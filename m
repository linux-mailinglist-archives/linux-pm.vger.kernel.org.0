Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4A3316876
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 14:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhBJN4Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 08:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhBJN4P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2021 08:56:15 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E0CC061574
        for <linux-pm@vger.kernel.org>; Wed, 10 Feb 2021 05:55:34 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e12so1245349pls.4
        for <linux-pm@vger.kernel.org>; Wed, 10 Feb 2021 05:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=mvDYLQKXAKZjPXAmP0sT16GTph47fienrWRIWtZn0cI=;
        b=zXLrY54vUiXQzb4/wuzdsRxI5VG6A2XPdbo3B40m2DE1wXRpkCQrcWVHYVVlVGWkbO
         9syhrkbKIgwtWuYfqGNU9eLwXBu5FVQ8BpCN5cZ7JsmZedKfpt8l9IrPPyq7v16MyL+s
         qq9bGkix7FgVGILysWX3sjCOLp/qv+mQBPnBzchqWaDwsYg4/izSRsaGdzlsLFEAtMZw
         Nbw7yqYsNDaKe7XIap0MiDnYA6C3rgZGOHjlhhStvrcukudubPf11SSFxKTNdSIkDqPD
         WV5ZBZ5FHdSD4OEqBKqqUL4dBQzGCKsC5x0lyY15A/nP3e1EkYnmzNX6U1kbCODy+b0w
         GppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=mvDYLQKXAKZjPXAmP0sT16GTph47fienrWRIWtZn0cI=;
        b=nKjX1wyUvnyVJ6rswIdZ7wbUXTy3xCnpAQVsOQfUARIyuqnaGhqHKRcq9tYrCS9eOU
         7UhUeP+LECssIhCHSBIZi/B3+gd03WO/aJ0uS/DPZeNOO+w/81mVnzV00Q2W9vQ4vHDF
         RSTdNdmhXD6ZuOcq6yGILLU/YCSZ1wG9uZz3xct0k/9o0IuHUJEgOoz9U8UICtu6P2ws
         1Db4NCXJnbqMv3eENnkoAwXch3VEvhCDQpOvOpyXYfvjODlniqmvj/MK/uvKsUqi1ASd
         Z5qvaVUbkSBRG++TAiXHOMq/1iLcZVEXTqSBx3E9bIlm2cCdiJ/7pbNAfII2/GtpxBhX
         7+8w==
X-Gm-Message-State: AOAM5328p56/wzBGcfBym0qZOdvWFe/SxJ3QFilJM6nT5HDFpkx20GIE
        0kDJS3pQ5ahGwT1X5ceL4yYULQ==
X-Google-Smtp-Source: ABdhPJy5p5Eh68d+bE7Lpn93JPGSQiFCEM6qgDc8X75zAWqukLge5eLmsGKkm7byxXRFpTcHk+0TNg==
X-Received: by 2002:a17:90a:6d96:: with SMTP id a22mr3294524pjk.84.1612965333977;
        Wed, 10 Feb 2021 05:55:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y20sm2579052pfo.210.2021.02.10.05.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 05:55:33 -0800 (PST)
Message-ID: <6023e5d5.1c69fb81.4d76.523c@mx.google.com>
Date:   Wed, 10 Feb 2021 05:55:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.11-rc7-105-g32890f947002
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.11-rc7-105-g32890f947002)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.11-rc7-105-g32890f947002)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
11-rc7-105-g32890f947002/

Tree: pm
Branch: testing
Git Describe: v5.11-rc7-105-g32890f947002
Git Commit: 32890f947002ed83bfa76ad73fae15393292a21a
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
