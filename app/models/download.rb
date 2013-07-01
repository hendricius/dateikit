class Download < ActiveRecord::Base

  def self.filename_or_id(filename: nil, id: nil)
    return unless :filename && :id
    return find(id) if id
    find_database_and_local_files(filename)
  end

  def self.find_database_and_local_files(filename)
    file = find_by_filename(filename)
    return file if file
    file_list = get_list_of_files
    return unless file_list
    file_names = file_list.map{|file_and_path| file_and_path.split("/").last}
    exists_locally = file_names.include?(filename)
    return unless exists_locally
    create(filename: filename)
  end

  def self.get_list_of_files
    begin
      Dir.glob("public/files/*")
    rescue
      nil
    end
  end

  def path
    "public/files/#{filename}"
  end

end
