Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8C6E0AB5
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 11:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjDMJyy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 05:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDMJyx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 05:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A22F4EE8
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 02:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681379650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CeYAJ9s9GJgcTfD/js1rcHupsVP7TgTk3gJ1hyh07+Q=;
        b=iGZuMi5Y0s33+SEOOncDYNovQRNNVFOu2xHPZaVHIXmi/YzMSHpLhj1fbf8dxLqrd41qz3
        9yjVBhevaMwJnrLLe+ZHd0bIGawG0HFL7XKkCvjYiMzlU46m+xHJL31hAaXg5qyvpOWDdP
        vRgFBkVA7GpWAN5TTXpKOINaYp/0a7Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-uvxR_gGYOcOtd02oc2KBlg-1; Thu, 13 Apr 2023 05:54:07 -0400
X-MC-Unique: uvxR_gGYOcOtd02oc2KBlg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 516FE101A531;
        Thu, 13 Apr 2023 09:54:07 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F788492C13;
        Thu, 13 Apr 2023 09:54:06 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Marek Vasut <marex@denx.de>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org
Subject: [PATCH 0/9] power: supply: bq27xxx/bq25890 status update fixes
Date:   Thu, 13 Apr 2023 11:53:56 +0200
Message-Id: <20230413095405.71685-1-hdegoede@redhat.com>
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

Hi all,

The main goal of this series is to fix userspace sometimes not
getting notified in a timely manner of charging <-> discharging
status changes, causing e.g. battery status icons to lag
and the lagging of updates also effects power_supply_leds.c .

While working on this I noticed a number of races surrounding
bq27xxx_battery_update(), so patches 1-4 fix those first.

Patches 5-9 take care of the status update lagging issues.

Regards,

Hans


Hans de Goede (9):
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

 drivers/power/supply/bq25890_charger.c     |   3 +
 drivers/power/supply/bq27xxx_battery.c     | 181 +++++++++++----------
 drivers/power/supply/bq27xxx_battery_i2c.c |   3 +-
 include/linux/power/bq27xxx_battery.h      |   4 +
 4 files changed, 107 insertions(+), 84 deletions(-)

-- 
2.39.1

