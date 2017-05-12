command: " 
output=$(curl --silent 'http://www.dictionary.com/wordoftheday/wotd.rss');
echo $output;
";

refreshFrequency: '1h';

style: """
  color: #fff; 
  font-family: Helvetica Neue;
  top: 10px;
  right: 10px;
  text-align: right;
  width: 400px;
  .title
    display: block;
    font-size: 1.25em;
    padding: 0 0 5px;
  .word
    font-size: 2em;
    text-transform: capitalize;
    display: block;
    padding: 0 0 7px 0;
  span.definition
    display: inline-block;
    line-height: 1.25em;
  span.definition::first-letter
    text-transform: capitalize;

"""

render: (output) -> """
<div class="container">
  <span class="title"></span>
  <span class="word"></span><span class="definition"></span>
</div>
"""

afterRender: ->

update: (output) ->
  if !output
    $('.container').hide()
  else
    $xmlDoc = $.parseXML(output);
    $xml = $( $xmlDoc );

    $data = $xml.find("item").eq(0).find("description").text().split(' ');
    $word = $data[0].substring(0, $data[0].length - 1);
    
    $data.shift();

    $( ".title" ).html("Word of the day");
    $( ".word" ).html($word).append('&nbsp;');
    $( ".definition" ).html($data.join(' '));

