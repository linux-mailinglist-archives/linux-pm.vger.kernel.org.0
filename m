Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5924B776B2D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Aug 2023 23:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjHIVn1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Aug 2023 17:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHIVn0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2023 17:43:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB191702
        for <linux-pm@vger.kernel.org>; Wed,  9 Aug 2023 14:43:26 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686f94328a4so204962b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Aug 2023 14:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691617405; x=1692222205;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XywXds2Sf2R+7b3izGEFrV6NLwDa343fJgzH/kY5xMM=;
        b=L1ET3fbtLoyD+V1jRn2mj0ErBodd2L15Z0tRjPwPINaAYRvXE3p2ZjSIRHG+Dt3Ogw
         yOAZeYbQPu9yOUOyhXh+xl7taz1d6H52+5HJbSBKRdZHO10QR/lwQyKajzeDdkIJD30m
         ltG1Gnc8LZLzlhTlCM/BMXnlHvn798EbgUvOFpkfVtp189jxD4tuUGTJkPVYADs76mdJ
         pE4QOouztwJ7iJgL3ROOP8nq2B3zeQfx+SQqoWMnQN+zFdoxkDxFbWNyRkgYHX3SKLrH
         0MvF4Mr6HMUSwbefx5pgO4lC3WAQYEmYGv+Hlmkan1o4BE9g1BsAZqwIe1fSNFZdbDah
         8KLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691617405; x=1692222205;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XywXds2Sf2R+7b3izGEFrV6NLwDa343fJgzH/kY5xMM=;
        b=K0LbWTAbHRFvERTnXB85koJ6WgnurFRemowCBp3H9p45woGWhQa4LK54P/UDgWv/cS
         XOpMygaA6xfQ6nIPSeGXJ3GycO5p+gwAvyxFwHM08eDObHFH49QcyTAojqxMotL6wlif
         rmQQsOkd+ekDykAbe3tu/Q0IEAS49FOcgPHsqc5HcN7hm8hK/OmD8OqUhbcACKJvAzPV
         dzwVByzJmLsN78DvFhJFialiqQtqOHbglaiOz2KoR4C+H7Cq0eJ12nNS7yiZ4sWzyeal
         9qtks6wvhF8BDcdLLYYynh/XtImSF6JM8HUU3INuZYDz3fHVRKQX6VAOEsKc91rgzaL6
         VjnQ==
X-Gm-Message-State: AOJu0YwrHkpSv764INyYoZOwN54Hvedpbdg1vsSqoKHZf77cTGuTkho1
        Ok6k7EvN9L/cnV/B0v7OydDtwA==
X-Google-Smtp-Source: AGHT+IE0ko9q+bNTr+84DA/kM2le46i+xGSGeQBWga9/ff8xevUVcBD/C8Vae3dN93r8Y2h3Z5CaZQ==
X-Received: by 2002:a05:6a20:1588:b0:134:73f6:5832 with SMTP id h8-20020a056a20158800b0013473f65832mr218568pzj.16.1691617405478;
        Wed, 09 Aug 2023 14:43:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7820f000000b006877a2e6285sm59912pfi.128.2023.08.09.14.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:43:24 -0700 (PDT)
Message-ID: <64d4087c.a70a0220.9e1bb.034b@mx.google.com>
Date:   Wed, 09 Aug 2023 14:43:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.5-rc5-74-ga20df7d5b715
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.5-rc5-74-ga20df7d5b715)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.5-rc5-74-ga2=
0df7d5b715)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc5-74-ga20df7d5b715/

Tree: pm
Branch: testing
Git Describe: v6.5-rc5-74-ga20df7d5b715
Git Commit: a20df7d5b715d8e98e9c26642039b200e00edad2
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
