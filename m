Return-Path: <linux-pm+bounces-975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE6D80EE0D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 14:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC2F1C20C10
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669436F61D;
	Tue, 12 Dec 2023 13:48:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DCC5194;
	Tue, 12 Dec 2023 05:48:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6DAB1474;
	Tue, 12 Dec 2023 05:48:54 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 43EB03F738;
	Tue, 12 Dec 2023 05:48:07 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v2 8/8] thermal: gov_power_allocator: Support new update callback of weights
Date: Tue, 12 Dec 2023 13:48:44 +0000
Message-Id: <20231212134844.1213381-9-lukasz.luba@arm.com>
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

When the thermal instance's weight is updated from the sysfs the governor
update_tz() callback is triggered. Implement proper reaction to this
event in the IPA, which would save CPU cycles spent in throttle().
This will speed-up the main throttle() IPA function and clean it up
a bit.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 574aa5822112..a9f1549e6355 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -61,6 +61,7 @@ static inline s64 div_frac(s64 x, s64 y)
  *			@trip_switch_on should be NULL.
  * @trip_max:		last passive trip point of the thermal zone. The
  *			temperature we are controlling for.
+ * @total_weight:	Sum of all thermal instances weights
  * @num_actors:		number of cooling devices supporting IPA callbacks
  * @buffer_size:	IPA internal buffer size
  * @req_power:		IPA buffer for requested power
@@ -76,6 +77,7 @@ struct power_allocator_params {
 	u32 sustainable_power;
 	const struct thermal_trip *trip_switch_on;
 	const struct thermal_trip *trip_max;
+	int total_weight;
 	int num_actors;
 	int buffer_size;
 	u32 *req_power;
@@ -403,16 +405,11 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 	u32 total_req_power = 0;
 	u32 *weighted_req_power;
 	u32 power_range, weight;
-	int total_weight = 0;
 	int i = 0;
 
 	if (!params->num_actors)
 		return -ENODEV;
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-		if (power_actor_is_valid(params, instance))
-			total_weight += instance->weight;
-
 	/* Clean all buffers for new power estimations */
 	memset(params->req_power, 0, params->buffer_size);
 
@@ -430,7 +427,7 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 		if (cdev->ops->get_requested_power(cdev, &req_power[i]))
 			continue;
 
-		if (!total_weight)
+		if (!params->total_weight)
 			weight = 1 << FRAC_BITS;
 		else
 			weight = instance->weight;
@@ -666,6 +663,12 @@ static void power_allocator_update_tz(struct thermal_zone_device *tz,
 
 		allocate_actors_buffer(params, num_actors);
 		break;
+	case THERMAL_INSTANCE_WEIGHT_UPDATE:
+		params->total_weight = 0;
+		list_for_each_entry(instance, &tz->thermal_instances, tz_node)
+			if (power_actor_is_valid(params, instance))
+				params->total_weight += instance->weight;
+		break;
 	default:
 		break;
 	}
-- 
2.25.1


