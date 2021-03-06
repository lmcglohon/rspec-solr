# RSpec-Solr Matchers for RSpec-Solr::SolrResponseHash

(rspec-solr_resp_hash..should ...  or rspec-solr_resp_hash..should_not ...)

## MATCHING WHETHER RESPONSE HAS DOCUMENTS OR NOT

 NOTE:  this is about the TOTAL number of Solr documents that match ("numFound"), NOT solely the documents returned in this response

### Matcher
* `have_documents`

### Usage
* `expect(rspec-solr_resp_hash).to have_documents`
* `expect(rspec-solr_resp_hash).not_to have_documents`

## MATCHING NUMBER OF DOCUMENTS 

 NOTE:  this is about the TOTAL number of Solr documents that match ("numFound"), NOT solely the documents returned in this response

### Matchers
* `have(2).documents`
* `have_exactly(4).documents`
* `have_at_least(3).documents`  
* `have_at_most(3).documents`

### Usage
* rspec-solr_resp_hash.should have(3).documents
* rspec-solr_resp_hash.should_not have(2).documents
* rspec-solr_resp_hash.should have_at_least(3).documents
* rspec-solr_resp_hash.should have_at_most(4).documents

## MATCHING SPECIFIC DOCUMENTS IN RESPONSE

 NOTE:  this is about the Solr documents returned in THIS response

### Matcher
* `include()`

### Usage
#### Specifying Single Document
##### String
* (`"idval"`) 
 NOTE: value of the unique id field (defaults to 'id') in the Solr document
       To change the id field name, use my_solr_response_hash.id_field='my_id_fldname'
##### Hash
* (`"fldname" => "value"`)
* (`"fldname" => /regex_to_match_val/`)
* (`"fld1" => "val1", "fld2" => /val2_regex/`)
 NOTE: single Solr document must satisfy all key value pairs
* (`"fldname" => ["val1", /val2_regex/, "val3"]`)
 NOTE: all of the Array values must be present for the fld in a single Solr document
       should_not for Array implies NONE of the values should be present in a single document

More Ideas (TODO):
* `include_title("val")` (i.e. include_anyFieldName("val") )

#### Specifying Multiple Documents
##### Array
* by id strings: (`["id1", "id2", "id3"]`)
* by hashes: (`[{"title" => "green is best"}, {"title" => /blue/}, {"fld" => "val"}]`)
 NOTE: you cannot do this:  (`[{"title" => ["Solr doc 1 title", "Solr doc 2 title"]} ]`) to specify multiple documents
* by mix of id strings and hashes: (`[{"title" => "green is best"}, "id3", {"author" => "steinbeck"}]`)

#### Full Examples
* `expect(rspec-solr_resp_hash).to include("fld1" => "val1")`
* `expect(rspec-solr_resp_hash).to include("fld1" => /regex_for_val/)`
* `expect(rspec-solr_resp_hash).to include("f1" => "v1", "f2" => ["val1", "val2", /regex_for_val/])`
* `expect(rspec-solr_resp_hash).to include("idval")`
* `expect(rspec-solr_resp_hash).to include(["id1", "id2", "id3"])`
* `expect(rspec-solr_resp_hash).to include([{"title" => "title1"}, {"title" => "title2"}])`
* `expect(rspec-solr_resp_hash).to include([{"title" => "title1"}, {"title" => "title2"}, "id8"])`

## MATCHING SPECIFIC DOCUMENTS OCCURRING IN FIRST N RESULTS 

 NOTE:  this is about the Solr documents returned in THIS response

### Matchers
* `include().as_first`
* `include().as_first.document`
* `include().in_first(n)`
* `include(Array).in_first(n).results `
* `include(Hash).in_each_of_first(n).documents`

Note that the following are equivalent:
* `include().blah.document`
* `include().blah.documents`
* `include().blah.result`
* `include().blah.results`

TODO:
* `include_at_least(3).of_these_documents().in_first(3).results`
* `start_with()`

### Usage
See above for information on how to specify specific documents
* `expect(rspec-solr_resp_hash).to include("111").as_first.document`
* `expect(rspec-solr_resp_hash).to include(["111", "222"]).as_first.documents`
* `expect(rspec-solr_resp_hash).to include([{"title" => "title1"}, {"title" => "title2"}]).in_first(3).results`
* `expect(rspec-solr_resp_hash).to include("fld1" => "val1").in_first(3)`
* `expect(rspec-solr_resp_hash).to include("title" => /cooking/).in_first(3).results`

## MATCHING RELATIVE ORDER OF SPECIFIC DOCUMENTS

 NOTE:  this is about the Solr documents returned in THIS response

### Matcher
* `include().before()`
 NOTE: documents are specified the same way inside both sets of parens (see Usage for examples and see above re: specifying documents)

TODO: Potential Syntax:
* `include().before_first_occurrence_of()`
* `include().within(3).of_document()`
* `expect(subject.document(:title => 'vala')).to come_before(subject.document(:title =>'valb'))`
* `expect(subject).to have_result_field_ordered("title", "vala", "valb") `

### Usage
* `expect(rspec-solr_resp_hash).to include("111").before("222")`
* `expect(rspec-solr_resp_hash).to include("fld"=>"val").before("fld"=>["val1", "val2", "val3"])`
* `expect(rspec-solr_resp_hash).to include([{"title" => "title1"}, {"title" => "title2"}]).before("title" => "title3")`


## COMPARING TOTAL RESULTS OF TWO RESPONSES

 NOTE:  this is about the TOTAL number of Solr documents that match ("numFound"), NOT solely the documents returned in THESE responses

### Matchers
* `have_more_results_than()`
* `have_fewer_results_than()`
* `have_the_same_number_of_results_as()`
* `have_more_documents_than()`
* `have_fewer_documents_than()`
* `have_the_same_number_of_documents_as()`

### Usage
* `expect(rspec-solr_resp_hash1).to have_more_results_than(rspec-solr_resp_hash2)`
* `expect(rspec-solr_resp_hash1).to have_fewer_results_than(rspec-solr_resp_hash2)`
* `expect(rspec-solr_resp_hash1).to have_the_same_number_of_results_as(rspec-solr_resp_hash2)`

#### Alternate (allows more granularity)
* `expect(rspec-solr_resp_hash1.size).to > rspec-solr_resp_hash2.size`
* `expect(rspec-solr_resp_hash1.size).to >= rspec-solr_resp_hash2.size`
* `expect(rspec-solr_resp_hash1.size).to < rspec-solr_resp_hash2.size`
* `expect(rspec-solr_resp_hash1.size).to <= rspec-solr_resp_hash2.size`
* `expect(rspec-solr_resp_hash1.size).to == rspec-solr_resp_hash2.size`
* `expect(rspec-solr_resp_hash1.size).to be_within(delta).of(rspec-solr_resp_hash2.size)`

## MATCHING FACET VALUES IN RESPONSE

 NOTE:  this is about the facet counts returned in THIS response

### Matchers
* `have_facet_field()`
* `have_facet_field().with_value()`

### Usage
* `expect(rspec-solr_resp_hash).to have_facet_field("author")`
* `expect(rspec-solr_resp_hash).to have_facet_field("author").with_value("Steinbeck, John")`

### TODO:
* facets with arrarr and without (Solr option to get better facet formatting)
* `have_facet_field().with_value().with_count()`
* more ideas
  * `facet(:format => "Book")`
  * `facets(:format => ["Image", "Map"])`
  * `include_facet().before_facet()`
  * `include_facets().before_facet()`
  * `include_facet().before_facets()`
  * `include_facets().before_facets()`
