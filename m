Return-Path: <linux-pm+bounces-25370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 731E4A8819E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 15:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAE73A9052
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70A076410;
	Mon, 14 Apr 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7pVOzyY"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F2433CB
	for <linux-pm@vger.kernel.org>; Mon, 14 Apr 2025 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636769; cv=none; b=cuRJut5XzUjaU6IEBsrjyUfPGkEvROzQeMIk+SXtfEU9WeNbDrqs5gLlvQXxtf0KHAZByomx6ARgreX8Iu3KY2HUlYZb/n9gxE1yYm5VjsU3EyNqd2OKaGkwMdEcbDLhMT8aPVkbNYloj5y3Ssc5u4ohaUUnwhteklo+JI2+aas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636769; c=relaxed/simple;
	bh=4WbjWndT1sMKVQI5cmcoiYHcbPsF1JCdp/Dys+QMVtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi6WmPOouriVR1+lI9psZlyW2764nhO+WlUcIstPyLsPjOaKyjPI52XdhHhZHahJayiL3DxkG9b0z9nvWJlal7LfCi7U1bUZBZfTm5a0RHfBgwMK5oApnsdTcqaj/E6fZJcQxmyXlwc5oGa/uq1YOhNgaWrAJ6M+8D/lWNJ5a5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K7pVOzyY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744636766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4B6GaTPwmvnHhTHOaGuMDBI5sHEqGfaJZbjG4rKzdlo=;
	b=K7pVOzyY5e+2HfIN4lgF8pX6QBvuRLuq9qUh31KxeSUoX0Y3mmqz7Ui+nGKBrYzy1Qjx8H
	Q58xvoNXwvUa3vNaX3IddrkLt0u+U6y54Jcgd2GiNhTBtWK8n0ytgGK5/l8XOfTj3K8rDr
	vFNVV2dmx0fgaskN1/jEKpx7aQJDQzA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-Tgzuf07xNRK_xaL_4S8ENg-1; Mon,
 14 Apr 2025 09:19:23 -0400
X-MC-Unique: Tgzuf07xNRK_xaL_4S8ENg-1
X-Mimecast-MFC-AGG-ID: Tgzuf07xNRK_xaL_4S8ENg_1744636762
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C16C4195608A;
	Mon, 14 Apr 2025 13:19:21 +0000 (UTC)
Received: from carbon.redhat.com (unknown [10.44.32.142])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86FB13001D15;
	Mon, 14 Apr 2025 13:19:19 +0000 (UTC)
From: Jelle van der Waa <jvanderwaa@redhat.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Jelle van der Waa <jvanderwaa@redhat.com>
Subject: [PATCH v2 1/1] power: supply: support charge_types in extensions
Date: Mon, 14 Apr 2025 15:18:40 +0200
Message-ID: <20250414131840.382756-2-jvanderwaa@redhat.com>
In-Reply-To: <20250414131840.382756-1-jvanderwaa@redhat.com>
References: <20250414131840.382756-1-jvanderwaa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Similar to charge_behaviour, charge_types is an enum option where
reading the property shows the supported values, with the active value
surrounded by brackets. To be able to use it with a power_supply
extension a bitmask with the supported charge_Types values has to be
added to power_supply_ext.

Signed-off-by: Jelle van der Waa <jvanderwaa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
V1->V2: clarified commit message, fix small logic error discovered by
-Wparentheses and changed example charge_types to use Long
Life/Standard.
---
 drivers/power/supply/power_supply_sysfs.c | 23 ++++++++++++++++++++++-
 drivers/power/supply/test_power.c         | 20 ++++++++++++++++++--
 include/linux/power_supply.h              |  1 +
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index edb058c19c9c..6d80640511b5 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -321,6 +321,27 @@ static ssize_t power_supply_show_charge_behaviour(struct device *dev,
 						  value->intval, buf);
 }
 
