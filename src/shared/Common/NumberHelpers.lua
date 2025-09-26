local u1 = {
	[5] = "K", 
	[6] = "M", 
	[9] = "B"
};
local u2 = {}

function u2.randomDigits(p1)
	local v1 = nil;
	v1 = "";
	for v2 = 1, p1 do
		v1 = v1 .. math.random(0, 9);
	end;
	return tonumber(v1)
end

function u2.formatCommas(p2)
	return tostring(p2):reverse():gsub("(%d%d%d)", "%1,"):gsub(",$", ""):reverse();
end

function u2.format(p3)
	local v4 = math.floor(math.floor(math.log10(p3)) / 3) * 3;
	local v5 = u1[v4];
	if not v5 then
		return u2.formatCommas(p3);
	end;
	return string.format("%s%s", string.sub(p3 / 10 ^ v4, 1, 5), v5);
end

return u2;
