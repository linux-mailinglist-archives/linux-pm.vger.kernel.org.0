Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B300036CBDF
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbhD0TpL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbhD0TpL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A17AC061574
        for <linux-pm@vger.kernel.org>; Tue, 27 Apr 2021 12:44:27 -0700 (PDT)
Date:   Tue, 27 Apr 2021 19:44:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552665;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8zY11GOUWWmYoMsPwq9gCdyc6RGlBM8QFeqyEQ3uk8U=;
        b=gJpCassF+10pNdOm7xZ4deUtxJDi0uOS8W5UW4I607r1jreD3n5Z35whJzgK2+ld8aNHny
        Oih6TvjIZQJPA4eNpAsxJfdRJuql4fnqq5cAyiA9dW7k6tqMBpqAY6MQ4vmm2C3r7bAwwb
        vzarwRdem2fpK82omjMGpLxJY14dUPVsqYJw6yOsSudpbHnGmdp/zITDzwRUzBu0vmuOQ2
        dJKoS4Ht/ki6mA89kOcwy7yD+tA19iSnq+QslkL8/Q/azzBg5bt5S2/OWqOxH+sbOuZ4gC
        upKsgl/8y+pOrrDYEXL4ZZHJRYgW6Zu5XInHgu3RXNVdFIK691JxTq1LRDD5Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552665;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8zY11GOUWWmYoMsPwq9gCdyc6RGlBM8QFeqyEQ3uk8U=;
        b=5p/mo44UcY/8q1KzY86chgrvLFEvAgud9YQFJ9jQg+i4UOfpj9hup6Yg1fXOzCCnG8QBTg
        GVGzU/IS1F1bixCA==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Create a helper
 __thermal_cdev_update() without a lock
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20210422114308.29684-2-lukasz.luba@arm.com>
References: <20210422114308.29684-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <161955266517.29796.16631543427209031231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     b70dbf40eb075c596d86c42d93b86ff502290fc5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//b70dbf40eb075c596d86c42d93b86ff502290fc5
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Thu, 22 Apr 2021 12:43:06 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 22 Apr 2021 14:10:28 +02:00

thermal/core: Create a helper __thermal_cdev_update() without a lock

There is a need to have a helper function which updates cooling device
state from the governors code. With this change governor can use
lock and unlock while calling helper function. This avoid unnecessary
second time lock/unlock which was in previous solution present in
governor implementation. This new helper function must be called
with mutex 'cdev->lock' hold.

The changed been discussed and part of code presented in thread:
https://lore.kernel.org/linux-pm/20210419084536.25000-1-lukasz.luba@arm.com/

Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20210422114308.29684-2-lukasz.luba@arm.com
---
 drivers/thermal/thermal_core.h    |  1 +
 drivers/thermal/thermal_helpers.c | 27 +++++++++++++++++----------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 86b8cef..726e327 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -66,6 +66,7 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 }
 
 void thermal_cdev_update(struct thermal_cooling_device *);
+void __thermal_cdev_update(struct thermal_cooling_device *cdev);
 
 /**
  * struct thermal_trip - representation of a point in temperature domain
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 7f50f41..3edd047 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -192,18 +192,11 @@ static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
 	thermal_cooling_device_stats_update(cdev, target);
 }
 
-void thermal_cdev_update(struct thermal_cooling_device *cdev)
+void __thermal_cdev_update(struct thermal_cooling_device *cdev)
 {
 	struct thermal_instance *instance;
 	unsigned long target = 0;
 
-	mutex_lock(&cdev->lock);
-	/* cooling device is updated*/
-	if (cdev->updated) {
-		mutex_unlock(&cdev->lock);
-		return;
-	}
-
 	/* Make sure cdev enters the deepest cooling state */
 	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
 		dev_dbg(&cdev->device, "zone%d->target=%lu\n",
@@ -216,11 +209,25 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 
 	thermal_cdev_set_cur_state(cdev, target);
 
-	cdev->updated = true;
-	mutex_unlock(&cdev->lock);
 	trace_cdev_update(cdev, target);
 	dev_dbg(&cdev->device, "set to state %lu\n", target);
 }
+
+/**
+ * thermal_cdev_update - update cooling device state if needed
+ * @cdev:	pointer to struct thermal_cooling_device
+ *
+ * Update the cooling device state if there is a need.
+ */
+void thermal_cdev_update(struct thermal_cooling_device *cdev)
+{
+	mutex_lock(&cdev->lock);
+	if (!cdev->updated) {
+		__thermal_cdev_update(cdev);
+		cdev->updated = true;
+	}
+	mutex_unlock(&cdev->lock);
+}
 EXPORT_SYMBOL(thermal_cdev_update);
 
 /**
