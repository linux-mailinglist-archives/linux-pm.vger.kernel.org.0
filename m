Return-Path: <linux-pm+bounces-18322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25939DFD79
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D180B22084
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6731FBCA0;
	Mon,  2 Dec 2024 09:44:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021096.outbound.protection.outlook.com [40.107.57.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4DA1FBC9B;
	Mon,  2 Dec 2024 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.57.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132660; cv=fail; b=DjNAMsVjjIZsjlE3l8wt1r8EQjr5WyOUri2uMJwypyBTb48Ygps/abKDqoiI60KMLZVLaNnDq5ZvNk+b0ViayyawD3R/XTVvsiBF5mhqJevEGJ7YfvggMO9FLNvjcsxG8kDqOLN02ef1b9Df3KIDCmaS1P1NjlDkHZ+dlK5SBq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132660; c=relaxed/simple;
	bh=GY6GuC9PpAtzUrgcwk1agyCxDP3tqO09ZLd6bJzvplQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H4/zois8G+A5qoys2NVk8O/9cKhZ4UjZhvd9SGF2sIv95q7c+cRgLQ5hZL4QUXPCIazDVVq9K7Iujbh9CbEx8x+iqdu+KpqzVUYcpn9hk/+7naoKUhm4yzBhqzwau7c8CyJBOPl9Te6nZ83THw512oL2VVmd6c+jFNb9Zejjij4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.57.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3Hy8GoytBSDC2BQtzdqfFVSQFutXfSuyy63hQA7ddiKnpD4hVP0Ylrgfc5I44X0M/s6xEc7/jISVmC/4vF8zxlGToR8lcqN6e7SLUn4ITTxIL8hCtjDYtYYjiUWsL5WFsbdBzRlKo+NHSl1oxyQktHVyO+ZgF+8BAQsVtJ6q9G0grsWGpW52lm3X6DeDpYBq6u9oT23lvaba3w9fHKQOVqlP4fNasuCayUhUQpE47NUnp+5DIRXy8/FJchkJlW3B/1Req8Eer2x3Lc2OILXsTsgoUXKyGjStGHj4ea6UYD515Y30HFKy5J4WwaLPKyNfLxUgssrxdZ1a0OXWAIcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2s21Ex34I3H9c4oMbQWvi9b1SHLuXzsw8XptuNuIUs0=;
 b=VilbYrv3mF9ShvHHLy6qsGctGD1Z4NSbK8xwFJyccL2M7q0onflXBMIYF2yBNMsAxUFxCBez+y2ZZx59IfG67Bhzv2Pu7xfIRqPjThrJ7fzdbVquAxSo4fOMNdKJnqn0oPS89O/locOZBuyccqf+mJ/eRZIrO0Y7p6qhhDYKpnHpktsHNBbnfDp2oJIHAXbIz5wC/S1iBafakidf8tGdlz9byIZyS/2dnwAtEvFpkDInoVsSq7DLmYyoMLF9Keh3ZJJwkhLHKYpmGCOjM96aAALBKNPTTy4ozV7dGE1jUgwUBiObYdf91sKQYaCH9fzO44HPkNhZ4iuJPmxTPnSaRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN2P287MB1028.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 09:44:14 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 09:44:14 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org,
	christophe.jaillet@wanadoo.fr
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] power: supply: Add STC3117 fuel gauge unit driver
Date: Mon,  2 Dec 2024 15:11:53 +0530
Message-ID: <20241202094328.14395-3-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202094328.14395-1-bhavin.sharma@siliconsignals.io>
References: <20241202094328.14395-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::32) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|PN2P287MB1028:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d2e3bd-8fbb-4f24-164e-08dd12b5e179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P8JxCwMQ5EJ3EnwdTfgaM/dzhn2Eud8T+SUE+l41aGvkKtmPN7wiRg2broTC?=
 =?us-ascii?Q?3FhjGXpAUKs/EfcmuIkLmXY+ZToXR0J1kfAxVswag8fXw6M+mVaZ5saIxCwX?=
 =?us-ascii?Q?88hAOHzpN1rJBJpu2LcSiYEH58emVZyhMMvkLA++bievyMgr27o95jIBdKUe?=
 =?us-ascii?Q?LGsIRkZj2KbR1hn24dez2QO0UhS2pUdodKPdSkb/s3EJzztSNFu2/YmPFQxC?=
 =?us-ascii?Q?i2+vvEWpx3N+MzfbZnOJDGk3PbVO76X6Oc5c2TcFwrtDPH/O7OMEU4viP2/+?=
 =?us-ascii?Q?NO6B+IG/UTihxeDb4oSnD5rJhE9O14LcQCKMiTUnYJ+cibar8vTpg+w/cqjY?=
 =?us-ascii?Q?5GzYDJBvx+uIKrYVKsmpXk6eU8tL9ffOTjf89nFxVCs/bjLAfa38ShQcXsFg?=
 =?us-ascii?Q?KLWBJyU4A2cGwa+LNGoakwzpw3Faxs/Fj8XxZ6/86g+XvznXFe2tYc1iQt1Y?=
 =?us-ascii?Q?XZQIQ/t+yAsvo1QG/3jfLK5l2dSyd/Ac6x1SCzzdjntE9nFftBPeiocRAJjH?=
 =?us-ascii?Q?s4GyuH6txL4z6Wigzfy3jzJRi1x7nzztJlv+mqRnDXk5qz6vXC1VcOPVSQga?=
 =?us-ascii?Q?eo6Pd+WXew5DGPQWCmSpbiF5xkdIb0YtM435Lo0j7CVtUZJQHyesRjD2BXXc?=
 =?us-ascii?Q?goN95X7kBD64Hxnxim7++MVkl7C8WXMQBR0jXFStGyOgorD1VHbYWapM2ifg?=
 =?us-ascii?Q?VtGQoLBtMecDapUAOFw2YU0TzMWQP2T7tjsFd5pVNJB2IuAY/DqFiUfMIbZP?=
 =?us-ascii?Q?BKibrcfieF04oi4B6+eBXDFx7b6K+G3MAMqMMh6dyVIHxS3PUHN0ag2mgD0B?=
 =?us-ascii?Q?Xbqb/HBUSy5zDHEcFmYdeRTcQB/dzljsSDelTQ9vSxCPqIaXHRsjRAukPxf1?=
 =?us-ascii?Q?8uG81GtIkLY6yDn+/RcPUdRZo7EOjwW/z72jzOcLP/wGpEdEIFxCZ7FOb+aO?=
 =?us-ascii?Q?e0PFmasMB6xntBWu956EXJmLLQ4lqFLT140YEZ4BtUPk0kKBENqlopDAI0+o?=
 =?us-ascii?Q?S4FjHTi4sO4qlZvEJkeNdi8NaUM4D3EDHGtW4Q3wt0oetNeneWILa8yqQMu7?=
 =?us-ascii?Q?yqQ3pMsFPB3n3EZ4rCJyDz5MXpeyLpju5wW7Ck701n8I5p26oT75i9z8o3J5?=
 =?us-ascii?Q?uZIu+AGPgx1AnJ3yf66M+W1lXjNqZcvw02rnCPvscbjoWDCstVp7vZUFnRUQ?=
 =?us-ascii?Q?qB+p8Z1cL9WRolXFf/HeXsoWcYGDqrvK+pD+lD6Q/HqHGyAMfSOsMR6/qwUr?=
 =?us-ascii?Q?OMrzRhPzRPzenr2WA4GCyEcfvkTzAzal9F4/6qIZII+mn9nq8JuClLZzD35u?=
 =?us-ascii?Q?EoSjcBEmjT/r0JZggJooICtdAPkucnZC4wdps+GRJz3eJ9EfD7XoN1KaWy/E?=
 =?us-ascii?Q?I5QvzuxtYwESC7/B6WNTv51s73pEL0zRwABgbssUXglclqAdsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XhubLc/tELhjpWS4sw+pwnNKZXdI6KKuivEyVadWMbjT3zlzs/Y+mmSKuRCd?=
 =?us-ascii?Q?4wsMXpOXVnjiUqPRLyT+6CkkDsSGMLNCXfRYhqt7z0NTppF8dbcfp+k6HmcD?=
 =?us-ascii?Q?vfMl2aR+g/5K+GI2RYPi4fLqhUUz1TmxMPzyOJznFmGJxKSt7a3zb3xegRij?=
 =?us-ascii?Q?4Urc1DLZ6ArNN7FN+VSWVu9GG/F5tAfXmvsHzGUydYbSkqfkTxdmMIJabRAy?=
 =?us-ascii?Q?UJyLzw9zEtI4QMSLH79WthCxq9oAmbJG9xhQ8pWt5Pu90mXfHLGTJAIXg8f8?=
 =?us-ascii?Q?pT0ZT95QnC3wT/nKcIhSu4vtYiyPswNp9c6vlh75QynSpt4WcA68AQitkR6c?=
 =?us-ascii?Q?JGf8l+71Xxt1lxKhT8iB2XptEbL14zTxwzGnpa74IkLD7285Dq1rj1NJL1Jq?=
 =?us-ascii?Q?sQMS2aZoxnxhxOi1XfATEiGMZTux8oFdUKnCPuLtfp4PjAwyndcHt0JL4eZ3?=
 =?us-ascii?Q?M0rgUu8p+i5SdDDUSJSj5ELrIhw0+qnulR+IgRoPQyrk2NcS7OlTqCuI2/wI?=
 =?us-ascii?Q?ks5A3WoJfcr8/I5HIaOdEo+gDUkijsRoDLDxV4EXdWHKJf6Gq29moOWAGYO/?=
 =?us-ascii?Q?4kmWBJmpkMbd8zlOy6WFl3r2DkY818lEAN6uODPf0YTHYn19QFO59S5MtMUF?=
 =?us-ascii?Q?8b0xqaPJo7FHUWjn+ZX5wGwQS2PSvz84JsfUoA83d09ag+6wD10nVUg+ONDU?=
 =?us-ascii?Q?e4pG5Oqr5VxErv0F3s8f8O9PFUkHTNHAQHMO7EISSiybyWwF5WeRAdxaktjA?=
 =?us-ascii?Q?FBF2VtaxWylTOZ+XuYZNB7j/c/YVTblIJrBgBsTmWQFDtGAyhdwtWAwWLYer?=
 =?us-ascii?Q?GqubrNUB1TajGSUttPcjIVtvtn0tcfrTGry1+wZwN4iP9Z5SVS+t8ZsZVm1e?=
 =?us-ascii?Q?ANlGo4f7rGqAupdF1bRFRYepwLNus6ODx85oPnq869P40hWEsx7S6Jz2DDXD?=
 =?us-ascii?Q?T17OGSyFCHJ3f1IEYhlE19ikaLNLbIMYBqQ04nyMim9aU6WLZvpC60IfahrK?=
 =?us-ascii?Q?c4kTdUID3SpSNAE3zsamHJg828K+RWYxsGsfj9GmbhICj2OZ4z20gcQwSMVF?=
 =?us-ascii?Q?042BmM9rJ3jhGpxRcvstM1c2wOon7O/G9kc8yxKArgyYNR/2EN/dFeK22Vtd?=
 =?us-ascii?Q?fxd23554euKAljtFJ8TT6+gGO93ndqbaTMTOsQW2Ga7NwW7nYdhv7E8bU61p?=
 =?us-ascii?Q?G49O1miFjd8KfOG1e09x/Q1rvIhwh52qFVd43MdnV0EapoddYSZP8bH6cHbU?=
 =?us-ascii?Q?jCPXneb0qQsRTdku04O0dlRqXaTIBrkCipwXUAqzF2X52Dnzbvr76MnbXEu2?=
 =?us-ascii?Q?G7+sTOLCDmX5vShk35/tbt2SZjXFszKRxIW96NOMP4/DEHHiW4ZM609A9RvR?=
 =?us-ascii?Q?IfbURrv4U42LIbQ5VzBTufeTeAfly8q6DPEBMn+jZtpg1yzxiWlVtmjHWltj?=
 =?us-ascii?Q?wAKIGUazSHgUibYmnLiKETdpnB2/fgIaMuI1zepqwOyaQf6MJgN/cnJRnf7l?=
 =?us-ascii?Q?TCtYQJVsSZJyyh67IW1JZEk9aZ2Bu14GCuZSw5Z2YaBnnkrC+5zMJTq+Znjy?=
 =?us-ascii?Q?sHp/viPKvg3mbbfYTk/cEF1umVlFPbe6DzljBinAnQLQZbYfY6s2y7PbtjVa?=
 =?us-ascii?Q?QcQE96oxusUNkqC7e/adnrA=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d2e3bd-8fbb-4f24-164e-08dd12b5e179
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 09:44:13.9479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaPtYF7Z7F+gp/knO/lNCOOEh10OK7J4kXh12vET5xoEGb5IhFzqQNnXVTAaiF09cX/ulp3OfY388Rk48ntlv9xUAdLtog6vwSBLcqfL5EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1028

