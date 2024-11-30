Return-Path: <linux-pm+bounces-18289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9399DF18A
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568A31639E6
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62A51A9B2A;
	Sat, 30 Nov 2024 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jk233gbn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303381A42D8;
	Sat, 30 Nov 2024 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980058; cv=fail; b=m3coCuoPPfxRQdylTu7NQjnaSPFBgLZEWL5i30K7KRkG3R9OfAG177TqBbZFYPPGRMCbxIQwsbESM73jEB4kQRiqRhQOS+a4c4Zpra2frrlvrc2h6YybpmFniMXsqF17jHitbdTIwCsnLJOqu0445P8su4hLwCpSansUASBlFCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980058; c=relaxed/simple;
	bh=PLIN9Di4iSKUgShzNiv/me6wtqLVjfircb034nTlU6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuuDqFB3K1nV4s+dncFdZwD/Zj2YbqsnXeVJe1iCU/OjUKnRxZNC6+oJIkdb0LuNSqAEGH6KYxDskjWKlqW8IPwruJc2DmvHfAUKqBvIwsOqPw4rtA9iFIBcukHxbOvsmRrBcznbCkVL/Gm83oXe05WPc27NmjV0HvR7XwMvYzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jk233gbn; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blYf1U6HY0n0n3XG12FjQ1txzaYPvf2CyjGfxdXyCKMG9VSJaGcdyZ9Hyv5BbCV5YsJl3BveqE2iP2O37wD4xBreWLnUWXW2YoMSjRjGHAN520tS3gMYplWX/jhTxemcPKIuVf1zOvnIw0EpczAXl1C7sghUcNlj9NTwAF0rUqdkRN9vnFhXvot1nKoDUEWG6tBm4FgIdtJSgcMXxgQZZ3/Iu2/1sq+VSys30GGMqdfW4l/rfSQiOSv14vpCdkwfeR4szwCgQBCIv5avcTm2JIEpG5SunLtuqBpIjUG+bjo+vYuGSx05W9d3hlfPhHpiltJ9UhUJWmw49tW9rpYYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy9dv4xCxmrEZGkcGwXZO4M6YugEJjOtZzXUC8M5aL0=;
 b=bRqSVOBp2lHG9UZIgvZqwGdF1nOet8/m+NMJvlMtWczzHZudCZ8BybmLdMUtEeAFx/O4tRjVUynzEoijvb6nT5/jfpZX8B+pLdTIIH8l7STtUnvp0v/D2lscMDxJxn515ZG5oxRcySJc/EDXNlIGB+s3YdJMm4e+K90QatA+vbj5p8aYfiWbHBxceURmk7LZycYy1jcpBMYNwZFB83orDRbZIMmhAmC9sZ7CsbNGkA23i9Lny9EJOjgJKK/E7Z9Twzb6wYWsvBZxBU0maeMnOe3aRSWHSlBpIg2p93ECtoPK58PTPZ6t40eeG01v244r9CRVTx8r9bFc7fJkBFCxug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy9dv4xCxmrEZGkcGwXZO4M6YugEJjOtZzXUC8M5aL0=;
 b=jk233gbnqNsrLX38fzIe0xOSvHUXy2TfNh0sgz1BNkSVigVRu9864JS7Ds1r/DJcsTHQdvNQIfequagR3beA08xwy3tw/x1Zc0NDjOOW8+1cOLKutqBLje8HX2n3ZCq0mOg7L19UFssIGnUTK34RyTxPAVprzkOHvbCJ1jHQagA=
Received: from CH0PR03CA0320.namprd03.prod.outlook.com (2603:10b6:610:118::25)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 15:20:54 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::6c) by CH0PR03CA0320.outlook.office365.com
 (2603:10b6:610:118::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Sat,
 30 Nov 2024 15:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 15:20:53 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 09:20:51 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v7 06/12] platform/x86: hfi: init per-cpu scores for each class
