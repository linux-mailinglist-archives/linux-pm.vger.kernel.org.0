Return-Path: <linux-pm+bounces-16997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179F69BBD5A
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 19:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911621F21F90
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4511C9EDF;
	Mon,  4 Nov 2024 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKE56y4O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C541C1C4A2F
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745357; cv=none; b=N++zYuqlW9WH5T+PekWRnyEVWQWPxtvTu+NuV+ctBV3ic2dyKLKUSLSLCZH0gmz6NIZDz3kXR5/Dtmau/lhj2YmddPByhldGCD4Fnh2dPdUdPSbSHLHqjF6hPA6KNwFObul5bPsQwlv3LZnhOZsDnpE1wADyuafk/NyPKwC6sFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745357; c=relaxed/simple;
	bh=uZcdc31ihX39mbxk/X1aedOGHVEBNtOhl9GcOqLhJSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIDcy2U8GQwbzjyDtQIwH+AlLRaz/FqFRz5pntUxW1XD7SbUwHEddzNxctk5c2EiRbSMuVSzphmj0jBJ7yuqzhw3FrW0LS1VLrztvypOhTd0AuQoJ0vjPeiXM1wZDQP1UgvOqawjKtPtr6qb0Sc5ShE4t2d+TCIEx6dnue+PLYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKE56y4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F207C4CED3
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 18:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730745357;
	bh=uZcdc31ihX39mbxk/X1aedOGHVEBNtOhl9GcOqLhJSQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PKE56y4Oso8Pl2UPw0Do1fUWq6XRzDVjVrb0uRo1NiCEVr51Gyvx+dHbsN2bxhTTO
	 tYRLEwOowW2GU8QY0mPdvgBwDkEjDsvNtwdZcXBJJFkd5EopPLDGxqlpF5TK3qhU/3
	 9MCAivtUOxXiLR3Sn5eJYAK+O3rW7ejMpG5GJwvAnCkyHsQ6pf/sl5S+bIOGaLj1dd
	 UGZhhN6Timxhd82Upj+lxMmwMbe6Ekd7bTtgNksg7RFc6KB+zGQ7Wo98CeVaLTg5gR
	 T3HzkNXEP0RCXoDVDQTJJm5SsZW/9m13pjX0yv9iAL4zdwdmfH9ufZcjJTMMPoCoC4
	 AFN3X8a0KkZwA==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e605ffe10cso2544529b6e.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 10:35:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9W84bacRTWDdLnz23ASftTMxT6Kh9hxRE3uuOLNlSuie1DjfRuWxJviT44RA2dRRXUt+mSEIFQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBuVkgjYzK+ZWUiSNTHY5P1HPKj6ntE/KngX+U/H6qAnTaR0pu
	Kf7XjzBartbtYowKBJ43DjRdfvwDqllCudblp7tz6do5Q3+OiDBq3x/6AqVd7vFyeF6xOJwlwjB
	W/W/YXscuEfznfNFkptI+tcfr79A=
X-Google-Smtp-Source: AGHT+IGTHv4JuiIGhUXxcK+io6dIjh+0xkyq5gzy41hziZFTQBkc1wwYh4D9z1jlFacB9dcVt2f43mcYS1pCO9cTeLE=
X-Received: by 2002:a05:6871:5810:b0:28c:8476:dd76 with SMTP id
 586e51a60fabf-29484638c26mr13597615fac.29.1730745356495; Mon, 04 Nov 2024
 10:35:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67290cbd.630a0220.3b06d1.05d1@mx.google.com>
In-Reply-To: <67290cbd.630a0220.3b06d1.05d1@mx.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Nov 2024 19:35:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j0+2iWE1Xu7egnymi8Njuav+miMOdeKkxHF5TPvYm+Wg@mail.gmail.com>
Message-ID: <CAJZ5v0j0+2iWE1Xu7egnymi8Njuav+miMOdeKkxHF5TPvYm+Wg@mail.gmail.com>
Subject: Re: pm/testing build: 8 builds: 1 failed, 7 passed, 1 error, 24
 warnings (v6.12-rc6-98-g57d5fb99dade)
