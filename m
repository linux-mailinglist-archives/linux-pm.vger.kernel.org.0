Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4BA345501
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 02:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhCWB3S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 21:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhCWB3F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 21:29:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762C8C061574
        for <linux-pm@vger.kernel.org>; Mon, 22 Mar 2021 18:29:05 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f10so3016204pgl.9
        for <linux-pm@vger.kernel.org>; Mon, 22 Mar 2021 18:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=AhTfzSBxQjBBvs+iC1V0yeRtlM8h96+GbKw4uTi17XY=;
        b=LJ5vm8ZC3yibIf6reoyG0nK4Xttnw4KQraPh0kjc9fSrVXBvF++I6bqL/GgVONMH0r
         uKYVfflwowcymHfHiLRmnRml/Lu5NEBEwg4L9H4/89micsAe+murTwfYwGGGBQfXzIdP
         3/g6x4ICNHJRbz7RnR29kbpUZEsOC4j3zr3p7LuDu8SBdvY735UbrzUXEYPUxr2bn585
         VvNkd+6OJ0Zor+VvS0aNP894GhL1454RcvRFSIOX0JsML4V9nyoWvSEIxog6WVjMf6zk
         VOZH4AV6hWTzhfI8kp2J7/UIQoZobQOFfh2CsRMqqz2Vlfqj9fDRyUGPBKfBbEhHiKKj
         2pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=AhTfzSBxQjBBvs+iC1V0yeRtlM8h96+GbKw4uTi17XY=;
        b=pYVwoTitdXXDBPPSt9DlAVGdslxTh2tPluFZy+Va65G7V3HbDnTi2hnKSGzChvoGDW
         bBSX6Gn4fWZumvLyB7KLmS0yETr23N+JEzbVnp+zRGna7yPT8F3SX388ziZJF3UYCRkk
         DJMw/6+xLXPFoWicBqoM2xWKOKMOMYJ/aBhVkCUgN2SgtH7jAv5s/XfaVzjq7IePP9LU
         ODbd5zvtMb/0pYl/fPPWnHgiJiDqTsh5wsCQnODBIIypxGyJM/86cPBlO2GGGY6i1fue
         gnfQ/lWCYKhLfOrGz3OqHoMvegv3RwpVNfX1hBoEodv4sUMb+zOGuUF18jw4xy5CDMij
         nCXg==
X-Gm-Message-State: AOAM531e6vjme55k5RDSBS4c1GB/yvPsGfjyTZYfaS3oBPgOiT8H6gks
        tRz2ZxLKuxs9Q8b77AO57fGRFw==
X-Google-Smtp-Source: ABdhPJxqk5AyiXgMYMzmDY3lz55RihGmXVfHZPWMMbods7J/J0ySOUO0zxyRrX5Kp3qO9r7a65QvkQ==
X-Received: by 2002:a05:6a00:72b:b029:218:6603:a6a9 with SMTP id 11-20020a056a00072bb02902186603a6a9mr2349783pfm.78.1616462945051;
        Mon, 22 Mar 2021 18:29:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id il6sm546982pjb.56.2021.03.22.18.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 18:29:04 -0700 (PDT)
Message-ID: <60594460.1c69fb81.b4b7c.27ae@mx.google.com>
Date:   Mon, 22 Mar 2021 18:29:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc4-38-g0fc4b6feae23
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.12-rc4-38-g0fc4b6feae23)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.12-rc4-38-g0f=
c4b6feae23)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc4-38-g0fc4b6feae23/

Tree: pm
Branch: testing
Git Describe: v5.12-rc4-38-g0fc4b6feae23
Git Commit: 0fc4b6feae239ecf9e355838c15521f9896dda22
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
