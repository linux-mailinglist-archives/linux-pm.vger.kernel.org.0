Return-Path: <linux-pm+bounces-9225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3BA90979B
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 12:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46BF1F2280E
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 10:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEBC22067;
	Sat, 15 Jun 2024 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="KM27k1xZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664AC1849
	for <linux-pm@vger.kernel.org>; Sat, 15 Jun 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718446864; cv=none; b=Mrj6ZFv6vyy6RR7kYsvZxj3cUBWaS6WMZKPfvPQnjmhnhrLxPy6N640LYU053oW/TrELvJUQtrgNcwQs9ETbxJ7xTxZQeyDHFbqeDL025b9oxvHWm2953K13OqGKE6r+QG49gpBmW0NzMQ8tOVUohm1fKWXac8skJWU++/amo5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718446864; c=relaxed/simple;
	bh=Mfd5Pf8uXXTou/0M5Eoi3PY75/+D3kMtYTbgR5YPvr0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=gzKiyWyT+ftrEgt7Wsc1O6uPLLZbsM8g0G+Xs+N26QhoDL7O9j46POJZcuDJpUpveniE4qi1oX9gK+s3GqLdIen+HQcfe3KSNzFyeEMBhdRHoWJmtrS+SYyINA7vHRtEM92p9SGY8AdeAvvWj9uQvmPS3778YzsXeGtLGTStsU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=KM27k1xZ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e3ff7c4cc8so2231544a12.3
        for <linux-pm@vger.kernel.org>; Sat, 15 Jun 2024 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718446862; x=1719051662; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q3v54kjO3HZlyD7LW1No/2jtN1nuu20p67RV4tomL0U=;
        b=KM27k1xZnEYHBLo9H6f6EVhehn/k8UpqvKSbn7k/h5CbjhWo3RjvBcKa0EwwosXYMw
         s4IFmBQGp0rmg5XouF/a6BRVJqTVOvZ9oKkpj/kHTfk/BdMfMxl0vLZZdLuZu7lrcJ/y
         gM60s3mPZvM0K32xHItgoQJGTNHWSSBwDVl6gQIc3/0KUJKam7JH+YjY1v4EbEMgdVOB
         d1jY+SxEV0bqZ7DLYihvjryCZt6cO3mRiN9AX8fdq1Q/E+seJjD/wC4tKJzMq29AiRPP
         RM6Pv7qf/oaJpMOAYJEU0KAW5mU0XycA5Y8Pi7t1XaNA8PzG7NK6qtRsjoTWqWAUrZ70
         Mjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718446862; x=1719051662;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3v54kjO3HZlyD7LW1No/2jtN1nuu20p67RV4tomL0U=;
        b=hiYMzNG3s8fBs34jGiTf/b5nta5eWRyJzkcVkMlNYsCkQwAl9fhw37p4UpOlhVEXN6
         CDSdyuiOT0BmZtvI+j2bFl4S8ko6r8YUL6QrhdLD1R+YWwrXdjVdt5HW9TrwG/feY78b
         ecM0YKzD5Uwq1ySGOGIyqeM+ftPboVvqlZ4GNyd0i+Hnucssx0VcELmSJdJtfDVHLEID
         juZFK7G8kXaq2tQfJl06zDSRLv7gi38pYhiZsQOHFkV4kT6UdF2n/sHBhoVee3w3uuyj
         sllonB39VjApuVbQ5lVAf4tuobpljRRkDrwu3avdrSnKfGnwGnPQ91GTD404zgmpUTBm
         xLPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8BhmmUDhdYx2sbS3Mb36tg+X8ERVZzZJzgaVm+zVg5krb45q2GKfAcO5Lg71VHRpjDuYba6Sn+k6SEDhTEVFxIsTaW3fbT3Y=
X-Gm-Message-State: AOJu0YxuIhp/0fbesDXhXUTMkl+EbFoKwB5P6wEAfUVBKjzmQedFwmij
	YZtJG+a3LAjMNBM7CCERAZqUttsiU1A4aH03n6RijP/MgYI1zrwGKRGpuvFTozw=
X-Google-Smtp-Source: AGHT+IFb9onA2HpwQvspcfy08UoIV3z3rm+NC+KQSJoMwP23vCgQDVc/vIB+i/KzQfxOzqO/65Q9gg==
X-Received: by 2002:a05:6a20:a125:b0:1b6:98ba:8de9 with SMTP id adf61e73a8af0-1bae7d97c2dmr5848549637.7.1718446861569;
        Sat, 15 Jun 2024 03:21:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c4671099sm5453021a91.38.2024.06.15.03.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 03:21:01 -0700 (PDT)
Message-ID: <666d6b0d.170a0220.a48c6.05a4@mx.google.com>
Date: Sat, 15 Jun 2024 03:21:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: pm-6.10-rc4-72-g9b51b9b194ae
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 19 warnings (pm-6.10-rc4-72-g9b51b9b194ae)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 19 warnings (pm-6.10-rc4-72=
-g9b51b9b194ae)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
6.10-rc4-72-g9b51b9b194ae/

Tree: pm
Branch: testing
Git Describe: pm-6.10-rc4-72-g9b51b9b194ae
Git Commit: 9b51b9b194ae8977f6d39ef24099797ab0ebbdc0
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

