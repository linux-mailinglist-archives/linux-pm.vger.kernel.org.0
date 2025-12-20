Return-Path: <linux-pm+bounces-39733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FB5CD378B
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B643300997B
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 21:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2302F12D3;
	Sat, 20 Dec 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="K3BWnQdp"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF629992A;
	Sat, 20 Dec 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766266804; cv=fail; b=nlLsjWhSI1oVwxEJTSygkeZRg3cyJLxCcstVJAPiwX8yqvdXpcqGF0MuIiN1cKnHLlDwXKkMlnvVJd6qKKDIztaosRmR3ymI6x7zRBmrLNFJ3tYLI922SbICN1SwucepyWk5JJNPYaoKEKbiXhgMs7coJNzFGasYz/pu3Jq8FhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766266804; c=relaxed/simple;
	bh=4pBQWAkw2H/hGdifI62OEp1LIlTMchaDlsToEhoiadQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FpPvnYEETQLlWS+ujyZaVcAodNH2Kl5K7SIpM2M13dA0aAE7HETGdga+NMFeyasMUoJYKmY/u96QFWs2SgAgtWBN/g3ba6F5PFvDD5Z2t3DihUy59siCVVcVtxthEHvcWodc4nBX0YHnjt9VKvmYd+EXSakN6f+MglxSDmUAqvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=K3BWnQdp; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rcn4BprmqyMUq5pAPvBGzRscyKQSCFPp1UASt6B4whPmcU7cOoBJ915soE3nUFshQ642TuDd0TzE3KjY2kAXUGPGaKcwwgZD6eou0BgPynkMcbw4Im7alhYOvOwsKfiFbee9W0mh48W4tp86wbAVFbTq6clsuesAi96qA7gPYO3Y2wjq2B5Rg7WDmQCj/zrmuamQ7hCM8+vGsbCGmgwvAvxt1DLwFZTdIgtE0QRA5/2BnVEAfSUu8TCzHhm0qE3Ac4d8J0kZeidAJEks1M22lamXetfI1U26F3tjfuOyEkQCjEWUrKYv11H2Lh5ZU8BNBNpiWTZfnmz574UxbfBosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx3xx1mw+CRvub5cerShgbfTe39FS0t33owP54eEWLs=;
 b=vR/cQrZKZ/aSnhm8/oxJgJ2781yJaW+VviYAkX7odLE6VsgAFz9OC6R8+bpf8DYAVxu6fok9v3hVzPGedVxDcMVVS2M75qbcZaIjfyjwC9rCBT3hIjNwEQmW4HbdIqFmIsqXqmx0DK/FDSijaXTi5x5bNAh91jHDM8hC8FYbsetc2ARGpkHog3Bv3EIs1GYc0EKZEt0okGjErEadCKF7fSFz9FThqlNls1z+ZJj3wwdGN0X3XHUwt65akI+fx2WvtTCLMId86yh20ISiMvovnD6uaCdS4x/D2GSBj/UpR+FJMm0yasdom37LJqXj1IktAcDZG04vr9h+Z3rZ7RxpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lx3xx1mw+CRvub5cerShgbfTe39FS0t33owP54eEWLs=;
 b=K3BWnQdpAGPftFVVIMtkPyTioU5Dx4mXtQB8buayk6YJ3832WGRJzn8/wXTJXp2TJotlOJlpUxkt0E35hxYsJeWLhtfMf8yiMk+283AjRytlfVJYCL0dkpnnpi1MfHc2uQQ4h/OHKbN0jOe4PYQRj1NUcGm05WwHENSQCJsMpjY=
Received: from AM8P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::22)
 by GV1PR02MB10757.eurprd02.prod.outlook.com (2603:10a6:150:163::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 21:39:56 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::12) by AM8P191CA0017.outlook.office365.com
 (2603:10a6:20b:21a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 21:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Sat, 20 Dec 2025 21:39:56 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 22:39:55 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Tobias Schrammm
	<t.schramm@manjaro.org>, Matti Vaittinen <mazziesaccount@gmail.com>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] power: supply: Remove unused gpio include header
