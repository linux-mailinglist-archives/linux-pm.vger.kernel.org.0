Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC1A33F090
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 13:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCQMjn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 08:39:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49788 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhCQMjL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 08:39:11 -0400
Date:   Wed, 17 Mar 2021 12:39:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3n43Su6hIL/O4SO5vFporQTrz5ypX1/Deu53d4d+7To=;
        b=Kwz4U+4jZzlGYuZIkHWk6/Yihm1opJKCfVsjgbK7pLRz47x8ZvUWQb/LqPcLfH3Y3i7tt1
        Kwiimyeh0IqjGITweYrNPpxB6LEqEun068zaOAcLHuVklvYjH0MJH26REASBDA8UaBMfBo
        o6+nLAqbKKvUMiunmUI3To4tqlkEFys/KvXVRvxOzJofa113u0p6ZkxlmVEWbWiLqECLMR
        ipNtFTOAOzxdZmvBrFw6VY2997kiMze/IwSstoWP+W1q7QVGjneHXLt7Yay6NzFLtcYzcD
        0qrthFEf/X+EcYZOciUFHOBB+O6qUANuruUxlrRzAcV/CguFvSd1qYQHqbuXaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3n43Su6hIL/O4SO5vFporQTrz5ypX1/Deu53d4d+7To=;
        b=aeLPckaX+B1Tzr3zyZa7rAc+ezyqJbD3qZ0AleedBZ75uUEN3yYuFjCTV0zhGuBO2KCtoV
        lby51UuDQrSXz5CA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/cpufreq_cooling: Remove unused list
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20210314111333.16551-5-daniel.lezcano@linaro.org>
References: <20210314111333.16551-5-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161598474980.398.8919141399973695970.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     87602aeb8ad5bb1b2e23285a9d1322ac033f86c9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//87602aeb8ad5bb1b2e23285a9d1322ac033f86c9
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Sun, 14 Mar 2021 12:13:33 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 15 Mar 2021 04:47:13 +01:00

thermal/drivers/cpufreq_cooling: Remove unused list

There is a list with the purpose of grouping the cpufreq cooling
device together as described in the comments but actually it is
unused, the code evolved since 2012 and the list was no longer needed.

Delete the remaining unused list related code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20210314111333.16551-5-daniel.lezcano@linaro.org
---
 drivers/thermal/cpufreq_cooling.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 3f5f1dc..f3d3084 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -59,7 +59,6 @@ struct time_in_idle {
  * @cdev: thermal_cooling_device pointer to keep track of the
  *	registered cooling device.
  * @policy: cpufreq policy.
- * @node: list_head to link all cpufreq_cooling_device together.
  * @idle_time: idle time stats
  * @qos_req: PM QoS contraint to apply
  *
@@ -72,16 +71,12 @@ struct cpufreq_cooling_device {
 	unsigned int max_level;
 	struct em_perf_domain *em;
 	struct cpufreq_policy *policy;
-	struct list_head node;
 #ifndef CONFIG_SMP
 	struct time_in_idle *idle_time;
 #endif
 	struct freq_qos_request qos_req;
 };
 
-static DEFINE_MUTEX(cooling_list_lock);
-static LIST_HEAD(cpufreq_cdev_list);
-
 #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
 /**
  * get_level: Find the level for a particular frequency
@@ -602,10 +597,6 @@ __cpufreq_cooling_register(struct device_node *np,
 	if (IS_ERR(cdev))
 		goto remove_qos_req;
 
-	mutex_lock(&cooling_list_lock);
-	list_add(&cpufreq_cdev->node, &cpufreq_cdev_list);
-	mutex_unlock(&cooling_list_lock);
-
 	return cdev;
 
 remove_qos_req:
@@ -697,10 +688,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	cpufreq_cdev = cdev->devdata;
 
-	mutex_lock(&cooling_list_lock);
-	list_del(&cpufreq_cdev->node);
-	mutex_unlock(&cooling_list_lock);
-
 	thermal_cooling_device_unregister(cdev);
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
 	free_idle_time(cpufreq_cdev);
