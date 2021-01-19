Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1C02FC257
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbhASV2o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 16:28:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36592 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbhASV2M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 16:28:12 -0500
Date:   Tue, 19 Jan 2021 21:27:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611091647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjuNqP+z8jDUXShB/2ufNeOTLnmkwvKeveq3DJrbIPU=;
        b=Ig91H/COgo3GLvpRYlSY17P6q2i2sds6eg0tnNMdw+ODIr9PZMn/pL25yiHHqVup2aA3pQ
        y+D2QyxKgxqlF4lHWmFovHt9HjT77pEaAK+t+0hOeIGnuqQ6/brxcVs0glWMn1LlM16qXl
        SyeKY0lefa9bRp72DO5pIYoNS0Nge6W+l83242eHJU71NddeEjuaf6YLU2MrqdGLrjYJ5L
        WqADzKts9jdpmi+3yjm/mDD2xaTfL3NHlLHYHCr3ZAr3NcHY9JcGXc641pj9LK8cJfuc9C
        1XleqXl9pr0+fMxuMdvlffr5j2jZzm8Nfv6D9nRH8pqFgoEmUKv0UDccC85qsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611091647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjuNqP+z8jDUXShB/2ufNeOTLnmkwvKeveq3DJrbIPU=;
        b=Pl1w2KA7wpBRBMTBvE4SA1j909TUG+xk+SLOsXUzLkXXqZlPhR4vArGQQFDeVhvHnSDcBq
        TFPvGDrQUj3u1XBg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Remove the 'forced_passive' option
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201214233811.485669-1-daniel.lezcano@linaro.org>
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161109164705.414.10993313469372759141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     a7d6ba14efb778fc8c65c627a057d5dd29debd04
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a7d6ba14efb778fc8c65c627a057d5dd29debd04
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Tue, 15 Dec 2020 00:38:04 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 19 Jan 2021 22:22:45 +01:00

thermal/core: Remove the 'forced_passive' option

The code was reorganized in 2012 with the commit 0c01ebbfd3caf1.

The main change is a loop on the trip points array and a unconditional
call to the throttle() ops of the governors for each of them even if
the trip temperature is not reached yet.

With this change, the 'forced_passive' is no longer checked in the
thermal_zone_device_update() function but in the step wise governor's
throttle() callback.

As the force_passive does no belong to the trip point array, the
thermal_zone_device_update() can not compare with the specified
passive temperature, thus does not detect the passive limit has been
crossed. Consequently, throttle() is never called and the
'forced_passive' branch is unreached.

In addition, the default processor cooling device is not automatically
bound to the thermal zone if there is not passive trip point, thus the
'forced_passive' can not operate.

If there is an active trip point, then the throttle function will be
called to mitigate at this temperature and the 'forced_passive' will
override the mitigation of the active trip point in this case but with
the default cooling device bound to the thermal zone, so usually a
fan, and that is not a passive cooling effect.

Given the regression exists since more than 8 years, nobody complained
and at the best of my knowledge there is no bug open in
https://bugzilla.kernel.org, it is reasonable to say it is unused.

Remove the 'forced_passive' related code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Link: https://lore.kernel.org/r/20201214233811.485669-1-daniel.lezcano@linaro.org
---
 Documentation/driver-api/thermal/sysfs-api.rst | 13 +---
 drivers/thermal/gov_step_wise.c                | 14 +---
 drivers/thermal/thermal_sysfs.c                | 80 +-----------------
 include/linux/thermal.h                        |  4 +-
 4 files changed, 3 insertions(+), 108 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index e7520cb..a4969c4 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -520,19 +520,6 @@ available_policies
 
 	RW, Optional
 
-passive
-	Attribute is only present for zones in which the passive cooling
-	policy is not supported by native thermal driver. Default is zero
-	and can be set to a temperature (in millidegrees) to enable a
-	passive trip point for the zone. Activation is done by polling with
-	an interval of 1 second.
-
-	Unit: millidegrees Celsius
-
-	Valid values: 0 (disabled) or greater than 1000
-
-	RW, Optional
-
 emul_temp
 	Interface to set the emulated temperature method in thermal zone
 	(sensor). After setting this temperature, the thermal zone may pass
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 2ae7198..12acb12 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -109,7 +109,7 @@ static void update_passive_instance(struct thermal_zone_device *tz,
 	 * If value is +1, activate a passive instance.
 	 * If value is -1, deactivate a passive instance.
 	 */
-	if (type == THERMAL_TRIP_PASSIVE || type == THERMAL_TRIPS_NONE)
+	if (type == THERMAL_TRIP_PASSIVE)
 		tz->passive += value;
 }
 
@@ -122,13 +122,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 	bool throttle = false;
 	int old_target;
 
