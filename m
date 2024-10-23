Return-Path: <linux-pm+bounces-16295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1419AC7D0
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 12:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB24E286EBF
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579FE1AC429;
	Wed, 23 Oct 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vXLYqybk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62211A4E70;
	Wed, 23 Oct 2024 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678984; cv=fail; b=rgcnEDV/IF2eHCl8cCHuKeyO4V+pbGnDzND2OUGKDCRivRIYniIZvmniOaHUwX6Jhj5g1LmSYxLe7GwdrkqG6ldRxjEpsXYJ47OS/+64LguoRssPauyo0hLUKZVLhrrpDSfEkrU9juuRczZl+NITRpk0oZX3llN1hin8wUQxloA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678984; c=relaxed/simple;
	bh=g2/kxZl4K//xKBgE0d9Jbi+dw8+jD4wafpmtQrhNdDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvqIp+YufKuloKYaBziky+7n4tHcXFCuSdgUf+LxhrawxXT13LBXRlW1FuCBk5/l5/IS5PKbGRznMLU2TL63e6smZs4RuXRbTCaxZ9uP9MYSHjh3NvwWxa+QmjbT9LVKlMP5gchvKvH/BYr2gIY0Z/C6nlbcazn0ov9zZ+5NOYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vXLYqybk; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWdGHiI8iNINT5NhhFrGYP2TE/DRrxcea5E8htfVbhRXLLj7XpjyQHdvKhPipHbFPd0McCU79J3dwEE0W8+WJ2o2P3uztKE1JdQUygUZbu2xh3cmWhc9LJ5D1ZkzKBrm/Pi7KFvRIQ4xCthKNJgITtCku8bI5sEsp5C5LbsirHdgW1b554wixJFH4TCQ+V4kIUQnxCXrBfb2MNmSNsBXFS37uyL/2IpneAEZAh+cawHCy3efaMVUhGntMWm3yhPwQJzhtoZnvaRPX8AR3AQRS2HpDj/ndC2/zcA+piEO9ufr6vt9FlBhd0B1xUobk/XmsuzJdNpaUEIlvq3JNwd9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJrg9tcE2XQvilXa/8k8XrTH/eBtZIADjQZ8V5Gs/TI=;
 b=Hir5WuTvrgSjO795uM3X+dg9EwofJWmzoMkfvs9lIYeKB/1RJxVJwhR9hVpxozyMpMA5UEvPrKML/lGFNOkn/im/d1rVkrRyFlr+C4TmcDFENgFbub6+rsPpOwZ7haSUqiIx3URKhtOEa9QijmmiKsHtqEcjmvG3NIGF0B+f5aMK3YlOwLvjnHwQ31c+isM5RY77zc9yiGoh4Pc4h/GvL5e2QunUOZEi5cO4P9SNjI9QVPcxqFVWDWnyAxPDWFX9y8iYpcFga7XAclI99m1tViIYdVOW7IxbvBc66vcgMecvNbq79q7q5O6xmrD/xuA/0/oY7Qv7VcftRiYbLp048A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJrg9tcE2XQvilXa/8k8XrTH/eBtZIADjQZ8V5Gs/TI=;
 b=vXLYqybkQD5WxrrrbCdAvSaIsTv0iuNgC6tP+u1ATNIfzUK5SQv+XATSNPyLZjzGQ3m/vXU/TZ+Fdp9b1KooKxVse12G4iu33WcVEkMbW6UEDzuozjQCCCllTl7He40u1jwQv//d78/e18Q5SIINf2pczdCYKsWv68JbERBoNG0=
Received: from BN1PR12CA0007.namprd12.prod.outlook.com (2603:10b6:408:e1::12)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 10:22:59 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::58) by BN1PR12CA0007.outlook.office365.com
 (2603:10b6:408:e1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 10:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:22:58 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:22:55 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 2/4] cpufreq/amd-pstate: Do not attempt to clear MSR_AMD_CPPC_ENABLE
