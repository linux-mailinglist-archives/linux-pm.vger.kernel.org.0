Return-Path: <linux-pm+bounces-8477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486E88D636B
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 15:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C131F263EC
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D6B15AD93;
	Fri, 31 May 2024 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpV6Hltr"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185415AAD3
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163244; cv=none; b=VI9bgc8MasokK2iZ+BdJioU5zyltYNSvXQDecPdunAP8eIHLT+sSn3bnSlF1JgfMBE+a4BiyD5amibIjYA0aOyZp7EXgcL8eLFyJgTpnUNGSf4psT7IbjVvFam38GyHQ/Opzj1EOZobQyOhkCdPCVQPfbM1RjSGfXBGZDjxqYRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163244; c=relaxed/simple;
	bh=wQ6grQSTJAymBgC+qQlSnU3prJtCFGC+Kz1yExdD/Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0dDq2UCrksru1kiOOwJkaRdd29SyOJDoupyl0P5NXcMW/VdjrTTwPpf+VHzMHCF1B+SVlpU1ibilTK9Eiv1rEmQa9mz+fcnWjSG+nUyjoVe4+TasRSaP+Y4rRssIrF7tTvR0BxNHWNqCA239cyKwYc4VE9thHlKWqeTbjYm4UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpV6Hltr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717163241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lpw9yAlt2svOocDcCFGqebLXAeIYXQT0G4d+gZ8Gy0I=;
	b=FpV6HltrUXpYEw1InoCitnJaLAe6xGUVBpPx18Dpeg/PQwz4j72P8AJIOkxwGRYY0YSygN
	8yCgyGajKUsWziMtbKtzl+qNJnfWFoLRO/bppBdOKTyISyVXu73p2LdJ3gjxOI0r9q66v1
	tgosL2uqhGULc9F1WN/adpGP9W01sUg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-mwLczKGdO1aoadquYdigXQ-1; Fri,
 31 May 2024 09:47:18 -0400
X-MC-Unique: mwLczKGdO1aoadquYdigXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC8B23C025AC;
	Fri, 31 May 2024 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7D202105480A;
	Fri, 31 May 2024 13:47:16 +0000 (UTC)
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
Subject: [PATCH v2 2/3] power: supply: power-supply-leds: Share trig pointer for online and charging_full
Date: Fri, 31 May 2024 15:47:01 +0200
Message-ID: <20240531134702.166145-3-hdegoede@redhat.com>
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

Either 5 different LED triggers are registered for battery power-supply
devices or a single online LED trigger is used for non battery power-supply
devices.

These 5 / 1 LED trigger(s) are never used at the same time. So there is
no need for a separate LED trigger pointer for the online trigger. Rename
the first battery trigger from charging_full_trig to just trig and use this
for the online trigger too.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/power_supply_leds.c | 18 +++++++++---------
 include/linux/power_supply.h             |  3 +--
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
index e3f65ff2f064..f2d6b8d33707 100644
--- a/drivers/power/supply/power_supply_leds.c
+++ b/drivers/power/supply/power_supply_leds.c
@@ -91,7 +91,7 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 
 	switch (status.intval) {
 	case POWER_SUPPLY_STATUS_FULL:
-		led_trigger_event(psy->charging_full_trig, LED_FULL);
+		led_trigger_event(psy->trig, LED_FULL);
 		led_trigger_event(psy->charging_trig, LED_OFF);
 		led_trigger_event(psy->full_trig, LED_FULL);
 		/* Going from blink to LED on requires a LED_OFF event to stop blink */
@@ -103,7 +103,7 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 				     LED_FULL);
 		break;
 	case POWER_SUPPLY_STATUS_CHARGING:
-		led_trigger_event(psy->charging_full_trig, LED_FULL);
+		led_trigger_event(psy->trig, LED_FULL);
 		led_trigger_event(psy->charging_trig, LED_FULL);
 		led_trigger_event(psy->full_trig, LED_OFF);
 		led_trigger_blink(psy->charging_blink_full_solid_trig, 0, 0);
@@ -113,7 +113,7 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 				     LED_FULL);
 		break;
 	default:
-		led_trigger_event(psy->charging_full_trig, LED_OFF);
+		led_trigger_event(psy->trig, LED_OFF);
 		led_trigger_event(psy->charging_trig, LED_OFF);
 		led_trigger_event(psy->full_trig, LED_OFF);
 		led_trigger_event(psy->charging_blink_full_solid_trig,
@@ -126,7 +126,7 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 
 static void power_supply_remove_bat_triggers(struct power_supply *psy)
 {
-	power_supply_unregister_led_trigger(psy->charging_full_trig);
+	power_supply_unregister_led_trigger(psy->trig);
 	power_supply_unregister_led_trigger(psy->charging_trig);
 	power_supply_unregister_led_trigger(psy->full_trig);
 	power_supply_unregister_led_trigger(psy->charging_blink_full_solid_trig);
@@ -138,7 +138,7 @@ static int power_supply_create_bat_triggers(struct power_supply *psy)
 	int err = 0;
 
 	power_supply_register_led_trigger(psy, "%s-charging-or-full",
-					  &psy->charging_full_trig, &err);
+					  &psy->trig, &err);
 	power_supply_register_led_trigger(psy, "%s-charging",
 					  &psy->charging_trig, &err);
 	power_supply_register_led_trigger(psy, "%s-full",
@@ -165,19 +165,19 @@ static void power_supply_update_gen_leds(struct power_supply *psy)
 	dev_dbg(&psy->dev, "%s %d\n", __func__, online.intval);
 
 	if (online.intval)
-		led_trigger_event(psy->online_trig, LED_FULL);
+		led_trigger_event(psy->trig, LED_FULL);
 	else
-		led_trigger_event(psy->online_trig, LED_OFF);
+		led_trigger_event(psy->trig, LED_OFF);
 }
 
 static int power_supply_create_gen_triggers(struct power_supply *psy)
 {
-	return power_supply_register_led_trigger(psy, "%s-online", &psy->online_trig, NULL);
+	return power_supply_register_led_trigger(psy, "%s-online", &psy->trig, NULL);
 }
 
 static void power_supply_remove_gen_triggers(struct power_supply *psy)
 {
-	power_supply_unregister_led_trigger(psy->online_trig);
+	power_supply_unregister_led_trigger(psy->trig);
 }
 
 /* Choice what triggers to create&update. */
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index e218a8ab72ee..65082ef75692 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -309,10 +309,9 @@ struct power_supply {
 #endif
 
 #ifdef CONFIG_LEDS_TRIGGERS
-	struct led_trigger *charging_full_trig;
+	struct led_trigger *trig;
 	struct led_trigger *charging_trig;
 	struct led_trigger *full_trig;
-	struct led_trigger *online_trig;
 	struct led_trigger *charging_blink_full_solid_trig;
 	struct led_trigger *charging_orange_full_green_trig;
 #endif
-- 
2.45.1


