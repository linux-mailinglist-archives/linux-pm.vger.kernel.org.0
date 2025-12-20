Return-Path: <linux-pm+bounces-39732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B55CD3782
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2EDC3002E80
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 21:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FD32DC77A;
	Sat, 20 Dec 2025 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="JEEbawl0"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011008.outbound.protection.outlook.com [40.107.130.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69E2BDC01;
	Sat, 20 Dec 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766266803; cv=fail; b=lcDYVzWPMwuANm4WdpaJCW086qJak+yihftJUP8T2EdiLtwTVD0rR/ef1EUlBmN/ON/rwhIR5oapbIywHCN58uTtqJnh+Cbqmdj0LlsDhRC08uAESkf9kktavTpsLS+nwbzEtGI1stKXtsUisyVbIHt4/Fj+2d+bymjGA6avDsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766266803; c=relaxed/simple;
	bh=qsbpEJ+OVQNpodLJAAaVdGcLxOdOC6SPwZpnoKdP6Fg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cpx2hgSzHLHnPwTPi/8kfxA5l5eDAseAlB4U4fEC2+9lWDADiC2PKp2B97PzkQ1pFP01/EQHGOK8d9OYOlcFb5tWDzuFLRkDDv2EIGzoYq6MxTFlv2xSKGFF/4ZMJUroM4ApMowJCB0Hppn5mO8zra4CkjyjbMSFWG5x5kvsVWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=JEEbawl0; arc=fail smtp.client-ip=40.107.130.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfVNpoNguLP8Gs8eY1DMfh/5zR8W+k+2vl1K3UC3vlbSodmyclxAqA2shL8NbsQrXEebtt6fP9Kzj6d4wM4wZFSG4j4BLSwPSEHg2xxusE5k7nl5Qv5vEin2mlQsFUHsB/Tp7WKLZgeiiAWpXy5XJprYWuPCmjmyJoy5OnNoFljMtEyt1ku7Gy2q7epi8/nbaMewuiP4zakjeqr8IYWZ2M+YtrpkhlYGpFx6hZ333uof0IDhvAt7Kyop32YXVn59yxXNxPAfAn1jP8CmOWx/L0wuT8Zfte3024lLchNjUOqAjsT1hKvb9k0MD7ugJs1dLtVzL9RT4hNq0cvNh4KkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ene6XvMxdBzXTycoydI5aNLkJ42q5A50785Eolf+CZI=;
 b=Iu4tWDnSlxqHGWWpbaptZQ5+hA4AtRftJa4+EbmpLpu4fiVFHjyszoCIHTEH6tqqr8dwqGrSSH5HQFrGYj4dTo7jf6S4LJIM/iTdI2r6OI7NGL28d6HNKR0JuVuPJ2LoIuTR2aQO2/eagUQPMwpI8y1ieCd2xece+eBpafdJxIK4y8VnMIvxHCQj8EE87q32S8y3DLV4+dO2EhlMTH07EZ2F/V6x0y7b6P3AbTJpZNd/Gr/2MKTsE0THeBRMRAzhCHXPr1p27dO9ZMeaoixNVdXKF+6MO/4QYEwgOjUEgEpe/UoyKI7YMoxUCM9KOHjxFFC1aZoaX+huiW6g62l5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ene6XvMxdBzXTycoydI5aNLkJ42q5A50785Eolf+CZI=;
 b=JEEbawl0nBBbhFyTD3Qts3Dm22p5rFuL2JiHEUDM3N60MniLyOOTQDd8YkI/MTKVOot0bs8U+ISqpFrKhilm5HRzq2PGThtMguyP9AZaj5Uo5uBxxnvpF81oNMW/tGfV8zjxfJBVeEIzTJ+AUrWcuwabPeSJD0qGuX+BLN0i0II=
Received: from AM8P191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::16)
 by AMBPR02MB11553.eurprd02.prod.outlook.com (2603:10a6:20b:736::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 21:39:58 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::65) by AM8P191CA0011.outlook.office365.com
 (2603:10a6:20b:21a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 21:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Sat, 20 Dec 2025 21:39:58 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 22:39:56 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] power: supply: bq25980: Remove unused gpio include header
