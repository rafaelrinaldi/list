package com.rafaelrinaldi.string
{
	/**
	 * 
	 * Converts a <code>String</code> value into a <code>Boolean</code> value.
	 *
	 * @author Rafael Rinaldi (rafaelrinaldi.com)
	 * @since Jul 15, 2011
	 *
	 */
	public function toBoolean( p_string : String ) : Boolean
	{
		return p_string == "true" || p_string == "1" || p_string == "yes";
	}
}