+static ssize_t power_supply_show_charge_types(struct device *dev,
+					      struct power_supply *psy,
+					      enum power_supply_charge_type current_type,
+					      char *buf)
+{
+	struct power_supply_ext_registration *reg;
+
+	scoped_guard(rwsem_read, &psy->extensions_sem) {
+		power_supply_for_each_extension(reg, psy) {
+			if (power_supply_ext_has_property(reg->ext,
+							  POWER_SUPPLY_PROP_CHARGE_TYPES))
+				return power_supply_charge_types_show(dev,
+						reg->ext->charge_types,
+						current_type, buf);
+		}
+	}
+
+	return power_supply_charge_types_show(dev, psy->desc->charge_types,
+						  current_type, buf);
+}
+
 static ssize_t power_supply_format_property(struct device *dev,
 					    bool uevent,
 					    struct device_attribute *attr,
@@ -365,7 +386,7 @@ static ssize_t power_supply_format_property(struct device *dev,
 	case POWER_SUPPLY_PROP_CHARGE_TYPES:
 		if (uevent) /* no possible values in uevents */
 			goto default_format;
-		ret = power_supply_charge_types_show(dev, psy->desc->charge_types,
+		ret = power_supply_show_charge_types(dev, psy,
 						     value.intval, buf);
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index 2a975a110f48..b5f148081c51 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -37,6 +37,8 @@ static int battery_charge_counter	= -1000;
 static int battery_current		= -1600;
 static enum power_supply_charge_behaviour battery_charge_behaviour =
 	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+static enum power_supply_charge_type battery_charge_types =
+	POWER_SUPPLY_CHARGE_TYPE_STANDARD;
 static bool battery_extension;
 
 static bool module_initialized;
@@ -87,7 +89,7 @@ static int test_power_get_battery_property(struct power_supply *psy,
 		val->intval = battery_status;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
-		val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		val->intval = battery_charge_types;
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
 		val->intval = battery_health;
@@ -129,6 +131,9 @@ static int test_power_get_battery_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
 		val->intval = battery_charge_behaviour;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPES:
+		val->intval = battery_charge_types;
+		break;
 	default:
 		pr_info("%s: some properties deliberately report errors.\n",
 			__func__);
@@ -140,7 +145,7 @@ static int test_power_get_battery_property(struct power_supply *psy,
 static int test_power_battery_property_is_writeable(struct power_supply *psy,
 						    enum power_supply_property psp)
 {
-	return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR;
+	return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR || psp == POWER_SUPPLY_PROP_CHARGE_TYPES;
 }
 
 static int test_power_set_battery_property(struct power_supply *psy,
@@ -156,6 +161,14 @@ static int test_power_set_battery_property(struct power_supply *psy,
 		}
 		battery_charge_behaviour = val->intval;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPES:
+		if (val->intval < 0 ||
+		    val->intval >= BITS_PER_TYPE(typeof(psy->desc->charge_types)) ||
+		    !(BIT(val->intval) & psy->desc->charge_types)) {
+			return -EINVAL;
+		}
+		battery_charge_types = val->intval;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -188,6 +201,7 @@ static enum power_supply_property test_power_battery_props[] = {
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+	POWER_SUPPLY_PROP_CHARGE_TYPES,
 };
 
 static char *test_power_ac_supplied_to[] = {
@@ -215,6 +229,8 @@ static const struct power_supply_desc test_power_desc[] = {
 		.charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
 				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)
 				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE),
+		.charge_types = BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD)
+				   | BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE)
 	},
 	[TEST_USB] = {
 		.name = "test_usb",
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 888824592953..c4cb854971f5 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -288,6 +288,7 @@ struct power_supply_desc {
 struct power_supply_ext {
 	const char *const name;
 	u8 charge_behaviours;
+	u32 charge_types;
 	const enum power_supply_property *properties;
 	size_t num_properties;
 
-- 
2.49.0


