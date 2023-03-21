Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2F76C2ED8
	for <lists+linux-pm@lfdr.de>; Tue, 21 Mar 2023 11:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCUK2k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Mar 2023 06:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCUK2i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2023 06:28:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249061E284
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2023 03:28:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so19702350pjt.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2023 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679394516;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yh1GbxN6NlfsvLEY/zDb70pAlknLyh+ItpJBDZ1c6e0=;
        b=z53eYG2gZSHHhwU2MywL/O2ZgjTENLPqjnMwWrc3NlSYpql5qNxBZmX7PAsaHudsoM
         xOKym5uvcwog9AkteNvIQobFW74oC7dNU1MjUDjdKEJ1yg8cMBJfPhWeVqj+p5vxtVyo
         39rqtsgaETSzxDG8prr+xkuW1GCUsfisFj2N5GsdNI0KMPvLido+vcWxK2hkZXc6rwQa
         sHh1O/SYgtthPAjdidoxuXyBott8UueojiyWUK7M6eL7L7TK6j03uKLnTyS0ocnf7CtQ
         GnRYXkuiAxUZaAZ32gTW21UBm6H28cao3VxLVoD1EhNUERGnmxiIsqU12fAYzlzhbFfC
         YO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679394516;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yh1GbxN6NlfsvLEY/zDb70pAlknLyh+ItpJBDZ1c6e0=;
        b=RYuRwLhOI2ERHtKU8B8Nfids+clBrXAIns3UVIDMIOqPYmMd1sI9jHm/2McC0nlS6X
         GmbguE9AhqMDvQMVCiW/XCR8fo9AnbKsfbKF6EeTGcHfzzbK1mRXdLOlXZdebxaGPJc7
         vlkLWJx98ZHVs5fE8iOFDQqXUCKgYLWWbx6TWQ7IkohV+umf/pu5pbddTCJLX8C5P9cU
         2tLswtkyBDV3cBopvktjOIpeeMUSaxzA3qCDOx/SHwb5HEO9bD8NqJj7WN87Fq3sQ6XB
         kZrgQiG9nWtBU85qUt3U8xSaTlk5oelvrEAj0hJ3SntWUJeTK5BpdVOVeU5L+r4i7UFy
         mOBQ==
X-Gm-Message-State: AO0yUKV9qGLqL31ox2XFbsECCYI60ruckO0Wju+Ns5zVKNuZp71hjG0A
        VGMpqjl4swc0kwFOs7c79C7kyQ==
X-Google-Smtp-Source: AK7set9iFP8oRptDOCgQyKYFOM3oq6WQlk1JKpmIs91lei4EHBC+XcfWOPwy3mcYesz3R6MzegYJyw==
X-Received: by 2002:a05:6a20:299e:b0:da:c080:9b86 with SMTP id f30-20020a056a20299e00b000dac0809b86mr831856pzh.53.1679394516611;
        Tue, 21 Mar 2023 03:28:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g5-20020a655805000000b005039c35225bsm7541739pgr.94.2023.03.21.03.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:28:36 -0700 (PDT)
Message-ID: <641986d4.650a0220.9df74.c436@mx.google.com>
Date:   Tue, 21 Mar 2023 03:28:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.3-rc3-30-g51555d0c77b35
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc3-30-g51555d0c77b35)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc3-30-g51=
555d0c77b35)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc3-30-g51555d0c77b35/

Tree: pm
Branch: testing
Git Describe: v6.3-rc3-30-g51555d0c77b35
Git Commit: 51555d0c77b35f23311fe0c81bad3a8083478a96
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


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]

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
