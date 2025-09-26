local messages = 
{
	"Pet System New version",
	"Subscribe To YobestBYTR",
	"Like & Subscribe",
}

local timePerMessage = 20


while wait(timePerMessage) do

	game.StarterGui:SetCore("ChatMakeSystemMessage", 
	{
		Text = "[TIPS]: " .. messages[math.random(1, #messages)],
		Color = Color3.fromRGB(255, 0, 0),
		Font = Enum.Font.FredokaOne,
		TextSize = 20,
	})
end