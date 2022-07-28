Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9AA584362
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiG1PmI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiG1PmH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:42:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F916675B7
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:42:06 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:42:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022925;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xks27Dnp58BMs2V8Nyxlu0vIIWDNUlTkVog3vDhZhBU=;
        b=mY4Wh17pt1Y3pe/KWGtKz6m64LdCcnkJRDJQnU18Eg05uBjaXHwLjmp3rjlxhIR9FtkfQl
        xyHBuT6i9/uL+20yPdvw037mEDjBUPrDJSraF0J0YtThFMU0wrvycFfWkV2JZxmDUn9bTh
        weX/5Q+mWeZgsg7CoUugx85nwKu2GR9zuFYMr1RpkEh8cBKV8CsNYCKJg9k8LeY/rjEK7S
        /UHCKHlxP+PgRsR1ilZMQz/DL83tMn9uXRhwMyLM28gC7Tbu3kAYFGWHBwiChhVeYJ34MX
        VdbuN9OLfK1Dhcgn1YEwv5NhJFaNuiO174XxLgaThS4m/E8ug2GLv2pvbGd6+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022925;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xks27Dnp58BMs2V8Nyxlu0vIIWDNUlTkVog3vDhZhBU=;
        b=IxogYHEnsXIHuu4UJzy5/ZSH7x2FZuTQ7usAYr/8i6NrVhyTektWyo9ptWD7FAHMaCjSJJ
        LTsUAnVz0yF6/4Cg==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] drivers/thermal/cpufreq_cooling: Use private
 callback ops for each cooling device
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220613124327.30766-2-lukasz.luba@arm.com>
References: <20220613124327.30766-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <165902292398.15455.9515377508059027850.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     3cbf6a8ab70b21de75bc389d384911392cf7f616
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//3cbf6a8ab70b21de75bc389d384911392cf7f616
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Mon, 13 Jun 2022 13:43:24 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:41 +02:00

drivers/thermal/cpufreq_cooling: Use private callback ops for each cooling device

It is very unlikely that one CPU cluster would have the EM and some other
won't have it (because EM registration failed or DT lacks needed entry).
Although, we should avoid modifying global variable with callbacks anyway.
Redesign this and add safety for such situation.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lore.kernel.org/r/20220613124327.30766-2-lukasz.luba@arm.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpufreq_cooling.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index b8151d9..ad8b86f 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -59,6 +59,7 @@ struct time_in_idle {
  * @cdev: thermal_cooling_device pointer to keep track of the
  *	registered cooling device.
  * @policy: cpufreq policy.
+ * @cooling_ops: cpufreq callbacks to thermal cooling device ops
  * @idle_time: idle time stats
  * @qos_req: PM QoS contraint to apply
  *
@@ -71,6 +72,7 @@ struct cpufreq_cooling_device {
 	unsigned int max_level;
 	struct em_perf_domain *em;
 	struct cpufreq_policy *policy;
+	struct thermal_cooling_device_ops cooling_ops;
 #ifndef CONFIG_SMP
 	struct time_in_idle *idle_time;
 #endif
@@ -485,14 +487,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	return ret;
 }
 
-/* Bind cpufreq callbacks to thermal cooling device ops */
-
-static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
-	.get_max_state		= cpufreq_get_max_state,
-	.get_cur_state		= cpufreq_get_cur_state,
-	.set_cur_state		= cpufreq_set_cur_state,
-};
-
 /**
  * __cpufreq_cooling_register - helper function to create cpufreq cooling device
  * @np: a valid struct device_node to the cooling device device tree node
@@ -554,7 +548,10 @@ __cpufreq_cooling_register(struct device_node *np,
 	/* max_level is an index, not a counter */
 	cpufreq_cdev->max_level = i - 1;
 
-	cooling_ops = &cpufreq_cooling_ops;
+	cooling_ops = &cpufreq_cdev->cooling_ops;
+	cooling_ops->get_max_state = cpufreq_get_max_state;
+	cooling_ops->get_cur_state = cpufreq_get_cur_state;
+	cooling_ops->set_cur_state = cpufreq_set_cur_state;
 
 #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
 	if (em_is_sane(cpufreq_cdev, em)) {
