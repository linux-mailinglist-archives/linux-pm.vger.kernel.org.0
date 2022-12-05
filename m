Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0056C642976
	for <lists+linux-pm@lfdr.de>; Mon,  5 Dec 2022 14:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiLENeU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Dec 2022 08:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLENeT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Dec 2022 08:34:19 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496981B78C
        for <linux-pm@vger.kernel.org>; Mon,  5 Dec 2022 05:34:18 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so14856116pjp.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Dec 2022 05:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gSVmwYRM796Ouau4wGBscH89Bzk2g2ljL1Zu3WpPiNk=;
        b=4B6t7T+F4/E7/BGw54W6tcNQEsbKxeX65OtnhDnugBvdrFXtLaO0L8G6min6nmfq79
         9051yGmJKMclXAtIHHv1WBsymwDIBbV/kKXqSwuR/N5gbsGsueXsl700jYmpVmbH9O7c
         FneD6UBKLrM+KlVv0VzaT4NcNzxWSOQ+GicQYMMWVTi11FrKJEGLQtRNmV4XIx7uddQ5
         1SJxSayGIvwH+GnuRvCq17SZSieSBm8TPZbgsqZTy/zbXFNinl4h1C8aWM0c4R/xzMV8
         f6avh7jkm2xKRfaOxqKlQ4mDDsCVyroTg6IwvnY8sZ9ID886EyUleE9hlI0IqWukn5Dc
         3OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSVmwYRM796Ouau4wGBscH89Bzk2g2ljL1Zu3WpPiNk=;
        b=W18nYE/ycTXXTM2fOmtWGxPP3x6DDgmrLLvSD0dKmQobtWmncrH3c/lzC5KQchPFu1
         bS7Q7ucdS0lVmC9zlh1Q1xaRC6NFNlNt5qq/fXUXLh7cfeZCwt/ifcBVCUASqYLDIcUo
         J/Kginakl4j1GcfN9wrGYc7qZth/Won2KQ97Qi1NFo2gmZLUPGZUm9b6CwvLFNWY6LJk
         QnBhG1Qtf7ZMSxc22bYa/68Ex3zxOi6L/1+l1WUSVpELgr7ngEigdGd+dbAK9HF/Qztp
         iV7JOQdlAQ84ky5sxOxgj150GXFG2S9lXOI+R2udnXpg/In3bF3j93I8BwnPUPXIctGl
         YmVg==
X-Gm-Message-State: ANoB5pnuhIBXWIo6E/7M/vxmhwNm9oeJiFZHWi+8IXWNh2bEi8WTmzjN
        5EkdDa4f+ouSnvrmZgGDEVAYdg==
X-Google-Smtp-Source: AA0mqf7Db36Ee+Z3PmSh7B5C+/RIwfaSn6W0fdYA3PgD1X1A4gpBRpMVEeMG7IVBOdsvcHRXct7A7Q==
X-Received: by 2002:a17:90a:2f62:b0:219:14b9:ac05 with SMTP id s89-20020a17090a2f6200b0021914b9ac05mr48861407pjd.175.1670247257733;
        Mon, 05 Dec 2022 05:34:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709026bc800b001897e2fd65dsm10603518plt.9.2022.12.05.05.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 05:34:17 -0800 (PST)
Message-ID: <638df359.170a0220.cc445.3031@mx.google.com>
Date:   Mon, 05 Dec 2022 05:34:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc8-118-gcbb91738df5e
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc8-118-gcbb91738df5e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc8-118-gc=
bb91738df5e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc8-118-gcbb91738df5e/

Tree: pm
Branch: testing
Git Describe: v6.1-rc8-118-gcbb91738df5e
Git Commit: cbb91738df5e16fcce8b627a7d0714cb21ade0ff
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
