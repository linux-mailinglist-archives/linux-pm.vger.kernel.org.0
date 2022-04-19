Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57A1507956
	for <lists+linux-pm@lfdr.de>; Tue, 19 Apr 2022 20:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343974AbiDSSr5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Apr 2022 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350472AbiDSSr4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2022 14:47:56 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7286FBF40
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 11:45:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c23so16675311plo.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 11:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4C7E9sUX0iRjEGH4b3/QwuSEMQs/Dy/9jJ5JMDlWKF8=;
        b=R2b7+J4WZELvGeWwlOynui0xdwo+iWIG818ZtXS6HoH1HepM+ZOdvIWMkPXsuTFgxi
         qBEBQmPeHRnPjNxFWzKo2m3rV6+HmAdccBk9QhNcphNa1pOtzopyJqgm/mLUjq1IyOW1
         ONB0q6g2uMITSRjdL66p8LVlL1g4IItCRL3sgzigtqgJknf7TMAuKbV25PxdELiBMNSc
         iMo6yUCxIoXm328W+o5XY1RAsDi2c9/eSu7IX1ns4XFNdnE1z4Et69T7Gjyar3sEFBkR
         B7z2M8eoHXWOT14rTfCn6PQOhQka/x2nt2Qg3pfUQOx913tgx4QiPuJ9keQkjLprAzqG
         /UAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4C7E9sUX0iRjEGH4b3/QwuSEMQs/Dy/9jJ5JMDlWKF8=;
        b=IvRdb/M3YvCeQ4eCL8nbBAbj9rLePNQaCxRzHPHXEp1RibagtPqR0JIMASa7mFm/Tl
         jHeiObiUqhZsbAk6UMAEGeZXEDH3VHkSw8k8zIXCK6vA6qYzcfVXEZNOeQKlispCvSYE
         w0pzUqvmbBDTV0rtCmns5qbnEXCSRvNGleMV1Vx34156Thz36zVgZAw3UqrRwtdUuh1A
         ydxnNTR+nNrKJtjrkXmZrwDCaoSes12z+h1Wx1dLeV7pEaw2RupAomMgFTK+gxobpJZp
         tSDNGLWMBiRcgCLXJZhJXK8vdNQeyYlbzGG/cQX3b3uxA17j5185pgX+J5lr3BdfG1rj
         ngbg==
X-Gm-Message-State: AOAM533r7szKIht7PHzgL5Ph/HiOlx7X7oxfbiI2GStmcMOM8h6bTzTg
        ltxOaaLtTd5w74CLiv563CkbHjy1UQawuH8X
X-Google-Smtp-Source: ABdhPJzxrn7XRF7DPEOeR1nCrKDXiB7gThbrWAhaX7//tyP/+jC4AqwDsTZygS0Kh39P2v74DSFE0Q==
X-Received: by 2002:a17:902:f78d:b0:14f:ce61:eaf2 with SMTP id q13-20020a170902f78d00b0014fce61eaf2mr17087778pln.124.1650393912966;
        Tue, 19 Apr 2022 11:45:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y8-20020aa78f28000000b00508225493ddsm17204857pfr.80.2022.04.19.11.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:45:12 -0700 (PDT)
Message-ID: <625f0338.1c69fb81.624cf.84d8@mx.google.com>
Date:   Tue, 19 Apr 2022 11:45:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.18-rc3-87-ga8a4f8e63bdfe
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.18-rc3-87-ga8a4f8e63bdfe)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.18-rc3-87-ga8=
a4f8e63bdfe)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
18-rc3-87-ga8a4f8e63bdfe/

Tree: pm
Branch: testing
Git Describe: v5.18-rc3-87-ga8a4f8e63bdfe
Git Commit: a8a4f8e63bdfeac9fafe43dcafabc27d8f2e8b8e
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
