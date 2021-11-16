Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5FA453B6E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 22:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhKPVJx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 16:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhKPVJx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 16:09:53 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3700C061570
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 13:06:55 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id o14so267202plg.5
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 13:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nZhvbzsjCqtS42dLH2V0fPl3YTcwnbs+WH2x8zbaLQ0=;
        b=0ezVRfwsF2XBorbRkpf1qFzyyYbYkVLLrhEVgh+YajBU6uNF0okf8Og9NmKwwbbWFM
         UByenMCjL4+Te7WlffnlcqZtCDtCwkYElwAUQyQT/S2dUBXcvrChwWUqnBhvZMgECNEF
         irv2s9/lFRY4uJ1QpBWnwOhQrMTX/Ty1p8TotgVFTHDqA0kl1no7EUW8y+T506PV0y7z
         7Vs/R8NwQntI4+9zcO9NffGQyedK1kiET9N2r1OOrciocDT4QCfRzfFlYH6L9hXdBL0h
         g/DUkmkjr28mwCPNlO/83s64alOhPswMfoGlT8QduGzcWnW/yznipURX9Um20BwOtQv1
         R/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nZhvbzsjCqtS42dLH2V0fPl3YTcwnbs+WH2x8zbaLQ0=;
        b=UifX4WsVHk6drqpC14tn1fhxLoaMr7C0b3e0ktRXQ00xqEQjXTp8F8eBMt6rkeHTZT
         RcOGbic8l4UG+P7Zpzp1T3r5fOJkq+SOiD9rjDYRBLfqqZ7Gl89E0PBPKSZJEYrLgRVC
         BWRNvJzv11uPJy4+i/c7xgGfL2cY4fN8QOG8VKZq238nDMy0AQYm1kQvAkVVkUao++UB
         /j/W4i1ygjkXxZXRcQBdCOygewp67hw2YuFSPttFz0M8Z4m6tsA302Z0L9D2ZmEaOyBw
         1l/mMsRpbEXQybLteLZ2W+LlcMTZTP61GWa39Ah1rz0lrQlPW0iNgB58TmntFdXnjLzz
         2rZg==
X-Gm-Message-State: AOAM530yWCkteo1L6E64riW/bqJri0jdWo7nLsGQnRcNeyk/PXp4lM00
        SFZBzT38YnWViSap+dy6dpXPWg==
X-Google-Smtp-Source: ABdhPJzZjobgrMndTaM8CnJgIbSZ4KyBTKFvUa0qxkRfJuwONXYVsVkwLMgfBZLTMdPiUq9GjUOYJg==
X-Received: by 2002:a17:90b:4d0c:: with SMTP id mw12mr2489740pjb.209.1637096815478;
        Tue, 16 Nov 2021 13:06:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l1sm3142297pjh.28.2021.11.16.13.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 13:06:55 -0800 (PST)
Message-ID: <61941d6f.1c69fb81.7278.97e7@mx.google.com>
Date:   Tue, 16 Nov 2021 13:06:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.16-rc1-12-g273b3dc3453c
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 3 warnings (v5.16-rc1-12-g273b3dc3453c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 3 warnings (v5.16-rc1-12-g2=
73b3dc3453c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc1-12-g273b3dc3453c/

Tree: pm
Branch: testing
Git Describe: v5.16-rc1-12-g273b3dc3453c
Git Commit: 273b3dc3453c1f8a58528a8c44d3bd8a973aba1b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 3 warnings

riscv:

x86_64:


Warnings summary:

    2    <stdin>:1559:2: warning: #warning syscall futex_waitv not implemen=
ted [-Wcpp]
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
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 sec=
tion mismatches

Warnings:
    <stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [=
-Wcpp]
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"
    <stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [=
-Wcpp]

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
