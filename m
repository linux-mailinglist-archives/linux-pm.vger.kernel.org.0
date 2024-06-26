Return-Path: <linux-pm+bounces-10004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9EE917747
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9B31F235B3
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656213AD37;
	Wed, 26 Jun 2024 04:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SpyZZigu"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD299139D04
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 04:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376097; cv=fail; b=WH1Cqc8IHd8axbabYrdna8q58XL/8QqoWrwmst0HSyTczO0M2ecvQe2pJnWOtbFQNeHUBGxcufhsw2+NOeifQ9Y/zEmpzvf9hbeQjyjZDEH/745zFJ46bHRu9cRTVmeycldFjSR8kdn2XTX9EPSo5iWPCHTnXeJ8GZ/P8c9AtEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376097; c=relaxed/simple;
	bh=TASC5jguVhON3YI4f2mt1FVFg/rAk2Brs8rf3S88cfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixyJKdqxXRtgkYSa3VAwnKvTp196SacrPT3CcrrySDwaMmheJmktA0ol1cTZsJhtP12qSpRg+lJKxD8V7p5D2lCRQicSBX8Pj3IG748Xx4LBVaJRibZnJ2m4laup3uebq5kUigzGJcE45EbWtqFlXPLLy7ePz9+xosZaMT5tpEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SpyZZigu; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8UlSD0raWCS+kA/egfWAyHfX9M4pYpVemMEqgt2x7FckSox467JsIZp5XVVFgIb3mbHI8YHQNt7Y+4fskiGeLpsilUknOu7AgwwAfMis56J2N034Z8bEkndywledRJqwG/2ovQ0Kb7yBpQJBJMe2cyFt+WOP5gR6go1530dEYfqusHXiWejDf8HbGxoUYi8uRH3JRsCU4EInkC7DuTXuab9FRYMIm1r0zSxmZByZPLsWiRkgU6v2wlYT7nWbX+AJXreUfuzU7Ly59sD2r3T+/f+GvkX9w0+JJ3OV88sMYVZ+us28/TKzM7dj1nZ1cICvQwQv3nHmpD1iNZJ/rBSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHouJyi/jLHbdCjCwXpCrmdGEsgbOGV7IXnWOt0czbo=;
 b=Uj5h3q/RO3t5FYisErVQY74Iy2JA8oGa2W2XjjZLOiroT38byhGR7BsA5JfqsLkhSDWQpD6/jz2E+KrQzijDon+hnj5C+adyrGDBS8BOzKsuNYmxZU11w3xAW0z5gBLeE21Jt7j6sDyJO6JB6dzfp2ujqFEf08rox809NvwUsCHCjMpTwnkmyr3y7zOmygYBGAriC0Bh4srkNd0BZYMXFLJj2KQ576JvkobUgDbCmsxFLm6IXsheF/upqjoHOvZu9U6Hlbh9YWbKCQwYSoBgGhyccp3u45/p1sCk3vR+4+Hkjz+n4yR2Kabu3g3BBJb8+tBGZsvtgGq776PBg4fWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHouJyi/jLHbdCjCwXpCrmdGEsgbOGV7IXnWOt0czbo=;
 b=SpyZZiguSHpoTQcuHOnXOu5o9A/DrNOKrR/9UgnZgTzVEdL+kcgE7xaXbxXXPp+abr9vus5LD9B/e6B1ag4vhx83xROTRwTOuqdX1YLNIBHDOPPs97ZZtBPys9FQ63WAfUbCR0b94Owxflkrj/uqXFlzSdvF4I+MEZqM5tEqDDE=
