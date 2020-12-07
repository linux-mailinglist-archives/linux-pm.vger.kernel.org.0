Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F592D192D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 20:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgLGTKF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 14:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgLGTKD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 14:10:03 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB462C061749
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 11:09:17 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id e25so277339wme.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 11:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LwCnH4NJfHp5ZykyBVx/tUGuZ/xxrEB0midiN+uyBnQ=;
        b=XfOuHP/I+sgUgtIImebemPfmcZZujI8Cebh1xBnaU9kkJvzZodlCckakvVyq5R2i7i
         8PvJiTTaTfwYSVHpRmWBXrHgtPDkCrIiEtQ88RZ/JD+PKqMYuHIVq7BEf+K4PquIsp3B
         ZbnTdYLnpd/AkzqvutIx5jTYSJs4Eyhxk6VuKOUFp6WPTqV6fgMj4wOem1a+BdG9GdJJ
         TIvcQc1j8GuyAW/cLflX21znv7bUMGUeH68DQQmmCr1j08IlUTt+oQjrKan03EW+hc5L
         qaUWGKLC5bMbXycb8BCeaTjiJu4JZ/+Y/JUomOxJYo2WzacxbWEADO8H6/ejQgLP669r
         eFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LwCnH4NJfHp5ZykyBVx/tUGuZ/xxrEB0midiN+uyBnQ=;
        b=TLiXIenFdWtrf+G9dIpSsCFFlQmHFqKcaeZ6cNFKvpjSVUFb/kfjzPV07VgyACfcgK
         im9fkJ1DIYHJXWy1W5ZrkVPGQyqQTy9uARGBew9Wfz6hT0xcjafquDUfFePH5Sm04Rf2
         Jcff0TvdyzyoxuD+qd37h3oWl4h7kjqYsY+tMTxvImKLhDn3kjyp76X1c7OQDE+AlUoy
         4xwYvdgNjF26ixuAzUvr1sOQ9c+zZXkeahOLsUM8OjOSnsLSxDCK/thBEIOlnCfduaz0
         gCTYgCIvWRkopxdOqTL0h7Bfo8K01iZ0J7L/CpKWfEWL4405GG5gvdKyuPftf7hbUds3
         ggXg==
X-Gm-Message-State: AOAM530ymQlTE+JIMBYBlAcTJYfuU3tGZoHjSVHsCglWicb35d5KnSl/
        3NOS1l1sMY+JA6B/bUzWxEkdkg==
X-Google-Smtp-Source: ABdhPJwPMyNHUTILCIZvl63yYKwMKQSWuHNnz702Axnx6wy5nZlnHtNhfgE9a+eh7n9Q6n3EpvbkQw==
X-Received: by 2002:a1c:491:: with SMTP id 139mr257287wme.81.1607368156261;
        Mon, 07 Dec 2020 11:09:16 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id v1sm16335827wrr.48.2020.12.07.11.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:09:15 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 2/4] thermal/core: Precompute the delays from msecs to jiffies
Date:   Mon,  7 Dec 2020 20:09:00 +0100
Message-Id: <20201207190902.30464-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201207190902.30464-1-daniel.lezcano@linaro.org>
References: <20201207190902.30464-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The delays are stored in ms units and when the polling function is
called this delay is converted into jiffies at each call.

Instead of doing the conversion again and again, compute the jiffies
at init time and use the value directly when setting the polling.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c  |  5 +++--
 drivers/thermal/thermal_core.h  | 18 ++++++++++++++++++
 drivers/thermal/thermal_sysfs.c |  4 ++--
 include/linux/thermal.h         |  7 +++++++
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5b500d72aab4..08c6e4e36896 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1340,8 +1340,9 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
 	tz->trips = trips;
-	tz->passive_delay_ms = passive_delay;
-	tz->polling_delay_ms = polling_delay;
+
+	thermal_zone_set_passive_delay(tz, passive_delay);
+	thermal_zone_set_polling_delay(tz, polling_delay);
 
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 8df600fa7b79..2c9551ed5ef8 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -128,6 +128,24 @@ int thermal_build_list_of_policies(char *buf);
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
 
+static inline void thermal_zone_set_passive_delay(
+	struct thermal_zone_device *tz, int delay_ms)
+{
+	tz->passive_delay_ms = delay_ms;
+	tz->passive_delay_jiffies = msecs_to_jiffies(delay_ms);
+	if (delay_ms > 1000)
+		tz->passive_delay_jiffies = round_jiffies(tz->passive_delay_jiffies);
+}
+
+static inline void thermal_zone_set_polling_delay(
+	struct thermal_zone_device *tz, int delay_ms)
+{
+	tz->polling_delay_ms = delay_ms;
+	tz->polling_delay_jiffies = msecs_to_jiffies(delay_ms);
+	if (delay_ms > 1000)
+		tz->polling_delay_jiffies = round_jiffies(tz->polling_delay_jiffies);
+}
+
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
 void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index f465462d8aa1..9598b288a0a1 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -234,11 +234,11 @@ passive_store(struct device *dev, struct device_attribute *attr,
 
 	if (state && !tz->forced_passive) {
 		if (!tz->passive_delay_ms)
-			tz->passive_delay_ms = 1000;
+			thermal_zone_set_passive_delay(tz, 1000);
 		thermal_zone_device_rebind_exception(tz, "Processor",
 						     sizeof("Processor"));
 	} else if (!state && tz->forced_passive) {
-		tz->passive_delay_ms = 0;
+		thermal_zone_set_passive_delay(tz, 0);
 		thermal_zone_device_unbind_exception(tz, "Processor",
 						     sizeof("Processor"));
 	}
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 230d451bf335..5dd9bdb6c6ad 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -118,9 +118,14 @@ struct thermal_cooling_device {
  * @trips_disabled;	bitmap for disabled trips
  * @passive_delay_ms:	number of milliseconds to wait between polls when
  *			performing passive cooling.
+ * @passive_delay_jiffies: number of jiffies to wait between polls when
+ *			performing passive cooling.
  * @polling_delay_ms:	number of milliseconds to wait between polls when
  *			checking whether trip points have been crossed (0 for
  *			interrupt driven systems)
+ * @polling_delay_jiffies: number of jiffies to wait between polls when
+ *			checking whether trip points have been crossed (0 for
+ *			interrupt driven systems)
  * @temperature:	current temperature.  This is only for core code,
  *			drivers should use thermal_zone_get_temp() to get the
  *			current temperature
@@ -161,6 +166,8 @@ struct thermal_zone_device {
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
 	int passive_delay_ms;
 	int polling_delay_ms;
+	int passive_delay_jiffies;
+	int polling_delay_jiffies;
 	int temperature;
 	int last_temperature;
 	int emul_temperature;
-- 
2.17.1

