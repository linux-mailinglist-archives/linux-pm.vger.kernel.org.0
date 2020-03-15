Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C785185DD4
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 16:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgCOPOk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 11:14:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44582 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgCOPOk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 11:14:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id y2so2582776wrn.11;
        Sun, 15 Mar 2020 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lb85Vsp0xUlVkHp+V++9SA5TEfJMXw1OCLYxxoW6Ha4=;
        b=cr9RIVOP5EB1gguj9gEVaQgSDQ/aA0weBFNRCuZq2T1b79wbfZr5LHAVD4dXu/RAA0
         TJ7SSWMrAIUBB6sSDPPurKOnzdkne5uALRIYiQmfQVvvMx1PvpNXIE9D4aeX/WI8x2fL
         Er2JnjwBTj1hAHVkoIL7/RgweEPxAccOefAQN0Z20v/k+8Q62udc1zXskOd0GyqlxGxz
         GIkQdcEjPyDMi0L+1v6TMeHW87Rcd2zei4WKpu2bmrS3uHG+WMoP6tA8c6AW5yy6FPIi
         belLK7Z0bCajx4sB7mXk81qkO7AFsSsuYkUHQKUbV5H7aRZpbPJIXtEulM8q1kYoKHKI
         y5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lb85Vsp0xUlVkHp+V++9SA5TEfJMXw1OCLYxxoW6Ha4=;
        b=pqfWVWFtNJaryk3KVs7AlUzBWF1WBiR8c/ghT5rFishSnd8NHT2Z0WKTf8fWPWR0fR
         2+ApAS/XnfuG1FWgBxUdzUW5ApERKnIIp1z21sVVj2AGit8WNkikKAwOqz+I6SZnDmiJ
         4/l0BZm3aqq2s4NQ6ylRwlHTwP7ypJhF5NBvdt2lByr2f+ARFbexf/heswFAwUu01yCw
         UGS9N8Xq8tseRruA+HRc4Gpn1Z64ZzQS/v1kAi37OeHGlIvpiyzxP5UvqUePSzr/gDrB
         BGMArssO1gBZiCGND9YabCkc/XWurMQsvv8AvCEQNZ3OsU3jB/EjJ1kAkZ4LVSBLoroW
         YYhw==
X-Gm-Message-State: ANhLgQ0pUHCpwFwreM0gpuAhQ7ITxrmZtmQ/3PHeziJXnFeGqTy4njlz
        /l02sluvzscKHYROP1yqxJ4=
X-Google-Smtp-Source: ADFU+vvOXCXQsewsdReWIDsFQYGgiVVJcPj/m6HKcXQ9fGUIMCG6zAzoOph+e4FC5xuQNiEF8W5AmA==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr28706221wrw.99.1584285276876;
        Sun, 15 Mar 2020 08:14:36 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id i67sm67746869wri.50.2020.03.15.08.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 08:14:36 -0700 (PDT)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH 04/15] power: supply: cpcap-battery: Add charge_full property
Date:   Sun, 15 Mar 2020 18:11:55 +0300
Message-Id: <20200315151206.30909-4-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200315151206.30909-1-spinal.by@gmail.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add charge_full property.

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 8a58ad943960..43e39485a617 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -134,6 +134,7 @@ struct cpcap_battery_ddata {
 	struct cpcap_battery_state_data state[CPCAP_BATTERY_STATE_NR];
 	u32 cc_lsb;		/* μAms per LSB */
 	atomic_t active;
+	int charge_full;
 	int status;
 	u16 vendor;
 };
@@ -530,6 +531,7 @@ static enum power_supply_property cpcap_battery_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
 	POWER_SUPPLY_PROP_POWER_NOW,
@@ -649,6 +651,11 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 		val->intval = cpcap_battery_get_rough_capacity(ddata);
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		if (!ddata->charge_full)
+			return -ENODATA;
+		val->intval = ddata->charge_full;
+		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		val->intval = ddata->config.info.charge_full_design;
 		break;
@@ -710,6 +717,15 @@ static int cpcap_battery_set_property(struct power_supply *psy,
 		ddata->config.bat.constant_charge_voltage_max_uv = val->intval;
 
 		return cpcap_battery_update_charger(ddata, val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		if (val->intval < 0)
+			return -EINVAL;
+		if (val->intval > ddata->config.info.charge_full_design)
+			return -EINVAL;
+
+		ddata->charge_full = val->intval;
+
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -722,6 +738,7 @@ static int cpcap_battery_property_is_writeable(struct power_supply *psy,
 {
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		return 1;
 	default:
 		return 0;
-- 
2.11.0

