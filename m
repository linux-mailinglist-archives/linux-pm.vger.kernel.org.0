Return-Path: <linux-pm+bounces-39756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E4FCD388A
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0527A300EA01
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6931A238C1A;
	Sat, 20 Dec 2025 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="XVbatNLv"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A974A21CA0D;
	Sat, 20 Dec 2025 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270791; cv=fail; b=Wd3mavwizuHvkJyGsHEFFd+t0+hHNbyMUCU6tjPzILioJyqLbEdMgjskr6ZWheC0XyqDxFB1xNdRIJKd/S9eEfYYq3FiWgb0aMq3RTNZkx/1VybnEQh5Ofyo+iFq9A7kqP+njBSfJf3DC03xg/ylWLm+p8AwXVStgUpWU3aAK18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270791; c=relaxed/simple;
	bh=qjZ1K70xzXA2RaJRN01Gh86KtBIQ9aQFbAztNO6rwZU=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=seLWueiVl0cXKmfwoF0k4cxx/87fua41IOXlSqx6nQ86PjAANzjTdVrvUG21poAW94UHTvs0lbSURCibUiMQsKU5i+L07TmVOvaSuN9dhuYvcWOSUn6dkb8Pw0fkK0N5Vl4TbZUIjAIocWXQ1PvAZFmsYnY9a9E92yNyGY6R+l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=XVbatNLv; arc=fail smtp.client-ip=52.101.72.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJ9y6IEP1GB+QiNWyXYiUlYv0xfKrYjqqH0cL5flApUu9Bfs9I/sIc4aClGQs4Ce45OjPjqTPvp7d6r7ahdBuC7uiIfXSlitZ5MhPQNSpEr8QsJOIAnZGbbtaMaBeIFmrWI/c/Y5iwgerNE4Zhqj+dsWnSs8w773f/24J0Y/UA0YtqU5qzAkslXIwOdQv4rKT5caxbvSeKnVzULZ41d070DrgwDMJw2a0uW91r27zIt12grnFr7uBEt+wpqhRo7VzeuBAXImgtvOSLIJrFDl8xmE4Lp5Bspr53EACTxpVu+lC1Vwvkwv7fUtIVCAHnGHKpUT9fJIKRn8+XldV6xsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrR939cA/5ghlY3aCXXv0ZtsduiEycgeD0VL88Ojr0k=;
 b=BmbaNNupVX+NDdaRb58K+WHWixNsZf+E1fl6ALKB0Hz738VHgg8gNX/acl4J+2dEUuvucTKJ1yNRpZUdkakvEb2N5YLpLMfJ33GS+pqedjp2tCqEWlegxp+RsnhSyu60OtN5lD2yQ0CQtNiNHtiSDCbVwBxZ+LoUfPxvcGooPlN51zj1iGXFdCl5tBM9jKPE4ath+DdhN5chv3nszdLuLxL5B+qmD1q1F3BSzl1TZfRBgXMgbfbGfpUPUUa2vlVtU747VOWJrov1Ddwqbw+Ba0CulkS7BoAV1k0rcfcMp4lI5Vfi69dzuZw2/9a2M7gKWS2CGkuUON9vXVbuuCQ0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrR939cA/5ghlY3aCXXv0ZtsduiEycgeD0VL88Ojr0k=;
 b=XVbatNLvu+1ReyC4AvdCvx2m6csoxvFL9VVZcjdoMQ+4kp0Uck3+1OKjOA518dYPGo/aMDNYEopsj9WTrtwhJh1DbGq+2eOjVCbquZZVDG84agpIaQGNb1nMaQCsLXaJrQBvcqVhJ6zsmzpghikp5inB6y5uX8ThETrIDu4JLro=
Received: from CWLP265CA0417.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b6::7)
 by AM0PR02MB5890.eurprd02.prod.outlook.com (2603:10a6:208:185::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Sat, 20 Dec
 2025 22:46:25 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:400:1b6:cafe::1d) by CWLP265CA0417.outlook.office365.com
 (2603:10a6:400:1b6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 22:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:46:25 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:46:24 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Anton Vorontsov
	<avorontsov@ru.mvista.com>, Marek Vasut <marek.vasut@gmail.com>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] power: supply: wm97xx: Fix NULL pointer dereference in
 power_supply_changed()
