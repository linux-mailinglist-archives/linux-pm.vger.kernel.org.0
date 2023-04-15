Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B416E331A
	for <lists+linux-pm@lfdr.de>; Sat, 15 Apr 2023 20:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDOSYa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Apr 2023 14:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDOSY3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2023 14:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F62F1FF7
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2023 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681583025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2paejZ9FTiHh9qCuyzM6Jd7BdB0qMiCfyvw18AeYSno=;
        b=JNrN49HMcyXZurSAsYRyTZFXdDiMWslGwon0FrWZNsHC69EJsJuZh4wS+8I3gRoIQE1soa
        qr7EbeVc1qfiqlHeubAp0ezcu0tANOqlzA3BvN/Hkaw+hvUrDGZlqz0WoHB71JUFk+ezfn
        V5IYsfOMxSExws8IFP/PQdrj94+3KdQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-LZ6PJlhrMjOBorehlaWXkQ-1; Sat, 15 Apr 2023 14:23:43 -0400
X-MC-Unique: LZ6PJlhrMjOBorehlaWXkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8505800B35;
        Sat, 15 Apr 2023 18:23:42 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB7A3BC88;
        Sat, 15 Apr 2023 18:23:41 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Marek Vasut <marex@denx.de>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org
Subject: [PATCH v2 00/10] power: supply: bq27xxx/bq25890 status update fixes
Date:   Sat, 15 Apr 2023 20:23:31 +0200
Message-Id: <20230415182341.86916-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

Here is v2 if my bq* status update fixes series

Changes in v2:
- Do not use bq->charger in bq25890_external_power_changed(),
  because it may not be set yet (avoid NULL ptr deref on race)
- Add "power: supply: bq24190: Call power_supply_changed()
  after updating input current" to the series

The main goal of this series is to fix userspace sometimes not
getting notified in a timely manner of charging <-> discharging
status changes, causing e.g. battery status icons to lag
and the lagging of updates also effects power_supply_leds.c .

While working on this I noticed a number of races surrounding
bq27xxx_battery_update(), so patches 1-4 fix those first.

Patches 5-10 take care of the status update lagging issues.

Regards,

Hans


Hans de Goede (10):
  power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition
  power: supply: bq27xxx: Fix I2C IRQ race on remove
  power: supply: bq27xxx: Fix poll_interval handling and races on remove
  power: supply: bq27xxx: Add cache parameter to
    bq27xxx_battery_current_and_status()
  power: supply: bq27xxx: Move bq27xxx_battery_update() down
  power: supply: bq27xxx: Ensure power_supply_changed() is called on
    current sign changes
  power: supply: bq27xxx: After charger plug in/out wait 0.5s for things
    to stabilize
  power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() +
    schedule()
  power: supply: bq25890: Call power_supply_changed() after updating
    input current or voltage
  power: supply: bq24190: Call power_supply_changed() after updating
    input current

 drivers/power/supply/bq24190_charger.c     |   1 +
 drivers/power/supply/bq25890_charger.c     |   3 +
 drivers/power/supply/bq27xxx_battery.c     | 181 +++++++++++----------
 drivers/power/supply/bq27xxx_battery_i2c.c |   3 +-
 include/linux/power/bq27xxx_battery.h      |   4 +
 5 files changed, 108 insertions(+), 84 deletions(-)

-- 
2.39.1

