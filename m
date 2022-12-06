Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0195644283
	for <lists+linux-pm@lfdr.de>; Tue,  6 Dec 2022 12:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiLFLwc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Dec 2022 06:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiLFLwb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2022 06:52:31 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A299027FC9
        for <linux-pm@vger.kernel.org>; Tue,  6 Dec 2022 03:52:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so17775658pje.5
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2022 03:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CDoFXdqJAEfyMF4qlxPwSxbVRIGfxLhIdHj1Wd9v1cU=;
        b=ldhRl2iXWD4VAbrLzDUqOmcOuK7iFb1hgKQSwAFgc9StHWTgkfLCdjyfsK9sX0mmvX
         +ZIHy2qzn2015APbZdopoxS8g45idyubLwoznUdXaXM5dDiBnzIdX7rLC43B/j0yTjwT
         yU0lS8/BlA8J8Skz14CDx/nT5F9GkeK7a0kmRCWJHrdAIg+nhFQUab6t9Pvm+oMPI0GX
         T3IJ0QGl5d9GX8+A4ebmP3gDkFrc9rxLDZbUYEfE/Fynr+EpVI4xOYdEr4l9evbAWBsc
         jHeaIEWzjcCn3AOgwPllNvUKolHnzL1+2GSUhU92V8WR+5qc316mzCQKkAaIyXN7BkFt
         XqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDoFXdqJAEfyMF4qlxPwSxbVRIGfxLhIdHj1Wd9v1cU=;
        b=VBxq6mFuVCAf6oyS39vjW78IVe1ejEHNgHCtuAgf/NstKYOL2nOLoQ3/V391Pj3sKQ
         Ffci7qxzJjbj/PR7bxjlvPEAfmTUn1MHtCORzY6LSLGH/WWEyu4qndfmOSZO7AoYbDyi
         E3FliSujzLGOiRi5VlWPyhe3t5u5vspejuyqHMuRvbXtPYxha/v8/Cq7pFJ8GuY+lRY0
         jJncVkiFKMh/1R9A+n4En5DCQ59kSinckhOLKHyDYbr+pfAvDSaOoVgfdAAloZkKNum+
         YmEIXaisCTAbBOqS3tDwAYeowQ627rYQNhd/JOT4TuvyWA7JCv4pEHwh+1hKvBpM2xxp
         XwpA==
X-Gm-Message-State: ANoB5pn3fEHVKHllSE0/7PGd+5ccAc+E5gpkqAvw3SYH4J8DK70vBi8O
        nM3ga7BjY3YtXtdaIWHZ8SvvoMVEM8KQt573M5f+Ag==
X-Google-Smtp-Source: AA0mqf4DLthg7WZilYwh+h3godI9xctF3+AKB0zhEpBsj8lUPYJG8M9sYlhkur3UFJ8i6EeDOwl6QA==
X-Received: by 2002:a17:90a:7896:b0:218:6fd6:b693 with SMTP id x22-20020a17090a789600b002186fd6b693mr93601978pjk.29.1670327550114;
        Tue, 06 Dec 2022 03:52:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 62-20020a621441000000b00575bab45644sm3066158pfu.61.2022.12.06.03.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 03:52:29 -0800 (PST)
Message-ID: <638f2cfd.620a0220.e65a.5d43@mx.google.com>
Date:   Tue, 06 Dec 2022 03:52:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc8-156-g0a9e32afe717
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc8-156-g0a9e32afe717)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc8-156-g0=
a9e32afe717)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc8-156-g0a9e32afe717/

Tree: pm
Branch: testing
Git Describe: v6.1-rc8-156-g0a9e32afe717
Git Commit: 0a9e32afe717bcf671fa0946d3f58d5bfe9fa6f4
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
