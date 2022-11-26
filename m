Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B4F6395EF
	for <lists+linux-pm@lfdr.de>; Sat, 26 Nov 2022 13:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKZMJM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Nov 2022 07:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKZMJL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Nov 2022 07:09:11 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1831E3D9
        for <linux-pm@vger.kernel.org>; Sat, 26 Nov 2022 04:09:09 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E0A6785112;
        Sat, 26 Nov 2022 13:09:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669464547;
        bh=RMQ6glafawdbpsSr3/HPgI5SzhHwEO/sya4kkMMhdb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9bTOIkMRgDJV5akv6BtWOXK+C3kF/1tDwo4wpVHGg15nsZkJma9xrYe+AXpmWTyJ
         b+fW7kB3+ZF0tGqkSBS8E9znWbvJItfRf57RAB7VZxctN6zMGercnE1lrVUboPWs4x
         Yten1AaZaLko9VKuJE+DdCmdNfHUtBxZ2SQLpPax2nvG78lUIouPQcfrGe839rYjAT
         flrqg+yFsthuRqa6igMOiNud5QUbcJDAL35Q8/HyEuf87n8t0zX79akWLNmgHYl3P4
         ghZzwSo7yVqCBkni7s1ObMo4R9oFzTKFGHGIyzT00dMQKY1GneCzYt7n9wZ15zxN3I
         UOXtpjD+g2D1Q==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 2/2] power: supply: bq25890: Add HiZ mode support
Date:   Sat, 26 Nov 2022 13:08:49 +0100
Message-Id: <20221126120849.74632-2-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221126120849.74632-1-marex@denx.de>
References: <20221126120849.74632-1-marex@denx.de>
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
---
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>
---
V2: - Mix HiZ mode check into POWER_SUPPLY_PROP_STATUS,
      POWER_SUPPLY_PROP_CHARGE_TYPE, POWER_SUPPLY_PROP_ONLINE
      read back, so those behave as if the system was offline
      in case HiZ mode is enabled and cable is plugged in
    - Cache user HiZ configuration in bq->force_hiz, reinstate
      the user HiZ configuration in IRQ handler on offline to
      online transition as the chip clears the HiZ bit on that
      transition when the cable is replugged.
---
 drivers/power/supply/bq25890_charger.c | 58 +++++++++++++++++++-------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 374ab66ba8770..e40c8a94cf2e1 100644
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
+		val->intval = state.online & !state.hiz;
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
2.35.1

