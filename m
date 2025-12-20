Return-Path: <linux-pm+bounces-39741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B05EACD37D8
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6B56302410A
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 21:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802BF2FE577;
	Sat, 20 Dec 2025 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="gymd+POt"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74472FC890;
	Sat, 20 Dec 2025 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766267657; cv=fail; b=pxRElUoDnK6l4fV1Ic0cHqpdB77EAGO5qOynGNgQWqvFO8BdveM3QtEKPAIGqhe7ETo/HAYmG3f6foHXjR+ltQ6bApjgO4bBjB63xuwaW1pZbjjWI7VRsKPa7cdgPl7MuGhzsij7ZOZ1JCAqaiFxhcyTh8+wnyooY/JUbuntE1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766267657; c=relaxed/simple;
	bh=nV8upDMteWN35B5zSfUaghEx7pyKkoynn2ZRKCXXMEU=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=mTl8HnqLTql1PymXUVef00Di+pqQK4L0Qg9shng5oHReQthBonpdJKaXh1SZ6xuzRvVOLD8opn9PvEqYK5fZdLDIRhJ4oxbF7PDUUiu60bbs9sjzJlrxRT6x1vqPAV1XaGRckWMmfUtXEBzORJkkvWR/BEDUfKOKWiIqdUAzKvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=gymd+POt; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpgG+UK2bPLM/zaLJJVjfayElmAAOtK5sf2kZYc0BPJaSjvWwPvwEgnDaqpztPdWcUPZ7ND+AO1/hxBqe7eqtQufTpwXGLoDDidD3zsUMVGttAjjSZZXsB3yzXRZd1GmqtCdKcg8Cx8SrgdEZU8tb9RhbttofBnpgRErdD8JZFceSpxA44tc0AJsKxiZvRGpvNMDKfjrLRH7TGLqR5kL/D3HnlOVcFMBMVxNgDYox1gDnDS45xNjl5VeOZ5vBcNwW/LhR/b+hm7P4G5hx9JvXzM3qKpLhESgNl35JcLNrDgUHfBSCE4kycxkl6jv6fGYKl37Jcru1nolIkpoFbmLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmPIxjR+nF83cy1XcmbA88yv1OkhwXorvPRcczYpDDY=;
 b=ZFSjXvM+CBof5wordHSJgefSxveeAbfh5bt/7g9JScaaMevk/2fh8GVBYhtcqA81eWGYuL9nyrzCbffIKTySjD4LB1/xg5gF9fadO0VGkYODsCB6LVQtsxNWigvs5A5v4MHIdTY1m8oNv0R+p4CQbAPSCHlEv+7eV4wBk+zgGCScu2jokEqN/WezcyPLw6GjDafWj/v34O02Cm/5PzF1zZsSytvit+/O7Vc3qQirzQ2we3m8347cpbYOgeXqbBxyM3/xExVOpwMn8AD1GDSid4hrotvcgn3bma3hReNc4JMgcYl74ETMHUOVeHUJ9PmkmIhP9bQ7iKbL1eEg8XtISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmPIxjR+nF83cy1XcmbA88yv1OkhwXorvPRcczYpDDY=;
 b=gymd+POtQzfBFzDi5nGFE/ABjgOWcFCl+zW8Cz+db7H0nk6bK7Syy8Qb8mSLlPxoh5f++Uoc9xgA+YTH3EiYC0itrOQGr3sDRaPNc2xMl5wfehk73Rdscrd/mwvPN1+chEr2WTbQR0IklQTDLcPX3jLuAZHgc2lcDvPchv+l140=
Received: from AS4P189CA0006.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::10)
 by AMDPR02MB11581.eurprd02.prod.outlook.com (2603:10a6:20b:73b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 21:54:12 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::30) by AS4P189CA0006.outlook.office365.com
 (2603:10a6:20b:5d7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Sat,
 20 Dec 2025 21:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Sat, 20 Dec 2025 21:54:12 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 22:54:09 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] power: supply: ucs1002: Remove unused gpio include header
