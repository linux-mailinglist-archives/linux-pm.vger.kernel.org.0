Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBBF4F1A5D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Apr 2022 23:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378908AbiDDVSW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 17:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380260AbiDDTXW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 15:23:22 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DD13B033
        for <linux-pm@vger.kernel.org>; Mon,  4 Apr 2022 12:21:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z16so9916589pfh.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Apr 2022 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=qj+08UoQ81QXCJIQ0FgNKcu3iX45S9pwm2TaiMUsPUQ=;
        b=Tx0DLhaT35SVhaJtjG4RXEwT5NbflW1Jt4AWotrHS+8I2nrLgPXhlBoQPp7FOcIg/o
         6g4m0TFBv4yYDTPnxW10XYNsnQKkiBSqQCxeDxTEgYRdpbBd9S4IBwuIwMh3C2avrbfV
         tC+c10ZJr1IfIAgXXkNhso96P1k7m1apAK4bDBaFhJejdOTn2dLEK3yeqOPGFocs090V
         Zotsj412wDVwYr+x5QIkkxySFMhSsQNLoTuaLaYFTfn/g+MlyMmGWQ/PXS/SK+y8pHy6
         o/bfJJXnmLfiCm4eV1jl7XwkEd1vni/7h4k9cRPwO9N9kJSkzThqOBF0bJq/V1x8Lgu3
         ZRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=qj+08UoQ81QXCJIQ0FgNKcu3iX45S9pwm2TaiMUsPUQ=;
        b=T0r0Zi4tJqfOaqPHvuWK2Nq7mi9AHSXT6gb2e8v2Xl15umNO8M3CO7cjZETaKibG0j
         ciJgItmEHO1CeadFRy1gQtGm5pEdo8KvJBA0SlVudylA89eTyI/Owx+IkUyGxgOK4M4t
         X8fLon7YCxBPFWPqXDzn2/1iRXf6Gnbnpedy0YmReDOrGOQq2u49J+ZDZ+yOxKgc2EeK
         77hEnMPy/9mf1uORLIkKDlEE4Af/kx6jXLLUakMOadSyNQ1jGyn/GqvUKMoHUQEQ9PvU
         VRjjomvT8I5jZE2M3RSSINlFQy2Zmv1MZsHxR6yxWEHGYULnCHZw4uQ9cfM+6AVj7icC
         BFmQ==
X-Gm-Message-State: AOAM533BicTnpn9CPYvNtbiFgmCegnewA9mECPmzAo2vRhpuQ7L14aPJ
        YN12vImvsrOPfuHpM68dngGrPA==
X-Google-Smtp-Source: ABdhPJzfkpiR1DiTFs9IhkKAfUS4XW1JV3sMxAekA1ytB46matysNGdlufGvuouYsjDplKQfd5pClA==
X-Received: by 2002:a62:38d1:0:b0:4fa:80ad:bf5e with SMTP id f200-20020a6238d1000000b004fa80adbf5emr1211036pfa.69.1649100085168;
        Mon, 04 Apr 2022 12:21:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j63-20020a636e42000000b003987df110edsm11184329pgc.42.2022.04.04.12.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 12:21:24 -0700 (PDT)
Message-ID: <624b4534.1c69fb81.7c30c.d324@mx.google.com>
Date:   Mon, 04 Apr 2022 12:21:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.18-rc1
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.18-rc1)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.18-rc1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
18-rc1/

Tree: pm
Branch: testing
Git Describe: v5.18-rc1
Git Commit: 3123109284176b1532874591f7c81f3837bbdc17
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
