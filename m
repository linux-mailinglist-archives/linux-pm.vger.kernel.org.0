Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB0659E6EE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbiHWQWH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbiHWQVu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:21:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A9816D2C5
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:42:45 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:42:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258563;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKcOm9BMu/u0iyxrc//KwCcRIh0F1fpJ1HTwY4FmgNY=;
        b=ur599XLlqRVJW8XDG6fL+4MdCvnNZSdBIWihPMMFXr7lQcWFlhxgotiffUf8iq1Jlu7VVs
        fyt2o1WnxgNulSIaRPW4taOwaeGwNHPop3vJucYJ1rVH6RNHFVcJzpQc51YddEaKciRwXQ
        y77Zhi7VnXFCLsR8+fCkYdc1m7wVMGb+M2qSQtrwsmgHwWphrPT295OTCmNujl8TC3V1ja
        TaUec7SuQPJDMKNeaeznDsPjWP4Z5DQCUiQ3Jg62TQrMLUAQdSb5Jv2io4ReHQ2OoB8PbW
        ZmQUibH2sPFwTMscuJn6nDZ9kz38ms17GvjL78pbzr3rOiuhhd/HfFm/5dVTAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258563;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKcOm9BMu/u0iyxrc//KwCcRIh0F1fpJ1HTwY4FmgNY=;
        b=2h9YiUYlvpR1gcSjgy534PvZKuIgXdiJUMAU71Be3ZdFpAVQyou/iyYId/Gqj+Jxucgqj6
        oqflsRF30UuUT7BA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Rework the monitoring a bit
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20220805153834.2510142-2-daniel.lezcano@linaro.org>
References: <20220805153834.2510142-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <166125856275.401.851692262137895508.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     15a73839e3ced8d418e6c34548f5e2789f9da619
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//15a73839e3ced8d418e6c34548f5e2789f9da619
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Fri, 05 Aug 2022 17:38:31 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:39 +02:00

thermal/core: Rework the monitoring a bit

The should_stop_polling() function wraps the function
thermal_zone_device_is_enabled().

The monitor_thermal_zone() function checks if the thermal zone is
enabled via the should_stop_polling() function.

However, the instant after checking the thermal zone is enabled, this
one can be disabled, so even if that reduces the race window, it does
not prevent that and the monitoring can be set again with the thermal
zone disabled.

For this reason, the function should_stop_polling() is replaced by a
direct check of the thermal zone mode with the mutex locks held, that
prevents the situation described above.

As the semantic is clear with the thermal_zone_is_enabled() function,
we can remove the should_stop_polling() function and replace the check
with the former function.

While at it, reorder the checks to improve the readability of the
monitor_thermal_zone() function.

In the future, the thermal_zone_device_disable() and the
thermal_zone_device_enable() functions should unset / set the polling
timer directly instead of relying on the next
thermal_zone_device_update() call to do that. That will make a
synchronous thermal zone mode change but the locking scheme should be
double checked for that which out of the scope of this change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20220805153834.2510142-2-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index ea41ea6..5408e92 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -295,25 +295,16 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 		cancel_delayed_work(&tz->poll_queue);
 }
 
-static inline bool should_stop_polling(struct thermal_zone_device *tz)
-{
-	return !thermal_zone_device_is_enabled(tz);
-}
-
 static void monitor_thermal_zone(struct thermal_zone_device *tz)
 {
-	bool stop;
-
-	stop = should_stop_polling(tz);
-
 	mutex_lock(&tz->lock);
 
-	if (!stop && tz->passive)
+	if (tz->mode != THERMAL_DEVICE_ENABLED)
+		thermal_zone_device_set_polling(tz, 0);
+	else if (tz->passive)
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
-	else if (!stop && tz->polling_delay_jiffies)
+	else if (tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
-	else
-		thermal_zone_device_set_polling(tz, 0);
 
 	mutex_unlock(&tz->lock);
 }
@@ -480,7 +471,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 {
 	int count;
 
-	if (should_stop_polling(tz))
+	if (!thermal_zone_device_is_enabled(tz))
 		return;
 
 	if (atomic_read(&in_suspend))
