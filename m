Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925811C45A4
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 20:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbgEDSQv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 14:16:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:27142 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732300AbgEDSQp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 14:16:45 -0400
IronPort-SDR: ltC6PEoAL5UZSGBC6COMMyP3JP0yADVUk6h2a5cRJv9iWwLq72heEXfqLgfHh48UEDUgbrZFq4
 LZ6K7wYNz2Tw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 11:16:35 -0700
IronPort-SDR: mvLLiJAuzzRExPXFYoNI1g29gexMvcoi/88KTXr0i7bmqEuaESdFvfjEiWu77537aI5xy8CkGU
 GIbfMIsfrafg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="259427141"
Received: from spandruv-mobl.amr.corp.intel.com ([10.212.145.237])
  by orsmga003.jf.intel.com with ESMTP; 04 May 2020 11:16:34 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC][PATCH 5/5] thermal: int340x: Use new device interface
Date:   Mon,  4 May 2020 11:16:16 -0700
Message-Id: <20200504181616.175477-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the new framework to send notifications for:
- Setting temperature threshold for notification to avoid polling
- Send THERMAL_TRIP_REACHED event on reaching threshold
- Send THERMAL_TRIP_UPDATE when firmware change the the existing trip
temperature

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/int3403_thermal.c   |  3 ++
 .../int340x_thermal/int340x_thermal_zone.c    | 29 +++++++++++++++++++
 .../int340x_thermal/int340x_thermal_zone.h    |  7 +++++
 .../processor_thermal_device.c                |  1 +
 4 files changed, 40 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index f86cbb125e2f..77c014a113a4 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -63,15 +63,18 @@ static void int3403_notify(acpi_handle handle,
 
 	switch (event) {
 	case INT3403_PERF_CHANGED_EVENT:
+		int340x_thermal_send_user_event(obj->int340x_zone, THERMAL_PERF_CHANGED, 0);
 		break;
 	case INT3403_THERMAL_EVENT:
 		int340x_thermal_zone_device_update(obj->int340x_zone,
 						   THERMAL_TRIP_VIOLATED);
+		int340x_thermal_send_user_event(obj->int340x_zone, THERMAL_TRIP_REACHED, 0);
 		break;
 	case INT3403_PERF_TRIP_POINT_CHANGED:
 		int340x_thermal_read_trips(obj->int340x_zone);
 		int340x_thermal_zone_device_update(obj->int340x_zone,
 						   THERMAL_TRIP_CHANGED);
+		int340x_thermal_send_user_event(obj->int340x_zone, THERMAL_TRIP_UPDATE, 0);
 		break;
 	default:
 		dev_err(&priv->pdev->dev, "Unsupported event [0x%x]\n", event);
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 432213272f1e..9568a2db7afd 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -146,12 +146,41 @@ static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
 	return 0;
 }
 
+static int int340x_thermal_get_thres_low(struct thermal_zone_device *zone, int *temp)
+{
+	struct int34x_thermal_zone *d = zone->devdata;
+
+	*temp = d->aux_trips[0];
+
+	return 0;
+}
+
+static int int340x_thermal_set_thres_low(struct thermal_zone_device *zone, int temp)
+{
+	struct int34x_thermal_zone *d = zone->devdata;
+	acpi_status status;
+
+	if (d->override_ops && d->override_ops->set_trip_temp)
+		return d->override_ops->set_trip_temp(zone, 0, temp);
+
+	status = acpi_execute_simple_method(d->adev->handle, "PAT0",
+			millicelsius_to_deci_kelvin(temp));
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	d->aux_trips[0] = temp;
+
+	return 0;
+}
+
 static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
 	.get_temp       = int340x_thermal_get_zone_temp,
 	.get_trip_temp	= int340x_thermal_get_trip_temp,
 	.get_trip_type	= int340x_thermal_get_trip_type,
 	.set_trip_temp	= int340x_thermal_set_trip_temp,
 	.get_trip_hyst =  int340x_thermal_get_trip_hyst,
+	.set_temp_thres_low = int340x_thermal_set_thres_low,
+	.get_temp_thres_low = int340x_thermal_get_thres_low,
 };
 
 static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
index 3b4971df1b33..142027e4955f 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
@@ -58,4 +58,11 @@ static inline void int340x_thermal_zone_device_update(
 	thermal_zone_device_update(tzone->zone, event);
 }
 
+static inline void int340x_thermal_send_user_event(
+					struct int34x_thermal_zone *tzone,
+					enum thermal_device_events event,
+					u64 data)
+{
+	thermal_dev_send_event(tzone->zone->id, event, data);
+}
 #endif
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 297db1d2d960..e25f01948d33 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -340,6 +340,7 @@ static void proc_thermal_notify(acpi_handle handle, u32 event, void *data)
 		proc_thermal_read_ppcc(proc_priv);
 		int340x_thermal_zone_device_update(proc_priv->int340x_zone,
 				THERMAL_DEVICE_POWER_CAPABILITY_CHANGED);
+		int340x_thermal_send_user_event(proc_priv->int340x_zone, THERMAL_PERF_CHANGED, 0);
 		break;
 	default:
 		dev_dbg(proc_priv->dev, "Unsupported event [0x%x]\n", event);
-- 
2.25.4

