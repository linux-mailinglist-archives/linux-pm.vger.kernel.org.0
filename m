Return-Path: <linux-pm+bounces-39739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 023DECD37C3
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94C87300CCEE
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 21:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEC22FD695;
	Sat, 20 Dec 2025 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="hwcsSlE9"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013062.outbound.protection.outlook.com [40.107.162.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0812F49EB;
	Sat, 20 Dec 2025 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766267656; cv=fail; b=nzerYvOQOZZu3bTysBB+WdbkWVxIuBVTIDCOTcGmdZwvIGs6lTVvYDlKOt9rWY9PYm5H2VtSz/XTVXn/rXtkMP1zQJiggL+q48+gOgRh7jva6BAig+hFgoPKAmb43OP/ifimbnsPmihmx1bjU2o2NkXHqwHaL6dxXu/RO3WyGDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766267656; c=relaxed/simple;
	bh=qsbpEJ+OVQNpodLJAAaVdGcLxOdOC6SPwZpnoKdP6Fg=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=NQcBtBm0wmFmZ2jzcml1JtO82/vJbdtOACgUstS66/mlq7pUZGuofTKQJ2LxbzFr9Ep5lnANIZi5VRIzBTvRJbiUBaToKWI9DhdeuNbRQJuGwjCAkk50eSIjVN8JGYHfwRSJWuM/7yA8HDeAKL8scnro7mPEHhjo8pBL7f/2EH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=hwcsSlE9; arc=fail smtp.client-ip=40.107.162.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASB+gbsIxNUfAoybP9jtSnz1hSC51C+v03mQdo+KhvA6h/UpdG2Ey5zcHsuAYyTf2IFVjjA/rjdcjJZV5c9MADWHHNYD5JOG15STquuqtfo5Vxi41wT09z5Psz5L5DBOg4GVABvljX2SPB1xFRDE5X1y8a8tLfIgmpPVD6kbOa3+hXgIYFlGTetRtv+Io2CKV4+hai94PMUuqN/JZDB6Jpf8gfx4CYUCBPahW6ogaRc+XvBoY0KJsC+if6ROG6sPMRMmBAL2Kuz5ZwhpG04MkNDNRX0sOcnpIA8hN45A8iMItoUC34Xedl3LhXDAbhJ+ffwkaBYTvIkdW6wJzYSLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ene6XvMxdBzXTycoydI5aNLkJ42q5A50785Eolf+CZI=;
 b=ErGGRT87BHtNWeZqZEAem8QjsNY5PAKJOXS+tFtfjuUVOaKiLiqK7hps6eTSdXCoSnUo+YbkJfbGIfSh8k+grYDJUHpkYnRBY8VY/s3n5ru3Ikg6sMDOAyNLrUuGe6durqZG0ndf5ahGe9ngDG38wWOO6YhK+4jy4Aay9whEKEOMCwns26k0q+EpXk47A3DV/yp6WCeHQXoy9knEemeWA0UMYnX0La7vZdWWdjsWngRjtIqgl32HLMuU0KDtSVFnsLU6XbEEnoxU5QME0hDxVEdU9ORSexZvVtg/KdfH6Bc+/mgnCyb0lrO2hqjnUvCFbZ8lMDKPkuPPvgWclNOQTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ene6XvMxdBzXTycoydI5aNLkJ42q5A50785Eolf+CZI=;
 b=hwcsSlE9OFD6QM4RzQhRep4u3/cue6GcoB9TnlLzvXHKZv3gmAsClp0gM7cliQVD9jiu96S30YpEfB5B1dCamdvfzh9O32rLVje6HzjFmobdRA3qdUJ4GtjEPPc8oGMh/AaGW2/f3TXxfqe8ZQGk+81/DvG8asd2devxKgsweY0=
Received: from AS4P189CA0004.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::7)
 by DB9PR02MB7259.eurprd02.prod.outlook.com (2603:10a6:10:24a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 21:54:10 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::c) by AS4P189CA0004.outlook.office365.com
 (2603:10a6:20b:5d7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 21:54:06 +0000
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
 2025 22:54:09 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] power: supply: bq25980: Remove unused gpio include header
