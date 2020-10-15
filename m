Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CB128F0E1
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 13:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgJOLZi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 07:25:38 -0400
Received: from foss.arm.com ([217.140.110.172]:32812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbgJOLZF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Oct 2020 07:25:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AD6B31B;
        Thu, 15 Oct 2020 04:25:04 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.48.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85D963F66B;
        Thu, 15 Oct 2020 04:25:02 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com,
        michael.kao@mediatek.com, rui.zhang@intel.com
Subject: [PATCH v2 3/4] thermal: core: remove unused functions in power actor section
Date:   Thu, 15 Oct 2020 12:24:40 +0100
Message-Id: <20201015112441.4056-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015112441.4056-1-lukasz.luba@arm.com>
References: <20201015112441.4056-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since the Intelligent Power Allocation (IPA) uses different way to get
minimum and maximum power for a given cooling device, the helper functions
are not needed. There is no other code which uses them, so remove the
helper functions.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.c | 47 ----------------------------------
 drivers/thermal/thermal_core.h |  4 ---
 2 files changed, 51 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2ea3633b5d66..d5540bfeee5e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -600,53 +600,6 @@ static void thermal_zone_device_check(struct work_struct *work)
  * how to estimate their devices power consumption.
  */
 
-/**
- * power_actor_get_max_power() - get the maximum power that a cdev can consume
- * @cdev:	pointer to &thermal_cooling_device
- * @max_power:	pointer in which to store the maximum power
- *
- * Calculate the maximum power consumption in milliwats that the
- * cooling device can currently consume and store it in @max_power.
- *
- * Return: 0 on success, -EINVAL if @cdev doesn't support the
- * power_actor API or -E* on other error.
- */
-int power_actor_get_max_power(struct thermal_cooling_device *cdev,
-			      u32 *max_power)
-{
-	if (!cdev_is_power_actor(cdev))
-		return -EINVAL;
-
-	return cdev->ops->state2power(cdev, 0, max_power);
-}
-
-/**
- * power_actor_get_min_power() - get the mainimum power that a cdev can consume
- * @cdev:	pointer to &thermal_cooling_device
- * @min_power:	pointer in which to store the minimum power
- *
- * Calculate the minimum power consumption in milliwatts that the
- * cooling device can currently consume and store it in @min_power.
- *
- * Return: 0 on success, -EINVAL if @cdev doesn't support the
- * power_actor API or -E* on other error.
- */
-int power_actor_get_min_power(struct thermal_cooling_device *cdev,
-			      u32 *min_power)
-{
-	unsigned long max_state;
-	int ret;
-
-	if (!cdev_is_power_actor(cdev))
-		return -EINVAL;
-
-	ret = cdev->ops->get_max_state(cdev, &max_state);
-	if (ret)
-		return ret;
-
-	return cdev->ops->state2power(cdev, max_state, min_power);
-}
-
 /**
  * power_actor_set_power() - limit the maximum power a cooling device consumes
  * @cdev:	pointer to &thermal_cooling_device
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 764c2de31771..14f8a829a84a 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -65,10 +65,6 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 		cdev->ops->power2state;
 }
 
-int power_actor_get_max_power(struct thermal_cooling_device *cdev,
-			      u32 *max_power);
-int power_actor_get_min_power(struct thermal_cooling_device *cdev,
-			      u32 *min_power);
 int power_actor_set_power(struct thermal_cooling_device *cdev,
 			  struct thermal_instance *ti, u32 power);
 /**
-- 
2.17.1

