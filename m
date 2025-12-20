Return-Path: <linux-pm+bounces-39744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48959CD3833
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61C72300EA08
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4102F3638;
	Sat, 20 Dec 2025 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="MuZYiLyZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4C23A9AD;
	Sat, 20 Dec 2025 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270164; cv=fail; b=DKKLueBQnnf6A1sTmfUF1eZ8GHuzivtrAaL+Hmicg8FP4vOxDEK/dvf3XT+VoNTT7V+0DcWcXEz4AfbY4rYf3Tc9U7HEGBkmhRtWm6SyF7qQDDX2X9c2Rq/74G/pMuly7qf35pw23O3z2iDq3m8+1FnotUyb2AYkmkes9XNAQvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270164; c=relaxed/simple;
	bh=Q9EfMRvuadjccWMXUtoumHe+igptqA+5ilPTxmj4Qkw=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=R4SclGAgeTY5f1LS26Rc4y1S48YbIEeFVpF0vIUat9Q2fc0HqOC/KEL3//nlqzaGn+O88ia2yM02n/u1lbeXOsds7sNfR/yySTwfTEcyh/JzlnAURcaM8NuB9dZw/0l3v4DZYnxtKgXnJldwbXFMM5AQxw2vgtLwVxwmfx8A7Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=MuZYiLyZ; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqXUR1ExOjupTkyY7dOUQPsCWwV/KqGY23EHFKfZSAiKLHZQsmwEnPuu+UJFxkNe/tinMa1q3lIAExoYZupqlcUq6IwbLif8KnCa18X8zzB5tFiNiOsqks7a7W7lUX1PwkHVWidljaU7enfku91LU2HlbKpX8x4+EQSG+bTs8V7TuAyO/MtNqQv0/m588jHiZ55U0+K1N9qT7w59c8pjrrm4DduxzgX0wYCKpuDqisE1vNr3aG6+S3Iuwhf2DJsKtNs6VSzAGN/5nm+IeU9Hx8/JCSJgHUlPG40/7Oo/BetrV8GeqZ6PEk9gU14G+LGMnCkxn84wPyAGoNgZSIfjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6SIBZimb+8gqWhQUFGRQBwSsp4EiUAbdvqcovGdedg=;
 b=l0zkeY75slq5BQ+wr5BDtGtqf+Hn2PQxgZLBiXpZSXW3VTKI2iPzjc4jJLal3Bw5adrAwJ/oytESghA95XhaP2NM3gpU6vVVFr7mdINT8xpgdb5UlolKWiim7g4pQdJzA5tOnCvdRkFosAY5rzoAFsH9PRDlUdl8dlH/oKGXF7LQi2lOXe/4aIdUVlAsYjze3TEDn7XpQtT1YMpi91f6XOj+HWhVWg8pgy9l5A7A4s5Zg/nV06E4zxOTDsnJmsE/h/9dtCLbcCszNYZxWG4VVrWE4xV1rdD+2kKebaqMaIHkauHOnn0dhfE3SAVymlY6UoeRMvSwgyiQTQbQ9zvgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6SIBZimb+8gqWhQUFGRQBwSsp4EiUAbdvqcovGdedg=;
 b=MuZYiLyZyQ3eJrQTYU//e0VW0G9z0mq1plvQ8yNg7QA1Zg8Ccm16RxeO2qk5wc6oFLZ4mfEskxN6HOWfcX93km3n0E7gExh1iOI03Oj2W1GtldoaMMSGZ9wAFrGFFy6KJjiDh0HlhzqLWSkBLUBwHuyvKDNVMME2AiakzeIzZ8M=
