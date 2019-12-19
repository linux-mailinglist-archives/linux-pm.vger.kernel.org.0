Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 878B9127095
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 23:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfLSWWJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 17:22:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51086 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfLSWWJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 17:22:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so7019768wmb.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 14:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+EdJlshrU/x9lwXaiDsMcX871Y/B3IPP2mzwerHvxc0=;
        b=OBYavYa3Os4P3wLJqYc7ViOZC9UtFFSArzXrXdPXO3u/P6Fp+c/tZWkJ+54mrV5+Ql
         PPVp8YdxWqA59qeUMnStPysx3l+AICJR1TLM3NIVcUzMV+FaC6ciUwqpvmNt6AfUCwxW
         aqGQKQiwTUKWxaSGkfsLgiFxZfgmx5LMAd+Lz9dha6Z8sHPIQ5P8wg6ByWQid7SW+lWd
         romJPspM/EhgfAVanxijAsqNdPmyOlb15lVhMRxRIVi84XVf52/y7lS7RHyxN+Il3xsh
         9c3EqCphIVONRXpK69tJ316L7xSYrE2gXEMpR3WCKHlHVu6sWl0oQzvjwRH7mq1atxw0
         rJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+EdJlshrU/x9lwXaiDsMcX871Y/B3IPP2mzwerHvxc0=;
        b=GcqKlql08OnsYRGBdbPi5MEu/GjpvcZ1F4VB1KKfi4EkwhtDicru/0IAxqympmm14S
         HTyzg7rh12UzbhgGvORO7gwGRcxOGlzRKUs1gQGouW6m7+YWidLCuNAWy4MxOIPKtRbD
         JAW7DFBpVM/XfrxwFTiei8nn4q7xvX6rULjUuqX/0S/XVCCP4+151hGY0HCo7kfSmyU/
         Bg/3TVsuKInCGDUUVNMagT0APerSxd1m6NrWVLP2D9FqGqTGkCCuGpgiu3pIUKVM4l2g
         NGJsX4pcsw13F+0G7gXFX80PK0sazM6HGYdrmXNr5HWcCbPW+mySiohHM5X2PO/92ZXz
         QSXQ==
X-Gm-Message-State: APjAAAWDa86Rz4vMjQmXyIpLgufqkLXtDkfplUtNfaEu8jbFgotalLa0
        SD8Paw9ruzFVoaJsPoUVcpksSg==
X-Google-Smtp-Source: APXvYqxIwrQqO/WUQCmlhV0J4pjiUCYJdYEful8OM0YCNQMEt1xhhWrR6SBU+q4pjINCvhcrEuKT2w==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr12429961wmi.152.1576794126696;
        Thu, 19 Dec 2019 14:22:06 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:58d:4e9b:2833:86c3])
        by smtp.gmail.com with ESMTPSA id q68sm8942295wme.14.2019.12.19.14.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 14:22:06 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] thermal/drivers/of-thermal: Make of_thermal_destroy_zones static
Date:   Thu, 19 Dec 2019 23:21:52 +0100
Message-Id: <20191219222154.16100-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function of_thermal_destroy_zones() is only used internally by the
of_parse_thermal_zones() for rollbacking in case of error.

Make it static and tag it as an __init function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/of-thermal.c   | 64 +++++++++++++++++-----------------
 drivers/thermal/thermal_core.h |  2 --
 2 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index dc5093be553e..4333cd5f1073 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -998,6 +998,38 @@ static inline void of_thermal_free_zone(struct __thermal_zone *tz)
 	kfree(tz);
 }
 
+/**
+ * of_thermal_destroy_zones - remove all zones parsed and allocated resources
+ *
+ * Finds all zones parsed and added to the thermal framework and remove them
+ * from the system, together with their resources.
+ *
+ */
+static __init void of_thermal_destroy_zones(void)
+{
+	struct device_node *np, *child;
+
+	np = of_find_node_by_name(NULL, "thermal-zones");
+	if (!np) {
+		pr_debug("unable to find thermal zones\n");
+		return;
+	}
+
+	for_each_available_child_of_node(np, child) {
+		struct thermal_zone_device *zone;
+
+		zone = thermal_zone_get_zone_by_name(child->name);
+		if (IS_ERR(zone))
+			continue;
+
+		thermal_zone_device_unregister(zone);
+		kfree(zone->tzp);
+		kfree(zone->ops);
+		of_thermal_free_zone(zone->devdata);
+	}
+	of_node_put(np);
+}
+
 /**
  * of_parse_thermal_zones - parse device tree thermal data
  *
@@ -1087,35 +1119,3 @@ int __init of_parse_thermal_zones(void)
 
 	return -ENOMEM;
 }
-
-/**
- * of_thermal_destroy_zones - remove all zones parsed and allocated resources
- *
- * Finds all zones parsed and added to the thermal framework and remove them
- * from the system, together with their resources.
- *
- */
-void of_thermal_destroy_zones(void)
-{
-	struct device_node *np, *child;
-
-	np = of_find_node_by_name(NULL, "thermal-zones");
-	if (!np) {
-		pr_debug("unable to find thermal zones\n");
-		return;
-	}
-
-	for_each_available_child_of_node(np, child) {
-		struct thermal_zone_device *zone;
-
-		zone = thermal_zone_get_zone_by_name(child->name);
-		if (IS_ERR(zone))
-			continue;
-
-		thermal_zone_device_unregister(zone);
-		kfree(zone->tzp);
-		kfree(zone->ops);
-		of_thermal_free_zone(zone->devdata);
-	}
-	of_node_put(np);
-}
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 207b0cda70da..a9bf00e91d64 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -92,14 +92,12 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 /* device tree support */
 #ifdef CONFIG_THERMAL_OF
 int of_parse_thermal_zones(void);
-void of_thermal_destroy_zones(void);
 int of_thermal_get_ntrips(struct thermal_zone_device *);
 bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
 const struct thermal_trip *
 of_thermal_get_trip_points(struct thermal_zone_device *);
 #else
 static inline int of_parse_thermal_zones(void) { return 0; }
-static inline void of_thermal_destroy_zones(void) { }
 static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
 {
 	return 0;
-- 
2.17.1

