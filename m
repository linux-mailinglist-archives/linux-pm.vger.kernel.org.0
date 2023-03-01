Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE06A7506
	for <lists+linux-pm@lfdr.de>; Wed,  1 Mar 2023 21:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCAUQX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Mar 2023 15:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCAUQR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2023 15:16:17 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B78515E6
        for <linux-pm@vger.kernel.org>; Wed,  1 Mar 2023 12:15:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so314089wms.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Mar 2023 12:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b92i5j4suI6iMes/bILYFXO036hJyAX8EiI58S1R41c=;
        b=Scjjoddufz1DfGYWyLG4gYxZ4y8eSi2DmsQmcIkqPp3omLIYadL8eU6Yuelv0SOiP7
         LM60QZmX5TYdB1E6pW7owOoacod2pjpRxBdzlqcRf1fCp3wT3NLRH2UMrExjHgit9sX+
         5p9mGToQiWV+eynXAecNV9Pakn1tJvddqvh3BSDnQ23ob/k/T2Ua/7jQoetg+XyIHafy
         YyqDTkvqfb7fhN5VM7tCJLBdv5hcJ38Uz3mlW4FjDKisc4SLRMQb5Ex5J+mDlMD6BpP+
         5khFgnBgBdoDPEfZHI9RO/F95CjlChqw58ARgdtxSX0PmXFWoGPoym+jXnehh6S+/8L1
         MMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b92i5j4suI6iMes/bILYFXO036hJyAX8EiI58S1R41c=;
        b=DYYHNLc3deZ0MLAp845OE9U36yDiY+1Kr2hNbBeWZ7cdgqysx1Jmi1RZnJDA/zJBz9
         qcP2HANrvR1m6epG/zjT0aIsE0c+I3q2C04RUDegJvb3W5xFdlYwOYdkJQHtNMOoRW3X
         Tk8w2nsBHzRka8z3ZCZMqWcgkcck9ys711E4S0S9DRgblpRqybv5tLLC7N+WF6oBgn+e
         IHRbnzmK2hN0B0godLAyHEZHq4TBzICYpOccvzi4hLaek6BpgvlQVbauIB3uu0hh6zPw
         fBQ6GdOm6+xtDZJ6y5ZAcAK63NSwfbagokRVu8Y9mej30oMPsPtsEy2Lq5Ltpi8pI+qk
         SeXQ==
X-Gm-Message-State: AO0yUKUAK/a0551LrAh+QgFtPts7M8Vt+9h/RAafpeWGI6skiGzGbGLk
        4w8YAVzCwudj+G9tLcozsYoXbw==
X-Google-Smtp-Source: AK7set/aHNxqaSnx47sUyypc2ojGT0vB4mUbUYjNUwcqeWTM40mA/AUxrCaCjrWGaIVT72U7Li+4Aw==
X-Received: by 2002:a05:600c:1f0e:b0:3e7:95ba:e1c7 with SMTP id bd14-20020a05600c1f0e00b003e795bae1c7mr6244399wmb.32.1677701738545;
        Wed, 01 Mar 2023 12:15:38 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:15:37 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE),
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v5 09/18] thermal: Don't use 'device' internal thermal zone structure field
Date:   Wed,  1 Mar 2023 21:14:37 +0100
Message-Id: <20230301201446.3713334-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some drivers are directly using the thermal zone's 'device' structure
field.

Use the driver device pointer instead of the thermal zone device when
it is available.

Remove the traces when they are duplicate with the traces in the core
code.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Balsam CHIHI <bchihi@baylibre.com> #Mediatek LVTS
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> #MediaTek LVTS
---
 drivers/thermal/imx_thermal.c                 | 37 ++++---------------
 drivers/thermal/mediatek/lvts_thermal.c       |  4 +-
 drivers/thermal/thermal_hwmon.c               |  4 +-
 .../ti-soc-thermal/ti-thermal-common.c        |  2 +-
 4 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index a0b8de269986..c3136978adee 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -285,13 +285,13 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 		if (data->alarm_temp == trips[IMX_TRIP_CRITICAL].temperature &&
 			*temp < trips[IMX_TRIP_PASSIVE].temperature) {
 			imx_set_alarm_temp(data, trips[IMX_TRIP_PASSIVE].temperature);
-			dev_dbg(&tz->device, "thermal alarm off: T < %d\n",
+			dev_dbg(data->dev, "thermal alarm off: T < %d\n",
 				data->alarm_temp / 1000);
 		}
 	}
 
 	if (*temp != data->last_temp) {
-		dev_dbg(&tz->device, "millicelsius: %d\n", *temp);
+		dev_dbg(data->dev, "millicelsius: %d\n", *temp);
 		data->last_temp = *temp;
 	}
 
