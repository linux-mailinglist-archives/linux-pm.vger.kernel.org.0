Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760F43241D9
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 17:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhBXQNx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 11:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbhBXP6c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 10:58:32 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C8C0617A7
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 07:57:49 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id t29so1571760pfg.11
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 07:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=15ZOGAlgdlu1iznSFBklyGx9FBGftrnsu67V/CrxzRo=;
        b=pU1UXocFH+LHn9frZrt4C1FWU+F9GLCxYqF7dWWJmNJJzIiGXWH8bBOnl8W6AjPzDq
         OVep0HDktRbV2EPJ1CwD6qmKGoboF7Xp//Z2H4fmrmLfz9FyuzEUIiesbmTyyq+Cms3n
         eif2wgZNYU2tO0m2Xu5P6xaDoj5DB/tKkRXZfQZeeggxujjN67gInbZfOo46qCc3aoFO
         wXF7PDlZq7H7Yg1HQVHrmIO9+3w/lVv4wrB8sDoKjQjuD7VNo1z1f6kSv1XHMzonCINm
         /QS6VfHTZzxEpJvnySL+7SXmXiNc28z67LD427yoxQCDp8pTxsLsMWb9KDPAKzykhIld
         RyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=15ZOGAlgdlu1iznSFBklyGx9FBGftrnsu67V/CrxzRo=;
        b=A09BXa//R1yWaOm7BDgYrA+AD3mYyLCg3WvfVhefNcyVrILCNhQaLEIy0f6CUQiVp7
         vLK/3F/HIdCU7L5UstEAgvYf86qckBUMJh0J098I10S2VO94GKc58l0qKUTYfTCDbf+/
         HGXLzA9EDenQH5PveNe9JdXgtWMaF2mP7zyrexovIHzpdf0NJhgBMfv4TVVOcukrVA1a
         uVthx0WYaICs28/3W/amT/1SM+aAmhcDtpgFMYvsWudexlAj+zXYw09FoICwpgFdDMnJ
         mNC5FaVqFIA6f4QDHmutTeXUaJ48DQhZIHMXz2qXjknyjXnqnJjIvarWKadjpOIWnnfM
         Hn+Q==
X-Gm-Message-State: AOAM531pMS9uiMXZyBjFn4AiCo09EZ7DD9skIxL7ZIm9NE0c+32IYMIA
        Tc9apgLh+VL3gCvLtoutb4x5z3nQrtFrtw==
X-Google-Smtp-Source: ABdhPJwM1FpZfmC5/2SPglZ1ah5pjXgjf1DJ+T9o9kooxi3aw08qKK3aECG5BUTVgL1OPoYVWWab/g==
X-Received: by 2002:a63:4956:: with SMTP id y22mr29947779pgk.309.1614182269195;
        Wed, 24 Feb 2021 07:57:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v185sm3254322pfb.125.2021.02.24.07.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 07:57:48 -0800 (PST)
Message-ID: <6036777c.1c69fb81.3a6d8.6c86@mx.google.com>
Date:   Wed, 24 Feb 2021 07:57:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.11-168-gd10b8fa0d6dfd
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.11-168-gd10b8fa0d6dfd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.11-168-gd10b8fa0d6dfd)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
11-168-gd10b8fa0d6dfd/

Tree: pm
Branch: testing
Git Describe: v5.11-168-gd10b8fa0d6dfd
Git Commit: d10b8fa0d6dfd06fb9afd44b0ceea8e904fc95bf
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
