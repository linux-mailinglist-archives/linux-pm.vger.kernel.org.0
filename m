Return-Path: <linux-pm+bounces-11810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91167944BA3
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 14:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5B4B2679D
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 12:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D07D170A31;
	Thu,  1 Aug 2024 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ANeUcweW"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9E14D443;
	Thu,  1 Aug 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516383; cv=fail; b=JXtoq3n42nZ0HRS+FM5vIteBu4p1nan9wLQOeVcPt312Rq0/rHG3wNeJyL2M+LpdmX1LJvqU9xNFTU9XIrwbPdWILMfMS9KyiD9/cB5zI9el+Id0r2NYKgseiT7NNDdYPnwkvPZAdX3XL1qHERQk/zDuY1fjZrjPasnjLWnKsuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516383; c=relaxed/simple;
	bh=l+mdtguRGpCSZTtHzmzl2BjOoygw4Z+ZhQpM/V4gvr8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XExO0r7Ic9SF8/Yx+reo3JVC3EvVDAWfz26Iz0c3Rj+kRMU1zo+gM4Alyp5Owo2sZXwx1KAEipRxcMy56GqtuCn1SZo8BJ7q32bT9rjBEFKf8x5SSMJ3bM5izVTw6kVjnc2meekmiy2WkAW+kPBwGQrOuxlAIvKJ/vCfkrQmfXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ANeUcweW; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOigLa4l8ifcoMPU4Kz9Htmcu2nErwPhndzxTYPJyet6Go5pjIUmDQ3FTVsHwL663ZGfNmF/j8gzsUEnS4Uc+v3IIOCUT/Iw4CR8E/04oUDvDmsDZRbFrH6urPPZ+SOjnMYFhaNe/1G3NIqpdqqpioGRqRCHgMJTcM40EnoPLzTWOvhANuv1PYPR10TTHyKw0XPcnZIKAtwikB+uFmjxWgvq5LL6NKAogffolLHYcLkuo+JozahZpI2uusijYbOCeuZviafhCalf7nW8yXFRcyyjLKHqR0regIyUoasM16AiYYlSii+Z/FycpMBsmgQCYdBhLIRUavhY8drb/90Jig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMmprZ2V52VtcKWNkNTAo4J2JvehRw7NABhCtGzxG9E=;
 b=Qd5bVrAS2vES3G+jNV+txBG8dZ54D6em4QxJAtgvAXXablcU9pXiUG3wj7OYGVp3b6Lg2ECPgwE0USDodNzgp2iSXA5xmT+mXy2oLCwS7hRoM03Oz48wDuY7c0fgUaVFgcxNkGtBE2QP0gZZj4jbFxdYboHtZpyGnAKf7EWvjqlaYjdNQ/xAuJRCIULWwpGRdpKuJFx8QGDv8twnF/2b8y9G8kNZ9NlUUHgmuvf7WUwT3uAsPAI2eYdckzfeHgX6BxLGUbC5rjwlKmsn0fOCrCospvTUvbkCpcMvAN2McIZkkdfF+/BPCZoJKHa5qrjZ8wruEDxly8XfpjUQL2+XUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMmprZ2V52VtcKWNkNTAo4J2JvehRw7NABhCtGzxG9E=;
 b=ANeUcweWETs6uFPZjrrra2TsLUummmhhvn+I0zqVcwNLU3IyaOCZv9jm8RfJm1mYh8dGKVsZxd2jLzefGumULIsjCnxUpnhqixSZw8shx7qRZWuKXUAzZQd7NmwXudc7NA+8VebvPQRisW+o+VWb3TvwUFtFE0GNDiAXrs9uAU0=
