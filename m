Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8858827F123
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 20:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgI3SOM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 14:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3SOJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 14:14:09 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15472C061755
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 11:14:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m34so1554894pgl.9
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Z5lu0PeqUpQhHfIFiSeFh3YIiVvY8Dyl15uNalwR/lc=;
        b=v54jyApSEtOIgv38chiNi12+W5aoKN1il2S6XEU+H5+78qjS1w+mxSN1a26Uuwf0jg
         Bg0nr3dYwbFKAtcWDnVcNZZ1JWvulJ5RfAsJogt4mi/rpM2ue/60ZBSV1Gg+KI2F1XXC
         buEMs3MpDt/25AI4DzEBFTgVbeIFCi5qsy2UfQ8tuDv75wXZkqV/hq+xjIKVwGuBH/R8
         MBmBkZb/Ka5XcPLWBGrXBF1bOkb5I+cDvIPj33yyAmh968MnqXFtsdQDdWgNXuDZZrAw
         5zyoKLsxo9LlX4fsroGME7eX0xKinZfYn5cYslfn2LBEWk3c8hZK9bj5cdjbIsepaynY
         wNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Z5lu0PeqUpQhHfIFiSeFh3YIiVvY8Dyl15uNalwR/lc=;
        b=hXNHUSJF1NdyDOG0yfk5gJrSOKwIkhLzJADbC4t1hduuphjg2ZHTd69DySH/6uxPaP
         RG0nkTw8vBRKfaVJhCgXe7XIb8WFjbsYUqgM+BI6eTl80pUGcSU/SP4f6kijvit6QsZw
         oJ0N3K3JhvyEv5hJdxFjNYDNrhXIvwm9BxC3kY8jnpuJuIECWnZI/+45M4+qOUTs5zCu
         +NZCMvgpOMv5qrIHbsS0MieutCsmfcb4KA+xKLzVccE0v4Tg47307ihr0W4yDYphg2z9
         4QGLQPW9luYhq+tY61A3rx5v0mU6frdRMOQS2yVZdVjjoh/kULxcLTcK3Oufe8ShSGND
         TpAA==
X-Gm-Message-State: AOAM531JL4t99K0Tz64N4Njw9Oti3HbfA0ifGMv+7iVayq8dtc63ZTNe
        owMEcEU5j5mHcB2g8Oojqixrt9VlXZVZtw==
X-Google-Smtp-Source: ABdhPJyFNqVYg17+/tVfoRB+ejMm5GmU0R86MZAOh7goKlhTPQ+9XM1UkHo7o2Gvpdaw3Z3Lrn1YfQ==
X-Received: by 2002:aa7:9a0e:0:b029:142:2501:35e5 with SMTP id w14-20020aa79a0e0000b0290142250135e5mr3755963pfj.69.1601489648582;
        Wed, 30 Sep 2020 11:14:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j144sm3369415pfd.106.2020.09.30.11.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 11:14:07 -0700 (PDT)
Message-ID: <5f74caef.1c69fb81.a5ef8.64f6@mx.google.com>
Date:   Wed, 30 Sep 2020 11:14:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.9-rc7-75-g027a0d093137
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 13 warnings (v5.9-rc7-75-g027a0d093137)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 13 warnings (v5.9-rc7-75-g0=
27a0d093137)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
9-rc7-75-g027a0d093137/

Tree: pm
Branch: testing
Git Describe: v5.9-rc7-75-g027a0d093137
Git Commit: 027a0d093137cac9655d241a1ace1b36ed1f455d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-8): 8 warnings

arm:
    multi_v7_defconfig (gcc-8): 3 warnings

i386:
    i386_defconfig (gcc-8): 2 warnings

mips:

riscv:

x86_64:


Warnings summary:

    3    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.=
dtsi:7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-range=
s" property but its #size-cells (1) differs from / (2)
    3    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.=
dtsi:7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-range=
s" property but its #address-cells (1) differs from / (2)
    2    /scratch/linux/include/acpi/actypes.h:501:48: warning: cast to poi=
nter from integer of different size [-Wint-to-pointer-cast]
    1    arch/arm/boot/dts/mmp2-olpc-xo-1-75.dtb: Warning (spi_bus_reg): Fa=
iled prerequisite 'spi_bus_bridge'
    1    /scratch/linux/arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: War=
ning (dma_ranges_format): /soc:dma-ranges: empty "dma-ranges" property but =
its #size-cells (1) differs from / (2)
    1    /scratch/linux/arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: War=
ning (dma_ranges_format): /soc:dma-ranges: empty "dma-ranges" property but =
its #address-cells (1) differs from / (2)
    1    /scratch/linux/arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (=
spi_bus_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #size-cells for =
SPI bus
    1    /scratch/linux/arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (=
spi_bus_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #address-cells f=
or SPI bus

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
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 8 warnings, 0 section mi=
smatches

Warnings:
    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:=
7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" pr=
operty but its #address-cells (1) differs from / (2)
    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:=
7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" pr=
operty but its #size-cells (1) differs from / (2)
    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:=
7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" pr=
operty but its #address-cells (1) differs from / (2)
    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:=
7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" pr=
operty but its #size-cells (1) differs from / (2)
    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:=
7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" pr=
operty but its #address-cells (1) differs from / (2)
    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:=
7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" pr=
operty but its #size-cells (1) differs from / (2)
    /scratch/linux/arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: Warning =
(dma_ranges_format): /soc:dma-ranges: empty "dma-ranges" property but its #=
address-cells (1) differs from / (2)
    /scratch/linux/arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: Warning =
(dma_ranges_format): /soc:dma-ranges: empty "dma-ranges" property but its #=
size-cells (1) differs from / (2)

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sectio=
n mismatches

Warnings:
    /scratch/linux/include/acpi/actypes.h:501:48: warning: cast to pointer =
from integer of different size [-Wint-to-pointer-cast]
    /scratch/linux/include/acpi/actypes.h:501:48: warning: cast to pointer =
from integer of different size [-Wint-to-pointer-cast]

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 3 warnings, 0 sec=
tion mismatches

Warnings:
    /scratch/linux/arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_b=
us_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #address-cells for SP=
I bus
    /scratch/linux/arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_b=
us_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #size-cells for SPI b=
us
    arch/arm/boot/dts/mmp2-olpc-xo-1-75.dtb: Warning (spi_bus_reg): Failed =
prerequisite 'spi_bus_bridge'

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
