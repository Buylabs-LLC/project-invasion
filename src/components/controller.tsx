import { Button, Navbar, Menu, ButtonGroup } from 'react-daisyui'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faDigging, faUpDownLeftRight, faLeftLong, faRightLong, faTrowel, faServer, faUser, faThumbsDown, faThumbsUp } from '@fortawesome/free-solid-svg-icons'
import react, { useState, useEffect } from 'react'
import Axios from 'axios'

interface NavChildren {
    Buttons: [{title: string, action: string, icon: any}]
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
                    <input id="network-drawer" type="checkbox" className="drawer-toggle" />
                    <div className="drawer-content flex flex-row min-w-full gap-x-8 lg:justify-center">
                        <label htmlFor="network-drawer" className="btn btn-primary drawer-button">See network</label>
                        
                        <NavChildren Buttons={[{action: null, icon:faLeftLong, title: 'Move Up'}, {action: null, icon: faUpDownLeftRight, title: 'Move Forwards'}, {action: null, icon: faRightLong, title: 'Move Down'}]} />
                        <NavChildren Buttons={[{action: null, icon:faLeftLong, title: 'Dig Up'}, {action: null, icon: faDigging, title: 'Dig Forwards'}, {action: null, icon: faRightLong, title: 'Dig Down'}]} />
                        <NavChildren Buttons={[{action: null, icon:faLeftLong, title: 'Place Up'}, {action: null, icon: faTrowel, title: 'Place '}, {action: null, icon: faRightLong, title: 'Place Down'}]} />

                        <div className="info">
                            {/* @ts-ignore */}
                            <div className="radial-progress" style={{"--value":76, "--thickness": "4px"}}>Fuel</div>
                        </div>

                    </div> 
                    <div id='network-drawer' className="drawer-side">
                        <label htmlFor="network-drawer" className="drawer-overlay"></label>
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
    const [selected, setSelected]: any = useState()
    const [dbWorks, setDbWorks]: any = useState()

    useEffect(() =>{
        Axios.get('/api/turtles')
            .then((response: {data: {}})=>{
                if (response.data){
                    setTurtles(response.data)
                }else{
                    setTurtles([{Id: -1, Name: 'No Turtles Found', Action: "N/A", Active: false}])
                }
            })
    }, [turtles])
    
    useEffect(() =>{
        Axios.get('/api/masters')
            .then((response: {data: {}})=>{
                if (response.data){
                    setMasters(response.data)
                }else{
                    setMasters([{Id: -1, Name: 'No Turtles Found', Action: "N/A", Active: false}])
                }
            })
    }, [masters])

    return (
        <>
            <Menu className="turtles">
                <Menu.Title>
                    <span className='text-center font-black text-lg'>
                        <FontAwesomeIcon icon={faUser} /> | Turtles
                    </span>
                </Menu.Title>
                <CreateDrawerChildren data={turtles} />
            </Menu>
            <div className="divider"></div>
            <Menu className="masters">
                <Menu.Title>
                    <span className='text-center font-black text-lg'>
                        <FontAwesomeIcon icon={faServer} /> | Masters
                    </span>
                </Menu.Title>
                <CreateDrawerChildren data={masters} />
            </Menu>
        </>
    )
}

function CreateDrawerChildren({data, selected, setSelected}: {data: [any], selected: number, setSelected: any}){
    return data.map((v:{Name: string, Id: number, Action: string, LastSeen: string, Active: boolean}, index: number)=>{
        return (
            <Menu.Item key={index} className="hover-bordered">
                <a className='grid grid-cols-3 justify-items-center'>
                    <FontAwesomeIcon icon={faUser} />
                    <span>{v.Name}</span>
                    <span>{v.Action}</span>
                    <span>{v.Id}</span>
                    {v.Active ? <FontAwesomeIcon className='text-green-600' icon={faThumbsUp} />:<FontAwesomeIcon className='text-red-600' icon={faThumbsDown} />}
                </a>
            </Menu.Item>
        )
    })
}

function NavChildren({Buttons}: NavChildren){
    return (
        <ButtonGroup className="flex flex-row">
            {Buttons.map((button: {action: any, icon: any, title: string}, index: number) =>{
                return (
                    <Button key={index} onClick={button.action} title={button.title}>
                        <FontAwesomeIcon icon={button.icon} />
                    </Button>
                )
            })}
        </ButtonGroup>
    )
}