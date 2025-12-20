Return-Path: <linux-pm+bounces-39736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E797CD37B7
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61EED3002768
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 21:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410452F3609;
	Sat, 20 Dec 2025 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="C+NWHscn"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8784E26ED5C;
	Sat, 20 Dec 2025 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766267654; cv=fail; b=qkAUMPxdZvISAMVBfGZ/kKPwPXivwA7YM7je03T6og+uRj4W4MUy7l3s26rx0BtOQLCcufpPJhf+/S3VD2tsGvsaLzsraBENDphYD/rIofSOX22a4/dtAFdBLis+7Z4UKqx6fWoDFnNLkjVO/OJc1U7sr4kkgtMweL5mkZfnFgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766267654; c=relaxed/simple;
	bh=4pBQWAkw2H/hGdifI62OEp1LIlTMchaDlsToEhoiadQ=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=SlNSsEzbCG/QvgavF6Ca2BGGFGVqO6r2UksgDPDivuGpZc1KDsJwyL2AX/LX+hYOSetsI0lTEsC+ToSpYpBPWjTiGfmnTmbFMamwpt0jhmNTXFIL6qVc+IseCr0RcW5CNY4bE4pI+ixqSJjzEpsXVxOAe+8lfkuwxBlshU+tR/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=C+NWHscn; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8IP064Rp6wP66s1pX8yYneTnQ78Qb7BEv02N61Goci3YncdnKnuMPnAsmDls89MtJmasNx8MguOBUdK37HDT5EXkRra0HQJYReplGzLtBStLDLWDb93fc+XpSCwYPhEmFI50Vx9jlVrtsnfCYhbka5Tdy9XseIjDrsmtsiMs0QqfcH2LOHIRDvHgc/+o1qek1/pB6P8WjCMW6mztbram5yduluEzwwGCeTlBQgUxmjt71OqtCSq6YAxcfsuzH0tBb8KG0TMwre8qe3Yj+s/dCC0n1ESPUbjiH4lb6FcGjk279ATeM1OCfw/E5HV2fSJWhZw+zs/rDuHhuFPp5IksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx3xx1mw+CRvub5cerShgbfTe39FS0t33owP54eEWLs=;
 b=C9RN3Yd+OdHnjcLQzGHBVk/lxr/3mjZm4zf1gTcgRYn3pmX2Gh8zmBu4B2ivEZFJg6a9ONlQl1KlGS0E2ZUte42DRgERHBhdwKzL7gjVNGBz+ZcMdY2rgX7LUzcOwMgiCE1ezusxIfxBNLURR+O4P0qf/fayleBfcOscK7f3Nosn1kbXNv/Hm83obP1vafBfjI7lkPco6Yn5vlVYhQDC09EbDk1NiaraEmwl8xA/DQBAw5l1BanLxr8sSFSd61RuKZo/Ysxb/rgqr1Cxi+GN5wcpEUNdW/ErBPtSaHE9lku15fSMjnZXToJ7BBGxg2yv4ePvDmTsBF+MXZnKHX045w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lx3xx1mw+CRvub5cerShgbfTe39FS0t33owP54eEWLs=;
 b=C+NWHscnlTA6o505AfR7Jg/A2M8GyxuES+fDwIZUtWHDfi+ilca9SvxdZHWOEBXRvhs3jXfaBhs1d9UDoDr7lw3DFV60KSXsFwyDQ9nmSTwTL6F7SX21bCbbhK31nOsk61Dqm1GRV+weqCegrj4phKmwTCD8ayv90JRfS4B1OIg=
Received: from AS4P189CA0004.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::7)
 by DB5PR02MB10454.eurprd02.prod.outlook.com (2603:10a6:10:48a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 21:54:08 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::c) by AS4P189CA0004.outlook.office365.com
 (2603:10a6:20b:5d7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 21:54:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Sat, 20 Dec 2025 21:54:08 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 22:54:07 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Tobias Schrammm
	<t.schramm@manjaro.org>, Matti Vaittinen <mazziesaccount@gmail.com>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] power: supply: Remove unused gpio include header
