Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C244262993F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Nov 2022 13:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKOMw7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Nov 2022 07:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiKOMw6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2022 07:52:58 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A465C27DDB
        for <linux-pm@vger.kernel.org>; Tue, 15 Nov 2022 04:52:57 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s196so13193535pgs.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Nov 2022 04:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PSOuU6KoeBdeQZZuFWO5/W6k53v+V1kLdoDD6W6dS6U=;
        b=DbHgzWsCKvN9EJ3qkUfWj2mLhRkIEUEUDOTNO/rUhiBsbVxFnY9Ui/HhFFO+cCKl+V
         f5JdBXBJ/UtEcPtovBmJgYwwZbZgANXWdSy5N+n6fZ8YRhuq1XJ0Oqevu1ftWyqa1/DE
         IGafq9lmbG0pKv7V9LT1K/eJbwQ7NkrkMm9/qcfEdD00YAnqE9NVuQQ7njSsp8cxd9NR
         lbkEau+He9NqD4mVAYC+kvaYWuZcrTS6lz4dVDnt4yWGLxoxy2VmWrj2y3sGtlVwDJuw
         AoAUjf90pE4jSWt4/N81ocu+EiVPkyHosSw/akvT2ctx2yEjgS12vZZOm4A8GjfduR4v
         pZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSOuU6KoeBdeQZZuFWO5/W6k53v+V1kLdoDD6W6dS6U=;
        b=bt556ouVyYeW1o7CjREQgSj1u3nM+joKb1+N1L7ZJCgP3tGcxLyX/ptgL3xO+IiuGH
         4NjNKmZ7ZoD+TR30Py4uLFWi/peCvVYaJFFRbTNWZHrAC8ql/YjWbwate7VZSkuWlzVI
         +aZ1hrdPolc5E6TO1H023Spi+rSzvNOnL2P8ltgleT/VYpe/Ltnw6p18ObiZDIt7Z632
         IzpveLCM89E+ATwTleg19+AWrQ9SX25yz3foOlxCjWi9rISr2Tmy4fosZBGJJhFeoubh
         i18t65MpWJ6U7ObRHOh4jfyUfEJl59wh9Sgu19GqHmDmls1A1tIh04EnEf1cewqHstMV
         /fOQ==
X-Gm-Message-State: ANoB5pnbFi931mDsYuyL1sNkMRRqjBOVupl63a0+DhAZFGM/dZkRmTIN
        I0O2G3zXrqQHpONsnHn+ytGHNg==
X-Google-Smtp-Source: AA0mqf7lKwYQ2j2DAGMOt2YDO2rMKmBA8UeEO8RBuvt6zN6m/F2/AY2nbWLZQRbuVpV9m4v7XfZLwQ==
X-Received: by 2002:a05:6a00:1c96:b0:563:69ac:2f05 with SMTP id y22-20020a056a001c9600b0056369ac2f05mr17913192pfw.33.1668516777147;
        Tue, 15 Nov 2022 04:52:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jj3-20020a170903048300b001714c36a6e7sm9610796plb.284.2022.11.15.04.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:52:56 -0800 (PST)
Message-ID: <63738ba8.170a0220.33b49.da88@mx.google.com>
Date:   Tue, 15 Nov 2022 04:52:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc5-55-g60453df62d30
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc5-55-g60453df62d30)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc5-55-g60=
453df62d30)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc5-55-g60453df62d30/

Tree: pm
Branch: testing
Git Describe: v6.1-rc5-55-g60453df62d30
Git Commit: 60453df62d306d285f98efa85de9871855a15233
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
