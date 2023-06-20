import Controller from "@/components/controller"
import Config from "@config"

export default function Home() {
  return (
    <main className="flex flex-col justify-center w-full gap-8">
      <section id="home" className="flex justify-center items-center h-96 bg-gradient-to-r from-purple-500 via-amber-800 to-pink-500 hero">
        <h1 className="text-5xl font-black">{Config.Title}</h1>
      </section>
      <section id="controller" className="flex justify-center">
        <Controller />
      </section>
    </main>
  )
}
