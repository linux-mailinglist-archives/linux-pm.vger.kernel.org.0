Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0F11C45A1
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbgEDSQp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 14:16:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:27145 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732278AbgEDSQo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 14:16:44 -0400
IronPort-SDR: OphSXnXIigcuahTUBJ6R4Xomb3S2mYLZ/GjwWJQMrV8+KikGCrfNiEBfl/Jq2admAt0QkYHEbL
 cvhqS86rQgWQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 11:16:34 -0700
IronPort-SDR: dNMkY38EIkVXXa27TiyYYe6z7BrjLhUlmnlPlboysHT6WLyDfmGS7ojOVc1TzjIpr7OlrMWib6
 UBwG1bEKSyLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="259427135"
Received: from spandruv-mobl.amr.corp.intel.com ([10.212.145.237])
  by orsmga003.jf.intel.com with ESMTP; 04 May 2020 11:16:33 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC][PATCH 4/5] thermal: Add support for setting polling interval
Date:   Mon,  4 May 2020 11:16:15 -0700
Message-Id: <20200504181616.175477-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new attribute in the thermal syfs for setting temperature sampling
interval when CONFIG_THERMAL_USER_EVENT_INTERFACE is defined. The default
value is 0, which means no polling.

At this interval user space will get an event THERMAL_TEMP_SAMPLE with
temperature sample. This reuses existing polling mecahnism when polling
or passive delay is specified during zone registry. To avoid interference
with passive and polling delay, this new polling attribute can't be used
for those zones.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/thermal_core.c  |  7 +++++++
 drivers/thermal/thermal_sysfs.c | 36 +++++++++++++++++++++++++++++++--
 include/linux/thermal.h         |  1 +
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 14770d882d42..17cd799b0073 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -313,6 +313,8 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 		thermal_zone_device_set_polling(tz, tz->passive_delay);
 	else if (tz->polling_delay)
 		thermal_zone_device_set_polling(tz, tz->polling_delay);
+	else if (tz->temp_polling_delay)
+		thermal_zone_device_set_polling(tz, tz->temp_polling_delay);
 	else
 		thermal_zone_device_set_polling(tz, 0);
 
@@ -446,6 +448,11 @@ static void update_temperature(struct thermal_zone_device *tz)
 	tz->temperature = temp;
 	mutex_unlock(&tz->lock);
 
+	if (tz->temp_polling_delay) {
+		thermal_dev_send_event(tz->id, THERMAL_TEMP_SAMPLE, temp);
+		monitor_thermal_zone(tz);
+	}
+
 	trace_thermal_temperature(tz);
 	if (tz->last_temperature == THERMAL_TEMP_INVALID)
 		dev_dbg(&tz->device, "last_temperature N/A, current_temperature=%d\n",
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index aa85424c3ac4..0df7997993fe 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -248,6 +248,36 @@ create_thres_attr(temp_thres_low);
 create_thres_attr(temp_thres_high);
 create_thres_attr(temp_thres_hyst);
 
+static ssize_t
+temp_polling_delay_store(struct device *dev, struct device_attribute *attr,
+		   const char *buf, size_t count)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	int val;
+
+	if (kstrtoint(buf, 10, &val))
+		return -EINVAL;
+
+	if (val && val < 1000)
+		return -EINVAL;
+
+	tz->temp_polling_delay = val;
+	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+	return count;
+}
+
+static ssize_t
+temp_polling_delay_show(struct device *dev, struct device_attribute *attr,
+		     char *buf)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+
+	return sprintf(buf, "%d\n", tz->temp_polling_delay);
+}
+
+static DEVICE_ATTR_RW(temp_polling_delay);
+
 static int create_user_events_attrs(struct thermal_zone_device *tz)
 {
 	struct attribute **attrs;
@@ -260,8 +290,8 @@ static int create_user_events_attrs(struct thermal_zone_device *tz)
 	if (tz->ops->get_temp_thres_high)
 		++index;
 
-	/* One additional space for NULL */
-	attrs = kcalloc(index + 1, sizeof(*attrs), GFP_KERNEL);
+	/* One additional space for NULL and temp_pollling_delay */
+	attrs = kcalloc(index + 2, sizeof(*attrs), GFP_KERNEL);
 	if (!attrs)
 		return -ENOMEM;
 
@@ -312,6 +342,8 @@ static int create_user_events_attrs(struct thermal_zone_device *tz)
 		attrs[index] = &tz->threshold_attrs[index].attr.attr;
 		++index;
 	}
+	if (!tz->polling_delay && !tz->passive_delay)
+		attrs[index++] = &dev_attr_temp_polling_delay.attr;
 	attrs[index] = NULL;
 	tz->threshold_attribute_group.attrs = attrs;
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index ee9d79ace7ce..0ec4bd8c9c5c 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -216,6 +216,7 @@ struct thermal_zone_device {
 	enum thermal_notify_event notify_event;
 	struct attribute_group threshold_attribute_group;
 	struct thermal_attr *threshold_attrs;
+	int temp_polling_delay;
 };
 
 /**
-- 
2.25.4

