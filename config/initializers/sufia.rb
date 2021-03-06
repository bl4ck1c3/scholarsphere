# frozen_string_literal: true
Sufia.config do |config|
  # Sufia can integrate with Zotero's Arkivo service for automatic deposit
  # of Zotero-managed research items.
  # Defaults to false.  See Sufia's README for more info
  # ** Only set to true on qa for now **
  config.arkivo_api = Rails.application.get_vhost_by_host[0] == "scholarsphere-qa.dlt.psu.edu" || Rails.env.development?

  config.application_name = "ScholarSphere"
  config.enable_contact_form_delivery = true
  config.contact_form_delivery_body = <<-EOM
    Greetings,

    Thank you for contacting us with your question or issue about ScholarSphere.
    Our service team will review the submitted form. Within three business days after submission,
    a member of the team will get back to you via email with a more specific response.
    If this is an urgent concern, please consult this page, https://scholarsphere.psu.edu/help/.

    Sincerely,

    The ScholarSphere Service Team
  EOM
  config.contact_form_delivery_from = 'do-not-reply@scholarsphere.psu.edu'
  config.fits_path = "fits.sh"
  config.fits_to_desc_mapping = {}
  config.max_days_between_audits = 7
  config.enable_ffmpeg = true
  config.ffmpeg_path = Rails.application.ffmpeg_path

  config.cc_licenses = {
    'Attribution-NonCommercial-NoDerivs 3.0 United States' => 'http://creativecommons.org/licenses/by-nc-nd/3.0/us/',
    'Attribution 3.0 United States' => 'http://creativecommons.org/licenses/by/3.0/us/',
    'Attribution-ShareAlike 3.0 United States' => 'http://creativecommons.org/licenses/by-sa/3.0/us/',
    'Attribution-NonCommercial 3.0 United States' => 'http://creativecommons.org/licenses/by-nc/3.0/us/',
    'Attribution-NoDerivs 3.0 United States' => 'http://creativecommons.org/licenses/by-nd/3.0/us/',
    'Attribution-NonCommercial-ShareAlike 3.0 United States' => 'http://creativecommons.org/licenses/by-nc-sa/3.0/us/',
    'Public Domain Mark 1.0' => 'http://creativecommons.org/publicdomain/mark/1.0/',
    'CC0 1.0 Universal' => 'http://creativecommons.org/publicdomain/zero/1.0/',
    'All rights reserved' => 'All rights reserved'
  }

  config.cc_licenses_reverse = Hash[*config.cc_licenses.to_a.flatten.reverse]

  config.resource_types = {
    "Article" => "Article",
    "Audio" => "Audio",
    "Book" => "Book",
    "Capstone Project" => "Capstone Project",
    "Conference Proceeding" => "Conference Proceeding",
    "Dataset" => "Dataset",
    "Dissertation" => "Dissertation",
    "Image" => "Image",
    "Journal" => "Journal",
    "Map or Cartographic Material" => "Map or Cartographic Material",
    "Part of Book" => "Part of Book",
    "Poster" => "Poster",
    "Presentation" => "Presentation",
    "Project" => "Project",
    "Report" => "Report",
    "Research Paper" => "Research Paper",
    "Software or Program Code" => "Software or Program Code",
    "Thesis" => "Thesis",
    "Video" => "Video",
    "Other" => "Other"
  }

  config.permission_levels = {
    "Choose Access" => "none",
    "View/Download" => "read",
    "Edit" => "edit"
  }

  config.owner_permission_levels = {
    "Edit" => "edit"
  }

  config.public_permission_levels = {
    "Choose Access" => "none",
    "View/Download" => "read"
  }

  config.analytics = true
  config.google_analytics_id = Rails.application.google_analytics_id

  # Specify a date you wish to start collecting Google Analytic statistics for.
  config.analytic_start_date = DateTime.new(2013, 3, 24)

  # If browse-everything has been configured, load the configs.  Otherwise, set to nil.
  begin
    if defined? BrowseEverything
      config.browse_everything = BrowseEverything.config
    else
      logger.warn "BrowseEverything is not installed"
    end
  rescue Errno::ENOENT
    config.browse_everything = nil
  end

  config.share_notify = ShareNotify.config

  config.temp_file_base = "/tmp"

  config.retry_unless_sleep = 2 # seconds
end
