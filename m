Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ADA59E70A
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242872AbiHWQWp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243049AbiHWQW1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F3C10BE17
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:43:15 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:43:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BCZ3wVPoJEke/jTdcVMY17JHqVmRG4icUtUBkwfHeqw=;
        b=nwtVitT1+Q5GuzbvsTH9sU3TzSD7L8dscwSAj7OEp8jPmZqpfGEPrawOsyz9Km6r5bU/+Y
        0q/F9JBRxbFsmYLya3V15r38oMw0VqAD8GTE/tfhVSH70lklRTCtcLcnR0WZBZDETwpQT5
        zpGlBV9RqAPrKvBrzdLkGZJfSEE8MGnLxIpczyY1n4m/vywiKi/mY7tUKNPFoUNxp9euU2
        o4BMazZegqxmXhDw8UZDmXNfxqR+ejCs1h74rAtOX1WH2Sde90ogAOt1AlhB5HjiWDTARb
        rxzio7BtW6HubW+jipoLz7IyHCfMK0l1SF+ghVGpQCxCHJ+pWevmj//Ohi3noA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BCZ3wVPoJEke/jTdcVMY17JHqVmRG4icUtUBkwfHeqw=;
        b=7mqmwPV64hRmKx6sVgteNowdJLlVLm+8aQOObP2KZ5HnaQS/9WOJdvnpIoER19YZ7UhQz1
        8Ai7ulGMbLrzpKCw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tegra: Switch to new of API
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220804224349.1926752-8-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-8-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <166125859251.401.13579731935909894654.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     6fc2e1a5f98feb9cf0698b69c90701e0b9de2bf5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//6fc2e1a5f98feb9cf0698b69c90701e0b9de2bf5
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 05 Aug 2022 00:43:23 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:38 +02:00

thermal/drivers/tegra: Switch to new of API

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Link: https://lore.kernel.org/r/20220804224349.1926752-8-daniel.lezcano@linexp.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/tegra/soctherm.c           | 21 ++++++++++-----------
 drivers/thermal/tegra/tegra-bpmp-thermal.c | 19 ++++++++++++-------
 drivers/thermal/tegra/tegra30-tsensor.c    | 12 ++++++------
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 825eab5..1efe470 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -421,9 +421,9 @@ static int translate_temp(u16 val)
 	return t;
 }
 
-static int tegra_thermctl_get_temp(void *data, int *out_temp)
+static int tegra_thermctl_get_temp(struct thermal_zone_device *tz, int *out_temp)
 {
-	struct tegra_thermctl_zone *zone = data;
+	struct tegra_thermctl_zone *zone = tz->devdata;
 	u32 val;
 
 	val = readl(zone->reg);
@@ -582,10 +582,9 @@ static int tsensor_group_thermtrip_get(struct tegra_soctherm *ts, int id)
 	return temp;
 }
 
-static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
+static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip, int temp)
 {
-	struct tegra_thermctl_zone *zone = data;
-	struct thermal_zone_device *tz = zone->tz;
+	struct tegra_thermctl_zone *zone = tz->devdata;
 	struct tegra_soctherm *ts = zone->ts;
 	const struct tegra_tsensor_group *sg = zone->sg;
 	struct device *dev = zone->dev;
@@ -657,9 +656,9 @@ static void thermal_irq_disable(struct tegra_thermctl_zone *zn)
 	mutex_unlock(&zn->ts->thermctl_lock);
 }
 
