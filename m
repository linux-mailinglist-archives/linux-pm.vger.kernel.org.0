Return-Path: <linux-pm+bounces-16129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14559A71C9
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618091F212E7
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26011FB3E1;
	Mon, 21 Oct 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T87Ti4aR"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60661FA241;
	Mon, 21 Oct 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533809; cv=fail; b=kyqbIL5kDePi9FTMraRfYEUV1R/KZuqjX+EqgHK5wuV05mm1BvIFsFX5ui5afGNvcc4vc2hGlTmKpQl5MsfhtEIvd1a8ijoC/gxAGS7fKki5yJV9YDsXVYytzBIeCrvU7Ivg8pTwF6ORxxlUT0Yre0UaIOVHGvRIMn+YaJPVQls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533809; c=relaxed/simple;
	bh=P3m2c9JuF5V/pEKH9uso8u99z3oEsXSpVghxZGJV1bw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ue+ClsZrMuomWPS6VdrBF3woIyUPb5vRGKx75A1II6Viq6F5nsZ8G4RdpUStjeRzzSvleLTYPL5vbYW1VCst4CDk+VyZgyBTPVd06c1s6XEnWH/Tfk9kHMgkc8DNB65uL+8nyHnkLBjJdlPbjq6XWSP082epRZXiaW6Z3KaWbnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T87Ti4aR; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDv5dywS7owixUenKxMdidQ6AezlrKP8lFyA6nwHdq3KQGqkz/AF/dMX+r9o5ZNsP23KHDLFA62AZbXAqefRYLkfIn0CakOXJqvEFyjtl13a3+TfCr8jrcoHpXrXMG1qoBA31SmswOMKuhbhOH2PH5UnJ+/pT8siLHBHvC7gtifArxRoQMyKCJk8QVRbpSpSNd96hd0XMsehkw47yA5bAaIfQiWQT+YCCdglI+zktdmSWnVrmS5TzM4hs6f1zHAwEuWsktbF7rxVyRWO0/bwBaS5YgqtLb71t1isthPo/fXhBpwuVTb+BT0Vf3Dpa2bToeJzl1+rLrudqVlzm7jFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2X8xL95i8IpbtZbeSCxd8/9tjs59kBnkt4S8UPZ0sZI=;
 b=JZY0xPBKkBxVqpCrT+K0PeQQQit8MDA/oJVQWgvPW56UHM5X0w2bpYeIhqJkPmn99vDwWEPpDF5K0hOHs0l6ZxI8r+qOwsNysiJjfxrJlNGWrHaR+kxXLstH3eDLKU3R+L/J8tmK/+u/4xZS92MZZUM81QBEJnQsWk8McAIdhrev0NY8QUppLU/jl7g8kit+fRG5xK3DKI9DHMjh2ZOVX2dCFiJ7SmxXxmi59m0THSrLHa2J2oAXX3hTKCWt8d6b05e+/r6URGWCudWKRBv9Nun3ZrABG5Fj8yAmAUkKjmAa10tKO5iRcEUOxooOYiO2XykBatoooA9VYcEZlLvO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2X8xL95i8IpbtZbeSCxd8/9tjs59kBnkt4S8UPZ0sZI=;
 b=T87Ti4aRH2R5e+1NJLo0uCObPnFLgtQpZ5AV/3yTa5Lp/AtlRKhcc5yOzn6PE4ksV4NDX6/7FJMA4xbK6cClOrUyWlPhDuy9hPt58mvbLOWCPJdGE3+aXlYb9rU7c+xi66nwbjr4oj2GftSAbjkp8WCF0xdktDlWu2qeiWGp8u0=
Received: from BY3PR05CA0049.namprd05.prod.outlook.com (2603:10b6:a03:39b::24)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:03:22 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::13) by BY3PR05CA0049.outlook.office365.com
 (2603:10b6:a03:39b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 18:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:03:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 13:03:19 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 07/13] platform/x86: hfi: init per-cpu scores for each class
