Return-Path: <linux-pm+bounces-17241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6373E9C2817
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 00:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E47F1C21AA7
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 23:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7C320DD6F;
	Fri,  8 Nov 2024 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+t+3pUp"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB7020DD5E
	for <linux-pm@vger.kernel.org>; Fri,  8 Nov 2024 23:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731108299; cv=none; b=M+yyqHFPURu6odjO+xhcjfs0MRBHCR1vj2EEoJxKCi7A7PPVBxpLpkWn3DE8atZQAOLEbqas1WVjSo96mEXIspeKnJQuGBsipuJPeLhNA5mdeJAJBH/Re+2Xp/6soAuPkFALm4ViZPk6QuaC2CZfxD2jGtvdGkGz4bXVeUPA3zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731108299; c=relaxed/simple;
	bh=7sy/VaHTU5YgO2h3pbjmNQ1wxdJGh6fDZPTC8PaEdgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gv1FshbtoFSHkhf26H9OzzdJe0OWLbUNpLLOIdMZOBtUxTXnuZ1mtWkUuqwCPOsk1+c1hBb+NjMhCzfhFL0Z+6E0LM7zCzDELRbqYhZy+QntAdyIyRYwyL9dzp4wR3gvodJKXbl2+e2liK9juea9klxG3nF6LdPPenPKj7bQjjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+t+3pUp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731108296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NOHzmuZWEEkg9ixZXicPkdjJ6PNpOxqjjt5Nt/hrTs4=;
	b=N+t+3pUp40kouKB4FQE5/PoYStKaORBQIFU5hovayzGau0rjKPLxftmi+ToS0J88zSt4me
	4owscFrPS+vSmL+ijLeD4qpjNYRj91RYoMSLNjRXHyng5KTp+BZ7ZM5ytJnEtbQAtLgMfm
	jivDq93nUxZtFYGIWKjWOdAo43Zxoyg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-B_pxqft5PTGpR4Pj7GoX3Q-1; Fri,
 08 Nov 2024 18:24:54 -0500
X-MC-Unique: B_pxqft5PTGpR4Pj7GoX3Q-1
X-Mimecast-MFC-AGG-ID: B_pxqft5PTGpR4Pj7GoX3Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBC3719560A3;
	Fri,  8 Nov 2024 23:24:52 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.67])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7A6A300019E;
	Fri,  8 Nov 2024 23:24:49 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 3/4] power: supply: bq24190_charger: Add support for "charge_types" property
Date: Sat,  9 Nov 2024 00:24:37 +0100
Message-ID: <20241108232438.269156-4-hdegoede@redhat.com>
In-Reply-To: <20241108232438.269156-1-hdegoede@redhat.com>
References: <20241108232438.269156-1-hdegoede@redhat.com>
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
2.47.0


