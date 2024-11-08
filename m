Return-Path: <linux-pm+bounces-17240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 928939C2812
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 00:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24EA01F21C60
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 23:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3683220B811;
	Fri,  8 Nov 2024 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8dTCt3V"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EAD206E61
	for <linux-pm@vger.kernel.org>; Fri,  8 Nov 2024 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731108295; cv=none; b=l4usl8BW9f0BX1Luoli1AZDAR0vbY/6Ze39CLBmqkY2aQMvsjkahiPZjpwEniuUsPsCw+vR7vxlDrLG/nQL74VfDhhHN7ZLrigWi2/26d8CjthJq2oue5SX/G9sRieePoLKasuow24gE2DcRmaljqe7laD5BcWVOD+NnMFMfbag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731108295; c=relaxed/simple;
	bh=Uh44gXfnd+iNpd2aZvbhADAOvo0ngUdwXEkXjVGnqzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9+mbCJp8NBKFu9SSvQr8knY2PLgrZlwpNdn+wqddml4hR+dm9XqryDB9qAT1QnW2XzdfGT+WsRedyWxGFQPfIvChFvQZ5kwiyZNK2oGAig2GK9I2l9GC1Si6AutGV+pDBXC9oJUDU0HM3Wb6a5setjJHY7955FtPKC4UuASpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d8dTCt3V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731108292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2muY8OaiUS5t9qeAK7fAObBSsOHksBZZpxBWDU2eoY=;
	b=d8dTCt3VyhEI8fvUVVi7kIyxwcbXMWBvi7UXggWibza5X/vdn6q05WhhEJmVxzFIY54upC
	pMRS7bje1MCbODLNalqO5TOvyL3sap7GXXhI81luOqBs7AP8RWVjYkHWI86ViQzxPD+CQM
	brtu96Kyyw55xhwND/9JDaSobOmna3M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-5nrCwphYMhOSF6MpwzPH-w-1; Fri,
 08 Nov 2024 18:24:50 -0500
X-MC-Unique: 5nrCwphYMhOSF6MpwzPH-w-1
X-Mimecast-MFC-AGG-ID: 5nrCwphYMhOSF6MpwzPH-w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72F6919560A6;
	Fri,  8 Nov 2024 23:24:49 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.67])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6DB9E300019E;
	Fri,  8 Nov 2024 23:24:46 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 2/4] power: supply: core: Add new "charge_types" property
Date: Sat,  9 Nov 2024 00:24:36 +0100
Message-ID: <20241108232438.269156-3-hdegoede@redhat.com>
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

Add a new "charge_types" property, this is identical to "charge_type" but
reading returns a list of supported charge-types with the currently active
type surrounded by square brackets, e.g.:

Fast [Standard] "Long_Life"

This has the advantage over the existing "charge_type" property that this
allows userspace to find out which charge-types are supported for writable
charge_type properties.

Drivers which already support "charge_type" can easily add support for
this by setting power_supply_desc.charge_types to a bitmask representing
valid charge_type values. The existing "charge_type" get_property() and
set_property() code paths can be re-used for "charge_types".

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Add "Check charge_types to get the values supported by the battery."
  to Documentation/ABI/testing/sysfs-class-power
- Add a note about labels with spaces having these replaced by '_'
  to Documentation/ABI/testing/sysfs-class-power
- Use power_supply_match_string() in power_supply_charge_types_parse()
---
 Documentation/ABI/testing/sysfs-class-power | 20 ++++++++++++
 drivers/power/supply/power_supply_sysfs.c   | 34 +++++++++++++++++++++
 include/linux/power_supply.h                | 23 +++++++++++++-
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 45180b62d426..4421815cfb40 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -407,10 +407,30 @@ Description:
 
 		Access: Read, Write
 
+		Reading this returns the current active value, e.g. 'Standard'.
+		Check charge_types to get the values supported by the battery.
+
 		Valid values:
 			      "Unknown", "N/A", "Trickle", "Fast", "Standard",
 			      "Adaptive", "Custom", "Long Life", "Bypass"
 
