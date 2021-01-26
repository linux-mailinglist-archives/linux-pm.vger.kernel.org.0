Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB18B303A8F
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404282AbhAZKlj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 05:41:39 -0500
Received: from foss.arm.com ([217.140.110.172]:60928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404267AbhAZKlS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Jan 2021 05:41:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08040113E;
        Tue, 26 Jan 2021 02:40:33 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.2.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 55E0A3F66B;
        Tue, 26 Jan 2021 02:40:30 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     vireshk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com, amitk@kernel.org,
        rui.zhang@intel.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [RFC][PATCH 3/3] thermal: power_allocator: get proper max power limited by user
Date:   Tue, 26 Jan 2021 10:40:01 +0000
Message-Id: <20210126104001.20361-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126104001.20361-1-lukasz.luba@arm.com>
References: <20210126104001.20361-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use new API interface to get the maximum power of the cooling device. This
is needed to properly allocate and split the total power budget. The
allowed limit is taken from supported cooling device and then checked with
limits set in DT. The final state value is used for asking for the related
power value the cooling device.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 92acae53df49..ec33fba5a358 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -308,6 +308,20 @@ power_actor_set_power(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
+static int
+power_actor_get_max_power(struct thermal_cooling_device *cdev,
+			  struct thermal_instance *instance, u32 *max_power)
+{
+	unsigned long min_state = 0;
+
+	if (cdev->ops->get_user_min_state)
+		cdev->ops->get_user_min_state(cdev, &min_state);
+
+	min_state = max(instance->lower, min_state);
+
+	return cdev->ops->state2power(cdev, min_state, max_power);
+}
+
 /**
  * divvy_up_power() - divvy the allocated power between the actors
  * @req_power:	each actor's requested power
@@ -455,8 +469,7 @@ static int allocate_power(struct thermal_zone_device *tz,
 
 		weighted_req_power[i] = frac_to_int(weight * req_power[i]);
 
-		if (cdev->ops->state2power(cdev, instance->lower,
-					   &max_power[i]))
+		if (power_actor_get_max_power(cdev, instance, &max_power[i]))
 			continue;
 
 		total_req_power += req_power[i];
-- 
2.17.1

