Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B636E0ABC
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 11:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjDMJzI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 05:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjDMJzG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 05:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786155FE4
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681379660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EmqmVVkKgyC3ns+K6YRmSctgxILzI5nXo/WwrxlF0Nk=;
        b=cdZQj9tdzDy5f+jIhKAFBrC+mPQRc+IozyXBasBBdU9fPQX43+/Wq8wkcp0AvK++inXf0g
        kI/b3xx0wcnZgrhLnXDTR8gn5MJuRSWixKcdt3vplxa+JmoyMBmWNGpufUEwEPWIRuaWr4
        8xFmn/U2IoBmM2MsXloj2CTQKIC16ac=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-jL1zEEQdP9WUgWJXrakgCw-1; Thu, 13 Apr 2023 05:54:15 -0400
X-MC-Unique: jL1zEEQdP9WUgWJXrakgCw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A536101A551;
        Thu, 13 Apr 2023 09:54:15 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F1DA492C13;
        Thu, 13 Apr 2023 09:54:14 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Marek Vasut <marex@denx.de>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org
Subject: [PATCH 5/9] power: supply: bq27xxx: Move bq27xxx_battery_update() down
Date:   Thu, 13 Apr 2023 11:54:01 +0200
Message-Id: <20230413095405.71685-6-hdegoede@redhat.com>
In-Reply-To: <20230413095405.71685-1-hdegoede@redhat.com>
References: <20230413095405.71685-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move the bq27xxx_battery_update() functions to below
the bq27xxx_battery_current_and_status() function.

This is just moving a block of text, no functional changes.

This is a preparation patch for making bq27xxx_battery_update() check
the status and have it call power_supply_changed() on status changes.

Fixes: 297a533b3e62 ("bq27x00: Cache battery registers")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq27xxx_battery.c | 122 ++++++++++++-------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 1115f233d959..8f2995e9850a 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1761,67 +1761,6 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 	return POWER_SUPPLY_HEALTH_GOOD;
 }
 
-static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
-{
-	struct bq27xxx_reg_cache cache = {0, };
-	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
-
-	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
-	if ((cache.flags & 0xff) == 0xff)
-		cache.flags = -1; /* read error */
-	if (cache.flags >= 0) {
-		cache.temperature = bq27xxx_battery_read_temperature(di);
-		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
-			cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
-		if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
-			cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
-		if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
-			cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
-
-		cache.charge_full = bq27xxx_battery_read_fcc(di);
-		cache.capacity = bq27xxx_battery_read_soc(di);
-		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
-			cache.energy = bq27xxx_battery_read_energy(di);
-		di->cache.flags = cache.flags;
-		cache.health = bq27xxx_battery_read_health(di);
-		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
-			cache.cycle_count = bq27xxx_battery_read_cyct(di);
-
-		/* We only have to read charge design full once */
-		if (di->charge_design_full <= 0)
-			di->charge_design_full = bq27xxx_battery_read_dcap(di);
-	}
-
-	if ((di->cache.capacity != cache.capacity) ||
-	    (di->cache.flags != cache.flags))
-		power_supply_changed(di->bat);
-
-	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
-		di->cache = cache;
-
-	di->last_update = jiffies;
-
-	if (!di->removed && poll_interval > 0)
-		mod_delayed_work(system_wq, &di->work, poll_interval * HZ);
-}
-
-void bq27xxx_battery_update(struct bq27xxx_device_info *di)
-{
-	mutex_lock(&di->lock);
-	bq27xxx_battery_update_unlocked(di);
-	mutex_unlock(&di->lock);
-}
-EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
-
-static void bq27xxx_battery_poll(struct work_struct *work)
-{
-	struct bq27xxx_device_info *di =
-			container_of(work, struct bq27xxx_device_info,
-				     work.work);
-
-	bq27xxx_battery_update(di);
-}
-
 static bool bq27xxx_battery_is_full(struct bq27xxx_device_info *di, int flags)
 {
 	if (di->opts & BQ27XXX_O_ZERO)
@@ -1895,6 +1834,67 @@ static int bq27xxx_battery_current_and_status(
 	return 0;
 }
 
+static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
+{
+	struct bq27xxx_reg_cache cache = {0, };
+	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
+
+	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
+	if ((cache.flags & 0xff) == 0xff)
+		cache.flags = -1; /* read error */
+	if (cache.flags >= 0) {
+		cache.temperature = bq27xxx_battery_read_temperature(di);
+		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
+			cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
+		if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
+			cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
+		if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
+			cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
+
+		cache.charge_full = bq27xxx_battery_read_fcc(di);
+		cache.capacity = bq27xxx_battery_read_soc(di);
+		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
+			cache.energy = bq27xxx_battery_read_energy(di);
+		di->cache.flags = cache.flags;
+		cache.health = bq27xxx_battery_read_health(di);
+		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
+			cache.cycle_count = bq27xxx_battery_read_cyct(di);
+
+		/* We only have to read charge design full once */
+		if (di->charge_design_full <= 0)
+			di->charge_design_full = bq27xxx_battery_read_dcap(di);
+	}
+
+	if ((di->cache.capacity != cache.capacity) ||
+	    (di->cache.flags != cache.flags))
+		power_supply_changed(di->bat);
+
+	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
+		di->cache = cache;
+
+	di->last_update = jiffies;
+
+	if (!di->removed && poll_interval > 0)
+		mod_delayed_work(system_wq, &di->work, poll_interval * HZ);
+}
+
+void bq27xxx_battery_update(struct bq27xxx_device_info *di)
+{
+	mutex_lock(&di->lock);
+	bq27xxx_battery_update_unlocked(di);
+	mutex_unlock(&di->lock);
+}
+EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
+
+static void bq27xxx_battery_poll(struct work_struct *work)
+{
+	struct bq27xxx_device_info *di =
+			container_of(work, struct bq27xxx_device_info,
+				     work.work);
+
+	bq27xxx_battery_update(di);
+}
+
 /*
  * Get the average power in µW
  * Return < 0 if something fails.
-- 
2.39.1

