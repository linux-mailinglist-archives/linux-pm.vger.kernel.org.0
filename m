Return-Path: <linux-pm+bounces-13872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C8970969
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 21:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4E3281A2C
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 19:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F4177991;
	Sun,  8 Sep 2024 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/y+InT5"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A36339A8
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823407; cv=none; b=J/rCC/Kg8K1fplCsXvm6ihXAPDtS6zcqO45slm+mZEyBpCNmx2H6wf/WBjdmq6jEOuSyFebltmDmRTg922DM49zJ4nyXIODyo5hvqGlauHoyrgcr7QdA9Gz+P4e7qofMF/ECRKsWNC58dI+QglC7BE+8ZlWM+oAYQnwbpYuICRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823407; c=relaxed/simple;
	bh=Hm9HtswaAo/5Cad+CgG0qwCpFzd/TE6YbbW1CMZB52M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHd5mS2SnJDykExoMY5frOJDmLw98yGrm8bLIHPKO99eM3OcEk3Z13jSKINNpOEvcCpYC3D84CJA9nze8jNwD00evPUVrqduRQV2ozws3H40lFUwwiJTrWRuoX1RXtVzQn2UlMoHif6KND1T933z89ZJoj+VcSnt6hIcsXnQz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/y+InT5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725823404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaeAiWJX1GeGsDIi6Cw72T1diLc1D8tBcVlvtYtDu2Q=;
	b=A/y+InT54kGdlLDXsLr3CQf231XRyQ/n/FgPfjiF632MppayKnZF8ij/RAu57rqUEwwxhj
	SzLwkxOo9mc+FnxVJ3Elh2eSxVIIH26ZHAak+KIOGSOE8+WZDT9O30isqdTrGz+zkwtglu
	j9NnU+PVdrp3QDss2QazDOfz61Iz4+M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-ejCWx34lN--dlkWKXd1d-A-1; Sun,
 08 Sep 2024 15:23:21 -0400
X-MC-Unique: ejCWx34lN--dlkWKXd1d-A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39FC219560AB;
	Sun,  8 Sep 2024 19:23:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.33])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A01B81956086;
	Sun,  8 Sep 2024 19:23:17 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/4] power: supply: core: Add new "charge_types" property
Date: Sun,  8 Sep 2024 21:23:01 +0200
Message-ID: <20240908192303.151562-3-hdegoede@redhat.com>
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

Add a new "charge_types" property, this is identical to "charge_type" but
reading returns a list of supported charge-types with the currently active
type surrounded by square brackets, e.g.:

Fast [Standard] "Long Life"

This has the advantage over the existing "charge_type" property that this
allows userspace to find out which charge-types are supported for writable
charge_type properties.

Drivers which already support "charge_type" can easily add support for
this by setting power_supply_desc.charge_types to a bitmask representing
valid charge_type values. The existing "charge_type" get_property() and
set_property() code paths can be re-used for "charge_types".

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/ABI/testing/sysfs-class-power | 15 ++++++++++
 drivers/power/supply/power_supply_sysfs.c   | 32 +++++++++++++++++++++
 include/linux/power_supply.h                | 23 ++++++++++++++-
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 45180b62d426..0173dda8d5ea 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -407,10 +407,25 @@ Description:
 
 		Access: Read, Write
 
+		Reading this returns the current active value, e.g. 'Standard'.
+
 		Valid values:
 			      "Unknown", "N/A", "Trickle", "Fast", "Standard",
 			      "Adaptive", "Custom", "Long Life", "Bypass"
 
+What:		/sys/class/power_supply/<supply_name>/charge_types
+Date:		September 2024
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Identical to charge_type but reading returns a list of supported
+		charge-types with the currently active type surrounded by square
+		brackets, e.g.: 'Fast [Standard] "Long Life"'.
+
+		power_supply class devices may support both charge_type and
+		charge_types for backward compatibility. In this case both will
+		always have the same active value and the active value can be
+		changed by writing either property.
+
 What:		/sys/class/power_supply/<supply_name>/charge_term_current
 Date:		July 2014
 Contact:	linux-pm@vger.kernel.org
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index ac42784eab11..6cd3fac1891b 100644
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
@@ -309,6 +311,10 @@ static ssize_t power_supply_show_property(struct device *dev,
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
@@ -545,3 +551,29 @@ int power_supply_charge_behaviour_parse(unsigned int available_behaviours, const
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
+	int i = sysfs_match_string(POWER_SUPPLY_CHARGE_TYPE_TEXT, buf);
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
2.46.0


