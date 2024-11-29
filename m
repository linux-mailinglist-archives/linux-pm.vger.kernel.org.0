Return-Path: <linux-pm+bounces-18235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 694E59DC305
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 12:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71B7B21A58
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 11:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED2319ABD8;
	Fri, 29 Nov 2024 11:43:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021095.outbound.protection.outlook.com [40.107.57.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01FA19ABA3;
	Fri, 29 Nov 2024 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.57.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732880598; cv=fail; b=gd//Y/wKVKg9Tno1N5+gmkpZge1v2zdNh938e/JwA1iGn9AKM5m5+rliCLzHgnnfLGjEfMhjx+bUlSSpyb6pTQc02yFYsZ271vQoYSfzPLKkLblS9xbZe+4W+aMe7NjnlBLlvscgzC51OBbFviirlUI6QmmXCgPKyOeDY76aorw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732880598; c=relaxed/simple;
	bh=04mZzVFSqGcLveK0OM0Hngjt74sCh86V9x/EcmCuQYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CkEySIKgMy+hbku1fqHHs9qJ9jiwjGJw2PRDt8+I9Qlmw+S11KFm68QdQ1CZJEgd6vHXHVnr7HvJ6Hmx3cnN4FqFfXB3qH/vGP2DZeTolkqY2/48uypACGJHq/jj8+eyGzqspzI9hZTGjhoKv5x5EiTbnshNMsLYHV2OsGw7w6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.57.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BV+e+vw89AD/xbKXDMPMU9rq7ARi3BpzJ6wS1dV5mJCYO3oilmwcjAV0PzUNFnb/eg8hc1VBp/MHa8w9yvJNqxjWHvDJhydHZfaRBSo5Fk8OeK/1ALNcXJkpEgMEIh6C/qSjxrNk9gOkulZZ5KfvEPKpMD8XuLPIwV1ChigYZlv1WxuhQg7oHK7IBpQ6NsNAo2hackqvaWazlsf+EWzZqFJPZPAeduV6SjAhsqxs2ozQK4Q6H3fFHvDWL6lTAAvXq8Caf61IgWIgL+6YpO+O2IonPHe4YVQ2xoxthTvfU3uBUKkAvVPIkuhIFjT+V1xx4lxZC2qmmJ6ZRpcPovPJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3QIHRwATYd6NaxRsKTguI1GNodt8KvJlgFnK1hVfIg=;
 b=PDr2EuPJbf7da4dTfzMexUgdf2VlgyTumBpl5sa8hMZv27eRBJN5ahLiEWP/H0d9httBwacRaaoBz+VDIDmdmOoRSd7uoq5XozAJMjYxaUS04Q5CjsDsp04tyYq+1vBJjfOZHdDr5AiCv8KapTYFYbbYk8AanbcyYz8r2BexTMfY2f55bTkugF50/SMl9sp8CgyQNS6JVajYnefZJZ89/ddSWBzjCsSkOBVkvJwiYJBZQNG//nKU6Cz3qmfSrCeBS4A8yt1fWBn2jUtbUx43bArJ1qVIoVVL8lDNf2m4H30L9c/fmy0ob2Ug7dqbySLhwH43IFW4LGc8dpI0G6gRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::7) by
 PN3P287MB1729.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:19c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.14; Fri, 29 Nov 2024 11:43:11 +0000
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2]) by MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 11:43:11 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org,
	krzk+dt@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] power: supply: Add STC3117 fuel gauge unit driver
