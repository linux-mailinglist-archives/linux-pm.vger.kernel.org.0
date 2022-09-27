Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AAD5EC65B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 16:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiI0OeG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 10:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiI0Od2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 10:33:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C341B8C97
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso5558012wmq.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xYvlHjUzJ1gAdl8KtmAH0mCHcP29B+tCMOTUThwt7jg=;
        b=QX9BzKfcBASFxtQ4MW5JxvOb+wYygM//84qzelToOCwnFzzj5bbXwqEbU1/NYlvJQM
         AkUkDeVCAjOfvJFh0MU4OAb/VBRo+Mn4K436Cf4fjxdcMaiZRHR07mMOT5fVeTQP2RNx
         5OZXidycwCa6+zVEESgHCwQVfozCwhI9/Pn0aFLIxG1JUT/azmAceWiGedcdFeMLUoIp
         nyUGrEwyg/nH35MK783BDU/DR+uvwJuONcQ7kYaIuI6opC0/QAhx05Vof1nL1841SU4d
         197lQvxGO4vyx8fzToCi7urGRKs8IGQewhXPHh2rrWlBsgcpGz6ZcvJjYFhQrT95Rpx1
         97IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xYvlHjUzJ1gAdl8KtmAH0mCHcP29B+tCMOTUThwt7jg=;
        b=rO2Lk40/ZZwXKxwMi82YLFANwdr5NmhR3p0t5QvYOh3KTqCEWbOpsF7806JCOj6+mY
         Xf7pR8pwoPN5kYnbzpx1Is/ntfMurNyLICfABde5w4jJZ8LVm8qI7HezaEbqEF/sq9cL
         aRAN28rK+0EEw/4ql+pZHV8+F093/bhzYKh2CCMT50xxYDVv1/VjKozy2bz1DFgVB7D1
         JGdANhTkNRVMGgMc9/qqXNQ4Zis/qmAiUjq6nruFHoDGGAgte/JIXEa2x0iVTSlb0A7q
         sD7vVz/20hPdRG9HYzxcmG8Wr/kpzw/nuOxXYy1nWB9JZ9drPXS154WbjNCC3+ayTkGY
         LR8A==
X-Gm-Message-State: ACrzQf1JIw/0C9lAa2HlEy2XTGp6e2sKSKF8r90GytZt/jQXew/IFYQN
        NZh2IYSqtNzBohwSPCy+TTZhNw==
X-Google-Smtp-Source: AMsMyM5PXZObBCto2bbeZ7EKxHpVSI3muQpkTPAKmWgm51HjCxxYbGeavBFlT+95vPLqtdq0dPdL2g==
X-Received: by 2002:a05:600c:1e13:b0:3b4:74c3:620b with SMTP id ay19-20020a05600c1e1300b003b474c3620bmr3027122wmb.168.1664289200324;
        Tue, 27 Sep 2022 07:33:20 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:19 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH v6 21/29] thermal/drivers/imx: Use generic thermal_zone_get_trip() function
Date:   Tue, 27 Sep 2022 16:32:31 +0200
Message-Id: <20220927143239.376737-22-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx_thermal.c | 72 +++++++++++++----------------------
 1 file changed, 27 insertions(+), 45 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 16663373b682..fb0d5cab70af 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -76,7 +76,6 @@
 enum imx_thermal_trip {
 	IMX_TRIP_PASSIVE,
 	IMX_TRIP_CRITICAL,
-	IMX_TRIP_NUM,
 };
 
 #define IMX_POLLING_DELAY		2000 /* millisecond */
@@ -115,6 +114,11 @@ struct thermal_soc_data {
 	u32 low_alarm_shift;
 };
 
