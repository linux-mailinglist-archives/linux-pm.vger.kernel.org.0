Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F13E59E6FE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbiHWQWf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244223AbiHWQWF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2086C10B512
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:42:58 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:42:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y01XZhyP3RCbmF7fACEkpX0NR3z23L7obHeZEFbTHlk=;
        b=Hvir+jpWP2euQcmJVvIh2mnhX4d5dfhG/xnVqojY7Idf/QWZVoAm9Q5QwN/9wEy5G8vQ5V
        NWvhP1D2hipLGQ22S7ltPpjoMtc6IPW/dYVLRe17WVw9oLtbvHzfui+6PXNNMVFBuSuuAy
        W2cmR44d0is/f15OipvyG5+IGYJ/lR8rjeVrD93BT5Cws63kQb7FhfPiKsO2IeJg3AKwXD
        lceXSKsPwHY8JFQUqSe1PpvAoZyriP0DfJoHECItGlRrOBfmpwoeHscSsNreFdbRdOf556
        JTiPsk9drnLzgn7Hu0dYFd4azoBMnXY9jOPCL9gdujgyTg6mR906+8JO0Z/AIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y01XZhyP3RCbmF7fACEkpX0NR3z23L7obHeZEFbTHlk=;
        b=TLZ/bKolp4gX9+6MZndJHW0SeiSDHZxHDqYSkzj7DeTyCmfeV4wIdkCRkwxUGIuXoOM7PC
        Ndf+eNmBugU+fbAw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/ti-soc: Switch to new of API
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Keerthy <j-keerthy@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220804224349.1926752-25-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-25-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <166125857558.401.6528884854648399104.tip-bot2@tip-bot2>
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

Commit-ID:     2cf3c72a3ffba080b8188a07c19514cd43df6097
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//2cf3c72a3ffba080b8188a07c19514cd43df6097
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 05 Aug 2022 00:43:40 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:38 +02:00

thermal/drivers/ti-soc: Switch to new of API

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Link: https://lore.kernel.org/r/20220804224349.1926752-25-daniel.lezcano@linexp.org
Acked-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 16 ++++++-------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 703039d..8a9055b 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -65,10 +65,10 @@ static inline int ti_thermal_hotspot_temperature(int t, int s, int c)
 
 /* thermal zone ops */
 /* Get temperature callback function for thermal zone */
-static inline int __ti_thermal_get_temp(void *devdata, int *temp)
+static inline int __ti_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct thermal_zone_device *pcb_tz = NULL;
-	struct ti_thermal_data *data = devdata;
+	struct ti_thermal_data *data = tz->devdata;
 	struct ti_bandgap *bgp;
 	const struct ti_temp_sensor *s;
 	int ret, tmp, slope, constant;
@@ -85,8 +85,8 @@ static inline int __ti_thermal_get_temp(void *devdata, int *temp)
 		return ret;
 
 	/* Default constants */
-	slope = thermal_zone_get_slope(data->ti_thermal);
-	constant = thermal_zone_get_offset(data->ti_thermal);
+	slope = thermal_zone_get_slope(tz);
+	constant = thermal_zone_get_offset(tz);
 
 	pcb_tz = data->pcb_tz;
 	/* In case pcb zone is available, use the extrapolation rule with it */
@@ -107,9 +107,9 @@ static inline int __ti_thermal_get_temp(void *devdata, int *temp)
 	return ret;
 }
 
-static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
+static int __ti_thermal_get_trend(struct thermal_zone_device *tz, int trip, enum thermal_trend *trend)
 {
-	struct ti_thermal_data *data = p;
+	struct ti_thermal_data *data = tz->devdata;
 	struct ti_bandgap *bgp;
 	int id, tr, ret = 0;
 
@@ -130,7 +130,7 @@ static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops ti_of_thermal_ops = {
+static const struct thermal_zone_device_ops ti_of_thermal_ops = {
 	.get_temp = __ti_thermal_get_temp,
 	.get_trend = __ti_thermal_get_trend,
 };
@@ -170,7 +170,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 		return -EINVAL;
 
 	/* in case this is specified by DT */
-	data->ti_thermal = devm_thermal_zone_of_sensor_register(bgp->dev, id,
+	data->ti_thermal = devm_thermal_of_zone_register(bgp->dev, id,
 					data, &ti_of_thermal_ops);
 	if (IS_ERR(data->ti_thermal)) {
 		dev_err(bgp->dev, "thermal zone device is NULL\n");
