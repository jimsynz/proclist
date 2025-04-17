use rustler::{NifResult, NifStruct, NifTaggedEnum};
use proclist;


#[derive(NifStruct)]
#[module = "Proclist.Process"]
pub struct Process {
    name: String,
    pid: u32,
    parent_pid: u32,
    threads_count: u32
}

impl From<proclist::ProcessInfo> for Process {
    fn from(value: proclist::ProcessInfo) -> Process {
        Process {
            name: value.name,
            pid: value.pid,
            parent_pid: value.parent_pid,
            threads_count: value.threads_count
        }
    }
}

#[derive(NifTaggedEnum)]
pub enum Error {
    InternalError(String, String),
    ExternalError(String, String)
}

impl From<proclist::Error> for Error {
    fn from(error: proclist::Error) -> Error {
        match error {
            proclist::Error::InternalError{description, cause} => Error::InternalError(description, cause),
            proclist::Error::ForeignError{api_name, errno} => Error::ExternalError(api_name.to_string(), format!("{}", errno))
        }
    }
}

impl Into<rustler::Error> for Error {
    fn into(self) -> rustler::Error {
        rustler::Error::Term(Box::new(self))
    }
}

#[rustler::nif]
pub fn all_processes() -> NifResult<Vec<Process>> {
    match proclist::get_processes_info() {
        Ok(processes) => Ok(processes.iter().map(|process| process.clone().into()).collect()),
        Err(error) => Err(Into::<Error>::into(error).into())
    }
}

rustler::init!("Elixir.Proclist");
