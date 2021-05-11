Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD43637B2BC
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 01:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhEKXoe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 May 2021 19:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKXoe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 May 2021 19:44:34 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEE3C061574
        for <linux-pm@vger.kernel.org>; Tue, 11 May 2021 16:43:27 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b21so10129899pft.10
        for <linux-pm@vger.kernel.org>; Tue, 11 May 2021 16:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8cbWmhiEWpaqyzm/Kw94+CqKTR1Rag7aFlN1yqX25RE=;
        b=aU4ySMolwD0VTM7lPT7Vc5OL8oHfOkJ68Pl/I7hei7Z00YgsFsrF9SCuUjIsVvrI3j
         Mu8eIc6MqIKiw4m5lx6uV0HhF1tj+SDhdUBds8LfmMSE7uPaXmAy5JmapUEpm1Z3Tr/S
         Lt8AL9mwjNjC+P84OAfmJufbj+aI+7wXuZC/vJ4Kb0CnAZzWDkMUJlWXzwLlz+HP/ARL
         Idu4DNxxFVnl/pmzJxR5UfgeeFvVDVtMTOywFnPrEH8Uap2QOqbshgNFE8nUwLOXCgVS
         0q9EAgeOZ8t7zVE2b3ZOhFSuLY62O4ZHAqAJzJWETX3bLr2QwOzMiqfV0lNPtTV8EGlg
         efiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8cbWmhiEWpaqyzm/Kw94+CqKTR1Rag7aFlN1yqX25RE=;
        b=Tf5Is4QCnWazZWy2jTDZATqBABsAAgHlXsajgMUSxM3JEok/VUUYqBa7yIkg0ziM1Z
         NjJfo/OWG3dMn/DGNE1WCTYN6uTWa+ah4cA9dn7NwwyIv0Qr6Z3ClYL0JULsalnZGsUi
         IK83FiZaCkR4eWsEBCg25otBDT8Xvoa+Dh+6H+NePVrAkg/Pe3cdNZHYgzOjhetwuSUJ
         WjwIEzrWllU81P22yVSI8bY+aQAtVmcm+MNV+ggsHQ7c0wm1wxB/clwuoIfmh/IA3EQD
         F/ViDqM84L/gLAfrFpiqIaYYv/Vt1Hni4hRSmakNTHgo/mCP5SudFup6Rqge09lGwhcu
         AOtg==
X-Gm-Message-State: AOAM533EZLKH21tbQ3MLAcHJ5Q3KCuO/3sgk1C+/i70crhJc8x5w5SkK
        wh7mhKE5M4CuZnmN8yGbI62ogg==
X-Google-Smtp-Source: ABdhPJytLiPTvWCeFBHiJXvsFZjjoqzPelKQk/V4ujhHd1OIc23CnoRT1CwjTRKDIzAu9NvvBDYYyg==
X-Received: by 2002:a63:4b43:: with SMTP id k3mr32674494pgl.450.1620776606782;
        Tue, 11 May 2021 16:43:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id hi8sm14372243pjb.34.2021.05.11.16.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 16:43:26 -0700 (PDT)
Message-ID: <609b169e.1c69fb81.24919.ca7b@mx.google.com>
Date:   Tue, 11 May 2021 16:43:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.13-rc1-9-gcb7accda3e01f
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc1-9-gcb7accda3e01f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc1-9-gcb7accda3e01f)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc1-9-gcb7accda3e01f/

Tree: pm
Branch: testing
Git Describe: v5.13-rc1-9-gcb7accda3e01f
Git Commit: cb7accda3e01f71abfb7a987f8733e8c2d2d911d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

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
