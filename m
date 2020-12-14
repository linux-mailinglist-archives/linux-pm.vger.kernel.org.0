Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3BD2D9A2A
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 15:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438299AbgLNOlM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 09:41:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51672 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408226AbgLNOlD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 09:41:03 -0500
Date:   Mon, 14 Dec 2020 14:40:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607956820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPTZaRW5S7wF6Sk4o1lZr7D06VGXAdkI6NVAHQwtHck=;
        b=xUsafWpRwaPAMDtsSjv+ejOHQqQi1KmhN9T5VndLcIIMjZ87ss9mRCJHgXieylh+9MPlxU
        xJ5Pro4QF2qn58aWg03GLUKzAhgbmCYRQlThUy0Ux3wDlPAErtZ3Fg1wZWxa4C25d7LQM+
        h9nqCXuoCHp6F0pFzDsAgEkdJEK2ym/h7AknSADdHSERN7Wvn5vJaemy2zaGctr/zQE/2g
        SELZDRelPcjE/jMuEMwXTed66hk6e0bwIQ23bbhoUKU1H4iGa+3nmPxRRBaIW5dQ2LCZ80
        k1lIxEKV6e3px71rPO2JZd8UQWcvnJuofP4XF5il94oMKEEM52p0rgikawK2VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607956820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPTZaRW5S7wF6Sk4o1lZr7D06VGXAdkI6NVAHQwtHck=;
        b=mXi7JmHhI0EYOufSJbMRhv6YqDXmfCD41WlCqogYZ8sj6El6jO+OHQyROoefI5TGFl7bF7
        H00DHoM6uu8tzSDA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Add critical and hot ops
Cc:     "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20201210121514.25760-2-daniel.lezcano@linaro.org>
References: <20201210121514.25760-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <160795681913.3364.1257623265702641480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     d7203eedf4f68e9909fd489453168a9d26bf0c3d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d7203eedf4f68e9909fd489453168a9d26bf0c3d
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Thu, 10 Dec 2020 13:15:11 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 11 Dec 2020 14:11:13 +01:00

thermal/core: Add critical and hot ops

Currently there is no way to the sensors to directly call an ops in
interrupt mode without calling thermal_zone_device_update assuming all
the trip points are defined.

A sensor may want to do something special if a trip point is hot or
critical.

This patch adds the critical and hot ops to the thermal zone device,
so a sensor can directly invoke them or let the thermal framework to
call the sensor specific ones.

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20201210121514.25760-2-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c | 43 ++++++++++++++++++++-------------
 include/linux/thermal.h        |  3 ++-
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 64de098..4a291d2 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -380,6 +380,25 @@ static void thermal_emergency_poweroff(void)
 			      msecs_to_jiffies(poweroff_delay_ms));
 }
 
+void thermal_zone_device_critical(struct thermal_zone_device *tz)
+{
+	dev_emerg(&tz->device, "%s: critical temperature reached, "
+		  "shutting down\n", tz->type);
+
+	mutex_lock(&poweroff_lock);
+	if (!power_off_triggered) {
+		/*
+		 * Queue a backup emergency shutdown in the event of
+		 * orderly_poweroff failure
+		 */
+		thermal_emergency_poweroff();
+		orderly_poweroff(true);
+		power_off_triggered = true;
+	}
+	mutex_unlock(&poweroff_lock);
+}
+EXPORT_SYMBOL(thermal_zone_device_critical);
+
 static void handle_critical_trips(struct thermal_zone_device *tz,
 				  int trip, enum thermal_trip_type trip_type)
 {
@@ -396,22 +415,10 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 	if (tz->ops->notify)
 		tz->ops->notify(tz, trip, trip_type);
 
-	if (trip_type == THERMAL_TRIP_CRITICAL) {
-		dev_emerg(&tz->device,
-			  "critical temperature reached (%d C), shutting down\n",
-			  tz->temperature / 1000);
-		mutex_lock(&poweroff_lock);
-		if (!power_off_triggered) {
-			/*
-			 * Queue a backup emergency shutdown in the event of
-			 * orderly_poweroff failure
-			 */
-			thermal_emergency_poweroff();
-			orderly_poweroff(true);
-			power_off_triggered = true;
-		}
-		mutex_unlock(&poweroff_lock);
-	}
+	if (trip_type == THERMAL_TRIP_HOT && tz->ops->hot)
+		tz->ops->hot(tz);
+	else if (trip_type == THERMAL_TRIP_CRITICAL)
+		tz->ops->critical(tz);
 }
 
 static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
@@ -1336,6 +1343,10 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 
 	tz->id = id;
 	strlcpy(tz->type, type, sizeof(tz->type));
+
+	if (!ops->critical)
+		ops->critical = thermal_zone_device_critical;
+
 	tz->ops = ops;
 	tz->tzp = tzp;
 	tz->device.class = &thermal_class;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d07ea27..31b8440 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -79,6 +79,8 @@ struct thermal_zone_device_ops {
 			  enum thermal_trend *);
 	int (*notify) (struct thermal_zone_device *, int,
 		       enum thermal_trip_type);
+	void (*hot)(struct thermal_zone_device *);
+	void (*critical)(struct thermal_zone_device *);
 };
 
 struct thermal_cooling_device_ops {
@@ -399,6 +401,7 @@ void thermal_cdev_update(struct thermal_cooling_device *);
 void thermal_notify_framework(struct thermal_zone_device *, int);
 int thermal_zone_device_enable(struct thermal_zone_device *tz);
 int thermal_zone_device_disable(struct thermal_zone_device *tz);
+void thermal_zone_device_critical(struct thermal_zone_device *tz);
 #else
 static inline struct thermal_zone_device *thermal_zone_device_register(
 	const char *type, int trips, int mask, void *devdata,
