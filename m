Return-Path: <linux-pm+bounces-416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF8C7FC3FF
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 20:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA9D2B2141F
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 19:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02383D0D7;
	Tue, 28 Nov 2023 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Zn81qiA/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83601BC
	for <linux-pm@vger.kernel.org>; Tue, 28 Nov 2023 11:07:45 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cfb3ee8bc7so30578515ad.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Nov 2023 11:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701198465; x=1701803265; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OpFBUmRU4CKJMoFztCJs4gxwIQzHEBjYZnKbmTIoG60=;
        b=Zn81qiA/mlXNtwgDNfX+xFuxhhMFN+wyycEz2amJuPQppntOrtsFHBJtx7hwCO/V5X
         6C100e57r+zfcJ/u/YZ2LfPRuWIBaNET3Ruh0KR6vutuEJqMv2dS24iAMZ6aab/KCwhu
         SecXFGrLOVIYWDurnaRwEevrbRzCNFPlbY+e5o3YU7vJ3aSv7rbGb5HB5uvdnzXe9N28
         uek9qXYhoyHjVh8w5lZqYirhDbPlvMa+NyoIHt5ypJn6NMCmar16p8dOzb+1uxOwX+lK
         rVfYiCb83VTQekQIL2NTnt8cDhdvwkFYarSU4LOmvrjanDA6Cigu6Souuh7IPnoORSiz
         Nlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198465; x=1701803265;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpFBUmRU4CKJMoFztCJs4gxwIQzHEBjYZnKbmTIoG60=;
        b=XzG6p2fW2s7GQrgYisHpTaa6WU3Zt10hY7EYz6H7o4vMQZIsEDEeG1HxFO7tYyCA03
         waBvyQF/OeP0gsGTpO6l0sNCOtoj6OhEDvo/lp4Pc8mVLcdrAQs1YVzesfQWFHi7zmgA
         f8VA7a46WshUpzmz6QwLNMaj9ls9z+cgkn0kbugX19x1EL2nUtsZ0emwyAGIWthXB08L
         f6KAxZmXlvwUSLYAXtfB8TIUiNBxHadchxDuMljtsjPnPlJjPlbWdwrUm8NnQO+D1fLe
         PbUtzmJfA2V2rZLMy9pkhCQDuROwkT+83yuvdYRrWQ/cxdZz6zgksTX8Z6Pha3Bst5LC
         9+Bw==
X-Gm-Message-State: AOJu0Ywuh0aLHr8GsTBx6R986gMTy5K/qGLojO/aED7TTt/2XpihKg4L
	SsDe1Cfef2r6n4bdzXTapxQVqQ==
X-Google-Smtp-Source: AGHT+IFk2yKeU1ejkWDt5T9IUmv6H1gJVcC++gBBQNjoCCKuQRZhBh7peDs0K1yLmMkSGPgdbXF9Sg==
X-Received: by 2002:a17:902:d4c7:b0:1d0:1257:d35b with SMTP id o7-20020a170902d4c700b001d01257d35bmr272416plg.67.1701198465141;
        Tue, 28 Nov 2023 11:07:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i1-20020a170902c28100b001c739768214sm10721099pld.92.2023.11.28.11.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:07:44 -0800 (PST)
Message-ID: <65663a80.170a0220.20fb3.b15e@mx.google.com>
Date: Tue, 28 Nov 2023 11:07:44 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc3-43-g3f96bebf018e
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc3-43-g3f96bebf018e)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc3-43-g3f=
96bebf018e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc3-43-g3f96bebf018e/

Tree: pm
Branch: testing
Git Describe: v6.7-rc3-43-g3f96bebf018e
Git Commit: 3f96bebf018e0e06c7a3ec604f487fe95a878ed3
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

