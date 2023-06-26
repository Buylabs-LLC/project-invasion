import React from 'react';
import { Footer } from 'react-daisyui';

export default function FooterBar(){
    return (
        <Footer className="p-10 bg-neutral text-neutral-content flex flex-row">
            <div className='grow text-center'>
                <Footer.Title>
                    Front End Credits
                </Footer.Title>
                <ul>
                    <li>TenCreator</li>
                </ul>
            </div>
            <div className='grow text-center'>
                <Footer.Title>
                    Back End Credits
                </Footer.Title>
                <ul>
                    <li>TenCreator</li>
                </ul>
            </div>
            <div className='grow text-center'>
                <Footer.Title>
                    LUA Credits
                </Footer.Title>
                <ul>
                    <li>TenCreator</li>
                    <li>TipsyTheCat</li>
                </ul>
            </div>
        </Footer>
    )
}