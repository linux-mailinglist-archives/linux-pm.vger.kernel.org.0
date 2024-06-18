Return-Path: <linux-pm+bounces-9511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2668C90DDD6
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 22:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B042F2829F2
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F259176AB9;
	Tue, 18 Jun 2024 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ADP+QVuk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7094D8DC
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743888; cv=none; b=FT7osLCGHquFmnjE7kCehJO8Sx6qwZO+5f8G9FQsV3dDwtxMWiAZiSej721JoIG/zoOeJXrekCURxg/q1TlOLarNEhBUgOSH9jfAYq9bJyk6EUdkzYyRhx7VHRtBl8rpvRJFq6TqGjQrjNgQ/cUm6Za0XcgOvHnTUvyR9leJfKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743888; c=relaxed/simple;
	bh=iX067yiZbsGJEZmcXLehLra1ysS6TN6p65FclWa3f7s=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=fmJisZGXRU1OnvGb69cxbVPLDKNnbbTbkkyfF42Pz4OjDx9vqlOZ1Bmx8n1yUgs7No+uD5IB/YJvscTcNboierFDHVFKYcP4hhflf2OUTI62qQYHyLSJeb9iWKe8sx+f+CRU4jWzlHWkLkog6UASXFvWyky4we/YUc+9/c22+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ADP+QVuk; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-6e41550ae5bso4368432a12.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 13:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718743885; x=1719348685; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rUGdfv4fnltuZxTiymCq32PDwHt+qydn8kALGXZpZrE=;
        b=ADP+QVukcxKhj8jx5uJlxGShDwdqw1qh74rN+ykNsPpdBimMVRjQvdTjfrJ+u5rnqt
         0sO1k3H62ZbW+e1dtssepznH9So+6z+4x2KtJNB/U7/v2ynGpe15NkP3IuOgQi8RUQU5
         f+LowkSi0+MNh12tTfSNQkpuEufk5NPJ47C7iYSx5YbpRjElyn5KDaePPUUB5TlKCAut
         hk9hpHRzfyLrgy3Rc68C+tvbdWpxWViZcE5Knp7Y/cOm7oQLFATcMOTR+2yKEiQBZxZy
         GjgeDcB3tTDE55fABFF2N45wxRsxJZyb4dzHWlm2P/9OpkcWsrwbTozU7xgDyqsxEm4y
         kl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718743885; x=1719348685;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUGdfv4fnltuZxTiymCq32PDwHt+qydn8kALGXZpZrE=;
        b=orp+bQQn55NQCO2dXT2eNeXNWmYiPKEHM1CWrAYU5O9ASesiChT47ovy/Q50ZAXfxS
         Fp5w59ISVQnSh0286N0ftzZHpz7qF98wlTWjU4dg6oyIFL2ttyw0I6RFORIddJfFIR19
         XpsGRyIDneMNpWw/BSiOjMXbnQKIqM9g+k5s2ckbUqSaPdfjFaKtZ5rcJh81obUCjlDG
         NXN9pwTGSY94Wz2jS2Cqhojpd6Octv8Ls5p+2dAQRsHh6r/0h1NfhLj0oP10ws+k2Aa9
         Xfp527+Ux9rY+tlneqGKwMg+HlqBElx7W8hOxmnq58E20pHvXVwdZ5NEF4XiJ1RgprnU
         zXuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyytI9g3vhyyef5fikEHr41cVfTygUrtL1wDJiSAmjHopMkoIEpc8Zhwkf4JK/0DexP+SgQxx/PgGY0nXzS8LuhOaM39mB1iM=
X-Gm-Message-State: AOJu0YyFvPAPSKC1jx8gsNhtueXj1skInzo5Lw+sqTIPH//4e2RCwmN2
	vWF50HFUXe1MgfINI4WeP+43tOzTS1MkUIlNrnNGmi+e+VSe/F3LSijF+3iCpUE=
X-Google-Smtp-Source: AGHT+IFkhyZNsU8iI2rJFkeXH3I/m90F2GKtJhgwCGGpey8KChKNWR+FFnQv7KmOtBMYBtRB981Vuw==
X-Received: by 2002:a17:903:41d1:b0:1f8:3c47:9d9d with SMTP id d9443c01a7336-1f9aa3f868amr8162595ad.38.1718743885374;
        Tue, 18 Jun 2024 13:51:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e723fasm101573775ad.97.2024.06.18.13.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:51:24 -0700 (PDT)
Message-ID: <6671f34c.170a0220.d86a9.cc04@mx.google.com>
Date: Tue, 18 Jun 2024 13:51:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc4-72-g071560a0bcce2
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 19 warnings (v6.10-rc4-72-g071560a0bcce2)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 19 warnings (v6.10-rc4-72-g=
071560a0bcce2)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
10-rc4-72-g071560a0bcce2/

Tree: pm
Branch: testing
Git Describe: v6.10-rc4-72-g071560a0bcce2
Git Commit: 071560a0bcce264edf11c46e56fc38b6475ec6f9
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:
    haps_hs_smp_defconfig (gcc-10): 2 warnings

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 3 warnings

riscv:

sparc:
    sparc64_defconfig (gcc-10): 14 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
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
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 sec=
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
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0=
 section mismatches

Warnings:
    arch/arc/boot/dts/haps_hs_idu.dts:68.16-72.5: Warning (interrupt_provid=
er): /fpga/pct: '#interrupt-cells' found, but node is not an interrupt prov=
ider
    arch/arc/boot/dts/haps_hs_idu.dtb: Warning (interrupt_map): Failed prer=
equisite 'interrupt_provider'

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 14 warnings, 0 =
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>

