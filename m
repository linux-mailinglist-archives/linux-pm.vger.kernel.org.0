Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 995EF125CAD
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 09:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfLSI3x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 03:29:53 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43249 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfLSI3m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 03:29:42 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191219082940euoutp02dd87598b78e617c11e1d552cced888cc~huHpkO9il1763617636euoutp02N
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 08:29:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191219082940euoutp02dd87598b78e617c11e1d552cced888cc~huHpkO9il1763617636euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576744180;
        bh=pj4zc0DjOjeyC5CrooTc2mCB0uhmCjiP4F+F6+fDoUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0MsuwDqATzSvxE6pqUbC2LyVYN/4v4hGaahYTXz1R4h/7q7cTCttaXcIiaf1evuY
         W2GRhMVRrV6TADCil7vClIiAbf+5iR78qf6afiL2FfHxaQcmzS6f2lWzlA0+0c9/OR
         Wi3bK0iSvxQ4BqVHDLQx0By9ls2Rhc2zcJVE1XYY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191219082939eucas1p12319bfbe2c7f3b9394bdc5f83921fd4d~huHpOWQCY1482914829eucas1p1r;
        Thu, 19 Dec 2019 08:29:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B1.EA.60679.3F43BFD5; Thu, 19
        Dec 2019 08:29:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191219082939eucas1p2afc32535df1512dc21ca983daa012568~huHo7e5781682716827eucas1p29;
        Thu, 19 Dec 2019 08:29:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191219082939eusmtrp14f7739da8e8a8b0e6a6ff7bb3f6ec017~huHo65I-k0048200482eusmtrp1w;
        Thu, 19 Dec 2019 08:29:39 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-07-5dfb34f3a92f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BC.C8.07950.3F43BFD5; Thu, 19
        Dec 2019 08:29:39 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191219082939eusmtip1f57ad9d5c7a4ac29414aca2e6b601803~huHogu4TG0546305463eusmtip1c;
        Thu, 19 Dec 2019 08:29:39 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/2] ARM: dts: exynos: Adjust bus related OPPs to the values
 correct for Odroids
Date:   Thu, 19 Dec 2019 09:29:27 +0100
Message-Id: <20191219082927.11898-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219082927.11898-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djP87qfTX7HGjQstbTYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLy7vmsFl87j3CaDHj/D4mi7VH7rI7cHhsWtXJ5tG3ZRWjx+dNcgHMUVw2
        Kak5mWWpRfp2CVwZq761Mhf02Vd87epgbWCcp9/FyMkhIWAi8ejLdmYQW0hgBaPE9YlZXYxc
        QPYXRolfK2eyQjifGSU6li1nhOl4++IjM0RiOaNE+843bHAtP//fAqtiEzCU6HrbxQZiiwjE
        Szzqv8sCUsQs8JhR4vi/U0wgCWGBJIklx++DFbEIqErs3XGeFcTmFbCV+HXpNgvEOnmJ1RsO
        gB3IKWAn8W/DcrDVEgLP2STWP5gHdZOLxOF5LewQtrDEq+NboGwZidOTe1ggGpoZJR6eW8sO
        4fQwSlxumgHVbS1x+PhFoNUcQPdpSqzfBQ0aR4kFd/+xgYQlBPgkbrwVBAkzA5mTtk1nhgjz
        SnS0CUFUq0nMOr4Obu3BC5eYIWwPidlzWtkhITSRUeLl1xPsExjlZyEsW8DIuIpRPLW0ODc9
        tdgoL7Vcrzgxt7g0L10vOT93EyMwPZz+d/zLDsZdf5IOMQpwMCrx8P5w/RUrxJpYVlyZe4hR
        goNZSYT3dsfPWCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4
        pRoYmS/xHXgYffDntu6+rRfftu0JmPXva5f0QeagjBzLbmOne/p1q7vmvHDI1ZjVcnr+Zq4u
        retHQ24GT32XsSD13rpUhwVlXw9eWxV39t2vZfrt1gHl915Z7DmRfnTu8+79FQbf39/3k39q
        99vRR9cvZINa9aGT/z1mvTn5RrnF47Ns/a+4pR8UjiixFGckGmoxFxUnAgCnR1W2CwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsVy+t/xu7qfTX7HGrS9U7XYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLy7vmsFl87j3CaDHj/D4mi7VH7rI7cHhsWtXJ5tG3ZRWjx+dNcgHMUXo2
        RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZq761Mhf0
        2Vd87epgbWCcp9/FyMkhIWAi8fbFR+YuRi4OIYGljBLtn9eyQiRkJE5Oa4CyhSX+XOtigyj6
        xCjx5V4PWIJNwFCi6y1IgpNDRCBRYvbH2WBFzAJPGSVWrZkCViQskCCxqaeTEcRmEVCV2Lvj
        PFicV8BW4tel2ywQG+QlVm84wAxicwrYSfzbsBzMFgKqWfb4EssERr4FjAyrGEVSS4tz03OL
        jfSKE3OLS/PS9ZLzczcxAoN127GfW3Ywdr0LPsQowMGoxMMb4PErVog1say4MvcQowQHs5II
        7+2On7FCvCmJlVWpRfnxRaU5qcWHGE2BjprILCWanA+MpLySeENTQ3MLS0NzY3NjMwslcd4O
        gYMxQgLpiSWp2ampBalFMH1MHJxSDYy7UvkYd600u8tsF+Ffm/kxOVumbycnO094z659Uxa0
        MskwL3X2/2IVrB0eGyd9yv5BZOvys+Gz399n+sT8cWmQUPOrs53vXi26mzcxL3HGd/cy4Ul3
        Llg9ZF1XcyP5ZMlW+f2uB/q32rqZvlb3e/B5VUywLf9rVl/GSPZFqVwWySenr7/qL6HEUpyR
        aKjFXFScCADZEWbubAIAAA==
