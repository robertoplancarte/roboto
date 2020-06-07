class ScriptsController < ApplicationController
  before_action :set_script, only: [:show, :edit, :update, :destroy, :action]
  # POST /scripts/1/<actiion>
  def action
    authorize(@script)
    @script.send(script_params.dig(:action) + '!')
    respond_to do |format|
      format.html { redirect_to scripts_url, notice: "Successfully ran action '#{script_params.dig(:action)}' on script." }
      format.json { head :no_content }
    end
  end


  # GET /scripts
  # GET /scripts.json
  def index
    authorize(Script)
    @scripts = Script.all
  end

  # GET /scripts/1
  # GET /scripts/1.json
  def show
  end

  # GET /scripts/new
  def new
    @script = Script.new
  end

  # GET /scripts/1/edit
  def edit
  end

  # POST /scripts
  # POST /scripts.json
  def create
    @script = Script.new(script_params)

    respond_to do |format|
      if @script.save
        format.html { redirect_to @script, notice: 'Script was successfully created.' }
        format.json { render :show, status: :created, location: @script }
      else
        format.html { render :new }
        format.json { render json: @script.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scripts/1
  # PATCH/PUT /scripts/1.json
  def update
    respond_to do |format|
      if @script.update(script_params)
        format.html { redirect_to @script, notice: 'Script was successfully updated.' }
        format.json { render :show, status: :ok, location: @script }
      else
        format.html { render :edit }
        format.json { render json: @script.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scripts/1
  # DELETE /scripts/1.json
  def destroy
    @script.destroy
    respond_to do |format|
      format.html { redirect_to scripts_url, notice: 'Script was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_script
    @script = Script.find(params[:id])
    authorize(@script)
  end

  # Only allow a list of trusted parameters through.
  def script_params
    params.require(:script).permit(:title, :code, :aasm_state, :path_to_application, :command, :action)
  end
end
