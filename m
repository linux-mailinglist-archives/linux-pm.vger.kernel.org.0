Return-Path: <linux-pm+bounces-206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A387F8693
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 00:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C34DB2137B
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 23:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56017364DE;
	Fri, 24 Nov 2023 23:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="c9uOgo3x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDD21735
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 15:15:38 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b2018a11efso2315093b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 15:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700867738; x=1701472538; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uy+793CV4Pqoo743qyQu3iwwiDdsR9zvnIGUZnLxkks=;
        b=c9uOgo3xN6zPaUVL1K5/nWl2fvqE1/9DfXzKPRM8kcLbWi29K/SnmnpeAOb0G1aJWG
         OGUbqqT/YmZ9ZLxxoMnjEq6D0YAyJpF0Mij5I13P4/znDRU7NbWF2eGRZ9DPPA26oB2Z
         pDO/JBDFZ2/Ktx8a5rh49+Pzvcy9dTTUOb2OJpEkVXwZ/aGHMo9lv3BM+zyEC008cJTl
         o9CiCWU+1p/PKELflDn6v2SSV3rQcuN7638xAyofowMki5W/kg2q/UJzOuPdw2UPrXye
         +QhzP75nyqf8Z3pzDbN7H4zj7VrRxSO0wPdagUkEJE+nDf3BHI/jEhf91PYAE5ngBzgX
         mFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700867738; x=1701472538;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uy+793CV4Pqoo743qyQu3iwwiDdsR9zvnIGUZnLxkks=;
        b=UNcWqo7p5SArGUiHiXuzjlmkwqbQGS7+P/FbFINxhECrkchotblDgt1Y7n9yU/a2gH
         eWgxLcsLiT0mBzWVuISvq6iL8jXKN96u/T8X5XfymCpsbV0o96nUl57a28aJerH7iW1X
         7Hw6yh4f64VLx9OHGWTn0GanCBjeK/AgfFNbYNNoGuQmECoHngP6IvmJIvfszaubyXDU
         +dHzCtrSYXIjXO0lY+P3x8o46QFfcyRYjWhvKkoHdFmWcQbGAPmgcITe2XPEePC4Hnf+
         jCBEpND6psrhaS/U8BLEJDp9MHYolVZKUJ+UeZvCXCQ/3JJ1BnTOnKvA+vTW/kuYiehA
         2Knw==
X-Gm-Message-State: AOJu0YyA3sU1wqt3AxD262m+ispb8PLbHybUJC2CfIJRczAZFA+4NqgN
	V3ZxBcGfaUWGLp/qWmKqPb5cTQ==
X-Google-Smtp-Source: AGHT+IHL8tld8j9++rDkUwqEsSwqthE1EY5dF/cOQTVuO8jZjvOBy0wK49Vs6e1ByrwaJ8/QaOIBVA==
X-Received: by 2002:a05:6a21:3606:b0:18a:e4fe:3b8b with SMTP id yg6-20020a056a21360600b0018ae4fe3b8bmr4247571pzb.19.1700867737851;
        Fri, 24 Nov 2023 15:15:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 18-20020aa79252000000b006cbb56d4e58sm3334265pfp.65.2023.11.24.15.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 15:15:37 -0800 (PST)
Message-ID: <65612e99.a70a0220.9cc29.87ff@mx.google.com>
Date: Fri, 24 Nov 2023 15:15:37 -0800 (PST)
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
X-Kernelci-Kernel: pm-6.7-rc3-40-g9795b7a7c21ef
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (pm-6.7-rc3-40-g9795b7a7c21ef)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (pm-6.7-rc3-40-g=
9795b7a7c21ef)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
6.7-rc3-40-g9795b7a7c21ef/

Tree: pm
Branch: testing
Git Describe: pm-6.7-rc3-40-g9795b7a7c21ef
Git Commit: 9795b7a7c21ef0f9dca1ace3954513e2b1e58c96
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

