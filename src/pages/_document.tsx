import { Html, Head, Main, NextScript } from 'next/document'
import React from 'react'
import Header from '@components/header'
import FooterBar from '@components/footer'
import Config from '@config'

export default function Document() {
  return (
    <Html lang="en" data-theme="dracula">
      <Head>
        <link rel="shortcut icon" href="/favicon.ico" />
        <title>{Config.Title}</title>
      </Head>
      <body className='font-sans'>
        <Header />
        <Main />
        <FooterBar />
        <NextScript />
      </body>
    </Html>
  )
}
