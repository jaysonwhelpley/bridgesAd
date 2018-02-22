class CodesController < ApplicationController
  before_action :set_code, only: [:show, :edit, :update, :destroy]

  # GET /codes
  # GET /codes.json
  def index
    @codes = Code.all
  end

  # GET /codes/1
  # GET /codes/1.json
  def show
    require "mini_magick"

    @codeimage = @code.image
    croppedcode = @codeimage.cropped
    compositecode = @codeimage.composite
    base = Base.last.image

    newimage = MiniMagick::Image.open(root_url + croppedcode.url)
    baseimage = MiniMagick::Image.open(root_url + base.url)
    newimage.rotate("-10")

    newimage = baseimage.composite(newimage) do |c|
      c.compose("Darken")
      c.geometry("200x200+215+70")
      c.gravity("southeast")
    end

    codedirsplit = @codeimage.url.split("/")
    filename = codedirsplit.pop(1)[0]

    compositecodesplit = compositecode.url.split("/")
    compositefilename = compositecodesplit.pop(1)[0]

    codedir = codedirsplit.join("/").concat("/")

    # @newimage.write("public/" + @code.url)
    newimage.write("public" + @codeimage.composite.url)

    if Code.count > 1
      Code.first.delete
    end

  end

  # GET /codes/new
  def new
    @code = Code.new
  end

  # GET /codes/1/edit
  def edit
  end

  # POST /codes
  # POST /codes.json
  def create
    @code = Code.new(code_params)

    respond_to do |format|
      if @code.save
        format.html { redirect_to @code, notice: 'Code was successfully created.' }
        format.json { render :show, status: :created, location: @code }
      else
        format.html { render :new }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /codes/1
  # PATCH/PUT /codes/1.json
  def update
    respond_to do |format|
      if @code.update(code_params)
        format.html { redirect_to @code, notice: 'Code was successfully updated.' }
        format.json { render :show, status: :ok, location: @code }
      else
        format.html { render :edit }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codes/1
  # DELETE /codes/1.json
  def destroy
    @code.destroy
    respond_to do |format|
      format.html { redirect_to codes_url, notice: 'Code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def merged
    require "mini_magick"

    @code = Code.find(params[:id]).image
    croppedcode = @code.cropped
    compositecode = @code.composite
    base = Base.last.image

    newimage = MiniMagick::Image.open(root_url + croppedcode.url)
    baseimage = MiniMagick::Image.open(root_url + base.url)
    newimage.rotate("-10")

    newimage = baseimage.composite(newimage) do |c|
      c.compose("Darken")
      c.geometry("200x200+215+70")
      c.gravity("southeast")
    end

    codedirsplit = @code.url.split("/")
    filename = codedirsplit.pop(1)[0]

    compositecodesplit = compositecode.url.split("/")
    compositefilename = compositecodesplit.pop(1)[0]

    codedir = codedirsplit.join("/").concat("/")

    # @newimage.write("public/" + @code.url)
    newimage.write("public" + @code.composite.url)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code
      @code = Code.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def code_params
      params.require(:code).permit(:image, :remove_image)
    end
end
