class Field < ActiveRecord::Base

  belongs_to :field
  belongs_to :input_parameter

  def self.content_attr(attr_name, attr_type = :string)
    content_attributes[attr_name] = attr_type

    define_method(attr_name) do
      self.payload ||= {}
      self.payload[attr_name.to_s]
    end

    define_method("#{attr_name}=".to_sym) do |value|
      self.payload ||= {}
      self.payload[attr_name.to_s] = value
      self.payload_will_change!
      self.save!
    end
  end

  def self.content_attributes
    @content_attributes ||= {}
  end

  content_attr :name, :string

end
