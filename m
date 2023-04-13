Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925D66E14DE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 21:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDMTKX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 15:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjDMTKW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 15:10:22 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C067D81
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 12:10:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id w11so16658085pjh.5
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681413021; x=1684005021;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oAvXQVhJg0TrCI/ueRE8GVeOdxEmIW6eLICGYrV8qmw=;
        b=tMb34b3p8nS0PAQ8ikhEKqy9QPTlXrpXmKgTrsiAhRgYPvizWWWIy9/2kulVssyjeQ
         dnX9PNDB7ByJSBGnELGDJ7gy0xUrpIgdhUK94hqTIpk0BTiLnECoQddz/FigwGazldMe
         lyG0tSkmc0IYgxqc4m7gSo1t2smZ8ckLXMoZ8+un7jTtraoGJ6EjMRoXjcfXyFkJ3fb3
         mw6AAZhf8tGFNPIHzI4CgDmCTRuqIdOpRgMCuCWtvBHGgwI0qjVQy1M0q2eQ+L3AuhbU
         mR2CuZZkffLdXQj985qGifnZSx43sFRz+YrOYeHCB4S4Lc+Z6wcUXyTIFY0cnHkvWp2z
         9aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681413021; x=1684005021;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAvXQVhJg0TrCI/ueRE8GVeOdxEmIW6eLICGYrV8qmw=;
        b=Cl121eR98Q+Jk6NChqU11Af1zcdCF+DKzlodnoTO59LZ7wliHcQarGF1DCOWiNc6m/
         w36iNOoy2exyMcAluGkU7ZKTrPWTBWuyrX8+sM56KszdE40wcuLnvV4XFC8W8COdJZin
         JmPAXRXcDJ/QMX63OWua6HokusYPLDdf9RnQ9P+vCXIkMDlHDPYrEcrcmJ4Ceu7LNtDi
         eInKGc0uFsQvREfSkm+1LpBxJFPu8uaYD4SOXKxwCC2f9L0X7niBcJT5q45SLPx0Mw95
         /5t3rCOlTANarE0a0QEjyh5nsCw38uLkZrGuzol45wv8aFJorXENtB/fFaO2O7XsWtEC
         W3CQ==
X-Gm-Message-State: AAQBX9ff0M6NZZAc83BDY/aRX+PUVs9F8vqdbKOuytJDO/CdyUgiv151
        pi4RdzLVKoPF+j3c5tA2uudhZaOU3xXMgJUfjcr3rCRx
X-Google-Smtp-Source: AKy350atoGPyg5Y2rEbJjgMCVB9rWGe+XrwKByPd5M51iIGvXyWDl6iZcRq9siUSn7tbrAyohPdaWA==
X-Received: by 2002:a17:902:fb46:b0:1a0:50bd:31bf with SMTP id lf6-20020a170902fb4600b001a050bd31bfmr39504plb.32.1681413021227;
        Thu, 13 Apr 2023 12:10:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jm10-20020a17090304ca00b001a55c2a42f6sm1812657plb.158.2023.04.13.12.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 12:10:20 -0700 (PDT)
Message-ID: <6438539c.170a0220.91c0e.4056@mx.google.com>
Date:   Thu, 13 Apr 2023 12:10:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc6-135-g5235219c59f8
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc6-135-g5235219c59f8)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc6-135-g5=
235219c59f8)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc6-135-g5235219c59f8/

Tree: pm
Branch: testing
Git Describe: v6.3-rc6-135-g5235219c59f8
Git Commit: 5235219c59f891671ed4d433bad3e0f493da644a
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
