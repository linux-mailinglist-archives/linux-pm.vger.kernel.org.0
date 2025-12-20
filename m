Return-Path: <linux-pm+bounces-39738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFBCCD37C9
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F28F230142CA
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 21:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB902FBE1F;
	Sat, 20 Dec 2025 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Lmr6/SbT"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589F2F1FFE;
	Sat, 20 Dec 2025 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766267655; cv=fail; b=KiGNcY0QdDpJPEwOYSji5CiKXRxTeInIiAPZ20KMaTKQ1Q/9RWPyTMigCdGK/WIa7BdOrR9aTR0hbSwsqMu+rTd9eWAg3v+8WNZG2DX3m5dd4JOFtuqHqug2WIr+/3yRTxcXGlDBgeq2xIty7Eo3RO080wiT+6SSSFk8igg3cDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766267655; c=relaxed/simple;
	bh=HaZ+btVsSSkOycn46ZgPFoo0OiMCKsZCWcp8JRrf1IM=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=jI6OB2GoJQ34CouFwWD5V8AXct5SgZD+HslAzUg81HRF8DuP9Ob8F98h5iqOfEDSqrJcRvGSosOyFYRtEL5G1fOtZbqLvFHlGj8XN4klwXULv+EdHe0xBYYu/tqF8sqzbSCGiMaYQDouOrz5ZfQntjiBW65C0iDSqgQIn1mauaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Lmr6/SbT; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOLGOMJH9U2S26kfyOwoK84usFGbW9ykNebtXAYsyLyPoiq0FavW7yk5qXe9M0WgDVQ5CQSA38DejkqzxejQlJcTlf7yzFs3lXGpgju7c4iQQ8w5r1xTyQswWmwXPrZkR9AbCcf1GstTmWxwvgBCl5jhiupD22EyqToW1HQXgafl1vpFV3lRpVxbeLYXYgHUUZyiqrtpNjd+VKb38+ANdo6WUr+FhrE2OP62qe2kqd3pc0ufSwdUqlBNMZz+tg64/oQpeUA9Uh9bouZdsPEIDMbo1LSAcmsFO5sss+II8KQhja6V5t2bxFFQJLuqVJbQeuNJpE3fL25sQ3obxRcdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wff7TPCndBNfAhqgFG3r+4GuCKBzKD4rchHhvvMDhRA=;
 b=c9GXt1207HiDaTe3zY/zffL3nvBNLL7jGakGo/jXvXftHtQc1qF/P8tnIkcIFfSppGEwdCJhtZwHPvYJgYtk8gB6AoMmiWM4vTwdpgjR2wR/IEucStDJiE8BjAl3QKusR/Oc6NT8HiHvC2y1apuXM6ZWXFxydc3xNpE5E2bTzJbY3D0lRQ7lLA4X8y/3Fc5lBvFqbYFsW4SZPBKsZ6hdjos+cHmwJeDZf2vkGUFzRhGKq9obW688naoSkRdhtqwQ0+3ixxtdAXyKcEzVJ9UG75Oo7Q6eq6Z1kc7MAh+dzV0/ycsn3517ucvaLHlWdi2qVqCh5DdQtl329ESu1YiWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wff7TPCndBNfAhqgFG3r+4GuCKBzKD4rchHhvvMDhRA=;
 b=Lmr6/SbTbOMygXzoKTMkmAjkDdlVz6H/tn1f6L4WtaaAbxzB2hX+lMgDBhc0EuNd0mkf1s1YbxvyQmg0B7mOqJCq3xpfIc7vd0jczC3EJpVD6LRH6jP6qLdvh/iUSs5izUQEo7cMcCPY+qro0lO6VtjRVvdZWIDVefnZWHlkCfw=
Received: from AS4P189CA0013.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::16)
 by AM9PR02MB6627.eurprd02.prod.outlook.com (2603:10a6:20b:2c8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 21:54:10 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::4d) by AS4P189CA0013.outlook.office365.com
 (2603:10a6:20b:5d7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 21:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Sat, 20 Dec 2025 21:54:10 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 22:54:08 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] power: supply: bq256xx: Remove unused gpio include header
