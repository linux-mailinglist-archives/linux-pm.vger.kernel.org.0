Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53A930631A
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 19:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhA0STK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 13:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhA0STK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 13:19:10 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1395AC061573
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 10:18:30 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id g15so1890304pjd.2
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 10:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Bwj01gKlHb+axgiSNe+6BbEjXmPX6Z52py8J/II9MKo=;
        b=kM3lJLx8YAhMnYTIeWP5SMs/JAwRV/kwTgkOhgpXugO+i/Lb6sGNoF5RjeeOgPEEr5
         1QfA0wqq6PSrxDRQqPnNsRtWGlps7BSvteeaOBFh7qrx6QVtA/bXsXrzDDsDzTdFW/ik
         Pgg8yjCiUKSDqfgSZtV5iUG3RXxnj5c0iuFuGxWnkicfR5oUs2dRNtBUY4cLdi3tuHRF
         silez0onwTJF8H2OpjA9VAjuAoh9OCp0SbMAgtyo9Emzz8vLKRV/CqiTEULUcRCioszb
         Nhxt6hv7sSPLMzs/VJU4BP7LT7mTUvSnVnHYk3FjkLG2NhZab71DIg/PAYrXCyx92F+W
         JyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Bwj01gKlHb+axgiSNe+6BbEjXmPX6Z52py8J/II9MKo=;
        b=cTFC780MA2k+wiGVUYlQH5sAQiaMkq+Sm1DT2Kv4MEWE2eEqp42se4yxgC7Mj88/Ax
         8jyH70d+htD345tMvZK09ZXILgBq+xfFP6bHjKxxdmnG6f386o8vCQIqkzZIJh5k2T3M
         eLq6ih9YStc2esi/BWIveWmU+el9QZOJoqfljRL8cjb+rVFtR95HlD7qwRPbZZ6wlBzu
         ZyvJBlBLvyX1VK3FTDy4wm2HctF4JcDU6k/4dynql5Q1DkNOdetwfdeQnNA5YggD55Qq
         BghGWYhNcsMUnAW68HFgz7IS5Jb1HS7sunT7p8Ro2NWRdvQ40M5YWLi0GObhhl+0OM1L
         QVHw==
X-Gm-Message-State: AOAM530nV7vTzDm9e7ykge3xGSJ6MNATz5KRsHIm2n+MFfTCd1SbPRg+
        pCtVV9kCktY8Vf+GQFao25OQbGjzeKyVBXEh
X-Google-Smtp-Source: ABdhPJx14bTWHquYwAUR8CP1IUCdoW/fmamx61WqqLOgt3v06hcwCkF/JdUtJkSA92WO7oc85nrR9Q==
X-Received: by 2002:a17:903:248f:b029:de:c703:9839 with SMTP id p15-20020a170903248fb02900dec7039839mr12540236plw.42.1611771509706;
        Wed, 27 Jan 2021 10:18:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 5sm2740823pjz.23.2021.01.27.10.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 10:18:28 -0800 (PST)
Message-ID: <6011ae74.1c69fb81.f2789.60b7@mx.google.com>
Date:   Wed, 27 Jan 2021 10:18:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.11-rc5-62-g93c3d4245f20
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.11-rc5-62-g93c3d4245f20)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.11-rc5-62-g93c3d4245f20)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
11-rc5-62-g93c3d4245f20/

Tree: pm
Branch: testing
Git Describe: v5.11-rc5-62-g93c3d4245f20
Git Commit: 93c3d4245f208b925982f9e9bef346f47dff0157
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
