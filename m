Return-Path: <linux-pm+bounces-23462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A740A4F690
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 06:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 636D47A51C1
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 05:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493451DF982;
	Wed,  5 Mar 2025 05:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ki0lEhz6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FB81DB924;
	Wed,  5 Mar 2025 05:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741152630; cv=none; b=kXJ8skViQ0KTnaXUd0YFzkSRjScAtUAuyLyQeqrxwV08wtN/QDztoFFG0r9jQrpRCf6ZM5KjRvm73k5hdPdcNKTUf3XbzZxhBZ/+J00W6nT8uS/fvXbTIS5OKnYbzvZeJkYdypBV2vXjG8Lp+o4U4ezSG6a5YRGZ/QEHu29dmug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741152630; c=relaxed/simple;
	bh=QoYw3EV2PTQQEHPlv4pDNm31tpLdrgmMIQezAA0ysFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mmx0EjPBOuOwM2+fk2h+Yl0kthwUjKFQ+KlgTKJRXzp15Q5s+IXOssIkGVPRkH4HazrDoTFwkCY8CIzfal9ctFJjYKbG3aQaa/X4qqduxCSt5EBE35bQDymnOcb8zM1Sn7+JDyANiTU7vUqSrxPYEr0vKLzRC+gyvmPtlkDFGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ki0lEhz6; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741152624; x=1741757424; i=w_armin@gmx.de;
	bh=qiYfmLTFay8BFeSgQBCeWuSFU5BJ2TAwpkl8owzumx8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ki0lEhz6AhPUIDaMOsKv6R1KZbRgcpxw+Os0jCCv/a9MW/KqLxxmbqqaPo9GrfYm
	 rD66fkcVwPaDHk0Ba8MKy6P6pbcpC1JvKHLLKDObgJ4frPd0cjOqPDi/guN8QxvHi
	 QIdyPiNW9+GDktBra3Mnc+cfu8ZLIH/g81Bq/T4Vlx3QQKJ3Yu3J6HjsIHAMmaN4X
	 YZNhp+crhuArAad8Uc1zzMBlhLPGSv0eudnVTk3Oiv1GJYuRiwMr88BYIQ55miQXS
	 r3IeZMCgXMg1cdmDxk5s+QLvgPSF7i7e8cnyO9XMRa5YxkhlLVZTJiyjc6JxPFdkO
	 5bWUK9fhzDViFuBS3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N17UW-1t97Yb36Wg-00vqf7; Wed, 05 Mar 2025 06:30:24 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	sre@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] platform/x86: dell-ddv: Use the power supply extension mechanism
