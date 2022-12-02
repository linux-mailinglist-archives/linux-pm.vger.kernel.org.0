Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD28F640FC3
	for <lists+linux-pm@lfdr.de>; Fri,  2 Dec 2022 22:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiLBVFr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Dec 2022 16:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLBVFq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 16:05:46 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B272EAB7D
        for <linux-pm@vger.kernel.org>; Fri,  2 Dec 2022 13:05:45 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 140so6011110pfz.6
        for <linux-pm@vger.kernel.org>; Fri, 02 Dec 2022 13:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wFotzBZEznDLcqCJjjRQxtY/hHfDFvYP1oqtqFi1lu0=;
        b=cq5xFNbWepaovI+GnM9D6ZUz103+a7E5fNSKt7xduqd6+P9Nue4MvI87jz8jsN+4AF
         Rlg8n4ozXSycKNf9P/VQaOpoICKewAwJaGkLzrpjAI8WK0MeOw7sLpVai4q0g71YhZmJ
         Es7C3CmZDKjKKj87ktBX51BG+eiqBIFTWdAdmddeY7/AwzjMaGZZLbmGD4C9VvVvAg20
         khpVv9ACqN218lB+dC3ux81qHad58WBl9kSCUW/tiwlaeoeCWImHzwykMhjzPjkQ0Xnr
         n8AdCYgcb852PS/+CMujAPv6ry+z5YpDqXnBsKJb4CavF3fKCr2hDjWCVu80cRnmg3sR
         Uihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFotzBZEznDLcqCJjjRQxtY/hHfDFvYP1oqtqFi1lu0=;
        b=U0kNFioO5QVbl4PxveMgqAyp7Tchg3dXuTOVvN5COMiIBzYcJidc/sCq3VbTILNOIt
         iJeRouoRWi4SHFMOjwyFvZNs7YnpgdthPOCeoQ7gU0JFQvo/I1K7pogl47tVLoQV14dQ
         JzKodxcYdLT23t+cDUYPCCpI/KdZ3S0erUafvMKgPxg2LU3w5s9TbGJbLPTd+uHlX3hi
         2BtI9qrsMDsRZJs3I2A6RbqTqFXNPxTGcTVifs12RC9oZTv1eQWqgTUuGI5Ne5+OXbWY
         xePQnn6bawjSqySwoutgkPZXm7CijnZ6wl3v8nTWPBWyhjk78jNsQFa156p5eht8DDKQ
         2VCw==
X-Gm-Message-State: ANoB5pk68uRAuhFqbG56MKY2xvFJTiWHif3M+jCdrw6K0/sumyXwxtR5
        Pxw3DxRMcFCYqUBq0PurvGK/eyt3mklxjuVnz14dwg==
X-Google-Smtp-Source: AA0mqf4viezhSf6Gg/8mcaDD6wbUmhL5uGVq5tP5VX9m4Cmd4S0jvcKkshMCsGPyULz5G9PavwUisg==
X-Received: by 2002:a05:6a00:4c8f:b0:575:4bb2:d67d with SMTP id eb15-20020a056a004c8f00b005754bb2d67dmr24325268pfb.32.1670015144778;
        Fri, 02 Dec 2022 13:05:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b0017f7c4e260fsm6065057plg.150.2022.12.02.13.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 13:05:44 -0800 (PST)
Message-ID: <638a68a8.170a0220.88ca.bc47@mx.google.com>
Date:   Fri, 02 Dec 2022 13:05:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc7-111-ge1ca6bc96dff
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc7-111-ge1ca6bc96dff)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc7-111-ge=
1ca6bc96dff)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc7-111-ge1ca6bc96dff/

Tree: pm
Branch: testing
Git Describe: v6.1-rc7-111-ge1ca6bc96dff
Git Commit: e1ca6bc96dff669de20cfd5474a5e4cd5b7465b0
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
