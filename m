Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633CB2DC8AC
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 23:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgLPWEh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 17:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgLPWEg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 17:04:36 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7CBC061794
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 14:03:56 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 91so24619238wrj.7
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 14:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQ2hOfI0dzYX8OoDPqs1f4i7ZZhNl5HguLcf9GaVfOw=;
        b=YHWHFPxcMCKDHvCMyAdpsNCWoaQL9MlYQn4/DVfR9dt2e4Yjz3pd0KMsmapEdptFfL
         erXAGBi2f8z04bSSQ4AgAHNywOvFfetMsgm7MQtn+KwGOzK6+9EGL1TlF9lMWf+ArjTM
         ar4e4u52DWrL2c98jLSFsYCql9kKWGxFrLz+/EAXLpz+gO5pScrboqZ0k0un5rBiiF2l
         /bQL33DLbML9zVPSecQrXc/+Mt+TURgv1Q7aDuM2SryLDUDsBvqhPAEdNKYhBQEOAhHg
         SlvqMyTb1/mEY3+XdI084jzfQh83yL9CPFoythPke/Xfc9Jqy3tF+jLXY0ULHp652GW3
         ro2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQ2hOfI0dzYX8OoDPqs1f4i7ZZhNl5HguLcf9GaVfOw=;
        b=I8Loc05Z/F4vDd/xs19NcxjbGNVdsFdrmzu1tbajOzXobbKk+3TwYT5ZJqwZgaokQb
         dFEIZYdNzDrKQnmyFVHhFCJfzr8Hv5ks0KuvM6DrY4PCLzebwnkOSjhA7LwLTUUBk2Ni
         5TwifYpIEq7GjFceKpz9ZMV5dqX4jt5eabYQEZPYDKgXFiFiCRIyac53BlidTzmjit/h
         KP5QeTT7fL2EaSYj6HCE6kHU/NCSEEIU6/Vvir9Dn+ka0p14hCEvPQaG5iGD7yIW+kyj
         LLsxyFB7qdv2erkWJkWnafSW7Y6pBtB5yEDEuKKewHwAI+NP/NdjJK3ElfQvn4hAdMUL
         hoOQ==
X-Gm-Message-State: AOAM5332G/R5JJuMehtTgQxwbDnV+2eQxbLw4gCcY+d4nla1rYHzjFdL
        voxfE2rm/fDpfZGsmRpFRa+g1w==
X-Google-Smtp-Source: ABdhPJx6Jh8D/DJGFsLfvyHBHzvfVLO/QXMI08J8DTEuFFGgdH9KXFqYUuNeXqpGyZWuWjqWgz5P2A==
X-Received: by 2002:a5d:4bc2:: with SMTP id l2mr24594609wrt.204.1608156234512;
        Wed, 16 Dec 2020 14:03:54 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:601a:58a2:ee98:f8a1])
        by smtp.gmail.com with ESMTPSA id a17sm5277933wrs.20.2020.12.16.14.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 14:03:53 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v2 1/3] thermal/core: Precompute the delays from msecs to jiffies
Date:   Wed, 16 Dec 2020 23:03:35 +0100
Message-Id: <20201216220337.839878-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The delays are stored in ms units and when the polling function is
called this delay is converted into jiffies at each call.

Instead of doing the conversion again and again, compute the jiffies
at init time and use the value directly when setting the polling.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.c    | 3 +++
 drivers/thermal/thermal_core.h    | 1 +
 drivers/thermal/thermal_helpers.c | 7 +++++++
 include/linux/thermal.h           | 7 +++++++
 4 files changed, 18 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index bcc2ea4f5482..2c41d4a0923f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1315,6 +1315,9 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	tz->passive_delay = passive_delay;
 	tz->polling_delay = polling_delay;
 
+	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
+	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
+
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
 	result = thermal_zone_create_device_groups(tz, mask);
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index e50c6b2909fe..90f9a80c8b23 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -123,6 +123,7 @@ int thermal_build_list_of_policies(char *buf);
 
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
+void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index c94bc824e5d3..7f50f412e02a 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -175,6 +175,13 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
+void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
+{
+	*delay_jiffies = msecs_to_jiffies(delay_ms);
+	if (delay_ms > 1000)
+		*delay_jiffies = round_jiffies(*delay_jiffies);
+}
+
 static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
 				       int target)
 {
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 060a2160add4..d1b82c70de69 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -117,9 +117,14 @@ struct thermal_cooling_device {
  * @trips_disabled;	bitmap for disabled trips
  * @passive_delay:	number of milliseconds to wait between polls when
  *			performing passive cooling.
+ * @passive_delay_jiffies: number of jiffies to wait between polls when
+ *			performing passive cooling.
  * @polling_delay:	number of milliseconds to wait between polls when
  *			checking whether trip points have been crossed (0 for
  *			interrupt driven systems)
+ * @polling_delay_jiffies: number of jiffies to wait between polls when
+ *			checking whether trip points have been crossed (0 for
+ *			interrupt driven systems)
  * @temperature:	current temperature.  This is only for core code,
  *			drivers should use thermal_zone_get_temp() to get the
  *			current temperature
@@ -155,6 +160,8 @@ struct thermal_zone_device {
 	void *devdata;
 	int trips;
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
+	unsigned long passive_delay_jiffies;
+	unsigned long polling_delay_jiffies;
 	int passive_delay;
 	int polling_delay;
 	int temperature;
-- 
2.25.1

