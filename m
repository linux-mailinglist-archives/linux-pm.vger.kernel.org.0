Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD9DC125FE7
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 11:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLSKvj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 05:51:39 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40681 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfLSKvj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 05:51:39 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191219105137euoutp02e88498440f61e48af879a47baa777ed8~hwDl0BmQs1376513765euoutp02i
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 10:51:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191219105137euoutp02e88498440f61e48af879a47baa777ed8~hwDl0BmQs1376513765euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576752697;
        bh=WBtsaDEVNd8eeFgqlk4a/0JRbkQds+n9ahQDvfn0EN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rMCDR0ZhMu8c9WtRxx91P08V9h64KoOqS5k2F0OSaOpe5DSMWIOjlek9QNveUDTYA
         mC/ykXV+hKMKs/y+ZeROMoHb9azAL6w3qch/z1MXMrtJsuW/DW2zHIWPj8XXqm4zF5
         d1vQLskEdBFvJEUYDhP3c+tjeigittxAocpdJXDo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191219105137eucas1p101428355f681f902764d51666f599edf~hwDld67z-0263802638eucas1p14;
        Thu, 19 Dec 2019 10:51:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 71.5D.61286.9365BFD5; Thu, 19
        Dec 2019 10:51:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191219105136eucas1p1d57974e96a166308b4a692d1783936f8~hwDlLfFez1661716617eucas1p1d;
        Thu, 19 Dec 2019 10:51:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191219105136eusmtrp13576b167db5d6170410d93c3afbe9a0d~hwDlK9ME82881728817eusmtrp1J;
        Thu, 19 Dec 2019 10:51:36 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-fb-5dfb5639d78a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 55.BB.08375.8365BFD5; Thu, 19
        Dec 2019 10:51:36 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191219105136eusmtip10570ec51d5291a0b5d14c54980f0d23c~hwDkrBorF0221702217eusmtip1n;
        Thu, 19 Dec 2019 10:51:36 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 2/2] ARM: dts: exynos: Adjust bus related OPPs to the
 values correct for Odroids
Date:   Thu, 19 Dec 2019 11:51:30 +0100
Message-Id: <20191219105130.29394-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219105130.29394-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djPc7qWYb9jDVZuZrXYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLy7vmsFl87j3CaDHj/D4mi7VH7rI7cHhsWtXJ5tG3ZRWjx+dNcgHMUVw2
        Kak5mWWpRfp2CVwZP3evZi5odag4cOAHcwNjt0EXIyeHhICJxKYHsxi7GLk4hARWMEq0X/rM
        AuF8YZRYcOE8lPOZUaJ3VSc7TMvTpg2sEInljBJtF1axwrXcn3GEEaSKTcBQouttFxuILSIQ
        L/Go/y7YKGaBx4wSx/+dYgJJCAukSkzf/hKom4ODRUBV4t91GZAwr4CtxJnbXSwQ2+QlVm84
        wAxicwrYSVz4vJYJZI6EwGs2ic275kIVuUj8Pd3OCmELS7w6vgXqVBmJ05N7WCAamhklHp5b
        yw7h9DBKXG6awQhRZS1x+PhFsCuYBTQl1u/Shwg7Stxe2MsOEpYQ4JO48VYQJMwMZE7aNp0Z
        Iswr0dEmBFGtJjHr+Dq4tQcvXGKGsD0k5j7dBWYLCUwEOuFN4QRG+VkIuxYwMq5iFE8tLc5N
        Ty02zEst1ytOzC0uzUvXS87P3cQITA6n/x3/tIPx66WkQ4wCHIxKPLw/XH/FCrEmlhVX5h5i
        lOBgVhLhvd3xM1aINyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYO
        TqkGxhzNH780eur/sl07Oq8umcdrzobso+vLWhr/TdbJfnND7XPQSTOD9LPuv8XiDjLvZnm1
        +M3LsrlL65Ydc0tZxqf/+9HvSaZzgl/tXhoVdGyd7cWzSplPMrkUbkkuPsZ7KefC3OfMDzfe
        c2/StJsrPGHh8hmlV+v//p+nUauksK4wPXhl8IzgtwFKLMUZiYZazEXFiQAO80ETCgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsVy+t/xu7oWYb9jDQ4t1bfYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLy7vmsFl87j3CaDHj/D4mi7VH7rI7cHhsWtXJ5tG3ZRWjx+dNcgHMUXo2
        RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZP3evZi5o
        dag4cOAHcwNjt0EXIyeHhICJxNOmDawgtpDAUkaJ7xf8IeIyEienNbBC2MISf651sXUxcgHV
        fGKUaHy4GizBJmAo0fUWJMHJISKQKDH742ywImaBp4wSq9ZMASsSFkiWOLHmL3MXIwcHi4Cq
        xL/rMiBhXgFbiTO3u1ggFshLrN5wgBnE5hSwk7jweS0TxEG2ErvnLmOcwMi3gJFhFaNIamlx
        bnpusaFecWJucWleul5yfu4mRmCgbjv2c/MOxksbgw8xCnAwKvHw/nD9FSvEmlhWXJl7iFGC
        g1lJhPd2x89YId6UxMqq1KL8+KLSnNTiQ4ymQDdNZJYSTc4HRlFeSbyhqaG5haWhubG5sZmF
        kjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGgNy5vIKeqzgsC5KbJjuUt2hU7X+fNjnk9akF
        InNSNia6G0x37a006Uq1NvjLt+NCjoK8k9GDptC9PLp39FyTftx+N2HPfOdZp++kfJ4pK/73
        6q5+l/8m/74W/TtTl/dIx3yH1I+sxDkRymcjHdzCLXMYchrWlr/Mrl5RM5Ez+rDLup0iBpOU
        WIozEg21mIuKEwGaFnqsagIAAA==
