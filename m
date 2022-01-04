Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67894847BF
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jan 2022 19:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiADSZW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jan 2022 13:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbiADSZV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jan 2022 13:25:21 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11680C061761
        for <linux-pm@vger.kernel.org>; Tue,  4 Jan 2022 10:25:21 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z3so27634583plg.8
        for <linux-pm@vger.kernel.org>; Tue, 04 Jan 2022 10:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=oqc2I1f5kPfg6pPi0DkEugPKem5jHofOCzEM0fRR8Ew=;
        b=TaNWahTrD0CREGVGam4rFI9elOAj3/SRrlq1Xib6IHLjvXt4DKs4x8kqx1AzTGkBiP
         aVRLj4K5wT3wNUwhx9yz0SXEoEpxSN0ydiKEzolqEJ3UZqHraVEqBIg+UMTU1O3JFgMC
         BOU1uzxVllW8ThvYp7BqfHhY9aJgj2qg8rcmcJL2ZY03wk8ONA6xfL5R51AYStz4GhAp
         /DLGpkp/mcgbeEaLS1P/1CQSoFK15J9an/FeYG7iEEaKSUuUIFzPmYQcaWcqnG7pmPUS
         lKytALhGlH5CGe40Ll2ZWYmAWOX0OBwHi4k0c61gGf3C5LSmIX2VAwGnzA3am+9SnA11
         RwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=oqc2I1f5kPfg6pPi0DkEugPKem5jHofOCzEM0fRR8Ew=;
        b=mtHc25URHw3Mk4XxZVOA5QlrQP/aPBkmeYnl8svRPK+kWSxTB1W7e8Rvz/JMHeGvZ4
         LvYnGRMw7msNE6RVFfK3FwrHJ8jPS6qQTwJYO3y8b/Q+FwotHVN9mlCT04OP2D7SvRka
         VNfcKrugAMZ4hZ0ajcaK7AJvc/u8JD/7NcUUJZgHlL+zrqDwPw8ukFkQTUojuRQTx9mT
         cCTP5HpDNNSxsPXMiyElNPr2WJHF1RItILPWqZmhEzAjXPN9jNx30UPiN1Dqmp//H/Xl
         liA2N3e7KldSxaZ26ncLGFhjfkI13NOCg8H9i7Obc1Tyw5CmFgZhLXVoAfADSikgmLmw
         xSkA==
X-Gm-Message-State: AOAM5315GH/K1w7H7EBG+PzNHgvnOwP2bHxNNGqz5qHdsBO/cFCBvknI
        0weqBXx3NWsdqDrO+3Ep8akFULzrUhVzCpgg
X-Google-Smtp-Source: ABdhPJwHPNecLlnhpv+cqnJTAUqlBkD4P/jd4TGp+g9UwQxfgD7ngTiAllZRywNyQc8uxPgFPAJl/g==
X-Received: by 2002:a17:90b:903:: with SMTP id bo3mr61942964pjb.11.1641320720664;
        Tue, 04 Jan 2022 10:25:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j22sm45142490pfj.29.2022.01.04.10.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:25:20 -0800 (PST)
Message-ID: <61d49110.1c69fb81.e133f.5906@mx.google.com>
Date:   Tue, 04 Jan 2022 10:25:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.16-rc8-155-g7a716cec17d1
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc8-155-g7a716cec17d1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc8-155-g7=
a716cec17d1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc8-155-g7a716cec17d1/

Tree: pm
Branch: testing
Git Describe: v5.16-rc8-155-g7a716cec17d1
Git Commit: 7a716cec17d19211715a34b426aafc3fadb22de6
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
