Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12EF8B1465
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfILS00 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Sep 2019 14:26:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43614 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfILS0Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2019 14:26:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id d15so16482672pfo.10;
        Thu, 12 Sep 2019 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JzxKcqXd0tvz5LO/KYD3/ViyFB8ewNV3niaA2nj26EY=;
        b=sICe4ZZruTXL7Q4M72Lf+MAHFS976VA6f0RYw+X0z6F77rJBAUO5Ik0j1UUsfSsYiS
         o/xbGiQV7itYEVHw9fSmRwmOm8Gb4m0gpvUt2tHAXsFkcEvPcwYjN+W6nrnOxWhw1q1i
         wxrP4EuO//JoD8yVVkgh+pkSeOT71RzhsA7eI+O0K7yoKi6P42Yy0ciICxTXY5iXLpco
         oV8Dr5L+T4uqPE7thYaNuXnA6iZLKLlpoJbqQrApr03/wNcQcATt8UgjH3bTLKM75bHh
         6Dqa+mi1iUrtYV905ktMx6CuA/nY0pPQtIdt0xW/PwgixQWhIGtf5mhx7bsnNsLu8Jin
         TiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JzxKcqXd0tvz5LO/KYD3/ViyFB8ewNV3niaA2nj26EY=;
        b=Pjgv4nDlGdwCn+8s9MlS+5tpR22EK9ZP/QRzsn40UjHZgXkbWxCwL303RMe1aK93Xf
         Bw7Jzhw1a59G/Q/BxcmkPgDUWz/ECgxxotkIXjfJaFktXOjUUxFpXlQ4gOrIzm4vW1/y
         UTm+w2vuJs7ZW9TBqSyHreS8Xp8MHOFCgUJSRhPMgBsPWfqOaWxqX7rr1LJZTBeom49n
         hqlCdb+h01K0hkioE1YcmXb9xUV2fKxRoAq6AM/bCmrrVBZa3dESKZ9tWGtNIGyd5HEQ
         UcaFQbHmwv47RfHunNGyhO9f8puoN1pm3Vyitpigj6+yMNu8AmoCuaiZwjfY3caVjWSh
         JcQg==
X-Gm-Message-State: APjAAAX567QMSWn2hdOab/yTtRZb7FjEoEWT3piBXq5lmQMWxjMkYTwM
        dSphg4WNOj2HScWYWSXS2EI=
X-Google-Smtp-Source: APXvYqyHJkvk7e6quVl6VNg/s9CElz/pCWZM45U+uWxhBcITe6mon2lR4Eog29reeNJWy80K8aXf2Q==
X-Received: by 2002:a17:90a:26e3:: with SMTP id m90mr64095pje.57.1568312784860;
        Thu, 12 Sep 2019 11:26:24 -0700 (PDT)
Received: from localhost.localdomain (61-231-52-128.dynamic-ip.hinet.net. [61.231.52.128])
        by smtp.gmail.com with ESMTPSA id r1sm20747382pgv.70.2019.09.12.11.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 11:26:24 -0700 (PDT)
From:   lecopzer@gmail.com
X-Google-Original-From: lecopzer.chen@mediatek.com
To:     lecopzer@gmail.com, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yj.chiang@mediatek.com, lecopzer.chen@mediatek.com
Subject: [PATCH v2 1/2] test_power: Add CHARGE_COUNTER properties
Date:   Fri, 13 Sep 2019 02:25:59 +0800
Message-Id: <20190912182600.24211-2-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912182600.24211-1-lecopzer.chen@mediatek.com>
References: <20190912182600.24211-1-lecopzer.chen@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CHARGE_COUNTER is really general in other power supply drivers and
Android also has an interface to monitor CHARGE_COUNTER, so let's
add it into test framework.

Set default as -1000 is because the default status is
POWER_SUPPLY_STATUS_DISCHARGING, which means the counter should be
negative, and 1000 means not zero but small enough.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 drivers/power/supply/test_power.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index c3cad2b6daba..70db8d20e138 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -33,6 +33,7 @@ static int battery_present		= 1; /* true */
 static int battery_technology		= POWER_SUPPLY_TECHNOLOGY_LION;
 static int battery_capacity		= 50;
 static int battery_voltage		= 3300;
+static int battery_charge_counter	= -1000;
 
 static bool module_initialized;
 
@@ -100,6 +101,9 @@ static int test_power_get_battery_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 		val->intval = battery_capacity;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
+		val->intval = battery_charge_counter;
+		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		val->intval = 100;
@@ -135,6 +139,7 @@ static enum power_supply_property test_power_battery_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CHARGE_COUNTER,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
@@ -447,6 +452,21 @@ static int param_set_battery_voltage(const char *key,
 
 #define param_get_battery_voltage param_get_int
 
+static int param_set_battery_charge_counter(const char *key,
+					const struct kernel_param *kp)
+{
+	int tmp;
+
+	if (1 != sscanf(key, "%d", &tmp))
+		return -EINVAL;
+
+	battery_charge_counter = tmp;
+	signal_power_supply_changed(test_power_supplies[TEST_BATTERY]);
+	return 0;
+}
+
+#define param_get_battery_charge_counter param_get_int
+
 static const struct kernel_param_ops param_ops_ac_online = {
 	.set = param_set_ac_online,
 	.get = param_get_ac_online,
@@ -487,6 +507,11 @@ static const struct kernel_param_ops param_ops_battery_voltage = {
 	.get = param_get_battery_voltage,
 };
 
+static const struct kernel_param_ops param_ops_battery_charge_counter = {
+	.set = param_set_battery_charge_counter,
+	.get = param_get_battery_charge_counter,
+};
+
 #define param_check_ac_online(name, p) __param_check(name, p, void);
 #define param_check_usb_online(name, p) __param_check(name, p, void);
 #define param_check_battery_status(name, p) __param_check(name, p, void);
@@ -495,6 +520,7 @@ static const struct kernel_param_ops param_ops_battery_voltage = {
 #define param_check_battery_health(name, p) __param_check(name, p, void);
 #define param_check_battery_capacity(name, p) __param_check(name, p, void);
 #define param_check_battery_voltage(name, p) __param_check(name, p, void);
+#define param_check_battery_charge_counter(name, p) __param_check(name, p, void);
 
 
 module_param(ac_online, ac_online, 0644);
@@ -525,6 +551,10 @@ MODULE_PARM_DESC(battery_capacity, "battery capacity (percentage)");
 module_param(battery_voltage, battery_voltage, 0644);
 MODULE_PARM_DESC(battery_voltage, "battery voltage (millivolts)");
 
+module_param(battery_charge_counter, battery_charge_counter, 0644);
+MODULE_PARM_DESC(battery_charge_counter,
+	"battery charge counter (microampere-hours)");
+
 MODULE_DESCRIPTION("Power supply driver for testing");
 MODULE_AUTHOR("Anton Vorontsov <cbouatmailru@gmail.com>");
 MODULE_LICENSE("GPL");
-- 
2.17.1