To: "kernelci.org bot" <bot@kernelci.org>, Mario Limonciello <mario.limonciello@amd.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 7:04=E2=80=AFPM kernelci.org bot <bot@kernelci.org> =
wrote:
>
> pm/testing build: 8 builds: 1 failed, 7 passed, 1 error, 24 warnings (v6.=
12-rc6-98-g57d5fb99dade)
>
> Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v=
6.12-rc6-98-g57d5fb99dade/
>
> Tree: pm
> Branch: testing
> Git Describe: v6.12-rc6-98-g57d5fb99dade
> Git Commit: 57d5fb99dadef3680372de9e1d3972dffb1ec800
> Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.=
git
> Built: 8 unique architectures
>
> Build Failure Detected:
>
> riscv:
>     defconfig: (gcc-12) FAIL
>
> Errors and Warnings Detected:
>
> arc:
>     haps_hs_smp_defconfig (gcc-12): 2 warnings
>
> arm64:
>
> arm:
>
> i386:
>
> mips:
>     32r2el_defconfig (gcc-12): 3 warnings
>
> riscv:
>     defconfig (gcc-12): 1 error, 1 warning
>
> sparc:
>     sparc64_defconfig (gcc-12): 18 warnings
>
> x86_64:
>
> Errors summary:
>
>     1    drivers/acpi/processor_driver.c:273:9: error: implicit declarati=
on of function =E2=80=98arch_init_invariance_cppc=E2=80=99 [-Werror=3Dimpli=
cit-function-declaration]

Mario, I think that this is for you to take care of.

I'll drop the CPPC invariance init from linux-next now and please
submit a v3 with this fixed (and the comment we've discussed
elsewhere).

> Warnings summary:
>
>     2    kernel/fork.c:3077:2: warning: #warning clone3() entry point is =
missing, please fix [-Wcpp]
>     2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version gene=
ration failed, symbol will not be versioned.
>     2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented=
 [-Wcpp]
>     2    3077 | #warning clone3() entry point is missing, please fix
>     1    sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso32/vdso-note.=
o: missing .note.GNU-stack section implies executable stack
>     1    sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso-note.o: miss=
ing .note.GNU-stack section implies executable stack
>     1    cc1: some warnings being treated as errors
>     1    arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: warning: no pr=
evious prototype for =E2=80=98__vdso_gettimeofday_stick=E2=80=99 [-Wmissing=
-prototypes]
>     1    arch/sparc/vdso/vdso32/../vclock_gettime.c:307:1: warning: no pr=
evious prototype for =E2=80=98__vdso_gettimeofday=E2=80=99 [-Wmissing-proto=
types]
>     1    arch/sparc/vdso/vdso32/../vclock_gettime.c:282:1: warning: no pr=
evious prototype for =E2=80=98__vdso_clock_gettime_stick=E2=80=99 [-Wmissin=
g-prototypes]
>     1    arch/sparc/vdso/vdso32/../vclock_gettime.c:254:1: warning: no pr=
evious prototype for =E2=80=98__vdso_clock_gettime=E2=80=99 [-Wmissing-prot=
otypes]
>     1    arch/sparc/vdso/vclock_gettime.c:343:1: warning: no previous pro=
totype for =E2=80=98__vdso_gettimeofday_stick=E2=80=99 [-Wmissing-prototype=
s]
>     1    arch/sparc/vdso/vclock_gettime.c:307:1: warning: no previous pro=
totype for =E2=80=98__vdso_gettimeofday=E2=80=99 [-Wmissing-prototypes]
>     1    arch/sparc/vdso/vclock_gettime.c:282:1: warning: no previous pro=
totype for =E2=80=98__vdso_clock_gettime_stick=E2=80=99 [-Wmissing-prototyp=
es]
>     1    arch/sparc/vdso/vclock_gettime.c:254:1: warning: no previous pro=
totype for =E2=80=98__vdso_clock_gettime=E2=80=99 [-Wmissing-prototypes]
>     1    arch/mips/boot/dts/img/boston.dts:136.23-177.6: Warning (interru=
pt_provider): /pci@14000000/pci2_root@0,0/eg20t_bridge@1,0,0: '#interrupt-c=
ells' found, but node is not an interrupt provider
>     1    arch/mips/boot/dts/img/boston.dts:128.17-178.5: Warning (interru=
pt_provider): /pci@14000000/pci2_root@0,0: '#interrupt-cells' found, but no=
de is not an interrupt provider
>     1    arch/mips/boot/dts/img/boston.dtb: Warning (interrupt_map): Fail=
ed prerequisite 'interrupt_provider'
>     1    arch/arc/boot/dts/haps_hs_idu.dts:68.16-72.5: Warning (interrupt=
_provider): /fpga/pct: '#interrupt-cells' found, but node is not an interru=
pt provider
>     1    arch/arc/boot/dts/haps_hs_idu.dtb: Warning (interrupt_map): Fail=
ed prerequisite 'interrupt_provider'
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> Detailed per-defconfig build reports:
>
> -------------------------------------------------------------------------=
-------
> 32r2el_defconfig (mips, gcc-12) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches
>
> Warnings:
>     arch/mips/boot/dts/img/boston.dts:128.17-178.5: Warning (interrupt_pr=
ovider): /pci@14000000/pci2_root@0,0: '#interrupt-cells' found, but node is=
 not an interrupt provider
