Return-Path: <linux-pm+bounces-8476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A528D6369
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 15:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957D028CA0B
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E49C158DDD;
	Fri, 31 May 2024 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxOglD3v"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C852158DCA
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163243; cv=none; b=WmVmlC9b3vP/Zgg8/C0oIeyXNwkZxZFHI+Fz1QDlh4s8lrPO/7kWFDewL/WYNex7clya7cgiAn3757iW2bHw8WEgAw7d29XtvHVtmMIojr8W/QEEez5sFQtXs57h5wTZJsdt2n750AJPjyefxpZAvw6eyAeXx8ev/pVXTm6KnaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163243; c=relaxed/simple;
	bh=1pNDJi2eiGqbssRofhJohqAnUNYn5MvkmoOZtJwDL3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlF9BhF80N1djAAWBFF0RMKSS2Vwxh1Vhi3mRR+KBe84q1mZwYyM5NibQ9CHj/T32M7dGAEbYdMpRCk2Q3rB1HqH0Dq593Ful4nzts9oI7QrFgbRgT4LXIiC1DoJzv10gsm86EyQwBbkv/GZJ250I991JMOcLhrVQTaGC9b9ys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gxOglD3v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717163240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+7LKWLfVolh9HuieCttrwEhFEQ3sV/QvOmPSERuWWc=;
	b=gxOglD3v1RFUIjZWYJoadFH53fAuRmoaI+lVcYIy1g/UmVYKQc+W7YdXlMToqFlFKPfZp/
	bHIJfXJDxNOaASi9HEXuOS585x1bGglidaIhIzEnT168p2F/U9X8krnAV6Y9UuBoyMWJyR
	V6wr5reph4KFnLaTP3Hgfd/9Eck8ejQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-0vDMS6uKP4G14anS04lUhw-1; Fri, 31 May 2024 09:47:16 -0400
X-MC-Unique: 0vDMS6uKP4G14anS04lUhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EC5E101A54F;
	Fri, 31 May 2024 13:47:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D97FE1054820;
	Fri, 31 May 2024 13:47:14 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Kate Hsuan <hpa@redhat.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 1/3] power: supply: power-supply-leds: Add power_supply_[un]register_led_trigger()
Date: Fri, 31 May 2024 15:47:00 +0200
Message-ID: <20240531134702.166145-2-hdegoede@redhat.com>
In-Reply-To: <20240531134702.166145-1-hdegoede@redhat.com>
References: <20240531134702.166145-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Add power_supply_[un]register_led_trigger() helper functions.

The primary goal of this is as a preparation patch for adding an activate
callback to the power-supply LED triggers to ensure that power-supply
LEDs get the correct initial value when the LED gets registered after
the power_supply has been registered (this will use the psy back pointer).

There also is quite a lot of code duplication in the existing LED trigger
registration in the form of the kasprintf() for the name-template for each
trigger + related error handling. This duplication is removed by these
new helpers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Rebase on 6.10-rc1 + "[PATCH v10 0/6] KTD2026 indicator LED for X86 Xiaomi Pad2"
- Pass a pointer to err to power_supply_register_led_trigger() to allow
  it to check for previous errors so that calls can be chained without
  having to error check every call seperately
- Add trigger_to_psy_trigger() macro
---
 drivers/power/supply/power_supply_leds.c | 157 +++++++++++++----------
 include/linux/power_supply.h             |   6 -
 2 files changed, 86 insertions(+), 77 deletions(-)

diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
index 73935de844d9..e3f65ff2f064 100644
--- a/drivers/power/supply/power_supply_leds.c
+++ b/drivers/power/supply/power_supply_leds.c
@@ -19,6 +19,65 @@
 
 /* Battery specific LEDs triggers. */
 
+struct power_supply_led_trigger {
+	struct led_trigger trig;
+	struct power_supply *psy;
+};
+
+#define trigger_to_psy_trigger(trigger) \
+	container_of(trigger, struct power_supply_led_trigger, trig)
+
+static int power_supply_register_led_trigger(struct power_supply *psy,
+					     const char *name_template,
+					     struct led_trigger **tp, int *err)
+{
+	struct power_supply_led_trigger *psy_trig;
+	int ret = -ENOMEM;
+
+	/* Bail on previous errors */
+	if (err && *err)
+		return *err;
+
+	psy_trig = kzalloc(sizeof(*psy_trig), GFP_KERNEL);
+	if (!psy_trig)
+		goto err_free_trigger;
+
+	psy_trig->trig.name = kasprintf(GFP_KERNEL, name_template, psy->desc->name);
+	if (!psy_trig->trig.name)
+		goto err_free_trigger;
+
+	psy_trig->psy = psy;
+
+	ret = led_trigger_register(&psy_trig->trig);
+	if (ret)
+		goto err_free_name;
+
+	*tp = &psy_trig->trig;
+	return 0;
+
+err_free_name:
+	kfree(psy_trig->trig.name);
+err_free_trigger:
+	kfree(psy_trig);
+	if (err)
+		*err = ret;
+
+	return ret;
+}
+
+static void power_supply_unregister_led_trigger(struct led_trigger *trig)
+{
+	struct power_supply_led_trigger *psy_trig;
+
+	if (!trig)
+		return;
+
+	psy_trig = trigger_to_psy_trigger(trig);
+	led_trigger_unregister(&psy_trig->trig);
+	kfree(psy_trig->trig.name);
+	kfree(psy_trig);
+}
+
 static void power_supply_update_bat_leds(struct power_supply *psy)
 {
 	union power_supply_propval status;
@@ -65,69 +124,33 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 	}
 }
 
