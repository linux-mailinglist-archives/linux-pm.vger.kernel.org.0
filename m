Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30E9648572
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLIP1w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiLIP0t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E36A8F0AE
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:41 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+KhKRF0mXMYZnesJMZZnXrK8jyczBWJM1pPh3LEYKPA=;
        b=TeNeeDfbESaqmpe5eoJZZjctMPCqmE4xE0txGiP8r7NOCu2Q4VQjup0Z80jOQliH9R/5/V
        cKRtbaNVRFsZ1UtXQaxBO7j2mWvj5IY/GJ69rW4lQ2wDWXMm9CgkVF7Li6BMBgE9SKREix
        +32BIsDWfKeNM17pzJdtxNXArhaJCTbcPEpNSlkV/q+XeQ2q9oS7puo3pSlo4OUVy45tam
        WOTwX4e7YeDoetGiHBU1G4vlq6bG45BjBwTZDBCzJJwEDWoHb3VMPDFcn5VhHBGlSC5QYX
        ytT/7spNE82DT/cLSfiB2AyG8Ibu/QWVSY3RXQKneutLn4p3I0/d44S8h5UmYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+KhKRF0mXMYZnesJMZZnXrK8jyczBWJM1pPh3LEYKPA=;
        b=m5g7ysbvuYTUNYac7NwOXYiJOS3dRsZlFxK9U4pU2fIL3WtwfNqdpvJTTTwHHgTnABBOW5
        2K8yF7JQyg8P7uAg==
From:   "thermal-bot for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Delete device under thermal
 device zone lock
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959868.4906.12329659841412199047.tip-bot2@tip-bot2>
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

Commit-ID:     30b2ae07d3d60a4f9763b08a1f696b789e777337
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//30b2ae07d3d60a4f9763b08a1f696b789e777337
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Thu, 10 Nov 2022 07:24:53 -08:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 14 Nov 2022 19:04:37 +01:00

thermal/core: Delete device under thermal device zone lock

Thermal device attributes may still be opened after unregistering
the thermal zone and deleting the thermal device.

Currently there is no protection against accessing thermal device
operations after unregistering a thermal zone. To enable adding
such protection, protect the device delete operation with the
thermal zone device mutex. This requires splitting the call to
device_unregister() into its components, device_del() and put_device().
Only the first call can be executed under mutex protection, since
put_device() may result in releasing the thermal zone device memory.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b31d324..5d19dc6 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1391,7 +1391,12 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
-	device_unregister(&tz->device);
+
+	mutex_lock(&tz->lock);
+	device_del(&tz->device);
+	mutex_unlock(&tz->lock);
+
+	put_device(&tz->device);
 
 	thermal_notify_tz_delete(tz_id);
 }
