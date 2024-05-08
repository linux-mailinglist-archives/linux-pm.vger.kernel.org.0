Return-Path: <linux-pm+bounces-7628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559AC8BF6EB
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 09:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787D71C22826
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 07:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45512BB08;
	Wed,  8 May 2024 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M0EFPCTe"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B9288AE;
	Wed,  8 May 2024 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152896; cv=fail; b=KHnEs7rAEh747iad319aezYAz7vYYdd6STPVRAC/d23nMdOOJLP5R7CL8sqyUwuXnb8vTDk8ZjbX5bTbydZFvCDDgCmy2ZZxWFOY9tjy98v7EPtcZvPcblraae7a31dcxSWm+f3eI4I+0n8Ck3gN4dKT6mpI54j3EemiNb0Bf1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152896; c=relaxed/simple;
	bh=oEJ1aIAtGosrFyk4IqINDU+8CxFIH3iJUhgfurIlJY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVNijk3q4qSkcsWQOdzbVld4Rl4h6jnOMcy/5Mh2vhzpJP6DKSZUSLPMfTvlsmJLXwRGKKKhf42ntOHbUZ2kWD0nwVypsyqQtZ3co9w9HqYVbFq5ajuH8z4rvEuhxGxEY8oVVJA4Xig86zEl8sb3WLuzjDdQRT0Rn4BNF6r7LoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M0EFPCTe; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBRkpewO8YQELlplOEFndnaVXH4Xd76L37cIkAJuFzHNnSxTAOusEHZFZSO/2+81sMLoyHOq8UdvM42fb3HnY2ru1m+84ArVavOjr2jFMWWN3BUIIt+bCyr97+4ozxLZXm8X7TpYi/KDLroWof9aNfa10AdMXJYWD9Hi/4BeHcabMKxJ0uoq671ayAK4DefmR/Z8EXy60sfEX8JPfs+oe7Q3DeoRWCiU8PMz/rx4/8wHlmlQduvhb8Q4AmTZ579ynS61j/oMf9os7cwC7NpnOg46imp2BIUCTQGQgMh3dXkdOc0bsorUfnFLLcxv6l2zI008LTDDwZbJvk+YEg/9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kq+BXGQldt6vAGnrN13zwfmUSkeLFSTbaIEjid2Iko8=;
 b=Sd8c2usf5VntQ49PuklN+zQkA9w1tcs1w4BZZ2Fqo+uOqt6PUoS/9iIP1KR5+nJH8KYQbpuYDk1+NQ9+mnxfSxYRGcjuPeiAZ4b1u7uNwOsD8BRyCteEe4pRU59PlE3Q+X57PyM99ztF9HXCuQmuGH2i+Vr/JTK0N/M9AXHYbhg9TKFIK7aIiTlhg8TxX2VcDR6My/Adtulyl5XlW6QS8tIbVDjdPA8MBDdAPWO+bSIklCuDGUSHBVFL/+DS+DTbZVFkOGJzJn3j16gRFLx4lmhy/pVhaBVUAHi6nIXCjyZ+WSKAGpwaYo+c8fTGIKS+7ZT4V2lR+LjSnWNbXGQOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq+BXGQldt6vAGnrN13zwfmUSkeLFSTbaIEjid2Iko8=;
 b=M0EFPCTeWeqMPpuEz+N7uq+cWCdtWTL102lcJqF+uctS0T3vnsKC6GpNRrQPSoTeBPR+inJxaRO5j3nfdzitT6Bj79rcLOBFforWCBn82YqxGmoDAUTaUC7KZgACHHoeJWCChVCHCltE9/ohWD/esqQDnq2cvNtIopwOymxZvxY=
Received: from MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10) by
 SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 07:21:32 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::c7) by MN2PR01CA0041.outlook.office365.com
 (2603:10b6:208:23f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 07:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 07:21:32 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 02:21:28 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 1/7] cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
