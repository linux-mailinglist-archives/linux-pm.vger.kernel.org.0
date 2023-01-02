Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768C365B451
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jan 2023 16:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbjABPhM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Jan 2023 10:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjABPg4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2023 10:36:56 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55115C0
        for <linux-pm@vger.kernel.org>; Mon,  2 Jan 2023 07:36:55 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b2so29836083pld.7
        for <linux-pm@vger.kernel.org>; Mon, 02 Jan 2023 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3xbPAAoR5TNNaXxpt5BXhcyV4DPiLkdBlfg+2MuRDz4=;
        b=Y8ESOzQgsgIbS1fDjDq7NWStVXvuq97bW50NeYZ80/CcYdFbggpe3EUa/6bWc2PxTX
         yhmnhokNDwzbqhBWbnJMHEkt3MhtwEHxpkBNCQGxOADVv6oXZH3nyCLgHepryskepL7V
         G4HTUj7yxQDti6iU40LWMTTYgveUOrT2XAAC12c2nT3dPcCTlDOqHcj6SftUWwM2bWLd
         YaxjBoO1wm7geqjRFtqjINkxr5ltHC/RbQNmofP51BdORyLZa6xuOexCm5W/QpWVgMKs
         4U6LMVm3tGAEgovftEKst40yDDoIt/cZ8T0jMGNzUwiTSBKby279/o2WZaFULn0oWmC9
         0f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xbPAAoR5TNNaXxpt5BXhcyV4DPiLkdBlfg+2MuRDz4=;
        b=TWOlGZbz4rBE8GqjzLYSb2fe5xdYq3f8+Fkq5ZOh73Y8hrn9G7UtiVHEzjg0wnk2k5
         ZWLbd2J7nvoT073qmrdsa2pSKigXmJORqIWkV1f4Eub3T9HJn8XcDVWOlkXDwHAW+wZs
         1iX3Ps9IoNX+Jh2huQ3rms3tsJ1IsSH9oaMQ26x65sI3wdGJwYWFwDJW4O+YRrCM/oyZ
         mrDFNrVCdc64kICpzdird4bWTSQ2yFrssMD5ivNCPEsp5G+9ZdD1fMWV6kWyC3bFayWd
         7o4IMxoubXaC/FSksbVNHA2Y7OMi3V8wgOiSz4kUAnkrIQbPJznl/+B+VgNoNIQNGgC9
         zKRA==
X-Gm-Message-State: AFqh2kpb4H6JjhNk8bm1Wo6AZtlWrzNcI+nbv0PpyFO2eb2zRsVWdIEt
        Y0bO1R8sHHicYc7vLJvAEk1KytF8jKxrZVHc+zc=
X-Google-Smtp-Source: AMrXdXuiGlwpKwZR/lv5FNJx19v1zqHFnTCxHSzsP5m/O0I/ApOiyiQE5JX5OnRsvhQ0s35oQJ1vaQ==
X-Received: by 2002:a17:902:da86:b0:186:865c:ea17 with SMTP id j6-20020a170902da8600b00186865cea17mr59479328plx.38.1672673814817;
        Mon, 02 Jan 2023 07:36:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b0017f64ab80e5sm20303629plh.179.2023.01.02.07.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 07:36:54 -0800 (PST)
Message-ID: <63b2fa16.170a0220.c1eec.0089@mx.google.com>
Date:   Mon, 02 Jan 2023 07:36:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc2-20-g2804f848d8e3
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc2-20-g2804f848d8e3)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc2-20-g28=
04f848d8e3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc2-20-g2804f848d8e3/

Tree: pm
Branch: testing
Git Describe: v6.2-rc2-20-g2804f848d8e3
Git Commit: 2804f848d8e3541dc77038a8d9b0b3385e93495f
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
