Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55108284ACF
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 13:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgJFL0U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 07:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgJFL0U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 07:26:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81017C061755
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 04:26:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w21so8833956pfc.7
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 04:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=P7E5jGgKNshGLnz7Ge5UhUexG7Xa6q2w/HTIeBTfW9c=;
        b=FvApZEbPQw95aE/jKCdhfQbgi2NZLR4KBfEEMNJIcSDYQQhIfTHZZzJBDDzw7DJeAR
         SmvH+RnzlAbRrrN3VvL9rvXDiZVCLVsoO+TYBiSIG3iRS4Bfwmdez9JMjiWtNVoF9bXm
         v/N52jfV5Uizrn4Oa+FIaafwMe8T3spRA5QRTDMtBSZMGomiUxPTXXu7vYsTzHUM0MFP
         rGB8FGlpUmau49z/RGgQuye41xRSXeiC67snhrGoFDW1AERB2N+Ud6D5ToMX69vI7uv2
         xx/co5EeRRcOgHHAP1AVpjMGNKR08JJicCDzAufi3pSi1wsWpA2zoBW6a1mDGioGmRGJ
         FBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=P7E5jGgKNshGLnz7Ge5UhUexG7Xa6q2w/HTIeBTfW9c=;
        b=Y5JL9g3Ye8ljV5HhwBbTympgwPdQqKWmL7e2e2PdpQAzSnIOJVri6fEkuYppjkHa0p
         eobuuOPBY28pEvi5n9vnQC+IIzPH+jSM798OogWO1xkhBh33+OtZJ53z28uO9M3Hbzpd
         NPaWjy8emVknkD03n05bDq30YRGwGFYA+fdbX1q+W6olx9bRot4YDahqXZvOqwQ7y6cd
         9oS+waZU44OkveCr1bapIDyMlpSGihW/nwdqHs3zAVP+5LIt6jsycKw+mt7DHV0YN/lC
         JztqRjwvlAqGGs7SZQR+gwBBiqOPEuXQFgvN1Fk2K5GGAg5grJNk6hv/CI8NTcSkSF67
         bWWA==
X-Gm-Message-State: AOAM5321BEr8+AlEjEyMstKdKNx1GcMNgIpMd8t+KYBqHYjlyRgNr8f8
        i82FwaCMs2wYDMXeGH+7y7japUMqaZHC1w==
X-Google-Smtp-Source: ABdhPJzgb3NwMg9YFCtG49cT1005FS0IkhzexYSpEwsYSwuxrStmX+yMwbOfwdMQXyMc2Pv3bh+KKw==
X-Received: by 2002:a62:7e94:0:b029:152:60c3:faaa with SMTP id z142-20020a627e940000b029015260c3faaamr4484924pfc.9.1601983577923;
        Tue, 06 Oct 2020 04:26:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i7sm3239189pfo.208.2020.10.06.04.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 04:26:17 -0700 (PDT)
Message-ID: <5f7c5459.1c69fb81.e2eb1.6f79@mx.google.com>
Date:   Tue, 06 Oct 2020 04:26:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.9-rc8-119-g9acb56ca0dec
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 13 warnings (v5.9-rc8-119-g9acb56ca0dec)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 13 warnings (v5.9-rc8-119-g=
9acb56ca0dec)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
9-rc8-119-g9acb56ca0dec/

Tree: pm
Branch: testing
Git Describe: v5.9-rc8-119-g9acb56ca0dec
Git Commit: 9acb56ca0dec044037bf2d0a76f49ba773134ec0
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
