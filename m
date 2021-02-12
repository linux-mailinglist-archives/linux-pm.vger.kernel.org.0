Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1863231A2D4
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 17:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhBLQh1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 11:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhBLQfY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2021 11:35:24 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D073C061756
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2021 08:34:42 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id k13so6103779pfh.13
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2021 08:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=sFoFpN+oAKcKgkJHe+edL9iyi3lGF2o+rY37WquJbts=;
        b=09Xa2JHcrPVwgGlipXXDZfXDP3ht+r5F9VvUCA+PXdP+JGnryPX2lN3Uks4WdwXedn
         w8ghnD7J3UU5BOKb8096qkqLXmuVSZPQcZwPNPivEjZSzfXsLy7KnayaAxDAaH0OgSv+
         UcXSEtRKgB8RcY2u+WE2E6JIboGZfQGOhEGpR+HyZYlFJKydfKj70FC/U3np7FOYdOqB
         p5GR+oOCVeZMPLP3Js71k48ymIOanvMEBz5Us5yZo+bQg634HxAapyuaFWbAnRvpxKPY
         VnnveevG+872vNjOnkeqg4pc0cSLlrfStEii5WV7Lv8jRcvvQ0zUubct/aVfJGLNyUoH
         0ZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=sFoFpN+oAKcKgkJHe+edL9iyi3lGF2o+rY37WquJbts=;
        b=NuPJJApmYnnEqJ2k/c6bX7b/QiO9EHeIl1CCYFpH4I1uHbO6+lCk6sRBFSdwfEquHX
         WteBn5RqZbsMV7p/W22Op5hdCLq68TJOz89LXuBTUnhw/7ncIgghn9pB/SvtU26ySKH7
         tu4k8gMojJpsFTOUU+U0mYgdP5lif1rtMGbpvegZrjyFYomsQeQM7b4VboJ76rFDyYuB
         39seyKZSEVq59UJ+RB7X4OQkbDPvglAkK2qYdg/2dzLShGmQK17LhlFdwCVtwL5Dgm2Z
         wR9h1BrNBMcP1GhO/f3SVTuNhFTT0G+LXxWu4re7Ta3GVJXehuk7Yx3lEWIBvb/s9cIO
         Gn6Q==
X-Gm-Message-State: AOAM531SPDGW2VuBHppLFKI8BhT8gad/OmH6uNMnzw9o1UwtjxWQ/hWH
        hl4pCPh/h5L33ZPoBL15aODPAA==
X-Google-Smtp-Source: ABdhPJwibDQIi9VkFBwV9yXiOgtx2EkZyxiMbWhIiCyF/iCmXAY1jMqseAyceH7HA1Le7lmOPy668w==
X-Received: by 2002:a63:c1d:: with SMTP id b29mr3973313pgl.9.1613147679756;
        Fri, 12 Feb 2021 08:34:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i6sm10453492pfg.93.2021.02.12.08.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 08:34:39 -0800 (PST)
Message-ID: <6026ae1f.1c69fb81.d14ae.68e5@mx.google.com>
Date:   Fri, 12 Feb 2021 08:34:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: pm-5.11-rc8-133-g5352de4c92b3a
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (pm-5.11-rc8-133-g5352de4c92b3a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (pm-5.11-rc8-133-g5352de4c92=
b3a)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
5.11-rc8-133-g5352de4c92b3a/

Tree: pm
Branch: testing
Git Describe: pm-5.11-rc8-133-g5352de4c92b3a
Git Commit: 5352de4c92b3acb86d4756be6105203619809e07
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
