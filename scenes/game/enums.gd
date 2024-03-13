extends Node

enum PlayerId {
	PlayerId_Player,
	PlayerId_Opponent,
	PlayerId_Unassigned,
}

enum CardZone {
	CardZone_PlayerHand,
	CardZone_PlayerGauge,
	CardZone_PlayerBoosts,
	CardZone_OpponentHand,
	CardZone_OpponentGauge,
	CardZone_OpponentBoosts,
}

enum DecisionType {
	DecisionType_None,
	DecisionType_BoostCancel,
	DecisionType_BoostNow,
	DecisionType_ChooseArenaLocationForEffect,
	DecisionType_ChooseDiscardContinuousBoost,
	DecisionType_ChooseDiscardOpponentGauge,
	DecisionType_ChooseFromBoosts,
	DecisionType_ChooseFromDiscard,
	DecisionType_ChooseFromTopDeck,
	DecisionType_ChooseSimultaneousEffect,
	DecisionType_EffectChoice,
	DecisionType_ForceBoostSustainTopdeck,
	DecisionType_ForceBoostSustainTopDiscard,
	DecisionType_ForceForEffect,
	DecisionType_GaugeForEffect,
	DecisionType_NameCard_OpponentDiscards,
	DecisionType_ChooseToDiscard,
	DecisionType_PayStrikeCost_Required,
	DecisionType_PayStrikeCost_CanWild,
	DecisionType_PickNumberFromRange,
	DecisionType_ForceForArmor,
	DecisionType_CardFromHandToGauge,
	DecisionType_ReadingNormal,
	DecisionType_Sidestep,
	DecisionType_StrikeNow,
	DecisionType_ZeroVector,
}

enum GameState {
	GameState_AutoStrike,
	GameState_NotStarted,
	GameState_Boost_Processing,
	GameState_GameOver,
	GameState_PickAction,
	GameState_DiscardDownToMax,
	GameState_Mulligan,				#6
	GameState_WaitForStrike,
	GameState_PlayerDecision,
	GameState_Strike_Opponent_Response,
	GameState_Strike_Opponent_Set_First,
	GameState_Strike_Processing,
}

enum GameOverReason {
	GameOverReason_Life,
	GameOverReason_Decked,
	GameOverReason_Disconnect,
	GameOverReason_Quit,
}

enum EventType {
	EventType_AddToGauge,
	EventType_AddToDiscard,
	EventType_AddToDeck,
	EventType_AddToHand,
	EventType_AddToOverdrive,
	EventType_AdvanceTurn,
	EventType_BecomeWide,
	EventType_BlockMovement,
	EventType_Boost_ActionAfterBoost,
	EventType_Boost_CancelDecision,
	EventType_Boost_DiscardContinuousChoice,
	EventType_Boost_DiscardOpponentGauge,
	EventType_Boost_Played,
	EventType_Boost_Canceled,
	EventType_Boost_Continuous_Added,
	EventType_Boost_NameCardOpponentDiscards,
	EventType_Boost_Sidestep,
	EventType_Boost_ZeroVector,
	EventType_CardFromHandToGauge_Choice,
	EventType_ChangeCards,
	EventType_CharacterAction,
	EventType_ChooseArenaLocationForEffect,
	EventType_ChooseFromBoosts,
	EventType_ChooseFromDiscard,
	EventType_ChooseFromTopDeck,
	EventType_ChooseOpponentCardToDiscard,
	EventType_Draw,
	EventType_Emote,
	EventType_EffectDoBoost,
	EventType_Exceed,
	EventType_ExceedRevert,
	EventType_ForceForEffect,
	EventType_GaugeForEffect,
	EventType_ForceStartBoost,
	EventType_ForceStartStrike,
	EventType_GameOver,
	EventType_HandSizeExceeded,
	EventType_Move,
	EventType_MulliganDecision,
	EventType_PickNumberFromRange,
	EventType_PlaceBuddy,
	EventType_PlaceCardUnderBoost,
	EventType_PlaceLightningRod,
	EventType_Prepare,
	EventType_ReadingNormal,
	EventType_ReshuffleDeck,
	EventType_ReshuffleDeck_Mulligan,
	EventType_ReshuffleDiscard,
	EventType_ReshuffleDiscardInPlace,
	EventType_RevealCard,
	EventType_RevealHand,
	EventType_RevealRandomGauge,
	EventType_RevealStrike_OnePlayer,
	EventType_RevealTopDeck,
	EventType_Seal,
	EventType_SetCardAside,
	EventType_Strike_ArmorUp,
	EventType_Strike_AttackDoesNotHit,
	EventType_Strike_CardActivation,
	EventType_Strike_CharacterEffect,
	EventType_Strike_Critical,
	EventType_Strike_DodgeAttacks,
	EventType_Strike_DodgeAttacksAtRange,
	EventType_Strike_DodgeFromOppositeBuddy,
	EventType_Strike_DoResponseNow,
	EventType_Strike_EffectChoice,
	EventType_Strike_EffectDoStrike,
	EventType_Strike_ExUp,
	EventType_Strike_ForceForArmor,
	EventType_Strike_ForceWildSwing,
	EventType_Strike_FromGauge,
	EventType_Strike_GainAdvantage,
	EventType_Strike_GainLife,
	EventType_Strike_GuardUp,
	EventType_Strike_IgnoredPushPull,
	EventType_Strike_Miss,
	EventType_Strike_ChooseToDiscard,
	EventType_Strike_ChooseToDiscard_Info,
	EventType_Strike_Cleanup,
	EventType_Strike_OpponentCantMovePast,
	EventType_Strike_OpponentSetsFirst,
	EventType_Strike_OpponentSetsFirst_DefenderSet,
	EventType_Strike_OpponentSetsFirst_InitiatorSet,
	EventType_Strike_PayCost_Gauge,
	EventType_Strike_PayCost_Force,
	EventType_Strike_PayCost_Unable,
	EventType_Strike_PowerUp,
	EventType_Strike_RandomGaugeStrike,
	EventType_Strike_RangeUp,
	EventType_Strike_Response,
	EventType_Strike_Response_Ex,
	EventType_Strike_Reveal,
	EventType_Strike_SpeedUp,
	EventType_Strike_SetX,
	EventType_Strike_Started,
	EventType_Strike_Started_Ex,
	EventType_Strike_Started_ExtraAttack,
	EventType_Strike_Stun,
	EventType_Strike_Stun_Immunity,
	EventType_Strike_TookDamage,
	EventType_Strike_WildStrike,
	EventType_SustainBoost,
	EventType_SwapSealedAndDeck,
}

enum LogType {
	LogType_CardInfo,
	LogType_CharacterMovement,
	LogType_Effect,
	LogType_Health,
	LogType_Action,
	LogType_Strike,
	LogType_Default
}
