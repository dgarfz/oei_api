class TypesController < ApplicationController
  before_action :set_school_type, only: %i[ show update destroy ]

  # GET /school_types
  def index
    @school_types = SchoolType.all

    render json: @school_types
  end

  # GET /school_types/1
  def show
    render json: @school_type
  end

  # POST /school_types
  def create
    @school_type = SchoolType.new(school_type_params)

    if @school_type.save
      render json: @school_type, status: :created, location: @school_type
    else
      render json: @school_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /school_types/1
  def update
    if @school_type.update(school_type_params)
      render json: @school_type
    else
      render json: @school_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /school_types/1
  def destroy
    @school_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school_type
      @school_type = SchoolType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def school_type_params
      params.require(:school_type).permit(:name)
    end
end
