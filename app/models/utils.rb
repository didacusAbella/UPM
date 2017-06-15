class Validator

  class << self

    def validate_params_user(params)
      params.all? { |key, value| !value.empty? && value.in_range?(3, 15) }
    end

    def validate_params_patent(params)
      params.all? { |key, value| !value.empty? } &&
      params[:title].in_range?(6, 25) && params[:background].in_range?(20, 255) &&
      params[:claims].in_range?(20, 255) && params[:summary].in_range?(20, 255) &&
      params[:description].in_range?(20, 255)
    end
    
  end

end

class String

  def in_range?(min, max)
    length >= min && length <= max 
  end

end

class ValidationError < RuntimeError;end
class UnauthorizedError < RuntimeError;end