Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4488D04A
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 12:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfHNKHA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 06:07:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53505 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726121AbfHNKG7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 06:06:59 -0400
X-UUID: b6fe7958dc7e4710af101f9b1029e17d-20190814
X-UUID: b6fe7958dc7e4710af101f9b1029e17d-20190814
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 220725746; Wed, 14 Aug 2019 18:06:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 14 Aug 2019 18:06:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 14 Aug 2019 18:06:53 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Kao <michael.kao@mediatek.com>
Subject: [PATCH 4/4] arm64: dts: mt8183: Configure CPU cooling
Date:   Wed, 14 Aug 2019 18:06:49 +0800
Message-ID: <1565777209-21869-5-git-send-email-michael.kao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565777209-21869-1-git-send-email-michael.kao@mediatek.com>
References: <1565777209-21869-1-git-send-email-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TM-SNTS-SMTP: 6B35072D115418BD62FDFB3A8FCC7BF1CA3916877D76B820D34241335E752A382000:8
X-MTK:  N
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

Add SoC temperature threshold at 68°C and target at 80°C.
Add trip points and cooling maps for big and litter clusters.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Michael Kao <michael.kao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index bc42b82..6611d29 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -411,6 +411,61 @@
 				polling-delay = <500>;
 				thermal-sensors = <&thermal 0>;
 				sustainable-power = <4500>;
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
+							14>,
+								 <&cpu5
+							THERMAL_NO_LIMIT
+							14>,
+								 <&cpu6
+							THERMAL_NO_LIMIT
+							14>,
+								 <&cpu7
+							THERMAL_NO_LIMIT
+							14>;
+						contribution = <1024>;
+					};
+				};
 			};
 
 			/* The tzts1 ~ tzts6 don't need to polling */
-- 
1.9.1

