Return-Path: <linux-pm+bounces-8774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 530129000F4
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 12:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13D71F25970
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 10:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4560215E5CD;
	Fri,  7 Jun 2024 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPbSdKdN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8315E5BD
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756369; cv=none; b=f6eHaVxwNWjrfsgDPX9i2DSABRINcMiM6/ErAT6gMRlJX9V/6I+g7GH9+OHxDTwaMqWZuQXfvw86d6xLpXxG2Fc4D/cNPaiOWHQzd+CG2bMjiT4P+mMjB/RVuPm9zG+kJwdMtMSYcEElTiic3bpKvbRHvImoGU0Nq3dFsea4Cck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756369; c=relaxed/simple;
	bh=kjiRR/aTqwtnPBdziJVOFsjsB2oelRJFCXGyR0bGHuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qdfF8mig1kyooZMmooyJLnU/jVDtSC9V2nMty1cIw7yXDP+Dc+1o3/0QwmZLzLZs+SX0mk4bHur6VyhEDmgwYgZarmP3S3hi/OB/WBE+tWXl860oUtDMLJNgJqBMYt6OD4B4TMnoVCvQDiM2QWWFYlEg7iFs4iPb3eMRc02Pw04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RPbSdKdN; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b840cfecdso2306956e87.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 03:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717756363; x=1718361163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGOHmSlS5KUbXp4q4upOjoea9Ddg/UJrl7ZqS3zOIXU=;
        b=RPbSdKdNHRo6+CLb7ZfNhXGn7096jpwDBN6aYGJgrEG/ruwPhZgHuL1UBi5+pWo1Ik
         kwt5lDoAvmhRkk1Dn5I6tFcGbpuJizBBSG1JGyLn0kM+6/HvdO19CMYa9FArLkvklg4A
         yfbtsvVBnvWzgIOtWoUcYhrqw36lUgTCQW7UeXbfjjj+8EyQS4RCARF8GMJxXkhWzSdH
         1YmJxNb5a6eZEH5icVCN8KufWOCakP3V58EP9B+PRTCDRVHqfBTZR/zZ0CiLAXH9JXFf
         fv5R681XriAb8cHQ0YHa1AUccVUmuiv61BfD6ZytbnSHfCOWU5946JUBEsq2TzOUPLpE
         boGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717756363; x=1718361163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGOHmSlS5KUbXp4q4upOjoea9Ddg/UJrl7ZqS3zOIXU=;
        b=NEyOtz8VKuD3a4qglDI4EGZ/KiHEJNYXUcghhddRphJbUKndc7LP03D15Je0rcnhJv
         /pdXAEZ3edR3Yfp5iB2rEU96b42bO5+X7fBNGwCJugEqovdcke4b7NN5Wb3e7uvph+aJ
         0piUziPxlu3lkyhweSDn61F1JnNqC+pkqWjl0qXX5YLvB6tyHwSWMyZqOsOlxvB3vUWh
         LGBKKlSSiz7KzsD5YP7BdPcgFlhM2zwEf8bTCYy+Kafj4WGHNNbty6NEzFNTQUb2SAjb
         p9Huis9e9zmXphNteglW6pb5vo6zNuoUzae6q4X7WsAb17G6dzoViP0nftPTk7tBak4h
         AypQ==
X-Gm-Message-State: AOJu0Yy77WVNa1W5YP7knNgueCp+LVB8r4ukuKnJQluDx3Z5kvfoNhaP
	adqO0SK9fYuzsIEYeG9xFPr9Tzs0dRUA3yhw1Z6H7Dk+ZPu0LB5gEt7q4Y7+xqo=
