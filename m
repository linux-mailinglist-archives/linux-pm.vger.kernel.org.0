Return-Path: <linux-pm+bounces-766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979EA807963
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 21:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF5F2821DB
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 20:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416EE365;
	Wed,  6 Dec 2023 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="lG/jWEvq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C58512F
	for <linux-pm@vger.kernel.org>; Wed,  6 Dec 2023 12:32:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28865456abbso211284a91.1
        for <linux-pm@vger.kernel.org>; Wed, 06 Dec 2023 12:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701894723; x=1702499523; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K8Rucb/OpNefoDF1HnIbCZ/OCdftI/NIFudtH2jW+zI=;
        b=lG/jWEvqlwu3lb/Ps7F6Rb72ZldvEy+mbq6vfSEgVMKJLOe1Fhiuc0nRdDdDFWO6nm
         z3/zcY799RZpcQgoFq7Ymz9Zii82xyJYi6DJKYMoRq/hwgyVwpy1k1A0oUqfq48oZ6ho
         7oXDINLeBoKt2kivtq0Psb4OtiXZsjUNnqJ7CCOJ1xA6SjyWwnF6DJP9TLnm7aydNWXi
         7lQrGd3bfMPPfaqb+ZC/h4zJ9u27j2kRSyiwXMnPu1eaUe/DQea6708qPPAzeEaiL7QC
         i/KRZ/GrppLmMVcgqxXLbbPHj1GN0CyCzozaVBlG2ACrg8lxG2cGCyYilStsuP9dF50D
         Bmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701894723; x=1702499523;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8Rucb/OpNefoDF1HnIbCZ/OCdftI/NIFudtH2jW+zI=;
        b=RP99laRKcxEDoRBDpzPIkTybi8AslmNIfZHUtMeCzYQEkVBpY43HcYYEQJsviLSPKx
         RyXXLOOi1/YJI9qeP6EAG8oJEB8VcRX1Pxp4o32smmm17YDYdwLeSdRnLQQkBy1qtYbp
         I9AQ2kpbVuK8ZIDzlitxfPcmWp/IU1x6eBHzlbcDZjggHK8JDMUDkWYawfhRhSCpk1xT
         ljaO3nDOfk8s5w+qESava3VAfUcjjRZSzbl8U3ng8XrDiI7v/vq/6aF8ZOCmWIN70g5v
         CAMLQI4tHSjuiP8wvrQoJtShChrqqftMUtNkT6F15NoMajDhEC9sHGnLThJqVu5wUcE7
         6hIw==
X-Gm-Message-State: AOJu0YzbMzCEGo5DYEPMOwVenrCY9zjaYYJXr996ZSAo3HjKUPu/SB59
	JQnRhuSI3HA7nciD+COAS+rrvA==
X-Google-Smtp-Source: AGHT+IE4Wf93J0BKTZwH85H/Ptx1fzY8K5NllvtNAdeGuiLclaXoj/cCY2NFE3D0JCo2g331DdJX0A==
X-Received: by 2002:a17:90b:310b:b0:286:bff2:c41b with SMTP id gc11-20020a17090b310b00b00286bff2c41bmr1394549pjb.23.1701894723504;
        Wed, 06 Dec 2023 12:32:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id rs11-20020a17090b2b8b00b00286e0c91d73sm226822pjb.55.2023.12.06.12.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:32:02 -0800 (PST)
Message-ID: <6570da42.170a0220.5243e.1413@mx.google.com>
Date: Wed, 06 Dec 2023 12:32:02 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc4-46-g358f5a2a7f791
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc4-46-g358f5a2a7f791)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc4-46-g35=
8f5a2a7f791)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc4-46-g358f5a2a7f791/

Tree: pm
Branch: testing
Git Describe: v6.7-rc4-46-g358f5a2a7f791
Git Commit: 358f5a2a7f7911f1eff8eee8d1b593ffdca14eba
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

