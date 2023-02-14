class CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show edit update destroy ]

  def index
    @companies = Company.all
  end

  def show
  end

  def new
    @company = Company.new
  end

    def edit
    end

   def create
    @company = Company.new(company_params)
      respond_to do |format|
      if @company.save
        format.turbo_stream
        format.html { redirect_to company_url(@company), notice: "company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @company.update(company_params)
        format.turbo_stream
        format.html { redirect_to company_url(@company), notice: "Company was successfully updated." }
        format.json { render "show", status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company.destroy
      respond_to do |format|
      format.turbo_stream
        flash[:notice] = "project deleted successfully"
        redirect_to companies_path
    end
  end


  private

    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :state, :city, :website)
    end
end