User-Agent: a.out
Message-ID: <cover.1766266985.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 22:54:07 +0100
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|DB5PR02MB10454:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2308c3-5357-4fcd-e626-08de40124d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0fmkC37SF/pvqrruLwMxRhf77UWt9JxyxWvziE7j9sr/PYy2WVVmOh0Up21K?=
 =?us-ascii?Q?pZEmm5Se4uSnoz9yTk0Cn8blH5q1YlSyrzNb9BGgB/b9HgdLDoJnKWWR8T6z?=
 =?us-ascii?Q?Aj0x9J/m6LdgsvJ6nibIevv+j3fxFEXt/0lGiU2VomVXPsEDszymgNzaAP0u?=
 =?us-ascii?Q?BIYSpcHxsl+ObPE9ARXVmZbDLDDc4oidRYmGgZIdXYMrTPvAGFVTJ+mA+tqk?=
 =?us-ascii?Q?Qk3i+ejFxXI82MqS3c/2AA1MHX7UDf1y//HULC0ixnwxdBmvyip30PU7yXR4?=
 =?us-ascii?Q?t5E7hZlKr0YQW0X+17VtUnD1HfbiX9CeJ34UhjoprSgRZUdODmu2PqzzzBDy?=
 =?us-ascii?Q?42SKJ8Ku9YMEmB5CHRx4yi3kqyRld/FrlAwoUoWl1HOoZFCWPLByA0RZlhzG?=
 =?us-ascii?Q?sNjWbwMT52HnIVJExH24lh1bgh3Lq2InCeaS6ryDPMYVKaSSJwztYXEgBWsE?=
 =?us-ascii?Q?phuCAoBYBZ0W3gNcCIQKZlUIzED6PvnEb2O0sosbfciQ7xuuARce0rni/uOy?=
 =?us-ascii?Q?A8Tg/hh+wmB12Ab7Qf3gUW2qOeaPCtqTXjC2Q7M/GGv3XhN+vJRu1fOh22sT?=
 =?us-ascii?Q?MTwdtSyuF2qZ3KAJGdZBnJM1/7QxZ0Ui0bu30cCRumVRcuswxaKqO0yCJayn?=
 =?us-ascii?Q?wOXSyg0dgSQ4hRAMqrJWnHs6L/f+tMjlv20HWDgyLLeloNwC59qUhkrNxkba?=
 =?us-ascii?Q?wQFXxPD8+jpgNI7U2cchkaLeHwv9rYQYNNkld8SC8dx9e8lz7Vffnce7iIKQ?=
 =?us-ascii?Q?t5HTghBsMvZY5WK8Wb6joPLI6vygAxFn1YMeJ5KUy2yg8Wv6maVhIJXc5Skq?=
 =?us-ascii?Q?hxn68YWj4davdxg8YkbXKPhKpnY5dKNDKtKqh1383xApv6FslPz2h67eIemy?=
 =?us-ascii?Q?GHattZ/Oy/Z9POONHImaRrjM8d2DnnFS/Z7pOaBDvRzxuQR9c+pgjBUwGYuf?=
 =?us-ascii?Q?cV87exlMEL8t7+eSIu5pasclyz/Q4YgbkPR/eq1lwliFy/gickTkCjKExmxn?=
 =?us-ascii?Q?EBoZ0cPpMvlKO4PyFKoY3uQS6UsaHWwOEO0MNcu0fpqMv5cBuZfH2sG12Reh?=
 =?us-ascii?Q?mLfiqm9F+Wc+i1EOb6UZ0Dc1Q72vPd0PLuA6duygnK4TPGpBnXeDod9RQMj1?=
 =?us-ascii?Q?3qz9rsRhttNHXoSUC497q9aynLcQFQg/Mezzw2q0g2ZJhcqaCsRHK98S0XfV?=
 =?us-ascii?Q?SoLaFgMbCvGJ/fkQOZ97Wuu2ZM0uSf3qGjXC6Ub2jxeLJQ29a/iJhOIGYrjC?=
 =?us-ascii?Q?WsqNJi15qne0n0yoZ9mF4kkUgGPaopG1Ch/b5XTHpd28wrtOfW56QEdUWsnI?=
 =?us-ascii?Q?nNOxH+ulQSAndBb7lfxaJGiWC+wK9UzYXCrY+dEtofp0LrgXbrAxMx2+iXTr?=
 =?us-ascii?Q?AHJxlVqxq/AI/rMSyIw5Mo8Q0KkAXTycaBGRZ1ojZjZj46ZvoQj2t97aWJKv?=
 =?us-ascii?Q?1RC7DmghNO755u85QG8ILawG8CtyP3VIhFLj2jmiv3EOrLCVHzCukgRyaZaJ?=
 =?us-ascii?Q?ReSHSs7TVvbvUv9rimeOeZsrRTLt0satGF0/mPRFwVLCbBVkK0rDj/QpSK+Y?=
 =?us-ascii?Q?VFU2DkxtDgpqww6qT9c=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 21:54:08.7416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2308c3-5357-4fcd-e626-08de40124d8c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR02MB10454

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


