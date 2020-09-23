Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8AE275B06
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 17:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIWPAB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Sep 2020 11:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWPAB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2020 11:00:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECA5C0613CE
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2020 08:00:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t7so3371847pjd.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2020 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=OdgxVchKr804lbg26B3TIKGQcQ5GUL6BtiREtl0Xv88=;
        b=j0GsnOtKQH8GPr8K0IKpzk6RhfdZSbUQobXgnOygsYa5heqvGNwkjjs+lV0dUE/OMV
         VKioe8HxGjF9MJIo/nPzq8pXqs1sSvTwXM8muIzfQuVWde1E0D7KTZdqwncDy3b43VjA
         QZmzz6r3Yr74Y1aaeeh/ZppekeQoyTRkwIi+fzgH1kDM3IpeLR/IIPJMfAWltDQ+i7TJ
         pRzjVUOYKP5qQDC+y7N6NTuzZV5A+xmWLmPRZasLFx3S+LtFFNULnilOWv5GCUBgfQ+I
         Tojrg8lLijG7b0NND/s0A5Pc9vPfDYj6eirGrr/4zkZ7gd+pQV2+DKmCfsgiX417fmvI
         Gh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=OdgxVchKr804lbg26B3TIKGQcQ5GUL6BtiREtl0Xv88=;
        b=YLoSvlJEUAUkAjfV+L3kPow6kelA4HtwzeGAxB1tICMpen8sK8WyUOvLf8NPA6haif
         XHU+Hj3To6Lo43vsSVHIqp+QyqAN3UPBx0ss1HYSJqp9i9Kabjh2Hx1HDYseAtB21Hrk
         I07IiGGm8Wfcs2c70b1YfQGE5ymzOdhjtMqZLAzW9CVgvOd+6S0KSAbvWOYrFgvcjqYA
         YhtNCdALKyDrm95dYjExGSKV7LFv+RXpAUJd7epS/+nSf938uSCLYETtx3Gtcr9tM02v
         3JZdRMMgDzxUC0A8jo9D3m6kO0wfLMpFKF862wx4G1ZV51nenJqLyEsc+vgwKkpSv+0y
         ctFg==
X-Gm-Message-State: AOAM530FeJbeTsV2QvdpzSLMIf70pnDld8fL1wCQi3hZiyfw8SA4tzWe
        9/obYOGIvNmsH5uqyBWsv4yDLAiKscEndA==
X-Google-Smtp-Source: ABdhPJyW2vZHYLvCo6EchRmlNb4BreW2Kzs8YRVV8ajG6fGZYbGdKOcQLbH+VMaQrvN1UoCrM7gjDg==
X-Received: by 2002:a17:902:7c01:b029:d2:29fc:9a93 with SMTP id x1-20020a1709027c01b02900d229fc9a93mr226786pll.84.1600873201147;
        Wed, 23 Sep 2020 08:00:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 9sm205131pgx.76.2020.09.23.07.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:00:00 -0700 (PDT)
Message-ID: <5f6b62f0.1c69fb81.921c3.087e@mx.google.com>
Date:   Wed, 23 Sep 2020 08:00:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.9-rc6-35-g5dee22f9d504
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 13 warnings (v5.9-rc6-35-g5dee22f9d504)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 13 warnings (v5.9-rc6-35-g5=
dee22f9d504)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
9-rc6-35-g5dee22f9d504/

Tree: pm
Branch: testing
Git Describe: v5.9-rc6-35-g5dee22f9d504
Git Commit: 5dee22f9d504e6f0a1ab8559900638a87376475c
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
