Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE47735A8B5
	for <lists+linux-pm@lfdr.de>; Sat, 10 Apr 2021 00:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhDIW2U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 18:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbhDIW2U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 18:28:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969C9C061762
        for <linux-pm@vger.kernel.org>; Fri,  9 Apr 2021 15:28:06 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so7117960pjb.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Apr 2021 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=hmZ9HSf1chGUEAbtEPPe3LvMOELrxTE0c6dAZSknpiQ=;
        b=YzAlaXzY7NK8/Jhs/QDsdGmEhsPrkJnS2A5S3kKRoLDdh84MyipyqBLtX8CWqVHBaG
         5fc+uhjPoDM6onc6qCr+6IdGLuyvglNQCKw5tDBhEkytyvdEJq8zPcNMf6DG3Aj6uBGX
         IhN+8YfpuluZhE65Aw2H4zpfN3BXx33gr01ZwdiGydEKD2ls/ivV1cDS7+Qi8DdTGbVo
         TUbXkiouzZEQ6r8RC/GVGj8HvpK81bMA0hy1moOK5Px+B8b4kjv46a7yDxq/6SqUivAr
         7znaK5dK2JhYhDRIvGWYvUQRLgxu1nDghyuT8o7zWzlSeOrW8RtjG22gryMgjzhfUKvO
         jV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=hmZ9HSf1chGUEAbtEPPe3LvMOELrxTE0c6dAZSknpiQ=;
        b=W6IYGmkrQU2MqleHX6ppuLV8YS40QEMxhfm3Z351eG3JRZfjC2dQZPlbun9OEXu1tJ
         s5lRECrtBzVMTcIB/k6uaEtAgnHUXYp35lh277s3JKS4dyRkc+0lqocW5RHSwOhFbeNB
         +r84QCPYvQTlXvEOBYuK4pfMRxBe+oQelfC5m4Xw5ki5m+gLTJELgwqVdxfIp/3Asbcy
         LTjGRADYWLHx5OXwDa7RYkOBaeZZOPth7+wy0xgQ4WvMqy3iyAom1KU6/12Y170Szc1A
         X0dFmpj1GcJrJ/aYcxc6D+7H2vDgz7eTKf9lZWE5/aOR3+T6fe9J4AW76iiYheolPX1L
         6nrA==
X-Gm-Message-State: AOAM530e90Y1UPyjWvltNINGrwxAlrpuz5s5DTr1o2PwSsjWy9bNnjHT
        0/ctguSxJBXywral+RqlNHw9ZA==
X-Google-Smtp-Source: ABdhPJxkS0cL5XZ2Pv6LFV0n51SuxKnc9UR5jK9CaoCvEGz0CZd7spOycJ3XOlbzi3droQx/RQ/Lcg==
X-Received: by 2002:a17:90a:74c6:: with SMTP id p6mr15791905pjl.218.1618007286049;
        Fri, 09 Apr 2021 15:28:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h8sm2796881pjp.37.2021.04.09.15.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 15:28:05 -0700 (PDT)
Message-ID: <6070d4f5.1c69fb81.edd68.72b5@mx.google.com>
Date:   Fri, 09 Apr 2021 15:28:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: acpi-5.12-rc7-125-g45f505d811b4
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (acpi-5.12-rc7-125-g45f505d811b4)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (acpi-5.12-rc7-12=
5-g45f505d811b4)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-5.12-rc7-125-g45f505d811b4/

Tree: pm
Branch: testing
Git Describe: acpi-5.12-rc7-125-g45f505d811b4
Git Commit: 45f505d811b4a64b2909019c0e0cba141114a007
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
