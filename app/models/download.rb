class Download < ActiveRecord::Base

  MAX_DOWNLOAD_COUNT = ENV["MAX_DOWNLOAD_COUNT"] || 1
  AUTO_DELETE_AFTER = ENV["AUTO_DELETE_AFTER"] || 5

  validates :filename, :download_count, :allowed_downloads, presence: true
  validates :filename, uniqueness: true
  validates :allowed_downloads, numericality: {greater_than: 0, less_than: 100000}

  before_validation :set_initial_values, on: :create

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
    exists_locally = get_list_of_files.include?(filename)
    return unless exists_locally
    create(filename: filename)
  end

  def self.get_list_of_files
    begin
      Dir.glob("public/files/*").map{|file_and_path| file_and_path.split("/").last}
    rescue
      nil
    end
  end

  def path
    "public/files/#{filename}"
  end

  def send_update_download
    self.download_count += 1
    save
    path
  end

  def allowed_to_download?
    download_count <= allowed_downloads
  end

  def should_destroy?
    download_count >= allowed_downloads || Time.now >= expires_at
  end

  private

  def set_initial_values
    self.download_count = 0
    self.allowed_downloads = MAX_DOWNLOAD_COUNT
    self.expires_at = Time.now + AUTO_DELETE_AFTER.days
    true
  end

end
