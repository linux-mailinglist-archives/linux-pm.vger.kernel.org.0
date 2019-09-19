Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1AA3B7181
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 04:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbfISCSb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 22:18:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34732 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388316AbfISCS3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 22:18:29 -0400
Received: by mail-qt1-f195.google.com with SMTP id j1so2355274qth.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 19:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hnMqV/Yia1YygR1EYdN6c9UtAx32hcNfOwxm8eVaTYM=;
        b=eoagL2Ho32riRPQK1weZiYpbIytlCjkW+ru7mE2enP6E/1J6MXI8dYLN9ZbL0TSvgL
         ElEo8/fVUCczO5OnPUJQuhmN6UyL9gSi0RVvLnoKMKzmgH6ezTiYhfLfYhDAtJXMClsd
         sHwL6T6041fq6ZUVgx4mrecGEtKRzMYCvquYUd+LTZDMjKQx/VcmZiS2eESxodx/m+2F
         GDtNYjhS70G2aHSmcMNL5FrX3lYahyzmjVfLEq51P4OKo/2AQjJGyUfOwz8WWWEl51mj
         i0ASOSu1d6zJFC1sJ/a37mSX/HDShmjbTtLSm+6riV6sC6Njepz9E13sxGUmB2ho2nBU
         1Pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hnMqV/Yia1YygR1EYdN6c9UtAx32hcNfOwxm8eVaTYM=;
        b=pTHDUgEQ+KljQwuLWnhCO1ZQcVS7o1Ehx1maHDjoZhLgROOlIimOjapws+x+M/ioJl
         juEe6p5eMcSYEehCGWV53phzJUf0X/ST7kDWr2hVIaaVP+ghcV7UKHiTXAIaUwwbhAe9
         7Ys5D+PDm1An202UHMOji8pWaHjdhDZ7VvbXb4TW6DKw0O8Ept0NDb596GWw9y0+6Hmo
         ft4m0VpQRdjixJNplS7JxyByAqpMG18+0Ib1jxk97gg5q9t/wfeAesOcpwoyrJy1vF+3
         VhnSfhgR/jBw4Lf+Ni7jeajwukpchZX3HJIwGDdtwBl4GGEKc+ZjbNxik9scZiEV5y4j
         VYkQ==
X-Gm-Message-State: APjAAAUEMaMPuUd6NJFvpN1H8W7jaLFQJyhfiHCLtOAIF22wC/lkM4Gy
        RSl7q928kbXfUP5FYeIqXGp+kQ==
X-Google-Smtp-Source: APXvYqwWxJa+e/9Dkm6Gl54NQOL0ymsuCyUJ7oQlERhzz5TBJeXUk2TqkkUc00V/G4aieFshjeb2eQ==
X-Received: by 2002:aed:2726:: with SMTP id n35mr850709qtd.171.1568859507091;
        Wed, 18 Sep 2019 19:18:27 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id o52sm5261275qtf.56.2019.09.18.19.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 19:18:26 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] thermal: Thermal core and sysfs changes needed to support bi-directional monitoring of trip points.
Date:   Wed, 18 Sep 2019 22:18:21 -0400
Message-Id: <1568859503-19725-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1568859503-19725-1-git-send-email-thara.gopinath@linaro.org>
References: <1568859503-19725-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thermal trip points can be defined to indicate whether a
temperature rise or a temperature fall is to be monitored. This
property can now be defined in the DT bindings for a trip point.
To support this following three changes are introduced to thermal
core and sysfs code.
1. Define a new variable in thermal_trip to capture the monitor
   rising/falling information from trip point DT bindings.
2. Define a new ops in thermal_zone_device_ops that can be populated
   to indicate whether a trip is being monitored for rising or falling
   temperature. If the ops is not populated or if the binding is missing
   in the DT, it is assumed that the trip is being monitored for rising
   temperature. (default behavior today)
3. Introduce sysfs entries for each trip point to read the direction of
   monitoring.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 60 ++++++++++++++++++++++++++++++++++++++---
 include/linux/thermal.h         | 10 +++++++
 include/uapi/linux/thermal.h    |  2 +-
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index aa99edb..b4ef6be 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -216,6 +216,31 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t
+trip_point_monitor_type_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	enum thermal_trip_monitor_type type;
+	int trip, result;
+
+	if (sscanf(attr->attr.name, "trip_point_%d_monitor_type", &trip) != 1)
+		return -EINVAL;
+
+	if (!tz->ops->get_trip_monitor_type)
+		goto exit;
+
+	result = tz->ops->get_trip_monitor_type(tz, trip, &type);
+	if (result)
+		return result;
+
+	if (type == THERMAL_TRIP_MONITOR_FALLING)
+		return sprintf(buf, "falling\n");
+
+exit:
+		return sprintf(buf, "rising\n");
+}
+
+static ssize_t
 passive_store(struct device *dev, struct device_attribute *attr,
 	      const char *buf, size_t count)
 {
@@ -520,10 +545,20 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 	if (!tz->trip_type_attrs)
 		return -ENOMEM;
 
+	tz->trip_monitor_type_attrs = kcalloc
+					(tz->trips,
+					sizeof(*tz->trip_monitor_type_attrs),
+					GFP_KERNEL);
+	if (!tz->trip_monitor_type_attrs) {
+		kfree(tz->trip_type_attrs);
+		return -ENOMEM;
+	}
+
 	tz->trip_temp_attrs = kcalloc(tz->trips, sizeof(*tz->trip_temp_attrs),
 				      GFP_KERNEL);
 	if (!tz->trip_temp_attrs) {
 		kfree(tz->trip_type_attrs);
+		kfree(tz->trip_monitor_type_attrs);
 		return -ENOMEM;
 	}
 
@@ -533,14 +568,16 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 					      GFP_KERNEL);
 		if (!tz->trip_hyst_attrs) {
 			kfree(tz->trip_type_attrs);
+			kfree(tz->trip_monitor_type_attrs);
 			kfree(tz->trip_temp_attrs);
 			return -ENOMEM;
 		}
 	}
 
