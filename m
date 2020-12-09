Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F282D4B92
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 21:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgLIUVH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 15:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732783AbgLIUVF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 15:21:05 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C85C061794
        for <linux-pm@vger.kernel.org>; Wed,  9 Dec 2020 12:20:24 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p6so1554471plo.6
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2020 12:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=GsuEMbOUQUfhJcvFQln/Cf4uFF1d4uWDWP6j853EsfE=;
        b=K+trvSsvXBqkZUBFCVvqYXQin9AP5Fji9JiCW5xrLGQeoiVVLcD9buCw3/4CTor+h9
         UJpYd7Xs0/IoSj4PbTMu5eorwRpcBlf5fGPTlQN5aFFhM0Q83WWQh+ts62ndEL9Sd3Lx
         pM7eeW+l24UeETC3m4dDXFsgts79o9Lfgvup6nqLJzfIalAZuwahLr6GXCu6MEvldrp2
         w2WVQ1F+W/WvE4FlBhX9EVmtJjapXNo3PWyarG4M9EvQ6ulvcGvMvEOjdd7xdEV5D2Td
         BmKRgWiaXkviPeNcHrsNGxnjZZR+wvtl4Fhewe+ws7Ats8Yss8jWKc6fv4SRvwPe3DLN
         4GAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=GsuEMbOUQUfhJcvFQln/Cf4uFF1d4uWDWP6j853EsfE=;
        b=SwBhQkhjiVS+DsL+W8tRt+v10tDyJ72fBHwNRht2HiEWyHT3mdSuHoDvVveLiWhXw3
         Qe3Dpb6TBKvTPrH7Kp3RwihQWrIBTBX6A2pl4G7+YoF3GBCkSyLUjjtPKv81BqZ9K5u1
         q76C6Tj/aIt57vjgBG0nsR39AodjqPO2FUw4PuSOZcJCkpT8EGWG2Bi9S2Hwbf6Fkhj7
         Thoiu8hBJWgFrqT5eNpP4c09G7SiH5npAt+i0aLbdAz5cfXcoxrACyqzwHZGWBFR479A
         ZHtPRrhB/bjEqYuRFiq2kepx4OuXx/V7YKjOETUhUBfJQfFtSXYa3rUDiExbp8OP/MAC
         S4BQ==
X-Gm-Message-State: AOAM5302vA6i+REV2oSISZADRteDkUqA8cq+KOiVKJVEv0E6ctx4FZXW
        iHYsu9Hc/7nuh70G99hsbChpTQ==
X-Google-Smtp-Source: ABdhPJyrVzNszRAR499SSjoN/H4YeQ6zcPz8SijGy+VwXB3konjC5wELCgvKtf2VLBrrR7JAxgHmwQ==
X-Received: by 2002:a17:902:d90d:b029:da:5114:7275 with SMTP id c13-20020a170902d90db02900da51147275mr3738814plz.64.1607545224418;
        Wed, 09 Dec 2020 12:20:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y1sm3429711pfe.80.2020.12.09.12.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:20:23 -0800 (PST)
Message-ID: <5fd13187.1c69fb81.bed02.641c@mx.google.com>
Date:   Wed, 09 Dec 2020 12:20:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc7-96-ga834ecc967a3
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 3 warnings (v5.10-rc7-96-ga834ecc967a3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 3 warnings (v5.10-rc7-96-ga=
834ecc967a3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
10-rc7-96-ga834ecc967a3/

Tree: pm
Branch: testing
Git Describe: v5.10-rc7-96-ga834ecc967a3
Git Commit: a834ecc967a356eabe764b7439b3877e93822dca
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
