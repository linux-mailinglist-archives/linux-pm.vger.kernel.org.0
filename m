Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F03355617
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbhDFOHp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Apr 2021 10:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbhDFOHn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Apr 2021 10:07:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0446C06175F
        for <linux-pm@vger.kernel.org>; Tue,  6 Apr 2021 07:07:32 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso7724904pjb.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Apr 2021 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=KobbtfTSJGsK237DCMNwdq9rBJHig6rHOMPLeKe80Xs=;
        b=Ly/rEl0yiLduVcxk7jVQYJz0rMGuvYOv8D14UCS7Z6IezEwSVZNrYATeVKJORYUNfd
         sUFhATn1B63/0Ex0Z4RIT2vqPDSNa47e7h+6p5NrmFUsllCl7R7A1Mnz23vQpqgek0sn
         pnHURBdrAESvrgJU210D/sTDMm2DZV5Q3B0ei5S31ieI8yMv2lBFj2kzHInsCtSxteWz
         w171ymsRd0nMgN/8YDkd/wiYSNzMAKZN67024bDxbtZboFBuj7rTFFCIksSdAhJBkKmy
         2oo7hu7VkxRMo8H0K/0ROKlt8uPjc7gcAwLC/Wg3/e2LKBsQLvl8Nh9Q9pLHU2oLnRkq
         RDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=KobbtfTSJGsK237DCMNwdq9rBJHig6rHOMPLeKe80Xs=;
        b=CujbdXGhHAn2uHwXzmKuJu8r4BsOMwtlbtxlgqFKgKAWWqB0Oxv2dpdLEBZ91LuqqC
         eq+J8Y9Wv0oo/Y/p3aZ9H+zEoEjrlR3YOhBHD+C+nlgxSfzAppvn6tkc5B598HRA5ZFv
         1zxLF9vUmoEAPox9irRdl6gRepyzxruIhf75CWpOILLWHegAgHG3pfxkiwNcC6zAxE+b
         DpPTVh4Ubh1PTgrMj6SUYO2O85xelPxV+juo2ilA0VfQb6MPHuI4n6QEkDWhNm/B4Q50
         K/TJI+X0jJeJkczYFvVZKViCBrZo/m4LnAr0QCx+dC+0UXquuX/LrhUadq5aq01nAkSp
         dQSw==
X-Gm-Message-State: AOAM533AjuKPUwDLvnD4/cJAS8q8mIWEA4J5v+nO/5nZxi2cNU6C3fef
        Cc/K/eTZsxzDSsLvb6rTyxpOEng3ZudPErGm
X-Google-Smtp-Source: ABdhPJxP6Hb4LZKGYoDvEdiLY9xYDBXcMzdsAP8FTYD2okf8yrHTBY7wn+pBkMyp+nUjymW4KSud6w==
X-Received: by 2002:a17:90b:33c7:: with SMTP id lk7mr4591671pjb.95.1617718052381;
        Tue, 06 Apr 2021 07:07:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g3sm18489816pfi.31.2021.04.06.07.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:07:31 -0700 (PDT)
Message-ID: <606c6b23.1c69fb81.dd017.eaf0@mx.google.com>
Date:   Tue, 06 Apr 2021 07:07:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.12-rc6-37-gcf66fa75745a0
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.12-rc6-37-gcf66fa75745a0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.12-rc6-37-gcf=
66fa75745a0)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc6-37-gcf66fa75745a0/

Tree: pm
Branch: testing
Git Describe: v5.12-rc6-37-gcf66fa75745a0
Git Commit: cf66fa75745a0b1237bc54340c8148170dc63edc
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-8): 1 warning

riscv:

x86_64:


Warnings summary:

    1    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol =
check will be entirely skipped.

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
