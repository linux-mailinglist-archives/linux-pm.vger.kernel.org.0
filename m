Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C021A36B8
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 17:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgDIPPa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 11:15:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46767 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbgDIPPa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Apr 2020 11:15:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id f13so5760428wrm.13
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2020 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NB4ksyP2jrR/UYMBMPqVUT1i/za7yPOLnw9p85nB5k0=;
        b=YeshcaYVhuzooV87JL/oy+h4UfUMlrMT5+lDQ9mgKmQuP9LzHc3nMDCsrhLVPiX4mp
         CwzKe/7FcaMXA1jl8Sb2tQTj6prIvLbe75X2hWyGPvYBS5S0MI4pkPEVyeDI0YSYTrUK
         TaTDOLuII3hCC2AZVcYhlxJ/BfHi6dXYfaLOVPfTl0cR4T7sHPPIVFdWsrXhi9G4sj/b
         Pyr3L/wpzaLTVgKVdR7rNLSTLuHQtmGYYjEEQ9IdO3lwqe1zBUcv/IRzCLiAEUF7oVDi
         HwLdSj6i/EetleoMTltSvLUXTqU92XD1lyvrgSMbFMfJlhWR0ZFz6/cnoQVW0GxxmTTl
         D58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NB4ksyP2jrR/UYMBMPqVUT1i/za7yPOLnw9p85nB5k0=;
        b=buH2U1393pxU8p6GVLtZmfY8Lzbu7JDAg2XRpLDOvhBtXuS8pfmkHMAKeLg0nj5Kp7
         CFSpLnmR50zhksUlniIFLwtYcF2BETcknGUIfrRlnFSsBp0dcq+wIbrjqh++EMvoiqRH
         sFIELr6t6C2MVyOZsdKxxMmz8tkvZ6pJT4jxG9mD7k5wY8oKbk/OUkSdSXlM6ywF7A59
         XFLEhKlJmHnOHkp3JOcUZktJ6jYk2r1WhmbwY42a4D9ObvJnHMiyoMejwCTDhytK7MHh
         HQI0ow+YcR0JWAmEdJ/NTXyOFwZO7WNIPhbRrPd/zifPk7YG8hfDwGq6Y2PlBa6dbRAi
         eIiA==
X-Gm-Message-State: AGi0PuZ0mXYbGkASGi3Eh/24wl7PKzxvLQx0LYioLsnP/NqMu85y5FZS
        gxW5yCbfiOwYEpbzTRP+cTQJkw==
X-Google-Smtp-Source: APiQypKyFG8LUaYzBZRLhP2WaBrGH1w7TFh8TNT19wcdguxini7oXIHR8ivm0cgqucWHwxgBNlRSsg==
X-Received: by 2002:a5d:4011:: with SMTP id n17mr12149784wrp.104.1586445329570;
        Thu, 09 Apr 2020 08:15:29 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id 19sm4051392wmi.32.2020.04.09.08.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 08:15:29 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH 2/2] thermal: core: Remove pointless 'updated' boolean
Date:   Thu,  9 Apr 2020 17:15:15 +0200
Message-Id: <20200409151515.6607-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409151515.6607-1-daniel.lezcano@linaro.org>
References: <20200409151515.6607-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The sequence to update the cooling state in the thermal instances is always:

    mutex_lock(&instance->cdev->lock);
    instance->cdev->updated = false;
    mutex_unlock(&instance->cdev->lock);
    thermal_cdev_update(instance->cdev);

So each call to thermal_cdev_update() is prefixed by resetting the updated
flag which turns on to be a pointless test in the function itself.

Remove the flag.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/fair_share.c      | 3 ---
 drivers/thermal/gov_bang_bang.c   | 3 ---
 drivers/thermal/power_allocator.c | 3 ---
 drivers/thermal/step_wise.c       | 3 ---
 drivers/thermal/thermal_core.c    | 4 ----
 drivers/thermal/thermal_helpers.c | 6 ------
 include/linux/thermal.h           | 1 -
 7 files changed, 23 deletions(-)

diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
index aaa07180ab48..718de1f96cb6 100644
--- a/drivers/thermal/fair_share.c
+++ b/drivers/thermal/fair_share.c
@@ -105,9 +105,6 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 		instance->target = get_target_state(tz, cdev, percentage,
 						    cur_trip_level);
 
-		mutex_lock(&instance->cdev->lock);
-		instance->cdev->updated = false;
-		mutex_unlock(&instance->cdev->lock);
 		thermal_cdev_update(cdev);
 	}
 	return 0;
diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index c292a69845bb..d678a2a0c4d4 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -61,9 +61,6 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		dev_dbg(&instance->cdev->device, "target=%d\n",
 					(int)instance->target);
 
-		mutex_lock(&instance->cdev->lock);
-		instance->cdev->updated = false; /* cdev needs update */
-		mutex_unlock(&instance->cdev->lock);
 		thermal_cdev_update(instance->cdev);
 	}
 
diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 44636475b2a3..f8e4219cf5de 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -530,9 +530,6 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
 			continue;
 
 		instance->target = 0;
-		mutex_lock(&instance->cdev->lock);
-		instance->cdev->updated = false;
-		mutex_unlock(&instance->cdev->lock);
 		thermal_cdev_update(instance->cdev);
 	}
 	mutex_unlock(&tz->lock);
diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 298eedac0293..9ddff715f3dd 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -164,9 +164,6 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 			update_passive_instance(tz, trip_type, -1);
 
 		instance->initialized = true;
-		mutex_lock(&instance->cdev->lock);
-		instance->cdev->updated = false; /* cdev needs update */
-		mutex_unlock(&instance->cdev->lock);
 		thermal_cdev_update(instance->cdev);
 	}
 
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c06550930979..da63899b9e6c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -593,9 +593,6 @@ int power_actor_set_power(struct thermal_cooling_device *cdev,
 		return ret;
 
 	instance->target = state;
-	mutex_lock(&cdev->lock);
-	cdev->updated = false;
-	mutex_unlock(&cdev->lock);
 	thermal_cdev_update(cdev);
 
 	return 0;
@@ -969,7 +966,6 @@ __thermal_cooling_device_register(struct device_node *np,
 	INIT_LIST_HEAD(&cdev->thermal_instances);
 	cdev->np = np;
 	cdev->ops = ops;
-	cdev->updated = false;
 	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
 	thermal_cooling_device_setup_sysfs(cdev);
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 59eaf2d0fdb3..85cae31301aa 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -180,11 +180,6 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	unsigned long target = 0;
 
 	mutex_lock(&cdev->lock);
-	/* cooling device is updated*/
-	if (cdev->updated) {
-		mutex_unlock(&cdev->lock);
-		return;
-	}
 
 	/* Make sure cdev enters the deepest cooling state */
 	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
@@ -199,7 +194,6 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	if (!cdev->ops->set_cur_state(cdev, target))
 		thermal_cooling_device_stats_update(cdev, target);
 
-	cdev->updated = true;
 	mutex_unlock(&cdev->lock);
 	trace_cdev_update(cdev, target);
 	dev_dbg(&cdev->device, "set to state %lu\n", target);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 216185bb3014..08969f0be6a0 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -114,7 +114,6 @@ struct thermal_cooling_device {
 	void *devdata;
 	void *stats;
 	const struct thermal_cooling_device_ops *ops;
-	bool updated; /* true if the cooling device does not need update */
 	struct mutex lock; /* protect thermal_instances list */
 	struct list_head thermal_instances;
 	struct list_head node;
-- 
2.17.1

