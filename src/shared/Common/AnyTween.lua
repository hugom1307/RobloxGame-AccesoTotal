-- Decompiled with the Synapse X Luau decompiler.

local l__RunService__1 = game:GetService("RunService");
local v2 = {};
local u1 = require(game:GetService("ReplicatedStorage").Packages.Promise);
local l__TweenService__2 = game:GetService("TweenService");
function v2.alpha(p1, p2)
	return u1.delay(p1.DelayTime):andThen(function()
		return u1.new(function(p3, p4, p5)
			local v3 = 0;
			while true do
				p2((l__TweenService__2:GetValue(v3 / p1.Time, p1.EasingStyle, p1.EasingDirection)));
				v3 = v3 + task.wait();
				if p1.Time <= v3 then
					break;
				end;
				if p5() then
					break;
				end;			
			end;
			if not p5() then
				p2(1);
				p3();
			end;
		end);
	end);
end;
function v2.range(p6, p7, p8, p9)
	if p7 ~= p8 then
		return v2.alpha(p6, function(p10)
			p9(p7 + (p8 - p7) * p10);
		end);
	end;
	p9(p8);
	return u1.resolve();
end;
return v2;
