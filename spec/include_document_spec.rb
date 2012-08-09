require 'spec_helper'
require 'rspec-solr'

describe RSpecSolr do
  
  context "RSpecSolr::SolrResponseHash #include matcher" do
    
    # ONE FIELD SPECIFIED
    context "should include('fldname'=>'fldval')" do

      context "doc_expectations for single valued fields" do
        it "passes if Solr document in response contains 'fldval' in named field" do
          @solr_resp_5_docs.should include("id" => "111")
          @solr_resp_5_docs.should include("fld" => "val")  # 2 docs match 
        end
        
        it "fails if no Solr document in response has 'fldval' for the named field" do
          lambda {
            @solr_resp_5_docs.should have_document("id" => "not_there")
          }.should fail
        end
        
        it "fails if no Solr document in response has the named field" do
          lambda {
            @solr_resp_5_docs.should have_document("not_there" => "anything")
          }.should fail
        end
      end # single valued fields in docs
      
      context "doc expectations against multi-valued fields" do
        it "does something" do
          pending "to be implemented"
        end
        #      it "should be true when all the expected values are matched" do
        #        @solr_resp_5_docs.should have_document({"fld" => ["val1", "val2", "val3"]})
        #        @solr_resp_5_docs.should have_document({"fld" => ["val1", "val2"]})
        #      end
        #      it "should work with an array of field values" do
        #        @solr_resp_5_docs.should_not have_document({"id" => "222", "fld" => "val"})
        #      end
        #    end
        
      end # multi-valued fields in docs
    end # context "should_not include('fldname'=>'fldval')"


    context "should_not include('fldname'=>'fldval')" do

      context "doc expectations against single valued fields" do
        it "fails if Solr document in response contains 'fldval' in named field" do
          lambda {
            @solr_resp_5_docs.should_not include("id" => "111")
          }.should fail
          lambda {
            @solr_resp_5_docs.should_not include("id" => "111", "fld" => "val")
          }.should fail
          lambda {
            @solr_resp_5_docs.should_not include("fld" => "val") 
          }.should fail
        end
        
        it "passes if no Solr document in response has 'fldval' for the named field" do
            @solr_resp_5_docs.should_not have_document({"id" => "not_there"})
        end
        
        it "passes if no Solr document in response has the named field" do
            @solr_resp_5_docs.should_not have_document({"not_there" => "anything"})
        end
      end # single valued fields in docs

      context "doc expectations against multi-valued fields" do
        it "does something" do
          pending "to be implemented"
        end
      end # multi-valued fields in docs
    end # "should_not include('fldname'=>'fldval')"

    # MULTIPLE FIELDS SPECIFIED
    context "should include('fld1'=>'val1', 'fld2'=>'val2')" do

      context "doc expectations against single valued fields" do
        it "passes if all pairs are included in a Solr document in the response" do
          @solr_resp_5_docs.should include("id" => "111", "fld" => "val")
          @solr_resp_5_docs.should include("id" => "333", "fld" => "val")
        end
        
        it "fails if only part of expectation is met" do
          lambda {
            @solr_resp_5_docs.should include("id" => "111", "fld" => "not_there")
          }.should fail
          lambda {
            @solr_resp_5_docs.should include("id" => "111", "not_there" => "whatever")
          }.should fail
          lambda {
            @solr_resp_5_docs.should include("id" => "222", "fld" => "val")
          }.should fail
        end
        
        it "fails if no part of expectation is met" do
          lambda {
            @solr_resp_5_docs.should include("id" => "not_there", "not_there" => "anything")
          }.should fail
        end
      end # single valued fields in docs
      
      context "doc expectations against multi-valued fields" do
        it "does something" do
          pending "to be implemented"
        end
        
      end # multi-valued fields in docs  
    end # should include('fld1'=>'val1', 'fld2'=>'val2')


    context "should_not include('fld1'=>'val1', 'fld2'=>'val2')" do
      context "doc expectations against single valued fields" do
        it "fails if a Solr document in the response contains all the key/value pairs" do
          lambda {
            @solr_resp_5_docs.should_not include("id" => "333", "fld" => "val")
          }.should fail
        end
        
        it "passes if a Solr document in the response contains all the key/value pairs among others" do
          lambda {
            @solr_resp_5_docs.should_not include("id" => "111", "fld" => "val")
          }.should fail
        end
        
        it "fails if part of the expectation is met" do
          lambda {
            @solr_resp_5_docs.should include("id" => "111", "fld" => "not_there")
          }.should fail
          lambda {
            @solr_resp_5_docs.should include("id" => "111", "not_there" => "whatever")
          }.should fail
          lambda {
            @solr_resp_5_docs.should include("id" => "222", "fld" => "val")
          }.should fail
        end
        
        it "passes if no part of the expectatio is met" do
          @solr_resp_5_docs.should_not include("id" => "not_there", "not_there" => "anything")
        end
      end # single valued fields in docs

      context "doc expecations against multi-valued fields" do
        it "does something" do
          pending "to be implemented"
        end
      end # multivalued fields in docs
    end # should_not include('fld1'=>'val1', 'fld2'=>'val2')
    
    
    
    context "should include(single_string_arg)" do
      it "does something" do
        pending "to be implemented"
      end
    end
    
    context "should include(:key => [val1, val2, val3])" do
      it "does something" do
        pending "to be implemented"
      end
    end
    
    context 'should include(:key => "/regex/")' do
      it "does something" do
        pending "to be implemented"
      end
    end


    before(:all) do
      @solr_resp_5_docs = RSpecSolr::SolrResponseHash.new({ "response" =>
                            { "numFound" => 5, 
                              "start" => 0, 
                              "docs" => 
                                [ {"id"=>"111", "fld"=>"val", "fld2"=>"val2"}, 
                                  {"id"=>"222"}, 
                                  {"id"=>"333", "fld"=>"val"}, 
                                  {"id"=>"444", "fld"=>["val1", "val2", "val3"]}, 
                                  {"id"=>"555"}
                                ]
                            }
                          })
    end


    context "shouldn't break RSpec #include matcher" do
      it "for String" do
        "abc".should include("a")
        "abc".should_not include("d")
      end

      it "for Array" do
        [1,2,3].should include(3)
        [1,2,3].should include(2,3)
        [1,2,3].should_not include(4)
        lambda {
          [1,2,3].should include(1,666)
        }.should fail
        lambda {
          [1,2,3].should_not include(1,666)
        }.should fail
      end

      it "for Hash" do
        {:key => 'value'}.should include(:key)
        {:key => 'value'}.should_not include(:key2)
        lambda {
          {:key => 'value'}.should include(:key, :other)
        }.should fail
        lambda {
          {:key => 'value'}.should_not include(:key, :other)
        }.should fail
        {'key' => 'value'}.should include('key')
        {'key' => 'value'}.should_not include('key2')
      end
    end # context shouldn't break RSpec #include matcher
    
  end # context RSpecSolr::SolrResponseHash #include matcher
  
end