Date: Sat, 30 Nov 2024 09:20:17 -0600
Message-ID: <20241130152023.684-7-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 85b387bf-d457-48bc-bde2-08dd115294bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N/pAdPza/hb9udo+wC7bNCJ/WxqIuEEG70sWcyITiIgeijen1DIeuWwbCFuJ?=
 =?us-ascii?Q?gUt5cEedhzQvuOsmmIrZKTQCsqd4qUUf3fUs8QoIwcLWrBZRhKHoWgaPz+PN?=
 =?us-ascii?Q?nV/NR5RihjCSuyQ462B1wHVlbEDiBZQdQHWaDIevtugEM9qOmJ1ZFubEmith?=
 =?us-ascii?Q?D5PdOJ/xmJG1OjYPPSjM3QvG7kMfACQgLOSoous/I326yHSXNU0Kd17ZfL7J?=
 =?us-ascii?Q?OHqcRovjaoELCmKcWVjMleTlLRBsske+x8rBdOSnlfE3EI0Sx+Zpo6zHMPK0?=
 =?us-ascii?Q?XvAUvULRZB1OLM8eROneIaOPrOE5lP2izdNmTp7TEzLAvmvXyYg3a0W3kRjC?=
 =?us-ascii?Q?5rmYiD6nQNxiOyhnNtIcVAf7F3NuWqx/e9ZWuR6qVdagGxEA8JHegdHJNjvf?=
 =?us-ascii?Q?a+kurCoAjc/lqPIH52o13CT3aokIbrt1Nf2IPpAY2DOX/wSEMsvlDvSvIBYb?=
 =?us-ascii?Q?6wWFejoLlO1HiuH+fY8ueZPXO7ZWmPcfcJKIc7E3LOLuNJ2rV1nmMy8wrNxl?=
 =?us-ascii?Q?vg9I0/k71gcqagOFymvW0b9Kt86qAuA/PGFQAe8itZcPT/cFNnX+HIVrXvHJ?=
 =?us-ascii?Q?QCAqDXi3YQiViJZqdoNeJYOQf3BVKIQlx69HT4jU9wYoPuPjijlTeB2+/LoR?=
 =?us-ascii?Q?qfyCyW024a53WFbrX9riU/nNPiY/1mz9NS4pf3Bu3wkOFpsWdVGSPYl/CKJj?=
 =?us-ascii?Q?VKOHaDOEPQUg1fOUdeRLbfSlWBAZpu36nW8wcUFoInKNhvGBl/PT8PXqxc2c?=
 =?us-ascii?Q?/gg1mytqpYk1LY3Zl6JwwmIOrRJ+MG7+9drkxscFLZskZIFHEp3skAaYvzLk?=
 =?us-ascii?Q?8oaQQ7+WtdjA3M5bzcsksd2jJfNTU8e6ILm1GgdiTFuUUy2UIzUhF6m9Mu/a?=
 =?us-ascii?Q?USoVxiYlSrrwCK7ADkJ5HnmEr3kMcrUykCcvbamFnO6GV/EO28dD3WSD7bY1?=
 =?us-ascii?Q?T3XUGtNOnEwBnuMJBycnhimpgNfY+JOhSw3wad+aB41+eyCJILS8ojOO2F81?=
 =?us-ascii?Q?FZCJezC/Xelm6X2jRJJ03ojL/ZYSRauhoMnUYu5bVmT0HEQgCDSbkk6/mOGT?=
 =?us-ascii?Q?wW5piYRDUV6xwOUhkyxjVFmCesvmLyQ9NmxvzolqPpn59/emfuBVeYwDO3Ig?=
 =?us-ascii?Q?EZTfNrrkzeyrP/GJjdyYSLa1mXoBpDcxF29TgbJNBoX1HvKIs1DdcN5rCbnx?=
 =?us-ascii?Q?/jRZ1Xycp9apuHmIxHeaQCxNZYnQ96E1NhC06LcNIpSfYhNlW7q4ERr6zmkB?=
 =?us-ascii?Q?Agx6RyJUfYPfwUK5y9Yvb9025xp/rgPC7RJ7zENUJbX8oIH741HusG6olu/7?=
 =?us-ascii?Q?668zefRBclT2vpEh3mT+w58BsmQQAGR63ADT2uLRZ55WMHpVRzhmMBBbGk6F?=
 =?us-ascii?Q?IS2xPy7/WCzx5ForHl8jrjrMd4JGjnBBiUPkVTkBo9VZS4As+OpYCf8xzENQ?=
 =?us-ascii?Q?ZWZ6mrNcrKGcEtb1KhARBF78ppX4IeD6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:20:53.5994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b387bf-d457-48bc-bde2-08dd115294bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846

From: Perry Yuan <Perry.Yuan@amd.com>

Initialize per cpu score `amd_hfi_ipcc_scores` which store energy score
and performance score data for each class.

`Classic core` and `Dense core` are ranked according to those values as
energy efficiency capability or performance capability.
OS scheduler will pick cores from the ranking list on each class ID for
the thread which provide the class id got from hardware feedback
interface.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Drop mutex, move to proper patch
---
 drivers/platform/x86/amd/hfi/hfi.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 3c90e93fd192c..9671f07c76390 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -226,6 +226,31 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 	return 0;
 }
 
+static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
+{
+	for (int i = 0; i < hfi_cpuinfo->nr_class; i++)
+		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
+			   hfi_cpuinfo->amd_hfi_classes[i].perf);
+
+	return 0;
+}
+
+static int update_hfi_ipcc_scores(void)
+{
+	int cpu;
+	int ret;
+
+	for_each_present_cpu(cpu) {
+		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
+
+		ret = amd_set_hfi_ipcc_score(hfi_cpuinfo, cpu);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int amd_hfi_metadata_parser(struct platform_device *pdev,
 				   struct amd_hfi_data *amd_hfi_data)
 {
@@ -311,6 +336,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = update_hfi_ipcc_scores();
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.43.0


