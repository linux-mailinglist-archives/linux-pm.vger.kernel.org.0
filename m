Return-Path: <linux-pm+bounces-4669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE4C8714B2
	for <lists+linux-pm@lfdr.de>; Tue,  5 Mar 2024 05:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AFA1F2101D
	for <lists+linux-pm@lfdr.de>; Tue,  5 Mar 2024 04:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAEB38FA7;
	Tue,  5 Mar 2024 04:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gtU1u9Ov"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8447F2940D
	for <linux-pm@vger.kernel.org>; Tue,  5 Mar 2024 04:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709612690; cv=none; b=ccMBbhV4VSYRZA0TWSGjV4yT3yt/X8T860GLz8ogZMPJRgYaCmdjOqKETxUKCXQjH7NqL+fu3x/0IaneW+GHzj3SM3MAzCtsOoESwV5WedIxwFJn0BQJlmXEUdQvIXNEoEeIsrNbWy1CSzJCZZSLcxBM2+zBNugJxORG+sO/0DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709612690; c=relaxed/simple;
	bh=6YT3Qe5EiYC4AuglxyBHcKHUlzvWap/uuHGTVRAiXDU=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Fnx7FAyEgiLyDp6REk/HxujPSRQ96dMcTdFNZ9Fwdt5USUPnEEXsHwCBUL3p4ilX/ut0R5TSfj035/xMI1gDDSrNQ8Ayn60wiBqg9wJP33RiUCk4NLTTCVw0eJJiQxaD8NK3Y2SwamRPGdU84/8RlkYbkJlyCw/eH1IYH0I6Sgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=gtU1u9Ov; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a132ce36ebso922805eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Mar 2024 20:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709612687; x=1710217487; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2EvrQzVo9WAI4p492c1q00ksLDCA659REl55l6bH+c0=;
        b=gtU1u9OvWzSCEClALLnjEqgWgBEjz+0I/0NukuvCibugzQLj/AaJAzLvay5e1DfAqW
         YxhOmZVzO8J5EM6yE9ReoYFmo2ouWJ+fyM4cAfJG4BvveskZPf157BA+PET2x15tfXGX
         mdoDFXBnjksyfqwdzzNzdS5y7a/27DWNnebVwc2P7OAOQdqZHIy73RHAQRjEPyRMsjgi
         EyWvrSwWqwAfnj+GKTkwSrFTviuBR5WtqX3JN7nIzSoRE08yLFXVBbgsPvGUpXdF2QSk
         iYXbiIIquxPJDrCCr1T9WOyfsgLKubSdNCtYcrCe3VzbpUnnp73bXJAqoa1Xfh53XPs8
         i5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709612687; x=1710217487;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2EvrQzVo9WAI4p492c1q00ksLDCA659REl55l6bH+c0=;
        b=oFAaAwZ1CUtWVd3cpsLSIpTOOMC7zDta0kMxnB/OX/dtJLOzbhNYV6DmIxk4CPpii2
         9hGcvc5kuY1AZl5fM72E1FxwgLgoflPumuQmZjyLpaQlo6zNAqqovaR+g1K1k7v5QCcQ
         LmBk8RitkYO/jHWRB4++Ia2aqQEo49mfqOZlSw/jgJsW5YfpYiBL4R/OHkvvz0YvkFwb
         SA7R6ZWrveeDNyOkoWhQeKzKR/yD0k7MOO0P93wjoYik0wVfiKaHbc9WeDOX59L0X9ZV
         nMWqFiN1QkrIJ3KzoV6ZGGG96iNbLxO5Tdi0Vn2VmdvfMQ4bKN2CiQqExCdEZ349jbMJ
         BEFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBwnpf6Y+OigNFOblrmnxthrZ6X+q80qX4QxM2ry/W6Cr/txJ3cSNhkB1RDauDxqBIdOX5/pRYe4NTPniEHjFc9WXTuMdY2HY=
X-Gm-Message-State: AOJu0YwJgDV2HFYBBJwXOf9qDEsHn1fyxSEKGA+QUKUbXA6TZfxpoyof
	v4SHMt0LG0PXAPgBaewwOMDz0rHUjm8B+zjmLe/nnJCnrUN+E6jx8E1/5A+w/sE=
X-Google-Smtp-Source: AGHT+IGd8Vcyp4jggNM+ygRePLvF0KhP6NKx54CPGdomWz76YyJfBwtlCFsLXkP0wxKgAkER41iyLw==
X-Received: by 2002:a05:6358:3423:b0:17b:f3f0:8fe with SMTP id h35-20020a056358342300b0017bf3f008femr777021rwd.25.1709612687381;
        Mon, 04 Mar 2024 20:24:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i125-20020a639d83000000b005dc5129ba9dsm8228939pgd.72.2024.03.04.20.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 20:24:46 -0800 (PST)
