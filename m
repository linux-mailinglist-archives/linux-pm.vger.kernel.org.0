Return-Path: <linux-pm+bounces-18866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F499EA07D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 21:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8B8166908
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 20:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CF019AA63;
	Mon,  9 Dec 2024 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwYjiAyl"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E5C19ABB6
	for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2024 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776878; cv=none; b=ohLaAmc/5dQx7DoXcWgvd9Ghg8Kj5qc8HYMUirYSERZjijgfuOFQbBVfR1Ms0e0Rbzf3BhzDDZrT8OaR9dzTfL42uXCBW1jF/Q2nzOYzE/H+U6d506I3Ef06iXzTcSA/ThOrzmRfH9JIgW/1djr+aZ0fae0lGkjf57/B7AAkOOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776878; c=relaxed/simple;
	bh=7hwvhBYRg+U0oN45RmLmFZQMZ2QzumV970gdrrlArUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGNjtYu5crqFpBqxb3/N1TbXG2p3GKfAUvxrFBXia6xWtUfjxpdhpE29/+ATXO9MMYj6PRhph+hJ/w5W6DE+XBSS3AGiYEXx86XGxHD0cBmbDaZQLGYlhUZFjqx5Cg7TNutWyUeBWe5Of+VlCwQ+6JLRV2kWwokbIgG+PwLF9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SwYjiAyl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733776875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zif0dVMKwpgf9jHDEMxVh/6U6kVDG4MYeNepaSfiYu4=;
	b=SwYjiAyl9JlRWfaJUcSJuDd13RNQ0MjubW1Ul7ocloV5THzhwBaaFqtdNHaEsTRY0BNcs9
	oHzitFr6TxazazZPrr8+PgvFfY7IbgsDmL3l1+qRZMbmW41U8TlFIzWELqMFz5VjJJ2btb
	Z/+cpIFkK10O5Dmy4RrH01U2dpQCeKM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-XQfhVCcmPl2yn4HyAdpBUA-1; Mon,
 09 Dec 2024 15:41:09 -0500
X-MC-Unique: XQfhVCcmPl2yn4HyAdpBUA-1
X-Mimecast-MFC-AGG-ID: XQfhVCcmPl2yn4HyAdpBUA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BC7219560AB;
	Mon,  9 Dec 2024 20:41:08 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E7593000199;
	Mon,  9 Dec 2024 20:41:04 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 4/4] platform/x86: dell-laptop: Use power_supply_charge_types_show/_parse() helpers
Date: Mon,  9 Dec 2024 21:40:51 +0100
Message-ID: <20241209204051.8786-5-hdegoede@redhat.com>
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

Make battery_modes a map between tokens and enum power_supply_charge_type
values instead of between tokens and strings and use the new
power_supply_charge_types_show/_parse() helpers for show()/store()
to ensure that things are handled in the same way as in other drivers.

This also changes battery_supported_modes to be a bitmap of charge-types
(enum power_supply_charge_type values) rather then a bitmap of indices
into battery_modes[].

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/dell/dell-laptop.c | 54 ++++++++++++-------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 5671bd0deee7..9a4cfcb8bbe0 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -103,15 +103,15 @@ static bool mute_led_registered;
 
 struct battery_mode_info {
 	int token;
-	const char *label;
+	enum power_supply_charge_type charge_type;
 };
 
 static const struct battery_mode_info battery_modes[] = {
-	{ BAT_PRI_AC_MODE_TOKEN,   "Trickle" },
-	{ BAT_EXPRESS_MODE_TOKEN,  "Fast" },
-	{ BAT_STANDARD_MODE_TOKEN, "Standard" },
-	{ BAT_ADAPTIVE_MODE_TOKEN, "Adaptive" },
-	{ BAT_CUSTOM_MODE_TOKEN,   "Custom" },
+	{ BAT_PRI_AC_MODE_TOKEN,   POWER_SUPPLY_CHARGE_TYPE_TRICKLE },
+	{ BAT_EXPRESS_MODE_TOKEN,  POWER_SUPPLY_CHARGE_TYPE_FAST },
+	{ BAT_STANDARD_MODE_TOKEN, POWER_SUPPLY_CHARGE_TYPE_STANDARD },
+	{ BAT_ADAPTIVE_MODE_TOKEN, POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE },
+	{ BAT_CUSTOM_MODE_TOKEN,   POWER_SUPPLY_CHARGE_TYPE_CUSTOM },
 };
 static u32 battery_supported_modes;
 
@@ -2261,46 +2261,42 @@ static ssize_t charge_types_show(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	ssize_t count = 0;
+	enum power_supply_charge_type charge_type;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
-		bool active;
+		charge_type = battery_modes[i].charge_type;
 
-		if (!(battery_supported_modes & BIT(i)))
+		if (!(battery_supported_modes & BIT(charge_type)))
 			continue;
 
-		active = dell_battery_mode_is_active(battery_modes[i].token);
-		count += sysfs_emit_at(buf, count, active ? "[%s] " : "%s ",
-				battery_modes[i].label);
+		if (!dell_battery_mode_is_active(battery_modes[i].token))
+			continue;
+
+		return power_supply_charge_types_show(dev, battery_supported_modes,
+						      charge_type, buf);
 	}
 
-	/* convert the last space to a newline */
-	if (count > 0)
-		count--;
-	count += sysfs_emit_at(buf, count, "\n");
-
-	return count;
+	/* No active mode found */
+	return -EIO;
 }
 
 static ssize_t charge_types_store(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t size)
 {
-	bool matched = false;
-	int err, i;
+	int charge_type, err, i;
+
+	charge_type = power_supply_charge_types_parse(battery_supported_modes, buf);
+	if (charge_type < 0)
+		return charge_type;
 
 	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
-		if (!(battery_supported_modes & BIT(i)))
-			continue;
-
-		if (sysfs_streq(battery_modes[i].label, buf)) {
-			matched = true;
+		if (battery_modes[i].charge_type == charge_type)
 			break;
-		}
 	}
-	if (!matched)
-		return -EINVAL;
+	if (i == ARRAY_SIZE(battery_modes))
+		return -EIO;
 
 	err = dell_battery_set_mode(battery_modes[i].token);
 	if (err)
@@ -2430,7 +2426,7 @@ static u32 __init battery_get_supported_modes(void)
 
 	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
 		if (dell_smbios_find_token(battery_modes[i].token))
-			modes |= BIT(i);
+			modes |= BIT(battery_modes[i].charge_type);
 	}
 
 	return modes;
-- 
2.47.1