Date: Wed, 8 May 2024 15:21:06 +0800
Message-ID: <5b37025fd0ce8f72ae4667bffd85dfdfb21380c5.1715152592.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715152592.git.perry.yuan@amd.com>
References: <cover.1715152592.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8722c3-94aa-46e0-7299-08dc6f2f7c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4vc1aK2jfGYeYMSl9FgzB7oEs+njfzu3U/QBVhmuMddj7HImEC0RYKiXF7G0?=
 =?us-ascii?Q?LaCty56uHys4l91f62bpLikpQWkkjgDd170yc8yHUz7FLcUVU50t1Do78ZjL?=
 =?us-ascii?Q?KLxWxGJAFYGuejTcSrLirHD0wu+GD6Y+QEbxZpSwcEomIwSWAiMhZ7gKPF54?=
 =?us-ascii?Q?xq2GhnqObRdfXFnoLbCuKbdI01kRyz0Yzy2ArjQm+P4pIdMtmyxoIvlBqeWr?=
 =?us-ascii?Q?XNU0iYh9tW2PIfxOhRFlDCYKQekw8fJL24M+tgQkTS90qyMnsyD3vuz+Rkm1?=
 =?us-ascii?Q?b+Y9T4Cp7LL0ilYnMk8xerNxa/hcp4+DNDmBFD82b9VX2axzZ/l1PGpElFgt?=
 =?us-ascii?Q?er7ydo9UL18CWsJ3+5TfHanxDbKnn8/rx2/rmgBDP3j1LNFLIq7LUGTr2eqk?=
 =?us-ascii?Q?zCRziHOv4I+m/YxHIYSD585/MWklTXp1iqDt4yPRGIZI2JvyKD/GAd/ByEBn?=
 =?us-ascii?Q?WTgLrTRjj8riwHqTyKgsFcEtqBc/SVZExUfM1SOxe51OTMbwATgkJrd3nrTh?=
 =?us-ascii?Q?FmhgQEklsDmGUD36Y988rbSd4Lqd6+ssdgjttzyvKIJ88bUjksNta7qyMEfj?=
 =?us-ascii?Q?uYz9HzYeZkOxT3yxf8hrASZx+fa+adlXC6la5B6tAM4vODA1ml+sEXLOL9Yg?=
 =?us-ascii?Q?Vx0ULdijvP9xeCFPkV9N92phyQzx2ULkJWFBMH7W2IwXWjo5aiMURApTkJWZ?=
 =?us-ascii?Q?CSryvfjlF02hbd2kahGFjkrCeQPWHYBW0QBDck8njkGqas/7ShllQyovV6sf?=
 =?us-ascii?Q?l/VFpW6xpzXXqTycFTlhAs4LEhFVCA6A+GLSMwltlQVCxOW55vSJUnlR5qX/?=
 =?us-ascii?Q?Z/CzRpd59ubRxp7eNeaXtyrpey8Tn9TyG2RM7h6ODGixo27lG6X9ep6EyKi2?=
 =?us-ascii?Q?GWtENJW9hH/jdUAXugUOCwyP34r7CPNT3NsLhIG37eOIn0znu8vCW3ZZrK+1?=
 =?us-ascii?Q?Gq4NXPGqw0bF2rstYvTgQnHpVv5kC/3vDdyeqJqCR/pkANfVKRDatq5jYRc8?=
 =?us-ascii?Q?PWc1kftjDj+4FjgRoujODcfRb/FCMC69EKZEi1ZuKg2fjjRRzsE1qHMAERI4?=
 =?us-ascii?Q?tyCGcEshuS5iCez0xFRkgQJQQ63svaiyJZ6FhEwT8aTXpkJNjOz4vpHdAy5s?=
 =?us-ascii?Q?U/vd1hw820stpo91RMnb7/uh3UahnjEHEWTLw9h3IHhOb00eKGTUD7eo2bBi?=
 =?us-ascii?Q?rA/f5yyhVsfc4v1MwaBlDqkC3cBKPHDALjzGEePBOowE50Cuv3A7tYmjrcAG?=
 =?us-ascii?Q?KNdQRabd6mw4YgqUmLv49R1RyhJV5w/etZsY22euGzaqFkeXSOuNM2q/92hu?=
 =?us-ascii?Q?1FfmDNGEBo7/QAxTv9e1Jx3pV5ZPclOWKCNIEcJlSsC7iZWtUXFtrAYAUe/k?=
 =?us-ascii?Q?EHn6MzQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 07:21:32.0231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8722c3-94aa-46e0-7299-08dc6f2f7c5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132

There are some other drivers also need to use the
MSR_K7_HWCR_CPB_DIS_BIT for CPB control bit, so it makes sense to move
the definition to a common header file to allow other driver to use it.

No intentional functional impact.

Suggested-by: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/msr-index.h | 2 ++
 drivers/cpufreq/acpi-cpufreq.c   | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e72c2b872957..8738a7b3917d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -782,6 +782,8 @@
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
+#define MSR_K7_HWCR_CPB_DIS_BIT		25
+#define MSR_K7_HWCR_CPB_DIS		BIT_ULL(MSR_K7_HWCR_CPB_DIS_BIT)
 
 /* K6 MSRs */
 #define MSR_K6_WHCR			0xc0000082
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 37f1cdf46d29..2fc82831bddd 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -50,8 +50,6 @@ enum {
 #define AMD_MSR_RANGE		(0x7)
 #define HYGON_MSR_RANGE		(0x7)
 
-#define MSR_K7_HWCR_CPB_DIS	(1ULL << 25)
-
 struct acpi_cpufreq_data {
 	unsigned int resume;
 	unsigned int cpu_feature;
-- 
2.34.1


