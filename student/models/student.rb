class Student < XGen::Mongo::Base

  set_collection :students, %w(name email address scores)

  def initialize(row=nil)
    super
    @scores = []
  end

  def summary
    return <<EOS
#{name}
#{address}
#{scores.each { |s| s.to_s + "\n" }}
EOS
  end

  def add_score(course, grade)
    @scores << Score.new(course, grade)
  end
end