User-Agent: a.out
Date: Sat, 20 Dec 2025 22:39:55 +0100
Message-ID: <pndh5tkzvbo.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|GV1PR02MB10757:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c244ecd-0329-4a36-901d-08de40105166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xhcVeLn5hxRzny+0keaTnDpjsvlMXji4+gWj3g0fF1UmO4ksOT0iFAhKDcPg?=
 =?us-ascii?Q?Eb+xIZovyF71ujD+gRrnpUKdJGxhHKaELFjV15+2WCSLU0Y3dcxh8dkHgIYM?=
 =?us-ascii?Q?YsdJ4jQS2BJ0jt7ISWCgOPq6ryGJmzJ9/+Ri5YJQjDDFcdAsL8bmOiMFQ/rR?=
 =?us-ascii?Q?gaN6DmS3fJekecEtjoWVKl3qN3mER4bDOWkaFyZdTo26aeEM9lT8EUEGgCyu?=
 =?us-ascii?Q?Z7PWlGsJEMtBeF27U3I2Fw4/xGPxb5wJFWzSh+YBlRK1P6aI2DDXpJ7spTAy?=
 =?us-ascii?Q?JoL1J2mBOocp9lPtI484cWtzjgDX9Xn5xzx56xy/6r3QAe+fDYh8YFun1Cb6?=
 =?us-ascii?Q?NXrc7qEw8uVN4sSYg8XXaPsT1mlQyNWpm/oayHDOPTEFztbecZG03feMfmd+?=
 =?us-ascii?Q?3W7t4ITWgItV8x2HY//MRWrNMlZy9yhrFbaxPsbTTM3X3b3S+EZnYfgKbsBb?=
 =?us-ascii?Q?Oed0gAEOWS4CiT8qlxvE4e+v8zpkaeGzCTLORewclBn4K9mVim2lOE99WAqM?=
 =?us-ascii?Q?p5HzBNzu0+BDqp9Js2mqsXi+f8Kdmm5UfnDWPfuHYZFqqSQo0nqAbo9kAWYL?=
 =?us-ascii?Q?jMvG2nSn4PQdglHRuwZXk5ZaG3dfozuhv/mtJJMtUYfxfF6NGFXn14vV9Jfb?=
 =?us-ascii?Q?ZldX+vfypEnh3pE1OoU8HvBGTLvCMXivSWc1qfUHwVpN24F7bcwAErO6Vk2Z?=
 =?us-ascii?Q?eOon8jnwoCyFS3IKDCSrauA8s6lh6Nua+ulJWeH/BauHFkEi/J2s6GkAamJ2?=
 =?us-ascii?Q?VOT42sj7Yel8EuLEI7Zjpb1YvEiBvxxKIEIhf5z+ArSxsEOWmE5v9O0bU33v?=
 =?us-ascii?Q?S7zK0Ecl5Jco0jg0OSbo2eIqtZJFuqoZ7P4LVKgrXON/TsRakFpmjJEJbfg+?=
 =?us-ascii?Q?0yAdMi9d4CEDvEqiOyxaEkDDAUSMuw8wGBkmjBW8xL8KQNzyqShQiIdscpzf?=
 =?us-ascii?Q?VXovWXvtM4ZACRgKgSHJCpasQHGaxUv/Y21GbrfioVd4l6rWXPkq62lZvUEb?=
 =?us-ascii?Q?xeBygGJZGBBjBn1L/YM+FYENv1f+WXjmZ3U1lIpGeAmoKK9/BHK8EL4FP4Yh?=
 =?us-ascii?Q?RNC68FO5Nx6k7EDPsnJpPYuGfwLaIDiST7C/iGw3bqJRONxFt/fvBrwk8qZJ?=
 =?us-ascii?Q?2nUicK0vt+b0+GVDCrqBkGK+xEongy3oP9Han6Mbr+O83aoBiWPxdIsD8jtr?=
 =?us-ascii?Q?TeK0mex6L+hDIBYEtV23MyrnEGPLqT2c63cPghgBgldD5zHqpBrUNDCIJTMg?=
 =?us-ascii?Q?8gC4lLv4ml5aW0f0KREYWNcdxHzQrC6FtpMBi7Ja/bLzJFLH58E7pVlOB017?=
 =?us-ascii?Q?U5ig1b6c2Qrp6+zcLVv3ES4JOokSlminHFrwQrR3n8tDq3BTrlq+Spcrd8yI?=
 =?us-ascii?Q?BN1Krfa1u/+ZDlD3f+Rnj80Ba8fOgMH5ju8heseoudyLqhtYOzr8v/962v8K?=
 =?us-ascii?Q?4wqrr82Dfa+D9r1K5gmRvkLIWu8jkDiDUiui4+Xt0DW1IQ+LBMHTaT7Mpyww?=
 =?us-ascii?Q?thA43xPzeuzM2+OdFUMux63pmupLl64UlH2B3aTRMailLADRT898f42VBSXV?=
 =?us-ascii?Q?xfUQhFMlNwzE1/G7l9I=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 21:39:56.2103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c244ecd-0329-4a36-901d-08de40105166
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10757

These drivers include the gpio header but never use it. This patch
series just removes this unnecessary header.

This issue was found when writing a new driver for the upcoming TI
BQ25630 [1]. Patch adding support for that one will be sent as soon as
TI releases the datasheet publicly, which should be anytime soon...

[1] https://www.ti.com/product/BQ25630

Waqar Hameed (5):
  power: supply: bd99954: Remove unused gpio include header
  power: supply: bq256xx: Remove unused gpio include header
  power: supply: bq25980: Remove unused gpio include header
  power: supply: cw2015: Remove unused gpio include header
  power: supply: ucs1002: Remove unused gpio include header

 drivers/power/supply/bd99954-charger.c | 1 -
 drivers/power/supply/bq256xx_charger.c | 1 -
 drivers/power/supply/bq25980_charger.c | 1 -
 drivers/power/supply/cw2015_battery.c  | 1 -
 drivers/power/supply/ucs1002_power.c   | 1 -
 5 files changed, 5 deletions(-)


base-commit: fa084c35afa13ab07a860ef0936cd987f9aa0460
-- 
2.39.5


