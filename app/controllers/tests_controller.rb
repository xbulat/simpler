class TestsController < Simpler::Controller

  def index
    @time = Time.now
    @tests = Test.all
    render 'tests/list'
  end

  def create
    render plain: "Plain text test response"
    status 201
  end

  def show
    @test = Test.first(id: params[:id])
  end

end
