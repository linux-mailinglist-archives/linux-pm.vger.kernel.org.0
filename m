Return-Path: <linux-pm+bounces-1777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9B9822D32
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 13:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B28C9B2315A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 12:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C30D285;
	Wed,  3 Jan 2024 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="pTtMnMx2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689F19442
	for <linux-pm@vger.kernel.org>; Wed,  3 Jan 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbd6e3795eso4072017b6e.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jan 2024 04:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704285439; x=1704890239; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLccUbZIGCcP0SHupasCqIR7GlneVkbwyHPzOk4+FWI=;
        b=pTtMnMx2Dd6Ib/srhSD0IBNQ/tZkns0405RlZKYcJ3rZRkRANSxfl9YPuuOziBinwU
         EakZC5Urh8VCwCMnkkNB1Xi4ATXhu72JWanpGlldF9t6LQGWodH6wRz425mjqkj86674
         +UpyqTvTXZalgxixcy7OZwoIdmm2Pfgs1FKszJ/xuE96+s/VHZzlzN7XY3EzbuW6CaUY
         az+HPDgrFty/yQR+7/U6ken5nHdIUvhwsS171trJSFiy94TVKMMSRiZhaDhkpGDlkqbw
         RGXZjoKENvVuXARri6SEDV/tYnM8hiVwbMmItYw1DZa4dzlRbpSuzV6YABxRZyb7yCr+
         1KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704285439; x=1704890239;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLccUbZIGCcP0SHupasCqIR7GlneVkbwyHPzOk4+FWI=;
        b=DCW2vmlX4JfxpG1LX9x9cQ3N9lBqB9CeFM3427HClRonoOOO7XEqbcf8qeyCmgq0Wm
         XdmYoQrdyhEn+X6HxT5InAICMv1f4Tq1f8cqPUOTtMP0/eMQL0aF4vtJIcz6pk2VRtCi
         DPEYNqbRFHFjVxS1cs0UDa0Q82HbfLEbg5j/FnZ+XmOenoJl1so2hSha70mkTqSGz8cx
         dbXVT1RgVHQd1/rRaYjDtPHdOSDSqLQ9gSp0A1p5z5j9wOQc9eHMCEOxyY5HAX0fCc9b
         Xcc3y/R2ROTHVgmiMHhk9yWp+szyUQbPg1xsTs8RhDjDWuMFr+lNOOsgS0wV++RbMUtK
         VNcQ==
X-Gm-Message-State: AOJu0YwcPVU2Y5IHnuVTKA0hNSTbM3So5cYuHYQ2BSdFU1xLtGEEIw5m
	qaJqYGuiIGoOPr0RL0z1e7CF6XAW4NCTsQ==
X-Google-Smtp-Source: AGHT+IFTWu9ZF2v9uZVIwbB2l7jihwAxH6AoOzZAtgp0S2w2f4BSwf9IzryqMfqp9ns3/l3rItK0dQ==
X-Received: by 2002:a05:6358:7e56:b0:172:e470:39f2 with SMTP id p22-20020a0563587e5600b00172e47039f2mr19823306rwm.24.1704285439651;
        Wed, 03 Jan 2024 04:37:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q23-20020a056a0002b700b006d9a4a4b14dsm18801262pfs.68.2024.01.03.04.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 04:37:19 -0800 (PST)
Message-ID: <659554ff.050a0220.863b0.51cc@mx.google.com>
Date: Wed, 03 Jan 2024 04:37:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.7-rc8-156-g3d6055242846
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc8-156-g3d6055242846)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc8-156-g3=
d6055242846)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc8-156-g3d6055242846/

Tree: pm
Branch: testing
Git Describe: v6.7-rc8-156-g3d6055242846
Git Commit: 3d605524284615c2e1d6a317d1b24b5237153b34
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

