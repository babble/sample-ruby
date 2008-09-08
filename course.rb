require 'models/course'

# DEBUG
class Object
  def method_missing sym, *args
    msg = "method_missing: symbol = #{sym}, args = #{args.join(', ')}, class of self = #{self.class.name}"
    puts "<p style='color:red;'>#{msg}</p>"
    $stderr.puts "**** #{msg}"
  end
end

courses = Course.find().limit(100).sort(:name => 1)
template = 'views/courses'

course = Course.find(:first, $request['c__id']) if $request['c__id']

case $request.action.downcase
when "list"
  # already set up (the find() above that set courses)
when "delete"
  if course
    course.remove
  end
when "edit"
  # Nothing to do yet
when "save"
  course ||= Course.new
  $Forms.fillInObject("c_" , data.c , $request)
  course.save
  course.delete
when "new"
  course = Course.new
end

if course
  # TODO
  course._form = $Forms.Form(course , "c_")
  template = 'views/course'
end

data = {}

cs = courses
c = course if course

# TODO arguments
require 'template'
