Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7136A127227
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 01:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfLTASU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 19:18:20 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:57704 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfLTASK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 19:18:10 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191220001805epoutp036de23ba2b49d52ad6f89a0c906c8fc47~h7DuUVNpP1346513465epoutp033
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 00:18:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191220001805epoutp036de23ba2b49d52ad6f89a0c906c8fc47~h7DuUVNpP1346513465epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576801085;
        bh=eX43I+qUocUpECabhW06ewcSAYF+DXL//QhEerlGfJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HuVJUaMCId+d6MyCMktULJu1zufmNLSZQGfaKj6DparF4hNVsORXJqivZi54yx1Ud
         5Qi59JKQQXIta8f8bZpI6NZhmcSxa0xRpaMTpkfQykqXj4yeTMk+uTNFyPBTsp8WvX
         nCgnlHvLSJl6EdJ15l+hy09YwjywxmyKB445mzzs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191220001804epcas1p3d714a4067c0c06c4da2c113712f2110b~h7Dt7LEb21359613596epcas1p3q;
        Fri, 20 Dec 2019 00:18:04 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47f8Tj1SF4zMqYkt; Fri, 20 Dec
        2019 00:18:01 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.0E.48019.9331CFD5; Fri, 20 Dec 2019 09:18:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191220001800epcas1p2f2dfd9d24e275425b07a06bcdeb4aba9~h7DqBPUIe0401904019epcas1p2O;
        Fri, 20 Dec 2019 00:18:00 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191220001800epsmtrp126c101be240b24abc78f6b3303e58865~h7DqARxA61705617056epsmtrp1Z;
        Fri, 20 Dec 2019 00:18:00 +0000 (GMT)
X-AuditID: b6c32a38-6b4789c00001bb93-6a-5dfc1339b920
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.7C.06569.8331CFD5; Fri, 20 Dec 2019 09:18:00 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220001800epsmtip111e3e06f1fdda1e3566767b27de19e3a~h7Dp0an3w2227322273epsmtip1o;
        Fri, 20 Dec 2019 00:18:00 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de,
        leonard.crestez@nxp.com, lukasz.luba@arm.com
Cc:     mark.rutland@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v2 10/11] ARM: dts: exynos: Replace deprecated property for
 Exynos bus and DMC
