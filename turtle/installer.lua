local Urls = {
    config = 'http://92.232.171.148/turtle/config.lua',
    turtle = 'http://92.232.171.148/turtle/turtle.lua',
    master = 'http://92.232.171.148/turtle/master.lua',
    router = 'http://92.232.171.148/turtle/router.lua'
}

local deviceType = os.getComputerLabel()

function installFile(file)
    if not fs.isDir('pj-invade') then shell.run('mkdir pj-invade') end

    if (fs.exists('pj-invade/config.lua')) then
        print('Backing up config file to config.lua.bk')
        if (fs.exists('pj-invade/config.lua.bk')) then
            print('Deleting old backup config')
            fs.delete('pj-invade/config.lua.bk')
            print('Deleted backup config')
        end
        print('backing up config file')
        fs.copy('pj-invade/config.lua', 'pj-invade/config.lua.bk')
        print('Config backed up!')
        fs.delete('pj-invade/config.lua')
    end
    print('Installing the config.lua')
    shell.run('wget '..Urls.config.. ' pj-invade/config.lua')
    print('config.lua installed successfully')

    if (fs.exists('pj-invade/'..file..'.lua')) then
        if (fs.exists('pj-invade/'..file..'.lua.bk')) then
            fs.delete('pj-invade/'..file..'.lua.bk')
        end
        fs.copy('pj-invade/'..file..'.lua', 'pj-invade/'..file..'.lua.bk')
        fs.delete('pj-invade/'..file..'.lua')
    end

    print('Installing the '..file..'.lua')
    shell.run('wget '..Urls[file].. ' pj-invade/'..file..'.lua')
    print(file..'.lua installed successfully')
end

if (string.upper(deviceType) == 'ROUTER') then
    installFile('router')
elseif (string.upper(deviceType) == 'MASTER') then
    installFile('master')
elseif (string.upper(deviceType) == 'TURTLE') then
    installFile('turtle')
else
    print('You need to set the turtle label to one of the following')
    print('Master, Turtle, Router')
    print('You can do this by running: label set [NAME]')
end