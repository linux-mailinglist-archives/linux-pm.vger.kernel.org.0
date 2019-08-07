Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA20484D9F
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 15:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388530AbfHGNjC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 09:39:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58169 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388480AbfHGNjB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 09:39:01 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190807133900euoutp013797e504a1f72e96e3dd1988bfe8cf93~4p5ed_7wf2498224982euoutp01B
        for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2019 13:39:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190807133900euoutp013797e504a1f72e96e3dd1988bfe8cf93~4p5ed_7wf2498224982euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565185140;
        bh=MPIjTyHieD2gGpsaXd2KwE9jDzTxd4a6XuBnBOBEIew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRd+lspbjBUvjN27E6OXuVdyOaBKpuNnFWliS8z8qezcBk/UGaQeM9UHRzEPE3sqs
         AEA7Kotr9L2dONSW0xVGNa5AxEVSe+5StfgWcJOpEKtCdBSQA6fdzp/L323C3/LeyR
         QD7QoAMnQUDT1e53Z36Ayqy3Z+DgkPnIag3/dQVI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190807133859eucas1p27583edae9e862600f647c69bfd19e23f~4p5di1FqP1798117981eucas1p2h;
        Wed,  7 Aug 2019 13:38:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 70.29.04309.274DA4D5; Wed,  7
        Aug 2019 14:38:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190807133858eucas1p28b272aa9a8dbbd95830f70098e25325a~4p5c0VeXj1099710997eucas1p2r;
        Wed,  7 Aug 2019 13:38:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190807133858eusmtrp26a80c933af4fa93bcfb91d65fe4c5b14~4p5cmF8-z0146501465eusmtrp2K;
        Wed,  7 Aug 2019 13:38:58 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-ad-5d4ad4729680
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1E.0F.04117.174DA4D5; Wed,  7
        Aug 2019 14:38:58 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190807133857eusmtip292ac6b938e88a2efec109082d9eb389e~4p5bzpqz11919719197eusmtip2d;
        Wed,  7 Aug 2019 13:38:57 +0000 (GMT)
From:   k.konieczny@partner.samsung.com
To:     k.konieczny@partner.samsung.com
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v5 3/4] ARM: dts: exynos: add initial data for coupled
 regulators for Exynos5422/5800
Date:   Wed,  7 Aug 2019 15:38:37 +0200
Message-Id: <20190807133838.14678-4-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190807133838.14678-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djPc7pFV7xiDebeNrPYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB7FZZOSmpNZllqkb5fAlXHivW/BCZuKOQvesDcw3tDrYuTkkBAw
        kfi/8yBzFyMXh5DACkaJYx2/2SCcL4wSu152QGU+M0rM39XGDtPy+PobRojEcqCWe+/Z4Vo6
        FjezgVSxCahKbJnxEqxDREBZYvK96WCjmAV+skic3tXMCpIQFkiXeN+7BqyIBajh4bw+li5G
        Dg5eAReJtQf0IbbJS3Tu2M0CYnMKuEp83TuBEcTmFRCUODnzCVicGaimeetssPkSAm/ZJVqn
        /WWBaHaReHiglw3CFpZ4dXwL1AsyQF/PZ4KwyyWeLuxjh2huYZR40P4Rqtla4vDxi6wgBzEL
        aEqs3wV1kKPEmXf9YGEJAT6JG28FIW7gk5i0DeRHkDCvREebEES1rsS8/2dYIWxpia7/66Bs
        D4k535cxT2BUnIXkm1lIvpmFsHcBI/MqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwFR3
        +t/xLzsYd/1JOsQowMGoxMPLcMErVog1say4MvcQowQHs5II770yz1gh3pTEyqrUovz4otKc
        1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjA3XDHvys4pjo/eff/m7qlxtirPw
        kg0pDcf2SCpcbnu35ttSmZeLXCbE/WISTXWN5+tcz6OtlptcXFNzZJ+inZG67rzPpzLPr0zN
        nnnpzqrKg8bCyyQ5W/Z5CO3ysDRZvkxogXXIsr27SsJXnN3PKykbsSk18sKJF+f6On/+dZd9
        s2pxj5+xjRJLcUaioRZzUXEiAK7ejmpxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7pFV7xiDVZPZrLYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB6lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5egl3HivW/BCZuKOQvesDcw3tDrYuTkkBAwkXh8/Q1jFyMXh5DAUkaJeZ9X
        M0EkpCUaT8PYwhJ/rnWxQRR9YpR4/OkZI0iCTUBVYsuMl+wgtoiAssTke9OZQYqYBTpZJZZM
        +guWEBZIlZjbNAdsEgtQw8N5fSxdjBwcvAIuEmsP6EMskJfo3LGbBcTmFHCV+Lp3Ath8IaCS
        RQc3grXyCghKnJz5BKyGGai+eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltspFecmFtcmpeu
        l5yfu4kRGJPbjv3csoOx613wIUYBDkYlHl6GC16xQqyJZcWVuYcYJTiYlUR475V5xgrxpiRW
        VqUW5ccXleakFh9iNAX6YSKzlGhyPjBd5JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnN
        Tk0tSC2C6WPi4JRqYOzn+ZV//Oazrdp/g1e1PRacaLY6Ms1gUVL3tfsNkXZ5TzqWPszzeqCz
        4mtD4JbAE1EWT4L6XEtvn5cV/MMSduKgja3t+j21tbIKnjE+74vTjxUHPFQ/vcr5eIPVpatt
        GfPWC5r+6ZOWN9yhr/eoSEHQPq1Ofwbz0UvHrxSF2DVa7fmX7xfJrsRSnJFoqMVcVJwIAP7Q
        j3XfAgAA