User-Agent: a.out
Message-ID: <cover.1766270196.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 23:46:24 +0100
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AA:EE_|AM0PR02MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 64471465-f23a-4090-a666-08de40199b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kB2IymhdYZnzkUA4k2rX7Fz0aFZR8de4sr0zOxxxOdubwWSkyB3ZVerxSKNd?=
 =?us-ascii?Q?HTpjLFOzgi87fj139IOQfFSBC9yvOyz2UeWdDd5GNw4EBH7gyT7ykST+Vc2m?=
 =?us-ascii?Q?5UYKcdugQuPHI6gJInfxck1BBKLZR+rn1MLpk4seXXCyeoGjXhZ8moleLXQj?=
 =?us-ascii?Q?mJN1Nv65mOF0gXmyy7ZTpNut9m+1u02CAivOlPNMajhBYy+Z+xDt9+g1wwd7?=
 =?us-ascii?Q?xbCOOvXTmIQQ92MGpkF8I0m1Qti9vmuKFlidJccV4J/CNNgzmW1rWhOouzhO?=
 =?us-ascii?Q?alq9seN7XaiKpicVzgkSkuqAwjNPSKdSIA2qKjYl7ZZtq3DmVYbNuMfEUkpL?=
 =?us-ascii?Q?FriL4pExXBdeal954OLGNGm9bXDvFVbmW8pgjolTlL1X4tro0Sml5k/heINU?=
 =?us-ascii?Q?TBwzBGqXC342mqTnE+2HWPBwWIcb+P3upXN4FneXBoxb/FzRGtzda8a6jRNV?=
 =?us-ascii?Q?z/04OucDQH+6FlfY4BS9xwBLekye52cL+bA/e3oI9bG9Tg0+X9t7seKpD+v6?=
 =?us-ascii?Q?PPc98+E85apvHoYsrBPkYN4P2Wi2lSYIjOS2Q4f4feI+6KkQ017DUjbRJCrS?=
 =?us-ascii?Q?sxqCdR9aIAPlBhhc8/ka82S9yREA0pNEZ3Prj0+obzJl+bTdB0stRNq8vfQf?=
 =?us-ascii?Q?/qfWdM+OiJiMTxjLCEyLtLfT5JZQmE5GZhr79i9MF3KrOQwfsoIlrzOIWYXk?=
 =?us-ascii?Q?IrdnAs5vAdaKC0VUCTdioMII8pfRxQEqHopvv6umj5KYtGyeT1RlF0Wz35nP?=
 =?us-ascii?Q?KYFt1ZhsJO2FlGoVo4rkTOmEguMH+lWOfOQqVux9KNV4WDG9nSggRLetqJBK?=
 =?us-ascii?Q?x1KCrm/LD+yaOaYa0pMKxb/LufoNFaegSlgsO2k91rn/rF6XZauFC2ypjMAS?=
 =?us-ascii?Q?PcjctzxheYQpDuk6+QAzkAObMM6sFbZi1+dswx4yth8V3rrdLOunlbRk+BQb?=
 =?us-ascii?Q?xGm7EAvEwFdefrAN2Km+ZTikUfIgwls+4OuJK2gMSamcc1+5a6hynvON6MV2?=
 =?us-ascii?Q?i3YCErvy9dcF2TmG08W2gOqLjCwrSxoxUsBVxxj8wUrndEUNflSN/TRPZPkq?=
 =?us-ascii?Q?VIgHrSVfXjG+CDaUNqxROcxCjLaR9aHbrc9Qa0slWOoYB38+YsmrcXaJYfbg?=
 =?us-ascii?Q?RMpyuODnpRCj+RytAXxXDok9bapsheoCPz3Ch4pVdsvBi2m0s48MhoVv8K0t?=
 =?us-ascii?Q?9af/rUEgeUm4XDMhZi14uVxND2tFzLKguE9vAeaAN4EL1SCHA/sEbUmghkpG?=
 =?us-ascii?Q?zcQXpnXvrzbhvHuDvONSIVtaObsODNQTpdzkYSDJEWAW/toXGt7BqRfAaPlY?=
 =?us-ascii?Q?vidU2xaI7paCEoX0MRk10AHUagWaiBh+Ft7KiBrV+/nkoE/sTcFKs+09AU0l?=
 =?us-ascii?Q?eMydXfBa/MyPnN/gPRJx4+PlZrJSKp4VGsMUMOy2PisRm4/oegH+8mUsvAR+?=
 =?us-ascii?Q?TW9DQm1iQlkkEWExCpGEwgpfnjqQV2+Hir1YVIo+WWVb1bx1GYB7MNawCVIT?=
 =?us-ascii?Q?c9JnCQMrUdRHT8QgFIPWYYRg+IKITwwOv6Vcuj3rrYHm9etiFlfmrsft2ehv?=
 =?us-ascii?Q?gDL6AWuV7nXZPJhOF+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:46:25.7180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64471465-f23a-4090-a666-08de40199b55
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5890

The majority of the drivers in `drivers/power/supply/` do the right
thing when registering an interrupt handler and the `power_supply`
handle; namely making sure that the interrupt handler only runs while
the `power_supply` handle is valid. This driver requests the IRQ a
little too soon, and this can lead to a nasty NULL pointer dereference
as thoroughly explained in the commit message. This patch series also
contains some other related clean-ups that makes life a little easier.

This issue was found when writing a new driver for the upcoming TI
BQ25630 [1]. Patch adding support for that one will be sent as soon as
TI releases the datasheet publicly, which should be anytime soon...

[1] https://www.ti.com/product/BQ25630

Waqar Hameed (3):
  power: supply: wm97xx: Fix NULL pointer dereference in
    power_supply_changed()
  power: supply: wm97xx: Use devm_power_supply_register()
  power: supply: wm97xx: Use devm_kcalloc()

 drivers/power/supply/wm97xx_battery.c | 40 ++++++++++-----------------
 1 file changed, 15 insertions(+), 25 deletions(-)


base-commit: fa084c35afa13ab07a860ef0936cd987f9aa0460
-- 
2.39.5


