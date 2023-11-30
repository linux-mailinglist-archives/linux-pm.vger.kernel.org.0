Return-Path: <linux-pm+bounces-534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 134ED7FE8F9
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 07:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25B2282237
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 06:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4909F168AB;
	Thu, 30 Nov 2023 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="SntodaYC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E3DD7F
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 22:08:05 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b88f2a37deso361796b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 22:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701324485; x=1701929285; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0UnkxZ8hXhHV0JhpwuYKXm1BNxJIMlcctZRSb/EvMM4=;
        b=SntodaYC34wESZJm6MgqjXXS6/353X9znUG1qFK774p/I1OQ32ISTO1eUOO+r42TEM
         azrRW7fql17h5OjDWbsvYLIiUdlKXt9QoPm5w1hq85DlYHqudLsLRebPWYpFZt7JNFxL
         a0ZvL8Z9MzxdU1EXwilCR+chuzagaNvYeauQshbzEdhwTeSRYIfS8dnq9pRL8jHDWFb2
         f7o+brVk5YQokVSuN/VjM5yBP6SkV3zdUFeiRje76OA4pfiYfA2AjPrZEmRwt/EmyPPD
         kI6r+m2IYiUcDn3dBRmUXVvYyjPFtkpw6hl4tBs+8qCna4TC+jB8NyxeyNSxGbsmR/jC
         FEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701324485; x=1701929285;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UnkxZ8hXhHV0JhpwuYKXm1BNxJIMlcctZRSb/EvMM4=;
        b=TzE1NvHotNAC7ytRuSDOVYmYX+4lYcFB64zhEnwpxUoe3mhdQ0JggRgWsxQUBnRBLH
         1+PwKRaXXzJW+kwaZ9/r4KmrSELHcX6AD8rQ817c+9525vSNW68ASU9i0Sohj5m4x2fR
         VbErohecfVb25675Gup078tzOISRrbmdEz1zKZlmKsoa/35FVgpdxC/jFHBXnqtScPSO
         oSYlAuKxqIbYp3CiX2nUB6hU7T+RNTuSDjaWg/09xDODRf1FUfTxSZAgbAHsSt93qBLB
         4zoerYlBjZXFjinJQmOll4PKs5Pv8TCTO1oueJNz4U1JykjUSapbOrAM+xGQc+NBMhAj
         TmDQ==
X-Gm-Message-State: AOJu0YyLuEHd6txIQgh1ZS31DoR0ZFu2eMiYbX0QjblF6OYeDX/cQ/Ob
	G3AMMsmHU9fAE/tTfGSJiSMsmA==
X-Google-Smtp-Source: AGHT+IEm7qCieGkOxYGgdyOIN4eBdMT+KoY6P/u7gLw23Lq9+38/O6qbJ+4g/cu3JYuQOcGAuB4JgQ==
X-Received: by 2002:a05:6808:1304:b0:3ae:126b:8c2b with SMTP id y4-20020a056808130400b003ae126b8c2bmr27169569oiv.30.1701324485322;
        Wed, 29 Nov 2023 22:08:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r19-20020aa78b93000000b006cdd39faaaesm389089pfd.20.2023.11.29.22.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 22:08:04 -0800 (PST)
Message-ID: <656826c4.a70a0220.c232f.1164@mx.google.com>
Date: Wed, 29 Nov 2023 22:08:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.7-rc3-56-gd9670e2b27245
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc3-56-gd9670e2b27245)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc3-56-gd9=
670e2b27245)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc3-56-gd9670e2b27245/

Tree: pm
Branch: testing
Git Describe: v6.7-rc3-56-gd9670e2b27245
Git Commit: d9670e2b27245a223eb61a1636e87b169570786c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]

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
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
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

