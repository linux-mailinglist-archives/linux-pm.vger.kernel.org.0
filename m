Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225155679EC
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 00:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiGEWGx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 18:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiGEWGw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 18:06:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEA81A04D
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 15:06:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ju17so8380321pjb.3
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 15:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zkw3hb8gsbCRk3DlG3oM8P+xs+NVhLX4QMQ5emT8v5Y=;
        b=jqmP3u9SfFmYoFmUkPwhTuV2DR8jPIf7NaXyuylP6MRpKthsrEovrfPWZJwcQ2YrH3
         Zo5AOxQVxaDo8Ypt5KkEYrYoxNPKNBTtCAGr/i8nJPVpZ81i2c7EytYWvaaUxHRGnjCK
         A80coIJ2QM1inrf3JZmiHgYTM8DXxRhluCOZvrjU3nPr0pOWZiuvFCySul+NERSQ3tvS
         ePqmoVyIFf+ejSsKBJ/cKKZgAYxojxBsnMgAraFPak8Bw29YXnK8swAJc+DwjPT2GtA7
         jAS9QDCMQYHtPEvNrfaDzV33FTHaNUmyULjDdcczNSBd4zS6Xyw4G34Ie0kfEvZRLT7h
         H7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zkw3hb8gsbCRk3DlG3oM8P+xs+NVhLX4QMQ5emT8v5Y=;
        b=6vjyAwff/A53S2sen+7Ey/Lp2mdhmdKyiz7BgDoCQr6XBj+cCEAjnR2c321DKCeldT
         O4t3g5wHBCSTvvPBS+0kW2I9SddRu3SKvBAhAwxKArBV4v4LHpekAOU+BMWGmkjOrzGD
         jiZb54o4iQp02fVLmmcMvO5YYQQUOS0Tc8OUtvL1OzA6Yvb8l1A2VOVLLVmR3Nkz8PCd
         MkTaMaOpXEbxesvSPfpaSC5i2vYqUWqHjnNaQ8dbDlI/l+vcoVAGgc8BEsvQ45nvm3lg
         p6A0hyogKqCethDOdRcEZ6PErJV/KsunpkrDR24PZrPFO33Zot7Ge/6npVpz/ow49ja9
         MuMg==
X-Gm-Message-State: AJIora89Ygs8ekZfm2vSUVWla+UNMBMg/wNrnFlSnRlOphYTDqzXWPcN
        Qp4SeqPZx0s/x/Rg2qDZQlUxPp2ChglYQXx0
X-Google-Smtp-Source: AGRyM1vnlqpxZs0nI989lXRZFY+innxIdL7EQ+DD9zNd6jmz57F26hJsNAyz/cQzQyrZtDX116zArw==
X-Received: by 2002:a17:90b:3b86:b0:1ef:a333:e67b with SMTP id pc6-20020a17090b3b8600b001efa333e67bmr4095253pjb.158.1657058811127;
        Tue, 05 Jul 2022 15:06:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p4-20020a625b04000000b005289ffefe82sm514548pfb.130.2022.07.05.15.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 15:06:50 -0700 (PDT)
Message-ID: <62c4b5fa.1c69fb81.aee94.113d@mx.google.com>
Date:   Tue, 05 Jul 2022 15:06:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc5-50-g3bc028d913bd
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.19-rc5-50-g3bc028d913bd)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.19-rc5-50-g3b=
c028d913bd)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc5-50-g3bc028d913bd/

Tree: pm
Branch: testing
Git Describe: v5.19-rc5-50-g3bc028d913bd
Git Commit: 3bc028d913bd352d8ba9e4b371e7e1303457bfe3
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
