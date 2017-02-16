require 'csv'
require 'purchase_import'

class FileUploadsController < ApplicationController
  def new
    @file_upload = FileUpload.new
  end
  
  def create
    has_error = false
    
    @file_upload = FileUpload.new
    
    # If no file data is available, give an error
    if (params[:file_upload].nil?)
      has_error = true
      @file_upload.errors.add(:error, ': Please select a file.')
    end
    
    # If no error, attempt to import
    if (!has_error)
      # Set the file data
      file_data = params[:file_upload][:file_path]
      file_name = file_data.original_filename
      csv = CSV.new(file_data.read)
            
      # Import the spreadsheet
      purchase_import = PurchaseImport.new()
      purchase_import.import(csv, file_name)
        
      # If there were errors, then build a list of all the messages
      if (purchase_import.has_error)
        has_error = true
        purchase_import.errors.each do |error_message|
          @file_upload.errors.add(:error, error_message)
        end
      end
  	end
    
    # If no errors, display the purchases	
    if (!has_error)
      # save the import
      purchase_import.save
    
      redirect_to '/recent_purchases'
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @file_upload.errors, status: :unprocessable_entity }
      end
    end
  end
end
