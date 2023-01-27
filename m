Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F9967EDF5
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jan 2023 20:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjA0TG0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Jan 2023 14:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjA0TG0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jan 2023 14:06:26 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B937C334
        for <linux-pm@vger.kernel.org>; Fri, 27 Jan 2023 11:06:25 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id u5so3613234pfm.10
        for <linux-pm@vger.kernel.org>; Fri, 27 Jan 2023 11:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s02yvdqPIv9mtVdyYNNOHPVfzGOc6FwpGfkhBVGVaq8=;
        b=0XCDwCvGFssZww5eWw++Pg+mKBdjucgGLxgP5npg7bM+FGrxGS97BRqfZE3KLKDPxJ
         3/SNfA3zMmwLXuSs1sp1p88anHPxUz5IQ9wAJ04y3yWN/AJojU+JsegjZb9ByfW8Mdi9
         JI+P3V2A9BK3gexma2jf5UIHvRV0MsIR3ajVMq8cgTZZxK0ppQxqJ+8FGlZXFkyWvpub
         Kf7u6u++z67KqctxvyhSaPM9r/xSycdGywWbt6eKykKVyQ6WHFwFGmkdWYPo1uMLBqvR
         tFnQ6itMfxu2tc7s9gQiJ+KO4RAFV3zHrU15cjlmv+jJyxojn69ZSF7R44LdgTAHqWMw
         hs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s02yvdqPIv9mtVdyYNNOHPVfzGOc6FwpGfkhBVGVaq8=;
        b=GNKUMJeGvGB1OCDLrxB3NWFrsSZKF/pKH9POMGujqRORULxLUA2d8LbfiWIBFLVF61
         McPcqoGJzcW47w+DHjvv2PPwTFj6SgMEqAqdS15m6TJdZYRuCjQ7FJmBV6VZ6jkGoxpU
         3iHNMwUv/YT5RuuSTiL5p6PhHSCAvdlo0EnMMawCNzlfDUjG+oMi5C0mVKHrccmjBmH8
         OIdnMa0p6P5CRV8Y2FEabbW6d4Cg8GNycT8EgTq6xH8zkM/GIo4mtEditMPUHLjeqQi4
         7o5WkRmPxqDeZZ7QyqweCcyjXG028pq0TdO2GFxMfrYTzE91Jm8BXlow8u9+D3O2L41n
         GtSA==
X-Gm-Message-State: AO0yUKVm7IBxW0cjaMLzORA+gNNhvib+K+B59bmfCecsmOl1yR+RZ0FA
        MwzNiVS9Up9gZQv8ODq3/jtrwQ==
X-Google-Smtp-Source: AK7set/4+Bbn7AQlmKBF8PbzmTDTqQvtQej1gjEFwuqLhyAabRUAU17xFXos78BoACkcnZijzqlgYg==
X-Received: by 2002:a62:1c10:0:b0:57d:56f1:6ae7 with SMTP id c16-20020a621c10000000b0057d56f16ae7mr7331515pfc.33.1674846384871;
        Fri, 27 Jan 2023 11:06:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t1-20020aa79461000000b0058da7e58008sm2988206pfq.36.2023.01.27.11.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:06:24 -0800 (PST)
Message-ID: <63d420b0.a70a0220.ec59b.542e@mx.google.com>
Date:   Fri, 27 Jan 2023 11:06:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: acpi-6.2-rc6-146-g628c61874ffd
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (acpi-6.2-rc6-146-g628c61874ffd)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (acpi-6.2-rc6-14=
6-g628c61874ffd)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-6.2-rc6-146-g628c61874ffd/

Tree: pm
Branch: testing
Git Describe: acpi-6.2-rc6-146-g628c61874ffd
Git Commit: 628c61874ffd18b2ac7596523a60d3a4b3a0e567
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
