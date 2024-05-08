Return-Path: <linux-pm+bounces-7643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C858BFCF3
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 14:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2AA1C2172B
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A9B82C6B;
	Wed,  8 May 2024 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="kV6ly0R7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3C3D96D
	for <linux-pm@vger.kernel.org>; Wed,  8 May 2024 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170610; cv=none; b=DndFLKB53FPsTFW6KMi7Ps+K9O3ez3Jcn9S8s0gzglnjBlrUp5Oiv27SeLFHJum669clURc0ERxoeVDWkUtWaHo5o2mT2n1duVGcQP/A+COJHB6u2YEdBjOwJwM8OahWKeEoSQYJW4t+QNI8NHiUf6fZ/d926R4gbyl8LPbE8PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170610; c=relaxed/simple;
	bh=z7FVq19euXMAOFQUGEwz4BJC5fBSXGd4q290/NG+v2k=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=ew5x2q2R1GOUxls46PGVoHNBrD5qak5gRvZ3nvihXKyjSMI+WVdYKJQabu4EccsHG4Pxgz0pv8Cug2/r9RbdLxEql3Ng4uOZXu66ZVGBnlxXtQKwhpyhdsYkEXOeX/le/EOk0oES/d3vxgmdGVCTgZmwCTFErT/Ua+qA3jgWo7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=kV6ly0R7; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7ded01aa1d2so200711139f.3
        for <linux-pm@vger.kernel.org>; Wed, 08 May 2024 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1715170607; x=1715775407; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOKC7NMYLCcgRGAEZ39kg/D8n/Bl365qwD6fUpAFel0=;
        b=kV6ly0R7k9jo5yMWrCuIbLWFMYUGmskGeD1Vot8w5R8ITLton63JkQ/YS/0UWlktbd
         0IxVo1GOjhzWmSO3XC4K9Lw1ju8zPMAdeQg5B3GQGdbqPYrLcId9qNvRiBTTa69TwlzH
         MGfMIzPQRpNNfyr1bEE9Y0T3Id+rEPRmotzgNN5JxsDeWXlCfc1hRUyRBQPWkNnKrQlx
         ZeMle5lpVk5JrFafWbactgd7g6rsnS1jxolgo+xqpWlOh0SsZWxIb5rP8Mf837JoENJK
         zvDzc57RI+qqBuiK4uStZq9bas5WETgQASiCjKBx4UIweW0kZNuUPxy5yXpzBvHxgZQ8
         VlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715170607; x=1715775407;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOKC7NMYLCcgRGAEZ39kg/D8n/Bl365qwD6fUpAFel0=;
        b=D3TNiwwjwGDq9HVOdo9pXOpNRoT8Vl5FzPzzh7X/Vy4rzPAaTb3L4LqiUlr0mMu47C
         f48Vi/NWWmY0r8GpiZ0JaxOc/KlU8D3oqerTeBEcQYsx04w2pcpXWHRW9kAW0qQAR9Q8
         Nwghz2X1XR+mAgiVcvyoqB/dDb8Ljcp6qmkqaJH+s3q3p1KGxtuLmdX+AHcYqEuIrmKJ
         je3OPlQ62HIpXQNleaMiOnLJw0brPLr1qbtPs67HKX9WNb7dwAWzTaTP3VO622SPh6qm
         IzdArP0ZjXLzUsCs1lwQfx3XrRxWAPAU82MrZylndS3anXe5h5VBJuprwdNeTkWCffYD
         yJbA==
X-Forwarded-Encrypted: i=1; AJvYcCUB3o4K1p8c5E5trToGtGtVWZBFN1xa/Li/yHWVQB5cc6xkU8VyhlbXwlIwDVV7l3JR6483nl3IGnWwYajQiJCUHy0JJX406Jo=
X-Gm-Message-State: AOJu0Yz5zKBcqNUE7sinFsYqNWSOG3xgRq+1IgajaImyXcgPXRxETxwu
	fuB0qjD8Km+8thbMDlZ6nVfpPSKVu303ThlmV9W3qRaRf/g8uammnrXSnePxwJEy4b0K4gts5vr
	U
X-Google-Smtp-Source: AGHT+IGYb7g82LXooDNAfysDDkxf18zEhw7C+AjowF+ouh5wXxQqAyJ6n7azTAsmDkuAW9nRHqDBeA==
X-Received: by 2002:a6b:720f:0:b0:7de:cdf2:7f21 with SMTP id ca18e2360f4ac-7e18fd9c1e3mr239098039f.16.1715170607278;
        Wed, 08 May 2024 05:16:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k3-20020a6568c3000000b005f75f325db4sm9937815pgt.29.2024.05.08.05.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 05:16:46 -0700 (PDT)
Message-ID: <663b6d2e.650a0220.51da.cf02@mx.google.com>
Date: Wed, 08 May 2024 05:16:46 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc7-227-g3ac65ca623a5
X-Kernelci-Report-Type: build
Subject: pm/testing build: 2 builds: 0 failed, 2 passed,
 26 warnings (v6.9-rc7-227-g3ac65ca623a5)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 2 builds: 0 failed, 2 passed, 26 warnings (v6.9-rc7-227-g=
3ac65ca623a5)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
9-rc7-227-g3ac65ca623a5/

Tree: pm
Branch: testing
Git Describe: v6.9-rc7-227-g3ac65ca623a5
Git Commit: 3ac65ca623a535166a652c292d43ee959d71d572
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 2 unique architectures

Warnings Detected:

arm64:

sparc:
    sparc64_defconfig (gcc-10): 26 warnings


Warnings summary:

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

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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

---
For more info write to <info@kernelci.org>

