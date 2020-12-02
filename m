Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8081A2CBC6E
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 13:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgLBMIA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 07:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbgLBMIA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 07:08:00 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC1EC0617A7
        for <linux-pm@vger.kernel.org>; Wed,  2 Dec 2020 04:07:19 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s8so3585126wrw.10
        for <linux-pm@vger.kernel.org>; Wed, 02 Dec 2020 04:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UIDq+KW00cXiRWlv/JAzZ8+RBZbAH3GMyxtATb0Dmi4=;
        b=mXiAtgM0W/LxjZMo+BhxY/PMo8HDvF95Z9Ow1zW7TsE2y180u+oF56zehpf2tNgeQQ
         YXJBf7G0CJDXKeOV7NCHASKya27I0q9iIPF74dgSzhVzV/rgWoVXwwWVHt3ViyS+t4gO
         eysDa3SvVI9/UJZ8jCFPP4KtSrGD5NyVzxeTHJ00HBJAFKXG4LYEuRZ50tPa2gy0YiAo
         I3WjXZ1Z5bVTwYUteZxOjqLdhOF2poPenoV2lFHK56cuHeX2EK2TfVHm5LvvRcBQZppK
         V1G/eZkTpVtq/jWhIsmAKS9cTeWONvVl5IHozGecjNOucBC2z9ZI871WoORJdwueDoFg
         c4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UIDq+KW00cXiRWlv/JAzZ8+RBZbAH3GMyxtATb0Dmi4=;
        b=g0+jbsi+7jYf20y+pr/bdTjgRrqiAKO46xbDTMGF0lvW4zKTcXEqmwpGT/vyjzFnxN
         BXglnJDG9NAbXz2+JB0A+WgRdGKrc+Fc6JYdhJsMzXWb/ib1ANimOY+o3HmvH2AbB36h
         IlOaigBD7O0rivfQsEsiLzdd6DeUz8GUD3acx6WXI3xRBrAUNHnh6+A9vUCtGBr/0ETB
         WJ45NQ8H01H/dLAIkhOHhyppeJ7oUvRkIbzXRUITC1cMKzKq5VoJzgZeFTZvjBnWw7Q8
         lboU30YdRhEDgNZAT4ZXfw/IRg1wHsnTgBhiKU+3cgkhLgsD3mQo1TRobCuPzH7D36+o
         vZbA==
X-Gm-Message-State: AOAM533u8nH6RegfSgjslUgW2gGTRZ1ijsToq9/svBbdonlG250eWcvd
        HO44Jsv3UGSgDQAanqLKkW9GtON5SvZSWQ==
X-Google-Smtp-Source: ABdhPJwaIUOTKsm41DdVvpj96ALshPKT0Yf32c4g5vUFDjRkYQ/LU2+levso9Z0tstsb7HLbSaLS2g==
X-Received: by 2002:adf:dd0e:: with SMTP id a14mr3071026wrm.36.1606910838314;
        Wed, 02 Dec 2020 04:07:18 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-140-184.adsl.proxad.net. [82.252.140.184])
        by smtp.gmail.com with ESMTPSA id c1sm1755132wml.8.2020.12.02.04.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:07:17 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/4] thermal/core: Precompute the jiffies
Date:   Wed,  2 Dec 2020 13:06:55 +0100
Message-Id: <20201202120657.1969-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202120657.1969-1-daniel.lezcano@linaro.org>
References: <20201202120657.1969-1-daniel.lezcano@linaro.org>
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
index 53f55ceca220..3111ca2c87a1 100644
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