Date:   Fri, 20 Dec 2019 09:24:29 +0900
Message-Id: <20191220002430.11995-11-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220002430.11995-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjuO8dzMVocptbX6LJOFCRoHufWZ2l070ARgtWPaKyDO23ibu1s
        lQWlkrmkixVFRmqRhZpdXGYWmWWLLpAalhq27ldXgZes0LJtx6h/z/u8z/O9l++lcWUlqaIz
        bS7RaRMsLDk6ou72zPi45KghfcJjL4lelOYD1NH/gUBlvmYCDb8OEGj/mwCOWlouUuhh3mcK
        Vfh7COR9006gtmvHSdS31wdQ78thHB1tuYGhk3k7KXTO56fQ6Y5HGOrKrSBRfoOPmq/kq0ur
        Ae+t2k3yl8p38DVf6zF+X20V4K+0l+J8n3dyGrU2K8UsCkbRqRZtGXZjps2Uyi5PNywyaHUJ
        XByXjGazaptgFVPZxSvS4pZmWoJjsOpNgsUdpNIESWJnzUtx2t0uUW22S65UVnQYLY5kR7wk
        WCW3zRSfYbfO4RISErVB4fosc8OREsLRzm8ZaO4kckDXnEIQSUMmCf7My8UKwWhaydQD+Hao
        h5CDXgB///oCQiolMwCg/8qkv46GW09wWdQAYFX3vRFHP4APDt+hQiqSiYWNHzvJEI5mzLA4
        0BYW4UwPBgvr/OFEFLMefjlaHkzQdAQzHeYMmEK0gpkLCw6ewuRqU+DZizfxEI4M8rXvX1Gh
        dyAzTMKaQBEuixbDbw+7KRlHwe67tSNYBT/t3zWCt8HK+z5SNnsArG1sJeSEBjaePoSFmsCZ
        mfDCtVkyPRVeHSwJj48zY+HXb3vCfUJGAT27lLJkGmx76R/pcwI8VbCblDEPA+8uk/Lm9gHY
        128sApOP/StwAoAqME50SFaTKHGOpP9/zAvCZxqL6sH15hVNgKEBO0Yxf8OgXkkIm6RsaxOA
        NM5GK7o8P/VKhVHI3io67Qan2yJKTUAbXOQBXBWTYQ8evc1l4LSJGo0GJXE6Lcex4xX0j0d6
        JWMSXGKWKDpE518fRkeqcsDKlIW6yurr9T1nHGWajvTLq7PdMz6XEZYLdQ8qW+8NHVt3d0ZU
        qtNDq1y5m5dmi5p5558t0xmLheK3nqKnowYfP4/BDNvT7b1+vW5JRTH/XeqLMY3rHP5UE1di
        fBpRoIpelOSuyzjeqv54ZMHAmvi28olNU3JurepONFli8ys23mYjJLPAxeJOSfgDSmgakLwD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnK6F8J9Yg70/5S3uz2tltLj+5Tmr
        xfwj51gt/j96zWrR//g1s8X58xvYLc42vWG3WHH3I6vFpsfXWC0u75rDZvG59wijxacH/5kt
        Zpzfx2SxsKmF3WLtkbvsFkuvX2SyuN24gs2ide8RdgchjzXz1jB6bFrVyeaxeUm9x8Z3O5g8
        +rasYvTYfm0es8fnTXIB7FFcNimpOZllqUX6dglcGXunzWUtuOZR8e3cDdYGxttWXYycHBIC
        JhJ7D15l7mLk4hAS2M0osXHeJTaIhKTEtItHgRIcQLawxOHDxRA1nxgl3q3dzwhSwyagJbH/
        xQ2wehGBPIlNG7+CDWIW+M8k8f3kA7AiYYE4ibUz3zOBDGIRUJVo+JYOEuYVsJZon7SYCWKX
        vMTqDQeYQWxOoPiWZw/ZQWwhASuJl+cvsE5g5FvAyLCKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0
        L10vOT93EyM46LW0djCeOBF/iFGAg1GJh9ch7XesEGtiWXFl7iFGCQ5mJRHe2x0/Y4V4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFwSjUw1k7hjdbVnrrkT9LR
        Tf/fyi//6TXhg+bq4NPda93XszKsCDlwOGDRmzU5Dr7CR6cHu9+N4NLf5SH6S4bBY7v0RuWP
        JkIzLGc5zXyb++dATqHot7vXP19jTxafYHa3stlo+nr3daETqz+e3fwmdHcjo+oOLoszWlsc
        qwIsHIwNXvYuFztQ9WjfSiWW4oxEQy3mouJEAM4GE2l2AgAA
X-CMS-MailID: 20191220001800epcas1p2f2dfd9d24e275425b07a06bcdeb4aba9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220001800epcas1p2f2dfd9d24e275425b07a06bcdeb4aba9
References: <20191220002430.11995-1-cw00.choi@samsung.com>
        <CGME20191220001800epcas1p2f2dfd9d24e275425b07a06bcdeb4aba9@epcas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace the property related to devfreq and devfreq-event device
to remove the deprecated property name.
- Replace 'devfreq' with 'exynos,parent-bus' property
  for getting the parent devfreq device of exynos-bus.