+static struct thermal_trip trips[] = {
+	[IMX_TRIP_PASSIVE]  = { .type = THERMAL_TRIP_PASSIVE  },
+	[IMX_TRIP_CRITICAL] = { .type = THERMAL_TRIP_CRITICAL },
+};
+
 static struct thermal_soc_data thermal_imx6q_data = {
 	.version = TEMPMON_IMX6Q,
 
@@ -201,8 +205,6 @@ struct imx_thermal_data {
 	struct thermal_cooling_device *cdev;
 	struct regmap *tempmon;
 	u32 c1, c2; /* See formula in imx_init_calib() */
-	int temp_passive;
-	int temp_critical;
 	int temp_max;
 	int alarm_temp;
 	int last_temp;
@@ -279,12 +281,12 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	/* Update alarm value to next higher trip point for TEMPMON_IMX6Q */
 	if (data->socdata->version == TEMPMON_IMX6Q) {
-		if (data->alarm_temp == data->temp_passive &&
-			*temp >= data->temp_passive)
-			imx_set_alarm_temp(data, data->temp_critical);
-		if (data->alarm_temp == data->temp_critical &&
-			*temp < data->temp_passive) {
-			imx_set_alarm_temp(data, data->temp_passive);
+		if (data->alarm_temp == trips[IMX_TRIP_PASSIVE].temperature &&
+			*temp >= trips[IMX_TRIP_PASSIVE].temperature)
+			imx_set_alarm_temp(data, trips[IMX_TRIP_CRITICAL].temperature);
+		if (data->alarm_temp == trips[IMX_TRIP_CRITICAL].temperature &&
+			*temp < trips[IMX_TRIP_PASSIVE].temperature) {
+			imx_set_alarm_temp(data, trips[IMX_TRIP_PASSIVE].temperature);
 			dev_dbg(&tz->device, "thermal alarm off: T < %d\n",
 				data->alarm_temp / 1000);
 		}
@@ -330,29 +332,10 @@ static int imx_change_mode(struct thermal_zone_device *tz,
 	return 0;
 }
 
-static int imx_get_trip_type(struct thermal_zone_device *tz, int trip,
-			     enum thermal_trip_type *type)
-{
-	*type = (trip == IMX_TRIP_PASSIVE) ? THERMAL_TRIP_PASSIVE :
-					     THERMAL_TRIP_CRITICAL;
-	return 0;
-}
-
 static int imx_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct imx_thermal_data *data = tz->devdata;
-
-	*temp = data->temp_critical;
-	return 0;
-}
-
-static int imx_get_trip_temp(struct thermal_zone_device *tz, int trip,
-			     int *temp)
-{
-	struct imx_thermal_data *data = tz->devdata;
+	*temp = trips[IMX_TRIP_CRITICAL].temperature;
 
-	*temp = (trip == IMX_TRIP_PASSIVE) ? data->temp_passive :
-					     data->temp_critical;
 	return 0;
 }
 
@@ -371,10 +354,10 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
 		return -EPERM;
 
 	/* do not allow passive to be set higher than critical */
-	if (temp < 0 || temp > data->temp_critical)
+	if (temp < 0 || temp > trips[IMX_TRIP_CRITICAL].temperature)
 		return -EINVAL;
 
-	data->temp_passive = temp;
+	trips[IMX_TRIP_PASSIVE].temperature = temp;
 
 	imx_set_alarm_temp(data, temp);
 
@@ -423,8 +406,6 @@ static struct thermal_zone_device_ops imx_tz_ops = {
 	.unbind = imx_unbind,
 	.get_temp = imx_get_temp,
 	.change_mode = imx_change_mode,
-	.get_trip_type = imx_get_trip_type,
-	.get_trip_temp = imx_get_trip_temp,
 	.get_crit_temp = imx_get_crit_temp,
 	.set_trip_temp = imx_set_trip_temp,
 };
@@ -507,8 +488,8 @@ static void imx_init_temp_grade(struct platform_device *pdev, u32 ocotp_mem0)
 	 * Set the critical trip point at 5 °C under max
 	 * Set the passive trip point at 10 °C under max (changeable via sysfs)
 	 */
-	data->temp_critical = data->temp_max - (1000 * 5);
-	data->temp_passive = data->temp_max - (1000 * 10);
+	trips[IMX_TRIP_PASSIVE].temperature = data->temp_max - (1000 * 10);
+	trips[IMX_TRIP_CRITICAL].temperature = data->temp_max - (1000 * 5);
 }
 
 static int imx_init_from_tempmon_data(struct platform_device *pdev)
@@ -743,12 +724,13 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		goto legacy_cleanup;
 	}
 
-	data->tz = thermal_zone_device_register("imx_thermal_zone",
-						IMX_TRIP_NUM,
-						BIT(IMX_TRIP_PASSIVE), data,
-						&imx_tz_ops, NULL,
-						IMX_PASSIVE_DELAY,
-						IMX_POLLING_DELAY);
+	data->tz = thermal_zone_device_register_with_trips("imx_thermal_zone",
+							   trips,
+							   ARRAY_SIZE(trips),
+							   BIT(IMX_TRIP_PASSIVE), data,
+							   &imx_tz_ops, NULL,
+							   IMX_PASSIVE_DELAY,
+							   IMX_POLLING_DELAY);
 	if (IS_ERR(data->tz)) {
 		ret = PTR_ERR(data->tz);
 		dev_err(&pdev->dev,
@@ -758,8 +740,8 @@ static int imx_thermal_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "%s CPU temperature grade - max:%dC"
 		 " critical:%dC passive:%dC\n", data->temp_grade,
-		 data->temp_max / 1000, data->temp_critical / 1000,
-		 data->temp_passive / 1000);
+		 data->temp_max / 1000, trips[IMX_TRIP_CRITICAL].temperature / 1000,
+		 trips[IMX_TRIP_PASSIVE].temperature / 1000);
 
 	/* Enable measurements at ~ 10 Hz */
 	regmap_write(map, data->socdata->measure_freq_ctrl + REG_CLR,
@@ -767,10 +749,10 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
 	regmap_write(map, data->socdata->measure_freq_ctrl + REG_SET,
 		     measure_freq << data->socdata->measure_freq_shift);
-	imx_set_alarm_temp(data, data->temp_passive);
+	imx_set_alarm_temp(data, trips[IMX_TRIP_PASSIVE].temperature);
 
 	if (data->socdata->version == TEMPMON_IMX6SX)
-		imx_set_panic_temp(data, data->temp_critical);
+		imx_set_panic_temp(data, trips[IMX_TRIP_CRITICAL].temperature);
 
 	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
 		     data->socdata->power_down_mask);
-- 
2.34.1

