extends ExceedGutTest

func who_am_i():
	return "vega"

## Character ability: If you are at the edge of the arena when you set your
##     attack, your Specials and Ultras have +0/2/0 (+0/3/1 when exceeded).

func test_vega_ua_normal():
	position_players(player1, 1, player2, 2)
	execute_strike(player1, player2, "standard_normal_sweep", "standard_normal_sweep")
	# Expected: Power bonus does not apply to Normals.
	validate_positions(player1, 1, player2, 2)
	validate_life(player1, 24, player2, 24)

func test_vega_ua_exceeded_normal():
	position_players(player1, 1, player2, 2)
	player1.exceed()
	execute_strike(player1, player2, "standard_normal_sweep", "standard_normal_sweep")
	# Expected: Power bonus does not apply to Normals
	validate_positions(player1, 1, player2, 2)
	validate_life(player1, 24, player2, 24)

func test_vega_ua_special():
	position_players(player1, 1, player2, 2)
	execute_strike(player1, player2, "vega_scarletterror", "standard_normal_sweep")
	# Expected: Scarlet Terror hits for 3 + 2 (UA) = 5
	validate_positions(player1, 1, player2, 2)
	validate_life(player1, 24, player2, 25)

func test_vega_ua_exceeded_special():
	position_players(player1, 1, player2, 2)
	player1.exceed()
	execute_strike(player1, player2, "vega_scarletterror", "standard_normal_assault")
	# Expected: Scarlet Terror outspeeds Assault at 4 + 1 = 5 (XA)
	#           Scarlet Terror hits for 3 + 3 (XA) = 6
	validate_positions(player1, 1, player2, 2)
	validate_life(player1, 30, player2, 24)

## Bloody High Claw (1~2/4/6) -- Before: If there are 3 or more spaces behind
##     the opponent, +3 POW. Hit: Move up to 8.

func test_vega_bloodyhigh_2_spaces_playerright():
	position_players(player1, 4, player2, 3)
	var p1_gauge = give_gauge(player1, 3)
	execute_strike(player1, player2, "vega_bloodyhighclaw", "standard_normal_sweep",
			false, false, [[], p1_gauge, 9], [])  # Decline Critical, pay for Ultra, move to space 9 on hit
	# Expected: Bloody High Claw hits for 4 (only 2 spaces behind opponent)
	validate_positions(player1, 9, player2, 3)
	validate_life(player1, 30, player2, 26)

func test_vega_bloodyhigh_3_spaces_playerright():
	position_players(player1, 5, player2, 4)
	var p1_gauge = give_gauge(player1, 3)
	execute_strike(player1, player2, "vega_bloodyhighclaw", "standard_normal_sweep",
			false, false, [[], p1_gauge, 1], [])  # Decline Critical, pay for Ultra, move to space 1 on hit
	# Expected: Bloody High Claw hits for 4 + 3 = 7 (3+ spaces behind opponent)
	#           Sweep is stunned out
	validate_positions(player1, 1, player2, 4)
	validate_life(player1, 30, player2, 23)

func test_vega_bloodyhigh_2_spaces_playerleft():
	position_players(player1, 6, player2, 7)
	var p1_gauge = give_gauge(player1, 3)
	execute_strike(player1, player2, "vega_bloodyhighclaw", "standard_normal_sweep",
			false, false, [[], p1_gauge, 9], [])  # Decline Critical, pay for Ultra, move to space 9 on hit
	# Expected: Bloody High Claw hits for 4 (only 2 spaces behind opponent)
	#           Sweep retaliates for 6.
	validate_positions(player1, 9, player2, 7)
	validate_life(player1, 24, player2, 26)
	advance_turn(player2)

func test_vega_bloodyhigh_3_spaces_playerleft():
	position_players(player1, 5, player2, 6)
	var p1_gauge = give_gauge(player1, 3)
	execute_strike(player1, player2, "vega_bloodyhighclaw", "standard_normal_sweep",
			false, false, [[], p1_gauge, 0])  # Decline Critical, pay for Ultra, decline move
	# Expected: Bloody High Claw hits for 4 + 3 = 7 (3+ spaces behind opponent)
	#           Sweep is stunned out
	validate_positions(player1, 5, player2, 6)
	validate_life(player1, 30, player2, 23)
	advance_turn(player2)

## Scarlet Terror boost -- (2 Force) If you are at the edge of the arena, move
##     to any space and Strike. You get your ability's bonuses during this
##     Strike.

