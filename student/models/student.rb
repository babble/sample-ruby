require 'xgen/mongo/base'
require "models/utils"

class Student < XGen::Mongo::Base

  collection_name :students
  fields :name, :email
  has_one :address, :class_name => "Address"
  has_many :scores, :class_name => "Score"
  attr_accessor :_form          # for JavaScript form library

  def initialize(row=nil)
    super
    @address ||= Address.new
  end

  def summary
    return <<EOS
#{name}
#{address}
#{scores.each { |s| s.to_s + "\n" }}
EOS
  end

  def add_score(course, grade)
    @scores << Score.new(:for_course => course, :grade => grade)
  end
end
