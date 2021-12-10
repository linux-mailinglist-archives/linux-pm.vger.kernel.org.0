Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F753470DF5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Dec 2021 23:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbhLJWiH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Dec 2021 17:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhLJWiH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Dec 2021 17:38:07 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FF5C061746
        for <linux-pm@vger.kernel.org>; Fri, 10 Dec 2021 14:34:31 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n26so9706457pff.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Dec 2021 14:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=AmYCLZ6IWMsUZlDKqVTULubsbwDnRek5rFHq4l51GsQ=;
        b=AeD+0XAimehTAkgwrIjSyimWbU4GZcAI8uhY2edcmZU4p5JscJcuHz6tRsSlhE+uh+
         nnGLOuVV82k8aozelYFx3iIYobnnJncKcDsNzTEzlbie1qfe8PDPLrnBgPBgagSeL+GW
         NKfB3rmxJQPuQoZBlwsmx8l2t9Xv93vCJ8EZ3Ni9apUZNA6XTzRbBH3LXPHuPfZXymKn
         qVz6wmGmd0qzX9udFDlVUDi1JWN2Ngb6QL0OCNgEd08XRkJDTy+3H2r9xRbt89rVPIRp
         +QVQrS8cA/fc4nbuv9pN9MbVO6mkIKxxCxF8SDPRbankDAOjCOwYSSIXcpRgoYnJFZo9
         76pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=AmYCLZ6IWMsUZlDKqVTULubsbwDnRek5rFHq4l51GsQ=;
        b=eOXOdLepd6nMbapCNqtvy/slVAIjTlmuQVe2GD7yGZc0xNyyZ72oeqzcUz2zhnFp3I
         G36APFQC8/uwIk1D3NacH/QLD6Cl/s9UceNNzdL/74VsS+mvefl+PLEtA0w0vW69SvTe
         +cKmN3nuL82Bul/3hirmmLv/3mQgnLPnvQ0sStyqeoYnRh9ErXlkdly5gxBJMWkDIXFo
         A2Jtp/NOFhklmiSFIDKYB+cfUfxIo5AZIrQETDkh+g/6pZf4PYGpA1CESiPSG4bVR/f6
         F7Z7mgKFjmup/VPEzN3vmTzg+385HcKp90x3l1PGsIyAMtymn3vts7kXIe6yNyOjNnLz
         Qeew==
X-Gm-Message-State: AOAM530/hL4AMxvp53ryo7cu9pZFegr2apFGbirXqamrW6pLHo4ZVO9U
        8nRGm2chRLJzyG0zgeMx9QIwRQ==
X-Google-Smtp-Source: ABdhPJwu0XbWAZBXpgygoOmtj29B0mtHnPUDPVL923k/hoChTjqIEFAQvBwpiLYxX/w7fKZLswnX3Q==
X-Received: by 2002:a63:2cd8:: with SMTP id s207mr8103633pgs.231.1639175671451;
        Fri, 10 Dec 2021 14:34:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id lt5sm29257pjb.43.2021.12.10.14.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 14:34:31 -0800 (PST)
Message-ID: <61b3d5f7.1c69fb81.2c960.0211@mx.google.com>
Date:   Fri, 10 Dec 2021 14:34:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: thermal-5.16-rc5-48-gf1f42573b6f3
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (thermal-5.16-rc5-48-gf1f42573b6f3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (thermal-5.16-rc5=
-48-gf1f42573b6f3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/the=
rmal-5.16-rc5-48-gf1f42573b6f3/

Tree: pm
Branch: testing
Git Describe: thermal-5.16-rc5-48-gf1f42573b6f3
Git Commit: f1f42573b6f39aa35a5d07079189c5c242180687
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
