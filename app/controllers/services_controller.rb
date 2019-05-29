class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :require_logged_in_professional_user

  # GET /services
  # GET /services.json
  def index
    @services = current_professional_user.services
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
    7.times{@service.schedules.build}
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    @service = current_professional_user.services.build(service_params)

    respond_to do |format|
      if @service.save
        format.html { redirect_to meus_servicos_path }
        flash[:success] = 'Serviço adicionado com sucesso!'
      else
        7.times{@service.schedules.build} if @service.schedules.blank?
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    @service = current_professional_user.services.find(params[:id])
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to meus_servicos_path }
        flash[:success] = 'Serviço atualizado com sucesso!'
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service = current_professional_user.services.find(params[:id])
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Serviço excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(
        :service, :description, :value, :duration, :email, schedules_attributes: [:id, :day, :morning, :evening, :night, :_destroy]
        )
    end
end
