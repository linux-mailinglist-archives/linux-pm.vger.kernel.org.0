Return-Path: <linux-pm+bounces-26435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740FBAA42AD
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 07:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A224C05F8
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 05:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434D11E8329;
	Wed, 30 Apr 2025 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ74JsRQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D96A1E5B68;
	Wed, 30 Apr 2025 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992318; cv=none; b=ShOHIjVo/CXePnmhU0zIBqyoNfnHh2jO4FpCySDf5Cru9BBNWipcqxMFUNwGXf5cahhs6zFtpB3aEdDOGEIRdpknG52ANYka44NrCAsgD63n2R1KNIInbOKu8PGIuEXGU/1XAKCNVb6mZyUQhqfWfLTxvzzenXang2habcmSqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992318; c=relaxed/simple;
	bh=ND3uHtD4kblOcKKg4brI2hMzQqIkU1aT+2JhgeNnNRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWgFK/F2qXJ5KxPuLAmYsuqzkcRxpyCna13XUpjoY9yixj1rctltyigKMzAAYyPUjGIEgN3cX8UarxcJzKllpz7JK1hrciXGWx2/aGxr2h1c8NJh+qwJZrcKq9FBCd+J7LTSIpRWOGShuQclRRnPBkNnX5cyziIkCZ0D9ivAiE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ74JsRQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aca99fc253bso1049911366b.0;
        Tue, 29 Apr 2025 22:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745992312; x=1746597112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPwYZu5Sw0ujxMeuZ9hQfOKEkijsGXSWuZMElxzTjX4=;
        b=gQ74JsRQSHcbLtF+YQESix1F1nFU8CdXI1zqP5NrDc5fuOKhmCf5FK5hRcCTIYlwOz
         BLGgv70eheMVNYJWnew7DF9vxVTLgFBQrWdWADvlShjJ3JtzzxAB/4StAC5jUuhy2IzE
         U6tGb6mqGtVqDq6LQDr2MHDssesXVSgghl+Nb2Gcj4ABoruP0b5lEc2HfAIbKZuCzUBK
         b0dHDWw/nQxUTZkx6FL8z2fIwvGV32vQpmHxRLA/01DTqpiZDHBobihVMi8fW9DHnwBG
         JUfDqU/K/pQpBEOLMbjUsigc6V4EDq58KLZCNHXs+0mCGH5rU5p7Hkj7RwVBcLb3FitY
         0mHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745992312; x=1746597112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPwYZu5Sw0ujxMeuZ9hQfOKEkijsGXSWuZMElxzTjX4=;
        b=D7LHy4G/fYJJ7OaztEN9kkD7dFZ05Njm8VAJoklcqxw9+ApZiw9aHRsscooHHt6j7T
         z4TFGbkkMfBKhQE5p1i+tYAtROY1Mfx4UvpeEHAP5lzRPU88iVqfUPHTgbHkwZJzFpY6
         HITMsGp+DMMvlGp7z7Bio+LPQ4zgJZoVTW33ir1dWFC19Lup7rdIrpw6OEkIDi1Sebp+
         /arO7xfsoMSfM0K0QSFMBm86ixZ6/Z/SLTpp0lI/Zfw9gj05oPHGnStQlUmPY3lm6mQ8
         Vj1yTxz85dPK7wolWysGXLaIOUPGUilC66EpM4HA3qc61uRmOrglQibR2ndWPBJFd4De
         EpBg==
X-Forwarded-Encrypted: i=1; AJvYcCU6J9UibhOnL7r3QLdVB5nC7biX88zBPk7DW5B0kwDRsdiSL+s3ZLuGaZw/mG9pP8t5XPKufC1LQw62@vger.kernel.org, AJvYcCUtVx8LxfqD6Pct6zcWN/0kWgz7FJ+gIWqNEGgfT+OYlbTHA0bUO2APmZBtGKOZjysYNszwMrQzBFxE31Gy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzucf4nOD9UIQEhCt7v5YAkWv0wEVPW9bJ2rCnZNejB/8aS1Bia
	G4Juy7t6MitMGT7DU8MEDh5rlyAzeDGLTXNVamc8ffxh+nCCzvby