In-Reply-To: <cover.1766266985.git.waqar.hameed@axis.com>
References: <cover.1766266985.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <94cf6d7dc464e20abea543983b24828e51c64f93.1766266985.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 22:54:08 +0100
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|DB9PR02MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: e0563e19-f11c-4c77-e700-08de40124ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1WYYVOYlC07/d4sQTcOj7WB7yIXVR6cBkxHBqJIVSTUR7L/hopERXcFppHFX?=
 =?us-ascii?Q?DR7h3lb1e54ewe7PJQ9Dg4heT4BfxOzumTSY7CDr05zJXwXjkjZMKUnItAyG?=
 =?us-ascii?Q?qUfjoqMxoQ2+wXZZoElC5i1HMBrIfTBL8/zzRMmtKXsBoYepKsdMuizYLExJ?=
 =?us-ascii?Q?el3O1paVGJ8vI8/2AVYWvbuuaRcod78LV/RqN9oFwZOzOKUReh8T/AiyhqRK?=
 =?us-ascii?Q?YK6wu34+tKH2aXrLboucdwZY4PTffXvM6XADFMlEMqkEou1/jy/B9SgA9rGU?=
 =?us-ascii?Q?sHp5f94BbUOSj5OAYWG2nX6avQ5l8M0vr+k9sbnbNmOvZdyVt15m2zZVT5xv?=
 =?us-ascii?Q?+kskmu3j1srB7y2JmkZ2vNjak9pTCQ4ZaE8Sgs0v1tlH+gbZ74oRhIBChn7n?=
 =?us-ascii?Q?OCteIPOXOWUrAgDl1frc3CSQZ7LbpFKK+gU38vldVqauocGujMjf5xhL1uHV?=
 =?us-ascii?Q?Yb0MwHy3EC5/SQb0kP4il9cDt5eD4UMksi36Q7rkpNxEVp9IyRDzJBHbPW4k?=
 =?us-ascii?Q?P2i5jW2n8TJlfXouN9u6cdbX6DFcPGXr4sm0Xv9DJTgeouKmjVu0YTXZjNzT?=
 =?us-ascii?Q?GWSb2SIj1e/MGi1Rm8LJ+433J1HlMMoxREI8CY+xPWMP1ZO9hA7C6O26naRw?=
 =?us-ascii?Q?ULIIIpyPegO/YdAlTnaR/4rTVpzb9ocH8BpuaJTssUUx6CT3BEurFO6L8S5e?=
 =?us-ascii?Q?PIE25cqgw/1obpvaoEyobYfPdO1GzerFkG92QVw0VthcurJs1AzBE6g9YoXL?=
 =?us-ascii?Q?kLosu3DjU7rBdlLmiJoQbDWA3EoieL/BlWr5oSkHzQmPe5+66AYK5WUtfG4A?=
 =?us-ascii?Q?VqOhzKvCyU/nKu+sr/E12mKzzu9EYYyaYBZ+H4M3ho91EkF559D67upCk0bx?=
 =?us-ascii?Q?eKlkjJ9kHGsoPZWacgaTbUZ9aYUwASGOdo1Wj2RW1j8AV4duaXZmlKLwnR/C?=
 =?us-ascii?Q?E9NASf4VtPWvAAika3o2g+3UptY6L2rs0sCIMmdu1g2jnfRlQP1WPdNCbX+0?=
 =?us-ascii?Q?wWW6TRjLYPgLvwPg7Xu9HordlPxgw/dHHFWkDViIObIPdSXog1OaUhWkyOk/?=
 =?us-ascii?Q?Es9amyRWG3/KpNNUk6HPMJ/Ii28qbz86Qu9Dxm4DhsLG6UlF5fPnErTtdeUo?=
 =?us-ascii?Q?s03rSrn9qeS91qJspHOD/VqkBn5VBXibYeSNIlhB8p0vO9koa0F6QBQHUchv?=
 =?us-ascii?Q?zcUx/OCdkrqeFGfbXktol/D/aTLAf/6vn38cA8hwsrcdHBuojbNMMKlNSmMS?=
 =?us-ascii?Q?KOC7LxfwunHGMlSAKj8kmpmkzLF+9c2yu6SFQFEKx8VQQKUftQD5U7BQWziA?=
 =?us-ascii?Q?iuZTCbBzMraZ0U1RLf5YNZVOP2ULnIxDv3rT9bL0k+QakqgPodq7IBdm1Vnj?=
 =?us-ascii?Q?ZtYwgTyKpqjf0YvLBshpBpp1v3TJ1Jg5FqQsMj7iYARqjAfSUGamxCdZF9+o?=
 =?us-ascii?Q?3WAABHneWNTUWUxIRWL82H1Bk8MwnqRS20Fsf91uwBJ5vhTigUGfcQ7S1wGb?=
 =?us-ascii?Q?Dg5kjTqiKsaiwPOzCzH4sZ4Z62Nu4jDYUwpi/tUwI3oOWyW3IqAY6Fddlydr?=
 =?us-ascii?Q?gCRmlaZClSPolXddYws=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 21:54:10.8783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0563e19-f11c-4c77-e700-08de40124ed2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7259

This header file is not used anywhere in the driver. Remove it.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/bq25980_charger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index 723858d62d141..4f91fd1a3dec9 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
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


