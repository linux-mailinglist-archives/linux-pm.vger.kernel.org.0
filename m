Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A4C3E0DE2
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 07:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhHEFvK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 01:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhHEFvK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 01:51:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B44FC061765
        for <linux-pm@vger.kernel.org>; Wed,  4 Aug 2021 22:50:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mt6so6447288pjb.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Aug 2021 22:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=IhlFcEJ3Ey+FvnFqP6SL6I4PAijNOqIkFEL281s7fw0=;
        b=Ogdyws4BjzLySgfIuElgUG11L8psN2IYIvd4ztc0XbQk07QvxLnbYhKbkbmm9aK26d
         OWph2VTMTK1Nx0GqdfrjJT0L+VJPG6eHuj2e1IAb1wZXRpALS1+6PY8nuhhOzPHlZcOa
         PASlA5qbVPW7F5H1gsUhAkQ3aCt8xFGxRCZLzDEP9IbtN3SjA6f1KV+BPgrXN8sCTH37
         NRbHxvl2ODN96+MXy4lko6oYgvUB9JOTS7lMsajbU9qsjytv5n3CYjOC6leL4Ouo2GYQ
         YDmpWy3NMGtdo47B1GJOFrs+A/sEmFlKjrsV9Us5GLk8rMyt4POUV/VTte/o3e0XKcuI
         zybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=IhlFcEJ3Ey+FvnFqP6SL6I4PAijNOqIkFEL281s7fw0=;
        b=dEjHYGrtVWNojoQQkVBX6weosI1M35xaAlcEVc2K0YKnV9isIDiWD+NkLkBqqLb8fm
         IFq25IXyIZiRK2czUo6F0nNtv2FlGnlRs3S6qxvKdBh98rzPk2WRx1+t/aXmcePRfbUg
         LpsoKAh7H+ipao1RfP8QNWb8E1+PtQlqdX1Eq1DYeGyZFBz1BbuhyL5Mach/rk7m63t5
         Cedg+GCmKBP5RuyNgQUSDaCIfpKQ8nT96aQm3WvAD9E+p3/ka5KIBqr6lMqYYm0NCGv/
         X6Mz4JDXG4iEQKI8f9PY5Swq3wA4CWFTZsj+9vUSDy7BGJHHHSvJkjYDg/bgB+i1uKJq
         LXcA==
X-Gm-Message-State: AOAM5303cH7s1Iag3N+4BOJTWEW/fxNNjTU08wGVgHUOu9ieQmlMkucd
        dvmoXa5cYJQ3sNQt3DzKLcG7/Q==
X-Google-Smtp-Source: ABdhPJz205HNLFa9urpursH+0URCDNv7SWz9VIDSyoywyAkd4lA2zGV8r82u6DjSlVQHvPeIN/2P3g==
X-Received: by 2002:a05:6a00:1712:b029:327:75dd:c8da with SMTP id h18-20020a056a001712b029032775ddc8damr3145771pfc.34.1628142655171;
        Wed, 04 Aug 2021 22:50:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x2sm4484212pjq.35.2021.08.04.22.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 22:50:54 -0700 (PDT)
Message-ID: <610b7c3e.1c69fb81.a1939.e19d@mx.google.com>
Date:   Wed, 04 Aug 2021 22:50:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.14-rc4-18-g197da54f3a8e
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.14-rc4-18-g197da54f3a8e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.14-rc4-18-g197da54f3a8e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
14-rc4-18-g197da54f3a8e/

Tree: pm
Branch: testing
Git Describe: v5.14-rc4-18-g197da54f3a8e
Git Commit: 197da54f3a8ea155a1d3c5bf025cf6329a8dafc7
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