X-Gm-Gg: ASbGncsJg1ISTCyrSysw73kGdSon02BFJx3dV8krqyhOxg/QmBBqonS/Nj3P7+C6I0f
	TiwVkn1XT8SAtBRuYF+5DiDqnuhF1qizb5fuQw+c9RkPPhyVulvKiaWkiAdvowR3EM1kb4HQ8H2
	qmZkKtTjLAWaskEGNv5sreQXYGXKxPCeECHlinAl9ACWP02bqRkWfKUWPTSEog+M6bz+487fsPI
	kTEjXRVAvFmgKsowOhJ3pJXnjjSivVvtoPQwgaAZ7fMKbb/qOm6cf0XtM7C6Ik9hGt0evJgX+Wa
	KJYKPl436D6ACqsWocvakAQOnKc/jWLH
X-Google-Smtp-Source: AGHT+IHINP8N9181bFfqqCZv5UDC9fqMMM43BOflkvQBND9Yro6dmDQkpAK5CAkg6h/7HZKI/K/dAA==
X-Received: by 2002:a17:907:7204:b0:aca:a1cf:d5f8 with SMTP id a640c23a62f3a-acee215d0cbmr100659466b.11.1745992311465;
        Tue, 29 Apr 2025 22:51:51 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acebe7a4f1csm299929566b.51.2025.04.29.22.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:51:51 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] power: supply: Add support for Maxim MAX8971 charger
Date: Wed, 30 Apr 2025 08:51:14 +0300
Message-ID: <20250430055114.11469-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250430055114.11469-1-clamor95@gmail.com>
References: <20250430055114.11469-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX8971 is a compact, high-frequency, high-efficiency switch-mode
charger for a one-cell lithium-ion (Li+) battery.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-power |  43 ++
 drivers/power/supply/Kconfig                |  14 +
 drivers/power/supply/Makefile               |   1 +
 drivers/power/supply/max8971_charger.c      | 752 ++++++++++++++++++++
 4 files changed, 810 insertions(+)
 create mode 100644 drivers/power/supply/max8971_charger.c

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 2a5c1a09a28f..560124cc3177 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -822,3 +822,46 @@ Description:
 		Each entry is a link to the device which registered the extension.
 
 		Access: Read
+
+What:		/sys/class/power_supply/max8971-charger/fast_charge_timer
+Date:		May 2025
+KernelVersion:	6.15.0
+Contact:	Svyatoslav Ryhel <clamor95@gmail.com>
+Description:
+		This entry shows and sets the maximum time the max8971
+		charger operates in fast-charge mode. When the timer expires
+		the device will terminate fast-charge mode (charging current
+		will drop to 0 A) and will trigger interrupt.
+
+		Valid values:
+
+		- 4 - 10 (hours), step by 1
+		- 0: disabled.
+
+What:		/sys/class/power_supply/max8971-charger/top_off_threshold_current
+Date:		May 2025
+KernelVersion:	6.15.0
+Contact:	Svyatoslav Ryhel <clamor95@gmail.com>
+Description:
+		This entry shows and sets the charging current threshold for
+		entering top-off charging mode. When charging current in fast
+		charge mode drops below this value, the charger will trigger
+		interrupt and start top-off charging mode.
+
+		Valid values:
+
+		- 50000 - 200000 (microamps), step by 50000 (rounded down)
+
+What:		/sys/class/power_supply/max8971-charger/top_off_timer
+Date:		May 2025
+KernelVersion:	6.15.0
+Contact:	Svyatoslav Ryhel <clamor95@gmail.com>
+Description:
+		This entry shows and sets the maximum time the max8971
+		charger operates in top-off charge mode. When the timer expires
+		the device will terminate top-off charge mode (charging current
+		will drop to 0 A) and will trigger interrupt.
+
+		Valid values:
+
+		- 0 - 70 (minutes), step by 10 (rounded down)
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 8dbd39afa43c..09fb123efe4f 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -595,6 +595,20 @@ config CHARGER_MAX77976
 	  This driver can also be built as a module. If so, the module will be
 	  called max77976_charger.
 
