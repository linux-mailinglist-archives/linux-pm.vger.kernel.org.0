Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8B58BC76
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 17:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfHMPIq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 11:08:46 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54750 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbfHMPIq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 11:08:46 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190813150844euoutp02cfacef1d05337694df71a57428d260c1~6g-iyMFur1874218742euoutp02i
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 15:08:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190813150844euoutp02cfacef1d05337694df71a57428d260c1~6g-iyMFur1874218742euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565708924;
        bh=7ATlolmKB2vLAwWlEKLrEMvaSHiuKCWTBcweaWIHNYc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FihvMt4lSk7Hj2Nd8IkQjvu2q/vtJ4BP4vj/J7R/E9nfnFIMxQybD7P0PLdUlyFq8
         juH4xaZB+0ydCehHmjahW3xUZer6TfD4Ul6vdLJsWHgU6X+P9/NHYRp/1REBIefxh1
         OaoJBW5U7q/NhZOxX4CFBs7Xbf9iPeFvptqJ3G6s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190813150843eucas1p19382c776b90dd8a959dbfabde955d639~6g-h5XLUT0898208982eucas1p1J;
        Tue, 13 Aug 2019 15:08:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C2.9E.04309.B72D25D5; Tue, 13
        Aug 2019 16:08:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190813150842eucas1p2c248537d9cd593073e12abeac2cacab5~6g-g7bwt52657926579eucas1p2u;
        Tue, 13 Aug 2019 15:08:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190813150842eusmtrp15fcd0a834058ad23143a20e535a97203~6g-grdCL91601316013eusmtrp1j;
        Tue, 13 Aug 2019 15:08:42 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-d9-5d52d27b5da6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 06.C1.04166.A72D25D5; Tue, 13
        Aug 2019 16:08:42 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190813150841eusmtip2c0cefc9844cbef5bf5c605e8884af6ed~6g-gC7cEV1406314063eusmtip2X;
        Tue, 13 Aug 2019 15:08:41 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 0/9] Exynos Adaptive Supply Voltage support
Date:   Tue, 13 Aug 2019 17:08:18 +0200
Message-Id: <20190813150827.31972-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSyUcRzv97zc8zDHzyHfXaa6MquWl9CepolV223WMrU2lenKM4zDnvOS
        /JHNVIRUW6RaSnbnTDhHIta8zlTCZrcpydtCkVxbRcl5KP99Xr6f7+/z3X4sKWug5WxMfBIv
        xKviFBJrqr7zZ+/e9P7QcK8q02aupqiK5h62v6G5G2MzJNfbW81whrFBmhtovC/hFvLaEVfU
        20Jwle3vGe5xnZnhsprbGa7t81Waqx3plARKlQZ9tkRZ++SyMt+oR8oFg2sIddr6YCQfF5PC
        C54B56yjOxeqqMRCp4vNS8/IDPQW5yArFrAvvCv+TuQga1aGdQgymyrWiBlBf3UNI5IFBFPd
        HWg9Mv7rFS0aWgQfJ7X0v0iGScdYpiTYG/I68lcTjtgBhsu0q6tIPExAz8RrwmI44AAYH10m
        LZjCbmB8sbiCWVaK/aHsQYL42laoqH65OiLF9tB9d5yyYHJFz6y7R1p2An7KQNtoPiMGjsDk
        w1ZaxA4w3WVc012g53YuJQYyEeQ2DTEiKUDwoatk7Th/aOvqoy0tSLwLqho9RTkIimp1EosM
        2BZMX+zFErZwq76QFGUpXLsiE6d3wqK+kBCxHK6PL1MiVsLs4PJqHRkOh2HzDFGAthVvOK14
        w2nF/zuUIFKPnPlkjTqK1+yL51M9NCq1Jjk+yuNCgtqAVv5Tz58ucwNqXDrfijCLFDbSEGNo
        uIxWpWjS1K0IWFLhKC3oW5Gkkaq0S7yQECEkx/GaVrSFpRTO0vRNI2dkOEqVxMfyfCIvrLsE
        ayXPQMHTi8+VXn7aJhfnww4FYNIKFS5BSwduHpoLTZ1yfUTg2RNJgkHi3u8e9tu3xfUU53gs
        f3bMXOrm0xTett9mPrC8LBup7bzCVNvLf+woFbqHvpqD6z75SHQzcyePH5Urzwb4yearnTrs
        vnlOyF1jAwci9tgOjt7x6B5trkwishSUJlrlvZsUNKq/gyHdpEsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7pVl4JiDdbe4LfYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexrHP61kKpotW7P2znbmB8YJAFyMnh4SAicSTX2dY
        QWwhgaWMEg2tMl2MHEBxKYn5LUoQJcISf651sXUxcgGVfGKUmDHpFiNIgk3AUKL3aB+YLQJU
        dG/pcnaQImaBV0wSt+f9ZwJJCAvYSTx59J8ZxGYRUJXYsuc3M8gCXgFriaVz8yEWyEus3nAA
        rIRXQFDi5MwnLCAlzALqEuvnCYGEmYFKmrfOZp7AyD8LSdUshKpZSKoWMDKvYhRJLS3OTc8t
        NtQrTswtLs1L10vOz93ECIyebcd+bt7BeGlj8CFGAQ5GJR7egC1BsUKsiWXFlbmHGCU4mJVE
        eCdcBArxpiRWVqUW5ccXleakFh9iNAX6YCKzlGhyPjCy80riDU0NzS0sDc2NzY3NLJTEeTsE
        DsYICaQnlqRmp6YWpBbB9DFxcEo1MJaah3wSb63vzrd/acX6UM5vefZ1074yda/UTbNeb37e
        f9vQWnhbxyvODUs47mocXrSQIZv3zMVzXNtZrO+KrpOKZ/3ZKvz2mN7KZY7TbTcnC/3YcTeo
        f3uEu9Jl3dIDD6TmSnhHhZ5LtRfYrv757aJ0Oe+iuN3X6ty4H/ysDTm4/v8vx+6lj5RYijMS
        DbWYi4oTAY4cMiK0AgAA
