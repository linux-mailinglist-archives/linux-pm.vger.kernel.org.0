Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7EC43D7A6
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 01:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhJ0XmB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 19:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ0XmA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Oct 2021 19:42:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF746C061570
        for <linux-pm@vger.kernel.org>; Wed, 27 Oct 2021 16:39:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r28so4607168pga.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Oct 2021 16:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=0F4QzNn2YoCPVpLRA3IP4Gaz6ilHcWyubMn25ZJB4JM=;
        b=MdHgF1/xqlnV+QmgFpOs7tm0MxYqo8hkz/Ky3q2H1IVGV4S4FOJhsCAvkoRDDGqIba
         VQZJzfk/A7MXmYIuylBb4bB5PF2gYazhfsdBt/fSKT6WsvTQ7eoju7m1lfwUo3B1ckLU
         ORGRBXhvNwTPcZB/yymmpJMAy1oQjRZY+CxPNq5RAJ0on0147ovPhKLcf/MJPp3gD7GS
         ybDRs0TBXBPFlbUFmJMrfOAOxsr9S9DGaFj1lqHVXmU4+OzL0OXW/OIoa2GKHci3YkFZ
         WJLx4CpkqfNh2TPZmLn75esLjum7+ihqU49r4gPGqoAO4s0tUn2ewbrMiD660LCfbTgv
         sAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=0F4QzNn2YoCPVpLRA3IP4Gaz6ilHcWyubMn25ZJB4JM=;
        b=GS/F9TvVHlNa5RwJowvR0BxbysYsKm/M0zG7iTeTOeQKCZaIavPncx04VFbrcIEGU0
         auvgQSc2RJ7f1RZyRER6DSkINvyWBelI8qyPDY9V8EHhaLNUshfA+oqt+T6+XEE4ch7U
         RNvbkEvKnXUYnpEr67k1CzrstBv36t6vDJ2K92uFvHmtUmoG7YBRgT++zIGVfBzWhv5u
         hC5DW1hERsQn06opp3R98dBSYhzAy35bSgQRaJ/xt6g9L4QbrhmCAQ7L+UDAE0qH9El3
         bPYfceh2gjN3oy6dRqZ77fUpj4BpWapWfIf6jsNLNPq3qTI65xLBLUL9scZCaHy6AYs8
         xdMw==
X-Gm-Message-State: AOAM532eTubFOcD8CwUhZ8W78PsoHbc144K2RX+OQlBKpmjdaACxZFYy
        EBKiW9l8WRzm09HqGcfmAIGj+g==
X-Google-Smtp-Source: ABdhPJw5j9CHT6zgbCMEWGUUCxIXVXRqL1V/Sgf6HVfB9/kRkePU/g/QHi2Uj8FZCoYWHPWhI8nGPA==
X-Received: by 2002:a62:1b8e:0:b0:44c:9318:f6e1 with SMTP id b136-20020a621b8e000000b0044c9318f6e1mr756414pfb.84.1635377974330;
        Wed, 27 Oct 2021 16:39:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p17sm1000828pfn.191.2021.10.27.16.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:39:33 -0700 (PDT)
Message-ID: <6179e335.1c69fb81.cab70.4b78@mx.google.com>
Date:   Wed, 27 Oct 2021 16:39:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.15-rc7-108-gba9410801460
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc7-108-gba9410801460)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc7-108-gb=
a9410801460)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc7-108-gba9410801460/

Tree: pm
Branch: testing
Git Describe: v5.15-rc7-108-gba9410801460
Git Commit: ba9410801460466c3d47801e2df1052da9f36132
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:


Warnings summary:

    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
