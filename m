Return-Path: <linux-pm+bounces-20184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E63A0897B
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 09:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28E73A8672
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 08:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4C3207E19;
	Fri, 10 Jan 2025 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FFLUexNb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5280D1AA1D8;
	Fri, 10 Jan 2025 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736496186; cv=none; b=gKC2VatT1c5JEAJU997agX8wSKTXXW7SjbEn6a0dVd6yuV/rZxy8QJscM6JtSOODj0YOpKPVa2SM0xX9RBA/EchqqxOLIbvY3rlp4spBWogaN/Kb+PvGbfXZp4QggFuMRvYA+Rs9jWRewP2sd420zHpiIRX4Qjg0BwEZhEzAQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736496186; c=relaxed/simple;
	bh=7aDlLsFl376E/lQfPi0x+zUmx8uFLuIaK65B5+uLGiQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHo+3f3W83A3qIn9wKokYpF1CB0J1CBJPc4Uj+hil5kVo8wd7qNmV/8mn/uiTjLtyEov7v2XCWXO5JtK8a8r2y7YF4TXYUHn0+ucv4VnjDWc4fZtTXGUK+YZuPI/NxfaJuZl8QIls/y8HVuCUlfjsJd+aXrcPe8Y4zyhQfqkqwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FFLUexNb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A6oQYQ020798;
	Fri, 10 Jan 2025 03:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KhyCS
	SkgKJNa1g6hlscU9T7VCrnSN6B9buIBDBRfvqY=; b=FFLUexNbLbXSLRS4uVSO3
	LJZLihn07Tnj/SCEQ4rLibyswblBkIDrzyBDIYzx+MZMbkjmbL72GXIO6CI5wuFG
	BATx3NJQK1lqqkhDXORgbVCNQIesNc+WFecdtgbMc02yapu6EbC7kLSZ5TzgehAl
	IVw2d1gkGLwtVLn/BFQggd76vapsg5oPmOOann5TgQxnDs28q1dpderohpaFzZLJ
	ulzBpk4dCODPbQHI5HKl/pln1Vcp4VnpzvIwJitkjgTHbQNQDPx6SbkvzvAlEC9/
	yhsqnrqo3perITIuJpzlmwqqeSETZRiq8EuvCxqI1Oe8BAKw6aneN9hkvtQGcSrf
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 442xmr88rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 03:03:00 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50A82xwL053916
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 10 Jan 2025 03:02:59 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 10 Jan 2025 03:02:59 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 10 Jan 2025 03:02:59 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 10 Jan 2025 03:02:59 -0500
Received: from JGERONI2-L01.ad.analog.com (JGERONI2-L01.ad.analog.com [10.117.223.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50A82hMJ006597;
	Fri, 10 Jan 2025 03:02:53 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 2/2] power: supply: add LT8491 battery charger driver
Date: Fri, 10 Jan 2025 16:02:35 +0800
Message-ID: <20250110080235.54808-3-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110080235.54808-1-johnerasmusmari.geronimo@analog.com>
References: <20250110080235.54808-1-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: vCsK2S-2vJEs5t-N_tm1C_xKJTzGVeQ-
X-Proofpoint-GUID: vCsK2S-2vJEs5t-N_tm1C_xKJTzGVeQ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100065

Adds initial support for the LT8491 High Voltage Buck-Boost Battery
Charge Controller with I2C

The driver provides functionality to monitor key parameters including:
Voltage, Current, Power, Temperature, Status

Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
---
 MAINTAINERS                           |   1 +
 drivers/power/supply/Kconfig          |   9 +
 drivers/power/supply/Makefile         |   1 +
 drivers/power/supply/lt8491_charger.c | 410 ++++++++++++++++++++++++++
 4 files changed, 421 insertions(+)
 create mode 100644 drivers/power/supply/lt8491_charger.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 96f510358..0d98734de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13564,6 +13564,7 @@ M:	John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
+F:	drivers/power/supply/lt8491_charger.c
 
 LTC1660 DAC DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 7b18358f1..2a85ae1f7 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -545,6 +545,15 @@ config CHARGER_LT3651
 	  Say Y to include support for the Analog Devices (Linear Technology)
 	  LT3651 battery charger which reports its status via GPIO lines.
 
+config CHARGER_LT8491
+	tristate "Analog Devices LT8491 charger"
+	depends on I2C
+	help
+	  Say Y to include support for the Analog Devices (Linear Technology)
+	  LT8491 battery charge controller connected to I2C. The LT8491 is a
+	  high voltage buck-boost switching regulator battery charger
+	  controller.
+
 config CHARGER_LTC4162L
 	tristate "LTC4162-L charger"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index b55cc48a4..68699430b 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_CHARGER_LP8788)	+= lp8788-charger.o
 obj-$(CONFIG_CHARGER_GPIO)	+= gpio-charger.o
 obj-$(CONFIG_CHARGER_MANAGER)	+= charger-manager.o
 obj-$(CONFIG_CHARGER_LT3651)	+= lt3651-charger.o
