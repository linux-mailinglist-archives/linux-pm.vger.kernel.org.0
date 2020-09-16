Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C93E26CE5A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 00:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgIPWIO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 18:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgIPWH7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 18:07:59 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5249C0698CF
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 14:59:39 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g29so137773pgl.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 14:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=mJOzzNgVbUp7zhsRmXvEFKirSQmYB9zLHzRmaSU0HG4=;
        b=IiWYprE1qL0ZN31qktupbvBuNscc1eNsT8NkqYsmvMRzn/8E8iD8hRggT7+9N/+lKe
         DfY4YvXBEqDk3XtL9RCOe8xDjuh8KvqwUbUmRSn50S+1Om1Q9Z5RIiPR0TGvncy251eN
         b/l50cHIRRYIZcIvRdBBUJ1kYhictaGXAdApS2e2oxqwCCPc8Ff5XyVyUWm6hegB7XMx
         N2u0riM4qDznoz9+IFA5fcm0OLDA5FPMmAXeTlz0w4CqDYxKCw07mN0u428cBQlA0BOu
         PGPHu/syD8TfIVrYrRGNQw8bVwqosWPrqAkaYnZqvE9s7LKloDNWuEzJyX+zZqBMhaoi
         UWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=mJOzzNgVbUp7zhsRmXvEFKirSQmYB9zLHzRmaSU0HG4=;
        b=aDbvcIs+beFC4sqWWpJAuoo1HAHWwMvv+wBKcQRzqROFl2omXSVPp99uryaWDuQJg5
         Y9/3feU3Eq+ZSrnOcqHev9lkpm2WJRULNVqcvMyhaqsJZ+o8c3pqgAlrbt/9C/2OsgPS
         Zfekjn+QchWH1wFW4cc8M4dxJe3JWD34ch1SqpbHDVqYFbGTk0C00eTecO0o6SaOWZ0E
         88l4h/HGR4u29/YTNwA7fMjQN0LELI62gPq91s0y2j/1Uicu8J5Jz6dJrEoxg12WrlI3
         xXtXx80YCcWB6GxY2hmDGSR5ARuMNuh7GC6yG0pRBCzlIST6F16/uod2GTi3m2Af5HnZ
         Nkvw==
X-Gm-Message-State: AOAM530DoRBv3u1WvL7wYjX7BrGf+LNuvTH+B8h4m9Xbk/OZ8I6HmJ2D
        Qz0DfC4nO1w/7jyq5OqHgdOYRA==
X-Google-Smtp-Source: ABdhPJyQbV9df43ax8B1AlVD9eYY4gIVv/x5e07p8/Eo1JlNXcZq5HyCYVokyEUIlTKmMxwjRB/sLQ==
X-Received: by 2002:a63:7882:: with SMTP id t124mr10229130pgc.381.1600293578776;
        Wed, 16 Sep 2020 14:59:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 20sm18700925pfv.87.2020.09.16.14.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 14:59:38 -0700 (PDT)
Message-ID: <5f628aca.1c69fb81.ac74f.ed91@mx.google.com>
Date:   Wed, 16 Sep 2020 14:59:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.9-rc5-11-ga65af31190c0
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 11 warnings (v5.9-rc5-11-ga65af31190c0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 11 warnings (v5.9-rc5-11-ga=
65af31190c0)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
9-rc5-11-ga65af31190c0/

Tree: pm
Branch: testing
Git Describe: v5.9-rc5-11-ga65af31190c0
Git Commit: a65af31190c0d5c8a9953508914f499deecc82bc
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
