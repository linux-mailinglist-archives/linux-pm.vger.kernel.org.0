Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A8C6031E1
	for <lists+linux-pm@lfdr.de>; Tue, 18 Oct 2022 20:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJRSAC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Oct 2022 14:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJRSAB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2022 14:00:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACBF1DF11
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2022 11:00:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fw14so14729505pjb.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2022 11:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E0UDjgYLDlp9S2RV9U0HCbE2GFOFaYSXa95yuZMS11g=;
        b=4lVaBajK3vaDfnaLVx7B3jOoxvHsY2wX+haEODIbF3ikDLCZaFYBQt7x1Ao4VWlthe
         9et6GO9HSSWNxI6fcpdTbV7krL4jXXv3p8Bsq8pjxSIItBlRGsRtgEZAtd6wk0n3+zO5
         bOlffmmiYR6KDg3KSVlbiIMGWSmBUI8t/0H4l9I/Df57YQdIM4yGmR9LsuNrX6FTCeK3
         GnYzeOKrZXW7f+kRBSreKlmWcRQc1xnXI9V4zlFD//6uwaN7tru3wjBmFZpLXVzh9GhZ
         oeYyGZ/ivRRc/DsnYPWTE3a6p02faSMQdO7I5AGL0agqWcJ+uIPBLURsvn3eW19h1Tk5
         dBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0UDjgYLDlp9S2RV9U0HCbE2GFOFaYSXa95yuZMS11g=;
        b=E/vqjCB4tDofnJlC6fbumoDZpRbgIDoCA/S7dk917FlJn1MonNc4as4kUE/I7Snh+2
         BvQgZtXhSWRAp5yDXP/6mkRNYD4A/uFtHsnJZ1fXNvNXQHK7xczTiv0g28baxuGP2koq
         kS9etIpiEcOPBGnzZUL7Tsb+EGVxFRDW4j2Vn3YKh4Jutw4xoom4lJ3KpBB/A4M1CNzy
         nwKjSNtCRRXj2+/aD6Dz40DtObK7L+lfPYvW7AaQH3K5K1IJyUK9pmBCIZj/cVRGydiN
         K6LTA1LQZftW9vv3ttfbdMxKtWlUmFe98D8i/P6GHJzEApDvuHEkhJkacR+JvHzgqTBR
         avSA==
X-Gm-Message-State: ACrzQf1zNG6nVTmpE1uftZXuygOfUWduj75UnzH9PYf8KCsv/Am4YEOT
        g3P+xjLi3ma9Yhrf7+yJ7/Vkcw==
X-Google-Smtp-Source: AMsMyM4JTNhXTvzslPe/sLF0Cuuo5BX62TyDb8mlMdbXlG3bPscuq+XfPTVWrN0C19GtjsTX7s+2gg==
X-Received: by 2002:a17:903:22c1:b0:185:5276:92e5 with SMTP id y1-20020a17090322c100b00185527692e5mr4271454plg.134.1666115999009;
        Tue, 18 Oct 2022 10:59:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902b19600b00172f6726d8esm8923681plr.277.2022.10.18.10.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 10:59:58 -0700 (PDT)
Message-ID: <634ee99e.170a0220.1630.0daa@mx.google.com>
Date:   Tue, 18 Oct 2022 10:59:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.1-rc1-18-gba1b46e36fd7
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 1 failed, 7 passed, 1 error,
 5 warnings (v6.1-rc1-18-gba1b46e36fd7)
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

pm/testing build: 8 builds: 1 failed, 7 passed, 1 error, 5 warnings (v6.1-r=
c1-18-gba1b46e36fd7)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc1-18-gba1b46e36fd7/

Tree: pm
Branch: testing
Git Describe: v6.1-rc1-18-gba1b46e36fd7
Git Commit: ba1b46e36fd7cae85e58325de9814fd9a594b4fe
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Build Failure Detected:

riscv:
    defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    defconfig (gcc-10): 1 error

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:

Errors summary:

    1    ERROR: modpost: "riscv_cbom_block_size" [arch/riscv/kvm/kvm.ko] un=
defined!

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
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section mi=
smatches

Errors:
    ERROR: modpost: "riscv_cbom_block_size" [arch/riscv/kvm/kvm.ko] undefin=
ed!

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
