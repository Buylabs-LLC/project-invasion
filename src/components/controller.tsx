import { Button, Navbar, Menu, ButtonGroup } from 'react-daisyui'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faDigging, faUpDownLeftRight, faLeftLong, faRightLong, faTrowel, faServer, faUser, faThumbsDown, faThumbsUp } from '@fortawesome/free-solid-svg-icons'
import react, { useState, useEffect } from 'react'
import Axios from 'axios'

interface NavChildren {
    Buttons: any
}

interface DrawerChildren {
    Turtles: [name: string, status: string]
    Masters: [name: string, status: string]
}

export default function Controller(){
    return (
        <div className="container rounded-md min-w-full flex flex-row p-1">
            <Navbar className="toolbar min-w-full">

                <div className="drawer">
                    <input id="my-drawer" type="checkbox" className="drawer-toggle" />
                    <div className="drawer-content flex flex-row min-w-full gap-x-8 justify-center">
                        <label htmlFor="my-drawer" className="btn btn-primary drawer-button">See network</label>
                        
                        <NavChildren Buttons={[{action: null, icon:faLeftLong}, {action: null, icon: faUpDownLeftRight}, {action: null, icon: faRightLong}]} />
                        <NavChildren Buttons={[{action: null, icon:faLeftLong}, {action: null, icon: faDigging}, {action: null, icon: faRightLong}]} />
                        <NavChildren Buttons={[{action: null, icon:faLeftLong}, {action: null, icon: faTrowel}, {action: null, icon: faRightLong}]} />

                        <div className="info">
                            {/* @ts-ignore */}
                            <div className="radial-progress" style={{"--value":76, "--thickness": "4px"}}>Fuel</div>
                        </div>

                    </div> 
                    <div id='my-drawer' className="drawer-side">
                        <label htmlFor="my-drawer" className="drawer-overlay"></label>
                        <ul className="menu p-4 w-80 h-full bg-base-200 text-base-content">
                            <DrawerChildren />
                        </ul>
                    </div>
                </div>
            </Navbar>
        </div>
    )
}

function DrawerChildren(){
    const [turtles, setTurtles]: any = useState()
    const [masters, setMasters]: any = useState()

    useEffect(() =>{
        Axios.get('/api/turtles')
            .then((response: {data: {}})=>{
                setTurtles(response.data)
            })
    }, [turtles])
    
    useEffect(() =>{
        Axios.get('/api/masters')
            .then((response: {data: {}})=>{
                setMasters(response.data)
            })
    }, [masters])

    if (!turtles) return
    if (!masters) return

    return (
        <>
            <Menu className="turtles">
                <Menu.Title><FontAwesomeIcon icon={faUser} /></Menu.Title>
                {
                    turtles.map((turtle:{Name: string, Id: number, Action: string, LastSeen: string, Active: boolean})=>{
                        return (
                            <Menu.Item className="hover-bordered">
                                <a className='grid grid-cols-3 justify-items-center'>
                                    <FontAwesomeIcon icon={faUser} />
                                    <span>{turtle.Name}</span>
                                    <span>{turtle.Action}</span>
                                    <span>{turtle.Id}</span>
                                    {turtle.Active ? <FontAwesomeIcon className='text-green-900' icon={faThumbsUp} />:<FontAwesomeIcon className='text-red-900' icon={faThumbsDown} />}
                                </a>
                            </Menu.Item>
                        )
                    })
                }
            </Menu>
            <div className="divider"></div>
            <Menu className="masters">
                <Menu.Title><FontAwesomeIcon icon={faServer} /></Menu.Title>
                {
                    masters.map((master:{Name: string, Id: number, Action: string, LastSeen: string, Active: boolean})=>{
                        return (
                            <Menu.Item className="hover-bordered">
                                <a className='grid grid-cols-3 justify-items-center'>
                                    <FontAwesomeIcon icon={faUser} />
                                    <span>{master.Name}</span>
                                    <span>{master.Action}</span>
                                    <span>{master.Id}</span>
                                    {master.Active ? <FontAwesomeIcon className='text-green-900' icon={faThumbsUp} />:<FontAwesomeIcon className='text-red-900' icon={faThumbsDown} />}
                                </a>
                            </Menu.Item>
                        )
                    })
                }
            </Menu>
        </>
    )
}

function NavChildren({Buttons}: NavChildren){
    return (
        <ButtonGroup className="flex flex-row">
            {
                Buttons.map((button: {action: any, icon: any}) =>{
                    return (
                        <Button onClick={button.action}>
                            <FontAwesomeIcon icon={button.icon} />
                        </Button>
                    )
                })
            }
        </ButtonGroup>
    )
}