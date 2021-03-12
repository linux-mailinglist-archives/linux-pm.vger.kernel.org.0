Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525D3339826
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 21:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhCLUX4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 15:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbhCLUXd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 15:23:33 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A332C061574
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 12:23:33 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so11618807pjb.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 12:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=039rlWsKonP66C2q95Q26c9Ry4EAnI2qExSC2AZggGQ=;
        b=f2QVQXsw1uFrurLMLl3UXwkKHb0bH6jd8laQ4Uo+QgQrxMoEWD3nmSoVJW80svro/z
         dWe6e6D1vwmzjU6FJjrp4wlxCVZWq0DgyI4kBNOdNguyjneYwFUIgAUPruIXgVheI35I
         KFQy15xfSy+udIx0X747gqi2nToxmyq11HB99D4nV9hLtbQvg8liL+Q4FRu+BhZ4sux/
         03z2+t5kMFjGYULAVJ8W0n9uDBzwZO62A91hPRSyX6tYiWp/xhDVE4srmYSMdHKag027
         6I9tjnH0BQLh6p2N0KsahFtM/2S+cIl/EaZ56Lrvvl0TiTsHDf9QryDBP73gy5MYRXBQ
         HnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=039rlWsKonP66C2q95Q26c9Ry4EAnI2qExSC2AZggGQ=;
        b=cLj3kcB9QXrpUlpAzRUu4BfTwh2yup9VH388HHi4FLdgmaTCCOEVjdc8f3m0olrKNw
         FhQVqErerYENbPC+AJTHl0kl+8bkPy33Sho/lZBs5mmLk0P6mkIQFMIuuZ4GxHHa0fd9
         6ibmRf9gxFb+4PV6hUmvS1bp2RRBTrUO/0OHKTa8QzEdBv8b5wkJu9Gup/sMYDpF+aW7
         HNA2JG/6ZuzL1BrdPnuY2zbPJVbhbqBl1xpiQ2rCKFt8SbobVp1xLRS/IQuMtw7aY5PI
         i0Sun+Vo5UCVp7Q66yHB6SsodfWKYp3uCTnI8xg1HRQf4XCv65MYlNtmeUH4xde1ZADo
         2zxA==
X-Gm-Message-State: AOAM532JKSyfqFwicYzwS+kobZphx3SaIept0TUfY8vHJ4Ye0q1Ovc91
        vu+O1wWxiiJYL8YcRh8L0sPuiQ==
X-Google-Smtp-Source: ABdhPJywo7mRvQK2FXJ+rSW4YGtnpU6VNwXE2rZ+4vwffbNEFtvxXBetSXV930tFUpxOVgtoj8m4DA==
X-Received: by 2002:a17:903:2286:b029:e6:6499:8c2d with SMTP id b6-20020a1709032286b02900e664998c2dmr241244plh.17.1615580612870;
        Fri, 12 Mar 2021 12:23:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r10sm6547078pfq.216.2021.03.12.12.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:23:32 -0800 (PST)
Message-ID: <604bcdc4.1c69fb81.10fb4.139c@mx.google.com>
Date:   Fri, 12 Mar 2021 12:23:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: devprop-5.12-rc3-29-g42326a293954f
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (devprop-5.12-rc3-29-g42326a293954f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (devprop-5.12-rc3-29-g42326a=
293954f)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/dev=
prop-5.12-rc3-29-g42326a293954f/

Tree: pm
Branch: testing
Git Describe: devprop-5.12-rc3-29-g42326a293954f
Git Commit: 42326a293954f11eadf31161b8315bf6dc2279da
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
