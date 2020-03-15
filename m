Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7964185DDA
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgCOPOn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 11:14:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41620 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgCOPOn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 11:14:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id f11so1284769wrp.8;
        Sun, 15 Mar 2020 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nw9EpIfztqsWhJ/JuEKjzVHKAstJZGt97qEhfNdT50k=;
        b=l9/1t3072/UUbHY49oThk6ocSHP6SXo9e29Yd0jL96PHiEjmdTTet05ZjlmCDpZpcl
         hazic516JrOuFJxg4Yrx3U3eth2E0WGnYdX6H98KJhkdvlablAFz/UpC66L2wKaQjZEg
         L8hzBuBVOXdAz5jX+MMASZRmlcJJtZ+oQ8bBbWBBbIvLDw1QO7iCzDw6iYPZtHJ7xBU/
         7ho1dEV7Bdcp7w71R7fzKEerV9uejhE3iFt5nht5CIb/pMeDy/JYeYrgRHPIchluaTzK
         nvZbM5YrsOjxX7h2u55wzBJ86yBhdbMvAvr3O+QRiuBIpjknMt8hYiNuN6AijFv5kA5N
         qqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nw9EpIfztqsWhJ/JuEKjzVHKAstJZGt97qEhfNdT50k=;
        b=n4IGQryH/ZNCjxjISgr2Il4X/j6KYrr0PZqoAY90ZII8KZ2Cxc99kmddujH0Rl64o9
         6DSZwnM7TL0wxYL9KshB7Lo8IxqLG/T1kaqdQj4cEmqDkYUIl73pCFYZCiPN+WWsKN7f
         vPThMfenqbVjSCP3MauOSTOmlBWFgOciUYNdOArOsKgwfoFHPb72uoBD/gguq3TH1yOL
         MdNLw5aQRmlIzMnNuTDbzDNGNWwEeLTbVWygIRbdXXLikgNV52gXezDnrzTitkAqzghB
         aWY13nV6rzAgnbMCaZTeJg6inueZMn1G9TUUjN48bn/KmMH10K112UFhbsVOvy/v5mzY
         KHhw==
X-Gm-Message-State: ANhLgQ0oHOYgWj9cUPHS9bK4xlfkL/ZliD2KvZPSA9Ob7eqTPAUy1nAI
        jkiNZvMZEF5jyIjX8Le25iQ=
X-Google-Smtp-Source: ADFU+vvpNoYbMggMfVam9rNXtEJjIPNyBboiRZP3i2QGNAQ0Ea5cf+35iVViGMKjEjPHHaHKz29nlA==
X-Received: by 2002:a5d:6282:: with SMTP id k2mr26161882wru.401.1584285281491;
        Sun, 15 Mar 2020 08:14:41 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id i67sm67746869wri.50.2020.03.15.08.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 08:14:40 -0700 (PDT)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH 08/15] power: supply: cpcap-battery: Get rid of rough capacity percentage
Date:   Sun, 15 Mar 2020 18:11:59 +0300
Message-Id: <20200315151206.30909-8-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200315151206.30909-1-spinal.by@gmail.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Get rid of rough capacity percentage.

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 46 +++++++++---------------------------
 1 file changed, 11 insertions(+), 35 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index f712a3bda315..2f4c6669c37d 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -142,24 +142,22 @@ struct cpcap_battery_ddata {
 struct cpcap_battery_capacity {
 	int capacity;
 	int voltage;
-	int percentage;
 };
 
-#define CPCAP_CAP(l, v, p)			\
+#define CPCAP_CAP(l, v)				\
 {						\
 	.capacity = (l),			\
 	.voltage = (v),				\
-	.percentage = (p),			\
 },
 
 /* Pessimistic battery capacity mapping before high or low value is seen */
 static const struct cpcap_battery_capacity cpcap_battery_cap[] = {
-	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN,        0,   0)
-	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL, 3100000,   0)
-	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_LOW,      3300000,   2)
-	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_NORMAL,   3700000,  50)
-	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_HIGH,     4000000,  75)
-	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_FULL,     4200000 - 18000, 100)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN,        0)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL, 3100000)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_LOW,      3300000)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_NORMAL,   3700000)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_HIGH,     4000000)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_FULL,     4200000 - 18000)
 };
 
 #define CPCAP_NO_BATTERY	-400
@@ -503,8 +501,7 @@ static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 	return 0;
 }
 
-static void cpcap_battery_get_rough(struct cpcap_battery_ddata *ddata,
-				    int *level, int *percentage)
+static int cpcap_battery_get_capacity_level(struct cpcap_battery_ddata *ddata)
 {
 	struct cpcap_battery_state_data *latest;
 	const struct cpcap_battery_capacity *cap = NULL;
@@ -520,30 +517,9 @@ static void cpcap_battery_get_rough(struct cpcap_battery_ddata *ddata,
 	}
 
 	if (!cap)
-		return;
-
-	if (level)
-		*level = cap->capacity;
-	if (percentage)
-		*percentage = cap->percentage;
-}
-
-static int cpcap_battery_get_rough_capacity(struct cpcap_battery_ddata *ddata)
-{
-	int capacity = 0;
-
-	cpcap_battery_get_rough(ddata, &capacity, NULL);
-
-	return capacity;
-}
-
-static int cpcap_battery_get_rough_percentage(struct cpcap_battery_ddata *ddata)
-{
-	int percentage = 0;
-
-	cpcap_battery_get_rough(ddata, NULL, &percentage);
+		return 0;
 
-	return percentage;
+	return cap->capacity;
 }
 
 static enum power_supply_property cpcap_battery_props[] = {
@@ -662,7 +638,7 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 		val->intval /= ddata->charge_full;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
-		val->intval = cpcap_battery_get_rough_capacity(ddata);
+		val->intval = cpcap_battery_get_capacity_level(ddata);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 		low = cpcap_battery_get_lowest(ddata);
-- 
2.11.0

