Return-Path: <linux-pm+bounces-19265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1EB9F24FE
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 18:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1F0164704
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCB51B21B2;
	Sun, 15 Dec 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0zMq8LG"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4CD19993D
	for <linux-pm@vger.kernel.org>; Sun, 15 Dec 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734283319; cv=none; b=d0rt66RJylpVU4hTJOeGILUKAh54scGsa5CdUUtUXAheK3sNL6rGYHjxof8uzeW6oGUo1WtMuJdNFq7wYCoshsz3qQaYdgBdjLYN3uZKM8LjjT2Yf887+7L46vz7PpVwV1QfjNlFHahdaBrMe6NL1Lx6YZvxhXFXWI8+CD5ay24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734283319; c=relaxed/simple;
	bh=Rpa9os+HMb6BZmvFQKYMNOceMWBJlqmibDiUH7sqII0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XM2lT4AN64nIc42lFnYhvqL78ZawCKEl69PDAwjNgl6J/CVQ03WxM7Wb6iZz/slqHiqg7PUvTWoF6nJXRmN+38OjcXgTabw4HuZeUO8p7iWIQqdufiDV+IPzytLVgWdxSboP3pQ0TVDYKPtTOCztGH4qFO5YVz1QMLsWAhnH+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D0zMq8LG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734283316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKUvUq/LS0E73eqmlsiioHSTEqxYzpVFnKaC48IsVGw=;
	b=D0zMq8LGzhCz/6LWjK0RvScYHM04HQPOLnGKO3PRW9w0pXmQCRA4OKiOZYhTBl0JlDaVWl
	kIgOVpD35xkaSkpzJ1NRuoPhtapGp1Ir53w/8KyZJ2ZqHz5U+deK1e25LtxCt2LETE2fkr
	FlnYjilJgkaC9Dw12s4LW9MldHHRUjc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-NyHVTjE2NHuqnKJ7OpypiA-1; Sun,
 15 Dec 2024 12:21:52 -0500
X-MC-Unique: NyHVTjE2NHuqnKJ7OpypiA-1
X-Mimecast-MFC-AGG-ID: NyHVTjE2NHuqnKJ7OpypiA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F07D319560A5;
	Sun, 15 Dec 2024 17:21:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.51])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4E7E195605A;
	Sun, 15 Dec 2024 17:21:50 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH 7/8] power: supply: adc-battery-helper: Add support for optional charge_finished GPIO
Date: Sun, 15 Dec 2024 18:21:30 +0100
Message-ID: <20241215172133.178460-8-hdegoede@redhat.com>
In-Reply-To: <20241215172133.178460-1-hdegoede@redhat.com>
References: <20241215172133.178460-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
index 104d9a888486..f01976b95466 100644
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


