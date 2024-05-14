Return-Path: <linux-pm+bounces-7837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C8A8C4F80
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB28280FC6
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09370140361;
	Tue, 14 May 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oMn640gB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/i0eeb8r"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F397D13F457
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681945; cv=none; b=u5lQd4VvKQxXs0O/mDESN06BGRjfUIyM7p5XJQ8NTuSDbCpVV5ECLtserLpEnhFXCACFkgU0holUyROKB6b9xGHpAPpIiE+bo+UYHOEw32jXgXYhu4pliYC4kpJk5ALZG1AdOJGV6PLO7NqxrO1+7vm12ffstE5yHJ1Sr+fw1t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681945; c=relaxed/simple;
	bh=Y37NvGJNHMXCuilyTrtoM5vJ+ET23UGypFhxqF12nFk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=kHXXmH6yp0NtV9UW9LKLa+kombtVFOJ8hMKvZzwuDyKulumaai+iJ6rhGDLLDPVBkzdnQoNVpdxyMncd1tWvDdRCYigJuc2/e0/0FOb6ilbEmQKWzuHx8kCUj3LSYuDIG09npQQuZnjWMlmK+ImcZ7wBnDK8w1Y9yRH7sxKtlWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oMn640gB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/i0eeb8r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hiP+VzDuMvjW/aD8bZ0BVXrspTAL0qJUXX27+VzzwBk=;
	b=oMn640gBtADBzCIajW0Q3/Z8/A9C8O8ANaljphAKPjP9pQB2rEIJ9RoD1YTCwYskRn0/Qg
	D2qDazWvb3WdXroMK2P3amvGF3rU4ZAn4TIGy/XV+11YD4XFXzViS2mlhheKcMdJ9CNqKn
	AFBtc7CWInUlCiskKCw53D+49uwbWydDGY7muhgQ3oDdLy7UPhOE2aLgDUfMn3h1AbO8+P
	sAc6eLuFNIHGeLRRob+ueejaDkKo9RPoMhB3vtjTrhJrE03tBZaRdjk6LVWNp2X1eg4iFY
	XHA4eD22fWJ98W/bdguaC+kEd/8GlAh1FDRxqAZKbCun/AYTZxFeCFx8dZ8cRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hiP+VzDuMvjW/aD8bZ0BVXrspTAL0qJUXX27+VzzwBk=;
	b=/i0eeb8rMLBOdUlgQZvT2hAhzu2O85/cK2TiPfr9MVJaSNN+wpzST8G1X5uuc06SKODRVI
	j4fQIhR/VWLvP4Ag==
From: "thermal-bot for Rafael J. Wysocki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal: core: Make struct
 thermal_zone_device definition internal
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 rui.zhang@intel.com, amitk@kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193681.10875.3713951064776021375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     b1ae92dcfa8ed7d5044c525c3a868fcb4d0f9c0e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//b1ae92dcfa8ed7d5044c525c3a868fcb4d0f9c0e
Author:        Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate:    Tue, 02 Apr 2024 20:57:57 +02:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 08 Apr 2024 16:01:20 +02:00

thermal: core: Make struct thermal_zone_device definition internal

Move the definitions of struct thermal_trip_desc and struct
thermal_zone_device to an internal header file in the thermal core,
as they don't need to be accessible to any code other than the thermal
core and so they don't need to be present in a global header.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h      | 85 +++++++++++++++++++++++++++-
 drivers/thermal/thermal_trace.h     |  2 +-
 drivers/thermal/thermal_trace_ipa.h |  2 +-
 include/linux/thermal.h             | 87 +----------------------------
 4 files changed, 91 insertions(+), 85 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 4ad9c67..5dd3be5 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -15,6 +15,91 @@
 #include "thermal_netlink.h"
 #include "thermal_debugfs.h"
 
