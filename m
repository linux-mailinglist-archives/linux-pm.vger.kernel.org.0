Return-Path: <linux-pm+bounces-18865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0909EA07B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 21:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435901883CB7
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 20:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496D319B3EC;
	Mon,  9 Dec 2024 20:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KA3m9e8a"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F419AA63
	for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2024 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776874; cv=none; b=OIC7MA44XOimkwd3QKYQelzMq31r4WNNo3zswQXgThu9Kli2ZhYSITQ0zuRkqRQNXz7lT+Tmxd/b1uWm0c6hcPgQga2KmYCreKTcUSzyntSkM9X1lBOY6psGym7zLdPmxbDtoJIfeqZ4UQ/4OBDC9cJYzFn80IbLkaMn/PImmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776874; c=relaxed/simple;
	bh=ePbbe8e7Ozxy1XZoTBiC4a7oC6lT7jvrAQfYJrNGy8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aR6XQEIIUfoO77eN18XRbkk9+BcXfkktqbFOdZTuXX79IlQaTIUYeHjICiumCbSfXw90b8CGES1UcJedztkfRamDzPxwvtAQZzuk84S2hGaZBew13gDOIA8bVlY7rlf8CerWn2rN+dvHEe6K5+zOSyIMl9Fs7cJ/zE3/JS9Q420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KA3m9e8a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733776871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqF0MX/wyp3lyosqW2NwsjV3BHKbyitAaCuopLNeBc8=;
	b=KA3m9e8a+eT7H5zBriSJJzLzRP64o9DuNatBBw2VqGDe4XhEOhENDnyiAbzHP9Uo2SsAeh
	iZxi29ARn3WHEMG5tE/GuIKy5l0q88R4GWxH4P9ZLn7OoTafww+1llWLLZvvOoAjzRqMMa
	laew8UaJLaMfNlxiw66QoRJJRy6oQzk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-aRPn6sKbPM6evYsj2LRPMw-1; Mon,
 09 Dec 2024 15:41:06 -0500
X-MC-Unique: aRPn6sKbPM6evYsj2LRPMw-1
X-Mimecast-MFC-AGG-ID: aRPn6sKbPM6evYsj2LRPMw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD27C195608B;
	Mon,  9 Dec 2024 20:41:04 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D54E300018D;
	Mon,  9 Dec 2024 20:41:01 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 3/4] power: supply: bq24190_charger: Add support for "charge_types" property
Date: Mon,  9 Dec 2024 21:40:50 +0100
Message-ID: <20241209204051.8786-4-hdegoede@redhat.com>
In-Reply-To: <20241209204051.8786-1-hdegoede@redhat.com>
References: <20241209204051.8786-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The bq24190 power_supply class device has a writeable "charge_type"
property, add support for the new "charge_types" property. Reading this
returns a list of supported charge-types with the currently active type
surrounded by square brackets, allowing userspace to find out which
enum power_supply_charge_type values are supported.

This has been tested on a GPD win gaming-handheld.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 2b393eb5c282..0101aaca1a97 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1313,6 +1313,7 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+	case POWER_SUPPLY_PROP_CHARGE_TYPES:
 		ret = bq24190_charger_get_charge_type(bdi, val);
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
@@ -1393,6 +1394,7 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 		ret = bq24190_charger_set_temp_alert_max(bdi, val);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+	case POWER_SUPPLY_PROP_CHARGE_TYPES:
 		ret = bq24190_charger_set_charge_type(bdi, val);
 		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
@@ -1421,6 +1423,7 @@ static int bq24190_charger_property_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+	case POWER_SUPPLY_PROP_CHARGE_TYPES:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
@@ -1469,6 +1472,7 @@ static void bq24190_charger_external_power_changed(struct power_supply *psy)
 
 static enum power_supply_property bq24190_charger_properties[] = {
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_CHARGE_TYPES,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_STATUS,
@@ -1498,6 +1502,9 @@ static const struct power_supply_desc bq24190_charger_desc = {
 	.set_property		= bq24190_charger_set_property,
 	.property_is_writeable	= bq24190_charger_property_is_writeable,
 	.external_power_changed	= bq24190_charger_external_power_changed,
+	.charge_types		= BIT(POWER_SUPPLY_CHARGE_TYPE_NONE)    |
+				  BIT(POWER_SUPPLY_CHARGE_TYPE_TRICKLE) |
+				  BIT(POWER_SUPPLY_CHARGE_TYPE_FAST),
 };
 
 /* Battery power supply property routines */
-- 
2.47.1


