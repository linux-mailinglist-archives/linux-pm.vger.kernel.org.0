Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E802D8312
	for <lists+linux-pm@lfdr.de>; Sat, 12 Dec 2020 01:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407252AbgLKX7X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 18:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407242AbgLKX7S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 18:59:18 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23109C0613CF
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2020 15:58:38 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p6so5414855plo.6
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2020 15:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=QqYv805a1RU0wrswW6DIXkLD+Bs1FBzAj2tYjxGw0wU=;
        b=ZBe3B+euEg10Yj9R15Oepc1gBC2H5a0VtstAJJ305toJj4D9+f3h+gr14ZS1zeNjpU
         cbosNPp+IqcGwnKqm8E0gRA4ua6V6NwAKwYLeUtlJPsIfYa02KsdrgVig80Ufz2qtAcs
         4UTIdgvGdxrCuq3ukrFo/FgAIVqLiW31XndACgBq+7n+MR5oOJA0meZwwpTdaeTN9brT
         MGZHgtcJPVJmb/yfAUl2eOYIe15X6cKexceWyj98Fox8RcyBHn2165acmddQgqQUkntt
         uX7NF+QeUc4vTryNhZnrL+yUInp4QJoCSnNYAjY/98oQuqelo57DXiLFf/KUFTzQQjqZ
         aBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=QqYv805a1RU0wrswW6DIXkLD+Bs1FBzAj2tYjxGw0wU=;
        b=NCITruF+IgmX7cSMGY8cdHe1uT4pKhxfW0CFz3XnwfgCE8Zo1dcbCFyEWO2tW2tG1U
         8wz2EubOS0yHzqhteMeo7qvaSltT79b7emtfKvmNltq6XiXw8mEmDhm0xXVK6F6nFwDX
         Awms2NKhp9syyGOKseKeQZY0+uWPTAV9rnDUx8VAvZb7mGkxwrvrR37qECXsiYuLsE7n
         M7gZ0x/sXffRcnxbHUa08eKTlVx7F7u6yJBeks4o1zwz9uIsE102rtK9ZFA9gkqdKiB6
         bsNxPxtvLRq6EHUeQNWnzRabAMpSwxaRk3686QLElgLp7Vw/GzDGwI1YIV2lH93iAEk1
         dW5A==
X-Gm-Message-State: AOAM533LHNt3aZv5XPmA7NreCGdbMyTuJrcfMZYnpvPhYBpxP8azngGO
        Wtql5wnq4wMOblIflhMp3RVwjg==
X-Google-Smtp-Source: ABdhPJw7JRhrETb5goQx/qZVZwzg6axDy9xFZ2J3JnlF8Nop6E1u9ZZEyj/Z/bgsy3dUndBpFGZRxQ==
X-Received: by 2002:a17:90a:a108:: with SMTP id s8mr15080965pjp.206.1607731117708;
        Fri, 11 Dec 2020 15:58:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e2sm11061332pjv.10.2020.12.11.15.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 15:58:36 -0800 (PST)
Message-ID: <5fd407ac.1c69fb81.dce80.530a@mx.google.com>
Date:   Fri, 11 Dec 2020 15:58:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc7-106-g97756044ce06
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 3 warnings (v5.10-rc7-106-g97756044ce06)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 3 warnings (v5.10-rc7-106-g=
97756044ce06)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
10-rc7-106-g97756044ce06/

Tree: pm
Branch: testing
Git Describe: v5.10-rc7-106-g97756044ce06
Git Commit: 97756044ce0645570f22b356174ed0c811458ca7
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

    2    arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge)=
: /soc/apb@d4000000/spi@d4037000: incorrect #size-cells for SPI bus
    2    arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge)=
: /soc/apb@d4000000/spi@d4037000: incorrect #address-cells for SPI bus
    2    arch/arm/boot/dts/mmp2-olpc-xo-1-75.dtb: Warning (spi_bus_reg): Fa=
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
