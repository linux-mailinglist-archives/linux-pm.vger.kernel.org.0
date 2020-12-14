Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156222DA43D
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 00:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgLNXk2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 18:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgLNXk2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 18:40:28 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11C6C06179C
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 15:39:47 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c133so3271009wme.4
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 15:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=26F5bU6HzmYDlPPEyiuAM3Eq9TxTugaHeptJZ4C0SqU=;
        b=tJyvxhlIUERBUJEVvnukQdpKelK1ioR8LBIevf5H4JxcTsYTmFPRYVH0I8Lt3g2ee7
         RqtHXgIPskDnsNyuWS1Y0CKCAy97IRxpj5kndO0KreWrtXKzJeWgfx/RUqS2zaWhES7w
         WTYynE4Y4+NAqU72or5rkzBDifYFJLLfbhnYdKkRSiYpSCsqVe8ROt0K2AUCS0GCKdXC
         5cTrEJ9eao5srLwO3sebCFPVjasGZC4iaaRcctmrgC5NE4ZySUNDgsBccvVkys4FvpoO
         FkFvDFtxUP23+yD/k6B+xLw6QRnUgj8LwmtjZkPZh7nXme+xLJDWDSvEDKXzF2sImZb0
         6hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=26F5bU6HzmYDlPPEyiuAM3Eq9TxTugaHeptJZ4C0SqU=;
        b=hzuTFNFRFN7nUBo1vhRTk/tOO68e6Nqq9U5pbw+XTJQfZInATRkcfOSD+EJSpyGC4z
         9f7PiJEuLMoWjfRt3gnCgFcK1Ii150EzFO5jauA59i1SBeI0Ny7XatK2gyO6WwwzPQuc
         8a7hCxZEBeds79x6P6yXwgAwiOCmg32Ob1Vko5zSto9yfOv4qhTBDeUrOA8HFvFl7JmE
         z/9k7aDOFa1RTr7tA5HW88SgwhKnrPxdg7If5ngac0dN6jDcf0DQhJKmK08QjxwpKFKL
         IXWIT0/+pwt9vVHfGp6ouwtEnTWpZBBwZUEfLWvR3pjMZzSl9nJezHmcQto3weC2DXyZ
         +weA==
X-Gm-Message-State: AOAM532UoBRlER7+Tb07+d0WyawBNfdgY50PIhCtJ9B8y0tL9ICYsqPC
        lLYALUZnujP9yOv6GjlNnzz4SA==
X-Google-Smtp-Source: ABdhPJzURAmXW6KOS5YcnaL3ewXd8S/Oq7R5uZx6Zf4kELlNDiHN2LhUQ20cZaFv+lk67nfxyCZyLA==
X-Received: by 2002:a05:600c:2057:: with SMTP id p23mr29686434wmg.109.1607989186511;
        Mon, 14 Dec 2020 15:39:46 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:e842:4086:6f24:55a6])
        by smtp.gmail.com with ESMTPSA id h3sm34145075wmm.4.2020.12.14.15.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 15:39:45 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     mjg59@codon.org.uk, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        thara.gopinath@linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH 1/6] thermal/core: Remove the 'forced_passive' option
Date:   Tue, 15 Dec 2020 00:38:04 +0100
Message-Id: <20201214233811.485669-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
---
 .../driver-api/thermal/sysfs-api.rst          | 13 ---
 drivers/thermal/gov_step_wise.c               | 14 +---
 drivers/thermal/thermal_sysfs.c               | 80 -------------------
 include/linux/thermal.h                       |  4 -
 4 files changed, 3 insertions(+), 108 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index e7520cb439ac..a4969c474cc3 100644
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
index 2ae7198d3067..12acb12aac50 100644
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
index 0866e949339b..4e7f9e880d76 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -216,49 +216,6 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 	return ret ? ret : sprintf(buf, "%d\n", temperature);
 }
 
-static ssize_t
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
 static ssize_t
 policy_store(struct device *dev, struct device_attribute *attr,
 	     const char *buf, size_t count)
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
index c80032322158..a57232a9a6f9 100644
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
-- 
2.25.1

