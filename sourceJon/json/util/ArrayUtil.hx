package json.util;

class ArrayUtil
{
	static function containsExact<T>(list:Array<T>, item:T):Bool
	{
		for (entry in list)
		{
			if (thx.Dynamics.equals(entry, item))
				return true;
		}

		return false;
	}

	public static function subtract<T>(list:Array<T>, subtract:Array<T>):Array<T>
	{
		return list.filter((item) ->
		{
			var contains = containsExact(subtract, item);
			return !contains;
		});
	}

	public static function equalsUnordered<T>(a:Array<T>, b:Array<T>):Bool
	{
		if (a.length != b.length)
			return false;

		for (element in a)
		{
			if (!containsExact(b, element))
				return false;
		}

		for (element in b)
		{
			if (!containsExact(a, element))
				return false;
		}

		return true;
	}

	public static function intersect<T>(list:Array<T>, intersect:Array<T>):Array<T>
	{
		return list.filter((item) ->
		{
			var contains = containsExact(intersect, item);
			return contains;
		});
	}
}
