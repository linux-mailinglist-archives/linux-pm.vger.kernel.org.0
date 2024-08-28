Return-Path: <linux-pm+bounces-13009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA00961AD9
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 01:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40BF1C22969
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 23:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB3B198A34;
	Tue, 27 Aug 2024 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="S6/a+Nrr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA37D77117
	for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802692; cv=none; b=oBEk0HRAEJ+peyPSWWnC/sGDxUVIQo8AJyKi1lBLOqxkBlqD/mdgZjbTi7LUHx/poLN3vwEtM/uOZrkB1qhLHVyeP80vKUpPyEbZVX8PvbOoPI/0V62BUO0yeOJYwDFt4DTLOFo2RM5SaZaZk0/iDbFldLQV8TdMNc6AGH/Xld8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802692; c=relaxed/simple;
	bh=Mt07DPK6txQjLD1BuV9oLng7+aAR/zBF4xCRRsQHSC4=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=ZhCHzLeUCj2ugnzddDT3Og3w7Rv7EPfsxoLiftrFQkPFSH6gwttLM4SeIVP4wzCe8w9K4Un5kRuzD8ActNXg4RrUVE3elRGBzHhXyG/lTwFEi9lIDRYEFxOK2xa29pG9KsjLozh4/ThgGlI9Wh3MJ6yuj220COvNEgQQsvREd4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=S6/a+Nrr; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-27045e54272so3926282fac.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 16:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1724802689; x=1725407489; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RORDVy1JdedZCVjVhtfVYPQ79q/SQYkz2s3z62daBBQ=;
        b=S6/a+NrrqIbWRpjlQv6OSlOHaytH48Lt8BmWvacI9a9PXxV1WtaxjtZgHBxYkM70Fd
         8k54laOqqg1xLEVow7mUJwxG9oxXhN/wKqwBbrVSVwVo0KuD6qhITYruYl5jYtYifeR8
         j2ajIKTwvdot3QDKDs/EfUqZLAOq7qI8ylK66qNt0zOuco+5GpFXlnueTyKdzA1kEAtt
         NmMCA5UVCQ8o4KFTNcBNQTI/E8IuqrAnHuzhipAWum9qlL+RlS2U8F9dpdyhe1MbrtTT
         rpC9aPlrlfcqVirmwwXelV3D8EEWaAq5VgUbXueBH4hoOdWsR+sH7KhRbKwRObyJoMax
         R8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724802689; x=1725407489;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RORDVy1JdedZCVjVhtfVYPQ79q/SQYkz2s3z62daBBQ=;
        b=gWupci4O+X0wgGX4QFtnprjqslkgGx1Wn4sErx+7iyo7JkKCS3ar6GP+T9ih86IHlG
         IHR3BpbJEny7CUHAtgl+ExcsCDinmZ9mWSx5yiYZjCxZMFLTaPJKfwTWnlUxXXIpM/7v
         CgRPjvB0BI+K5vnje1k+PJG6dd3ftaon3LXj/mnlvejR3jwNlXuKjs62vn8c0HbSzhtN
         NzsZFggeSBeitS50+J67oSlXYed2dq0ncXc1x3Makl+/RnS61Gtwp5Nn2RBLV4dke11v
         fWLJCg9h7EPej1evnSf0X1mH5Xkr4FyaajoumhkHSzPh7ao9B60M2LL2ovif0mdjxQ+1
         iqRw==
X-Forwarded-Encrypted: i=1; AJvYcCW2zMjlzivYFGuo9x1oID9DC6jCySTedAHbPXwIMLKwc7JuCq+qKDS7OLOIf59KMDaPVy+RxTFfwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgDZ1IX0PJX07tRIPzRCTUAh43gtx6g+K1oimm41nYnuonznTT
	zBEKo1ZjMBGrounCmha5FXIUii+TZTY+y+gjwyaM4/B14EQRYg53b4b3LVaItJGcb6hlbRJadPF
	dOgQ=
X-Google-Smtp-Source: AGHT+IF56B/uSsAOvcDPGycHgz4ufV2d9CWrKMiOxwsyIn9/cjE1xzgInuwzN2A7euEavXCfhs0rbA==
X-Received: by 2002:a05:6870:7192:b0:24f:d178:d48d with SMTP id 586e51a60fabf-273e66f41d6mr15913302fac.31.1724802688684;
        Tue, 27 Aug 2024 16:51:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac97fb5sm9843880a12.8.2024.08.27.16.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 16:51:28 -0700 (PDT)
Message-ID: <66ce6680.630a0220.3a2de3.737b@mx.google.com>
Date: Tue, 27 Aug 2024 16:51:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.11-rc5-77-ge5be0a6c0a37c
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 23 warnings (v6.11-rc5-77-ge5be0a6c0a37c)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 23 warnings (v6.11-rc5-77-g=
e5be0a6c0a37c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
11-rc5-77-ge5be0a6c0a37c/

Tree: pm
Branch: testing
Git Describe: v6.11-rc5-77-ge5be0a6c0a37c
Git Commit: e5be0a6c0a37ceaf4ac0cc343b0d103c6491e17b
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

