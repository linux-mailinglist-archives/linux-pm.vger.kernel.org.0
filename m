Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264E664854C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLIP1T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiLIP0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598028E5A0
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:37 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iqXJlBxpYBFDbXF32oOvFwrHYHBEl0l076wzNgCvcfA=;
        b=ugWaqSxkBd98+euNCWwTHKbj8nPJnkEYq9zaqIZip8jxNBowYMHjV1UjaQYkpjihpkul1l
        IsXIE2o7lGj22dtOiJBP/wOMVTPWbErSQfCw0//JhhWu+N8ZGmJcMYWJ/5Xb/o4AogX3Ub
        FCiCKcVnGkumRpA5MIZFOJUJifNjE4PvipKUu7GgzvxnIvfG+Sisa9N3akuF8dSWgVwJx4
        q3z9gi23ugnnj4kIQP4Omu1V1LbsIcn8Ft2wMSblotPHgEtGrgehRbRFntP3DcyyHehzNS
        m5FchuL2SSr02XaNrU1JR1xvHGHlwmgEurPGvNAxEVVU+myKKjAR9s4g4Eey+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iqXJlBxpYBFDbXF32oOvFwrHYHBEl0l076wzNgCvcfA=;
        b=yOd6GmkX4U2jSX4CtwL8sh5cHwiq1aKq7KWYM6I7m74Wr6M+b5CZp0oL258V7v04HAanSu
        xZW9l0JciOjBnlDg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/imx: Use generic
 thermal_zone_get_trip() function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20221003092602.1323944-22-daniel.lezcano@linaro.org>
References: <20221003092602.1323944-22-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959334.4906.17640227207955490810.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     4e87d98cd6fb918baf227a07cd02e922d6c04eb9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//4e87d98cd6fb918baf227a07cd02e922d6c04eb9
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 11:25:54 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:42 +01:00

thermal/drivers/imx: Use generic thermal_zone_get_trip() function

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20221003092602.1323944-22-daniel.lezcano@lina=
ro.org
---
 drivers/thermal/imx_thermal.c | 72 ++++++++++++----------------------
 1 file changed, 27 insertions(+), 45 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 1666337..fb0d5ca 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -76,7 +76,6 @@
 enum imx_thermal_trip {
 	IMX_TRIP_PASSIVE,
 	IMX_TRIP_CRITICAL,
-	IMX_TRIP_NUM,
 };
=20
 #define IMX_POLLING_DELAY		2000 /* millisecond */
@@ -115,6 +114,11 @@ struct thermal_soc_data {
 	u32 low_alarm_shift;
 };
