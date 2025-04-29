use rustler::env::Env;
use rustler::types::Atom;
use rustler::thread;

rustler::atoms! {
    ok = "ok"
}

#[rustler::nif]
fn start(env: Env) -> Atom {
    thread::spawn(env, move |env| {
        std::thread::sleep(std::time::Duration::from_millis(10000));
  ok().to_term(env)
    });

  ok()
}

rustler::init!("Elixir.Proclist.Monitor");
