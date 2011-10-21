module ValidationExpectations

  BasicValidations = [:presence, :acceptance, :numericality, :format, :length, :confirmation, :uniqueness]
  InListValidations = [:exclusion, :inclusion]

  BasicValidations.each do |method|
    define_method("it_should_validate_#{method}_of") do |*one_or_more_fields|
      options = one_or_more_fields.last.is_a?(Hash) ? one_or_more_fields.pop : {}
      model_name = described_class
      one_or_more_fields.each do |field|
        it "should validate #{method} of #{field.to_s.humanize.downcase}" do
          validators = model_name.validators
          
          if method == :uniqueness
            validator = validators.detect { |e| e.class.to_s == "ActiveRecord::Validations::UniquenessValidator" && e.attributes.include?(field) }
          else
            validator = validators.detect { |e| e.class.to_s == "ActiveModel::Validations::#{method.to_s.titleize}Validator" && e.attributes.include?(field) }
          end
          
          validator.should_not be_nil
          validator.options.should include(options)
        end
      end
    end
  end

  InListValidations.each do |method|
    define_method("it_should_validate_#{method}_of") do |*one_or_more_fields|
      options = one_or_more_fields.last.is_a?(Hash) ? one_or_more_fields.pop : {}
      model_name = described_class
      one_or_more_fields.each do |field|
        it "should validate #{method} of #{field.to_s.humanize.downcase} as one of #{options[:in].to_sentence(:last_word_connector => ' or ')}" do
          validators = model_name.validators
          validator = validators.detect { |v| v.class.to_s == "ActiveModel::Validations::#{method.to_s.titleize}Validator" && v.attributes.include?(field) }
          validator.should_not be_nil
          validator.options[:in].sort.should == options[:in].sort unless validator.nil?
        end
      end
    end
  end

end

include ValidationExpectations

def it_should_be_createable *args
  model_name = described_class
  attributes = args.last.is_a?(Hash) ? args.last[:with] : {}

  it "should be creatable" do
    lambda { model_name.create attributes }.should change(model_name, :count).by(1)
  end
end
