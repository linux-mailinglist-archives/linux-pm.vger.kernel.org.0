Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BAA68991D
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 13:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjBCMui (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 07:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjBCMug (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 07:50:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AFF9AFC3
        for <linux-pm@vger.kernel.org>; Fri,  3 Feb 2023 04:50:32 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pNvWI-0000bW-GB; Fri, 03 Feb 2023 13:50:22 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pNvWB-002Oq4-KF; Fri, 03 Feb 2023 13:50:16 +0100
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pNvWA-000ZlH-0m; Fri, 03 Feb 2023 13:50:14 +0100
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
Subject: [PATCH 08/18] PM / devfreq: rk3399_dmc,dfi: generalize DDRTYPE defines
Date:   Fri,  3 Feb 2023 13:50:02 +0100
Message-Id: <20230203125012.3804008-9-s.hauer@pengutronix.de>
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

The DDRTYPE defines are named to be RK3399 specific, but they can be
used for other Rockchip SoCs as well, so replace the RK3399_PMUGRF_
prefix with ROCKCHIP_. They are defined in a SoC specific header
file, so when generalizing the prefix also move the new defines to
a SoC agnostic header file. While at it use GENMASK to define the
DDRTYPE bitfield and give it a name including the full register name.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/devfreq/event/rockchip-dfi.c | 10 ++++++----
 drivers/devfreq/rk3399_dmc.c         | 10 +++++-----
 include/soc/rockchip/rk3399_grf.h    |  7 +------
 include/soc/rockchip/rockchip_grf.h  | 15 +++++++++++++++
 4 files changed, 27 insertions(+), 15 deletions(-)
 create mode 100644 include/soc/rockchip/rockchip_grf.h

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 18d578730fd0c..7896cd8beb143 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -18,7 +18,10 @@
 #include <linux/list.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 
+#include <soc/rockchip/rockchip_grf.h>
 #include <soc/rockchip/rk3399_grf.h>
 
 #define DMC_MAX_CHANNELS	2
@@ -74,9 +77,9 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
 	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
 
 	/* set ddr type to dfi */
-	if (dfi->ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
+	if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR3)
 		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
-	else if (dfi->ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
+	else if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR4)
 		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
 
 	/* enable count, use software mode */
@@ -191,8 +194,7 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
 
 	/* get ddr type */
 	regmap_read(regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
-	dfi->ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
-			RK3399_PMUGRF_DDRTYPE_MASK;
+	dfi->ddr_type = FIELD_GET(RK3399_PMUGRF_OS_REG2_DDRTYPE, val);
 
 	dfi->channel_mask = 3;
 
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index daff407026157..fd2c5ffedf41e 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -22,6 +22,7 @@
 #include <linux/suspend.h>
 
 #include <soc/rockchip/pm_domains.h>
+#include <soc/rockchip/rockchip_grf.h>
 #include <soc/rockchip/rk3399_grf.h>
 #include <soc/rockchip/rockchip_sip.h>
 
@@ -381,17 +382,16 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	}
 
 	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
-	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
-		    RK3399_PMUGRF_DDRTYPE_MASK;
+	ddr_type = FIELD_GET(RK3399_PMUGRF_OS_REG2_DDRTYPE, val);
 
 	switch (ddr_type) {
-	case RK3399_PMUGRF_DDRTYPE_DDR3:
+	case ROCKCHIP_DDRTYPE_DDR3:
 		data->odt_dis_freq = data->ddr3_odt_dis_freq;
 		break;
-	case RK3399_PMUGRF_DDRTYPE_LPDDR3:
+	case ROCKCHIP_DDRTYPE_LPDDR3:
 		data->odt_dis_freq = data->lpddr3_odt_dis_freq;
 		break;
-	case RK3399_PMUGRF_DDRTYPE_LPDDR4:
+	case ROCKCHIP_DDRTYPE_LPDDR4:
 		data->odt_dis_freq = data->lpddr4_odt_dis_freq;
 		break;
 	default:
diff --git a/include/soc/rockchip/rk3399_grf.h b/include/soc/rockchip/rk3399_grf.h
index 3eebabcb28123..775f8444bea8d 100644
--- a/include/soc/rockchip/rk3399_grf.h
+++ b/include/soc/rockchip/rk3399_grf.h
@@ -11,11 +11,6 @@
 
 /* PMU GRF Registers */
 #define RK3399_PMUGRF_OS_REG2		0x308
-#define RK3399_PMUGRF_DDRTYPE_SHIFT	13
-#define RK3399_PMUGRF_DDRTYPE_MASK	7
-#define RK3399_PMUGRF_DDRTYPE_DDR3	3
-#define RK3399_PMUGRF_DDRTYPE_LPDDR2	5
-#define RK3399_PMUGRF_DDRTYPE_LPDDR3	6
-#define RK3399_PMUGRF_DDRTYPE_LPDDR4	7
+#define RK3399_PMUGRF_OS_REG2_DDRTYPE		GENMASK(15, 13)
 
 #endif
diff --git a/include/soc/rockchip/rockchip_grf.h b/include/soc/rockchip/rockchip_grf.h
new file mode 100644
index 0000000000000..dc77bb762a05a
--- /dev/null
+++ b/include/soc/rockchip/rockchip_grf.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Rockchip General Register Files definitions
+ */
+
+#ifndef __SOC_ROCKCHIP_GRF_H
+#define __SOC_ROCKCHIP_GRF_H
+
+/* Rockchip DDRTYPE defines */
+#define ROCKCHIP_DDRTYPE_DDR3	3
+#define ROCKCHIP_DDRTYPE_LPDDR2	5
+#define ROCKCHIP_DDRTYPE_LPDDR3	6
+#define ROCKCHIP_DDRTYPE_LPDDR4	7
+
+#endif /* __SOC_ROCKCHIP_GRF_H */
-- 
2.30.2

