Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3A62CE041
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 21:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgLCU6w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 15:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgLCU6w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 15:58:52 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48619C061A4F
        for <linux-pm@vger.kernel.org>; Thu,  3 Dec 2020 12:58:12 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t7so2130101pfh.7
        for <linux-pm@vger.kernel.org>; Thu, 03 Dec 2020 12:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=6Y3KzEfvqnG4Tugs0hQBXtfTz5f86iEr0F/wcnYMUn0=;
        b=O2AaWd0PXvHexbPCuEyAV934rbG7gaQbXybS7jE1R+F4r/yUUe4vmCR31oaLFVPK5b
         6P2FvAgTzxcwLvCzwtoIjouyC5S6XFc/XmsH2iYwvkvGcnpW2D0/hV8RqyeVg+8gMyLs
         GFhhGC6VinQEtuA/13rqB3893mqZWA1RB0B8uHgmuqM77oF1wapc8ohNZ+4727aU/saT
         CWQXRZ5W2W+GvLUxkNGnseWD463Nybc0W+SY5ymmaLpKfUtoZ3lFOs4YK98YqBInJU2/
         ojuXoJrk0KqOz9eRTcANn5Njg3aagI9lf3KOyo0wT0Ogkea9jokrTYYR49rL5Nff/ez7
         PhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=6Y3KzEfvqnG4Tugs0hQBXtfTz5f86iEr0F/wcnYMUn0=;
        b=sklf96RKJczWbwItdwr4oa6OdOm1iVgni0vV+34uo6jtGEvvZFZCZ0MfYz9mxZf7c5
         aR2YNJkii46174+uuLLLC4nP9GYh7doBwZ0v7sdpB8rpert1M7Qi9ZPZRE8c/qE2lgUt
         zUaLkWGGO5diRLThJ8B/w6fYaCupHiFVeUWXfuw2bECOHzEljAF/uFXqP0QebwyWwPVv
         HiwQ0VAsax4axT9FuHVB25HUh4Bwcf4ptWx3j7zTXogapTppLlhKCUFQftgAj/Zvxnum
         jiaDMz0UcZ1U3PEal6QsPKPQTpBV0x+a7HOfrd3HWb9sqCmyqeWg2dRGo+py2lZuBQUh
         JIOg==
X-Gm-Message-State: AOAM530f3lFe/3cZOGgBlZ1D3gjwQY9sfaTzXVCJV5t9L3WS7nliTo9s
        Lz/1j+M4FST30nWfdtVXyjNn7dxQK2FmRQ==
X-Google-Smtp-Source: ABdhPJzEXxQmnPbJzZJIAik19a1Q07Xd4mYI6oN49eNpns/IhJEv5bLkYR0tU0utMNSOVm92HtnUyw==
X-Received: by 2002:a62:3205:0:b029:197:f692:6a8b with SMTP id y5-20020a6232050000b0290197f6926a8bmr689289pfy.2.1607029091559;
        Thu, 03 Dec 2020 12:58:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e1sm2627560pfi.158.2020.12.03.12.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 12:58:10 -0800 (PST)
Message-ID: <5fc95162.1c69fb81.da5b6.5c84@mx.google.com>
Date:   Thu, 03 Dec 2020 12:58:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc6-90-gc35cc6e0cf05
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 3 warnings (v5.10-rc6-90-gc35cc6e0cf05)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 3 warnings (v5.10-rc6-90-gc=
35cc6e0cf05)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
10-rc6-90-gc35cc6e0cf05/

Tree: pm
Branch: testing
Git Describe: v5.10-rc6-90-gc35cc6e0cf05
Git Commit: c35cc6e0cf0522be409eb83e6c2d7ab606627e17
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
