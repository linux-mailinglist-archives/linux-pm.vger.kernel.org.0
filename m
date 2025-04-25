Return-Path: <linux-pm+bounces-26260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBACA9D61B
	for <lists+linux-pm@lfdr.de>; Sat, 26 Apr 2025 01:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32D31BC868C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 23:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D35297A5D;
	Fri, 25 Apr 2025 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="eIP9t2hU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B7297A51;
	Fri, 25 Apr 2025 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745622933; cv=none; b=bSJm16E0HJDBkYyxYv1BJBUtUh9aD598HyxTCHx+C7KEIooA2O7nYoFuPXPBPWzGDPUCP1xixQoqyQ2skv119GJrIoxl6AOZmEfhZliIFZ6TQhtb/6FgEatudBJwj2RerAPnd4NBR0HzspIbaviKZT//k8OBlu46ZOWimulcNZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745622933; c=relaxed/simple;
	bh=B1bGCnb0p0EausLCfNDFBg5v1GfoFoL2EjWsSCjsRyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZDAiMwcBpe93LFNsoqV75i2++XpNlL6Gabp0F5atOPSUZ/HArTlXoDOE34XxYuTRTh1bzKlOIo9KEaDOc2NWYn6SBnlMhV5Av5iER1quiBlRc5q2i3ZALM9x5o+eE8xucjSYuxI3L5xfSchRW71AfUlIxb9iAMX1GdASIuwnuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=eIP9t2hU; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745622927; x=1746227727; i=w_armin@gmx.de;
	bh=kp0fA/Y9blrQcx5RK3lNRwlX0u7H+VQ9eRNUaAdnd9g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eIP9t2hUoMJDGMFP4Mweih39u53yweFXcvQQsh6kfaOrh/uNjUjEbZiaqwrOrjNk
	 hVGh50cJi6if9zMKVu1vkyiBOhB0tS2pRoAXj5deW7PMnq5rUSAySkVBMBuZWaJ8o
	 hymv2miMbUSFiXRHaJ5SggK06N0exQ3msTmM/8XMfodb7dro7ibdT88LNADt7IL6m
	 uGfDSKQoe3mN9zvRWLviaLc6zh37XJiORYSCTlhknIZuD3RtYdXIZgmg9JQH0oY+5
	 9PVfiAENM4xBHquxVq82CZAMFljiLnsPLRdlSm9zV0OE+dt+NAxbq16+7cNTSV7Zx
	 ylw2vrlQ65XpHfOXFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MPGW7-1uRU3O2Io9-00S0V5; Sat, 26 Apr 2025 01:15:27 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: sre@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] platform/x86: dell-ddv: Implement the battery matching algorithm
Date: Sat, 26 Apr 2025 01:15:16 +0200
Message-Id: <20250425231518.16125-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250425231518.16125-1-W_Armin@gmx.de>
References: <20250425231518.16125-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lbGfmQUP8rggWftFOjnne6fH8S9YfhL6ebzupkQOu/NmCxe+GgQ
 CPB7AadMCnQheG3GnVvUztFFv3omYDbnV70IS8ODPRMAQc8UaGtrD/FJV8YdIvpDZPFed+a
 cO9ZlTD5RG+t1yG990KyZjlP76y3iUkgVGJmMKQepvlP32V70SWqqQsXFF4ZQeBDuaT2INo
 cl/6LXEfgOlWC2w/ayZ/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:83YDHOblOio=;u8YmvK2AiwStFlcdr8K+LeXk8iR
 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

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


