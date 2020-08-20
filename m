Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8DB24C4E5
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 19:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgHTR4I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 13:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgHTR4G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 13:56:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86697C061385
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 10:56:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a79so1400572pfa.8
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=KVK0gSpvqykJDr5HNbFAMvmoRNbH1Orc7FXLxvYkYI4=;
        b=NGdwn2CRUZ7/LTYkk/Un6ZYEx5LA3OmBXQKbfkaSG/LYADTEY5UMU4gACc658kG+K8
         4UpnRBz32nrPQkhcXZZHV07a2z1WxERVsHGTU0fB4I0PpP8HPT7wa1mOaY6o5zCvnRnN
         BBB04jiwbmY615+N8PfHfqzhsaR5DckAZ7XpfvbboLhZNAnEZ2CoMgz/qrNrQexroN3q
         tB1UTNGmyFCc73WzMNmEpBn4TcKLwmqbRTlYJZjV9TBF04PGrWoxm//PO/aIVQtOrACr
         y9/YsfDwAx2PnxYZUrtjbHahJu58muH3LMva9RJ02OBwKa83P97NbLXyp8P5v81Nl8hN
         3l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=KVK0gSpvqykJDr5HNbFAMvmoRNbH1Orc7FXLxvYkYI4=;
        b=H1gemxiDArlMjxAsGd14y/CaJDoRX2x7NP3AlWx9qdVUybgNnTmI4UaV75cpHmOyyc
         nnCpl2q+/LJyHY7nFsitdHOxHaSMTBJPNkX2Mhxn9s9sVsgOAhn5uvzG60OV5qBubVC0
         3INCvxkcCEvm+XPg4vEUyFGlcE/DZBeBmG+lKrgw4ulf5Z/PXLJyFpRGD9mo4zzlGP3A
         jqlq5WpEsKQZQvJ16yrX/F2CnofMc9hMvKpNR/EGstJh1ebYhq4gycfPCPDsCUOoTLYl
         3+IaNTJU3MleqiKpp6suGSxvlTdzQP483mfHXDvOLLDo0FgKbVMNE74Zp9sKneKj7CC4
         DJPA==
X-Gm-Message-State: AOAM5314zk8YEsFsGp+JkJ5xCdlvJ06IechXMMrX2znNxFrHkxN7qMig
        whG2gWIryy72+kOg0bzGgCIhBw==
X-Google-Smtp-Source: ABdhPJxNMqYx5fFjw1lDaGMkNN+D76lPzGWKbMmHWYcDsw9amhh7B9ONEVVJPX7AjtCHyZKic7W2Sw==
X-Received: by 2002:a62:758f:: with SMTP id q137mr3019272pfc.170.1597946164771;
        Thu, 20 Aug 2020 10:56:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x8sm3719271pfp.101.2020.08.20.10.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 10:56:03 -0700 (PDT)
Message-ID: <5f3eb933.1c69fb81.4fbe8.8f51@mx.google.com>
Date:   Thu, 20 Aug 2020 10:56:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.9-rc1-4-gcc15fd9892e2
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 11 warnings (v5.9-rc1-4-gcc15fd9892e2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 11 warnings (v5.9-rc1-4-gcc=
15fd9892e2)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
9-rc1-4-gcc15fd9892e2/

Tree: pm
Branch: testing
Git Describe: v5.9-rc1-4-gcc15fd9892e2
Git Commit: cc15fd9892e28689b6e17dbd6e28d00c55d62928
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-8): 8 warnings

arm:
    multi_v7_defconfig (gcc-8): 3 warnings

i386:

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
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

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
