Return-Path: <linux-pm+bounces-38377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FD2C7A149
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 15:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DBF4345AA5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0BF2D73A4;
	Fri, 21 Nov 2025 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UG4xOrf2"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1B2BEC3A;
	Fri, 21 Nov 2025 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734235; cv=fail; b=Ae9DXbzm6Ftzq5RvtkQw+LISYSZylDWZx1JFo7TJcXNSC4g9Ma+eY/FSBzVnqAhQ2Yrg2uLEw3uRF35V7L642rT7tSVyXShU+KzzkarD9plfSlkJTS7P2N71mw5xN2jSa8/ANH6wAeZCeRnV5hUiMBtrGOBXPqCtsrwIN5QuFk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734235; c=relaxed/simple;
	bh=kBB1euSDedJDwuYq5ikvw8KJc1sEGzCkYepusOfbHsw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n6NmG/a13ayBmb7/QYCA8mljU18M966q81eYh71Tej+swTW6gnVZjopzJNgrgKC3hQpp6rNqrTroVHsddG24w3IkMo69VQP1SY6sZUsJN+J0WzS8kSBEF0nMW5/BXPeYbu30Xs2uc840M3F0eyIM1ZIaGiJTMqe+1OnSYaYgsxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UG4xOrf2; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lau+MZSpC12Howgtez696JXaG9Vb6WwBHMzrkxmDNrkH4kVnsc8CuWJehdW/Y4f28H/KOvNkzsBwB9L2zLt7q84Hm0R/TqX49y61D07XtsdZMGtvu++xI0bxxZbCsKmiZw7T3p5HLtETiUNZMzPhjvP23ad4n/5fFM8FavE8bQpnxgcp0eVU2bf9CRBkbXLuG9kYVv5DnOBoFnNfCw8k2CkMa3qa/Wnq/GFyy+49mzna4Cufz5WOt84fXuGwDq6hTxmeob/05e9z0s0nzSTPqUOtcuoaORjf1are8eDhh6ON3Gnkg3bJLw34BLvgSzUiWkUPPoPlJ1nc54FRV/qZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0phbGKwUjb8ORY22iY/onSeIHpp6guHhI/3MbFU2E4=;
 b=LMHSHwxsA9bi3/vfy0uxwUESHrRatQfxXxd1HIB2IVLXu+35K6P40f8Vvud1urd4zXnDN1jNPoC9tXRL9v8CwkvrbA8MCP81rqethll2VC8tlkVgetQnGjKaV2/0+6J9nElN0DhHDg20lMiobEbVvfqbRxvmB3aDA+153HTt2yk4XRgmH6iL1wJmArthc7UBl/BQ3IkxjuD/Ws47FHnRWFp6nnCr9WeOQo2c+ZpFphcMX8mCZ61RQh4gCWXl8rr9//5B96juaBuhyE7fJGj334t8pn0tlBRsik7LXepRHC5Zujzfm6n6zwr0fA1jJSPV2SiqYUXtoefLVFbsZN+a2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0phbGKwUjb8ORY22iY/onSeIHpp6guHhI/3MbFU2E4=;
 b=UG4xOrf2ySvBNOyyFHRi3Ek4ujvMQeU56lVljREmpvBIxRITHtHhgGlcMhyoEapBAhvj/VH9PnNzss9Orx4ST8twKwGaJHpIw5fOavoasNUmAVkw2PUIIp0pzkKn6oEHCEydq04V+79MJJ3ZyTUDc23Mj3k82hePmb1UPX15RfkJEI/kQshd58iH8d9gsAw4A9Qy34SPUr6sW20cdD/3lrwmF9DtGn6R0nlQAAcG4BU2H9cWSb+YrKwzS934K5nvETzQ6rZiG0+Bp+YlEjmu/2Zd9JLTPBqL2DnoYqbOiGFO0SmxO4lmBpBD+qQeRyd8ITCja18PNs9HC0CUBSvNWw==
