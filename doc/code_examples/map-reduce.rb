
Model.collection.map_reduce(map, reduce, options)

map = %Q{
  function() {
    if (this.keywords != null)
      this.keywords.forEach(function(k) { emit(k, {count: 1}) })
  }}

reduce = %Q{
  function(key, values) {
    var res = {count: 0}
    values.forEach(function(v) { res.count += v.count })
    return res;
  }}

    
options = { 
    out: { inline: 1 }, raw: true,
  query: Product.available.selector
}

Product.collection.map_reduce(map, reduce, options)

  {
    "results"=> [
      {"_id"=>"bar", "value"=>{"count"=>3.0}},
      {"_id"=>"baz", "value"=>{"count"=>3.0}},
      {"_id"=>"foo", "value"=>{"count"=>5.0}},
      {"_id"=>"qux", "value"=>{"count"=>1.0}}
    ],
   "timeMillis" => 35,
   "counts"=> {
     "input" => 7, "emit"  => 12, "reduce"=>3, "output"=>4
    },
   "ok"=>1.0
  }


