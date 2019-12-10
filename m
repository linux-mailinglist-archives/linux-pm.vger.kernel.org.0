Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74B911869C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 12:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfLJLkp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 06:40:45 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38230 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfLJLkj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 06:40:39 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191210114037euoutp027a2bdd71b432a030cc41a9e89d9424c9~e-6zvs1i22617226172euoutp02z
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 11:40:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191210114037euoutp027a2bdd71b432a030cc41a9e89d9424c9~e-6zvs1i22617226172euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575978037;
        bh=wQumKIz1maChZun8tmgFpr9OpnB118sw+oCKKMdPaeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeDtc70akSeotTCIMJII6fyITMnU2aHLnxVdOVJMpKZX5zt68CDemkgUWAOwPgeQv
         8Jtaxgnp8tLkF2KuaGgZ2DfCWIelYaJfF+AmMPCvz8zv2SLI4brmxJVfiMjeZrpZ5R
         7i8POYtstMRcgHgtqhqPch9ZDOuw/94IGiSckf80=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191210114037eucas1p137f80e019179a09b752aa0c7de24743a~e-6zgHOQ70524805248eucas1p1e;
        Tue, 10 Dec 2019 11:40:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CC.69.61286.5348FED5; Tue, 10
        Dec 2019 11:40:37 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191210114036eucas1p2fe31f68148688632d983e27bed12e7d8~e-6y1t8ej2394423944eucas1p2g;
        Tue, 10 Dec 2019 11:40:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191210114036eusmtrp2792869c1c710493ebca4e851a4aef52b~e-6y0_6lT2532425324eusmtrp2y;
        Tue, 10 Dec 2019 11:40:36 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-32-5def8435d843
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 81.90.07950.4348FED5; Tue, 10
        Dec 2019 11:40:36 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191210114036eusmtip12721cedc71aefb72d1f94113f0eacde9~e-6yUf0Qh2202222022eusmtip1E;
        Tue, 10 Dec 2019 11:40:36 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Andreas Faerber <afaerber@suse.de>,
        Arjun K V <arjun.kv@samsung.com>
Subject: [PATCH 2/2] ARM: dts: exynos: Add missing CPU frequencies for
 Exynos5422/5800
