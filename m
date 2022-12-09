Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2C564856A
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiLIP1q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiLIP0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8927F8AAFC
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:41 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WzRsUlY3GoYMjE3D9qV32LWFPFozY1KVqEmfnqQHBHM=;
        b=NtcjEzl+pk950yRqPxVLZZKQrsN/XJr2IqBzzTAqvuxp8i2SZz+G20jy9y6pioFkdQRfeu
        K170AAfWo9v4P6ljCYJOpfqlkyHjq1D6ALn8p3C1xizvz0wNdttjJUpE9oFkiGVtkwGEU4
        jyXmKyKjCGKsoDYRde9yQmdhWTj58UvSiAeeDkMyzzcqJSqw5ouyLVdBg57QZzgwTTGTV2
        7g3JpmoGukdTjHhrhNzOzYRUDTSdcq4gSETFGEUPbamvvDh0xBJVuwmlLm5Mk0Heg+LVma
        HJk6OpOGPtI/cxCJrCemhPU9mRIFSXvzwyeyuJByT99Covadi4amufr+1aLzSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WzRsUlY3GoYMjE3D9qV32LWFPFozY1KVqEmfnqQHBHM=;
        b=1mntX4MxTWZmK1bin5leQ8U4I+CwbG4fRx0kD7Q1Dw4alirR9N7uN3MBKb7xBxnZZPik7S
        6gauvp32qJfR46AQ==
From:   "thermal-bot for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Protect hwmon accesses to
 thermal operations with thermal zone mutex
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959795.4906.13706670571193287868.tip-bot2@tip-bot2>
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

Commit-ID:     ea37bec51ff442546e4a57d5cca2de9cc64a9df3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ea37bec51ff442546e4a57d5cca2de9cc64a9df3
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Thu, 10 Nov 2022 07:24:57 -08:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 14 Nov 2022 19:04:37 +01:00

thermal/core: Protect hwmon accesses to thermal operations with thermal zone mutex

In preparation to protecting access to thermal operations against thermal
zone device removal, protect hwmon accesses to thermal zone operations
with the thermal zone mutex. After acquiring the mutex, ensure that the
thermal zone device is registered before proceeding.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_hwmon.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index f53f4ce..c594c42 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -77,7 +77,15 @@ temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int temperature;
 	int ret;
 
-	ret = tz->ops->get_crit_temp(tz, &temperature);
+	mutex_lock(&tz->lock);
+
+	if (device_is_registered(&tz->device))
+		ret = tz->ops->get_crit_temp(tz, &temperature);
+	else
+		ret = -ENODEV;
+
+	mutex_unlock(&tz->lock);
+
 	if (ret)
 		return ret;
 
