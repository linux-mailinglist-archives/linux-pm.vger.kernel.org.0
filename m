Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DF3583495
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 23:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiG0VFk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 17:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbiG0VEs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 17:04:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CA761135
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:04:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i205-20020a1c3bd6000000b003a2fa488efdso1537987wma.4
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mb4JyaEjxL4JDBtXDcGCWHFGP5KgiZCOnINym1JdoVI=;
        b=13YHnvPFGlHVD3It/kAW0PC4kqnY1vTEOpiGKK/McFrXR7XO621SlHmXlO2fw7BOOg
         4Lr85dXZoaPkOpKgj0b0uyY3fqcK1iiEc7YqZ3YXd6RbIb2OBDrqrvIwE9xSiZl3iGYL
         3ybXBkrtAhfjlgpiFGOmFe/PMDdFN39BfJFOp6AFu2Usu/FkiICGhpR6BZFT1v1n8v3u
         Fjb5cixwEagngCSIe4Ug3v3lsbX9G9yw4LEIPLu2z9zH33CQ5X9WbqvESwK8VolN/yLC
         tGnwbOhpIA/ADqE9bOLpT6ad6QiDhRgb4EcqoiNoFC1c3QB/e2aDRLofIDn2e5Sf6gPd
         cYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mb4JyaEjxL4JDBtXDcGCWHFGP5KgiZCOnINym1JdoVI=;
        b=fohjsxg55id9dnrSo0wJw2HtY7AjDVKoiCK3dgYTHkTE79z9aufCMN/5um8L5FYIC+
         e0QZw6tdPU02/auEXTbQEOYuxWJVp14tEv6jlGRsibFRB0SOu563bK6LWpylNqt4TGvY
         6paojhH/hQwtDn4ze0KfaNDO8b1Sy/DoTzLdaO+qOrpTppyx4MW5BGYySHiwvpH/Httz
         2+fcgikOTB4EukMcZFCuj3t4U6ETvmJG+QL91m4+5K3Fv7L7s+ollXxQo7eRbVu0/KPa
         X4ZASDTej+KbC8MGLVyyK4OB6BMd/zkhagWaBAN0qH4YqHm/KsfhbyIcCCWPdLUu++T4
         sjGA==
X-Gm-Message-State: AJIora83XyyutN4Xb8Qfh/vqs2rbAu9qveZJEU/bezxyCSsynGfGxub4
        uZWI0bJDwzw+bePsh/AusaNHKQ==
X-Google-Smtp-Source: AGRyM1s71Y8IOIJenvi/rSkvm0EMO95yLxX5Nr+kSHCzocJU/To/zxNgOL/Q/7gYaRqMJ9G2Y3PPLQ==
X-Received: by 2002:a1c:4c02:0:b0:3a3:160f:f1ec with SMTP id z2-20020a1c4c02000000b003a3160ff1ecmr4344701wmf.159.1658955851598;
        Wed, 27 Jul 2022 14:04:11 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:04:11 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v3 26/32] hwmon/drivers: Switch to new of thermal API
Date:   Wed, 27 Jul 2022 23:02:47 +0200
Message-Id: <20220727210253.3794069-27-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/hwmon.c      | 14 +++++++-------
 drivers/hwmon/scpi-hwmon.c | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 2e2cd79d89eb..4218750d5a66 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -151,9 +151,9 @@ static DEFINE_IDA(hwmon_ida);
  * between hwmon and thermal_sys modules.
  */
 #ifdef CONFIG_THERMAL_OF
-static int hwmon_thermal_get_temp(void *data, int *temp)
+static int hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct hwmon_thermal_data *tdata = data;
+	struct hwmon_thermal_data *tdata = tz->devdata;
 	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
 	int ret;
 	long t;
@@ -168,9 +168,9 @@ static int hwmon_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static int hwmon_thermal_set_trips(void *data, int low, int high)
+static int hwmon_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct hwmon_thermal_data *tdata = data;
+	struct hwmon_thermal_data *tdata = tz->devdata;
 	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
 	const struct hwmon_chip_info *chip = hwdev->chip;
 	const struct hwmon_channel_info **info = chip->info;
@@ -203,7 +203,7 @@ static int hwmon_thermal_set_trips(void *data, int low, int high)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops hwmon_thermal_ops = {
+static const struct thermal_zone_device_ops hwmon_thermal_ops = {
 	.get_temp = hwmon_thermal_get_temp,
 	.set_trips = hwmon_thermal_set_trips,
 };
@@ -227,8 +227,8 @@ static int hwmon_thermal_add_sensor(struct device *dev, int index)
 	tdata->dev = dev;
 	tdata->index = index;
 
-	tzd = devm_thermal_zone_of_sensor_register(dev, index, tdata,
-						   &hwmon_thermal_ops);
+	tzd = devm_thermal_of_zone_register(dev, index, tdata,
+					    &hwmon_thermal_ops);
 	if (IS_ERR(tzd)) {
 		if (PTR_ERR(tzd) != -ENODEV)
 			return PTR_ERR(tzd);
diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 5187c6dd5a4f..4d75385f7d5e 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -62,9 +62,9 @@ static void scpi_scale_reading(u64 *value, struct sensor_data *sensor)
 	}
 }
 
-static int scpi_read_temp(void *dev, int *temp)
+static int scpi_read_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct scpi_thermal_zone *zone = dev;
+	struct scpi_thermal_zone *zone = tz->devdata;
 	struct scpi_sensors *scpi_sensors = zone->scpi_sensors;
 	struct scpi_ops *scpi_ops = scpi_sensors->scpi_ops;
 	struct sensor_data *sensor = &scpi_sensors->data[zone->sensor_id];
@@ -121,7 +121,7 @@ scpi_show_label(struct device *dev, struct device_attribute *attr, char *buf)
 	return sprintf(buf, "%s\n", sensor->info.name);
 }
 
-static const struct thermal_zone_of_device_ops scpi_sensor_ops = {
+static const struct thermal_zone_device_ops scpi_sensor_ops = {
 	.get_temp = scpi_read_temp,
 };
 
@@ -275,10 +275,10 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 
 		zone->sensor_id = i;
 		zone->scpi_sensors = scpi_sensors;
-		z = devm_thermal_zone_of_sensor_register(dev,
-							 sensor->info.sensor_id,
-							 zone,
-							 &scpi_sensor_ops);
+		z = devm_thermal_of_zone_register(dev,
+						  sensor->info.sensor_id,
+						  zone,
+						  &scpi_sensor_ops);
 		/*
 		 * The call to thermal_zone_of_sensor_register returns
 		 * an error for sensors that are not associated with
-- 
2.25.1