X-CMS-MailID: 20190807133858eucas1p28b272aa9a8dbbd95830f70098e25325a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190807133858eucas1p28b272aa9a8dbbd95830f70098e25325a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190807133858eucas1p28b272aa9a8dbbd95830f70098e25325a
References: <20190807133838.14678-1-k.konieczny@partner.samsung.com>
        <CGME20190807133858eucas1p28b272aa9a8dbbd95830f70098e25325a@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

Declare Exynos5422/5800 voltage ranges for opp points for big cpu core and
bus wcore and couple their voltage supllies as vdd_arm and vdd_int should
be in 300mV range.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
[k.konieczny: add missing patch description]
Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi             | 34 +++++++++----------
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  4 +++
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |  4 +++
 arch/arm/boot/dts/exynos5800.dtsi             | 32 ++++++++---------
 4 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 5fb2326875dc..0cbf74750553 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -48,62 +48,62 @@
 			opp-shared;
 			opp-1800000000 {
 				opp-hz = /bits/ 64 <1800000000>;
-				opp-microvolt = <1250000>;
+				opp-microvolt = <1250000 1250000 1500000>;
 				clock-latency-ns = <140000>;
 			};
 			opp-1700000000 {
 				opp-hz = /bits/ 64 <1700000000>;
-				opp-microvolt = <1212500>;
+				opp-microvolt = <1212500 1212500 1500000>;
 				clock-latency-ns = <140000>;
 			};
 			opp-1600000000 {
 				opp-hz = /bits/ 64 <1600000000>;
-				opp-microvolt = <1175000>;
+				opp-microvolt = <1175000 1175000 1500000>;
 				clock-latency-ns = <140000>;
 			};
 			opp-1500000000 {
 				opp-hz = /bits/ 64 <1500000000>;
-				opp-microvolt = <1137500>;
+				opp-microvolt = <1137500 1137500 1500000>;
 				clock-latency-ns = <140000>;
 			};
 			opp-1400000000 {
 				opp-hz = /bits/ 64 <1400000000>;
-				opp-microvolt = <1112500>;
+				opp-microvolt = <1112500 1112500 1500000>;
 				clock-latency-ns = <140000>;
 			};
 			opp-1300000000 {
 				opp-hz = /bits/ 64 <1300000000>;
-				opp-microvolt = <1062500>;
+				opp-microvolt = <1062500 1062500 1500000>;
 				clock-latency-ns = <140000>;
 			};
 			opp-1200000000 {
 				opp-hz = /bits/ 64 <1200000000>;
-				opp-microvolt = <1037500>;
+				opp-microvolt = <1037500 1037500 1500000>;
 				clock-latency-ns = <140000>;
 			};
 			opp-1100000000 {
 				opp-hz = /bits/ 64 <1100000000>;
-				opp-microvolt = <1012500>;
+				opp-microvolt = <1012500 1012500 1500000>;
 				clock-latency-ns = <140000>;
 			};
 			opp-1000000000 {
 				opp-hz = /bits/ 64 <1000000000>;
-				opp-microvolt = < 987500>;
+				opp-microvolt = < 987500 987500 1500000>;
 				clock-latency-ns = <140000>;
 			};
 			opp-900000000 {
 				opp-hz = /bits/ 64 <900000000>;
-				opp-microvolt = < 962500>;
+				opp-microvolt = < 962500 962500 1500000>;
 				clock-latency-ns = <140000>;
 			};
 			opp-800000000 {
 				opp-hz = /bits/ 64 <800000000>;
-				opp-microvolt = < 937500>;
+				opp-microvolt = < 937500 937500 1500000>;
 				clock-latency-ns = <140000>;
 			};
 			opp-700000000 {
 				opp-hz = /bits/ 64 <700000000>;
-				opp-microvolt = < 912500>;
+				opp-microvolt = < 912500 912500 1500000>;
 				clock-latency-ns = <140000>;
 			};
 		};
