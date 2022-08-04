Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8E158A393
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 00:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbiHDWzW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 18:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbiHDWyN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 18:54:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F05E73939
        for <linux-pm@vger.kernel.org>; Thu,  4 Aug 2022 15:52:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i128-20020a1c3b86000000b003a3a22178beso3170434wma.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2022 15:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Mb4JyaEjxL4JDBtXDcGCWHFGP5KgiZCOnINym1JdoVI=;
        b=wQo/UV9mshrZkcNDdjalDKNxK63vlfmQjhNxevBHCxrFdsMT7nB90i1ZE6huszQ/db
         2bl8ZrWoUnMQJhVWhbw8Q/cKmO/0nt2z4svjTvqbUUY0tQ7fXuI4fcdsSiGl67GACG1n
         bSMGo7EjTT0N8vsk5TsxgVEDLH3cwt/P9BpYOJ6Z/kwcEwWWk23H2GdFzVF9PoC3iB8O
         760MdX6i3YhxrwszI6CwkNH0YgSTqG1hckIvey/rwgjFdQELdtDtIrz/saHyXZO5h/eO
         by8fOA6f7Q2assdrf+1iuG+Q38rAred/Dsh7mcOEEMwB3Ygh21+2eneqL2IZG8ngs08k
         l/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Mb4JyaEjxL4JDBtXDcGCWHFGP5KgiZCOnINym1JdoVI=;
        b=SqjyIZArvWpUshP10W4bx7+Eb7DgnVCT3VgPbiFVzF/N8hdZtAbh/DvzlnW/J1yV0/
         2k7YhY4Yx2M3BPVMakgTsGv6SjihPkGPGz+nSxeTV4j5gsnrT+aBUyYBK1cckVNVGwlL
         v9MRe8iUqwIu9d0kjV8t4afIW9VNIssdn3I7XuTSyNmflgaguySouPNEYxBAra6tix8a
         29Cyzangco9eKVTZ0Jjg6yqTRLjm2eG0mRh3q3lBVCf3bVfMarROv1HlhziJZRFUnqHd
         kffUttD0VSua1h4XNp4s8A/3yrY3sq/K5uZ36+lMK7GIiKR6QmChXEhmkjWQI3GfWPvF
         ZGng==
X-Gm-Message-State: ACgBeo1DSe+bhIg01ce3Wb4EcdQxlgEk+5b7P7JqsR7UIYEQRrAHvLDU
        qrPFcHHrlh4C52hv3e/kq4MHvg==
X-Google-Smtp-Source: AA6agR5VKn8mBE1+7AKB21QkxmN4RJNv5p+IzBpLUtP9ibque/PJyyCzb0QuN6l6KiTs8FG5xCb8LA==
X-Received: by 2002:a05:600c:4f07:b0:3a3:2277:7064 with SMTP id l7-20020a05600c4f0700b003a322777064mr2707995wmq.181.1659653578896;
        Thu, 04 Aug 2022 15:52:58 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:58 -0700 (PDT)
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
Subject: [PATCH v5 27/33] hwmon/drivers/core: Switch to new of thermal API
Date:   Fri,  5 Aug 2022 00:43:43 +0200
Message-Id: <20220804224349.1926752-28-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
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

