Return-Path: <linux-pm+bounces-8924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDB590372E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2018D1C23437
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ADE17B42B;
	Tue, 11 Jun 2024 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sAFVDwjC"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60D17B41F;
	Tue, 11 Jun 2024 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095994; cv=fail; b=bcn0X9AgBLCvCCynVvlkFrdZVwYfl/zFeKG3KPoEAcnNZe1YTyaH1M8iW5j+Pl1kvQlSDhTa+1fd2K6BP8ClqQJ9eY/TfGict7y2CgQVBZKCLmMMqirfYTMs6pQI2COEgO4ix1FIvrOGqAsCTr3iGE+O0m2JlzlrVhe65xia4W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095994; c=relaxed/simple;
	bh=fFfsKxNhZvDv10T0+KsP6LiJUPQ5KyzqK+JF4C5Lu60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AB74IkXQnJ5W2oTYzCIkJw1/ghuTutAbRNvgOglZZ3wlwK/KHQqeDAVCgpLSFE1WgFvFoevYm2h7MyjNdjJzs1jDo9QFdskpqOTpmqpwXuMK266ccgBL4jwBk6Czz/6DnKQz4YnkkGUAE5/7lSqgQ++awFQcoN66J/wROIFpOEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sAFVDwjC; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsXJ43wcgQ0NDxt5jyRu2ckqAj9W9UmhidE79bLNZUvVhSxHd8v5LH8i4Yglvit6FUAX84k8o7RWvIJUc/IjDE2S/zzFSEW67JqHvWbokDKhFLLM7Igi2QSgXIzH5OS6zeveU4nPKr7M9hHdWhGeqshPP6dVK+pAkLAYKWZhhwe0Od6ZfYpvUmWmhnN8H75sKKk2rQQH2uH8+H+HBoBnTEmUlaylqIRXazwd62lFH8V0h+Uw4pgdNn/5UDrHKUU8CpyLlJWguUk398yAbgZVvGpwYox1Rj/ZWMjD4NyIk64Zcn/139Q5v6KWBZsSHwfmGCuFJuVwh6S1l+XCOScUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpS9Lp4lgApv0tVb3MEd6FRzJU5Az/KlCTpi+pU3/2w=;
 b=H4vVfoYZsoDarFSAQuC2bWKfKkj6Xnu7CH6+EJdzpNsEF5yEfLbUZqK9YpJi0YLfowdQjDAQrkaFjnzWoBdbUGH5ygDQa6TSGZbFUEahnen7vgCUOdHwwzdrDdUnjapiQJBMWzyL1XyjzZDGV90MLjEgcM6pWBBRU8UKGzMtMh5+PQMz9jbRHbDkJZ4HNoum11IfCKjF2o+hW1+punrN8TQsmA231ojLPQmaKnllolKknKSWOr7L2uLZuP6+UUtDd5ewlxkD6SQpELX+2nGM1Q7YEAxkcty47XfYe/gQejPv+3I95oFDM9atdWjFWmeJkU8E54Lcye7Hsan8SuGhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpS9Lp4lgApv0tVb3MEd6FRzJU5Az/KlCTpi+pU3/2w=;
 b=sAFVDwjCl16JuzQBNFWWJ+MUtQjU03Eb49f1fqFJNUYPlgryfdoKShqhgDxvEyd1eRsOrYDW20pwf+f8cjnFSR76FjnhNFLg8hPB8w517bwCMw3ZL57Zmq2+chTPqsymARLgn+QK0bGGnEOsqBLtBJHlpDzYVMcfY5YcYfA33Ds=
Received: from SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Tue, 11 Jun 2024 08:53:10 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::5f) by SN6PR05CA0011.outlook.office365.com
 (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Tue, 11 Jun 2024 08:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 08:53:10 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 03:53:06 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 08/10] x86/cpufeatures: Add feature bits for AMD heterogeneous processor
