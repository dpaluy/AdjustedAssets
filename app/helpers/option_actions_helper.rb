module OptionActionsHelper
  def call_put_type(option)
    if option.is_call?
      "CALL"
    else
      "PUT"
    end
  end
end
