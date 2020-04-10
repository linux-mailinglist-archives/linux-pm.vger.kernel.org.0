Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 092A11A4BCB
	for <lists+linux-pm@lfdr.de>; Sat, 11 Apr 2020 00:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgDJWNV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 18:13:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38963 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgDJWNE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 18:13:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so3869185wrt.6
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2020 15:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oYYsLKLLTRoF1sH0wteLzvtUl/2XjHlGFpOY2S4yWW4=;
        b=Rsi9w/sk4jmAaC+/eaqQosQyO7xc/rlNe2w8DP14Mb35iZMk0NPn5AUNYPXiL+qnTG
         fp6+S3HvVmqxQg8I+E6ZOs+vCZ7t5q4T1AdQRwbl3kGdNFrCacfoE/FqiGQI44T4vk+A
         1yyK/81c+w4rGhZD1uuv3lttWtbETp7bNvsO3dgFCW9/vqxsVI5VMQYVD+PNmX7gw5O1
         bBS5WDSJolTL7rUdj3iAwqefAf/1Z1aFi1TAoiVQ+wp/5wsBg4R9RE0hRyJjKfeZ3XI4
         myKJE9yUDQPpLL+sMBm3XzcV6DYod59vgU5N8dh5vLqvekAUXbTFUnzQjDnv8znyr5hZ
         2MYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oYYsLKLLTRoF1sH0wteLzvtUl/2XjHlGFpOY2S4yWW4=;
        b=npgneODQPzJ5Fia5paOcR447bjMVI7yDoDEDIvL10aYkY7D8IH/l7YS27LFS3VwKvC
         dtE1ijm0PemMJVoNkkUesYgvWL5b8V/XG/vMFdL5KgeFqqi5bbuJaUw8kZISp6Y/VatL
         rf4M8/n4fclGT/aHqyXJF0OW0RHsG1VzbqiQAJH+9XSLhBdCkG+fIE26ahG0+ZuhX+Gs
         sbc5LxV0jmX7RU7xhpGnc9ckmbjKcXeFwlqivoea5Gn6rKm3IWV+S75rvkOjE0W0jJ2H
         GGIFjJte3a9TCApg5eaMRsu9adythS6GF6xiLRcQOamXG7J8v/7vmhgvkZJI1/FKCZfb
         BTvQ==
X-Gm-Message-State: AGi0PuYIEVLINiDD4kxXOYtpWqHL4eqU0wEe0wtVZCBQxqa8LEOgr16x
        yAtt5J9gxRqPAQTnHtjTdMB/dCnEXKs=
X-Google-Smtp-Source: APiQypIuUAg6+hYPzbRABsJ++pvXZycYR4rL7OJFhdsb0G2Nq1dWnooCyjxwkmSROe/UI15FwmTd0Q==
X-Received: by 2002:adf:bc05:: with SMTP id s5mr6553216wrg.70.1586556782064;
        Fri, 10 Apr 2020 15:13:02 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id b14sm4687952wrw.83.2020.04.10.15.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 15:13:01 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH 3/6] thermal: core: Remove pointless 'updated' boolean
Date:   Sat, 11 Apr 2020 00:12:32 +0200
Message-Id: <20200410221236.6484-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410221236.6484-1-daniel.lezcano@linaro.org>
References: <20200410221236.6484-1-daniel.lezcano@linaro.org>
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
index ccd2417cd42e..052f77b0b0ef 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -614,9 +614,6 @@ int power_actor_set_power(struct thermal_cooling_device *cdev,
 		return ret;
 
 	instance->target = state;
-	mutex_lock(&cdev->lock);
-	cdev->updated = false;
-	mutex_unlock(&cdev->lock);
 	thermal_cdev_update(cdev);
 
 	return 0;
@@ -990,7 +987,6 @@ __thermal_cooling_device_register(struct device_node *np,
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

