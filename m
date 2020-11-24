Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703A42C219C
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 10:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbgKXJgs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 04:36:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42112 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731384AbgKXJgr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:47 -0500
Date:   Tue, 24 Nov 2020 09:36:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7JX6Pzemlt727AZxrgxhUPVgUk8XmClNLTEFP9IKWM=;
        b=mKkdpUNCw2PH9tY+2CoW5jHdUxUF6WIcryYj3G9idZUK2SWEDJk6XzUtZCHgxN16rGgmyC
        hO2KeRT4lOVe2SoDgLQtoNNybvDiKFBYxFGdzeAws7A3N7jMIghaL73OifzR8tUj31Agdq
        EpxYjjQzJPiPjY1vH3XT4FwcArsEh1bzpeiUZjCSJ8VdbmDcSYAW4ATw5ekulBskgF4C1L
        RZz8V9gZhBXtAl70swDogG7haB2lkD+KPOeKRoxhTFd6s45XU+EGtLDZli47qpCWse4dXJ
        m3u90lFLjxMvyHYMaJ+oxoE7VWOXhIW31MuzBT4+i23M92k8mecPx/rmw+YPow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7JX6Pzemlt727AZxrgxhUPVgUk8XmClNLTEFP9IKWM=;
        b=8ahQzYDVr2wRI73rDoC+va0zBazbgzV+FfhgbWXAUpI4WfIiqtiaJtjqzuCTcgt/bOSZN6
        DEjg5opLMVXdYQCg==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: power_allocator: Respect upper and
 lower bounds for cooling device
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201015112441.4056-3-lukasz.luba@arm.com>
References: <20201015112441.4056-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <160621060492.11115.4305995116543175135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     8132df3a06a41823aa370dbb4ff08f48fa07f6df
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8132df3a06a41823aa370dbb4ff08f48fa07f6df
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Thu, 15 Oct 2020 12:24:39 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Oct 2020 09:44:32 +01:00

thermal: power_allocator: Respect upper and lower bounds for cooling device

The thermal cooling device specified in DT might be instantiated for
a thermal zone trip point with a limited set of OPPs to operate on. This
configuration should be supported by Intelligent Power Allocation (IPA),
since it is a standard for other governors. Change the code and allow IPA
to get power value of lower and upper bound set for a given cooling
device.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201015112441.4056-3-lukasz.luba@arm.com
---
 drivers/thermal/gov_power_allocator.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index ab0be26..eb8c9af 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -96,7 +96,10 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
 		if (instance->trip != params->trip_max_desired_temperature)
 			continue;
 
-		if (power_actor_get_min_power(cdev, &min_power))
+		if (!cdev_is_power_actor(cdev))
+			continue;
+
+		if (cdev->ops->state2power(cdev, instance->upper, &min_power))
 			continue;
 
 		sustainable_power += min_power;
@@ -398,7 +401,8 @@ static int allocate_power(struct thermal_zone_device *tz,
 
 		weighted_req_power[i] = frac_to_int(weight * req_power[i]);
 
-		if (power_actor_get_max_power(cdev, &max_power[i]))
+		if (cdev->ops->state2power(cdev, instance->lower,
+					   &max_power[i]))
 			continue;
 
 		total_req_power += req_power[i];
