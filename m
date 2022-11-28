Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F95D63A50C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 10:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiK1JaN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 04:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiK1JaM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 04:30:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E275F62
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 01:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669627749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymAdaUOVg/PTZtGMFazS7nrw3mgKfKim5MfI+PVzSfg=;
        b=TjggX2YXfs+tpGYOkxju02ymlyJdxSD4xibqrlyW5ZZTCdcvUl/wgSyLdNlpJC6Uo2vdqy
        NEAco3xV33BF8uv+pn+FpaX07KkaE5TVwLbFf/bTIITkP0xKO6fm/TvUc6q6mZOKmV41Rk
        ls1/OsNwIh/TstZexEETuKHDzTTVzz0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-6iRhRmmVMfG12wD-kAlzXA-1; Mon, 28 Nov 2022 04:29:05 -0500
X-MC-Unique: 6iRhRmmVMfG12wD-kAlzXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45809886063;
        Mon, 28 Nov 2022 09:29:05 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.195.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55BFAFD48;
        Mon, 28 Nov 2022 09:29:04 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH v2 4/9] power: supply: bq25890: Add HiZ mode support
Date:   Mon, 28 Nov 2022 10:28:51 +0100
Message-Id: <20221128092856.71619-5-hdegoede@redhat.com>
In-Reply-To: <20221128092856.71619-1-hdegoede@redhat.com>
References: <20221128092856.71619-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

The bq25890 is capable of disconnecting itself from the external supply,
in which case the system is supplied only from the battery. This can be
useful e.g. to test the pure battery operation, or draw no power from
USB port.

Implement support for this mode, which can be toggled by writing 0 or
non-zero to sysfs 'online' attribute, to select either offline or online
mode.

The IRQ handler has to be triggered to update chip state, as switching
to and from HiZ mode does not generate an interrupt automatically.

The IRQ handler reinstates the HiZ mode in case a cable is replugged by
the user, the chip itself clears the HiZ mode bit when cable is plugged
in by the user and the chip detects PG bad-to-good transition.

Signed-off-by: Marek Vasut <marex@denx.de>
[hdegoede@redhat.com: Replace "&" with "&&" in a boolean check]
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 58 +++++++++++++++++++-------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index e9f5964f9dcd..f5fa39dca832 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -95,6 +95,7 @@ struct bq25890_init_data {
 
 struct bq25890_state {
 	u8 online;
+	u8 hiz;
 	u8 chrg_status;
 	u8 chrg_fault;
 	u8 vsys_status;
@@ -119,6 +120,7 @@ struct bq25890_device {
 
 	bool skip_reset;
 	bool read_back_init_data;
+	bool force_hiz;
 	u32 pump_express_vbus_max;
 	enum bq25890_chip_version chip_version;
 	struct bq25890_init_data init_data;
@@ -487,7 +489,7 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		if (!state.online)
+		if (!state.online || state.hiz)
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 		else if (state.chrg_status == STATUS_NOT_CHARGING)
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
@@ -502,7 +504,8 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
-		if (!state.online || state.chrg_status == STATUS_NOT_CHARGING ||
+		if (!state.online || state.hiz ||
+		    state.chrg_status == STATUS_NOT_CHARGING ||
 		    state.chrg_status == STATUS_TERMINATION_DONE)
 			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
 		else if (state.chrg_status == STATUS_PRE_CHARGING)
@@ -522,7 +525,7 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = state.online;
+		val->intval = state.online && !state.hiz;
 		break;
 
 	case POWER_SUPPLY_PROP_HEALTH:
@@ -676,7 +679,8 @@ static int bq25890_power_supply_set_property(struct power_supply *psy,
 					     const union power_supply_propval *val)
 {
 	struct bq25890_device *bq = power_supply_get_drvdata(psy);
-	int maxval;
+	struct bq25890_state state;
+	int maxval, ret;
 	u8 lval;
 
 	switch (psp) {
@@ -691,6 +695,12 @@ static int bq25890_power_supply_set_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		lval = bq25890_find_idx(val->intval, TBL_IINLIM);
 		return bq25890_field_write(bq, F_IINLIM, lval);
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = bq25890_field_write(bq, F_EN_HIZ, !val->intval);
+		if (!ret)
+			bq->force_hiz = !val->intval;
+		bq25890_update_state(bq, psp, &state);
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -703,6 +713,7 @@ static int bq25890_power_supply_property_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_ONLINE:
 		return true;
 	default:
 		return false;
@@ -757,6 +768,7 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
 	} state_fields[] = {
 		{F_CHG_STAT,	&state->chrg_status},
 		{F_PG_STAT,	&state->online},
+		{F_EN_HIZ,	&state->hiz},
 		{F_VSYS_STAT,	&state->vsys_status},
 		{F_BOOST_FAULT, &state->boost_fault},
 		{F_BAT_FAULT,	&state->bat_fault},
@@ -772,10 +784,11 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
 		*state_fields[i].data = ret;
 	}
 
-	dev_dbg(bq->dev, "S:CHG/PG/VSYS=%d/%d/%d, F:CHG/BOOST/BAT/NTC=%d/%d/%d/%d\n",
-		state->chrg_status, state->online, state->vsys_status,
-		state->chrg_fault, state->boost_fault, state->bat_fault,
-		state->ntc_fault);
+	dev_dbg(bq->dev, "S:CHG/PG/HIZ/VSYS=%d/%d/%d/%d, F:CHG/BOOST/BAT/NTC=%d/%d/%d/%d\n",
+		state->chrg_status, state->online,
+		state->hiz, state->vsys_status,
+		state->chrg_fault, state->boost_fault,
+		state->bat_fault, state->ntc_fault);
 
 	return 0;
 }
@@ -792,16 +805,33 @@ static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq)
 	if (!memcmp(&bq->state, &new_state, sizeof(new_state)))
 		return IRQ_NONE;
 
-	if (!new_state.online && bq->state.online) {	    /* power removed */
+	/* power removed or HiZ */
+	if ((!new_state.online || new_state.hiz) && bq->state.online) {
 		/* disable ADC */
 		ret = bq25890_field_write(bq, F_CONV_RATE, 0);
 		if (ret < 0)
 			goto error;
-	} else if (new_state.online && !bq->state.online) { /* power inserted */
-		/* enable ADC, to have control of charge current/voltage */
-		ret = bq25890_field_write(bq, F_CONV_RATE, 1);
-		if (ret < 0)
-			goto error;
+	} else if (new_state.online && !bq->state.online) {
+		/*
+		 * Restore HiZ bit in case it was set by user.
+		 * The chip does not retain this bit once the
+		 * cable is re-plugged, hence the bit must be
+		 * reset manually here.
+		 */
+		if (bq->force_hiz) {
+			ret = bq25890_field_write(bq, F_EN_HIZ, bq->force_hiz);
+			if (ret < 0)
+				goto error;
+			new_state.hiz = 1;
+		}
+
+		if (!new_state.hiz) {
+			/* power inserted and not HiZ */
+			/* enable ADC, to have control of charge current/voltage */
+			ret = bq25890_field_write(bq, F_CONV_RATE, 1);
+			if (ret < 0)
+				goto error;
+		}
 	}
 
 	bq->state = new_state;
-- 
2.37.3

