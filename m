Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EFC40D244
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 06:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhIPETK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 00:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhIPETJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Sep 2021 00:19:09 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030B8C061574
        for <linux-pm@vger.kernel.org>; Wed, 15 Sep 2021 21:17:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t1so4953018pgv.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Sep 2021 21:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=5PILVR3fB10VDwmxMZHDIm48YBfz0kOyxaqcCUTzvSo=;
        b=eiyKg58vZC0rY3v35JoSo7WXSSrIzv3ymO1NeY3g8gN/Jh2N9p9fedZWFPmeWSp8bd
         PymRM2XIpzNr9DQsAIUIGsRqT6k6782g0EjitdWeahlyqNNBF3cwQC8w1FnfccQUGGLp
         Ilbp3L+a9c8dp4vS5bxCkXD76Q+y8SBzs7eyBWKCDlZj78sUYBHqactjrssAzgMyF8AK
         0HzJX6jah3HZVswoFTg7wJPEl1CV6FSUGqbRWpen8OdV9UzB6OhboNTYDUPN50lM+lj9
         1cyPE6qpaM15WN+IiatejOe20mFhJ6+rCkk3Voc5LeRm4qS4azKVsqANr0YzAb6kvaPN
         tYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=5PILVR3fB10VDwmxMZHDIm48YBfz0kOyxaqcCUTzvSo=;
        b=reM+htU9UD2cjHCTVNxc1RmSVlf7033Ngp89mDvJIBFgIQnozlZrbv5cB775HYYIEe
         BY3Ex1kB/O/JnhurW5WP+01KwhnFkAw6++cqHhd81a94yBc21jxXSCiXRT0JFLgrE4xT
         jP/4495afxp1keEl+YO83LR2fHNgZ9AoaMLpCUQTEfwgx7fsfD22B3X2NP1Bf/l2jqGr
         3sxkerxbyPA3up7jLJww4HWYwwmFqFGOgQ4rADPsv7veEazSapYUT9u0Qr1zfIA16iLN
         7Xl+pf+urKpDkGB0vc+kwLebUfgGvqzwylCmhHVZwSWQgfJIiQVKQyTh7W80ln6jn+Ln
         iK+w==
X-Gm-Message-State: AOAM533cEJV0P6T+V5ixlzWxDniFbESOqY2jpphsEuffVkZt6ifdmIeE
        s9T7TtxvGSMVQGN1/TBG+PuIYw==
X-Google-Smtp-Source: ABdhPJxDwSTX5LHOPeul0DU/4cTcS6YVMpY+91upDt8mS44o5X8mRwBz59o145AaCoLXLKQMxCowsA==
X-Received: by 2002:a63:f963:: with SMTP id q35mr3152924pgk.132.1631765869393;
        Wed, 15 Sep 2021 21:17:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b27sm1388727pge.52.2021.09.15.21.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 21:17:49 -0700 (PDT)
Message-ID: <6142c56d.1c69fb81.681b3.6da0@mx.google.com>
Date:   Wed, 15 Sep 2021 21:17:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc1-5-g7f2d17677d02
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc1-5-g7f2d17677d02)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc1-5-g7f2=
d17677d02)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc1-5-g7f2d17677d02/

Tree: pm
Branch: testing
Git Describe: v5.15-rc1-5-g7f2d17677d02
Git Commit: 7f2d17677d02a80230c9ef4b9b7dc986aa4c2914
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
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

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
