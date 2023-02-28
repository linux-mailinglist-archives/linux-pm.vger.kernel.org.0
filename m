Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D9F6A57D9
	for <lists+linux-pm@lfdr.de>; Tue, 28 Feb 2023 12:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjB1LYZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Feb 2023 06:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjB1LYH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2023 06:24:07 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA207DAA
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 03:23:29 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bv17so9341208wrb.5
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 03:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677583408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNKZqTSfik6kbKLTg6DAWWxGUvdMh+G/qh4G7aDUg+w=;
        b=wV/L9wxmkG0QFszeQY1rP/fmvWNtWBgOWQ20k9R2NIz3qAgL1Z4s5U/m2fUhZvZiJ2
         LjJ+RiJ45DjHzwzE1kV7pc2FAdY2sC2YY9b4xzu8w/WOwX8vsh+e5Br7OcC/XiVBTiEq
         uTdyoRJq75pO8YU5osAVYSdkJzIBvJI2QJOclFm6K0nT9vCARArHdfhyAJ1o8dERlvn8
         QSZ079y3ywulzSBvnFrMvkIKKPKiVZY5yq8KPPI0RzzdtyMbwFf9rFMCVMBVJrFsxwF4
         C+3672ei+T1SK+whbLakvxiA9AR/QVGlhNMKoqGJ45lzPsGwnDt3op3yGk4bJZTWOPpK
         VFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677583408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNKZqTSfik6kbKLTg6DAWWxGUvdMh+G/qh4G7aDUg+w=;
        b=t9HHYrQg85Jy6IGE0tzQyqVM2h2odFZYTBIQbVoDzp0kIRyU2hUdNHUz1AzgexDJ2M
         rRPUOkmoGWDyL64wIJz8H3Vr681EJF+bBNMnA2q+du2cgWlaoC91nv+yu4rA/jOEyd0r
         K1bMBT0XvCsfN0+VKg5w0MvdG1jeaX3pkiL9DOHCRkhIbGo7E0sAJbi6fHO/7wqyQmjG
         DyzPIDGPiUZWcV26FlmPjVx5ML8YA7NcPE+Hmd2l04ehcuOtuJIlhEZzW+hO0U+vZoiF
         3lAdOvtwFQ4MOlC6USqYeULz/Kz71H3Orbcc4O8ab0cSvr6cCTVF76jP3WrfnpvB/uB0
         yifw==
X-Gm-Message-State: AO0yUKU3iVp4ancajMegycn0ZkfinqvT0L8vVxpkFqZqZeMG9XRHj+vW
        3xvORRcTGY5Rpppr7dTgQMLtUw==
X-Google-Smtp-Source: AK7set/frF01WULXg9I0nglY7Ek7yOFBLqMBxaJCvHt6wq+wuarFgVeWlk7YGgeHzmgRPlA1x4bEsw==
X-Received: by 2002:a5d:4a44:0:b0:2c9:9b81:11de with SMTP id v4-20020a5d4a44000000b002c99b8111demr1679350wrs.20.1677583408590;
        Tue, 28 Feb 2023 03:23:28 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6830:6390:2815:b6a5])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6545000000b002c5501a5803sm9598130wrv.65.2023.02.28.03.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:23:28 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: [PATCH v4 09/19] thermal: Don't use 'device' internal thermal zone structure field
Date:   Tue, 28 Feb 2023 12:22:28 +0100
Message-Id: <20230228112238.2312273-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
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

