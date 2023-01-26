Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48B867D7E2
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jan 2023 22:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjAZVol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Jan 2023 16:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAZVok (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2023 16:44:40 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803804B19D
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 13:44:39 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p24so3074704plw.11
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 13:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u+kUUbeTcOb48mchbBpgI5nGJekzLPc7/rMLlF3T9Qg=;
        b=fEgM5rKPANKOUbnIZ4fIWaVG/+FQlGzqDhNnF1LStNnwquJUBTZ2kdeMosqKoVljdv
         N4Gwz/dQ7gtNCfTaMMKHYNpFXRJv2cs34pstV5BKvG6w5wQ4d9VS8ylZ8NdXlGKaTWlS
         QHNcoEQOaih5eMAokvejIV5F5x64aYUBQA6V8hg4u5gT3cDGu8uwwY0gNox/kcRvXKIV
         AM/Q9xaRuAgzuLR4ZdQrG5oFH/G9uh2W+Le3QWHG52AXikt2wgHdzSxjKvvjC1ZGeOlc
         npHUd7KSaPjT4WKJy//GY+kW+74XhxP099KEIsDDXlvSjNKOhZQRNrVgMKgS+6lFmjAB
         HO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+kUUbeTcOb48mchbBpgI5nGJekzLPc7/rMLlF3T9Qg=;
        b=Mg9ZjYGbpJSrQnwTiOBvs3+mwlvAy67hVH/nQnJQYBwrUj7cSMcg1VbBQOm+Rg12L+
         wsNYDkacEVR6w3tE7JxozgFREW52tPf9miRBcLMR7MbG4e6zx2Z9yUkqVyqdtP4ywT67
         U4akpztkTxr2XffPvAoNvCeeL4c5EDeHfSoGJEDrgyckwu7UDjQjv7W58ATLtejjwO9U
         t4bj4Sws2DNV5pB8NMJkQgzXK+jlxGT33XS0QMni7Vfmb1ImYe4HNJo2L8VK/VUrgZop
         6VDiAwP0YJKd1zs3r8yVdNSknbKN6TQq76Tb3tiykZleoWVuGsyvfqGhiWPawUfKc1hP
         bXpQ==
X-Gm-Message-State: AFqh2ko8FDkYEq6jC9B0+SKEZtzNT90Bi+2kFyN31FrTHm7P1JhFF5KS
        OcHQFa+OmjZjl+oSYhs8nIhPlg==
X-Google-Smtp-Source: AMrXdXtdQ60E/LXiefNHC76IQiSidH3VSWOLq/MvcCNQW//2VwOKK5SL1RQ/a6uponsBrzegqsz1vg==
X-Received: by 2002:a17:902:ea0e:b0:195:f0f9:a9fb with SMTP id s14-20020a170902ea0e00b00195f0f9a9fbmr29004394plg.11.1674769479046;
        Thu, 26 Jan 2023 13:44:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902ccc400b00194ab9a4febsm1440489ple.74.2023.01.26.13.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:44:38 -0800 (PST)
Message-ID: <63d2f446.170a0220.38cbb.23d7@mx.google.com>
Date:   Thu, 26 Jan 2023 13:44:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc5-141-g0bb04b623f4c
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc5-141-g0bb04b623f4c)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc5-141-g0=
bb04b623f4c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc5-141-g0bb04b623f4c/

Tree: pm
Branch: testing
Git Describe: v6.2-rc5-141-g0bb04b623f4c
Git Commit: 0bb04b623f4c836a9df3199616369010dbf5ce17
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
