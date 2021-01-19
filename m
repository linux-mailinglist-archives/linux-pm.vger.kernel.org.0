Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E2A2FC26D
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbhASVfC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 16:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbhASV2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 16:28:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF682C061575
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 13:27:29 -0800 (PST)
Date:   Tue, 19 Jan 2021 21:27:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611091646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3G+YDwPYN7neBOD8rA6aRuClL/6iHsM/u3oBKqzayY=;
        b=TkL13HYN9M6JRe7rlBVraTdGp7oxkM89DQD3OINLS4mQFCo//EXh5dnRM3VvZknOMZWWy7
        kdXbRtjFT+9F0xVaTpAg2MzWslJb3uYXgKqCZISkzEKNXsUX3zZYCyrRbU+lXvBUsEBXrS
        JvM7vdlL5bwCO59IHFi1g13l4ek8XlLg8gwwFioYVwut76y/bCemeMIxzZqWOQS2a4d2b4
        UQ33e3pbl9CUbBd6Ycihekn64O/BAtpRO9WhW4zXZ1TCM4A7hrT/47wpg6PyKfC7YCWInD
        CzDhwayF5OOc+vGS9RXuF888KdH4wq+GftCrP7Z2ojmCJxRBy2r2oApGWUxz3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611091646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3G+YDwPYN7neBOD8rA6aRuClL/6iHsM/u3oBKqzayY=;
        b=kQydRSo09rSqVDQlai7Lvq/QO+zy3Iv1EJzvqtZub9K3MAuwlsJqvN4//xKG0lZAXZTwJd
        1oft3R9va22iayCg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Precompute the delays from
 msecs to jiffies
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20201216220337.839878-1-daniel.lezcano@linaro.org>
References: <20201216220337.839878-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161109164594.414.12897889848127148595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     17d399cd9c8936909bc8936a5837b6da9af9c29e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//17d399cd9c8936909bc8936a5837b6da9af9c29e
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Wed, 16 Dec 2020 23:03:35 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 19 Jan 2021 22:23:38 +01:00

thermal/core: Precompute the delays from msecs to jiffies

The delays are stored in ms units and when the polling function is
called this delay is converted into jiffies at each call.

Instead of doing the conversion again and again, compute the jiffies
at init time and use the value directly when setting the polling.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Link: https://lore.kernel.org/r/20201216220337.839878-1-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c    | 3 +++
 drivers/thermal/thermal_core.h    | 1 +
 drivers/thermal/thermal_helpers.c | 7 +++++++
 include/linux/thermal.h           | 7 +++++++
 4 files changed, 18 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index bcc2ea4..2c41d4a 100644
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
index e50c6b2..90f9a80 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -123,6 +123,7 @@ int thermal_build_list_of_policies(char *buf);
 
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
+void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index c94bc82..7f50f41 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -175,6 +175,13 @@ exit:
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
index 060a216..d1b82c7 100644
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
