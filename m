Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B852933CE55
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 08:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhCPHCC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 03:02:02 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44042 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231978AbhCPHBz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 03:01:55 -0400
X-UUID: 767150ff4af74e5a894747134e872fc4-20210316
X-UUID: 767150ff4af74e5a894747134e872fc4-20210316
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 593126547; Tue, 16 Mar 2021 15:01:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Mar 2021 15:01:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Mar 2021 15:01:44 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     <michael.kao@mediatek.com>, <fan.chen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [v7,2/3] arm64: dts: mt8183: Configure CPU cooling
Date:   Tue, 16 Mar 2021 15:01:43 +0800
Message-ID: <20210316070144.28440-3-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210316070144.28440-1-michael.kao@mediatek.com>
References: <20210316070144.28440-1-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

Add two passive trip points at 68°C and 80°C for the CPU temperature.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 56 ++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index d3550af06408..1ad0a1d55d53 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/power/mt8183-power.h>
 #include <dt-bindings/reset-controller/mt8183-resets.h>
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/thermal/thermal.h>
 #include "mt8183-pinfunc.h"
 
 / {
@@ -678,6 +679,61 @@
 				polling-delay = <500>;
 				thermal-sensors = <&thermal 0>;
 				sustainable-power = <5000>;
+
+				trips {
+					threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+
+					target: trip-point@1 {
+						temperature = <80000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+
+					cpu_crit: cpu-crit {
+						temperature = <115000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+
+				cooling-maps {
+					map0 {
+						trip = <&target>;
+						cooling-device = <&cpu0
+							THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>,
+								 <&cpu1
+							THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>,
+								 <&cpu2
+							THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>,
+								 <&cpu3
+							THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>;
+						contribution = <3072>;
+					};
+					map1 {
+						trip = <&target>;
+						cooling-device = <&cpu4
+							THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>,
+								 <&cpu5
+							THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>,
+								 <&cpu6
+							THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>,
+								 <&cpu7
+							THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>;
+						contribution = <1024>;
+					};
+				};
 			};
 
 			/* The tzts1 ~ tzts6 don't need to polling */
-- 
2.18.0

