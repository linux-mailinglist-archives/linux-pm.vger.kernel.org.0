Return-Path: <linux-pm+bounces-31201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97296B0C412
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 14:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB0A7A578F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0062D3EF5;
	Mon, 21 Jul 2025 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZCCRg+m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3C3C0C
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100779; cv=none; b=nGGgL3ptao9/R9fzsq5hfJNRy7jGkujEfWuWt2yPnv4GDMayJaf56v5jfTfnznqlJCgUVC4uEfCUmD31+IWFfanbr/MlAtdKBWs/L4R+TiqQHiPjTQniufnXwiz44QRxiB0yDt7CkEHvG7DP14/031EGaHdOMtjRzke9WbUs5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100779; c=relaxed/simple;
	bh=AggPZnw+FS9VEWVCRKo1WV2iCyG67iLyczgsV3wqJdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeNA4nkc3ZUI2aHMJhPYGV0iUVtmFJQqXSy006Ujz8w+BDQqC7ltBBmUxhWNHgpn8bTslHFcUZhr+Qiv53GljXGNBm7/R/7uUZCHEhqIoJJNg0YA+VAHtSsATFZP7WCIAfi8cZxPfZJ5goivf91H68/7ufkhTxrTIcSnbG/hrx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZCCRg+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F5EC4CEF4;
	Mon, 21 Jul 2025 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753100779;
	bh=AggPZnw+FS9VEWVCRKo1WV2iCyG67iLyczgsV3wqJdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZCCRg+mRAAwOtYji2cmGqGyfVZ0004R4sPGuNkI6jXc34+uLKJ37nVnmvM7wlNYC
	 KJEK9jrYomPGdt+XHwFhJ0BbEE0hu5hoorHuRp6v6+HLScCEmNLyj6xdgFhaUuYcM6
	 8smm8rnMuFewvlSXNKKtD9EZQjIY8V4uBg3Ad8IKZ1Gx583/aj1zuiS0y70V0RUuEV
	 PIpz5FVZ9WRgw8pfxmFzbIAJMCmlorWkI1UIyg3S+JpLogdgaeIpuyKDa/v4WGoW8G
	 NzOvYkctaa0a/lhf3WblJuYJeOIV8qaJZfDK6VeXfXcd/a+qSho59XIkgl4so/8mZs
	 /cz/fUSpu6zNg==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 4/5] power: supply: adc-battery-helper: Add support for optional charge_finished GPIO
Date: Mon, 21 Jul 2025 14:26:03 +0200
Message-ID: <20250721122605.46724-5-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250721122605.46724-1-hansg@kernel.org>
References: <20250721122605.46724-1-hansg@kernel.org>
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
index 919634db5472..c3e42a740496 100644
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
index 6daba08c1a21..1876c4239729 100644
--- a/drivers/power/supply/adc-battery-helper.h
+++ b/drivers/power/supply/adc-battery-helper.h
@@ -11,6 +11,7 @@
 #define ADC_BAT_HELPER_MOV_AVG_WINDOW				8
 
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
2.49.0