=20
+static struct thermal_trip trips[] =3D {
+	[IMX_TRIP_PASSIVE]  =3D { .type =3D THERMAL_TRIP_PASSIVE  },
+	[IMX_TRIP_CRITICAL] =3D { .type =3D THERMAL_TRIP_CRITICAL },
+};
+
 static struct thermal_soc_data thermal_imx6q_data =3D {
 	.version =3D TEMPMON_IMX6Q,
=20
@@ -201,8 +205,6 @@ struct imx_thermal_data {
 	struct thermal_cooling_device *cdev;
 	struct regmap *tempmon;
 	u32 c1, c2; /* See formula in imx_init_calib() */
-	int temp_passive;
-	int temp_critical;
 	int temp_max;
 	int alarm_temp;
 	int last_temp;
@@ -279,12 +281,12 @@ static int imx_get_temp(struct thermal_zone_device *tz,=
 int *temp)
=20
 	/* Update alarm value to next higher trip point for TEMPMON_IMX6Q */
 	if (data->socdata->version =3D=3D TEMPMON_IMX6Q) {
-		if (data->alarm_temp =3D=3D data->temp_passive &&
-			*temp >=3D data->temp_passive)
-			imx_set_alarm_temp(data, data->temp_critical);
-		if (data->alarm_temp =3D=3D data->temp_critical &&
-			*temp < data->temp_passive) {
-			imx_set_alarm_temp(data, data->temp_passive);
+		if (data->alarm_temp =3D=3D trips[IMX_TRIP_PASSIVE].temperature &&
+			*temp >=3D trips[IMX_TRIP_PASSIVE].temperature)
+			imx_set_alarm_temp(data, trips[IMX_TRIP_CRITICAL].temperature);
+		if (data->alarm_temp =3D=3D trips[IMX_TRIP_CRITICAL].temperature &&
+			*temp < trips[IMX_TRIP_PASSIVE].temperature) {
+			imx_set_alarm_temp(data, trips[IMX_TRIP_PASSIVE].temperature);
 			dev_dbg(&tz->device, "thermal alarm off: T < %d\n",
 				data->alarm_temp / 1000);
 		}
@@ -330,29 +332,10 @@ static int imx_change_mode(struct thermal_zone_device *=
tz,
 	return 0;
 }
=20
-static int imx_get_trip_type(struct thermal_zone_device *tz, int trip,
-			     enum thermal_trip_type *type)
-{
-	*type =3D (trip =3D=3D IMX_TRIP_PASSIVE) ? THERMAL_TRIP_PASSIVE :
-					     THERMAL_TRIP_CRITICAL;
-	return 0;
-}
-
 static int imx_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct imx_thermal_data *data =3D tz->devdata;
-
-	*temp =3D data->temp_critical;
-	return 0;
-}
-
-static int imx_get_trip_temp(struct thermal_zone_device *tz, int trip,
-			     int *temp)
-{
-	struct imx_thermal_data *data =3D tz->devdata;
+	*temp =3D trips[IMX_TRIP_CRITICAL].temperature;
=20
-	*temp =3D (trip =3D=3D IMX_TRIP_PASSIVE) ? data->temp_passive :
-					     data->temp_critical;
 	return 0;
 }
=20
@@ -371,10 +354,10 @@ static int imx_set_trip_temp(struct thermal_zone_device=
 *tz, int trip,
 		return -EPERM;
=20
 	/* do not allow passive to be set higher than critical */
-	if (temp < 0 || temp > data->temp_critical)
+	if (temp < 0 || temp > trips[IMX_TRIP_CRITICAL].temperature)
 		return -EINVAL;
=20
-	data->temp_passive =3D temp;
+	trips[IMX_TRIP_PASSIVE].temperature =3D temp;
=20
 	imx_set_alarm_temp(data, temp);
=20
@@ -423,8 +406,6 @@ static struct thermal_zone_device_ops imx_tz_ops =3D {
 	.unbind =3D imx_unbind,
 	.get_temp =3D imx_get_temp,
 	.change_mode =3D imx_change_mode,
-	.get_trip_type =3D imx_get_trip_type,
-	.get_trip_temp =3D imx_get_trip_temp,
 	.get_crit_temp =3D imx_get_crit_temp,
 	.set_trip_temp =3D imx_set_trip_temp,
 };
@@ -507,8 +488,8 @@ static void imx_init_temp_grade(struct platform_device *p=
dev, u32 ocotp_mem0)
 	 * Set the critical trip point at 5 =C2=B0C under max
 	 * Set the passive trip point at 10 =C2=B0C under max (changeable via sysfs)
 	 */
-	data->temp_critical =3D data->temp_max - (1000 * 5);
-	data->temp_passive =3D data->temp_max - (1000 * 10);
+	trips[IMX_TRIP_PASSIVE].temperature =3D data->temp_max - (1000 * 10);
+	trips[IMX_TRIP_CRITICAL].temperature =3D data->temp_max - (1000 * 5);
 }
=20
 static int imx_init_from_tempmon_data(struct platform_device *pdev)
@@ -743,12 +724,13 @@ static int imx_thermal_probe(struct platform_device *pd=
ev)
 		goto legacy_cleanup;
 	}
=20
-	data->tz =3D thermal_zone_device_register("imx_thermal_zone",
-						IMX_TRIP_NUM,
-						BIT(IMX_TRIP_PASSIVE), data,
-						&imx_tz_ops, NULL,
-						IMX_PASSIVE_DELAY,
-						IMX_POLLING_DELAY);
+	data->tz =3D thermal_zone_device_register_with_trips("imx_thermal_zone",
+							   trips,
+							   ARRAY_SIZE(trips),
+							   BIT(IMX_TRIP_PASSIVE), data,
+							   &imx_tz_ops, NULL,
+							   IMX_PASSIVE_DELAY,
+							   IMX_POLLING_DELAY);
 	if (IS_ERR(data->tz)) {
 		ret =3D PTR_ERR(data->tz);
 		dev_err(&pdev->dev,
@@ -758,8 +740,8 @@ static int imx_thermal_probe(struct platform_device *pdev)
=20
 	dev_info(&pdev->dev, "%s CPU temperature grade - max:%dC"
 		 " critical:%dC passive:%dC\n", data->temp_grade,
-		 data->temp_max / 1000, data->temp_critical / 1000,
-		 data->temp_passive / 1000);
+		 data->temp_max / 1000, trips[IMX_TRIP_CRITICAL].temperature / 1000,
+		 trips[IMX_TRIP_PASSIVE].temperature / 1000);
=20
 	/* Enable measurements at ~ 10 Hz */
 	regmap_write(map, data->socdata->measure_freq_ctrl + REG_CLR,
@@ -767,10 +749,10 @@ static int imx_thermal_probe(struct platform_device *pd=
ev)
 	measure_freq =3D DIV_ROUND_UP(32768, 10); /* 10 Hz */
 	regmap_write(map, data->socdata->measure_freq_ctrl + REG_SET,
 		     measure_freq << data->socdata->measure_freq_shift);
-	imx_set_alarm_temp(data, data->temp_passive);
+	imx_set_alarm_temp(data, trips[IMX_TRIP_PASSIVE].temperature);
=20
 	if (data->socdata->version =3D=3D TEMPMON_IMX6SX)
-		imx_set_panic_temp(data, data->temp_critical);
+		imx_set_panic_temp(data, trips[IMX_TRIP_CRITICAL].temperature);
=20
 	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
 		     data->socdata->power_down_mask);
