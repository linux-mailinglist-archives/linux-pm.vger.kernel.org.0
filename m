Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED35391719
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 16:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfHROEh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Aug 2019 10:04:37 -0400
Received: from mxwww.masterlogin.de ([95.129.51.220]:43038 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfHROE0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Aug 2019 10:04:26 -0400
Received: from mxout2.routing.net (unknown [192.168.10.82])
        by new.mxwww.masterlogin.de (Postfix) with ESMTPS id D27A496DF7;
        Sun, 18 Aug 2019 13:56:25 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.253])
        by mxout2.routing.net (Postfix) with ESMTP id 333C96207B;
        Sun, 18 Aug 2019 13:56:26 +0000 (UTC)
Received: from localhost.localdomain (fttx-pool-185.53.43.183.bambit.de [185.53.43.183])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 6C84136043A;
        Sun, 18 Aug 2019 15:56:25 +0200 (CEST)
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
Subject: [PATCH v6 04/13] dt-bindings: rtc: mediatek: add missing mt6397 rtc
Date:   Sun, 18 Aug 2019 15:56:02 +0200
Message-Id: <20190818135611.7776-5-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818135611.7776-1-frank-w@public-files.de>
References: <20190818135611.7776-1-frank-w@public-files.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

add missing devicetree-binding document for mt6397 rtc
in later patch driver is extended with mt6323 chip

Suggested-By: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
changes since v5: none
changes since v4: use relative path
changes since v3: moved SOB
changes since v2: splitted rtc-mt6397.txt from first patch
---
 .../devicetree/bindings/rtc/rtc-mt6397.txt    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
new file mode 100644
index 000000000000..55a0c8874c03
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
@@ -0,0 +1,29 @@
+Device-Tree bindings for MediaTek PMIC based RTC
+
+MediaTek PMIC based RTC is an independent function of MediaTek PMIC that works
+as a type of multi-function device (MFD). The RTC can be configured and set up
+with PMIC wrapper bus which is a common resource shared with the other
+functions found on the same PMIC.
+
+For MediaTek PMIC MFD bindings, see:
+../mfd/mt6397.txt
+
+For MediaTek PMIC wrapper bus bindings, see:
+../soc/mediatek/pwrap.txt
+
+Required properties:
+- compatible: Should be one of follows
+       "mediatek,mt6323-rtc": for MT6323 PMIC
+       "mediatek,mt6397-rtc": for MT6397 PMIC
+
+Example:
+
+       pmic {
+               compatible = "mediatek,mt6323";
+
+               ...
+
+               rtc {
+                       compatible = "mediatek,mt6323-rtc";
+               };
+       };
-- 
2.17.1

