Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86323127A91
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 13:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLTMCD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 07:02:03 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36386 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfLTMBr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 07:01:47 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191220120145euoutp01cc480a88b331ac6e3f65bdc2904af659~iEqG27f1g0861508615euoutp01g
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 12:01:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191220120145euoutp01cc480a88b331ac6e3f65bdc2904af659~iEqG27f1g0861508615euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576843305;
        bh=lpHh2CLsKl9Vo1x5ZpVOJyf/41Vj/t4qkAQBmJMc1BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vSAJqWfP97UNj3lD4/I+vEmcQ2GlmSQ90O5piQoRyg2TtSPkA7da0+GQs6mU0azfG
         OHFE9aVvGdgwInNjrk5sqXnupu4SIaDz8F7Q5jdyaHoiZ53j6sjTt1yjlUIkUoslLx
         xJZkg0WyTB+jMwDOEN8mAjvGhPDvtzZJACEv5/TE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191220120144eucas1p26ecb251dd8ee4c4bef7dbe6203d52a94~iEqGWmtnO2975829758eucas1p20;
        Fri, 20 Dec 2019 12:01:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E0.94.60679.828BCFD5; Fri, 20
        Dec 2019 12:01:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9~iEqF_4imR1895018950eucas1p1X;
        Fri, 20 Dec 2019 12:01:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191220120144eusmtrp23bf44b2ad15c3e14bb0360f47e4da276~iEqF_PztJ2149121491eusmtrp2x;
        Fri, 20 Dec 2019 12:01:44 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-1f-5dfcb8282389
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.68.07950.828BCFD5; Fri, 20
        Dec 2019 12:01:44 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191220120143eusmtip2bbaceb996ba95413eafb3782203260f7~iEqFKOe_R2848028480eusmtip2d;
        Fri, 20 Dec 2019 12:01:43 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v3 4/7] arm: dts: exynos: Add interconnect bindings for
 Exynos4412
Date:   Fri, 20 Dec 2019 12:56:50 +0100
Message-Id: <20191220115653.6487-5-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220115653.6487-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjuO2fn7DiaHDfLl4qkUaRBaib0dcGKIg79CulHBKOWnlR0Tna0
        NIi8ZMwkMyO8FGUhzSamLi9zVOQcDZE0Ly1NZUF2WReXbqObZbqzLv+e77m8z/vCx5AKJ7WC
        Sc/K4fVZmkwVLZN0PP7WvzHKMqeOa3oRhV3XSxBurW6m8HPfWwrfsPdTeMTvoXHVAzONK10V
        Ejww0CLFDZMzFDa/clJ42HqNxt4LdoSrBx4SuMk+KcXjhQ00rr7spnexnNlUSnMTzvs05ypz
        ENy9+jNc67SF4MrbTIjzmlcfkB6W7UjhM9NP8PrYxKOytFtjIyjbL8t793GMKEDlIedRCANs
        AhR5fNR5JGMUbAMCr/OuRHz4EHx2WGjx4UXQVFVM/ImU/+gmRcGIoGqgV/o3UtJzR7Lootnd
        UHnlZUAIZ+0ILtd5AoNJ9hoBhlJjwKVkD8HszCC9iCXsOui0PQl0yFkM7hljsC8SGlsekYs4
        hN0Ko8+GSNETBr01U4E55IKnuP1qYCdg/VJwVPikYngv+M9epESshPeOtiC/Cua7bgQLBHjd
        5aLEcAEC8207KQrbYaL/+8J2zEJDNDRbY0V6N7R/KSMWaWBDYfRTmLhDKFR2VJEiLQfDOYUI
        VWCtCRWDAEWNzuBsDgbrS6kKtKb2v2Nq/zum9l9tHSJNKILPFbSpvBCfxZ+METRaITcrNSZZ
        pzWjhd/W98vhsyDr3DEbYhmkWip/l/xDraA0J4R8rQ0BQ6rC5eOGb2qFPEWTf4rX647oczN5
        wYZWMhJVhHzzLbdawaZqcvgMns/m9X9UgglZUYAO5y2fXzvtTky6A95ZpTl22MQVPt2zb9n6
        h3MPouJW1qsvRUpndJfGoq2j/P6pyPnpi8+uJPldDssEbOMSvzo9y3b+LKP9fQezXRlLdPF5
        Ob1tQ4bZEmP3zdbTSdFvUmwcm1+z177cQbjIGENdb9iWSeVIzK6E/J7jaS86P+xUSYQ0zaYN
        pF7Q/AaaHXOOaQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xe7oaO/7EGnzYImhxf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C3WHH3I6vFpsfXWC0u75rDZvG59wij
        xYzz+5gs1h65y25xu3EFm8WMyS/ZHAQ8Nq3qZPO4c20Pm8f97uNMHpuX1HtsfLeDyaNvyypG
        j8+b5ALYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/Tt
        EvQyFt28wljwlavixZubTA2MfZxdjJwcEgImEn2/DzKD2EICSxklHs+ThYhLSHxcf4MVwhaW
        +HOti62LkQuo5hOjxMw7XWANbAKOEpOmPmAHSYgInGKU2Lr8HBtIgllgBZNE/xxhEFtYIEzi
        zuXr7CA2i4CqxPZDZ5lAbF4BC4mXH5czQWyQl1i94QDYUE4BS4kbVy9BXWQhsfNzH1S9oMTJ
        mU9Yuhg5gOarS6yfJwSxSl6ieets5gmMgrOQVM1CqJqFpGoBI/MqRpHU0uLc9NxiI73ixNzi
        0rx0veT83E2MwGjdduznlh2MXe+CDzEKcDAq8fA6pP2OFWJNLCuuzD3EKMHBrCTCe7vjZ6wQ
        b0piZVVqUX58UWlOavEhRlOg1yYyS4km5wMTSV5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0
        xJLU7NTUgtQimD4mDk6pBkbTW2eer2UTu7V985m7Z1QNRadacCjHfvSXP1dZ7btT51uxTMbq
        /TWbW2N+Vtf+WLpu0Vmxlv0J84MYZy94XzHn5i4Pvt1Ou5tjTbx1ze2mHfqcwpebdM5GyG1R
        wPwbWw6zhMklyW4yqGvL64v92zyNccKOGidbg0OaLDOn6N7JLU8+Nm330xwlluKMREMt5qLi
        RAB3lwoS7AIAAA==
X-CMS-MailID: 20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9
References: <20191220115653.6487-1-a.swigon@samsung.com>
        <CGME20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds the following properties to the Exynos4412 DT:
  - exynos,interconnect-parent-node: to declare connections between
    nodes in order to guarantee PM QoS requirements between nodes;
  - #interconnect-cells: required by the interconnect framework.

Note that #interconnect-cells is always zero and node IDs are not
hardcoded anywhere.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 4ce3d77a6704..d9d70eacfcaf 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -90,6 +90,7 @@
 &bus_dmc {
 	exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
 	vdd-supply = <&buck1_reg>;
+	#interconnect-cells = <0>;
 	status = "okay";
 };
 
@@ -106,6 +107,8 @@
 &bus_leftbus {
 	exynos,ppmu-device = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
 	vdd-supply = <&buck3_reg>;
+	exynos,interconnect-parent-node = <&bus_dmc>;
+	#interconnect-cells = <0>;
 	status = "okay";
 };
 
@@ -116,6 +119,8 @@
 
 &bus_display {
 	exynos,parent-bus = <&bus_leftbus>;
+	exynos,interconnect-parent-node = <&bus_leftbus>;
+	#interconnect-cells = <0>;
 	status = "okay";
 };
 
-- 
2.17.1

