Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDF6623661
	for <lists+linux-pm@lfdr.de>; Wed,  9 Nov 2022 23:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKIWP2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Nov 2022 17:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKIWP0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2022 17:15:26 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07B22EF3B
        for <linux-pm@vger.kernel.org>; Wed,  9 Nov 2022 14:15:24 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E8B01806FC;
        Wed,  9 Nov 2022 23:15:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1668032123;
        bh=hbju7MdyTF8RRhhvNpIw4k/q4fO57Qv9kCdlfK/EM80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9FrYYpGGlOpYQq/gpsVoslsAA7aTfTcaTrVylHRPowyyTRBHCMriNun2WNbgnXj1
         7RLbbJ+5hmCrR40k/oFj3f3+Jlbq+kT2h4JaUzBgAaHWG8o3EL0GflGmluSICiF3Es
         U88bFeoM9t9xlCYUivGFUDLzEQMdcVEP2eUiXm0gs7nlxrrOYEt4ktEis77JjGY0ZX
         Auv0TZyBnuuGQsznxmXaDswz+c+k741QWZn29hX67vCR2dcwpZaOKFV5cdhrBnULit
         v6n2TS8FipjS4+NlhmO0QxgPNAEEvTrNWtIzmD9k78RJ034QYs4IWQ2/hHcCTD2ayn
         yeZitWj+6RVfA==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/2] power: supply: bq25890: Add HiZ mode support
Date:   Wed,  9 Nov 2022 23:15:04 +0100
Message-Id: <20221109221504.79562-2-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221109221504.79562-1-marex@denx.de>
References: <20221109221504.79562-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/bq25890_charger.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 676eb66374e01..70b5783999345 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -95,6 +95,7 @@ struct bq25890_init_data {
 
 struct bq25890_state {
 	u8 online;
+	u8 hiz;
 	u8 chrg_status;
 	u8 chrg_fault;
 	u8 vsys_status;
@@ -676,7 +677,8 @@ static int bq25890_power_supply_set_property(struct power_supply *psy,
 					     const union power_supply_propval *val)
 {
 	struct bq25890_device *bq = power_supply_get_drvdata(psy);
-	int maxval;
+	struct bq25890_state state;
+	int maxval, ret;
 	u8 lval;
 
 	switch (psp) {
@@ -691,6 +693,10 @@ static int bq25890_power_supply_set_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		lval = bq25890_find_idx(val->intval, TBL_IINLIM);
 		return bq25890_field_write(bq, F_IINLIM, lval);
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = bq25890_field_write(bq, F_EN_HIZ, !val->intval);
+		bq25890_update_state(bq, psp, &state);
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -703,6 +709,7 @@ static int bq25890_power_supply_property_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_ONLINE:
 		return true;
 	default:
 		return false;
@@ -757,6 +764,7 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
 	} state_fields[] = {
 		{F_CHG_STAT,	&state->chrg_status},
 		{F_PG_STAT,	&state->online},
+		{F_EN_HIZ,	&state->hiz},
 		{F_VSYS_STAT,	&state->vsys_status},
 		{F_BOOST_FAULT, &state->boost_fault},
 		{F_BAT_FAULT,	&state->bat_fault},
@@ -772,10 +780,11 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
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
@@ -792,12 +801,14 @@ static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq)
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
+	} else if (new_state.online && !new_state.hiz && !bq->state.online) {
+		/* power inserted and not HiZ */
 		/* enable ADC, to have control of charge current/voltage */
 		ret = bq25890_field_write(bq, F_CONV_RATE, 1);
 		if (ret < 0)
-- 
2.35.1

