Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F1762C95C
	for <lists+linux-pm@lfdr.de>; Wed, 16 Nov 2022 21:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKPUBK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Nov 2022 15:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiKPUBJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Nov 2022 15:01:09 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC0761BAE
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2022 12:01:08 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id b29so18467958pfp.13
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2022 12:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wytc2o+/RbxQsgJvp/l1EGgCszaT+PTvBuuTROWdlYw=;
        b=myFQnQ3s2p9u2ZR5x8HhboIUdeGAcNS6/E2J59D437SbcVb318yRPmbm+xjPIMPBba
         BPqCZugByYPX/Ut0O2ZfRyv7hvqzVDyYmY/4fZLO/fxssU9wM3kgQrKkoEKXvcg1Q6tf
         xFgVWEwmjW2NlYvCwKkGTvmP2J2ELWS8YSaJ+4y4bGa/XUfis3ygar45L3j4fxKSR+h8
         XcvjKv6re5juXIxMF/PyTuKuMsh4DeHT7z2fr4Iy0qSNw0tOV1PJdp5VklLCe26dnxry
         nVDAwSR2Y+Z9nYDS7mIf9KM5D3vVV+UjTBanEdIXFhqVuRk0DNeVe3VwYwnCOVxkstiz
         /tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wytc2o+/RbxQsgJvp/l1EGgCszaT+PTvBuuTROWdlYw=;
        b=C8TdVAboCt7J4QYwOXGa/qd9JZccTrHXF3+G26UnrfHT5bshGRGutfYpN3etWTB2Bp
         BNlTdRjGAIQEmNJsQCklgY8Sg/xhln9At/VsmZI8SS9LiQNyUR5mL2y23otoIvsejJkG
         A2p7InhvSZhq/EvaJl5cvh6dgb7Alny2ktO/VWyCTRH3Bnc2Qtljzc3aMVQqfbkaGwYN
         32+CPFBu3oY64L80204rk7wMW4x8XGDwzTtABedPjW/c1/9IAneD9t87xo0xdaQ9ewch
         xuryCyblHYfxPwXejuk4bo+ppfS4fYjSmdcwI59PdIuG5rPmyMlvRIp/3nzKSaHlDuBa
         1ssg==
X-Gm-Message-State: ANoB5pna+P6C1dFbOj5hUQYPujPiqyNHebTeqsFU1P6/K4xuL9gphGis
        cEnbglc3CV87cEYxeTD99qgioA==
X-Google-Smtp-Source: AA0mqf4fLo70DKdG7mctwg/mgGPXip70dOu50yM8Blk/ZFX4RhlL67u0iFb6Wv0AaE3CDVZxgfYlTA==
X-Received: by 2002:a63:5242:0:b0:46b:3c3d:f618 with SMTP id s2-20020a635242000000b0046b3c3df618mr21301879pgl.423.1668628867924;
        Wed, 16 Nov 2022 12:01:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y25-20020aa79439000000b0056bd1bf4243sm11293284pfo.53.2022.11.16.12.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:01:07 -0800 (PST)
Message-ID: <63754183.a70a0220.68b5f.1c49@mx.google.com>
Date:   Wed, 16 Nov 2022 12:01:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc5-65-g32e8e1c35ebb
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc5-65-g32e8e1c35ebb)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc5-65-g32=
e8e1c35ebb)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc5-65-g32e8e1c35ebb/

Tree: pm
Branch: testing
Git Describe: v6.1-rc5-65-g32e8e1c35ebb
Git Commit: 32e8e1c35ebbe0bb2853f5f8417e247abf87ad05
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