Date: Fri, 29 Nov 2024 17:10:46 +0530
Message-ID: <20241129114200.13351-3-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241129114200.13351-1-bhavin.sharma@siliconsignals.io>
References: <20241129114200.13351-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::31) To MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:fc::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB1178:EE_|PN3P287MB1729:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac6dd1f-fad8-4cdf-e9c2-08dd106b0040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SA1o344pOavlYLC5UzbhUf84L85zXtpSqx2hcFXNLRw4KqUdjbLmFwnGSfPo?=
 =?us-ascii?Q?uuy2Tb9GerepYdgOModutyggOY8u+fwjH/YGYu3418m0ZJNsZPAPc8wz17T2?=
 =?us-ascii?Q?inb/EchKJR+3a1gQbBcQaFkly0fXFWbDdhQilS1gPuIWX+LHiCLTXaRpJwFW?=
 =?us-ascii?Q?kszAHqsWBTsXgez+BxnFnhull2/7JejhZ+YbPBmyegoXQqHHfpakC8K1Ps9L?=
 =?us-ascii?Q?LcfJrryFdayUmvbM6J+AYlD6oThdQ94pA1tEUSEXLmsnOca6D5+Ybbyqj/Mf?=
 =?us-ascii?Q?ne+7Jghrh1oTcablvVuUoRB90sHrC7im/QasLn6vlQj6as2nAWqXPcguoTEH?=
 =?us-ascii?Q?b99zSbDnbGZHugODAfWy/miQZT3EIIZAmdPbOH1Hli0RvIoRk1cSXaMxW3yO?=
 =?us-ascii?Q?9BUp1HciKv44PBJepRrH4INU/I+iyDe2UUwBOaVnQ2N/S9V1rVWC4E5gqT+9?=
 =?us-ascii?Q?Ms4XABWaHWFK9ypZvLMbsFhw8WnMC7SRhVGB1hxYTiIGnVV2tYXx6SN7mnGH?=
 =?us-ascii?Q?ycejjlUUQqWa/PkTFRsQ+tQJehhOzuvW3Y4vGA+Qfsqz6jCiY9VCXeMHCXGF?=
 =?us-ascii?Q?HnWMCuYqIvAry8T5lajVydVBm8G/aJTaw/QbGoXpmPL+qKPEVJrjFTgEQQ4d?=
 =?us-ascii?Q?TdjJyqFTiyJKzQKB0i0VwMrh3TF/iTPKDz8ZoIlu+HEhk7y/tVx78+kSL1Tu?=
 =?us-ascii?Q?vYWcezzWA0zcmVqKv7kj8b0cGjJP9Ah/Kik+BPduh5uaYrxzDdFyW+8J9VOO?=
 =?us-ascii?Q?3VfRQjmdqn2gGuleVo7HQ+l+eelxcePNaAjDQ1Hrixt439tKa32KTrRvzB5p?=
 =?us-ascii?Q?g9FIg3f71bBpLMnKghZbOTESq2BLus8uDFyeEN26GIbK0vb2tBbp6NkDGuUH?=
 =?us-ascii?Q?gXj7a8fn8/u7ntlfIIHFlqreaNwpAWHkMvuLrd8idVrvq1jhiRnCuNIKLyGU?=
 =?us-ascii?Q?6wbpDH2IeBK1Z/hfa95YJdj3hewmR9XBEl4aXNXwMPZw9MnSvfrwQRf0B/TR?=
 =?us-ascii?Q?JY3939a5COBJHtVraRE0MXhVQKh6BKEkWl2Ns6cEsYzTqE45lImTRLtspBbu?=
 =?us-ascii?Q?G9ny0FsuS0v+qgT1TIPFyXNcURk0PEXeyWAoTBJidxBMVxj0t0DFR2O7jRl2?=
 =?us-ascii?Q?uq739Hh5rwhGet57bESF699vStPAs6zE23IbDUk6Yz39I8SniYjMC8eJqkzr?=
 =?us-ascii?Q?svrpyXcKUJ/ZdG1zWiwBT6Rhc0KQH4bzNl4svW1uSdEkNkhGEIwGT/xnSNxi?=
 =?us-ascii?Q?wH3MQ+MC4vgL2J40RAnC/UHUTZ5Wxa0Z8AwPqKJ4qkt0ELz2GnoEH6gWoYJp?=
 =?us-ascii?Q?CKUe7GO7Mz9OSMlMIT+DVu8a771mobGImf5RXuPU3geigVYJ9vOfmWdJY7Tu?=
 =?us-ascii?Q?YjLhx9ZTiuG57HAh24EfZLPnBYxvQZyw1dHYPAu6GJhX6dcTzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB1178.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qPOFJsf7fsBDFb8V5bMy/BYmxM3dT3o7pWtGFChoqvA7NIdbO8iTw/THOfkm?=
 =?us-ascii?Q?ktAG5mt49XQXf3mvNkLpmDtKLp6/CS/5k7Oap965azXE2k29Wisu3zwrTDCf?=
 =?us-ascii?Q?WqGmK/+DkoiW27DhVCvPu93OnkfWG0Y1dz48OCYdbvxDjbRHyihFlZxX+DDn?=
 =?us-ascii?Q?IciKdvOU48mCqSooyXGWEIk7p548vklcDZC74edeNV2Kh70hJdFujcmByNVJ?=
 =?us-ascii?Q?4n7suRFk4qkoJ1W3xG6MEJARzIVVTPzyLyddQleXjBKJoCdbBf34qFoRpsWO?=
 =?us-ascii?Q?rd4r9FlEr8kGGGUbzYmUbbYa/uo8sF4Rx7hBbVfb5xtq7bWaR7zTfJ/yT2Ib?=
 =?us-ascii?Q?/AgbVozQPOeQR/1HTqqNaGEmtYd9xE1otrNoiMs2BwSShUlg9PdFLJHGSXXJ?=
 =?us-ascii?Q?XK/Sq4HMBQ8lsv7XWjZCjFDBNci5haM5UEuTlduEs4iDSL1PwBM2oMVQ5+9P?=
 =?us-ascii?Q?KCv5U+qbXOZgpcYxeKCfJm4LDd4lc1ViqC+aUV4BAG4vY4Of2yHcFM5dCmtg?=
 =?us-ascii?Q?mgbTi8QB8clgCbSNfV8yJWr6ANSKbMclYtni8rkWYUfxxmjmkbOtBo7V/KAC?=
 =?us-ascii?Q?TlCHyudzuWNE8ZdBOIXAwHhH19Jcwx0UclDbAt+c8AU+6QV8Mssk2dXgOUl8?=
 =?us-ascii?Q?liEZTdwX+FqMguxzsPab8TZ6UUYygF22pBwhh+Ch4XqNS9mLpn5f+iz8wYuH?=
 =?us-ascii?Q?CfDTJ+CmQCFpiwX4e1bfYpRkPR/SxVQucMx1N8L2J3EMD+PJSVlciO4psRW4?=
 =?us-ascii?Q?yCKJO91vQ8uAdE+8jZVYi6wyRBfEleH/+FmakD5IdCAHurn9Qwvt73BBoI8K?=
 =?us-ascii?Q?zUOEdFZ4Ax2iLyeCRrd1m+tBRwqG1noUG9cF0ipxlonayhitJJMKThyBpt9B?=
 =?us-ascii?Q?nPKXKnp98ZQ7jfDeyDEeQgymoTEhT9h1Pl4OwsLLZxIri4zQJi1wCkstp3wO?=
 =?us-ascii?Q?pIKcsCEFbQ2WiuP9wSM31WF80vSKPmJbZVX9GwMzoeAKoF/FuZQCX3CTV5DP?=
 =?us-ascii?Q?RcNMpinZt2g7HBL36yFLw9z7n/P6LX4GqDT5ie2IKloMspkXe32zzvRctBg2?=
 =?us-ascii?Q?nspCcY9cEP1M/6QJhkuYLI7QZDovXpZw7ZVTADo2nOnMS1DIhJuHPVgUGEg4?=
 =?us-ascii?Q?CptBZgnIjMc732f4TglSn9yX5kGYQgio2XTK3K18C8D1BP/OLBOyLqGtV31K?=
 =?us-ascii?Q?AkON4KpjSuNLHBtxDAtoGJPuLA0zGpbt83FVBS6T+CD21FZlw3YzQtHRb0Ik?=
 =?us-ascii?Q?OhJpHAGp/Qng1HHjOqrjTDzF93cTC/PP8Jjtl8zep2nbsyEFKECbEEX+tSu7?=
 =?us-ascii?Q?AY7IUmn1coLz06CyDsmKmNGELAbFKzp6KECdIORWhe8RdPznuehfl2RxvTyz?=
 =?us-ascii?Q?krjXfnpF1kpR6CsFSxYyzvdCXEdoX4ia73oKVXMNqSGIpMEluHLaq9pWTHWX?=
 =?us-ascii?Q?PTrquN5/xtxaaLc+HRgNnYNbA+vARVQyNGrLBK8+BL11bqv6B8Vj3yzelH1U?=
 =?us-ascii?Q?D1HKBfRjxMtMCzESt8ofYeMAMlkNewb1KAQzQKzJamFAdrU5KhiLpXypv2ok?=
 =?us-ascii?Q?nmysn/i1Gk7WhIEX9+W9nzzfcWsAWX5Otp3x8hbj+oMlmRNzXO/La/FvLvtg?=
 =?us-ascii?Q?Ofu9rRGtithCiq7DWoY6UHc=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac6dd1f-fad8-4cdf-e9c2-08dd106b0040
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 11:43:11.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxU7g2U+sH/2BSYItcMtIIJFfPLHTsYPTmZQ+Cc7E8/HSzUi5RSXG4Wero4t5YQvqnnBYSdlKDfWbpr9aFWMsYTDzEZJdXMrUg2+PjDeFRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1729

