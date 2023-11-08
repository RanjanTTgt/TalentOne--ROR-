class DocumentUploader < BaseUploader

  # Add an allowlist of extensions which are allowed to be uploaded.
  def extension_allowlist
    %w(jpg jpeg png doc docx pdf xlsx csv)
  end

end
