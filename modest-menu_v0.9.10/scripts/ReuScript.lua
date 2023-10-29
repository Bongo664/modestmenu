--Start

	ReuScript = menu.add_submenu("ツ ReuScript")

--Options

			a1 = false
	ReuScript:add_toggle("Drift Mod (alt)", function() return a1 end, function() a1 = not a1 ToggleDriftMod(a1) end)

			a2 = false
	ReuScript:add_toggle("Nitrous Mod (shift)", function() return a2 end, function() a2 = not a2 ToggleNitroBoost(a2) end)

			a3 = false
	ReuScript:add_toggle("Rainbow Mod", function() return a3 end, function() a3 = not a3 end)

			a4 = false
	ReuScript:add_toggle("Speedometer Mod", function() return a4 end, function() a4 = not a4 PlateSpeedometer(a4) end)

	CustomModifications = ReuScript:add_submenu("Custom Mod")

--Functions

	--Drift Mod

			a5 = false
		function DriftMod()
			if a5 == false then
				if localplayer:is_in_vehicle() then
					SaveAcceleration = localplayer:get_current_vehicle():get_acceleration()
					SaveGravity = localplayer:get_current_vehicle():get_gravity()
					SaveMass = localplayer:get_current_vehicle():get_mass()
					SaveWheelDrive = localplayer:get_current_vehicle():get_drive_bias_front()
					SaveUpShift = localplayer:get_current_vehicle():get_up_shift()
					SaveDownShift = localplayer:get_current_vehicle():get_down_shift()
					SaveSteerLock = localplayer:get_current_vehicle():get_steering_lock()
					SaveDriftTyres = localplayer:get_current_vehicle():get_drift_tyres_enabled()
				end
				localplayer:get_current_vehicle():set_acceleration(0.70)
				localplayer:get_current_vehicle():set_gravity(7.80)
				if SaveMass >= 1400 then
					localplayer:get_current_vehicle():set_mass(1400)
				end
				localplayer:get_current_vehicle():set_drive_bias_front(0.05)
				localplayer:get_current_vehicle():set_up_shift(20.00)
				localplayer:get_current_vehicle():set_down_shift(20.00)
				localplayer:get_current_vehicle():set_steering_lock(80.00)
				localplayer:get_current_vehicle():set_drift_tyres_enabled(true)
				a5 = true
			else
				localplayer:get_current_vehicle():set_acceleration(SaveAcceleration)
				localplayer:get_current_vehicle():set_gravity(SaveGravity)
				localplayer:get_current_vehicle():set_mass(SaveMass)
				localplayer:get_current_vehicle():set_drive_bias_front(SaveWheelDrive)
				localplayer:get_current_vehicle():set_up_shift(SaveUpShift)
				localplayer:get_current_vehicle():set_down_shift(SaveDownShift)
				localplayer:get_current_vehicle():set_steering_lock(SaveSteerLock)
				localplayer:get_current_vehicle():set_drift_tyres_enabled(SaveDriftTyres)
				a5 = false
			end
		end

		function ToggleDriftMod(Enabled)
			if not localplayer:is_in_vehicle() then
				a1 = false
				return end
			if Enabled then
				driftmod_hotkey = menu.register_hotkey(18, DriftMod)
			else
				menu.remove_hotkey(driftmod_hotkey)
			end
		end

	--Nitrous Mod

				a6 = false
		function NitroBoost()
			if localplayer:is_in_vehicle() then
				if a6 == false then
					menu.send_key_press(201)
					menu.send_key_press(200)
					menu.send_key_press(69)
					a6 = true
				else
					menu.send_key_press(201)
					menu.send_key_press(200)
					a6 = false
				end
			end
		end

		function ToggleNitroBoost(Enabled)
			if not localplayer:is_in_vehicle() then
				a2 = false
				return end
			if Enabled then
				nitroboost_hotkey1 = menu.register_hotkey(16, NitroBoost)
			else
				menu.remove_hotkey(nitroboost_hotkey1)
			end
		end

	--Rainbow Mod -- thanks to Quad_Plex

			multiplier = 4
		function RainbowMod(color_red, color_green, color_blue)
			if (color_red > 0 and color_blue == 0 and color_green == 0 and not (color_red >= 255)) then
				color_red = color_red + 1 * multiplier
			elseif (color_red > 0 and color_blue == 0) then
				color_red = color_red - 1 * multiplier
				color_green = color_green + 1 * multiplier
			elseif (color_green > 0 and color_red == 0) then
				color_green = color_green - 1 * multiplier
				color_blue = color_blue + 1 * multiplier
			elseif (color_blue > 0 and color_green == 0) then
				color_red = color_red + 1 * multiplier
				color_blue = color_blue - 1 * multiplier
			else
				color_red = color_red + 1 * multiplier
				color_green = color_green - 1 * multiplier
				color_blue = color_blue - 1 * multiplier
			end
			color_red = math.max(0, math.min(255, color_red))
			color_green = math.max(0, math.min(255, color_green))
			color_blue = math.max(0, math.min(255, color_blue))
		return color_red, color_green, color_blue
		end

		function ColorChanger(vehicle, a3)
			red, green, blue = vehicle:get_custom_primary_colour()
			red, green, blue = a3(red, green, blue)
			vehicle:set_custom_primary_colour(red, green, blue)
			vehicle:set_custom_secondary_colour(red, green, blue)
		end

		function OnScriptsLoaded()
			while true do
				if a3 then
					vehicle = localplayer:get_current_vehicle()
					local function ApplyColor(a3)
						if vehicle then
							ColorChanger(vehicle, a3)
						end
							sleep(0.04)
						if not localplayer:is_in_vehicle() then
							a3 = false
						return false
						end
					return true
					end
					while a3 and ApplyColor(RainbowMod) do
					end
				end
			sleep(1)
			end
		end
	menu.register_callback('OnScriptsLoaded', OnScriptsLoaded)

	--Speedometer Mod -- thanks to Bababoiiiii

		function PlateSpeedometer()
			while a4 do
				if localplayer ~= nil and localplayer:is_in_vehicle() then
					vehicle = localplayer:get_current_vehicle()
					speedms = math.sqrt(vehicle:get_velocity().x^2 + vehicle:get_velocity().y^2 + vehicle:get_velocity().z^2)
					vehicle:set_number_plate_text(math.floor(speedms * 3.6)) -- replace 3.6 with 2.24 to get MPH instead of KPH
				end
			sleep(0.05)
			end
		end

	--Custom Mod

	CustomWheels = CustomModifications:add_submenu("Custom Wheels")

			F1Mode = false
			OldF1Hash = 0
	CustomWheels:add_toggle("F1 Wheels", function() return F1Mode end,
	function() F1Mode = not F1Mode
		if F1Mode then
			if localplayer ~= nil and localplayer:is_in_vehicle() then
				OldF1Hash = localplayer:get_current_vehicle():get_model_hash()
				localplayer:get_current_vehicle():set_model_hash(1492612435)
			end
		else
			if localplayer ~= nil and localplayer:is_in_vehicle() then
				localplayer:get_current_vehicle():set_model_hash(OldF1Hash)
			end
		end
	end)

			BennysMode = false
			OldBennysHash = 0
	CustomWheels:add_toggle("Benny's Wheels", function() return BennysMode end,
		function() BennysMode = not BennysMode
			if BennysMode then
				if localplayer ~= nil and localplayer:is_in_vehicle() then
					OldBennysHash = localplayer:get_current_vehicle():get_model_hash()
					localplayer:get_current_vehicle():set_model_hash(196747873)
				end
			else
				if localplayer ~= nil and localplayer:is_in_vehicle() then
					localplayer:get_current_vehicle():set_model_hash(OldBennysHash)
				end
			end
		end)

	CustomWheels:add_action("", function() end)

	CustomWheelsNote = CustomWheels:add_submenu("Read Me")

	CustomWheelsNote:add_action("    Enable which feature you want to use", function() end)
	CustomWheelsNote:add_action(" when you're in CEO Office Mod Shop and", function() end)
	CustomWheelsNote:add_action("      disable after purchasing the wheels", function() end)

	CustomPlate = CustomModifications:add_submenu("Custom Plate")

			PlateChars = {".", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}

			DefNum1 = PlateChars[1]
			DefNum1Cur = 1
	CustomPlate:add_array_item("Char #1", PlateChars, function() if localplayer ~= nil and localplayer:is_in_vehicle() then return DefNum1Cur end end,
		function(NewNum1) DefNum1 = PlateChars[NewNum1]
						   DefNum1Cur = NewNum1 end)

			DefNum2 = PlateChars[1]
			DefNum2Cur = 1
	CustomPlate:add_array_item("Char #2", PlateChars, function() if localplayer ~= nil and localplayer:is_in_vehicle() then return DefNum2Cur end end,
		function(NewNum2) DefNum2 = PlateChars[NewNum2]
						   DefNum2Cur = NewNum2 end)

			DefNum3 = PlateChars[1]
			DefNum3Cur = 1
	CustomPlate:add_array_item("Char #3", PlateChars, function() if localplayer ~= nil and localplayer:is_in_vehicle() then return DefNum3Cur end end,
		function(NewNum3) DefNum3 = PlateChars[NewNum3]
						  DefNum3Cur = NewNum3 end)

			DefNum4 = PlateChars[1]
			DefNum4Cur = 1
	CustomPlate:add_array_item("Char #4", PlateChars, function() if localplayer ~= nil and localplayer:is_in_vehicle() then return DefNum4Cur end end,
		function(NewNum4) DefNum4 = PlateChars[NewNum4]
						  DefNum4Cur = NewNum4 end)

			DefNum5 = PlateChars[1]
			DefNum5Cur = 1
	CustomPlate:add_array_item("Char #5", PlateChars, function() if localplayer ~= nil and localplayer:is_in_vehicle() then return DefNum5Cur end end,
		function(NewNum5) DefNum5 = PlateChars[NewNum5]
						  DefNum5Cur = NewNum5 end)

			DefNum6 = PlateChars[1]
			DefNum6Cur = 1
	CustomPlate:add_array_item("Char #6", PlateChars, function() if localplayer ~= nil and localplayer:is_in_vehicle() then return DefNum6Cur end end,
		function(NewNum6) DefNum6 = PlateChars[NewNum6]
						  DefNum6Cur = NewNum6 end)

			DefNum7 = PlateChars[1]
			DefNum7Cur = 1
	CustomPlate:add_array_item("Char #7", PlateChars, function() if localplayer ~= nil and localplayer:is_in_vehicle() then return DefNum7Cur end end,
		function(NewNum7) DefNum7 = PlateChars[NewNum7]
						  DefNum7Cur = NewNum7 end)

			DefNum8 = PlateChars[1]
			DefNum8Cur = 1
	CustomPlate:add_array_item("Char #8", PlateChars, function() if localplayer ~= nil and localplayer:is_in_vehicle() then return DefNum8Cur end end,
		function(NewNum8) DefNum8 = PlateChars[NewNum8]
					      DefNum8Cur = NewNum8 end)

		local function CheckPlate(IfSpace)
			if IfSpace == "." then return " "
			else return IfSpace
			end
		end

	CustomPlate:add_bare_item("", function()
		return "Apply Plate: " .. CheckPlate(DefNum1) .. CheckPlate(DefNum2) .. CheckPlate(DefNum3) .. CheckPlate(DefNum4) .. CheckPlate(DefNum5) .. CheckPlate(DefNum6) .. CheckPlate(DefNum7) .. CheckPlate(DefNum8)
		end,
		function()
			if localplayer ~= nil and localplayer:is_in_vehicle() then
				localplayer:get_current_vehicle():set_number_plate_text(DefNum1 .. DefNum2 .. DefNum3 .. DefNum4 .. DefNum5 .. DefNum6 .. DefNum7 .. DefNum8)
			end
		end, function() end, function() end)

	CustomPlate:add_action("", function() end)

	CustomPlateNote = CustomPlate:add_submenu("Read Me")

	CustomPlateNote:add_action("                        «.» = space", function() end)
	CustomPlateNote:add_action("", function() end)
	CustomPlateNote:add_action("      Use in LSC and buy a plate to save", function() end)

--End-