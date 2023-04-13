Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8691D6E0B22
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 12:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjDMKLA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 06:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjDMKKf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 06:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EC77DAA
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681380587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GA5idMpd+TZgpXZrAo1IdJC9g6KsA6clhlbss96ykNE=;
        b=M4+LaxIdz0U/j9+6KcKdzSurkaq49UbRIbCaA/ITPfmYeel9xG/4rIqWpbJDXWLg1vZLYv
        yWHvJiHBkgiPY618T7Mp3mBcztAA5mYsTxJgVSZi3EFDYQ+GLAPl6ZwUxNaQ/NqDk8g4Kh
        6ntAkmXxnMVfWcfi0IpH9/SzUvSUDe4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-orXoK6u9N4CE9g7AQrGMVQ-1; Thu, 13 Apr 2023 06:09:44 -0400
X-MC-Unique: orXoK6u9N4CE9g7AQrGMVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C647185A790;
        Thu, 13 Apr 2023 10:09:43 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D90540C6E70;
        Thu, 13 Apr 2023 10:09:42 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] power: supply: leds: Fix blink to LED on transition
Date:   Thu, 13 Apr 2023 12:09:41 +0200
Message-Id: <20230413100941.115529-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When a battery's status changes from charging to full then
the charging-blink-full-solid trigger tries to change
the LED from blinking to solid/on.

As is documented in include/linux/leds.h to deactivate blinking /
to make the LED solid a LED_OFF must be send:

"""
         * Deactivate blinking again when the brightness is set to LED_OFF
         * via the brightness_set() callback.
"""

led_set_brighness() calls with a brightness value other then 0 / LED_OFF
merely change the brightness of the LED in its on state while it is
blinking.

So power_supply_update_bat_leds() must first send a LED_OFF event
before the LED_FULL to disable blinking.

Fixes: 6501f728c56f ("power_supply: Add new LED trigger charging-blink-solid-full")
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/power_supply_leds.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
index e2f554e4e4e6..c7db29d5fcb8 100644
--- a/drivers/power/supply/power_supply_leds.c
+++ b/drivers/power/supply/power_supply_leds.c
@@ -33,8 +33,9 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 		led_trigger_event(psy->charging_full_trig, LED_FULL);
 		led_trigger_event(psy->charging_trig, LED_OFF);
 		led_trigger_event(psy->full_trig, LED_FULL);
-		led_trigger_event(psy->charging_blink_full_solid_trig,
-			LED_FULL);
+		/* Going from blink to LED on requires a LED_OFF event to stop blink */
+		led_trigger_event(psy->charging_blink_full_solid_trig, LED_OFF);
+		led_trigger_event(psy->charging_blink_full_solid_trig, LED_FULL);
 		break;
 	case POWER_SUPPLY_STATUS_CHARGING:
 		led_trigger_event(psy->charging_full_trig, LED_FULL);
-- 
2.39.1