+config CHARGER_MAX8971
+	tristate "Maxim MAX8971 battery charger driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  The MAX8971 is a compact, high-frequency, high-efficiency switch-mode
+	  charger for a one-cell lithium-ion (Li+) battery. It delivers up to
+	  1.55A of current to the battery from inputs up to 7.5V and withstands
+	  transient inputs up to 22V.
+
+	  Say Y to enable support for the Maxim MAX8971 battery charger.
+	  This driver can also be built as a module. If so, the module will be
+	  called max8971_charger.
+
 config CHARGER_MAX8997
 	tristate "Maxim MAX8997/MAX8966 PMIC battery charger driver"
 	depends on MFD_MAX8997 && REGULATOR_MAX8997
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 61677be328b0..f1c28ba34e4a 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_CHARGER_MAX77650)	+= max77650-charger.o
 obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
 obj-$(CONFIG_CHARGER_MAX77705)	+= max77705_charger.o
 obj-$(CONFIG_CHARGER_MAX77976)	+= max77976_charger.o
+obj-$(CONFIG_CHARGER_MAX8971)	+= max8971_charger.o
 obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
 obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
 obj-$(CONFIG_CHARGER_MP2629)	+= mp2629_charger.o
diff --git a/drivers/power/supply/max8971_charger.c b/drivers/power/supply/max8971_charger.c
new file mode 100644
index 000000000000..26416d26f235
--- /dev/null
+++ b/drivers/power/supply/max8971_charger.c
@@ -0,0 +1,752 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/devm-helpers.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/extcon.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of_graph.h>
+#include <linux/property.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#define MAX8971_REG_CHGINT		0x0f
+#define   MAX8971_REG_CHG_RST		BIT(0)
+#define MAX8971_REG_CHGINT_MASK		0x01
+#define   MAX8971_AICL_MASK		BIT(7)
+#define MAX8971_REG_CHG_STAT		0x02
+#define   MAX8971_CHG_MASK		BIT(3)
+#define MAX8971_REG_DETAILS1		0x03
+#define MAX8971_REG_DETAILS2		0x04
+#define MAX8971_REG_CHGCNTL1		0x05
+#define MAX8971_REG_FCHGCRNT		0x06
+#define MAX8971_REG_DCCRNT		0x07
+#define   MAX8971_CHGRSTRT_MASK		BIT(6)
+#define MAX8971_REG_TOPOFF		0x08
+#define MAX8971_REG_TEMPREG		0x09
+#define MAX8971_REG_PROTCMD		0x0a
+#define   MAX8971_CHGPROT_LOCKED	0x00
+#define   MAX8971_CHGPROT_UNLOCKED	0x03
+
+#define MAX8971_FCHGT_DEFAULT		2
+#define MAX8971_TOPOFFT_DEFAULT		3
+
+static const char *max8971_manufacturer	= "Maxim Integrated";
+static const char *max8971_model	= "MAX8971";
+
+enum max8971_charging_state {
+	MAX8971_CHARGING_DEAD_BATTERY,
+	MAX8971_CHARGING_PREQUALIFICATION,
+	MAX8971_CHARGING_FAST_CONST_CURRENT,
+	MAX8971_CHARGING_FAST_CONST_VOLTAGE,
+	MAX8971_CHARGING_TOP_OFF,
+	MAX8971_CHARGING_DONE,
+	MAX8971_CHARGING_TIMER_FAULT,
+	MAX8971_CHARGING_SUSPENDED_THERMAL,
+	MAX8971_CHARGING_OFF,
+	MAX8971_CHARGING_THERMAL_LOOP,
+};
+
+enum max8971_health_state {
+	MAX8971_HEALTH_UNKNOWN,
+	MAX8971_HEALTH_COLD,
+	MAX8971_HEALTH_COOL,
+	MAX8971_HEALTH_WARM,
+	MAX8971_HEALTH_HOT,
+	MAX8971_HEALTH_OVERHEAT,
+};
+
+/* Fast-Charge current limit, 250..1550 mA, 50 mA steps */
+#define MAX8971_CHG_CC_STEP			  50000U
+#define MAX8971_CHG_CC_MIN			 250000U
+#define MAX8971_CHG_CC_MAX			1550000U
+
+/* Input current limit, 250..1500 mA, 25 mA steps */
+#define MAX8971_DCILMT_STEP			  25000U
+#define MAX8971_DCILMT_MIN			 250000U
+#define MAX8971_DCILMT_MAX			1500000U
+
+enum max8971_field_idx {
+	THM_DTLS,		/* DETAILS1 */
+	BAT_DTLS, CHG_DTLS,	/* DETAILS2 */
+	CHG_CC, FCHG_T,		/* FCHGCRNT */
+	DCI_LMT,		/* DCCRNT */
+	TOPOFF_T, TOPOFF_S,	/* TOPOFF */
+	CPROT,			/* PROTCMD */
+	MAX8971_N_REGMAP_FIELDS
+};
+
+static const struct reg_field max8971_reg_field[MAX8971_N_REGMAP_FIELDS] = {
+	[THM_DTLS] = REG_FIELD(MAX8971_REG_DETAILS1, 0, 2),
+	[BAT_DTLS] = REG_FIELD(MAX8971_REG_DETAILS2, 4, 5),
+	[CHG_DTLS] = REG_FIELD(MAX8971_REG_DETAILS2, 0, 3),
+	[CHG_CC]   = REG_FIELD(MAX8971_REG_FCHGCRNT, 0, 4),
+	[FCHG_T]   = REG_FIELD(MAX8971_REG_FCHGCRNT, 5, 7),
+	[DCI_LMT]  = REG_FIELD(MAX8971_REG_DCCRNT,   0, 5),
+	[TOPOFF_T] = REG_FIELD(MAX8971_REG_TOPOFF,   5, 7),
+	[TOPOFF_S] = REG_FIELD(MAX8971_REG_TOPOFF,   2, 3),
+	[CPROT]    = REG_FIELD(MAX8971_REG_PROTCMD,  2, 3),
+};
+
+static const struct regmap_config max8971_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX8971_REG_CHGINT,
+};
+
+struct max8971_data {
+	struct device *dev;
+	struct power_supply *psy_mains;
+
+	struct extcon_dev *edev;
+	struct notifier_block extcon_nb;
+	struct delayed_work extcon_work;
+
+	struct regmap *regmap;
+	struct regmap_field *rfield[MAX8971_N_REGMAP_FIELDS];
+
+	enum power_supply_usb_type usb_type;
+
+	u32 fchgt;
+	u32 tofft;
+	u32 toffs;
+
+	bool present;
+};
+
+static int max8971_get_status(struct max8971_data *priv, int *val)
+{
+	u32 regval;
+	int err;
+
+	err = regmap_field_read(priv->rfield[CHG_DTLS], &regval);
+	if (err)
+		return err;
+
+	switch (regval) {
+	case MAX8971_CHARGING_DEAD_BATTERY:
+	case MAX8971_CHARGING_PREQUALIFICATION:
+	case MAX8971_CHARGING_FAST_CONST_CURRENT:
+	case MAX8971_CHARGING_FAST_CONST_VOLTAGE:
+	case MAX8971_CHARGING_TOP_OFF:
+	case MAX8971_CHARGING_THERMAL_LOOP:
+		*val = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case MAX8971_CHARGING_DONE:
+		*val = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case MAX8971_CHARGING_TIMER_FAULT:
+		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case MAX8971_CHARGING_OFF:
+	case MAX8971_CHARGING_SUSPENDED_THERMAL:
+		*val = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	default:
+		*val = POWER_SUPPLY_STATUS_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int max8971_get_charge_type(struct max8971_data *priv, int *val)
+{
+	u32 regval;
+	int err;
+
+	err = regmap_field_read(priv->rfield[CHG_DTLS], &regval);
+	if (err)
+		return err;
+
+	switch (regval) {
+	case MAX8971_CHARGING_DEAD_BATTERY:
+	case MAX8971_CHARGING_PREQUALIFICATION:
+		*val = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		break;
+	case MAX8971_CHARGING_FAST_CONST_CURRENT:
+	case MAX8971_CHARGING_FAST_CONST_VOLTAGE:
+		*val = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		break;
+	case MAX8971_CHARGING_TOP_OFF:
+	case MAX8971_CHARGING_THERMAL_LOOP:
+		*val = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+		break;
+	case MAX8971_CHARGING_DONE:
+	case MAX8971_CHARGING_TIMER_FAULT:
+	case MAX8971_CHARGING_SUSPENDED_THERMAL:
+	case MAX8971_CHARGING_OFF:
+		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		break;
+	default:
+		*val = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int max8971_get_health(struct max8971_data *priv, int *val)
+{
+	u32 regval;
+	int err;
+
+	err = regmap_field_read(priv->rfield[THM_DTLS], &regval);
+	if (err)
+		return err;
+
+	switch (regval) {
+	case MAX8971_HEALTH_COLD:
+		*val = POWER_SUPPLY_HEALTH_COLD;
+		break;
+	case MAX8971_HEALTH_COOL:
+		*val = POWER_SUPPLY_HEALTH_COOL;
+		break;
+	case MAX8971_HEALTH_WARM:
+		*val = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	case MAX8971_HEALTH_HOT:
+		*val = POWER_SUPPLY_HEALTH_HOT;
+		break;
+	case MAX8971_HEALTH_OVERHEAT:
+		*val = POWER_SUPPLY_HEALTH_OVERHEAT;
+		break;
+	case MAX8971_HEALTH_UNKNOWN:
+	default:
+		*val = POWER_SUPPLY_HEALTH_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int max8971_get_online(struct max8971_data *priv, int *val)
+{
+	u32 regval;
+	int err;
+
+	err = regmap_read(priv->regmap, MAX8971_REG_CHG_STAT, &regval);
+	if (err)
+		return err;
+
+	if (priv->present)
+		/* CHG_OK bit is 0 when charger is online */
+		*val = !(regval & MAX8971_CHG_MASK);
+	else
+		*val = priv->present;
+
+	return 0;
+}
+
+static int max8971_get_integer(struct max8971_data *priv, enum max8971_field_idx fidx,
+			       u32 clamp_min, u32 clamp_max, u32 mult, int *val)
+{
+	u32 regval;
+	int err;
+
+	err = regmap_field_read(priv->rfield[fidx], &regval);
+	if (err)
+		return err;
+
+	*val = clamp_val(regval * mult, clamp_min, clamp_max);
+
+	return 0;
+}
+
+static int max8971_set_integer(struct max8971_data *priv, enum max8971_field_idx fidx,
+			       u32 clamp_min, u32 clamp_max, u32 div, int val)
+{
+	u32 regval;
+
+	regval = clamp_val(val, clamp_min, clamp_max) / div;
+
+	return regmap_field_write(priv->rfield[fidx], regval);
+}
+
+static int max8971_get_property(struct power_supply *psy, enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct max8971_data *priv = power_supply_get_drvdata(psy);
+	int err = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		err = max8971_get_status(priv, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		err = max8971_get_charge_type(priv, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = priv->usb_type;
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		err = max8971_get_health(priv, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		err = max8971_get_online(priv, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = priv->present;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
+		val->intval = MAX8971_CHG_CC_MAX;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		err = max8971_get_integer(priv, CHG_CC, MAX8971_CHG_CC_MIN, MAX8971_CHG_CC_MAX,
+					  MAX8971_CHG_CC_STEP, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		err = max8971_get_integer(priv, DCI_LMT, MAX8971_DCILMT_MIN, MAX8971_DCILMT_MAX,
+					  MAX8971_DCILMT_STEP, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = max8971_model;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = max8971_manufacturer;
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+static int max8971_set_property(struct power_supply *psy, enum power_supply_property psp,
+				const union power_supply_propval *val)
+{
+	struct max8971_data *priv = power_supply_get_drvdata(psy);
+	int err = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		err = max8971_set_integer(priv, CHG_CC, MAX8971_CHG_CC_MIN, MAX8971_CHG_CC_MAX,
+					  MAX8971_CHG_CC_STEP, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		err = max8971_set_integer(priv, DCI_LMT, MAX8971_DCILMT_MIN, MAX8971_DCILMT_MAX,
+					  MAX8971_DCILMT_STEP, val->intval);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+};
+
+static int max8971_property_is_writeable(struct power_supply *psy,
+					 enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static enum power_supply_property max8971_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static const struct power_supply_desc max8971_charger_desc = {
+	.name = "max8971-charger",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN) |
+		     BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_ACA),
+	.properties = max8971_properties,
+	.num_properties = ARRAY_SIZE(max8971_properties),
+	.get_property = max8971_get_property,
+	.set_property = max8971_set_property,
+	.property_is_writeable = max8971_property_is_writeable,
+};
+
+static void max8971_update_config(struct max8971_data *priv)
+{
+	regmap_field_write(priv->rfield[CPROT], MAX8971_CHGPROT_UNLOCKED);
+
+	if (priv->fchgt != MAX8971_FCHGT_DEFAULT)
+		regmap_field_write(priv->rfield[FCHG_T], priv->fchgt);
+
+	regmap_write_bits(priv->regmap, MAX8971_REG_DCCRNT, MAX8971_CHGRSTRT_MASK,
+			  MAX8971_CHGRSTRT_MASK);
+
+	if (priv->tofft != MAX8971_TOPOFFT_DEFAULT)
+		regmap_field_write(priv->rfield[TOPOFF_T], priv->tofft);
+
+	if (priv->toffs)
+		regmap_field_write(priv->rfield[TOPOFF_S], priv->toffs);
+
+	regmap_field_write(priv->rfield[CPROT], MAX8971_CHGPROT_LOCKED);
+}
+
+static ssize_t fast_charge_timer_show(struct device *dev, struct device_attribute *attr,
+				      char *buf)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct max8971_data *priv = power_supply_get_drvdata(psy);
+	u32 regval;
+	int err;
+
+	err = regmap_field_read(priv->rfield[FCHG_T], &regval);
+	if (err)
+		return err;
+
+	switch (regval) {
+	case 0x1 ... 0x7:
+		/* Time is off by 3 hours comparing to value */
+		regval += 3;
+		break;
+	case 0x0:
+	default:
+		regval = 0;
+		break;
+	}
+
+	return sysfs_emit(buf, "%u\n", regval);
+}
+
+static ssize_t fast_charge_timer_store(struct device *dev, struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct max8971_data *priv = power_supply_get_drvdata(psy);
+	unsigned long hours;
+	int val, err;
+
+	err = kstrtoul(buf, 10, &hours);
+	if (err)
+		return err;
+
+	val = hours - 3;
+	if (val <= 0 || val > 7)
+		priv->fchgt = 0;
+	else
+		priv->fchgt = val;
+
+	max8971_update_config(priv);
+
+	return count;
+}
+
+static ssize_t top_off_threshold_current_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct max8971_data *priv = power_supply_get_drvdata(psy);
+	u32 regval, val;
+	int err;
+
+	err = regmap_field_read(priv->rfield[TOPOFF_S], &regval);
+	if (err)
+		return err;
+
+	/* 50uA start with 50uA step */
+	val = regval * 50 + 50;
+	val *= 1000;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t top_off_threshold_current_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct max8971_data *priv = power_supply_get_drvdata(psy);
+	unsigned long uamp;
+	int err;
+
+	err = kstrtoul(buf, 10, &uamp);
+	if (err)
+		return err;
+
+	if (uamp < 50000 || uamp > 200000)
+		return -EINVAL;
+
+	priv->toffs = uamp / 50000 - 1;
+
+	max8971_update_config(priv);
+
+	return count;
+}
+
+static ssize_t top_off_timer_show(struct device *dev, struct device_attribute *attr,
+				  char *buf)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct max8971_data *priv = power_supply_get_drvdata(psy);
+	u32 regval;
+	int err;
+
+	err = regmap_field_read(priv->rfield[TOPOFF_T], &regval);
+	if (err)
+		return err;
+
+	/* 10 min intervals */
+	regval *= 10;
+
+	return sysfs_emit(buf, "%u\n", regval);
+}
+
+static ssize_t top_off_timer_store(struct device *dev, struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct max8971_data *priv = power_supply_get_drvdata(psy);
+	unsigned long minutes;
+	int err;
+
+	err = kstrtoul(buf, 10, &minutes);
+	if (err)
+		return err;
+
+	if (minutes > 70)
+		return -EINVAL;
+
+	priv->tofft = minutes / 10;
+
+	max8971_update_config(priv);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(fast_charge_timer);
+static DEVICE_ATTR_RW(top_off_threshold_current);
+static DEVICE_ATTR_RW(top_off_timer);
+
+static struct attribute *max8971_attrs[] = {
+	&dev_attr_fast_charge_timer.attr,
+	&dev_attr_top_off_threshold_current.attr,
+	&dev_attr_top_off_timer.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(max8971);
+
+static void max8971_extcon_evt_worker(struct work_struct *work)
+{
+	struct max8971_data *priv =
+		container_of(work, struct max8971_data, extcon_work.work);
+	struct device *dev = priv->dev;
+	struct extcon_dev *edev = priv->edev;
+	u32 chgcc, dcilmt;
+
+	if (extcon_get_state(edev, EXTCON_CHG_USB_SDP) > 0) {
+		dev_dbg(dev, "USB SDP charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_SDP;
+		chgcc = 500000;
+		dcilmt = 500000;
+	} else if (extcon_get_state(edev, EXTCON_USB) > 0) {
+		dev_dbg(dev, "USB charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_SDP;
+		chgcc = 500000;
+		dcilmt = 500000;
+	} else if (extcon_get_state(edev, EXTCON_DISP_MHL) > 0) {
+		dev_dbg(dev, "MHL plug is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_SDP;
+		chgcc = 500000;
+		dcilmt = 500000;
+	} else if (extcon_get_state(edev, EXTCON_CHG_USB_DCP) > 0) {
+		dev_dbg(dev, "USB DCP charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_DCP;
+		chgcc = 900000;
+		dcilmt = 1200000;
+	} else if (extcon_get_state(edev, EXTCON_CHG_USB_FAST) > 0) {
+		dev_dbg(dev, "USB FAST charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_ACA;
+		chgcc = 900000;
+		dcilmt = 1200000;
+	} else if (extcon_get_state(edev, EXTCON_CHG_USB_SLOW) > 0) {
+		dev_dbg(dev, "USB SLOW charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_ACA;
+		chgcc = 900000;
+		dcilmt = 1200000;
+	} else if (extcon_get_state(edev, EXTCON_CHG_USB_CDP) > 0) {
+		dev_dbg(dev, "USB CDP charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_CDP;
+		chgcc = 900000;
+		dcilmt = 1200000;
+	} else {
+		dev_dbg(dev, "USB state is unknown\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+		return;
+	}
+
+	regmap_field_write(priv->rfield[CPROT], MAX8971_CHGPROT_UNLOCKED);
+
+	max8971_set_integer(priv, CHG_CC, MAX8971_CHG_CC_MIN, MAX8971_CHG_CC_MAX,
+			    MAX8971_CHG_CC_STEP, chgcc);
+	max8971_set_integer(priv, DCI_LMT, MAX8971_DCILMT_MIN, MAX8971_DCILMT_MAX,
+			    MAX8971_DCILMT_STEP, dcilmt);
+
+	regmap_field_write(priv->rfield[CPROT], MAX8971_CHGPROT_LOCKED);
+}
+
+static int extcon_get_charger_type(struct notifier_block *nb,
+				   unsigned long state, void *data)
+{
+	struct max8971_data *priv =
+		container_of(nb, struct max8971_data, extcon_nb);
+	schedule_delayed_work(&priv->extcon_work, 0);
+
+	return NOTIFY_OK;
+}
+
+static irqreturn_t max8971_interrupt(int irq, void *dev_id)
+{
+	struct max8971_data *priv = dev_id;
+	struct device *dev = priv->dev;
+	int err, state;
+
+	err = regmap_read(priv->regmap, MAX8971_REG_CHGINT, &state);
+	if (err)
+		dev_err(dev, "interrupt reg read failed %d\n", err);
+
+	err = regmap_write_bits(priv->regmap, MAX8971_REG_CHGINT_MASK,
+				MAX8971_AICL_MASK, MAX8971_AICL_MASK);
+	if (err)
+		dev_err(dev, "failed to mask IRQ\n");
+
+	/* set presence prop */
+	priv->present = state & MAX8971_REG_CHG_RST;
+
+	/* on every plug chip resets to default */
+	if (priv->present)
+		max8971_update_config(priv);
+
+	/* update supply status */
+	power_supply_changed(priv->psy_mains);
+
+	return IRQ_HANDLED;
+}
+
+static int max8971_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct max8971_data *priv;
+	struct device_node *extcon;
+	struct power_supply_config cfg = { };
+	int err, i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+
+	i2c_set_clientdata(client, priv);
+
+	priv->regmap = devm_regmap_init_i2c(client, &max8971_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(dev, PTR_ERR(priv->regmap), "cannot allocate regmap\n");
+
+	for (i = 0; i < MAX8971_N_REGMAP_FIELDS; i++) {
+		priv->rfield[i] = devm_regmap_field_alloc(dev, priv->regmap, max8971_reg_field[i]);
+		if (IS_ERR(priv->rfield[i]))
+			return dev_err_probe(dev, PTR_ERR(priv->rfield[i]),
+					     "cannot allocate regmap field\n");
+	}
+
+	cfg.attr_grp = max8971_groups;
+	cfg.drv_data = priv;
+	cfg.fwnode = dev_fwnode(dev);
+
+	priv->psy_mains = devm_power_supply_register(dev, &max8971_charger_desc, &cfg);
+	if (IS_ERR(priv->psy_mains))
+		return dev_err_probe(dev, PTR_ERR(priv->psy_mains),
+				     "failed to register mains supply\n");
+
+	err = regmap_write_bits(priv->regmap, MAX8971_REG_CHGINT_MASK, MAX8971_AICL_MASK,
+				MAX8971_AICL_MASK);
+	if (err)
+		return dev_err_probe(dev, err, "failed to mask IRQ\n");
+
+	err = devm_request_threaded_irq(dev, client->irq, NULL, &max8971_interrupt,
+					IRQF_ONESHOT | IRQF_SHARED, client->name, priv);
+	if (err)
+		return dev_err_probe(dev, err, "failed to register IRQ %d\n", client->irq);
+
+	extcon = of_graph_get_remote_node(dev->of_node, -1, -1);
+	if (!extcon)
+		return 0;
+
+	priv->edev = extcon_find_edev_by_node(extcon);
+	of_node_put(extcon);
+	if (IS_ERR(priv->edev))
+		return dev_err_probe(dev, PTR_ERR(priv->edev), "failed to find extcon\n");
+
+	err = devm_delayed_work_autocancel(dev, &priv->extcon_work,
+					   max8971_extcon_evt_worker);
+	if (err)
+		return dev_err_probe(dev, err, "failed to add extcon evt stop action\n");
+
+	priv->extcon_nb.notifier_call = extcon_get_charger_type;
+
+	err = devm_extcon_register_notifier_all(dev, priv->edev, &priv->extcon_nb);
+	if (err)
+		return dev_err_probe(dev, err, "failed to register notifier\n");
+
+	/* Initial configuration work with 1 sec delay */
+	schedule_delayed_work(&priv->extcon_work, msecs_to_jiffies(1000));
+
+	return 0;
+}
+
+static int __maybe_unused max8971_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max8971_data *priv = i2c_get_clientdata(client);
+
+	irq_wake_thread(client->irq, priv);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(max8971_pm_ops, NULL, max8971_resume);
+
+static const struct of_device_id max8971_match_ids[] = {
+	{ .compatible = "maxim,max8971" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, max8971_match_ids);
+
+static const struct i2c_device_id max8971_i2c_id[] = {
+	{ "max8971" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max8971_i2c_id);
+
+static struct i2c_driver max8971_driver = {
+	.driver = {
+		.name = "max8971-charger",
+		.of_match_table = max8971_match_ids,
+		.pm = &max8971_pm_ops,
+	},
+	.probe = max8971_probe,
+	.id_table = max8971_i2c_id,
+};
+module_i2c_driver(max8971_driver);
+
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("MAX8971 Charger Driver");
+MODULE_LICENSE("GPL");
-- 
2.48.1


