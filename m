Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167A06395EE
	for <lists+linux-pm@lfdr.de>; Sat, 26 Nov 2022 13:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKZMJM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Nov 2022 07:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZMJK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Nov 2022 07:09:10 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423651E3C7
        for <linux-pm@vger.kernel.org>; Sat, 26 Nov 2022 04:09:09 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CFDF38510C;
        Sat, 26 Nov 2022 13:09:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669464546;
        bh=tvZkw6WxdAO3pnqnmJ4bKJJ+3tEgAC392u7I5NEJDoI=;
        h=From:To:Cc:Subject:Date:From;
        b=QA8FACo1cVtp2Aya++jM/PdFnBvgHQPhCrr8jWpzIWzxFYu8kDdDyyAyIEdGpopDu
         pd5dWECHKUKpCZBOnlEdY50NManQzadRgVAkkYDIk/FhXVDjLOfdTcHElAiAVaA/YC
         V5hqotrIglfpP5pLz/TiWiVuO6/O5l/HcdtK/w4osx0Dy/xkUsUTuXhJJxnSEj9YBj
         IPxmWrqQEL5TeVO9tq3wc6F2Lye7t5ec1ysW3DrKqDNpxkIo71JWIktwfkxBYwDikn
         fM/TvSFmlu7r3MvI4X62UmrJ+FRs1+AraT160LiEql1h5el+n8HjI293dO8C5fbCqC
         ubE4NI/dKqv+w==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 1/2] power: supply: bq25890: Factor out chip state update
Date:   Sat, 26 Nov 2022 13:08:48 +0100
Message-Id: <20221126120849.74632-1-marex@denx.de>
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

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>
---
V2: Add RB from Hans
---
 drivers/power/supply/bq25890_charger.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index bfdd2213ba69a..374ab66ba8770 100644
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

