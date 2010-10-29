class User < ActiveRecord::Base
  # scope :latest, lambda {|param| where(:created_at.gt => param)}
  belongs_to :role
  validates_presence_of :first_name
  
  # netzke_attribute :first_name, :editor => {:xtype => "combobox"}
end
