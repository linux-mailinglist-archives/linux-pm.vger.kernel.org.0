Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4149A19C52F
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389013AbgDBO6x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:58:53 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:40831 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389055AbgDBO6h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:58:37 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR5m1387z9j;
        Thu,  2 Apr 2020 16:58:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839516; bh=Z5m6v9PbZvsaRy/wVOFR85m5686ZzFRztIiMSmfJt0Y=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=jJB8aqYOYrf5iDaTcb/lF5MHMkUwjVaUeqF4a/YRAGx2sY+fdFn4VVR3HWuXHi36v
         jubybgYGUlcnuFMD723dnaqwVYrL8dRKEuhZTWuoWpE0Zz8HgDOlQ1dH5WGCR1kW6b
         VXxjnzWmGHnSTqHtliwzDwHAaTSi0PveGaX20uSMkB+2M5HD+mj4wCZO0efxz8hmnO
         tIiUUXNkNFRpCBe9d1sxkO4O/ep0qWYU5QWxur6zMA2602Ej1+hmbw77sXWVBhwtWc
         z6Yb4oJd34Te4l52DWJpCIaxb2GVpoGX7sVJ2J6t+YhQBpot5hs0jR0js9mcuftaDJ
         yML3BCxzEDF3Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:58:35 +0200
Message-Id: <fdd9ec41a66113264c3b233658a72e00159f65d5.1585838679.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 12/14] power: supply: bq25890: show VSYS as output voltage
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VSYS is the voltage that is provided to the rest of the system. Show
measurement OUTPUT_VOLTAGE and supplement it with VSYSMIN setting.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index d23274d13263..6c277f2dbae2 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -524,7 +524,7 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = 2600000 + ret * 100000;
 		break;
 
-	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_NOW:
 		ret = bq25890_field_read(bq, F_SYSV); /* read measured value */
 		if (ret < 0)
 			return ret;
@@ -533,6 +533,10 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = 2304000 + ret * 20000;
 		break;
 
+	case POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_MIN:
+		val->intval = bq25890_find_val(bq->init_data.sysvmin, TBL_SYSVMIN);
+		break;
+
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		ret = bq25890_field_read(bq, F_ICHGR); /* read measured value */
 		if (ret < 0)
@@ -724,7 +728,8 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_INPUT_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_MIN,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
-- 
2.20.1

