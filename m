Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D075630ED97
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 08:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhBDHla (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 02:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbhBDHl1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 02:41:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590FBC0613D6
        for <linux-pm@vger.kernel.org>; Wed,  3 Feb 2021 23:40:47 -0800 (PST)
Date:   Thu, 04 Feb 2021 07:40:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612424445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CArLlvBHilk+zsvJN01PGWTU2LdI0ISGbaAOrzgbQ/g=;
        b=x7uvqlJFhvoP2f5zwKzqofoJ3vvpTqH8QByPqHdNq+1YObNMQd5Ha0Wlqbwt9cCVWuWalZ
        o+G6cvRJSzTS6TpVNDscECKxe6w0W94b5rfPq8DSY2O6siaaf12GlyHhpnWpk9xb/yM9KH
        DfVJzbc5mbOKq4LSHDa9LCqr5s8BKi31BTAiKI55gRJBDFUMrEAWVvANGl73vy0qOhXzdy
        8iTUBGQbKjyuKbY6mSRNxHe5CSHpO0x+It7mgYqf6nOxBTUrwFdJmAtF2eu4HW67LeQAtD
        oiZj6zbS0BVigIuBxOSaw5sI+tN4FcWP0l8ggYB8YaPzcW84CNMzvZgwRoVCmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612424445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CArLlvBHilk+zsvJN01PGWTU2LdI0ISGbaAOrzgbQ/g=;
        b=lwykZnvk9rEuyeiEmw60Cnxsy0/+tpz4RLPBnktjEErokCXHnxG3rq3jOHWY1xwIjY0CHW
        e2c4+g2SXr1SkbCw==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: power allocator: fail binding for
 non-power actor devices
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210119114126.19480-1-lukasz.luba@arm.com>
References: <20210119114126.19480-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <161242444480.23325.11302648327159355536.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     7a583405f24bffdd9f696a8e1b2f02c297245f4d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//7a583405f24bffdd9f696a8e1b2f02c297245f4d
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Tue, 19 Jan 2021 11:41:26 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 19 Jan 2021 22:31:10 +01:00

thermal: power allocator: fail binding for non-power actor devices

The thermal zone can have cooling devices which are missing power actor
API. This could be due to missing Energy Model for devfreq or cpufreq
cooling device. In this case it is safe to fail the binding rather than
trying to workaround and control the temperature in such thermal zone.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210119114126.19480-1-lukasz.luba@arm.com
---
 drivers/thermal/gov_power_allocator.c | 35 +++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index f8c3d1e..92acae5 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -590,13 +590,42 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
 }
 
 /**
+ * check_power_actors() - Check all cooling devices and warn when they are
+ *			not power actors
+ * @tz:		thermal zone to operate on
+ *
+ * Check all cooling devices in the @tz and warn every time they are missing
+ * power actor API. The warning should help to investigate the issue, which
+ * could be e.g. lack of Energy Model for a given device.
+ *
+ * Return: 0 on success, -EINVAL if any cooling device does not implement
+ * the power actor API.
+ */
+static int check_power_actors(struct thermal_zone_device *tz)
+{
+	struct thermal_instance *instance;
+	int ret = 0;
+
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		if (!cdev_is_power_actor(instance->cdev)) {
+			dev_warn(&tz->device, "power_allocator: %s is not a power actor\n",
+				 instance->cdev->type);
+			ret = -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+/**
  * power_allocator_bind() - bind the power_allocator governor to a thermal zone
  * @tz:	thermal zone to bind it to
  *
  * Initialize the PID controller parameters and bind it to the thermal
  * zone.
  *
- * Return: 0 on success, or -ENOMEM if we ran out of memory.
+ * Return: 0 on success, or -ENOMEM if we ran out of memory, or -EINVAL
+ * when there are unsupported cooling devices in the @tz.
  */
 static int power_allocator_bind(struct thermal_zone_device *tz)
 {
@@ -604,6 +633,10 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	struct power_allocator_params *params;
 	int control_temp;
 
+	ret = check_power_actors(tz);
+	if (ret)
+		return ret;
+
 	params = kzalloc(sizeof(*params), GFP_KERNEL);
 	if (!params)
 		return -ENOMEM;