@@ -1100,23 +1100,23 @@
 
 			opp00 {
 				opp-hz = /bits/ 64 <84000000>;
-				opp-microvolt = <925000>;
+				opp-microvolt = <925000 925000 1400000>;
 			};
 			opp01 {
 				opp-hz = /bits/ 64 <111000000>;
-				opp-microvolt = <950000>;
+				opp-microvolt = <950000 950000 1400000>;
 			};
 			opp02 {
 				opp-hz = /bits/ 64 <222000000>;
-				opp-microvolt = <950000>;
+				opp-microvolt = <950000 950000 1400000>;
 			};
 			opp03 {
 				opp-hz = /bits/ 64 <333000000>;
-				opp-microvolt = <950000>;
+				opp-microvolt = <950000 950000 1400000>;
 			};
 			opp04 {
 				opp-hz = /bits/ 64 <400000000>;
-				opp-microvolt = <987500>;
+				opp-microvolt = <987500 987500 1400000>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 25d95de15c9b..65d094256b54 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -428,6 +428,8 @@
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&buck3_reg>;
+				regulator-coupled-max-spread = <300000>;
 			};
 
 			buck3_reg: BUCK3 {
@@ -436,6 +438,8 @@
 				regulator-max-microvolt = <1400000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&buck2_reg>;
+				regulator-coupled-max-spread = <300000>;
 			};
 
 			buck4_reg: BUCK4 {
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index e0f470fe54c8..5c1e965ed7e9 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -257,6 +257,8 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-ramp-delay = <12500>;
+				regulator-coupled-with = <&buck3_reg>;
+				regulator-coupled-max-spread = <300000>;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -269,6 +271,8 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-ramp-delay = <12500>;
+				regulator-coupled-with = <&buck2_reg>;
+				regulator-coupled-max-spread = <300000>;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index 57d3b319fd65..2a74735d161c 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -22,61 +22,61 @@
 
 &cluster_a15_opp_table {
 	opp-1700000000 {
-		opp-microvolt = <1250000>;
+		opp-microvolt = <1250000 1250000 1500000>;
 	};
 	opp-1600000000 {
-		opp-microvolt = <1250000>;
+		opp-microvolt = <1250000 1250000 1500000>;
 	};
 	opp-1500000000 {
-		opp-microvolt = <1100000>;
+		opp-microvolt = <1100000 1100000 1500000>;
 	};
 	opp-1400000000 {
-		opp-microvolt = <1100000>;
+		opp-microvolt = <1100000 1100000 1500000>;
 	};
 	opp-1300000000 {
-		opp-microvolt = <1100000>;
+		opp-microvolt = <1100000 1100000 1500000>;
 	};
 	opp-1200000000 {
-		opp-microvolt = <1000000>;
+		opp-microvolt = <1000000 1000000 1500000>;
 	};
 	opp-1100000000 {
-		opp-microvolt = <1000000>;
+		opp-microvolt = <1000000 1000000 1500000>;
 	};
 	opp-1000000000 {
-		opp-microvolt = <1000000>;
+		opp-microvolt = <1000000 1000000 1500000>;
 	};
 	opp-900000000 {
-		opp-microvolt = <1000000>;
+		opp-microvolt = <1000000 1000000 1500000>;
 	};
 	opp-800000000 {
-		opp-microvolt = <900000>;
+		opp-microvolt = <900000 900000 1500000>;
 	};
 	opp-700000000 {
-		opp-microvolt = <900000>;
+		opp-microvolt = <900000 900000 1500000>;
 	};
 	opp-600000000 {
 		opp-hz = /bits/ 64 <600000000>;
-		opp-microvolt = <900000>;
+		opp-microvolt = <900000 900000 1500000>;
 		clock-latency-ns = <140000>;
 	};
 	opp-500000000 {
 		opp-hz = /bits/ 64 <500000000>;
-		opp-microvolt = <900000>;
+		opp-microvolt = <900000 900000 1500000>;
 		clock-latency-ns = <140000>;
 	};
 	opp-400000000 {
 		opp-hz = /bits/ 64 <400000000>;
-		opp-microvolt = <900000>;
+		opp-microvolt = <900000 900000 1500000>;
 		clock-latency-ns = <140000>;
 	};
 	opp-300000000 {
 		opp-hz = /bits/ 64 <300000000>;
-		opp-microvolt = <900000>;
+		opp-microvolt = <900000 900000 1500000>;
 		clock-latency-ns = <140000>;
 	};
 	opp-200000000 {
 		opp-hz = /bits/ 64 <200000000>;
-		opp-microvolt = <900000>;
+		opp-microvolt = <900000 900000 1500000>;
 		clock-latency-ns = <140000>;
 	};
 };
-- 
2.22.0

