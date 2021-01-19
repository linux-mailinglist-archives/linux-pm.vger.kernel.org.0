Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED762FC274
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391317AbhASRs2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 12:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732203AbhASPGb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 10:06:31 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A991C061573
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 07:04:34 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id r4so10643923pls.11
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 07:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=obLBRjopawFQS1P0rqiT1SLY+yVd5BfnpOSpsiCeQOg=;
        b=P2ovxFuQDjm6i1Kc1LZl71Kh1iEyhh65t8/0MCrbGJjM+rEM3R970ra2v1YbJn7FUa
         1O6/9sso/ZaiDcjnBEplmpI02ExkVe3tuqK45OK+RHBtsi+h8atAkUShz7ctunjpY5wh
         f53aMEw9XjpuVXYy3t998cx+jMbNy3O1f/+hoZPkdhP7lNa6k4yKiJxeyhswP6eIBLrP
         4MalxEix3AtW9p4qTm+jvGfx6TjTTvXOm8l3gI0dcKCgawja98u1XWtdgM30T9m/cV2n
         Y1weFt0sw8roZRCwOil7kwjZLKGiQT9b74Uy9QDoH0NyaTxqAFK2pA0Ad7LNzwe8/5Si
         sHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=obLBRjopawFQS1P0rqiT1SLY+yVd5BfnpOSpsiCeQOg=;
        b=KnVxSgn8WJH9KRzowJDHW4nH/n6XoK9cPNXoBETeeMOjV8NCptmM2VB7q+tV4ZdOkm
         y9HsFGKKEfF/S1rdHOmrSHFxokE6E91XwZ/yIhiD90vtOCtoAu1hpi6kJT/v57Ak7HPb
         0pJHF/el9N0gdi8NK6+UqyOlYc0zyeyJqN5L9f0RqA9bZeSm5rKeRZMT9i0AolNxgojE
         3VymVwbACrEoAo5IbQG6O2+q7Upnkn8rfxtK0e7Fpc/hXXY2l7dQLRT2jKRbAAvJbfpT
         ISdzJ39Y7kG7wiOktwdEhpkABQ1VFBduTM4U1x9nGR8/thZiyurH2IPGxDALsy4s12eS
         ewQA==
X-Gm-Message-State: AOAM531qJTwfcBkzCIQhDWq0c+zq90UMLQPZC22+dcVNCV8b7iWoZqvZ
        +j0d7QXOVJqtfrfFE/6PsqaS64nHu3N++Q==
X-Google-Smtp-Source: ABdhPJz5Apet0aiImh5hOn4lqyBPRePY7QfHi7TDCE3PbT+pPnVLJZNesa11IUEdD0uyPn+I8MA7Gg==
X-Received: by 2002:a17:902:6903:b029:da:f458:798c with SMTP id j3-20020a1709026903b02900daf458798cmr5154506plk.68.1611068674086;
        Tue, 19 Jan 2021 07:04:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e63sm10328723pfe.216.2021.01.19.07.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 07:04:33 -0800 (PST)
Message-ID: <6006f501.1c69fb81.1f180.756a@mx.google.com>
Date:   Tue, 19 Jan 2021 07:04:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.11-rc4-16-g192963bcaa64
Subject: pm/testing build: 6 builds: 0 failed, 6 passed,
 1 warning (v5.11-rc4-16-g192963bcaa64)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed, 1 warning (v5.11-rc4-16-g19=
2963bcaa64)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
11-rc4-16-g192963bcaa64/

Tree: pm
Branch: testing
Git Describe: v5.11-rc4-16-g192963bcaa64
Git Commit: 192963bcaa64826582bed29644e2a54b81c0fb9a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm:
    multi_v7_defconfig (gcc-8): 1 warning

i386:

mips:

riscv:

x86_64:


Warnings summary:

    1    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused v=
ariable =E2=80=98wake=E2=80=99 [-Wunused-variable]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused variab=
le =E2=80=98wake=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