-	if (trip == THERMAL_TRIPS_NONE) {
-		trip_temp = tz->forced_passive;
-		trip_type = THERMAL_TRIPS_NONE;
-	} else {
-		tz->ops->get_trip_temp(tz, trip, &trip_temp);
-		tz->ops->get_trip_type(tz, trip, &trip_type);
-	}
+	tz->ops->get_trip_temp(tz, trip, &trip_temp);
+	tz->ops->get_trip_type(tz, trip, &trip_type);
 
 	trend = get_tz_trend(tz, trip);
 
@@ -189,9 +184,6 @@ static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
 
 	thermal_zone_trip_update(tz, trip);
 
-	if (tz->forced_passive)
-		thermal_zone_trip_update(tz, THERMAL_TRIPS_NONE);
-
 	mutex_lock(&tz->lock);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 0866e94..4e7f9e8 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -217,49 +217,6 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t
-passive_store(struct device *dev, struct device_attribute *attr,
-	      const char *buf, size_t count)
-{
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int state;
-
-	if (sscanf(buf, "%d\n", &state) != 1)
-		return -EINVAL;
-
-	/* sanity check: values below 1000 millicelcius don't make sense
-	 * and can cause the system to go into a thermal heart attack
-	 */
-	if (state && state < 1000)
-		return -EINVAL;
-
-	if (state && !tz->forced_passive) {
-		if (!tz->passive_delay)
-			tz->passive_delay = 1000;
-		thermal_zone_device_rebind_exception(tz, "Processor",
-						     sizeof("Processor"));
-	} else if (!state && tz->forced_passive) {
-		tz->passive_delay = 0;
-		thermal_zone_device_unbind_exception(tz, "Processor",
-						     sizeof("Processor"));
-	}
-
-	tz->forced_passive = state;
-
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
-
-	return count;
-}
-
-static ssize_t
-passive_show(struct device *dev, struct device_attribute *attr,
-	     char *buf)
-{
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
-
-	return sprintf(buf, "%d\n", tz->forced_passive);
-}
-
-static ssize_t
 policy_store(struct device *dev, struct device_attribute *attr,
 	     const char *buf, size_t count)
 {
@@ -403,7 +360,6 @@ static DEVICE_ATTR_RW(sustainable_power);
 
 /* These thermal zone device attributes are created based on conditions */
 static DEVICE_ATTR_RW(mode);
-static DEVICE_ATTR_RW(passive);
 
 /* These attributes are unconditionally added to a thermal zone */
 static struct attribute *thermal_zone_dev_attrs[] = {
@@ -438,45 +394,9 @@ static const struct attribute_group thermal_zone_mode_attribute_group = {
 	.attrs = thermal_zone_mode_attrs,
 };
 
-/* We expose passive only if passive trips are present */
-static struct attribute *thermal_zone_passive_attrs[] = {
-	&dev_attr_passive.attr,
-	NULL,
-};
-
-static umode_t thermal_zone_passive_is_visible(struct kobject *kobj,
-					       struct attribute *attr,
-					       int attrno)
-{
-	struct device *dev = kobj_to_dev(kobj);
-	struct thermal_zone_device *tz;
-	enum thermal_trip_type trip_type;
-	int count, passive = 0;
-
-	tz = container_of(dev, struct thermal_zone_device, device);
-
-	for (count = 0; count < tz->trips && !passive; count++) {
-		tz->ops->get_trip_type(tz, count, &trip_type);
-
-		if (trip_type == THERMAL_TRIP_PASSIVE)
-			passive = 1;
-	}
-
-	if (!passive)
-		return attr->mode;
-
-	return 0;
-}
-
-static const struct attribute_group thermal_zone_passive_attribute_group = {
-	.attrs = thermal_zone_passive_attrs,
-	.is_visible = thermal_zone_passive_is_visible,
-};
-
 static const struct attribute_group *thermal_zone_attribute_groups[] = {
 	&thermal_zone_attribute_group,
 	&thermal_zone_mode_attribute_group,
-	&thermal_zone_passive_attribute_group,
 	/* This is not NULL terminated as we create the group dynamically */
 };
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c800323..a57232a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -131,9 +131,6 @@ struct thermal_cooling_device {
 			trip point.
  * @prev_high_trip:	the above current temperature if you've crossed a
 			passive trip point.
- * @forced_passive:	If > 0, temperature at which to switch on all ACPI
- *			processor cooling devices.  Currently only used by the
- *			step-wise governor.
  * @need_update:	if equals 1, thermal_zone_device_update needs to be invoked.
  * @ops:	operations this &thermal_zone_device supports
  * @tzp:	thermal zone parameters
@@ -167,7 +164,6 @@ struct thermal_zone_device {
 	int passive;
 	int prev_low_trip;
 	int prev_high_trip;
-	unsigned int forced_passive;
 	atomic_t need_update;
 	struct thermal_zone_device_ops *ops;
 	struct thermal_zone_params *tzp;
