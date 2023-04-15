Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28306E3246
	for <lists+linux-pm@lfdr.de>; Sat, 15 Apr 2023 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDOQI3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Apr 2023 12:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjDOQI1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2023 12:08:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBD23A8E
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2023 09:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681574859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DBiA8bmNsq1t6pa+0JaZ8Jv6rXaTlipvSnwUYpjwyHk=;
        b=JgzTHW992zTSWex+0gtPl426QkPgy+wy+fRR3jfkOvOmnGiKewFj526D5zXBShe5Fu3clV
        NCvwQIB+BLhuoiBJzV3hse3MH+VJEKQyugoeyeRxgdQpUAWh4SBnfmaIhpef61jZaBJYpr
        DxdY7+7ICh1Fl8Yyc4TL5P84sWKQbvA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-Qkdc39KpOCiNACcMgJeYoA-1; Sat, 15 Apr 2023 12:07:35 -0400
X-MC-Unique: Qkdc39KpOCiNACcMgJeYoA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7312885A588;
        Sat, 15 Apr 2023 16:07:35 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCDE52166B26;
        Sat, 15 Apr 2023 16:07:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org
Subject: [PATCH 0/6] power: supply: Fix external_power_changed race in several drivers
Date:   Sat, 15 Apr 2023 18:07:28 +0200
Message-Id: <20230415160734.70475-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

I hit this issue where a Lenovo Yoga Book yb1-x90f would hang on boot
every couple of boots.

The problem was that bq25890_charger_external_power_changed() dereferences
bq->charger, which gets sets in bq25890_power_supply_init() like this:
    
  bq->charger = devm_power_supply_register(bq->dev, &bq->desc, &psy_cfg);
    
As soon as devm_power_supply_register() has called device_add()
the external_power_changed callback can get called. So there is a window
where bq25890_charger_external_power_changed() may get called while
bq->charger has not been set yet leading to a NULL pointer dereference.

This race hits on the yb1-x90f when the cht_wcove_pwrsrc (extcon) psy is
done with detecting the charger, which happens to exactly hit the window:

      BUG: kernel NULL pointer dereference, address: 0000000000000018
      <snip>
      RIP: 0010:__power_supply_is_supplied_by+0xb/0xb0
      <snip>
      Call Trace:
       <TASK>
       __power_supply_get_supplier_property+0x19/0x50
       class_for_each_device+0xb1/0xe0
       power_supply_get_property_from_supplier+0x2e/0x50
       bq25890_charger_external_power_changed+0x38/0x1b0 [bq25890_charger]
       __power_supply_changed_work+0x30/0x40
       class_for_each_device+0xb1/0xe0
       power_supply_changed_work+0x5f/0xe0
      <snip>

This series fixes this issue in the bq25890 + 3 other drivers with
the same issue. Patches 5-6 are small cleanup patches for 2 other
drivers which I audited for the same issue.

Regards,

Hans


Hans de Goede (6):
  power: supply: ab8500: Fix external_power_changed race
  power: supply: axp288_fuel_gauge: Fix external_power_changed race
  power: supply: bq25890: Fix external_power_changed race
  power: supply: sc27xx: Fix external_power_changed race
  power: supply: max17042_battery: Refactor
    max17042_external_power_changed()
  power: supply: twl4030_madc_battery: Refactor
    twl4030_madc_bat_ext_changed()

 drivers/power/supply/ab8500_btemp.c         | 6 ++----
 drivers/power/supply/ab8500_fg.c            | 6 ++----
 drivers/power/supply/axp288_fuel_gauge.c    | 2 +-
 drivers/power/supply/bq25890_charger.c      | 2 +-
 drivers/power/supply/max17042_battery.c     | 7 +------
 drivers/power/supply/sc27xx_fuel_gauge.c    | 9 +--------
 drivers/power/supply/twl4030_madc_battery.c | 8 +-------
 7 files changed, 9 insertions(+), 31 deletions(-)

-- 
2.39.1