Date: Tue, 11 Jun 2024 16:52:24 +0800
Message-ID: <7a2817ce6e8e6a2787bed8285dba8d81423d8414.1718095377.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718095377.git.perry.yuan@amd.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0be98f-bf7e-4b3c-bcf5-08dc89f3ebd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?66Kx9u/Ab1NCOcnZqLlDBRrPYgUabZS5nv285H5M9oq9xYSunb4iJBoA2vjc?=
 =?us-ascii?Q?41gP4+8Ut4OXFRndZ5CXPwYzsgI7pPKG+gUubs18TMyCYl5iQI+9pU8MQCnD?=
 =?us-ascii?Q?89qNeSmjp0e/1FynKGPkUkuqpRjmxM47+X4zXDJCqrDpbYV+gUcSbcdTh6Rh?=
 =?us-ascii?Q?XEs8NTac1nVEyH++3aM+ANwZeasnelETL2JHGivMMP1uHTXIM7Gyxd9IW4SP?=
 =?us-ascii?Q?sCrJkjfK5uAFp13bGxGSmfsAhpKzotwOfHO6GYWuXjTUT7rQ6xa9Al3VahC3?=
 =?us-ascii?Q?gFfjpIaQDrC7bAM8picQa4D1wrBl+NwhZQ0HwwnCDNxNnDwZKqiLa1SP1W/G?=
 =?us-ascii?Q?tenlwQ/4YREVecDSPdswr7dwwMX1arhtpAroMHaRFs4fZsw3NFz4FB1Ep+Ke?=
 =?us-ascii?Q?TTGXL7TsHJ+JiPvSFvxsRaucvINMyLpnDhN4NH6bdtE+rr9NyeZBguqF41gR?=
 =?us-ascii?Q?062mqY93oJojDSYUx1+BoG65pIJua+KPNeSy8/StcHG4YlaL/EaSBqFiiaB8?=
 =?us-ascii?Q?I6KswCrOSbAzMgwVw+h+5jYDKy7URY9RiqN7YSynu1FfO0/PZQXCjmWdBm2w?=
 =?us-ascii?Q?Wt+/B0zjaVujKWswP70cMjAwGr79uHYGwWtqljPY4T5ZZFLU7Kdxzq2EBIok?=
 =?us-ascii?Q?4lBGKms5zEloB+tN4kYT88Hl68YtkuzZkhL1llppcXehtwiwKI/8oNdBNXCO?=
 =?us-ascii?Q?3tLg2i+MvE++qriux5JMwXM2b/8WQqnizBnn0AldrvV3v59nlXeZNBZqkRTn?=
 =?us-ascii?Q?8u+7DEFNVXppfNFCQgrwMz+TTLCVrDCOqroAdY5ufxqWSJZewdZey9Hk23js?=
 =?us-ascii?Q?dsecNGFMU6z7K5U//R5kbAB+UYhc8lNG0vbkYegY1oNdamH8QhQ+uP8qFnxq?=
 =?us-ascii?Q?9w49Y0proGA9yhvJcAQEt/+6912VSPitlL4aZn0pjZDYy6xXcib2RzU76Z4w?=
 =?us-ascii?Q?e7dUPux4SkO9Btnz7WMSqm3cpCCd5J4p3fgyjDuNuhC70HkV+8nVyUpBWq56?=
 =?us-ascii?Q?Cm/HxrFUK2lBewcH9qrIaaLHCPFHDAgKRJlXYcStkmkTpP86TGapx2hqOPKd?=
 =?us-ascii?Q?6c6Um1NkueTDg9KLml8V1hhR6cPvyYyZnd7ek3LQv0+RruqP13zxCvWKAsvs?=
 =?us-ascii?Q?Uox+qPF+wNWDkyk8i37vocoThb+Nkz7TJNG1tcCfgATXMWARNO6oSM7cvqKy?=
 =?us-ascii?Q?7TAq+hEa6rFFtUb7I5vXeSwk0OohFW9UjnjYfn9gTj2tC1Zy9DTsqUIpE5zj?=
 =?us-ascii?Q?f5ZI+lPfc5qdjk0UrvxXAgbsLCVL4SqAwoeNllaVmpC7v3BSzMOnTJg1mfTQ?=
 =?us-ascii?Q?pQxTbZdQWm5mdVFAtxeWgyZke0Ui0fFcPiITPhjUkSCykyWKcevLv92wiWCZ?=
 =?us-ascii?Q?3t2SRPG5u15DXXp5nNECJHSavgbjg1bp3/2nN2FIVAZESdBYcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:53:10.5698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0be98f-bf7e-4b3c-bcf5-08dc89f3ebd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133

CPUID leaf 0x80000026 advertises core types with different efficiency rankings

Bit 30 indicates the heterogeneous core topology feature, if the bit
set, it means not all instances at the current hierarchical level have
the same core topology.

For better utilization of feature words and help to identify core type,
X86_FEATURE_HETERO_CORE_TOPOLOGY is added as a few scattered feature bits.

PDF p274

Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661..39a92338c015 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -470,6 +470,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_HETERO_CORE_TOPOLOGY       (21*32+ 5) /* "" Heterogeneous Core Topology */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index af5aa2c754c2..9e237a3daf7e 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -51,6 +51,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
+	{ X86_FEATURE_HETERO_CORE_TOPOLOGY,	CPUID_EAX,  30, 0x80000026, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.34.1


