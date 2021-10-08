package net.lifedatabase.dbserver

import cats.effect.{ExitCode, IO, IOApp}

object Main extends IOApp {
  def run(args: List[String]) =
    DbserverServer.stream[IO].compile.drain.as(ExitCode.Success)
}
