Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95535579152
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jul 2022 05:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiGSDaz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jul 2022 23:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbiGSDay (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2022 23:30:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F5826AFD
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 20:30:54 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s21so13512861pjq.4
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 20:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=B3vqNQXUPHLiidrsRquKDvdq06DoB7DEh5Ci8FLXtVI=;
        b=70MNsDc3V7bEpSiMtgiyP3PySZd9aagcwmx/JuIxz8JBgZockp4Sc8egvWkyae1ydD
         kWYCP4kJxITibG2RLmxtcfnRPXKK1fcrgWks5Un2hoRkenCcBLrFGJX7aMPXVvF8Nki+
         SZVNs+BRC+QITiARn8o4OrKDkGCyF0RnGBZRkBKtjcC39+UpqmeMDGR2CIHAoq+1sN+e
         MkpaW9gzlisZCvFF8yBxvLm78OsdvFubq1JzkomkfOFbFE9BBGqG4VsUopWVpPRGwqnE
         noti66NzhTrLt5YBIrCr7QgOCDFIbJ29MAiXi3eTMOFUL4/S/g89l00xfoAAkW4qTfGy
         7d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=B3vqNQXUPHLiidrsRquKDvdq06DoB7DEh5Ci8FLXtVI=;
        b=jh28uoi5CMw0VY/g2oitQNFggXA4daddIr+7dS4Zm1zvzNWsbSaIpURcjS2gFnOt+0
         feLp5ofd2EeZI7EtkWd9zRKHsJsvmfnDlicccHVfwotQnd3sKs2HETrOu3ebJNTlADmC
         7O2JIt1fDG+4thbfSKRJIas1ez5LCNzdMcqd4pcLKq9TJY9CGEmW/zCvfeANnTMuzGdn
         DWOT4W5zOFuVMrDjApWjGK6WcrgflZPn7SBdUJH1Kyg2IEWQBRMJrvcZ55TQE12egiE0
         gMfFX5J5TgK4rEBUHuA+uII/vdV/d/kKgQU8tSKKDB1QHBwXY8hCHX1aaRiw5eRPPUJG
         kRmA==
X-Gm-Message-State: AJIora+F2i9Emav1cBmb8R1JxP79sxGpl+GWHrWtzWl/HX7xw3RXN6L0
        6ytoEHJnm1GaOutfG70Tk3MVHA==
X-Google-Smtp-Source: AGRyM1sBOZjTQPTltZSrPDNEd9E7aViAx+eHi2m29mc8h95rPGy9jWCjb1NDu5S3ov8vNdDr7yHDwg==
X-Received: by 2002:a17:902:8a86:b0:16c:4292:9f56 with SMTP id p6-20020a1709028a8600b0016c42929f56mr31328468plo.36.1658201453500;
        Mon, 18 Jul 2022 20:30:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y21-20020a170902d65500b0016c19417495sm10321795plh.239.2022.07.18.20.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 20:30:53 -0700 (PDT)
Message-ID: <62d6256d.1c69fb81.83513.f079@mx.google.com>
Date:   Mon, 18 Jul 2022 20:30:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc7-69-gcd720ad594e64
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.19-rc7-69-gcd720ad594e64)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.19-rc7-69-gcd=
720ad594e64)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc7-69-gcd720ad594e64/

Tree: pm
Branch: testing
Git Describe: v5.19-rc7-69-gcd720ad594e64
Git Commit: cd720ad594e64894f94f2b011e281c9b85ac1cdd
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
