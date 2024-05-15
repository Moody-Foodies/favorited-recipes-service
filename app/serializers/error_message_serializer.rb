class ErrorMessageSerializer
  def self.serialize_json(error_message)
    {
      errors: {
        detail: error_message.message
      }
    }
  end
end