Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2B425396F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 22:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgHZU5L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 16:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHZU5L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 16:57:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1941AC061574
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 13:57:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id p37so1758364pgl.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=WXV6sMWC2xGYLJjlj3Olmod0E3eq3zLxTh2J6UYO7rA=;
        b=E2yrr1bRevxeDwuAEtoyyN3guVTBZuPhmANlrULKGuiPBHS5f+QBV4w8ZSmznIUYdy
         fs/m/HeNgqdW0sulKQkZ1ipuTy21scdo0cpKmeO7+CtypuXopcC3F/Z7yLyqcWb56U7j
         X0psdHdo5TnOLU2gDy+aTi5kwYO+Wa0KtIrengI7X60Ct5SYGgudX16w48McYPxLzZqq
         JEGYcGkgktgg+7TrBAOLKJBPhV3p8kqK+NF3KDYU9gKCXmNihZkZxdr9f0iRoSgqy6L7
         dqtMZPexLX10L+vPhbQF4t0wvzirYWTlPO+tCwVXjXN4qc3LBTAS9sVFf4JPoAPfDden
         2HRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=WXV6sMWC2xGYLJjlj3Olmod0E3eq3zLxTh2J6UYO7rA=;
        b=BL+r4Unrk9Jt/sAimwW5xLaQi1Q8DBiWmC247aX4juxyGLTHuXMttvxxGFIcZbGREB
         0EpEnbz4sNNAtKSJGVRIu6Lyo0ysu5iGnwa9ldJdkVwlrezfKXGq3HJGuWsHiv74VfpZ
         MIYNXZQu+pC8b58b7fGAITlR/Xg0sXpS8JBi/GUnRYYf0LBYLk6Hsob6+UUkDuAZ/g9l
         KM7Kz1cy1bKRznjSD3Re2NZ2/iCCzYZSvozBKKFxE2thIKd9yCmyz2VjvH2rbgMcPVfb
         gWEj/x7s3JfD7j0pkp2r5Jk/xRjK9yLtbHU7gY2t+dpDTAdAK2VQP1a/pkZjeTO233ZG
         KLHQ==
X-Gm-Message-State: AOAM531E/E56RXPRKYmCA+5nP0C73892IJGR9vuhuEfTa8p0UvB+9/Qc
        mDxqxfZsc+51sRzRgzoHHRa8XyiqPyKoIg==
X-Google-Smtp-Source: ABdhPJzcDzGQ4zUgYBqyl7FWhvwPd67jYuDQg51+G40CYWGpkqneO20T+iKBYthG8sN20J9HLkmbdw==
X-Received: by 2002:a62:ea01:: with SMTP id t1mr13852033pfh.125.1598475430504;
        Wed, 26 Aug 2020 13:57:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t63sm3284517pgt.50.2020.08.26.13.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 13:57:09 -0700 (PDT)
Message-ID: <5f46cca5.1c69fb81.777bd.7c48@mx.google.com>
Date:   Wed, 26 Aug 2020 13:57:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.9-rc2-14-gfe784821d630
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 11 warnings (v5.9-rc2-14-gfe784821d630)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 11 warnings (v5.9-rc2-14-gf=
e784821d630)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
9-rc2-14-gfe784821d630/

Tree: pm
Branch: testing
Git Describe: v5.9-rc2-14-gfe784821d630
Git Commit: fe784821d630f71eee1f431f10e08518db42dc02
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
    2    arch/arm/boot/dts/mmp2-olpc-xo-1-75.dtb: Warning (spi_bus_reg): Fa=
iled prerequisite 'spi_bus_bridge'
    2    /scratch/linux/arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (=
spi_bus_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #size-cells for =
SPI bus
    2    /scratch/linux/arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (=
spi_bus_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #address-cells f=
or SPI bus
    1    /scratch/linux/arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: War=
ning (dma_ranges_format): /soc:dma-ranges: empty "dma-ranges" property but =
its #size-cells (1) differs from / (2)
    1    /scratch/linux/arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: War=
ning (dma_ranges_format): /soc:dma-ranges: empty "dma-ranges" property but =
its #address-cells (1) differs from / (2)

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
