Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD272CAA98
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 19:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389526AbgLASR3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 13:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388619AbgLASR3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 13:17:29 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B533C0613CF
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 10:16:49 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q22so1370258pfk.12
        for <linux-pm@vger.kernel.org>; Tue, 01 Dec 2020 10:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=PHPt9QN/jYxGDi+7bBOYuuEohcBwZWvXhQWm7PdAUH8=;
        b=CHDzwjNNpr7E6fCm14d86bV/h3YU8r5CLi4n574rJnJ7/Jl1//CcePieMbJQR5RBQs
         J/BA+tNv2C+LbEI7oDScBQQuU72sPRcauu6TZhLi9p7YQ7YSBmQOBzleT251MBDqjZ3d
         A8Sw0Wv195+7Oy+9Z2pMUk6n6CkqkKTH3mGfMWGo+mdZnI0crpSzEGYwGQw07VIvtlwp
         F1Uy1AhfB0B4T6UehAgydxDAhZAECWZOUdSqRALW1CzpUlXbxUpUeP8IDloFM5EPv7RP
         d3tIVbfo7HRSpqsi5qEiwRaq3OIbk/SQPTulv0dB8zcBSJ8rsZMGx74ZpGGYyJXcdrYP
         UKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=PHPt9QN/jYxGDi+7bBOYuuEohcBwZWvXhQWm7PdAUH8=;
        b=eZyDDSuaLWXVlkZMARtrdgZ1aDzVEIFghvKSv48SiZzO9QcSmt0GFmoXA/IKDYzmg9
         cxt7cPA41DSFxTRLZMbi+aA7WZON0M42+k055M+ghRhLMfEwcTIbAXvF/F8jlSiukyYZ
         Vf7/CYTxqNXzbDqOruc/7SVEmcWiJouJU8RPwSd8t0k6Ime4i7wHBKqYQ40GeFvzqo4F
         o+h9a+KWjSlhsPEhIgsbKW96jDCFw2WdwsScn4oq45yzyWeVSn7NXk8IOkQ4zm8MO0kD
         a+0u19xc58mMCEaZFQaVWjrtDMC9bsyTizodovvMALoImZVnfxoL97z1Ox+QtTV8mvnR
         cu1g==
X-Gm-Message-State: AOAM530hgF20pQb4yRjLwRstspzSstW1ema25gkn3vG6Hg4rHRLdQd85
        ZQxzSh+Mlujh1GeLh9jYZ/NWjBJQh6BmCA==
X-Google-Smtp-Source: ABdhPJwS8vyIs6sqKvZOe7cZieQLufqVD81xSxdRjBT7YIEkVf8efOE5c0H5Rtp3AoCaiVasqee++g==
X-Received: by 2002:aa7:90d2:0:b029:198:39d8:e5b0 with SMTP id k18-20020aa790d20000b029019839d8e5b0mr3714808pfk.1.1606846608681;
        Tue, 01 Dec 2020 10:16:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gz2sm412580pjb.2.2020.12.01.10.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 10:16:47 -0800 (PST)
Message-ID: <5fc6888f.1c69fb81.d882d.0dee@mx.google.com>
Date:   Tue, 01 Dec 2020 10:16:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc6-78-gc6c91db76539e
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 3 warnings (v5.10-rc6-78-gc6c91db76539e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 3 warnings (v5.10-rc6-78-gc=
6c91db76539e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
10-rc6-78-gc6c91db76539e/

Tree: pm
Branch: testing
Git Describe: v5.10-rc6-78-gc6c91db76539e
Git Commit: c6c91db76539e729139e47085af40adf240800a4
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
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
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