Date: Wed,  5 Mar 2025 06:30:09 +0100
Message-Id: <20250305053009.378609-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305053009.378609-1-W_Armin@gmx.de>
References: <20250305053009.378609-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nf9M9MaBNKOuPHI5xkQ87fIO7LtPgVmw4Mw0qsu38SEo4jGdBG1
 5rD7nJ0O+gGjQfjKiWvhA3TCzGEL9MDQ2gEBl6ciIEfLRsi0aoRPG2gh8+7piL1BIpLtWAY
 1S4j+v7KLv5Kf95PX+V63KyCmTdsCo9TP5+ptdfjZlX3FZzBptIqZblytdwCd6IG23WqQhR
 fIwOICg+Eh7rioHv5phGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8/lsEW3TzyY=;udIEPtmDdIunPZPUwal8wMeh++z
 9a4bKnX/tlW5MxBax9pTU53oMXSjUbYU+6zJCJpwmknrGzQivskhXjYC1V5MMR3W8KUvIDFKf
 kaqY4jxxbO1hgVrRmTaHyWsEJNJFdA1W+9Ijie6tqkDhqtlOVu4hsC5Y6BuvV/Py5vLHQajiX
 ASqGwjcZl3oKc525jGwCJTpSE607pkmV0oly9pmlxhKsaKutLASstb/dH7cnXIHGcihxHeMll
 8GP0T9uyeUXh8KKUbCuoNwInBieRBOHKHpxmTvcoESDuOFmJNZZGUF/38dnZHVXN6Tm6R5GLG
 5eUjnV7MVCHdu9nK4ndBK7+Z3Ok6gc5P/dx6xkMjHkPlY0AAkPSDljNHpB/rSF+b/EIqNlIU6
 JNBISipy/DQ8sFEgiCNibOa9ck+s/oimLF/RI8u3Ueo228ejewZwxhU3l74tm/IKUFY5ARugg
 QmO2LTpCIVI61xysj3T0bSidT3d0CZ5CMNgfMCvo3ZBejOkpsqJgouFoDV/1j0zcmgFdT5LY9
 nvEiLLtN1SLE7m1EiOkj3oLBswT8T1QtgUagmtEVqXhTt1lc1bQfWqGjvIj9eeI+QCpwmAT1z
 1jNWRmZsHVZn6vCJTSt2IYB27IC8lmSJOyTYMv0zfiB2rsOmQOuOxEdYIv/4O5e2MFkdXEBY9
 RGfj0HsjL5vQRJBBZjHO3o6vu1tRHu682OC403Vr98KDDiNA0jDu4QTre+cebHPdF6lIEAVrR
 UKAWFFzfSnpsYWoh/2dLtwR2ChN/uPzzHtrQfW5/xtx+gmMK4MQWsymsy4prU/eAZ9Nlf+2/l
 Sd1LQ6FnWZlBI8m1neKl6UR4hLkPCCL9Tl8lkB5D/R6uddXSdKJ1bm0ZIV9jPLXzRITeAGMtL
 ZcfsIixU8lufjIxrvlJa9sXhB5rjpqdXyXDvybLPdzohw++5H5E98/8/SqPNRXQAcdjT8hLkT
 U7JrgVC6sYwR+jbUcl79iGz3w6fJSI8nm6s4yebip+zFTvoDmKJuAwbNTLE5FdaTD/dROx72V
 XfLHNwynGKkGtvGRl8JsFeuaqYmsrdrHGL7zwT1bQnApbulOlH4bfHVqZfZpNPDKELimz2dUW
 OivKhrKFTR+nOyxLW3+AKPNpfh571iUg+cUAJG16XiKNMR1bAPDZ9MEmMHlR9SAp0b6YdelnL
 Adn4Jdy/QhflE0lt3vR8f8ldGG8l+ec4E/yy3Cn8NTXb4rtnPStWedHD1+6O0o/ufCS2YlL9y
 eaELwxszruDDGVWy3a0AzRwvoXkd7wHFiEakuEu7W3SMTzmsBomkiGGufKr/ayNqLiGTq9Q3H
 cqSzG3AdjoM2T5ZB5ymhqBOLZ9/MrOXNHjTBWzONCWqJSYZCCbOclNDyocaGFD6yXkVm21Ur5
 c/JtWhTqkB0DPysXTesjlPgyy1J1FWM2oKLdsLtfI6TaOnRh22lB5OWsu3

