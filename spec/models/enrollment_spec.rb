# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

require "spec_helper"

describe Enrollment do
  it { should be_able_to_be_destroyed }
  it { should destroy_dependent :accomplishment }
  it { should destroy_dependent :advisement }
  it { should destroy_dependent :class_enrollment }
  it { should destroy_dependent :deferral }
  it { should restrict_destroy_when_exists :dismissal }
  it { should destroy_dependent :scholarship_duration }
  it { should destroy_dependent :thesis_defense_committee_participation }


  let(:enrollment) { Enrollment.new }
  subject { enrollment }
  describe "Validations" do
    describe "student" do
      context "should be valid when" do
        it "student is not null" do
          enrollment.student = Student.new
          enrollment.should have(0).errors_on :student
        end
      end
      context "should have error blank when" do
        it "student is null" do
          enrollment.student = nil
          enrollment.should have_error(:blank).on :student
        end
      end
      context "should have advisment error when it" do
        it "has just one advisor that is not a main advisor" do
          enrollment.advisements << FactoryGirl.create(:advisement, :main_advisor => false)
          enrollment.should_not be_valid
          enrollment.errors[:base].should include I18n.translate("activerecord.errors.models.enrollment.main_advisor_required")
        end

        it "has more than one main advisor" do
          enrollment.advisements << advisement1 = FactoryGirl.create(:advisement, :main_advisor => true)
          enrollment.advisements << advisement2 = FactoryGirl.create(:advisement, :main_advisor => true)
          enrollment.should_not be_valid
          enrollment.errors[:base].should include I18n.translate("activerecord.errors.models.enrollment.main_advisor_uniqueness")
        end
      end
    end
    describe "enrollment_status" do
      context "should be valid when" do
        it "enrollment_status is not null" do
          enrollment.enrollment_status = EnrollmentStatus.new
          enrollment.should have(0).errors_on :enrollment_status
        end
      end
      context "should have error blank when" do
        it "enrollment_status is null" do
          enrollment.enrollment_status = nil
          enrollment.should have_error(:blank).on :enrollment_status
        end
      end
    end
    describe "level" do
      context "should be valid when" do
        it "level is not null" do
          enrollment.level = Level.new
          enrollment.should have(0).errors_on :level
        end
      end
      context "should have error blank when" do
        it "level is null" do
          enrollment.level = nil
          enrollment.should have_error(:blank).on :level
        end
      end
    end
    describe "enrollment_number" do
      context "should be valid when" do
        it "enrollment_number is not null and is not taken" do
          enrollment.enrollment_number = "M123"
          enrollment.should have(0).errors_on :enrollment_number
        end
      end
      context "should have error blank when" do
        it "enrollment_number is null" do
          enrollment.enrollment_number = nil
          enrollment.should have_error(:blank).on :enrollment_number
        end
      end
      context "should have error taken when" do
        it "enrollment_number is already in use" do
          enrollment_number = "D123"
          FactoryGirl.create(:enrollment, :enrollment_number => enrollment_number)
          enrollment.enrollment_number = enrollment_number
          enrollment.should have_error(:taken).on :enrollment_number
        end
      end
    end
    describe "thesis_defense_date" do
      context "should be valid when" do
        it "is after admission_date" do
          enrollment = FactoryGirl.create(:enrollment, :admission_date => 3.days.ago.to_date)
          enrollment.thesis_defense_date = 3.days.from_now.to_date
          enrollment.should have(0).errors_on :thesis_defense_date
        end
      end
      context "should not be valid when" do
        it "is before admission_date" do
          enrollment = FactoryGirl.create(:enrollment, :admission_date => 3.days.ago.to_date)
          enrollment.thesis_defense_date = 4.days.ago.to_date
          enrollment.should have_error(:thesis_defense_date_before_admission_date).on :thesis_defense_date
        end
      end
    end

    describe "research_area" do
      context "should be valid when" do
        it "is empty" do
          enrollment = FactoryGirl.create(:enrollment, :research_area => nil)
          enrollment.should have(0).errors_on :research_area
        end

        it "is the same research_area as the advisor" do
          research_area = FactoryGirl.create(:research_area) 
          enrollment = FactoryGirl.create(:enrollment, :research_area => research_area)
          professor = FactoryGirl.create(:professor, :research_areas => [research_area])
          FactoryGirl.create(:advisement, :enrollment => enrollment, :professor => professor)
          enrollment.should have(0).errors_on :research_area
        end

        it "there is no advisor" do
          research_area = FactoryGirl.create(:research_area) 
          enrollment = FactoryGirl.create(:enrollment, :research_area => research_area)
          enrollment.should have(0).errors_on :research_area
        end
      end
      context "should not be valid when" do
        it "is not the same area as the advisor" do
          research_area1 = FactoryGirl.create(:research_area) 
          research_area2 = FactoryGirl.create(:research_area) 
          enrollment = FactoryGirl.create(:enrollment, :research_area => research_area1)
          professor = FactoryGirl.create(:professor, :research_areas => [research_area2])
          FactoryGirl.create(:advisement, :enrollment => enrollment, :professor => professor)
          enrollment.save
          enrollment.errors[:research_area].should include I18n.translate("activerecord.errors.models.enrollment.research_area_different_from_professors")
        end
      end
    end
  end
  describe "Methods" do
    before(:all) do
      admission_date = YearSemester.current.semester_begin
      @delayed_enrollment = FactoryGirl.create(:enrollment, :admission_date => admission_date)
      level = @delayed_enrollment.level


      inactive_enrollment = FactoryGirl.create(:enrollment, :level => level, :admission_date => admission_date)
      FactoryGirl.create(:dismissal, :enrollment => inactive_enrollment)

      one_month_phase = FactoryGirl.create(:phase)
      FactoryGirl.create(:phase_duration, :deadline_days => 0, :deadline_months => 1, :deadline_semesters => 0, :level => level, :phase => one_month_phase)
      @two_semesters_phase = FactoryGirl.create(:phase)
      FactoryGirl.create(:phase_duration, :deadline_days => 0, :deadline_months => 0, :deadline_semesters => 2, :level => level, :phase => @two_semesters_phase)

      @enrollment_accomplished = FactoryGirl.create(:enrollment, :level => @delayed_enrollment.level, :admission_date => admission_date)
      FactoryGirl.create(:accomplishment, :enrollment => @enrollment_accomplished, :phase => one_month_phase, :conclusion_date => 1.day.ago)

      enrollment_active_deferral = FactoryGirl.create(:enrollment, :level => level, :admission_date => admission_date)
      one_semester_deferral_type = FactoryGirl.create(:deferral_type, :phase => one_month_phase, :duration_days => 0, :duration_months => 0, :duration_semesters => 1)
      FactoryGirl.create(:deferral, :enrollment => enrollment_active_deferral, :deferral_type => one_semester_deferral_type)

      @enrollment_expired_deferral = FactoryGirl.create(:enrollment, :level => level, :admission_date => (admission_date - 8.months))
      FactoryGirl.create(:deferral, :enrollment => @enrollment_expired_deferral, :deferral_type => one_semester_deferral_type)

    end

    describe "to_label" do
      it "should return the expected string" do
        enrollment_number = "M213"
        enrollment.enrollment_number = enrollment_number
        student_name = "Student"
        enrollment.student = Student.new(:name => student_name)
        enrollment.to_label.should eql("#{enrollment_number} - #{student_name}")
      end
    end
    describe "self.with_delayed_phases_on" do
      it "should return the expected enrollments" do
        result = Enrollment.with_delayed_phases_on(2.months.from_now.to_date, nil)

        expected_result = [@delayed_enrollment.id, @enrollment_expired_deferral.id].sort
        result.sort.should eql(expected_result.sort)
      end
    end
    describe "self.with_all_phases_accomplished_on" do
      it "should return the expected enrollments" do
        FactoryGirl.create(:accomplishment, :enrollment => @enrollment_accomplished, :phase => @two_semesters_phase, :conclusion_date => 1.day.ago)
        
        result = Enrollment.with_all_phases_accomplished_on(Date.today)

        expected_result = [@enrollment_accomplished.id].sort
        result.sort.should eql(expected_result.sort)
      end
    end

    describe "available_semesters" do
      before(:all) do
        course1 = FactoryGirl.create(:course);
        course2 = FactoryGirl.create(:course);
        @class1 = FactoryGirl.create(:course_class, :year => "2012", :semester => "1")
        @class2 = FactoryGirl.create(:course_class, :year => "2012", :semester => "1")
        @class3 = FactoryGirl.create(:course_class, :year => "2012", :semester => "2")
        @class4 = FactoryGirl.create(:course_class, :year => "2013", :semester => "1")
        @class5 = FactoryGirl.create(:course_class, :year => "2013", :semester => "1", :course => course1)
        @class6 = FactoryGirl.create(:course_class, :year => "2013", :semester => "2", :course => course1)
        @class7 = FactoryGirl.create(:course_class, :year => "2013", :semester => "2", :course => course2)
      end
      it "shouldn't return any value when the enrollment doesn't have any classes" do
        admission_date = YearSemester.current.semester_begin
        enrollment = FactoryGirl.create(:enrollment, :admission_date => admission_date)
        enrollment.available_semesters.any?.should be_false
      end

      it "should return [[2013,2]] when it is enrolled to a class of 2013.2" do
        admission_date = YearSemester.current.semester_begin
        enrollment = FactoryGirl.create(:enrollment, :admission_date => admission_date)
        FactoryGirl.create(:class_enrollment, :enrollment => enrollment, :course_class => @class6)
        enrollment.available_semesters.any?.should be_true
        enrollment.available_semesters.should == [[2013, 2]]
      end

      it "should return [[2013,2]] when it is enrolled to more than one class of 2013.2" do
        admission_date = YearSemester.current.semester_begin
        enrollment = FactoryGirl.create(:enrollment, :admission_date => admission_date)
        FactoryGirl.create(:class_enrollment, :enrollment => enrollment, :course_class => @class6)
        FactoryGirl.create(:class_enrollment, :enrollment => enrollment, :course_class => @class7)
        enrollment.available_semesters.any?.should be_true
        enrollment.available_semesters.should == [[2013, 2]]
      end

      it "should return [[2013, 1], [2013,2]] when it is enrolled a class of 2013.1 and a class of 2013.2" do
        admission_date = YearSemester.current.semester_begin
        enrollment = FactoryGirl.create(:enrollment, :admission_date => admission_date)
        FactoryGirl.create(:class_enrollment, :enrollment => enrollment, :course_class => @class6)
        FactoryGirl.create(:class_enrollment, :enrollment => enrollment, :course_class => @class5)
        enrollment.available_semesters.any?.should be_true
        enrollment.available_semesters.should == [[2013, 1], [2013, 2]]
      end

      it "should be ordered: [[2012, 1], [2012, 2], [2013, 1], [2013,2]]" do
        admission_date = YearSemester.current.semester_begin
        enrollment = FactoryGirl.create(:enrollment, :admission_date => admission_date)
        FactoryGirl.create(:class_enrollment, :enrollment => enrollment, :course_class => @class3)
        FactoryGirl.create(:class_enrollment, :enrollment => enrollment, :course_class => @class5)
        FactoryGirl.create(:class_enrollment, :enrollment => enrollment, :course_class => @class1)
        FactoryGirl.create(:class_enrollment, :enrollment => enrollment, :course_class => @class7)
        FactoryGirl.create(:class_enrollment, :enrollment => enrollment, :course_class => @class4)
        FactoryGirl.create(:class_enrollment, :enrollment => enrollment, :course_class => @class2)
        FactoryGirl.create(:class_enrollment, :enrollment => enrollment, :course_class => @class6)
        enrollment.available_semesters.any?.should be_true
        enrollment.available_semesters.should == [[2012, 1], [2012, 2], [2013, 1], [2013,2]]
      end
    end

    describe "gpr" do

      before(:each) do
        with_grade = FactoryGirl.create(:course_type, :has_score => true)
        without_grade = FactoryGirl.create(:course_type, :has_score => nil)
        # create courses by number of credits
        courses = [4, 6, 6, 4, 2, 4].collect { |credits| FactoryGirl.create(:course, :credits => credits, :course_type => with_grade) }
        courses[4].course_type = without_grade
        courses[4].save

        admission_date = YearSemester.current.semester_begin
        @enrollment = FactoryGirl.create(:enrollment, :admission_date => admission_date)

        # create classes and grades
        [
          ["2012", "1", courses[0], 80, "aproved"], 
          ["2012", "1", courses[1], 50, "disapproved"], 
          ["2012", "2", courses[2], 90, "aproved"], 
          ["2013", "1", courses[1], 100, "aproved"],
          ["2013", "1", courses[4], nil, "aproved"],
          ["2013", "1", courses[3], 97, "aproved"],
          ["2013", "1", courses[5], nil, "registered"],
          ["2013", "2", courses[5], nil, "registered"]
        ].each do |year, semester, course, grade, situation|
          course_class = FactoryGirl.create(:course_class, :year => year, :semester => semester, :course => course)
          class_enrollment = FactoryGirl.create(:class_enrollment, :enrollment => @enrollment, :course_class => course_class)
          class_enrollment.situation = I18n.translate("activerecord.attributes.class_enrollment.situations." + situation)
          class_enrollment.grade = grade unless grade.nil?
          class_enrollment.save
        end
      end

      describe "gpr_by_semester" do
        it "should return 90 for 2012.2 (testing 1 grade)" do
          @enrollment.gpr_by_semester(2012, 2).should == 90
        end

        it "should return 62 for 2012.1 (testing 2 grades)" do
          @enrollment.gpr_by_semester(2012, 1).should == 62
        end

        it "should return 0 for 2013.2 (testing 1 incomplete class)" do
          @enrollment.gpr_by_semester(2013, 2).should be_nil
        end
        
        it "should return 99 for 2013.1 (testing 2 grades, 1 incomplete class, 1 approved class without grade)" do
          @enrollment.gpr_by_semester(2013, 1).round(0).should == 99
        end

        it "should return 0 if it is not enrolled in any classes of the semester" do
          @enrollment.gpr_by_semester(2011, 2).should be_nil
        end
      end

      describe "total_gpr" do
        it "should return 83" do
          @enrollment.total_gpr.round.should == 83
        end
      end

      
    end
  end

   
end