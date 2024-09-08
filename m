Return-Path: <linux-pm+bounces-13871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFE597096A
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 21:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7315BB213B4
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 19:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D7F172BB9;
	Sun,  8 Sep 2024 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajzxV/1j"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42EC17838A
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823406; cv=none; b=G/mRwRAmy8R+84tbvXHGXIFbj3punk2yuxmNI20wHpe+XVrErGmapgm921VoJXwXGE427yMIbCmM8DCMxfXMR5VdE5QEosTk8auVsIO9xW+ogNjHTLGf5BU1/l/FyQjmV/KO8PGq9yBVua0IvbqY6AsUjZPWW3OhSEavhjtLVwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823406; c=relaxed/simple;
	bh=3YjEZkeROHbA5PgnvUY3olCaoUzuUWtYoUqhZ2fqD0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/7L1Ur10vclEKh2Y9LJU3DNuNJDl67im+GgwEqZ8M6LRH7UPxK10aoY4vwqkiL0ZpL9ppkz60/qUeV2lU+eHltec+A5XDbDx6oqwh38nBg5FgE7RQ/3ZdYBRJViiiKoV6YnJTTcuWtKU2RtR2eQVnfP/wPIp0Fmz2XJOoAe64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajzxV/1j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725823403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCKZ5iTaBDg1c4AasgfWFeYvRPGFM5oi39pwnmf6JaQ=;
	b=ajzxV/1jy9hmUhYu8VC8bH0uJ3IgWgBIPKMTKDpcgZEW56VgKcEZU34pyEaR/HLLh217IO
	7VLSrAleVmcVeGVgHJmuq8jVZIa90+mIjje9zzrSeH8RYtxOAYOCk3THWdnZg9D0ca1kCB
	CAmif6Zrn98lElVdyHWCo+tvjhGDiv4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-3zA6VGRnNhihcLbkgxhQow-1; Sun,
 08 Sep 2024 15:23:22 -0400
X-MC-Unique: 3zA6VGRnNhihcLbkgxhQow-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84AB01956088;
	Sun,  8 Sep 2024 19:23:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.33])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D1A7195608A;
	Sun,  8 Sep 2024 19:23:19 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH 3/4] power: supply: bq24190_charger: Add support for "charge_types" property
Date: Sun,  8 Sep 2024 21:23:02 +0200
Message-ID: <20240908192303.151562-4-hdegoede@redhat.com>
In-Reply-To: <20240908192303.151562-1-hdegoede@redhat.com>
References: <20240908192303.151562-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
2.46.0


