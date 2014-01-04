require 'tag_reader'

describe TagReader do
  describe '#extract_quoted_phrases' do
    let(:normal_input) { "'those dang' commies 'are' outta control".split }
    let(:nested_input) { "those 'dang commies 'are outa' control'".split }
    let(:misplaced_quotes) { "those' dang 'commies".split }
    
    it do
      TagReader.extract_quoted_phrases(normal_input)[1].length.should == 2
      TagReader.extract_quoted_phrases(nested_input)[1].length.should == 1
      TagReader.extract_quoted_phrases(nested_input)[1][0].length.should == 2
      TagReader.extract_quoted_phrases(misplaced_quotes)[1].length.should == 0
    end
  end
end
