Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F177D34DC59
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 01:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhC2XWK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 19:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhC2XVs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 19:21:48 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A08BC061762
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 16:21:48 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v3so10424247pgq.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=BSzzBy4VMbomTajkUvvV9qrdMc5GHrfz58tS9yORfkA=;
        b=l7eTh2eKinWcLJzDy58kf9eeXysZuo05atcM+cnXCRYlVKJ7frpl3sdavQRaG8yk9G
         lyGvfODjKSjf+lk57pnNibmwa9DWSbhkZvwe9PXo2xY8eyS+XKtTkWg2tNL24Up+zy0N
         dFUH0YfA82+ASYpJnhbZrOrLVrNuaUvpR7wE4XTzFzU2gJFyMceNDpgd/kZb/twcmf47
         ByK7pIAs/70YhgSSN/tE8E3eAOyiGYzinaN+rVn/0NXPHn8CLoMlyAq5lCKPk5pZDY6m
         LrrsL4JH8euIzc2T1OQS27zWYnN05jFX8f3+WoXiPurzYG8HW+ZdZFj1iWs8Qr99K/RZ
         Nfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=BSzzBy4VMbomTajkUvvV9qrdMc5GHrfz58tS9yORfkA=;
        b=Yw+o04+X6RZDyOjCOwK+ni3Hz2Jxv2EL1w8kYO/M/mMCFDoR5NlNP++7Yh9DxId4iX
         BBatA+OJiHr4Wcve3FVtnfEUuhqG4wiVk739hMLXm6ooHDd4iv7akyMyecEYO/JBwJPT
         UZGthGeVfgj2h1fNx9t7Rcuc+8mZkgw26LVi9iBeWYu1nFuXS8A/rI1UR8UtvOfc041U
         sSn8oTVXDudZ1dj6PSZw0ArmAsihgsaqcS8lVo5fDR/dhpLkOl9ulPCzhmnPpNtnnPqh
         V87rLYk2tt4DXgCuJf/3Qi2VFntZHvRPVGljdozvOqaHZNRYa8RV/FSC4FRgRlZ8Dari
         jS0A==
X-Gm-Message-State: AOAM530V+mrwxAG8WkBQiJ+HeuubxJDJOzB+6qIPqsu784URPibOiPaA
        tx9CCvrPmpcM+zreRsGcO9blEg==
X-Google-Smtp-Source: ABdhPJw/QTfRKREjHqNLFDUUjUnHlnjkjwnBU00cyRdYkG7nEXl05gDU8s6Xp38ktmpwVg2lwWz5lg==
X-Received: by 2002:a62:3642:0:b029:225:a79b:da18 with SMTP id d63-20020a6236420000b0290225a79bda18mr13307534pfa.75.1617060108045;
        Mon, 29 Mar 2021 16:21:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 81sm18462046pfu.164.2021.03.29.16.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 16:21:47 -0700 (PDT)
Message-ID: <6062610b.1c69fb81.d4181.d192@mx.google.com>
Date:   Mon, 29 Mar 2021 16:21:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.12-rc5-44-g1d535f1c735a0
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.12-rc5-44-g1d535f1c735a0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.12-rc5-44-g1d=
535f1c735a0)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc5-44-g1d535f1c735a0/

Tree: pm
Branch: testing
Git Describe: v5.12-rc5-44-g1d535f1c735a0
Git Commit: 1d535f1c735a0cbe50c8446d81760a1d07605610
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
