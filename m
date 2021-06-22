Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814883B0C6E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhFVSKO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 14:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbhFVSKK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 14:10:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3667C08ECB6
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 11:01:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so2204339pjn.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2rN6MuRoyB0TxuLmnbC0w9XVqN0uHIDRho+X69GH4yk=;
        b=LdhkbfJq8ZN8lClFvlLZ0SvNmYgwdK2ry+f+55bvxu9MTJ8VODtAlgGrouXNmWC5J9
         ye8PVbx2TkD143VYAmHsIj8dz/wPfghhvRTXVAs9OLNdIJYemi+witxC+z3atZlx726B
         87DH8WJZ1rtKqcq/nMJ0HRS5xtQWfAx+C1TNF4m4SExJyyIM+Yw41DpgGHITZ3D4l9qM
         0WYZhnygo/Eq0uKfrKgKGS+zUt8L77m7+hD/No0mbPszY9UKvcqNyKOguh9dsdMX+3ye
         LRS3MgLQIsXoMK6XvirCr5IOvuItOHGVdox1DVud/LLIDg4fdMO+MsxiO5e2uhIL9vFy
         03Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2rN6MuRoyB0TxuLmnbC0w9XVqN0uHIDRho+X69GH4yk=;
        b=f8LaUwvSmbuZFvZoMVsduGpqVor2ZOj9svUSvGaO0/eCVfq2XPDpo3ICDhiyTBUkkX
         s/1xu9D0rzXsjO8o2Sz48iNGXmp5Z6zNqiS+Ju8SbOd8IyvMhODLmTdqGrt3ijBP0SS5
         zM4AA/at9kBG0YYxszZL+pH05W9LVAmm/c9W/+GvpDYLWJC/mwmy9bWisSD1kt06xOe7
         GMoWkA2AUHP9KdjAkWBp0IjQcMABNkjSEe17c+svtNHml880VGPhYf6TI7RKjc9j6hZm
         HgcjPZuuexv15SmluEgxOAnUwHrB294waX3Cq/NyFj1iLXj6qPv5+tdYDqgS9n9exqY5
         gsPg==
X-Gm-Message-State: AOAM532UkyNjqjOpV2k746Jb93/8kvUjh8R9XH8rhMMiZZ0XcGCxDZvq
        Qx/R/wWV2DKDDs2KbPY0oO+8wg==
X-Google-Smtp-Source: ABdhPJxG+5ohxtXPffswgtsx+4YPpU2WXp1DEXK0CH/FomTMUnHbOu64LNngdWkCUi9c+FiEUBEKfw==
X-Received: by 2002:a17:90a:4216:: with SMTP id o22mr5187398pjg.3.1624384904460;
        Tue, 22 Jun 2021 11:01:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b6sm20322286pgw.67.2021.06.22.11.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 11:01:43 -0700 (PDT)
Message-ID: <60d22587.1c69fb81.ed169.7be0@mx.google.com>
Date:   Tue, 22 Jun 2021 11:01:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.13-rc7-150-ga51c80057a88
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc7-150-ga51c80057a88)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc7-150-ga51c80057a88)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc7-150-ga51c80057a88/

Tree: pm
Branch: testing
Git Describe: v5.13-rc7-150-ga51c80057a88
Git Commit: a51c80057a887e0f24bd8303b0791a130ff04121
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
