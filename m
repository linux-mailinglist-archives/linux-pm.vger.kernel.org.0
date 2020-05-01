Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65171C1918
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgEAPLX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 11:11:23 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:3422 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbgEAPLW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 11:11:22 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49DG135MzJzT9;
        Fri,  1 May 2020 17:11:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588345879; bh=+wIBzwrX5ahM3oS+NP3Mk3ATTvfRc5hfitHIs59H+xs=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=BUm2psIrv7/tgPPi3w476tQfxw4xkF+moTcpOsSPp0367jZYtSf7b9p4w+5j7NYIe
         0Uozy6M7WZ6JJruFalZHmmAygDAkNkwJ3z7aKQm48NMqjbVLOhdo8L3zZ7wmtEhB9H
         2U3UZXELmHcmqYrYJIpv7j2BOj5jV/WFMraL3H047m4eCK6MGJXRE6Wvf/bPQ+Di/d
         lTO1ynXjqlod6buVN7KTWzBpqn9FGfi0N3ow1dym0SIV3ZOfN306ipGZs+cP65WDN6
         E+CVQBKaF18ZNbXTGLs/KafztaCeE8MsVdOd730z3YRjx7aKZAJ6dQvWL9K0wzCqHm
         gNWGKr9ZUdSBg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 01 May 2020 17:11:19 +0200
Message-Id: <d7728c3de2bbdcf496474a0f7ce4cb0d1c62bb71.1588345420.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588345420.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588345420.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 3/4] power: supply: core: add output voltage measurements
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for supply output voltage to be measured and configured.
This might be different from the voltage on the storage element (battery).

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/power_supply_hwmon.c | 25 +++++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c |  3 +++
 include/linux/power_supply.h              |  3 +++
 3 files changed, 31 insertions(+)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 3863b2a73ecf..626a344fbad1 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -16,6 +16,7 @@ struct power_supply_hwmon {
 static const char *const ps_input_label[] = {
 	"battery",
 	"external source",
+	"load",
 };
 
 static const char *const ps_temp_label[] = {
@@ -51,6 +52,20 @@ static int power_supply_hwmon_in1_to_property(u32 attr)
 	}
 }
 
+static int power_supply_hwmon_in2_to_property(u32 attr)
+{
+	switch (attr) {
+	case hwmon_in_min:
+		return POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_MIN;
+	case hwmon_in_max:
+		return POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_MAX;
+	case hwmon_in_input:
+		return POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_NOW;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int power_supply_hwmon_in_to_property(u32 attr, int channel)
 {
 	switch (channel) {
@@ -58,6 +73,8 @@ static int power_supply_hwmon_in_to_property(u32 attr, int channel)
 		return power_supply_hwmon_in0_to_property(attr);
 	case 1:
 		return power_supply_hwmon_in1_to_property(attr);
+	case 2:
+		return power_supply_hwmon_in2_to_property(attr);
 	default:
 		return -EINVAL;
 	}
@@ -399,6 +416,11 @@ static const struct hwmon_channel_info *power_supply_hwmon_info[] = {
 
 			   HWMON_I_LABEL   |
 			   HWMON_I_MAX     |
+			   HWMON_I_INPUT,
+
+			   HWMON_I_LABEL   |
+			   HWMON_I_MIN     |
+			   HWMON_I_MAX     |
 			   HWMON_I_INPUT),
 
 	NULL
@@ -469,6 +491,9 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 		case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		case POWER_SUPPLY_PROP_INPUT_VOLTAGE_NOW:
 		case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+		case POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_MIN:
+		case POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_MAX:
+		case POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_NOW:
 			set_bit(prop, psyhw->props);
 			break;
 		default:
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 1d1fb69516a8..fb6f113b52bb 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -278,6 +278,9 @@ static struct device_attribute power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(input_voltage_now),
 	POWER_SUPPLY_ATTR(input_voltage_limit),
 	POWER_SUPPLY_ATTR(input_power_limit),
+	POWER_SUPPLY_ATTR(output_voltage_now),
+	POWER_SUPPLY_ATTR(output_voltage_min),
+	POWER_SUPPLY_ATTR(output_voltage_max),
 	POWER_SUPPLY_ATTR(energy_full_design),
 	POWER_SUPPLY_ATTR(energy_empty_design),
 	POWER_SUPPLY_ATTR(energy_full),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 5313d1284aad..f1ff8d230488 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -132,6 +132,9 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_INPUT_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
 	POWER_SUPPLY_PROP_INPUT_POWER_LIMIT,
+	POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_FULL,
-- 
2.20.1

