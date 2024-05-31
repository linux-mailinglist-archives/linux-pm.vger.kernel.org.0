Return-Path: <linux-pm+bounces-8478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582BC8D636E
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 15:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC58F1F28233
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 13:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1968F159216;
	Fri, 31 May 2024 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNLgPVtX"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9932F158DD3
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163248; cv=none; b=puG+l2+THPdK6OwSlIUTyyf1CwqiknDGz4Hnw2l8Fb4J/jl/MLDta6/EZzX3Ipb2ZpJENZVEj2OTkRR7tDghSj5rdO3xOs8CYUSBtGCQzXvDjIrSZtf81KI72j0QuNaqNF3imssNWSdFd3VoCW0acTaIctIXZNUmk3y2yqWqAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163248; c=relaxed/simple;
	bh=gXKjLBynIcLmbfKX7WD2h03GNICMYxTgTCUf7gWsBIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPcmPzl44If+9VVmPP2BkrXXWOeQ+a4ur/Z8MtT16BirWHd0V6iOHg/c45QEUPjTBxNUji5I/xz2Qkt+PhCluf/K889tqD7+pLWBQ2KAfmusZt0H8x/ZX/BTRVUesBFjunZO+uBSQB1SdOnKjlp7c9tGdkBgNrGrocBkS5NuNKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bNLgPVtX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717163245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sy2QrRtQS1ZXr2r/Ht8xMH5jFrRv9RAt8SNKBxOYZFo=;
	b=bNLgPVtXBnROGHauzubVBf4XTf3I2jdVqkMqN+z62CaMhK8wZNCuezeYahFFE91hmeaqR2
	vRMAnu1cWpJh7OnoQSnXVah8FmMHP8W/ql1RFu2hyxdBjoXQS3PKibX8x794vPxNc1sV/w
	ESf6P6kHisOcPuNTu4GHurcLLRfi0II=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-l79VswIYMxa42MWeN2KnWQ-1; Fri, 31 May 2024 09:47:20 -0400
X-MC-Unique: l79VswIYMxa42MWeN2KnWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94CF7101A54F;
	Fri, 31 May 2024 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2795E1054820;
	Fri, 31 May 2024 13:47:18 +0000 (UTC)
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
Subject: [PATCH v2 3/3] power: supply: power-supply-leds: Add activate() callback to triggers
Date: Fri, 31 May 2024 15:47:02 +0200
Message-ID: <20240531134702.166145-4-hdegoede@redhat.com>
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

Add an activate() callback to the power-supply LED triggers so that
the LED being activated will properly reflect the current power-supply
state for power-supply devices which are already fully registered
when the trigger gets activated.

This fixes e.g. wrong LED state (1) when the LED gets registered
after the power-supply device.

1) Until the psy driver has a reason to call power_supply_changed()
   which may take quite a while

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Use trigger_to_psy_trigger() macro
---
 drivers/power/supply/power_supply_leds.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
index f2d6b8d33707..f4a7e566bea1 100644
--- a/drivers/power/supply/power_supply_leds.c
+++ b/drivers/power/supply/power_supply_leds.c
@@ -27,6 +27,16 @@ struct power_supply_led_trigger {
 #define trigger_to_psy_trigger(trigger) \
 	container_of(trigger, struct power_supply_led_trigger, trig)
 
+static int power_supply_led_trigger_activate(struct led_classdev *led_cdev)
+{
+	struct power_supply_led_trigger *psy_trig =
+		trigger_to_psy_trigger(led_cdev->trigger);
+
+	/* Sync current power-supply state to LED being activated */
+	power_supply_update_leds(psy_trig->psy);
+	return 0;
+}
+
 static int power_supply_register_led_trigger(struct power_supply *psy,
 					     const char *name_template,
 					     struct led_trigger **tp, int *err)
@@ -46,6 +56,7 @@ static int power_supply_register_led_trigger(struct power_supply *psy,
 	if (!psy_trig->trig.name)
 		goto err_free_trigger;
 
+	psy_trig->trig.activate = power_supply_led_trigger_activate;
 	psy_trig->psy = psy;
 
 	ret = led_trigger_register(&psy_trig->trig);
-- 
2.45.1