In-Reply-To: <cover.1766266985.git.waqar.hameed@axis.com>
References: <cover.1766266985.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <730eb504f7ae9d3fcdfeebb544bfe115c32e1064.1766266985.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 22:54:08 +0100
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|AM9PR02MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: f260b839-d649-477f-1381-08de40124e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xsgXuis8cxJ2SPtDJmLaWitDLqAu4cwJNXtu451mRAjVLTaY3WxZkUdE9n4l?=
 =?us-ascii?Q?tPZApGisiaa2tJelW9RQjwBYmpqzVbSp1XyvzwOwApWEWtjbOF96pDqx0kud?=
 =?us-ascii?Q?3RIX//cbbXYfwvPZaeWRd6ZA1exy9qQvlpHq2Kj/Cq+DTsaRsqkxJ6aPE5z9?=
 =?us-ascii?Q?G5wJ59Hbq4Ydl2HZaThtSJfFxnNeVFDPoahqj33aM75Tms2f30/VDahG0qrH?=
 =?us-ascii?Q?TFNNO37lrKU7BVp9AQ4r1kUtKMy/kIYqr5rBP4X1+/q57ZV16TTXMXf3vBNq?=
 =?us-ascii?Q?YWmke6r2D/cG6Wz5seY9y3RqUM/gABRnJja/5iqRNfDXEkNv00g3jBOZ68C3?=
 =?us-ascii?Q?VFOC9670J8leHHvx/pEQQIY9aIneRcEZNcwGDH03GMYnH+OUn4cyk4W5sDp5?=
 =?us-ascii?Q?lTRMhYQ+HzD2R3Z4rAevUA5e7uTiy75dVlopRgNCgTgZCZaCjutgRDeZdLVr?=
 =?us-ascii?Q?EUlzpTfJTPTQc0l6faVFPpCQq28kXhy2vvsd3CubkCNVGVe4VZmYMFmDPUB6?=
 =?us-ascii?Q?R03jQ5jEXuQB+Eh6qhShduumUZQFOdLyRB5mEEBHB7MQggodiAxE1/j5CQHE?=
 =?us-ascii?Q?EV/hHdAg1gbvCQ9KJOl4YYBURrU/LM66SxkrH7u0dpKAlJEBq4QCIcEC8eIY?=
 =?us-ascii?Q?mcJriEJg6RQF0oxEvwaasNTHi2EBP64DmVJstrefiZFqNUKOGOyXNfkO6O7g?=
 =?us-ascii?Q?aiI6mBu7aA6Hj07gRkxon43PPy6f0JSC1evyB3D/qai2qgicYdvgofSS4P27?=
 =?us-ascii?Q?RHb+HmzTZukbySA80KWgRo+eQNrVidifBrI1v2s2S+pfUjXA1GRxh3MiQA+C?=
 =?us-ascii?Q?F7tijOzOpvRznicFXfqueqXbbIvPOzPGUD4uzTfjwNoWphap7miFm/a0Cl7s?=
 =?us-ascii?Q?ObgqYwgWV5obL4qLg8R/E7XlasLj/ylgZ5D6w8rFsRD4cGxJlBCgzWi+D59T?=
 =?us-ascii?Q?N1B/v34FFK+5jIlYcaTEHL5om2hvG4tgHTfCt5frVOZJQXX6XDi2Wu8ohx6A?=
 =?us-ascii?Q?PaNBVJ3N6bMYOvdHoX7AhgukYJFr9A/BcAPFb2COB0q8NTHNOxpiFKFbFA3O?=
 =?us-ascii?Q?8U4FZwEOAzupObDvi+E942N9xDQciDSUCbJeu7LsUAsIHP/4F0RVHX3OWw68?=
 =?us-ascii?Q?aJ6q+JY6smChO6P+t97Tp0xTH65/hwMWNA8/mHEkYEL8N1HYP3MCfGUfU8IY?=
 =?us-ascii?Q?mRyRW8z/HkEle9b3QRccbQKh50GAR7z1xPFof6/9eBeKb6ihuogtgPe/kY4y?=
 =?us-ascii?Q?baFuLAnYqKq2295KLFDroEoZKE3BdBzUOX2/BeVJeMPDV/yipaPdYwk32xXk?=
 =?us-ascii?Q?oBCWqb2syeMdiJulrU0VJ/CPQ7eMLmgUUrS3Qxa0Fh3zPN7KqxJZ3jpP9YVz?=
 =?us-ascii?Q?DVHSSAjhhWJzPNzR1zGfB3ZPO6RHGjJHJaKm3A/uleID5N9dAQlkHGocwOTv?=
 =?us-ascii?Q?inh3AptHl3M6M3hKUac/H7YjJ8MwcVzqZ4/BnGpY9fON5KUCVsU9gKpqBekh?=
 =?us-ascii?Q?urX3K5asC6B28vju50JNSXGYRo5nUAJ97wTViX1ReBszkeLXsLDzRmmvWWSH?=
 =?us-ascii?Q?+mUie7Me0uprOloM3q8=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 21:54:10.1388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f260b839-d649-477f-1381-08de40124e62
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6627

This header file is not used anywhere in the driver. Remove it.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/bq256xx_charger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index ae14162f017a9..3eb1733940054 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -8,7 +8,6 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/gpio/consumer.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
-- 
2.39.5