- Replace 'devfreq-events' with 'exynos,ppmu-device' property
  for getting the devfreq-event device to monitor bus utilization.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos3250-monk.dts         |  2 +-
 arch/arm/boot/dts/exynos3250-rinato.dts       | 18 +++++-----
 .../boot/dts/exynos4412-itop-scp-core.dtsi    | 16 ++++-----
 arch/arm/boot/dts/exynos4412-midas.dtsi       | 18 +++++-----
 .../boot/dts/exynos4412-odroid-common.dtsi    | 18 +++++-----
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 34 +++++++++----------
 6 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 248bd372fe70..c6b1fcd4ba97 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -158,7 +158,7 @@
 };
 
 &bus_dmc {
-	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+	exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
 	vdd-supply = <&buck1_reg>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 86c26a4edfd7..7ad80354d8df 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -153,49 +153,49 @@
 };
 
 &bus_dmc {
-	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+	exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
 	vdd-supply = <&buck1_reg>;
 	status = "okay";
 };
 
 &bus_leftbus {
-	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
+	exynos,ppmu-device = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
 	vdd-supply = <&buck3_reg>;
 	status = "okay";
 };
 
 &bus_rightbus {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_lcd0 {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_fsys {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_mcuisp {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_isp {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_peril {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_mfc {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
index dfceb155b3a7..e275a52eb0d3 100644
--- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
+++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
@@ -70,44 +70,44 @@
 };
 
 &bus_dmc {
-	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+	exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
 	vdd-supply = <&buck1_reg>;
 	status = "okay";
 };
 
 &bus_acp {
-	devfreq = <&bus_dmc>;
+	exynos,parent-bus = <&bus_dmc>;
 	status = "okay";
 };
 
 &bus_c2c {
-	devfreq = <&bus_dmc>;
+	exynos,parent-bus = <&bus_dmc>;
 	status = "okay";
 };
 
 &bus_leftbus {
-	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
+	exynos,ppmu-device = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
 	vdd-supply = <&buck3_reg>;
 	status = "okay";
 };
 
 &bus_rightbus {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_fsys {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_peri {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_mfc {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 83be3a797411..1869eed05167 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -288,49 +288,49 @@
 };
 
 &bus_dmc {
-	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+	exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
 	vdd-supply = <&buck1_reg>;
 	status = "okay";
 };
 
 &bus_acp {
-	devfreq = <&bus_dmc>;
+	exynos,parent-bus = <&bus_dmc>;
 	status = "okay";
 };
 
 &bus_c2c {
-	devfreq = <&bus_dmc>;
+	exynos,parent-bus = <&bus_dmc>;
 	status = "okay";
 };
 
 &bus_leftbus {
-	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
+	exynos,ppmu-device = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
 	vdd-supply = <&buck3_reg>;
 	status = "okay";
 };
 
 &bus_rightbus {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_display {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_fsys {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_peri {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_mfc {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index ea55f377d17c..bb5a7cbcc308 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -88,49 +88,49 @@
 };
 
 &bus_dmc {
-	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+	exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
 	vdd-supply = <&buck1_reg>;
 	status = "okay";
 };
 
 &bus_acp {
-	devfreq = <&bus_dmc>;
+	exynos,parent-bus = <&bus_dmc>;
 	status = "okay";
 };
 
 &bus_c2c {
-	devfreq = <&bus_dmc>;
+	exynos,parent-bus = <&bus_dmc>;
 	status = "okay";
 };
 
 &bus_leftbus {
-	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
+	exynos,ppmu-device = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
 	vdd-supply = <&buck3_reg>;
 	status = "okay";
 };
 
 &bus_rightbus {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_display {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_fsys {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_peri {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
 &bus_mfc {
-	devfreq = <&bus_leftbus>;
+	exynos,parent-bus = <&bus_leftbus>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 059fa32d1a8f..8510e2787a9c 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -134,7 +134,7 @@
 };
 
 &bus_wcore {
-	devfreq-events = <&nocp_mem0_0>, <&nocp_mem0_1>,
+	exynos,ppmu-device = <&nocp_mem0_0>, <&nocp_mem0_1>,
 			<&nocp_mem1_0>, <&nocp_mem1_1>;
 	vdd-supply = <&buck3_reg>;
 	exynos,saturation-ratio = <100>;
@@ -142,77 +142,77 @@
 };
 
 &bus_noc {
-	devfreq = <&bus_wcore>;
+	exynos,parent-bus = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_fsys_apb {
-	devfreq = <&bus_wcore>;
+	exynos,parent-bus = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_fsys {
-	devfreq = <&bus_wcore>;
+	exynos,parent-bus = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_fsys2 {
-	devfreq = <&bus_wcore>;
+	exynos,parent-bus = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_mfc {
-	devfreq = <&bus_wcore>;
+	exynos,parent-bus = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_gen {
-	devfreq = <&bus_wcore>;
+	exynos,parent-bus = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_peri {
-	devfreq = <&bus_wcore>;
+	exynos,parent-bus = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_g2d {
-	devfreq = <&bus_wcore>;
+	exynos,parent-bus = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_g2d_acp {
-	devfreq = <&bus_wcore>;
+	exynos,parent-bus = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_jpeg {
-	devfreq = <&bus_wcore>;
+	exynos,parent-bus = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_jpeg_apb {
-	devfreq = <&bus_wcore>;
+	exynos,parent-bus = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_disp1_fimd {
-	devfreq = <&bus_wcore>;
+	exynos,parent-bus = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_disp1 {
-	devfreq = <&bus_wcore>;
+	exynos,parent-bus = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_gscl_scaler {
-	devfreq = <&bus_wcore>;
+	exynos,parent-bus = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_mscl {
-	devfreq = <&bus_wcore>;
+	exynos,parent-bus = <&bus_wcore>;
 	status = "okay";
 };
 
@@ -225,7 +225,7 @@
 };
 
 &dmc {
-	devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
+	exynos,ppmu-device = <&ppmu_event3_dmc0_0>, <&ppmu_event3_dmc0_1>,
 			<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
 	device-handle = <&samsung_K3QF2F20DB>;
 	operating-points-v2 = <&dmc_opp_table>;
-- 
2.17.1