User-Agent: a.out
Date: Sat, 20 Dec 2025 22:39:56 +0100
Message-ID: <pnd8qewzvbn.a.out@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|AMBPR02MB11553:EE_
X-MS-Office365-Filtering-Correlation-Id: efcdab4c-19ca-4612-c656-08de401052d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q0IvqWHIoriTAuNteCKylCQ0n+oDcws61VCyB6cvmb/qQ79JjHpuAiOUfS5o?=
 =?us-ascii?Q?xiLC8KW0LAGMj9kJK+M67C4txklCpZfejxQOpivnmD9Lql+da3e/Hx9HChnz?=
 =?us-ascii?Q?xbHeZVfVJC8IlfYn+7TI/mcaQPxKq4IK9nYlQK2Vm+2dCEhDazAbpsy1BPfR?=
 =?us-ascii?Q?RxMAmDRRho8j6YneJRjY3vXHp5kCK8bS9usPYC7I7A4ciQpApuweaPI8uYnZ?=
 =?us-ascii?Q?syzx01hL+QCgO1HkpU3mIvWLAE0mAOv2XYQk+mc/BvwSdlzpBIJbwJAbxN79?=
 =?us-ascii?Q?A2cD/zwiK2mSkdfsAI98KfF0sjGMN8xrt3CP/jczqlsMUvJl7Mfc82/1Kfy9?=
 =?us-ascii?Q?UBvlQCjFFGACXdsBQKENGJsLa2k4c0Aup8S7WCrilydFajImahP8u7DSjt0+?=
 =?us-ascii?Q?FNNTZedtXydXJnSvCh//835oEMwQBUxLNRmPAH1aSbQgrvlwF0NpjqhZTL2p?=
 =?us-ascii?Q?ojqf2AU6NmtpU/YiIbqAjeIkTNRBubSqTFHyZ3hTlKikq7AaWmZRAbmYVHkR?=
 =?us-ascii?Q?d1PB64GugVLuXkpZPVN/GGd6bx4h6xr74xmxOuzKf/ICHuL/wS8qe2UpEft1?=
 =?us-ascii?Q?gkF3NuVDEfNrZx1/gqAtcnfa9w0uu44QYshZBmnmCQkAz9pEd8k4oD1C40Id?=
 =?us-ascii?Q?EGOHjl5R2cRhzr7ftIaW8mvon1A1ReAZczwCLrlV3xcMgw6sWTUF0CQcunit?=
 =?us-ascii?Q?hQ/Ou3QRndA4BUya173gE37fjb8o7jHbYZmD3Vd2teg+4vud/MsWl7DNGfE4?=
 =?us-ascii?Q?iW7k3FDjRWIST1hPaoUPi5Bht4rctisrh6OqJYUSDmGoa6C6swFHkC7kNasM?=
 =?us-ascii?Q?7UPyUo9J7riyIkiDeqhW7ilqx0XJp9QgzhPDPZqq8SGZjwykztQ4lv0AVkda?=
 =?us-ascii?Q?xCxV4U6mcmy6DOBf8kRyLUrW244BfYzXpNlR+MWYE+2ytiXjhjIQyV/Sf/Al?=
 =?us-ascii?Q?6GTK1Hq6bmGYgkETdEewFdhqGsqNBlxXSpceqYquUiJ+Y7bdufrK3DPcyfBn?=
 =?us-ascii?Q?2gFkbGf0nCMqArjqDgeykjnbf/cZrqJv+Wb/ojjmcsJpPFyxjyZZUwdqJyja?=
 =?us-ascii?Q?qAI2oKfOX8iizIUjikvY6zMJ7pyu5/+Pjscc3G7JeeIRand5k+K0Q4Y6b7Uw?=
 =?us-ascii?Q?3eNWBcb7Iz+wkRVrfZHwQb5LJCpjqM2YfYBXoQJuh3dZYIluxoCY6iXwujfy?=
 =?us-ascii?Q?DRiMbjByPpUyELd3/z4JNbHzpR3VPRnxOQzMLg4YQRqmwotGf+oF+OI1pVE+?=
 =?us-ascii?Q?66CRvfJdM0VYKOuKtMI3MdXbMYw9Ln4LJ9zN+6N3okPsw89Bfnyp2eWttSIC?=
 =?us-ascii?Q?77JHeg85pSXq7MHiB9RnAE7V3/AikGIbtc+aOQ39vC7h7ueeF4T986xyZlUL?=
 =?us-ascii?Q?Apz6s2R9HoTB5abmuO84Fu6FZpZY7BYunVPKHzgXwzNMygHA956WhwkYyAYe?=
 =?us-ascii?Q?TFYS8A4xXJCpGk1/v++lXHuynbKCd3s50PFBx0KvAvy7PrOpY5mLE3aHsgDv?=
 =?us-ascii?Q?USM223A0wk8iu+J/Z+xaN9hJFfLZy8wQWjDVPfKhMIY2V1/INayK6pIOPX+I?=
 =?us-ascii?Q?tM7ELAG8MwW7H/fBJHQ=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 21:39:58.6239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efcdab4c-19ca-4612-c656-08de401052d6
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR02MB11553

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


