Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8301D32FFF2
	for <lists+linux-pm@lfdr.de>; Sun,  7 Mar 2021 10:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhCGJpt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Mar 2021 04:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhCGJpg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Mar 2021 04:45:36 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C4AC06175F
        for <linux-pm@vger.kernel.org>; Sun,  7 Mar 2021 01:45:36 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id w7so4271226wmb.5
        for <linux-pm@vger.kernel.org>; Sun, 07 Mar 2021 01:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ihXVSbxv7FyslBFnvseGR/NddNzkR/mnLj93t8UIBfA=;
        b=frwiDO8DtUKisLLH799ud1Ejtd7sw4X9i5GlRkez3twBY2FxIK/uv5WQWL+Ze1MWS+
         n75Q6jepcRGJ0FEJ6YtjZJef2k5MWqipp3ezxDbDpcfO9q1oOL2na1qZAtej/GGOMqnn
         66GgsQfHzt1iUbd1nkbhdR1HquKPCWXIS++kMaBOVFVtfUThedQyt2grF/pV7JIGvA9C
         JaxGgVf0ydByvZEB9P1Tc7w6rSkKxwCrC42h9gjlGHFXi/tZMTdveU/jEEGUms2FWwKP
         qtRBf2Wsh5BQKqFW1Frx5eZHd5BFWp20kSm/OWLlShp5UBbiMiOnmGkXBwKTEUDRzWqD
         gpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ihXVSbxv7FyslBFnvseGR/NddNzkR/mnLj93t8UIBfA=;
        b=Y8UxnluB3GZYJV05NfQsk/KniX+G+byHNIG3H14U5M0EPNvx/edVAI8jMAVQm9EwIf
         +JZSJzTrbUXIWkbiJlHXKVfqbOjaxw5tP92TTDqIFZL5sdq7aBicX08YfHJPIeXagbtc
         JmRaCEadIIn14QvB8eTZQ4MnQdqKXeV8pFMvc8vNAtVAR8/mLdEiy/xVDzHL/tPH9oNl
         H8Q6B+LeC5ewsv+mE86pgw5SVqJYLExlJowIgq4a4fU1l2egafDjgQlRpvUAbxVGWGK+
         mEO11s1NK5LgW2LqvmFsUhJTeoXbNEvREw+CstEPf1B44WCe/s7bqXT/AZAkq3rbx1LO
         TqOw==
X-Gm-Message-State: AOAM5308CQX7nh2hTuhHY33CGAYb2oc0mBAyhUECeP4yqu8dwpnKfae2
        Zx8EPkSXAZpDu8uUAnHaLCeq2g==
X-Google-Smtp-Source: ABdhPJzVSOQa4Phv0ix4jaHgr3ku+JaaJeayAUbJcZ6dWw8adrQXMtWi1HzFoW4EbMloA9Gurv+48Q==
X-Received: by 2002:a1c:1dd4:: with SMTP id d203mr16885107wmd.83.1615110334754;
        Sun, 07 Mar 2021 01:45:34 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id z7sm12790737wrt.70.2021.03.07.01.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 01:45:34 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     cwchoi00@gmail.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v3 1/4] devfreq: Register devfreq as a cooling device on demand
Date:   Sun,  7 Mar 2021 10:45:15 +0100
Message-Id: <20210307094519.9032-1-daniel.lezcano@linaro.org>
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
index bf3047896e41..cf64aeec468f 100644
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
 
+	thermal_cooling_device_unregister(devfreq->cdev);
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

