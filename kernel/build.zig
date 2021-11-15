const std = @import("std");
const pkgs = @import("deps.zig").pkgs;

pub fn build(b: *std.build.Builder) void {
    const kernel = b.addExecutable("kernel.elf", "src/main.zig");
    pkgs.addAllTo(kernel);
    kernel.install();
    kernel.setOutputDir("build");

    kernel.setBuildMode(b.standardReleaseOptions());
    kernel.setTarget(std.zig.CrossTarget {
        .cpu_arch = std.Target.Cpu.Arch.x86_64,
        .os_tag = std.Target.Os.Tag.freestanding,
        .abi = std.Target.Abi.none,
    });

    kernel.setLinkerScriptPath(.{.path="./linker.ld"});
    b.default_step.dependOn(&kernel.step);
}