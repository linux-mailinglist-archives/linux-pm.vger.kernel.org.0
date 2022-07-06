Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1D45692D9
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 21:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiGFTtT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 15:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiGFTtT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 15:49:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7503217065
        for <linux-pm@vger.kernel.org>; Wed,  6 Jul 2022 12:49:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id o12so1703777pfp.5
        for <linux-pm@vger.kernel.org>; Wed, 06 Jul 2022 12:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=5W6vJvOFXnXPMLwp26uhNrAQcL07LrTq8GzeGAp4zr0=;
        b=m+QsKUWIEBP/rc2Vx7Di3sMln2ivgx4WeK2rMN61ZIR+QMEITyTKidVZHHiHfl7+Cv
         bMIbP4M/Sag7aeuhfJa9ytQFWGfx+lpDAa1cRcpgtDZKDhW/+HCozdNXxJkfr6zrUnSm
         lgitb6GpyvTs4nNa2r2Boivjeg9YRA3DSFIZL9uHgiqogrlqNazQqIicNA4eAnCCRFIo
         QQoHnggV9QkJTV+kv4SGrMinLizzSBlfYqRxqzc02WfKKMTC6xGbVhtrdLk+Hwx0NA9Q
         xUNQe46wpM6aqmPecnpDS1gY5Jjeeimz1pi1BcrETrIrtn6SStmUHPcvi47Yq41a198G
         fQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=5W6vJvOFXnXPMLwp26uhNrAQcL07LrTq8GzeGAp4zr0=;
        b=kAxS0xwfE2EGqaOWi8ODz3tEcW8eBQfEvZhF6Usya/VHN0NFbRPuDc0yyLNIVW131c
         +p9DpVCLsWGC4dzhjjtgDJB41UYjikGK7UcsaX5dy3Otf47QPrXlCmubW5F6KQnUXTts
         kVRO4K+ANxssUc4JiX2ipeM29WeNglLT9zngv7RUCIVyRpBJNagmnWl2aloYwkTZPzAo
         NCc7GwuFufmv1D5DQ/WTqIRcuGygnN0wnDGP/xqRHWkoXrdI6QhnYr0qkr0JFL565GZe
         Rg9ikKyWa+Efz5Mg9djQi4BBY8tr6SVcOVxUFmCG1VDPHJw2XG4/cnBmNcMAHIMVj/OJ
         hIOg==
X-Gm-Message-State: AJIora9Ud6AG83yDuFOclViJArGMlZ5yUnS3E8va6iUtvGjJXnfDrQ4P
        whUNAoBzKc7zfKR1OtHl7x9QtZndixBrnYQs
X-Google-Smtp-Source: AGRyM1tOFgYChWHjDsZ/427P14UfYy9ng2VxVXRomW5a6zIfKbippCWV3xdRywdbOowl3qXjjZJ44A==
X-Received: by 2002:a63:710c:0:b0:40c:adcf:ce72 with SMTP id m12-20020a63710c000000b0040cadcfce72mr36782581pgc.310.1657136958015;
        Wed, 06 Jul 2022 12:49:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b0016c0d531448sm87164plg.276.2022.07.06.12.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 12:49:17 -0700 (PDT)
Message-ID: <62c5e73d.1c69fb81.22b61.040f@mx.google.com>
Date:   Wed, 06 Jul 2022 12:49:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc5-58-gf97e5813664c
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.19-rc5-58-gf97e5813664c)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.19-rc5-58-gf9=
7e5813664c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc5-58-gf97e5813664c/

Tree: pm
Branch: testing
Git Describe: v5.19-rc5-58-gf97e5813664c
Git Commit: f97e5813664c9631f3890f316cc9c8da611719ea
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
