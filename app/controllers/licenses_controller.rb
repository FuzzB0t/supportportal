require 'base64'

class LicensesController < ApplicationController
  before_action :set_license, only: [:show, :edit, :update, :destroy]

  # GET /licenses
  # GET /licenses.json
  def index
    @licenses = License.all
  end

  # GET /licenses/1
  # GET /licenses/1.json
  def show
    contentBytes = @license.file.download.bytes
    @license_data = verify_license(contentBytes)
  end

  # GET /licenses/new
  def new
    @license = License.new
  end

  # GET /licenses/1/edit
  def edit
  end

  # POST /licenses
  # POST /licenses.json
  def create
    @license = License.new(license_params)

    respond_to do |format|
      if @license.save
        format.html { redirect_to @license, notice: 'License was successfully created.' }
        format.json { render :show, status: :created, location: @license }
      else
        format.html { render :new }
        format.json { render json: @license.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /licenses/1
  # PATCH/PUT /licenses/1.json
  def update
    respond_to do |format|
      if @license.update(license_params)
        format.html { redirect_to @license, notice: 'License was successfully updated.' }
        format.json { render :show, status: :ok, location: @license }
      else
        format.html { render :edit }
        format.json { render json: @license.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /licenses/1
  # DELETE /licenses/1.json
  def destroy
    @license.destroy
    respond_to do |format|
      format.html { redirect_to licenses_url, notice: 'License was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_license
      @license = License.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def license_params
      params.require(:license).permit(:title, :file)
    end

  private
    def verify_license(license_bytes)
      license_key = ""
      signature = ""

      begin
        value = 35
        start_point = 0
        for i in 1..license_bytes.length
          if license_bytes[i] == value && license_bytes[i+1] == value && license_bytes[i+2] == value && license_bytes[i+3] == value && license_bytes[i+4] == value
            start_point = i+5
          end
        end

        public_key_bytes = Array.new(license_bytes.length - start_point)

        license_key_bytes = Array.new(start_point - 5)

        i, j, k = 0, 0, 0
        while i < license_bytes.length
          if i >= start_point
            public_key_bytes[j] = license_bytes[i]
            j += 1
          elsif i < (start_point - 5)
            license_key_bytes[k] = license_bytes[i]
            k += 1
          end
          i += 1
        end

        public_key_bytes = Base64.decode64(public_key_bytes.to_s)
        license_encoded = license_key_bytes.pack('c*')

        tokens = license_encoded.split("#")

        if tokens.length != 2
          return "Invalid License"
        end
        license_key = Base64.decode64(tokens[0])
        signature = tokens[1]

        license_data = license_key.split("#")
        return license_data
      rescue
        return "Invalid License"
      ensure
      end
    end
end
