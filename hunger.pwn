// Автор системы https://t.me/warningexception


// Ко всем new с MAX_PLAYERS
new satietynull[MAX_PLAYERS] = 0;

// Ко всем форвардам
forward SatietyP(playerid);

// Ко всем пабликам
public SatietyP(playerid)
{
    if(PlayerInfo[playerid][pSatiety] >= 100) // проверяем сытость игрока
    {
        PlayerInfo[playerid][pSatiety] = 95; // ставим игроку значение сытости на 95
        return 1;
    }
    else if(PlayerInfo[playerid][pSatiety] <= 5)
    {
        SendClientMessage(playerid, -1, "{FF0000}[Info]: {FFFFFF}Ваша сытость на исходе, немедленно перекусите, иначе Вы можете погибнуть от голода"); // высылаем сообщение игроку
         PlayerInfo[playerid][pSatiety] -= 5; // отнимаем у игрока 5 сытости
         satietynull[playerid] = 1; // меняем значение переменной
    }
    else if(PlayerInfo[playerid][pSatiety] <= 5 && satietynull[playerid] == 1) // проверяем сытость и значение переменной
    {
         SendClientMessage(playerid, -1, "{FF0000}[Info]: {FFFFFF} Вы погибли от голода..."); // высылаем сообщение игроку
         PlayerInfo[playerid][pSatiety] = 35; // ставим игроку 35 сытости
         SetPlayerHealth(playerid, 0); // ставим значение здоровья на 0
         satietynull[playerid] = 0; // меняем значение переменной
    }
    else
    {
         SendClientMessage(playerid, -1, "{FF0000}[Notif]: {FFFFFF}Вы проголодались, посетите ближайшую закусочную."); // отправляем игроку сообщение о голоде в чат
        PlayerInfo[playerid][pSatiety] -= 5; // вычитаем у игрока 5 сытости
        satietynull[playerid] = 0;
        return 1;
    }
    return 0;
}

// в OnPlayerSpawn
SetTimer("SatietyP", 1000*180, True); // запускаем игроку таймер выполнения паблика(раз в 3 минуты)
satietynull[playerid] = 0;

// в OnPlayerDisconnect
satietynull[playerid] = 0;