Return-Path: <linux-pm+bounces-16581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738C9B33B4
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 15:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8831C203E0
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95B21DDC07;
	Mon, 28 Oct 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="av4gBbxL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E269A1DDA1B
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126251; cv=none; b=l22Z57iwD5qn1G/3vLj7ZB9elF8WB8knVzMkbNfW4enm1AN2u+yGH+AZ4ivicsA9c7BpzI71CF0pA1CY9GqS/uh8POKWII96e3ElghkSYYs3iB3I/QfbsSJMW9Vh19gkkEOBZPQhT/jT+TemhlvdO+P7BKpfj9xTi4HtGq9AQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126251; c=relaxed/simple;
	bh=U54maMnBdvSIUxcSYvwfUfpJi1Ld/RSv6GuQ7f7j9/k=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=BwqAJmTA3dNk77pQoOXsaeSGoAUqldwbRiyrDqOL9SJlK9e0qfRne+WeB3iqYC3hDdEAEQSVOq3cGYtCLBPMK1t5+m7eXTh37cIX5R0Yw/J8smVSLuuYGwR9za0SJABl2yjHVz+KJdvmUAJqYgC/DyqfyaNCzfdZR1Cb6Ia5lYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=av4gBbxL; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7edb3f93369so2668869a12.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1730126246; x=1730731046; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jhc2Jo8PpZJTguLYFYjx2WujyHxu+sgKYYONP414Yd0=;
        b=av4gBbxLa1M2fvVzZBZQ+zcBrBUx4G73gfof17Fq5dL59vfyc/pshz1mShWaWMgRED
         4XZTKJjhN/NPQw76LE/kuGblnS95mx1AerNcq+OUm349rcsChKOzMniMYhYgTlUIqaMr
         mvgxnf0db0e88J9cQxX1C92JSeMHJkJWqxoiR88ZwRQHhWPftw/IGkzAw5/eP5HMjJGN
         K/6EwA7EvlX22Xd+cMcXQu+7nqbd/dVRMCYLxBQx0pzKADeSCXBQiyu6vT7s5AYQS/5i
         ojQ+VMncksxPVcp79bu7/guntuyPkz08VJ/rN7Wl4b78hSmkClNrRiwcTdvEbYdEo8X9
         dHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730126246; x=1730731046;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhc2Jo8PpZJTguLYFYjx2WujyHxu+sgKYYONP414Yd0=;
        b=OXUkS9cShRv8lK3yPEudTvM7NxvU//PW3mHkd0x3BPwC/jJx8d6YyWXddsuuz0TNWt
         Q/kj4WcFVFRK0hcjLfJ0FoTqKmfEBTtS9oWJPIZ3YdMgizV2mwhcXjiVKeqhMBDyed9Q
         /mcHujKyfWLpUpQh5deHLHOBH1G2zntIc0xsDS5vO9+vfXEWz5g1OiJGv6UvK7vhu2cE
         3hiIfjhT6nLJyQZff4OQr+GtKR7mv6Ai5T6ZiCBVEJd7/qbxL/wC6IFzlXOMTtIhYO41
         NYCk+WyEtaBkXMuchbc5P8N+aSl+rAGpvy56CtRrHdUdul2e1lujxWHpHD7Nesk4q+9D
         20+w==
X-Forwarded-Encrypted: i=1; AJvYcCXRoTHZ9/wnVCKhiiWlmLt8l55tahEqbCNQ4HKLTAg9vvz2bmBwxCJ2QN/nhImpgNMO6+vDVuefIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxF9IAJrK0T6qrNyqTqco1e0FsIzrUSHum0kn3wOh9NF+KJWOeG
	ky0U+jV7dFTqMq+aEL9CDtenXFKy25S56sMCsvGJeWiR/+iQp4D+thGQdwQC4Sk=
X-Google-Smtp-Source: AGHT+IGGwOwDP8SJUMlfU+tt+QYUBzX7qF2Fkbb1Ew7h2kpc/+un1khV6c6xGWw1K0y4hNQiAbws4A==
X-Received: by 2002:a05:6a20:e68c:b0:1d9:1907:aa2b with SMTP id adf61e73a8af0-1d9a83a66a8mr10353306637.1.1730126246039;
        Mon, 28 Oct 2024 07:37:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3771a2asm7250708a91.56.2024.10.28.07.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:37:25 -0700 (PDT)
Message-ID: <671fa1a5.170a0220.36f5ad.86bf@mx.google.com>
Date: Mon, 28 Oct 2024 07:37:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.12-rc5-66-g764dc1b95fe3
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 23 warnings (v6.12-rc5-66-g764dc1b95fe3)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 23 warnings (v6.12-rc5-66-g=
764dc1b95fe3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
12-rc5-66-g764dc1b95fe3/

Tree: pm
Branch: testing
Git Describe: v6.12-rc5-66-g764dc1b95fe3
Git Commit: 764dc1b95fe35f86cd4c7c156198d44eaac63752
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

    2    kernel/fork.c:3075:2: warning: #warning clone3() entry point is mi=
ssing, please fix [-Wcpp]
    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    2    3075 | #warning clone3() entry point is missing, please fix
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
    kernel/fork.c:3075:2: warning: #warning clone3() entry point is missing=
, please fix [-Wcpp]
    3075 | #warning clone3() entry point is missing, please fix
    kernel/fork.c:3075:2: warning: #warning clone3() entry point is missing=
, please fix [-Wcpp]
    3075 | #warning clone3() entry point is missing, please fix
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

