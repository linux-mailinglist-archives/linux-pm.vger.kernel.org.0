Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E05857AADE
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jul 2022 02:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiGTAT7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jul 2022 20:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiGTAT6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2022 20:19:58 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C300B5006E
        for <linux-pm@vger.kernel.org>; Tue, 19 Jul 2022 17:19:57 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g4so14980181pgc.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Jul 2022 17:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8uoruPVjjAopYfi56p96WhEHcJ5THBtn63kPwlJmQOM=;
        b=6FpmafoUU1SImRmYwuK2YZLcjop830zw/y3Z+P/CbhInOgeTdParWCY5kCeNorsIsT
         Hfa8qdUCXIMRK0cmGtxN//AvsJDsMAOO2MgBoAHmS1iQojvvtzdaX057mpZMPjwSBJ3Z
         UydKRG4WYDFGyartiY6YPaJtGx55M7fPOpJiVDT/xyUO4eLFCE70j1GruPfDWA4xWkKi
         IxkzVw2towQOs7RX59zcXEnrvt4zEIiTJ0lco6EZ4f7anS1GAecuic/uunFPgUPMyh2l
         t/ISC8ZoX8jo+1x4BGNHLK9JxqXLqpp84HbEKhAMBybE1hL5Su6owSk3lmUj2PD5TcPB
         uLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8uoruPVjjAopYfi56p96WhEHcJ5THBtn63kPwlJmQOM=;
        b=S8AgWd+a7HVQ2OzjNoJZRRTlj90kP3ZAaEv2zDEUmZbzFS0Iy44KWfPy22aKtiSg16
         FP/gb/rlPLLfViIU5ndVwQP8naN7eTvD7GnNbTh4irR+awUOO++kw+uibn+PWlick1iT
         OYssJ9Kpu/rcQCpxNaRMZ1r/jA4Egm+FWkMgibGuvRJATQFPHgMdp3MD/Qj8F56FMd6R
         Ou2glIIZ0fCXiOBOqw/RFpGrK/pdFHQLT5H71qbbPu0rZj2wgkQsHkoeuxMxYDE6RgL6
         PJpnG8BuEvuILWRhvkMtEMejN/cPD2msu06Z5/0fB/TL/MSsEgQaJTcBffu0jv1KUp0I
         mSXQ==
X-Gm-Message-State: AJIora/RqdvK8JG67BiXWJ2/p2YLhcI1H0NZeyALojnZQagaA7LyeFc+
        Jxipfdkd7vxJXhDxyEMgVoovY4Prb+gS/7M8
X-Google-Smtp-Source: AGRyM1uQ/EfUkdL8D/4y/qZFwGRyVL1YLVqXJ2LbtzkKzvqMBXhID/CNMyxBml0w28iUUROj6c7eTQ==
X-Received: by 2002:a05:6a00:c8c:b0:52b:1169:6a6d with SMTP id a12-20020a056a000c8c00b0052b11696a6dmr35779953pfv.2.1658276397238;
        Tue, 19 Jul 2022 17:19:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 127-20020a620685000000b0052b29fd7982sm11128544pfg.85.2022.07.19.17.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 17:19:56 -0700 (PDT)
Message-ID: <62d74a2c.1c69fb81.92f92.0775@mx.google.com>
Date:   Tue, 19 Jul 2022 17:19:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc7-79-g66de314cd08fc
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.19-rc7-79-g66de314cd08fc)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.19-rc7-79-g66=
de314cd08fc)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc7-79-g66de314cd08fc/

Tree: pm
Branch: testing
Git Describe: v5.19-rc7-79-g66de314cd08fc
Git Commit: 66de314cd08fc4a7830333025d6a9c61ed12cd30
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
