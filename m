Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789E065F664
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jan 2023 23:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjAEWHQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Jan 2023 17:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbjAEWHO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jan 2023 17:07:14 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C22367BE4
        for <linux-pm@vger.kernel.org>; Thu,  5 Jan 2023 14:07:13 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id a30so10759319pfr.6
        for <linux-pm@vger.kernel.org>; Thu, 05 Jan 2023 14:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7RroxY/pkHFTrpqQKk13i+tGRgrRW1DTV+/p+bb/CPA=;
        b=LxSKFIDwH4GkQLqo5IAcE3KHTfT11t+qGv0TmCngXI/sB+jb87VllDjPpOgVQyF4M+
         l3v7qQ7eQZDmdeVZSV6vpSM5Y0ns9MHrnNYKVx4TxGHDgJEIwz+2EIeo9ob9w3nttZjv
         5lWgvj542Ww7q64AMVDv7oAml2RnPbS/YNlm98W8iviGGeadfDcvjfw0sZZzX23QaDnu
         NR8GVm+9uWFm4byneP+LNoGAY+u7VKAT0acvphaulesFwooOTNvmwlmmB3haDWYWV3jh
         ZBhBIurWpokftGpB1257vcT0SE6bmkY0R667bKj6M4th4lI4EIWe8PR5Qv7nRBVOIPDe
         Ku+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RroxY/pkHFTrpqQKk13i+tGRgrRW1DTV+/p+bb/CPA=;
        b=WGDe8ioBVWtY0JvProuaZlTLmiqhapiCUDZobypJw2hlXe/kTPIvE/LMziRjLL0751
         LpO0Vrtj2dVnLpCZzra2Rdugn6Wzt4attjGLA0pVY0R+rP42zJkb9xyLUmdm24nw65u8
         r75MXxu2K3NM5asuKDwLyjOOIDMlk3T3+ZTXhOyW12b3XIdOY9N4e2oI+NWc9MX+Rw9w
         rnJly+EDq+V5S4kJyja6qyb80TDusYiESOqTfZ0Ea9Zz1/TudRP7AiTQdXbCx+e23vzA
         WefrvmGUvT8FzOh5NKqLPpK6KnY7XoIfwJoeATShFgtpttZ0sjhDfmQq+j+k2NxRSAS5
         FTWw==
X-Gm-Message-State: AFqh2krxdi+AYYx/GF3cuTeHusFfMc8/DcZKK2+DaQT2EY+t6K5sdYMK
        Fo9o1wJw+TLApAFMNS0dIoB1zQ==
X-Google-Smtp-Source: AMrXdXvC9jisuFd4XbSkn0M9UUb4fpDIu6tvad02a2vQqtXAM/k3k4+29norVQ7lDkTSKD5ppUkn1Q==
X-Received: by 2002:a62:cd0d:0:b0:583:2971:df8e with SMTP id o13-20020a62cd0d000000b005832971df8emr3402843pfg.24.1672956432860;
        Thu, 05 Jan 2023 14:07:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q19-20020aa79613000000b00575d06e53edsm1686088pfg.149.2023.01.05.14.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:07:12 -0800 (PST)
Message-ID: <63b74a10.a70a0220.653cb.2958@mx.google.com>
Date:   Thu, 05 Jan 2023 14:07:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc2-13-g83965b829e5c
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc2-13-g83965b829e5c)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc2-13-g83=
965b829e5c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc2-13-g83965b829e5c/

Tree: pm
Branch: testing
Git Describe: v6.2-rc2-13-g83965b829e5c
Git Commit: 83965b829e5c0f5e013538f5f09dcde99bc5ab22
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