Received: from SN6PR16CA0055.namprd16.prod.outlook.com (2603:10b6:805:ca::32)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.31; Wed, 26 Jun
 2024 04:28:10 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::19) by SN6PR16CA0055.outlook.office365.com
 (2603:10b6:805:ca::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 04:28:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 04:28:10 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 23:28:09 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <perry.yuan@amd.com>, <gautham.shenoy@amd.com>
CC: <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v15 1/4] cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
Date: Tue, 25 Jun 2024 23:27:30 -0500
Message-ID: <20240626042733.3747-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626042733.3747-1-mario.limonciello@amd.com>
References: <20240626042733.3747-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: ca048f5a-aa65-496c-3849-08dc959862cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ROqJyixaMLqL54rx64cs1E0a7LVrsWNPDy1o6ZhkLLRyM49do7Lw68QwHeJW?=
 =?us-ascii?Q?A9rNuT3AGE0nOJr81yAf/qyO4KcdgKaeqUqOcDtMJ1i3PAw+Gf3gRtit9SmJ?=
 =?us-ascii?Q?mTCVlhfIKB0awSN1K44EZKxU8eAyDbrmRi1Lancgctptvcx86rUCK5PvjPga?=
 =?us-ascii?Q?o9MZf9/+cYjEowpPzOF6be/ZedZYDy+7t5StCeB354N2p6PdZWyUmSu/5n35?=
 =?us-ascii?Q?VAPdE3hVcwsgFoAlu2kr4WUVVzVBjVHEmEHlj3cvVy//5nzph0Ql7DksEBVQ?=
 =?us-ascii?Q?Ad2r0LzZvmrsDXsdvTgG+wpXhoVeHMj6KoLbMLjcGDDrMGS64db1RTkDDC6+?=
 =?us-ascii?Q?uyFAP0KkvhxxSO/JCdeeg5dhybUpSbihOl/feX/UUFTUMvC0GWEr7k77dAix?=
 =?us-ascii?Q?Kazd+oSrS8Kona2sklPOT/uFoH/h0iAh/B83tAsOZvvCREG3iSLMbWUJ3RZL?=
 =?us-ascii?Q?M7b9qbP78F7IL+Ncj7kITExiiZDYwGznufOBdzZeNDmllEa/jJpc9JA74Jxb?=
 =?us-ascii?Q?VepAAcUJ920pr3aCqn9GF1dLz+3QmyOWv9aeGEq1+gezL/wHfeHsZ1qoCUmV?=
 =?us-ascii?Q?qsQ/kthXAMnwhr42tqKl/Qg5yj4ETUXClvJxsigdi5wYlcNfs0iTFiq7A/SW?=
 =?us-ascii?Q?Y89Cgdt+qObg05ALe444d1oAgjivMl9y7V83xC1Lx1aMmJV0VWir1GZZPVDX?=
 =?us-ascii?Q?/YOwzNp2MKHV52frsRuaWO3kx+457Y4vpS8g4pYcWFCjcVrxF/xdwYNF1rgh?=
 =?us-ascii?Q?L7WG4uFNlO6AIyBzXQ+FdWYJo4d7QMx3eRnSGAlLlgt42TgS5CPtyPQusAt3?=
 =?us-ascii?Q?5q7bkhJRhjJ9MrB6E18NEqeQrpOIudp4/qhhDv408f6nnZ+75Uv7ePEYQOzr?=
 =?us-ascii?Q?fqFhWa+KxHAZXccxTP3sWSemIfW085FDw4lr7tGX/s563qjmCmfEk0dLZeDd?=
 =?us-ascii?Q?PZPUDrg2ltFMSrrbQun0uMrOrgroblmBzT0VxxyX7/MzUjlc+9XNYXPXhTcE?=
 =?us-ascii?Q?VMcmSgBszyToXj0Ya2OZxUMIKeN80xm4wmSdjLDErhxfE4tdoqBIJF6cQ9Pi?=
 =?us-ascii?Q?MkrF2PxAplLlrIWBGKbaBqDi/rrEWG8aokRZvrHg72Nz2tfvd0s65TtZkVMj?=
 =?us-ascii?Q?U91o9rLJdwV23WgFewSt7Q/l4gjDv2PUUaObO40Ztupb1EphfKomO0pbnxHj?=
 =?us-ascii?Q?5U5sWwzr9ctu1pBC+rVwkwi++H1jDoaeoW/K8MVkgvwutRMgort6gbU06iS5?=
 =?us-ascii?Q?SaWiV52A3/2ImPMQCuluWapw/QiA6LnpCeVop/7fjoEmXwZ+oHquFNmldn+i?=
 =?us-ascii?Q?kssFAAiN+O4+oiXQras3i4I3Ifkyl9uVLf3c4pw+TEsp6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 04:28:10.4170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca048f5a-aa65-496c-3849-08dc959862cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994

From: Perry Yuan <perry.yuan@amd.com>

There are some other drivers also need to use the
MSR_K7_HWCR_CPB_DIS_BIT for CPB control bit, so it makes sense to move
the definition to a common header file to allow other driver to use it.

No intentional functional impact.

Suggested-by: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Huang Rui <ray.huang@amd.com>
Link: https://lore.kernel.org/r/78b6c75e6cffddce3e950dd543af6ae9f8eeccc3.1718988436.git.perry.yuan@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/msr-index.h | 2 ++
 drivers/cpufreq/acpi-cpufreq.c   | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e022e6eb766c..384739d592af 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -781,6 +781,8 @@
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
+#define MSR_K7_HWCR_CPB_DIS_BIT		25
+#define MSR_K7_HWCR_CPB_DIS		BIT_ULL(MSR_K7_HWCR_CPB_DIS_BIT)
 
 /* K6 MSRs */
 #define MSR_K6_WHCR			0xc0000082
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index bd3f95a7a4fe..094f1f91a9b3 100644
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
2.43.0


