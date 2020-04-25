Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79EC1B8382
	for <lists+linux-pm@lfdr.de>; Sat, 25 Apr 2020 05:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgDYDl7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 23:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbgDYDl6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 23:41:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148F3C09B049
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 20:41:58 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t4so4476038plq.12
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 20:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Bzj1NRoBjzDwN9BHS3DdNbagMxKdLmNQnnaHrwan4TA=;
        b=L8k3yxgquh3E7rl6rGhZOlvaRp1xDpwqgeZ08hzVadqKBoNZCzxey2HFe4wAp00NGM
         /KxaErv2umeN+boxNWOcddgLqIZMGm0c7dCsFctI//aMLVnLkkdfNNlTl2KywyhxQnzd
         wLiLYnN8LhggwmY+C7DaafmKqWA0HT38Dhzr0RirKDw/ezBnD7QQTiUBmj732XIZiM+3
         DNtdNKlcaiL44yq34lRQ7bALN4FPqrFBDoiANXJfxrsw6XvFWJVbyCb+JThWbdnq57DR
         s9+Pt4YpTD6C22XeVnTOaPoWuYf/wDkUOD+FWDfeclMTOfvFzYhPnFrnDGHEIL7VKKdT
         jpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Bzj1NRoBjzDwN9BHS3DdNbagMxKdLmNQnnaHrwan4TA=;
        b=mc29hDMCfWmNGzF3wJpLykCFB3ZC1KplhVtQmJlf805l+7okgCSetoEs8jZJHpGiXC
         3UMVnr+Qfm3pbovEX5X80xeEhZDkS+rSLYuN1TXoaN6HfjsL3FUcfj2bnrxL4dBVXONq
         KF+7OXXJvtO6L7RBVsIMgb0s5W4k2q38FZx9Mjd5SOM2PkSj+rH80RhVu55v9SyT74JV
         C1N68nT9aYHW6NIkB4dOA3C8K9NRR8+4Yj3Bzeflk51xkniZS05dbwSQYjlaSfJ9fbAy
         9audVGCAKXd2pFyTJCfODQzBmOPMn+zyYn4yBOafPD53ExRUbOtFoboxaOcTnkyzQNiG
         OrKg==
X-Gm-Message-State: AGi0PubnmiJSmkI2NHoFvNnllTPsm0+3DhFs1gdHby9D0Jz9f9WRN6V7
        hZUbSS+EjJ1SMHVvjS+zzJrGVxo10nA=
X-Google-Smtp-Source: APiQypJ4BIkDLalk5Z/EjA13OY2RwYYlWY9z17Y1+nUmWhcKkC2pt4JS642LqTSuZAix8TtW5HqCdw==
X-Received: by 2002:a17:90b:f16:: with SMTP id br22mr9921332pjb.89.1587786117496;
        Fri, 24 Apr 2020 20:41:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c4sm6412007pgg.17.2020.04.24.20.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 20:41:56 -0700 (PDT)
Message-ID: <5ea3b184.1c69fb81.ecf2c.46cf@mx.google.com>
Date:   Fri, 24 Apr 2020 20:41:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pnp-5.7-rc3-19-gcd227cc5ff82
X-Kernelci-Report-Type: build
Subject: pm/testing build: 6 builds: 0 failed, 6 passed,
 44 warnings (pnp-5.7-rc3-19-gcd227cc5ff82)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed, 44 warnings (pnp-5.7-rc3-19=
-gcd227cc5ff82)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pnp=
-5.7-rc3-19-gcd227cc5ff82/

Tree: pm
Branch: testing
Git Describe: pnp-5.7-rc3-19-gcd227cc5ff82
Git Commit: cd227cc5ff829b628f48df3e6b18fc59349c4f9c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-8): 29 warnings

arm:
    multi_v7_defconfig (gcc-8): 15 warnings

mips:

riscv:

x86_64:


