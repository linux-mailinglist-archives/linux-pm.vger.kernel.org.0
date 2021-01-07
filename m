Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667C72EE8E5
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 23:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbhAGWjk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 17:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbhAGWjj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 17:39:39 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EA5C0612F5
        for <linux-pm@vger.kernel.org>; Thu,  7 Jan 2021 14:38:59 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e2so4589157plt.12
        for <linux-pm@vger.kernel.org>; Thu, 07 Jan 2021 14:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=u+y0YpCllpuunqF7vxTnkrOGoKsmqVeWvKaVyGv8oO4=;
        b=cwkx0bQl/kf9L/pegCIC9l8gn0V8sLNKc7eUdScdl5qvF6kXN0W3xIdrUrJwB8Gjrl
         XUYmT89EASz+23tHn74acXcAxbDIX3k3xWE7wzQ7RiVFmjdmeVSTVUQBbUFNJeUJy4B8
         tH76afFbNirLYlRWgyWNR5Ds+j2vvdIjjQsfyDmSaCwlRoCkDDsgMSnPUbohHUGpaDVv
         iEr0HOsEEYHFSpSWk19yaVl7Qa7pNU7Wib+Ev8hVpv840zWeUrvTG5gBMtrON5rr+t7c
         bfHx9TDXgujrl///QC46PUGUnpzja3W/2d4q643qiLKYP3lryLuyX853pmVO+CipFCaP
         OJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=u+y0YpCllpuunqF7vxTnkrOGoKsmqVeWvKaVyGv8oO4=;
        b=tUKs3kfBcxePRPb1vA3ZV5+nD42tq8j3COsE2bAiWYVmLJY5AyPwLJL88U4L9Gh7h+
         OFvbz0rLmbs9i9q57Kg3YZiqxgzTv3OnTbsOnfR5WjTI8K9cDQiAUntKEBZvTs+su1BB
         xsZu0+p4r1jOQJfXxaA/gRgoGgvZKPrHeZNfBv4ILZJKlF2FPw3QfOm7YHObnCsuu+VF
         CCdgXE+OIW9PL/Bp8/tHxVTRnhq2WmnP/2bUffp8UJIBkPhRK6frZI307KJbJp144ppX
         Ds/av8mMzO/TPhQW8eSF/dscaT4xIGUN+SnPBiJEGyISax2/M9EijP4fVdMwlqULb62M
         RaDA==
X-Gm-Message-State: AOAM531+mk5CHyC9AHxb8rZXPj9mM7X4hdvKHERh7Uhvt0EwcONbwUSa
        QmsEA2R0KlUsYo+8QDewedOrIjH/l3ug8w==
X-Google-Smtp-Source: ABdhPJwQ6AXZJLAEWPVL0LKbM6qydW+z4Dfjj95AiMpnxCJeFMRPdpPgi+RhUOY3ssvBSYt3pT5bKA==
X-Received: by 2002:a17:902:c155:b029:da:9460:99a0 with SMTP id 21-20020a170902c155b02900da946099a0mr964817plj.20.1610059139060;
        Thu, 07 Jan 2021 14:38:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p21sm6649356pfn.15.2021.01.07.14.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 14:38:58 -0800 (PST)
Message-ID: <5ff78d82.1c69fb81.683ca.0213@mx.google.com>
Date:   Thu, 07 Jan 2021 14:38:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.11-rc2-21-g75a052c6b1ba
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 2 warnings (v5.11-rc2-21-g75a052c6b1ba)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 2 warnings (v5.11-rc2-21-g7=
5a052c6b1ba)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
11-rc2-21-g75a052c6b1ba/

Tree: pm
Branch: testing
Git Describe: v5.11-rc2-21-g75a052c6b1ba
Git Commit: 75a052c6b1ba2bb2cb1a09af90576af93d4f95a7
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-8): 1 warning

arm:
    multi_v7_defconfig (gcc-8): 1 warning

i386:

mips:

riscv:

x86_64:


Warnings summary:

    1    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused v=
ariable =E2=80=98wake=E2=80=99 [-Wunused-variable]
    1    arch/arm64/kernel/smp.c:810:16: warning: unused variable =E2=80=98=
irq=E2=80=99 [-Wunused-variable]

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
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mis=
matches

Warnings:
    arch/arm64/kernel/smp.c:810:16: warning: unused variable =E2=80=98irq=
=E2=80=99 [-Wunused-variable]

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
