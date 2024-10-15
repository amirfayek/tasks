class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :find_task, only: %i[edit update destroy]

  def index
    set_tasks
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.turbo_stream
        format.html { redirect_to tasks_path, flash: { notice: "Task was successfully created." } }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@task)}_form", partial: "tasks/form", locals: { task: @task }) }
        format.html do
          set_tasks
          render :index, status: :unprocessable_entity, locals: { task: @task }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@task)}_container", partial: "tasks/task", locals: { task: @task }) }
        format.html { redirect_to tasks_path }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@task)}_form", partial: "tasks/form", locals: { task: @task }) }
        format.html { render :edit, status: :unprocessable_entity, locals: { task: @task } }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @task.destroy
        format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@task)}_container") }
        format.html { redirect_to tasks_path }
      else
        format.html { redirect_to tasks_path, flash: { error: @task.errors.full_messages.first } }
      end
    end
  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :complete, :due_date, :assignee_id)
  end

  def set_tasks
    @tasks = filter_tasks
  end

  def filter_tasks
    if params[:filter] == "due_soon"
      current_user.assigned_tasks.due_soon
    else
      current_user.tasks
    end
  end
end
