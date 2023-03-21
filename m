Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19D16C3913
	for <lists+linux-pm@lfdr.de>; Tue, 21 Mar 2023 19:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCUSXD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Mar 2023 14:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjCUSXB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2023 14:23:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BF344B1
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2023 11:23:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id le6so16915040plb.12
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2023 11:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679422980;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DWj8fuzeYJMjYBlJumL5aEAWqq9PFl2kOv0q+T5/KNM=;
        b=1S94hpAShAgVDEkxSKzLkZeTqgrvx3FCM0lol6A0Vxm5goBjQmlCP0tApEsdHZR5Ck
         519/q3oeQWy6vsUdumtJR8lDSzGPUyOK4O8Jq07bVyheq/mmuqI2l7YRbEzR+RQwDeAn
         BrRg24qAesSRbdtMWr5fqjJt2eCpZjR/WdemV9u7AiZs2LceSqCUYWpFWRxKOtrPIAwy
         7pRl5UvvjJtzdCZyX33pdkKfzRM/ony2ArK0kPqb+ZVgHPB0zttwx439cgdObR7kHX6G
         rQSPrX0e8RYfPSLco+DUmVEbNwr4PsF6UABPm366sGvggc05lUongyl2nuyXoORq90YU
         Jlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679422980;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWj8fuzeYJMjYBlJumL5aEAWqq9PFl2kOv0q+T5/KNM=;
        b=fEqbeu8MP64kS4067N39w9DB6ah0G/c/P+GRzyvyPsTEY3Aiz5Iov39XmRE2gaCtb0
         s06GsIN5XoQ7YXA5TR39tPuiQzF+csRCAb2FORPnwFiJnbqv3GdrCJ8GErW7tLfzQBP0
         SRdh67ZRFYiq/BbKgXohfqAqZsWcFkfWokqKwQFnQXK8Bypvle2u2H1GxyzqASsN4Hhh
         JcD+wOC1XmtLHh6V0yRJwVjGlMX5gDdyI57oMybGdOan7DcfT5KZ00RRm8etFhfBSA6l
         gKtUmoAsxHnRWxMwSI0q1cieginGYmBHK6n+lHi56suNBbOGXmE71RcnAT8kygeqaAO3
         A7Mg==
X-Gm-Message-State: AO0yUKWcQSG7Kk7Wgz5XhH6HZ7V6AKhPCWbMVmuu3cZgvMqv32gqJhml
        RMSDRf2Hf8x4o7TYsWT9vf0xYFGuCD9W/G41GjvwMg==
X-Google-Smtp-Source: AK7set8MWr+oViw3vpbCOnSty4nQUNuYe+73yzAZ1YRLl7A0QgXplfATLYdqKspe3DgrPaPVeUV3ew==
X-Received: by 2002:a17:90b:4a08:b0:234:bf0:86b9 with SMTP id kk8-20020a17090b4a0800b002340bf086b9mr618290pjb.25.1679422980039;
        Tue, 21 Mar 2023 11:23:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902b11400b0019251e959b1sm9043695plr.262.2023.03.21.11.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:22:59 -0700 (PDT)
Message-ID: <6419f603.170a0220.15473.0b88@mx.google.com>
Date:   Tue, 21 Mar 2023 11:22:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.3-rc3-33-g8e95155f8f29
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc3-33-g8e95155f8f29)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc3-33-g8e=
95155f8f29)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc3-33-g8e95155f8f29/

Tree: pm
Branch: testing
Git Describe: v6.3-rc3-33-g8e95155f8f29
Git Commit: 8e95155f8f299d6c2941c7bfa133ae8d0242870e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
