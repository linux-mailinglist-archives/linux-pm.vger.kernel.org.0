Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 745BF19C53C
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbgDBO7E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:59:04 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:40831 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389041AbgDBO6f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:58:35 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR5j2Bpvz9j;
        Thu,  2 Apr 2020 16:58:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839513; bh=CtdnXaW3M9J6/3+oqZVerhtAMCemduwcslAGnqFReTw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Kdmo72ywkGxiqa5vrzjpXFuEm59PmujDUIiEgUrQ1yB8yhMkO37IDPZu4A608+kFn
         dETm6BpadQ+/JuYUGw4gFiR/wc24zZ+DjjQIk2EwBMBKHbCiCyo1ZLOOwO1ZuerPrE
         /HyCyYMXBXB2nHNtFyDIi5PIMx9XSGEv9qI3s0wG2uPJKiPDi11NPEUHcnmm7QWB2u
         CLhzzbzsr5RsFnHGWjV5rIwku7Hd2MZClonth48ZGUfTYSuUCA20fffwNyacbcORLP
         xYXbEW+FLMlhn3ysqu8S4R0RCZVNt6/gJnj/pdtkpjdYRXEMj+IlvfUptGdI9MwZjr
         NNlid/rDhU9Yg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:58:32 +0200
Message-Id: <a5056368c4056445ec9b98d7abf01aced590905f.1585838679.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 07/14] power: supply: bq25890: implement CHARGE_TYPE property
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
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

