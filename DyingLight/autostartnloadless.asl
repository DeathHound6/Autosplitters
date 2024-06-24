// New pointers by Mysterion_06_ & code remodification by Ero
// Parkour Fever by DeathHound6

state("DyingLightGame", "Epic Games")
{
    int start : "gamedll_x64_rwdi.dll", 0x1CF8050;
    int loading: "rd3d11_x64_rwdi.dll", 0x7E048;

    // Parkour Fever stuff - ILs
    int pfState : "gamedll_x64_rwdi.dll", 0x01C39930, 0x2F58;
    uint pfCheckpointNum : "gamedll_x64_rwdi.dll", 0x1C39930, 0x2F50;
    uint pfCheckpointMax : "gamedll_x64_rwdi.dll", 0x01C10AC0, 0x20, 0x70, 0x0, 0x10, 0x48, 0x158;
    float pfTimeCurrent : "gamedll_x64_rwdi.dll", 0x01C10AC0, 0x20, 0x70, 0x0, 0x10, 0x48, 0xF0;
    float pfTimeLast : "gamedll_x64_rwdi.dll", 0x01C10AC0, 0x20, 0x70, 0x0, 0x10, 0x48, 0x1CC;
}

state("DyingLightGame", "Steam")
{
    int start : "gamedll_x64_rwdi.dll", 0x1CF8050;
    int loading: "rd3d11_x64_rwdi.dll", 0x7E048;

    // base game - both pointers resolve to same address
    uint mainPercent: "engine_x64_rwdi.dll", 0xA401D8, 0x560, 0x0, 0x10, 0x10, 0x10, 0x0, -0x10;
    // uint mainPercent: "engine_x64_rwdi.dll", 0xA401E8, 0x560, 0x0, 0x10, 0x10, 0x10, 0x0, -0x10;

    // Parkour Fever stuff - ILs
    int pfState : "gamedll_x64_rwdi.dll", 0x01BAFA68, 0xE00, 0x0, 0x2F58;
    uint pfCheckpointNum : "gamedll_x64_rwdi.dll", 0x01BAFA68, 0xE00, 0x0, 0x2F50;
    uint pfCheckpointMax : "gamedll_x64_rwdi.dll", 0x01BAFA68, 0xF90, 0x30, 0x30, 0x30, 0x20, 0x158;
    float pfTimeCurrent : "gamedll_x64_rwdi.dll", 0x01BAFA68, 0xF90, 0x30, 0x30, 0x30, 0x20, 0xF0;
    float pfTimeLast : "gamedll_x64_rwdi.dll", 0x01BAFA68, 0xF90, 0x30, 0x30, 0x30, 0x20, 0x1CC;
}

init
{
    byte[] checksum = vars.CalcModuleHash(modules.First());
    if (Enumerable.SequenceEqual(checksum, vars.steamHash))
        version = "Steam";
    else if (Enumerable.SequenceEqual(checksum, vars.epicHash))
        version = "Epic Games";
    else
        version = "Unknown";
    print("Version found: " + version);
}

