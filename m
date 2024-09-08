Return-Path: <linux-pm+bounces-13873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0231797096B
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 21:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8191E1F21295
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 19:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17053177991;
	Sun,  8 Sep 2024 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7JkYJ2r"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A26F339A8
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823411; cv=none; b=dRm5Ruhekaz6qHv6zWpnBS2FECFeTPnJ63C0RWVVJa6c3GGb5vIofr4AMZVI2yOLiA80DAtS1qssC/YMTQmgTYSpdtVUYVdxyBaJleZ4FlKZHdlQSw+BqrVLVorVoeqypMr5NvADdO09/82ChWFIxq+9WbZfe9tPyUF4BNk217o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823411; c=relaxed/simple;
	bh=5/VyYIXVdgEHotkpzpm92DYuJ03B4mXi8ZHU0aPpthY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjSkAxVW/Loy7TEXsaFzqIp9E0Ynr+RjaJQgEoFrUNgpSPX8jbkn+uecbquwf+2pVCIKsg9Pn8+ZKipY68pgTlZkwpeU5BIq2+du799MExUwsaXyhh1dGlKRfHmLXrGa8CXyOr2zTDHMaPDXFT4fc8g+++8kMSpw8WD4dE8I2HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7JkYJ2r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725823408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+6Qf4igUPHjW9yqNcmV5booAg93WTWfVSVAY+xkvJA=;
	b=U7JkYJ2rHDAEyYO50jn3B60Jf9c78tlVXaJXA4oakewC2Q8nnuQU5YG7oLpIZRKc/Ejq0b
	B4UxpGSkMLWiq+6YMV3bSdpUpFwAbiH1ZKl6ZzNT5BxFbNhXXIVmlEDwCfyyKTJ8apObLY
	ofBUw0tgkzY+a1FpeMIIjIJCwqovAjk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-xHfpNZ0aNDmPOnCCIfn0Ig-1; Sun,
 08 Sep 2024 15:23:25 -0400
X-MC-Unique: xHfpNZ0aNDmPOnCCIfn0Ig-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F5C21953944;
	Sun,  8 Sep 2024 19:23:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.33])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA3431956086;
	Sun,  8 Sep 2024 19:23:21 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-pm@vger.kernel.org
Subject: [RFC 4/4] platform/x86: dell-laptop: Use power_supply_charge_types_show/_parse() helpers
Date: Sun,  8 Sep 2024 21:23:03 +0200
Message-ID: <20240908192303.151562-5-hdegoede@redhat.com>
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

Make battery_modes a map between tokens and enum power_supply_charge_type
values instead of between tokens and strings and use the new
power_supply_charge_types_show/_parse() helpers for show()/store()
to ensure that things are handled in the same way as in other drivers.

This also changes battery_supported_modes to be a bitmap of charge-types
(enum power_supply_charge_type values) rather then a bitmap of indices
into battery_modes[].

FIXME: not tested yet

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/dell/dell-laptop.c | 54 ++++++++++++-------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index a3cd0505f282..d2ef18547c41 100644
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
@@ -2421,7 +2417,7 @@ static u32 __init battery_get_supported_modes(void)
 
 	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
 		if (dell_smbios_find_token(battery_modes[i].token))
-			modes |= BIT(i);
+			modes |= BIT(battery_modes[i].charge_type);
 	}
 
 	return modes;
-- 
2.46.0


