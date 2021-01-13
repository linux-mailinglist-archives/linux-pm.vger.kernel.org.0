Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714DF2F41D5
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 03:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbhAMCep (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 21:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhAMCep (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 21:34:45 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7FEC061575
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 18:34:04 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id s15so228215plr.9
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 18:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=suL/CDhJ5J0e33aS880Tja/HdCZZi4bFgOMZKkQ26j8=;
        b=01yMqNrXT5Br39Gp/RrCLThEEM8zUfiuTXzsiIQ1O6//YWWlQ54Bb3b3dy7NOCOuRj
         fOCHU2E/P5JNTY5yLIi7NY4jSFQz4IO6AP4WgxZTl+w32sD5fwEmpmPB79Y0GYhQZEhV
         jloI9tA/DDVAcx5U8n8E8iAdbqnIcj9Xa16yzz0IxMtBriSsVFFqsQb8waoSBorIJ5T6
         oRP+wo4zwOSRsmHAADVL5qXA9C2bzYs4/76Y455niwk7acFRmBVKS5yLdKix8E7AEN5R
         w3oDExzdmhP+Y+hTXTkXgqSl3VLsFJy8m5y+6eBnpYo/gtdPJlpLVHkWF1HoTkf2Xj2+
         KUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=suL/CDhJ5J0e33aS880Tja/HdCZZi4bFgOMZKkQ26j8=;
        b=AhOHjgENfEwWQheIPGRyPGrbcP12xbzYOBcNbhIcrfW+MgipPvbL4N1McUsg6wmRZu
         r/RA43EDNZy/422Mhm2GSUlvj4T96dGH1k7ww8ez2wf68dSagPWS9K0epuKA9GJk8yUN
         2olYl9KYzExlTj43MZehUwAfZsIahB7kKLwOGJswHKfaIoClSqxmOIG4XcObw4Qtt5wm
         CxDyzduCO5RFJkL7gZIb2QdhefG99p/V6627dUCLCiWhKxEgxpWCWxbixux5UNMxhwPE
         l0RkuOqjiqk2ZEq82tkFefxgsM4915vR5CdF15U4gDszHozS8aoWBf6/ijCEApkVyZup
         B/FA==
X-Gm-Message-State: AOAM532rh9oikfc8Q0ko1f4g7Fu6tmBDn7m5Z/PPz7OdP0MvDCX1oAP7
        0q98m0xDZeLx5RWZoX7Nluw3xw==
X-Google-Smtp-Source: ABdhPJwM+Rk1/NxantYdzfjT2rbioeRP6Pl5SWYzV3zJc2IIM0VLSkQDwPrd1v43mifOzC60whINuQ==
X-Received: by 2002:a17:90a:c203:: with SMTP id e3mr231963pjt.8.1610505244082;
        Tue, 12 Jan 2021 18:34:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z3sm469944pfq.89.2021.01.12.18.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 18:34:03 -0800 (PST)
Message-ID: <5ffe5c1b.1c69fb81.5aadf.1c2d@mx.google.com>
Date:   Tue, 12 Jan 2021 18:34:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.11-rc3-12-g8cbb6cfa9b8e
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.11-rc3-12-g8cbb6cfa9b8e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.11-rc3-12-g8c=
bb6cfa9b8e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
11-rc3-12-g8cbb6cfa9b8e/

Tree: pm
Branch: testing
Git Describe: v5.11-rc3-12-g8cbb6cfa9b8e
Git Commit: 8cbb6cfa9b8ef84f97642e04038e571673f6ffe4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:
    multi_v7_defconfig (gcc-8): 1 warning

i386:

mips:

riscv:

x86_64:


Warnings summary:

    1    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused v=
ariable =E2=80=98wake=E2=80=99 [-Wunused-variable]

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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused variab=
le =E2=80=98wake=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
