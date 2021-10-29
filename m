Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944E7440431
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 22:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhJ2UjX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 16:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhJ2UjW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 16:39:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3779C061570
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 13:36:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id s24so7608495plp.0
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=MGQYZLRsHEcO23nfBccodDoInLk+NNsFIhGPGy4wns0=;
        b=EUJ/PShJLGbNLUQl4WBbOYzMODanJltqfzUXRNLcKAY9UAtmTDUZJjJtxLfYGl1+5W
         P70irSRh1vaBwYqEw6BQzLBogQhx1KPeRmMkAQG+wNlCvcoGrsRGAj/3+ISy2B7ehpva
         lvXWOZ06m8OnDgVrmJLKD9VauMPbWQGqOarZddMAL8HJJxDfTaZ62prH0l6CCviGV8VA
         cIoZ/TOgqSzRw7mW/aLIlYDIFjAvGQ/gcx2Z+k5VzRNr2OphyDNZzvGmY2iGRdNwkemm
         uQXlyJQkAbbnmI8Hpuap+NJE7gMVKyP+Up7Kg76XME5Dg4sJDdEEXYBd/9Vz7oX6hyBQ
         vu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=MGQYZLRsHEcO23nfBccodDoInLk+NNsFIhGPGy4wns0=;
        b=QOUkzN3sMaWxrldJIDfPdK4rpDHH2U8FVsblYZNrGYAB3kJ9LoqnqXhWpndJlFJUTl
         /KMlsSOvYDXx2QaVqBu1O5bFiTUbnq8o/Xe/VneD4tQ83qTpkkEvJ7pR2q/6FO6FRnR7
         dYolWCHhIsG0gXQbfXeQ51NEgghuvYJUKd1jZAZ/dHSMiMvc/HBfuWVLkJf9Bk6xS0TL
         3QxFCFM0WGYaktd5PN0aEFHiGssUSb7wVMRrbDZVFdu9gAT3UlXNOs62gZkiAgK7J1cb
         Ey8gfPl5rMato/9JaV+jLkkFAgo9wX1g7vxT5B/Mr5QHJQE0kV886pLXWRXs/4StFoG9
         iR5g==
X-Gm-Message-State: AOAM531+HodohYCF8JC7PucjkVv/MlTFJ8q9+X1Pk7dcF1zqIE0s3VJP
        jG/zfM299ow4aBDmtonr3nBlhA==
X-Google-Smtp-Source: ABdhPJz2c+eYZfJDVFLxbjn8ORPyPHdl+7gpHFFmrkzQlzwGQ2b8a1eybfLakfyALFdP7Eoq7rpllg==
X-Received: by 2002:a17:90b:3b88:: with SMTP id pc8mr13474260pjb.93.1635539813431;
        Fri, 29 Oct 2021 13:36:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id rm6sm6951953pjb.18.2021.10.29.13.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 13:36:53 -0700 (PDT)
Message-ID: <617c5b65.1c69fb81.60c9a.42fc@mx.google.com>
Date:   Fri, 29 Oct 2021 13:36:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.15-rc7-122-g5f6ba0ff183c
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc7-122-g5f6ba0ff183c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc7-122-g5=
f6ba0ff183c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc7-122-g5f6ba0ff183c/

Tree: pm
Branch: testing
Git Describe: v5.15-rc7-122-g5f6ba0ff183c
Git Commit: 5f6ba0ff183c91ef793c5db5da532357e7b0ba5e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:


Warnings summary:

    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
