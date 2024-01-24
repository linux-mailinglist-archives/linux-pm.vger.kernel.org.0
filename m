Return-Path: <linux-pm+bounces-2632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E3F83A001
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 04:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B3B1C279DD
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 03:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329D91FDC;
	Wed, 24 Jan 2024 03:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="2bKcFM/1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59350524C
	for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2024 03:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706066289; cv=none; b=B9+m7UKQCyp+Prgx5EENMjiBY84isaomzioDZeg2+vQrnVlVVBzBkIO8GAR/Z3QPZnNcyHgW+raf80pUHupMSRi72c4rcI1dNxlCUzautMf7/P0asWuxVvOL+slgIkDdZKYVhcBv4T+/vfvZjXIXfTZ1JAUJ3+CuocjMe9VcSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706066289; c=relaxed/simple;
	bh=dFMpNSGfrMV8hc3MZCWaJcDSEFCfWmOTQfer5dEgoHc=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=gGt4EoiuJnzgNx+ToKwGWf2XrfcVA5IJvFgffdk7Nqg5ZflBqEcYKeVXu7l45V+pDwEDsXytIHTsW4QbWyTRqBww8onZuOiBSnWTZ0BTydud1NH1eVc42srjtGcQAncH0BoVnXxhm/Av8pHaSgiWgHwvT0Lv67ZaAdcbVxt2UNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=2bKcFM/1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d71b62fa87so28261105ad.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2024 19:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706066286; x=1706671086; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wd2tMLGNQLVC6yYZUM9TYYQ9sOk9iVdFwCU4jtb2drE=;
        b=2bKcFM/1UMQjXaDHzjUu8s/mV8bWEGpiNjRxqQuarbtW3mEOoUwBvNkkN0kR/z13Yo
         AECLE7c/UEuWr2VDKDRQUSJ5voXqS2Ad1OXmY07FwkL6aHEYuaFG2ZwpXuUup1JZhmD1
         Fp1AHcbgyWMW9NbteNv0/maOVYzY0OvBEKMMRp8TGZAMWQMyNfjE9+zzfPtY5dz/pJV2
         NmsgxvkQgARDQ3JH+uD67zGpNqUojN6+jOSBwXMRsnbOUe/5oyBTbnwA4mfNmDpcZFMN
         3u/OlKwY7LV83oTcB3QHddjU6Z64orHFqPBnAQkkffcDhDxD23UmJoEQM10b74Qapw4V
         2CYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706066286; x=1706671086;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wd2tMLGNQLVC6yYZUM9TYYQ9sOk9iVdFwCU4jtb2drE=;
        b=UpB5ntdJdpICFeTH4CPvyZ9/fdjBU/+uvvLX7gx+bpEDY6Afu5HZGTGvIQrx1myny4
         Jm1uGboW9Kc3A2jYRNbroQefTv2OsgaFJs+A8diC7CQw5pArNlsZjICIAhcDNcG1xyCQ
         SF4hifnE01HId5sQ3jKsbAXyQVg9bM2uV6FR3uXI7uKC1O9jO5JzyFX3DjVM3ixhWRF/
         RnrR4mVBfY1KKg31Apfsyw3WlIpOilmJKhxGHbmReY8SoC40r0RW/UMYEYm0DZJl7pF7
         5eNS+CIH9jsl85hLfIX9W+lJY544sYQnBqGAWNPFefVtYAud94MVBItIOl4BNb/sQy13
         vC1g==
X-Gm-Message-State: AOJu0YwjJV4tE7HVHVnglJGmshwzAxDv6RC4mGZRu0GqOO8NsIuP3dd0
	bfae4xYpmaX7ClnCVtA7dheSoOyJPJJqI/YeyuMEpBnB0M749kKNH6gWYILF7SI=
