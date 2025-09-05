Return-Path: <linux-pm+bounces-33932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAFBB451E5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 10:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B59B60383
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 08:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22A9301492;
	Fri,  5 Sep 2025 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Luz9DPjO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AAF2C0F6C;
	Fri,  5 Sep 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061751; cv=fail; b=B0pmyNNQy3DaWC7KwQC7ApNNpbQ1owOa4+1xGZPgKZQdhTs4n6cGPho2UIVk8HqswCG3erDKJ4Egb1+g1m/xRvzHr9utyCGMwl7yPP4h9oP5w2rtj3A1vqId7axWvXY1VLMsn8oez0ln4gDbOuRuxVC8oCkOykuyBceIPaODPE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061751; c=relaxed/simple;
	bh=fAjM/eoF9g8QGhaCy0iT3tNJjI8I2ZoRdMqiAkWx9e0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTrIx+kjX9WBxZZNA/N0pXMHN9cHtaqP5nc6KvjiE6bV0XaDnYzRsv1xlxOhk0nIrUX5OJxp61LLQ4NgWp00nfN/X9AFIf0Y5pm7HCvdLEHyIFNcUWuq9EA01/iBTswCyP7W3pW01MFXcd0HfzPPngMeJrQ15TGAitItDntahnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Luz9DPjO; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tR44nfg+3Io2ftoDNvqdU2x2WzfTpGHP05Vf6jxMnalIEptQzME5nyDAJ1vT76TTnzNDkiRb5loI6RhOqll9odHOSbZmBIVglQ3JTyZugSzhejrO7racmFLNI9F6fs6OwnnvAPyavye0Lwmkz+wqgU/mf6jYSxx/tpt9kgssO+GTqdwrYb9dLNBbmfMk1H5YWbzraYjhNYIXeq4MeWdqyJTo3lHZkiW5HuJEiDmSBcw8YZK3sQAYG6L+2tOXS1jBtF5dW0V9+MJr4l2rs4qkuCJTz5FxhJuGEPv1OPsKa9yBScyTFfPAvPZA6+g7mQbx+evTMy0xCIO/nA0st1KSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zEYK+kcDE3L26umQEkB02w4YFCKNZZ6my1jjC4udyU=;
 b=DKlm1PUT8sn5SCK4mS3eAciTdxDizveI2cCDjfvKLK+L/wpoCnU34CbTsOB05zq9VBVRAqgVw4UjheBknBX7WhH+V9mI1SRxFPYuOyc2QeD9M6I4zi5W7Vp9Db9AHpv+nJISPAmwJEShsQeJkBU4ilndTPjxpd+M3lBaDLeXn3iM/FAwqpNrVdakNfWd/ag9o/TLb/VapG28iOKfX7EfJu09oCoAHfGF+PHR1IMjka92Vke1NZZ6B+x94+slgdWSdKiInj9rW/ZdUkp8ey/viohVcGwvJ4C8da6AH853x0ZzHj9l83O4cXFNFJH8QYYHE065RtO4UP/a4Lwwh7340Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zEYK+kcDE3L26umQEkB02w4YFCKNZZ6my1jjC4udyU=;
 b=Luz9DPjO76r6XOVBWNZV8ooLysGausxTVBoIebFt89FyoA11npuEL8ZWnIM7uMtjcv2gdwEiMtoZEAdeTR2iJjudU0AjF/iOhr0avP5uF/EMlvbqwB5ReZ0g+mozTrxAxZLYjQyVHrLOV2O6wNs++jvdrwt5cgSvxMfwBJ+PIMs=
