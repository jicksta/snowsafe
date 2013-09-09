require 'spec_helper'

module Snowsafe
  describe Index do

    let(:password) { new_password }

    describe ".generate" do
      it "creates a new Index on the filesystem" do
        index = Snowsafe::Index.generate(FIXTURE_DIR, password)
        index.path.should exist_on_disk
      end
    end

  end
end
