require 'models/student'
require 'models/course'



# DEBUG
class Object
  def method_missing sym, *args
    msg = "method_missing: symbol = #{sym}, args = #{args.join(', ')}, class of self = #{self.class.name}"
    puts "<p style='color:red;'>#{msg}</p>"
    $stderr.puts "**** #{msg}"
    raise "method not there"
  end
end

action = $request["action"] || ""
action = action.downcase

data = {}

if action == "list"
  data['ss'] = Student.find().limit(50).sort(:name => 1)
  $djang10.get_template('/views/students').call(data)
  return
end

my_student = Student.find(:first, $request["s__id"]) if $request["s__id"] 
my_student ||= Student.new

if action == "delete"
  my_student.remove
  $response.sendRedirectTemporary("/students")
  return
end

#FIXME: remove when js toArray works
data['courses'] = Course.find().to_a

if action == "save"
  $Forms.fillInObject("s_" , my_student , $request)
  if my_student._new
    my_student._new = false
  end
        
  my_student.save
  data['msg'] = "Saved"
end
    
if action == "add" && $request.has_key?("course_for") && $request.has_key?("score")
  c = Course.findOne($request.course_for)
  if !c
    data['msg'] = "Can't find course"
  else
    my_student.add_score(c , $request.score)
    my_student.save
  end
end
    
# FIXME: remove this when constructors work
my_student._form = $newFormsForm.call(my_student , "s_")
    
data['s'] = my_student

$djang10.get_template('/views/student').call(data)
