Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5660542D05A
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 04:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhJNC2A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Oct 2021 22:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNC17 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Oct 2021 22:27:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E14C061570
        for <linux-pm@vger.kernel.org>; Wed, 13 Oct 2021 19:25:55 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x8so3103459plv.8
        for <linux-pm@vger.kernel.org>; Wed, 13 Oct 2021 19:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=7dta8HyjGUnWF3jAumiBTSkJXxPdlOBgxAI7BKGT32M=;
        b=zqcXdcMjccQ/RO0QYGVt/em4+/Xs+CdRKSsTf0MWcfnmBYabiHj3QQ1HGpBzCXEV+h
         5h5RQHwjMO8EF7EhX7SFSMY+xpu5zoE+4Ry8FV6jRbLbT78OUWbwQ6gWOQxTgzygHiGN
         OIivb/4jnETwI0kb5HytqfSkgkXqe1S3/6PAjb61A3AS3kttZyYMf1zJYZXj1nqSVArI
         p8n7JWPrdwbFjylQ32V3ws7jHr8KsrRWsRZmH8VwMbWdzewRSKoYcsq//7cpn+FzDpQH
         lVWeR+oPrt57eThSbdfliZ7xorjfIawwl2bPvxpyUjkGo6FLNElfeBgjsbk5YN3xmuje
         kpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=7dta8HyjGUnWF3jAumiBTSkJXxPdlOBgxAI7BKGT32M=;
        b=jjAdVp2IKtqzqn5ywUiRO0QiJHT3D8KjWZ22VfU6xv6H2ZnQm0RtH6toZnqi+EX2st
         nHiwfnOEvXRJ+c/SRPT9EjYfxIiF64sUTu2bKx5EZoMJHrZErsLb0tC091LNVu/tLk4v
         +3rEhA24e7SU01Q+CQQpcI+F/COCVaZ2Z3OyYEAfh4x0UWfGjz/njg6Q+mJhhRbPVy62
         11Gh2zN7gGzAD2c7oUiCktx9LDxQCDasrbGqvEuNPeYuZSiNc8t/X8SzJ0dbceYP+tS9
         vIlSi6reT8sgnmy1HB41olsGqXoCyuRz3sMUEdknOmGAXvYepnuomhLkwObjQptqqRJz
         1D0w==
X-Gm-Message-State: AOAM532pgVhbLtj3q1bBxXWU2m9M9UKWLW58Y/gn1xODq1OeDH7K+LBx
        c7a7Tle0h9kOrM7AGBizAYgYKA==
X-Google-Smtp-Source: ABdhPJwTlTwbJ+u4z4in3y1QEDLHzoLBzmkrYzofw6AK4eP0Z2vtBFbYWFtQluGvAzFjZWPKIkw0Aw==
X-Received: by 2002:a17:90b:398:: with SMTP id ga24mr3395191pjb.87.1634178355505;
        Wed, 13 Oct 2021 19:25:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i13sm759214pgf.77.2021.10.13.19.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 19:25:55 -0700 (PDT)
Message-ID: <61679533.1c69fb81.c2e31.3925@mx.google.com>
Date:   Wed, 13 Oct 2021 19:25:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.15-rc5-53-g1b3dc77d7595
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc5-53-g1b3dc77d7595)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc5-53-g1b=
3dc77d7595)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc5-53-g1b3dc77d7595/

Tree: pm
Branch: testing
Git Describe: v5.15-rc5-53-g1b3dc77d7595
Git Commit: 1b3dc77d759553dba8e4842113a61a1a7de4adce
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-8): 1 warning

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
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
