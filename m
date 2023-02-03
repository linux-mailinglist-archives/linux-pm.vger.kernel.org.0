Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818B4689919
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 13:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjBCMug (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 07:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjBCMud (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 07:50:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F9B9A803
        for <linux-pm@vger.kernel.org>; Fri,  3 Feb 2023 04:50:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pNvWI-0000bS-ES; Fri, 03 Feb 2023 13:50:22 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pNvWB-002Opw-E8; Fri, 03 Feb 2023 13:50:16 +0100
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pNvW9-000ZlD-W9; Fri, 03 Feb 2023 13:50:14 +0100
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
Subject: [PATCH 07/18] PM / devfreq: rockchip-dfi: introduce channel mask
Date:   Fri,  3 Feb 2023 13:50:01 +0100
Message-Id: <20230203125012.3804008-8-s.hauer@pengutronix.de>
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

Different Rockchip SoC variants have a different number of channels.
Introduce a channel mask to make the number of channels configurable
from SoC initialization code.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/devfreq/event/rockchip-dfi.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 25d64d9166a9a..18d578730fd0c 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -21,7 +21,7 @@
 
 #include <soc/rockchip/rk3399_grf.h>
 
-#define RK3399_DMC_NUM_CH	2
+#define DMC_MAX_CHANNELS	2
 
 /* DDRMON_CTRL */
 #define DDRMON_CTRL	0x04
@@ -44,7 +44,7 @@ struct dmc_count_channel {
 };
 
 struct dmc_count {
-	struct dmc_count_channel c[RK3399_DMC_NUM_CH];
+	struct dmc_count_channel c[DMC_MAX_CHANNELS];
 };
 
 /*
@@ -62,6 +62,7 @@ struct rockchip_dfi {
 	struct regmap *regmap_pmu;
 	struct clk *clk;
 	u32 ddr_type;
+	unsigned int channel_mask;
 };
 
 static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
@@ -96,7 +97,9 @@ static void rockchip_dfi_read_counters(struct devfreq_event_dev *edev, struct dm
 	u32 i;
 	void __iomem *dfi_regs = dfi->regs;
 
-	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
+	for (i = 0; i < DMC_MAX_CHANNELS; i++) {
+		if (!(dfi->channel_mask & BIT(i)))
+			continue;
 		count->c[i].access = readl_relaxed(dfi_regs +
 				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
 		count->c[i].total = readl_relaxed(dfi_regs +
@@ -146,9 +149,14 @@ static int rockchip_dfi_get_event(struct devfreq_event_dev *edev,
 	rockchip_dfi_read_counters(edev, &count);
 
 	/* We can only report one channel, so find the busiest one */
-	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
-		u32 a = count.c[i].access - last->c[i].access;
-		u32 t = count.c[i].total - last->c[i].total;
+	for (i = 0; i < DMC_MAX_CHANNELS; i++) {
+		u32 a, t;
+
+		if (!(dfi->channel_mask & BIT(i)))
+			continue;
+
+		a = count.c[i].access - last->c[i].access;
+		t = count.c[i].total - last->c[i].total;
 
 		if (a > access) {
 			access = a;
@@ -186,6 +194,8 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
 	dfi->ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
 			RK3399_PMUGRF_DDRTYPE_MASK;
 
+	dfi->channel_mask = 3;
+
 	return 0;
 };
 
-- 
2.30.2

