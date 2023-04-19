function mysplit(input, sep) -- thanks tutorialspoint.com
   if sep == nil then
      sep = "%s"
   end
   local t={}
   for str in string.gmatch(input, "([^"..sep.."]+)") do
      table.insert(t, str)
   end
   return t
end

function onEvent(name, v1, v2)
	if name == "V4 Credits" then
		credits = mysplit(v1, ";")
		size = mysplit(v2, ";")
		if size[2] == nil then size[2] = getProperty('creditBox.height') end
		
		objWidth = tonumber(size[1])
		objHeight = tonumber(size[2])
		
		cancelTween("creditBoxTween")
		cancelTween("creditTitleTween")
		cancelTween("creditCreatorTween")
		cancelTimer("creditDisplay")
		
		setProperty("creditBox.x", -objWidth)
		setProperty("creditTitle.x", -objWidth)
		setProperty("creditCreator.x", -objWidth)
		
		setGraphicSize('creditBox', objWidth, objHeight)
		
		setTextWidth('creditTitle', objWidth)
		setTextWidth('creditCreator', objWidth)		
		setTextString('creditTitle', credits[1])
		setTextString('creditCreator', credits[2])
		
		doTweenX("creditBoxTween", "creditBox", 0, 1, "quartInOut")
		doTweenX("creditTitleTween", "creditTitle", 12, 1, "quartInOut")
		doTweenX("creditCreatorTween", "creditCreator", 12, 1, "quartInOut")
		runTimer("creditDisplay", 3.5, 1)
	end
end

function onTimerCompleted(tag)
    if tag == "creditDisplay" then
        doTweenX("creditBoxTween", "creditBox", getProperty("creditBox.x") - (objWidth * 1.1), 1, "quartInOut")
        doTweenX("creditTitleTween", "creditTitle", getProperty("creditTitle.x") - (objWidth * 1.1), 1, "quartInOut")
        doTweenX("creditCreatorTween", "creditCreator", getProperty("creditCreator.x") - (objWidth * 1.1), 1, "quartInOut")
    end
end