startup
{
    settings.Add("bg", false, "Main Game");
    settings.Add("first_assignment", false, "First Assignment", "bg");
    settings.Add("gre1", false, "GRE Call", "first_assignment");
    settings.Add("tower1", false, "Tower Meeting", "first_assignment");
    settings.Add("airdrop", false, "Airdrop", "bg");
    settings.Add("airdrop1", false, "Airdrop 1", "airdrop");
    settings.Add("airdrop2", false, "Real Airdrop", "airdrop");
    settings.Add("tower2", false, "Return to Tower", "airdrop");
    settings.Add("tower3", false, "Tower Meeting", "airdrop");
    settings.Add("pact", false, "Pact With Rais", "bg");
    settings.Add("tower4", false, "Go Downstairs", "pact");
    settings.Add("talk1", false, "Talk to Karim", "pact");
    settings.Add("garrison", false, "Return to Rais' Garrison (after Antennas)", "pact");
    settings.Add("talk2", false, "Talk to Karim again", "pact");
    settings.Add("talk3", false, "Talk to Gursel", "pact");
    settings.Add("patrol", false, "Collect note from missing patrol", "pact");
    settings.Add("tower5", false, "Return to Tower", "pact");
    settings.Add("jade1", false, "Listen to Jade talk about the school", "pact");
    settings.Add("siblings", false, "Siblings", "bg");
    settings.Add("enter1", false, "Enter School", "siblings");
    settings.Add("thugs1", false, "Kill Rais' thugs (upstairs)", "siblings");
    settings.Add("thugs2", false, "Kill Rais' thugs (basement)", "siblings");
    settings.Add("leave1", false, "Leave school", "siblings");
    settings.Add("tower6", false, "Return to Tower", "siblings");
    settings.Add("talk4", false, "Talk to Zere", "siblings");
    settings.Add("talk5", false, "Talk to Quartermaster", "siblings");
    settings.Add("talk6", false, "Give Zere bolter tissue", "siblings");
    settings.Add("enter2", false, "Enter trainyard", "siblings");
    settings.Add("talk7", "Talk to Brecken (radio)", "siblings");
    settings.Add("pit", false, "The Pit", "bg");
    settings.Add("talk8", false, "Talk to Brecken", "pit");
    settings.Add("zere1", false, "Protect Zere's trailer", "pit");
    settings.Add("enter3", false, "Enter Rai's Garrison", "pit");
    settings.Add("zere2", false, "Find Zere", "pit");
    settings.Add("hand", false, "Cut Rais' hand off", "pit");
    settings.Add("leave2", false, "Leave the Pit", "pit");
    settings.Add("seizure1", false, "Pass out from seizure", "pit");
    settings.Add("stash1", false, "Open Stash", "pit");
    settings.Add("saviors", false, "The Saviors", "bg");
    settings.Add("enter4", false, "Enter Sewers", "saviors");
    settings.Add("talk8", false, "Talk to Saviors", "saviors");
    settings.Add("ambush", false, "Survive ambush", "saviors");
    settings.Add("leave3", false, "Exit Sewers", "saviors");
    settings.Add("enter5", false, "Enter Old Town", "saviors");
    settings.Add("education", false, "Higher Education", "bg");
    settings.Add("embers", false, "Meet Troy and Savvy", "education");
    settings.Add("uni", false, "Reach University", "education");
    settings.Add("talk9", false, "Talk to Fidan", "education");
    settings.Add("talk10", false, "Talk to Troy and Savvy", "education");
    // settings.Add("");

    settings.Add("pf", false, "Parkour Fever");

    vars.steamHash = new byte[] { 0xC8, 0xFA, 0x97, 0x96, 0xC7, 0xE0, 0xF4, 0x6C, 0x9B, 0xD7, 0x7B, 0x01, 0xFC, 0xB7, 0xF2, 0xD4, 0xE0, 0x82, 0xDD, 0xAD, 0x41, 0xEC, 0xA0, 0x38, 0x38, 0x3F, 0x5A, 0xFC, 0x97, 0x06, 0x7D, 0x72 };
    vars.epicHash = new byte[] { 0xF9, 0x82, 0xBA, 0x71, 0x29, 0x2B, 0x11, 0x7D, 0x2F, 0xC6, 0x3D, 0xCF, 0xEA, 0x37, 0xD7, 0x42, 0xA4, 0x42, 0x0F, 0x62, 0x5E, 0x7F, 0x70, 0x89, 0x0D, 0xD2, 0x99, 0xD3, 0xAB, 0x47, 0xFE, 0x7A };
    vars.CalcModuleHash = (Func<ProcessModuleWow64Safe, byte[]>)((module) => {
        byte[] checksum = new byte[32];
        using (var hashFunc = System.Security.Cryptography.SHA256.Create())
            using (var fs = new FileStream(module.FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite | FileShare.Delete))
                checksum = hashFunc.ComputeHash(fs);
        return checksum;
    });
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
        return (old.pfCheckpointNum == (current.pfCheckpointNum - 1)) || (current.pfCheckpointNum == current.pfCheckpointMax);
}

isLoading
{
    return current.loading == 240;
}

gameTime
{
    // If pf is enabled and pf state is not Out of Challenge
    if (settings["pf"] && current.pfState != -1)
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

reset
{
    if (settings["pf"])
        return current.pfState == 5;
}
