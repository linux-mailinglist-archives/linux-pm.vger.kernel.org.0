Return-Path: <linux-pm+bounces-971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8140C80EE09
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 14:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1203EB20DE9
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A953E6F636;
	Tue, 12 Dec 2023 13:48:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01F4F112;
	Tue, 12 Dec 2023 05:48:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FA2A175A;
	Tue, 12 Dec 2023 05:48:49 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7F0223F738;
	Tue, 12 Dec 2023 05:48:01 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v2 4/8] thermal: gov_power_allocator: Simplify checks for valid power actor
Date: Tue, 12 Dec 2023 13:48:40 +0000
Message-Id: <20231212134844.1213381-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212134844.1213381-1-lukasz.luba@arm.com>
References: <20231212134844.1213381-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a need to check if the cooling device in the thermal zone
supports IPA callback and is set for control trip point.
Refactor the code which validates the power actor capabilities and
make it more consistent in all places.

No intentional functional impact.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 41 +++++++++++----------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 3328c3ec71f2..1a605fd9c8c6 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -85,6 +85,13 @@ struct power_allocator_params {
 	u32 *weighted_req_power;
 };
 
+static bool power_actor_is_valid(struct power_allocator_params *params,
+				 struct thermal_instance *instance)
+{
+	return ((instance->trip == params->trip_max) &&
+		 cdev_is_power_actor(instance->cdev));
+}
+
 /**
  * estimate_sustainable_power() - Estimate the sustainable power of a thermal zone
  * @tz: thermal zone we are operating in
@@ -105,14 +112,10 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
 	u32 min_power;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		cdev = instance->cdev;
-
-		if (instance->trip != params->trip_max)
-			continue;
-
-		if (!cdev_is_power_actor(cdev))
+		if (!power_actor_is_valid(params, instance))
 			continue;
 
+		cdev = instance->cdev;
 		if (cdev->ops->state2power(cdev, instance->upper, &min_power))
 			continue;
 
@@ -407,8 +410,7 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 		return -ENODEV;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-		if ((instance->trip == params->trip_max) &&
-		    cdev_is_power_actor(instance->cdev))
+		if (power_actor_is_valid(params, instance))
 			total_weight += instance->weight;
 
 	/* Clean all buffers for new power estimations */
@@ -421,14 +423,10 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 	weighted_req_power = params->weighted_req_power;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		cdev = instance->cdev;
-
-		if (instance->trip != params->trip_max)
-			continue;
-
-		if (!cdev_is_power_actor(cdev))
+		if (!power_actor_is_valid(params, instance))
 			continue;
 
+		cdev = instance->cdev;
 		if (cdev->ops->get_requested_power(cdev, &req_power[i]))
 			continue;
 
@@ -458,10 +456,7 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 
 	i = 0;
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != params->trip_max)
-			continue;
-
-		if (!cdev_is_power_actor(instance->cdev))
+		if (!power_actor_is_valid(params, instance))
 			continue;
 
 		power_actor_set_power(instance->cdev, instance,
@@ -546,12 +541,11 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 	u32 req_power;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		cdev = instance->cdev;
-
-		if (instance->trip != params->trip_max ||
-		    !cdev_is_power_actor(instance->cdev))
+		if (!power_actor_is_valid(params, instance))
 			continue;
 
+		cdev = instance->cdev;
+
 		instance->target = 0;
 		mutex_lock(&cdev->lock);
 		/*
@@ -664,8 +658,7 @@ static void power_allocator_update_tz(struct thermal_zone_device *tz,
 	switch (reason) {
 	case THERMAL_INSTANCE_LIST_UPDATE:
 		list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-			if ((instance->trip == params->trip_max) &&
-			    cdev_is_power_actor(instance->cdev))
+			if (power_actor_is_valid(params, instance))
 				num_actors++;
 
 		if (num_actors == params->num_actors)
-- 
2.25.1


