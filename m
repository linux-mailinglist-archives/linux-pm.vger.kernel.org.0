Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFA35B1467
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 20:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfILS0c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Sep 2019 14:26:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39549 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfILS0c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2019 14:26:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so13894703pgi.6;
        Thu, 12 Sep 2019 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=16RAWRckcie+V9oI/6PZrjOMSfXV1PuRqJWQkGoociA=;
        b=Zs/x+6ihUxdRh3Di/Xv7kRptkUwioSJUSmFuHUeFZIyjBnwGf0Ib5R09DisS9N7Zsd
         zAGTvEBCRbDJCFz2XX1hrCKloqXaTrCRFdkBmhr7jDE8mJEIODyct2x8h4dxxYa9IGFk
         AMGKx28vk9JNXLqwuwG04jX7AHpPH1cOsOinvDMPYjYXeyEcukmgf507rWGh7UBjIJVR
         xd2q+PDHIHS9Fbr/S0Xj5Q4y1w/cuwa+CG2gioYwvhBAHNyCLdkuGy/cb8sWIV6W7mV5
         MYd0ETzbXkl+py7rQw6I0lDaB2opkPUzuGol5DVG7os4mSFDsibN6u2TCrSbEO9bi44H
         bjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=16RAWRckcie+V9oI/6PZrjOMSfXV1PuRqJWQkGoociA=;
        b=DzJGGLNJRBYi8IKpMFV26eyVEawlbQJ5AsSZjalg8o13mQp9FYNQmFlX2XpNWmITsx
         trTN433qQEJWvHSDlQ+ZtNDp98KRLbxYZ6+9y5FgHgyy+XwMkfaXcg5q6XtgysRr007E
         gQDVJLOanhhOg5vVRlqd/J8RnFT1w2f3u3bHbigd2PpmAUB0D73KEf5lfRAG9g0Zn0bk
         G76t+XEhnZhE3lyH25AOH4PuR7HwTSnvwt2RF/aiLR4wUCIvDHuAPDVlOcsbcpAyEt63
         7LB8IGQ57nbS/57q5fYtgP7qTEzdBW5kARk27vFakzlBGYTXL9jwtYr9P6AZeLEq99ox
         sT1Q==
X-Gm-Message-State: APjAAAUzpVwFjnJUJNqE0aUUqV3cGWWwK8lpIQuYlna/wKvq2NtYtSni
        DGZzmO6BrTdWu0vdyKZmz9Y=
X-Google-Smtp-Source: APXvYqy5c50GltAl+kKInt13PhiVj7hdgfYsMKoWVysjItsDA5w7rBOLXYV1yajOhJMzqnZplbjCzQ==
X-Received: by 2002:a63:5754:: with SMTP id h20mr38137589pgm.195.1568312791454;
        Thu, 12 Sep 2019 11:26:31 -0700 (PDT)
Received: from localhost.localdomain (61-231-52-128.dynamic-ip.hinet.net. [61.231.52.128])
        by smtp.gmail.com with ESMTPSA id r1sm20747382pgv.70.2019.09.12.11.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 11:26:31 -0700 (PDT)
From:   lecopzer@gmail.com
X-Google-Original-From: lecopzer.chen@mediatek.com
To:     lecopzer@gmail.com, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yj.chiang@mediatek.com, lecopzer.chen@mediatek.com
Subject: [PATCH v2 2/2] test_power: Add CURRENT properties
Date:   Fri, 13 Sep 2019 02:26:00 +0800
Message-Id: <20190912182600.24211-3-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912182600.24211-1-lecopzer.chen@mediatek.com>
References: <20190912182600.24211-1-lecopzer.chen@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CURRENT is really general in other battery drivers,
Android also has an interface to monitor CURRENT, so let's
add it into test framework.

The default value (1.6A) is just a random but reasonable value.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 drivers/power/supply/test_power.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index 70db8d20e138..65c23ef6408d 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -34,6 +34,7 @@ static int battery_technology		= POWER_SUPPLY_TECHNOLOGY_LION;
 static int battery_capacity		= 50;
 static int battery_voltage		= 3300;
 static int battery_charge_counter	= -1000;
+static int battery_current		= 1600;
 
 static bool module_initialized;
 
@@ -118,6 +119,10 @@ static int test_power_get_battery_property(struct power_supply *psy,
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
@@ -149,6 +154,8 @@ static enum power_supply_property test_power_battery_props[] = {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	POWER_SUPPLY_PROP_TEMP,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
 static char *test_power_ac_supplied_to[] = {
@@ -467,6 +474,21 @@ static int param_set_battery_charge_counter(const char *key,
 
 #define param_get_battery_charge_counter param_get_int
 
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
@@ -512,6 +534,11 @@ static const struct kernel_param_ops param_ops_battery_charge_counter = {
 	.get = param_get_battery_charge_counter,
 };
 
+static const struct kernel_param_ops param_ops_battery_current = {
+	.set = param_set_battery_current,
+	.get = param_get_battery_current,
+};
+
 #define param_check_ac_online(name, p) __param_check(name, p, void);
 #define param_check_usb_online(name, p) __param_check(name, p, void);
 #define param_check_battery_status(name, p) __param_check(name, p, void);
@@ -521,6 +548,7 @@ static const struct kernel_param_ops param_ops_battery_charge_counter = {
 #define param_check_battery_capacity(name, p) __param_check(name, p, void);
 #define param_check_battery_voltage(name, p) __param_check(name, p, void);
 #define param_check_battery_charge_counter(name, p) __param_check(name, p, void);
+#define param_check_battery_current(name, p) __param_check(name, p, void);
 
 
 module_param(ac_online, ac_online, 0644);
@@ -555,6 +583,9 @@ module_param(battery_charge_counter, battery_charge_counter, 0644);
 MODULE_PARM_DESC(battery_charge_counter,
 	"battery charge counter (microampere-hours)");
 
+module_param(battery_current, battery_current, 0644);
+MODULE_PARM_DESC(battery_current, "battery current (milliampere)");
+
 MODULE_DESCRIPTION("Power supply driver for testing");
 MODULE_AUTHOR("Anton Vorontsov <cbouatmailru@gmail.com>");
 MODULE_LICENSE("GPL");
-- 
2.17.1