@@ -367,36 +367,16 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
 static int imx_bind(struct thermal_zone_device *tz,
 		    struct thermal_cooling_device *cdev)
 {
-	int ret;
-
-	ret = thermal_zone_bind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev,
-					       THERMAL_NO_LIMIT,
-					       THERMAL_NO_LIMIT,
-					       THERMAL_WEIGHT_DEFAULT);
-	if (ret) {
-		dev_err(&tz->device,
-			"binding zone %s with cdev %s failed:%d\n",
-			tz->type, cdev->type, ret);
-		return ret;
-	}
-
-	return 0;
+	return thermal_zone_bind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev,
+						THERMAL_NO_LIMIT,
+						THERMAL_NO_LIMIT,
+						THERMAL_WEIGHT_DEFAULT);
 }
 
 static int imx_unbind(struct thermal_zone_device *tz,
 		      struct thermal_cooling_device *cdev)
 {
-	int ret;
-
-	ret = thermal_zone_unbind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev);
-	if (ret) {
-		dev_err(&tz->device,
-			"unbinding zone %s with cdev %s failed:%d\n",
-			tz->type, cdev->type, ret);
-		return ret;
-	}
-
-	return 0;
+	return thermal_zone_unbind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev);
 }
 
 static struct thermal_zone_device_ops imx_tz_ops = {
@@ -558,8 +538,7 @@ static irqreturn_t imx_thermal_alarm_irq_thread(int irq, void *dev)
 {
 	struct imx_thermal_data *data = dev;
 
-	dev_dbg(&data->tz->device, "THERMAL ALARM: T > %d\n",
-		data->alarm_temp / 1000);
+	dev_dbg(data->dev, "THERMAL ALARM: T > %d\n", data->alarm_temp / 1000);
 
 	thermal_zone_device_update(data->tz, THERMAL_EVENT_UNSPECIFIED);
 
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index fb4b1b4db245..beb835d644e2 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -305,7 +305,7 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	 * 14-0 : Raw temperature for threshold
 	 */
 	if (low != -INT_MAX) {
-		dev_dbg(&tz->device, "Setting low limit temperature interrupt: %d\n", low);
+		pr_debug("%s: Setting low limit temperature interrupt: %d\n", tz->type, low);
 		writel(raw_low, LVTS_H2NTHRE(base));
 	}
 
@@ -318,7 +318,7 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	 *
 	 * 14-0 : Raw temperature for threshold
 	 */
-	dev_dbg(&tz->device, "Setting high limit temperature interrupt: %d\n", high);
+	pr_debug("%s: Setting high limit temperature interrupt: %d\n", tz->type, high);
 	writel(raw_high, LVTS_HTHRE(base));
 
 	return 0;
diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 964db7941e31..bc02095b314c 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -228,14 +228,14 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 	hwmon = thermal_hwmon_lookup_by_type(tz);
 	if (unlikely(!hwmon)) {
 		/* Should never happen... */
-		dev_dbg(&tz->device, "hwmon device lookup failed!\n");
+		dev_dbg(hwmon->device, "hwmon device lookup failed!\n");
 		return;
 	}
 
 	temp = thermal_hwmon_lookup_temp(hwmon, tz);
 	if (unlikely(!temp)) {
 		/* Should never happen... */
-		dev_dbg(&tz->device, "temperature input lookup failed!\n");
+		dev_dbg(hwmon->device, "temperature input lookup failed!\n");
 		return;
 	}
 
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 216b29068b08..060f46cea5ff 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -43,7 +43,7 @@ static void ti_thermal_work(struct work_struct *work)
 
 	thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
 
-	dev_dbg(&data->ti_thermal->device, "updated thermal zone %s\n",
+	dev_dbg(data->bgp->dev, "updated thermal zone %s\n",
 		data->ti_thermal->type);
 }
 
-- 
2.34.1

