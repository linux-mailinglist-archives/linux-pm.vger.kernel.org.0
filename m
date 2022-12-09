Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDC9648563
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiLIP1j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiLIP0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5292C92323
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:41 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mcjw3+G70ffidzFwibf8WIyWyIs0dYYGTGd8CPedFW4=;
        b=pPVf/VhXAKPXcITDsRCTtONTEFKcnp+LIiivi9Vba0sm4V+PZlp4ZJV0AgtFp9uorAZLpB
        AY2UlT9qvy5OskW+ZFrXK4YDeUAMcbN5C2gMpRoefpBbaxtk0etFTSEvThrltbPlQC7aA5
        yMdZ8Clk5/hWQ7XX5lnlrZRxkvBtSaWHu6W8QHw/X2aeVtUTfWdy9aPmKwwEBz7AcpoNgM
        yt3c0QsWeqNQlDJrsnvunG/Onc1JarACaZgcwhOtiE67jVJ2juI2xwXwkWHur9AWKRvRk+
        osPXKkRXclRA5yRvJfDJ87amyfe6amDTBrUEpZyFQWrHeP0+uw/vSh8NyjJ2iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mcjw3+G70ffidzFwibf8WIyWyIs0dYYGTGd8CPedFW4=;
        b=ql1bCkV9t/Q+jlBbKuWeg1ojIc5/vCU9Go0eWg11LXoF4NfMit7hJKZBVl4sx4IynupQdi
        VDUbsauuQW1M3BAg==
From:   "thermal-bot for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Protect thermal device
 operations against thermal device removal
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959741.4906.11406532013896487477.tip-bot2@tip-bot2>
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

Commit-ID:     b778b4d782d48b9a8751b21deb8eb2f054a3c772
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//b778b4d782d48b9a8751b21deb8eb2f054a3c772
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Thu, 10 Nov 2022 07:25:00 -08:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 14 Nov 2022 19:04:37 +01:00

thermal/core: Protect thermal device operations against thermal device removal

Thermal device operations may be called after thermal zone device removal.
After thermal zone device removal, thermal zone device operations must
no longer be called. To prevent such calls from happening, ensure that
the thermal device is registered before executing any thermal device
operations.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 173b049..cc7dbcb 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -203,6 +203,9 @@ int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
 	mutex_lock(&thermal_governor_lock);
 	mutex_lock(&tz->lock);
 
+	if (!device_is_registered(&tz->device))
+		goto exit;
+
 	gov = __find_governor(strim(policy));
 	if (!gov)
 		goto exit;
@@ -445,6 +448,12 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 		return ret;
 	}
 
+	if (!device_is_registered(&tz->device)) {
+		mutex_unlock(&tz->lock);
+
+		return -ENODEV;
+	}
+
 	if (tz->ops->change_mode)
 		ret = tz->ops->change_mode(tz, mode);
 
@@ -486,7 +495,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 				enum thermal_notify_event event)
 {
 	mutex_lock(&tz->lock);
-	__thermal_zone_device_update(tz, event);
+	if (device_is_registered(&tz->device))
+		__thermal_zone_device_update(tz, event);
 	mutex_unlock(&tz->lock);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
