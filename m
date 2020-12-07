Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C462D13BC
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 15:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgLGOa6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 09:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgLGOa6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 09:30:58 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84D1C0613D1
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 06:30:11 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id f14so7435171pju.4
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 06:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Gy9xDeC7zH2SLO6k43yQydOWdkEDOtU5OrOnFrHQ7o0=;
        b=vNOfNSqVwsTrhftYIdLdBSSb9iLPi8z1zHtHXWGWTgDYb7+zdEXJuQW6hdgH7tE4LM
         zwwGzeSHyAb7uXoUOdUnwoTUWHgaKM5+sYnt5r67zeldvmO6129XiSM7E1sK9Wnb+QCd
         SOEGwzQrDUo0XsUD6puLlkx9SnoMzbXspZ0pWrFgjHopc0xdmFMyTlh/SkjdPhkhVTU5
         52nPSoUMIumiiECANnVAAnjeQ2ZGRvrhPCNpL2fc5aGQRrKIGOmW87h7fMeXkO+mCahM
         Qtz5OGXah0BBocvU+JBZGDzPKmclweKEPG01Iw/uXU72lundhGDYgS26KiRI8OYPIWc3
         umXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Gy9xDeC7zH2SLO6k43yQydOWdkEDOtU5OrOnFrHQ7o0=;
        b=iix+O6FrX8vRKSGjoYW3FYf/sBY+sqm7rXFcblRBnJQxCY/vMHcwu+V+u0iA5TXO4r
         fhhG6LHGVoTywIygT8v4+Lalg9CWDAzJ8BU5pHy/BvRtUINTGlchOdAC+maLnzcsQnx0
         7YrNGwwtZIWI1r0K79Dfkiviaosheu0UOnb3kgwWDDKxaQX1FSVbtCkj09+A/iSIkkh2
         KBQaCMTzXnomww/kWOm6eufSLtqazeDWJdkNf2eK/iBigH2j2Z2iUbSyo5R+jI2476bw
         KSktmHYv9oqnyuhMYGHRA7Vyf/7FfhY6A/DTDheVxJIPvrAh0b3j2CQpkECjtWld25jT
         aN3A==
X-Gm-Message-State: AOAM5323M8ArFfwYN3GkGnNb5mi4OPS+E0hnw0s77pjTiKxcv5wwuc5u
        nTqDdn3u1yMJGHOnT0frY6R85wOdL269+A==
X-Google-Smtp-Source: ABdhPJxCr27mus90zSLqwbJebw3dJ7dI4+KWQOJBNb4gk3mc5Q1fq9/CQ+bbmolcxjfZBAkAjoxeSQ==
X-Received: by 2002:a17:90a:ab8e:: with SMTP id n14mr16184224pjq.96.1607351411496;
        Mon, 07 Dec 2020 06:30:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z27sm12907431pfq.70.2020.12.07.06.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 06:30:10 -0800 (PST)
Message-ID: <5fce3c72.1c69fb81.9465b.e85c@mx.google.com>
Date:   Mon, 07 Dec 2020 06:30:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc7-87-g960e625edeb5
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 3 warnings (v5.10-rc7-87-g960e625edeb5)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 3 warnings (v5.10-rc7-87-g9=
60e625edeb5)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
10-rc7-87-g960e625edeb5/

Tree: pm
Branch: testing
Git Describe: v5.10-rc7-87-g960e625edeb5
Git Commit: 960e625edeb5932009c1e687adae37447fdf69d8
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
