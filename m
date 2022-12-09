Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CDD64855D
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiLIP1d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiLIP0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8933C8F089
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:40 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fjfkI6+U5L0nHIhJEr+/AY8aDV/8PiroFIK3gXe7uTI=;
        b=ieec9yeiVrG4AURNiEjsNWOQzfkCahc8TzMrmUrcShJEfUzQhOBY2EmRRDFHp9zQtUX/ms
        e9XQsmSFSAwKpPT8cDnLFy14tHQ3f0kD4UAe8cz5oXGS4L61icH6X6LVpeN0lnCyuVkjFX
        THZi5x1xGMiYMCC5sBldX2Be9cezixxTRlyYRgj2qxi8Ta/i9+Ue4aJnBXW5XX1Zj8NS7u
        x+x0bfUyfpDYqWTCE7N4Wc3QJHLUGxeXOSb1pgsSMk4ljxMzoSN8SV/MIJvA/GKM4+DnGz
        BI7SDmVdqr3X9t73TGwHBFSqsItJ6mmE1av/1Cv17BhHTh1KstWWCBcGV+iEDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fjfkI6+U5L0nHIhJEr+/AY8aDV/8PiroFIK3gXe7uTI=;
        b=JPnCkDHIk415GHar/GL4lJxBbcg3upATJF+iu27k3carJBB5nHyyx1Dl3G8nZ3yjs6/rWN
        yWAe1BbYIo1hk5DQ==
From:   "thermal-bot for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: core: fix some possible name leaks
 in error paths
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959672.4906.17420034404543985383.tip-bot2@tip-bot2>
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

Commit-ID:     4748f9687caaeefab8578285b97b2f30789fc4b4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//4748f9687caaeefab8578285b97b2f30789fc4b4
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Tue, 15 Nov 2022 17:19:45 +08:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Fri, 25 Nov 2022 19:51:41 +01:00

thermal: core: fix some possible name leaks in error paths

In some error paths before device_register(), the names allocated
by dev_set_name() are not freed. Move dev_set_name() front to
device_register(), so the name can be freed while calling
put_device().

Fixes: 1dd7128b839f ("thermal/core: Fix null pointer dereference in thermal_release()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cc7dbcb..f17ab23 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -894,10 +894,6 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->id = ret;
 	id = ret;
 
-	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
-	if (ret)
-		goto out_ida_remove;
-
 	cdev->type = kstrdup(type ? type : "", GFP_KERNEL);
 	if (!cdev->type) {
 		ret = -ENOMEM;
@@ -917,6 +913,11 @@ __thermal_cooling_device_register(struct device_node *np,
 		goto out_kfree_type;
 
 	thermal_cooling_device_setup_sysfs(cdev);
+	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
+	if (ret) {
+		thermal_cooling_device_destroy_sysfs(cdev);
+		goto out_kfree_type;
+	}
 	ret = device_register(&cdev->device);
 	if (ret)
 		goto out_kfree_type;
@@ -1250,10 +1251,6 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	tz->id = id;
 	strscpy(tz->type, type, sizeof(tz->type));
 
-	result = dev_set_name(&tz->device, "thermal_zone%d", tz->id);
-	if (result)
-		goto remove_id;
-
 	if (!ops->critical)
 		ops->critical = thermal_zone_device_critical;
 
@@ -1276,6 +1273,11 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	/* A new thermal zone needs to be updated anyway. */
 	atomic_set(&tz->need_update, 1);
 
+	result = dev_set_name(&tz->device, "thermal_zone%d", tz->id);
+	if (result) {
+		thermal_zone_destroy_device_groups(tz);
+		goto remove_id;
+	}
 	result = device_register(&tz->device);
 	if (result)
 		goto release_device;