X-Google-Smtp-Source: AGHT+IFBqbsuic8nP2MwWuKJ+w4SEurLYKAv2kil+qLxRnWAnAWWecQNLDG7JlT7fZw3A+/vtuDkPg==
X-Received: by 2002:a17:90a:f507:b0:28e:87a4:ebcc with SMTP id cs7-20020a17090af50700b0028e87a4ebccmr788665pjb.4.1706066286535;
        Tue, 23 Jan 2024 19:18:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id db3-20020a17090ad64300b0028e245501e7sm12590429pjb.4.2024.01.23.19.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 19:18:06 -0800 (PST)
Message-ID: <65b0816e.170a0220.f71f0.d192@mx.google.com>
Date: Tue, 23 Jan 2024 19:18:06 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-9-g3d5bdaa27c031
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 2 failed, 6 passed, 2 errors,
 40 warnings (v6.8-rc1-9-g3d5bdaa27c031)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 2 failed, 6 passed, 2 errors, 40 warnings (v6.8=
-rc1-9-g3d5bdaa27c031)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
8-rc1-9-g3d5bdaa27c031/

Tree: pm
Branch: testing
Git Describe: v6.8-rc1-9-g3d5bdaa27c031
Git Commit: 3d5bdaa27c031adcd79e46503159fa720ff8535f
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
    defconfig (gcc-10): 3 warnings

arm:
    multi_v7_defconfig (gcc-10): 2 warnings

i386:
    i386_defconfig (gcc-10): 1 error, 1 warning

mips:
    32r2el_defconfig (gcc-10): 2 warnings

riscv:
    defconfig (gcc-10): 3 warnings

sparc:
    sparc64_defconfig (gcc-10): 26 warnings

x86_64:
    x86_64_defconfig (gcc-10): 1 error, 1 warning

Errors summary:

    1    security/security.c:810:2: error: =E2=80=98memcpy=E2=80=99 offset =
32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]
    1    arch/x86/include/asm/string_32.h:150:25: error: =E2=80=98__builtin=
_memcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bou=
nds]

Warnings summary:

    4    drivers/base/power/runtime.c:1823:24: warning: decrement of a bool=
ean expression [-Wbool-operation]
    4    drivers/base/power/runtime.c:1815:24: warning: increment of a bool=
ean expression [-Wbool-operation]
    2    security/security.c:810:2: warning: =E2=80=98memcpy=E2=80=99 offse=
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
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sec=
tion mismatches

Warnings:
    drivers/base/power/runtime.c:1815:24: warning: increment of a boolean e=
xpression [-Wbool-operation]
    drivers/base/power/runtime.c:1823:24: warning: decrement of a boolean e=
xpression [-Wbool-operation]

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section m=
ismatches

Warnings:
    security/security.c:810:2: warning: =E2=80=98memcpy=E2=80=99 offset 32 =
is out of the bounds [0, 0] [-Warray-bounds]
    drivers/base/power/runtime.c:1815:24: warning: increment of a boolean e=
xpression [-Wbool-operation]
    drivers/base/power/runtime.c:1823:24: warning: decrement of a boolean e=
xpression [-Wbool-operation]

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section m=
ismatches

Warnings:
    security/security.c:810:2: warning: =E2=80=98memcpy=E2=80=99 offset 32 =
is out of the bounds [0, 0] [-Warray-bounds]
    drivers/base/power/runtime.c:1815:24: warning: increment of a boolean e=
xpression [-Wbool-operation]
    drivers/base/power/runtime.c:1823:24: warning: decrement of a boolean e=
xpression [-Wbool-operation]

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
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 se=
ction mismatches

Warnings:
    drivers/base/power/runtime.c:1815:24: warning: increment of a boolean e=
xpression [-Wbool-operation]
    drivers/base/power/runtime.c:1823:24: warning: decrement of a boolean e=
xpression [-Wbool-operation]

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
    security/security.c:810:2: error: =E2=80=98memcpy=E2=80=99 offset 32 is=
 out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings:
    cc1: all warnings being treated as errors

---
For more info write to <info@kernelci.org>