func test_vega_scarletterror_boost():
	position_players(player1, 1, player2, 6)
	var terror_id = give_player_specific_card(player1, "vega_scarletterror")
	assert_true(game_logic.do_boost(player1, terror_id, get_cards_from_hand(player1, 2)))
	assert_true(game_logic.do_choice(player1, select_space(5)))
	validate_positions(player1, 5, player2, 6)

	var p1_gauge = give_gauge(player1, 3)
	execute_strike(player1, player2, "vega_bloodyhighclaw", "standard_normal_focus",
			false, false, [[], p1_gauge, 0], [])  # Decline Critical, pay for Ultra, decline move
	# Expected: Bloody High Claw hits for
	#     4 + 3 (3 spaces behind opp.) + 2 (Scarlet Terror gets ability bonus) - 2 (Focus Armor) = 7
	validate_positions(player1, 5, player2, 6)
	validate_life(player1, 30, player2, 23)
	advance_turn(player2)


func test_vega_scarletterror_boost_exceeded():
	position_players(player1, 1, player2, 6)
	player1.exceed()
	var terror_id = give_player_specific_card(player1, "vega_scarletterror")
	assert_true(game_logic.do_boost(player1, terror_id, get_cards_from_hand(player1, 2)))
	assert_true(game_logic.do_choice(player1, select_space(5)))
	validate_positions(player1, 5, player2, 6)

	var p1_gauge = give_gauge(player1, 3)
	execute_strike(player1, player2, "vega_bloodyhighclaw", "standard_normal_cross",
			false, true, [[], p1_gauge, 0], [])  # Decline Critical, pay for Ultra, decline move
	# Move up to 8
	validate_positions(player1, 5, player2, 6)
	# Total power of 4 + 3 + ua 3 = 10, -1 armor for ex = 21
	validate_life(player1, 30, player2, 21)
	advance_turn(player2)


func test_vega_scarletterror_boost_exceeded_no_difference_edge():
	position_players(player1, 1, player2, 7)
	player1.exceed()
	var terror_id = give_player_specific_card(player1, "vega_scarletterror")
	assert_true(game_logic.do_boost(player1, terror_id, get_cards_from_hand(player1, 2)))
	assert_true(game_logic.do_choice(player1, select_space(9)))
	validate_positions(player1, 9, player2, 7)

	var p1_gauge = give_gauge(player1, 3)
	execute_strike(player1, player2, "vega_bloodyhighclaw", "standard_normal_cross",
			false, true, [[], p1_gauge, 0], [])  # Decline Critical, pay for Ultra, decline move
	# Move up to 8
	validate_positions(player1, 9, player2, 7)
	# Expected: Total power of 4 + 3 + ua 3 = 10, -1 armor for ex = 21
	#     i.e. checking that the UA doesn't apply twice (once from UA, once from Terror)
	validate_life(player1, 30, player2, 21)
	advance_turn(player2)


func test_vega_scarletterror_boost_default_edge_normal():
	position_players(player1, 1, player2, 7)
	var terror_id = give_player_specific_card(player1, "vega_scarletterror")
	assert_true(game_logic.do_boost(player1, terror_id, get_cards_from_hand(player1, 2)))
	assert_true(game_logic.do_choice(player1, select_space(9)))
	validate_positions(player1, 9, player2, 7)

	execute_strike(player1, player2, "standard_normal_cross", "standard_normal_cross")
	validate_positions(player1, 9, player2, 7)
	# Expected: Scarlet Terror causes the UA power bonus to apply to Cross even
	#     though it's a Normal
	validate_life(player1, 30, player2, 25)
	advance_turn(player2)

func test_vega_scarletterror_boost_exceeded_edge_normal():
	position_players(player1, 1, player2, 7)
	player1.exceed()
	var terror_id = give_player_specific_card(player1, "vega_scarletterror")
	assert_true(game_logic.do_boost(player1, terror_id, get_cards_from_hand(player1, 2)))
	assert_true(game_logic.do_choice(player1, select_space(9)))
	validate_positions(player1, 9, player2, 7)

	execute_strike(player1, player2, "standard_normal_assault", "standard_normal_cross")
	# Expected: Scarlet Terror causes the UA power and speed bonuses to apply to
	#     Assault even though it's a Normal
	validate_positions(player1, 8, player2, 7)
	validate_life(player1, 30, player2, 23)
	advance_turn(player1)  # P1 has advantage

