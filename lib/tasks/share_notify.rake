namespace :share do

  desc "Push all available GenericFiles to SHARE Notify"
  task files: :environment do
    shareable_files.each do |file|
      puts "Sending #{file.id} to SHARE Notify"
      Sufia.queue.push(ShareNotifyJob.new(file.id))
    end
  end 

  def shareable_files
    ResourceFilteredList.new(
      PublicFilteredList.new(GenericFile.where(read_access_group_ssim: ["public"])).filter
    ).filter
  end

end