-static int tegra_thermctl_set_trips(void *data, int lo, int hi)
+static int tegra_thermctl_set_trips(struct thermal_zone_device *tz, int lo, int hi)
 {
-	struct tegra_thermctl_zone *zone = data;
+	struct tegra_thermctl_zone *zone = tz->devdata;
 	u32 r;
 
 	thermal_irq_disable(zone);
@@ -682,7 +681,7 @@ static int tegra_thermctl_set_trips(void *data, int lo, int hi)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
+static const struct thermal_zone_device_ops tegra_of_thermal_ops = {
 	.get_temp = tegra_thermctl_get_temp,
 	.set_trip_temp = tegra_thermctl_set_trip_temp,
 	.set_trips = tegra_thermctl_set_trips,
@@ -2194,9 +2193,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		zone->sg = soc->ttgs[i];
 		zone->ts = tegra;
 
-		z = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							 soc->ttgs[i]->id, zone,
-							 &tegra_of_thermal_ops);
+		z = devm_thermal_of_zone_register(&pdev->dev,
+						  soc->ttgs[i]->id, zone,
+						  &tegra_of_thermal_ops);
 		if (IS_ERR(z)) {
 			err = PTR_ERR(z);
 			dev_err(&pdev->dev, "failed to register sensor: %d\n",
diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index 5affc3d..eb84f0b 100644
--- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
+++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
@@ -30,9 +30,9 @@ struct tegra_bpmp_thermal {
 	struct tegra_bpmp_thermal_zone **zones;
 };
 
-static int tegra_bpmp_thermal_get_temp(void *data, int *out_temp)
+static int __tegra_bpmp_thermal_get_temp(struct tegra_bpmp_thermal_zone *zone,
+					 int *out_temp)
 {
-	struct tegra_bpmp_thermal_zone *zone = data;
 	struct mrq_thermal_host_to_bpmp_request req;
 	union mrq_thermal_bpmp_to_host_response reply;
 	struct tegra_bpmp_message msg;
@@ -60,9 +60,14 @@ static int tegra_bpmp_thermal_get_temp(void *data, int *out_temp)
 	return 0;
 }
 
-static int tegra_bpmp_thermal_set_trips(void *data, int low, int high)
+static int tegra_bpmp_thermal_get_temp(struct thermal_zone_device *tz, int *out_temp)
 {
-	struct tegra_bpmp_thermal_zone *zone = data;
+	return __tegra_bpmp_thermal_get_temp(tz->devdata, out_temp);
+}
+
+static int tegra_bpmp_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct tegra_bpmp_thermal_zone *zone = tz->devdata;
 	struct mrq_thermal_host_to_bpmp_request req;
 	struct tegra_bpmp_message msg;
 	int err;
@@ -157,7 +162,7 @@ static int tegra_bpmp_thermal_get_num_zones(struct tegra_bpmp *bpmp,
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops tegra_bpmp_of_thermal_ops = {
+static const struct thermal_zone_device_ops tegra_bpmp_of_thermal_ops = {
 	.get_temp = tegra_bpmp_thermal_get_temp,
 	.set_trips = tegra_bpmp_thermal_set_trips,
 };
@@ -200,13 +205,13 @@ static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
 		zone->idx = i;
 		zone->tegra = tegra;
 
-		err = tegra_bpmp_thermal_get_temp(zone, &temp);
+		err = __tegra_bpmp_thermal_get_temp(zone, &temp);
 		if (err < 0) {
 			devm_kfree(&pdev->dev, zone);
 			continue;
 		}
 
-		tzd = devm_thermal_zone_of_sensor_register(
+		tzd = devm_thermal_of_zone_register(
 			&pdev->dev, i, zone, &tegra_bpmp_of_thermal_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -EPROBE_DEFER)
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 0588668..c345012 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -159,9 +159,9 @@ static void devm_tegra_tsensor_hw_disable(void *data)
 	tegra_tsensor_hw_disable(ts);
 }
 
-static int tegra_tsensor_get_temp(void *data, int *temp)
+static int tegra_tsensor_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	const struct tegra_tsensor_channel *tsc = data;
+	const struct tegra_tsensor_channel *tsc = tz->devdata;
 	const struct tegra_tsensor *ts = tsc->ts;
 	int err, c1, c2, c3, c4, counter;
 	u32 val;
@@ -217,9 +217,9 @@ static int tegra_tsensor_temp_to_counter(const struct tegra_tsensor *ts, int tem
 	return DIV_ROUND_CLOSEST(c2 * 1000000 - ts->calib.b, ts->calib.a);
 }
 
-static int tegra_tsensor_set_trips(void *data, int low, int high)
+static int tegra_tsensor_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	const struct tegra_tsensor_channel *tsc = data;
+	const struct tegra_tsensor_channel *tsc = tz->devdata;
 	const struct tegra_tsensor *ts = tsc->ts;
 	u32 val;
 
@@ -240,7 +240,7 @@ static int tegra_tsensor_set_trips(void *data, int low, int high)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops ops = {
+static const struct thermal_zone_device_ops ops = {
 	.get_temp = tegra_tsensor_get_temp,
 	.set_trips = tegra_tsensor_set_trips,
 };
@@ -516,7 +516,7 @@ static int tegra_tsensor_register_channel(struct tegra_tsensor *ts,
 	tsc->id = id;
 	tsc->regs = ts->regs + 0x40 * (hw_id + 1);
 
-	tsc->tzd = devm_thermal_zone_of_sensor_register(ts->dev, id, tsc, &ops);
+	tsc->tzd = devm_thermal_of_zone_register(ts->dev, id, tsc, &ops);
 	if (IS_ERR(tsc->tzd)) {
 		if (PTR_ERR(tsc->tzd) != -ENODEV)
 			return dev_err_probe(ts->dev, PTR_ERR(tsc->tzd),
