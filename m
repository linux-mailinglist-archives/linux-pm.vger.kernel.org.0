Return-Path: <linux-pm+bounces-2120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27F582B052
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 15:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23BA1C2124D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 14:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA0A3B187;
	Thu, 11 Jan 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="H+HrSrlf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948143D542
	for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d50d0c98c3so37513965ad.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2024 06:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704982189; x=1705586989; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l7ZSRPh2OpESjLd0uhmvAyPCKfE2pKLc9icDiFUCXjg=;
        b=H+HrSrlfOyRMcIo3Oa/0yUYpuBzhojGksaWcE9MFFpFKB9JEVi5wb3uJDY1AMQCd7q
         kL/0bp/B7DRI7Cqh4gtrgxcw0bVljrbiiglzW/kHddKOnOKXivHAyfHYN3q1wgPGRICM
         MUgo6DgSb9H2nmRpCVRRYCi+ft5bO0j8ABv8Tf3HN90rMTN4sXyW9NKgtTnRfVYthNed
         fF/eXAowCeegqgDpPyZAaZ5w7amBqoFJbWe3uOKVCx8k0d1mDZCTmg/Nh1mSZPiDlKAh
         vhByhKYkGtPxX40uTPRDzugqEWG/DkPUejjqBNejFKdwDBMkHKDRDwSxgsN3Pu6MWm+j
         XXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704982189; x=1705586989;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7ZSRPh2OpESjLd0uhmvAyPCKfE2pKLc9icDiFUCXjg=;
        b=QMAGO9EcFsCEbYM7sxKrxORMC+dCaKYA3iF89I21q/Suhon9BsP0gYk5zWIoyNeGok
         qcaelvgKjNs4cDPOgelWrIInYaAPbmTmG7pwgiOerVN3y5eDNVxA5ZornV4UmVpJdbH5
         +GByTxhIxakafISrfms/n4MDPZfvlrgIOvjjl3SfSfkuF0HzP5eEx/sFOQV6Rap5Zt/H
         1XbhYlWMptpK+5iX8TM3sZxcPM61BfQbPWPlrV3udsuQozy84+xvCq8EAS4IkmTW34Cd
         vGbC8nnTHUy1D+iq6oKwOEbUwrj80/gujVRDJiWlNHynxchOmTlYuD5RPGhO1NzdU8/u
         +vXw==
X-Gm-Message-State: AOJu0YznizejKNqxvj88rLB7NgBJmvk76dXSNAgJqwSmGvc1vmy/j5QO
	0Hm/ALH1THTFi8wtqSNR080egEtJJ6sqAg==
X-Google-Smtp-Source: AGHT+IHPu3jAHanNlP1naOfs+ebaUMNlApqBle3JbtdjpeLtJgJO7aeoV+f7W/2MRCShNKBOT3P+Kg==
X-Received: by 2002:a17:90a:fb85:b0:28d:fd67:fa9c with SMTP id cp5-20020a17090afb8500b0028dfd67fa9cmr154616pjb.37.1704982188870;
        Thu, 11 Jan 2024 06:09:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id oh6-20020a17090b3a4600b0028cc9afaae9sm1580750pjb.34.2024.01.11.06.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 06:09:48 -0800 (PST)
Message-ID: <659ff6ac.170a0220.72251.3e65@mx.google.com>
Date: Thu, 11 Jan 2024 06:09:48 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc8-188-g2bbcd5ace0c78
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc8-188-g2bbcd5ace0c78)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc8-188-g2=
bbcd5ace0c78)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc8-188-g2bbcd5ace0c78/

Tree: pm
Branch: testing
Git Describe: v6.7-rc8-188-g2bbcd5ace0c78
Git Commit: 2bbcd5ace0c7837ee4de185d520ea81e3e4048c0
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

