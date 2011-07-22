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
- `match` - Match some id or value.
- `reset` - Start from scratch.
- `length` - List length.
- `dispose` - Clear from memory.

---
### License
[WTFPL][license]