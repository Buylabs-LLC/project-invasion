import React from "react";
import { Link } from "react-daisyui";
export default function Header(){
  return (
    <div className="flex w-full component-preview p-4 items-center justify-center gap-2 shadow-2xl shadow-black z-10">
        <div className="navbar-center">
        <Link className="btn btn-ghost normal-case text-xl" href='/'>Project Invasion</Link>
      </div>
    </div>
  )    
}