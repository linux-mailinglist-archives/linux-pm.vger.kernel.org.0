Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024945EE59D
	for <lists+linux-pm@lfdr.de>; Wed, 28 Sep 2022 21:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiI1TYz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Sep 2022 15:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiI1TYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Sep 2022 15:24:36 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B6841984
        for <linux-pm@vger.kernel.org>; Wed, 28 Sep 2022 12:22:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y20so2486247plb.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Sep 2022 12:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=IATbB+mTuldm9DEGTU9Ku/OShkHX1AvIMasBRffFmUE=;
        b=uFptoWOo+d89TNFCQfB+zTNtVPgtwpdZvI6kyXS3MY5nYTBZYxYDgFJ9rYzOv+qLNm
         Cp1CJU3B4btumwpb/KBOKROtPBecadIAlnWa/4M0xxcMbTMVnZASmHlivkydgGTk3qdy
         /cieThSu9kPS5upng3kR8t33iho79eACYrl3jdD2ySnkwqY1OaTFWjKFyT/cNhJw5baT
         RVIjl0X6g3RuMXvEibio8ZNuiwk3RCzv4cskrXqjQUVcjT8LhL4UMaebFqItbxTDyKdA
         shnRn5DHHlTScJ8MWTVBSBrWgX/aPF9G/dvLhOJZeauNMm738pg9FcFJgYqaaWsRQpq7
         lU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=IATbB+mTuldm9DEGTU9Ku/OShkHX1AvIMasBRffFmUE=;
        b=BJG0ClPkriU95xM5jXewdH/c/ZQzcZ8MGUZBUTX6PCa3Ui0IhjJNKItUFF1mL/uWmE
         a8ySlFe65Pemeqd+DxpiVPmGA9u/NTWNd+gR19pR8F8k/ftYrrf1nBoiHf3l2ORyI35E
         L1g7YGpqKIxNG6koyjHgcRnArxu/CuGkm2b2KP9XKXhb3yFDMuk07KEt+TNV2dLEiHMY
         4DmhYESfb2YQ8PkUvKNGn4uEnniPZM9ateOdwTVEtsdvKh1b32PN753yZAaCzON7JOyi
         y8B/r7ISXRJ5mYFgBQxvJN6UFZDSLfl7Pau8txLkLmj/stog6jrbGQdmgD52t9ZRmv6L
         GnLA==
X-Gm-Message-State: ACrzQf3w74uqjZlmKMtdADfftTAjwkbA8yldD7sFJCjIJ3ErUQXybxxC
        biUozAcl8AcmGof3k3IxTpk/gg==
X-Google-Smtp-Source: AMsMyM6biu2Vp5Q4UfWhvxDXvktdzAeeAqRY2BZzwqY8RUWylYAm0ookZ83sylzUpK0JcM5lbMcVTg==
X-Received: by 2002:a17:903:40c9:b0:176:e58c:f082 with SMTP id t9-20020a17090340c900b00176e58cf082mr1326266pld.60.1664392955179;
        Wed, 28 Sep 2022 12:22:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gi9-20020a17090b110900b001fb47692333sm1939387pjb.23.2022.09.28.12.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 12:22:34 -0700 (PDT)
Message-ID: <63349efa.170a0220.da0b6.3581@mx.google.com>
Date:   Wed, 28 Sep 2022 12:22:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.0-rc7-179-g530bc2b3f53f3
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.0-rc7-179-g530bc2b3f53f3)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.0-rc7-179-g5=
30bc2b3f53f3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
0-rc7-179-g530bc2b3f53f3/

Tree: pm
Branch: testing
Git Describe: v6.0-rc7-179-g530bc2b3f53f3
Git Commit: 530bc2b3f53f310b78938352fa32d7c1b364d2dd
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
    sparc64_defconfig (gcc-10): 3 warnings

x86_64:


Warnings summary:

    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"
    1    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.

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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
