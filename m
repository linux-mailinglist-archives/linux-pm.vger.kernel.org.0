Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE346E0ABE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 11:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjDMJzJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 05:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjDMJzG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 05:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE865FEA
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681379661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1RNFAKZwRZKzpVC/9sYhPfhe1lzjvgHQBmhnXgWq2U=;
        b=MZNOBB7Od+92b16xvxbZvlB9DmiquijR7R4yoEHp3uVyEMw1n8MxLgG5eSutLa/v3lSe+o
        PSivpHjDh81JLlNC/K/QjndxjhawI7YrTYkrY/2L27zewylZyEdfWculPJSCozY7Qe1p1Z
        5myZWThvqEJEctROjw2ykSM/kEfHXJk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-MLxF-u2DOoiAMoLGmYjPGQ-1; Thu, 13 Apr 2023 05:54:16 -0400
X-MC-Unique: MLxF-u2DOoiAMoLGmYjPGQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24F7C101A531;
        Thu, 13 Apr 2023 09:54:16 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BD7E492C13;
        Thu, 13 Apr 2023 09:54:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Marek Vasut <marex@denx.de>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org
Subject: [PATCH 6/9] power: supply: bq27xxx: Ensure power_supply_changed() is called on current sign changes
Date:   Thu, 13 Apr 2023 11:54:02 +0200
Message-Id: <20230413095405.71685-7-hdegoede@redhat.com>
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

On gauges where the current register is signed, there is no charging
flag in the flags register. So only checking flags will not result
in power_supply_changed() getting called when e.g. a charger is plugged
in and the current sign changes from negative (discharging) to
positive (charging).

This causes userspace's notion of the status to lag until userspace
does a poll.

And when a power_supply_leds.c LED trigger is used to indicate charging
status with a LED, this LED will lag until the capacity percentage
changes, which may take many minutes (because the LED trigger only is
updated on power_supply_changed() calls).

Fix this by calling bq27xxx_battery_current_and_status() on gauges with
a signed current register and checking if the status has changed.

Fixes: 297a533b3e62 ("bq27x00: Cache battery registers")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq27xxx_battery.c | 13 ++++++++++++-
 include/linux/power/bq27xxx_battery.h  |  3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 8f2995e9850a..f98b51ce19b5 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1836,6 +1836,7 @@ static int bq27xxx_battery_current_and_status(
 
 static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 {
+	union power_supply_propval status = di->last_status;
 	struct bq27xxx_reg_cache cache = {0, };
 	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
 
@@ -1860,14 +1861,24 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
 			cache.cycle_count = bq27xxx_battery_read_cyct(di);
 
+		/*
+		 * On gauges with signed current reporting the current must be
+		 * checked to detect charging <-> discharging status changes.
+		 */
+		if (!(di->opts & BQ27XXX_O_ZERO))
+			bq27xxx_battery_current_and_status(di, NULL, &status, &cache);
+
 		/* We only have to read charge design full once */
 		if (di->charge_design_full <= 0)
 			di->charge_design_full = bq27xxx_battery_read_dcap(di);
 	}
 
 	if ((di->cache.capacity != cache.capacity) ||
-	    (di->cache.flags != cache.flags))
+	    (di->cache.flags != cache.flags) ||
+	    (di->last_status.intval != status.intval)) {
+		di->last_status.intval = status.intval;
 		power_supply_changed(di->bat);
+	}
 
 	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
 		di->cache = cache;
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index e3322dad9c85..7c8d65414a70 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_BQ27X00_BATTERY_H__
 #define __LINUX_BQ27X00_BATTERY_H__
 
+#include <linux/power_supply.h>
+
 enum bq27xxx_chip {
 	BQ27000 = 1, /* bq27000, bq27200 */
 	BQ27010, /* bq27010, bq27210 */
@@ -70,6 +72,7 @@ struct bq27xxx_device_info {
 	int charge_design_full;
 	bool removed;
 	unsigned long last_update;
+	union power_supply_propval last_status;
 	struct delayed_work work;
 	struct power_supply *bat;
 	struct list_head list;
-- 
2.39.1

