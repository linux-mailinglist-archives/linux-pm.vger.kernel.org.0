Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B052A28F148
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 13:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgJOLZi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 07:25:38 -0400
Received: from foss.arm.com ([217.140.110.172]:32784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbgJOLZA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Oct 2020 07:25:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E37B813D5;
        Thu, 15 Oct 2020 04:24:59 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.48.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB3393F66B;
        Thu, 15 Oct 2020 04:24:57 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com,
        michael.kao@mediatek.com, rui.zhang@intel.com
Subject: [PATCH v2 1/4] thermal: core: add upper and lower limits to power_actor_set_power
Date:   Thu, 15 Oct 2020 12:24:38 +0100
Message-Id: <20201015112441.4056-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015112441.4056-1-lukasz.luba@arm.com>
References: <20201015112441.4056-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

The upper and lower limits of thermal throttle state in the
DT do not apply to the Intelligent Power Allocation (IPA) governor.
Add the clamping for cooling device upper and lower limits in the
power_actor_set_power() used by IPA.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Michael Kao <michael.kao@mediatek.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c6d74bc1c90b..2ea3633b5d66 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -672,7 +672,7 @@ int power_actor_set_power(struct thermal_cooling_device *cdev,
 	if (ret)
 		return ret;
 
-	instance->target = state;
+	instance->target = clamp_val(state, instance->lower, instance->upper);
 	mutex_lock(&cdev->lock);
 	cdev->updated = false;
 	mutex_unlock(&cdev->lock);
-- 
2.17.1

