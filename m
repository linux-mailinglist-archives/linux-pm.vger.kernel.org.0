Return-Path: <linux-pm+bounces-969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF7380EE04
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 14:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5E21C20B4E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B6D6F628;
	Tue, 12 Dec 2023 13:48:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A4E1A1;
	Tue, 12 Dec 2023 05:48:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ABDD1516;
	Tue, 12 Dec 2023 05:48:46 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9670F3F738;
	Tue, 12 Dec 2023 05:47:58 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v2 2/8] thermal: gov_power_allocator: Refactor check_power_actors()
Date: Tue, 12 Dec 2023 13:48:38 +0000
Message-Id: <20231212134844.1213381-3-lukasz.luba@arm.com>
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

Refactor check_power_actors() to make it possible for re-use in the
upcoming new callback.

No intentional functional impact.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 785fff14223d..38e1e89ba10c 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -581,8 +581,9 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
  * power actor API. The warning should help to investigate the issue, which
  * could be e.g. lack of Energy Model for a given device.
  *
- * Return: 0 on success, -EINVAL if any cooling device does not implement
- * the power actor API.
+ * Return number of cooling devices or -EINVAL if any cooling device does not
+ * implement the power actor API. Return value 0 is also valid since cooling
+ * devices might be attached later.
  */
 static int check_power_actors(struct thermal_zone_device *tz,
 			      struct power_allocator_params *params)
@@ -597,8 +598,9 @@ static int check_power_actors(struct thermal_zone_device *tz,
 		if (!cdev_is_power_actor(instance->cdev)) {
 			dev_warn(&tz->device, "power_allocator: %s is not a power actor\n",
 				 instance->cdev->type);
-			ret = -EINVAL;
+			return -EINVAL;
 		}
+		ret++;
 	}
 
 	return ret;
@@ -631,7 +633,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	}
 
 	ret = check_power_actors(tz, params);
-	if (ret) {
+	if (ret < 0) {
 		dev_warn(&tz->device, "power_allocator: binding failed\n");
 		kfree(params);
 		return ret;
-- 
2.25.1