Date:   Tue, 10 Dec 2019 12:40:27 +0100
Message-Id: <20191210114027.14910-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210114027.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTURjn7Hk1F9cp+WGmsNBQUFtZ3DDFIHF/FEhBaCC28qLi5mPXWSaB
        ZmmubCaYQ6WWrWbzMV0+aki6aQ4y3dRMwxQMQRLN8kmY1rY787/f6zu/7xwOxuQr2b5YemYu
        KcsUSwQcd1bnwG9r6Ik7y0lH27R+RLGBIrSvjCyiTaVnExNr82xi6KWJQ6hXVGzCam3lEmPG
        Og6xWt6PCJX1HYNo7p/mxuwT1RaOsEQGXRlH9LBdh0SvBwtEqwb/ePZl99MppCQ9j5SFR19x
        T5vqaOJk68/fmNCXo0I0EqFAbhjgEXC/SsNQIHeMjzcg+GnSsGmyhmBrcYNJk1UEhT0GtDsy
        oh9zGVoEy8v1eyMl6iGmI8XBhaBYUnAc2BtPhm/KaZYjxMRHGaAp2uQ6DC88AV5ovjoxCw+E
        vqn3TszDo8DaYmPTdQHQ2NrrPNQNj4bKRaVzW8BLubDd28yiQ2fhedkXLo29YMHS7sJ+8Pft
        U9dAMYLZ4WYuTR4gGLutct0oEvosI/Y6zL5fMOiN4bR8BopmTAyHDPh+mFzydMhMO6zsrGbS
        Mg/ulfDpdBDUWFr+15pso66ICKwfg+gHeoSgebgCVaCAmr0uNUI65EPKKWkqSQkzyethlFhK
        yTNTw65lSQ3I/k0Gdywrb9D66FUzwjEk8OCpY34k8dniPCpfakaAMQXePEuJXeKliPNvkrKs
        ZJlcQlJmdBBjCXx4x+u/J/HxVHEumUGS2aRs12Vgbr6FqPpQz6K/KTFH3uGxtQOW9u75rq4B
        8bige3zO3FL5JxRTXNTlfZZuRJQdWNwuupWyeVeanUBMRtZ4Lg8pehoX4gr8w3J+rT8JPJx9
        QVj8zPbhsfZY1cyRKWND42xd1QJFzNpO1mouTUbFJSpL57SnBJL4pli9Lbj13Cd+bEgGCFhU
        mlgYwpRR4n/acYtEIgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsVy+t/xu7omLe9jDT4/N7Bo3lRssXzlLhaL
        jTPWs1pc//Kc1eLssoNsFgs+zWC1OH9+A7vF5V1z2Cw+9x5htJhxfh+Txdojd9kduD1mN1xk
        8di0qpPNo2/LKkaPzaerPT5vkgtgjdKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1
        MjJV0rezSUnNySxLLdK3S9DLuL11DVvBet+K6+t7GRsYL5p0MXJySAiYSFxcf5m5i5GLQ0hg
        KaPE5oZfLBAJGYmT0xpYIWxhiT/Xutggij4xSlxd/w0swSZgKNH1FiTBySEikCgx++NssCJm
        gRtMEpfezmECSQgLhEnM+LUSrIFFQFXi8O2j7CA2r4CtxPl1F6A2yEus3nCAGcTmFLCTmPSm
        H6xXCKhmy9IpzBMY+RYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIDO1tx35u2cHY9S74
        EKMAB6MSD+8Ch3exQqyJZcWVuYcYJTiYlUR4j7cBhXhTEiurUovy44tKc1KLDzGaAh01kVlK
        NDkfGHd5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYxetrJpS3
        3Ja2jbGaHjrvzMmrV/dvMZ8TVGf8umD94ZS6g5OZin6V3LLbMSXw/rr2KN/P+6/dkBAw+Mh0
        f534U88pv69eOGq01z7/dZHOxk9mO6+aH04tlfXhPvtislPQE73kpaJpEUudDPcz3FnyiXnb
        8q7ZWdxfk4r0T2mk1a/3Mt3GlP5EXomlOCPRUIu5qDgRAPs19sCDAgAA
X-CMS-MailID: 20191210114036eucas1p2fe31f68148688632d983e27bed12e7d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191210114036eucas1p2fe31f68148688632d983e27bed12e7d8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191210114036eucas1p2fe31f68148688632d983e27bed12e7d8
References: <20191210114027.14910-1-m.szyprowski@samsung.com>
        <CGME20191210114036eucas1p2fe31f68148688632d983e27bed12e7d8@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Add missing 2.0GHz, 1.9GHz & 1.8GHz OPPs (for A15 cores) and 1.4GHz
OPP (for A7 cores).  Also update common Odroid-XU3 Lite/XU3/XU4
thermal cooling maps to account for new OPPs.

Since some new OPPs are not available on all Exynos5422/5800 boards
modify dts files for Odroid XU3 Lite (limited to 1.8 GHz / 1.3 GHz) &
Peach Pi (limited to 2.0 GHz / 1.3 GHz) accordingly.

This patch uses maximum voltages for new OPPs. This is a temporary
solution till proper Exynos ASV support is added.

Also while at it fix the number of cooling down steps for big cores
(should be 11 instead of 12 on Odroid XU3 Lite and 14 on XU3/XU4).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[mszyprow: rebased onto v5.5-rc1 and adapted to recent dts changes,
 fixed removal of the 1.4GHz OPP for A7s on Peach-Pi]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Based on the patch from 15th Dec 2016:
https://patchwork.kernel.org/patch/9475909/
---
 arch/arm/boot/dts/exynos5422-odroidhc1.dts    | 64 +++++++--------
 .../boot/dts/exynos5422-odroidxu3-common.dtsi | 78 +++++++++----------
 .../boot/dts/exynos5422-odroidxu3-lite.dts    | 58 ++++++++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |  9 +++
 arch/arm/boot/dts/exynos5800.dtsi             | 20 +++++
 5 files changed, 158 insertions(+), 71 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidhc1.dts b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
