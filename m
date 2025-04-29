Return-Path: <linux-pm+bounces-26345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A92AA9FE70
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 02:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861EE18922E1
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 00:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D141925A2;
	Tue, 29 Apr 2025 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="BX6q7Z8k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BE11494C3;
	Tue, 29 Apr 2025 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886989; cv=none; b=KVcva/JT57Rxs3P4ODt2f0K3ZvG8+979bxhCw5F/iuSJa5OSFGy85JzrI6eW+bSRS1yfiFCtlZuy38nxfHn7QIdL0Z3Mw9mE/2BAbSQcZSkGULcH/Ieh6C1PWKVdrEEKta3Dr66gElpSrjh71cPGhDenuj9XC1b11HUEQC50Ucw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886989; c=relaxed/simple;
	bh=2G13UdckMVoNWyQ2KkNbIsqMt2eJ/selT3Q4mTX/i9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AM2kveJzBuppfm21RsSowwApoCRKJqRmCfh5AvV96Brhb8+M4CJrd83EStEPEeSvRSJ2WejZ8zkFdZYSyjrrOoA8UnWe6VOvs9h4wdWLC2iDnfdcprc1iPEUuUTxxHEF5RMrl2VwHfRVwGmS6oPaYxfbteFMiolP6AnA0jxxBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=BX6q7Z8k; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745886982; x=1746491782; i=w_armin@gmx.de;
	bh=g9WnqqVjdggWi2YjHHXf4QuvT/xttrq0L//6veEdl2w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BX6q7Z8kDr+SCLb41wsd4I3BYXCnrqb4BwWXbf4x3IIBUMUVDU50fit91K5j3ODO
	 ik+iEMsWQKmDkodV/q7bABKj/AI/QeS+afKXmo8AsiyccTIyxXv6odUFtz6KymsJr
	 ZohNYwIKlxxG6IbiHrvMTrmiVeiB5Cp7rJf6A40RYdakseIHXmzRIg1z4aFjC/LGr
	 eos4rqalYFRKZ5yPz7/z344Zb68EosP0VwwYlwtaqeJS44HddC8aSeLUymKhEirHT
	 ZJOAVDAiLQwo0fm0Z1n+Z3gPcQei247dxNNWqMrkdqyUQXeC0+lMoYk460jUqz7LE
	 DUw06e/VGTcYY8FLQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MrhQC-1uoPZ40VXw-00fQIe; Tue, 29 Apr 2025 02:36:22 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: sre@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] platform/x86: dell-ddv: Expose the battery manufacture date to userspace
Date: Tue, 29 Apr 2025 02:36:05 +0200
Message-Id: <20250429003606.303870-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:CCotywXhA+GsZBcrnSnFt/W7RmxOkIa/WOrFgZautWT24o3gXwL
 BLv37ohB2N17uQ7/tF6h+do+QVBJxvP04n2ycPpquGOE/TeR+UNF+sabsviBhhzg+qUt4Yw
 TnFAX2C8VJsmiX5QEmIW/PFPIWk2NF9RLSvifIu/bfEgNWvzRS1BQNKbx4f+5GjDHcjY0NZ
 eX4BkziUAIJBYKyYXkZxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:crD9Uq+VSbA=;DzW8CM6+StTN8TuQep4LqBlLrMC
 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
 mrek=

The manufacture date of a given battery is exposed over the Dell DDV
WMI interface using the "BatteryManufactureDate" WMI method. The
resulting data contains the manufacture date of the battery encoded
inside a 16-bit value as described in the Smart Battery Data
Specification.

Expose this value to userspace using the power supply extension
interface.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/wmi/devices/dell-wmi-ddv.rst |  3 --
 drivers/platform/x86/dell/dell-wmi-ddv.c   | 58 ++++++++++++++++++++++
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/Documentation/wmi/devices/dell-wmi-ddv.rst b/Documentation/wm=
i/devices/dell-wmi-ddv.rst
index f10a623acca1..41c553d5c77d 100644
=2D-- a/Documentation/wmi/devices/dell-wmi-ddv.rst
+++ b/Documentation/wmi/devices/dell-wmi-ddv.rst
@@ -118,9 +118,6 @@ The date is encoded in the following manner:
 - bits 5 to 8 contain the manufacture month.
 - bits 9 to 15 contain the manufacture year biased by 1980.
