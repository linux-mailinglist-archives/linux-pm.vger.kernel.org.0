Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D8F330407
	for <lists+linux-pm@lfdr.de>; Sun,  7 Mar 2021 19:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhCGSwJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Mar 2021 13:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhCGSvn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Mar 2021 13:51:43 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10860C06174A
        for <linux-pm@vger.kernel.org>; Sun,  7 Mar 2021 10:51:42 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c76-20020a1c9a4f0000b029010c94499aedso2479745wme.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Mar 2021 10:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Y2nnNS+GqT7TJyAzMEoj0JTe1ldgAoF/8NSEWFXeM7o=;
        b=XEQinZBvw40UemIVFSBuR4zO0PnieCrZhqNTiebm5YknyluAW+Qcf9Th1X6qlAp+Km
         1loBQ1rTmQQIvAOJD9S1K/mZIe27BCd+bS5NfrD46SUPrDGvMLBs9ysvTqEPTueWYKTi
         fLTZkYWtw4HKxtS5z/GYZDdd1yv3H8B6MyIHguleBb8sVKZkyiUqpP2yJNDa/emhWrIB
         3y0zvTXSlWkNpjCowItRt3ThbHtJYxndEfiJtEZY95LtYpv8CLbYF0zFDdUZt9KAmtIl
         jkNutdkdD/eZ0hUr58UOrXv6Odu4x57f9EugppBGsx1tezPGKMMIVYmGpPIkGtut00BB
         8nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y2nnNS+GqT7TJyAzMEoj0JTe1ldgAoF/8NSEWFXeM7o=;
        b=G1tjE+qNNCYPF1Jips2TW11KUEqYIBQ3cPK/TTNEvUUu4Q5SJDJuhrnLY09R3CrK+5
         oxLL+rqlGv+AUU4emCl8LiK5EeIsF6DZVC64bxWUKl6RhodX8bGdJvdxTLmOitiW7iXf
         aUS2CtkW9CLliC1fSaqv5oc6G0/zYAPh5agDQjhWdmeQNFW6Qvj0oE+n/yYzYMZ1gNhL
         1OZUGUH80KvdRF0p35rfRw8h+mF04qkm3cmoftbd+ciRowVPhJj0l1u5a3SGZG9jbbFq
         X7Kei55QJ6MhPIY4dZ+x1OfekM1eMW5Y+ZvWgASsh7Maz3xm4iXPd4m7cTlfuo33dNhw
         d5jQ==
X-Gm-Message-State: AOAM532h6haIwEvqLk6XHqzghuhu3oeMbmglK3owFs1ZaB1yfZlONGbt
        ASd1CzLPYMfwWPR2gt9eTgHqHBwC9Q7bBg==
X-Google-Smtp-Source: ABdhPJxPa1cKfmS4DGjawfyyfLw4AFQi3uDDzViTul/rXsL+C7IFPZJFOn6jby2a5idBqxriDOPXGQ==
X-Received: by 2002:a7b:c188:: with SMTP id y8mr18282898wmi.76.1615143101395;
        Sun, 07 Mar 2021 10:51:41 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id v5sm14842965wmh.2.2021.03.07.10.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 10:51:41 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     cwchoi00@gmail.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 1/4] devfreq: Register devfreq as a cooling device on demand
Date:   Sun,  7 Mar 2021 19:51:34 +0100
Message-Id: <20210307185137.24925-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the default behavior is to manually having the devfreq
backend to register themselves as a devfreq cooling device.

Instead of adding the code in the drivers for the thermal cooling
device registering, let's provide a flag in the devfreq's profile to
tell the common devfreq code to register the newly created devfreq as
a cooling device.

Suggested-by: Chanwoo Choi <cwchoi00@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 V4:
   - Replaced thermal_cooling_device_unregister() by
     devfreq_cooling_unregister()
 V3:
   - Rebased on linux-pm branch without units.h
   - Set the cdev to NULL in case of error
   - Added description for the cdev field in the devfreq structure
 V2:
   - Added is_cooling_device boolean in profile structure
   - Register cooling device when the is_cooling_device boolean is set
   - Remove devfreq cooling device registration in the backend drivers
 V1:
   - Register devfreq as a cooling device unconditionnally
---
 drivers/devfreq/devfreq.c | 13 +++++++++++++
 include/linux/devfreq.h   |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index bf3047896e41..8a535d4d6083 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -11,6 +11,7 @@
 #include <linux/kmod.h>
 #include <linux/sched.h>
 #include <linux/debugfs.h>
+#include <linux/devfreq_cooling.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -26,6 +27,7 @@
 #include <linux/hrtimer.h>
 #include <linux/of.h>
 #include <linux/pm_qos.h>
+#include <linux/thermal.h>
 #include "governor.h"
 
 #define CREATE_TRACE_POINTS
@@ -935,6 +937,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	mutex_unlock(&devfreq_list_lock);
 
+	if (devfreq->profile->is_cooling_device) {
+		devfreq->cdev = devfreq_cooling_em_register(devfreq, NULL);
+		if (IS_ERR(devfreq->cdev)) {
+			dev_info(dev, "Failed to register devfreq "
+				 "cooling device\n");
+			devfreq->cdev = NULL;
+		}
+	}
+
 	return devfreq;
 
 err_init:
@@ -960,6 +971,8 @@ int devfreq_remove_device(struct devfreq *devfreq)
 	if (!devfreq)
 		return -EINVAL;
 
+	devfreq_cooling_unregister(devfreq->cdev);
+
 	if (devfreq->governor) {
 		devfreq->governor->event_handler(devfreq,
 						 DEVFREQ_GOV_STOP, NULL);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 26ea0850be9b..aba7ace11b72 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -98,11 +98,15 @@ struct devfreq_dev_status {
  * @freq_table:		Optional list of frequencies to support statistics
  *			and freq_table must be generated in ascending order.
  * @max_state:		The size of freq_table.
+ *
+ * @is_cooling_device: A self-explanatory boolean giving the device a
+ *                     cooling effect property.
  */
 struct devfreq_dev_profile {
 	unsigned long initial_freq;
 	unsigned int polling_ms;
 	enum devfreq_timer timer;
+	bool is_cooling_device;
 
 	int (*target)(struct device *dev, unsigned long *freq, u32 flags);
 	int (*get_dev_status)(struct device *dev,
@@ -156,6 +160,7 @@ struct devfreq_stats {
  * @suspend_count:	 suspend requests counter for a device.
  * @stats:	Statistics of devfreq device behavior
  * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
+ * @cdev:	Cooling device pointer if the devfreq has cooling property
  * @nb_min:		Notifier block for DEV_PM_QOS_MIN_FREQUENCY
  * @nb_max:		Notifier block for DEV_PM_QOS_MAX_FREQUENCY
  *
@@ -198,6 +203,9 @@ struct devfreq {
 
 	struct srcu_notifier_head transition_notifier_list;
 
+	/* Pointer to the cooling device if used for thermal mitigation */
+	struct thermal_cooling_device *cdev;
+
 	struct notifier_block nb_min;
 	struct notifier_block nb_max;
 };
-- 
2.17.1

