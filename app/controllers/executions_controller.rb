class ExecutionsController < ApplicationController
  before_action :set_execution, only: [:show, :edit, :update, :destroy, :execute]
  # POST /executions/1/execute
  def execute
    ExecuteJob.perform_later(@execution)
  end

  # GET /executions
  # GET /executions.json
  def index
    @executions = Execution.all
  end

  # GET /executions/1
  # GET /executions/1.json
  def show
  end

  # GET /executions/new
  def new
    @execution = Execution.new(user: current_user)
  end

  # GET /executions/1/edit
  def edit
  end

  # POST /executions
  # POST /executions.json
  def create
    @execution = Execution.new(execution_params)
    @execution.user = current_user

    respond_to do |format|
      if @execution.save
        format.html { redirect_to @execution, notice: 'Execution was successfully created.' }
        format.json { render :show, status: :created, location: @execution }
      else
        format.html { render :new }
        format.json { render json: @execution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /executions/1
  # PATCH/PUT /executions/1.json
  def update
    respond_to do |format|
      if @execution.update(execution_params)
        format.html { redirect_to @execution, notice: 'Execution was successfully updated.' }
        format.json { render :show, status: :ok, location: @execution }
      else
        format.html { render :edit }
        format.json { render json: @execution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /executions/1
  # DELETE /executions/1.json
  def destroy
    @execution.destroy
    respond_to do |format|
      format.html { redirect_to executions_url, notice: 'Execution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_execution
      @execution = Execution.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def execution_params
      params.require(:execution).permit(:aasm_state, :started_at, :finished_at, :input, :output, :user_id, :environment_id, :script_id)
    end
end
