Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C3F2CC53E
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 19:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389492AbgLBSdM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 13:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbgLBSdM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 13:33:12 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA6AC0617A6
        for <linux-pm@vger.kernel.org>; Wed,  2 Dec 2020 10:32:32 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v3so1577087plz.13
        for <linux-pm@vger.kernel.org>; Wed, 02 Dec 2020 10:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=tOBNibXNzOvsr3Ogui+BT7vRd3HKP/8LXGtFuXsgKg4=;
        b=djjHKLG9hqnOAKkBHrv1hKiI5LxQ9XgQXbv/dMwcY8MP8MJivhHN6XoZ8Jbs9bn+0N
         COOXYx3kLdaDJynCCO9rPYIyojRjegBDX9KlLmv6UcY1pFClA+QljAxodghk1lOsm/fU
         MMTdAKFOOvzNx9sCBK+nExMKuTeBs5YIBopjkyxSpHIv6py1ek9Q0WMKL6wOdnbUAyNC
         Tk1CaogQ5Ecx/RtIVvS4nP6ZSyPoi0OcHF2pS2nVxH70boftXW1ZnAmFIWSi6SPVSfF0
         4n+tIeFL5UGLzonPLELnK/GQQ1kZigDUw1Yg56gHfsuV121libkVJByZ1wrXf0tqaujA
         j0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=tOBNibXNzOvsr3Ogui+BT7vRd3HKP/8LXGtFuXsgKg4=;
        b=ZgjnqweRlat45AE4isNrfw+hXZtyt+UTHu33gQzZ6pnpyby+Yz0UTrLl16BohwvoEQ
         UCHuvy0pMtPTmcRqpBVoAsfJaXiqsNr/Zh59vA74GNxvEF0HZU4oXtCbDZRmQXh8oAAU
         XNdhTJqtXyKHNryo4su7gmfr211QvlpcIKun4EvQDsuLBV4b9BBO/a85MfMUnwVrTHhA
         Z8TLlGsd7r2/mXkhhyEf5IkK1pgn1Bv+jlaEmdjE6d8mMuMqAJRclZWy0nS/ShGf6pKO
         xvSRD9hdZa+RpSIr207QVCaomuEVs6z1IskKMu6kBVXWZg1fVj5RqTZIhx1KDvHlrCUE
         mQwA==
X-Gm-Message-State: AOAM532KjNS+wsh62NhE3tEbjpfABUBTy9KsgeF3r4aTTzj/RCgOtbYT
        LgzoG511eZfloiZ1bmDFFpgscA==
X-Google-Smtp-Source: ABdhPJyk7JjSRtCW3l/pYZbbNkC0VjV+7FsY6lux/mALbHOBjgRxyGDLZMnwPexgKdseVahbgNiQ4g==
X-Received: by 2002:a17:902:a502:b029:d8:e85f:3ac7 with SMTP id s2-20020a170902a502b02900d8e85f3ac7mr3721824plq.48.1606933952016;
        Wed, 02 Dec 2020 10:32:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y14sm488052pfo.142.2020.12.02.10.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:32:31 -0800 (PST)
Message-ID: <5fc7ddbf.1c69fb81.ac811.15b1@mx.google.com>
Date:   Wed, 02 Dec 2020 10:32:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc6-87-g53bf34061bc2
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 3 warnings (v5.10-rc6-87-g53bf34061bc2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 3 warnings (v5.10-rc6-87-g5=
3bf34061bc2)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
10-rc6-87-g53bf34061bc2/

Tree: pm
Branch: testing
Git Describe: v5.10-rc6-87-g53bf34061bc2
Git Commit: 53bf34061bc25d8191db8c0d66104c9e7ed7f9b3
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:
    multi_v7_defconfig (gcc-8): 3 warnings

i386:

mips:

riscv:

x86_64:


Warnings summary:

    1    arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge)=
: /soc/apb@d4000000/spi@d4037000: incorrect #size-cells for SPI bus
    1    arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge)=
: /soc/apb@d4000000/spi@d4037000: incorrect #address-cells for SPI bus
    1    arch/arm/boot/dts/mmp2-olpc-xo-1-75.dtb: Warning (spi_bus_reg): Fa=
iled prerequisite 'spi_bus_bridge'

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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 3 warnings, 0 sec=
tion mismatches

Warnings:
    arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): /so=
c/apb@d4000000/spi@d4037000: incorrect #address-cells for SPI bus
    arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): /so=
c/apb@d4000000/spi@d4037000: incorrect #size-cells for SPI bus
    arch/arm/boot/dts/mmp2-olpc-xo-1-75.dtb: Warning (spi_bus_reg): Failed =
prerequisite 'spi_bus_bridge'

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