Date: Wed, 23 Oct 2024 10:21:08 +0000
Message-ID: <20241023102108.5980-3-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
References: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: c08f21b3-877d-4522-f122-08dcf34caacb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tbf4X4CfMj7ZSaPHJiAzsaVGqV0W5Fc7p4NrGnJwjhUtQFva5qbANcrNmoSa?=
 =?us-ascii?Q?yWSrMlnR+fdzpIyl38L1WGOlKr/0a6F2EtmrkHX0m2J5FfYOojaXR5I6NTOF?=
 =?us-ascii?Q?tvb1q8HRBr2X8Rd2E5mq6KjbP+0xXo/G1P1xpUeLmA4OQ68HaoGTve+dBF9L?=
 =?us-ascii?Q?lcgB6QNxPrxanKBhb9uIGnvlEnPk/EGygvMu/EL4CvApu+ctNGgQfIqcjiLe?=
 =?us-ascii?Q?hbxA3YElxK/yTGDXNoln+YbfKHDrtaB6cdukp6KLGlLpMoT6GCKyhUNJw7r7?=
 =?us-ascii?Q?bjdAiB2jlFE5llfh1qVJqK3eTsD5kM80f9aAhvYPVAfO1a50UD9M3rKak4ax?=
 =?us-ascii?Q?o3n16XNQuCuFNBqJLQ/oZvvA4bAG/iHDOXSgcpWJIhe1mESHw2thpj0vlW8N?=
 =?us-ascii?Q?mgw+eaof0FLaOksbpPMVxe5maqxbEIlM1lwwu31CGiQ7SYDF0cPHPPm8QX3p?=
 =?us-ascii?Q?BAgqBxswEcsjpBCoNoywvZScG8tM5uPuiyNhnaT8YEfEoiT2hnRlPEIQ3Q2l?=
 =?us-ascii?Q?bCW1odjBVMCMe39iRvjISS75wzgi43hk0sp6wk8s92pi+bAp82ZWeBZ6UBkW?=
 =?us-ascii?Q?BRRTZWiBE+getePHC9RRxpQuw7GnPsmHb3Y/qUp4BEsm5SNhbOnydpHA3v3P?=
 =?us-ascii?Q?P1zlRkHpwAEfsS/EEwfKhOpMdhvUfcxHZ6pRK/OU5Dd1tUpumDRfjfi0dZ3k?=
 =?us-ascii?Q?YRw87xEXI9DfG58jHKlh2FSqOoV05Qt3wla8fcT+F0bqnQFrYTBV29Vgljor?=
 =?us-ascii?Q?9B4FAv+0BdADWlTu3zL5hdGHKfuM4XOtA8dIkOioE4mfsYG5I7dRYOVishDV?=
 =?us-ascii?Q?bKbQ+T6s+ZGMbBh5quaAUGN/PLCfzpxT95wT913xx/cUSwJq/LMgsbrrWOYU?=
 =?us-ascii?Q?YWYCjMDXq/9rb0bZXeyhRYA7vxzHOwurU9KhV5rNirC496Kroyp6/ONt9fZ5?=
 =?us-ascii?Q?M4rMMKqQxpwbe4LV+mXGx92N0IZZYdpWsjcbQuCBjCsUqhRpeUEPuu8xb9/c?=
 =?us-ascii?Q?VnoYrDmaN/8d2ONvidbFFHZtWWORakr5x0Mn6+yZm+6QnFMhzrIBNsfigVcN?=
 =?us-ascii?Q?vyDBUkMykjIJgN4qpfUnVrsPC38VnyC9IRmEyTz5zCu81TWJK2/9/i1514R3?=
 =?us-ascii?Q?a680B9cc44StaFKYfTxlbYs4zJUQYz79JD2DbQ3TAxeMgZtaK5hwh68qEyvY?=
 =?us-ascii?Q?x4FJvzRBsBJ6PrRZuv5jNn5bHE368cB8QRuBfzsU5OrrHMsr0J0Gg6SEuxxG?=
 =?us-ascii?Q?8PYpcstahIW8zT6f4qT23wwBZLgd0xR79i0zS2fqCRQw+QdNEQRwczdbtCOV?=
 =?us-ascii?Q?4oAVRyJvsUi4NVrzKkk8loPBgxQKj4DQZwHTrOfaRubucVJnqv3uXP0XRHn9?=
 =?us-ascii?Q?gcjCXZ5MjQDtPjBEj4KCchfa6jw4Auk1Yamn4P1de8d7+LBLcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:22:58.7699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c08f21b3-877d-4522-f122-08dcf34caacb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490

MSR_AMD_CPPC_ENABLE is a write once register, i.e. attempting to clear
it is futile, it will not take effect. Hence, return if disable (0)
argument is passed to the msr_cppc_enable()

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 0b4a4d69c14d..576251e61ce0 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -311,6 +311,12 @@ static inline int msr_cppc_enable(bool enable)
 	int ret, cpu;
 	unsigned long logical_proc_id_mask = 0;
 
+       /*
+        * MSR_AMD_CPPC_ENABLE is write-once, once set it cannot be cleared.
+        */
+	if (!enable)
+		return 0;
+
 	if (enable == cppc_enabled)
 		return 0;
 
-- 
2.34.1