Message-ID: <65e69e8e.630a0220.2f8be.2a9d@mx.google.com>
Date: Mon, 04 Mar 2024 20:24:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.8-rc7-146-gd720e67268b7
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 2 failed, 6 passed, 2 errors,
 32 warnings (v6.8-rc7-146-gd720e67268b7)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 2 failed, 6 passed, 2 errors, 32 warnings (v6.8=
-rc7-146-gd720e67268b7)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
8-rc7-146-gd720e67268b7/

Tree: pm
Branch: testing
Git Describe: v6.8-rc7-146-gd720e67268b7
Git Commit: d720e67268b76a4e663ac8df7c6e9c397d0cdc6a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Build Failures Detected:

i386:
    i386_defconfig: (gcc-10) FAIL

x86_64:
    x86_64_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:
    haps_hs_smp_defconfig (gcc-10): 2 warnings

arm64:
    defconfig (gcc-10): 1 warning

arm:

i386:
    i386_defconfig (gcc-10): 1 error, 1 warning

mips:

riscv:
    defconfig (gcc-10): 1 warning

sparc:
    sparc64_defconfig (gcc-10): 26 warnings

x86_64:
    x86_64_defconfig (gcc-10): 1 error, 1 warning

Errors summary:

    1    security/security.c:811:2: error: =E2=80=98memcpy=E2=80=99 offset =
32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]
    1    arch/x86/include/asm/string_32.h:150:25: error: =E2=80=98__builtin=
_memcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bou=
nds]

Warnings summary:

    2    security/security.c:811:2: warning: =E2=80=98memcpy=E2=80=99 offse=
t 32 is out of the bounds [0, 0] [-Warray-bounds]
    2    cc1: all warnings being treated as errors
    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    1    arch/sparc/vdso/vma.c:246:12: warning: no previous prototype for =
=E2=80=98init_vdso_image=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: warning: no prev=
ious prototype for =E2=80=98__vdso_gettimeofday_stick=E2=80=99 [-Wmissing-p=
rototypes]
    1    arch/sparc/vdso/vdso32/../vclock_gettime.c:307:1: warning: no prev=
ious prototype for =E2=80=98__vdso_gettimeofday=E2=80=99 [-Wmissing-prototy=
pes]
    1    arch/sparc/vdso/vdso32/../vclock_gettime.c:282:1: warning: no prev=
ious prototype for =E2=80=98__vdso_clock_gettime_stick=E2=80=99 [-Wmissing-=
prototypes]
    1    arch/sparc/vdso/vdso32/../vclock_gettime.c:254:1: warning: no prev=
ious prototype for =E2=80=98__vdso_clock_gettime=E2=80=99 [-Wmissing-protot=
ypes]
    1    arch/sparc/vdso/vclock_gettime.c:343:1: warning: no previous proto=
type for =E2=80=98__vdso_gettimeofday_stick=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/vdso/vclock_gettime.c:307:1: warning: no previous proto=
type for =E2=80=98__vdso_gettimeofday=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/vdso/vclock_gettime.c:282:1: warning: no previous proto=
type for =E2=80=98__vdso_clock_gettime_stick=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/vdso/vclock_gettime.c:254:1: warning: no previous proto=
type for =E2=80=98__vdso_clock_gettime=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/prom/p1275.c:52:6: warning: no previous prototype for =
=E2=80=98prom_cif_init=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/prom/misc_64.c:165:5: warning: no previous prototype fo=
r =E2=80=98prom_get_mmu_ihandle=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/mm/init_64.c:2644:6: warning: no previous prototype for=
 =E2=80=98vmemmap_free=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/uprobes.c:237:17: warning: no previous prototype=
 for =E2=80=98uprobe_trap=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/traps_64.c:253:6: warning: no previous prototype=
 for =E2=80=98is_no_fault_exception=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/traps_64.c:2153:6: warning: no previous prototyp=
e for =E2=80=98sun4v_nonresum_error_user_handled=E2=80=99 [-Wmissing-protot=
ypes]
    1    arch/sparc/kernel/traps_64.c:2035:6: warning: no previous prototyp=
e for =E2=80=98do_mcd_err=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/time_64.c:880:20: warning: no previous prototype=
 for =E2=80=98sched_clock=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/setup_64.c:602:13: warning: no previous prototyp=
