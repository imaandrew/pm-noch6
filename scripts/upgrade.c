#include "world/area_flo/flo_08/flo_08.h"


EvtScript lol = {
    EVT_IF_EQ(EVT_SAVE_FLAG(1402), 1)
        EVT_RETURN
    EVT_END_IF
    EVT_CALL(IsStartingConversation, EVT_VAR(0))
    EVT_IF_EQ(EVT_VAR(0), 1)
        EVT_RETURN
    EVT_END_IF
    EVT_CALL(0x80740D08)
    EVT_IF_EQ(EVT_VAR(0), 1)
        EVT_RETURN
    EVT_END_IF
    EVT_CALL(ModifyGlobalOverrideFlags, 1, 2097152)
    EVT_CALL(0x80740000)
    EVT_CALL(DisablePlayerInput, TRUE)
    EVT_CALL(DisablePartnerAI, 0)
    EVT_CALL(SetNpcFlagBits, NPC_PARTNER, ((NPC_FLAG_100)), TRUE)
    EVT_CALL(0x80740480, EVT_MAP_VAR(0), EVT_VAR(9))
    EVT_CALL(FindKeyItem, ITEM_ULTRA_STONE, EVT_VAR(12))
    EVT_CALL(0x80740120)
    EVT_IF_EQ(EVT_VAR(0), -1)
        EVT_CALL(ShowMessageAtScreenPos, MESSAGE_ID(0x1D, 0x00DC), 160, 40)
        EVT_WAIT_FRAMES(10)
        EVT_CALL(0x80740510, EVT_VAR(9))
        EVT_CALL(DisablePlayerInput, FALSE)
        EVT_CALL(EnablePartnerAI)
        EVT_CALL(ModifyGlobalOverrideFlags, 0, 2097152)
        EVT_CALL(0x8074001C)
        EVT_RETURN
    EVT_END_IF
    EVT_IF_EQ(EVT_SAVE_FLAG(438), 0)
        EVT_SET(EVT_SAVE_FLAG(438), 1)
        EVT_CALL(ShowMessageAtScreenPos, MESSAGE_ID(0x1D, 0x00DA), 160, 40)
    EVT_ELSE
        EVT_CALL(ShowMessageAtScreenPos, MESSAGE_ID(0x1D, 0x00DB), 160, 40)
    EVT_END_IF
    EVT_CALL(0x807401CC)
    EVT_IF_EQ(EVT_VAR(0), -1)
        EVT_CALL(0x80740510, EVT_VAR(9))
        EVT_CALL(DisablePlayerInput, FALSE)
        EVT_CALL(EnablePartnerAI)
        EVT_CALL(ModifyGlobalOverrideFlags, 0, 2097152)
        EVT_CALL(0x8074001C)
        EVT_RETURN
    EVT_END_IF
    EVT_SET(EVT_VAR(10), EVT_VAR(0))
    EVT_SET(EVT_VAR(11), EVT_VAR(1))
    EVT_CALL(EnablePartnerAI)
    EVT_CALL(GetCurrentPartnerID, EVT_VAR(0))
    EVT_IF_NE(EVT_VAR(0), EVT_VAR(11))
        EVT_CALL(0x8074041C, EVT_VAR(11))
    EVT_ELSE
        EVT_CALL(func_802CF56C, 2)
    EVT_END_IF
    EVT_WAIT_FRAMES(10)
    EVT_CALL(ShowMessageAtScreenPos, MESSAGE_ID(0x1D, 0x00DF), 160, 40)
    EVT_CALL(ShowChoice, MESSAGE_ID(0x1E, 0x000D))
    EVT_CALL(CloseMessage)
    EVT_IF_NE(EVT_VAR(0), 0)
        EVT_CALL(0x80740510, EVT_VAR(9))
        EVT_CALL(DisablePlayerInput, FALSE)
        EVT_CALL(EnablePartnerAI)
        EVT_CALL(ModifyGlobalOverrideFlags, 0, 2097152)
        EVT_CALL(0x8074001C)
        EVT_RETURN
    EVT_END_IF
    EVT_CALL(0x80740068, EVT_VAR(11), EVT_VAR(13))
    EVT_SET(EVT_SAVE_FLAG(1402), 1)
    EVT_CALL(0x80740510, EVT_VAR(9))
    EVT_CALL(0x80740448)
    EVT_IF_EQ(EVT_VAR(13), 1)
        EVT_CALL(ShowMessageAtScreenPos, MESSAGE_ID(0x1D, 0x00DD), 160, 40)
    EVT_ELSE
        EVT_CALL(ShowMessageAtScreenPos, MESSAGE_ID(0x1D, 0x00DE), 160, 40)
    EVT_END_IF
    EVT_CALL(DisablePlayerInput, FALSE)
    EVT_CALL(EnablePartnerAI)
    EVT_CALL(ModifyGlobalOverrideFlags, 0, 2097152)
    EVT_CALL(0x8074001C)
    EVT_RETURN
    EVT_END
};
