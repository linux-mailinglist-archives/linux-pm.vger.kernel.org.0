Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DF92FC26B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbhASVfB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 16:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbhASV2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 16:28:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE64C0613C1
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 13:27:29 -0800 (PST)
Date:   Tue, 19 Jan 2021 21:27:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611091646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0HkW5o91COjuekgU/TS60vkKAW2ep46WmQ+q5F8/shw=;
        b=cLdneG5tGBo3RyxJB6tvs89dRfA1p3KTt1GuifSMCZBNxoqSMh0Depk1d76NRfdyn/lwMJ
        FJW9VSo0H5ziEEBwkLhHxm8LpqXCJ6tL/TEas9tB0QuG0mTrAT+EOGR1bI31G5OHzL+Fao
        RFDsz1CetAcoSG9FvjalGkuGNjLW6UisAks2PjqBXZ6ZqaX65afe7m1krrYKlAFS/wx3nf
        YDNAch2jUEQg2qsbpD5jgFxL19hVYoJzReIfFOyQOSzP/YX3+7/vSxtX2QhwdD1rWAl//M
        +ljpToTVayi/ZCMT49lv21lU8dt9LR6L9LP76BwZI0mYkWEmWfZQQQUE0dveyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611091646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0HkW5o91COjuekgU/TS60vkKAW2ep46WmQ+q5F8/shw=;
        b=wxYJsmKSGg3me+S1Cd2FcM96wy2tuTteHcdpuIHqGXsXfmfNhgNFJNzZxmEH5C35gnKI8D
        hrSMKBoiipPCh7Dw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Use precomputed jiffies for the polling
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20201216220337.839878-2-daniel.lezcano@linaro.org>
References: <20201216220337.839878-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161109164575.414.18091167535205437557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     39a38808d082fc0fbf45cfefda17252ed8c6b31f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//39a38808d082fc0fbf45cfefda17252ed8c6b31f
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Wed, 16 Dec 2020 23:03:36 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 19 Jan 2021 22:23:43 +01:00

thermal/core: Use precomputed jiffies for the polling

The delays are also stored in jiffies based unit. Use them instead of
the ms.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Link: https://lore.kernel.org/r/20201216220337.839878-2-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2c41d4a..d96c515 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -289,16 +289,11 @@ static int __init thermal_register_governors(void)
  * - Critical trip point will cause a system shutdown.
  */
 static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
-					    int delay)
+					    unsigned long delay)
 {
-	if (delay > 1000)
+	if (delay)
 		mod_delayed_work(system_freezable_power_efficient_wq,
-				 &tz->poll_queue,
-				 round_jiffies(msecs_to_jiffies(delay)));
-	else if (delay)
-		mod_delayed_work(system_freezable_power_efficient_wq,
-				 &tz->poll_queue,
-				 msecs_to_jiffies(delay));
+				 &tz->poll_queue, delay);
 	else
 		cancel_delayed_work(&tz->poll_queue);
 }
@@ -317,9 +312,9 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 	mutex_lock(&tz->lock);
 
 	if (!stop && tz->passive)
-		thermal_zone_device_set_polling(tz, tz->passive_delay);
+		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
 	else if (!stop && tz->polling_delay)
-		thermal_zone_device_set_polling(tz, tz->polling_delay);
+		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
 	else
 		thermal_zone_device_set_polling(tz, 0);
 
