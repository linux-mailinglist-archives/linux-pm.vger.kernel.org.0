Return-Path: <linux-pm+bounces-24901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C370CA7EF72
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 22:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6B216F899
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 20:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FD721ABAC;
	Mon,  7 Apr 2025 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="pAN/g3r3"
X-Original-To: linux-pm@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F8E1C5F06
	for <linux-pm@vger.kernel.org>; Mon,  7 Apr 2025 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744059198; cv=none; b=EM8NAmiqVwhMbLUunQ27dlSv6i/pMa6PilJ+vkMsQ94ZnzqLwxegI32GcFoZ0M5J/GRSDIjuKkvBYtvrxyCcepUowZa39ITsOz3n6KnPDHIvwz1+sYsZBRK8OnPkL9fS8VbuEmWpjcac05Amy/bVBWmCJ0AWET9aWMur6nBhr7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744059198; c=relaxed/simple;
	bh=6UdzA84OUgTGKO1uqvZ1DbslZq1kXSRMOGSmqhIm3KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0LdKT973J8LPUf+LbP8C5UPAyAicgf0SqK367Uc5xwm2+m4ztf4b4SleEeoiY1Lv26IHGbk8jJvJW3cmM6a630StcUXzjCTTVWNf8fGi+hnbugQ/lZyI8mAsoAbDSfJl3IwpvE7KXjC1/rQC+Rq4phMie/DtJ1tmH1WGGmezp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=pAN/g3r3; arc=none smtp.client-ip=195.121.94.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
X-KPN-MessageId: 5b4f35aa-13f2-11f0-beb8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5b4f35aa-13f2-11f0-beb8-005056992ed3;
	Mon, 07 Apr 2025 22:53:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ZW9j9CVqft7u6ZmAvaLOCHdM98NK5xfmZrgJrWrJ2iM=;
	b=pAN/g3r39d60riu+w45IF1gJd6IcTczOBuxezBGoZfbOykTLXJnwZPLpmR9tiD9/jLK/zfKqVAjRp
	 2qD3ZI/LtiT5GkhoH/bCbar77jBa/KspT5HGSmZyykfCRgOt1w1hi8sRTkgSuxuW8Y2X48SF8maFgO
	 nNw9gORRybbAJSx0=
X-KPN-MID: 33|aCNIhL/PiBouYIsz44b2ylw1Qu54JSip1JtAuGiPcvsixYPcJ4l5/tKUtdcm4eq
 iRgV+55vd1dh68nscdfqDjP+uuh+dS/PlY+eV01aJ0+A=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|aJULggOI/JQSc4VC5KPvgBqq1cNubskUcNh3avS8uRz7y2Yz2ra5cA3TBdjoKq8
 pBNlnwmDlkS2jA3o2IBA1yg==
Received: from localhost.localdomain (77-171-66-179.fixed.kpn.net [77.171.66.179])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 2a527e8a-13f2-11f0-97d1-00505699d6e5;
	Mon, 07 Apr 2025 22:52:06 +0200 (CEST)
From: Jelle van der Waa <jvanderw@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org,
	Jelle van der Waa <jvanderwaa@redhat.com>
Subject: [PATCH 1/1] power: supply: support charge_types in extensions
Date: Mon,  7 Apr 2025 22:18:45 +0200
Message-ID: <20250407201845.332348-2-jvanderw@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407201845.332348-1-jvanderw@redhat.com>
References: <20250407201845.332348-1-jvanderw@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jelle van der Waa <jvanderwaa@redhat.com>

Similar to charge_behaviour, charge_types is an enum option with
multiple possible values. To be able to use it with a power_supply
extension its known values have to be exposed.

Signed-off-by: Jelle van der Waa <jvanderwaa@redhat.com>
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
index 2a975a110f48..0d9cc0c5613e 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -37,6 +37,8 @@ static int battery_charge_counter	= -1000;
 static int battery_current		= -1600;
 static enum power_supply_charge_behaviour battery_charge_behaviour =
 	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+static enum power_supply_charge_type battery_charge_types =
+	POWER_SUPPLY_CHARGE_TYPE_NONE;
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
+	return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR | POWER_SUPPLY_PROP_CHARGE_TYPES;
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
+		.charge_types = BIT(POWER_SUPPLY_CHARGE_TYPE_NONE)
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


