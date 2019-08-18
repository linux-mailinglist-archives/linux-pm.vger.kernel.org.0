Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0654E91715
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfHROEi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Aug 2019 10:04:38 -0400
Received: from mxwww.masterlogin.de ([95.129.51.220]:43034 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfHROE0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Aug 2019 10:04:26 -0400
Received: from mxout1.routing.net (unknown [192.168.10.81])
        by new.mxwww.masterlogin.de (Postfix) with ESMTPS id 7FA6696DFB;
        Sun, 18 Aug 2019 13:56:30 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.253])
        by mxout1.routing.net (Postfix) with ESMTP id BF88743D5A;
        Sun, 18 Aug 2019 13:56:30 +0000 (UTC)
Received: from localhost.localdomain (fttx-pool-185.53.43.183.bambit.de [185.53.43.183])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id EAAAC36043A;
        Sun, 18 Aug 2019 15:56:29 +0200 (CEST)
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
Subject: [PATCH v6 10/13] mfd: mt6323: add mt6323 rtc+pwrc
Date:   Sun, 18 Aug 2019 15:56:08 +0200
Message-Id: <20190818135611.7776-11-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818135611.7776-1-frank-w@public-files.de>
References: <20190818135611.7776-1-frank-w@public-files.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

add entry for rtc and power-controller to mt6323

Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
changes since v5: none
changes since v4: none
changes since v3: none
changes since v2: only splitting, second part of v2 part 4
---
 drivers/mfd/mt6397-core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index c9a81087fa55..5916978a8feb 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -16,13 +16,24 @@
 #include <linux/mfd/mt6397/registers.h>
 #include <linux/mfd/mt6323/registers.h>
 
+#define MT6323_RTC_BASE		0x8000
+#define MT6323_RTC_SIZE		0x40
+
 #define MT6397_RTC_BASE		0xe000
 #define MT6397_RTC_SIZE		0x3e
 
+#define MT6323_PWRC_BASE	0x8000
+#define MT6323_PWRC_SIZE	0x40
+
 #define MT6323_CID_CODE		0x23
 #define MT6391_CID_CODE		0x91
 #define MT6397_CID_CODE		0x97
 
+static const struct resource mt6323_rtc_resources[] = {
+	DEFINE_RES_MEM(MT6323_RTC_BASE, MT6323_RTC_SIZE),
+	DEFINE_RES_IRQ(MT6323_IRQ_STATUS_RTC),
+};
+
 static const struct resource mt6397_rtc_resources[] = {
 	DEFINE_RES_MEM(MT6397_RTC_BASE, MT6397_RTC_SIZE),
 	DEFINE_RES_IRQ(MT6397_IRQ_RTC),
@@ -38,8 +49,17 @@ static const struct resource mt6397_keys_resources[] = {
 	DEFINE_RES_IRQ(MT6397_IRQ_HOMEKEY),
 };
 
+static const struct resource mt6323_pwrc_resources[] = {
+	DEFINE_RES_MEM(MT6323_PWRC_BASE, MT6323_PWRC_SIZE),
+};
+
 static const struct mfd_cell mt6323_devs[] = {
 	{
+		.name = "mt6323-rtc",
+		.num_resources = ARRAY_SIZE(mt6323_rtc_resources),
+		.resources = mt6323_rtc_resources,
+		.of_compatible = "mediatek,mt6323-rtc",
+	}, {
 		.name = "mt6323-regulator",
 		.of_compatible = "mediatek,mt6323-regulator"
 	}, {
@@ -50,6 +70,11 @@ static const struct mfd_cell mt6323_devs[] = {
 		.num_resources = ARRAY_SIZE(mt6323_keys_resources),
 		.resources = mt6323_keys_resources,
 		.of_compatible = "mediatek,mt6323-keys"
+	}, {
+		.name = "mt6323-pwrc",
+		.num_resources = ARRAY_SIZE(mt6323_pwrc_resources),
+		.resources = mt6323_pwrc_resources,
+		.of_compatible = "mediatek,mt6323-pwrc"
 	},
 };
 
-- 
2.17.1

