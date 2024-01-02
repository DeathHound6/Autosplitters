// New pointers by Mysterion_06_ & code remodification by Ero
// Parkour Fever by DeathHound6

state("DyingLightGame")
{
    int start : "gamedll_x64_rwdi.dll", 0x1CF8050;
    int loading: "rd3d11_x64_rwdi.dll", 0x7E048;

    // Parkour Fever stuff - ILs
    int pfState : "gamedll_x64_rwdi.dll", 0x01C39930, 0x2F58;
    int pfCheckpointNum : "gamedll_x64_rwdi.dll", 0x1C39930, 0x2F50;
    int pfCheckpointMax : "gamedll_x64_rwdi.dll", 0x01C10AC0, 0x20, 0x70, 0x0, 0x10, 0x48, 0x158;
    float pfTimeCurrent : "gamedll_x64_rwdi.dll", 0x01C10AC0, 0x20, 0x70, 0x0, 0x10, 0x48, 0xF0;
    float pfTimeLast : "gamedll_x64_rwdi.dll", 0x01C10AC0, 0x20, 0x70, 0x0, 0x10, 0x48, 0x1CC;
}

startup
{
    settings.Add("pf", false, "Parkour Fever");
}

start
{
    if (settings["pf"])
        // state 5 is countdown timer, state 7 is running
        return old.pfState == 5 && current.pfState == 7;
    return old.start != 2 && current.start == 2;
}

split
{
    // If state is playing or loading 1 (when won/lost)
    if (settings["pf"] && (current.pfState == 1 || current.pfState == 2 || current.pfState == 7 || current.pfState == 11))
        return old.pfCheckpointNum < current.pfCheckpointNum ||
            (current.pfCheckpointNum == current.pfCheckpointMax && old.pfCheckpointNum != current.pfCheckpointMax);
}

isLoading
{
    return current.loading == 240;
}

gameTime
{
    // If pf is enabled and pf state is not Out of Challenge
    if (settings["pf"] && current.pfState != 4294967295)
    {
        float time = current.pfTimeCurrent;
        // If we have just hit the last checkpoint and `current` time has already been reset, use the value of `last`
        if (time == 0f && current.pfCheckpointNum == current.pfCheckpointMax)
            time = current.pfTimeLast;
        // Round the value down to 2dp (rounding down)
        time = (float)Math.Floor(time * 100) / 100;
        return TimeSpan.FromSeconds(time);
    }
}
