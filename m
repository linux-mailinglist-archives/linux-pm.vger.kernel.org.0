Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6294764856C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiLIP1t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiLIP0s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6029232E
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:41 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qDZHZ+79q+oGET6R8sLKec9GgkM6O9aboKpJ6jGJemo=;
        b=E+d4UxVKSVsY8RaGQSAY/joFu+LX9vgwp7DeqGeQKj+UJLz6AXfh/J52hMdNvTmSKgJMfV
        LuNT0cmC5GRFlVXkAMa0q+itkqRLI8kcPoHm1t516mWXH3zdtb/yBGAVXWLP9hDOB1yYDU
        XENxEsmWcPs4XQCym6slIgnd/diUB5VFxQRaJsZFNMg3ls8JgFCniZZokZAE1v856lWAm7
        GkcTFpflm/x8CVwqoQ/ixf/LxZJfFH3baGMhQyruhMWJvc1PLtaJYYOJjpa9QycF3TV8ds
        SY4joPuUtuxol4TA86CvDhqmvUg8N9PlSObJ9AyF706ml6i3Pqg9RMYfQ9/8hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qDZHZ+79q+oGET6R8sLKec9GgkM6O9aboKpJ6jGJemo=;
        b=ikkaBEGA1mw9QCRzf5YoOOl0BRLHZFiKOBBb6geJy7FBW/KaX2w3qx8OE1QGQEZ37YfTwV
        h7PVUyVwOjIaD0BA==
From:   "thermal-bot for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Destroy thermal zone device
 mutex in release function
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959889.4906.17504155884396642778.tip-bot2@tip-bot2>
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

Commit-ID:     d35f29ed9d11ccc4f9b957871d14726f4451a4ad
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d35f29ed9d11ccc4f9b957871d14726f4451a4ad
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Thu, 10 Nov 2022 07:24:52 -08:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 14 Nov 2022 19:04:37 +01:00

thermal/core: Destroy thermal zone device mutex in release function

Accesses to thermal zones, and with it the thermal zone device mutex,
are still possible after the thermal zone device has been unregistered.
For example, thermal_zone_get_temp() can be called from temp_show()
in thermal_sysfs.c if the sysfs attribute was opened before the thermal
device was unregistered.

Move the call to mutex_destroy from thermal_zone_device_unregister()
to thermal_release() to ensure that it is only destroyed after it is
guaranteed to be no longer accessed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index e0ca631..b31d324 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -754,6 +754,7 @@ static void thermal_release(struct device *dev)
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
+		mutex_destroy(&tz->lock);
 		kfree(tz);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
 			    sizeof("cooling_device") - 1)) {
@@ -1390,7 +1391,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
-	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
 
 	thermal_notify_tz_delete(tz_id);
