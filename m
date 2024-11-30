Return-Path: <linux-pm+bounces-18284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0191F9DF175
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908EA2816D7
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 15:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F1719F118;
	Sat, 30 Nov 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Llb4drEK"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62612A177;
	Sat, 30 Nov 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980054; cv=fail; b=cn20exuGdOc4ZsYEeJ4JjzJeiZrlAsuDDkeUg/viNbL8YXogPYskU3PiLiAG2QMmimw6/DEBa6y5QIQpgwNuVdgFejEdTWlBO2b/2EdLfOwN/IPts2+h/KCoMx0Ny8h3B0Ud5MWi/Yh0MBMUFYUTJRFVWYyVMiCOedNLsWTsLWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980054; c=relaxed/simple;
	bh=6/GNpT2p5G0nMQWNGh63AxQqGIghyA/swYKFuepemJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1RkZWDQh8mIexhwLNSwjJ4jJb6WV10brnOeoieo3E4GoOMilul9WNqGfFNUwg705yPmreHw6vn6FzenaoMtZTq4gHbwqPbR6MuHW42nFuJH6Nt3P4GdKcZHwNcp2180iwjld1Qvcf/LpfMZYZiqOis9Iawz9k34rVNXsk6VQ7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Llb4drEK; arc=fail smtp.client-ip=40.107.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dX0Ywow2/MAxiyzthzAVXf1YZ8Ub3vP9yTXPvBUR6ff/4nTiOOJvBGM5Y/D2RPNt1bRMdYpZOoLzCtxUM6tFEDMcfQLcT3UADgWzen4jTVMtikyUdSl6+wNqoFUpVwcNYY/7825kQUBEO9OQc9dGd+Z86m8UKyYbypLSIqi9rdUpzFFGjCNmoL2m2FnrwJ2MpcmQxhIj1m2r03+gN5ErDcac5w4TaUUpbEJVVnvr1Pl0eomr4NoJjhSw1DeGQ07nKjhKiynSORsUs2lmkznAlgG/ywwUgZWScy0wwX5puAbq8xTaiYg4L0IoAKba51DLuohZXKAGOQBhazsOBBct+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MK4bqI2kTIwrrtnwYodnqVtCHNR2bI5U4bV4Sc3i77M=;
 b=qjma4AZAaqM7HRUEsGMzGcWYw6JicWWOxRRHwtbt4kwpfTWW9mgK9DXyW7E7kdu7KhMYunBujYiXCoAm/oP0MY/flYBYM73wlu5inxFKOdF6eFQZQMus5N7iOlNmOM0gwmTLkQDj7ULg8bUm11tQOoBcpowxB2t4QZFEo7b3rEmYdEwqZ+nKT7tnEEtX3XI1+f3RQ7OcPVZlBCzLu/Bh0xfIhab0V/Uh0vxJ50MRCTvuBtozWFaNLexcV31JpXVpKRMWdYdEVzSWyIafnt/tJJVl2oETCdDqUFSH9s35RlCpZBvaTfIN+KjSCviGbgYA7PF9EtCOw3KeeLmgd+NYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK4bqI2kTIwrrtnwYodnqVtCHNR2bI5U4bV4Sc3i77M=;
 b=Llb4drEKl4YPW6C3RbPxhA2MZdYQDK3xZUUF7r8BjccXeMtRLfQWS4yhTfP+dcjBL61PDwxr45dFiVR4Z49WsrMUc4Yqyf+pEO1+jiB1oesUNvtW6rNzJPZh+nR0XxRHz+YuJWv4YSiqg/V35h9fvmUirWH9htPxmHoug8QOD6g=
Received: from CH0PR03CA0309.namprd03.prod.outlook.com (2603:10b6:610:118::30)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 15:20:49 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::b9) by CH0PR03CA0309.outlook.office365.com
 (2603:10b6:610:118::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Sat,
 30 Nov 2024 15:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 15:20:49 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 09:20:47 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v7 03/12] x86/msr-index: define AMD heterogeneous CPU related MSR
