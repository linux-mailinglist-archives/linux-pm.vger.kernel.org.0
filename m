Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B791453A14
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 20:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbhKPTWq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 14:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239686AbhKPTWm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 14:22:42 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A42AC06122C
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 11:19:19 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id q17so20597plr.11
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 11:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=tC5c3ACpJcoxPsIIe7zhCBXUfWXlKqjNJoytfdemBJ8=;
        b=ajDjV3U1riUV33g9Wnow9NB7j0INjE/wH52Izv7UzLmrMH0Iom5PkUvzCi+qYMYQPt
         vgszkYAeLczDViLn7V3SD69HdAEpG3qmN3s7V9fZMabqc7Rw7YazN3I/d7LJv+vZQW6B
         Ew8RPncyfFQqhVulXLN67gTXja1mHwGbKT7jeTmPdgSmeEnIw2gmc/p9L/5AXXWgB9Iw
         preIfziqlJo1vw1M0E+f2KHsAtYtORY5XgBUAf+qABfnfdbgzMbasIVgzS2NbyGepgCz
         W2Z19WPIbVMSW1sp6M9OFKMBdLJeK09GT9r/PsFRv18ZahHMZq/kDap5XG7mLXr78yk/
         6Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=tC5c3ACpJcoxPsIIe7zhCBXUfWXlKqjNJoytfdemBJ8=;
        b=ruIeyCA35dHSzxM3I9lHL25i3KR/oFptai13QEI94KirbspW6JoNeSHX+0VyTq7rfR
         gBjqVSTS8I/T8AK6sN/Cyin95y/3RS4ovulou1MnQ5ONTBfOBKUC1xW0+/GK1wsX5Yaw
         U7nwmoNJ2cy2ZyJxjz6YTAJ9s31Nwl4snuiH9ifdQcitNa3/RFaiJikghJivPCZ3vVf5
         JUUJbeWFpJs2hy6UAwXYM7JuXWB9xCuR1mymwdMOSOM9tBgEnhNK4Bg6/kgx+A0CHYZt
         Igso/tvA4z3IYXjA+cc8HKOFQgZDE810PuPXgLy1YWRKEcJ/YAvODhSkud5BwR4gzRXE
         Gqng==
X-Gm-Message-State: AOAM533IoQP3OL6jLMBL0Wl6lxbsns6B6u/W3HC1s2Il9r+EWRJdOZu0
        G/jv/rdFqzOgrRbBoJmzoYmeVg==
X-Google-Smtp-Source: ABdhPJwdxsecsS7P12+ceMD124mn1EmAjBuh35QZtabzAfaxeC61UvMDZa92lc1EPNZycnLp7Le6ug==
X-Received: by 2002:a17:90b:38c7:: with SMTP id nn7mr1666619pjb.105.1637090358970;
        Tue, 16 Nov 2021 11:19:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c21sm21571271pfl.15.2021.11.16.11.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 11:19:18 -0800 (PST)
Message-ID: <61940436.1c69fb81.77f51.c55c@mx.google.com>
Date:   Tue, 16 Nov 2021 11:19:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.16-rc1-4-ge6ec93931387
X-Kernelci-Report-Type: build
Subject: pm/testing build: 6 builds: 0 failed, 6 passed,
 3 warnings (v5.16-rc1-4-ge6ec93931387)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed, 3 warnings (v5.16-rc1-4-ge6=
ec93931387)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc1-4-ge6ec93931387/

Tree: pm
Branch: testing
Git Describe: v5.16-rc1-4-ge6ec93931387
Git Commit: e6ec93931387b8ae43b72db2b66c54ba8e0ae524
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 3 warnings

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
