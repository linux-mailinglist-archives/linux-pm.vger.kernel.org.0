Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5F235961A
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 09:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhDIHMh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 03:12:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42382 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231679AbhDIHMg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 03:12:36 -0400
X-UUID: 96e6dfa9373a443c949729cfb833874e-20210409
X-UUID: 96e6dfa9373a443c949729cfb833874e-20210409
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 871725561; Fri, 09 Apr 2021 15:12:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 15:11:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 15:11:58 +0800
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
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] arm64: dts: mt8183-kukui: Enable thermal Tboard
Date:   Fri, 9 Apr 2021 15:11:58 +0800
Message-ID: <20210409071158.2346-1-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Tboard thermal sensor settings.

pull-up voltage: 1800 mv
pull-up resistor: 75K

Vsense = pull-up voltage * Rntc / ( pull-up resistor + Rntc )
AuxIn = Vsense * 4096 / 1500

TEST=boot kukui
     check /sys/class/thermal/thermal_zone*/type
     check /sys/class/thermal/thermal_zone*/temp

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi       |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index bf2ad1294dd3..202acb542b12 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -801,6 +801,20 @@
 	status = "okay";
 };
 
+&thermal_zones {
+	Tboard1 {
+		polling-delay = <1000>; /* milliseconds */
+		polling-delay-passive = <0>; /* milliseconds */
+		thermal-sensors = <&tboard_thermistor1>;
+	};
+
+	Tboard2 {
+		polling-delay = <1000>; /* milliseconds */
+		polling-delay-passive = <0>; /* milliseconds */
+		thermal-sensors = <&tboard_thermistor2>;
+	};
+};
+
 &u3phy {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 1ad0a1d55d53..f0719dbef249 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -673,7 +673,7 @@
 			nvmem-cell-names = "calibration-data";
 		};
 
-		thermal-zones {
+		thermal_zones: thermal-zones {
 			cpu_thermal: cpu_thermal {
 				polling-delay-passive = <100>;
 				polling-delay = <500>;
-- 
2.18.0