+obj-$(CONFIG_CHARGER_LT8491)	+= lt8491_charger.o
 obj-$(CONFIG_CHARGER_LTC4162L)	+= ltc4162-l-charger.o
 obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
 obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
diff --git a/drivers/power/supply/lt8491_charger.c b/drivers/power/supply/lt8491_charger.c
new file mode 100644
index 000000000..dcef6691d
--- /dev/null
+++ b/drivers/power/supply/lt8491_charger.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices LT8491 Battery Charger
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+
+#define LT8491_TELE_TBAT_REG 0x0
+#define LT8491_TELE_POUT_REG 0x2
+#define LT8491_TELE_PIN_REG  0x4
+#define LT8491_TELE_EFF_REG  0x6
+#define LT8491_TELE_IOUT_REG 0x8
+#define LT8491_TELE_IIN_REG  0xA
+#define LT8491_TELE_VBAT_REG 0xC
+#define LT8491_TELE_VIN_REG  0xE
+#define LT8491_TELE_VINR_REG 0x10
+#define LT8491_STAT_CHARGER_REG 0x12
+#define LT8491_STAT_CHRG_FAULTS_REG 0x19
+#define LT8491_CTRL_UPDATE_TELEM_REG 0x26
+
+#define LT8491_CFG_RSENSE1_REG 0x28
+#define LT8491_CFG_RIMON_OUT_REG 0x2A
+#define LT8491_CFG_RSENSE2_REG 0x2C
+#define LT8491_CFG_RDACO_REG 0x2E
+#define LT8491_CFG_RFBOUT1_REG 0x30
+#define LT8491_CFG_RFBOUT2_REG 0x32
+#define LT8491_CFG_RDACI_REG 0x34
+#define LT8491_CFG_RFBIN2_REG 0x36
+#define LT8491_CFG_RFBIN1_REG 0x38
+#define LT8491_CFG_TBAT_MIN_REG 0x40
+#define LT8491_CFG_TBAT_MAX_REG 0x41
+#define LT8491_MFR_DATA1_LSB_REG 0x5C
+
+#define LT8491_TELEM_ACTIVE_MASK BIT(6)
+#define LT8491_CHARGING_MASK BIT(2)
+#define LT8491_BAT_DISCON_FLT_MASK BIT(3)
+
+#define LT8491_UPDATE_TELEM_CMD 0xAA
+
+#define LT8491_MFR_DATA_LEN 0x3
+
+struct lt8491_info {
+	struct i2c_client *client;
+	struct power_supply *psp;
+	char serial_number[16];
+	/* protect against device accesses */
+	struct mutex lock;
+};
+
+static int lt8491_read_serial_number(struct lt8491_info *info)
+{
+	int i, ret;
+	u32 serial_number[LT8491_MFR_DATA_LEN];
+
+	for (i = 0; i < LT8491_MFR_DATA_LEN; i++) {
+		serial_number[i] = i2c_smbus_read_word_data(info->client,
+					LT8491_MFR_DATA1_LSB_REG + i * 2);
+		if (serial_number[i] < 0)
+			return serial_number[i];
+	}
+
+	ret = sprintf(info->serial_number, "%04x%04x%04x", serial_number[0],
+		      serial_number[1], serial_number[2]);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int lt8491_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct lt8491_info *info = power_supply_get_drvdata(psy);
+	s16 ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = i2c_smbus_read_byte_data(info->client,
+					       LT8491_STAT_CHARGER_REG);
+		if (ret < 0)
+			return ret;
+
+		val->intval = FIELD_GET(LT8491_CHARGING_MASK, ret) ?
+					POWER_SUPPLY_STATUS_CHARGING :
+					POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+		return 0;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		scoped_guard(mutex, &info->lock) {
+			ret = i2c_smbus_read_byte_data(info->client,
+						LT8491_STAT_CHARGER_REG);
+			if (ret < 0)
+				return ret;
+
+			if (!FIELD_GET(LT8491_TELEM_ACTIVE_MASK, ret)) {
+				ret = i2c_smbus_write_byte_data(info->client,
+						LT8491_CTRL_UPDATE_TELEM_REG,
+						LT8491_UPDATE_TELEM_CMD);
+				if (ret)
+					return ret;
+			}
+
+			ret = i2c_smbus_read_word_data(info->client,
+						LT8491_TELE_VBAT_REG);
+			if (ret < 0)
+				return ret;
+		}
+
+		val->intval = ret * 10000;
+
+		return 0;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		scoped_guard(mutex, &info->lock) {
+			ret = i2c_smbus_read_byte_data(info->client,
+						       LT8491_STAT_CHARGER_REG);
+			if (ret < 0)
+				return ret;
+
+			if (!FIELD_GET(LT8491_TELEM_ACTIVE_MASK, ret)) {
+				ret = i2c_smbus_write_byte_data(info->client,
+						LT8491_CTRL_UPDATE_TELEM_REG,
+						LT8491_UPDATE_TELEM_CMD);
+				if (ret)
+					return ret;
+			}
+
+			ret = i2c_smbus_read_word_data(info->client,
+						       LT8491_TELE_IOUT_REG);
+			if (ret < 0)
+				return ret;
+		}
+
+		val->intval = ret;
+
+		return 0;
+	case POWER_SUPPLY_PROP_POWER_NOW:
+		scoped_guard(mutex, &info->lock) {
+			ret = i2c_smbus_read_byte_data(info->client,
+						       LT8491_STAT_CHARGER_REG);
+			if (ret < 0)
+				return ret;
+
+			if (!FIELD_GET(LT8491_TELEM_ACTIVE_MASK, ret)) {
+				ret = i2c_smbus_write_byte_data(info->client,
+						LT8491_CTRL_UPDATE_TELEM_REG,
+						LT8491_UPDATE_TELEM_CMD);
+				if (ret)
+					return ret;
+			}
+
+			ret = i2c_smbus_read_word_data(info->client,
+						       LT8491_TELE_POUT_REG);
+			if (ret < 0)
+				return ret;
+		}
+
+		val->intval = ret * 10000;
+
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP:
+		scoped_guard(mutex, &info->lock) {
+			ret = i2c_smbus_read_byte_data(info->client,
+						       LT8491_STAT_CHARGER_REG);
+			if (ret < 0)
+				return ret;
+
+			if (!FIELD_GET(LT8491_TELEM_ACTIVE_MASK, ret)) {
+				ret = i2c_smbus_write_byte_data(info->client,
+						LT8491_CTRL_UPDATE_TELEM_REG,
+						LT8491_UPDATE_TELEM_CMD);
+				if (ret)
+					return ret;
+			}
+
+			ret = i2c_smbus_read_word_data(info->client,
+						       LT8491_TELE_TBAT_REG);
+			if (ret < 0)
+				return ret;
+		}
+
+		val->intval = sign_extend32(ret, 15);
+
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+		ret = i2c_smbus_read_byte_data(info->client,
+					       LT8491_CFG_TBAT_MIN_REG);
+		if (ret < 0)
+			return ret;
+
+		val->intval = sign_extend32(ret, 7) * 10;
+
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		ret = i2c_smbus_read_byte_data(info->client,
+					       LT8491_CFG_TBAT_MAX_REG);
+		if (ret < 0)
+			return ret;
+
+		val->intval = sign_extend32(ret, 7) * 10;
+
+		return 0;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = "lt8491";
+
+		return 0;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = "Analog Devices";
+
+		return 0;
+	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+		val->strval = info->serial_number;
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int lt8491_set_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				const union power_supply_propval *val)
+{
+	struct lt8491_info *info = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+		return i2c_smbus_write_byte_data(info->client,
+						 LT8491_CFG_TBAT_MIN_REG,
+						 val->intval / 10);
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		return i2c_smbus_write_byte_data(info->client,
+						 LT8491_CFG_TBAT_MAX_REG,
+						 val->intval / 10);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int lt8491_property_is_writeable(struct power_supply *psy,
+					enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static enum power_supply_property lt8491_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+};
+
+static const struct power_supply_desc lt8491_desc = {
+	.name		= "lt8491",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= lt8491_properties,
+	.num_properties	= ARRAY_SIZE(lt8491_properties),
+	.get_property	= lt8491_get_property,
+	.set_property	= lt8491_set_property,
+	.property_is_writeable = lt8491_property_is_writeable,
+};
+
+static int lt8491_configure_resistor(struct lt8491_info *info,
+				     const char *propname, int divider,
+				     unsigned int reg)
+{
+	struct device *dev = &info->client->dev;
+	int ret;
+	u32 val;
+
+	ret = device_property_read_u32(dev, propname, &val);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Missing %s property.\n",
+				     propname);
+
+	return i2c_smbus_write_word_data(info->client, reg, val / divider);
+}
+
+static int lt8491_configure_telemetry(struct lt8491_info *info)
+{
+	int ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rsense1-micro-ohms", 10,
+					LT8491_CFG_RSENSE1_REG);
+	if (ret)
+		return ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rimon-out-ohms", 10,
+					LT8491_CFG_RIMON_OUT_REG);
+	if (ret)
+		return ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rsense2-micro-ohms", 10,
+					LT8491_CFG_RSENSE2_REG);
+	if (ret)
+		return ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rdaco-ohms", 10,
+					LT8491_CFG_RDACO_REG);
+	if (ret)
+		return ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rfbout1-ohms", 100,
+					LT8491_CFG_RFBOUT1_REG);
+	if (ret)
+		return ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rfbout2-ohms", 10,
+					LT8491_CFG_RFBOUT2_REG);
+	if (ret)
+		return ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rdaci-ohms", 10,
+					LT8491_CFG_RDACI_REG);
+	if (ret)
+		return ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rfbin2-ohms", 10,
+					LT8491_CFG_RFBIN2_REG);
+	if (ret)
+		return ret;
+
+	return lt8491_configure_resistor(info, "adi,rfbin1-ohms", 100,
+					 LT8491_CFG_RFBIN1_REG);
+}
+
+static int lt8491_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct lt8491_info *info;
+	struct power_supply_config psy_cfg = {};
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_READ_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->client = client;
+	psy_cfg.drv_data = info;
+
+	devm_mutex_init(dev, &info->lock);
+
+	ret = lt8491_read_serial_number(info);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Can't read serial. Hardware error.\n");
+
+	ret = lt8491_configure_telemetry(info);
+	if (ret)
+		return ret;
+
+	info->psp = power_supply_register(dev, &lt8491_desc, &psy_cfg);
+	if (IS_ERR(info->psp))
+		return dev_err_probe(dev, PTR_ERR(info->psp),
+				     "Failed to register power supply.\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id lt8491_id[] = {
+	{ "lt8491", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lt8491_id);
+
+static const struct of_device_id lt8491_of_match[] = {
+	{ .compatible = "adi,lt8491" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lt8491_of_match);
+
+static struct i2c_driver lt8491_driver = {
+	.driver = {
+		.name = "lt8491",
+		.of_match_table = lt8491_of_match,
+	},
+	.probe = lt8491_probe,
+	.id_table = lt8491_id,
+};
+module_i2c_driver(lt8491_driver);
+
+MODULE_AUTHOR("John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com");
+MODULE_DESCRIPTION("LT8491 battery charger");
+MODULE_LICENSE("GPL");
-- 
2.34.1


