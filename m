Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A79E6DA20C
	for <lists+linux-pm@lfdr.de>; Thu,  6 Apr 2023 21:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbjDFT6B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Apr 2023 15:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjDFT57 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Apr 2023 15:57:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D435FDB
        for <linux-pm@vger.kernel.org>; Thu,  6 Apr 2023 12:57:58 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so41724452pjl.4
        for <linux-pm@vger.kernel.org>; Thu, 06 Apr 2023 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680811078; x=1683403078;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RNWY/wrPXgBmzOGUPf97Dii6ROoNMiD5Maxsog/HK18=;
        b=KKljFSl98kevJ96WsY6bw99zU7Xe4qhI5WEx7j7LWBLcMXPAH3mRbGi8IPh/TNgIhr
         YTfAS7sFmMLePaAkAxntD/JqZ0F8NnBJB5fdBK/259NOP1dgtFdqvnbpdGG4OEwL/jP5
         F5aT+v8PEoDR/n2gHoLijfGvqZxO1umOJjhsTkdoDihg3pHiklMoQz/EqyMoOSYh2ijr
         dqba7g+7eWVmRL/4N1RE0VdgJy1nglUc+foEakRB/GXqJKeGRfwYritggQXFQlitRUnd
         oBcb0Lhm8LA2OC8TJVRveVT7YFYDpCb01QAfNmxWBPunbtoIIM4il1vKZWdP/3k2hebw
         zQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811078; x=1683403078;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNWY/wrPXgBmzOGUPf97Dii6ROoNMiD5Maxsog/HK18=;
        b=fBrolmSHq2/CwHAUqnqC1mLefbKpd1rVFaOT1wL5Y1ZqSjFh2AV00PxU+t6KvAfoJu
         LmqvQfcTH1qjFe7HYmg6TPIi5l3MTZPmdYPrq0axem8rytOTZxi3+pAj5+YTaWqx5JYZ
         2U5ECthyVWU4xDtWiG6d+aPuH9mCwEB6oZ1XuIn5UTzZH9n4Zp3Qd2QXT/K4lW8SUY5T
         izSG8QlBCejRGSyi9f5DS56PugdLN6qiDdmvg6FbxJk1kI3zpDG0MkL7dov9O4NGa+kV
         DSCFLNK7fJsWODJhOZ8kjYchxHKIATtfhZjbirw4aTS3SAp7uRNxbkHshiE9XDAUOElt
         vwYQ==
X-Gm-Message-State: AAQBX9dWioSOci9Ma9ybLkzIRVcSQ+jjLy88U2gsK6viNBBvmmo66PJc
        BKYKaSv0jD9HVz/OEUBflE5FlLURMTLYxbDIC3wmFhoO
X-Google-Smtp-Source: AKy350YG04IFahLy/yPW7/GlvQfU+eLI4xy7vL1wbFHQrNvsaooUKPTKlBSaZCClCU+KnGJeXcM8Jw==
X-Received: by 2002:a17:902:c651:b0:1a0:7508:daf2 with SMTP id s17-20020a170902c65100b001a07508daf2mr308303pls.2.1680811077889;
        Thu, 06 Apr 2023 12:57:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y1-20020a63de41000000b00513092bdca1sm1511472pgi.73.2023.04.06.12.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 12:57:57 -0700 (PDT)
Message-ID: <642f2445.630a0220.86f13.32bc@mx.google.com>
Date:   Thu, 06 Apr 2023 12:57:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.3-rc5-82-g88579d8989f1
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc5-82-g88579d8989f1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc5-82-g88=
579d8989f1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc5-82-g88579d8989f1/

Tree: pm
Branch: testing
Git Describe: v6.3-rc5-82-g88579d8989f1
Git Commit: 88579d8989f143a528ada7f733b72091ccd3e2a6
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
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
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
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
