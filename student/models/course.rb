require 'xgen/mongo/base'

class Course < XGen::Mongo::Base

  collection_name :courses
  field :name
  attr_accessor :_form          # for JavaScript form library

  def to_s
    "Course #{name}"
  end
end
