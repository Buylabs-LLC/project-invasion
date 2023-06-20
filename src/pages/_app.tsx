import type { AppProps } from 'next/app'
import Head from 'next/head'
import React from 'react'
import '@globalcss'

export default function App({
  Component,
  pageProps: { ...pageProps },
}:any) {
  return (
    <>
      <Component {...pageProps} />
    </>
  )
}