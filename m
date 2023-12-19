Return-Path: <linux-pm+bounces-1380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 279CC81905A
	for <lists+linux-pm@lfdr.de>; Tue, 19 Dec 2023 20:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577491C23EED
	for <lists+linux-pm@lfdr.de>; Tue, 19 Dec 2023 19:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEF81C69A;
	Tue, 19 Dec 2023 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="2NGcccd+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D164E37D06
	for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d39afa1eecso30322545ad.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 11:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703012866; x=1703617666; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vAsC8vGX7ofpOmLQsbrwnvi8vccdoxxGDxxp+67vRMI=;
        b=2NGcccd+l3Uy2TSz9dvA9NN+c3wUZAqH0C3x25WVPEZEmDPYeteyA7MMbxAGDD6XFB
         hwpLWMhs8AGTCKVBOGi5r9v9+Akk2Oxo9PDddGTP+Grl/ca8Fx8MgA/N1A2xx0E24V1j
         hEkp5LZxSmCa3wei0dg34/Wt9dSnAzr28wGeFIE5K27tlvyOwJA+QudEw5Lyo0WOIkBl
         W/BZZez5uDatBXcrLeQAM/VvcXwv43bn0+6q3Wpcnp9ryUgHTysfCmhCYCX/PQ4Filup
         IYyd8Km0C2yTSYvo7Z3c8Mee9HQCAB62KasYMggSXX3eO+PzrAoMY9uTrR4X91G9jfAp
         3mCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703012866; x=1703617666;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAsC8vGX7ofpOmLQsbrwnvi8vccdoxxGDxxp+67vRMI=;
        b=UA1Wv2S+g92CcL/Lf/WaIecFnuT+VP8faG3Dj4dAlxBSEHt15Gj6ul0IV29U5TMyzH
         O1S8CmRhI/Ci5T/mCvdc+Ajld0kjX2GrTkd5BrhgJj5tnPTCtpC9uqe56JFjorFJVZm/
         uGZvCA+EmO2LwA0LqB77ZNYrmIDSdqa+hhu6BCQm4Y41UOXIZtrUT1b1N0jUO/7g3uJG
         3r74XzGBwduqHFILK5wbWgJFnMzycslBpLQQpMLJwn49b6nGpMQoKUfxrL3ffjFA2RO1
         YSd1tSi8gviNgJ6jxkUQBoCTeGR6/S/zaHnm5v9L33Y14zefg5xvaENhoACr7zyM9Nb5
         8uqw==
X-Gm-Message-State: AOJu0Ywt5b8uD2o417fAn5LbEoGDe7Vz0JaKnnm2Ivdt4vX3SGUIemT2
	BFCfkpWMvo7ASyfc9FgZfgE1dQ==
X-Google-Smtp-Source: AGHT+IFSSpPEaH1bO0bdvdwytbAnn1pEvAcRWBihSqSM9Ck9kUurT7uh/ZDPKDFbzsRTfz9pnA43qg==
X-Received: by 2002:a17:903:2350:b0:1d3:eb29:4a23 with SMTP id c16-20020a170903235000b001d3eb294a23mr385582plh.84.1703012866170;
        Tue, 19 Dec 2023 11:07:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001d3561680aasm7211487plb.82.2023.12.19.11.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 11:07:45 -0800 (PST)
Message-ID: <6581ea01.170a0220.5230a.3a45@mx.google.com>
Date: Tue, 19 Dec 2023 11:07:45 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc6-87-gfb3da63feffb
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc6-87-gfb3da63feffb)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc6-87-gfb=
3da63feffb)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc6-87-gfb3da63feffb/

Tree: pm
Branch: testing
Git Describe: v6.7-rc6-87-gfb3da63feffb
Git Commit: fb3da63feffb7968ac26d869f9caad0a1f06f0ec
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