Received: from BN0PR04CA0065.namprd04.prod.outlook.com (2603:10b6:408:ea::10)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 1 Aug
 2024 12:46:18 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::8) by BN0PR04CA0065.outlook.office365.com
 (2603:10b6:408:ea::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Thu, 1 Aug 2024 12:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 12:46:17 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 07:46:13 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <ray.huang@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <mingo@kernel.org>, <tglx@linutronix.de>,
	<kprateek.nayak@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Use topology_logical_package_id() instead of logical_die_id()
Date: Thu, 1 Aug 2024 12:45:11 +0000
Message-ID: <20240801124509.3650-1-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a80e1d-919a-48b4-f051-08dcb227efca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HiqLi8LQk6P7MThLTWyTiVHZv4QJHqvhhr3jep9veJbUf/M1UrUomqAl8wjE?=
 =?us-ascii?Q?wyQMWi1ZcdSnLPbQRKkPGxVVQq6hda96vc4lOAabo4df5Q/LnzpbAKSKw8nb?=
 =?us-ascii?Q?IyT5HNVkY5F2mAlxhdht4Lw6J3gcgfDWRmlYx295hCbD1/vDvpLnGHf7AnGj?=
 =?us-ascii?Q?2ZlI+2rXRI/CRhgJWjsdJsLZirkjf7+b03IqN0OQqJa7Cq4adEC7Q095sJcm?=
 =?us-ascii?Q?T7+Yzg8Lofwwy6gIBvl3A3j7PbqVRvJh/q83Ff+a83gqvMqWyjfuNlJLzSJ1?=
 =?us-ascii?Q?ELa73QgqT1rIdXavAnIhZA7DVKLUnMgf0Frkkzap6yXvOxv6NLuINFEOW66x?=
 =?us-ascii?Q?MwCp88yCHtWJUDXKNmigud1zrZ8fiEe0KGfKiv8pVRYqMGyoqU7nCE15wgCD?=
 =?us-ascii?Q?1SeoyJ0b2adCgvCIPOR+Xpl8b6/kFPve2uO+oiZTxsXxSufcWLyn/uiBAqoU?=
 =?us-ascii?Q?J9+EITjzgnoKPvntgsvUPgMwM83ojuEg3fICv4WZXtp06MEis62CiVprkgky?=
 =?us-ascii?Q?BWGjaheJFM86NH74xT1KgQ3kT05TfNSusyPbPYRk0GMhzWu64YL/nLHAcBXn?=
 =?us-ascii?Q?wETF0uatre/vaqDiHy7yxyio/ZA5xZ6+ccLY1Noznv+XfCFYiOR8+zBVlHMq?=
 =?us-ascii?Q?wW5Au8dxiyGLlhWVxVM3DYnIxtQ0XvjZnDpfdOFaZY9bxSclkFWk18Nf5Di0?=
 =?us-ascii?Q?nRMw4BohihadNJG7pnuW+woz6022aPKtYZQZYW7ZD42AwLwokoMKUgassuHm?=
 =?us-ascii?Q?rLpOvc/+p6XE7lzwQauZ1/dRRrVf30swjCLwxPYZhJNa1nZi9nYKfWeGPRay?=
 =?us-ascii?Q?gieEzIK9JDpypdIePLfItOeHN1PY9usLqeE8Bw98+bcjiKUZYBtwQhsJVl9Y?=
 =?us-ascii?Q?pMJHnHiG+HdHZWvuKcw1VQ6agpnkoP9yjPsKwXFL8mEA22meuf86pYKvgpcu?=
 =?us-ascii?Q?CQyr4I7X+IgnIBNrjYyzdqtLa5DqOcSiTJ7dduwKm2ty+2fCfZUZjFVF6U6X?=
 =?us-ascii?Q?Y6Au6VosqNAzzJ0XLrRQWpebCrUTZJv21ac7KVJ6QWkGHnUvE6rCTPPtxg+0?=
 =?us-ascii?Q?PO+H93M2UiiqDJ6BvkGmCVpeI2qyrio9Hg39didYXSFyDfPo5Jm4AnMU/o1J?=
 =?us-ascii?Q?0rtZtIsIze4CbU8qb8EhuXI0IZSEGEFPkvYX3qHI2T9q+WJdaF4xSk3mNeL9?=
 =?us-ascii?Q?eGZx7FKyjfztrlaBL8szIWfuO35PUUZt5rPnLne9ZQFa4uJVRX+WqjgVApl5?=
 =?us-ascii?Q?p+kDvfINSOYXms045DJOdq3ZN5l67UuyafoSlmA2IfvMhmGjMm+7tjbsTao9?=
 =?us-ascii?Q?fmu6qFzQuw1G6JpGonHu/TPEmmEKPGot7c0JOdnx2Lu+eEDQRD/kHT0yf0kI?=
 =?us-ascii?Q?4B8tnnxLbZ+2tlgkW3NveR5Hle4KxH0O6lzUdN7nUr3Xn17o1g3hJ79fQk9h?=
 =?us-ascii?Q?a+NL7cm6sLDKAIYJX/h/VDTcZCBUJbx9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 12:46:17.5509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a80e1d-919a-48b4-f051-08dcb227efca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

After the commit 63edbaa48a57 ("x86/cpu/topology: Add support for the
AMD 0x80000026 leaf"), the topolgy_logical_die_id() function returns
the logical Core Chiplet Die (CCD) ID instead of the logical socket
ID.

Since this is currently used to set MSR_AMD_CPPC_ENABLE, which needs
to be set on any one of the threads of the socket, it is prudent to
use topology_logical_package_id() in place of
topology_logical_die_id().

Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 68c616b572f2..0039b7114f81 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -321,7 +321,7 @@ static inline int pstate_enable(bool enable)
 		return 0;
 
 	for_each_present_cpu(cpu) {
-		unsigned long logical_id = topology_logical_die_id(cpu);
+		unsigned long logical_id = topology_logical_package_id(cpu);
 
 		if (test_bit(logical_id, &logical_proc_id_mask))
 			continue;
-- 
2.34.1