Adds initial support for the STC3117 fuel gauge.

The driver provides functionality to monitor key parameters including:
- Voltage
- Current
- State of Charge (SOC)
- Temperature
- Status

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---
 MAINTAINERS                               |   8 +
 drivers/power/supply/Kconfig              |   7 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c | 665 ++++++++++++++++++++++
 4 files changed, 681 insertions(+)
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 82161bc70b51..1eab5179871d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21855,6 +21855,14 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
 F:	drivers/media/i2c/st-mipid02.c
 
+ST STC3117 FUEL GAUGE DRIVER
+M:	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+M:	Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
+F:	drivers/power/supply/stc3117_fuel_gauge.c
+
 ST STM32 FIREWALL
 M:	Gatien Chevallier <gatien.chevallier@foss.st.com>
 S:	Maintained
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index bcfa63fb9f1e..68d8aa848f7b 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -908,6 +908,13 @@ config FUEL_GAUGE_SC27XX
 	  Say Y here to enable support for fuel gauge with SC27XX
 	  PMIC chips.
 
+config FUEL_GAUGE_STC3117
+       tristate "STMicroelectronics STC3117 fuel gauge driver"
+       depends on I2C
+       help
+         Say Y here to enable support for fuel gauge with STC3117
+         chip.
+
 config CHARGER_UCS1002
 	tristate "Microchip UCS1002 USB Port Power Controller"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 8dcb41545317..5b4633e5818d 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_FUEL_GAUGE_STC3117)       += stc3117_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
