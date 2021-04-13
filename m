Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A67E35E5D1
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 20:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347488AbhDMSDR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Apr 2021 14:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347407AbhDMSDQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Apr 2021 14:03:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DD1C061574
        for <linux-pm@vger.kernel.org>; Tue, 13 Apr 2021 11:02:56 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f29so12504704pgm.8
        for <linux-pm@vger.kernel.org>; Tue, 13 Apr 2021 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=UdblpVKjegAVzbExIUqcVo4svdHN8wbbh6L3g3bsZVQ=;
        b=qfAbBgsjRHAEgQzXJca5G27ILCW3rQY0chhW5tAAqPBuWrKdG1da826n63EUyBfEBA
         0zz666gr3TE5rLH34zvgf+zXEbIn3H5EA3QqY+bLqcy6XjZyBuM0d/rVj7Oepq617dRP
         MTKYu5UBTI93Ke96dyz4wsSVMcKjnHq2xu/4rbnhsjMgYVa1BlhCCpFo/LZcTbzVm0Fr
         tq6FXsagSWu+kYdO1KZDiBWvjkxxYeXXUMVnZ8QW+O5BBl5UdnGR4b6j6FzQRbAjfX0i
         RlaUKeDMuSaizUUdkianxfOuLI5aoaSAyFxzWZV6ZBuR8nFKp5Z16++rOjWReSbM2aIp
         bBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=UdblpVKjegAVzbExIUqcVo4svdHN8wbbh6L3g3bsZVQ=;
        b=k/CsI1ffhj3k5sYh4fdMn5ZIU22VAvw94513bN9LCB9sPfEli2u2TX58BMab/nVnPA
         FduLMvGIQn6IBA30SLTTAg5QN49YIFQH90X3McKQY4U0LImTobXpewaRjriyIYsUWfm2
         SSmp4XsjK9P/OCVZyZIHYycyRogE2jbAxb5NMoYraD2K0z6o5hA9Dyq9BqDbBx/m8Q2r
         3kftm6jvdQETPex03VzVrZA0c1fV3ABV6NdMwBEG8e4gOnVPc5MSh7LeFBm5dCWfgw21
         s/Erws1nEkPNcsDvD2zDPXQ6etojHZbtG4POBaVbBloRIfs6kL8jFFy2DhYCvHquZSN7
         KcoA==
X-Gm-Message-State: AOAM533VCm5Iohmv0VAcLTt5tW01TE+DUmVR94y1ythPPxNrS7MrEDim
        haxZQNFiiRRsOiacs/xUYTVmEg==
X-Google-Smtp-Source: ABdhPJwUVpCognS/KRSBigZ2IFgNc6xUzZ/a8K92EHBy2EwEOKcx+hVO41tB8XQlcakDZp5fKiNV5A==
X-Received: by 2002:aa7:9412:0:b029:247:baa2:d951 with SMTP id x18-20020aa794120000b0290247baa2d951mr20724809pfo.63.1618336976394;
        Tue, 13 Apr 2021 11:02:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d4sm2930143pjz.49.2021.04.13.11.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 11:02:56 -0700 (PDT)
Message-ID: <6075dcd0.1c69fb81.1fe57.818f@mx.google.com>
Date:   Tue, 13 Apr 2021 11:02:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.12-rc7-158-gf0ad2a845d869
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.12-rc7-158-gf0ad2a845d869)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.12-rc7-158-gf=
0ad2a845d869)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc7-158-gf0ad2a845d869/

Tree: pm
Branch: testing
Git Describe: v5.12-rc7-158-gf0ad2a845d869
Git Commit: f0ad2a845d869594a16bab7da43c361f0cccce59
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-8): 1 warning

riscv:

x86_64:


Warnings summary:

    1    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol =
check will be entirely skipped.

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
