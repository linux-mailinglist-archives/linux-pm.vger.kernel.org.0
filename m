Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EE632D397
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 13:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhCDMwC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 07:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbhCDMvj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 07:51:39 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4712C061574
        for <linux-pm@vger.kernel.org>; Thu,  4 Mar 2021 04:50:58 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h98so27485506wrh.11
        for <linux-pm@vger.kernel.org>; Thu, 04 Mar 2021 04:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T4drX2OHz8WsU2B+DyV2cYvNY39nMQirtfdi2mTuSOg=;
        b=aT1zbGeyGacOaJcwjnuOmLSK6neJHxSZln7SpxKQYeYLkoMFu4fvwf2ZIQvJ8ZXsNL
         UyrBq4ll7SJEQgIJsoZ3gq05uAYhMnOjY2YM8EiSyhlPEpOz5In6kuKRsDTeMaFbiuyU
         aRlT+7rzGU0HqwpGo04vyPLaHPeLAbHBkApowFty6WvQ6p/IFUxKRevPINH2x7bCXPMM
         58GD8mOxaTzQreXLjLiKGM3uREA5CgURdllKVkQxCPvTlt7OX0xe7rywzsTmogYKm6fG
         2oPM9ZobJWjD6c2SAt2Onxh7NjxtOYeCyViyk2hlgJHkQ0MbzopK4irrvutohf941nTw
         lEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T4drX2OHz8WsU2B+DyV2cYvNY39nMQirtfdi2mTuSOg=;
        b=ByISH1DAqfHjVsuHZekyNgehf0tT65Vwb5Yy52VZBzX+lnIivEzekaLAfurel/ekkC
         lxsMEEaIw+Tmf3bA15QMFekbgA4GxcFr9OZEtyDUJUla+zPiqfaTO5/KuCkzDiSAE3x7
         5vGRLx9vv9ocKkFXMQ9ZCHgwyrxdUPG4S2+GZCyBkC9mq9uppK37zXp8avj6pDpGMEWj
         ypB26ycD/TsNComtz2JIFd02gn33xVbdNc+S+7ez2juSjUInQu3mXDEpMglT0t2E2CUx
         wY/W35VGzKmlIfv+lA1WDAfmku3Nv3/CeAowTQSaBfCxD5A5N6Y8E2Jod0SOYYfn4AFc
         HInA==
X-Gm-Message-State: AOAM5339yLpym4m/fHbKtgo/X2p8Ep9X6QLQoT1P9H2PDuk3Ie8sRSWI
        pgAhxGY55swkT+znA7/O9gbCFQ==
X-Google-Smtp-Source: ABdhPJzGo4COvZK7kDu3+r40eNKlVccn5YfL70YriZdNoTBFiRhALzWFMjin8vjSY9WX/vCfmJQxIQ==
X-Received: by 2002:a5d:620d:: with SMTP id y13mr3986716wru.88.1614862257577;
        Thu, 04 Mar 2021 04:50:57 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.gmail.com with ESMTPSA id z2sm19688850wrm.0.2021.03.04.04.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 04:50:56 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     cwchoi00@gmail.com, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR LIMA),
        lima@lists.freedesktop.org (moderated list:DRM DRIVERS FOR LIMA),
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU)
Subject: [PATCH] devfreq: Register devfreq as a cooling device
Date:   Thu,  4 Mar 2021 13:50:33 +0100
Message-Id: <20210304125034.28404-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the default behavior is to manually having the devfreq
backend to register themselves as a devfreq cooling device.

There are no so many and actually it makes more sense to register the
devfreq device when adding it.

Consequently, every devfreq becomes a cooling device like cpufreq is.

Having a devfreq being registered as a cooling device can not mitigate
a thermal zone if it is not bound to this one. Thus, the current
configurations are not impacted by this change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/devfreq/devfreq.c                   |  8 ++++++++
 drivers/gpu/drm/lima/lima_devfreq.c         | 13 -------------
 drivers/gpu/drm/lima/lima_devfreq.h         |  2 --
 drivers/gpu/drm/msm/msm_gpu.c               | 11 -----------
 drivers/gpu/drm/msm/msm_gpu.h               |  2 --
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 13 -------------
 include/linux/devfreq.h                     |  3 +++
 7 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b6d63f02d293..19149b31b000 100644
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
 #include <linux/units.h>
 #include "governor.h"
 
@@ -935,6 +937,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	mutex_unlock(&devfreq_list_lock);
 
+	devfreq->cdev = devfreq_cooling_em_register(devfreq, NULL);
+	if (IS_ERR(devfreq->cdev))
+		dev_info(dev, "Failed to register devfreq cooling device\n");
+
 	return devfreq;
 
 err_init:
@@ -960,6 +966,8 @@ int devfreq_remove_device(struct devfreq *devfreq)
 	if (!devfreq)
 		return -EINVAL;
 
