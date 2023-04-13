Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990936E0AB9
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 11:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDMJzE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 05:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjDMJzA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 05:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE04859C3
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 02:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681379653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kAUjCOt6/1YhkCPGy/XqBtbFZ68SM6dnChJzq4cDP0U=;
        b=SjIAJo19Tb/AKENMGEdabmR6+sbo7dr9Uvec8grtFVQHImcmo1W4xJEKDI44GCWj9g8PcP
        ZDptGEBeBPIUDeZRpQbg9Bjht9ktwjGrZ0JAVKPH6wPEfjgVk2tqPqytO5lt5KYyDPV5KN
        pXcgxkeuXDhpi3AHlVGdsRZOV1Y29bQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-LBNmk9foNAG-wYNddFkZqQ-1; Thu, 13 Apr 2023 05:54:09 -0400
X-MC-Unique: LBNmk9foNAG-wYNddFkZqQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEFC685A5A3;
        Thu, 13 Apr 2023 09:54:08 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 812F8492C13;
        Thu, 13 Apr 2023 09:54:07 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Marek Vasut <marex@denx.de>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org
Subject: [PATCH 1/9] power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition
Date:   Thu, 13 Apr 2023 11:53:57 +0200
Message-Id: <20230413095405.71685-2-hdegoede@redhat.com>
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

bq27xxx_battery_update() assumes / requires that it is only run once,
not multiple times at the same time. But there are 3 possible callers:

1. bq27xxx_battery_poll() delayed_work item handler
2. bq27xxx_battery_irq_handler_thread() I2C IRQ handler
3. bq27xxx_battery_setup()

And there is no protection against these racing with each other,
fix this race condition by making all callers take di->lock:

- Rename bq27xxx_battery_update() to bq27xxx_battery_update_unlocked()

- Add new bq27xxx_battery_update() which takes di->lock and then calls
  bq27xxx_battery_update_unlocked()

- Make stale cache check code in bq27xxx_battery_get_property(), which
  already takes di->lock directly to check the jiffies, call
  bq27xxx_battery_update_unlocked() instead of messing with
  the delayed_work item

- Make bq27xxx_battery_update_unlocked() mod the delayed-work item
  so that the next poll is delayed to poll_interval milliseconds after
  the last update independent of the source of the update

Fixes: 740b755a3b34 ("bq27x00: Poll battery state")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq27xxx_battery.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 5ff6f44fd47b..79aedf83cc8d 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1761,7 +1761,7 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 	return POWER_SUPPLY_HEALTH_GOOD;
 }
 
-void bq27xxx_battery_update(struct bq27xxx_device_info *di)
+static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 {
 	struct bq27xxx_reg_cache cache = {0, };
 	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
@@ -1800,6 +1800,16 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 		di->cache = cache;
 
 	di->last_update = jiffies;
+
+	if (poll_interval > 0)
+		mod_delayed_work(system_wq, &di->work, poll_interval * HZ);
+}
+
+void bq27xxx_battery_update(struct bq27xxx_device_info *di)
+{
+	mutex_lock(&di->lock);
+	bq27xxx_battery_update_unlocked(di);
+	mutex_unlock(&di->lock);
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
 
@@ -1810,9 +1820,6 @@ static void bq27xxx_battery_poll(struct work_struct *work)
 				     work.work);
 
 	bq27xxx_battery_update(di);
-
-	if (poll_interval > 0)
-		schedule_delayed_work(&di->work, poll_interval * HZ);
 }
 
 static bool bq27xxx_battery_is_full(struct bq27xxx_device_info *di, int flags)
@@ -1985,10 +1992,8 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
 
 	mutex_lock(&di->lock);
-	if (time_is_before_jiffies(di->last_update + 5 * HZ)) {
-		cancel_delayed_work_sync(&di->work);
-		bq27xxx_battery_poll(&di->work.work);
-	}
+	if (time_is_before_jiffies(di->last_update + 5 * HZ))
+		bq27xxx_battery_update_unlocked(di);
 	mutex_unlock(&di->lock);
 
 	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
-- 
2.39.1

