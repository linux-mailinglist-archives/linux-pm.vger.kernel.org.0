Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088F54767A0
	for <lists+linux-pm@lfdr.de>; Thu, 16 Dec 2021 02:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhLPB6o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Dec 2021 20:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhLPB6o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Dec 2021 20:58:44 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA06C061574
        for <linux-pm@vger.kernel.org>; Wed, 15 Dec 2021 17:58:44 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 133so21621713pgc.12
        for <linux-pm@vger.kernel.org>; Wed, 15 Dec 2021 17:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ARQM7MA0E1C0MVBRyRZAh7gXwblyhTDP+28Ma4CA4Ow=;
        b=iTqQb2nl4yzbnRihqcPCGl/VVLBThUBvFWijEiBlqubaJXItlEEGkDeaK/KMMQecS8
         B5RspMW/JatpT0hrpa72D5z+9V3QShn78/Ggse3cUsN/FIlIsLsXfx1+yyaMrrohbIZU
         arXBUNqC0+9ol4bNJVG7GqJylV1DjjBGoBchbb+0K013bCXIIoSitIRjOjubyX0R0TZF
         iAMf616N7N2wnhMeeD+9LjCrIczDEn71iDhB1ZTin9z/pxK1BoChvU6qfBo68W715Moo
         D1ga/dWRiqJZWFGWAoJCJBFrb/bltL/MMH1scB17mcW/8H2qoipIAd/m+LrdRHneEpTn
         zlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ARQM7MA0E1C0MVBRyRZAh7gXwblyhTDP+28Ma4CA4Ow=;
        b=4sesB8xp2arZYzV9ykmXJkUqsyGa6bMPWW64IgJwH9eUriRmXy4ZAFffQSE8qRLCOR
         /RHD27tEcNsHCoPWUAr0au4fB5YpK1m6iv48GkAe+nZLhcdW3Q5GVtv2Zo2DVotly/ai
         XIwHmK/ipY1hI1uNB7GtvrB4CxGacXJSZ348soxvJKuEGQ8VbzcjlX8tPIsBgy1nNW/z
         NeCly76UKPJe2WJuYRod1g0lGMEE4X5Q7ynTQlGWG89aXYpcOMHVELez6Y432iOIrjMp
         MA8hBGYQYajUfrArcn3VETJW2yQK+FEetM475LrN2DsOloH8b1WKaxYdvOMu0gV/ho38
         FiuA==
X-Gm-Message-State: AOAM531rfuRuEAYCx/1ftKMDs8O79VEZ/fz5LcUkjEvzD9XnNAkv4mml
        RVHOARS37+u7yn9XVqf86UL7fw==
X-Google-Smtp-Source: ABdhPJwvLDTR7xIZrvY1f4y/yrfRV54K1ue9rIJJiYuPz9aJipvV7rfSItMmntV/4yOpSrZrHY9Hqw==
X-Received: by 2002:a05:6a00:856:b0:4ad:7832:e13a with SMTP id q22-20020a056a00085600b004ad7832e13amr11638116pfk.41.1639619923578;
        Wed, 15 Dec 2021 17:58:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h13sm3724980pfv.37.2021.12.15.17.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 17:58:43 -0800 (PST)
Message-ID: <61ba9d53.1c69fb81.8b456.b0d7@mx.google.com>
Date:   Wed, 15 Dec 2021 17:58:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.16-rc5-43-g8dff5ac97bf3
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc5-43-g8dff5ac97bf3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc5-43-g8d=
ff5ac97bf3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc5-43-g8dff5ac97bf3/

Tree: pm
Branch: testing
Git Describe: v5.16-rc5-43-g8dff5ac97bf3
Git Commit: 8dff5ac97bf3147fe5caf4c0f21592607ca08416
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
