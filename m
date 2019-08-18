Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B02B91714
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 16:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfHROEi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Aug 2019 10:04:38 -0400
Received: from mxwww.masterlogin.de ([95.129.51.220]:43026 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfHROE0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Aug 2019 10:04:26 -0400
Received: from mxout2.routing.net (unknown [192.168.10.82])
        by new.mxwww.masterlogin.de (Postfix) with ESMTPS id 2897096DF2;
        Sun, 18 Aug 2019 13:56:25 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.253])
        by mxout2.routing.net (Postfix) with ESMTP id 738156207B;
        Sun, 18 Aug 2019 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (fttx-pool-185.53.43.183.bambit.de [185.53.43.183])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id AA8F336008B;
        Sun, 18 Aug 2019 15:56:24 +0200 (CEST)
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org,
        "linux-arm-kernel @ lists . infradead . org Alessandro Zummo" 
        <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        "Tianping Fang" <tianping.fang@mediatek.com>
Subject: [PATCH v6 03/13] dt-bindings: mfd: mediatek: add mt6323 power-controller
Date:   Sun, 18 Aug 2019 15:56:01 +0200
Message-Id: <20190818135611.7776-4-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818135611.7776-1-frank-w@public-files.de>
References: <20190818135611.7776-1-frank-w@public-files.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

- add powercontroller-section to existing binding-document
- add mt6323-pwrc bindings-document with example

Suggested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
changes since v5: split out non-pwrc related changes
changes since v4: none
changes since v3: none
changes since v2: none (=v2 part 7)
---
 .../devicetree/bindings/mfd/mt6397.txt        |  6 ++++++
 .../bindings/power/reset/mt6323-poweroff.txt  | 20 +++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 5fccf987865b..a9b105ac00a8 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -8,6 +8,7 @@ MT6397/MT6323 is a multifunction device with the following sub modules:
 - Clock
 - LED
 - Keys
+- Power controller
 
 It is interfaced to host controller using SPI interface by a proprietary hardware
 called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
@@ -48,6 +49,11 @@ Optional subnodes:
 		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
 	see ../input/mtk-pmic-keys.txt
 
+- power-controller
+	Required properties:
+		- compatible: "mediatek,mt6323-pwrc"
+	For details, see ../power/reset/mt6323-poweroff.txt
+
 Example:
 	pwrap: pwrap@1000f000 {
 		compatible = "mediatek,mt8135-pwrap";
diff --git a/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
new file mode 100644
index 000000000000..933f0c48e887
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
@@ -0,0 +1,20 @@
+Device Tree Bindings for Power Controller on MediaTek PMIC
+
+The power controller which could be found on PMIC is responsible for externally
+powering off or on the remote MediaTek SoC through the circuit BBPU.
+
+Required properties:
+- compatible: Should be one of follows
+       "mediatek,mt6323-pwrc": for MT6323 PMIC
+
+Example:
+
+       pmic {
+               compatible = "mediatek,mt6323";
+
+               ...
+
+               power-controller {
+                       compatible = "mediatek,mt6323-pwrc";
+               };
+       }
-- 
2.17.1

