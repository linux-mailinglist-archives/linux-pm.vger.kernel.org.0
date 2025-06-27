Return-Path: <linux-pm+bounces-29719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C75B1AEC18A
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 22:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD962564C52
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 20:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13362E92DE;
	Fri, 27 Jun 2025 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="CKvQqpXZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854CA1F3FED;
	Fri, 27 Jun 2025 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057618; cv=none; b=P0iWIbCzHAAWskVFoRnfr5mdLEzvhXWeuOIB/grB9Bz8nNO+dNinPqv0F+SBe3FVN8yAr8QTS0kK+P36+snhPbSLjueyrDXRktoJYGo1Z12Zc4pHYA/giesteVa8eDM9arY0jnebCRTfkcgQnBurh9sSoq7keD8+u16tEjEeHhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057618; c=relaxed/simple;
	bh=Q5MfKjbjYSrHdzI3fRMl17kM6NaOgiBesjgXDepXjh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rr7Qy17ZWBxRgb0hjScHD1YPKBPJLhbcb6bl669HsEh3rncbgETl1O5q1EC5ORMtvdBnR4Mv1Ou5LF/ityX1Xc1odZi1gt4q5Xa0qe6i1peG5g3/cYTA3jRgwHLa6QDW4oBpFNHmxIlIIsElK2TAWYClkPZr+HVHSf9RkfVWQy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=CKvQqpXZ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751057611; x=1751662411; i=w_armin@gmx.de;
	bh=hUUsqnZQFIKQOpOknR8UAJqoZYk2LlPuCBFJSqKkl6Q=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CKvQqpXZjZiX01PNrXM2AN3MUT9eQYUxFRsRvIo74mFW4vwZ6z+w/NfQqf3dCTat
	 FSYsxyuTdHvp45fHD2zMscgIoiloVnjUYhfwErtJjy4Xs7JyIxsuvfD//Ki5cDLKY
	 wjlDNo9XIL86zQkdLXzRWAFY5fL6s0uLWcThtej0vWvSfmtzfczBai0f3UfM2Jsi0
	 sPWct/bxCH8IMqhxTHSpgMM5+4xg/janiQ6ODsN6ubKoz720CUvpkJhV//uiv/wr4
	 r88A2jwn2iH0Lbc+kdZAF3XPr7hbRPBWV52ii/jGiuhFj2XVC6ANNVR+k0YFllsja
	 gIFZKOQ8ulaESEv4AA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MVeI2-1uLSQx1NP2-00UXQr; Fri, 27 Jun 2025 22:53:31 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: sre@kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@weissschuh.net
Subject: [PATCH 1/3] power: supply: core: Add power_supply_get/set_property_direct()
Date: Fri, 27 Jun 2025 22:53:23 +0200
Message-Id: <20250627205325.250608-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yY/QoVX0uRnKg+Z99TOquIieW82z5uYuYktDe2C/lpUTRtRiWZz
 TeYI5Um++7mEa/90yZZj1NKPoAM0+hGT6RTz97fh/Hr0kYqEOjv03JMeJLsULjYHHzxxl+t
 TcJ7xwkfWURxp19Y1HG4a5sxgcWJX2qL9YvL3xIicoEe90nsps27P3h2/oUpP5+dNVg4DdT
 x2QhGaDeAgezfXlU98pGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nZI7wk40r9Q=;4oLK9CycJ+jBSLDEJjmlV8Dec9j
 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

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


