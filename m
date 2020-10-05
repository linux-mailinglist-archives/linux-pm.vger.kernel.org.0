Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD0283778
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 16:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgJEOQd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 10:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgJEOQc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 10:16:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA797C0613CE
        for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2020 07:16:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g10so3751381pfc.8
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2020 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VpbTPMeY6GdL3qa/RrovXWsJ/xo6QLp2Ync1bxB5ZoY=;
        b=Ev0nEnuvsIpLy06QqGrbTTC5OEUXoanSkJqgUgS9RYMO6vwuhjfAON+JTus//8T3ll
         2iZWRLVErryyzAzf/uT8D8AKatPJzdwdhWWjvMg3V8AD3s29/6V7ErT75VR9yp766Q+7
         hTPv1TENnbCE1ZDRc57QjzNxY3Q8ff2N4gttNEhPxZWzHAfshxeOaL73rp/bn+T8e9xa
         JIwvIn1l0RKB2mdvy4RaMTCoUP8/cHm2telZf5UUq3bPhVijjnhipX3i7Luwb4E0JhCI
         yeYnh9AjbgNkMVMLYpXoFzJlpWzJBEu2C/eKh4OfYJygcxxWupb++8VusPINA42J23/m
         XgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VpbTPMeY6GdL3qa/RrovXWsJ/xo6QLp2Ync1bxB5ZoY=;
        b=g318RyZRldr4Rao2wnct63Xd//aNG1XFqT5xrsINStxD/cCPDSu1nCXsTLK+0MYfCM
         KyBu9Ma7koVjEtvXb0F/5+CMDtWQ+6b9IXwk04AXW0szUvEEjkBtPXGG8UcwnZ4J6rwE
         qhcF1/HM/2X8u9vh5QHAOhJzu435ph6Q8M1DvjKn0HljeMsbDHHCjHetjpq8/kMc+ORn
         LF+u4Vse7+7AT/mG10nq3TreDkomsFFBznGvYnwT+7ZRxa1QOGSbj2yS3OIvt1F8WaWz
         JCngpZPDK9p4YLoFEED8luYrY1u6di0v+VUnI59feXgD6yMNVGA4OIELQPwwEnoF/6+d
         VaYQ==
X-Gm-Message-State: AOAM532KVHL4GbURmuJcgySHHkayR7UzKpGdOk/tpKa/KAZ2crl9dG5f
        ZnRhAf7NplH0/YpZJpOhruirXw==
X-Google-Smtp-Source: ABdhPJz4LYmMXBvp/OJz/Czu+5aGNNFvV3I27F1sPQksPMV4sXkybQ6So5Kp99K+YZHvjSRNKqm2PQ==
X-Received: by 2002:a63:50f:: with SMTP id 15mr10527728pgf.211.1601907374870;
        Mon, 05 Oct 2020 07:16:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j1sm62815pfj.202.2020.10.05.07.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:16:14 -0700 (PDT)
Message-ID: <5f7b2aae.1c69fb81.ad9e1.01eb@mx.google.com>
Date:   Mon, 05 Oct 2020 07:16:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.9-rc8-85-g66bebc5f7cab
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 13 warnings (v5.9-rc8-85-g66bebc5f7cab)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 13 warnings (v5.9-rc8-85-g6=
6bebc5f7cab)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
9-rc8-85-g66bebc5f7cab/

Tree: pm
Branch: testing
Git Describe: v5.9-rc8-85-g66bebc5f7cab
Git Commit: 66bebc5f7cabaf1149f341fb7bc660d59fb99269
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
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

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
