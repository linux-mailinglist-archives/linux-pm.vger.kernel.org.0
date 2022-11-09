Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BBF623662
	for <lists+linux-pm@lfdr.de>; Wed,  9 Nov 2022 23:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKIWP2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Nov 2022 17:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKIWP0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2022 17:15:26 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06A62EF3A
        for <linux-pm@vger.kernel.org>; Wed,  9 Nov 2022 14:15:24 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 985EF85010;
        Wed,  9 Nov 2022 23:15:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1668032122;
        bh=/9BQkYMXI1gK7muUGPn2LT4qVR56QvjNHZ0qoVar4PA=;
        h=From:To:Cc:Subject:Date:From;
        b=PV/QiJTFTWIu5iNFRP6PRhR/oaNskQgrmCY6o1lml/qa+yrfMkbP//HGeVOX//5EX
         9h1yN3IYL/ik2AvhnrFpVmNRe4i4bC0HXR8XSmrApHrXqWNICOJIuUzQcwCBeZmFqT
         19NxMwevZ3x/kDOepSkh36+FppEs+ibu5rY8N1XyX7iXHcMPKSg5R430Q4s2TsOV+Y
         qRcYYBTIC1qtm0n9+C2DfrTjWGOEuYNKxaEm61cEK5WVHx+pW1SQ8rmK4g2rA0UhtV
         RVFu3EIjOKVj2ZUgKO2buKYJoZuwRTliR+u1gCJxDCA5yaBK7yHYWgVYhL+0O6ci1B
         YyVDb+S4J5cQQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/2] power: supply: bq25890: Factor out chip state update
Date:   Wed,  9 Nov 2022 23:15:03 +0100
Message-Id: <20221109221504.79562-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Pull the chip state and ADC conversion update functionality out into
separate function, so it can be reused elsewhere in the driver. This
is a preparatory patch, no functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/bq25890_charger.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index f0362dcb935e9..676eb66374e01 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -454,20 +454,18 @@ static int bq25890_get_vbus_voltage(struct bq25890_device *bq)
 	return bq25890_find_val(ret, TBL_VBUSV);
 }
 
-static int bq25890_power_supply_get_property(struct power_supply *psy,
-					     enum power_supply_property psp,
-					     union power_supply_propval *val)
+static void bq25890_update_state(struct bq25890_device *bq,
+				 enum power_supply_property psp,
+				 struct bq25890_state *state)
 {
-	struct bq25890_device *bq = power_supply_get_drvdata(psy);
-	struct bq25890_state state;
 	bool do_adc_conv;
 	int ret;
 
 	mutex_lock(&bq->lock);
 	/* update state in case we lost an interrupt */
 	__bq25890_handle_irq(bq);
-	state = bq->state;
-	do_adc_conv = !state.online && bq25890_is_adc_property(psp);
+	*state = bq->state;
+	do_adc_conv = !state->online && bq25890_is_adc_property(psp);
 	if (do_adc_conv)
 		bq25890_field_write(bq, F_CONV_START, 1);
 	mutex_unlock(&bq->lock);
@@ -475,6 +473,17 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 	if (do_adc_conv)
 		regmap_field_read_poll_timeout(bq->rmap_fields[F_CONV_START],
 			ret, !ret, 25000, 1000000);
+}
+
+static int bq25890_power_supply_get_property(struct power_supply *psy,
+					     enum power_supply_property psp,
+					     union power_supply_propval *val)
+{
+	struct bq25890_device *bq = power_supply_get_drvdata(psy);
+	struct bq25890_state state;
+	int ret;
+
+	bq25890_update_state(bq, psp, &state);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-- 
2.35.1

