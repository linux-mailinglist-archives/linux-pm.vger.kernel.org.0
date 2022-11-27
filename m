Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93405639C33
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 19:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiK0SD4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 13:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiK0SDz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 13:03:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3451A65A4
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 10:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669572171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r2zdyHrvuAYnZXX3i/QTem6V9ylAuglqPkvlKoPQGw0=;
        b=ac/B1Z48q3fp4hmBMVp8QsgIXNyPIquHaWhSXQDfxLVtnZRFa7FPDpHf2zkA/rk2XpzuaB
        5ZsbR6Z5rLjK/r710FQNtGeRY47wEUkZQ77MKaADkkZJ4+//hx4fBlQiOJ1lEpRXQ/3G8Q
        wbtY838/oGpBv50bLIic8osAvVkpwI4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-JHyuWw2pMx-AquxocRexHQ-1; Sun, 27 Nov 2022 13:02:47 -0500
X-MC-Unique: JHyuWw2pMx-AquxocRexHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 823963C0D188;
        Sun, 27 Nov 2022 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0D31140EBF5;
        Sun, 27 Nov 2022 18:02:46 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 04/10] power: supply: bq25890: Factor out chip state update
Date:   Sun, 27 Nov 2022 19:02:27 +0100
Message-Id: <20221127180233.103678-5-hdegoede@redhat.com>
In-Reply-To: <20221127180233.103678-1-hdegoede@redhat.com>
References: <20221127180233.103678-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Marek Vasut <marex@denx.de>

Pull the chip state and ADC conversion update functionality out into
separate function, so it can be reused elsewhere in the driver. This
is a preparatory patch, no functional change.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 032a10a3877b..d0a7a1c11ad5 100644
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
2.38.1

