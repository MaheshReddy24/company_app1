class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy ]


  def index
    @employees = Employee.all
  end

  
  def show
  end

  
  def new
    @employee = Employee.new
  end

  
  def edit
  end

  
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.turbo_stream
        format.html { redirect_to employee_url(@employee), notice: "Employee was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.turbo_stream
        format.html { redirect_to employee_url(@employee), notice: "Employee was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @employee.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to employees_url, notice: "Employee was successfully destroyed." }
      head :no_content
    end
  end

  private
    
    def set_employee
      @employee = Employee.find(params[:id])
    end

    
    def employee_params
      params.require(:employee).permit(:name, :phone_number, :email, :gender, :salary, :experience, :company_id)
    end
end
