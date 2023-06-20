import { Button } from 'react-daisyui'

export default function Controller(){
    return (
        <div className="container border-2 border-neutral-500 rounded-md">
            <div className="toolbar">
                <div className="movement">
                    <Button>Test</Button>
                </div>
                <div className="digging"></div>
                <div className="placing"></div>
                <div className="info"></div>
            </div>
            <div className="inventory"></div>
            <div className="turtles"></div>
            <div className="masters"></div>
        </div>
    )
}