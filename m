Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2290E4BEEBD
	for <lists+linux-pm@lfdr.de>; Tue, 22 Feb 2022 02:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiBVAuL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Feb 2022 19:50:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiBVAuL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Feb 2022 19:50:11 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C7423BFF
        for <linux-pm@vger.kernel.org>; Mon, 21 Feb 2022 16:49:46 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id iq13-20020a17090afb4d00b001bc4437df2cso829239pjb.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Feb 2022 16:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=epmHs12NXKTXHLUZ9nwDZ4br/8ppgIcKu9jlfDkKS8s=;
        b=XnCBpjTBLNXQLAgRHriEXOrv3aQ9d9iRcKkOIrafB+aIhy1pLanBihHBhF39F72imy
         AR3vt3PTWgmUbJomiP0I8+KF+BaZXs+1IJ1jFmfqPTFLB8NO+686gm6F8tIJsW784T3y
         +g/sGIHfcrmS8l8KLpGWFYZUukkXB4uzOiA2o4UhrgDLIGyFns2L5YMHfsOh8yTthL1M
         sP4NIAO2D8VzcRwao6hXNncogs3aKvA4mpL1dwLhqcJ+RmpGCGJjAljq93q+MO6/nMJ4
         P4v1DHnESmz6VT8NmvdVpGj3cuu/s4LKAcWtTrG8QKhB6x2bm0oGegEq7qiKaeyP7/ZS
         R0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=epmHs12NXKTXHLUZ9nwDZ4br/8ppgIcKu9jlfDkKS8s=;
        b=XoJMPUlE61soKkNODpN0WmMoFwOpWF2gxIvGy+JkZaCJzrB/igqA6My9PjV1n8s6R6
         TKfQCHF+PZ1HD5ZP50aO64NSE59jfxZ6fj9rgzrFchMirMFmUdEWRo8/D++nje3w9I4J
         aDGCxlKkFvdTSfLNCp4fBJqEAjSFpdilQLBYcIIiCTUd2rbfuiGy++1zZmFKDU1nYxih
         kW1n6SB2QWjrFJo1/v2Xfzb1l33r/J4QuEy+0KQYavxVKbywid0n9yPCHgTm/71+gu7b
         06z+pTAltTJEEVTwOil5Vwld0iDdnT4JfInIFcn3A4jihAxPI17/h7QJb6aPS+02hGHO
         YZ8A==
X-Gm-Message-State: AOAM531PZvoPeAU6AMc27C/c+bEocJ9niV15iC+HgAOaSn0GMpqX01G0
        yGQy+YLGyaa2wvqU2qD1GNS8VA==
X-Google-Smtp-Source: ABdhPJzzYiqsXGCJu8ldp8hYFabrq/F5SPGCjmmEXrYuC40eRKCJfjIPnf+IEJuF4spb5npzZTMHGg==
X-Received: by 2002:a17:90a:5302:b0:1b9:ba0a:27e5 with SMTP id x2-20020a17090a530200b001b9ba0a27e5mr1449309pjh.91.1645490985871;
        Mon, 21 Feb 2022 16:49:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y27sm18727244pgc.92.2022.02.21.16.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 16:49:45 -0800 (PST)
Message-ID: <62143329.1c69fb81.50ca0.2ba7@mx.google.com>
Date:   Mon, 21 Feb 2022 16:49:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc5-50-g2ecb866af004
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc5-50-g2ecb866af004)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc5-50-g2e=
cb866af004)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc5-50-g2ecb866af004/

Tree: pm
Branch: testing
Git Describe: v5.17-rc5-50-g2ecb866af004
Git Commit: 2ecb866af0048e96c331a206a876a935d3649f78
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