-static int power_supply_create_bat_triggers(struct power_supply *psy)
-{
-	psy->charging_full_trig_name = kasprintf(GFP_KERNEL,
-					"%s-charging-or-full", psy->desc->name);
-	if (!psy->charging_full_trig_name)
-		goto charging_full_failed;
-
-	psy->charging_trig_name = kasprintf(GFP_KERNEL,
-					"%s-charging", psy->desc->name);
-	if (!psy->charging_trig_name)
-		goto charging_failed;
-
-	psy->full_trig_name = kasprintf(GFP_KERNEL, "%s-full", psy->desc->name);
-	if (!psy->full_trig_name)
-		goto full_failed;
-
-	psy->charging_blink_full_solid_trig_name = kasprintf(GFP_KERNEL,
-		"%s-charging-blink-full-solid", psy->desc->name);
-	if (!psy->charging_blink_full_solid_trig_name)
-		goto charging_blink_full_solid_failed;
-
-	psy->charging_orange_full_green_trig_name = kasprintf(GFP_KERNEL,
-		"%s-charging-orange-full-green", psy->desc->name);
-	if (!psy->charging_orange_full_green_trig_name)
-		goto charging_red_full_green_failed;
-
-	led_trigger_register_simple(psy->charging_full_trig_name,
-				    &psy->charging_full_trig);
-	led_trigger_register_simple(psy->charging_trig_name,
-				    &psy->charging_trig);
-	led_trigger_register_simple(psy->full_trig_name,
-				    &psy->full_trig);
-	led_trigger_register_simple(psy->charging_blink_full_solid_trig_name,
-				    &psy->charging_blink_full_solid_trig);
-	led_trigger_register_simple(psy->charging_orange_full_green_trig_name,
-				    &psy->charging_orange_full_green_trig);
-
-	return 0;
-
-charging_red_full_green_failed:
-	kfree(psy->charging_blink_full_solid_trig_name);
-charging_blink_full_solid_failed:
-	kfree(psy->full_trig_name);
-full_failed:
-	kfree(psy->charging_trig_name);
-charging_failed:
-	kfree(psy->charging_full_trig_name);
-charging_full_failed:
-	return -ENOMEM;
-}
-
 static void power_supply_remove_bat_triggers(struct power_supply *psy)
 {
-	led_trigger_unregister_simple(psy->charging_full_trig);
-	led_trigger_unregister_simple(psy->charging_trig);
-	led_trigger_unregister_simple(psy->full_trig);
-	led_trigger_unregister_simple(psy->charging_blink_full_solid_trig);
-	led_trigger_unregister_simple(psy->charging_orange_full_green_trig);
-	kfree(psy->charging_blink_full_solid_trig_name);
-	kfree(psy->full_trig_name);
-	kfree(psy->charging_trig_name);
-	kfree(psy->charging_full_trig_name);
-	kfree(psy->charging_orange_full_green_trig_name);
+	power_supply_unregister_led_trigger(psy->charging_full_trig);
+	power_supply_unregister_led_trigger(psy->charging_trig);
+	power_supply_unregister_led_trigger(psy->full_trig);
+	power_supply_unregister_led_trigger(psy->charging_blink_full_solid_trig);
+	power_supply_unregister_led_trigger(psy->charging_orange_full_green_trig);
+}
+
+static int power_supply_create_bat_triggers(struct power_supply *psy)
+{
+	int err = 0;
+
+	power_supply_register_led_trigger(psy, "%s-charging-or-full",
+					  &psy->charging_full_trig, &err);
+	power_supply_register_led_trigger(psy, "%s-charging",
+					  &psy->charging_trig, &err);
+	power_supply_register_led_trigger(psy, "%s-full",
+					  &psy->full_trig, &err);
+	power_supply_register_led_trigger(psy, "%s-charging-blink-full-solid",
+					  &psy->charging_blink_full_solid_trig, &err);
+	power_supply_register_led_trigger(psy, "%s-charging-orange-full-green",
+					  &psy->charging_orange_full_green_trig, &err);
+	if (err)
+		power_supply_remove_bat_triggers(psy);
+
+	return err;
 }
 
 /* Generated power specific LEDs triggers. */
@@ -149,20 +172,12 @@ static void power_supply_update_gen_leds(struct power_supply *psy)
 
 static int power_supply_create_gen_triggers(struct power_supply *psy)
 {
-	psy->online_trig_name = kasprintf(GFP_KERNEL, "%s-online",
-					  psy->desc->name);
-	if (!psy->online_trig_name)
-		return -ENOMEM;
-
-	led_trigger_register_simple(psy->online_trig_name, &psy->online_trig);
-
-	return 0;
+	return power_supply_register_led_trigger(psy, "%s-online", &psy->online_trig, NULL);
 }
 
 static void power_supply_remove_gen_triggers(struct power_supply *psy)
 {
-	led_trigger_unregister_simple(psy->online_trig);
-	kfree(psy->online_trig_name);
+	power_supply_unregister_led_trigger(psy->online_trig);
 }
 
 /* Choice what triggers to create&update. */
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index c852cc882501..e218a8ab72ee 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -310,17 +310,11 @@ struct power_supply {
 
 #ifdef CONFIG_LEDS_TRIGGERS
 	struct led_trigger *charging_full_trig;
-	char *charging_full_trig_name;
 	struct led_trigger *charging_trig;
-	char *charging_trig_name;
 	struct led_trigger *full_trig;
-	char *full_trig_name;
 	struct led_trigger *online_trig;
-	char *online_trig_name;
 	struct led_trigger *charging_blink_full_solid_trig;
-	char *charging_blink_full_solid_trig_name;
 	struct led_trigger *charging_orange_full_green_trig;
-	char *charging_orange_full_green_trig_name;
 #endif
 };
 
-- 
2.45.1


