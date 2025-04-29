use rustler::env::Env;
use rustler::types::Atom;

#[cfg(target_os = "linux")]
use cnproc;

rustler::atoms! {
    ok = "ok",
    error = "error"
}

#[cfg(target_os = "linux")]
#[rustler::nif]
fn start(env: Env) -> Atom {
    let mut monitor = PidMonitor::new().unwrap();

    ok()
}

#[cfg(not(target_os = "linux"))]
#[rustler::nif]
fn start() -> Atom {
    error()
}

rustler::init!("Elixir.Proclist.Monitor");
