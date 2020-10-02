Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938B228127E
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 14:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbgJBMYa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 08:24:30 -0400
Received: from foss.arm.com ([217.140.110.172]:34560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387954AbgJBMY3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Oct 2020 08:24:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17B6E106F;
        Fri,  2 Oct 2020 05:24:29 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.50.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 535E73F70D;
        Fri,  2 Oct 2020 05:24:27 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com
Subject: [PATCH 2/2] thermal: power allocator: estimate sustainable power only once
Date:   Fri,  2 Oct 2020 13:24:16 +0100
Message-Id: <20201002122416.13659-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002122416.13659-1-lukasz.luba@arm.com>
References: <20201002122416.13659-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The sustainable power value might come from the Device Tree or can be
estimated in run time. There is no need to estimate every time when the
governor is called and temperature is high. Instead, store the estimated
value and make it available via standard sysfs interface so it can be
checked from the user-space.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index f69fafe486a5..dd59085f38f5 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -204,6 +204,8 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 		estimate_pid_constants(tz, sustainable_power,
 				       params->trip_switch_on, control_temp,
 				       true);
+		/* Do the estimation only once and make available in sysfs */
+		tz->tzp->sustainable_power = sustainable_power;
 	}
 
 	err = control_temp - tz->temperature;
-- 
2.17.1

