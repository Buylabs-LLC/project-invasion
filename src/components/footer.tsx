import React from 'react';
import { Footer } from 'react-daisyui';

export default function FooterBar(){
    return (
        <Footer className="p-10 bg-neutral text-neutral-content flex flex-row">
            <div className='grow text-center'>
                <Footer.Title>
                    Front End Credits
                </Footer.Title>
                <p>TenCreator</p>
                <p>TipsyTheCat</p>
            </div>
            <div className='grow text-center'>
                <Footer.Title>
                    Back End Credits
                </Footer.Title>
                <p>TenCreator</p>
                <p>TipsyTheCat</p>
            </div>
            <div className='grow text-center'>
                <Footer.Title>
                    LUA Credits
                </Footer.Title>
                <p>TenCreator</p>
                <p>TipsyTheCat</p>
            </div>
        </Footer>
    )
}