class AssetAttachment < ActiveRecord::Base
  attr_protected :id
  
  belongs_to :attached_to, :polymorphic => true, :touch => true
  belongs_to :asset_file
  accepts_nested_attributes_for :asset_file  
  
  acts_as_list :scope => [:type, :attached_to_type, :attached_to_id]
  
  delegate :file, :to => :asset_file
  
end
