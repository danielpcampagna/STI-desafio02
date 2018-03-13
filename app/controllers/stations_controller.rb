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
          street: data["address"]["road"].force_encoding("ISO-8859-1").encode("UTF-8"),
          suburb: data["address"]["suburb"].force_encoding("ISO-8859-1").encode("UTF-8"),
          city_district: data["address"]["city_district"].force_encoding("ISO-8859-1").encode("UTF-8"),
          city: data["address"]["city"].force_encoding("ISO-8859-1").encode("UTF-8"),
          state: data["address"]["state"].force_encoding("ISO-8859-1").encode("UTF-8"),
          country: data["address"]["country"].force_encoding("ISO-8859-1").encode("UTF-8")
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

    # when will check new stations?
    if @stations.empty?
      get_station
      @stations = Station.all
    end

    if params.has_key?(:lat) && params.has_key?(:lon)
      lat = params[:lat].to_f
      lon = params[:lon].to_f
      result = @stations.all.map do |s|
        {
          station: s.attributes,
          distance: Math.sqrt((s[:latitude] - lat)**2 + (s[:longitude] - lon)**2)
        }
      end
      result = result.min { |a,b| a[:distance] <=> b[:distance] }

    end
    respond_to do |format|
      format.json { render :json => result }
    end
  end

  # GET /stations
  # GET /stations.json
  def index
    @stations = Station.all
    if(@stations.empty?)
      get_station
      @stations = Station.all
    end
    gon.stations = @stations
    gon.your_int = 1
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

    def get_station
      stations = RioStationService.get
      columns  = stations["COLUMNS"].map {|c| RioStationService.DICTIONARY[c] }
      data     = stations["DATA"]
      if (columns - Station.column_names).empty?
        for d in data
          d = d.map do |i|
            if(i.class == String)
              i.force_encoding("ISO-8859-1").encode("UTF-8")
            else
              i
            end
          end
          Station.create(columns.each_with_index.map {|c,i| [c,d[i]] }.to_h)
        end
      end
    end
end