## Sky High Claw boost -- (1 Force) Move 3. If you moved past the opponent, put
##     a Continuous Boost from your discard into play.

func test_vega_skyhighclaw_boost_miss():
	position_players(player1, 1, player2, 7)
	var bhc_id = give_player_specific_card(player1, "vega_bloodyhighclaw")
	player1.discard_hand()
	player1.draw(3)

	var shc_id = give_player_specific_card(player1, "vega_skyhighclaw")
	assert_true(game_logic.do_boost(player1, shc_id, get_cards_from_hand(player1, 1)))
	assert_true(game_logic.do_choice(player1, 0)) # Advance 3
	validate_positions(player1, 4, player2, 7)
	# No further action since Vega didn't move past the opponent
	advance_turn(player2)
	assert_eq(player1.continuous_boosts.size(), 0)

func test_vega_skyhighclaw_boost_doit():
	position_players(player1, 5, player2, 7)
	var bhc_id = give_player_specific_card(player1, "vega_bloodyhighclaw")
	player1.discard_hand()
	player1.draw(3)

	var shc_id = give_player_specific_card(player1, "vega_skyhighclaw")
	assert_true(game_logic.do_boost(player1, shc_id, get_cards_from_hand(player1, 1)))
	assert_true(game_logic.do_choice(player1, 0)) # Advance 3
	validate_positions(player1, 9, player2, 7)
	assert_true(game_logic.do_boost(player1, bhc_id))  # P1 is allowed to boost now
	assert_eq(player1.continuous_boosts.size(), 1)
	assert_eq(player1.continuous_boosts[0].id, bhc_id)
	advance_turn(player2)  # No further action from P1 (does not have to pay BHC Force costs)

# func test_vega_rollingcrystalflash_boost_miss():
# 	position_players(player1, 1, player2, 7)
# 	give_player_specific_card(player1, "vega_rollingcrystalflash", TestCardId2)
# 	assert_true(game_logic.do_boost(player1, TestCardId2))
# 	# Advance or retreat 3.
# 	assert_true(game_logic.do_choice(player1, 0)) # Advance 3
# 	validate_positions(player1, 4, player2, 7)
# 	assert_eq(player1.gauge.size(), 0)
# 	advance_turn(player2)

# func test_vega_rollingcrystalflash_boost_doit():
# 	position_players(player1, 4, player2, 7)
# 	give_player_specific_card(player1, "vega_rollingcrystalflash", TestCardId2)
# 	assert_true(game_logic.do_boost(player1, TestCardId2))
# 	# Advance or retreat 3.
# 	assert_true(game_logic.do_choice(player1, 0)) # Advance 3
# 	validate_positions(player1, 8, player2, 7)
# 	assert_eq(player1.gauge.size(), 1)
# 	assert_eq(player1.gauge[0].id, TestCardId2)
# 	advance_turn(player2)

# func test_vega_rollingcrystalflash_speedboost_tooslow():
# 	position_players(player1, 4, player2, 7)
# 	execute_strike(player1, player2, "vega_rollingcrystalflash", "standard_normal_assault", [], [], false, false, [], [], 0, false, false)
# 	# Flash is speed 2 + 2 < 5
# 	validate_positions(player1, 4, player2, 5)
# 	validate_life(player1, 26, player2, 30)
# 	advance_turn(player2)

# func test_vega_rollingcrystalflash_speedboost_justright():
# 	position_players(player1, 3, player2, 7)
# 	execute_strike(player1, player2, "vega_rollingcrystalflash", "standard_normal_assault", [], [], false, false, [], [], 0, false, false)
# 	# Flash is speed 2 + 3 = 5
# 	validate_positions(player1, 6, player2, 9)
# 	validate_life(player1, 30, player2, 27)
# 	advance_turn(player2)

# func test_vega_rollingcrystalflash_weirdinteraction_nanase():
# 	position_players(player1, 5, player2, 9)
# 	give_gauge(player2, 4)
# 	# Lumiere misses since rolling crystal is back to speed 2 by the time it hits.
# 	execute_strike(player1, player2, "vega_rollingcrystalflash", "nanase_lumiereofthedawn", [], [], false, false, [], [player2.gauge[0].id], 0, false, true)
# 	validate_positions(player1, 8, player2, 9)
# 	validate_life(player1, 30, player2, 30)
# 	assert_eq(player1.gauge.size(), 1)
# 	assert_eq(player2.gauge.size(), 0)
# 	advance_turn(player2)
