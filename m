Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA211C69D
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 12:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfENKFg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 06:05:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12085 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726369AbfENKFf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2019 06:05:35 -0400
X-UUID: ed43b230cdd94b658c5208c3594f28a3-20190514
X-UUID: ed43b230cdd94b658c5208c3594f28a3-20190514
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 595000805; Tue, 14 May 2019 18:05:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 14 May 2019 18:05:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 14 May 2019 18:05:27 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lecopzer.chen@mediatek.com>
CC:     <srv_heupstream@mediatek.com>, <yj.chiang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] test_power: Add CURRENT and CHARGE_COUNTER properties
Date:   Tue, 14 May 2019 18:04:58 +0800
Message-ID: <1557828298-16591-1-git-send-email-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Lecopzer Chen" <lecopzer.chen@mediatek.com>

Emulate battery current (variable) and battery CHARGE_COUNTER
(same as battery_capacity) properties.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc: YJ Chiang <yj.chiang@mediatek.com>

---
 drivers/power/supply/test_power.c | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index 57246cdbd042..9f85060c84de 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -36,6 +36,7 @@ static int battery_present		= 1; /* true */
 static int battery_technology		= POWER_SUPPLY_TECHNOLOGY_LION;
 static int battery_capacity		= 50;
 static int battery_voltage		= 3300;
+static int battery_current		= 1600;
 
 static bool module_initialized;
 
@@ -101,6 +102,7 @@ static int test_power_get_battery_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
+	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
 		val->intval = battery_capacity;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
@@ -117,6 +119,10 @@ static int test_power_get_battery_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		val->intval = battery_voltage;
 		break;
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = battery_current;
+		break;
 	default:
 		pr_info("%s: some properties deliberately report errors.\n",
 			__func__);
@@ -138,6 +144,7 @@ static enum power_supply_property test_power_battery_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CHARGE_COUNTER,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
@@ -147,6 +154,8 @@ static enum power_supply_property test_power_battery_props[] = {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	POWER_SUPPLY_PROP_TEMP,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
 static char *test_power_ac_supplied_to[] = {
@@ -450,6 +459,21 @@ static int param_set_battery_voltage(const char *key,
 
 #define param_get_battery_voltage param_get_int
 
+static int param_set_battery_current(const char *key,
+					const struct kernel_param *kp)
+{
+	int tmp;
+
+	if (1 != sscanf(key, "%d", &tmp))
+		return -EINVAL;
+
+	battery_current = tmp;
+	signal_power_supply_changed(test_power_supplies[TEST_BATTERY]);
+	return 0;
+}
+
+#define param_get_battery_current param_get_int
+
 static const struct kernel_param_ops param_ops_ac_online = {
 	.set = param_set_ac_online,
 	.get = param_get_ac_online,
@@ -490,6 +514,11 @@ static const struct kernel_param_ops param_ops_battery_voltage = {
 	.get = param_get_battery_voltage,
 };
 
+static const struct kernel_param_ops param_ops_battery_current = {
+	.set = param_set_battery_current,
+	.get = param_get_battery_current,
+};
+
 #define param_check_ac_online(name, p) __param_check(name, p, void);
 #define param_check_usb_online(name, p) __param_check(name, p, void);
 #define param_check_battery_status(name, p) __param_check(name, p, void);
@@ -498,6 +527,7 @@ static const struct kernel_param_ops param_ops_battery_voltage = {
 #define param_check_battery_health(name, p) __param_check(name, p, void);
 #define param_check_battery_capacity(name, p) __param_check(name, p, void);
 #define param_check_battery_voltage(name, p) __param_check(name, p, void);
+#define param_check_battery_current(name, p) __param_check(name, p, void);
 
 
 module_param(ac_online, ac_online, 0644);
@@ -528,6 +558,9 @@ MODULE_PARM_DESC(battery_capacity, "battery capacity (percentage)");
 module_param(battery_voltage, battery_voltage, 0644);
 MODULE_PARM_DESC(battery_voltage, "battery voltage (millivolts)");
 
+module_param(battery_current, battery_current, 0644);
+MODULE_PARM_DESC(battery_current, "battery current (milliampere)");
+
 MODULE_DESCRIPTION("Power supply driver for testing");
 MODULE_AUTHOR("Anton Vorontsov <cbouatmailru@gmail.com>");
 MODULE_LICENSE("GPL");
-- 
2.18.0

