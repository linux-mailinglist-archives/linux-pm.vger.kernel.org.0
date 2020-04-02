Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B6B19C526
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389062AbgDBO6h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:58:37 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:58435 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389052AbgDBO6h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:58:37 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR5l4kdYzqB;
        Thu,  2 Apr 2020 16:58:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839515; bh=5DdryG9hn452PH5otkZQyLTHjkaK1jF+yu4xhWcJIes=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=h9N6AWMCD+bl1pulxoTnpTmk+uql18JADPHUv+phnMgiiMlnp/lW0hqb1Xy3XJ8ju
         3hKe8DL45eAS0Vzn30DiDyWgKgB0QuAxiirZauvgjdPAAa7ZeEsFknfHcjCoTyF921
         9bN7X+nzY/1FCo8eCbEVLtqwU+S32L193dKa+ZwNDdRKW47K3D++g+/7vmYV5E+lGD
         VkO/5Szv2X7AsJgr/OECkSJ/5gruXoIbA6QA4LuQYILi6JNOLDi74OKQS3o2nerHZ7
         WlfuLM3oxTbJGcnikJySZX6nh8vVWfYzIQfVxDqUTOAWGv4Ug2mK1EAnoTERJMjf3w
         WC4mGYplJ/3MQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:58:34 +0200
Message-Id: <32ec8cef47cb49e02542916ae15972ba2e619e5a.1585838679.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 11/14] power: supply: bq25890: show measured VBUS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Export VBUS measurement via INPUT_VOLTAGE_NOW property.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 250468f3ff18..d23274d13263 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -506,6 +506,24 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq25890_find_val(ret, TBL_IILIM);
 		break;
 
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_NOW:
+		ret = bq25890_field_read(bq, F_VBUS_GD); /* is VBUS connected? */
+		if (ret < 0)
+			return ret;
+
+		if (!ret) {
+			val->intval = 0;
+			break;
+		}
+
+		ret = bq25890_field_read(bq, F_VBUSV); /* read measured value */
+		if (ret < 0)
+			return ret;
+
+		/* converted_val = 2.6V + ADC_val * 100mV */
+		val->intval = 2600000 + ret * 100000;
+		break;
+
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret = bq25890_field_read(bq, F_SYSV); /* read measured value */
 		if (ret < 0)
@@ -705,6 +723,7 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_INPUT_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
-- 
2.20.1

