Return-Path: <linux-pm+bounces-18295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BBC9DF1A3
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16501636B3
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE861B3B28;
	Sat, 30 Nov 2024 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uduERjtb"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86CA1AE006;
	Sat, 30 Nov 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980067; cv=fail; b=hvSlpEUGJZpqnfMttYvKdMXNhsXtvzV7OYt97q8UBVDpbSLqZpImOMK/Klw4+ZKFJCat+8j1tdqoCUG1ThozfWjdHmUUnXrMdpgAHW+Wg5HoLdInDit4xU5z2Mg+EfqPi3o1bBNKYCgSIE45T62UASNXPyjZieEYInvArtedM3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980067; c=relaxed/simple;
	bh=SyTSHZsCUn82tUVuRI0O8Q8JYKLMIYs/4RA3IHHMzq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtPZfVQJjCVHOlDniD2AoKAHkwU2wqxYlBK5A6IeW9KAd/tPjGM3cO2lV9XGTT5//Pb7zjSGMwN+pdq2YHDWaO9bXJAFqgx79X6HDeQ56wNBTR5snrAwM5oKOnj0X+QrhL2Lj0NiaSG7HNTwcX7TAvC25AZXEZKhIkSDypMoTkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uduERjtb; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozgUoshgbkTvsisF8hv420LRqVT23WURwFaa//koQ3bQ6by3Gl61t+ovHN0zKlxz2JQaFJOBwD3U82nsbcOuTM5C9F5s/iuDuLEDVmkCpwo9JdLr9tP4YXAcqkudVyI4iRsJnxFvR6+IZTICF45nZy/e1TO6fryD1vVklRaavE5YICS1jur2MX0Sr9LeeYMRMeGbmp/6kY24n371NDEw+ehfwe7WYYeLpqu4HeIw2dsrLmawNjLWFsHHqZ8eHp/jR3Wu2Ipv/uBp5eILV4OEywQcqYXb9REiVotPh++/cpJQoMiU26DLIYV2KjyG4QUhVQ7H4HubTcnLcDkD8QPepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jynr0rR5oKbG7uuIa/0APhD+gIeciu7tVnGInLD4URk=;
 b=wpdrWQvuMGN5Fr56sKH/Cyf7jI1qV9GrOYwlcDMz7ZL6EDeDQqJBed+qsCwwJob4UoO4I+iX6sLZEsO00sBJDyNoGeb7PZKB9lcae0GTwlL+3wrd4InKXkzUfqNMHwJ6l1j8I7PSv9JAWPSqaKi3gJqGPy2Y/B7iYtW5LP9Wh1xUZuIS46IJPowddYzjwkpH0II973CAqrs219isbAKSm/a2DmL7lUrBetyMKgdMzYoByCb0iyPBOwC2r7QZQVaiC25dcG0xXgM4UfJkygZFT2Mpl2QGyB1jVtXnxIkqFlIljgrg3o2Cqp4YePWDeVROE/Fdq9yJTvelZYmWBsMbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jynr0rR5oKbG7uuIa/0APhD+gIeciu7tVnGInLD4URk=;
 b=uduERjtbkCXHnz1YGjJxTW7ruTjFbCfP078j6O7zv7kLmgWD2JoA/QXA5/arapHqZ34ApJTTgVwjgvW9un+IfC5M+VP7HbhOsm1wcFoKorjxFk6FiuvtPSs/039GBZQfp038q7QpkmWgg2oxyHY41ATHkwU3ciNp5Of3MtsT7Ho=
Received: from DM5PR07CA0070.namprd07.prod.outlook.com (2603:10b6:4:ad::35) by
 PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 15:21:02 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::ba) by DM5PR07CA0070.outlook.office365.com
 (2603:10b6:4:ad::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 15:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 15:21:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 09:20:58 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v7 11/12] platform/x86/amd: hfi: Set ITMT priority from ranking data
