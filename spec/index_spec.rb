require 'spec_helper'

describe Snowsafe::Index do

  let(:password) { new_password }

  let(:sample_entry_data) do
    {"title" => "Proxy.sh", "username" => "snowden", "password" => "password"}
  end

  let(:index) { Snowsafe::Index.generate(FIXTURE_DIR) }

  describe ".generate" do
    it "creates a new Index on the filesystem" do
      index = Snowsafe::Index.generate(FIXTURE_DIR)
      index.path.should exist_on_disk
    end
  end

  describe ".index_filename_from_dir" do
    it "returns the path to a file called 'index' in the given directory" do
      Snowsafe::Index.index_filename_from_dir(FIXTURE_DIR).should == File.join(FIXTURE_DIR, Snowsafe::Index::FILE_NAME)
    end
  end

  describe "#add_entry" do

    it "adds a new encrypted entry" do
      index.encrypted_entries.should be_empty

      entry = index.add_entry(password, sample_entry_data)
      entry.path.should exist_on_disk

      index.should have(1).encrypted_entries
      encrypted_entry = index.encrypted_entries.first
      encrypted_entry.should be_kind_of Snowsafe::Index::EncryptedEntry
      encrypted_entry.uuid.should == entry.uuid
    end

  end

  describe "#decrypt_entry" do

    it "returns the parsed, decrypted data of the encrypted entry" do
      entry = index.add_entry(password, sample_entry_data)
      decrypted_entry = index.decrypt_entry(entry.uuid, password)
      entry.data.should == decrypted_entry.data
    end
  end

end
