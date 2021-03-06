require 'models/course'

# DEBUG
class Object
  def method_missing sym, *args
    msg = "method_missing: symbol = #{sym}, args = #{args.join(', ')}, class of self = #{self.class.name}"
    puts "<p style='color:red;'>#{msg}</p>"
    $stderr.puts "**** #{msg}"
  end
end

courses = Course.find(:all, :limit => 100, :order => :name)
template = '/views/courses'

course = Course.find($request['c__id']) if $request['c__id']

action = $request["action"] || ""
action = action.downcase
case action
when "list"
  # already set up (the find() above that set courses)

when "delete"
  if course
    course.remove
  end
  course = nil

when "edit"
  # Nothing to do yet

when "save"
  course ||= Course.new
  $Forms.fillInObject("c_" , course , $request)
  course.save
  course = nil

when "new"
  course = Course.new

end

if course
  # FIXME: remove this when constructors work
  course._form = $newFormsForm.call(course , "c_")
  template = '/views/course'
end

data = {}

#FIXME: remove when toArray call works in js
data['cs'] = courses.to_a
data['c'] = course if course

$djang10.get_template(template).call(data)
