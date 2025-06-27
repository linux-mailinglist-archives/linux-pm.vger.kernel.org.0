Return-Path: <linux-pm+bounces-29716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2469AEC17F
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 22:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D3F56442A
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 20:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36D02ED157;
	Fri, 27 Jun 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Ldtv7Iig"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F9F2ECD11;
	Fri, 27 Jun 2025 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057505; cv=none; b=Eg4laSehJ8LOXExcKZT1u6p+hhTbsgQSvk0ZjmDqjxEtf/JMR/bgFwPfW0bTO+vhRp0ZaPBdYuhr/wkD3t5kOSF6zc79ZPo3kprX+o6sjEowrnLqtmwq7c84Al/89q3nVTBFxK36ndOsGQ1Jsp/uUiwVvTBqKlwiURuWGY79OeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057505; c=relaxed/simple;
	bh=Q5MfKjbjYSrHdzI3fRMl17kM6NaOgiBesjgXDepXjh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nbr4MDje9J5X01sACoAeCbvTmySyMgdUtVFRIwTqRBn/79L5g3FKaaadR8cVfNoSxepUVk6ja1TiAIspLvsfBbDAPGbe/Gs5Dmi3LOSglsmcNqoR3neOim47k0JGvWDSuZ/isvEGeRu/FOdZx/gUqSGHCxMQ3x+4XPzeHxKA3Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Ldtv7Iig; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751057490; x=1751662290; i=w_armin@gmx.de;
	bh=hUUsqnZQFIKQOpOknR8UAJqoZYk2LlPuCBFJSqKkl6Q=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ldtv7Iig848QpAP5wVXd4YoO6HY4SawZhByD2INWouNKbCBWVBygP9vnCvFjzwIP
	 GfOnmJDiSckC+grtvYwYQq0QgzGlNmb2f2wW3BS2yEE/JgBxbAoVHOupxEj8Ytsyv
	 Gkw+p/IQnnF7zl3VCzisc4/S6AByWGjL3/mqe5GGHAs1aiGv5ELnPYlaALVdsWe9R
	 3h8JeE0F/rFA/Y2u9UuQwXTBOg6qw1p7DSALrOFhq4UZZDbD/+mpVIhFmMqHQNwQO
	 bA2BLE+OONDnoVRXzMc8WOBjbYKgJPT/vZAogA9FCk2vgs2daxUvEUOb/TzT1LDNP
	 /coRDUSdqk72bVvG4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MCKBc-1udXma11oA-00BMIX; Fri, 27 Jun 2025 22:51:30 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: sre@kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] power: supply: core: Add power_supply_get/set_property_direct()
Date: Fri, 27 Jun 2025 22:51:22 +0200
Message-Id: <20250627205124.250433-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Czqf/QmY1VhuYFd4Y/U3MK9Zmg2XtuxSgMU8x5YH5gl7DQ4xiE5
 KIgtMCMYPn9w5vdxz+1n3kWmovB0GREyPPmuh4tU6fP59uv4smeHLeMHA4oZ8tj0q/Biw0x
 KFIinFVJxAe47SIstV73jHQoJrFjeVTPLzQvlH1Tywtg9LjBWzRclU+09H4uVGeVeJEaafI
 bwM9F7yQzD7kQiHS8klIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:trIV/CNFxzk=;xsZvodsyVZGd1mgcihGYZiwdHlL
 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
 F5U6vA8GY/Oo1Vn/dDwF9PUf2J6U/3Vw=

Power supply extensions might want to interact with the underlying
power supply to retrieve data like serial numbers, charging status
and more. However doing so causes psy->extensions_sem to be locked
twice, possibly causing a deadlock.

Provide special variants of power_supply_get/set_property() that
ignore any power supply extensions and thus do not touch the
associated psy->extensions_sem lock.

Suggested-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/power/supply/power_supply_core.c | 82 ++++++++++++++++++++----
 include/linux/power_supply.h             |  8 +++
 2 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supp=
ly/power_supply_core.c
index aedb20c1d276..e70ffedf1a80 100644
=2D-- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1241,9 +1241,8 @@ bool power_supply_has_property(struct power_supply *=
psy,
 	return false;
 }