In-Reply-To: <cover.1766266985.git.waqar.hameed@axis.com>
References: <cover.1766266985.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <dcff57bfbf0510c8b5bfd9d39de021607567a6e8.1766266985.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 22:54:09 +0100
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|AMDPR02MB11581:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9dfafd-afc9-4fdd-3872-08de40124fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x6H4BS6Bu9WQZY8YxYQ36eFhRhHP8aF7NxNMilGB9WGynTMmlAdSCsPQNAjS?=
 =?us-ascii?Q?bb1ciKlpcdoJjl8eNRkq7SrWuArI6w6Jt6XSEJw8F0x4VrsojAmJODsLYJlZ?=
 =?us-ascii?Q?y1KOigPtzxEsBixI6iRB8VTU80KhZBTZPy2MxSqxXRqNhdIQSRenDJ0CuLIJ?=
 =?us-ascii?Q?I/ORfs/wDI7Nwph0z0+dduKuSUZgVFwFMbH7eDj0WaZ7JBt6jH8xOnvZWjXK?=
 =?us-ascii?Q?F44bgYm0TDEfTBCgsV8H8tACsz6hFrI3hS3MGPlt57uXlFtldnlqrcdajzFH?=
 =?us-ascii?Q?pSq/iBsmTSLuEidm/bZfJI/PjA4Vfd58pSOPGVZRHckc4+oLAIp1gRJqdvLa?=
 =?us-ascii?Q?lqm/30zHvwlrZyoL7lfjebtPNKb55+ZreGMIxuPLNaA7ekB/8bcTcwtxRvg2?=
 =?us-ascii?Q?3Hb4oLylldjRTx5RMBU8uDJQCu2qOkeNVTyD0xpT09muVKtUJM34JAQqMdvf?=
 =?us-ascii?Q?9Yo2/7pbZGu/4Ghdyk1XA50zcPDMr6eTVb1M9XOBfTNDdFFmG5VUgOTWqite?=
 =?us-ascii?Q?5X85psA7JVwTWfhyXR5lQWKs8ZlRxeJHZnMZdi/PVpdvy+yAdY40a9YtCEjk?=
 =?us-ascii?Q?vUwpsBK1Tej1P7gz0rC21Ja18JOH+wdtUC496zxOVetRn8ie0q3Yro6S5f16?=
 =?us-ascii?Q?uRxapM8BVzubTN2eG+aJNwciQXmY6BkStuTyVMnOvrF1pr6stl17PMAsTeoW?=
 =?us-ascii?Q?8JwU6ERC4iwqtA/GtT39jXJ+UXHLIR2mzhw4BOtpTW/LttBIm/MC4FcwALeE?=
 =?us-ascii?Q?WKQ+X7bZCOWyaljNqf2DV0L5kKNSuuWsQ/q9HOyl0fqAW6WcLwiX755CetE+?=
 =?us-ascii?Q?YuT5KkbUBcFc41FqkuyJOiSNkBKja+ptWqQwA0XAZZ9qvKQVqk4jrIQDIegB?=
 =?us-ascii?Q?cZyvmOObQdTnkLnIsyDnYMDRvRNgecvH7KB/BPLUvyRp02QhPQxQ/FBYg2ci?=
 =?us-ascii?Q?TBJhBN/XaNugBx0DJPVXViV88QcaKVDThaBJpPPYdh4FFpM4Uk8XhEcmak0J?=
 =?us-ascii?Q?q3NTlhSxGaeZ2+b2VSp+R99mn3qLqqsT4fqf+neL3jw/k4qAPQqLArmI8IZ7?=
 =?us-ascii?Q?MjNA7fNE2ZD8vORSauokt0GrZyeIkNBvQEkqyMlG+g4dbjy2qCcYbJHpll7N?=
 =?us-ascii?Q?ITy9KfwnDlJwXaKGvpFRiu9VS2RC8VFRq2R8f6HBuGn2DE1xbw7wetQSz3Bx?=
 =?us-ascii?Q?lgmwUadrSyZee9tSHMMN1KzJ6k60wZeFhL33Cj+4anuhDbA/0UYT0w1tMeEO?=
 =?us-ascii?Q?aqhsQ7Edn8R4VCESRDlaj7YGIqM4hM6GGmg9u7nHv4GwHskyJHesHLD2peh3?=
 =?us-ascii?Q?+Pi5SJJk0qyL1t/5f2uokXId0uJPv24A0aLTpAxF4Ok7XUMVo/LH1yRxokNr?=
 =?us-ascii?Q?XJV8KJ54dH3O7ynQESgGLm6Rb3yfqlxqZVM5dJujxOVGnbvK1FSvZ6BxY3oG?=
 =?us-ascii?Q?ykepT0xvl3VRSexNIseJABHyAs2kzUrPLtc9QJTpMLl2El+4UMFQ3xDQRXbk?=
 =?us-ascii?Q?8KklghpsFiqiK+ISjbDf/wmUldJk9FNMAwe4N93A8Q1qkj9cCA9fXLABs3cE?=
 =?us-ascii?Q?vB1qsGML58WVgNPrhsM=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 21:54:12.4468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9dfafd-afc9-4fdd-3872-08de40124fc2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR02MB11581

This header file is not used anywhere in the driver. Remove it.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/ucs1002_power.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index fe94435340de6..3f44cc902f84d 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -6,7 +6,6 @@
  */
 #include <linux/bits.h>
 #include <linux/freezer.h>
-#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-- 
2.39.5


