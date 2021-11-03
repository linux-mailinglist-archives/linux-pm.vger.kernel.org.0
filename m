Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0620443BD9
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 04:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhKCDdn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 23:33:43 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:42508 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229506AbhKCDdm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Nov 2021 23:33:42 -0400
X-UUID: e2aa08772cd34549a1ee95d620a867cb-20211103
X-UUID: e2aa08772cd34549a1ee95d620a867cb-20211103
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ben.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1632646972; Wed, 03 Nov 2021 11:31:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 3 Nov 2021 11:30:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 3 Nov 2021 11:30:59 +0800
From:   Ben Tseng <ben.tseng@mediatek.com>
To:     Fan Chen <fan.chen@mediatek.com>, Zhang Rui <rui.zhang@intel.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Ben Tseng <ben.tseng@mediatek.com>
Subject: [PATCH 1/1] arm64: dts: mt8183-kukui: Update Tboard sensor mapping table
Date:   Wed, 3 Nov 2021 11:30:44 +0800
Message-ID: <20211103033044.2777-1-ben.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to auxadc change the readback value from raw data to Vsense.
Update the tboard table that temperature map to Vsense.

pull-up voltage: 1800 mv
pull-up resistor: 75K

Vsense = pull-up voltage * Rntc / ( pull-up resistor + Rntc )

Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>

---
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 108 +++++++++---------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 8e9cf36a9a41..65447de64f06 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -151,33 +151,33 @@
 		#thermal-sensor-cells = <0>;
 		io-channels = <&auxadc 0>;
 		io-channel-names = "sensor-channel";
-		temperature-lookup-table = <    (-5000) 4241
-						0 4063
-						5000 3856
-						10000 3621
-						15000 3364
-						20000 3091
-						25000 2810
-						30000 2526
-						35000 2247
-						40000 1982
-						45000 1734
-						50000 1507
-						55000 1305
-						60000 1122
-						65000 964
-						70000 827
-						75000 710
-						80000 606
-						85000 519
-						90000 445
-						95000 382
-						100000 330
-						105000 284
-						110000 245
-						115000 213
-						120000 183
-						125000 161>;
+		temperature-lookup-table = <    (-5000) 1553
+						0 1488
+						5000 1412
+						10000 1326
+						15000 1232
+						20000 1132
+						25000 1029
+						30000 925
+						35000 823
+						40000 726
+						45000 635
+						50000 552
+						55000 478
+						60000 411
+						65000 353
+						70000 303
+						75000 260
+						80000 222
+						85000 190
+						90000 163
+						95000 140
+						100000 121
+						105000 104
+						110000 90
+						115000 78
+						120000 67
+						125000 59>;
 	};
 
 	tboard_thermistor2: thermal-sensor2 {
@@ -185,33 +185,33 @@
 		#thermal-sensor-cells = <0>;
 		io-channels = <&auxadc 1>;
 		io-channel-names = "sensor-channel";
-		temperature-lookup-table = <    (-5000) 4241
-						0 4063
-						5000 3856
-						10000 3621
-						15000 3364
-						20000 3091
-						25000 2810
-						30000 2526
-						35000 2247
-						40000 1982
-						45000 1734
-						50000 1507
-						55000 1305
-						60000 1122
-						65000 964
-						70000 827
-						75000 710
-						80000 606
-						85000 519
-						90000 445
-						95000 382
-						100000 330
-						105000 284
-						110000 245
-						115000 213
-						120000 183
-						125000 161>;
+		temperature-lookup-table = <    (-5000) 1553
+						0 1488
+						5000 1412
+						10000 1326
+						15000 1232
+						20000 1132
+						25000 1029
+						30000 925
+						35000 823
+						40000 726
+						45000 635
+						50000 552
+						55000 478
+						60000 411
+						65000 353
+						70000 303
+						75000 260
+						80000 222
+						85000 190
+						90000 163
+						95000 140
+						100000 121
+						105000 104
+						110000 90
+						115000 78
+						120000 67
+						125000 59>;
 	};
 };
 
-- 
2.18.0