Use the power supply extension mechanism for registering the battery
temperature properties so that they can show up in the hwmon device
associated with the ACPI battery.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-wmi-ddv.c | 75 ++++++++++++++----------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index 811cddab57fc..f27739da380f 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -104,7 +104,6 @@ struct dell_wmi_ddv_sensors {

 struct dell_wmi_ddv_data {
 	struct acpi_battery_hook hook;
-	struct device_attribute temp_attr;
 	struct device_attribute eppid_attr;
 	struct dell_wmi_ddv_sensors fans;
 	struct dell_wmi_ddv_sensors temps;
@@ -651,26 +650,6 @@ static int dell_wmi_ddv_battery_index(struct acpi_dev=
ice *acpi_dev, u32 *index)
 	return kstrtou32(uid_str, 10, index);
 }

-static ssize_t temp_show(struct device *dev, struct device_attribute *att=
r, char *buf)
-{
-	struct dell_wmi_ddv_data *data =3D container_of(attr, struct dell_wmi_dd=
v_data, temp_attr);
-	u32 index, value;
-	int ret;
-
-	ret =3D dell_wmi_ddv_battery_index(to_acpi_device(dev->parent), &index);
-	if (ret < 0)
-		return ret;
-
-	ret =3D dell_wmi_ddv_query_integer(data->wdev, DELL_DDV_BATTERY_TEMPERAT=
URE, index, &value);
-	if (ret < 0)
-		return ret;
-
-	/* Use 2732 instead of 2731.5 to avoid unnecessary rounding and to emula=
te
-	 * the behaviour of the OEM application which seems to round down the re=
sult.
-	 */
-	return sysfs_emit(buf, "%d\n", value - 2732);
-}
-
 static ssize_t eppid_show(struct device *dev, struct device_attribute *at=
tr, char *buf)
 {
 	struct dell_wmi_ddv_data *data =3D container_of(attr, struct dell_wmi_dd=
v_data, eppid_attr);
@@ -697,6 +676,46 @@ static ssize_t eppid_show(struct device *dev, struct =
device_attribute *attr, cha
 	return ret;
 }

+static int dell_wmi_ddv_get_property(struct power_supply *psy, const stru=
ct power_supply_ext *ext,
+				     void *drvdata, enum power_supply_property psp,
+				     union power_supply_propval *val)
+{
+	struct dell_wmi_ddv_data *data =3D drvdata;
+	u32 index, value;
+	int ret;
+
+	ret =3D dell_wmi_ddv_battery_index(to_acpi_device(psy->dev.parent), &ind=
ex);
+	if (ret < 0)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_TEMP:
+		ret =3D dell_wmi_ddv_query_integer(data->wdev, DELL_DDV_BATTERY_TEMPERA=
TURE, index,
+						 &value);
+		if (ret < 0)
+			return ret;
+
+		/* Use 2732 instead of 2731.5 to avoid unnecessary rounding and to emul=
ate
+		 * the behaviour of the OEM application which seems to round down the r=
esult.
+		 */
+		val->intval =3D value - 2732;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const enum power_supply_property dell_wmi_ddv_properties[] =3D {
+	POWER_SUPPLY_PROP_TEMP,
+};
+
+static const struct power_supply_ext dell_wmi_ddv_extension =3D {
+	.name =3D DRIVER_NAME,
+	.properties =3D dell_wmi_ddv_properties,
+	.num_properties =3D ARRAY_SIZE(dell_wmi_ddv_properties),
+	.get_property =3D dell_wmi_ddv_get_property,
+};
+
 static int dell_wmi_ddv_add_battery(struct power_supply *battery, struct =
acpi_battery_hook *hook)
 {
 	struct dell_wmi_ddv_data *data =3D container_of(hook, struct dell_wmi_dd=
v_data, hook);
@@ -708,13 +727,14 @@ static int dell_wmi_ddv_add_battery(struct power_sup=
ply *battery, struct acpi_ba
 	if (ret < 0)
 		return 0;

-	ret =3D device_create_file(&battery->dev, &data->temp_attr);
+	ret =3D device_create_file(&battery->dev, &data->eppid_attr);
 	if (ret < 0)
 		return ret;

-	ret =3D device_create_file(&battery->dev, &data->eppid_attr);
+	ret =3D power_supply_register_extension(battery, &dell_wmi_ddv_extension=
, &data->wdev->dev,
+					      data);
 	if (ret < 0) {
-		device_remove_file(&battery->dev, &data->temp_attr);
+		device_remove_file(&battery->dev, &data->eppid_attr);

 		return ret;
 	}
@@ -726,8 +746,8 @@ static int dell_wmi_ddv_remove_battery(struct power_su=
pply *battery, struct acpi
 {
 	struct dell_wmi_ddv_data *data =3D container_of(hook, struct dell_wmi_dd=
v_data, hook);

-	device_remove_file(&battery->dev, &data->temp_attr);
 	device_remove_file(&battery->dev, &data->eppid_attr);
+	power_supply_unregister_extension(battery, &dell_wmi_ddv_extension);

 	return 0;
 }
@@ -738,11 +758,6 @@ static int dell_wmi_ddv_battery_add(struct dell_wmi_d=
dv_data *data)
 	data->hook.add_battery =3D dell_wmi_ddv_add_battery;
 	data->hook.remove_battery =3D dell_wmi_ddv_remove_battery;

-	sysfs_attr_init(&data->temp_attr.attr);
-	data->temp_attr.attr.name =3D "temp";
-	data->temp_attr.attr.mode =3D 0444;
-	data->temp_attr.show =3D temp_show;
-
 	sysfs_attr_init(&data->eppid_attr.attr);
 	data->eppid_attr.attr.name =3D "eppid";
 	data->eppid_attr.attr.mode =3D 0444;
=2D-
2.39.5


