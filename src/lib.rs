#![feature(lang_items)]
#![feature(unique)]
#![feature(const_fn)]
#![no_std]

extern crate volatile;
extern crate spin;

#[macro_use]
mod vga_buffer;

#[lang = "eh_personality"]
extern fn eh_personality() {
}

#[no_mangle]
#[lang = "panic_fmt"]
pub extern fn rust_begin_panic() -> ! {
    loop {}
}

#[no_mangle]
pub extern fn kmain() -> ! {
    println!("Welcome to");
    println!("TuziOS");
    println!("The Future is Now.");
    loop { }
}
