Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E8822124D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 18:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGOQ2Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgGOQ2Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 12:28:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F58FC061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 09:28:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u185so2327243pfu.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=antFgvcvovpPngM1DtsfIxAR1c7XyaeeaflzBv50dHg=;
        b=H4DfiEl0qls6SdilFnJ3ES+F19TE/po/QcD53LczgyrOjlL9yfGR8kHX3afkZ+3CN0
         DfGvKRLWCtDrrD+AHp2n2Nuq8fveXA0Kjtr1E5cgo6dMAzudkcMf9j9IemeYhZWEzzcS
         lLrvZQEWdtyrtg6C572+M+tD9ZPiwqk6Wb/551Zn/sY6r6sH6Zlxif6ZE2DsMJ+Mpwuv
         l1x9oQ4YOYFy6Kemy82HFeFbA+ZFcRwwmG8cuFxk6vUfTC++jAexGTHZb1w6DPNV+HHq
         O7yOz0O9/5kAeb8+xQYPWwEZpC0oqZft6VwlUr768r9R/zxNFdTgh7kdvb+WzFIcqs7B
         VJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=antFgvcvovpPngM1DtsfIxAR1c7XyaeeaflzBv50dHg=;
        b=Lmi1RJsX+G4NjOBhSijJNdEJ4aRs37CEjdCm4RK6h/OCawhtgq8v/gITGS/PA5dIUp
         HUzHcG4I6xOgnLNZTPKg719m5xo77B++/dpHt63tu9qBXLxBgR3BIPLyUGUo8Rb5jk7E
         m5cZQU6VFy3D6yQ6Mb9Hy4Hk1XNosCWqQiLg4eFDzH52KBBKLfAanmGg+rrhlACg8kCK
         fQ710D+p7oshTyyCKneWxp15dAxuqVp6JQblyHGR6xu+ZPhWi6sD44aBCK99y+q042FJ
         aU/2LWOL27nfAEaigOVaopgR0fMeHKpTqOnsl2oNvSoax8tzPs68v1De4INo0CCMhiK/
         VEug==
X-Gm-Message-State: AOAM532liwupn+SGH9edLgTEkDZYm7eu2IOxN0xfIqiFI0YLNHZLrvdD
        qltTzBNt7wIUtg02Q8QLtZArGg==
X-Google-Smtp-Source: ABdhPJzTd8hKP1w22KCVbqHCK3mOf/l4cmGoyZckc9Ud5GBLMtyQ0MYlOiGHlmOVpJUYp4pJKaHWHg==
X-Received: by 2002:a63:100b:: with SMTP id f11mr411066pgl.287.1594830502887;
        Wed, 15 Jul 2020 09:28:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y6sm2660147pfp.7.2020.07.15.09.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 09:28:22 -0700 (PDT)
Message-ID: <5f0f2ea6.1c69fb81.28993.6b61@mx.google.com>
Date:   Wed, 15 Jul 2020 09:28:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc5-46-g8d0151344351
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 4 builds: 0 failed, 4 passed,
 8 warnings (v5.8-rc5-46-g8d0151344351)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 4 builds: 0 failed, 4 passed, 8 warnings (v5.8-rc5-46-g8d=
0151344351)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
8-rc5-46-g8d0151344351/

Tree: pm
Branch: testing
Git Describe: v5.8-rc5-46-g8d0151344351
Git Commit: 8d01513443514b97657e43e2c02ca3aff58ae0a3
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 4 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-8): 8 warnings

arm:

riscv:


Warnings summary:

    3    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Wa=
rning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but=
 its #size-cells (1) differs from / (2)
    3    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Wa=
rning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but=
 its #address-cells (1) differs from / (2)
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
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 8 warnings, 0 section mi=
smatches

Warnings:
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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---
For more info write to <info@kernelci.org>
