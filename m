Return-Path: <linux-pm+bounces-26343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987C1A9FE6C
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 02:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AC73ACA71
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 00:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9D080034;
	Tue, 29 Apr 2025 00:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="N2Xp7MR4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DD8C148;
	Tue, 29 Apr 2025 00:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886984; cv=none; b=Gu2WsH3xv/Ms7IPgAUcdQRou0Hn8rXYBUz/0DvNQKEnavUCQZNpp75y7qTPGEFLvcVqbOYbk9996HgeZOzlbeIYVCbqOliDl+e6IFIeuR0cJZx6mCOun4FWxbsUaouKIP2efKzD4pbBr5OgQQ0zcSOLhTM5PzlCPkoGOx7gdT0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886984; c=relaxed/simple;
	bh=B1bGCnb0p0EausLCfNDFBg5v1GfoFoL2EjWsSCjsRyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kvKrtiOfVCWKa6pZ0yc6GkOpxbAYQTdA578eMzQoC+QEwwsBUgFfbpTtG725rzCo7n4tU2ZbEXW3AeIGYRwSjAr5tE9wcN80t6wHcdnXDa7QVwGFBolSt4P/7BcMoIps3ocmfHb01TyVn5qmFjZBP6G6mCyX+shVtP76ndZQGRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=N2Xp7MR4; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745886980; x=1746491780; i=w_armin@gmx.de;
	bh=kp0fA/Y9blrQcx5RK3lNRwlX0u7H+VQ9eRNUaAdnd9g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N2Xp7MR4qX0oMiZhMtH7rkJsajpYMwWVk/hLBwqTAy0Bl4wrTUCRi2zp5Gn5GlAY
	 HHvlPTcpZiML4SkmhP0lwDmULA10WmuEFLHKoIGik56/QUO8NlhtMs2Oddw5RMp3I
	 6jAhULuvB3NUlyecrYCo6RqYsK0EehmY93uSlE4BK8n6RjxmgIyEUN2q4pNviZjLd
	 SrMjxcLwARvZPfCcQovqdERnGTTSKQaUND08BYXgniIBfFRsjuhsuUc8WAy5P4pyc
	 1Pc8Nk6FolF4qnWausZbi/jG5AReeC+Hc24Yr0ThSVC1O/9S80ukCyGh1x3Yb9Ac2
	 tOys/1mkihbGl85v1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MybKf-1uzi6z0FNF-018LU9; Tue, 29 Apr 2025 02:36:20 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: sre@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] platform/x86: dell-ddv: Implement the battery matching algorithm
Date: Tue, 29 Apr 2025 02:36:04 +0200
Message-Id: <20250429003606.303870-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429003606.303870-1-W_Armin@gmx.de>
References: <20250429003606.303870-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ddesl4+Sh68QSSz3lQXzDPiWySQO0xsoQvBbxFapNwYhc4AsW1S
 8ykDsHAZ2Icm6A9YUeTZ/6hdQ7diZELpd2QHvWHMwc+HA781IcJ/ojt41FoFU47ZQ8kssVO
 1MvXONAwhmEdwWIQr9uWFTkcq8aPVUpo5uWMkgCoK9chg2v+7DvrmBF7adXSB656I4reZQz
 zwdVv3kzE6uBFn4cRjopQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R8/bia6T3lM=;/uCq9YmCOnRWro8ErcHxqrh/hGL
 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
 sP1g=