X-CMS-MailID: 20191219082939eucas1p2afc32535df1512dc21ca983daa012568
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191219082939eucas1p2afc32535df1512dc21ca983daa012568
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219082939eucas1p2afc32535df1512dc21ca983daa012568
References: <20191219082927.11898-1-m.szyprowski@samsung.com>
        <CGME20191219082939eucas1p2afc32535df1512dc21ca983daa012568@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hardkernel's Odroid XU3/XU4/HC1 boards use bootloader, which configures top
PLLs to the following values: MPLL: 532MHz, CPLL: 666MHz and DPLL: 600MHz.

Adjust all bus related OPPs to the values that are possible to derive from
the top PLL configured by the bootloader. Also add a comment for each bus
describing which PLL is used for it.

The most significant change is the highest rate for wcore bus. It has been
increased to 532MHz as this is the value configured initially by the
bootloader. Also the voltage for this OPP is changed to match the value
set by the bootloader.

This patch finally allows the buses to operate on the rates matching the
values set for each OPP and fixes the following warnings observed on boot:

exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
...
exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)

The problem with setting incorrect (in some cases much lower) clock rate
for the defined OPP were there from the beginning, but went unnoticed
because the only way to observe it was to manually check the rate of the
respective clocks. The commit 4294a779bd8d ("PM / devfreq: exynos-bus:
Convert to use dev_pm_opp_set_rate()") finally revealed it, because it
enabled use of the generic code from the OPP framework, which issues the
above mentioned warnings.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 75 +++++++++++--------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 663a38d53c9e..b6d6022e8735 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -38,42 +38,44 @@
 	bus_wcore_opp_table: opp_table2 {
 		compatible = "operating-points-v2";
 
+		/* derived from 532MHz MPLL */
 		opp00 {
-			opp-hz = /bits/ 64 <84000000>;
+			opp-hz = /bits/ 64 <88700000>;
 			opp-microvolt = <925000 925000 1400000>;
 		};
 		opp01 {
-			opp-hz = /bits/ 64 <111000000>;
+			opp-hz = /bits/ 64 <133000000>;
 			opp-microvolt = <950000 950000 1400000>;
 		};
 		opp02 {
-			opp-hz = /bits/ 64 <222000000>;
+			opp-hz = /bits/ 64 <177400000>;
 			opp-microvolt = <950000 950000 1400000>;
 		};
 		opp03 {
-			opp-hz = /bits/ 64 <333000000>;
+			opp-hz = /bits/ 64 <266000000>;
 			opp-microvolt = <950000 950000 1400000>;
 		};
 		opp04 {
-			opp-hz = /bits/ 64 <400000000>;
-			opp-microvolt = <987500 987500 1400000>;
+			opp-hz = /bits/ 64 <532000000>;
+			opp-microvolt = <1000000 1000000 1400000>;
 		};
 	};
 
 	bus_noc_opp_table: opp_table3 {
 		compatible = "operating-points-v2";
 
+		/* derived from 666MHz CPLL */
 		opp00 {
-			opp-hz = /bits/ 64 <67000000>;
+			opp-hz = /bits/ 64 <66600000>;
 		};
 		opp01 {
-			opp-hz = /bits/ 64 <75000000>;
+			opp-hz = /bits/ 64 <74000000>;
 		};
 		opp02 {
-			opp-hz = /bits/ 64 <86000000>;
+			opp-hz = /bits/ 64 <83250000>;
 		};
 		opp03 {
-			opp-hz = /bits/ 64 <100000000>;
+			opp-hz = /bits/ 64 <111000000>;
 		};
 	};
 
@@ -81,39 +83,42 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		/* derived from 666MHz CPLL */
 		opp00 {
-			opp-hz = /bits/ 64 <100000000>;
+			opp-hz = /bits/ 64 <111000000>;
 		};
 		opp01 {
-			opp-hz = /bits/ 64 <200000000>;
+			opp-hz = /bits/ 64 <222000000>;
 		};
 	};
 
 	bus_fsys2_opp_table: opp_table5 {
 		compatible = "operating-points-v2";
 
+		/* derived from 600MHz DPLL */
 		opp00 {
 			opp-hz = /bits/ 64 <75000000>;
 		};
 		opp01 {
-			opp-hz = /bits/ 64 <100000000>;
+			opp-hz = /bits/ 64 <120000000>;
 		};
 		opp02 {
-			opp-hz = /bits/ 64 <150000000>;
+			opp-hz = /bits/ 64 <200000000>;
 		};
 	};
 
 	bus_mfc_opp_table: opp_table6 {
 		compatible = "operating-points-v2";
 
+		/* derived from 666MHz CPLL */
 		opp00 {
-			opp-hz = /bits/ 64 <96000000>;
+			opp-hz = /bits/ 64 <83250000>;
 		};
 		opp01 {
 			opp-hz = /bits/ 64 <111000000>;
 		};
 		opp02 {
-			opp-hz = /bits/ 64 <167000000>;
+			opp-hz = /bits/ 64 <166500000>;
 		};
 		opp03 {
 			opp-hz = /bits/ 64 <222000000>;
@@ -126,8 +131,9 @@
 	bus_gen_opp_table: opp_table7 {
 		compatible = "operating-points-v2";
 
+		/* derived from 532MHz MPLL */
 		opp00 {
-			opp-hz = /bits/ 64 <89000000>;
+			opp-hz = /bits/ 64 <88700000>;
 		};
 		opp01 {
 			opp-hz = /bits/ 64 <133000000>;
@@ -136,32 +142,34 @@
 			opp-hz = /bits/ 64 <178000000>;
 		};
 		opp03 {
-			opp-hz = /bits/ 64 <267000000>;
+			opp-hz = /bits/ 64 <266000000>;
 		};
 	};
 
 	bus_peri_opp_table: opp_table8 {
 		compatible = "operating-points-v2";
 
+		/* derived from 666MHz CPLL */
 		opp00 {
-			opp-hz = /bits/ 64 <67000000>;
+			opp-hz = /bits/ 64 <66600000>;
 		};
 	};
 
 	bus_g2d_opp_table: opp_table9 {
 		compatible = "operating-points-v2";
 
+		/* derived from 666MHz CPLL */
 		opp00 {
-			opp-hz = /bits/ 64 <84000000>;
+			opp-hz = /bits/ 64 <83250000>;
 		};
 		opp01 {
-			opp-hz = /bits/ 64 <167000000>;
+			opp-hz = /bits/ 64 <111000000>;
 		};
 		opp02 {
-			opp-hz = /bits/ 64 <222000000>;
+			opp-hz = /bits/ 64 <166500000>;
 		};
 		opp03 {
-			opp-hz = /bits/ 64 <300000000>;
+			opp-hz = /bits/ 64 <222000000>;
 		};
 		opp04 {
 			opp-hz = /bits/ 64 <333000000>;
@@ -171,8 +179,9 @@
 	bus_g2d_acp_opp_table: opp_table10 {
 		compatible = "operating-points-v2";
 
+		/* derived from 532MHz MPLL */
 		opp00 {
-			opp-hz = /bits/ 64 <67000000>;
+			opp-hz = /bits/ 64 <66500000>;
 		};
 		opp01 {
 			opp-hz = /bits/ 64 <133000000>;
@@ -181,13 +190,14 @@
 			opp-hz = /bits/ 64 <178000000>;
 		};
 		opp03 {
-			opp-hz = /bits/ 64 <267000000>;
+			opp-hz = /bits/ 64 <266000000>;
 		};
 	};
 
 	bus_jpeg_opp_table: opp_table11 {
 		compatible = "operating-points-v2";
 
+		/* derived from 600MHz DPLL */
 		opp00 {
 			opp-hz = /bits/ 64 <75000000>;
 		};
@@ -205,23 +215,25 @@
 	bus_jpeg_apb_opp_table: opp_table12 {
 		compatible = "operating-points-v2";
 
+		/* derived from 666MHz CPLL */
 		opp00 {
-			opp-hz = /bits/ 64 <84000000>;
+			opp-hz = /bits/ 64 <83250000>;
 		};
 		opp01 {
 			opp-hz = /bits/ 64 <111000000>;
 		};
 		opp02 {
-			opp-hz = /bits/ 64 <134000000>;
+			opp-hz = /bits/ 64 <133000000>;
 		};
 		opp03 {
-			opp-hz = /bits/ 64 <167000000>;
+			opp-hz = /bits/ 64 <166500000>;
 		};
 	};
 
 	bus_disp1_fimd_opp_table: opp_table13 {
 		compatible = "operating-points-v2";
 
+		/* derived from 600MHz DPLL */
 		opp00 {
 			opp-hz = /bits/ 64 <120000000>;
 		};
@@ -233,6 +245,7 @@
 	bus_disp1_opp_table: opp_table14 {
 		compatible = "operating-points-v2";
 
+		/* derived from 600MHz DPLL */
 		opp00 {
 			opp-hz = /bits/ 64 <120000000>;
 		};
@@ -247,6 +260,7 @@
 	bus_gscl_opp_table: opp_table15 {
 		compatible = "operating-points-v2";
 
+		/* derived from 600MHz DPLL */
 		opp00 {
 			opp-hz = /bits/ 64 <150000000>;
 		};
@@ -261,6 +275,7 @@
 	bus_mscl_opp_table: opp_table16 {
 		compatible = "operating-points-v2";
 
+		/* derived from 666MHz CPLL */
 		opp00 {
 			opp-hz = /bits/ 64 <84000000>;
 		};
@@ -274,7 +289,7 @@
 			opp-hz = /bits/ 64 <333000000>;
 		};
 		opp04 {
-			opp-hz = /bits/ 64 <400000000>;
+			opp-hz = /bits/ 64 <666000000>;
 		};
 	};
 
@@ -398,7 +413,7 @@
 };
 
 &bus_fsys {
-	operating-points-v2 = <&bus_fsys_apb_opp_table>;
+	operating-points-v2 = <&bus_fsys2_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
-- 
2.17.1

