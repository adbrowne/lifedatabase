import type { NextPage } from 'next'
import Head from 'next/head'
import Image from 'next/image'
import styles from '../styles/Home.module.css'

const Home: NextPage = () => {
  return (
    <div className={styles.container}>
      <Head>
        <title>Lifedatabase.net</title>
        <meta name="description" content="For all your life's data" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        <h1 className={styles.title}>
          Welcome to <a href="https://lifedatabase.net">lifedatabase.net</a>
        </h1>

      </main>

      <footer className={styles.footer}>
          Copyright 2021 Andrew Browne{' '}
      </footer>
    </div>
  )
}

export default Home
