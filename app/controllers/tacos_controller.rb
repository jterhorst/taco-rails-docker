class TacosController < ApplicationController
  before_action :set_taco, only: [:show, :edit, :update, :destroy]

  ##
    # In HTML, returns the UI and component. In JSON, returns a collection of tacos.
    #
    # Accessible at `GET /tacos` or `GET /tacos.json`
    #
    # --
    # FIXME: fails if the birthday falls on February 29th
    #
  def index
    @tacos = Taco.all

    respond_to do |format|
      format.html { render :index }
      format.json { render @tacos }
    end
  end

  # GET /tacos/1
  #
  # GET /tacos/1.json
  def show
  end

  # GET /tacos/new
  def new
    @taco = Taco.new
  end

  # GET /tacos/1/edit
  def edit
    
  end

  # POST /tacos
  #
  # POST /tacos.json
  def create
    @taco = Taco.new(taco_params)

    respond_to do |format|
      if @taco.save
        format.html { redirect_to @taco, notice: 'Taco was successfully created.' }
        format.json { render :show, status: :created, location: @taco }
      else
        format.html { render :new }
        format.json { render json: @taco.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tacos/1
  #
  # PATCH/PUT /tacos/1.json
  def update
    respond_to do |format|
      if @taco.update(taco_params)
        format.html { redirect_to @taco, notice: 'Taco was successfully updated.' }
        format.json { render :show, status: :ok, location: @taco }
      else
        format.html { render :edit }
        format.json { render json: @taco.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tacos/1
  #
  # DELETE /tacos/1.json
  def destroy
    @taco.destroy
    respond_to do |format|
      format.html { redirect_to tacos_url, notice: 'Taco was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_taco
      @taco = Taco.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def taco_params
      params.require(:taco).permit(:name, :price, :description, :cheese, :lettuce, :meat, :tortilla, :beans)
    end
end
