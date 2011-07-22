package com.rafaelrinaldi.string
{
	/**
	 * 
	 * Try to convert a <code>String</code> value into a native value such as <code>Boolean</code> and <code>Number</code>.
	 *
	 * @author Rafael Rinaldi (rafaelrinaldi.com)
	 * @since Jul 20, 2011
	 *
	 */
	public function toNative( p_string : String ) : *
	{
		const string : String = p_string.toLowerCase();
			
		var value : *;
		
		if(string == "true" || string == "false") {
			value = toBoolean(string);
		} else if(string == "null" || string == "nan" || string == "undefined" || string == "infinity") {
			value = null; // Value is unnassigned.
		} else if(!isNaN(Number(string))) {
			value = toNumber(string);
		} else {
			value = p_string;
		}
			
		return value;
	}
}
