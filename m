Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE03B285F0D
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 14:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgJGMXz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 08:23:55 -0400
Received: from foss.arm.com ([217.140.110.172]:42886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgJGMXz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Oct 2020 08:23:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FBD81042;
        Wed,  7 Oct 2020 05:23:55 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.52.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB1C33F71F;
        Wed,  7 Oct 2020 05:23:39 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com,
        michael.kao@mediatek.com, rui.zhang@intel.com
Subject: [PATCH 1/3] thermal: power_allocator: respect upper and lower bounds for cooling device
Date:   Wed,  7 Oct 2020 13:22:54 +0100
Message-Id: <20201007122256.28080-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201007122256.28080-1-lukasz.luba@arm.com>
References: <20201007122256.28080-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal cooling device specified in DT might be instantiated for
a thermal zone trip point with a limited set of OPPs to operate on. This
configuration should be supported by Intelligent Power Allocation (IPA),
since it is a standard for other governors. Change the code and allow IPA
to get power value of lower and upper bound set for a given cooling
device.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index dd59085f38f5..f9ee7787b325 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -96,7 +96,8 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
 		if (instance->trip != params->trip_max_desired_temperature)
 			continue;
 
-		if (power_actor_get_min_power(cdev, tz, &min_power))
+		if (cdev->ops->state2power(cdev, tz, instance->upper,
+					   &min_power))
 			continue;
 
 		sustainable_power += min_power;
@@ -404,7 +405,8 @@ static int allocate_power(struct thermal_zone_device *tz,
 
 		weighted_req_power[i] = frac_to_int(weight * req_power[i]);
 
-		if (power_actor_get_max_power(cdev, tz, &max_power[i]))
+		if (cdev->ops->state2power(cdev, tz, instance->lower,
+					   &max_power[i]))
 			continue;
 
 		total_req_power += req_power[i];
-- 
2.17.1