>     arch/mips/boot/dts/img/boston.dts:136.23-177.6: Warning (interrupt_pr=
ovider): /pci@14000000/pci2_root@0,0/eg20t_bridge@1,0,0: '#interrupt-cells'=
 found, but node is not an interrupt provider
>     arch/mips/boot/dts/img/boston.dtb: Warning (interrupt_map): Failed pr=
erequisite 'interrupt_provider'
>
> -------------------------------------------------------------------------=
-------
> defconfig (riscv, gcc-12) =E2=80=94 FAIL, 1 error, 1 warning, 0 section m=
ismatches
>
> Errors:
>     drivers/acpi/processor_driver.c:273:9: error: implicit declaration of=
 function =E2=80=98arch_init_invariance_cppc=E2=80=99 [-Werror=3Dimplicit-f=
unction-declaration]
>
> Warnings:
>     cc1: some warnings being treated as errors
>
> -------------------------------------------------------------------------=
-------
> defconfig (arm64, gcc-12) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches
>
> -------------------------------------------------------------------------=
-------
> haps_hs_smp_defconfig (arc, gcc-12) =E2=80=94 PASS, 0 errors, 2 warnings,=
 0 section mismatches
>
> Warnings:
>     arch/arc/boot/dts/haps_hs_idu.dts:68.16-72.5: Warning (interrupt_prov=
ider): /fpga/pct: '#interrupt-cells' found, but node is not an interrupt pr=
ovider
>     arch/arc/boot/dts/haps_hs_idu.dtb: Warning (interrupt_map): Failed pr=
erequisite 'interrupt_provider'
>
> -------------------------------------------------------------------------=
-------
> i386_defconfig (i386, gcc-12) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches
>
> -------------------------------------------------------------------------=
-------
> multi_v7_defconfig (arm, gcc-12) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches
>
> -------------------------------------------------------------------------=
-------
> sparc64_defconfig (sparc, gcc-12) =E2=80=94 PASS, 0 errors, 18 warnings, =
0 section mismatches
>
> Warnings:
>     <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wc=
pp]
>     arch/sparc/vdso/vclock_gettime.c:254:1: warning: no previous prototyp=
e for =E2=80=98__vdso_clock_gettime=E2=80=99 [-Wmissing-prototypes]
>     arch/sparc/vdso/vclock_gettime.c:282:1: warning: no previous prototyp=
e for =E2=80=98__vdso_clock_gettime_stick=E2=80=99 [-Wmissing-prototypes]
>     arch/sparc/vdso/vclock_gettime.c:307:1: warning: no previous prototyp=
e for =E2=80=98__vdso_gettimeofday=E2=80=99 [-Wmissing-prototypes]
>     arch/sparc/vdso/vclock_gettime.c:343:1: warning: no previous prototyp=
e for =E2=80=98__vdso_gettimeofday_stick=E2=80=99 [-Wmissing-prototypes]
>     arch/sparc/vdso/vdso32/../vclock_gettime.c:254:1: warning: no previou=
s prototype for =E2=80=98__vdso_clock_gettime=E2=80=99 [-Wmissing-prototype=
s]
>     arch/sparc/vdso/vdso32/../vclock_gettime.c:282:1: warning: no previou=
s prototype for =E2=80=98__vdso_clock_gettime_stick=E2=80=99 [-Wmissing-pro=
totypes]
>     arch/sparc/vdso/vdso32/../vclock_gettime.c:307:1: warning: no previou=
s prototype for =E2=80=98__vdso_gettimeofday=E2=80=99 [-Wmissing-prototypes=
]
>     arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: warning: no previou=
s prototype for =E2=80=98__vdso_gettimeofday_stick=E2=80=99 [-Wmissing-prot=
otypes]
>     sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso-note.o: missing .=
note.GNU-stack section implies executable stack
>     sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso32/vdso-note.o: mi=
ssing .note.GNU-stack section implies executable stack
>     kernel/fork.c:3077:2: warning: #warning clone3() entry point is missi=
ng, please fix [-Wcpp]
>     3077 | #warning clone3() entry point is missing, please fix
>     kernel/fork.c:3077:2: warning: #warning clone3() entry point is missi=
ng, please fix [-Wcpp]
>     3077 | #warning clone3() entry point is missing, please fix
>     WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generatio=
n failed, symbol will not be versioned.
>     <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wc=
pp]
>     WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generatio=
n failed, symbol will not be versioned.
>
> -------------------------------------------------------------------------=
-------
> x86_64_defconfig (x86_64, gcc-12) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches
>
> ---
> For more info write to <info@kernelci.org>