Date: Sat, 30 Nov 2024 09:20:14 -0600
Message-ID: <20241130152023.684-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130152023.684-1-mario.limonciello@amd.com>
References: <20241130152023.684-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: f082e2d3-017e-4195-3f48-08dd11529216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sNBdIoPcPK2GImYl4Sc9ikgDi0Z0tdZIvRcYZordPWwyQ0X0YqM1e2Kw0f8a?=
 =?us-ascii?Q?KnyL/x6Mpoxd/KvKbTzsFcqW9lvyjkicDmu9ZUc33ylb6bbrO5dmaf45YzMp?=
 =?us-ascii?Q?OqqjQCpC/QArfmR6nPtCMHWBkpjJNSp144WE9Y5qNwwE5ekTiir84fm0cgDo?=
 =?us-ascii?Q?h9oKcngFdTqI7/uVhYh3rDBb2OM8vSg/A4KZeKg1cLJGouIBXF7eEwFpJUa+?=
 =?us-ascii?Q?Q/mPyFhZ8Iy7GVv3OnX8g98J/mBRkNWjWW8pF4M1qAZ7d/qJ8Cay77VIXX/u?=
 =?us-ascii?Q?f7G/VEW8vUBw1hdW8IVEzNewzwiRGxa+uqfJRJ7eZeLuUzYS3s8SHx9RGOrf?=
 =?us-ascii?Q?ar8LxdGyYS+BGkepK3Zqn4gyEiaIRufdzE8H1gI89vGkb2BY3Q+bsCEy0T0U?=
 =?us-ascii?Q?aiER+5jWCAGaNdidAyPclU+9c8JNnfNa8pkIdxZCpjEzmCI3anLSOtJHHm/C?=
 =?us-ascii?Q?Y0G/71326u8apk+dzazGeBm9Ei4+ufGVOuHbEeRl01JEF3VQ8P2cTdKHhUqQ?=
 =?us-ascii?Q?ck2Tixwh26ox8cStI8pMvmVctIAFJt7zVM4+S/qRxAEeYwuS1vPziHTArgjg?=
 =?us-ascii?Q?sI1yupoTUjB79x1ACkRJ6MinvbC3b42AZ+ttk1/wCDLTvo1eHhdcdnpusEPf?=
 =?us-ascii?Q?VsSuyEL+lboSxmz8l7DxqCSq1zF1NbjRiMfnZKGr24OpErvUxQVNF1SHxAWf?=
 =?us-ascii?Q?90bjA8/x1jm7ecrXimodL02UO7EaeLOr7VEG2iPelrBCswVpGlQY6JERDDAs?=
 =?us-ascii?Q?T7+Ab9VIRWYvVucA8DnCoos5ZM+LGZk+OSYZ4j4iupG2EDa5B3WcRs0yIZtL?=
 =?us-ascii?Q?AbtfPJgIgpNzf8ZDFZYNKyvtlRgjyVrQOcRiy+DG00GGc9JUmw9PeemY9NWI?=
 =?us-ascii?Q?/0Ss/LKaMwunc468bUK/qhY299dySzOlg+0eTpVHANZ66/7URnqUvxkrzs6N?=
 =?us-ascii?Q?cbWLKBCo8//0gYJi0DB//t8B/igjrKWUOZ9fvCJBF1pjPWmiReDyih26ITse?=
 =?us-ascii?Q?LvgPkE7sqinOhpCd16lUzDm8qoDPqvSsyvqwLL0OZBpEbgclh5g9lxRsiSoL?=
 =?us-ascii?Q?FbwON1vhcO0VjSaFDgTUep/PFK6w6brBTg2sGqsL+qgxCHO0vKCF28Fmw1jO?=
 =?us-ascii?Q?HgI33mOTpeQYEDXgdhPGBGv/9MGtxCHpwDNIBssTyIMQ/aojy3qQJzbYtZ3G?=
 =?us-ascii?Q?bakJNFqgkdk3lNIILZojp0OTnzbklvPQgoFrw5pJTkwrdlz5JIzZpru0YSFw?=
 =?us-ascii?Q?qt1bS2ZcvzcR5cwtP/JTpnS0y4djuCALRn6ZyvfA2F9S42DCnS/rDX7D3vkj?=
 =?us-ascii?Q?mzSAXRX8x4OYs4eES/YiYxg6gN1laUcmUdTD7jkWsTLbZGYmFgzDnhEO2UH7?=
 =?us-ascii?Q?y+oq7LZdnNpiR8/o3i6RPTv5Vi/L5C2NPGJQH1MuVYwAKNQhGXz2bAFbFZj/?=
 =?us-ascii?Q?k+tIP4RdsyTOvXrkYC3UE9I73pX0GK06?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:20:49.1306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f082e2d3-017e-4195-3f48-08dd11529216
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846

From: Perry Yuan <perry.yuan@amd.com>

Introduces new MSR registers for AMD hardware feedback support.
These registers enable the system to provide workload classification
and configuration capabilities.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6db..0cd5ffe50f4a4 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -712,6 +712,11 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+/* AMD Hardware Feedback Support MSRs */
+#define AMD_WORKLOAD_CLASS_CONFIG      0xc0000500
+#define AMD_WORKLOAD_CLASS_ID          0xc0000501
+#define AMD_WORKLOAD_HRST              0xc0000502
+
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
-- 
2.43.0