Date: Sat, 30 Nov 2024 09:20:22 -0600
Message-ID: <20241130152023.684-12-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|PH0PR12MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d9e9f9-93ad-4145-0f63-08dd1152996e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dbGvBZD2cPhVfnyi4uBqhfJ7FCxxfFYhR9e3i1wXFkeY8468nx2lraKv/YoU?=
 =?us-ascii?Q?jQS7NlaRYko435pJLkcxHDSbigCMbuHz6R+Cp8kmumXQrvIMPwmB6VN4UtGs?=
 =?us-ascii?Q?0DdQ8ElLfedrVRQU+KHxUYalgTLNS0cS1ubqVQ/wi8/uZzSkcseGcbshsBAr?=
 =?us-ascii?Q?z7uoDAzPy81Y5OUIEhS4DO05g+mh1PEVldbWBjKiZkPeGRDKLEoMJgkKN5IW?=
 =?us-ascii?Q?VC+lT2hdiQLKNZ8gI2M7/qC8ns7JifszumfaM2ZoieOsxVxlPJHm5vk4sWmm?=
 =?us-ascii?Q?QIDdPocIP4vU5FI9JYHXm0c0lBZ4aYprxjqSrp8RcgLMyQmVNxyfKZaUb5jr?=
 =?us-ascii?Q?aZeUO/1HCdnIRIHu9U5US4C0rcvmj7eQlyyDN1gB3KjNLrfJSpVafZaFMgtC?=
 =?us-ascii?Q?xEOwrgAQoLAhIAzjrBd1o+iF2tvfvQ0wEJe1+nn0KxQlMSFr7mg9b1K2RppA?=
 =?us-ascii?Q?gXvuE42NF1UB9AKjBspgc5ktdTNFwYpRSNV8gmAb+A1alAGh0BVKiiwA9uYQ?=
 =?us-ascii?Q?sWbMj8qwfzbOTWqSOUsV+AWWhB9AUqTXirJXNfDeMhwGOKVRsuWLLMIm52Os?=
 =?us-ascii?Q?d7Mh8nI9QQgzJgSEE8b/bFSQFif/g7CvT11TOc0FvavBd9kk9DpqEn/boqsH?=
 =?us-ascii?Q?kl6ea7Oanqji81GcwfpeJtrOok/GzfHMAF9o8agNkGdJSlHkRl4BME0FTAVY?=
 =?us-ascii?Q?y7oXS6ucnrs2gs55KV1u4dY2FbBypYuma65A84ekMSNDLBLcIrRFu4IuZIBa?=
 =?us-ascii?Q?hB6ZjK2JSBCZQqr94AbQcps3xS8Q7Qj74qjZqcpqdm9UffPx4HW2HClRfhv8?=
 =?us-ascii?Q?XR8Vch4KuXGcA67gIjWIkcDdQ8aKT/uIGwFbPQvcxR+sVtutADaB7TDGv7ur?=
 =?us-ascii?Q?TAoTrBQBkpaJ9QYCEszlUy/Tirl3ogghhMDzsHVLTbyfiN7cbG4seBkcXdOD?=
 =?us-ascii?Q?tek2hkNuGwO6ZKzF5t5FxnywNL9O5EId6w547NfLVmig4RnuCXXg9kkUHLTf?=
 =?us-ascii?Q?2XnrQvG+mpFDctNgMaLf1KomVD1RjRKYf6aSbLrr88+U3b+g1gmEIivPGs9G?=
 =?us-ascii?Q?BT/ve6JQilcqAtTAqK/+0973nUJBEB4pcHLY2zkktBs1NXLGvEgfWkDa2D+w?=
 =?us-ascii?Q?fpqfb8FudxH+eHYK/Z5LpIqgIjtZXsRakApiG2A3ZzBfbg6i6Q4YFbvrS5T9?=
 =?us-ascii?Q?FxECUmoEEMiGfoo0qPGg+FGi8oG48HoZiieLf+yhbGhmiAeYHBEwCdQo4QH3?=
 =?us-ascii?Q?cpFxfQlieruUB3Oox145ae0dGBbGQmbpsT+47PPD2WNuXSDn08OexJL0zPDX?=
 =?us-ascii?Q?eMHURAwmNlnDMRox5ywITTEzbBs/7O52+mKc3Ve8pFIyICCeKaQaewmZBttn?=
 =?us-ascii?Q?Cl5hEl74YsjxtIQwZ45aSQg9PWaClT0LRevA+wRrzz4/HAXgluQG3bH/WhEm?=
 =?us-ascii?Q?yKqT9oUnTqKpTsRs6xVtIhqrK4sozkth?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:21:01.4502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d9e9f9-93ad-4145-0f63-08dd1152996e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7093

The static ranking data that is read at module load should be used
to set up the priorities for the cores relative to the performance
values.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/Kconfig |  1 +
 drivers/platform/x86/amd/hfi/hfi.c   | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
index 532939eb08a6a..045f598f4866c 100644
--- a/drivers/platform/x86/amd/hfi/Kconfig
+++ b/drivers/platform/x86/amd/hfi/Kconfig
@@ -7,6 +7,7 @@ config AMD_HFI
 	bool "AMD Hetero Core Hardware Feedback Driver"
 	depends on ACPI
 	depends on CPU_SUP_AMD
+	depends on SCHED_MC_PRIO
 	help
 	 Select this option to enable the AMD Heterogeneous Core Hardware
 	 Feedback Interface. If selected, hardware provides runtime thread
diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 80ccc50ee0914..0940950dd7adc 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -115,6 +115,12 @@ static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index =
 
 static DEFINE_MUTEX(hfi_cpuinfo_lock);
 
+static void amd_hfi_sched_itmt_work(struct work_struct *work)
+{
+	sched_set_itmt_support();
+}
+static DECLARE_WORK(sched_amd_hfi_itmt_work, amd_hfi_sched_itmt_work);
+
 static int find_cpu_index_by_apicid(unsigned int target_apicid)
 {
 	int cpu_index;
@@ -234,6 +240,8 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
 		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
 			   hfi_cpuinfo->amd_hfi_classes[i].perf);
 
+	sched_set_itmt_core_prio(hfi_cpuinfo->ipcc_scores[0], cpu);
+
 	return 0;
 }
 
@@ -453,6 +461,8 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	schedule_work(&sched_amd_hfi_itmt_work);
+
 	return 0;
 }
 
-- 
2.43.0


