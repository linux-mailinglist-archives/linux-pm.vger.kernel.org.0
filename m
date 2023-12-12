Return-Path: <linux-pm+bounces-972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2559F80EE08
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 14:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FCE1F2166A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB2673163;
	Tue, 12 Dec 2023 13:48:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51FE2FD;
	Tue, 12 Dec 2023 05:48:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A7C3143D;
	Tue, 12 Dec 2023 05:48:50 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB1E03F738;
	Tue, 12 Dec 2023 05:48:02 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v2 5/8] thermal: gov_power_allocator: Refactor checks in divvy_up_power()
Date: Tue, 12 Dec 2023 13:48:41 +0000
Message-Id: <20231212134844.1213381-6-lukasz.luba@arm.com>
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

Simplify the code and remove one extra 'if' block.

No intentional functional impact.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 1a605fd9c8c6..574aa5822112 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -349,7 +349,8 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 			   u32 total_req_power, u32 power_range,
 			   u32 *granted_power, u32 *extra_actor_power)
 {
-	u32 extra_power, capped_extra_power;
+	u32 capped_extra_power = 0;
+	u32 extra_power = 0;
 	int i;
 
 	/*
@@ -358,8 +359,6 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 	if (!total_req_power)
 		total_req_power = 1;
 
-	capped_extra_power = 0;
-	extra_power = 0;
 	for (i = 0; i < num_actors; i++) {
 		u64 req_range = (u64)req_power[i] * power_range;
 
@@ -375,7 +374,7 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 		capped_extra_power += extra_actor_power[i];
 	}
 
-	if (!extra_power)
+	if (!extra_power || !capped_extra_power)
 		return;
 
 	/*
@@ -383,12 +382,13 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 	 * how far they are from the max
 	 */
 	extra_power = min(extra_power, capped_extra_power);
-	if (capped_extra_power > 0)
-		for (i = 0; i < num_actors; i++) {
-			u64 extra_range = (u64)extra_actor_power[i] * extra_power;
-			granted_power[i] += DIV_ROUND_CLOSEST_ULL(extra_range,
-							 capped_extra_power);
-		}
+
+	for (i = 0; i < num_actors; i++) {
+		u64 extra_range = (u64)extra_actor_power[i] * extra_power;
+
+		granted_power[i] += DIV_ROUND_CLOSEST_ULL(extra_range,
+						 capped_extra_power);
+	}
 }
 
 static int allocate_power(struct thermal_zone_device *tz, int control_temp)
-- 
2.25.1