X-Google-Smtp-Source: AGHT+IG4m7qZ8X5VgyrW0zdfzU2tMn3NcMlWGFktvumKrJTJZOmNKHvk3JwV9O5ShSQeULCHFc0O2w==
X-Received: by 2002:ac2:539a:0:b0:529:b796:1c9 with SMTP id 2adb3069b0e04-52bb9f695cdmr1268386e87.3.1717756363250;
        Fri, 07 Jun 2024 03:32:43 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb433ccdbsm483448e87.283.2024.06.07.03.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:32:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 07 Jun 2024 13:32:39 +0300
Subject: [PATCH v5 4/6] power: supply: lenovo_yoga_c630_battery: add Lenovo
 C630 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-yoga-ec-driver-v5-4-1ac91a0b4326@linaro.org>
References: <20240607-yoga-ec-driver-v5-0-1ac91a0b4326@linaro.org>
In-Reply-To: <20240607-yoga-ec-driver-v5-0-1ac91a0b4326@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16012;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=kjiRR/aTqwtnPBdziJVOFsjsB2oelRJFCXGyR0bGHuo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmYuHGdy5wgY7UnTWckHkmmNm/tIJDXlrpi53yY
 71BQtBL5CiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmLhxgAKCRCLPIo+Aiko
 1dFbB/9wooLiEIUANd/OzpXPFmQqUgu9HaAjHnqtOcudAywDNfSmgywP54seFziKjnCSUb5Sgcf
 oareLLVjtY0GTI+5vCJNHf9sYBLCXcSiuZfo1TfiJr7TWave+UQxe0sguxE90Ors4tOTC32gFHd
 zbSlxmgTxYbWcEcBrgJnLMykK9krotCK3Rm0SXOBb1yzmT1lGOg1zC6VQXGnW/11+AQwecRDjOM
 dh/3Uuikcu5PZ+17gnL3VH9p7sfaMmvC11kBhnNoqrV8RTgHNtaAJiVCs1D9Vb/vAWaKvr/TKCm
 uX34m4Dj4Xo02sMFlnrSCkS4aVvNPG73oZHq52aKS7+xHcGa
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On the Lenovo Yoga C630 WOS laptop the EC provides access to the adapter
and battery status. Add the driver to read power supply status on the
laptop.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/power/supply/Kconfig                    |   9 +
 drivers/power/supply/Makefile                   |   1 +
 drivers/power/supply/lenovo_yoga_c630_battery.c | 500 ++++++++++++++++++++++++
 3 files changed, 510 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 3e31375491d5..55ab8e90747d 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -167,6 +167,15 @@ config BATTERY_LEGO_EV3
 	help
 	  Say Y here to enable support for the LEGO MINDSTORMS EV3 battery.
 
+config BATTERY_LENOVO_YOGA_C630
+	tristate "Lenovo Yoga C630 battery"
+	depends on OF && EC_LENOVO_YOGA_C630
+	help
+	  This driver enables battery support on the Lenovo Yoga C630 laptop.
+
+	  To compile the driver as a module, choose M here: the module will be
+	  called lenovo_yoga_c630_battery.
+
 config BATTERY_PMU
 	tristate "Apple PMU battery"
 	depends on PPC32 && ADB_PMU
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 58b567278034..8ebbdcf92dac 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_BATTERY_DS2782)	+= ds2782_battery.o
 obj-$(CONFIG_BATTERY_GAUGE_LTC2941)	+= ltc2941-battery-gauge.o
 obj-$(CONFIG_BATTERY_GOLDFISH)	+= goldfish_battery.o
 obj-$(CONFIG_BATTERY_LEGO_EV3)	+= lego_ev3_battery.o
+obj-$(CONFIG_BATTERY_LENOVO_YOGA_C630) += lenovo_yoga_c630_battery.o
 obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
 obj-$(CONFIG_BATTERY_QCOM_BATTMGR)	+= qcom_battmgr.o
 obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
