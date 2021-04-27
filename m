Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675CF36CBDE
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbhD0TpL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbhD0TpK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6EEC06175F
        for <linux-pm@vger.kernel.org>; Tue, 27 Apr 2021 12:44:27 -0700 (PDT)
Date:   Tue, 27 Apr 2021 19:44:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552665;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7sGKnmAb9hM20PuDXuxwCUhx3ctB9ZYkUkXJYUhigI=;
        b=vsS4wtXENHGFFLNoNyPo1iaXp6VPVaX9VHSDDAP6ecpjfHjefKmW4UYfvFijAJvM7HLk66
        pfOHkkboq9UqZl3zSs2R0Kqa1Ikk0Aiw+eOS17Fmt29muqHw8QDY89WhFPHTB6ezq7uOv9
        HKGRJxvfMl2AeFiRgHShgsXouVyD0SveSbJelRLWRfGDogiQ09CVwtdRg8GqSA8nOO5T2I
        7Nk84ZI2rKhv4nS4/cPYzVJ3gpnbyMsVMWnY+2dSBoYv78gkZ/6OZ32zUfB6g2yQ3LSREc
        bRrqlzpIcDcUikGZL+QoffDTCHF5Pjp6Ylre33p1DC2CidRhhuy+5NecMwJ6+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552665;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7sGKnmAb9hM20PuDXuxwCUhx3ctB9ZYkUkXJYUhigI=;
        b=0bKruQzmceRw/GKOEFNFF2lj2prBYGiNgFyZB8cISNJ/Tq7kyeIwYxl8b4nFpvsPUAbmL2
        HlU5Q4ZwcbooMpCg==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core/power_allocator: Maintain the
 device statistics from going stale
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210422114308.29684-3-lukasz.luba@arm.com>
References: <20210422114308.29684-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <161955266480.29796.9360801387015526845.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     d3b60ed9b135e2c652115db691a87dc28b324bea
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d3b60ed9b135e2c652115db691a87dc28b324bea
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Thu, 22 Apr 2021 12:43:07 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 22 Apr 2021 23:50:49 +02:00

thermal/core/power_allocator: Maintain the device statistics from going stale

When the temperature is below the first activation trip point the cooling
devices are not checked, so they cannot maintain fresh statistics. It
leads into the situation, when temperature crosses first trip point, the
statistics are stale and show state for very long period. This has impact
on IPA algorithm calculation and wrong decisions. Thus, check the cooling
devices even when the temperature is low, to refresh these statistics.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210422114308.29684-3-lukasz.luba@arm.com
---
 drivers/thermal/gov_power_allocator.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 2802a0e..d393409 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -575,15 +575,25 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
 {
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
+	u32 req_power;
 
 	mutex_lock(&tz->lock);
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		struct thermal_cooling_device *cdev = instance->cdev;
+
 		if ((instance->trip != params->trip_max_desired_temperature) ||
 		    (!cdev_is_power_actor(instance->cdev)))
 			continue;
 
 		instance->target = 0;
 		mutex_lock(&instance->cdev->lock);
+		/*
+		 * Call for updating the cooling devices local stats and avoid
+		 * periods of dozen of seconds when those have not been
+		 * maintained.
+		 */
+		cdev->ops->get_requested_power(cdev, &req_power);
+
 		instance->cdev->updated = false;
 		mutex_unlock(&instance->cdev->lock);
 		thermal_cdev_update(instance->cdev);
