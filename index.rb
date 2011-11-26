class Index
  def initialize(file)
    @file  = File.open("#{file}.ix", File::RDWR|File::APPEND|File::CREAT)
    @file_read  = File.open("#{file}.ix", File::RDONLY|File::APPEND|File::CREAT)
  end

  def add(key, value, data)
  end

  def get(key, value)
  end

  def delete(key, value)
  end
end
