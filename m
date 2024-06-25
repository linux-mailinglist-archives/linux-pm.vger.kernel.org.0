Return-Path: <linux-pm+bounces-9964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3508B916E5B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 18:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582EC1C22D7C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 16:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778EE17554C;
	Tue, 25 Jun 2024 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="XQveO9fA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7073174EC6
	for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333892; cv=none; b=RitpwDTKJg38w2q+LWLu4jX3f9sx1G+xf9qGdCmRoNt7bZ8LfyT5vIEZpSAMQFXiT5VZ1AhUHyMHZA2kHqurrsZ0FZ/3EY2PyU/F95dBk3PEf8LaIqBXdPDgPMD+2mSicxk48ChKKvfk+phD9MYGGk162fLgORDm2KurGkgE164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333892; c=relaxed/simple;
	bh=WNelr6wFmmH0X5ZX2SBsoL4rdJIG5GYv+B142pLn45Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=fsogpBXN4XSZriOoIqpAF5xh/7lzLRkGU/ueA8/BTxvFAPpzOb45UUcFFwzO2tNSPZETSNg0btz3KOrVA8yr3IH5eTcAE2DP/C1q6sEBvnqn7VhSoB7hoTlfKZfcjtvpVO5Tf0iSX30fK6guAss59gPGm0TgBelTIV8UDaFFA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=XQveO9fA; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-71871d5e087so2735024a12.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1719333890; x=1719938690; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RCFCzGsBX8sUcrI/Ljtr8/NcxPRsr9/VKNiOPUCUjR0=;
        b=XQveO9fAIZomDyAdiTIq8cQW5kLPsvks5JeNhiN3oU8EMtTdszmVcbMXz6owNuq79a
         i+ZgcA64MfpOvj+xOyXdqvGgfuXp53WktIgNEWb+0/7Jhj1VsgHq80BB733cqu3x2REo
         dEdeuQZjDIYKhc6sVUkF8Os/VmTafSyUpCfddMW2EnANAeBJw1HVGXyx+aeu1cmGbL7F
         w38aYoVhzWyhSWHLWTlCeXpKD40OM8nMm05Dlc6CIYD07mkw+Cdqo0KDVRTkT+suSCAv
         a45xfMTElYkQHvcKHnKDdiWaBWBEvpod2mdkamTR8e0ZpTKyNM5tM+UmOVRYWbTD2lUJ
         4z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333890; x=1719938690;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCFCzGsBX8sUcrI/Ljtr8/NcxPRsr9/VKNiOPUCUjR0=;
        b=Sb/4pioWp6x2nM+x0VA/p8FDsl7l6eLkq+3wrU1f8Vs2b6lRVs8z9tFyAHODxm2R9B
         KnXbOVuzZkhRvHsMNR03LjeZzudf1cbkrVGYRrMkmeYalsQymBQi+F42/87xRBJXRf6h
         jiAisocT1An6/FH5rRCOgzSbadLjy9wjq9SOldDH2H2Gqj1TGb+Cd6JhfOd56FYn29k0
         SIAz+IRuH3hjg97o1TSsaM+/aXA5AIU1USKTllY1k99ctAobSoTedbhsPSLGrP2F1+Rv
         KwmVRZluk4/dGD4y8mOlnLiN0r2MVbhjbQToUu6zFOjIpFqhYGcmZbS4rEL2J1w0S7pB
         p14g==
X-Forwarded-Encrypted: i=1; AJvYcCWTY/w2egQtent6tRF4vjTwEoxertsk6bXIdtmtKoYZJPq7lazlXI70DlKaUrekrmWvQcB/yYaClm09HKDG5IPjHC/Kk2cvUlY=
X-Gm-Message-State: AOJu0YylhpJFOEPTyCibz/nbyjjfbbQfGEHGGsoH3/8dkujZ01X9WWMS
	6g/F6O8BowWdAnoBVn8k0puOnjcsgKLX6eyJa13GojNdnEhR76fjEkhvddjjTnw=
X-Google-Smtp-Source: AGHT+IFyAiXutdWHESjGp16oxGzOjMJQtVKgMF2us4mMLz7cRjmWbIvQxLJMTBNMTtrN6sx2HgH3Fg==
X-Received: by 2002:a17:90b:3907:b0:2c7:ab33:e01 with SMTP id 98e67ed59e1d1-2c8582090e6mr6725655a91.27.1719333889719;
        Tue, 25 Jun 2024 09:44:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819dcf123sm8923244a91.54.2024.06.25.09.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:44:49 -0700 (PDT)
Message-ID: <667af401.170a0220.d4a5.736e@mx.google.com>
Date: Tue, 25 Jun 2024 09:44:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc5-104-g87b765463f765
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 19 warnings (v6.10-rc5-104-g87b765463f765)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 19 warnings (v6.10-rc5-104-=
g87b765463f765)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
10-rc5-104-g87b765463f765/

Tree: pm
Branch: testing
Git Describe: v6.10-rc5-104-g87b765463f765
Git Commit: 87b765463f7650d4f687276e2570b9fa651032aa
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

