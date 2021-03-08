Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2FE330A1D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 10:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhCHJQ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 04:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhCHJQy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 04:16:54 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F060FC06175F
        for <linux-pm@vger.kernel.org>; Mon,  8 Mar 2021 01:16:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so7738109wma.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 01:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KIiRUMn2zbUAbTCCCaOOS6Ioymx172KJZHR6sOJkB3E=;
        b=p/CFh9WX6Zn2+eBgka+a2isZ6yuDutvVbcFKrocpz2AG6JzgayQgCHbNasO73R2G3Y
         a86OlA3iAl8OAqWKJIj7r/5XE0+nyxAnHhwTyK01+WuB4qF5rpcjE0N6jP8fwoem03Yn
         58yc7n6uebtC64hoM6hTnQJdL+d1Xs+eR2Mdwp6qbyMoyNdX55sKUE6x1XxPPkUWH6nX
         olcZwE/dpyoYcSuD+8rOBpaP6TtBHUBm5St5ZzdSTlJDvf37Iclz8nM1FxgaeOHl+f6k
         0bkah0mVPO1cerqyEqmjydxvedbe7Nci1NMMdBs7n/iqkU4/nn70pqBCDlvJLYhnUti8
         WTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KIiRUMn2zbUAbTCCCaOOS6Ioymx172KJZHR6sOJkB3E=;
        b=Q3DBFS1bfQVyJiwfisTJe3wRkNRgKWUSWEeHzez0cM6eUrcFzi3bQkzbMLXY4NaCsH
         6cvh7q1d99aDbWWQ6CvRGuj+wTV+xC00wICTCDQ8gmBTHNzcp4gLbKaceYSR7aIHM34/
         1Nx2c496Vt9jCx9Y2LMbmBMj39WW/MWbZY6Yek0OIjZebYnzJ5UKSbxhPtLzwP8ZCt2G
         nFNBkcG7VBL2pGqjXwZwwx20TtP2kkWpsqc96NiLvO+4fjJXc53NT3ko6VX94NjupBm+
         3IAngmzdZYjXZHI17DRA+Akhq1KlA9rToRMgkILE7ZDiJQbyPaWy4WkOVSVD9P5gHx6Y
         sYow==
X-Gm-Message-State: AOAM532F5rSr7UQ/Tde+OvnKOMeNOAQqCAknezc5zHRVqMmSvD9Yrfp2
        htJQ1feDD1SFd41dY2ejwsrHiA==
X-Google-Smtp-Source: ABdhPJwIlH5P7vdRw3H5xgE2pSX3CWLSv4FqlH0LHfZlkeTAxUU7wfokCC4U/j1uHhK7LC2jJQy/oA==
X-Received: by 2002:a1c:771a:: with SMTP id t26mr21399277wmi.60.1615195012511;
        Mon, 08 Mar 2021 01:16:52 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id i17sm6068135wrp.77.2021.03.08.01.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 01:16:52 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     cwchoi00@gmail.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v5 1/4] PM / devfreq: Register devfreq as a cooling device on demand
Date:   Mon,  8 Mar 2021 10:16:42 +0100
Message-Id: <20210308091646.28096-1-daniel.lezcano@linaro.org>
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
 V5:
   - Changed subject prefix by:  PM / devfreq
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