Received: from DU7P194CA0023.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::14)
 by DB4PR02MB8750.eurprd02.prod.outlook.com (2603:10a6:10:381::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Sat, 20 Dec
 2025 22:35:59 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::42) by DU7P194CA0023.outlook.office365.com
 (2603:10a6:10:553::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 22:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:35:59 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:35:58 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Linus Walleij <linusw@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Samuel Kayode <samkay014@gmail.com>, Wenyou Yang <wenyou.yang@atmel.com>,
	Ricardo Rivera-Matos <r-rivera-matos@ti.com>, Dan Murphy <dmurphy@ti.com>,
	Tony Lindgren <tony@atomide.com>, "Mike A. Chan" <mikechan@google.com>, Jun
 Nakajima <jun.nakajima@intel.com>, Xiaohui Xin <xiaohui.xin@intel.com>,
	Yunhong Jiang <yunhong.jiang@intel.com>, Tom Keel <thomas.keel@intel.com>,
	Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>, Nikita Travkin
	<nikita@trvn.ru>, Anda-Maria Nicolae <anda-maria.nicolae@intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, Phil Reid <preid@electromag.com.au>,
	Alan Cox <alan@linux.intel.com>, Sheng Yang <sheng@linux.intel.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<imx@lists.linux.dev>
Subject: [PATCH 00/11] power: supply: Fix use-after-free in
 power_supply_changed()
User-Agent: a.out
Message-ID: <cover.1766268280.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 23:35:58 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|DB4PR02MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c17c9a-bb82-4bb5-dce8-08de401825cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n/Dexb0MWwOvmw/Msgy5qRgBOdSaS9sCa3sfGNR/ptS7V13QQYjlChG2+rpm?=
 =?us-ascii?Q?TXBoOOKv+Dk4Itxinr0UoIS4ut/hehm2FDzv6YdJi2IHL9mmt6hRQckFTrKI?=
 =?us-ascii?Q?+PqwqZEJJpMUCAcpTAeCJ17pwkPEaEu0xC3OAQd946kcA29pFfSXtoj517e9?=
 =?us-ascii?Q?MfTEcojN+Bpb/j3P/dRwDzHzHMsocrsMXNT2x3RwcDo2jlUJ0Qpg/XAlVX2/?=
 =?us-ascii?Q?mOkQEObDFolGt5UP9h/DUEE+QP2U2lvZoWXj1NKN9sDt2KCd5W8Oi6QUdYxt?=
 =?us-ascii?Q?rQrQNDblS6fTNZzpT+k9Uxr2hJJzqSspIZMAcNATuzcadvVhqbVmWJVj3J3Y?=
 =?us-ascii?Q?+cClcGhczVbCDuiSIbwQL7jvGc7JZJwS2471WjrblDlvFWVtWWqnn1K3GHhz?=
 =?us-ascii?Q?7L5OT59lvtsEu8glp2b0hvW9tGuudYwzCZbkt/OKruK8fDu+82Qsh/YdoyPy?=
 =?us-ascii?Q?VnIdWgir742na8Dx9ZfTbuv6f6Hj+wfuAZshP1hxUycwZb9N7gjk4wwFwvGz?=
 =?us-ascii?Q?5xxejipkKnwtJz+nDq0j5kC1Frun12e+t69rZg8NUi0AQm3ecKyz71KRYcHb?=
 =?us-ascii?Q?G3ClBXosxkr6aICHdmt1GhpdWAloPlEMMWZO7zNn6X6dWRs7kZXTksUHhj9O?=
 =?us-ascii?Q?Y1RDP9p5DZRFgVWRHHQ//cS1LD40tpnpwYPUbJiWXEpxWNYAQMlc4xDDGP+v?=
 =?us-ascii?Q?qbb6FZ42iJlh9ZmOLj/lQpHQM6gksvYhLTqXWeEwVfsQqAKtfophz7JbKMQQ?=
 =?us-ascii?Q?Ucd1zs+w4cuYz+qnyejvitaojL2P9nVo6P9p0xcjYIMblQ5zPTUEnFRMFaOw?=
 =?us-ascii?Q?9iYhLC/eSMjZxtl+zS1EjvROdYWPsFvAWQdQmn07sRv986hS7cjlkPReL8Oz?=
 =?us-ascii?Q?5yWA5Pd0LiOkZaoIYBEteGm0nmLEyt4dPZ9tm0ExvUkgMyb1ck62ZhH7IJ92?=
 =?us-ascii?Q?B5lnRmqgMsbxdtczx20Uo58IfaIay0zfLdyNGMdFyrhd5YIifmR7y8a4u+rr?=
 =?us-ascii?Q?Z/etvJS9pF4hdnWFasBQKTiGIBpXOuqukq6kSzDxlTV0worJhjb5b+7qajif?=
 =?us-ascii?Q?mOGJcfXRShacY0ahd55vGkhTgaY2CZ46sIuLcnDDYyV5Ev7jG4kswLpkmcc5?=
 =?us-ascii?Q?FJ+RHLgNqflLFwSFXc5R/PHOJaXRaR8dZ9JLIU3e2MlKxNb9CoDGxwFR14AA?=
 =?us-ascii?Q?KklLZpj2MUUoXpFz9neEG38onYrYmEV0zeLpZtyQXhHWtpeDcuSlmZ+Z3mJd?=
 =?us-ascii?Q?lHV8jCQzKHnAoccnHBiyy/08kWZCBfEaENaqIPV1JB+DK5XarV3N2U38ixSx?=
 =?us-ascii?Q?kR9cIbpEXBSitpYe518IuaHyuzFr2EDThRJfqLLj4hNz1dlUWESNiOjXSVs9?=
 =?us-ascii?Q?243LkBmrUKwpeAzY+CZzCqm17KkMSZFSof8X7hyXW1alEv4XVjxaayM6lugW?=
 =?us-ascii?Q?9C2LOn8USCzdvZPab/lQ1N7GY2UDfKGCIqVzkmOxsJ7LcRhuqrsuOMIGOZx+?=
 =?us-ascii?Q?ihjhdS5xdiD7B4CiWKlbuc+XUhf6+vRr5koMQIkgDuvaHJy91Ap4XwqU1y9J?=
 =?us-ascii?Q?sIyYKeCknEPfi0rDtZT7SgOoxs0/kxPZz5bcHdOE?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:35:59.0157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c17c9a-bb82-4bb5-dce8-08de401825cb
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB8750

The majority of the drivers in `drivers/power/supply/` do the right
thing when registering an interrupt handler and the `power_supply`
handle; namely making sure that the interrupt handler only runs while
the `power_supply` handle is valid. The drivers in this patch series do
not however. This can lead to a nasty use-after-free as thoroughly
explained in the commit message.

These were identified by grepping for `request.+irq` and
`power_supply_changed\(`, and then manually inspecting and fixing the
affected ones. This issue was found when writing a new driver for the
upcoming TI BQ25630 [1]. Patch adding support for that one will be sent
as soon as TI releases the datasheet publicly, which should be anytime
soon...

[1] https://www.ti.com/product/BQ25630

Waqar Hameed (11):
  power: supply: ab8500: Fix use-after-free in power_supply_changed()
  power: supply: act8945a: Fix use-after-free in power_supply_changed()
  power: supply: bq256xx: Fix use-after-free in power_supply_changed()
  power: supply: bq25980: Fix use-after-free in power_supply_changed()
  power: supply: cpcap-battery: Fix use-after-free in
    power_supply_changed()
  power: supply: goldfish: Fix use-after-free in power_supply_changed()
  power: supply: pf1550: Fix use-after-free in power_supply_changed()
  power: supply: pm8916_bms_vm: Fix use-after-free in
    power_supply_changed()
  power: supply: pm8916_lbc: Fix use-after-free in
    power_supply_changed()
  power: supply: rt9455: Fix use-after-free in power_supply_changed()
  power: supply: sbs-battery: Fix use-after-free in
    power_supply_changed()

 drivers/power/supply/ab8500_charger.c   | 40 ++++++++++++-------------
 drivers/power/supply/act8945a_charger.c | 16 +++++-----
 drivers/power/supply/bq256xx_charger.c  | 12 ++++----
 drivers/power/supply/bq25980_charger.c  | 12 ++++----
 drivers/power/supply/cpcap-battery.c    |  8 ++---
 drivers/power/supply/goldfish_battery.c | 12 ++++----
 drivers/power/supply/pf1550-charger.c   | 32 ++++++++++----------
 drivers/power/supply/pm8916_bms_vm.c    | 18 +++++------
 drivers/power/supply/pm8916_lbc.c       | 18 +++++------
 drivers/power/supply/rt9455_charger.c   | 17 ++++++-----
 drivers/power/supply/sbs-battery.c      | 36 +++++++++++-----------
 11 files changed, 111 insertions(+), 110 deletions(-)


base-commit: fa084c35afa13ab07a860ef0936cd987f9aa0460
-- 
2.39.5


