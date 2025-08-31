Return-Path: <linux-pm+bounces-33487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4C7B3D2D8
	for <lists+linux-pm@lfdr.de>; Sun, 31 Aug 2025 14:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A9717B2BE
	for <lists+linux-pm@lfdr.de>; Sun, 31 Aug 2025 12:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26150257AC6;
	Sun, 31 Aug 2025 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEi7jVH2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00934273FD
	for <linux-pm@vger.kernel.org>; Sun, 31 Aug 2025 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756643392; cv=none; b=k45qq0OPnl8U47XXr6GJ08f7nK4zqxF1pHC1WMKi9hXZZluTo4gGFK+I/YubN3xGd72IRez1RuNUHFRRh8+eE+bgX1qk2RKk0Eyx6TwsJNiZBTgukHRdwigAlaItFw1upjBcomf9Y6lV/oX/6NkFpTF4VQPHgh69i3z/H4Ja8jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756643392; c=relaxed/simple;
	bh=f8JzYlA0AsmCJv22o5UFC9wx7UKX7AiD6IbVLe+GBEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/GWUXMZdOkd8qIvlmA2/vSJ9FTDLu23rEM77wUnuMFjegkhHDJfAsmTUwjNAzjNcDSPBVFHzyk9+kr/0p+udLS2Vuwe/PesGf6CciRyRx5J1ieq5l1qQVrqI8mPueU/WR7KkhyElcmaZzXIE26cmvWm0EMBj5Z0Dzds8LGPtEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEi7jVH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D96C4CEF5;
	Sun, 31 Aug 2025 12:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756643391;
	bh=f8JzYlA0AsmCJv22o5UFC9wx7UKX7AiD6IbVLe+GBEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hEi7jVH2zJ13w6EJ/eqk9FeOhhdaLrUUCRVXpIblXD32lTTJ1wPgU0cJuR6MUeB7u
	 miCsOPXjsjFDq4CJCCnywgDnuG7NjOfLWZAxE4GbKuUDsZVIwVDp4XQF5Xx5y82Xjz
	 VAF8QoHQYIXBkOjLNsJvLyE0iEvxdeKFTDkriDEdyuHY8ii19vfv2T2KsyQTFqKb52
	 OAhMZFmsGqLTwclgV8xMCOW86qzVtyZeT2/vpSoOMxA543J1kiBNIEjq2TGYUvLsOq
	 WVn1gpPa/g/dAt/hq9Wv3ehfCYji50+4uF0oW7TgEf7Bvcp1C3Npeh1mzXNMTlLR7s
	 f/nyZhTMoKpcQ==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 4/5] power: supply: adc-battery-helper: Add support for optional charge_finished GPIO
Date: Sun, 31 Aug 2025 14:29:40 +0200
Message-ID: <20250831122942.47875-5-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831122942.47875-1-hansg@kernel.org>
References: <20250831122942.47875-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Charger ICs often have a status pin which indicates when the charger has
finished charging the battery. Sometimes the status of this pin can be
read over a GPIO.

Add support for optionally reading a charge-finished GPIO and when
available use this to determine when to return POWER_SUPPLY_STATUS_FULL.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/power/supply/adc-battery-helper.c | 18 +++++++++++++++---
 drivers/power/supply/adc-battery-helper.h |  5 ++++-
 drivers/power/supply/ug3105_battery.c     |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/adc-battery-helper.c b/drivers/power/supply/adc-battery-helper.c
index f8f6d2f8ec89..229b49fef8ad 100644
--- a/drivers/power/supply/adc-battery-helper.c
+++ b/drivers/power/supply/adc-battery-helper.c
@@ -51,6 +51,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/devm-helpers.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mutex.h>
 #include <linux/power_supply.h>
 #include <linux/workqueue.h>
@@ -82,8 +83,17 @@ static int adc_battery_helper_get_status(struct adc_battery_helper *help)
 	if (help->curr_ua < -CURR_HYST_UA)
 		return POWER_SUPPLY_STATUS_DISCHARGING;
 
-	if (help->supplied && help->ocv_avg_uv > full_uv)
-		return POWER_SUPPLY_STATUS_FULL;
+	if (help->supplied) {
+		bool full;
+
+		if (help->charge_finished)
+			full = gpiod_get_value_cansleep(help->charge_finished);
+		else
+			full = help->ocv_avg_uv > full_uv;
+
+		if (full)
+			return POWER_SUPPLY_STATUS_FULL;
+	}
 
 	return POWER_SUPPLY_STATUS_NOT_CHARGING;
 }
@@ -255,13 +265,15 @@ static void adc_battery_helper_start_work(struct adc_battery_helper *help)
 }
 
 int adc_battery_helper_init(struct adc_battery_helper *help, struct power_supply *psy,
-			    adc_battery_helper_get_func get_voltage_and_current_now)
+			    adc_battery_helper_get_func get_voltage_and_current_now,
+			    struct gpio_desc *charge_finished_gpio)
 {
 	struct device *dev = psy->dev.parent;
 	int ret;
 
 	help->psy = psy;
 	help->get_voltage_and_current_now = get_voltage_and_current_now;
+	help->charge_finished = charge_finished_gpio;
 
 	ret = devm_mutex_init(dev, &help->lock);
 	if (ret)
diff --git a/drivers/power/supply/adc-battery-helper.h b/drivers/power/supply/adc-battery-helper.h
index 90c7edcb9ab1..4e42181c8983 100644
--- a/drivers/power/supply/adc-battery-helper.h
+++ b/drivers/power/supply/adc-battery-helper.h
@@ -11,6 +11,7 @@
 #define ADC_BAT_HELPER_MOV_AVG_WINDOW_SIZE		8
 
 struct power_supply;
+struct gpio_desc;
 
 /*
  * The adc battery helper code needs voltage- and current-now to be sampled as
@@ -21,6 +22,7 @@ typedef int (*adc_battery_helper_get_func)(struct power_supply *psy, int *volt,
 
 struct adc_battery_helper {
 	struct power_supply *psy;
+	struct gpio_desc *charge_finished;
 	struct delayed_work work;
 	struct mutex lock;
 	adc_battery_helper_get_func get_voltage_and_current_now;
@@ -44,7 +46,8 @@ extern const enum power_supply_property adc_battery_helper_properties[];
 #define ADC_HELPER_NUM_PROPERTIES 7
 
 int adc_battery_helper_init(struct adc_battery_helper *help, struct power_supply *psy,
-			    adc_battery_helper_get_func get_voltage_and_current_now);
+			    adc_battery_helper_get_func get_voltage_and_current_now,
+			    struct gpio_desc *charge_finished_gpio);
 /*
  * The below functions can be directly used as power-supply / suspend-resume
  * callbacks. They cast the power_supply_get_drvdata() / dev_get_drvdata() data
diff --git a/drivers/power/supply/ug3105_battery.c b/drivers/power/supply/ug3105_battery.c
index c4d4ac859fa4..210e0f9aa5e0 100644
--- a/drivers/power/supply/ug3105_battery.c
+++ b/drivers/power/supply/ug3105_battery.c
@@ -161,7 +161,7 @@ static int ug3105_probe(struct i2c_client *client)
 	}
 
 	ret = adc_battery_helper_init(&chip->helper, chip->psy,
-				      ug3105_get_voltage_and_current_now);
+				      ug3105_get_voltage_and_current_now, NULL);
 	if (ret)
 		goto stop;
 
-- 
2.51.0