=20
-.. note::
-   The data format needs to be verified on more machines.
-
 WMI method BatterySerialNumber()
 --------------------------------
=20
diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index 711639001be4..8bd3ff76bb91 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -8,6 +8,7 @@
 #define pr_format(fmt) KBUILD_MODNAME ": " fmt
=20
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/device/driver.h>
@@ -42,6 +43,10 @@
 /* Battery indices 1, 2 and 3 */
 #define DELL_DDV_NUM_BATTERIES		3
=20
+#define SBS_MANUFACTURE_YEAR_MASK	GENMASK(15, 9)
+#define SBS_MANUFACTURE_MONTH_MASK	GENMASK(8, 5)
+#define SBS_MANUFACTURE_DAY_MASK	GENMASK(4, 0)
+
 #define DELL_EPPID_LENGTH	20
 #define DELL_EPPID_EXT_LENGTH	23
=20
@@ -744,6 +749,52 @@ static ssize_t eppid_show(struct device *dev, struct =
device_attribute *attr, cha
 	return ret;
 }
=20
+static int dell_wmi_ddv_get_manufacture_date(struct dell_wmi_ddv_data *da=
ta, u32 index,
+					     enum power_supply_property psp,
+					     union power_supply_propval *val)
+{
+	u16 year, month, day;
+	u32 value;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_integer(data->wdev, DELL_DDV_BATTERY_MANUFACT=
URE_DATE,
+					 index, &value);
+
+	if (ret < 0)
+		return ret;
+
+	if (value > U16_MAX)
+		return -ENXIO;
+
+	/*
+	 * Some devices report a invalid manufacture date value
+	 * like 0.0.1980. Because of this we have to check the
+	 * whole value before exposing parts of it to user space.
+	 */
+	year =3D FIELD_GET(SBS_MANUFACTURE_YEAR_MASK, value) + 1980;
+	month =3D FIELD_GET(SBS_MANUFACTURE_MONTH_MASK, value);
+	if (month < 1 || month > 12)
+		return -ENODATA;
+
+	day =3D FIELD_GET(SBS_MANUFACTURE_DAY_MASK, value);
+	if (day < 1 || day > 31)
+		return -ENODATA;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
+		val->intval =3D year;
+		return 0;
+	case POWER_SUPPLY_PROP_MANUFACTURE_MONTH:
+		val->intval =3D month;
+		return 0;
+	case POWER_SUPPLY_PROP_MANUFACTURE_DAY:
+		val->intval =3D day;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int dell_wmi_ddv_get_property(struct power_supply *psy, const stru=
ct power_supply_ext *ext,
 				     void *drvdata, enum power_supply_property psp,
 				     union power_supply_propval *val)
@@ -768,6 +819,10 @@ static int dell_wmi_ddv_get_property(struct power_sup=
ply *psy, const struct powe
 		 */
 		val->intval =3D value - 2732;
 		return 0;
+	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
+	case POWER_SUPPLY_PROP_MANUFACTURE_MONTH:
+	case POWER_SUPPLY_PROP_MANUFACTURE_DAY:
+		return dell_wmi_ddv_get_manufacture_date(data, index, psp, val);
 	default:
 		return -EINVAL;
 	}
@@ -775,6 +830,9 @@ static int dell_wmi_ddv_get_property(struct power_supp=
ly *psy, const struct powe
=20
 static const enum power_supply_property dell_wmi_ddv_properties[] =3D {
 	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
+	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
+	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
 };
=20
 static const struct power_supply_ext dell_wmi_ddv_extension =3D {
=2D-=20
2.39.5


