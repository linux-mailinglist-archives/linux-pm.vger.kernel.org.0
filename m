Return-Path: <linux-pm+bounces-798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E73808B94
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 16:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6C41C2099C
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139CE4439A;
	Thu,  7 Dec 2023 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="JMv3t4WH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED30219A
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 07:18:06 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d0ccda19eeso8299055ad.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Dec 2023 07:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701962286; x=1702567086; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2lHnNYpRPFPbaU3AAmoDTQDjfRG+7SXwnb/QDYdCrzg=;
        b=JMv3t4WHqyZy5MIEA9exk/TjswfMt0DIASxPADHzTq7pVzYhQasQeanOV+/fok3q2s
         yKvvDnaCaINs1t9JzY+msObOqrY8D7Pe9PUo7G3xfxp4QhYnd6vzWDudXiMs2uH51ix/
         HOOINKoQiDliixc5mvaAMjVnkwWvZrVuvd+sThIKu8/vgjmebSGuR9eIrrjMG5HMNXn2
         2DPLV4oqe6CJ1a6FDJHSGwWiNbB2Q3ZyS6UiE9RAk89vO8wGMSiP+jvJkCkypwriM/ke
         aMnp3Q3h8b3Qr1gbGMXT7Pduqr/IkwlqZPRRBCuOeCVROA55f4X9ZxboEBh3+qJj6beU
         t/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701962286; x=1702567086;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lHnNYpRPFPbaU3AAmoDTQDjfRG+7SXwnb/QDYdCrzg=;
        b=Kp4rnmAt3GzUZ3ANJMsUWLB7QTRc4Z9xyuabx2nXP4G1GkJbJ9ylEykUyVlqZ3rEO8
         Fj8HbGEfo8SSo8gpOA1z8aVwZ5lLZqmB/lKn8aZAF894JAz4q8UvykVq+5M8P6vS+prJ
         6iB6RpZRzGB8/1cPcgeQPs0bMJFi9o7d6KsvUbI6PrmgbkjVpX898ZInEKZ1Tfbv61Rg
         tHHAUZXCjsAKAn9N/RlXAUGE3Gt3FchJ6OpXg4Vt8+sYQ21mG4Ga5dgzCgRn16Z0dXs7
         dCB2stpvOjrLhsBVJt+z/bCmWw2mlI7nkQhl65EfpHOJ46o3E7h0SdyJFrIL8UAO9NrL
         r5IQ==
X-Gm-Message-State: AOJu0Yx9DNIHJdkExZNFYC2Ab+E6Y6Ree9Uh0e05Yhc5ySBiFfNwvn7E
	yFFO0s7a1fOT9EXkvQ5eWQow1f2usCawXs/Ty7UksA==
X-Google-Smtp-Source: AGHT+IGb1g0ebah1zliNKGF/CyOovOzerHffMsM8V/1MHyjwsl3q1c+MFs1uaMc/pdS6dzXYzy9rDg==
X-Received: by 2002:a17:902:8bc8:b0:1d0:6ffe:1ea7 with SMTP id r8-20020a1709028bc800b001d06ffe1ea7mr2251154plo.138.1701962286350;
        Thu, 07 Dec 2023 07:18:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b001cc52ca2dfbsm1553086plg.120.2023.12.07.07.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 07:18:05 -0800 (PST)
Message-ID: <6571e22d.170a0220.f5646.3a59@mx.google.com>
Date: Thu, 07 Dec 2023 07:18:05 -0800 (PST)
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
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.7-rc4-65-g4a0bf67f43421
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 4 warnings (v6.7-rc4-65-g4a0bf67f43421)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 7 builds: 0 failed, 7 passed, 4 warnings (v6.7-rc4-65-g4a=
0bf67f43421)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc4-65-g4a0bf67f43421/

Tree: pm
Branch: testing
Git Describe: v6.7-rc4-65-g4a0bf67f43421
Git Commit: 4a0bf67f43421e410b2c3c7471ce01f263033ee2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

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

