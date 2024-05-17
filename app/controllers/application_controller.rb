class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_response
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
  rescue_from ActiveRecord::StatementInvalid, with: :statement_invalid_response

  def invalid_record_response(exception)
    render json: ErrorMessageSerializer.serialize_json(ErrorMessage.new(exception.message)), status: :unprocessable_entity
  end

  def statement_invalid_response(exception)
    render json: ErrorMessageSerializer.serialize_json(ErrorMessage.new("Unable to process request due to missing information")), status: :unprocessable_entity
  end

  def record_not_found_response(exception)
    render json: ErrorMessageSerializer.serialize_json(ErrorMessage.new(exception.message)), status: 404
  end
end
