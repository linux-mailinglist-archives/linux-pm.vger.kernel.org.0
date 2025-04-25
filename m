Return-Path: <linux-pm+bounces-26261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15FCA9D61C
	for <lists+linux-pm@lfdr.de>; Sat, 26 Apr 2025 01:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124861BC8524
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 23:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FB7297A72;
	Fri, 25 Apr 2025 23:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YybSCcCA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF7E2973C9;
	Fri, 25 Apr 2025 23:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745622935; cv=none; b=q5niglJjDHPySYULJmJehPJeqVw2K9VkXFXRtI2v88LzU94ea8cmjmbkUxMpfoxXvrlw8IvR72smANOCiMkWzPU5fX5kcK18Bo/KUw7LbILrYejydWvBWwZF1hDnWqfBEMdL1iUyAxPdXt+bpfpoKa6bM4HRlUDe97Kh3KjYXEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745622935; c=relaxed/simple;
	bh=agqt7GnsgWdQqfpoBb27a5IyqsFathLz81XGrlkmILY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sNttKxpqLKurX/dueOV9amDlRim0frVFxnYC30Xl2RTeFbErp9d6PA1ooG7XtVTuYzKLFM0PSHYc7DFQH2045ldRay7028tECfW/9/9TBcK7I0fn9ma7dZ1ClNnXm8JTro1EXRuj9jAH4E7G0kWVKIhkMOgYigmr2LrBhVV+gI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YybSCcCA; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745622930; x=1746227730; i=w_armin@gmx.de;
	bh=xnsMDjvgPbdTHpCKWeLTgevixuKms/TZceRGSNGM+5M=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YybSCcCAHDmN+kb2nHGMaOmO0+d7/4ejIItT72BhgojCDmyYwNUo5PDYo+hS29Sw
	 yt+CbZ54Zl4UBM1wosSzokmHthXtgcJrIH+DtJqm4LRF61/O9CoyX47ZGjia2cVuT
	 w12+mcsg/BHDFIv4+LC2Pky5XHQTNEspFdGxrCRbtErmalBL/gqe1Yti/ylFpmM/h
	 h3SER6mWVkJXpttscm6tEYmEsuMfl7bxxymlmCu5vWlFDoutIOA1T/ruZlO7Te+EK
	 /w5jzBcb6UX+n+GhJtGA4TL4ztNEqpNbQq7FHBY14ocI2w9y7miKzW4JZAbuuUlQW
	 mo1Mwqy7Cc3rKIKhsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N7zFZ-1vDUn32c1j-00twSs; Sat, 26 Apr 2025 01:15:30 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: sre@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] platform/x86: dell-ddv: Expose the battery health to userspace
Date: Sat, 26 Apr 2025 01:15:18 +0200
Message-Id: <20250425231518.16125-4-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:luIGGYBE1oVn85a1evF4PHaV+C2uYLVTGZIr8ypz32JaV29xHQ3
 HG2MUes+xZr8NvO/qbH1osZK6SOUbBskobhtqw1/yZ8IHfba+CEPfO39wzIOOjflCd99pPH
 H8932SkYWCkWBCI8uMlw8fXMS60y/t7W8sLuuxux4JT2U1yVZoEro9wMl8Wd2ctf6D6oS6e
 A8xfNB80UcXxrHGPDbAzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J2DJt2bBbqU=;4cXlNlSmtG1aQCH/aKnK1LSrx2Z
 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

The health of a given battery is exposed over the Dell DDV WMI
interface using the "BatteryManufactureAceess" WMI method. The
resulting data contains, among other data, the health status of
the battery.

Expose this value to userspace using the power supply extension
interface.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/wmi/devices/dell-wmi-ddv.rst | 35 ++++++++-
 drivers/platform/x86/dell/dell-wmi-ddv.c   | 89 ++++++++++++++++++++++
 2 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/Documentation/wmi/devices/dell-wmi-ddv.rst b/Documentation/wm=
i/devices/dell-wmi-ddv.rst
index 41c553d5c77d..109d4c5c922e 100644
=2D-- a/Documentation/wmi/devices/dell-wmi-ddv.rst
+++ b/Documentation/wmi/devices/dell-wmi-ddv.rst
@@ -150,7 +150,40 @@ Returns the voltage flow of the battery in mV as an u=
16.
 WMI method BatteryManufactureAccess()
 -------------------------------------
=20
-Returns a manufacture-defined value as an u16.
+Returns the health status of the battery as a u16.
+The health status encoded in the following manner:
+
+ - the third nibble contains the general failure mode
+ - the fourth nibble contains the specific failure code
+
+Valid failure modes are:
+
+ - permanent failure (``0x9``)
+ - overheat failure (``0xa``)
+ - overcurrent failure (``0xb``)
+
+All other failure modes are to be considered normal.
+
+The following failure codes are valid for a permanent failure:
+
+ - fuse blown (``0x0``)
+ - cell imbalance (``0x1``)
+ - overvoltage (``0x2``)
+ - fet failure (``0x3``)
+
+The last two bits of the failure code are to be ignored when the battery
+signals a permanent failure.
+
+The following failure codes a valid for a overheat failure:
+
+ - overheat at start of charging (``0x5``)
+ - overheat during charging (``0x7``)
+ - overheat during discharging (``0x8``)
+
+The following failure codes are valid for a overcurrent failure:
+
+ - overcurrent during charging (``0x6``)
+ - overcurrent during discharging (``0xb``)
=20
 WMI method BatteryRelativeStateOfCharge()
 -----------------------------------------
diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index 8bd3ff76bb91..59e1a8e9f8c8 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -47,6 +47,26 @@
 #define SBS_MANUFACTURE_MONTH_MASK	GENMASK(8, 5)
 #define SBS_MANUFACTURE_DAY_MASK	GENMASK(4, 0)
=20
+#define MA_FAILURE_MODE_MASK			GENMASK(11, 8)
+#define MA_FAILURE_MODE_PERMANENT		0x9
+#define MA_FAILURE_MODE_OVERHEAT		0xA
+#define MA_FAILURE_MODE_OVERCURRENT		0xB
+
+#define MA_PERMANENT_FAILURE_CODE_MASK		GENMASK(13, 12)
+#define MA_PERMANENT_FAILURE_FUSE_BLOWN		0x0
+#define MA_PERMANENT_FAILURE_CELL_IMBALANCE	0x1
+#define MA_PERMANENT_FAILURE_OVERVOLTAGE	0x2
+#define MA_PERMANENT_FAILURE_FET_FAILURE	0x3
+
+#define MA_OVERHEAT_FAILURE_CODE_MASK		GENMASK(15, 12)
+#define MA_OVERHEAT_FAILURE_START		0x5
+#define MA_OVERHEAT_FAILURE_CHARGING		0x7
+#define MA_OVERHEAT_FAILURE_DISCHARGING		0x8
+
+#define MA_OVERCURRENT_FAILURE_CODE_MASK	GENMASK(15, 12)
+#define MA_OVERCURRENT_FAILURE_CHARGING		0x6
+#define MA_OVERCURRENT_FAILURE_DISCHARGING	0xB
+
 #define DELL_EPPID_LENGTH	20
 #define DELL_EPPID_EXT_LENGTH	23
=20
@@ -749,6 +769,72 @@ static ssize_t eppid_show(struct device *dev, struct =
device_attribute *attr, cha
 	return ret;
 }
=20
+static int dell_wmi_ddv_get_health(struct dell_wmi_ddv_data *data, u32 in=
dex,
+				   union power_supply_propval *val)
+{
+	u32 value, code;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_integer(data->wdev, DELL_DDV_BATTERY_MANUFACT=
URER_ACCESS, index,
+					 &value);
+	if (ret < 0)
+		return ret;
+
+	switch (FIELD_GET(MA_FAILURE_MODE_MASK, value)) {
+	case MA_FAILURE_MODE_PERMANENT:
+		code =3D FIELD_GET(MA_PERMANENT_FAILURE_CODE_MASK, value);
+		switch (code) {
+		case MA_PERMANENT_FAILURE_FUSE_BLOWN:
+			val->intval =3D POWER_SUPPLY_HEALTH_FUSE_BLOWN;
+			return 0;
+		case MA_PERMANENT_FAILURE_CELL_IMBALANCE:
+			val->intval =3D POWER_SUPPLY_HEALTH_CELL_IMBALANCED;
+			return 0;
+		case MA_PERMANENT_FAILURE_OVERVOLTAGE:
+			val->intval =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+			return 0;
+		case MA_PERMANENT_FAILURE_FET_FAILURE:
+			val->intval =3D POWER_SUPPLY_HEALTH_DEAD;
+			return 0;
+		default:
+			dev_notice_once(&data->wdev->dev, "Unknown permanent failure code %u\n=
",
+					code);
+			val->intval =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+			return 0;
+		}
+	case MA_FAILURE_MODE_OVERHEAT:
+		code =3D FIELD_GET(MA_OVERHEAT_FAILURE_CODE_MASK, value);
+		switch (code) {
+		case MA_OVERHEAT_FAILURE_START:
+		case MA_OVERHEAT_FAILURE_CHARGING:
+		case MA_OVERHEAT_FAILURE_DISCHARGING:
+			val->intval =3D POWER_SUPPLY_HEALTH_OVERHEAT;
+			return 0;
+		default:
+			dev_notice_once(&data->wdev->dev, "Unknown overheat failure code %u\n"=
,
+					code);
+			val->intval =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+			return 0;
+		}
+	case MA_FAILURE_MODE_OVERCURRENT:
+		code =3D FIELD_GET(MA_OVERCURRENT_FAILURE_CODE_MASK, value);
+		switch (code) {
+		case MA_OVERCURRENT_FAILURE_CHARGING:
+		case MA_OVERCURRENT_FAILURE_DISCHARGING:
+			val->intval =3D POWER_SUPPLY_HEALTH_OVERCURRENT;
+			return 0;
+		default:
+			dev_notice_once(&data->wdev->dev, "Unknown overcurrent failure code %u=
\n",
+					code);
+			val->intval =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+			return 0;
+		}
+	default:
+		val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
+		return 0;
+	}
+}
+
 static int dell_wmi_ddv_get_manufacture_date(struct dell_wmi_ddv_data *da=
ta, u32 index,
 					     enum power_supply_property psp,
 					     union power_supply_propval *val)
@@ -808,6 +894,8 @@ static int dell_wmi_ddv_get_property(struct power_supp=
ly *psy, const struct powe
 		return ret;
=20
 	switch (psp) {
+	case POWER_SUPPLY_PROP_HEALTH:
+		return dell_wmi_ddv_get_health(data, index, val);
 	case POWER_SUPPLY_PROP_TEMP:
 		ret =3D dell_wmi_ddv_query_integer(data->wdev, DELL_DDV_BATTERY_TEMPERA=
TURE, index,
 						 &value);
@@ -829,6 +917,7 @@ static int dell_wmi_ddv_get_property(struct power_supp=
ly *psy, const struct powe
 }
=20
 static const enum power_supply_property dell_wmi_ddv_properties[] =3D {
+	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_TEMP,
 	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
 	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
=2D-=20
2.39.5