Received: from SJ0PR13CA0055.namprd13.prod.outlook.com (2603:10b6:a03:2c2::30)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 08:42:26 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::9b) by SJ0PR13CA0055.outlook.office365.com
 (2603:10b6:a03:2c2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.7 via Frontend Transport; Fri, 5
 Sep 2025 08:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 08:42:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 03:42:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 03:42:14 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 5 Sep 2025 03:42:14 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Salih Erim <salih.erim@amd.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, "open
 list:THERMAL" <linux-pm@vger.kernel.org>
Subject: [PATCH 5/6] thermal: versal-thermal: Add Versal thermal driver
Date: Fri, 5 Sep 2025 10:41:48 +0200
Message-ID: <ee77ab3014c367243a553dd4e814378804aaeb6e.1757061697.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757061697.git.michal.simek@amd.com>
References: <cover.1757061697.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5737; i=michal.simek@amd.com; h=from:subject:message-id; bh=7pWFcwQrQwuIrNzh9CkamMKwqRzSh+KygLRRyHiQQB4=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTsWuT/5dMvE616Znl9vkkfbjafWh55z9bnw9GNSz/Ur JmnG1h7uKOUhUGMg0FWTJFlOpOOw5pv15aKLY/Mh5nDygQyhIGLUwAmwizO8D/wcTuLPO9p4Sx/ B5EpWzXkBY32S0194PrCW6lu9dJmzhUMf8UUFS391t6Z42B+/fuKeVuzBQISDd6qt0ouq73dlNR 9lg0A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: ced523ec-91ff-4d3d-4b2b-08ddec582408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z1K3tkcKzGxQtSMPJSqmgwryrP3mLc1UufKPp2KGz/5zCI0oPArsjmI4UE5H?=
 =?us-ascii?Q?FCunhosVVhQPaSZmdMhC48c4VXt5VYOpYEf4qy9NNDwfxfG3QlStxGaBgE7J?=
 =?us-ascii?Q?FKKQhgsfs7S+SqjkI2jhKPFwF9Ir8S/7hf1npWmi/jrTqC1+CHURLqq2Eo++?=
 =?us-ascii?Q?74b+LW2q15XsVaUUjueRzmAg/sTieXS8IyFg7LeUxNo4Eda8DLy90ACY7xU4?=
 =?us-ascii?Q?BJg2WqEzZctwBe0ldejkviS4ruM/jYa6THrW6bw1CM5azhblJMaT7R60p4i6?=
 =?us-ascii?Q?KlAZLO82A/OjENh80KbjfPUcevpynvKskuMHfcUgwu+dg8L5eelLJ5F9KO92?=
 =?us-ascii?Q?N670c8bcK4vEOLYjd/H65ptLN/9MBEJMk+isGL94OP/o9t6x/3loH55LpOFs?=
 =?us-ascii?Q?hDtXEYAcoRuT4h3T7wBIvkzRSrw6AofC+1W0zKv4AQehezrpNUMSskHv7NJq?=
 =?us-ascii?Q?RemL4Csvv8awBfUeThAQYX61szKh2BC+ewXXhGAWLRRT5PJV6n9hZuXTvSMP?=
 =?us-ascii?Q?rAY70gaU/E/sp9nUGdiwN3Ekwt0M38cQxt5TuSOXBqMcyHDH2itIImNtVYFX?=
 =?us-ascii?Q?dLO9RrkKgF9PKIj+mFqquZ+zOlCbwM3eKwfyGR+KB2vMDf4bewHQZb85BzNi?=
 =?us-ascii?Q?hGYyZvM32jJS2gvaL2e4Kx533EzDkzWqywksDdI5lsewG7SEPnx1ECbk1Lk9?=
 =?us-ascii?Q?LxXPO2Aif4IZhrB8A3au2kohMvsFSjZO6+9qjQiyC6+7PK545ixqy2mrkI8M?=
 =?us-ascii?Q?QDlcXsywJ4okVRI5BdiOxudn6Cr8AgMqBhu3MA2D/noYy1PJ0mWiGJGevsl4?=
 =?us-ascii?Q?mDFsfrxKkZMvRVXUf51IxaLFdvYq1T3wb0DE3NKZg1a/tkcSoGZxmZByHyJL?=
 =?us-ascii?Q?lHR1zJozo9P9JwyFzTFMtoHrtjFf/8PyT94cko1EGTviy1TyV4y/pBaSkQc1?=
 =?us-ascii?Q?BBNBWjDo1wNAPV5ZXUPrksN+RosOE780wC14PPQO/rL4Xq1GcZq8c02XrSXM?=
 =?us-ascii?Q?HttvEzZ9cLlvruiK+VMB6xOLR+2+vDEFAnbqvPYiJR46LHjQQpjl5MsWqcsK?=
 =?us-ascii?Q?Dpi++pys1K5eJ4gJRORlnkzdM7UNnB9nllV67Q7oEOJc2jvhDbqw2rRgeKss?=
 =?us-ascii?Q?BOTCwy61mBKJjpPWgTAc5jpTP3Iw1L8t4ncWf+7BGsyuFgWbSdR4gyWCFbP/?=
 =?us-ascii?Q?FhSYESE0eHLC1377Z6iHij/SsLserMZOu2IhyuxBw48Rf0Y3LfZOM5MYC4v7?=
 =?us-ascii?Q?1QIuR2lq/FbZJ6BlZNrEKwKRPX72zg7OzG81W15r4CN0mwdlNxgCO4zTcwbO?=
 =?us-ascii?Q?Foae1gfuqVBYjuRLshjIAxIo0EFU6uSHqOQoSSd2Nxt3ru0cVN9sT0mlevTB?=
 =?us-ascii?Q?Qdft2j6DrX02E/XnqPs2JbCHwifjqblqvTldvcna2F5dHvjMJGOKa3bBZJNQ?=
 =?us-ascii?Q?CvAr56jQDJ62FkiSc3NXtrzZYfm9twbHf5W3iknuyms+gqESf/vtIramj3yF?=
 =?us-ascii?Q?LDJPeELvkP65HXXUysCZNP5yiHww3TaUCOIe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 08:42:26.0931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ced523ec-91ff-4d3d-4b2b-08ddec582408
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562

From: Salih Erim <salih.erim@amd.com>

This patch adds the Versal thermal driver based
on Versal Sysmon as thermal infrastructure sensor.

Sysmon devices use IIO framework to expose temperature
information to system.
This driver connects to the sysmon temp channel by iio
binding mapping defined on the sysmon driver.

This is initial work for defining thermal sensor driver and
thermal infrastructure for Versal devices. Single thermal zone
has to be defined and no cooling devices and maps are supported
at this point.

Sysmon devices default temperature event thresholds can be used as
temperature ranges.

Updates the maintainer file accordingly to this driver.

Signed-off-by: Salih Erim <salih.erim@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 MAINTAINERS                      |  6 +++
 drivers/thermal/Kconfig          | 12 +++++
 drivers/thermal/Makefile         |  1 +
 drivers/thermal/versal_thermal.c | 87 ++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 drivers/thermal/versal_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a9c5549d0dc..907a6c193fb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27609,6 +27609,12 @@ F:	Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 F:	drivers/iio/adc/versal-sysmon*
 F:	include/linux/iio/adc/versal-sysmon-events.h
 
+XILINX VERSAL THERMAL DRIVER
+M:	Salih Erim <salih.erim@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
+F:	drivers/thermal/versal_thermal.c
+
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	linux-serial@vger.kernel.org
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index a09c188b9ad1..9695ecec8f04 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -517,4 +517,16 @@ config LOONGSON2_THERMAL
 	  is higher than the high temperature threshold or lower than the low
 	  temperature threshold, the interrupt will occur.
 
+config VERSAL_THERMAL
+	tristate "Versal thermal sensor driver"
+	depends on OF
+	depends on VERSAL_SYSMON
+	help
+	  This adds support for Versal thermal driver as thermal zone sensor
+	  The thermal driver is connected to Versal Sysmon for the temperature
+	  channel via iio binding. The Sysmon channel is read via IIO framework
+	  and the channel information is provided to driver.
+	  The driver can also be build as a module. If so, the module will be called
+	  versal_thermal
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index d7718978db24..407c84aa2691 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -68,3 +68,4 @@ obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
 obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
 obj-$(CONFIG_THERMAL_CORE_TESTING)	+= testing/
+obj-$(CONFIG_VERSAL_THERMAL)	+= versal_thermal.o
diff --git a/drivers/thermal/versal_thermal.c b/drivers/thermal/versal_thermal.c
new file mode 100644
index 000000000000..51c8586af5a4
--- /dev/null
+++ b/drivers/thermal/versal_thermal.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Versal Thermal Driver for Versal Devices
+ *
+ * Copyright (C) 2024 - 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/iio/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#include "thermal_hwmon.h"
+
+#define SYSMON_TEMP_CH_NAME "sysmon-temp-channel"
+#define SYSMON_FRACTIONAL_DENOM		128
+
+struct versal_thermal_info {
+	struct device *dev;
+	struct thermal_zone_device *tzd;
+	struct iio_channel *channel;
+};
+
+static int temperature_sensor_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct versal_thermal_info *vti = thermal_zone_device_priv(tz);
+	int ret, val;
+
+	ret = iio_read_channel_processed(vti->channel, &val);
+	if (ret == IIO_VAL_FRACTIONAL) {
+		/* Convert raw value to temperature in millidegrees Celsius */
+		*temp = val * 1000;
+		*temp /= SYSMON_FRACTIONAL_DENOM;
+	} else if (ret == IIO_VAL_INT) {
+		*temp = val;
+	} else {
+		dev_err(vti->dev, "iio_read_channel_processed failed, ret code = %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static const struct thermal_zone_device_ops thermal_zone_ops = {
+	.get_temp = temperature_sensor_get_temp,
+};
+
+static int versal_thermal_probe(struct platform_device *pdev)
+{
+	struct versal_thermal_info *vti;
+
+	vti = devm_kzalloc(&pdev->dev, sizeof(struct versal_thermal_info), GFP_KERNEL);
+	if (!vti)
+		return -ENOMEM;
+
+	vti->channel = devm_iio_channel_get(&pdev->dev, SYSMON_TEMP_CH_NAME);
+	if (IS_ERR(vti->channel))
+		return dev_err_probe(&pdev->dev, PTR_ERR(vti->channel),
+				     "IIO channel not found\n");
+
+	vti->dev = &pdev->dev;
+
+	vti->tzd = devm_thermal_of_zone_register(&pdev->dev, 0, vti, &thermal_zone_ops);
+	if (IS_ERR(vti->tzd))
+		return dev_err_probe(&pdev->dev, PTR_ERR(vti->tzd),
+				     "Thermal zone sensor register failed\n");
+
+	return devm_thermal_add_hwmon_sysfs(&pdev->dev, vti->tzd);
+}
+
+static const struct of_device_id versal_thermal_of_match[] = {
+	{ .compatible = "xlnx,versal-thermal", },
+	{ /* end of list */ },
+};
+MODULE_DEVICE_TABLE(of, versal_thermal_of_match);
+
+static struct platform_driver versal_thermal_driver = {
+	.driver = {
+		.name = "versal-thermal",
+		.of_match_table = versal_thermal_of_match,
+	},
+	.probe = versal_thermal_probe,
+};
+
+module_platform_driver(versal_thermal_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("XILINX Versal Thermal Driver");
+MODULE_AUTHOR("Advanced Micro Devices, Inc");
-- 
2.43.0


