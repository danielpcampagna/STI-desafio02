class StationsController < ApplicationController
  # => require 'rio_station_service'
  before_action :set_station, only: [:show, :edit, :update, :destroy]

  def suggests
    if [:q, :street, :city].any? {|k| params.key? k}
      request_params = {
        limit:  10,
        city: "Rio de Janeiro",
        state: "RJ",
        country: "Brasil"
      }

      request_params[:q] = params[:q] if params.has_key?(:q)
      request_params[:street] = params[:street] if params.has_key?(:street)
      request_params[:city] = params[:city] if params.has_key?(:city)

      result = OpenStreetMapService.get(request_params).map do |data|
        {
          lat: data["lat"],
          lon: data["lon"],
          street: data["address"]["road"],
          suburb: data["address"]["suburb"],
          city_district: data["address"]["city_district"],
          city: data["address"]["city"],
          state: data["address"]["state"],
          country: data["address"]["country"]
        }
      end
      respond_to do |format|
        format.json { render :json => result }
      end
    end
  end

  def search
    @stations = Station.all
    result = nil
    if @stations.empty?
      stations = RioStationService.get
      columns  = stations["COLUMNS"].map {|c| RioStationService.DICTIONARY[c] }
      data     = stations["DATA"]
      if (columns - Station.column_names).empty?
        for d in data
          Station.create(columns.each_with_index.map {|c,i| [c,d[i]] }.to_h)
        end
      end
    end

    if params.has_key?(:lat) && params.has_key?(:lon)
      lat = params[:lat]
      lon = params[:lon]
      result = @stations.map {|s| Math.sqrt((s[:latitude] - lat)**2, (s[:longitude] - lon)**2)}.min
    end
    respond_to do |format|
      format.json { render :json => result }
    end
  end

  # GET /stations
  # GET /stations.json
  def index
    @stations = Station.all
    @station = nil
  end


  # GET /stations/1
  # GET /stations/1.json
  def show
  end

  # GET /stations/new
  def new
    @station = Station.new
  end

  # GET /stations/1/edit
  def edit
  end

  # POST /stations
  # POST /stations.json
  def create
    @station = Station.new(station_params)

    respond_to do |format|
      if @station.save
        format.html { redirect_to @station, notice: 'Station was successfully created.' }
        format.json { render :show, status: :created, location: @station }
      else
        format.html { render :new }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stations/1
  # PATCH/PUT /stations/1.json
  def update
    respond_to do |format|
      if @station.update(station_params)
        format.html { redirect_to @station, notice: 'Station was successfully updated.' }
        format.json { render :show, status: :ok, location: @station }
      else
        format.html { render :edit }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stations/1
  # DELETE /stations/1.json
  def destroy
    @station.destroy
    respond_to do |format|
      format.html { redirect_to stations_url, notice: 'Station was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station
      @station = Station.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def station_params
      params.require(:station).permit(:neighborhood, :station, :code, :address, :number, :latitude, :longitude)
    end
end
