Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3981C2D60
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgECPVl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 11:21:41 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:27795 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728706AbgECPVP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 May 2020 11:21:15 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49FV7X6YLPzrB;
        Sun,  3 May 2020 17:21:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588519273; bh=CtdnXaW3M9J6/3+oqZVerhtAMCemduwcslAGnqFReTw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=AEeTte93WKS/0qvl8ztsPhc0rzYLe3cAQXqzsiWa3GE8ChbGHXHAheLr8MGpCupwe
         wFbfobROysFQ7hb9vmTF/btBWTQZrMD4feNxBJwf8Noecbcvkl59DVbUZXaidcmt5d
         L4ENHvR+wSi4TrEP9j54sCI26BCBbAjYAAskbjl5caLckSg2uEPvhFus1QTcXPhL5y
         v5u2V3MkiSAYTu9QssmP+fnq07SqCQzEH0U/LjYo8yb5j8BJb6euuBoUeIOubXGJ4c
         KMHS1F7k6WWWE/IzXONciD3JM55NIg9VUnHoW4duXmioXREXF7jczyFE8OvPSQcs3y
         F/3Q84C9k0FGQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 03 May 2020 17:21:12 +0200
Message-Id: <9b3bd77de9cfef8af8f8ab76270b46599f9e5ab1.1588517058.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 07/11] power: bq25890: implement CHARGE_TYPE property
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Report charging type based on recently read state.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index e4368d01396a..ad0901fdceb6 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -429,6 +429,18 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 
 		break;
 
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		if (!state.online || state.chrg_status == STATUS_NOT_CHARGING ||
+		    state.chrg_status == STATUS_TERMINATION_DONE)
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		else if (state.chrg_status == STATUS_PRE_CHARGING)
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+		else if (state.chrg_status == STATUS_FAST_CHARGING)
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		else /* unreachable */
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+		break;
+
 	case POWER_SUPPLY_PROP_MANUFACTURER:
 		val->strval = BQ25890_MANUFACTURER;
 		break;
@@ -670,6 +682,7 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
-- 
2.20.1