new file mode 100644
index 000000000000..b6b1b4f24ea2
--- /dev/null
+++ b/drivers/power/supply/stc3117_fuel_gauge.c
@@ -0,0 +-2,662 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
+ *
+ * Copyright (c) 2024 Silicon Signals Pvt Ltd.
+ * Author:      Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+ *              Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/workqueue.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/crc8.h>
+
+#define STC3117_ADDR_MODE                       0x00
+#define STC3117_ADDR_CTRL                       0x01
+#define STC3117_ADDR_SOC_L                      0x02
+#define STC3117_ADDR_SOC_H                      0x03
+#define STC3117_ADDR_COUNTER_L                  0x04
+#define STC3117_ADDR_COUNTER_H                  0x05
+#define STC3117_ADDR_CURRENT_L                  0x06
+#define STC3117_ADDR_CURRENT_H                  0x07
+#define STC3117_ADDR_VOLTAGE_L                  0x08
+#define STC3117_ADDR_VOLTAGE_H                  0x09
+#define STC3117_ADDR_TEMPERATURE                0x0A
+#define STC3117_ADDR_AVG_CURRENT_L              0X0B
+#define STC3117_ADDR_AVG_CURRENT_H              0X0C
+#define STC3117_ADDR_OCV_L                      0X0D
+#define STC3117_ADDR_OCV_H                      0X0E
+#define STC3117_ADDR_CC_CNF_L                   0X0F
+#define STC3117_ADDR_CC_CNF_H                   0X10
+#define STC3117_ADDR_VM_CNF_L                   0X11
+#define STC3117_ADDR_VM_CNF_H                   0X12
+#define STC3117_ADDR_ALARM_soc                  0X13
+#define STC3117_ADDR_ALARM_VOLTAGE              0X14
+#define STC3117_ADDR_ID                         0X18
+#define STC3117_ADDR_CC_ADJ_L			0X1B
+#define STC3117_ADDR_CC_ADJ_H			0X1C
+#define STC3117_ADDR_VM_ADJ_L			0X1D
+#define STC3117_ADDR_VM_ADJ_H			0X1E
+#define STC3117_ADDR_RAM			0x20
+#define STC3117_ADDR_OCV_TABLE			0x30
+#define STC3117_ADDR_SOC_TABLE			0x30
+
+/* Bit mask definition */
+#define STC3117_ID			        0x16
+#define STC3117_MIXED_MODE			0x00
+#define STC3117_VMODE				BIT(0)
+#define STC3117_GG_RUN				BIT(4)
+#define STC3117_CC_MODE				BIT(5)
+#define STC3117_BATFAIL			BIT(3)
+#define STC3117_PORDET				BIT(4)
+#define STC3117_RAM_SIZE			16
+#define STC3117_OCV_TABLE_SIZE			16
+#define STC3117_RAM_TESTWORD			0x53A9
+#define STC3117_SOFT_RESET                      0x11
+#define STC3117_NOMINAL_CAPACITY		2600
+
+#define VOLTAGE_LSB_VALUE			9011
+#define CURRENT_LSB_VALUE			24084
+#define APP_CUTOFF_VOLTAGE			2500
+#define MAX_HRSOC				51200
+#define MAX_SOC				1000
+#define CHG_MIN_CURRENT			200
+#define CHG_END_CURRENT			20
+#define APP_MIN_CURRENT			(-5)
+#define BATTERY_FULL				95
+#define CRC8_POLYNOMIAL			0x07
+#define CRC8_INIT				0x00
+
+DECLARE_CRC8_TABLE(stc3117_crc_table);
+
+enum stc3117_state {
+	STC3117_INIT,
+	STC3117_RUNNING,
+	STC3117_POWERDN,
+};
+
+enum stc3117_status {
+	BATT_LOWBATT = -2,
+	BATT_DISCHARG,
+	BATT_IDLE,
+	BATT_FULCHARG,
+	BATT_ENDCHARG,
+	BATT_CHARGING,
+};
+
+/* Default ocv curve Li-ion battery */
+static const int ocvValue[16] = {
+    3400, 3582, 3669, 3676, 3699, 3737, 3757, 3774,
+    3804, 3844, 3936, 3984, 4028, 4131, 4246, 4320
+};
+
+static union stc3117_internal_ram {
+	u8 ram_bytes[STC3117_RAM_SIZE];
+	struct {
+	u16 testword;   /* 0-1    Bytes */
+	u16 hrsoc;      /* 2-3    Bytes */
+	u16 cc_cnf;     /* 4-5    Bytes */
+	u16 vm_cnf;     /* 6-7    Bytes */
+	u8 soc;         /* 8      Byte  */
+	u8 state;       /* 9      Byte  */
+	u8 unused[5];   /* 10-14  Bytes */
+	u8 crc;         /* 15     Byte  */
+	} reg;
+} ram_data;
+
+struct stc3117_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct delayed_work update_work;
+	struct power_supply *battery;
+
+	u8 soc_tab[16];
+	int cc_cnf;
+	int vm_cnf;
+	int cc_adj;
+	int vm_adj;
+	int avg_current;
+	int avg_voltage;
+	int batt_current;
+	int voltage;
+	int temp;
+	int soc;
+	int ocv;
+	int hrsoc;
+	int presence;
+	int battery_state;
+};
+
+struct stc3117_battery_info {
+	int voltage_min;
+	int voltage_max;
+	int battery_capacity;
+	int sense_resistor;
+} battery_info;
+
+static int STC3117_convert(int value, int factor)
+{
+	value = (value * factor) / 4096;
+	return value;
+}
+
+static int stc3117_get_battery_data(struct stc3117_data *data)
+{
+	u8 reg_list[16];
+	u8 data_adjust[4];
+	int value, mode;
+
+	regmap_bulk_read(data->regmap, STC3117_ADDR_MODE,
+			 reg_list, sizeof(reg_list));
+
+	/* soc */
+	value = (reg_list[3] << 8) + reg_list[2];
+	data->hrsoc = value;
+	data->soc = (value * 10 + 256) / 512;
+
+	/* cureent in mA*/
+	value = (reg_list[7] << 8) + reg_list[6];
+	data->batt_current = STC3117_convert(value,
+			     CURRENT_LSB_VALUE / battery_info.sense_resistor);
+
+	/* voltage in mV */
+	value = (reg_list[9] << 8) + reg_list[8];
+	data->voltage = STC3117_convert(value, VOLTAGE_LSB_VALUE);
+
+	/* temp */
+	data->temp = reg_list[10];
+
+	/* Avg batt_current in mA */
+	value = (reg_list[12] << 8) + reg_list[11];
+	regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (!(mode & STC3117_VMODE)) {
+		value = STC3117_convert(value, CURRENT_LSB_VALUE / 10);
+		value = value / 4;
+	} else {
+		value = STC3117_convert(value, 36 * STC3117_NOMINAL_CAPACITY);
+	}
+	data->avg_current = value;
+
+	/* ocv */
+	value = (reg_list[14] << 8) + reg_list[13];
+	value = STC3117_convert(value, VOLTAGE_LSB_VALUE);
+	value = (value + 2) / 4;
+	data->ocv = value;
+
+	/* CC & VM adjustment counters */
+	regmap_bulk_read(data->regmap, STC3117_ADDR_CC_ADJ_L,
+			 data_adjust, sizeof(data_adjust));
+	value = (data_adjust[1] << 8) + data_adjust[0];
+	data->cc_adj = value;
+
+	value = (data_adjust[3] << 8) + data_adjust[2];
+	data->vm_adj = value;
+
+	return 0;
+}
+
+static int stc3117_update_battery_status(struct stc3117_data *data)
+{
+	switch (data->battery_state) {
+	case BATT_CHARGING:
+		if (data->avg_current < CHG_MIN_CURRENT)
+			data->battery_state = BATT_ENDCHARG;
+		break;
+
+	case BATT_ENDCHARG:
+		if (data->batt_current > CHG_MIN_CURRENT)
+			data->battery_state = BATT_CHARGING;
+		else if (data->avg_current < CHG_END_CURRENT)
+			data->battery_state = BATT_IDLE;
+		else if ((data->batt_current > CHG_END_CURRENT) &&
+			 (data->voltage > battery_info.voltage_max))
+			data->battery_state = BATT_FULCHARG;
+		break;
+
+	case BATT_FULCHARG:
+		if ((data->batt_current > CHG_MIN_CURRENT))
+			data->battery_state = BATT_CHARGING;
+		else if (data->avg_current < CHG_END_CURRENT) {
+			if (data->avg_voltage > battery_info.voltage_max)
+			{
+				regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+					     (MAX_HRSOC >> 8 & 0xFF));
+				regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+					     (MAX_HRSOC & 0xFF));
+	       			data->soc = MAX_SOC;
+			}
+			data->battery_state = BATT_IDLE;
+		}
+		break;
+
+	case BATT_IDLE:
+		if (data->batt_current > CHG_END_CURRENT)
+			data->battery_state = BATT_CHARGING;
+		else if (data->batt_current < APP_MIN_CURRENT)
+			data->battery_state = BATT_DISCHARG;
+		break;
+
+	case BATT_DISCHARG:
+		if (data->batt_current > APP_MIN_CURRENT)
+			data->battery_state = BATT_IDLE;
+		else if (data->avg_voltage < battery_info.voltage_min)
+			data->battery_state = BATT_LOWBATT;
+		break;
+
+	case BATT_LOWBATT:
+		if (data->avg_voltage > (battery_info.voltage_min + 50))
+			data->battery_state = BATT_IDLE;
+		break;
+
+	default:
+		data->battery_state = BATT_IDLE;
+	}
+
+	return 0;
+}
+
+static int ram_write(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_write(data->regmap, STC3117_ADDR_RAM,
+				ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int ram_read(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, STC3117_ADDR_RAM,
+			       ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int stc3117_set_para(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, STC3117_ADDR_MODE, STC3117_VMODE);
+
+	for (int i = 0; i < STC3117_OCV_TABLE_SIZE; i++)
+		regmap_write(data->regmap, STC3117_ADDR_OCV_TABLE + i,
+						ocvValue[i] * 100 / 55);
+	if (data->soc_tab[1] != 0)
+		regmap_bulk_write(data->regmap, STC3117_ADDR_SOC_TABLE,
+				  data->soc_tab, STC3117_OCV_TABLE_SIZE);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_H,
+					(ram_data.reg.cc_cnf >> 8) & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_L,
+					ram_data.reg.cc_cnf & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_H,
+					(ram_data.reg.vm_cnf >> 8) & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_L,
+					ram_data.reg.vm_cnf & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CTRL, 0x03);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_MODE,
+					STC3117_MIXED_MODE | STC3117_GG_RUN);
+
+	return ret;
+};
+
+static int stc3117_init(struct stc3117_data *data)
+{
+	int ID, ret;
+	int ctrl;
+	int ocv_m, ocv_l;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &ID);
+	if (ID != STC3117_ID)
+		return -EINVAL;
+
+	data->cc_cnf = (battery_info.battery_capacity *
+				battery_info.sense_resistor * 250 + 6194) / 12389;
+	data->vm_cnf = (battery_info.battery_capacity * 200 * 50 + 24444) / 48889;
+
+	/* Battery has not been removed */
+	data->presence = 1;
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return ret;
+
+	if ((ram_data.reg.testword != STC3117_RAM_TESTWORD) ||
+	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT)) != 0)
+	{
+		ram_data.reg.testword = STC3117_RAM_TESTWORD;
+		ram_data.reg.cc_cnf = data->cc_cnf;
+		ram_data.reg.vm_cnf = data->vm_cnf;
+		ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+      	                        	STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+		ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+		ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+		ret |= stc3117_set_para(data);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_read(data->regmap, STC3117_ADDR_CTRL, &ctrl);
+		if ((ctrl & STC3117_BATFAIL) != 0  || (ctrl & STC3117_PORDET) != 0)
+		{
+			ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return ret;
+		} else {
+			ret = stc3117_set_para(data);
+			if (ret)
+				return ret;
+			regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+				     (ram_data.reg.hrsoc >> 8 & 0xFF));
+			regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+				     (ram_data.reg.hrsoc & 0xFF));
+		}
+	}
+
+	ram_data.reg.state = STC3117_INIT;
+	ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+                                	STC3117_RAM_SIZE - 1, CRC8_INIT);
+	ret = ram_write(data);
+	if (ret)
+		return ret;
+
+	data->battery_state = BATT_IDLE;
+
+	return 0;
+};
+
+static int stc3117_task(struct stc3117_data *data)
+{
+	int ID, mode, ret;
+	int count_l, count_m;
+	int ocv_l, ocv_m;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &ID);
+	if (ID != STC3117_ID) {
+		data->presence = 0;
+		return -EINVAL;
+	}
+
+	stc3117_get_battery_data(data);
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return ret;
+
+	if ((ram_data.reg.testword != STC3117_RAM_TESTWORD) ||
+	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT) != 0))
+	{
+		ram_data.reg.testword = STC3117_RAM_TESTWORD;
+		ram_data.reg.cc_cnf = data->cc_cnf;
+		ram_data.reg.vm_cnf = data->vm_cnf;
+		ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE - 1, CRC8_INIT);
+		ram_data.reg.state = STC3117_INIT;
+	}
+
+	/* check battery presence status */
+	ret = regmap_read(data->regmap, STC3117_ADDR_CTRL, &mode);
+	if ((mode & STC3117_BATFAIL) != 0)
+	{
+		data->presence = 0;
+		ram_data.reg.testword = 0;
+		ram_data.reg.state = STC3117_INIT;
+		ret = ram_write(data);
+		if (ret)
+			return ret;
+		regmap_write(data->regmap, STC3117_ADDR_CTRL, STC3117_PORDET);
+	}
+
+	data->presence = 1;
+
+	ret = regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if ((mode & STC3117_GG_RUN) == 0)
+	{
+		if (ram_data.reg.state > STC3117_INIT) {
+			ret = stc3117_set_para(data);
+			if (ret)
+				return ret;
+
+			regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+				     (ram_data.reg.hrsoc >> 8 & 0xFF));
+			regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+				     (ram_data.reg.hrsoc & 0xFF));
+		} else {
+			ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return ret;
+		}
+		ram_data.reg.state = STC3117_INIT;
+	}
+
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_L, &count_l);
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_H, &count_m);
+
+	count_m = (count_m << 8) + count_l;
+
+	/* INIT state, wait for batt_current & temperature value available: */
+	if (ram_data.reg.state == STC3117_INIT && count_m > 4) {
+		data->avg_voltage = data->voltage;
+		data->avg_current = data->batt_current;
+		ram_data.reg.state = STC3117_RUNNING;
+	}
+
+	if (ram_data.reg.state != STC3117_RUNNING)
+	{
+    		data->batt_current = 0;
+        	data->temp = 250;
+	} else {
+		if (data->voltage < APP_CUTOFF_VOLTAGE)
+			data->soc = 0;
+
+		if (mode & STC3117_VMODE) {
+			data->avg_current = 0;
+			data->batt_current = 0;
+		} else {
+		       stc3117_update_battery_status(data);
+		}
+	}
+
+	ram_data.reg.hrsoc = data->hrsoc;
+	ram_data.reg.soc = (data->soc + 5) / 10;
+	ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+			       	        STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+	ret = ram_write(data);
+	if (ret)
+		return ret;
+	return 0;
+};
+
+static void fuel_gauge_update_work(struct work_struct *work)
+{
+	struct stc3117_data *data = container_of(to_delayed_work(work),
+					struct stc3117_data, update_work);
+	stc3117_task(data);
+
+	/* Schedule the work to run again in 2 seconds */
+	schedule_delayed_work(&data->update_work, msecs_to_jiffies(2000));
+}
+
+static int stc3117_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct stc3117_data *data = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (data->soc > BATTERY_FULL)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		if (data->batt_current < 0)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (data->batt_current > 0)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = data->voltage;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = data->batt_current;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = data->soc;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval = data->temp;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = data->presence;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property stc3117_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_PRESENT,
+};
+
+static const struct power_supply_desc stc3117_battery_desc = {
+	.name = "stc3117-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.get_property = stc3117_get_property,
+	.properties = stc3117_battery_props,
+	.num_properties = ARRAY_SIZE(stc3117_battery_props),
+};
+
+static const struct regmap_config stc3117_regmap_config = {
+	.reg_bits       = 8,
+	.val_bits       = 8,
+};
+
+static int stc3117_probe(struct i2c_client *client)
+{
+	struct stc3117_data *data;
+	struct power_supply_config psy_cfg = {};
+	struct power_supply_battery_info *info;
+	int ret;
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	data->regmap = devm_regmap_init_i2c(client, &stc3117_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	i2c_set_clientdata(client, data);
+	psy_cfg.drv_data = data;
+
+	crc8_populate_msb(stc3117_crc_table, CRC8_POLYNOMIAL);
+
+	data->battery = devm_power_supply_register(&client->dev,
+						   &stc3117_battery_desc, &psy_cfg);
+	if (IS_ERR(data->battery))
+		return dev_err_probe(&client->dev, PTR_ERR(data->battery),
+						"failed to register battery\n");
+
+	ret = device_property_read_u32(&client->dev, "sense-resistor",
+				       &battery_info.sense_resistor);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+						"failed to get sense-register\n");
+
+	ret = power_supply_get_battery_info(data->battery, &info);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+					"failed to get battery information\n");
+
+	battery_info.battery_capacity = info->charge_full_design_uah * 1000;
+	battery_info.voltage_min = info->voltage_min_design_uv * 1000;
+	battery_info.voltage_max = info->voltage_min_design_uv * 1000;
+
+	ret = stc3117_init(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				"failed to initialization of stc3117\n");
+
+	INIT_DELAYED_WORK(&data->update_work, fuel_gauge_update_work);
+
+	schedule_delayed_work(&data->update_work, 0);
+
+	return 0;
+}
+
+static const struct i2c_device_id stc3117_id[] = {
+	{"stc3117", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, stc3117_id);
+
+static const struct of_device_id stc3117_of_match[] = {
+	{ .compatible = "st,stc3117" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stc3117_of_match);
+
+static struct i2c_driver stc3117_i2c_driver = {
+	.driver = {
+		.name = "stc3117_i2c_driver",
+		.of_match_table = stc3117_of_match,
+	},
+	.probe = stc3117_probe,
+	.id_table = stc3117_id,
+};
+
+module_i2c_driver(stc3117_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
+MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>");
+MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");
-- 
2.43.0


