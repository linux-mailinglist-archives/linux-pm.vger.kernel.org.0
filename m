Return-Path: <linux-pm+bounces-43331-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGL1J9i7oWmswAQAu9opvQ
	(envelope-from <linux-pm+bounces-43331-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 16:44:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD721BA25D
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 16:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8736F30CD7C0
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 15:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B45441046;
	Fri, 27 Feb 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="RjvG5FiL"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8C441023;
	Fri, 27 Feb 2026 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206545; cv=fail; b=J5YswC1T1smZY9aB9gxmHdRfoHfqACnvIJwka2UCmnIYDxD4yU3EtbGybfXc7mmGWfoeBNTrpARg4V5cGIZHWNp8AR9QnY1JzbhdY7bfxgj8EzYFbP6TY41qdjPAY8iABEag3NgLlmQFrXCUBPWvIyimFeTMELlms7NEvRg/xtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206545; c=relaxed/simple;
	bh=OV1k4Y2zPLP6RSfh8+Uz6ezvl1pWF5AjWTjjBXy9KvQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=NK3ojuyYNO4Wc8oLPnrul0Cfrh0gLYoIBxTY9ODRCUmMO9JWAzftXHJWxESlUmCCXVWNq5LNfcQ6jEqvKgfmhCRfIL4hMx8L+wVbUgwDNb+SBnRNaJu58yUVxnjalF38Nbvp+k5bAUKIeEbfjdAhUNffm3Q8uPOX4LwPPN+EXsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=RjvG5FiL; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqP+mdnSONAumUcX4NlscMPIy58EhWccD4iI6t0FUoGEM3gJsVTtjqAFRfXeIOYmN84uuAQ/zbxpZIANPlS04b/KnEMo6UT+o1KUg74xEh3Bx5m7dIs2J8YHv8t2P+KCVGHCcF9JEy6sknpqmQWHAkgRAICYNNCGDZUp4rsnbd20eJCil8a4cXOD0AEAva3BOazwWXVhM+3dWOyzlATrUhJwfcmJK3jyaBkUooey+FWE6+QNPbMCLf+LaNnc7d+cEh4nguTnBu+KuAQiDCKRvugixnQ3d+KFJkIGI9IMvZlh+9zm6Hs3n5boKwipZeTKw5zBLSzh8pXkcPXzCllQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbNnP+hDzScU0Imgx9D1ewnVmWHpQRmNziAEvN7SBwo=;
 b=ZkeWqrjz+/6bxO/shtDZq5ocCpAjtZUA1ClniXwPGs1imA3FVY9X8RZ5SluLOm4rXq4tmmKWxt6/WePChLmLHDHEBqGXPgvoluvaRzyFeOshGjwz/tn/X1MNHH8xFfIhyRF/UG1aU+zrP6VM8+V8bV6GpZx63mxjEQzJfAzkyAQmmK+K/G7i0e8IvHU5wky5JwqR/2Jl/jugAVpOisVwmk0tNoEcj7VEc2KgyfiLo1UBLjmUaWWa9sJDCOiL0Tua1SN6Z7L4mYEAJDOshHcLHCVAlwfoCLYAs0nLykEQxzkRvP6RVeCm/V4X3UZxIgHOqyrrrspLrCpsT9nh/BWH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbNnP+hDzScU0Imgx9D1ewnVmWHpQRmNziAEvN7SBwo=;
 b=RjvG5FiLLDq91apz54CzoiG+a6ukhfgZZWvb0zTtHrBIubnpUrya8e77GLqGup1q0qcZKsv/MnZe8JryY0VRoqho7LHLbvyrK9l2Mo22IVgC8wzCylgRBHmoLBPo+nomOd9HjOhl3zz+mhxIiNf/c17fIb6w98EmbuTqP5M4Q1A=
Received: from AS4P189CA0033.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::6)
 by DB9PR02MB11160.eurprd02.prod.outlook.com (2603:10a6:10:5c8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 15:35:36 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::5f) by AS4P189CA0033.outlook.office365.com
 (2603:10a6:20b:5dd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 15:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 15:35:36 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 27 Feb
 2026 16:35:33 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: [RFC PATCH 2/2] power: supply: Add driver for TI BQ25630 charger
In-Reply-To: <cover.1772201049.git.waqar.hameed@axis.com>
References: <cover.1772201049.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <ce8ca4cce1e63a5f74d8e522d3aac4c0b341de3b.1772201049.git.waqar.hameed@axis.com>
Date: Fri, 27 Feb 2026 16:35:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A9:EE_|DB9PR02MB11160:EE_
X-MS-Office365-Filtering-Correlation-Id: f923ca65-2caf-4c9f-1074-08de7615da63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	3Bm8Ku/08obFI8aKh4QiZ/+acfy+NO+bGdH0vBaUZ4bp4woi9/LEMMns92DaFFYgy82a7gExhJoIvEUUGV+Cx00SWHvpEKbwtvJQTVBMutRs9x0y8fbwsS8f+CeCFvYGH+60Wp6eAI9jAu0cUt7ckjVj1KJibk+AZMEE3B4M+9KfafW+SvAyPFnDt7DlZR8l/GUd1+nakBv7vbzqQSIlaNnMKxUE4CNaZiSVXutxFnF9lSSzKhm9N/50kcB0333MV7n8PvUUZb+mydXN2l4QdQ3dtrP3tiSC82qT2AgYM+FCvZcJzNMstFRtfKffw9SDjW9jzxrny1qU0L0wm4HbcYhQh3NGA+uiIv/N3G2NmnlPjplvClCKPAZ6HF4ZsHAOrbMBzAqnSQUJ9ZP6p1eW2oSyTzrNBiVWsKvJdKJ4it0JY+TUtUNlha9s4+LPgEvRK/Bo/9AxTSIR6tiLXH+/MX9yaHfCmr4/8drPy2lUM7YaIv01K2pRh1i6wSMqgSfdwuypiTAVk0g07KSUK1rdvUoxfhJsvpt04/2tWI8X/v95/MlkzK0dmQ7X0kWH9m1qAULfOuB7ou2s5WSZv6zh89c5qbcgB+W6LcnvBR160J2Qa8ERoeeZE/xDqwyUNfyjs06M3zBuJQljj9f67thcWKOEDT47heGfBj9ypYNmBn1MtlH1f1EwqzD1LBZZ7XqgQnjKcvB4wp+rGtIauOtRRAnjWtq8Vq0tbaNQDybkAKG7FJUIS8xX226Idu88gZwwam5ptfmjrlKVSiLHwe/61PVGWnyqToLrA3CQXRZ086OTus5rS/YQPxRHxX0+4LzhYoASpbdjSzkgrNXxMToM+A==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hYSZi6r4co/j9xm2Tmm6swUBSLd6i/FcXqG4NbdKmoK2Z8BTYbYNbj83DD0Cu70O2FCOF95zgGG9k6yRDF1AjrDuMKpnNwTGDYGWkHpX0DDkU0fsRjSqu8Qp+S/kOZfKuipIh1aGeTC6CoJ+HpBIX8zSxMzjTkSz3wi00Xi2qXrGxTaCo2pEzM+bmYHOWorl2XjkxMj7DCbOjXmZDeU99GSL1MtbXAFa4tsKiH+50V5Y49CjjTQWDe/XPb5nNboYb1iK3fXiWWV/nbch6c9UZXRnvwtO/2DT6+qXeP62O6YrRUUBA12ww+2LA8MwfDT/pO30Phwy6VwpQgm0KXsXRTDcFSLTS38jNlY7m3LtGRabU/Vc1ECRlQRTcT+ZS2ld9ml46Vs7djBWhJpq1z+9YYjRIZaeGLVyOa2ZFblzgSwfK1FWTkMZAVX5v5c2KFDN
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:35:36.3103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f923ca65-2caf-4c9f-1074-08de7615da63
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB11160
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.85 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[axis.com,none];
	R_DKIM_ALLOW(-0.20)[axis.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[axis.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43331-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:url];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[waqar.hameed@axis.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EDD721BA25D
X-Rspamd-Action: no action

TI BQ25630 is a battery charger that is I2C controlled. Despite its
model name, it is rather different from the other devices in the BQ256xx
family; it has a completely different register layout and some other
additional functionality (see the datasheet for more details [1]).

The most "annoying" thing is that it has two different register lengths:
8-bit and 16-bit. Moreover, the 16-bit registers are further partitioned
into either being little- or big-endian... Luckily, `regmap` has support
for multiple `regmap_config`s (by setting unique names). Therefore, use
three different `regmap_config`s for the corresponding registers. ADC
functionality has been left out, due to it not having any real-world
use-cases.

The `enum power_supply_property` values are straightforward to map. Some
properties are clamped (e.g. voltage/current ranges). Common
`bq25630_read/write_limit()` functions for this are therefore suitable.

Interrupts are sent whenever a state change is detected. Save the state
status registers in `bq25630_data` and `memcmp()` this in order to
decide if `power_supply_changed()` should be called or not. The actual
state values are in (and fetched from) the other
`power_supply_property`-mapped registers.

[1] https://www.ti.com/lit/gpn/bq25630

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/Kconfig           |    7 +
 drivers/power/supply/Makefile          |    1 +
 drivers/power/supply/bq25630_charger.c | 1074 ++++++++++++++++++++++++
 3 files changed, 1082 insertions(+)
 create mode 100644 drivers/power/supply/bq25630_charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 92f9f7aae92f2..52e85191ab076 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -817,6 +817,13 @@ config CHARGER_BQ25980
 	  Say Y to enable support for the TI BQ25980, BQ25975 and BQ25960
 	  series of fast battery chargers.
=20
+config CHARGER_BQ25630
+	tristate "TI BQ25630 battery charger driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y to enable support for the TI BQ25630 battery charger.
+
 config CHARGER_BQ256XX
 	tristate "TI BQ256XX battery charger driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 4b79d5abc49a7..9c7a52c302115 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_CHARGER_BQ2515X)	+=3D bq2515x_charger.o
 obj-$(CONFIG_CHARGER_BQ257XX)	+=3D bq257xx_charger.o
 obj-$(CONFIG_CHARGER_BQ25890)	+=3D bq25890_charger.o
 obj-$(CONFIG_CHARGER_BQ25980)	+=3D bq25980_charger.o
+obj-$(CONFIG_CHARGER_BQ25630)	+=3D bq25630_charger.o
 obj-$(CONFIG_CHARGER_BQ256XX)	+=3D bq256xx_charger.o
 obj-$(CONFIG_CHARGER_RK817)	+=3D rk817_charger.o
 obj-$(CONFIG_CHARGER_SMB347)	+=3D smb347-charger.o
diff --git a/drivers/power/supply/bq25630_charger.c b/drivers/power/supply/=
bq25630_charger.c
new file mode 100644
index 0000000000000..362622aaad895
--- /dev/null
+++ b/drivers/power/supply/bq25630_charger.c
@@ -0,0 +1,1074 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for TI BQ25630 charger.
+ *
+ * Copyright (C) 2026 Axis Communications AB
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include <linux/power_supply.h>
+
+#define BQ25630_DRV_NAME "bq25630-charger"
+
+/* Registers. */
+#define BQ25630_REG_CHARGE_CURRENT_LIMIT	0x02
+#define BQ25630_REG_CHARGE_VOLTAGE_LIMIT	0x04
+#define BQ25630_REG_INPUT_CURRENT_LIMIT		0x06
+#define BQ25630_REG_INPUT_VOLTAGE_LIMIT		0x08
+#define BQ25630_REG_IOTG_REGULATION		0x0a
+#define BQ25630_REG_VOTG_REGULATION		0x0c
+#define BQ25630_REG_MINIMAL_SYSTEM_VOLTAGE	0x0e
+#define BQ25630_REG_PRECHARGE_CONTROL		0x10
+#define BQ25630_REG_TERMINATION_CONTROL		0x12
+#define BQ25630_REG_CHARGE_TIMER_CONTROL	0x14
+#define BQ25630_REG_CHARGER_CONTROL_0		0x15
+#define BQ25630_REG_CHARGER_CONTROL_1		0x16
+#define BQ25630_REG_CHARGER_CONTROL_2		0x17
+#define BQ25630_REG_CHARGER_CONTROL_3		0x18
+#define BQ25630_REG_CHARGER_CONTROL_4		0x19
+#define BQ25630_REG_CHARGER_CONTROL_5		0x1a
+#define BQ25630_REG_NTC_CONTROL_0		0x1b
+#define BQ25630_REG_NTC_CONTROL_1		0x1c
+#define BQ25630_REG_NTC_CONTROL_2		0x1d
+#define BQ25630_REG_NTC_CONTROL_3		0x1e
+#define BQ25630_REG_CHARGER_STATUS_0		0x1f
+#define BQ25630_REG_CHARGER_STATUS_1		0x20
+#define BQ25630_REG_CHARGER_STATUS_2		0x21
+#define BQ25630_REG_FAULT_STATUS		0x22
+#define BQ25630_REG_CHARGER_FLAG_0		0x23
+#define BQ25630_REG_CHARGER_FLAG_1		0x24
+#define BQ25630_REG_FAULT_FLAG			0x25
+#define BQ25630_REG_CHARGER_MASK_0		0x26
+#define BQ25630_REG_CHARGER_MASK_1		0x27
+#define BQ25630_REG_FAULT_MASK			0x28
+#define BQ25630_REG_ICO_CURRENT_LIMIT		0x29
+#define BQ25630_REG_ADC_CONTROL			0x2b
+#define BQ25630_REG_ADC_CHANNEL_DISABLE_1	0x2c
+#define BQ25630_REG_IBUS_ADC			0x32
+#define BQ25630_REG_IBAT_ADC			0x34
+#define BQ25630_REG_VBUS_ADC			0x36
+#define BQ25630_REG_VPMID_ADC			0x38
+#define BQ25630_REG_VBAT_ADC			0x3a
+#define BQ25630_REG_VSYS_ADC			0x3c
+#define BQ25630_REG_TS_ADC			0x3e
+#define BQ25630_REG_TDIE_ADC			0x40
+#define BQ25630_REG_USB_C_CONTROL_0		0x44
+#define BQ25630_REG_USB_C_CONTROL_1		0x45
+#define BQ25630_REG_LIQUID_CONTROL_0		0x46
+#define BQ25630_REG_LIQUID_CONTROL_1		0x47
+#define BQ25630_REG_USB_C_INFORMATION_0		0x48
+#define BQ25630_REG_USB_C_INFORMATION_1		0x49
+#define BQ25630_REG_USB_DAC_CONTROL_0		0x4a
+#define BQ25630_REG_USB_DAC_CONTROL_1		0x4b
+#define BQ25630_REG_PART_INFORMATION		0x4d
+
+#define BQ25630_NR_STAT_REGS \
+	(BQ25630_REG_FAULT_FLAG - BQ25630_REG_FAULT_STATUS + 1)
+
+/* Charge current limits. */
+#define BQ25630_ICHG_MIN_REGVAL 0x04
+#define BQ25630_ICHG_MIN 80000
+#define BQ25630_ICHG_MAX 5040000
+#define BQ25630_ICHG_STEP 20000
+
+/* Charge voltage limits. */
+#define BQ25630_VREG_MIN_REGVAL 0x15e
+#define BQ25630_VREG_MIN 3500000
+#define BQ25630_VREG_MAX 4800000
+#define BQ25630_VREG_STEP 10000
+
+/* Input current limits. */
+#define BQ25630_IINDPM_MIN_REGVAL 0x0a
+#define BQ25630_IINDPM_MIN 100000
+#define BQ25630_IINDPM_MAX 3200000
+#define BQ25630_IINDPM_STEP 10000
+
+/* Input voltage limits. */
+#define BQ25630_VINDPM_MIN_REGVAL 0x5f
+#define BQ25630_VINDPM_MIN 3800000
+#define BQ25630_VINDPM_MAX 16800000
+#define BQ25630_VINDPM_STEP 40000
+
+/* Minimal system voltage limits. */
+#define BQ25630_VSYSMIN_MIN_REGVAL 0x20
+#define BQ25630_VSYSMIN_MIN 2560000
+#define BQ25630_VSYSMIN_MAX 4000000
+#define BQ25630_VSYSMIN_STEP 80000
+
+/* Pre-charge current limits. */
+#define BQ25630_IPRECHG_MIN_REGVAL 0x02
+#define BQ25630_IPRECHG_MIN 40000
+#define BQ25630_IPRECHG_MAX 1000000
+#define BQ25630_IPRECHG_STEP 20000
+
+/* Termination current limits. */
+#define BQ25630_ITERM_MIN_REGVAL 0x03
+#define BQ25630_ITERM_MIN 30000
+#define BQ25630_ITERM_MAX 1000000
+#define BQ25630_ITERM_STEP 10000
+
+/* Charge types. */
+#define BQ25630_CHG_STAT_NOT_CHARGING	0x00
+#define BQ25630_CHG_STAT_TRICKLE_CHARGE 0x01
+#define BQ25630_CHG_STAT_PRE_CHARGE	0x02
+#define BQ25630_CHG_STAT_FAST_CHARGE	0x03
+#define BQ25630_CHG_STAT_TAPER_CHARGE	0x04
+#define BQ25630_CHG_STAT_TERMINATION	0x07
+
+/* USB types (VBUS). */
+#define BQ25630_VBUS_STAT_NONE		0x00
+#define BQ25630_VBUS_STAT_SDP		0x01
+#define BQ25630_VBUS_STAT_CDP		0x02
+#define BQ25630_VBUS_STAT_DCP		0x03
+#define BQ25630_VBUS_STAT_HVDCP		0x06
+#define BQ25630_VBUS_STAT_BOOST_OTG	0x07
+#define BQ25630_VBUS_STAT_USB_C_DEFAULT 0x08
+#define BQ25630_VBUS_STAT_USB_C_MEDIUM	0x09
+#define BQ25630_VBUS_STAT_USB_C_HIGH	0x0a
+
+/* Temperature status. */
+#define BQ25630_TS_STAT_NORMAL	0x00
+#define BQ25630_TS_STAT_COLD	0x01
+#define BQ25630_TS_STAT_HOT	0x02
+#define BQ25630_TS_STAT_COOL	0x03
+#define BQ25630_TS_STAT_WARM	0x04
+#define BQ25630_TS_STAT_PRECOOL 0x05
+#define BQ25630_TS_STAT_PREWARM 0x06
+
+/* Register fields. */
+enum bq25630_regfield {
+	/* Charge current limit. */
+	BQ25630_REGF_ICHG,
+	/* Charge voltage limit. */
+	BQ25630_REGF_VREG,
+	/* Input current limit. */
+	BQ25630_REGF_IINDPM,
+	/* Input voltage limit. */
+	BQ25630_REGF_VINDPM,
+	/* Minimal system voltage. */
+	BQ25630_REGF_VSYSMIN,
+	/* Pre-charge current limit. */
+	BQ25630_REGF_IPRECHG,
+	/* Termination current threshold. */
+	BQ25630_REGF_ITERM,
+
+	/* IBUS ADC reading. */
+	BQ25630_REGF_IBUS_ADC,
+	/* VBUS ADC reading. */
+	BQ25630_REGF_VBUS_ADC,
+
+	/* Watchdog timer. */
+	BQ25630_REGF_WATCHDOG,
+	/* Enable charger. */
+	BQ25630_REGF_EN_CHG,
+	/* Register reset. */
+	BQ25630_REGF_REG_RST,
+	/* BATFET control. */
+	/* TODO: Add a new framework sysfs ABI? */
+	BQ25630_REGF_BATFET_CTRL,
+	/* Power good indicator. */
+	BQ25630_REGF_PG_STAT,
+	/* Charge status. */
+	BQ25630_REGF_CHG_STAT,
+	/* VBUS status. */
+	BQ25630_REGF_VBUS_STAT,
+
+	/* Temperature zone. */
+	BQ25630_REGF_TS_STAT,
+	/* Temperature shutdwon. */
+	BQ25630_REGF_TSHUT_STAT,
+	/* OTG fault. */
+	BQ25630_REGF_OTG_FAULT_STAT,
+	/* System voltage fault. */
+	BQ25630_REGF_VSYS_FAULT_STAT,
+	/* Battery fault. */
+	BQ25630_REGF_BAT_FAULT_STAT,
+	/* VBUS fault. */
+	BQ25630_REGF_VBUS_FAULT_STAT,
+
+	/* Sentinel value. */
+	BQ25630_REGF_MAX
+};
+
+static const struct reg_field bq25630_regfields[] =3D {
+	[BQ25630_REGF_ICHG] =3D
+		REG_FIELD(BQ25630_REG_CHARGE_CURRENT_LIMIT, 4, 11),
+	[BQ25630_REGF_VREG] =3D
+		REG_FIELD(BQ25630_REG_CHARGE_VOLTAGE_LIMIT, 3, 11),
+	[BQ25630_REGF_IINDPM] =3D
+		REG_FIELD(BQ25630_REG_INPUT_CURRENT_LIMIT, 3, 11),
+	[BQ25630_REGF_VINDPM] =3D
+		REG_FIELD(BQ25630_REG_INPUT_VOLTAGE_LIMIT, 5, 13),
+
+	[BQ25630_REGF_VSYSMIN] =3D
+		REG_FIELD(BQ25630_REG_MINIMAL_SYSTEM_VOLTAGE, 6, 11),
+
+	[BQ25630_REGF_IPRECHG] =3D
+		REG_FIELD(BQ25630_REG_PRECHARGE_CONTROL, 4, 9),
+	[BQ25630_REGF_ITERM] =3D
+		REG_FIELD(BQ25630_REG_TERMINATION_CONTROL, 3, 9),
+
+	[BQ25630_REGF_IBUS_ADC] =3D REG_FIELD(BQ25630_REG_IBUS_ADC, 1, 15),
+	[BQ25630_REGF_VBUS_ADC] =3D REG_FIELD(BQ25630_REG_VBUS_ADC, 2, 14),
+
+	[BQ25630_REGF_WATCHDOG] =3D
+		REG_FIELD(BQ25630_REG_CHARGER_CONTROL_1, 0, 1),
+	[BQ25630_REGF_EN_CHG] =3D
+		REG_FIELD(BQ25630_REG_CHARGER_CONTROL_1, 5, 5),
+	[BQ25630_REGF_REG_RST] =3D
+		REG_FIELD(BQ25630_REG_CHARGER_CONTROL_2, 7, 7),
+	[BQ25630_REGF_BATFET_CTRL] =3D
+		REG_FIELD(BQ25630_REG_CHARGER_CONTROL_3, 0, 1),
+	[BQ25630_REGF_PG_STAT] =3D
+		REG_FIELD(BQ25630_REG_CHARGER_STATUS_0, 7, 7),
+	[BQ25630_REGF_CHG_STAT] =3D
+		REG_FIELD(BQ25630_REG_CHARGER_STATUS_1, 3, 5),
+	[BQ25630_REGF_VBUS_STAT] =3D
+		REG_FIELD(BQ25630_REG_CHARGER_STATUS_2, 4, 7),
+
+	[BQ25630_REGF_TS_STAT] =3D
+		REG_FIELD(BQ25630_REG_FAULT_STATUS, 0, 2),
+	[BQ25630_REGF_TSHUT_STAT] =3D
+		REG_FIELD(BQ25630_REG_FAULT_STATUS, 3, 3),
+	[BQ25630_REGF_OTG_FAULT_STAT] =3D
+		REG_FIELD(BQ25630_REG_FAULT_STATUS, 4, 4),
+	[BQ25630_REGF_VSYS_FAULT_STAT] =3D
+		REG_FIELD(BQ25630_REG_FAULT_STATUS, 5, 5),
+	[BQ25630_REGF_BAT_FAULT_STAT] =3D
+		REG_FIELD(BQ25630_REG_FAULT_STATUS, 6, 6),
+	[BQ25630_REGF_VBUS_FAULT_STAT] =3D
+		REG_FIELD(BQ25630_REG_FAULT_STATUS, 7, 7),
+};
+
+/* 8-bit value regmap. */
+static const struct regmap_range bq25630_read_reg_range8[] =3D {
+	regmap_reg_range(BQ25630_REG_CHARGE_TIMER_CONTROL,
+			 BQ25630_REG_FAULT_MASK),
+	regmap_reg_range(BQ25630_REG_ADC_CONTROL,
+			 BQ25630_REG_ADC_CHANNEL_DISABLE_1),
+	regmap_reg_range(BQ25630_REG_USB_C_CONTROL_0,
+			 BQ25630_REG_PART_INFORMATION),
+};
+
+static const struct regmap_range bq25630_write_reg_range8[] =3D {
+	regmap_reg_range(BQ25630_REG_CHARGE_TIMER_CONTROL,
+			 BQ25630_REG_NTC_CONTROL_3),
+	regmap_reg_range(BQ25630_REG_CHARGER_MASK_0,
+			 BQ25630_REG_FAULT_MASK),
+	regmap_reg_range(BQ25630_REG_ADC_CONTROL,
+			 BQ25630_REG_ADC_CHANNEL_DISABLE_1),
+	regmap_reg_range(BQ25630_REG_USB_C_CONTROL_0,
+			 BQ25630_REG_LIQUID_CONTROL_1),
+	regmap_reg_range(BQ25630_REG_USB_DAC_CONTROL_0,
+			 BQ25630_REG_USB_DAC_CONTROL_1),
+};
+
+static const struct regmap_access_table bq25630_read_reg_access_table8 =3D=
 {
+	.yes_ranges =3D bq25630_read_reg_range8,
+	.n_yes_ranges =3D ARRAY_SIZE(bq25630_read_reg_range8),
+};
+
+static const struct regmap_access_table bq25630_write_reg_access_table8 =
=3D {
+	.yes_ranges =3D bq25630_write_reg_range8,
+	.n_yes_ranges =3D ARRAY_SIZE(bq25630_write_reg_range8),
+};
+
+static const struct regmap_config bq25630_regmap_config8 =3D {
+	.name =3D BQ25630_DRV_NAME "-8bit",
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.max_register =3D BQ25630_REG_PART_INFORMATION,
+	.rd_table =3D &bq25630_read_reg_access_table8,
+	.wr_table =3D &bq25630_write_reg_access_table8,
+};
+
+/* 16-bit little-endian value regmap. */
+static const struct regmap_range bq25630_read_reg_range16le[] =3D {
+	regmap_reg_range(BQ25630_REG_CHARGE_CURRENT_LIMIT,
+			 BQ25630_REG_TERMINATION_CONTROL),
+	regmap_reg_range(BQ25630_REG_ICO_CURRENT_LIMIT,
+			 BQ25630_REG_ICO_CURRENT_LIMIT),
+};
+
+static const struct regmap_range bq25630_write_reg_range16le[] =3D {
+	regmap_reg_range(BQ25630_REG_CHARGE_CURRENT_LIMIT,
+			 BQ25630_REG_TERMINATION_CONTROL),
+	regmap_reg_range(BQ25630_REG_ICO_CURRENT_LIMIT,
+			 BQ25630_REG_ICO_CURRENT_LIMIT),
+};
+
+static const struct regmap_access_table bq25630_read_reg_access_table16le =
=3D {
+	.yes_ranges =3D bq25630_read_reg_range16le,
+	.n_yes_ranges =3D ARRAY_SIZE(bq25630_read_reg_range16le),
+};
+
+static const struct regmap_access_table bq25630_write_reg_access_table16le=
 =3D {
+	.yes_ranges =3D bq25630_write_reg_range16le,
+	.n_yes_ranges =3D ARRAY_SIZE(bq25630_write_reg_range16le),
+};
+
+static const struct regmap_config bq25630_regmap_config16le =3D {
+	.name =3D BQ25630_DRV_NAME "-16bit-le",
+	.reg_bits =3D 8,
+	.val_bits =3D 16,
+	.reg_stride =3D 2,
+	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
+	/*
+	 * Datasheet doesn't mention that this register is little-endian, but it
+	 * looks like it?
+	 */
+	.max_register =3D BQ25630_REG_TERMINATION_CONTROL,
+	.rd_table =3D &bq25630_read_reg_access_table16le,
+	.wr_table =3D &bq25630_write_reg_access_table16le,
+};
+
+/* 16-bit big-endian value regmap. */
+static const struct regmap_range bq25630_read_reg_range16be[] =3D {
+	regmap_reg_range(BQ25630_REG_IBUS_ADC,
+			 BQ25630_REG_TDIE_ADC),
+};
+
+static const struct regmap_access_table bq25630_read_reg_access_table16be =
=3D {
+	.yes_ranges =3D bq25630_read_reg_range16be,
+	.n_yes_ranges =3D ARRAY_SIZE(bq25630_read_reg_range16be),
+};
+
+static const struct regmap_config bq25630_regmap_config16be =3D {
+	.name =3D BQ25630_DRV_NAME "-16bit-be",
+	.reg_bits =3D 8,
+	.val_bits =3D 16,
+	.reg_stride =3D 2,
+	.val_format_endian =3D REGMAP_ENDIAN_BIG,
+	.max_register =3D BQ25630_REG_TDIE_ADC,
+	.rd_table =3D &bq25630_read_reg_access_table16be,
+	.wr_table =3D NULL,
+};
+
+struct bq25630_data {
+	struct device *dev;
+	struct regmap *regmap8;
+	struct regmap *regmap16le;
+	struct regmap *regmap16be;
+	struct regmap_field *regfields[BQ25630_REGF_MAX];
+
+	struct power_supply *psy;
+	struct power_supply_battery_info *batinfo;
+
+	/* State status from IRQs. */
+	u8 statregs[BQ25630_NR_STAT_REGS];
+};
+
+static int bq25630_alloc_regfield_range(struct bq25630_data *data,
+					const enum bq25630_regfield from,
+					const enum bq25630_regfield to,
+					struct regmap *regmap)
+{
+	int i;
+
+	for (i =3D from; i <=3D to; ++i) {
+		data->regfields[i] =3D devm_regmap_field_alloc(
+			data->dev, regmap, bq25630_regfields[i]);
+		if (IS_ERR(data->regfields[i]))
+			return dev_err_probe(
+				data->dev, PTR_ERR(data->regfields[i]),
+				"Could not allocate register field %d\n", i);
+	}
+
+	return 0;
+}
+
+static irqreturn_t bq25630_irq_thread(int irq, void *dev_id)
+{
+	struct bq25630_data *data =3D dev_id;
+	u8 regbuf[BQ25630_NR_STAT_REGS];
+	int ret;
+
+	BUILD_BUG_ON(ARRAY_SIZE(regbuf) !=3D ARRAY_SIZE(data->statregs));
+
+	ret =3D regmap_bulk_read(data->regmap8, BQ25630_REG_FAULT_STATUS, regbuf,
+			       ARRAY_SIZE(regbuf));
+	if (ret) {
+		dev_err(data->dev, "Could not bulk read IRQ registers (%d)\n",
+			ret);
+		goto out;
+	}
+
+	if (memcmp(data->statregs, regbuf, ARRAY_SIZE(data->statregs))) {
+		power_supply_changed(data->psy);
+		memcpy(data->statregs, regbuf, ARRAY_SIZE(data->statregs));
+	}
+
+out:
+	return IRQ_HANDLED;
+}
+
+static int bq25630_read_limit(struct bq25630_data *data,
+			      const enum bq25630_regfield regfield,
+			      const int minval, const int step,
+			      const int minregval, int *val)
+{
+	int ret;
+	unsigned int regval;
+
+	ret =3D regmap_field_read(data->regfields[regfield], &regval);
+	if (ret) {
+		dev_err(data->dev, "Could not read limit (%d)\n", ret);
+		return ret;
+	}
+
+	*val =3D minval + step * (regval - minregval);
+
+	return 0;
+}
+
+static int bq25630_write_limit(struct bq25630_data *data,
+			       const enum bq25630_regfield regfield,
+			       const int minval, const int maxval,
+			       const int step, const int minregval, int val)
+{
+	int ret;
+	unsigned int regval;
+
+	val =3D clamp(val, minval, maxval);
+	regval =3D minregval + ((val - minval) / step);
+	ret =3D regmap_field_write(data->regfields[regfield], regval);
+	if (ret) {
+		dev_err(data->dev, "Could not write limit (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bq25630_read_charge_type(struct bq25630_data *data, int *val)
+{
+	int ret;
+	unsigned int regval;
+
+	ret =3D regmap_field_read(data->regfields[BQ25630_REGF_CHG_STAT],
+				&regval);
+	if (ret) {
+		dev_err(data->dev, "Could not read charge type (%d)\n", ret);
+		return ret;
+	}
+
+	switch (regval) {
+	case BQ25630_CHG_STAT_NOT_CHARGING:
+		*val =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
+		break;
+	case BQ25630_CHG_STAT_TRICKLE_CHARGE:
+	case BQ25630_CHG_STAT_PRE_CHARGE:
+		*val =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		break;
+	case BQ25630_CHG_STAT_FAST_CHARGE:
+		*val =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
+		break;
+	case BQ25630_CHG_STAT_TAPER_CHARGE:
+		*val =3D POWER_SUPPLY_CHARGE_TYPE_LONGLIFE;
+		break;
+	case BQ25630_CHG_STAT_TERMINATION:
+		*val =3D POWER_SUPPLY_CHARGE_TYPE_BYPASS;
+		break;
+	default:
+		*val =3D POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int bq25630_read_health(struct bq25630_data *data, int *val)
+{
+	int ret;
+	u8 temp;
+	unsigned int regval;
+
+	ret =3D regmap_read(data->regmap8, BQ25630_REG_FAULT_STATUS, &regval);
+	if (ret) {
+		dev_err(data->dev, "Could not read fault status (%d)\n", ret);
+		return ret;
+	}
+
+	temp =3D regval & GENMASK(bq25630_regfields[BQ25630_REGF_TS_STAT].msb,
+				bq25630_regfields[BQ25630_REGF_TS_STAT].lsb);
+	if (regval &
+	    GENMASK(bq25630_regfields[BQ25630_REGF_VBUS_FAULT_STAT].msb,
+		    bq25630_regfields[BQ25630_REGF_VBUS_FAULT_STAT].lsb)) {
+		*val =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+	} else if (regval &
+		   GENMASK(bq25630_regfields[BQ25630_REGF_BAT_FAULT_STAT].msb,
+			   bq25630_regfields[BQ25630_REGF_BAT_FAULT_STAT].lsb)) {
+		/*
+		 * We can't differentiate between dead, under voltage or over
+		 * voltage.
+		 */
+		*val =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+	} else if (regval &
+		   GENMASK(bq25630_regfields[BQ25630_REGF_VSYS_FAULT_STAT].msb,
+			   bq25630_regfields[BQ25630_REGF_VSYS_FAULT_STAT].lsb)) {
+		/*
+		 * We can't differentiate between under voltage or over voltage.
+		 */
+		*val =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+	} else if (regval &
+		   GENMASK(bq25630_regfields[BQ25630_REGF_OTG_FAULT_STAT].msb,
+			   bq25630_regfields[BQ25630_REGF_OTG_FAULT_STAT].lsb)) {
+		/*
+		 * We can't differentiate between under voltage or over voltage.
+		 */
+		*val =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+	} else if (regval &
+		   GENMASK(bq25630_regfields[BQ25630_REGF_TSHUT_STAT].msb,
+			   bq25630_regfields[BQ25630_REGF_TSHUT_STAT].lsb)) {
+		/* Temperature shutdown is always due to hot temperatures. */
+		*val =3D POWER_SUPPLY_HEALTH_HOT;
+	} else if (temp) {
+		switch (temp) {
+		case BQ25630_TS_STAT_COLD:
+			*val =3D POWER_SUPPLY_HEALTH_COLD;
+			break;
+		case BQ25630_TS_STAT_COOL:
+			*val =3D POWER_SUPPLY_HEALTH_COOL;
+			break;
+		case BQ25630_TS_STAT_WARM:
+			*val =3D POWER_SUPPLY_HEALTH_WARM;
+			break;
+		case BQ25630_TS_STAT_HOT:
+			*val =3D POWER_SUPPLY_HEALTH_HOT;
+			break;
+		default:
+			/* Interpret PRECOOL and PREWARM as NORMAL. */
+			*val =3D POWER_SUPPLY_HEALTH_GOOD;
+		}
+	} else {
+		*val =3D POWER_SUPPLY_HEALTH_GOOD;
+	}
+
+	return 0;
+}
+
+static int bq25630_read_vbus(struct bq25630_data *data, int *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_field_read(data->regfields[BQ25630_REGF_VBUS_STAT],
+				&regval);
+	if (ret) {
+		dev_err(data->dev, "Could not read VBUS (%d)\n", ret);
+		return ret;
+	}
+
+	switch (regval) {
+	case BQ25630_VBUS_STAT_NONE:
+		*val =3D -1;
+		break;
+	case BQ25630_VBUS_STAT_SDP:
+		*val =3D POWER_SUPPLY_USB_TYPE_SDP;
+		break;
+	case BQ25630_VBUS_STAT_CDP:
+		*val =3D POWER_SUPPLY_USB_TYPE_CDP;
+		break;
+	case BQ25630_VBUS_STAT_DCP:
+	case BQ25630_VBUS_STAT_HVDCP:
+		*val =3D POWER_SUPPLY_USB_TYPE_DCP;
+		break;
+	case BQ25630_VBUS_STAT_USB_C_DEFAULT:
+	case BQ25630_VBUS_STAT_USB_C_MEDIUM:
+	case BQ25630_VBUS_STAT_USB_C_HIGH:
+		*val =3D POWER_SUPPLY_USB_TYPE_C;
+		break;
+	default:
+		*val =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int bq25630_get_status(struct bq25630_data *data, int *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_field_read(data->regfields[BQ25630_REGF_PG_STAT], &regval);
+	if (ret) {
+		dev_err(data->dev, "Could not read PG status (%d)", ret);
+		return ret;
+	}
+
+	if (!regval) {
+		/* There is not enough power, battery must be discharging. */
+		*val =3D POWER_SUPPLY_STATUS_DISCHARGING;
+		return 0;
+	}
+
+	ret =3D regmap_field_read(data->regfields[BQ25630_REGF_EN_CHG], &regval);
+	if (ret) {
+		dev_err(data->dev, "Could not read charge status (%d)", ret);
+		return ret;
+	}
+
+	if (!regval) {
+		/* Charging is not enabled, battery must be discharging. */
+		*val =3D POWER_SUPPLY_STATUS_DISCHARGING;
+		return 0;
+	}
+
+	ret =3D bq25630_read_charge_type(data, val);
+	if (ret)
+		return ret;
+
+	switch (*val) {
+	case POWER_SUPPLY_CHARGE_TYPE_NONE:
+		*val =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case POWER_SUPPLY_CHARGE_TYPE_BYPASS:
+		/* Corresponds to BQ25630_CHG_STAT_TERMINATION. */
+		*val =3D POWER_SUPPLY_STATUS_FULL;
+		break;
+	default:
+		*val =3D POWER_SUPPLY_STATUS_CHARGING;
+	}
+
+	return 0;
+}
+
+static int bq25630_reset(struct bq25630_data *data)
+{
+	unsigned int regval =3D 1;
+	int ret;
+
+	ret =3D regmap_field_force_write(data->regfields[BQ25630_REGF_REG_RST],
+				       regval);
+	if (ret) {
+		dev_err(data->dev,
+			"Could not force write reset register field (%d)\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * After a successful register reset, the device signals by resetting
+	 * this register field to 0. Try reading it for some interrupt cycles.
+	 */
+	ret =3D regmap_field_read_poll_timeout(
+		data->regfields[BQ25630_REGF_REG_RST], regval, regval =3D=3D 0, 256,
+		100000);
+	if (ret) {
+		dev_err(data->dev, "Could not read reset register field (%d)\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bq25630_setup(struct bq25630_data *data)
+{
+	int ret;
+
+	ret =3D bq25630_reset(data);
+	if (ret) {
+		dev_err(data->dev, "Could not reset device (%d)\n", ret);
+		return ret;
+	}
+
+	/* Disable the watchdog. */
+	ret =3D regmap_field_write(data->regfields[BQ25630_REGF_WATCHDOG], 0);
+	if (ret) {
+		dev_err(data->dev, "Could not write watchdog timer (%d)\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * Set values according to battery info. Warn on missing "dangerous"
+	 * properties.
+	 */
+	if (data->batinfo->voltage_min_design_uv >=3D 0) {
+		ret =3D bq25630_write_limit(data, BQ25630_REGF_VSYSMIN,
+					  BQ25630_VSYSMIN_MIN,
+					  BQ25630_VSYSMIN_MAX,
+					  BQ25630_VSYSMIN_STEP,
+					  BQ25630_VSYSMIN_MIN_REGVAL,
+					  data->batinfo->voltage_min_design_uv);
+		if (ret)
+			return ret;
+	} else
+		dev_warn(data->dev,
+			 "Using default value for minimum voltage\n");
+
+	if (data->batinfo->constant_charge_voltage_max_uv >=3D 0) {
+		ret =3D bq25630_write_limit(
+			data, BQ25630_REGF_VREG, BQ25630_VREG_MIN,
+			BQ25630_VREG_MAX, BQ25630_VREG_STEP,
+			BQ25630_VREG_MIN_REGVAL,
+			data->batinfo->constant_charge_voltage_max_uv);
+		if (ret)
+			return ret;
+	} else
+		dev_warn(data->dev,
+			 "Using default value for maximum constant charge voltage\n");
+
+	if (data->batinfo->constant_charge_current_max_ua >=3D 0) {
+		ret =3D bq25630_write_limit(
+			data, BQ25630_REGF_ICHG, BQ25630_ICHG_MIN,
+			BQ25630_ICHG_MAX, BQ25630_ICHG_STEP,
+			BQ25630_ICHG_MIN_REGVAL,
+			data->batinfo->constant_charge_current_max_ua);
+		if (ret)
+			return ret;
+	} else
+		dev_warn(data->dev,
+			 "Using default value for maximum constant charge current\n");
+
+	if (data->batinfo->charge_term_current_ua >=3D 0) {
+		ret =3D bq25630_write_limit(
+			data, BQ25630_REGF_ITERM, BQ25630_ITERM_MIN,
+			BQ25630_ITERM_MAX, BQ25630_ITERM_STEP,
+			BQ25630_ITERM_MIN_REGVAL,
+			data->batinfo->charge_term_current_ua);
+		if (ret)
+			return ret;
+	}
+
+	if (data->batinfo->precharge_current_ua >=3D 0) {
+		ret =3D bq25630_write_limit(data, BQ25630_REGF_IPRECHG,
+					  BQ25630_IPRECHG_MIN,
+					  BQ25630_IPRECHG_MAX,
+					  BQ25630_IPRECHG_STEP,
+					  BQ25630_IPRECHG_MIN_REGVAL,
+					  data->batinfo->precharge_current_ua);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int bq25630_charger_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct bq25630_data *data =3D power_supply_get_drvdata(psy);
+	int ret =3D 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret =3D bq25630_get_status(data, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+	case POWER_SUPPLY_PROP_CHARGE_TYPES:
+		ret =3D bq25630_read_charge_type(data, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret =3D bq25630_read_health(data, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret =3D regmap_field_read(data->regfields[BQ25630_REGF_EN_CHG],
+					&val->intval);
+		if (ret || !val->intval) {
+			/* Charging is not even enabled. */
+			break;
+		}
+
+		ret =3D bq25630_read_vbus(data, &val->intval);
+		val->intval =3D val->intval >=3D 0;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		ret =3D bq25630_read_limit(data, BQ25630_REGF_VSYSMIN,
+					 BQ25630_VSYSMIN_MIN,
+					 BQ25630_VSYSMIN_STEP,
+					 BQ25630_VSYSMIN_MIN_REGVAL,
+					 &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		ret =3D bq25630_read_limit(data, BQ25630_REGF_ICHG,
+					 BQ25630_ICHG_MIN, BQ25630_ICHG_STEP,
+					 BQ25630_ICHG_MIN_REGVAL, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		val->intval =3D BQ25630_ICHG_MAX;
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret =3D bq25630_read_limit(data, BQ25630_REGF_VREG,
+					 BQ25630_VREG_MIN, BQ25630_VREG_STEP,
+					 BQ25630_VREG_MIN_REGVAL, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		val->intval =3D BQ25630_VREG_MAX;
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret =3D bq25630_read_limit(data, BQ25630_REGF_IINDPM,
+					 BQ25630_IINDPM_MIN,
+					 BQ25630_IINDPM_STEP,
+					 BQ25630_IINDPM_MIN_REGVAL,
+					 &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+		ret =3D bq25630_read_limit(data, BQ25630_REGF_VINDPM,
+					 BQ25630_VINDPM_MIN,
+					 BQ25630_VINDPM_STEP,
+					 BQ25630_VINDPM_MIN_REGVAL,
+					 &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		ret =3D bq25630_read_vbus(data, &val->intval);
+		if (!ret && val->intval < 0) {
+			/* Nothing connected. */
+			val->intval =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
+		}
+		break;
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		ret =3D bq25630_read_limit(data, BQ25630_REGF_IPRECHG,
+					 BQ25630_IPRECHG_MIN,
+					 BQ25630_IPRECHG_STEP,
+					 BQ25630_IPRECHG_MIN_REGVAL,
+					 &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		ret =3D bq25630_read_limit(data, BQ25630_REGF_ITERM,
+					 BQ25630_ITERM_MIN, BQ25630_ITERM_STEP,
+					 BQ25630_ITERM_MIN_REGVAL,
+					 &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval =3D "BQ25630";
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval =3D "Texas Instruments";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int bq25630_charger_set_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					const union power_supply_propval *val)
+{
+	struct bq25630_data *data =3D power_supply_get_drvdata(psy);
+	int ret =3D 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret =3D regmap_field_write(data->regfields[BQ25630_REGF_EN_CHG],
+					 !!val->intval);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		ret =3D bq25630_write_limit(
+			data, BQ25630_REGF_VSYSMIN, BQ25630_VSYSMIN_MIN,
+			BQ25630_VSYSMIN_MAX, BQ25630_VSYSMIN_STEP,
+			BQ25630_VSYSMIN_MIN_REGVAL, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		ret =3D bq25630_write_limit(data, BQ25630_REGF_ICHG,
+					  BQ25630_ICHG_MIN, BQ25630_ICHG_MAX,
+					  BQ25630_ICHG_STEP,
+					  BQ25630_ICHG_MIN_REGVAL, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret =3D bq25630_write_limit(data, BQ25630_REGF_VREG,
+					  BQ25630_VREG_MIN, BQ25630_VREG_MAX,
+					  BQ25630_VREG_STEP,
+					  BQ25630_VREG_MIN_REGVAL, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret =3D bq25630_write_limit(
+			data, BQ25630_REGF_IINDPM, BQ25630_IINDPM_MIN,
+			BQ25630_IINDPM_MAX, BQ25630_IINDPM_STEP,
+			BQ25630_IINDPM_MIN_REGVAL, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+		ret =3D bq25630_write_limit(
+			data, BQ25630_REGF_VINDPM, BQ25630_VINDPM_MIN,
+			BQ25630_VINDPM_MAX, BQ25630_VINDPM_STEP,
+			BQ25630_VINDPM_MIN_REGVAL, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		ret =3D bq25630_write_limit(
+			data, BQ25630_REGF_IPRECHG, BQ25630_IPRECHG_MIN,
+			BQ25630_IPRECHG_MAX, BQ25630_IPRECHG_STEP,
+			BQ25630_IPRECHG_MIN_REGVAL, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		ret =3D bq25630_write_limit(data, BQ25630_REGF_ITERM,
+					  BQ25630_ITERM_MIN, BQ25630_ITERM_MAX,
+					  BQ25630_ITERM_STEP,
+					  BQ25630_ITERM_MIN_REGVAL,
+					  val->intval);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int bq25630_charger_property_is_writeable(struct power_supply *psy,
+						 enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const enum power_supply_property bq25630_charger_properties[] =3D {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_CHARGE_TYPES,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static const struct power_supply_desc bq25630_charger_psy_desc =3D {
+	.name =3D BQ25630_DRV_NAME,
+	.type =3D POWER_SUPPLY_TYPE_USB_TYPE_C,
+	.charge_types =3D BIT(POWER_SUPPLY_CHARGE_TYPE_NONE) |
+			BIT(POWER_SUPPLY_CHARGE_TYPE_TRICKLE) |
+			BIT(POWER_SUPPLY_CHARGE_TYPE_FAST) |
+			BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE) |
+			BIT(POWER_SUPPLY_CHARGE_TYPE_BYPASS) |
+			BIT(POWER_SUPPLY_CHARGE_TYPE_UNKNOWN),
+	.usb_types =3D BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN) |
+		     BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_C),
+	.properties =3D bq25630_charger_properties,
+	.num_properties =3D ARRAY_SIZE(bq25630_charger_properties),
+	.get_property =3D bq25630_charger_get_property,
+	.set_property =3D bq25630_charger_set_property,
+	.property_is_writeable =3D bq25630_charger_property_is_writeable,
+};
+
+static int bq25630_probe(struct i2c_client *client)
+{
+	struct power_supply_config psy_cfg =3D {};
+	struct bq25630_data *data;
+	int ret;
+
+	data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev =3D &client->dev;
+
+	data->regmap8 =3D devm_regmap_init_i2c(client, &bq25630_regmap_config8);
+	if (IS_ERR(data->regmap8))
+		return dev_err_probe(data->dev, PTR_ERR(data->regmap8),
+				     "Could not initialize regmap8\n");
+
+	ret =3D bq25630_alloc_regfield_range(data, BQ25630_REGF_WATCHDOG,
+					   BQ25630_REGF_TS_STAT,
+					   data->regmap8);
+	if (ret)
+		return ret;
+
+	data->regmap16le =3D
+		devm_regmap_init_i2c(client, &bq25630_regmap_config16le);
+	if (IS_ERR(data->regmap16le))
+		return dev_err_probe(data->dev, PTR_ERR(data->regmap16le),
+				     "Could not initialize regmap16le\n");
+
+	ret =3D bq25630_alloc_regfield_range(data, BQ25630_REGF_ICHG,
+					   BQ25630_REGF_ITERM,
+					   data->regmap16le);
+	if (ret)
+		return ret;
+
+	data->regmap16be =3D
+		devm_regmap_init_i2c(client, &bq25630_regmap_config16be);
+	if (IS_ERR(data->regmap16le))
+		return dev_err_probe(data->dev, PTR_ERR(data->regmap16le),
+				     "Could not initialize regmap16be\n");
+
+	ret =3D bq25630_alloc_regfield_range(data, BQ25630_REGF_IBUS_ADC,
+					   BQ25630_REGF_VBUS_ADC,
+					   data->regmap16be);
+	if (ret)
+		return ret;
+
+	psy_cfg.drv_data =3D data;
+	psy_cfg.fwnode =3D dev_fwnode(data->dev);
+	data->psy =3D devm_power_supply_register(
+		data->dev, &bq25630_charger_psy_desc, &psy_cfg);
+	if (IS_ERR(data->psy))
+		return dev_err_probe(data->dev, PTR_ERR(data->psy),
+			      "Could not register power supply\n");
+
+	ret =3D power_supply_get_battery_info(data->psy, &data->batinfo);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Could not get battery info\n");
+
+	/*
+	 * Device sends active low 256 =C2=B5s pulse to report status and fault.
+	 *
+	 * Note that we need to request this *after* registering the power
+	 * supply so devm destructs it correctly in the reverse order. Otherwise
+	 * spurious interrupts could call power_supply_changed() wrongly with a
+	 * uninitialized/deallocated power supply.
+	 */
+	ret =3D devm_request_threaded_irq(data->dev, client->irq, NULL,
+					bq25630_irq_thread,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					NULL, data);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
+
+	ret =3D bq25630_setup(data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id bq25630_of_match[] =3D {
+	{
+		.compatible =3D "ti,bq25630",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, bq25630_of_match);
+
+static struct i2c_driver bq25630_driver =3D {
+	.driver =3D {
+		.name =3D BQ25630_DRV_NAME,
+		.of_match_table =3D bq25630_of_match,
+	},
+	.probe =3D bq25630_probe,
+};
+module_i2c_driver(bq25630_driver);
+
+MODULE_AUTHOR("Waqar Hameed <waqar.hameed@axis.com>");
+MODULE_DESCRIPTION("TI BQ25630 charger driver");
+MODULE_LICENSE("GPL");
--=20
2.39.5


