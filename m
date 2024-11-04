Return-Path: <linux-pm+bounces-16995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C3C9BBCD4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 19:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D313AB2366B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A0C1C9B68;
	Mon,  4 Nov 2024 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="vvNtQLlF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7025224F0
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743488; cv=none; b=oid3tVDqYAI0V/Jvi2M58vAPu3e7tCj4boVWpLNm2q6Sipwrivk52Vz3Kxe5gxJxbXWy3pusKX6K35gHO/YIUXGCdpc13cL5BI3ICmWJj4NrUpzurY1/BUgIKN00jqAHZsVse6NETOHPbCZb6pinM1+pDUOijb0XFqtE+FwdHh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743488; c=relaxed/simple;
	bh=CZ8LFMrwhDV/EHeX9aAE10rtiW4rBgvrpTlnMWGfl1Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=QolAPgLSOf0eUst2dtpmmUHepvXGHwx8Y/PZBWXbzbliD76KtW2Dhah+tsUBCYbWp3T4S6+YeEDQkkDgyFatuYa0ndNTq2hv1u2KNNd1Tn6w0hvD9gmneiuA1DVNKKUJ8goHXrhdTFNByHgibcUXDGnwp/WOCPE5R2x878uFqiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=vvNtQLlF; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-290d8d53893so2051072fac.2
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 10:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1730743486; x=1731348286; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x7X/MzD/G6tjtLADDePN3FQyWZBISBOi2ZSGK4N6FXM=;
        b=vvNtQLlFRDXY55Z7z9b7HXNaegXiBrYC33ClZ+uHNVqpog5sYlCewedeLjg3TgubVd
         8mtsVT31q7UjGbcTNXidQv61rNjBT4295Z0wq66X/waXl6+Xm69YrQNtDwiOUd0A0dgn
         WQ7hEEaYGHFD0VIi7scijPdW145hL6qKx7xbsOCelrQVfQ9IPCODKwN1UMHtTBkp16K1
         ou1iWm+uKXRfhf1Yryu+0ehIRXKWH3TYp1nMhNFmrHBWIg0MvTQpacrR/iEm1j/3lvcV
         6wwyefsrRa6489qYaVZclphGGaiGWJbIU8sN0boK+aIDCK3Tm/iWXV83CEWuOCY0pUFX
         F2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730743486; x=1731348286;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7X/MzD/G6tjtLADDePN3FQyWZBISBOi2ZSGK4N6FXM=;
        b=Ad6yAultEYcBg9b9uTTAgDQxdg/9O6XcKnnHACK1+3Ki0gmKGHrYPWDDuLcdZBr1f2
         uzA5fY9FHkVqoL9qB+Y6Cw+VZ6F6lwAyCqOAUpNhQ3jcG1P9dN3IO6PzQTPG3jg1OVTO
         6iVjUMcqdIT7v70sTWEa3+yL15yNvS7gfwKc9d0AVdQHipG522bTcOy8AhwLtNzwygSQ
         iMPP4oWb35K/HSxrk4aiHZGyKcEomlSZXqCAR/a53NGYTgR+Zir/q/nwRCkxyu7gDNW3
         l8mrn+7PVYMZvu+iJ0RUmDCf8kY1I77ulQQtNXhqW21n+orJs/efSjEnXhzfWnbCPcri
         k0fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVFE39iDcdVK17nTC9luZ2IRQdiLdlh+yQbffjNphbpY6STflM8jcYrDshVHZChr/7odVoLuPgKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy16KzbP64xDtxss0bSrHrvHar948f8LKuB1otv5+9wVKdCAwym
	5pTyKTAXecz8r5pzIqxd0B0s0qWRel7quxWYf2ZJPnhBXoXxRgn4X8NGEabFzUI=
X-Google-Smtp-Source: AGHT+IFvuBYSw0I7sykoLdYbHw1CHfAVOdotD575woMTefPVBNCnQXtFdMi92PEmDWwU65EDeOObNA==
X-Received: by 2002:a05:6871:6a0:b0:25e:de4:9621 with SMTP id 586e51a60fabf-29051bdaeecmr28803463fac.24.1730743485857;
        Mon, 04 Nov 2024 10:04:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a0081esm7402684a12.59.2024.11.04.10.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:04:45 -0800 (PST)
Message-ID: <67290cbd.630a0220.3b06d1.05d1@mx.google.com>
Date: Mon, 04 Nov 2024 10:04:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.12-rc6-98-g57d5fb99dade
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 1 failed, 7 passed, 1 error,
 24 warnings (v6.12-rc6-98-g57d5fb99dade)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 1 failed, 7 passed, 1 error, 24 warnings (v6.12=
-rc6-98-g57d5fb99dade)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
12-rc6-98-g57d5fb99dade/

