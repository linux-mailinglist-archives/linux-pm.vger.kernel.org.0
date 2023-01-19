Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4217674652
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jan 2023 23:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjASWmI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Jan 2023 17:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjASWln (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jan 2023 17:41:43 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832F9A19B9
        for <linux-pm@vger.kernel.org>; Thu, 19 Jan 2023 14:23:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o13so3857939pjg.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Jan 2023 14:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hyMnk20fIAcVhSo7QVpgH/r84FCT/vLCYZgA7cEgVv8=;
        b=QjuDr/XAuP+OvBwv7S2TZRFf08P4XJMWFDkuiDCvk+SEp1otylXb2pltsflqeuJmyk
         YI3Smd1yJX6pzCXDE96VoY+QDcgO6xOef2yrbKyemkGBIb0s3TpYgPNKH1orkP//wl7V
         82GPgwyJI02jN2nhUYoFWSJr9u4OBUgkTsg0QOPL2QUeEqbzjiT/NzHeolFFCmB+QRnJ
         8jsvSmcwwBhOjMMBDKr6EehTwlzgJFTpp0an/gZRPjSOQbeEX/4YtPwAZcxeHzLMuTDk
         WonctxbsHv8Qsj4XoUv2YVZKTkrtB+F+MU/FKW2UCUvMukq8OmTcgG0MQzwD3Aa8mG/A
         srpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyMnk20fIAcVhSo7QVpgH/r84FCT/vLCYZgA7cEgVv8=;
        b=bH/UV4htZFATLtRaQaYuB/83rmy2tmPfS6UzAVghPH6f5zY6T/KUS60T1aKzw7nvHg
         uNibHn8kxnB2maNCe1g79yeGkaaMkXtWQPNB4/VoAVA4ndHaDPSLCZWSDFikBo15ZVvc
         izYyS2GtKJ/GomG5EPqFf34aFd8dhH4gbmYtRIYMKPA+jpluz6GM/XMxQG12/1d958Zr
         3MVrSSIj4ZCaKxFp0IasFkhMR8Ob9URv3GbmSmYrQQrUMaaA5zZ0R6JCFQW0gi3W5QDT
         7SuEa13AgVGXg5vcLdtBK6PSVWxaWJ7irsDVowXa8jqvYUnHIKQICS4HLi5mM38ZJ+ZL
         capg==
X-Gm-Message-State: AFqh2kqibNPlGIa5aNPziosJayfv5X50b1aog3BybCRdJWit1UsKsF1h
        5K2ivFgM3c/ZJXnSONAk6gSlgTTLpkpheKXVo8M=
X-Google-Smtp-Source: AMrXdXsqtXQKT3Atm06s1X9p+aizcrmpgddzyJwKjSnr7TtoaqbTfN0GfJu8ZzaMvruFCbUSO+O4eA==
X-Received: by 2002:a17:90a:de05:b0:226:e1a0:6596 with SMTP id m5-20020a17090ade0500b00226e1a06596mr12912210pjv.12.1674166997764;
        Thu, 19 Jan 2023 14:23:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q64-20020a17090a17c600b002132f3e71c6sm123198pja.52.2023.01.19.14.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 14:23:17 -0800 (PST)
Message-ID: <63c9c2d5.170a0220.3ea60.0594@mx.google.com>
Date:   Thu, 19 Jan 2023 14:23:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc4-80-gafd822f01cda
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc4-80-gafd822f01cda)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc4-80-gaf=
d822f01cda)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc4-80-gafd822f01cda/

Tree: pm
Branch: testing
Git Describe: v6.2-rc4-80-gafd822f01cda
Git Commit: afd822f01cda9833bb5a4525a0dd36c689c5941a
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