Date: Mon, 21 Oct 2024 13:02:46 -0500
Message-ID: <20241021180252.3531-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021180252.3531-1-mario.limonciello@amd.com>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd8c602-1e20-4c41-4323-08dcf1faa6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w9CCgdleIcBBzLUg+TYr7AvJCWWYO2D+P4PAyLvZd8D5Qv/c84xRagfugkmN?=
 =?us-ascii?Q?XyYHb9j9pvJEi90+PnGtDrMj4ZEbig7HenCToI4lMglqpTIvolXZdIzC2dkL?=
 =?us-ascii?Q?Hi19u4ixGAWRQLrmX/XWIWYaistmIPzWnqYg9upbXGiG641K34eKnjtq4xTC?=
 =?us-ascii?Q?lOzD39fam9bTfHxL6aie9m5kgJpUXx+Ca9jRGL2NBHDPxL/970AHooQZfRql?=
 =?us-ascii?Q?iHSU6IUCKMk6vC7URpj4VbPDph6ZcG23PebF+AWocHpoEOIKFIJ/s9stwDWm?=
 =?us-ascii?Q?U6nchI4+ONUlFWWbM+QuzV+ghX+QNJEmgeGxx1VUprrVYwE2c07p5K5oWmNo?=
 =?us-ascii?Q?fJjPw/hP7ebjvxR4VSO8Foy0uFT1nkR9u1nrZdyB+AtrH0CxDuaPKSZhuHA9?=
 =?us-ascii?Q?rJfVm2SBETzT+CnreV885es2WahaX61uHeH0qxDGofXymn6XSIzF9Dh49fKc?=
 =?us-ascii?Q?ovRRzdRZwsFmsa0Pj4pOfZyxkQ6RSELdYyV1b2GgKQrtGRp0IdoivQ0ws2T+?=
 =?us-ascii?Q?OfKRN8gjtFlQ7v3NapXV4rBn4sqq3IwkFQhEAq1PTIqYfd7iAjbZJ0t5lTbi?=
 =?us-ascii?Q?Dk2KcYVjbn+d6c7UpMn3IvMJKDXSgmazSKvb4kbTPmBEEYoL2Te4zhqyySUv?=
 =?us-ascii?Q?f9sUzISuHEuGo7TA9As8+pJFmp2QP8phvuz3JvvAPNVq6rsvOzA5luXJoIov?=
 =?us-ascii?Q?D1eY752Lec/0x5CxxKMU+xd2jqpbtuRXDH4Jb2bD5YoDDcli5HFhQlb+0itN?=
 =?us-ascii?Q?8YZ0vVKstUU6+xgZmEN7Kpfzgy8q1ij2atF1SOgD0TOyBrdb1h+ksny0lJn7?=
 =?us-ascii?Q?6+KLrBFU11fmuE4Pc1oO/0nOzSGD+vfLcGWKPFKhx+daQmYCTMzDAuZGDNPQ?=
 =?us-ascii?Q?J/JreN3Ah+3wQJhM9CYaNjWR/v6d2mFDVzwexnYvF14vEtCiWlzKOQvPTQSk?=
 =?us-ascii?Q?WbayWwBKLfZyWPUYhD7J/MVmvWL/LCBgj6QPbdgxLrVX1bge4ybjIoWv1b1B?=
 =?us-ascii?Q?C+UoIaEaxYfFouBmnLXo0xEX/CsV9R7AMUxLynrYzV2Ufah/gWH2QOzKdIq6?=
 =?us-ascii?Q?RJ7BY7LTCq0eBriGYDLvVc3ZQRGFb9duzl01LRqDh9GF2ifh8JKx0d4GxSJQ?=
 =?us-ascii?Q?4NfFlZH4SQzhDMYkmPTjX8yWNzm2O3LUZSieRLrqr5FKLsKL2ypEjxhD/KUD?=
 =?us-ascii?Q?8V7DIE/QDOm4E3/cbqnwVSDFiJ0+n820H2vCKXy5ACucZ+leJoTSx5MldSLl?=
 =?us-ascii?Q?/VDRzvY6HMgGzXMKTzajm9MDLKPuL/luHXgltLF6qH2D7Caqmxfzpuo0XXqp?=
 =?us-ascii?Q?qo6kbWkNHB6AsZW4yvYdUTxTOqTbfgAIUfMlbCmXfBkZXr8snPzeLYadWD2p?=
 =?us-ascii?Q?vdEiyolKzoawyrGRhf66If1X50sKFzU+/sHnFxlkk8xynfMCtQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:03:22.1014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd8c602-1e20-4c41-4323-08dcf1faa6ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873

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
v2->v3:
 * Drop jump label (Ilpo)
---
 drivers/platform/x86/amd/hfi/hfi.c | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index b5cfe20c11052..986ea056fa022 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -114,6 +114,8 @@ struct amd_hfi_cpuinfo {
 
 static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
 
+static DEFINE_MUTEX(hfi_cpuinfo_lock);
+
 static int find_cpu_index_by_apicid(unsigned int target_apicid)
 {
 	int cpu_index;
@@ -234,6 +236,31 @@ static void amd_hfi_remove(struct platform_device *pdev)
 	mutex_destroy(&dev->lock);
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
@@ -317,6 +344,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
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


