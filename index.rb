class Index
  def initialize(file)
    @file  = File.open("#{file}.ix", File::RDWR|File::APPEND|File::CREAT)
  end

  def add
  end

  def update
  end

  def get
  end

  def delete
  end
end
