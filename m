Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1346DA51
	for <lists+linux-pm@lfdr.de>; Wed,  8 Dec 2021 18:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhLHRtb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Dec 2021 12:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhLHRtb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Dec 2021 12:49:31 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05653C061746
        for <linux-pm@vger.kernel.org>; Wed,  8 Dec 2021 09:45:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so4466433pjj.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Dec 2021 09:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=er08tZoeYaCQ6Xik97/bRHhFv4Up3gz8A6vxwNo3jbY=;
        b=Kr5BKPXJwZDgbvz2+SVMdh2iehNg7hM/3cQmyR6meCMeK7TWeXbfpSGBvcfz5Y5O72
         Ea1iJClySG76DbW5P9omWz2Qbt6c/8icHgwRBv8GpRR/7Z1YTnzimQpri+ePdzsjfScG
         WAoltqHwy3gKSvroHeRDs9wr1ffZSUJ3rze1rdGYT8/QNithiAm5tlM1rfp/YjOp+Ep1
         tveGT7kkPTgeCY7X6Cp+3xEncWF+uMSOB4R9q9e6e42ueF4sKPjH1FBl4SJeh1nONh3s
         4+vh1O0J8yl0/OW1YPscHD3BwVpxmgQqkOM+YugXMHS5PbKTqW/jMoOH1hQY1soEPXxG
         T9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=er08tZoeYaCQ6Xik97/bRHhFv4Up3gz8A6vxwNo3jbY=;
        b=Wg9SLXRFsYqxAK5jHiZBjSF4pWwVsKgguXzWLUSsj9uHSiCavlyGNmiqEKWQS4KCVq
         Td0hqNN4dz/lhm4xOwNRcpPX+4mqga/XbGsa62DyQV3CqY58RShJOpIn6YjTJLy+J9FX
         lNf3jZ2WqWXYNBCGsD3WumHK2yZkcWxMqIN8LbnABB1RgesoZR6HLBr7rWVpWNk/RjR/
         AokscvE+0e4QHe2NSST32zZS6Nrx/dYl1aIqavRcQabiaDfyTa7v+EoR9n+mNsUwmrbv
         3OOM4TeqI4AytixwZenod4Iv5qgAjh8EhTuIruEkm0VWU3MUOCMDeT40+dUfent2IMKp
         6zwA==
X-Gm-Message-State: AOAM5309k9ivWDAXr4FNZOf1yVphuOXv7f779e4yQuwTRFtSiBuMkyvs
        z4vCpkDArlQ1F+k1roJEvFKUbg==
X-Google-Smtp-Source: ABdhPJzv6MH496cqldJdtC5u9n+8uj/WWocFk75c1Bcj84XTczfn0DawTnQiv9VcmuggdosL3kNO2g==
X-Received: by 2002:a17:903:410b:b0:142:497b:7209 with SMTP id r11-20020a170903410b00b00142497b7209mr61884833pld.9.1638985558558;
        Wed, 08 Dec 2021 09:45:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s14sm4460102pfk.65.2021.12.08.09.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:45:58 -0800 (PST)
Message-ID: <61b0ef56.1c69fb81.c2062.cc62@mx.google.com>
Date:   Wed, 08 Dec 2021 09:45:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.16-rc4-42-gc4f4801e994a
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc4-42-gc4f4801e994a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc4-42-gc4=
f4801e994a)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc4-42-gc4f4801e994a/

Tree: pm
Branch: testing
Git Describe: v5.16-rc4-42-gc4f4801e994a
Git Commit: c4f4801e994a1697de4c30ac9afb749c396e1c2e
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
