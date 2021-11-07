Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F0C44759F
	for <lists+linux-pm@lfdr.de>; Sun,  7 Nov 2021 21:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbhKGUXG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Nov 2021 15:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbhKGUXF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Nov 2021 15:23:05 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11200C061570;
        Sun,  7 Nov 2021 12:20:22 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j2so31615654lfg.3;
        Sun, 07 Nov 2021 12:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/fhahaI39Wv/J0xESGd7vEiJN97fd/AUSsPWeiQtbU=;
        b=OJx92yQFJYSk+u2DnVahwFgyw5oQ32it8tc4ZEZQaVe41LjH31J/Ss1Pos+HuQvHSQ
         LmsnkiMLhmKUUrs1SAQzas9jIN58r2Xpoy+9Ki2YcEN0ZoH4dMPUCh93Gmtpl14p0tje
         uLnOipcjfjCuw1L0akDZFZk98FCvZrnnJbd6jDQ4qqmflsUnc4iKt0yG8/FTAf5ehrEC
         2L5r8Zc8w0bHtH/uLylxG4fqUXvnYbMh+G9jlMRdhRhrRzKw+sn85d0EcSKFarWYmj27
         T0IwUoURy3I7KOyb8C2/5/sj5NmzdF1vzN7/OnZiVE/bj9j4UmOsy3Dcjp/ioEvEyWXH
         APBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/fhahaI39Wv/J0xESGd7vEiJN97fd/AUSsPWeiQtbU=;
        b=oIq4tOEtYNa2bWvj9jQATTaygSbmE2TlMwqhEmC0N4sG/MM+aV6qSqMPzdRKPuT3zq
         oUUFJAtcxq/ofqP9/I19Olle4CK+7tIrkqWZvF1TFHB4/YVo9nPzcKdg0eu+Fmxt3Uu8
         hUI3soH+aLWo8W4mUKzUu3dHetm2W1bfgcP9mTWW/WWWruuO00LS36UfaG1pQcr0sc3n
         B2RCaLm46FFa10d9wLrAoB20alYpyX+XMfKa8UNeIfD6FDcrgs9Oj3JN99PQmrNa0BIP
         b7uaSV5+0KgLDa/QBAb7JKLH89CeuH0DUphvsnnn1haSTpnnSviohmvz7j2e9//EpCw3
         bm2w==
X-Gm-Message-State: AOAM531FbHnUvAFk+Z51AUp9pgT27V+EHz//1Plny03RtgVpkJaX/0bn
        03NozaJs8oX0rvyK+tQM0QE=
X-Google-Smtp-Source: ABdhPJzmDW05xEiiDrIm5l4TbTcQqbs4n8i9Vn2izIbXHRwv+fU0gHMcOr3/jACfkL1DvKymPWyWNA==
X-Received: by 2002:ac2:5fe9:: with SMTP id s9mr59629135lfg.412.1636316420434;
        Sun, 07 Nov 2021 12:20:20 -0800 (PST)
Received: from localhost.localdomain ([37.45.143.17])
        by smtp.gmail.com with ESMTPSA id w24sm1564572lfc.99.2021.11.07.12.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 12:20:20 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.95)
        (envelope-from <jekhor@gmail.com>)
        id 1mjoeJ-000ECw-GZ;
        Sun, 07 Nov 2021 23:20:19 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 3/4] power supply bq25890-charger: Handle temperature faults
Date:   Sun,  7 Nov 2021 23:20:00 +0300
Message-Id: <20211107202001.54579-3-jekhor@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211107202001.54579-1-jekhor@gmail.com>
References: <20211107202001.54579-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add debug info about thermal failure to message in
bq25890_get_chip_state().

Take into account possible thermal failure when calculating a
POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX value as it described in
datasheet (in cold conditions a current limit is decreased to 20% or 50% of
ICHG field value depended on JEITA_ISET field).

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/power/supply/bq25890_charger.c | 33 +++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 1c43555d5bd8..fb2f1578503c 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -95,6 +95,7 @@ struct bq25890_state {
 	u8 vsys_status;
 	u8 boost_fault;
 	u8 bat_fault;
+	u8 ntc_fault;
 };
 
 struct bq25890_device {
@@ -384,6 +385,14 @@ enum bq25890_chrg_fault {
 	CHRG_FAULT_TIMER_EXPIRED,
 };
 
+enum bq25890_ntc_fault {
+	NTC_FAULT_NORMAL = 0,
+	NTC_FAULT_WARM = 2,
+	NTC_FAULT_COOL = 3,
+	NTC_FAULT_COLD = 5,
+	NTC_FAULT_HOT = 6,
+};
+
 static bool bq25890_is_adc_property(enum power_supply_property psp)
 {
 	switch (psp) {
@@ -474,7 +483,19 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		ret = bq25890_field_read(bq, F_JEITA_ISET);
+		if (ret < 0)
+			return ret;
+
 		val->intval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
+
+		/* When temperature is too low, charge current is decreased */
+		if (bq->state.ntc_fault == NTC_FAULT_COOL) {
+			if (ret)
+				val->intval /= 5;
+			else
+				val->intval /= 2;
+		}
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
@@ -487,6 +508,10 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
+		ret = bq25890_field_read(bq, F_JEITA_VSET);
+		if (ret < 0)
+			return ret;
+
 		/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
 		val->intval = 2304000 + ret * 20000;
 		break;
@@ -550,7 +575,8 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
 		{F_VSYS_STAT,	&state->vsys_status},
 		{F_BOOST_FAULT, &state->boost_fault},
 		{F_BAT_FAULT,	&state->bat_fault},
-		{F_CHG_FAULT,	&state->chrg_fault}
+		{F_CHG_FAULT,	&state->chrg_fault},
+		{F_CHG_FAULT,	&state->ntc_fault}
 	};
 
 	for (i = 0; i < ARRAY_SIZE(state_fields); i++) {
@@ -561,9 +587,10 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
 		*state_fields[i].data = ret;
 	}
 
-	dev_dbg(bq->dev, "S:CHG/PG/VSYS=%d/%d/%d, F:CHG/BOOST/BAT=%d/%d/%d\n",
+	dev_dbg(bq->dev, "S:CHG/PG/VSYS=%d/%d/%d, F:CHG/BOOST/BAT/NTC=%d/%d/%d/%d\n",
 		state->chrg_status, state->online, state->vsys_status,
-		state->chrg_fault, state->boost_fault, state->bat_fault);
+		state->chrg_fault, state->boost_fault, state->bat_fault,
+		state->ntc_fault);
 
 	return 0;
 }
-- 
2.33.1

