Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFFE01186A2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 12:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfLJLku (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 06:40:50 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44518 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfLJLkj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 06:40:39 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191210114037euoutp010a70c38560557a319e357e45f92fe145~e-6y_zPhN1618016180euoutp01L
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 11:40:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191210114037euoutp010a70c38560557a319e357e45f92fe145~e-6y_zPhN1618016180euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575978037;
        bh=aiVnQzPbPozJNU83F/hiDg/No+tUDZ/IodGWUQHWRto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEtGQbxThmIa6H2Zp9ul8AD0rVON4VzjyJruk4oO8i8jHhpMAdiZ86I+BHUbrfLg0
         HW2xZFYrgEKc8cwqGAolK73NBXkOlMDT5sh6YHcs2ap9lrUHwlX04GLp2Nr1JCtQAL
         dtJgJt8PWApfdsSNIRJEU4/d/ATQOolA39zVcIEA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191210114036eucas1p22c80daa0215fa2fa06ca3dcf4bc44873~e-6yvGlTN2407724077eucas1p2l;
        Tue, 10 Dec 2019 11:40:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 23.87.60698.4348FED5; Tue, 10
        Dec 2019 11:40:36 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191210114036eucas1p2b0205a5dcdf1f26485235a232a5cbf20~e-6yaR9L52393723937eucas1p2m;
        Tue, 10 Dec 2019 11:40:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191210114036eusmtrp1652822c7a907e6a1f0ee8ed7724132f3~e-6yZj4jt2588725887eusmtrp1S;
        Tue, 10 Dec 2019 11:40:36 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-a0-5def8434f9ce
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F3.BF.08375.4348FED5; Tue, 10
        Dec 2019 11:40:36 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191210114035eusmtip100b278fd846293c6cfe242055958815b~e-6x2cvR22043220432eusmtip1f;
        Tue, 10 Dec 2019 11:40:35 +0000 (GMT)
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
Subject: [PATCH 1/2] ARM: dts: exynos: Add initial data for coupled
 regulators for Exynos5422/5800
Date:   Tue, 10 Dec 2019 12:40:26 +0100
Message-Id: <20191210114027.14910-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210114027.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduzneV2TlvexBief61g0byq2WL5yF4vF
        xhnrWS2uf3nOanF22UE2iwWfZrBanD+/gd3i8q45bBafe48wWsw4v4/JYu2Ru+wO3B6zGy6y
        eGxa1cnm0bdlFaPH5tPVHp83yQWwRnHZpKTmZJalFunbJXBlfLq9j7HguG3F5kkWDYwNBl2M
        nBwSAiYS1+cuYexi5OIQEljBKLHoyE02COcLo8TfmxeZQKqEBD4zSuzudYPpeDepG6pjOaPE
        2o2/WeE6Vh77ywpSxSZgKNH1tosNxBYRiJd41H+XBaSIWeASk8SSxu/sIAlhgRSJjifzwBpY
        BFQlXt24CBbnFbCVOLu9gwlinbzE6g0HmEFsTgE7iUlv+plABkkINLNL/Jp9jgWiyEWi6/hV
        NghbWOLV8S3sELaMxOnJPSxQDYwSD8+tZYdwehglLjfNYISospY4fPwi0BkcQPdpSqzfpQ8R
        dpRY03aQDSQsIcAnceOtIEiYGcictG06M0SYV6KjTQiiWk1i1vF1cGsPXrjEDGF7SLw9fQYa
        phMZJfY9uMk4gVF+FsKyBYyMqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQJTyel/x7/u
        YNz3J+kQowAHoxIP7wKHd7FCrIllxZW5hxglOJiVRHiPtwGFeFMSK6tSi/Lji0pzUosPMUpz
        sCiJ8xovehkrJJCeWJKanZpakFoEk2Xi4JRqYNy1SzBv76GsB9uOn4u89EF7ftyvgxveVHw9
        deCtlYZ/Hee8ZbPsP3+YeFxdVNcnQohrfcKFHpOH8oIv9jywNTXYa75nCoP//j7RN97eZdJv
        pQ0ZT/zImyK558rS6Rlmt+un1lecW6I1p1YphfXu9+nfJEpt/TTTg5NWfEibf8HmxqP1i/Z1
        SXkosRRnJBpqMRcVJwIAeYD5CiEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsVy+t/xu7omLe9jDS79ELRo3lRssXzlLhaL
        jTPWs1pc//Kc1eLssoNsFgs+zWC1OH9+A7vF5V1z2Cw+9x5htJhxfh+Txdojd9kduD1mN1xk
        8di0qpPNo2/LKkaPzaerPT5vkgtgjdKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1
        MjJV0rezSUnNySxLLdK3S9DL+HR7H2PBcduKzZMsGhgbDLoYOTkkBEwk3k3qZuxi5OIQEljK
        KNHyYwoTREJG4uS0BlYIW1jiz7UuNoiiT4wSS5vOsYMk2AQMJbregiQ4OUQEEiVmf5wNVsQs
        cINJ4tLbOWCThAWSJPrnzwebxCKgKvHqxkWwZl4BW4mz2zugtslLrN5wgBnE5hSwk5j0ph8s
        LgRUs2XpFOYJjHwLGBlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBAb2tmM/N+9gvLQx+BCj
        AAejEg/vAod3sUKsiWXFlbmHGCU4mJVEeI+3AYV4UxIrq1KL8uOLSnNSiw8xmgIdNZFZSjQ5
        Hxh1eSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGPsnrU85ahWQ
        zDIjoD1SrXGx2k7RDRK5TJ/faQRs2t91wWvjNYP5R6WYbP3Tn08KvSw1K0wxZ2cK16QKa637
        lmeTZZI9NkVMTrwhV25+NkrZx/JI95yAJ0aLEjZ/k5oy5c5UnclBq9ROc82WnbSJa2nuesYp
        C3lZfn58eMQkuutLreUPg/q8u0osxRmJhlrMRcWJABf6z1aCAgAA
X-CMS-MailID: 20191210114036eucas1p2b0205a5dcdf1f26485235a232a5cbf20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191210114036eucas1p2b0205a5dcdf1f26485235a232a5cbf20
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191210114036eucas1p2b0205a5dcdf1f26485235a232a5cbf20
References: <20191210114027.14910-1-m.szyprowski@samsung.com>
        <CGME20191210114036eucas1p2b0205a5dcdf1f26485235a232a5cbf20@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Declare Exynos5422/5800 voltage ranges for opp points for big cpu core and
bus wcore and couple their voltage supllies as vdd_arm and vdd_int should
be in 300mV range.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
[k.konieczny: add missing patch description]
Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
This patch is the same as https://patchwork.kernel.org/patch/11172427/
which has been dropped due to the other issues in the regulator framework.
Those issues has been resolved now, so it is safe to apply it.
---
 arch/arm/boot/dts/exynos5420.dtsi             | 34 +++++++++----------
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  4 +++
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |  4 +++
 arch/arm/boot/dts/exynos5800.dtsi             | 32 ++++++++---------
 4 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index d39907a41f78..1ae5211f7d79 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -48,62 +48,62 @@
 
 		opp-1800000000 {
 			opp-hz = /bits/ 64 <1800000000>;
-			opp-microvolt = <1250000>;
+			opp-microvolt = <1250000 1250000 1500000>;
 			clock-latency-ns = <140000>;
 		};
 		opp-1700000000 {
 			opp-hz = /bits/ 64 <1700000000>;
-			opp-microvolt = <1212500>;
+			opp-microvolt = <1212500 1212500 1500000>;
 			clock-latency-ns = <140000>;
 		};
 		opp-1600000000 {
 			opp-hz = /bits/ 64 <1600000000>;
-			opp-microvolt = <1175000>;
+			opp-microvolt = <1175000 1175000 1500000>;
 			clock-latency-ns = <140000>;
 		};
 		opp-1500000000 {
 			opp-hz = /bits/ 64 <1500000000>;
-			opp-microvolt = <1137500>;
+			opp-microvolt = <1137500 1137500 1500000>;
 			clock-latency-ns = <140000>;
 		};
 		opp-1400000000 {
 			opp-hz = /bits/ 64 <1400000000>;
-			opp-microvolt = <1112500>;
+			opp-microvolt = <1112500 1112500 1500000>;
 			clock-latency-ns = <140000>;
 		};
 		opp-1300000000 {
 			opp-hz = /bits/ 64 <1300000000>;
-			opp-microvolt = <1062500>;
+			opp-microvolt = <1062500 1062500 1500000>;
 			clock-latency-ns = <140000>;
 		};
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <1037500>;
+			opp-microvolt = <1037500 1037500 1500000>;
 			clock-latency-ns = <140000>;
 		};
 		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
