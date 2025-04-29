Return-Path: <linux-pm+bounces-26346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C04BFA9FE7B
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 02:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539D74609FB
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 00:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682CC1BB6BA;
	Tue, 29 Apr 2025 00:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="bsKvdV1x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF7C1B0430;
	Tue, 29 Apr 2025 00:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886999; cv=none; b=O+NZfaVvz6UZMgEmgF9mcd5kHHClIOjkktDuyIx9BIAKw1k/8BQXtPm9kKOfJgf/2oloY+tU/TBj6i8YZAL1szWCLfXp03AtyoklboGtcfakszwA/mwpHADZCmemAuTBDJr9g2pTe+o1LzP+OvoyYN+kxgLIlsIlG2AQm8Movf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886999; c=relaxed/simple;
	bh=VyAaQCwVTKyodHJbWRjjuyUH6q3W1KuHvM58oNnwBqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I4iq/PdqRz2elQAUZuu8Vfbhar1gEMWhbqRfixluCwFmz7e/5hUrdl4FufXvpaBugyPumeK7V3g/XwfKlhR3RToCM/Dm9Q7L7UKmgvNY9wIH/p49zrkwxnVkVXTGKAJHhhSrIaHcTHgTmt10iSISCEFi7MMRfEy++Rk1yJki8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=bsKvdV1x; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745886985; x=1746491785; i=w_armin@gmx.de;
	bh=9Y2WQZ77zZCI4KFEbSyvqglWHM2SvgIsYOScYy2OBxs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bsKvdV1xY0ERV8GTqjS2/I7Rv2vXX2rqt+GAoCJA05Lt+vocH0MryefS8Xwu6BbZ
	 Q3Sx/wGWsOnjdK0l8Bn+NaqSeUcvNxy6MYO+Xtuxg6ftW8wxzPZICl0Ok7vSCJaT3
	 I/v+Am0xpD6+jzsbY9MzTTUS8JQ4L7Ki5+WyKVeCKZ1QVL3E6ReN+YY6hlgTP+/wC
	 fsE6JsP8L6bsGDvJhk6wJ9HaGyLk53rzNszAvKmTRwmlPNuDL7lQ3ztOe0fTuZ64r
	 yK1FeXO7iXQzkCw6E/KhaModpVLG6d2v+d6YsG5XEOHD5i11hIX5R8qTFN/GR21nk
	 uMTL7q53//Ha4kL4Fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MGyxX-1uEnlb2rUh-00AUOd; Tue, 29 Apr 2025 02:36:24 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: sre@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] platform/x86: dell-ddv: Expose the battery health to userspace
Date: Tue, 29 Apr 2025 02:36:06 +0200
Message-Id: <20250429003606.303870-4-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:QDUPF2bWhumT0YXmQVYjFCcbqylL2H/aMBOY5pvk+5mgRilIw4R
 T1Gs9KeKKNbOXTT6lABMCGHIe6LYFjBDBZTrJQvVSuQej+mVoNKkBl42Ef3tIs9shAjdBDL
 zpVY076K+KaAyoqQumSzrutJvN31noTnpwwDK8Ekww9QojvdpFXI/NyExGswjBX0D6jJimp
 yjWmIfUd5n8qp/4HpJz2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:odmEQe451D4=;qBGKT834AgQ51PkQU9kdOhBWDbZ
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
index 8bd3ff76bb91..cb4e0c1b908e 100644
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
+			val->intval =3D POWER_SUPPLY_HEALTH_BLOWN_FUSE;
+			return 0;
+		case MA_PERMANENT_FAILURE_CELL_IMBALANCE:
+			val->intval =3D POWER_SUPPLY_HEALTH_CELL_IMBALANCE;
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