Warnings summary:

    16   arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (=
dma_ranges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" p=
roperty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, chil=
d #address-cells =3D=3D 2, #size-cells =3D=3D 1)
    14   arch/arm/boot/dts/bcm2835-rpi.dtsi:18.4-15: Warning (dma_ranges_fo=
rmat): /soc/firmware:dma-ranges: empty "dma-ranges" property but its #addre=
ss-cells (2) differs from /soc (1)
    5    scripts/dtc/include-prefixes/arm/bcm2835-rpi.dtsi:18.4-15: Warning=
 (dma_ranges_format): /soc/firmware:dma-ranges: empty "dma-ranges" property=
 but its #address-cells (2) differs from /soc (1)
    3    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Wa=
rning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but=
 its #size-cells (1) differs from / (2)
    3    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Wa=
rning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but=
 its #address-cells (1) differs from / (2)
    1    kernel/futex.c:1676:17: warning: =E2=80=98oldval=E2=80=99 may be u=
sed uninitialized in this function [-Wmaybe-uninitialized]
    1    arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: Warning (dma_range=
s_format): /soc:dma-ranges: empty "dma-ranges" property but its #size-cells=
 (1) differs from / (2)
    1    arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: Warning (dma_range=
s_format): /soc:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (1) differs from / (2)

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
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 29 warnings, 0 section m=
ismatches

Warnings:
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1086.4-52: Warning (dma_r=
anges_format): /soc/dram-controller@1c62000:dma-ranges: "dma-ranges" proper=
ty has invalid length (12 bytes) (parent #address-cells =3D=3D 1, child #ad=
dress-cells =3D=3D 2, #size-cells =3D=3D 1)
    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Warning=
 (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but its =
#address-cells (1) differs from / (2)
    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Warning=
 (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but its =
#size-cells (1) differs from / (2)
    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Warning=
 (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but its =
#address-cells (1) differs from / (2)
    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Warning=
 (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but its =
#size-cells (1) differs from / (2)
    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Warning=
 (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but its =
#address-cells (1) differs from / (2)
    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Warning=
 (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but its =
#size-cells (1) differs from / (2)
    scripts/dtc/include-prefixes/arm/bcm2835-rpi.dtsi:18.4-15: Warning (dma=
_ranges_format): /soc/firmware:dma-ranges: empty "dma-ranges" property but =
its #address-cells (2) differs from /soc (1)
    scripts/dtc/include-prefixes/arm/bcm2835-rpi.dtsi:18.4-15: Warning (dma=
_ranges_format): /soc/firmware:dma-ranges: empty "dma-ranges" property but =
its #address-cells (2) differs from /soc (1)
    scripts/dtc/include-prefixes/arm/bcm2835-rpi.dtsi:18.4-15: Warning (dma=
_ranges_format): /soc/firmware:dma-ranges: empty "dma-ranges" property but =
its #address-cells (2) differs from /soc (1)
    scripts/dtc/include-prefixes/arm/bcm2835-rpi.dtsi:18.4-15: Warning (dma=
_ranges_format): /soc/firmware:dma-ranges: empty "dma-ranges" property but =
its #address-cells (2) differs from /soc (1)
    scripts/dtc/include-prefixes/arm/bcm2835-rpi.dtsi:18.4-15: Warning (dma=
_ranges_format): /soc/firmware:dma-ranges: empty "dma-ranges" property but =
its #address-cells (2) differs from /soc (1)
    arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: Warning (dma_ranges_for=
mat): /soc:dma-ranges: empty "dma-ranges" property but its #address-cells (=
1) differs from / (2)
    arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: Warning (dma_ranges_for=
mat): /soc:dma-ranges: empty "dma-ranges" property but its #size-cells (1) =
differs from / (2)

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 15 warnings, 0 se=
ction mismatches

Warnings:
    kernel/futex.c:1676:17: warning: =E2=80=98oldval=E2=80=99 may be used u=
ninitialized in this function [-Wmaybe-uninitialized]
    arch/arm/boot/dts/bcm2835-rpi.dtsi:18.4-15: Warning (dma_ranges_format)=
: /soc/firmware:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (2) differs from /soc (1)
    arch/arm/boot/dts/bcm2835-rpi.dtsi:18.4-15: Warning (dma_ranges_format)=
: /soc/firmware:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (2) differs from /soc (1)
    arch/arm/boot/dts/bcm2835-rpi.dtsi:18.4-15: Warning (dma_ranges_format)=
: /soc/firmware:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (2) differs from /soc (1)
    arch/arm/boot/dts/bcm2835-rpi.dtsi:18.4-15: Warning (dma_ranges_format)=
: /soc/firmware:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (2) differs from /soc (1)
    arch/arm/boot/dts/bcm2835-rpi.dtsi:18.4-15: Warning (dma_ranges_format)=
: /soc/firmware:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (2) differs from /soc (1)
    arch/arm/boot/dts/bcm2835-rpi.dtsi:18.4-15: Warning (dma_ranges_format)=
: /soc/firmware:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (2) differs from /soc (1)
    arch/arm/boot/dts/bcm2835-rpi.dtsi:18.4-15: Warning (dma_ranges_format)=
: /soc/firmware:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (2) differs from /soc (1)
    arch/arm/boot/dts/bcm2835-rpi.dtsi:18.4-15: Warning (dma_ranges_format)=
: /soc/firmware:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (2) differs from /soc (1)
    arch/arm/boot/dts/bcm2835-rpi.dtsi:18.4-15: Warning (dma_ranges_format)=
: /soc/firmware:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (2) differs from /soc (1)
    arch/arm/boot/dts/bcm2835-rpi.dtsi:18.4-15: Warning (dma_ranges_format)=
: /soc/firmware:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (2) differs from /soc (1)
    arch/arm/boot/dts/bcm2835-rpi.dtsi:18.4-15: Warning (dma_ranges_format)=
: /soc/firmware:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (2) differs from /soc (1)
    arch/arm/boot/dts/bcm2835-rpi.dtsi:18.4-15: Warning (dma_ranges_format)=
: /soc/firmware:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (2) differs from /soc (1)
    arch/arm/boot/dts/bcm2835-rpi.dtsi:18.4-15: Warning (dma_ranges_format)=
: /soc/firmware:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (2) differs from /soc (1)
    arch/arm/boot/dts/bcm2835-rpi.dtsi:18.4-15: Warning (dma_ranges_format)=
: /soc/firmware:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (2) differs from /soc (1)

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