+What:		/sys/class/power_supply/<supply_name>/charge_types
+Date:		November 2024
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Identical to charge_type but reading returns a list of supported
+		charge-types with the currently active type surrounded by square
+		brackets, e.g.: "Fast [Standard] Long_Life".
+
+		power_supply class devices may support both charge_type and
+		charge_types for backward compatibility. In this case both will
+		always have the same active value and the active value can be
+		changed by writing either property.
+
+		Note charge-types which contain a space such as "Long Life" will
+		have the space replaced by a '_' resulting in e.g. "Long_Life".
+		When writing charge-types both variants are accepted.
+
 What:		/sys/class/power_supply/<supply_name>/charge_term_current
 Date:		July 2014
 Contact:	linux-pm@vger.kernel.org
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 6f128c6fa62f..b1a84ee8664a 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -182,6 +182,8 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
 	POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
 	POWER_SUPPLY_ENUM_ATTR(CHARGE_BEHAVIOUR),
+	/* Same enum value texts as "charge_type" without the 's' at the end */
+	_POWER_SUPPLY_ENUM_ATTR(CHARGE_TYPES, POWER_SUPPLY_CHARGE_TYPE_TEXT),
 	POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
 	POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
 	POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),
@@ -335,6 +337,10 @@ static ssize_t power_supply_show_property(struct device *dev,
 		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
 							 value.intval, buf);
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPES:
+		ret = power_supply_charge_types_show(dev, psy->desc->charge_types,
+						     value.intval, buf);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
 		ret = sysfs_emit(buf, "%s\n", value.strval);
 		break;
@@ -571,3 +577,31 @@ int power_supply_charge_behaviour_parse(unsigned int available_behaviours, const
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(power_supply_charge_behaviour_parse);
+
+ssize_t power_supply_charge_types_show(struct device *dev,
+				       unsigned int available_types,
+				       enum power_supply_charge_type current_type,
+				       char *buf)
+{
+	return power_supply_show_enum_with_available(
+				dev, POWER_SUPPLY_CHARGE_TYPE_TEXT,
+				ARRAY_SIZE(POWER_SUPPLY_CHARGE_TYPE_TEXT),
+				available_types, current_type, buf);
+}
+EXPORT_SYMBOL_GPL(power_supply_charge_types_show);
+
+int power_supply_charge_types_parse(unsigned int available_types, const char *buf)
+{
+	int i = power_supply_match_string(POWER_SUPPLY_CHARGE_TYPE_TEXT,
+					  ARRAY_SIZE(POWER_SUPPLY_CHARGE_TYPE_TEXT),
+					  buf);
+
+	if (i < 0)
+		return i;
+
+	if (available_types & BIT(i))
+		return i;
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(power_supply_charge_types_parse);
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 910d407ebe63..d521074cd073 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -40,7 +40,7 @@ enum {
 };
 
 /* What algorithm is the charger using? */
-enum {
+enum power_supply_charge_type {
 	POWER_SUPPLY_CHARGE_TYPE_UNKNOWN = 0,
 	POWER_SUPPLY_CHARGE_TYPE_NONE,
 	POWER_SUPPLY_CHARGE_TYPE_TRICKLE,	/* slow speed */
@@ -135,6 +135,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
 	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+	POWER_SUPPLY_PROP_CHARGE_TYPES,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
 	POWER_SUPPLY_PROP_INPUT_POWER_LIMIT,
@@ -243,6 +244,7 @@ struct power_supply_desc {
 	const char *name;
 	enum power_supply_type type;
 	u8 charge_behaviours;
+	u32 charge_types;
 	u32 usb_types;
 	const enum power_supply_property *properties;
 	size_t num_properties;
@@ -965,6 +967,11 @@ ssize_t power_supply_charge_behaviour_show(struct device *dev,
 					   char *buf);
 
 int power_supply_charge_behaviour_parse(unsigned int available_behaviours, const char *buf);
+ssize_t power_supply_charge_types_show(struct device *dev,
+				       unsigned int available_types,
+				       enum power_supply_charge_type current_type,
+				       char *buf);
+int power_supply_charge_types_parse(unsigned int available_types, const char *buf);
 #else
 static inline
 ssize_t power_supply_charge_behaviour_show(struct device *dev,
@@ -980,6 +987,20 @@ static inline int power_supply_charge_behaviour_parse(unsigned int available_beh
 {
 	return -EOPNOTSUPP;
 }
+
+static inline
+ssize_t power_supply_charge_types_show(struct device *dev,
+				       unsigned int available_types,
+				       enum power_supply_charge_type current_type,
+				       char *buf)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int power_supply_charge_types_parse(unsigned int available_types, const char *buf)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #endif /* __LINUX_POWER_SUPPLY_H__ */
-- 
2.47.0