e for =E2=80=98alloc_irqstack_bootmem=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/pci_sun4v.c:259:15: warning: no previous prototy=
pe for =E2=80=98dma_4v_iotsb_bind=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/adi_64.c:299:6: warning: no previous prototype f=
or =E2=80=98del_tag_store=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/adi_64.c:156:21: warning: no previous prototype =
for =E2=80=98alloc_tag_store=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/adi_64.c:124:21: warning: no previous prototype =
for =E2=80=98find_tag_store=E2=80=99 [-Wmissing-prototypes]
    1    arch/arc/kernel/ptrace.c:342:16: warning: no previous prototype fo=
r 'syscall_trace_enter' [-Wmissing-prototypes]
    1    arch/arc/kernel/kprobes.c:193:15: warning: no previous prototype f=
or 'arc_kprobe_handler' [-Wmissing-prototypes]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    security/security.c:811:2: warning: =E2=80=98memcpy=E2=80=99 offset 32 =
is out of the bounds [0, 0] [-Warray-bounds]

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    security/security.c:811:2: warning: =E2=80=98memcpy=E2=80=99 offset 32 =
is out of the bounds [0, 0] [-Warray-bounds]

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0=
 section mismatches

Warnings:
    arch/arc/kernel/ptrace.c:342:16: warning: no previous prototype for 'sy=
scall_trace_enter' [-Wmissing-prototypes]
    arch/arc/kernel/kprobes.c:193:15: warning: no previous prototype for 'a=
rc_kprobe_handler' [-Wmissing-prototypes]

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    arch/x86/include/asm/string_32.h:150:25: error: =E2=80=98__builtin_memc=
py=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings:
    cc1: all warnings being treated as errors

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 26 warnings, 0 =
section mismatches

Warnings:
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    arch/sparc/kernel/traps_64.c:253:6: warning: no previous prototype for =
=E2=80=98is_no_fault_exception=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/traps_64.c:2035:6: warning: no previous prototype for=
 =E2=80=98do_mcd_err=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/traps_64.c:2153:6: warning: no previous prototype for=
 =E2=80=98sun4v_nonresum_error_user_handled=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/setup_64.c:602:13: warning: no previous prototype for=
 =E2=80=98alloc_irqstack_bootmem=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/time_64.c:880:20: warning: no previous prototype for =
=E2=80=98sched_clock=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/adi_64.c:124:21: warning: no previous prototype for =
=E2=80=98find_tag_store=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/adi_64.c:156:21: warning: no previous prototype for =
=E2=80=98alloc_tag_store=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/adi_64.c:299:6: warning: no previous prototype for =
=E2=80=98del_tag_store=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/pci_sun4v.c:259:15: warning: no previous prototype fo=
r =E2=80=98dma_4v_iotsb_bind=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/uprobes.c:237:17: warning: no previous prototype for =
=E2=80=98uprobe_trap=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/mm/init_64.c:2644:6: warning: no previous prototype for =E2=
=80=98vmemmap_free=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vma.c:246:12: warning: no previous prototype for =E2=80=
=98init_vdso_image=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vclock_gettime.c:254:1: warning: no previous prototype =
for =E2=80=98__vdso_clock_gettime=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vclock_gettime.c:282:1: warning: no previous prototype =
for =E2=80=98__vdso_clock_gettime_stick=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vclock_gettime.c:307:1: warning: no previous prototype =
for =E2=80=98__vdso_gettimeofday=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vclock_gettime.c:343:1: warning: no previous prototype =
for =E2=80=98__vdso_gettimeofday_stick=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vdso32/../vclock_gettime.c:254:1: warning: no previous =
prototype for =E2=80=98__vdso_clock_gettime=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vdso32/../vclock_gettime.c:282:1: warning: no previous =
prototype for =E2=80=98__vdso_clock_gettime_stick=E2=80=99 [-Wmissing-proto=
types]
    arch/sparc/vdso/vdso32/../vclock_gettime.c:307:1: warning: no previous =
prototype for =E2=80=98__vdso_gettimeofday=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: warning: no previous =
prototype for =E2=80=98__vdso_gettimeofday_stick=E2=80=99 [-Wmissing-protot=
ypes]
    arch/sparc/prom/misc_64.c:165:5: warning: no previous prototype for =E2=
=80=98prom_get_mmu_ihandle=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/prom/p1275.c:52:6: warning: no previous prototype for =E2=80=
=98prom_cif_init=E2=80=99 [-Wmissing-prototypes]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    security/security.c:811:2: error: =E2=80=98memcpy=E2=80=99 offset 32 is=
 out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings:
    cc1: all warnings being treated as errors

---
For more info write to <info@kernelci.org>

