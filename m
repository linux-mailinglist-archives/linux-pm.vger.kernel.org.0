Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40C331E11D
	for <lists+linux-pm@lfdr.de>; Wed, 17 Feb 2021 22:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhBQVQh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 16:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhBQVQe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 16:16:34 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8530BC061574
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 13:15:54 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q20so9248908pfu.8
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 13:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=f9OLwvLv4OsJRXQ9UN/tv3Isfx9VyPIZ5fd588hEO8Q=;
        b=MP7mJblA9y49qF6b1tQSNpwBRDJ1FtRf5mAXGVhBDwSKOrOdL4KnrQAuDB7DQFRaya
         LgNUVtRzdX1y2DRA29CrZU/Gvi4YMKYVY6ggl41H4mtiRNOesLyIgsku5KuWtha2evWu
         tKP4fwrE/A9foiY6HcJKx8cdctYw1qlb9Pwy7IZyySfg/X9QO2iJsu2nV4a/Ufgp/ZJ/
         0LCQmFM2lHo2409uFgDTpBZrZ6c6BRHWo9dmTPiUf9jDzUz6NirJn8/6+wdjaIb+Ahwf
         9I1PQBwmVWyIEl89q3qblYW8MMoStqrfhZyfdot24fMAA/Pya602BxONdZhPHKzdgIIt
         rLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=f9OLwvLv4OsJRXQ9UN/tv3Isfx9VyPIZ5fd588hEO8Q=;
        b=tO5+aYQDbvha2Ig2RdnWxeCC4RuuWgTOkBeAAF2u1uWb472T5/n6/TJYbATazlfsoA
         YV0eyb/R90GyBxm8bTegf9uzviYNGadcK79bLEGHYT+knRY7MpCqL1/m1KJRHx5jKoUs
         AQ+n9miDgo1vziB7Cv1Ewgk0VDqjBy290E8aE/iVofyA6np4xWoSMUyjTed1Kg7gLMCe
         6WLINQea/JzILZH3XXhN1w1iJ2lW80tER0LPhEvqeGWf590eJrQ/LbN6d4Uet0z2hGbE
         g3IYdZlErsJAhs/JZnBnk+pGXPV/PxaZUZ05ezLyPeE5xiPgjVrtch/pUFpDF99f2IyV
         3+WQ==
X-Gm-Message-State: AOAM532SJSoOVu377pEGSylOLh+ZydGnfW6Cawrzst65l+cmAxca4dk0
        ZQljnP7GlSbBLlNQVwMdUCm0mQ==
X-Google-Smtp-Source: ABdhPJzZo9rNmjIMiD+NskMHrj8hPNrnenLUgBVNLYa08ApvkbpzPdZfD6xdpaZrO9Jw532z+ej51w==
X-Received: by 2002:a63:e108:: with SMTP id z8mr1086971pgh.363.1613596554094;
        Wed, 17 Feb 2021 13:15:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w3sm3103665pjb.2.2021.02.17.13.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:15:53 -0800 (PST)
Message-ID: <602d8789.1c69fb81.e8ad9.7134@mx.google.com>
Date:   Wed, 17 Feb 2021 13:15:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.11-156-gc9756fcd3979
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.11-156-gc9756fcd3979)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.11-156-gc9756fcd3979)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
11-156-gc9756fcd3979/

Tree: pm
Branch: testing
Git Describe: v5.11-156-gc9756fcd3979
Git Commit: c9756fcd3979ee48382b8e442bb0375bfa05291f
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