Received: from BY3PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:39a::20)
 by SA3PR12MB7921.namprd12.prod.outlook.com (2603:10b6:806:320::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 14:10:27 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::50) by BY3PR03CA0015.outlook.office365.com
 (2603:10b6:a03:39a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 14:10:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 14:10:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 06:10:07 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 06:10:06 -0800
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 21 Nov 2025 06:10:05 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding
	<thierry.reding@gmail.com>
CC: <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>
Subject: [PATCH] pmdomain: tegra: Add GENPD_FLAG_NO_STAY_ON flag
Date: Fri, 21 Nov 2025 14:10:03 +0000
Message-ID: <20251121141003.1808684-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SA3PR12MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: ece6dc17-aa01-45a2-aa68-08de2907b8bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IWND53b804x1frNvMdfzmaMvAb3Gz94F8J/LGrMoSUI3vPQMU8eG6cEEXd+t?=
 =?us-ascii?Q?lyT2xRVZ8sh/3HWYWGXqWQo4Nt4MUf3ntELYCxJr1/PmXPWZcDnBiNaf0Inl?=
 =?us-ascii?Q?7zukQz59JmHdxy4yl7UMj9dcZzngWnJDSowX6d19pIOrm/qEIVV0BGnQldD3?=
 =?us-ascii?Q?n/C0LWmRAdL1u4Vz0WGz+Hb+bi4/7uwBf4QzTfzdr0dVoxkNlw1dfgVlnP00?=
 =?us-ascii?Q?/Sa92wtE7IjMLro7AlyfsElp/irB+c7eF9GewIm8rAeGWNdFDsKPzAd2WnOv?=
 =?us-ascii?Q?WQ0WvjQGkTsykilMP0p1WqJU+AG6PLMn0I0KxguDvgj4HnyVO1g7GL2ggf71?=
 =?us-ascii?Q?WxD3aL7EZwjwNLWr3NkmVtwk7jAUkeloGPEpBBL0LYYwqn+RvyWS92H0osfj?=
 =?us-ascii?Q?XsOPBu+vDVhL3JlILt9AF3fcYGQ237DnpiZ4sb2bANLAiK1+8rFuOviInLk9?=
 =?us-ascii?Q?xWVHL2pg5cJYOUxQxbiXpZdmXCu3QpHyV/sg7Lqo3ceGZsWrm/yL8RR3zDHW?=
 =?us-ascii?Q?11SfmOMtUe8Bc1upBxBpoBZiyoYTiEX73krCV8gpAw8x2MqNnSxhMSM61XsB?=
 =?us-ascii?Q?M3fxk8VwtA5oHMAAsqbj4bIgak3ZJrm6k+yLRrnhsOiRtBQAKQ0pSn+L+XZ1?=
 =?us-ascii?Q?WpQxY784xKC5h85QrLdMIvqGGbPx/5CSGdiKzEzaPEKguk6SUd3XytmbLQmD?=
 =?us-ascii?Q?H/SMU6hFsqf2uzARYUKDHUtwyJefxIff3EgJJ4pdmdkhOPso6ONFKchn+irU?=
 =?us-ascii?Q?B5UMu6Li+DgIsKroF7cv+j4B6azdRVqewrl+zv7r0nI2F0/RNhfxP08w80fI?=
 =?us-ascii?Q?jtztdxSwEa+hCbPbvgGeTdFicHJ1IT8lzG9gk8HebS2H3IlFIu3N0j4c10t0?=
 =?us-ascii?Q?oEVO8Dqdw23uBDdQJ7U3puAz3rVeYG7NwRcE5HsLTnSzzVChmNj3+ARmNapL?=
 =?us-ascii?Q?Pcen7BY5WSc/dXyu+TG36E2ap+hKF4E1+ATqfxzkrS6UZ6t1R/un8k8vXzIW?=
 =?us-ascii?Q?9VipBMJFzUvfTDReYxRvisupWW2/IT91rACHJjCtoWK6t1tHtVwpKMPoVYaL?=
 =?us-ascii?Q?+a7e/Rl8iJ1FKKOSUNAjIdEw4L6RJ76ZGcHRHMNZxAEFkM4jJpf51+dhIpbq?=
 =?us-ascii?Q?tY/ozgUs+hfz9yKDmDvCDy2745tSlCd9F+iuZGpPo9mpO9YUKTs3PktBwxf5?=
 =?us-ascii?Q?luYfMb0SVALhc71KISoy969YpITD87iYfAyH1n0+oKT1t8IgJXxW4NgzLGfp?=
 =?us-ascii?Q?ra2rc7usZCFGSZSk4vxYeifFJ6Bg/tWTfB1o/5BVpovhc9qDwJ/NpLXpOzNm?=
 =?us-ascii?Q?6IJRrwQZaQP1XmjeaXGQz7OClEN6OA6hkyK+z2Fm4PNWr0diOYrtB492L1v8?=
 =?us-ascii?Q?0t4kbVpuOq6THVfACWcy/GSLmSWHwftHkUgLbaTF5kF7TECbqWxDInctPO1R?=
 =?us-ascii?Q?wECM2jKSbNOVXsskULeI987ZlXqYAOQCMPggsGrQaiKwjc0lXFtbWrBF3hjr?=
 =?us-ascii?Q?rWKP7dqUbFMJ3ocX7xEFAyPCiwDa6XGOzm3429ZEHvNEq2uiORm4Y7GnK2xP?=
 =?us-ascii?Q?fFHoteCWztWJFjg8Ayc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 14:10:27.2785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ece6dc17-aa01-45a2-aa68-08de2907b8bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7921

Commit 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until
late_initcall_sync") kept power-domains on longer during boot which is
causing some GPU related tests to fail on Tegra234. While this is being
investigated, add the flag GENPD_FLAG_NO_STAY_ON for Tegra devices to
restore the previous behaviour to fix this.

Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/pmdomain/tegra/powergate-bpmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/tegra/powergate-bpmp.c b/drivers/pmdomain/tegra/powergate-bpmp.c
index b0138ca9f851..9f4366250bfd 100644
--- a/drivers/pmdomain/tegra/powergate-bpmp.c
+++ b/drivers/pmdomain/tegra/powergate-bpmp.c
@@ -184,6 +184,7 @@ tegra_powergate_add(struct tegra_bpmp *bpmp,
 	powergate->genpd.name = kstrdup(info->name, GFP_KERNEL);
 	powergate->genpd.power_on = tegra_powergate_power_on;
 	powergate->genpd.power_off = tegra_powergate_power_off;
+	powergate->genpd.flags = GENPD_FLAG_NO_STAY_ON;
 
 	err = pm_genpd_init(&powergate->genpd, NULL, off);
 	if (err < 0) {
-- 
2.43.0


