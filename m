Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD3A2DA5CE
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 02:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgLOBuB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 20:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgLOBtz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 20:49:55 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618D0C061793
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 17:49:15 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id q22so13474892pfk.12
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 17:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=AOOT3m9UKQ6yw2sglpHPNZIOK6RHPFONH2iD9OMnGDw=;
        b=li/TlLvIOj6YwmhG6oMvvxohDl/5ipzZGMB+s1zbETig1hjuL50gFMjehomd+cIUuR
         anuN9/HG0zKz9j5GYEyGow6FJbwnEye32w+RxCHVo0A/NLavkp+QGWPxaVeXHvxwulAw
         RX8X05xhRvk7XRqJ+pxPfw7qATOR34BWLBpadmtRqjWYaZCPWb8gXO1dX+sX67JKaEYF
         ZV0b39LNOalM7MPFbSWCJIscwPWN4i4zFpny4ht5SRv/yJ8q0hWwVLjfQuGvGk8nSfKn
         eVOhh8Z81zkb3V8ZUymJAt01bebPjiEagwlOax0ukwS8xFlHdLD+wzY2AB1PziG+BCFI
         Kxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=AOOT3m9UKQ6yw2sglpHPNZIOK6RHPFONH2iD9OMnGDw=;
        b=YHphFZUi69DJLDtmawRRumQKbrx/5QjYwMr7bMZ5FVZA4C+4Er33rlOj4OMDPDMFrF
         vu9B/kpDD4Xo7nHgOtqQCpHWjDPsqh6F8/I6FGkcVF+MMEo8zuFnKrt4O30GRLLYsyj6
         ZV4+kGhT72Zm6yn4IMzOoD2sswf5YCBWA4l55yKjndDlp7OqJe2wD1I+CJIR/uC0s1GK
         aDGhwK7Dkh7wR9Fo6y1OmAzoMnvxjdh9twuV1RSvtcjlyXrNm9RBlLzF7cHUXIVxlkrZ
         eKpACfckpLm3/QMB0Qggx5qYP6QoVGh4yNj4afHXuKGhKbH/Ub+LXjV6HV1xRVsyNUeB
         RBqQ==
X-Gm-Message-State: AOAM533+O2l8hNXjQk+SujnS9sqNcqlX0IKBJtDkbtYLwmyeoRk5Rhyn
        30GM8XE0+P5O0o5dtySNzCCO/TdhwCndmQ==
X-Google-Smtp-Source: ABdhPJw5G86GobWrVdXaSt6NdotVuug8tWWVphe0cXlHeaHoUxRt+X/REl/8I2UeMyzXYKZ1+Bh8Kw==
X-Received: by 2002:a63:534c:: with SMTP id t12mr27579868pgl.128.1607996954966;
        Mon, 14 Dec 2020 17:49:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 77sm21428339pfv.16.2020.12.14.17.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 17:49:13 -0800 (PST)
Message-ID: <5fd81619.1c69fb81.4a51c.cf9d@mx.google.com>
Date:   Mon, 14 Dec 2020 17:49:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc7-148-g08e85a810cae
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 3 warnings (v5.10-rc7-148-g08e85a810cae)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 3 warnings (v5.10-rc7-148-g=
08e85a810cae)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
10-rc7-148-g08e85a810cae/

Tree: pm
Branch: testing
Git Describe: v5.10-rc7-148-g08e85a810cae
Git Commit: 08e85a810cae7e70eae555a109236dd8f8730593
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
