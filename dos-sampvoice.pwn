#include <a_samp>
#include <sampvoice>

#define X11_GREEN                   0x00FF00AA

main() {}

new SV_LSTREAM:lstream[MAX_PLAYERS] = { SV_NULL, ... };

public SV_VOID:OnPlayerActivationKeyPress(SV_UINT:playerid, SV_UINT:keyid) 
{
	if (keyid == 0x42)
	{
		if (lstream[playerid])
		{
			SvAttachSpeakerToStream(lstream[playerid], playerid);
			SendClientMessage(playerid, X11_GREEN, "{FF3300}[SAMPVOICE] {FFFFFF}คุณกำลังพูดอยู่บน {FFD700}(พื้นที่ใกล้เคียง)");
		}
	}
}

public SV_VOID:OnPlayerActivationKeyRelease(SV_UINT:playerid, SV_UINT:keyid) 
{
	if (keyid == 0x42)
	{
		if (lstream[playerid])
		{
			SvDetachSpeakerFromStream(lstream[playerid], playerid);
		}
	}
}

public OnPlayerConnect(playerid) 
{
	if (!SvGetVersion(playerid))
	{
		SendClientMessage(playerid, -1, "{FF3300}[SAMPVOICE] {FFD700}คุณไม่ได้ติดตั้งส่วนเสริม");
	}
	else if (!SvHasMicro(playerid))
	{
		SendClientMessage(playerid, -1, "{FF3300}[SAMPVOICE] {FFD700}คุณไม่มีไมค์");
	}
	else if ((lstream[playerid] = SvCreateDLStreamAtPlayer(40.0, SV_INFINITY, playerid, -1, "Local")))
	{ 
		SendClientMessage(playerid, -1, "{FF3300}[SAMPVOICE] {FFD700}กด B เพื่อพูดคุย");
		SvAddKey(playerid, 0x42);
	}
	return 1;
	
}

public OnPlayerDisconnect(playerid, reason) 
{
	if (lstream[playerid])
	{
		SvDeleteStream(lstream[playerid]);
		lstream[playerid] = SV_NULL;
	}
	return 1;
	
}