diff --git a/drivers/power/supply/lenovo_yoga_c630_battery.c b/drivers/power/supply/lenovo_yoga_c630_battery.c
new file mode 100644
index 000000000000..0013994a22a0
--- /dev/null
+++ b/drivers/power/supply/lenovo_yoga_c630_battery.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2024, Linaro Ltd
+ * Authors:
+ *    Bjorn Andersson
+ *    Dmitry Baryshkov
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/power_supply.h>
+#include <linux/platform_data/lenovo-yoga-c630.h>
+
+struct yoga_c630_psy {
+	struct yoga_c630_ec *ec;
+	struct device *dev;
+	struct fwnode_handle *fwnode;
+	struct notifier_block nb;
+
+	/* guards all battery properties and registration of power supplies */
+	struct mutex lock;
+
+	struct power_supply *adp_psy;
+	struct power_supply *bat_psy;
+
+	unsigned long last_status_update;
+
+	bool adapter_online;
+
+	bool unit_mA;
+
+	bool bat_present;
+	unsigned int bat_status;
+	unsigned int design_capacity;
+	unsigned int design_voltage;
+	unsigned int full_charge_capacity;
+
+	unsigned int capacity_now;
+	unsigned int voltage_now;
+
+	int current_now;
+	int rate_now;
+};
+
+#define LENOVO_EC_CACHE_TIME		(10 * HZ)
+
+#define LENOVO_EC_ADPT_STATUS		0xa3
+#define LENOVO_EC_ADPT_STATUS_PRESENT		BIT(7)
+#define LENOVO_EC_BAT_ATTRIBUTES	0xc0
+#define LENOVO_EC_BAT_ATTRIBUTES_UNIT_IS_MA	BIT(1)
+#define LENOVO_EC_BAT_STATUS		0xc1
+#define LENOVO_EC_BAT_STATUS_DISCHARGING	BIT(0)
+#define LENOVO_EC_BAT_STATUS_CHARGING		BIT(1)
+#define LENOVO_EC_BAT_REMAIN_CAPACITY	0xc2
+#define LENOVO_EC_BAT_VOLTAGE		0xc6
+#define LENOVO_EC_BAT_DESIGN_VOLTAGE	0xc8
+#define LENOVO_EC_BAT_DESIGN_CAPACITY	0xca
+#define LENOVO_EC_BAT_FULL_CAPACITY	0xcc
+#define LENOVO_EC_BAT_CURRENT		0xd2
+#define LENOVO_EC_BAT_FULL_FACTORY	0xd6
+#define LENOVO_EC_BAT_PRESENT		0xda
+#define LENOVO_EC_BAT_PRESENT_IS_PRESENT	BIT(0)
+#define LENOVO_EC_BAT_FULL_REGISTER	0xdb
+#define LENOVO_EC_BAT_FULL_REGISTER_IS_FACTORY	BIT(0)
+
+/* the mutex should already be locked */
+static int yoga_c630_psy_update_bat_info(struct yoga_c630_psy *ecbat)
+{
+	struct yoga_c630_ec *ec = ecbat->ec;
+	int val;
+
+	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_PRESENT);
+	if (val < 0)
+		return val;
+	ecbat->bat_present = !!(val & LENOVO_EC_BAT_PRESENT_IS_PRESENT);
+	if (!ecbat->bat_present)
+		return val;
+
+	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_ATTRIBUTES);
+	if (val < 0)
+		return val;
+	ecbat->unit_mA = val & LENOVO_EC_BAT_ATTRIBUTES_UNIT_IS_MA;
+
+	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_DESIGN_CAPACITY);
+	if (val < 0)
+		return val;
+	ecbat->design_capacity = val * 1000;
+
+	/*
+	 * DSDT has delays after most of EC reads in these methods.
+	 * Having no documentation for the EC we have to follow and sleep here.
+	 */
+	msleep(50);
+
+	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_DESIGN_VOLTAGE);
+	if (val < 0)
+		return val;
+	ecbat->design_voltage = val;
+
+	msleep(50);
+
+	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_FULL_REGISTER);
+	if (val < 0)
+		return val;
+	val = yoga_c630_ec_read16(ec,
+				  val & LENOVO_EC_BAT_FULL_REGISTER_IS_FACTORY ?
+				  LENOVO_EC_BAT_FULL_FACTORY :
+				  LENOVO_EC_BAT_FULL_CAPACITY);
+	if (val < 0)
+		return val;
+
+	ecbat->full_charge_capacity = val * 1000;
+
+	if (!ecbat->unit_mA) {
+		ecbat->design_capacity *= 10;
+		ecbat->full_charge_capacity *= 10;
+	}
+
+	return 0;
+}
+
+static int yoga_c630_psy_maybe_update_bat_status(struct yoga_c630_psy *ecbat)
+{
+	struct yoga_c630_ec *ec = ecbat->ec;
+	int current_mA;
+	int val;
+
+	scoped_guard(mutex, &ecbat->lock) {
+		if (time_before(jiffies, ecbat->last_status_update + LENOVO_EC_CACHE_TIME))
+			return 0;
+
+		val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_STATUS);
+		if (val < 0)
+			return val;
+		ecbat->bat_status = val;
+
+		msleep(50);
+
+		val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_REMAIN_CAPACITY);
+		if (val < 0)
+			return val;
+		ecbat->capacity_now = val * 1000;
+
+		msleep(50);
+
+		val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_VOLTAGE);
+		if (val < 0)
+			return val;
+		ecbat->voltage_now = val * 1000;
+
+		msleep(50);
+
+		val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_CURRENT);
+		if (val < 0)
+			return val;
+		current_mA = sign_extend32(val, 15);
+		ecbat->current_now = current_mA * 1000;
+		ecbat->rate_now = current_mA * (ecbat->voltage_now / 1000);
+
+		msleep(50);
+
+		if (!ecbat->unit_mA)
+			ecbat->capacity_now *= 10;
+
+		ecbat->last_status_update = jiffies;
+	}
+
+	return 0;
+}
+
+static int yoga_c630_psy_update_adapter_status(struct yoga_c630_psy *ecbat)
+{
+	struct yoga_c630_ec *ec = ecbat->ec;
+	int val;
+
+	scoped_guard(mutex, &ecbat->lock) {
+		val = yoga_c630_ec_read8(ec, LENOVO_EC_ADPT_STATUS);
+		if (val < 0)
+			return val;
+
+		ecbat->adapter_online = !!(val & LENOVO_EC_ADPT_STATUS_PRESENT);
+	}
+
+	return 0;
+}
+
+static bool yoga_c630_psy_is_charged(struct yoga_c630_psy *ecbat)
+{
+	if (ecbat->bat_status != 0)
+		return false;
+
+	if (ecbat->full_charge_capacity <= ecbat->capacity_now)
+		return true;
+
+	if (ecbat->design_capacity <= ecbat->capacity_now)
+		return true;
+
+	return false;
+}
+
+static int yoga_c630_psy_bat_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	struct yoga_c630_psy *ecbat = power_supply_get_drvdata(psy);
+	int rc = 0;
+
+	if (!ecbat->bat_present && psp != POWER_SUPPLY_PROP_PRESENT)
+		return -ENODEV;
+
+	rc = yoga_c630_psy_maybe_update_bat_status(ecbat);
+	if (rc)
+		return rc;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (ecbat->bat_status & LENOVO_EC_BAT_STATUS_DISCHARGING)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (ecbat->bat_status & LENOVO_EC_BAT_STATUS_CHARGING)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (yoga_c630_psy_is_charged(ecbat))
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = ecbat->bat_present;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		val->intval = ecbat->design_voltage;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+		val->intval = ecbat->design_capacity;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+	case POWER_SUPPLY_PROP_ENERGY_FULL:
+		val->intval = ecbat->full_charge_capacity;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+	case POWER_SUPPLY_PROP_ENERGY_NOW:
+		val->intval = ecbat->capacity_now;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = ecbat->current_now;
+		break;
+	case POWER_SUPPLY_PROP_POWER_NOW:
+		val->intval = ecbat->rate_now;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = ecbat->voltage_now;
+		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = "PABAS0241231";
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = "Compal";
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
+		break;
+	default:
+		rc = -EINVAL;
+		break;
+	}
+
+	return rc;
+}
+
+static enum power_supply_property yoga_c630_psy_bat_mA_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SCOPE,
+};
+
+static enum power_supply_property yoga_c630_psy_bat_mWh_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
+	POWER_SUPPLY_PROP_ENERGY_FULL,
+	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SCOPE,
+};
+
+static const struct power_supply_desc yoga_c630_psy_bat_psy_desc_mA = {
+	.name = "yoga-c630-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = yoga_c630_psy_bat_mA_properties,
+	.num_properties = ARRAY_SIZE(yoga_c630_psy_bat_mA_properties),
+	.get_property = yoga_c630_psy_bat_get_property,
+};
+
+static const struct power_supply_desc yoga_c630_psy_bat_psy_desc_mWh = {
+	.name = "yoga-c630-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = yoga_c630_psy_bat_mWh_properties,
+	.num_properties = ARRAY_SIZE(yoga_c630_psy_bat_mWh_properties),
+	.get_property = yoga_c630_psy_bat_get_property,
+};
+
+static int yoga_c630_psy_adpt_get_property(struct power_supply *psy,
+					  enum power_supply_property psp,
+					  union power_supply_propval *val)
+{
+	struct yoga_c630_psy *ecbat = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	ret = yoga_c630_psy_update_adapter_status(ecbat);
+	if (ret < 0)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = ecbat->adapter_online;
+		break;
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = POWER_SUPPLY_USB_TYPE_C;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static enum power_supply_property yoga_c630_psy_adpt_properties[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_USB_TYPE,
+};
+
+static const enum power_supply_usb_type yoga_c630_psy_adpt_usb_type[] = {
+	POWER_SUPPLY_USB_TYPE_C,
+};
+
+static const struct power_supply_desc yoga_c630_psy_adpt_psy_desc = {
+	.name = "yoga-c630-adapter",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.usb_types = yoga_c630_psy_adpt_usb_type,
+	.num_usb_types = ARRAY_SIZE(yoga_c630_psy_adpt_usb_type),
+	.properties = yoga_c630_psy_adpt_properties,
+	.num_properties = ARRAY_SIZE(yoga_c630_psy_adpt_properties),
+	.get_property = yoga_c630_psy_adpt_get_property,
+};
+
+static int yoga_c630_psy_register_bat_psy(struct yoga_c630_psy *ecbat)
+{
+	struct power_supply_config bat_cfg = {};
+
+	bat_cfg.drv_data = ecbat;
+	bat_cfg.fwnode = ecbat->fwnode;
+	ecbat->bat_psy = power_supply_register_no_ws(ecbat->dev,
+						     ecbat->unit_mA ?
+						     &yoga_c630_psy_bat_psy_desc_mA :
+						     &yoga_c630_psy_bat_psy_desc_mWh,
+						     &bat_cfg);
+	if (IS_ERR(ecbat->bat_psy)) {
+		dev_err(ecbat->dev, "failed to register battery supply\n");
+		return PTR_ERR(ecbat->bat_psy);
+	}
+
+	return 0;
+}
+
+static void yoga_c630_ec_refresh_bat_info(struct yoga_c630_psy *ecbat)
+{
+	bool current_unit;
+
+	scoped_guard(mutex, &ecbat->lock) {
+		current_unit = ecbat->unit_mA;
+
+		yoga_c630_psy_update_bat_info(ecbat);
+
+		if (current_unit != ecbat->unit_mA) {
+			power_supply_unregister(ecbat->bat_psy);
+			yoga_c630_psy_register_bat_psy(ecbat);
+		}
+	}
+}
+
+static int yoga_c630_psy_notify(struct notifier_block *nb,
+				unsigned long action, void *data)
+{
+	struct yoga_c630_psy *ecbat = container_of(nb, struct yoga_c630_psy, nb);
+
+	switch (action) {
+	case LENOVO_EC_EVENT_BAT_INFO:
+		yoga_c630_ec_refresh_bat_info(ecbat);
+		break;
+	case LENOVO_EC_EVENT_BAT_ADPT_STATUS:
+		power_supply_changed(ecbat->adp_psy);
+		fallthrough;
+	case LENOVO_EC_EVENT_BAT_STATUS:
+		power_supply_changed(ecbat->bat_psy);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int yoga_c630_psy_probe(struct auxiliary_device *adev,
+				   const struct auxiliary_device_id *id)
+{
+	struct yoga_c630_ec *ec = adev->dev.platform_data;
+	struct power_supply_config adp_cfg = {};
+	struct device *dev = &adev->dev;
+	struct yoga_c630_psy *ecbat;
+	int ret;
+
+	ecbat = devm_kzalloc(&adev->dev, sizeof(*ecbat), GFP_KERNEL);
+	if (!ecbat)
+		return -ENOMEM;
+
+	ecbat->ec = ec;
+	ecbat->dev = dev;
+	mutex_init(&ecbat->lock);
+	ecbat->fwnode = adev->dev.parent->fwnode;
+	ecbat->nb.notifier_call = yoga_c630_psy_notify;
+
+	auxiliary_set_drvdata(adev, ecbat);
+
+	adp_cfg.drv_data = ecbat;
+	adp_cfg.fwnode = ecbat->fwnode;
+	adp_cfg.supplied_to = (char **)&yoga_c630_psy_bat_psy_desc_mA.name;
+	adp_cfg.num_supplicants = 1;
+	ecbat->adp_psy = devm_power_supply_register_no_ws(dev, &yoga_c630_psy_adpt_psy_desc, &adp_cfg);
+	if (IS_ERR(ecbat->adp_psy)) {
+		dev_err(dev, "failed to register AC adapter supply\n");
+		return PTR_ERR(ecbat->adp_psy);
+	}
+
+	scoped_guard(mutex, &ecbat->lock) {
+		ret = yoga_c630_psy_update_bat_info(ecbat);
+		if (ret)
+			goto err_unreg_bat;
+
+		ret = yoga_c630_psy_register_bat_psy(ecbat);
+		if (ret)
+			goto err_unreg_bat;
+	}
+
+	ret = yoga_c630_ec_register_notify(ecbat->ec, &ecbat->nb);
+	if (ret)
+		goto err_unreg_bat;
+
+	return 0;
+
+err_unreg_bat:
+	power_supply_unregister(ecbat->bat_psy);
+	return ret;
+}
+
+static void yoga_c630_psy_remove(struct auxiliary_device *adev)
+{
+	struct yoga_c630_psy *ecbat = auxiliary_get_drvdata(adev);
+
+	yoga_c630_ec_unregister_notify(ecbat->ec, &ecbat->nb);
+	power_supply_unregister(ecbat->bat_psy);
+}
+
+static const struct auxiliary_device_id yoga_c630_psy_id_table[] = {
+	{ .name = YOGA_C630_MOD_NAME "." YOGA_C630_DEV_PSY, },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, yoga_c630_psy_id_table);
+
+static struct auxiliary_driver yoga_c630_psy_driver = {
+	.name = YOGA_C630_DEV_PSY,
+	.id_table = yoga_c630_psy_id_table,
+	.probe = yoga_c630_psy_probe,
+	.remove = yoga_c630_psy_remove,
+};
+
+module_auxiliary_driver(yoga_c630_psy_driver);
+
+MODULE_DESCRIPTION("Lenovo Yoga C630 psy");
+MODULE_LICENSE("GPL");

-- 
2.39.2