+struct thermal_trip_desc {
+	struct thermal_trip trip;
+	int threshold;
+};
+
+/**
+ * struct thermal_zone_device - structure for a thermal zone
+ * @id:		unique id number for each thermal zone
+ * @type:	the thermal zone device type
+ * @device:	&struct device for this thermal zone
+ * @removal:	removal completion
+ * @trip_temp_attrs:	attributes for trip points for sysfs: trip temperature
+ * @trip_type_attrs:	attributes for trip points for sysfs: trip type
+ * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
+ * @mode:		current mode of this thermal zone
+ * @devdata:	private pointer for device private data
+ * @num_trips:	number of trip points the thermal zone supports
+ * @passive_delay_jiffies: number of jiffies to wait between polls when
+ *			performing passive cooling.
+ * @polling_delay_jiffies: number of jiffies to wait between polls when
+ *			checking whether trip points have been crossed (0 for
+ *			interrupt driven systems)
+ * @temperature:	current temperature.  This is only for core code,
+ *			drivers should use thermal_zone_get_temp() to get the
+ *			current temperature
+ * @last_temperature:	previous temperature read
+ * @emul_temperature:	emulated temperature when using CONFIG_THERMAL_EMULATION
+ * @passive:		1 if you've crossed a passive trip point, 0 otherwise.
+ * @prev_low_trip:	the low current temperature if you've crossed a passive
+			trip point.
+ * @prev_high_trip:	the above current temperature if you've crossed a
+			passive trip point.
+ * @need_update:	if equals 1, thermal_zone_device_update needs to be invoked.
+ * @ops:	operations this &thermal_zone_device supports
+ * @tzp:	thermal zone parameters
+ * @governor:	pointer to the governor for this thermal zone
+ * @governor_data:	private pointer for governor data
+ * @thermal_instances:	list of &struct thermal_instance of this thermal zone
+ * @ida:	&struct ida to generate unique id for this zone's cooling
+ *		devices
+ * @lock:	lock to protect thermal_instances list
+ * @node:	node in thermal_tz_list (in thermal_core.c)
+ * @poll_queue:	delayed work for polling
+ * @notify_event: Last notification event
+ * @suspended: thermal zone suspend indicator
+ * @trips:	array of struct thermal_trip objects
+ */
+struct thermal_zone_device {
+	int id;
+	char type[THERMAL_NAME_LENGTH];
+	struct device device;
+	struct completion removal;
+	struct attribute_group trips_attribute_group;
+	struct thermal_attr *trip_temp_attrs;
+	struct thermal_attr *trip_type_attrs;
+	struct thermal_attr *trip_hyst_attrs;
+	enum thermal_device_mode mode;
+	void *devdata;
+	int num_trips;
+	unsigned long passive_delay_jiffies;
+	unsigned long polling_delay_jiffies;
+	int temperature;
+	int last_temperature;
+	int emul_temperature;
+	int passive;
+	int prev_low_trip;
+	int prev_high_trip;
+	atomic_t need_update;
+	struct thermal_zone_device_ops ops;
+	struct thermal_zone_params *tzp;
+	struct thermal_governor *governor;
+	void *governor_data;
+	struct list_head thermal_instances;
+	struct ida ida;
+	struct mutex lock;
+	struct list_head node;
+	struct delayed_work poll_queue;
+	enum thermal_notify_event notify_event;
+	bool suspended;
+#ifdef CONFIG_THERMAL_DEBUGFS
+	struct thermal_debugfs *debugfs;
+#endif
+	struct thermal_trip_desc trips[] __counted_by(num_trips);
+};
+
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
 #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_trace.h
index 459c8ce..88a962f 100644
--- a/drivers/thermal/thermal_trace.h
+++ b/drivers/thermal/thermal_trace.h
@@ -9,6 +9,8 @@
 #include <linux/thermal.h>
 #include <linux/tracepoint.h>
 
+#include "thermal_core.h"
+
 TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL);
 TRACE_DEFINE_ENUM(THERMAL_TRIP_HOT);
 TRACE_DEFINE_ENUM(THERMAL_TRIP_PASSIVE);
diff --git a/drivers/thermal/thermal_trace_ipa.h b/drivers/thermal/thermal_trace_ipa.h
index b16b5dd..a82821e 100644
--- a/drivers/thermal/thermal_trace_ipa.h
+++ b/drivers/thermal/thermal_trace_ipa.h
@@ -7,6 +7,8 @@
 
 #include <linux/tracepoint.h>
 
