Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B815C696B62
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 18:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjBNRYW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 12:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjBNRYV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 12:24:21 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3DC2CFFB
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 09:24:05 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so16092511pjw.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 09:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OXO702NYezjOOPGITdgS1tYZgLRAZIGG3/nsi+YieSw=;
        b=Fh9+7AUn2Ij9HXj04JiPOIoyWktfG91F17mTVFOK3ypWH0kcsQKfLq5i6JJXF6gKDF
         s+iqJursk4ntqLqEN/YRnQLH4NKqmwTktJ+h8KyV7TG8tqSyxRfTuh1dDaDbDKyyUQ8C
         VBR2Tso2jrxN1fLdwCr13AW2cgUfBLDAN6IG/U5ZbkBP0RxLDL/Aq79gB1Pz8SAim3hK
         f0kexbEdDaN3mtC896W6Hl6gEPwuU8EQyv1+IQJ+0P1q0Yx1kQUPdagvyMoKs5efvT33
         mqUDXswwebnJ4UZmeg4bN1CXlo/QPHKKKtBxnI9j2V/FE8823bvFKZYKnfff65Zl1l5d
         ZGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXO702NYezjOOPGITdgS1tYZgLRAZIGG3/nsi+YieSw=;
        b=k+tJmZICF1jHDceotXxAnh78AYpZUBPqkB81m3V3K4q+AsGIut+PuMyfB+If6tz/7q
         5xDcx139XAM6w4m8fbYg0MDyliJnzAM+L2Ky81V6m1uwST4c/T40Chz2q5msTQA/Erhk
         NJz3sTriXZFYlMZL8s0Vt4s8jiTp3Q2DHElXNnfGgTsGhxs3DqaFZX7NX13XNgxgS9NR
         dNUYuOqd6Y3s5E/mpCK58VotnlMC9fdYbQ2ADiXkfHmXtD5Hoj6by4e3MH/LrBgKqWu9
         lYB6faEIHsdmLeYO7FxO/awOotPOVbqx4yf2c7+YSgEDsRomMih3peTyZiV2pFZ2zb+A
         lBeQ==
X-Gm-Message-State: AO0yUKWJN4iC1h9kdTbgETamx26K26k0WXKpNPX7wSGmofUo8iBYRccQ
        mYoGhwR4jN6eCf3DyY2yGUES8MwmfUAsMmKQAsY=
X-Google-Smtp-Source: AK7set90Jg8jo/Y5zIbiAZSb/l/s1WKgaRIMxVHc6FgvS1Y+FtW4dr+yL2sjtJd6cdaJt4P0zRzwBw==
X-Received: by 2002:a17:902:e2c5:b0:199:2e77:fe56 with SMTP id l5-20020a170902e2c500b001992e77fe56mr2593310plc.52.1676395445093;
        Tue, 14 Feb 2023 09:24:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902aa8f00b001990e1aeae4sm10405090plr.47.2023.02.14.09.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 09:24:04 -0800 (PST)
Message-ID: <63ebc3b4.170a0220.28478.20e4@mx.google.com>
Date:   Tue, 14 Feb 2023 09:24:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-6.2-rc9-244-gdfe08e56df2e
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (pm-6.2-rc9-244-gdfe08e56df2e)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (pm-6.2-rc9-244-=
gdfe08e56df2e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
6.2-rc9-244-gdfe08e56df2e/

Tree: pm
Branch: testing
Git Describe: pm-6.2-rc9-244-gdfe08e56df2e
Git Commit: dfe08e56df2e9bb7d3b34e24284a28536063365b
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