+	thermal_cooling_device_unregister(devfreq->cdev);
+
 	if (devfreq->governor) {
 		devfreq->governor->event_handler(devfreq,
 						 DEVFREQ_GOV_STOP, NULL);
diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index 5686ad4aaf7c..a696eff1642c 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -7,7 +7,6 @@
  */
 #include <linux/clk.h>
 #include <linux/devfreq.h>
-#include <linux/devfreq_cooling.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
@@ -90,11 +89,6 @@ void lima_devfreq_fini(struct lima_device *ldev)
 {
 	struct lima_devfreq *devfreq = &ldev->devfreq;
 
-	if (devfreq->cooling) {
-		devfreq_cooling_unregister(devfreq->cooling);
-		devfreq->cooling = NULL;
-	}
-
 	if (devfreq->devfreq) {
 		devm_devfreq_remove_device(ldev->dev, devfreq->devfreq);
 		devfreq->devfreq = NULL;
@@ -110,7 +104,6 @@ void lima_devfreq_fini(struct lima_device *ldev)
 
 int lima_devfreq_init(struct lima_device *ldev)
 {
-	struct thermal_cooling_device *cooling;
 	struct device *dev = ldev->dev;
 	struct opp_table *opp_table;
 	struct devfreq *devfreq;
@@ -173,12 +166,6 @@ int lima_devfreq_init(struct lima_device *ldev)
 
 	ldevfreq->devfreq = devfreq;
 
-	cooling = of_devfreq_cooling_register(dev->of_node, devfreq);
-	if (IS_ERR(cooling))
-		dev_info(dev, "Failed to register cooling device\n");
-	else
-		ldevfreq->cooling = cooling;
-
 	return 0;
 
 err_fini:
diff --git a/drivers/gpu/drm/lima/lima_devfreq.h b/drivers/gpu/drm/lima/lima_devfreq.h
index 2d9b3008ce77..c43a2069e5d3 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.h
+++ b/drivers/gpu/drm/lima/lima_devfreq.h
@@ -9,7 +9,6 @@
 
 struct devfreq;
 struct opp_table;
-struct thermal_cooling_device;
 
 struct lima_device;
 
@@ -17,7 +16,6 @@ struct lima_devfreq {
 	struct devfreq *devfreq;
 	struct opp_table *clkname_opp_table;
 	struct opp_table *regulators_opp_table;
-	struct thermal_cooling_device *cooling;
 
 	ktime_t busy_time;
 	ktime_t idle_time;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index ab7c167b0623..d7f80ebfe9df 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -14,7 +14,6 @@
 #include <generated/utsrelease.h>
 #include <linux/string_helpers.h>
 #include <linux/devfreq.h>
-#include <linux/devfreq_cooling.h>
 #include <linux/devcoredump.h>
 #include <linux/sched/task.h>
 
@@ -112,14 +111,6 @@ static void msm_devfreq_init(struct msm_gpu *gpu)
 	}
 
 	devfreq_suspend_device(gpu->devfreq.devfreq);
-
-	gpu->cooling = of_devfreq_cooling_register(gpu->pdev->dev.of_node,
-			gpu->devfreq.devfreq);
-	if (IS_ERR(gpu->cooling)) {
-		DRM_DEV_ERROR(&gpu->pdev->dev,
-				"Couldn't register GPU cooling device\n");
-		gpu->cooling = NULL;
-	}
 }
 
 static int enable_pwrrail(struct msm_gpu *gpu)
@@ -1056,6 +1047,4 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
 	if (gpu->worker) {
 		kthread_destroy_worker(gpu->worker);
 	}
-
-	devfreq_cooling_unregister(gpu->cooling);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index d7cd02cd2109..93419368bac8 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -155,8 +155,6 @@ struct msm_gpu {
 	struct msm_gpu_state *crashstate;
 	/* True if the hardware supports expanded apriv (a650 and newer) */
 	bool hw_apriv;
-
-	struct thermal_cooling_device *cooling;
 };
 
 static inline struct msm_gpu *dev_to_gpu(struct device *dev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 56b3f5935703..2cb6300de1f1 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -3,7 +3,6 @@
 
 #include <linux/clk.h>
 #include <linux/devfreq.h>
-#include <linux/devfreq_cooling.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 
@@ -90,7 +89,6 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	struct device *dev = &pfdev->pdev->dev;
 	struct devfreq *devfreq;
 	struct opp_table *opp_table;
-	struct thermal_cooling_device *cooling;
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
 	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
@@ -139,12 +137,6 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	}
 	pfdevfreq->devfreq = devfreq;
 
-	cooling = devfreq_cooling_em_register(devfreq, NULL);
-	if (IS_ERR(cooling))
-		DRM_DEV_INFO(dev, "Failed to register cooling device\n");
-	else
-		pfdevfreq->cooling = cooling;
-
 	return 0;
 
 err_fini:
@@ -156,11 +148,6 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 {
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
-	if (pfdevfreq->cooling) {
-		devfreq_cooling_unregister(pfdevfreq->cooling);
-		pfdevfreq->cooling = NULL;
-	}
-
 	if (pfdevfreq->opp_of_table_added) {
 		dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
 		pfdevfreq->opp_of_table_added = false;
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 26ea0850be9b..690bd4affe18 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -198,6 +198,9 @@ struct devfreq {
 
 	struct srcu_notifier_head transition_notifier_list;
 
+	/* Pointer to the cooling device if used for thermal mitigation */
+	struct thermal_cooling_device *cdev;
+
 	struct notifier_block nb_min;
 	struct notifier_block nb_max;
 };
-- 
2.17.1