index d271e7548826..f163206265bb 100644
--- a/arch/arm/boot/dts/exynos5422-odroidhc1.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
@@ -72,14 +72,14 @@
 				 */
 				map1 {
 					trip = <&cpu0_alert1>;
-					cooling-device = <&cpu0 3 7>,
-							 <&cpu1 3 7>,
-							 <&cpu2 3 7>,
-							 <&cpu3 3 7>,
-							 <&cpu4 3 12>,
-							 <&cpu5 3 12>,
-							 <&cpu6 3 12>,
-							 <&cpu7 3 12>;
+					cooling-device = <&cpu0 3 8>,
+							 <&cpu1 3 8>,
+							 <&cpu2 3 8>,
+							 <&cpu3 3 8>,
+							 <&cpu4 3 14>,
+							 <&cpu5 3 14>,
+							 <&cpu6 3 14>,
+							 <&cpu7 3 14>;
 				};
 			};
 		};
@@ -116,14 +116,14 @@
 				};
 				map1 {
 					trip = <&cpu1_alert1>;
-					cooling-device = <&cpu0 3 7>,
-							 <&cpu1 3 7>,
-							 <&cpu2 3 7>,
-							 <&cpu3 3 7>,
-							 <&cpu4 3 12>,
-							 <&cpu5 3 12>,
-							 <&cpu6 3 12>,
-							 <&cpu7 3 12>;
+					cooling-device = <&cpu0 3 8>,
+							 <&cpu1 3 8>,
+							 <&cpu2 3 8>,
+							 <&cpu3 3 8>,
+							 <&cpu4 3 14>,
+							 <&cpu5 3 14>,
+							 <&cpu6 3 14>,
+							 <&cpu7 3 14>;
 				};
 			};
 		};
@@ -160,14 +160,14 @@
 				};
 				map1 {
 					trip = <&cpu2_alert1>;
-					cooling-device = <&cpu0 3 7>,
-							 <&cpu1 3 7>,
-							 <&cpu2 3 7>,
-							 <&cpu3 3 7>,
-							 <&cpu4 3 12>,
-							 <&cpu5 3 12>,
-							 <&cpu6 3 12>,
-							 <&cpu7 3 12>;
+					cooling-device = <&cpu0 3 8>,
+							 <&cpu1 3 8>,
+							 <&cpu2 3 8>,
+							 <&cpu3 3 8>,
+							 <&cpu4 3 14>,
+							 <&cpu5 3 14>,
+							 <&cpu6 3 14>,
+							 <&cpu7 3 14>;
 				};
 			};
 		};
@@ -204,14 +204,14 @@
 				};
 				map1 {
 					trip = <&cpu3_alert1>;
-					cooling-device = <&cpu0 3 7>,
-							 <&cpu1 3 7>,
-							 <&cpu2 3 7>,
-							 <&cpu3 3 7>,
-							 <&cpu4 3 12>,
-							 <&cpu5 3 12>,
-							 <&cpu6 3 12>,
-							 <&cpu7 3 12>;
+					cooling-device = <&cpu0 3 8>,
+							 <&cpu1 3 8>,
+							 <&cpu2 3 8>,
+							 <&cpu3 3 8>,
+							 <&cpu4 3 14>,
+							 <&cpu5 3 14>,
+							 <&cpu6 3 14>,
+							 <&cpu7 3 14>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 838872037493..1865a708b49f 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -107,7 +107,7 @@
 				/*
 				 * When reaching cpu0_alert3, reduce CPU
 				 * by 2 steps. On Exynos5422/5800 that would
-				 * be: 1600 MHz and 1100 MHz.
+				 * (usually) be: 1800 MHz and 1200 MHz.
 				 */
 				map3 {
 					trip = <&cpu0_alert3>;
@@ -122,19 +122,19 @@
 				};
 				/*
 				 * When reaching cpu0_alert4, reduce CPU
-				 * further, down to 600 MHz (12 steps for big,
-				 * 7 steps for LITTLE).
+				 * further, down to 600 MHz (14 steps for big,
+				 * 8 steps for LITTLE).
 				 */
-				map4 {
+				cpu0_cooling_map4: map4 {
 					trip = <&cpu0_alert4>;
-					cooling-device = <&cpu0 3 7>,
-							 <&cpu1 3 7>,
-							 <&cpu2 3 7>,
-							 <&cpu3 3 7>,
-							 <&cpu4 3 12>,
-							 <&cpu5 3 12>,
-							 <&cpu6 3 12>,
-							 <&cpu7 3 12>;
+					cooling-device = <&cpu0 3 8>,
+							 <&cpu1 3 8>,
+							 <&cpu2 3 8>,
+							 <&cpu3 3 8>,
+							 <&cpu4 3 14>,
+							 <&cpu5 3 14>,
+							 <&cpu6 3 14>,
+							 <&cpu7 3 14>;
 				};
 			};
 		};
