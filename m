Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33643314543
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 02:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBIBJJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 20:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhBIBJC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2021 20:09:02 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BD0C061786
        for <linux-pm@vger.kernel.org>; Mon,  8 Feb 2021 17:08:22 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g15so11398830pgu.9
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2021 17:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Kjar+SGvmPiiMRUKrlOlBSLAoZS9qmdK1bK/xBkl598=;
        b=RnEytroyoomfRi8nnlVyxni83cDkQcCHEkvKnmxOKi1VGxRHTPakErLrKg04fSssdS
         r20kiwlKBkSLywjmRYfVlo71kvn583/MlZMjEldx58sz0Dpz6kJh0GyckCM/HHyQ5sBu
         bBT9x+jVLcS8fAXhNNSN2tt0kJkldWfAMK7DtJlJKBmU4zlM1gbLYS6wSc9Sa+wtTO+u
         e+KYA/HuKaVc2xXI2h7teQ7GckPgwubMIkc6o+URPx2MaQfWwNAixBrRyD1LwMO0kNpe
         HfZsrSyGTFHcYeRZ2vbLlRZ0bK19+9azG7Ia0IZlNsYpkfB1rHNwqbxfLl0Mkl60k4J6
         B87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Kjar+SGvmPiiMRUKrlOlBSLAoZS9qmdK1bK/xBkl598=;
        b=styqHprHhvjltutfVNgQNKPh3/MMFmbE9Q/3awu/+/ZY5VAOX5uPytbx3PKTv1qZAM
         DQ5kVSE+GkWBSgTh+xiXUzJzoX9wAXzd3XFKcEn1K+Urkz4/DK0hti66n1kdVizbCebU
         6KgXn1EXSrBEv/pQ+bgAW3WUb8Jt5LmWoJpy/LIvRKGTtLgQemLEUPFLr+LkQ4RuoSJh
         CTbFLxdqUBKaUGRM/45cfDfXdCP67coAK/NMo3EaMZECvTtlAjt9HGpMgXAuiWhJcO4L
         G2M/IjFrZhmkclF/fSFpBi/i7mzDn0PfWclR3lxIOqbXhVdfXWn90zDiAV0Sqhz9L75h
         UuwA==
X-Gm-Message-State: AOAM530Lge306yhNqZpOptmh3hS01SOT/6T3eh6sLJieTWwPcCeV2/i4
        jOGPB5sN/8TphuGxgfraz/HEnw==
X-Google-Smtp-Source: ABdhPJzTb0eHF7cpph4nd2aMC/bu0w/46WvNUYs5YW0bLqGVHvtUMubkiAwBP/rxzWln7p47vd3C7w==
X-Received: by 2002:a63:4d59:: with SMTP id n25mr19227335pgl.122.1612832902147;
        Mon, 08 Feb 2021 17:08:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 21sm19182358pfh.56.2021.02.08.17.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 17:08:21 -0800 (PST)
Message-ID: <6021e085.1c69fb81.af63c.b93d@mx.google.com>
Date:   Mon, 08 Feb 2021 17:08:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.11-rc7-100-g4084a778320d
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.11-rc7-100-g4084a778320d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.11-rc7-100-g4084a778320d)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
11-rc7-100-g4084a778320d/

Tree: pm
Branch: testing
Git Describe: v5.11-rc7-100-g4084a778320d
Git Commit: 4084a778320da1b8455b8a1083a549247f901315
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
