# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  # self.implicit_order_column = 'created_at'
  default_scope { order('created_at DESC') }
end
