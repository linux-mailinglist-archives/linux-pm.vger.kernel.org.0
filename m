Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384A26E0AB8
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 11:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDMJy6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 05:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDMJy5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 05:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7864859C6
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681379655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06RTC2b5HppJPVJNkv6NlbtDAm2dm/J+xC+Tp+c7PZs=;
        b=DsdKDsuSQnZsdCxY69fQ+qsYRYlYBl2E1FxjCecZq/G5WsFsNa5axirBn73vdHWxJ5WTqi
        4SFkSIZft2D1e9+rylv/QUPpXnZf0lhxjV+Eazkl7QAWOternvOv9sTR65yPdF6p8qw/JQ
        bb8Yr3M9TB0sow2ABzGtjKFFqtR1NTs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-wpriT7xpOVOewGJ8QCYRKw-1; Thu, 13 Apr 2023 05:54:12 -0400
X-MC-Unique: wpriT7xpOVOewGJ8QCYRKw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07C7C1C0879F;
        Thu, 13 Apr 2023 09:54:12 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30013492C13;
        Thu, 13 Apr 2023 09:54:11 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Marek Vasut <marex@denx.de>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org
Subject: [PATCH 3/9] power: supply: bq27xxx: Fix poll_interval handling and races on remove
Date:   Thu, 13 Apr 2023 11:53:59 +0200
Message-Id: <20230413095405.71685-4-hdegoede@redhat.com>
In-Reply-To: <20230413095405.71685-1-hdegoede@redhat.com>
References: <20230413095405.71685-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Before this patch bq27xxx_battery_teardown() was setting poll_interval = 0
to avoid bq27xxx_battery_update() requeuing the delayed_work item.

There are 2 problems with this:

1. If the driver is unbound through sysfs, rather then the module being
   rmmod-ed, this changes poll_interval unexpectedly

2. This is racy, after it being set poll_interval could be changed
   before bq27xxx_battery_update() checks it through
   /sys/module/bq27xxx_battery/parameters/poll_interval

Fix this by added a removed attribute to struct bq27xxx_device_info and
using that instead of setting poll_interval to 0.

There also is another poll_interval related race on remove(), writing
/sys/module/bq27xxx_battery/parameters/poll_interval will requeue
the delayed_work item for all devices on the bq27xxx_battery_devices
list and the device being removed was only removed from that list
after cancelling the delayed_work item.

Fix this by moving the removal from the bq27xxx_battery_devices list
to before cancelling the delayed_work item.

Fixes: 8cfaaa811894 ("bq27x00_battery: Fix OOPS caused by unregistring bq27x00 driver")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq27xxx_battery.c | 22 +++++++++-------------
 include/linux/power/bq27xxx_battery.h  |  1 +
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 79aedf83cc8d..7411f1cf741b 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1801,7 +1801,7 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 
 	di->last_update = jiffies;
 
-	if (poll_interval > 0)
+	if (!di->removed && poll_interval > 0)
 		mod_delayed_work(system_wq, &di->work, poll_interval * HZ);
 }
 
@@ -2132,22 +2132,18 @@ EXPORT_SYMBOL_GPL(bq27xxx_battery_setup);
 
 void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 {
-	/*
-	 * power_supply_unregister call bq27xxx_battery_get_property which
-	 * call bq27xxx_battery_poll.
-	 * Make sure that bq27xxx_battery_poll will not call
-	 * schedule_delayed_work again after unregister (which cause OOPS).
-	 */
-	poll_interval = 0;
-
-	cancel_delayed_work_sync(&di->work);
-
-	power_supply_unregister(di->bat);
-
 	mutex_lock(&bq27xxx_list_lock);
 	list_del(&di->list);
 	mutex_unlock(&bq27xxx_list_lock);
 
+	/* Set removed to avoid bq27xxx_battery_update() re-queuing the work */
+	mutex_lock(&di->lock);
+	di->removed = true;
+	mutex_unlock(&di->lock);
+
+	cancel_delayed_work_sync(&di->work);
+
+	power_supply_unregister(di->bat);
 	mutex_destroy(&di->lock);
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index a1aa68141d0b..e3322dad9c85 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -68,6 +68,7 @@ struct bq27xxx_device_info {
 	struct bq27xxx_access_methods bus;
 	struct bq27xxx_reg_cache cache;
 	int charge_design_full;
+	bool removed;
 	unsigned long last_update;
 	struct delayed_work work;
 	struct power_supply *bat;
-- 
2.39.1

