Return-Path: <linux-pm+bounces-8724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DA28FF026
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 17:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6E128B76B
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 15:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317651A2FBD;
	Thu,  6 Jun 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CfmKsHZf"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C10A1A2C1E;
	Thu,  6 Jun 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685471; cv=none; b=tJ6WbU+lk2UnmCtm5xPDyX9Rz8TJhvafltlpGIOBsdn31aIYrFQwrpjkQyunlvh3frbJ/VR4svaglhm3QXsk23Z0cVbp9h1LKXk3BOffYxengi89mx4HcCP/2R7GttmhXhywZ4bB+6HaPiNsxCf4PCJI8DHXBUDSOc4fsmy6KwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685471; c=relaxed/simple;
	bh=CpbSko9MUrOONdiIMtfB2TK6xEtuWLt0mNiMMQVHVro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=muAfTCfpQekUy3btKSLtGk1gIj5PLvRTrpLWFoiuX+fah2EH3QOpsi+3Kem+e6h5y1FkteAbePtuqz8ytSBGS3eUyv1rZ1y+sRJAWYxPvLs/HiWht/1Ry7s38lJ0Eha75j2t/j5JPbYCDGhEGv2MUe/0ctpldoSxUSgGuNNZ+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CfmKsHZf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717685464;
	bh=CpbSko9MUrOONdiIMtfB2TK6xEtuWLt0mNiMMQVHVro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CfmKsHZfVFu9AeIsdm8pI3VKVLXW9NpdjmekNnCGQEN50Nc9ZWFPkLGidi8wH7BBP
	 DkJIkX7mhzb9d+0i9wisIOe5dVCO9nTqkn0FpNSS/1siKbLU/dTkrOvGAeozwHR217
	 gzp9F7yIazJxhNtlLIORnVq1S2PjQQSep3TF36ng=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 06 Jun 2024 16:51:00 +0200
Subject: [PATCH RFC 6/6] platform/x86: system76: Use power_supply extension
 API
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240606-power-supply-extensions-v1-6-b45669290bdc@weissschuh.net>
References: <20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net>
In-Reply-To: <20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Jeremy Soller <jeremy@system76.com>, 
 System76 Product Development <productdev@system76.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717685463; l=5181;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=CpbSko9MUrOONdiIMtfB2TK6xEtuWLt0mNiMMQVHVro=;
 b=/5mcEKpBkBU80sDzsXU5JK0I6crCorZge0wy9rVTQvGQg2l4RdbSj4PQfNLvpefCLYMt9YLIl
 yt+eH9nVJn1AGoGFY6Q/TDTYCyh9dMaCg+Ky9J9/xZy141uBrjx+CYZ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/system76_acpi.c | 83 +++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 39 deletions(-)

diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
index 3da753b3d00d..c26f42c917dd 100644
--- a/drivers/platform/x86/system76_acpi.c
+++ b/drivers/platform/x86/system76_acpi.c
@@ -162,7 +162,7 @@ enum {
 	THRESHOLD_END,
 };
 
-static ssize_t battery_get_threshold(int which, char *buf)
+static int battery_get_threshold(int which, int *val)
 {
 	struct acpi_object_list input;
 	union acpi_object param;
@@ -186,29 +186,21 @@ static ssize_t battery_get_threshold(int which, char *buf)
 	if (ret == BATTERY_THRESHOLD_INVALID)
 		return -EINVAL;
 
-	return sysfs_emit(buf, "%d\n", (int)ret);
+	*val = ret;
+	return 0;
 }
 
-static ssize_t battery_set_threshold(int which, const char *buf, size_t count)
+static int battery_set_threshold(int which, unsigned int value)
 {
 	struct acpi_object_list input;
 	union acpi_object params[2];
 	acpi_handle handle;
 	acpi_status status;
-	unsigned int value;
-	int ret;
 
 	handle = ec_get_handle();
 	if (!handle)
 		return -ENODEV;
 
-	ret = kstrtouint(buf, 10, &value);
-	if (ret)
-		return ret;
-
-	if (value > 100)
-		return -EINVAL;
-
 	input.count = 2;
 	input.pointer = params;
 	// Start/stop selection
@@ -222,52 +214,65 @@ static ssize_t battery_set_threshold(int which, const char *buf, size_t count)
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	return count;
+	return 0;
 }
 
-static ssize_t charge_control_start_threshold_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	return battery_get_threshold(THRESHOLD_START, buf);
-}
+static const enum power_supply_property system76_battery_properties[] = {
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
+};
 
-static ssize_t charge_control_start_threshold_store(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t count)
+static int system76_property_is_writeable(struct power_supply *psy,
+					  enum power_supply_property psp)
 {
-	return battery_set_threshold(THRESHOLD_START, buf, count);
+	return true;
 }
 
-static DEVICE_ATTR_RW(charge_control_start_threshold);
-
-static ssize_t charge_control_end_threshold_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
+static int system76_get_property(struct power_supply *psy, enum power_supply_property psp,
+				 union power_supply_propval *val)
 {
-	return battery_get_threshold(THRESHOLD_END, buf);
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+		return battery_get_threshold(THRESHOLD_START, &val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		return battery_get_threshold(THRESHOLD_END, &val->intval);
+	default:
+		return -EINVAL;
+	};
 }
 
-static ssize_t charge_control_end_threshold_store(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t count)
+static int system76_set_property(struct power_supply *psy, enum power_supply_property psp,
+				 const union power_supply_propval *val)
 {
-	return battery_set_threshold(THRESHOLD_END, buf, count);
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+		if (val->intval < 0 || val->intval > 100)
+			return -EINVAL;
+		return battery_set_threshold(THRESHOLD_START, val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		if (val->intval < 0 || val->intval > 100)
+			return -EINVAL;
+		return battery_set_threshold(THRESHOLD_END, val->intval);
+	default:
+		return -EINVAL;
+	};
 }
 
-static DEVICE_ATTR_RW(charge_control_end_threshold);
-
-static struct attribute *system76_battery_attrs[] = {
-	&dev_attr_charge_control_start_threshold.attr,
-	&dev_attr_charge_control_end_threshold.attr,
-	NULL,
+static const struct power_supply_ext system76_power_supply_ext = {
+	.properties            = system76_battery_properties,
+	.num_properties        = ARRAY_SIZE(system76_battery_properties),
+	.property_is_writeable = system76_property_is_writeable,
+	.get_property          = system76_get_property,
+	.set_property          = system76_set_property,
 };
 
-ATTRIBUTE_GROUPS(system76_battery);
-
 static int system76_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
 {
 	// System76 EC only supports 1 battery
 	if (strcmp(battery->desc->name, "BAT0") != 0)
 		return -ENODEV;
 
-	if (device_add_groups(&battery->dev, system76_battery_groups))
+	if (power_supply_register_extension(battery, &system76_power_supply_ext))
 		return -ENODEV;
 
 	return 0;
@@ -275,7 +280,7 @@ static int system76_battery_add(struct power_supply *battery, struct acpi_batter
 
 static int system76_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
 {
-	device_remove_groups(&battery->dev, system76_battery_groups);
+	power_supply_unregister_extension(battery, &system76_power_supply_ext);
 	return 0;
 }
 

-- 
2.45.2