Since commit db0a507cb24d ("ACPICA: Update integer-to-hex-string
conversions") the battery serial number is no longer distorted,
allowing us to finally implement the battery matching algorithm.

The battery matchign algorithm is necessary when translating between
ACPI batteries and the associated indices used by the WMI interface
based on the battery serial number. Since this serial number can only
be retrieved when the battery is present we cannot perform the initial
translation inside dell_wmi_ddv_add_battery() because the ACPI battery
might be absent at this point in time.

Introduce dell_wmi_ddv_battery_translate() which implements the
battery matching algorithm and replaces dell_wmi_ddv_battery_index().
Also implement a translation cache for caching previous translations
between ACPI batteries and indices. This is necessary because
performing a translation can be very expensive.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/wmi/devices/dell-wmi-ddv.rst |   8 --
 drivers/platform/x86/dell/dell-wmi-ddv.c   | 101 ++++++++++++++++++---
 2 files changed, 88 insertions(+), 21 deletions(-)

diff --git a/Documentation/wmi/devices/dell-wmi-ddv.rst b/Documentation/wm=
i/devices/dell-wmi-ddv.rst
index e0c20af30948..f10a623acca1 100644
=2D-- a/Documentation/wmi/devices/dell-wmi-ddv.rst
+++ b/Documentation/wmi/devices/dell-wmi-ddv.rst
@@ -260,14 +260,6 @@ Some machines like the Dell Inspiron 3505 only suppor=
t a single battery and thus
 ignore the battery index. Because of this the driver depends on the ACPI =
battery
 hook mechanism to discover batteries.
=20
-.. note::
-   The ACPI battery matching algorithm currently used inside the driver i=
s
-   outdated and does not match the algorithm described above. The reasons=
 for
-   this are differences in the handling of the ToHexString() ACPI opcode =
between
-   Linux and Windows, which distorts the serial number of ACPI batteries =
on many
-   machines. Until this issue is resolved, the driver cannot use the abov=
e
-   algorithm.
-
 Reverse-Engineering the DDV WMI interface
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index f27739da380f..711639001be4 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -39,6 +39,9 @@
 #define DELL_DDV_SUPPORTED_VERSION_MAX	3
 #define DELL_DDV_GUID	"8A42EA14-4F2A-FD45-6422-0087F7A7E608"
=20
+/* Battery indices 1, 2 and 3 */
+#define DELL_DDV_NUM_BATTERIES		3
+
 #define DELL_EPPID_LENGTH	20
 #define DELL_EPPID_EXT_LENGTH	23
=20
@@ -105,6 +108,8 @@ struct dell_wmi_ddv_sensors {
 struct dell_wmi_ddv_data {
 	struct acpi_battery_hook hook;
 	struct device_attribute eppid_attr;
+	struct mutex translation_cache_lock;	/* Protects the translation cache *=
/
+	struct power_supply *translation_cache[DELL_DDV_NUM_BATTERIES];
 	struct dell_wmi_ddv_sensors fans;
 	struct dell_wmi_ddv_sensors temps;
 	struct wmi_device *wdev;
@@ -639,15 +644,78 @@ static int dell_wmi_ddv_hwmon_add(struct dell_wmi_dd=
v_data *data)
 	return ret;
 }
=20
-static int dell_wmi_ddv_battery_index(struct acpi_device *acpi_dev, u32 *=
index)
+static int dell_wmi_ddv_battery_translate(struct dell_wmi_ddv_data *data,
+					  struct power_supply *battery, u32 *index)
 {
-	const char *uid_str;
+	u32 serial_dec, serial_hex, serial;
+	union power_supply_propval val;
+	int ret;
+
+	guard(mutex)(&data->translation_cache_lock);
+
+	for (int i =3D 0; i < ARRAY_SIZE(data->translation_cache); i++) {
+		if (data->translation_cache[i] =3D=3D battery) {
+			dev_dbg(&data->wdev->dev, "Translation cache hit for battery index %u\=
n",
+				i + 1);
+			*index =3D i + 1;
+			return 0;
+		}
+	}
+
+	dev_dbg(&data->wdev->dev, "Translation cache miss\n");
+
+	/* Perform a translation between a ACPI battery and a battery index */
+
+	ret =3D power_supply_get_property(battery, POWER_SUPPLY_PROP_SERIAL_NUMB=
ER, &val);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Some devices display the serial number of the ACPI battery (string!) =
as a decimal
+	 * number while other devices display it as a hexadecimal number. Becaus=
e of this we
+	 * have to check both cases.
+	 */
+	ret =3D kstrtou32(val.strval, 16, &serial_hex);
+	if (ret < 0)
+		return ret;	/* Should never fail */
+
+	ret =3D kstrtou32(val.strval, 10, &serial_dec);
+	if (ret < 0)
+		serial_dec =3D 0; /* Can fail, thus we only mark serial_dec as invalid =
*/
+
+	for (int i =3D 0; i < ARRAY_SIZE(data->translation_cache); i++) {
+		ret =3D dell_wmi_ddv_query_integer(data->wdev, DELL_DDV_BATTERY_SERIAL_=
NUMBER, i + 1,
+						 &serial);
+		if (ret < 0)
+			return ret;
=20
-	uid_str =3D acpi_device_uid(acpi_dev);
-	if (!uid_str)
-		return -ENODEV;
+		/* A serial number of 0 signals that this index is not associated with =
a battery */
+		if (!serial)
+			continue;
=20
-	return kstrtou32(uid_str, 10, index);
+		if (serial =3D=3D serial_dec || serial =3D=3D serial_hex) {
+			dev_dbg(&data->wdev->dev, "Translation cache update for battery index =
%u\n",
+				i + 1);
+			data->translation_cache[i] =3D battery;
+			*index =3D i + 1;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+static void dell_wmi_battery_invalidate(struct dell_wmi_ddv_data *data,
+					struct power_supply *battery)
+{
+	guard(mutex)(&data->translation_cache_lock);
+
+	for (int i =3D 0; i < ARRAY_SIZE(data->translation_cache); i++) {
+		if (data->translation_cache[i] =3D=3D battery) {
+			data->translation_cache[i] =3D NULL;
+			return;
+		}
+	}
 }
=20
 static ssize_t eppid_show(struct device *dev, struct device_attribute *at=
tr, char *buf)
@@ -657,7 +725,7 @@ static ssize_t eppid_show(struct device *dev, struct d=
evice_attribute *attr, cha
 	u32 index;
 	int ret;
=20
-	ret =3D dell_wmi_ddv_battery_index(to_acpi_device(dev->parent), &index);
+	ret =3D dell_wmi_ddv_battery_translate(data, to_power_supply(dev), &inde=
x);
 	if (ret < 0)
 		return ret;
=20
@@ -684,7 +752,7 @@ static int dell_wmi_ddv_get_property(struct power_supp=
ly *psy, const struct powe
 	u32 index, value;
 	int ret;
=20
-	ret =3D dell_wmi_ddv_battery_index(to_acpi_device(psy->dev.parent), &ind=
ex);
+	ret =3D dell_wmi_ddv_battery_translate(data, psy, &index);
 	if (ret < 0)
 		return ret;
=20
@@ -719,13 +787,12 @@ static const struct power_supply_ext dell_wmi_ddv_ex=
tension =3D {
 static int dell_wmi_ddv_add_battery(struct power_supply *battery, struct =
acpi_battery_hook *hook)
 {
 	struct dell_wmi_ddv_data *data =3D container_of(hook, struct dell_wmi_dd=
v_data, hook);
-	u32 index;
 	int ret;
=20
-	/* Return 0 instead of error to avoid being unloaded */
-	ret =3D dell_wmi_ddv_battery_index(to_acpi_device(battery->dev.parent), =
&index);
-	if (ret < 0)
-		return 0;
+	/*
+	 * We cannot do the battery matching here since the battery might be abs=
ent, preventing
+	 * us from reading the serial number.
+	 */
=20
 	ret =3D device_create_file(&battery->dev, &data->eppid_attr);
 	if (ret < 0)
@@ -749,11 +816,19 @@ static int dell_wmi_ddv_remove_battery(struct power_=
supply *battery, struct acpi
 	device_remove_file(&battery->dev, &data->eppid_attr);
 	power_supply_unregister_extension(battery, &dell_wmi_ddv_extension);
=20
+	dell_wmi_battery_invalidate(data, battery);
+
 	return 0;
 }
=20
 static int dell_wmi_ddv_battery_add(struct dell_wmi_ddv_data *data)
 {
+	int ret;
+
+	ret =3D devm_mutex_init(&data->wdev->dev, &data->translation_cache_lock)=
;
+	if (ret < 0)
+		return ret;
+
 	data->hook.name =3D "Dell DDV Battery Extension";
 	data->hook.add_battery =3D dell_wmi_ddv_add_battery;
 	data->hook.remove_battery =3D dell_wmi_ddv_remove_battery;
=2D-=20
2.39.5


