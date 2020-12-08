Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD6F2D346D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 21:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgLHUlY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 15:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgLHUlY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 15:41:24 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0201C0613CF
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 12:40:43 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o4so13273860pgj.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 12:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=J12rizzNJpvDHeBDK+JooIwKeN2M6waJYpLkDHkzQgc=;
        b=yZPn9wSKPOA4t0DXsi6A+CopXG1/dKiK9mqYDhFkIGRv66VMxL7YIZCJBBbpoeLbq0
         xCP+OQgwUq+T96nG+gsj5+2S+pFCFnMO+zxXdBveRrFsiP5DESV8L6kEUyEJ6If5zV5m
         2Ifm1012bTBS+px43ImT8UU0pQBxOMEMZTf+fZ64R/hmII5+P+dax825Bt9w3suU6Kb7
         njcptB0t+y84pxU41chu6JVX1l1eT84TGblTkaQs0oI+napVYctgkDEixrxJDj9zpvqS
         xINu8XhYMb1LWhO3HH0iRnHTT35yjOaxmqoyOhvcckQ0BTyaqJ5vjrCF4yjhALEQdpbf
         DQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=J12rizzNJpvDHeBDK+JooIwKeN2M6waJYpLkDHkzQgc=;
        b=XaAxpXEGMWGK+65K17AX9/QpGhOYWC3QCIXQQN5KlODJY0LKkn6viR4mkRy3BSBFhG
         tohIlqegmsgJawIhv0BclfF6JwBlm9rtU4ON9Snx/TYvjPVQtbQiNQJOMM35/M8pCs6G
         r+Pti+FoW11vZ5LAzymh/ycMCePwy1p4WNmqMVMMnbj4JyQC4iR9XZO1HbD3iFD0c6aS
         4u1dlQjXlwRwyND9FyV2WC6CC/FPM+ykBGuWm1nOy0AAVp6rVE6RKEaV+UDGX2NDwvSK
         tTF4aVYf7QBJwupQgL3Quq8owMdTPUsmju8ee6tBvYLK8ByzTZXQX7BYKNp2vEIhSk/5
         /s8w==
X-Gm-Message-State: AOAM533784GJW+pRn9iTUAqibaCg2J1JGzxfJRe/hrcvjze7ApwxH9tg
        0uDfQsUQ+fXR9OI7LvM+Nw8y0NiOsKC9Kw==
X-Google-Smtp-Source: ABdhPJxSo+6wdMxyLS3PJfTGHeO48VKCxYNRk00cI3aurfcIU//UN6UrGTE9iDOCngFwll8mJOCvJg==
X-Received: by 2002:a17:902:ee0b:b029:db:c808:ccef with SMTP id z11-20020a170902ee0bb02900dbc808ccefmr3336545plb.85.1607456401564;
        Tue, 08 Dec 2020 11:40:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id oc13sm4104288pjb.5.2020.12.08.11.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 11:40:00 -0800 (PST)
Message-ID: <5fcfd690.1c69fb81.da367.9073@mx.google.com>
Date:   Tue, 08 Dec 2020 11:40:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc7-92-g717f8fce803b
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 3 warnings (v5.10-rc7-92-g717f8fce803b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 3 warnings (v5.10-rc7-92-g7=
17f8fce803b)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
10-rc7-92-g717f8fce803b/

Tree: pm
Branch: testing
Git Describe: v5.10-rc7-92-g717f8fce803b
Git Commit: 717f8fce803b9501e192fef85d508e3d592f1c16
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