+#include "thermal_core.h"
+
 TRACE_EVENT(thermal_power_allocator,
 	TP_PROTO(struct thermal_zone_device *tz, u32 total_req_power,
 		 u32 total_granted_power, int num_actors, u32 power_range,
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 67bd133..62b1745 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -73,17 +73,14 @@ struct thermal_trip {
 	void *priv;
 };
 
-struct thermal_trip_desc {
-	struct thermal_trip trip;
-	int threshold;
-};
-
 #define THERMAL_TRIP_FLAG_RW_TEMP	BIT(0)
 #define THERMAL_TRIP_FLAG_RW_HYST	BIT(1)
 
 #define THERMAL_TRIP_FLAG_RW	(THERMAL_TRIP_FLAG_RW_TEMP | \
 				 THERMAL_TRIP_FLAG_RW_HYST)
 
+struct thermal_zone_device;
+
 struct thermal_zone_device_ops {
 	int (*bind) (struct thermal_zone_device *,
 		     struct thermal_cooling_device *);
@@ -130,86 +127,6 @@ struct thermal_cooling_device {
 };
 
 /**
- * struct thermal_zone_device - structure for a thermal zone
- * @id:		unique id number for each thermal zone
- * @type:	the thermal zone device type
- * @device:	&struct device for this thermal zone
- * @removal:	removal completion
- * @trip_temp_attrs:	attributes for trip points for sysfs: trip temperature
- * @trip_type_attrs:	attributes for trip points for sysfs: trip type
- * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
- * @mode:		current mode of this thermal zone
- * @devdata:	private pointer for device private data
- * @num_trips:	number of trip points the thermal zone supports
- * @passive_delay_jiffies: number of jiffies to wait between polls when
- *			performing passive cooling.
- * @polling_delay_jiffies: number of jiffies to wait between polls when
- *			checking whether trip points have been crossed (0 for
- *			interrupt driven systems)
- * @temperature:	current temperature.  This is only for core code,
- *			drivers should use thermal_zone_get_temp() to get the
- *			current temperature
- * @last_temperature:	previous temperature read
- * @emul_temperature:	emulated temperature when using CONFIG_THERMAL_EMULATION
- * @passive:		1 if you've crossed a passive trip point, 0 otherwise.
- * @prev_low_trip:	the low current temperature if you've crossed a passive
-			trip point.
- * @prev_high_trip:	the above current temperature if you've crossed a
-			passive trip point.
- * @need_update:	if equals 1, thermal_zone_device_update needs to be invoked.
- * @ops:	operations this &thermal_zone_device supports
- * @tzp:	thermal zone parameters
- * @governor:	pointer to the governor for this thermal zone
- * @governor_data:	private pointer for governor data
- * @thermal_instances:	list of &struct thermal_instance of this thermal zone
- * @ida:	&struct ida to generate unique id for this zone's cooling
- *		devices
- * @lock:	lock to protect thermal_instances list
- * @node:	node in thermal_tz_list (in thermal_core.c)
- * @poll_queue:	delayed work for polling
- * @notify_event: Last notification event
- * @suspended: thermal zone suspend indicator
- * @trips:	array of struct thermal_trip objects
- */
-struct thermal_zone_device {
-	int id;
-	char type[THERMAL_NAME_LENGTH];
-	struct device device;
-	struct completion removal;
-	struct attribute_group trips_attribute_group;
-	struct thermal_attr *trip_temp_attrs;
-	struct thermal_attr *trip_type_attrs;
-	struct thermal_attr *trip_hyst_attrs;
-	enum thermal_device_mode mode;
-	void *devdata;
-	int num_trips;
-	unsigned long passive_delay_jiffies;
-	unsigned long polling_delay_jiffies;
-	int temperature;
-	int last_temperature;
-	int emul_temperature;
-	int passive;
-	int prev_low_trip;
-	int prev_high_trip;
-	atomic_t need_update;
-	struct thermal_zone_device_ops ops;
-	struct thermal_zone_params *tzp;
-	struct thermal_governor *governor;
-	void *governor_data;
-	struct list_head thermal_instances;
-	struct ida ida;
-	struct mutex lock;
-	struct list_head node;
-	struct delayed_work poll_queue;
-	enum thermal_notify_event notify_event;
-	bool suspended;
-#ifdef CONFIG_THERMAL_DEBUGFS
-	struct thermal_debugfs *debugfs;
-#endif
-	struct thermal_trip_desc trips[] __counted_by(num_trips);
-};
-
-/**
  * struct thermal_governor - structure that holds thermal governor information
  * @name:	name of the governor
  * @bind_to_tz: callback called when binding to a thermal zone.  If it

