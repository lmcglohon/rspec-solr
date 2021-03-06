require 'spec_helper'
require 'rspec-solr'

describe RSpecSolr do
  # fixtures below

  context 'should include().before()' do
    it 'passes when criteria are met' do
      expect(@solr_resp_5_docs).to include('111').before('222')
      expect(@solr_resp_5_docs).to include('333').before('fld' => %w(val1 val2 val3))
      expect(@solr_resp_5_docs).to include('fld' => 'val').before('fld' => %w(val1 val2 val3))
      expect(@solr_resp_5_docs).to include(%w(111 222)).before(%w(333 555))
      expect(@solr_resp_5_docs).to include([{ 'id' => '111' }, { 'id' => '333' }]).before([{ 'id' => '444' }, { 'id' => '555' }])
    end
    it 'passes when criteria CAN BE met (more than one option)' do
      expect(@solr_resp_5_docs).to include('111').before('fld' => 'val')
    end
    it "fails when docs aren't in expected order" do
      expect do
        expect(@solr_resp_5_docs).to include('222').before('fld2' => 'val2')
      end.to raise_error.with_message a_string_including 'expected response to include document "222" before document matching {"fld2"=>"val2"}'
      expect do
        expect(@solr_resp_5_docs).to include('111', '444').before([{ 'id' => '333' }, { 'id' => '555' }])
      end.to raise_error.with_message a_string_including 'expected response to include documents "111" and "444" before documents matching [{"id"=>"333"}, {"id"=>"555"}]'
      expect do
        expect(@solr_resp_5_docs).to include([{ 'id' => '222' }, { 'id' => '444' }]).before([{ 'id' => '333' }, { 'id' => '555' }])
      end.to raise_error.with_message a_string_including 'expected response to include documents [{"id"=>"222"}, {"id"=>"444"}] before documents matching [{"id"=>"333"}, {"id"=>"555"}]'
    end
    it "fails when it can't find a doc matching first argument(s)" do
      expect do
        expect(@solr_resp_5_docs).to include('not_there').before('555')
      end.to raise_error.with_message a_string_including 'expected response to include document "not_there" before document matching "555"'
    end
    it "fails when it can't find a doc matching second argument(s)" do
      expect do
        expect(@solr_resp_5_docs).to include('222').before('not_there')
      end.to raise_error.with_message a_string_including 'expected response to include document "222" before document matching "not_there"'
    end
    it "fails when it can't find docs matching first or second argument(s)" do
      expect do
        expect(@solr_resp_5_docs).to include('not_there').before('still_not_there')
      end.to raise_error.with_message a_string_including 'expected response to include document "not_there" before document matching "still_not_there"'
    end
  end # should include().before()

  context 'should_NOT include().before()' do
    it 'fails when criteria are met' do
      expect do
        expect(@solr_resp_5_docs).not_to include('111').before('222')
      end.to raise_error.with_message a_string_including 'not to include document "111" before document matching "222"'
      expect do
        expect(@solr_resp_5_docs).not_to include('333').before('fld' => %w(val1 val2 val3))
      end.to raise_error.with_message a_string_including 'not to include document "333" before document matching {"fld"=>["val1", "val2", "val3"]}'
      expect do
        expect(@solr_resp_5_docs).not_to include('fld' => 'val').before('fld' => %w(val1 val2 val3))
      end.to raise_error.with_message a_string_including 'not to include document {"fld"=>"val"} before document matching {"fld"=>["val1", "val2", "val3"]}'
      expect do
        expect(@solr_resp_5_docs).not_to include(%w(111 222)).before(%w(333 555))
      end.to raise_error.with_message a_string_including 'not to include documents ["111", "222"] before documents matching ["333", "555"]'
      expect do
        expect(@solr_resp_5_docs).not_to include([{ 'id' => '111' }, { 'id' => '333' }]).before([{ 'id' => '444' }, { 'id' => '555' }])
      end.to raise_error.with_message a_string_including 'not to include documents [{"id"=>"111"}, {"id"=>"333"}] before documents matching [{"id"=>"444"}, {"id"=>"555"}]'
    end
    it 'fails when criteria CAN BE met (more than one option)' do
      expect do
        expect(@solr_resp_5_docs).not_to include('111').before('fld' => 'val')
      end.to raise_error.with_message a_string_including 'not to include document "111" before document matching {"fld"=>"val"}'
    end
    it "passes when docs aren't in expected order" do
      expect(@solr_resp_5_docs).not_to include('222').before('fld2' => 'val2')
      # NOTE: it is picky about the next line include() being ["111", "444"], not just "111", "444"
      expect(@solr_resp_5_docs).not_to include(%w(111 444)).before([{ 'id' => '333' }, { 'id' => '555' }])
      expect(@solr_resp_5_docs).not_to include([{ 'id' => '222' }, { 'id' => '444' }]).before([{ 'id' => '333' }, { 'id' => '555' }])
    end
    it "passes when it can't find a doc matching first argument(s)" do
      expect(@solr_resp_5_docs).not_to include('not_there').before('555')
    end
    it "passes when it can't find a doc matching second argument(s)" do
      expect(@solr_resp_5_docs).not_to include('222').before('not_there')
    end
    it "passes when it can't find docs matching first or second argument(s)" do
      expect(@solr_resp_5_docs).not_to include('not_there').before('still_not_there')
    end
  end # should_NOT include().before()

  before(:all) do
    @solr_resp_5_docs = RSpecSolr::SolrResponseHash.new('response' =>
                          { 'numFound' => 5,
                            'start' => 0,
                            'docs' =>
                              [{ 'id' => '111', 'fld' => 'val', 'fld2' => 'val2' },
                               { 'id' => '222' },
                               { 'id' => '333', 'fld' => 'val' },
                               { 'id' => '444', 'fld' => %w(val1 val2 val3) },
                               { 'id' => '555' }
                              ]
                          })
  end
end