Adds initial support for the STC3117 fuel gauge.

The driver provides functionality to monitor key parameters including:
- Voltage
- Current
- State of Charge (SOC)
- Temperature
- Status

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 MAINTAINERS                               |   8 +
 drivers/power/supply/Kconfig              |   7 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c | 665 ++++++++++++++++++++++
 4 files changed, 681 insertions(+)
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c1fcc56bf2fb..10ead03660d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22125,6 +22125,14 @@ T:	git git://linuxtv.org/media.git
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
index 9f2eef6787f7..9f34a2a6bc00 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -918,6 +918,13 @@ config FUEL_GAUGE_SC27XX
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
index 59c4a9f40d28..b55cc48a4c86 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_FUEL_GAUGE_STC3117)       += stc3117_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
new file mode 100644
index 000000000000..ffa7e0d35474
--- /dev/null
+++ b/drivers/power/supply/stc3117_fuel_gauge.c
@@ -0,0 +1,665 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
+ *
+ * Copyright (c) 2024 Silicon Signals Pvt Ltd.
+ * Author:      Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.com>
+ *              Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+ */
+
+#include <linux/i2c.h>
+#include <linux/workqueue.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/crc8.h>
+
+#define STC3117_ADDR_MODE                      0x00
+#define STC3117_ADDR_CTRL                      0x01
+#define STC3117_ADDR_SOC_L                     0x02
+#define STC3117_ADDR_SOC_H                     0x03
+#define STC3117_ADDR_COUNTER_L                 0x04
+#define STC3117_ADDR_COUNTER_H                 0x05
+#define STC3117_ADDR_CURRENT_L                 0x06
+#define STC3117_ADDR_CURRENT_H                 0x07
+#define STC3117_ADDR_VOLTAGE_L                 0x08
+#define STC3117_ADDR_VOLTAGE_H                 0x09
+#define STC3117_ADDR_TEMPERATURE               0x0A
+#define STC3117_ADDR_AVG_CURRENT_L             0X0B
+#define STC3117_ADDR_AVG_CURRENT_H             0X0C
+#define STC3117_ADDR_OCV_L                     0X0D
+#define STC3117_ADDR_OCV_H                     0X0E
+#define STC3117_ADDR_CC_CNF_L                  0X0F
+#define STC3117_ADDR_CC_CNF_H                  0X10
+#define STC3117_ADDR_VM_CNF_L                  0X11
+#define STC3117_ADDR_VM_CNF_H                  0X12
+#define STC3117_ADDR_ALARM_soc                 0X13
+#define STC3117_ADDR_ALARM_VOLTAGE             0X14
+#define STC3117_ADDR_ID                        0X18
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
+#define STC3117_CC_MODE			BIT(5)
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
+static const int ocv_value[16] = {
+	3400, 3582, 3669, 3676, 3699, 3737, 3757, 3774,
+	3804, 3844, 3936, 3984, 4028, 4131, 4246, 4320
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
+	int voltage_min_mv;
+	int voltage_max_mv;
+	int battery_capacity_mah;
+	int sense_resistor;
+} battery_info;
+
+static int stc3117_convert(int value, int factor)
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
+	data->batt_current = stc3117_convert(value,
+				CURRENT_LSB_VALUE / battery_info.sense_resistor);
+
+	/* voltage in mV */
+	value = (reg_list[9] << 8) + reg_list[8];
+	data->voltage = stc3117_convert(value, VOLTAGE_LSB_VALUE);
+
+	/* temp */
+	data->temp = reg_list[10];
+
+	/* Avg batt_current in mA */
+	value = (reg_list[12] << 8) + reg_list[11];
+	regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (!(mode & STC3117_VMODE)) {
+		value = stc3117_convert(value,
+			 	CURRENT_LSB_VALUE / battery_info.sense_resistor);
+	value = value / 4;
+	} else {
+		value = stc3117_convert(value, 36 * STC3117_NOMINAL_CAPACITY);
+	}
+	data->avg_current = value;
+
+	/* ocv */
+	value = (reg_list[14] << 8) + reg_list[13];
+	value = stc3117_convert(value, VOLTAGE_LSB_VALUE);
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
+			 (data->voltage > battery_info.voltage_max_mv))
+			data->battery_state = BATT_FULCHARG;
+		break;
+
+	case BATT_FULCHARG:
+		if (data->batt_current > CHG_MIN_CURRENT) {
+			data->battery_state = BATT_CHARGING;
+		} else if (data->avg_current < CHG_END_CURRENT) {
+			if (data->avg_voltage > battery_info.voltage_max_mv) {
+				regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+					     (MAX_HRSOC >> 8 & 0xFF));
+				regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+					     (MAX_HRSOC & 0xFF));
+				data->soc = MAX_SOC;
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
+		else if (data->avg_voltage < battery_info.voltage_min_mv)
+			data->battery_state = BATT_LOWBATT;
+		break;
+
+	case BATT_LOWBATT:
+		if (data->avg_voltage > (battery_info.voltage_min_mv + 50))
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
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_TABLE + i,
+			     ocv_value[i] * 100 / 55);
+	if (data->soc_tab[1] != 0)
+		ret |= regmap_bulk_write(data->regmap, STC3117_ADDR_SOC_TABLE,
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
+	data->cc_cnf = (battery_info.battery_capacity_mah *
+			battery_info.sense_resistor * 250 + 6194) / 12389;
+	data->vm_cnf = (battery_info.battery_capacity_mah
+						* 200 * 50 + 24444) / 48889;
+
+	/* Battery has not been removed */
+	data->presence = 1;
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return ret;
+
+	if (ram_data.reg.testword != STC3117_RAM_TESTWORD ||
+	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT)) != 0) {
+		ram_data.reg.testword = STC3117_RAM_TESTWORD;
+		ram_data.reg.cc_cnf = data->cc_cnf;
+		ram_data.reg.vm_cnf = data->vm_cnf;
+		ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE - 1, CRC8_INIT);
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
+		if (ret)
+			return ret;
+
+		if ((ctrl & STC3117_BATFAIL) != 0  ||
+		    (ctrl & STC3117_PORDET) != 0) {
+			ret = regmap_read(data->regmap,
+					  STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap,
+						STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap,
+						STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap,
+						STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return ret;
+		} else {
+			ret = stc3117_set_para(data);
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+				     (ram_data.reg.hrsoc >> 8 & 0xFF));
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+				     (ram_data.reg.hrsoc & 0xFF));
+			if (ret)
+				return ret;
+		}
+	}
+
+	ram_data.reg.state = STC3117_INIT;
+	ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+				STC3117_RAM_SIZE - 1, CRC8_INIT);
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
+	if (ram_data.reg.testword != STC3117_RAM_TESTWORD ||
+	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT) != 0)) {
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
+	if ((mode & STC3117_BATFAIL) != 0) {
+		data->presence = 0;
+		ram_data.reg.testword = 0;
+		ram_data.reg.state = STC3117_INIT;
+		ret = ram_write(data);
+		ret |= regmap_write(data->regmap, STC3117_ADDR_CTRL, STC3117_PORDET);
+		if (ret)
+			return ret;
+	}
+
+	data->presence = 1;
+
+	ret = regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (ret)
+		return ret;
+	if ((mode & STC3117_GG_RUN) == 0) {
+		if (ram_data.reg.state > STC3117_INIT) {
+			ret = stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+					(ram_data.reg.hrsoc >> 8 & 0xFF));
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+					(ram_data.reg.hrsoc & 0xFF));
+			if (ret)
+				return ret;
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
+	if (ram_data.reg.state != STC3117_RUNNING) {
+		data->batt_current = 0;
+		data->temp = 250;
+	} else {
+		if (data->voltage < APP_CUTOFF_VOLTAGE)
+			data->soc = 0;
+
+		if (mode & STC3117_VMODE) {
+			data->avg_current = 0;
+			data->batt_current = 0;
+		} else {
+			stc3117_update_battery_status(data);
+		}
+	}
+
+	ram_data.reg.hrsoc = data->hrsoc;
+	ram_data.reg.soc = (data->soc + 5) / 10;
+	ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+				STC3117_RAM_SIZE - 1, CRC8_INIT);
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
+		enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct stc3117_data *data = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (data->soc > BATTERY_FULL)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else if (data->batt_current < 0)
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
+	psy_cfg.drv_data = data;
+
+	crc8_populate_msb(stc3117_crc_table, CRC8_POLYNOMIAL);
+
+	data->battery = devm_power_supply_register(&client->dev,
+						   &stc3117_battery_desc, &psy_cfg);
+	if (IS_ERR(data->battery))
+		return dev_err_probe(&client->dev, PTR_ERR(data->battery),
+					"failed to register battery\n");
+
+	ret = device_property_read_u32(&client->dev, "shunt-resistor-micro-ohms",
+				       &battery_info.sense_resistor);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+					"failed to get sense-registor\n");
+	battery_info.sense_resistor = battery_info.sense_resistor / 1000;
+
+	ret = power_supply_get_battery_info(data->battery, &info);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+					"failed to get battery information\n");
+
+	battery_info.battery_capacity_mah = info->charge_full_design_uah / 1000;
+	battery_info.voltage_min_mv = info->voltage_min_design_uv / 1000;
+	battery_info.voltage_max_mv = info->voltage_max_design_uv / 1000;
+
+	ret = stc3117_init(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				"failed to initialize of stc3117\n");
+
+	INIT_DELAYED_WORK(&data->update_work, fuel_gauge_update_work);
+
+	schedule_delayed_work(&data->update_work, 0);
+
+	return 0;
+}
+
+static const struct i2c_device_id stc3117_id[] = {
+	{ "stc3117", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, stc3117_id);
+
+static const struct of_device_id stc3117_of_match[] = {
+	{ .compatible = "st,stc3117" },
+	{ }
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
+MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>");
+MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
+MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");
-- 
2.43.0


