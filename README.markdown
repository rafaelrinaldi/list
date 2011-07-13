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
- Chaining for fast adding/removing items.
- Match items by id or value.
- Option to restrict values by object type.
- [printf][printf] support.

---
### API
- `add` - Add a new list entry.
- `remove` - Remove a list entry.
- `item` - Get a single item.
- `group` - Get a group item.
- `match` - Match some id or value.
- `restrict` - A `Vector.<Class>` to restrict values by object type.
- `reset` - Start from scratch.
- `length` - List length.
- `dispose` - Clear from memory.

---
### Usage
	import com.rafaelrinaldi.data.list.List;
	import flash.display.Bitmap;
	import printf;
	
	// A random bitmap instance.
	var bitmapInstance : Bitmap = new Bitmap;
	
	// Starting the list with the id "generic".
	var generic : List = new List("generic");
	 
	// Adding some stuff.
	generic.add("pi", Math.PI);
	generic.add("max", int.MAX_VALUE);
	generic.add("bitmap", bitmapInstance);
	 
	// Getting items.
	trace(generic.item("pi")); // 3.141592653589793
	trace(generic.item("max")); // 2147483647
	trace(generic.item("bitmap")); // [object Bitmap]
	 
	// Matching the id "pi".
	trace(generic.match("pi")); // true
	// Matching the Bitmap instance.
	trace(generic.match(bitmapInstance)); // true
	// Matching something invalid.
	trace(generic.match("foo")); // false
	 
	// Using groups.
	var locales : List = generic.group("locales");
	 
	// Using the chain.
	locales.add("pt_BR", "Brazilian Portuguese").add("en_US", "American English").add("it", "Italian");
	
	// Getting items.
	trace(locales.item("pt_BR")); // Brazilian Portuguese
	trace(locales.item("en_US")); // American English
	trace(locales.item("it")); // Italian
	
	// Removing an item.
	locales.remove("it");
	
	// Trying to get the removed item.
	trace(locales.item("it")); // null
	
	// Overriding an item and getting him.
	locales.add("it", "Pizzalian");
	trace(locales.item("it")); // Pizzalian
	 		
	// Disabling override and testing it.
	locales.allowOverride = false;
	locales.add("en_US", "Baconenglish");
	trace(locales.item("en_US")); // American English
	
	// Creating a list with restrictions.
	var restricted : List = new List;
	restricted.restrict.push(String);
	restricted.add("string", "I'm a String");
	restricted.add("number", 2011);
	restricted.add("boolean", false);
	
	// Trying to get these items.
	trace(restricted.item("string")); // I'm a String
	trace(restricted.item("number")); // null
	trace(restricted.item("boolean")); // null
	
	// Dynamic variables using printf.
	var credentials : List = new List;
	credentials.add("name", "Rafael");
	credentials.add("surname", "Rinaldi");
	credentials.add("age", 21);
	credentials.add("website", "http://rafaelrinaldi.com");
	credentials.add("hi", "Hi! My name is %(name)s %(surname)s, %(age)s years old. You can see my works here: %(website)s");
	 	
	trace(credentials.item("hi")); // Hi! My name is Rafael Rinaldi, 21 years old. You can see my works here: http://rafaelrinaldi.com

---
### License
[WTFPL][license]