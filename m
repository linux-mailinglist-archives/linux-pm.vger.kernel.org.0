Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC5515B419
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 23:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgBLWta (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 17:49:30 -0500
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:12583 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLWt3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 17:49:29 -0500
X-Halon-ID: e64162ff-4de9-11ea-aa6d-005056917f90
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2392.dip0.t-ipconnect.de [79.202.35.146])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id e64162ff-4de9-11ea-aa6d-005056917f90;
        Wed, 12 Feb 2020 23:49:25 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] thermal: rcar_gen3_thermal: Generate interrupt when temperature changes
Date:   Wed, 12 Feb 2020 23:49:17 +0100
Message-Id: <20200212224917.737314-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The desired behavior of the driver is to generate an interrupt and call
thermal_zone_device_update() as soon as the temperature have changed
more then one degree.

When the set_trips operation was implemented it was believed that the
trip window set by the framework would move around the current
temperature and the hysteresis value described in devicetree. The
behavior of the framework is however to set a window based on the trip
points described in devicetree.

Remove the set_trips operation which was not used correctly and update
the temperatures that triggers interrupts directly from the interrupt
handler.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 72877bdc072daaed..55d1736f532cdb33 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -81,8 +81,6 @@ struct rcar_gen3_thermal_tsc {
 	void __iomem *base;
 	struct thermal_zone_device *zone;
 	struct equation_coefs coef;
-	int low;
-	int high;
 	int tj_t;
 	int id; /* thermal channel id */
 };
@@ -204,12 +202,14 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
 	return INT_FIXPT(val);
 }
 
-static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
+static int rcar_gen3_thermal_update_range(struct rcar_gen3_thermal_tsc *tsc)
 {
-	struct rcar_gen3_thermal_tsc *tsc = devdata;
+	int temperature, low, high;
 
-	low = clamp_val(low, -40000, 120000);
-	high = clamp_val(high, -40000, 120000);
+	rcar_gen3_thermal_get_temp(tsc, &temperature);
+
+	low = temperature - MCELSIUS(1);
+	high = temperature + MCELSIUS(1);
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP1,
 				rcar_gen3_thermal_mcelsius_to_temp(tsc, low));
@@ -217,15 +217,11 @@ static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP2,
 				rcar_gen3_thermal_mcelsius_to_temp(tsc, high));
 
-	tsc->low = low;
-	tsc->high = high;
-
 	return 0;
 }
 
 static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
 	.get_temp	= rcar_gen3_thermal_get_temp,
-	.set_trips	= rcar_gen3_thermal_set_trips,
 };
 
 static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
@@ -246,9 +242,11 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
 	for (i = 0; i < priv->num_tscs; i++) {
 		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
 		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
-		if (status)
+		if (status) {
+			rcar_gen3_thermal_update_range(priv->tscs[i]);
 			thermal_zone_device_update(priv->tscs[i]->zone,
 						   THERMAL_EVENT_UNSPECIFIED);
+		}
 	}
 
 	return IRQ_HANDLED;
@@ -454,6 +452,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto error_unregister;
 
+		rcar_gen3_thermal_update_range(tsc);
+
 		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
 	}
 
@@ -492,7 +492,7 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
 		priv->thermal_init(tsc);
-		rcar_gen3_thermal_set_trips(tsc, tsc->low, tsc->high);
+		rcar_gen3_thermal_update_range(tsc);
 	}
 
 	rcar_thermal_irq_set(priv, true);
-- 
2.25.0

