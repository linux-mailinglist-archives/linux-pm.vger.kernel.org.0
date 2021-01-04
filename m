Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136972E9CDC
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 19:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbhADSQU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 13:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbhADSQT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 13:16:19 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A20C061574
        for <linux-pm@vger.kernel.org>; Mon,  4 Jan 2021 10:15:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id x18so14971144pln.6
        for <linux-pm@vger.kernel.org>; Mon, 04 Jan 2021 10:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Nzkh/MTwfpC+tqSyjP0dSfbz3JESqUymFXdqE+SaNq0=;
        b=Hl/nNmx3/i8HXm9RLDIBIXHIMHLWIdEn0ic+R7iYAaqpjuLkcV2HNx5GktD6ntcbve
         7VqoRH3QvGMWqAFShe1CsmdRu2VGz921bSf0dVjTrf9zI6gybfO6vGDb1OU2fD3teMsH
         tAtHb+tALux7HUJj9vfh1RoGp2hSKUPOTdYzSjgFT5XhqDbtdY6NJi5SYmBtfhRAXgST
         jcSxS1Pqejiz4b8QNtQ8thajkBER8kF90CHRGaPd8sQ7fZjlbPo7mDceN1S5c/aPG/Ga
         1OAVUPgjhx8O/I0574q3haQf/doxPKhxfKBR5yj962CHsZWaJ/iMzf2eATAIdvrZTDrk
         G90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Nzkh/MTwfpC+tqSyjP0dSfbz3JESqUymFXdqE+SaNq0=;
        b=GMqHnRey/u5rGdE6cP2CeSB+SkPWAg2Hx85SfVsoy7/lST1LE3TJuS+/sGc68imFPa
         HNLfxanKrFg9tGi/qIXlYGjG8jMD/SfRDWEbTjlVjQxFr8ZfrMYlU/7ud5IWzCqa85fG
         lOXLBGwK1whbnWr8tJMRkqIXeJO/hrToEl5n8y+Dpalqfzs8VC2D5TSQ5+owu1twBAGd
         NTNBNunbnCyzZnnqQM6ZCC1WWrfhrYk7gf33a+v0b9guORdvEQSQlKMjmrLkmeRA3u6x
         /KWVmGS53yXfQ5KY/e91zWJIQ6syWEs1oCub3eirBnjwgIAvFMuMQtQaaQ8P+2KILTdu
         Qxhw==
X-Gm-Message-State: AOAM530g/KVYHkxcNJC+hPlmiIKn1p6Wb+kjkfkMWefUEleQlDTNZwh6
        O17L/GLIHcvmoZFuYEAQqtInQNHvjWVHvA==
X-Google-Smtp-Source: ABdhPJxoBnwp0sfqB03THM1UZmwMYhxAN0NzuP7PelNvxYhqF7QSdl/PV70REsN0oJlNjFRNNXPdGw==
X-Received: by 2002:a17:90a:72c8:: with SMTP id l8mr113615pjk.232.1609784139128;
        Mon, 04 Jan 2021 10:15:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o123sm54638729pfd.197.2021.01.04.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 10:15:38 -0800 (PST)
Message-ID: <5ff35b4a.1c69fb81.29807.b284@mx.google.com>
Date:   Mon, 04 Jan 2021 10:15:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.11-rc1-12-ga04307bd9ddd
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 2 warnings (v5.11-rc1-12-ga04307bd9ddd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 2 warnings (v5.11-rc1-12-ga=
04307bd9ddd)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
11-rc1-12-ga04307bd9ddd/

Tree: pm
Branch: testing
Git Describe: v5.11-rc1-12-ga04307bd9ddd
Git Commit: a04307bd9dddb650f84d968165cdf4d3dd3c9b99
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-8): 1 warning

arm:
    multi_v7_defconfig (gcc-8): 1 warning

i386:

mips:

riscv:

x86_64:


Warnings summary:

    1    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused v=
ariable =E2=80=98wake=E2=80=99 [-Wunused-variable]
    1    arch/arm64/kernel/smp.c:810:16: warning: unused variable =E2=80=98=
irq=E2=80=99 [-Wunused-variable]

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
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mis=
matches

Warnings:
    arch/arm64/kernel/smp.c:810:16: warning: unused variable =E2=80=98irq=
=E2=80=99 [-Wunused-variable]

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
