Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E2E6CCF89
	for <lists+linux-pm@lfdr.de>; Wed, 29 Mar 2023 03:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjC2Bdu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Mar 2023 21:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2Bdt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Mar 2023 21:33:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6874E129
        for <linux-pm@vger.kernel.org>; Tue, 28 Mar 2023 18:33:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ix20so13481507plb.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Mar 2023 18:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680053627;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b0sZVwt/KF3Lw5ppLmh71hhfx6Iu8TruV6I9k5u8Xjo=;
        b=C5EJTj1yPwAnH+x1jVXLosA97iElbM1hL5ZNeWwTbSFtpfmi/ABvllWbiyLwA9Cm0R
         E3iJPpnVRRiJSoiSgldzcoL03LW0DBbSaD1YuEsIKXERvqAJvgJt9C1hujufRRBDzr0S
         z/dSYOqoXr1QypM3FYsc+gtLKpW29pVFZ7UZbAMDkhF7M2leJma1uB+vhismhqKq0Ndu
         9ARFmvMRqdKmmlP52OMRapR0ySLLImv4gBitjuY4exYkOWKDFMDCzxfuoplfS2XXJgJV
         FRn2u02C9UVx8j/3OR3Mhr5LT3INzQ8PPdjfq/id+qUPRnqZG9RBB6UUxgbcNzTt0GrO
         IGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680053627;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0sZVwt/KF3Lw5ppLmh71hhfx6Iu8TruV6I9k5u8Xjo=;
        b=6JQ26YNsTBgwxQDtOjDvZ0V9W4wm2G0gCEcUPvtONxG3YdcwINN9rbFk7oXQZdwHRp
         +ErqapLY9M9EW0MKS5Z3VZLe+F2QBXe3yAY/g9Ln3ilOo4jBlrTWSDhE8GdnV8o/gfIv
         4G9PpbCeelP9AbtBMnnohtjFjYzu6FtuVtT7v8Ah1UBs8dtNxFkAsU3xC+qzm+CGojSz
         53lnfsQ4frxvafE4LaBZI1QIkv2+UPI2Xyy/saHKH/gHXrkMvm+G9niZD2RMiXRUAMA0
         9rvHJvvPtQvTitiYcU70rN1Tvj0/ONM/bwFRFNlz6JUjDDSAQTL7Jpu8VYE0kiKjRUk/
         MZ9A==
X-Gm-Message-State: AAQBX9ffui6crnWygub6aY/5Vsi+Rsqq/lAc6+AHKo82gnZnnWoHAH/r
        PdWQ/8Fj7wk0sCkXEnICeXlu7C09rHQ9UtnMI8+96Q==
X-Google-Smtp-Source: AKy350Yuu6Fa1MlOy1T1DvZFfUvenEk/3KALkNavcBT/GgT+33VyzEt2ooMaE3XWN2s/CbjQ5hKHUw==
X-Received: by 2002:a17:90b:4f48:b0:22c:59c3:8694 with SMTP id pj8-20020a17090b4f4800b0022c59c38694mr19056501pjb.44.1680053626893;
        Tue, 28 Mar 2023 18:33:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902968600b001a194df5a58sm21755126plp.167.2023.03.28.18.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 18:33:46 -0700 (PDT)
Message-ID: <6423957a.170a0220.8bdf1.8701@mx.google.com>
Date:   Tue, 28 Mar 2023 18:33:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.3-rc4-55-g075e225e906f
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 4 warnings (v6.3-rc4-55-g075e225e906f)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 4 warnings (v6.3-rc4-55-g07=
5e225e906f)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc4-55-g075e225e906f/

Tree: pm
Branch: testing
Git Describe: v6.3-rc4-55-g075e225e906f
Git Commit: 075e225e906f6f4845d87b260ed61306770838fa
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

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
