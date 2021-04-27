Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB4736CBE9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbhD0TpP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43138 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238952AbhD0TpO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:14 -0400
Date:   Tue, 27 Apr 2021 19:44:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwZNmxXdWKtrfWgCAF7ACIyoKQIR09omO3zTHz3qE+k=;
        b=QJ882u0CpCqdAre2b/bfykXBPAWLA26SAQgvmsIrd5h646ma1knLQP1IAARbskBZqFTMvN
        MfQ8s7vn1KimE9tuajrmVpHgNXRC47BoNciKA2MQAu5s1Ysj8l44HB2CuYLlwXSn7xh3JW
        5FVuS/xzeQY03k9DEoIOw6IGolglMMjXCRaqPPBpQVdM7XhMfkndqFC3gBSdeeXDWqZsR4
        ZVzZJONW5bxUQWqM1b4sgbedXxueusDkc0Za8/vMEEwYGlXKgqGMfgFQ42AFhwtQ9I5+B+
        BMFAWl0fw80tx/QzuQzAFua71EcSOGmIQSRpTsPuexB2kW7DLAHdeT49q0DK+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwZNmxXdWKtrfWgCAF7ACIyoKQIR09omO3zTHz3qE+k=;
        b=DrwHVX5F3eK2Fz/4cGJ8EY68jwkwrEJm1u/NdRxsK4Iz0vHrjoFrmslNoGuml23BGBOPj6
        gAQLZzEXFqi7N2BA==
From:   "thermal-bot for Thara Gopinath" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Remove thermal_notify_framework
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210122023406.3500424-3-thara.gopinath@linaro.org>
References: <20210122023406.3500424-3-thara.gopinath@linaro.org>
MIME-Version: 1.0
Message-ID: <161955266997.29796.1220869279176722111.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     d60d6e7adfc3814f6de03c978ff1daab21478f87
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d60d6e7adfc3814f6de03c978ff1daab21478f87
Author:        Thara Gopinath <thara.gopinath@linaro.org>
AuthorDate:    Thu, 21 Jan 2021 21:34:05 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 22 Apr 2021 13:14:09 +02:00

thermal/core: Remove thermal_notify_framework

thermal_notify_framework just updates for a single trip point where as
thermal_zone_device_update does other bookkeeping like updating the
temperature of the thermal zone and setting the next trip point. The only
driver that was using thermal_notify_framework was updated in the previous
patch to use thermal_zone_device_update instead. Since there are no users
for thermal_notify_framework remove it.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210122023406.3500424-3-thara.gopinath@linaro.org
---
 drivers/thermal/thermal_core.c | 18 ------------------
 include/linux/thermal.h        |  5 -----
 2 files changed, 23 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 3566fd2..d20b25f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -561,24 +561,6 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
-/**
- * thermal_notify_framework - Sensor drivers use this API to notify framework
- * @tz:		thermal zone device
- * @trip:	indicates which trip point has been crossed
- *
- * This function handles the trip events from sensor drivers. It starts
- * throttling the cooling devices according to the policy configured.
- * For CRITICAL and HOT trip points, this notifies the respective drivers,
- * and does actual throttling for other trip points i.e ACTIVE and PASSIVE.
- * The throttling policy is based on the configured platform data; if no
- * platform data is provided, this uses the step_wise throttling policy.
- */
-void thermal_notify_framework(struct thermal_zone_device *tz, int trip)
-{
-	handle_thermal_trip(tz, trip);
-}
-EXPORT_SYMBOL_GPL(thermal_notify_framework);
-
 static void thermal_zone_device_check(struct work_struct *work)
 {
 	struct thermal_zone_device *tz = container_of(work, struct
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 1695021..d296f3b 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -390,7 +390,6 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
 
-void thermal_notify_framework(struct thermal_zone_device *, int);
 int thermal_zone_device_enable(struct thermal_zone_device *tz);
 int thermal_zone_device_disable(struct thermal_zone_device *tz);
 void thermal_zone_device_critical(struct thermal_zone_device *tz);
@@ -436,10 +435,6 @@ static inline int thermal_zone_get_offset(
 		struct thermal_zone_device *tz)
 { return -ENODEV; }
 
-static inline void thermal_notify_framework(struct thermal_zone_device *tz,
-	int trip)
-{ }
-
 static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
 { return -ENODEV; }
 
