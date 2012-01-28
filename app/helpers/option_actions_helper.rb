module OptionActionsHelper
  def call_put_type(option)
    if option.is_call?
      "CALL"
    else
      "PUT"
    end
  end
  
  def expiration_dates
    exp_list = YAML::load(File.open("#{Rails.root}/config/expirations.yml"))
    collection = exp_list["TA25"].map {|d| [d.to_s(:expiration), d.to_s]}
  end
end
