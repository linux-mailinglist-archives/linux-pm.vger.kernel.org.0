Return-Path: <linux-pm+bounces-26263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE59A9D626
	for <lists+linux-pm@lfdr.de>; Sat, 26 Apr 2025 01:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF184920155
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 23:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3376229899A;
	Fri, 25 Apr 2025 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="GmhBLh9y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49462973C9;
	Fri, 25 Apr 2025 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745622942; cv=none; b=E5GaI6TOiBWj/ETrqcs8s8cni91AW9cyA3ptC5Qm/qgHRjqjGmSdGw5jy2D3MCOHU5dPUFf0/XT4jMbukgBYYiPMiNSDa35k4YkkmpAeaB8WDtYYYzEwLbvy2SEXDHnyFnAB4+FSHEoD/0Q3VnH6/nYCQxLHn3vhbCLQJczc5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745622942; c=relaxed/simple;
	bh=2G13UdckMVoNWyQ2KkNbIsqMt2eJ/selT3Q4mTX/i9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wjfnw/pr3S20WTTMozBklNs4vtT072nrgiqLVR9zN2XXYYRUCdmMBXWSOgQ4bYSSbQ9jr8FhRnUCwQffa9E1GqUTUSz6CtRCVH6/L0Zydnx0en5oU9H9twfqbj/uJWIrZRIMWZ/oGMWbrceu0kCzlfhe8KmUR/0TuJtteDQYzPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=GmhBLh9y; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745622929; x=1746227729; i=w_armin@gmx.de;
	bh=g9WnqqVjdggWi2YjHHXf4QuvT/xttrq0L//6veEdl2w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GmhBLh9y+Lx4LXXZmffR61yna+dFhQw7Y7nS10sBrobSMmq4OAfo8nsWRUg9rSU6
	 JzmikJTjrFbM49VECjkIrLYXS8ajHY/ctDP0qVdhXqTCqAyE+1euVeyXKlTFlUv80
	 +Qa/ji7xx+e+F7uNrzyM1BNyX5AoXfkJbl+dKy8l0Ssfqy6hFJCCbG+qWIs/V71UC
	 hd5O/8+FdNs8C7/0a7xTu3k2qZ2RrDwmjSw57iTESyd4LIHLFuIR3ek6manZlDe4+
	 GgEpTFbjtTaJdyXqlyPwVYPPyUpotgLwWx//pRvMAx7m+1gzQ18gG4a55Wkoch2G/
	 R747PtQPAegnkv4Fkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M72sP-1uAMbm0Y6Z-00AtPm; Sat, 26 Apr 2025 01:15:29 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: sre@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] platform/x86: dell-ddv: Expose the battery manufacture date to userspace
Date: Sat, 26 Apr 2025 01:15:17 +0200
Message-Id: <20250425231518.16125-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:9Fl5XihV7tB/KzPDEMJfnthSOvmMjmbqtsEJYWwJpnRoGwbxeQV
 jbt/krKFD6nIRqYhcmg8T0h8Kkh0xt26J8q2YoZkVZxtEqD8oeb/uzk/fh3jRnmLFgzG0eE
 RqqxRvUAXNTOcpgo0AWd7FBz5sZBP+9cyUjVDKSg+WFIIN4706I+vfQiFxTQjVeB7A83Afe
 Gkl76k49XqsIWH399K+qA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LZQ3ipiIRCY=;/u8YtIKroiqxdGz3C58soq7gwSI
 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
 xSO+7GFk+WQZj7t41Q35/Hd2qGbNoY/c2U

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