@@ -198,16 +198,16 @@
 							 <&cpu6 0 2>,
 							 <&cpu7 0 2>;
 				};
-				map4 {
+				cpu1_cooling_map4: map4 {
 					trip = <&cpu1_alert4>;
-					cooling-device = <&cpu0 3 7>,
-							 <&cpu1 3 7>,
-							 <&cpu2 3 7>,
-							 <&cpu3 3 7>,
-							 <&cpu4 3 12>,
-							 <&cpu5 3 12>,
-							 <&cpu6 3 12>,
-							 <&cpu7 3 12>;
+					cooling-device = <&cpu0 3 8>,
+							 <&cpu1 3 8>,
+							 <&cpu2 3 8>,
+							 <&cpu3 3 8>,
+							 <&cpu4 3 14>,
+							 <&cpu5 3 14>,
+							 <&cpu6 3 14>,
+							 <&cpu7 3 14>;
 				};
 			};
 		};
@@ -271,16 +271,16 @@
 							 <&cpu6 0 2>,
 							 <&cpu7 0 2>;
 				};
-				map4 {
+				cpu2_cooling_map4: map4 {
 					trip = <&cpu2_alert4>;
-					cooling-device = <&cpu0 3 7>,
-							 <&cpu1 3 7>,
-							 <&cpu2 3 7>,
-							 <&cpu3 3 7>,
-							 <&cpu4 3 12>,
-							 <&cpu5 3 12>,
-							 <&cpu6 3 12>,
-							 <&cpu7 3 12>;
+					cooling-device = <&cpu0 3 8>,
+							 <&cpu1 3 8>,
+							 <&cpu2 3 8>,
+							 <&cpu3 3 8>,
+							 <&cpu4 3 14>,
+							 <&cpu5 3 14>,
+							 <&cpu6 3 14>,
+							 <&cpu7 3 14>;
 				};
 			};
 		};
@@ -344,16 +344,16 @@
 							 <&cpu6 0 2>,
 							 <&cpu7 0 2>;
 				};
