Return-Path: <linux-pm+bounces-12649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E4A95A352
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 18:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAF2282AB9
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F8C18C01C;
	Wed, 21 Aug 2024 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="HO1KBxkm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B56914F9E1
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259545; cv=none; b=h9LTlXFBa9FHUHv6A05xVfg6Z8IvN/R0gTdNCfqIZa6BKiwGS4TfIyEeKk15eiLE/KhRr8hV4Pys9gdZ0LAAe8L+jUk50ZZEoLON/Yn/GK9SgMvXEIb+eZhF5Jhc1EmkpEgumlwZxIXx/29uJE1oKIm3mBuWILPPHxMWZmNt1JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259545; c=relaxed/simple;
	bh=s0E5EnlNT9NBZoe4fUGHwVOZ2Y3Zwz5RbRr27ApXt8M=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=t1T9yLVXyjCIcEUQ8bRErrjRhjvC1P93T+/vChoR+BhNTS0bimQh7j2qK4DI7YNSyZdG8qaOlFO9v1xNikITLeoBUpqVCkOFDH9uDsemRfitGeJ6ARZr4AVcyK8tEwo8iz+ZN7ANAIowugJn19xp6UddFAAZYP2u95GZUxUmVtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=HO1KBxkm; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5da6865312eso4648840eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 09:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1724259542; x=1724864342; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l36CdD1owOI3aADfUrsFU4OsueHVrpnEzrbbfLYjUJw=;
        b=HO1KBxkm4GpZxBL5WcORblkJY2elZZcmsuARCRFEBg37aAiSaaQNrfkXDHOIYiqP/t
         tYLbuVRzm7WIEnbIT9RqvY/+T2VaqdQc/UMdscV0yw5rc+qDGj5caY9Di1x2VG4ECTmr
         Uy1tnmWxBjgU+8sbzg8LeMCdOrOQq4ORfcFtX28p6u9IKRvsOLt4gmZY8pjxgwfy1+pj
         H2YTYljRMCxufkmDud0NP1cT1yvrkgM9FiLBq8z5l3Nxv98oPhq3XC7qsM9JJG0wBZ6S
         qVVjNX+nuXYB9L3/rCEa9Y7IJrEq32oh0Uv06CE0ke72FXly+zihIkaezZRzUgb23Q1K
         NERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724259542; x=1724864342;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l36CdD1owOI3aADfUrsFU4OsueHVrpnEzrbbfLYjUJw=;
        b=sW7YXOj+PFr58r6UKPddlydvnQlQUR18azcTQj0bJIYE+TMiGIBd/OkHKG/7GC8XA7
         iMb7hLRMXWcyUIXo5q9COrujiNgem+vQZLieJekRSIuXIlRwe6sD28FHH+t+dbIIJwX3
         l6qzySkzhFcy/XuuiTkazzZ2vCNAbRfVdQRB7xKzjse667G79ZDoCFIWHl80kirb+Q/E
         b8CsYt61d5hTf2ThABnmKfqZYpDWWts6voBXd1O0Kxubki3OljVdPTvM+O2s602yi5uw
         4B8+7s618zVxoYcfNbIh5rOD9cvp0G3naDWpJ6mpe//OJKqjqodYwl1bnpRWeXemCFiU
         laUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT5jWrx8umJ0UnA8fsIjTtx3zGmi1nB9adYb2DOEONv7G/rtlZDgb8eWJW4HgMd5zVIFfPyNWMUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fZPI567kJ1cAG7gQA6wSLn4OlWHFbvjL5oxL2QJGUpnnBnID
	Sh8LhKNyKA6pC2klc+YA8uEyPJuHqYdWXZZ2PKzeCdyiqrWihjN5C4OcMwiXnK0r3GpvLYOsE0a
	5
X-Google-Smtp-Source: AGHT+IEaJs8q17hFnFLokS2+e5UyehSqDS8ZR3it3NjOL6jD+DZBWl7Si6YkvpHw6FOMjsh9lCu4Tg==
X-Received: by 2002:a05:6870:7014:b0:261:1ed0:26c1 with SMTP id 586e51a60fabf-2737ef853b4mr3427727fac.29.1724259542259;
        Wed, 21 Aug 2024 09:59:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd8ce64ef3sm1157013a12.59.2024.08.21.09.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:59:01 -0700 (PDT)
Message-ID: <66c61cd5.650a0220.b1510.5320@mx.google.com>
Date: Wed, 21 Aug 2024 09:59:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.11-rc4-62-g96051083f54ab
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 23 warnings (v6.11-rc4-62-g96051083f54ab)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 23 warnings (v6.11-rc4-62-g=
96051083f54ab)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
11-rc4-62-g96051083f54ab/

Tree: pm
Branch: testing
Git Describe: v6.11-rc4-62-g96051083f54ab
Git Commit: 96051083f54ab00630804ce8fed69667929f6299
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:
    haps_hs_smp_defconfig (gcc-12): 2 warnings

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-12): 3 warnings

riscv:

sparc:
    sparc64_defconfig (gcc-12): 18 warnings

x86_64:


Warnings summary:

    2    kernel/fork.c:3091:2: warning: #warning clone3() entry point is mi=
ssing, please fix [-Wcpp]
    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    2    3091 | #warning clone3() entry point is missing, please fix
    1    sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso32/vdso-note.o:=
 missing .note.GNU-stack section implies executable stack
    1    sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso-note.o: missin=
g .note.GNU-stack section implies executable stack
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
defconfig (riscv, gcc-12) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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
    kernel/fork.c:3091:2: warning: #warning clone3() entry point is missing=
, please fix [-Wcpp]
    3091 | #warning clone3() entry point is missing, please fix
    kernel/fork.c:3091:2: warning: #warning clone3() entry point is missing=
, please fix [-Wcpp]
    3091 | #warning clone3() entry point is missing, please fix
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