-			opp-microvolt = <1012500>;
+			opp-microvolt = <1012500 1012500 1500000>;
 			clock-latency-ns = <140000>;
 		};
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = < 987500>;
+			opp-microvolt = < 987500 987500 1500000>;
 			clock-latency-ns = <140000>;
 		};
 		opp-900000000 {
 			opp-hz = /bits/ 64 <900000000>;
-			opp-microvolt = < 962500>;
+			opp-microvolt = < 962500 962500 1500000>;
 			clock-latency-ns = <140000>;
 		};
 		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = < 937500>;
+			opp-microvolt = < 937500 937500 1500000>;
 			clock-latency-ns = <140000>;
 		};
 		opp-700000000 {
 			opp-hz = /bits/ 64 <700000000>;
-			opp-microvolt = < 912500>;
+			opp-microvolt = < 912500 912500 1500000>;
 			clock-latency-ns = <140000>;
 		};
 	};
@@ -1171,23 +1171,23 @@
 
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
index 059fa32d1a8f..8a34a861c191 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -601,6 +601,8 @@
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&buck3_reg>;
+				regulator-coupled-max-spread = <300000>;
 
 				regulator-state-mem {
 					regulator-off-in-suspend;
@@ -613,6 +615,8 @@
 				regulator-max-microvolt = <1400000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&buck2_reg>;
+				regulator-coupled-max-spread = <300000>;
 
 				regulator-state-mem {
 					regulator-off-in-suspend;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 60ca3d685247..c1e38139ce4f 100644
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
index 16177d815ee4..1be7eb60439a 100644
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
2.17.1