-	attrs = kcalloc(tz->trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
+	attrs = kcalloc(tz->trips * 4 + 1, sizeof(*attrs), GFP_KERNEL);
 	if (!attrs) {
 		kfree(tz->trip_type_attrs);
+		kfree(tz->trip_monitor_type_attrs);
 		kfree(tz->trip_temp_attrs);
 		if (tz->ops->get_trip_hyst)
 			kfree(tz->trip_hyst_attrs);
@@ -559,6 +596,20 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		tz->trip_type_attrs[indx].attr.show = trip_point_type_show;
 		attrs[indx] = &tz->trip_type_attrs[indx].attr.attr;
 
+		/* create trip monitor type attribute */
+		snprintf(tz->trip_monitor_type_attrs[indx].name,
+			 THERMAL_NAME_LENGTH, "trip_point_%d_monitor_type",
+			 indx);
+
+		sysfs_attr_init(&tz->trip_monitor_type_attrs[indx].attr.attr);
+		tz->trip_monitor_type_attrs[indx].attr.attr.name =
+				tz->trip_monitor_type_attrs[indx].name;
+		tz->trip_monitor_type_attrs[indx].attr.attr.mode = S_IRUGO;
+		tz->trip_monitor_type_attrs[indx].attr.show =
+				trip_point_monitor_type_show;
+		attrs[indx + tz->trips] =
+				&tz->trip_monitor_type_attrs[indx].attr.attr;
+
 		/* create trip temp attribute */
 		snprintf(tz->trip_temp_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_temp", indx);
@@ -574,7 +625,8 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 			tz->trip_temp_attrs[indx].attr.store =
 							trip_point_temp_store;
 		}
-		attrs[indx + tz->trips] = &tz->trip_temp_attrs[indx].attr.attr;
+		attrs[indx + tz->trips * 2] =
+				&tz->trip_temp_attrs[indx].attr.attr;
 
 		/* create Optional trip hyst attribute */
 		if (!tz->ops->get_trip_hyst)
@@ -592,10 +644,10 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 			tz->trip_hyst_attrs[indx].attr.store =
 					trip_point_hyst_store;
 		}
-		attrs[indx + tz->trips * 2] =
+		attrs[indx + tz->trips * 3] =
 					&tz->trip_hyst_attrs[indx].attr.attr;
 	}
-	attrs[tz->trips * 3] = NULL;
+	attrs[tz->trips * 4] = NULL;
 
 	tz->trips_attribute_group.attrs = attrs;
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e45659c..1435176b 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -70,6 +70,11 @@ enum thermal_trip_type {
 	THERMAL_TRIP_CRITICAL,
 };
 
+enum thermal_trip_monitor_type {
+	THERMAL_TRIP_MONITOR_RISING = 0,
+	THERMAL_TRIP_MONITOR_FALLING
+};
+
 enum thermal_trend {
 	THERMAL_TREND_STABLE, /* temperature is stable */
 	THERMAL_TREND_RAISING, /* temperature is raising */
@@ -113,6 +118,8 @@ struct thermal_zone_device_ops {
 			  enum thermal_trend *);
 	int (*notify) (struct thermal_zone_device *, int,
 		       enum thermal_trip_type);
+	int (*get_trip_monitor_type)(struct thermal_zone_device *, int,
+				     enum thermal_trip_monitor_type *);
 };
 
 struct thermal_cooling_device_ops {
@@ -196,6 +203,7 @@ struct thermal_zone_device {
 	struct thermal_attr *trip_temp_attrs;
 	struct thermal_attr *trip_type_attrs;
 	struct thermal_attr *trip_hyst_attrs;
+	struct thermal_attr *trip_monitor_type_attrs;
 	void *devdata;
 	int trips;
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
@@ -364,6 +372,7 @@ struct thermal_zone_of_device_ops {
  * @temperature: temperature value in miliCelsius
  * @hysteresis: relative hysteresis in miliCelsius
  * @type: trip point type
+ * @monitor_type: trip point monitor type.
  */
 
 struct thermal_trip {
@@ -371,6 +380,7 @@ struct thermal_trip {
 	int temperature;
 	int hysteresis;
 	enum thermal_trip_type type;
+	enum thermal_trip_monitor_type monitor_type;
 };
 
 /* Function declarations */
diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index 9621837..c01492c 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -2,7 +2,7 @@
 #ifndef _UAPI_LINUX_THERMAL_H
 #define _UAPI_LINUX_THERMAL_H
 
-#define THERMAL_NAME_LENGTH	20
+#define THERMAL_NAME_LENGTH	30
 
 /* Adding event notification support elements */
 #define THERMAL_GENL_FAMILY_NAME                "thermal_event"
-- 
2.1.4