Tree: pm
Branch: testing
Git Describe: v6.12-rc6-98-g57d5fb99dade
Git Commit: 57d5fb99dadef3680372de9e1d3972dffb1ec800
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Build Failure Detected:

riscv:
    defconfig: (gcc-12) FAIL

Errors and Warnings Detected:

arc:
    haps_hs_smp_defconfig (gcc-12): 2 warnings

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-12): 3 warnings

riscv:
    defconfig (gcc-12): 1 error, 1 warning

sparc:
    sparc64_defconfig (gcc-12): 18 warnings

x86_64:

Errors summary:

    1    drivers/acpi/processor_driver.c:273:9: error: implicit declaration=
 of function =E2=80=98arch_init_invariance_cppc=E2=80=99 [-Werror=3Dimplici=
t-function-declaration]

Warnings summary:

    2    kernel/fork.c:3077:2: warning: #warning clone3() entry point is mi=
ssing, please fix [-Wcpp]
    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    2    3077 | #warning clone3() entry point is missing, please fix
    1    sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso32/vdso-note.o:=
 missing .note.GNU-stack section implies executable stack
    1    sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso-note.o: missin=
g .note.GNU-stack section implies executable stack
    1    cc1: some warnings being treated as errors
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
    1    arch/mips/boot/dts/img/boston.dts:136.23-177.6: Warning (interrupt=
_provider): /pci@14000000/pci2_root@0,0/eg20t_bridge@1,0,0: '#interrupt-cel=
ls' found, but node is not an interrupt provider
    1    arch/mips/boot/dts/img/boston.dts:128.17-178.5: Warning (interrupt=
_provider): /pci@14000000/pci2_root@0,0: '#interrupt-cells' found, but node=
 is not an interrupt provider
    1    arch/mips/boot/dts/img/boston.dtb: Warning (interrupt_map): Failed=
 prerequisite 'interrupt_provider'
    1    arch/arc/boot/dts/haps_hs_idu.dts:68.16-72.5: Warning (interrupt_p=
rovider): /fpga/pct: '#interrupt-cells' found, but node is not an interrupt=
 provider
    1    arch/arc/boot/dts/haps_hs_idu.dtb: Warning (interrupt_map): Failed=
 prerequisite 'interrupt_provider'

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-12) =E2=80=94 PASS, 0 errors, 3 warnings, 0 sec=
tion mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.17-178.5: Warning (interrupt_prov=
ider): /pci@14000000/pci2_root@0,0: '#interrupt-cells' found, but node is n=
ot an interrupt provider
    arch/mips/boot/dts/img/boston.dts:136.23-177.6: Warning (interrupt_prov=
ider): /pci@14000000/pci2_root@0,0/eg20t_bridge@1,0,0: '#interrupt-cells' f=
ound, but node is not an interrupt provider
    arch/mips/boot/dts/img/boston.dtb: Warning (interrupt_map): Failed prer=
equisite 'interrupt_provider'

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-12) =E2=80=94 FAIL, 1 error, 1 warning, 0 section mis=
matches

Errors:
    drivers/acpi/processor_driver.c:273:9: error: implicit declaration of f=
unction =E2=80=98arch_init_invariance_cppc=E2=80=99 [-Werror=3Dimplicit-fun=
ction-declaration]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-12) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-12) =E2=80=94 PASS, 0 errors, 2 warnings, 0=
 section mismatches

Warnings:
    arch/arc/boot/dts/haps_hs_idu.dts:68.16-72.5: Warning (interrupt_provid=
er): /fpga/pct: '#interrupt-cells' found, but node is not an interrupt prov=
ider
    arch/arc/boot/dts/haps_hs_idu.dtb: Warning (interrupt_map): Failed prer=
equisite 'interrupt_provider'

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-12) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-12) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
sparc64_defconfig (sparc, gcc-12) =E2=80=94 PASS, 0 errors, 18 warnings, 0 =
section mismatches

Warnings:
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
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
    sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso-note.o: missing .no=
te.GNU-stack section implies executable stack
    sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso32/vdso-note.o: miss=
ing .note.GNU-stack section implies executable stack
    kernel/fork.c:3077:2: warning: #warning clone3() entry point is missing=
, please fix [-Wcpp]
    3077 | #warning clone3() entry point is missing, please fix
    kernel/fork.c:3077:2: warning: #warning clone3() entry point is missing=
, please fix [-Wcpp]
    3077 | #warning clone3() entry point is missing, please fix
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-12) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>

