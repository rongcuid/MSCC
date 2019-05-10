name := "MSCC2"

version := "1.90"

scalaVersion := "2.11.12"

EclipseKeys.withSource := true

libraryDependencies ++= Seq(
  "com.github.spinalhdl" % "spinalhdl-core_2.11" % "1.3.3",
  "com.github.spinalhdl" % "spinalhdl-lib_2.11" % "1.3.3"
)

fork := true
