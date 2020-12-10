Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE2F2D6903
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 21:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgLJUnm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 15:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732007AbgLJUnm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 15:43:42 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AF5C0613CF
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2020 12:43:00 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q22so5231627pfk.12
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2020 12:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=vlhNojvZnrzTKA4w7L7ZADT3LHSq7JQj1yUclqqeiOs=;
        b=orvTT5dGbZC/1KDQti0j0cFeeMY1zvFa6OaCOmxHh05w5GmHIjPvxlSmWFh7WmsE6y
         mYFS0yactgjCHYIehpgnnoHfOxzaX5Lazi0NIZ6TW2UOgms5gB/ImrjO9s7OrEd4A3bp
         T/OSMjWF98IWi8bRfkneeVu0pxmtpnbKNBYMecWkJd3gCCv5YzztA4yXqoFYjVCwoEYP
         HcBx/zCr5uqg453mgF3Y9bm/zdmeT0QOMth8HFdt9MoBgfNS/zMu+s+7TX6JJQNykYxL
         cbIIDaw+4YkP41I/F3JjWaZt1o5hPW3sj1pzkqE3TiL7cRIEPhWkyPyRuiq0m2ImWubF
         7fIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=vlhNojvZnrzTKA4w7L7ZADT3LHSq7JQj1yUclqqeiOs=;
        b=OHsCjKN7kVHDWoFFKopv3ur2I5kzHRZeHcsYapq21CJMOjTNPONvGz545f1ZP1GBjn
         R6mneCS8+/pbNVY7un9aC8+9yy91/R4zNbD+n6ZFQwfAdUXp1XduHeCP0s453NyCHp1Y
         TT41HE2DMUrw8dBxNG7bZhXN8qVm6Om/M1ZKCV71T4MgiJupH1mG4pd4fzhz4uDvoXME
         AaKTZLv5Dn5Hkf1pvux565tspU9Dws+vCgpXQrsaP6jSN0Z2lS0co2R+4QZSrU/L4n2F
         DTIxeav/5QutVdEKJUtp2Zuuw1Ik6eXQPtWFSEolhWvaQQjvu4K0sB3ORFvtozSEo2Ds
         0iLQ==
X-Gm-Message-State: AOAM533M+G6i/myJ0uITAkp+LfIvSa1El/TgSanCBCDyzZqLSd2u9io5
        GDtUMlqWanVYeC8ymz/n3wJ28w==
X-Google-Smtp-Source: ABdhPJzzKmMkJUAlB3yKo86/Fx6yOcaFHoz8AGDIXhuSzc93w5JpjoRjrx0Rf/+NPXpIQN9VUqbfjw==
X-Received: by 2002:a17:90a:7f05:: with SMTP id k5mr9567202pjl.103.1607632980301;
        Thu, 10 Dec 2020 12:43:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q23sm7486513pfg.18.2020.12.10.12.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 12:42:59 -0800 (PST)
Message-ID: <5fd28853.1c69fb81.8cbe9.e018@mx.google.com>
Date:   Thu, 10 Dec 2020 12:42:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc7-88-g58dfa0fa290bb
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 3 warnings (v5.10-rc7-88-g58dfa0fa290bb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 3 warnings (v5.10-rc7-88-g5=
8dfa0fa290bb)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
10-rc7-88-g58dfa0fa290bb/

Tree: pm
Branch: testing
Git Describe: v5.10-rc7-88-g58dfa0fa290bb
Git Commit: 58dfa0fa290bb4c04c0dc3838b5cbce2caec7775
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