X-CMS-MailID: 20191219105136eucas1p1d57974e96a166308b4a692d1783936f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191219105136eucas1p1d57974e96a166308b4a692d1783936f8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219105136eucas1p1d57974e96a166308b4a692d1783936f8
References: <20191219105130.29394-1-m.szyprowski@samsung.com>
        <CGME20191219105136eucas1p1d57974e96a166308b4a692d1783936f8@eucas1p1.samsung.com>
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
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 76 +++++++++++--------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 5fb771680e98..5cf1aed20490 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -38,82 +38,86 @@
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
 
 	bus_fsys_apb_opp_table: opp_table4 {
 		compatible = "operating-points-v2";
-		opp-shared;
 
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
@@ -126,8 +130,9 @@
 	bus_gen_opp_table: opp_table7 {
 		compatible = "operating-points-v2";
 
+		/* derived from 532MHz MPLL */
 		opp00 {
-			opp-hz = /bits/ 64 <89000000>;
+			opp-hz = /bits/ 64 <88700000>;
 		};
 		opp01 {
 			opp-hz = /bits/ 64 <133000000>;
@@ -136,32 +141,34 @@
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
@@ -171,8 +178,9 @@
 	bus_g2d_acp_opp_table: opp_table10 {
 		compatible = "operating-points-v2";
 
+		/* derived from 532MHz MPLL */
 		opp00 {
-			opp-hz = /bits/ 64 <67000000>;
+			opp-hz = /bits/ 64 <66500000>;
 		};
 		opp01 {
 			opp-hz = /bits/ 64 <133000000>;
@@ -181,13 +189,14 @@
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
@@ -205,23 +214,25 @@
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
@@ -233,6 +244,7 @@
 	bus_disp1_opp_table: opp_table14 {
 		compatible = "operating-points-v2";
 
+		/* derived from 600MHz DPLL */
 		opp00 {
 			opp-hz = /bits/ 64 <120000000>;
 		};
@@ -247,6 +259,7 @@
 	bus_gscl_opp_table: opp_table15 {
 		compatible = "operating-points-v2";
 
+		/* derived from 600MHz DPLL */
 		opp00 {
 			opp-hz = /bits/ 64 <150000000>;
 		};
@@ -261,6 +274,7 @@
 	bus_mscl_opp_table: opp_table16 {
 		compatible = "operating-points-v2";
 
+		/* derived from 666MHz CPLL */
 		opp00 {
 			opp-hz = /bits/ 64 <84000000>;
 		};
@@ -274,7 +288,7 @@
 			opp-hz = /bits/ 64 <333000000>;
 		};
 		opp04 {
-			opp-hz = /bits/ 64 <400000000>;
+			opp-hz = /bits/ 64 <666000000>;
 		};
 	};
 
@@ -398,7 +412,7 @@
 };
 
 &bus_fsys {
-	operating-points-v2 = <&bus_fsys_apb_opp_table>;
+	operating-points-v2 = <&bus_fsys2_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
-- 
2.17.1