X-CMS-MailID: 20190813150842eucas1p2c248537d9cd593073e12abeac2cacab5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190813150842eucas1p2c248537d9cd593073e12abeac2cacab5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190813150842eucas1p2c248537d9cd593073e12abeac2cacab5
References: <CGME20190813150842eucas1p2c248537d9cd593073e12abeac2cacab5@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is third iteration of my patch series adding ASV (Adaptive Supply 
Voltage) support for Exynos SoCs. The previous one can be found at:
https://lore.kernel.org/lkml/20190718143044.25066-1-s.nawrocki@samsung.com

There is no major changes in this series comparing to v2, only minor
corrections addressing review comments.

I was not sure it was a good idea to try to extend the OPP binding 
so as to include the ASV data tables in DT, so the tables are left
in the driver.

This patch set includes Exynos CHIPID driver posted by Pankaj Dubey and
futher improved by Bartłomiej Żołnierkiewicz [1].

Tested on Odroid XU3, XU3 Lite, XU4.

One of the things on TODO list is support for the Adaptive Body Bias.
This will require modifications on the cpufreq driver side in order to 
support multiple voltage regulators and changes in the OPP framework 
to support adding OPPs with multiple voltages.

[1] https://lkml.org/lkml/2018/11/15/908

Pankaj Dubey (3):
  soc: samsung: Add exynos chipid driver support
  ARM: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
  ARM64: EXYNOS: enable exynos_chipid for ARCH_EXYNOS

Sylwester Nawrocki (6):
  soc: samsung: Convert exynos-chipid driver to use the regmap API
  soc: samsung: Add Exynos Adaptive Supply Voltage driver
  ARM: EXYNOS: Enable exynos-asv driver for ARCH_EXYNOS
  soc: samsung: Update the CHIP ID DT binding documentation
  ARM: dts: Add "syscon" compatible string to chipid node
  ARM: dts: Add samsung,asv-bin property for odroidxu3-lite

 .../bindings/arm/samsung/exynos-chipid.txt    |  10 +-
 arch/arm/boot/dts/exynos5.dtsi                |   4 +-
 .../boot/dts/exynos5422-odroidxu3-lite.dts    |   4 +
 arch/arm/mach-exynos/Kconfig                  |   2 +
 arch/arm64/Kconfig.platforms                  |   1 +
 drivers/soc/samsung/Kconfig                   |  15 +
 drivers/soc/samsung/Makefile                  |   5 +
 drivers/soc/samsung/exynos-asv.c              | 184 +++++++
 drivers/soc/samsung/exynos-asv.h              |  82 +++
 drivers/soc/samsung/exynos-chipid.c           | 101 ++++
 drivers/soc/samsung/exynos5422-asv.c          | 498 ++++++++++++++++++
 drivers/soc/samsung/exynos5422-asv.h          |  25 +
 include/linux/soc/samsung/exynos-chipid.h     |  52 ++
 13 files changed, 979 insertions(+), 4 deletions(-)
 create mode 100644 drivers/soc/samsung/exynos-asv.c
 create mode 100644 drivers/soc/samsung/exynos-asv.h
 create mode 100644 drivers/soc/samsung/exynos-chipid.c
 create mode 100644 drivers/soc/samsung/exynos5422-asv.c
 create mode 100644 drivers/soc/samsung/exynos5422-asv.h
 create mode 100644 include/linux/soc/samsung/exynos-chipid.h

-- 
2.17.1

