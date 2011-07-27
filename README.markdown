[license]: http://github.com/rafaelrinaldi/list/blob/master/license.txt
[printf]: http://github.com/arthur-debert/printf-as3

# list
Handy way to manipulate lists with ActionScript 3.0.

---
### Features
- Single and group items manipulation.
- Overriding control.
- Each entry is mapped with an `String` id. Nothing is anonymous.
- You can reset a list and start from scratch if needed.
- Chaining for fast manipulation.
- Match items by id or value.
- Option to restrict values by object type.
- [printf][printf] support.
- You can feed the list with XML.
- You can export the list as XML.
- Clone and merge support.
- `List` is based on `String` ids but also have an index search/matching.

---
### API
- `restrict` - A `Vector.<Class>` to restrict values by object type.
- `from` - Feed the list with XML data.
- `export` - Export list data as XML.
- `clone` - Clone the current instance.
- `merge` - Merge a list with another one.
- `add` - Add a new list entry.
- `remove` - Remove a list entry.
- `item` - Get a single item.
- `group` - Get a group item.
- `index` - Get an item based on a numeric index.
- `match` - Match some id or value.
- `reset` - Start from scratch.
- `toListString` - Print the `List` instance as `String`.
- `length` - List length.
- `dispose` - Clear from memory.

---
### Usage

	// Creating the list.
	var list : List = new List("foo");
	list.add("name", "Rafael Rinaldi");
	list.add("website", "rafaelrinaldi.com");
	list.add("message", "I'm %(name)s and my website is %(website)s"); // Dynamic values supported by printf
	
	trace(list.item("message")); // I'm Rafael Rinaldi and my website is rafaelrinaldi.com
	
	// Using groups.
	list.group("math").add("pi", Math.PI).add("max", int.MAX_VALUE);
	
	trace(list.group("math").item("pi")); // 3.141592653589793
	trace(list.group("math").item("max")); // 2147483647
	
	// Matching ids.
	
	trace(list.match("message")); // true
	
	// Adding different kind of values to the list.
	
	var bitmap : Bitmap =  new Bitmap();
	var point : Point = new Point(10, 10);
	
	function callback() : void {};
	
	list.add("bitmap", bitmap);
	list.add("point", point);
	list.add("callback", callback);
	
	trace(list.item("bitmap")); // [object Bitmap]
	trace(list.item("point")); // (x=10, y=10)
	trace(list.item("callback")); // function Function() {}
	
	// Matching values.
	
	trace(list.match(bitmap)); // true
	trace(list.match(point)); // true
	trace(list.match(callback)); // true
	
	// Adding restrictions by object type.
	list.group("numbers").restrict.push(Number);
	list.group("numbers").add("one", 1).add("year", 2011).add("one_hundred", 100);
	list.group("numbers").add("string", "I'm an String");
	
	trace(list.group("numbers").item("one")); // 1
	trace(list.group("numbers").item("year")); // 2011
	trace(list.group("numbers").item("one_hundred")); // 100
	trace(list.group("numbers").item("string")); // null
	
	// Getting items by index.
	trace(list.index(0)); // Rafael Rinaldi
	trace(list.index(1)); // rafaelrinaldi.com
	
	// List length.
	trace(list.length); // 6
	trace(list.group("numbers").length); // 3

---
### License
[WTFPL][license]