require_relative "test_helper"

describe "TeacherModelTest" do 
  subject { Teacher } 

  it { _(subject).must be_document }
  it { _(subject).must have_field(:name).of_type(String) }
  it { _(subject).must have_field(:latex_url).of_type(String)}
  it { _(subject).must have_many(:themes) }
end

describe "ThemeModelTest" do 
  subject { Theme } 

  it { _(subject).must be_document }
  it { _(subject).must have_field(:description).of_type(String) }
  it { _(subject).must have_field(:title).of_type(String) }
  it { _(subject).must have_field(:tags).of_type(Array)}
  it { _(subject).must have_field(:data).of_type(Time) }
  it { _(subject).must belong_to(:teacher).of_type(Teacher) }
end
