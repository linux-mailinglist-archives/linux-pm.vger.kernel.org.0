Return-Path: <linux-pm+bounces-2090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AB3829CC8
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 15:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2271F2660C
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263F04A99E;
	Wed, 10 Jan 2024 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="oMGv0AH7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25847A48
	for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2024 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3f2985425so21035405ad.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2024 06:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704898085; x=1705502885; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GjJebbWKZRzM4pVpKcQNLZCt6Gk1F+EUX2sa1CpgFnM=;
        b=oMGv0AH7FKXG2MKYmmD3f9d/Z5vOWf21j/uib3lZUWNsIbs3sV15nMXPCN0S4MC22Z
         E/a3bOZh/ZpSx+a8e00FkiyOK5n/B7SnNPPuZT3IbDddLPC6jbumBCyXgK5D+mGVRTv0
         wJK+f5pC6lj4t7PHOuLdsJmBqIIkZTPc0FQm4MQZSwDfAdsHmDEVrxILoSGQ008notfs
         KECMetfvFJxzMCpEjqx8EFcIZ+mJlpn+dSWn3W5oCvyAFQvi7ySh9t04WqTj0WVIUMtl
         NXf3mNipHgI7oHZpJ+vLEx0iRtUVWylpkD4VEhLNxsf0YXaJgYA7Bj7/tHFOKwTWA2BD
         eiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898085; x=1705502885;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjJebbWKZRzM4pVpKcQNLZCt6Gk1F+EUX2sa1CpgFnM=;
        b=PFdB4WKjJCNjdMXYd+VdY845OFwi7MO3U6WHbVMjUuVFkYZ2teD7IdxPxGCSK+6wlx
         4om+T/iRUWEJFju7nYUiPTav7WB1mbx0KKQUE0BDySw7EcYpo5LfAttPFuAPaNr3DmQz
         M9RcxdkV3MeqKCB0Zk3VyrAxNMk3Vi5FLpsnLDrsNZWZlQrFpsUMiFoubwwonTzuBIy4
         hAPkznYWYbsfboejubRCZK57oG+LBMWdaQMMNivucNwo7TI10kn7JL+udCOyjG4sNwnu
         Tfryh9puQspR03vmiXWOJS8gIUuV/QmAZ6GsLTeTi+sQJsrZua0Xb+sdmR0JJpZVosDZ
         rYQQ==
X-Gm-Message-State: AOJu0YxacBGEEzy7m44TqSMvDubzmUSgnWtQoVb9CCPBzvJwUuKCzBvN
	uOV+OUu0O7mpbnlNN0HHtumtiXaGDEAXEpF4ZnORbl+QxSo1hQ==
X-Google-Smtp-Source: AGHT+IF/wnNlSXkkL3Vhx5Sbj751uZ6RGoOoLkr1FhbxvSkLOOwrov6B6PuDJjRq6C/xii7pnYuJdw==
X-Received: by 2002:a17:902:e743:b0:1d5:6b59:bc8b with SMTP id p3-20020a170902e74300b001d56b59bc8bmr911370plf.47.1704898085613;
        Wed, 10 Jan 2024 06:48:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090276c300b001d5389bd42fsm3749877plt.57.2024.01.10.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:48:05 -0800 (PST)
Message-ID: <659eae24.170a0220.13328.e68b@mx.google.com>
Date: Wed, 10 Jan 2024 06:48:05 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc8-180-g54837abffa7ed
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc8-180-g54837abffa7ed)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc8-180-g5=
4837abffa7ed)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc8-180-g54837abffa7ed/

Tree: pm
Branch: testing
Git Describe: v6.7-rc8-180-g54837abffa7ed
Git Commit: 54837abffa7edaebbec7d7313f744f9aff9aa4da
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

