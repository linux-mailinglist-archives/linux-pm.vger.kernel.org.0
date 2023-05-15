Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9C77030B6
	for <lists+linux-pm@lfdr.de>; Mon, 15 May 2023 16:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240326AbjEOO46 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 May 2023 10:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbjEOO4w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 May 2023 10:56:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80A3100
        for <linux-pm@vger.kernel.org>; Mon, 15 May 2023 07:56:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aae5c2423dso124639225ad.3
        for <linux-pm@vger.kernel.org>; Mon, 15 May 2023 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684162605; x=1686754605;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kO9IRLef8pduSwic3Eq6AcLIlXzvh3sjqODzruAMNZA=;
        b=wHpu0GZ+Gj/OVOb5dqPcZZGhp74fvxIWb8vGhmrXByPqHgyox88/BgNFX6a1BmK1RG
         m/GC3VjptfSadOMyEhMKEDrHbG8XA/95FewnzDjpknYY97ref49HBb8YntbHMDo6dVz6
         9Fw7h+C6/NSM0HaSIAljDZTLCa28Qleasw7scpFwn6/yK3jBThjur6QGp64nhs1mASIR
         Y0olBVd/OajHAIfuzbAvJ7JZHa/LjhkBrZudPcC7P5ZUFw2ZEHSt3ZaJMRwLP3ES+9wN
         kKxAOfqQAMr7dlpO7gftgMC4ydqJmtKu8CUkzbpOfc/NdloIgMoObkdeKdz3PSPlEOL1
         DWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684162605; x=1686754605;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kO9IRLef8pduSwic3Eq6AcLIlXzvh3sjqODzruAMNZA=;
        b=NNl5l4dEL8XlE9myf101qPi69Cx2HPyCu0KnjywtfVDTfD/5cW2WhKHkKf1bkyhVpl
         DPF3bxT306IyXYcXHzL5auJMD4Cjhx/kJi2yHWwWVto1dh/6jArRJGMySqHvK/NR5KmG
         2ve6jU7+GboG0MHS+PA77ItNa0u4b+g5atD2ZeJP8mOO8B2cwYt/N+fkgCM3829YT+dm
         HpcykcTl/MfEV6SkFpUMy+oULsswH1p4kfYcI+vMupPrUJ0KLwSw9cEaBkwOUM95jeSR
         n89QZmCRLwaGQsu8U8lvnZ3Zhjza6iwqq8cLJV8OmhxwtdSa62k/S71D/hH+DPrevS2/
         R0sg==
X-Gm-Message-State: AC+VfDzM/04xoNfjB8dC+3jiDXWcO+FZ/zALU74aVbqe0cBSQBiH/Xm8
        vf55qntMRoRhhRQjluzi4ULoRlxC1ZlPhRCHgchnmQ==
X-Google-Smtp-Source: ACHHUZ5yP2M51JsClNwXNqtYuwMSztVgoR6JH/AhkpYOaKVwWXJ5q3YAsMej87F1YWgBM/mtGdWFUg==
X-Received: by 2002:a17:902:ee8a:b0:1ac:6c26:c32f with SMTP id a10-20020a170902ee8a00b001ac6c26c32fmr29557406pld.46.1684162605113;
        Mon, 15 May 2023 07:56:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ix10-20020a170902f80a00b001a6d4ea7301sm13604013plb.251.2023.05.15.07.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 07:56:44 -0700 (PDT)
Message-ID: <6462482c.170a0220.d5ea.a3c8@mx.google.com>
Date:   Mon, 15 May 2023 07:56:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.4-rc2
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed, 7 warnings (v6.4-rc2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 7 warnings (v6.4-rc2)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
4-rc2/

Tree: pm
Branch: testing
Git Describe: v6.4-rc2
Git Commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
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
    x86_64_defconfig (gcc-10): 3 warnings


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    1    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: .altinstr_replacement+0x17a8: redunda=
nt UACCESS disable

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
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    vmlinux.o: warning: objtool: .altinstr_replacement+0x17a8: redundant UA=
CCESS disable
    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled
    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled

---
For more info write to <info@kernelci.org>
