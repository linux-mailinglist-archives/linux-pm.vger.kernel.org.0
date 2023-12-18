Return-Path: <linux-pm+bounces-1291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA34817659
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 16:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4156D1C244D5
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 15:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2128E3D57F;
	Mon, 18 Dec 2023 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="SoaR5zD+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0246042392
	for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ce934e9d51so1648015b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702914735; x=1703519535; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xRTTXKwsjJet8ZkeLHXEyVsnly/+Y+ihhaRVJKHSVpQ=;
        b=SoaR5zD+Nt22wAImoKGjWaV1CxcGc8lJ6bN6ZEwwf/ZK0LzQQMxMmiEyn8U3UrxuNp
         dP0QbBluWFhgpuwP5gmgU+rINehoQYgdtNjZWRTuEFoHusCiCBj1WYpgD05P7EMwPT2n
         pKQ6Ww+mL8WrJDN87514pJFJB9Aq+jzc1oeiOnDSK8xLtbDiKEPBk94PevZU2N3rh/Go
         lyNev8yZPxTrTwiLdNAkr35Y2cjLVPIvZ4eNh52Lmmlj8GMwL41swkTmGFLLv4Q3wRDB
         Ljoiz1wbNTqpyhRtenzGe94snvF668p9l8D2v44xuGyJqc1rNriYTg3IvxyoHthfGeyX
         hNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914735; x=1703519535;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRTTXKwsjJet8ZkeLHXEyVsnly/+Y+ihhaRVJKHSVpQ=;
        b=dlKgkbcXKCHTD03KoHNgaWx8pSaQI9swnHBnHXTG5z4Sst5Gp4UwLjDNOuRKSYCZYS
         y4ewwQE99q+LJt6AiuB3x5n33VuHACIwpO+4LYKGOKqka62LBE/OvsUZs7cEPDl2zcTh
         R0IfEHt/aGmVJqbbZvMzwHH75CtD2SF96LDEiosKYpDB6Ejrt7rFzNBPP4kXKUFCZSon
         CbAsUra/M2EX/kL3ncvZtXzMb0Vbm3midMnH5xV0G4+L3RBMLERs4SZtolGeVgH8aB29
         Zj1fwz1Z1JM1L84BvZE0XvatE/Pb74lrEyLIsWQgD9iOFc8Ek9eJYIi36ghKhgLXIPP+
         DAEA==
X-Gm-Message-State: AOJu0YyFB66NvLY7j6ES2Adb92g/GCfvmeUO0eCThvbdAge8Kzy/tOH3
	v7CIlF71gVCYIAwee/ZaPT7Ce0P+ZmbEqdSs7+w=
X-Google-Smtp-Source: AGHT+IFeOqO6/R+ITYvB9oqZTCMeVr2JNfPaB6Ag9UCkTkczfjWk4XyP/+Z49DTDlSZcT5rvPYCB2A==
X-Received: by 2002:a05:6a00:124c:b0:6d6:e6cb:770d with SMTP id u12-20020a056a00124c00b006d6e6cb770dmr911002pfi.62.1702914735190;
        Mon, 18 Dec 2023 07:52:15 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fb7-20020a056a002d8700b006ce7e75cfa7sm1791867pfb.57.2023.12.18.07.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:52:14 -0800 (PST)
Message-ID: <65806aae.050a0220.f90f7.4b92@mx.google.com>
Date: Mon, 18 Dec 2023 07:52:14 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc6-87-gfbcc41b787013
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 4 warnings (v6.7-rc6-87-gfbcc41b787013)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 7 builds: 0 failed, 7 passed, 4 warnings (v6.7-rc6-87-gfb=
cc41b787013)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc6-87-gfbcc41b787013/

Tree: pm
Branch: testing
Git Describe: v6.7-rc6-87-gfbcc41b787013
Git Commit: fbcc41b78701321b5d7ba64b77bd1c19981d001f
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