=20
-int power_supply_get_property(struct power_supply *psy,
-			    enum power_supply_property psp,
-			    union power_supply_propval *val)
+static int __power_supply_get_property(struct power_supply *psy, enum pow=
er_supply_property psp,
+				       union power_supply_propval *val, bool use_extensions)
 {
 	struct power_supply_ext_registration *reg;
=20
@@ -1253,10 +1252,14 @@ int power_supply_get_property(struct power_supply =
*psy,
 		return -ENODEV;
 	}
=20
-	scoped_guard(rwsem_read, &psy->extensions_sem) {
-		power_supply_for_each_extension(reg, psy) {
-			if (power_supply_ext_has_property(reg->ext, psp))
+	if (use_extensions) {
+		scoped_guard(rwsem_read, &psy->extensions_sem) {
+			power_supply_for_each_extension(reg, psy) {
+				if (!power_supply_ext_has_property(reg->ext, psp))
+					continue;
+
 				return reg->ext->get_property(psy, reg->ext, reg->data, psp, val);
+			}
 		}
 	}
=20
@@ -1267,20 +1270,49 @@ int power_supply_get_property(struct power_supply =
*psy,
 	else
 		return -EINVAL;
 }
+
+int power_supply_get_property(struct power_supply *psy, enum power_supply=
_property psp,
+			      union power_supply_propval *val)
+{
+	return __power_supply_get_property(psy, psp, val, true);
+}
 EXPORT_SYMBOL_GPL(power_supply_get_property);
=20
-int power_supply_set_property(struct power_supply *psy,
-			    enum power_supply_property psp,
-			    const union power_supply_propval *val)
+/**
+ * power_supply_get_property_direct - Read a power supply property withou=
t checking for extensions
+ * @psy: The power supply
+ * @psp: The power supply property to read
+ * @val: The resulting value of the power supply property
+ *
+ * Read a power supply property without taking into account any power sup=
ply extensions registered
+ * on the given power supply. This is mostly useful for power supply exte=
nsions that want to access
+ * their own power supply as using power_supply_get_property() directly w=
ill result in a potential
+ * deadlock.
+ *
+ * Return: 0 on success or negative error code on failure.
+ */
+int power_supply_get_property_direct(struct power_supply *psy, enum power=
_supply_property psp,
+				     union power_supply_propval *val)
+{
+        return __power_supply_get_property(psy, psp, val, false);
+}
+EXPORT_SYMBOL_GPL(power_supply_get_property_direct);
+
+
+static int __power_supply_set_property(struct power_supply *psy, enum pow=
er_supply_property psp,
+				       const union power_supply_propval *val, bool use_extensions)
 {
 	struct power_supply_ext_registration *reg;
=20
 	if (atomic_read(&psy->use_cnt) <=3D 0)
 		return -ENODEV;
=20
-	scoped_guard(rwsem_read, &psy->extensions_sem) {
-		power_supply_for_each_extension(reg, psy) {
-			if (power_supply_ext_has_property(reg->ext, psp)) {
+	if (use_extensions) {
+		scoped_guard(rwsem_read, &psy->extensions_sem) {
+			power_supply_for_each_extension(reg, psy) {
+				if (!power_supply_ext_has_property(reg->ext, psp))
+					continue;
+
 				if (reg->ext->set_property)
 					return reg->ext->set_property(psy, reg->ext, reg->data,
 								      psp, val);
@@ -1295,8 +1327,34 @@ int power_supply_set_property(struct power_supply *=
psy,
=20
 	return psy->desc->set_property(psy, psp, val);
 }
+
+int power_supply_set_property(struct power_supply *psy, enum power_supply=
_property psp,
+			      const union power_supply_propval *val)
+{
+	return __power_supply_set_property(psy, psp, val, true);
+}
 EXPORT_SYMBOL_GPL(power_supply_set_property);
=20
+/**
+ * power_supply_set_property_direct - Write a power supply property witho=
ut checking for extensions
+ * @psy: The power supply
+ * @psp: The power supply property to write
+ * @val: The value to write to the power supply property
+ *
+ * Write a power supply property without taking into account any power su=
pply extensions registered
+ * on the given power supply. This is mostly useful for power supply exte=
nsions that want to access
+ * their own power supply as using power_supply_set_property() directly w=
ill result in a potential
+ * deadlock.
+ *
+ * Return: 0 on success or negative error code on failure.
+ */
+int power_supply_set_property_direct(struct power_supply *psy, enum power=
_supply_property psp,
+				     const union power_supply_propval *val)
+{
+	return __power_supply_set_property(psy, psp, val, false);
+}
+EXPORT_SYMBOL_GPL(power_supply_set_property_direct);
+
 int power_supply_property_is_writeable(struct power_supply *psy,
 					enum power_supply_property psp)
 {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 45468959dd98..f21f806bfb38 100644
=2D-- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -878,15 +878,23 @@ static inline int power_supply_is_system_supplied(vo=
id) { return -ENOSYS; }
 extern int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val);
+int power_supply_get_property_direct(struct power_supply *psy, enum power=
_supply_property psp,
+				     union power_supply_propval *val);
 #if IS_ENABLED(CONFIG_POWER_SUPPLY)
 extern int power_supply_set_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    const union power_supply_propval *val);
+int power_supply_set_property_direct(struct power_supply *psy, enum power=
_supply_property psp,
+				     const union power_supply_propval *val);
 #else
 static inline int power_supply_set_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    const union power_supply_propval *val)
 { return 0; }
+static inline int power_supply_set_property_direct(struct power_supply *p=
sy,
+						   enum power_supply_property psp,
+						   const union power_supply_propval *val)
+{ return 0; }
 #endif
 extern void power_supply_external_power_changed(struct power_supply *psy)=
;
=20
=2D-=20
2.39.5


