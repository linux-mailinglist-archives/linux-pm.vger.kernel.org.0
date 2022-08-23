Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469A259E71B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243943AbiHWQWo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242872AbiHWQW0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927AF275BA9
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:43:11 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:43:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EiGEcSOEFp0U6AU1EZOeSVCxcun/ED8z0a9DROvzrPs=;
        b=fjWG+uVj0MS+x9RNjMbqpqH8FG4PBArXJs26adNTqu+evarRnqzzpq0kkbaj4LHf6s++oI
        mutQxE7X/xA61oqUHEwSH1EqDeydpgXPPZcbRE+PMIJqfY2WMNh1jx47I18hTX/XHMWTc8
        ynt3lJ+OkvlYuB+dhMF2Ya29Ckt0Q84W5wJXGXwlzMnMwLP2prjyenn2FFQG2F2MR5mJ6I
        pbmC5ltd0jZuLwuvYzLVrXMPT5MYlyV3oYwxYR6bmfiwATmLzvxQQ6JbPOCzgA1CDfnxqa
        gvM+JunRwocRcZOXSBTcDJL6Mkxns0vZF6MXJbthGlwY2MWLkNagDP+fr3qIMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EiGEcSOEFp0U6AU1EZOeSVCxcun/ED8z0a9DROvzrPs=;
        b=oFithhKOxVd97TnRCZOeOXdWloNKBN/Iepvg16rV0ILc7AldnlIdBK5YIw2Y46KSKga26s
        VGzZgpdPVFWp+DDw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom: Switch to new of API
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220804224349.1926752-12-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-12-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <166125858857.401.10215079252799174884.tip-bot2@tip-bot2>
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

Commit-ID:     ca1b9a9eb3fdbb9aa39d0c174391af694ae77671
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ca1b9a9eb3fdbb9aa39d0c174391af694ae77671
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 05 Aug 2022 00:43:27 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:38 +02:00

thermal/drivers/qcom: Switch to new of API

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20220804224349.1926752-12-daniel.lezcano@linexp.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c    | 19 +++++++++----------
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 12 ++++++------
 drivers/thermal/qcom/tsens.c                | 16 ++++++++--------
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 073943c..add6f40 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -357,9 +357,9 @@ static irqreturn_t adc_tm5_gen2_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int adc_tm5_get_temp(void *data, int *temp)
+static int adc_tm5_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct adc_tm5_channel *channel = data;
+	struct adc_tm5_channel *channel = tz->devdata;
 	int ret;
 
 	if (!channel || !channel->iio)
@@ -639,9 +639,9 @@ config_fail:
 	return ret;
 }
 
-static int adc_tm5_set_trips(void *data, int low, int high)
+static int adc_tm5_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct adc_tm5_channel *channel = data;
+	struct adc_tm5_channel *channel = tz->devdata;
 	struct adc_tm5_chip *chip;
 	int ret;
 
@@ -660,7 +660,7 @@ static int adc_tm5_set_trips(void *data, int low, int high)
 	return ret;
 }
 
-static struct thermal_zone_of_device_ops adc_tm5_thermal_ops = {
+static const struct thermal_zone_device_ops adc_tm5_thermal_ops = {
 	.get_temp = adc_tm5_get_temp,
 	.set_trips = adc_tm5_set_trips,
 };
@@ -672,11 +672,10 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 
 	for (i = 0; i < adc_tm->nchannels; i++) {
 		adc_tm->channels[i].chip = adc_tm;
-
-		tzd = devm_thermal_zone_of_sensor_register(adc_tm->dev,
-							   adc_tm->channels[i].channel,
-							   &adc_tm->channels[i],
-							   &adc_tm5_thermal_ops);
+		tzd = devm_thermal_of_zone_register(adc_tm->dev,
+						    adc_tm->channels[i].channel,
+						    &adc_tm->channels[i],
+						    &adc_tm5_thermal_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV) {
 				dev_warn(adc_tm->dev, "thermal sensor on channel %d is not used\n",
diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 770f82c..be785ab 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -186,9 +186,9 @@ static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
 	return 0;
 }
 
-static int qpnp_tm_get_temp(void *data, int *temp)
+static int qpnp_tm_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct qpnp_tm_chip *chip = data;
+	struct qpnp_tm_chip *chip = tz->devdata;
 	int ret, mili_celsius;
 
 	if (!temp)
@@ -263,9 +263,9 @@ skip:
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
 }
 
-static int qpnp_tm_set_trip_temp(void *data, int trip, int temp)
+static int qpnp_tm_set_trip_temp(struct thermal_zone_device *tz, int trip, int temp)
 {
-	struct qpnp_tm_chip *chip = data;
+	struct qpnp_tm_chip *chip = tz->devdata;
 	const struct thermal_trip *trip_points;
 	int ret;
 
@@ -283,7 +283,7 @@ static int qpnp_tm_set_trip_temp(void *data, int trip, int temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops qpnp_tm_sensor_ops = {
+static const struct thermal_zone_device_ops qpnp_tm_sensor_ops = {
 	.get_temp = qpnp_tm_get_temp,
 	.set_trip_temp = qpnp_tm_set_trip_temp,
 };
@@ -446,7 +446,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	 * read the trip points. get_temp() returns the default temperature
 	 * before the hardware initialization is completed.
 	 */
-	chip->tz_dev = devm_thermal_zone_of_sensor_register(
+	chip->tz_dev = devm_thermal_of_zone_register(
 		&pdev->dev, 0, chip, &qpnp_tm_sensor_ops);
 	if (IS_ERR(chip->tz_dev)) {
 		dev_err(&pdev->dev, "failed to register sensor\n");
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index e49f58e..b1b1000 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -532,9 +532,9 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int tsens_set_trips(void *_sensor, int low, int high)
+static int tsens_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct tsens_sensor *s = _sensor;
+	struct tsens_sensor *s = tz->devdata;
 	struct tsens_priv *priv = s->priv;
 	struct device *dev = priv->dev;
 	struct tsens_irq_data d;
@@ -925,9 +925,9 @@ err_put_device:
 	return ret;
 }
 
-static int tsens_get_temp(void *data, int *temp)
+static int tsens_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct tsens_sensor *s = data;
+	struct tsens_sensor *s = tz->devdata;
 	struct tsens_priv *priv = s->priv;
 
 	return priv->ops->get_temp(s, temp);
@@ -991,7 +991,7 @@ static const struct of_device_id tsens_table[] = {
 };
 MODULE_DEVICE_TABLE(of, tsens_table);
 
-static const struct thermal_zone_of_device_ops tsens_of_ops = {
+static const struct thermal_zone_device_ops tsens_of_ops = {
 	.get_temp = tsens_get_temp,
 	.set_trips = tsens_set_trips,
 };
@@ -1044,9 +1044,9 @@ static int tsens_register(struct tsens_priv *priv)
 
 	for (i = 0;  i < priv->num_sensors; i++) {
 		priv->sensor[i].priv = priv;
-		tzd = devm_thermal_zone_of_sensor_register(priv->dev, priv->sensor[i].hw_id,
-							   &priv->sensor[i],
-							   &tsens_of_ops);
+		tzd = devm_thermal_of_zone_register(priv->dev, priv->sensor[i].hw_id,
+						    &priv->sensor[i],
+						    &tsens_of_ops);
 		if (IS_ERR(tzd))
 			continue;
 		priv->sensor[i].tzd = tzd;
