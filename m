Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EDB64855F
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiLIP1g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiLIP0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B2A92327
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:41 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uuFR0HAazqW/159Wq4Mx/nEfd/DtlaINFa8/ZuAVt4o=;
        b=bMV/VOTJMchlFcJsuLMGix9VUXMCjxEla1xKTDyX1/J/O2wPiRJTJXSvEgyGYaNxf3HYcv
        4LK+kCjI5OYQUCAGm2ZOPtb2+kHbRv5+Tu5/uQ0XWMURDt5qJ3AvIWsKVDyUera1cyAAaZ
        KzD8z4qNPYut2hz6XMSbVt/3tpInvIEN/ByhFkEH5p/QIGjl4nLHezJc5Muunb36nMyKIc
        ODDmb4f4NagOOI84445DIDmEUzINIZPbGT4REWjikvbfjz+4hmWVOnSnRO0S2QdjEusI7E
        lFRvToRjgQWkNgYfzRSCUn5Og+qkk+aO6zIx9ZERmWCn9iHTWK0uZJqLNalbFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uuFR0HAazqW/159Wq4Mx/nEfd/DtlaINFa8/ZuAVt4o=;
        b=NZtfi/9gO+5Fit0hsgNxbrPVwdSIXmY2RG+w/hKImrz9lF1Btw+c5PdzYOZNeSsfpYAxxz
        XLa9eD+MfJlEWIDQ==
From:   "thermal-bot for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Remove thermal_zone_set_trips()
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959761.4906.9161681478722287418.tip-bot2@tip-bot2>
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

Commit-ID:     91b3aafc2238a91051dff79a8d072a18c805ee50
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//91b3aafc2238a91051dff79a8d072a18c805ee50
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Thu, 10 Nov 2022 07:24:59 -08:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 14 Nov 2022 19:04:37 +01:00

thermal/core: Remove thermal_zone_set_trips()

Since no callers of thermal_zone_set_trips() are left, remove the function.
Document __thermal_zone_set_trips() instead. Explicitly state that the
thermal zone lock must be held when calling the function, and that the
pointer to the thermal zone must be valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.h    |  1 +-
 drivers/thermal/thermal_helpers.c | 34 +++++++++++++-----------------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 7b51b9a..b834cb2 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -113,7 +113,6 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event);
 
 /* Helpers */
-void thermal_zone_set_trips(struct thermal_zone_device *tz);
 void __thermal_zone_set_trips(struct thermal_zone_device *tz);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 321f802..56aa2e8 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -147,6 +147,21 @@ unlock:
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
+/**
+ * __thermal_zone_set_trips - Computes the next trip points for the driver
+ * @tz: a pointer to a thermal zone device structure
+ *
+ * The function computes the next temperature boundaries by browsing
+ * the trip points. The result is the closer low and high trip points
+ * to the current temperature. These values are passed to the backend
+ * driver to let it set its own notification mechanism (usually an
+ * interrupt).
+ *
+ * This function must be called with tz->lock held. Both tz and tz->ops
+ * must be valid pointers.
+ *
+ * It does not return a value
+ */
 void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 {
 	int low = -INT_MAX;
@@ -193,25 +208,6 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
 }
 
-/**
- * thermal_zone_set_trips - Computes the next trip points for the driver
- * @tz: a pointer to a thermal zone device structure
- *
- * The function computes the next temperature boundaries by browsing
- * the trip points. The result is the closer low and high trip points
- * to the current temperature. These values are passed to the backend
- * driver to let it set its own notification mechanism (usually an
- * interrupt).
- *
- * It does not return a value
- */
-void thermal_zone_set_trips(struct thermal_zone_device *tz)
-{
-	mutex_lock(&tz->lock);
-	__thermal_zone_set_trips(tz);
-	mutex_unlock(&tz->lock);
-}
-
 static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
 				       int target)
 {
