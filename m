Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E83648567
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiLIP1m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiLIP0s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9D18DBE3
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:41 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9kcLeTGGZsVV19pOQ6+EQyBX2gt6m3zqiALZyEYbA4c=;
        b=wEJUwkeaeq+/z5DdIO030fQTNazFYFQWp5Q9yBSylsablPOhzbo87ajQNc097esU+EwQvW
        4KgVjt05mB+59oJrpsyAvPgdesPH1K5UnpzwYZttwBcyLXXet90gpXJr1cNW6Yd9DJXbxp
        wpz3W0d8flncz19qXqq6WjkN0zL7O0gTENVFm2XlXPjsPhBCnpNUxVgFbhEwGPqdBqOo1t
        2MtoBDDrzyA6UFQmudriVdHW0xC/P1TDFS+JMks+8U+hphMK3IwBI/QA5g9BH43+hE9X5s
        a2oDXaVoV5tRCoiDhma0QhyEts6GwuPNS20pn2PAvmK/Ixf8L2YtGFKoUtVz6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9kcLeTGGZsVV19pOQ6+EQyBX2gt6m3zqiALZyEYbA4c=;
        b=wxgtTOJ1ZDQODesKgm5AmnWsrLUIVcZ0I5n29pvlaQFmeQ7RCbr3/sxtLx54RLsvn251FF
        QOxp0545dqAcU6BQ==
From:   "thermal-bot for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Introduce locked version of
 thermal_zone_device_update
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959812.4906.915161542460570093.tip-bot2@tip-bot2>
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

Commit-ID:     1c439dec359caa225c7752334c7a14ef9e3344c7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//1c439dec359caa225c7752334c7a14ef9e3344c7
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Thu, 10 Nov 2022 07:24:56 -08:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 14 Nov 2022 19:04:37 +01:00

thermal/core: Introduce locked version of thermal_zone_device_update

In thermal_zone_device_set_mode(), the thermal zone mutex is released only
to be reacquired in the subsequent call to thermal_zone_device_update().

Introduce __thermal_zone_device_update(), which is similar to
thermal_zone_device_update() but has to be called with the thermal device
mutex held. Call the new function from thermal_zone_device_set_mode()
to avoid the extra thermal device mutex release/acquire sequence in that
function.

With the new function in place, re-implement thermal_zone_device_update()
as wrapper around __thermal_zone_device_update() to acquire and release
the thermal device mutex.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c | 57 +++++++++++++++++----------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5d19dc6..0657e4b 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -403,6 +403,34 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 		pos->initialized = false;
 }
 
+static void __thermal_zone_device_update(struct thermal_zone_device *tz,
+					 enum thermal_notify_event event)
+{
+	int count;
+
+	if (atomic_read(&in_suspend))
+		return;
+
+	if (WARN_ONCE(!tz->ops->get_temp,
+		      "'%s' must not be called without 'get_temp' ops set\n",
+		      __func__))
+		return;
+
+	if (!thermal_zone_device_is_enabled(tz))
+		return;
+
+	update_temperature(tz);
+
+	__thermal_zone_set_trips(tz);
+
+	tz->notify_event = event;
+
+	for (count = 0; count < tz->num_trips; count++)
+		handle_thermal_trip(tz, count);
+
+	monitor_thermal_zone(tz);
+}
+
 static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 					enum thermal_device_mode mode)
 {
@@ -423,9 +451,9 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 	if (!ret)
 		tz->mode = mode;
 
-	mutex_unlock(&tz->lock);
+	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	mutex_unlock(&tz->lock);
 
 	if (mode == THERMAL_DEVICE_ENABLED)
 		thermal_notify_tz_enable(tz->id);
@@ -457,31 +485,8 @@ int thermal_zone_device_is_enabled(struct thermal_zone_device *tz)
 void thermal_zone_device_update(struct thermal_zone_device *tz,
 				enum thermal_notify_event event)
 {
-	int count;
-
-	if (atomic_read(&in_suspend))
-		return;
-
-	if (WARN_ONCE(!tz->ops->get_temp, "'%s' must not be called without "
-		      "'get_temp' ops set\n", __func__))
-		return;
-
 	mutex_lock(&tz->lock);
-
-	if (!thermal_zone_device_is_enabled(tz))
-		goto out;
-
-	update_temperature(tz);
-
-	__thermal_zone_set_trips(tz);
-
-	tz->notify_event = event;
-
-	for (count = 0; count < tz->num_trips; count++)
-		handle_thermal_trip(tz, count);
-
-	monitor_thermal_zone(tz);
-out:
+	__thermal_zone_device_update(tz, event);
 	mutex_unlock(&tz->lock);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
