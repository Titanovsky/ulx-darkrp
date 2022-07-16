local CATEGORY = 'DarkRP'

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
local command = 'spawn'
local function Action( eCaller, tPlayers )
    for _, ply in ipairs( tPlayers ) do ply:Spawn() end

	ulx.fancyLogAdmin( eCaller, '#A заспавнил #T', tPlayers )
end
local method = ulx.command( CATEGORY, 'ulx '..command, Action, '/'..command )
method:addParam{ type=ULib.cmds.PlayersArg }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( 'Заспавнить игрока' )

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
local command = 'setarrest'
local function Action( eCaller, ePly )
    local text = ''

    if ePly:IsArrested() then
        text = 'освободил'

        Ambi.DarkRP.UnArrest( ePly, eCaller )
    else
        text = 'арестовал'

        Ambi.DarkRP.Arrest( ePly, eCaller )
    end

	ulx.fancyLogAdmin( eCaller, '#A '..text..' #T', ePly )
end
local method = ulx.command( CATEGORY, 'ulx '..command, Action, '/'..command )
method:addParam{ type=ULib.cmds.PlayerArg }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( 'Арестовать / Освободить' )

local command = 'setwarrant'
local function Action( eCaller, ePly )
    local text = ''

    if ePly:HasWarrant() then
        text = 'убрал ордер на обыск у'

        Ambi.DarkRP.UnWarrant( ePly, eCaller )
    else
        text = 'подал ордер на обыск'

        Ambi.DarkRP.Warrant( ePly, eCaller )
    end

	ulx.fancyLogAdmin( eCaller, '#A '..text..' #T', ePly )
end
local method = ulx.command( CATEGORY, 'ulx '..command, Action, '/'..command )
method:addParam{ type=ULib.cmds.PlayerArg }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( 'Подать Ордер на Обыск / Удалить Ордер на Обыск' )

local command = 'setwanted'
local function Action( eCaller, ePly )
    local text = ''

    if ePly:IsWanted() then
        text = 'убрал розыск у'

        Ambi.DarkRP.UnWanted( ePly, eCaller )
    else
        text = 'подал в розыск'

        Ambi.DarkRP.Wanted( ePly, eCaller )
    end

	ulx.fancyLogAdmin( eCaller, '#A '..text..' #T', ePly )
end
local method = ulx.command( CATEGORY, 'ulx '..command, Action, '/'..command )
method:addParam{ type=ULib.cmds.PlayerArg }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( 'Подать Ордер на Обыск / Удалить Ордер на Обыск' )

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
local classes = {}
for class, _ in pairs( Ambi.DarkRP.GetJobs() ) do classes[ #classes + 1 ] = class end

local command = 'setjob'
local function Action( eCaller, tPlayers, sJob )
    if not Ambi.DarkRP.GetJob( sJob ) then eCaller:ChatPrint( 'Нет такой работы! Смотрите /getjobs' ) return end

    for _, ply in ipairs( tPlayers ) do ply:SetJob( sJob, true ) end

	ulx.fancyLogAdmin( eCaller, '#A изменил работу #T на #s', tPlayers, sJob )
end
local method = ulx.command( CATEGORY, 'ulx '..command, Action, '/'..command )
method:addParam{ type=ULib.cmds.PlayersArg }
method:addParam{ type=ULib.cmds.StringArg, hint= 'Класс работы', ULib.cmds.optional, ULib.cmds.takeRestOfLine, completes = classes }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( 'Изменить (насильно) работу игроку' )

local command = 'getjobs'
local function Action( eCaller )
    for class, job in pairs( Ambi.DarkRP.GetJobs() ) do
        if IsValid( eCaller ) then 
            eCaller:ChatPrint( job.name..' — '..class )
        else
            print( job.name..' — '..class )
        end
    end
end
local method = ulx.command( CATEGORY, 'ulx '..command, Action, '/'..command )
method:defaultAccess( ULib.ACCESS_ADMIN )
method:help( 'Узнать все работы: Название - Класс' )

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
local command = 'setmoney'
local function Action( eCaller, tPlayers, nMoney )
    for _, ply in ipairs( tPlayers ) do ply:SetMoney( nMoney ) end

	ulx.fancyLogAdmin( eCaller, '#A изменил деньги #T на #i', tPlayers, nMoney )
end
local method = ulx.command( CATEGORY, 'ulx '..command, Action, '/'..command )
method:addParam{ type=ULib.cmds.PlayersArg }
method:addParam{ type=ULib.cmds.NumArg, min=0, hint = 'Деньги', ULib.cmds.round, ULib.cmds.optional }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( 'Изменить деньги игрокам' )

local command = 'addmoney'
local function Action( eCaller, tPlayers, nMoney )
    for _, ply in ipairs( tPlayers ) do ply:AddMoney( nMoney ) end

	ulx.fancyLogAdmin( eCaller, '#A добавил деньги #T на #i', tPlayers, nMoney )
end
local method = ulx.command( CATEGORY, 'ulx '..command, Action, '/'..command )
method:addParam{ type=ULib.cmds.PlayersArg }
method:addParam{ type=ULib.cmds.NumArg, hint = 'Деньги', ULib.cmds.round, ULib.cmds.optional }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( 'Добавить деньги игрокам' )

local command = 'wipemoney'
local function Action( eCaller )
    for _, ply in ipairs( player.GetHumans() ) do ply:SetMoney( Ambi.DarkRP.Config.money_start ) end

    Ambi.SQL.UpdateAll( 'darkrp_alt_money', 'Money', Ambi.DarkRP.Config.money_start )

	ulx.fancyLogAdmin( eCaller, '#A вайпнул все деньги', tPlayers, nMoney )
end
local method = ulx.command( CATEGORY, 'ulx '..command, Action, '/'..command )
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( 'Вайпнуть деньги игрока на стартовые' )

-- TODO:
-- 1 - to show all guns of player
-- 2 - start/end lockdown
-- 3 - force demote
-- 4 - force drop current weapon
-- 5 - start/end vote
-- 6 - setlaw
-- 7 - addlaw
-- 8 - wipelaws
-- 9 - givelicense
-- 10 - removelicense
-- 11 - force sell all doors
-- 12 - force sell door front
-- 13 - get door owner front