-				map4 {
+				cpu3_cooling_map4: map4 {
 					trip = <&cpu3_alert4>;
-					cooling-device = <&cpu0 3 7>,
-							 <&cpu1 3 7>,
-							 <&cpu2 3 7>,
-							 <&cpu3 3 7>,
-							 <&cpu4 3 12>,
-							 <&cpu5 3 12>,
-							 <&cpu6 3 12>,
-							 <&cpu7 3 12>;
+					cooling-device = <&cpu0 3 8>,
+							 <&cpu1 3 8>,
+							 <&cpu2 3 8>,
+							 <&cpu3 3 8>,
+							 <&cpu4 3 14>,
+							 <&cpu5 3 14>,
+							 <&cpu6 3 14>,
+							 <&cpu7 3 14>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
index a31ca2ef750f..98feecad5489 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
@@ -30,6 +30,64 @@
 	samsung,asv-bin = <2>;
 };
 
+/*
+ * Odroid XU3-Lite board uses SoC revision with lower maximum frequencies
+ * than Odroid XU3/XU4 boards: 1.8 GHz for A15 cores & 1.3 GHz for A7 cores.
+ * Therefore we need to update OPPs tables and thermal maps accordingly.
+ */
+&cluster_a15_opp_table {
+	/delete-node/opp-2000000000;
+	/delete-node/opp-1900000000;
+};
+
+&cluster_a7_opp_table {
+	/delete-node/opp-1400000000;
+};
+
+&cpu0_cooling_map4 {
+	cooling-device = <&cpu0 3 7>,
+			 <&cpu1 3 7>,
+			 <&cpu2 3 7>,
+			 <&cpu3 3 7>,
+			 <&cpu4 3 12>,
+			 <&cpu5 3 12>,
+			 <&cpu6 3 12>,
+			 <&cpu7 3 12>;
+};
+
+&cpu1_cooling_map4 {
+	cooling-device = <&cpu0 3 7>,
+			 <&cpu1 3 7>,
+			 <&cpu2 3 7>,
+			 <&cpu3 3 7>,
+			 <&cpu4 3 12>,
+			 <&cpu5 3 12>,
+			 <&cpu6 3 12>,
+			 <&cpu7 3 12>;
+};
+
+&cpu2_cooling_map4 {
+	cooling-device = <&cpu0 3 7>,
+			 <&cpu1 3 7>,
+			 <&cpu2 3 7>,
+			 <&cpu3 3 7>,
+			 <&cpu4 3 12>,
+			 <&cpu5 3 12>,
+			 <&cpu6 3 12>,
+			 <&cpu7 3 12>;
+};
+
+&cpu3_cooling_map4 {
+	cooling-device = <&cpu0 3 7>,
+			 <&cpu1 3 7>,
+			 <&cpu2 3 7>,
+			 <&cpu3 3 7>,
+			 <&cpu4 3 12>,
+			 <&cpu5 3 12>,
+			 <&cpu6 3 12>,
+			 <&cpu7 3 12>;
+};
+
 &pwm {
 	/*
 	 * PWM 0 -- fan
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index c1e38139ce4f..60ab0effe474 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -156,6 +156,15 @@
 	assigned-clock-parents = <&clock CLK_MAU_EPLL>;
 };
 
+/*
+ * Peach Pi board uses SoC revision with lower maximum frequency for A7 cores
+ * (1.3 GHz instead of 1.4 GHz) than Odroid XU3/XU4 boards.  Thus we need to
+ * update A7 OPPs table accordingly.
+ */
+&cluster_a7_opp_table {
+	/delete-node/opp-1400000000;
+};
+
 &cpu0 {
 	cpu-supply = <&buck2_reg>;
 };
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index 1be7eb60439a..b4fd53496450 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -21,6 +21,21 @@
 };
 
 &cluster_a15_opp_table {
+	opp-2000000000 {
+		opp-hz = /bits/ 64 <2000000000>;
+		opp-microvolt = <1312500>;
+		clock-latency-ns = <140000>;
+	};
+	opp-1900000000 {
+		opp-hz = /bits/ 64 <1900000000>;
+		opp-microvolt = <1262500>;
+		clock-latency-ns = <140000>;
+	};
+	opp-1800000000 {
+		opp-hz = /bits/ 64 <1800000000>;
+		opp-microvolt = <1237500>;
+		clock-latency-ns = <140000>;
+	};
 	opp-1700000000 {
 		opp-microvolt = <1250000 1250000 1500000>;
 	};
@@ -82,6 +97,11 @@
 };
 
 &cluster_a7_opp_table {
+	opp-1400000000 {
+		opp-hz = /bits/ 64 <1400000000>;
+		opp-microvolt = <1275000>;
+		clock-latency-ns = <140000>;
+	};
 	opp-1300000000 {
 		opp-microvolt = <1250000>;
 	};
-- 
2.17.1

