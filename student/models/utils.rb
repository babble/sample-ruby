# This contains objects that aren't first-class (don't have their own
# collection in the database).
#
# Using XGen::Mongo::Subobject is optional; these could use XGen::Mongo::Base.

require 'xgen/mongo/subobject'
require 'models/course'

class Address < XGen::Mongo::Subobject

  fields :street, :city, :state, :postal_code

  def to_s
    "#{street}\n#{city}, #{state} #{postal_code}"
  end

end

# Grade for a class
class Score < XGen::Mongo::Subobject

  field :grade
  has_one :for_course, :class_name => "Course"

  def passed?
    @grade >= 2.0
  end

  def to_s
    "#{@for_course}: #@grade"
  end

end
