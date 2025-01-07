Return-Path: <linux-pm+bounces-20029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC07A03DD4
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3AC1881A13
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CC91E9B33;
	Tue,  7 Jan 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+3HMkCd"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C00193062
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249642; cv=none; b=Jfs0AzdZZUSIIdhpaB2fBgktT564zDAjETzIGXZZsyrC6h7YQdsKDsl09sxngGvACSSHlCIedVgl40AVqOWJOIhllEJigIJZjDH/QivvCF2SpgP6rsHYYRWQiexeig92lyzWJDTaEnYyWV4XgfoxHQMfuCMYp7ZryNTCsm859AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249642; c=relaxed/simple;
	bh=0jCVoXfwkPdqDGnY8GcpKHxd1ubIEmBR1owdDIo0PHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rx+QruIPJ9xOqCc8X3sJ4DFmpv6KyG0tkraYKKn+7s9FWmouUGHJGSKN0IiXip3WX51YDRxpSke3elAtHsWQI9bllFBs4a31RGYXv+o9qOCOUtGxx39wORg30DSWy7kqt/JPyTtH+CVeHTQTyhi0racFwQ7GsUQPVzY22RW5zn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+3HMkCd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736249639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0SS7zJUPd6qKsHzZLusxlTLa3nUzQ6u+ZuWm3LWI4Q=;
	b=Y+3HMkCdCDGaDXblnjB+uVX8T3eVLP2EjFM43ZTgHGVCqUZppCzRbNFAQS+0t5tojwtKPJ
	fsYNcY9/nf2yKIx+dwmC6cVvX5wikBlBTWNlzYr2juVxLYTHZJBuH7sQJ8Ryo6pOT9kjv1
	yKK+RpqoSihVVObCyJuPZNdyeKo6DkI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-fN5r-WTgP_SKK_3Zpgz6Gw-1; Tue,
 07 Jan 2025 06:33:57 -0500
X-MC-Unique: fN5r-WTgP_SKK_3Zpgz6Gw-1
X-Mimecast-MFC-AGG-ID: fN5r-WTgP_SKK_3Zpgz6Gw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F0ED19560BC;
	Tue,  7 Jan 2025 11:33:57 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.144])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E826B3000197;
	Tue,  7 Jan 2025 11:33:55 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 5/6] power: supply: adc-battery-helper: Add support for optional charge_finished GPIO
Date: Tue,  7 Jan 2025 12:33:45 +0100
Message-ID: <20250107113346.170612-6-hdegoede@redhat.com>
In-Reply-To: <20250107113346.170612-1-hdegoede@redhat.com>
References: <20250107113346.170612-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Charger ICs often have a status pin which indicates when the charger has
finished charging the battery. Sometimes the status of this pin can be
read over a GPIO.

Add support for optionally reading a charge-finished GPIO and when
available use this to determine when to return POWER_SUPPLY_STATUS_FULL.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/adc-battery-helper.c | 18 +++++++++++++++---
 drivers/power/supply/adc-battery-helper.h |  5 ++++-
 drivers/power/supply/ug3105_battery.c     |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/adc-battery-helper.c b/drivers/power/supply/adc-battery-helper.c
index fcbe484a4c90..a4c4e002a80e 100644
--- a/drivers/power/supply/adc-battery-helper.c
+++ b/drivers/power/supply/adc-battery-helper.c
@@ -48,6 +48,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/devm-helpers.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mutex.h>
 #include <linux/power_supply.h>
 #include <linux/workqueue.h>
@@ -77,8 +78,17 @@ static int adc_battery_helper_get_status(struct adc_battery_helper *help)
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
@@ -310,13 +320,15 @@ static void adc_battery_helper_start_work(struct adc_battery_helper *help)
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
index 2a13c64eadf1..3cb73d2818f0 100644
--- a/drivers/power/supply/adc-battery-helper.h
+++ b/drivers/power/supply/adc-battery-helper.h
@@ -10,6 +10,7 @@
 #define ADC_BAT_HELPER_MOV_AVG_WINDOW				8
 
 struct power_supply;
+struct gpio_desc;
 
 /*
  * The adc battery helper code needs voltage- and current-now to be sampled as
@@ -20,6 +21,7 @@ typedef int (*adc_battery_helper_get_func)(struct power_supply *psy, int *volt,
 
 struct adc_battery_helper {
 	struct power_supply *psy;
+	struct gpio_desc *charge_finished;
 	struct delayed_work work;
 	struct mutex lock;
 	adc_battery_helper_get_func get_voltage_and_current_now;
@@ -43,7 +45,8 @@ extern const enum power_supply_property adc_battery_helper_properties[];
 #define ADC_HELPER_NUM_PROPERTIES 7
 
 int adc_battery_helper_init(struct adc_battery_helper *help, struct power_supply *psy,
-			    adc_battery_helper_get_func get_voltage_and_current_now);
+			    adc_battery_helper_get_func get_voltage_and_current_now,
+			    struct gpio_desc *charge_finished_gpio);
 /*
  * The below functions can be directly used as power-supply / suspend-resume
  * callbacks. They cast the power_supply_get_drvdata() / dev_get_drvdata() data
diff --git a/drivers/power/supply/ug3105_battery.c b/drivers/power/supply/ug3105_battery.c
index 8d4ee8c12db9..0aaff3c4476d 100644
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
2.47.1


