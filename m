Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB906689921
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 13:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjBCMuj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 07:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjBCMug (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 07:50:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DAF9AFF7
        for <linux-pm@vger.kernel.org>; Fri,  3 Feb 2023 04:50:32 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pNvWE-0000ao-5I; Fri, 03 Feb 2023 13:50:18 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pNvWA-002Opb-M6; Fri, 03 Feb 2023 13:50:15 +0100
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pNvW9-000Zl5-VL; Fri, 03 Feb 2023 13:50:13 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pegutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 06/18] PM / devfreq: rockchip-dfi: Use free running counter
Date:   Fri,  3 Feb 2023 13:50:00 +0100
Message-Id: <20230203125012.3804008-7-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230203125012.3804008-1-s.hauer@pengutronix.de>
References: <20230203125012.3804008-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The DDR_MON counters are free running counters. These are resetted to 0
when starting them over like currently done when reading the current
counter values.

Resetting the counters becomes a problem with perf support we want to
add later, because perf needs a monotonicly increasing counter.

This patch removes resetting the counters and keeps them running
instead. Counter overflows are handled with modular arithmetics. Not
stopping the counters also has the impact that they are running while
we are reading them. We cannot read multiple timers atomically, so
the values do not exactly fit together. The effect should be negligible
though as the time between two measurements is some orders of magnitude
bigger than the time we need to read multiple registers.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/devfreq/event/rockchip-dfi.c | 53 ++++++++++++++++------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 383fe8a17a512..25d64d9166a9a 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -38,11 +38,15 @@
 #define DDRMON_CH1_COUNT_NUM		0x3c
 #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
 
-struct dmc_usage {
+struct dmc_count_channel {
 	u32 access;
 	u32 total;
 };
 
+struct dmc_count {
+	struct dmc_count_channel c[RK3399_DMC_NUM_CH];
+};
+
 /*
  * The dfi controller can monitor DDR load. It has an upper and lower threshold
  * for the operating points. Whenever the usage leaves these bounds an event is
@@ -51,7 +55,8 @@ struct dmc_usage {
 struct rockchip_dfi {
 	struct devfreq_event_dev *edev;
 	struct devfreq_event_desc desc;
-	struct dmc_usage ch_usage[RK3399_DMC_NUM_CH];
+	struct dmc_count count;
+	struct dmc_count last_event_count;
 	struct device *dev;
 	void __iomem *regs;
 	struct regmap *regmap_pmu;
@@ -85,30 +90,18 @@ static void rockchip_dfi_stop_hardware_counter(struct devfreq_event_dev *edev)
 	writel_relaxed(SOFTWARE_DIS, dfi_regs + DDRMON_CTRL);
 }
 
-static int rockchip_dfi_get_busier_ch(struct devfreq_event_dev *edev)
+static void rockchip_dfi_read_counters(struct devfreq_event_dev *edev, struct dmc_count *count)
 {
 	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
-	u32 tmp, max = 0;
-	u32 i, busier_ch = 0;
+	u32 i;
 	void __iomem *dfi_regs = dfi->regs;
 
-	rockchip_dfi_stop_hardware_counter(edev);
-
-	/* Find out which channel is busier */
 	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
-		dfi->ch_usage[i].access = readl_relaxed(dfi_regs +
+		count->c[i].access = readl_relaxed(dfi_regs +
 				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
-		dfi->ch_usage[i].total = readl_relaxed(dfi_regs +
+		count->c[i].total = readl_relaxed(dfi_regs +
 				DDRMON_CH0_COUNT_NUM + i * 20);
-		tmp = dfi->ch_usage[i].access;
-		if (tmp > max) {
-			busier_ch = i;
-			max = tmp;
-		}
 	}
-	rockchip_dfi_start_hardware_counter(edev);
-
-	return busier_ch;
 }
 
 static int rockchip_dfi_disable(struct devfreq_event_dev *edev)
@@ -145,12 +138,28 @@ static int rockchip_dfi_get_event(struct devfreq_event_dev *edev,
 				  struct devfreq_event_data *edata)
 {
 	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
-	int busier_ch;
+	struct dmc_count count;
+	struct dmc_count *last = &dfi->last_event_count;
+	u32 access = 0, total = 0;
+	int i;
+
+	rockchip_dfi_read_counters(edev, &count);
+
+	/* We can only report one channel, so find the busiest one */
+	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
+		u32 a = count.c[i].access - last->c[i].access;
+		u32 t = count.c[i].total - last->c[i].total;
+
+		if (a > access) {
+			access = a;
+			total = t;
+		}
+	}
 
-	busier_ch = rockchip_dfi_get_busier_ch(edev);
+	edata->load_count = access * 4;
+	edata->total_count = total;
 
-	edata->load_count = dfi->ch_usage[busier_ch].access * 4;
-	edata->total_count = dfi->ch_usage[busier_ch].total;
+	dfi->last_event_count = count;
 
 	return 0;
 }
-- 
2.30.2

