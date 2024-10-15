Return-Path: <linux-pm+bounces-15705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5841E99FA54
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5D11C2017A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91B20C01D;
	Tue, 15 Oct 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AhGA8/wn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EE82076C6;
	Tue, 15 Oct 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028259; cv=fail; b=t1LQpPdaACHd31RQvCfYfTuY9w/UKLbqgH1rjY+kcuMgqPH7g4TB/8yTRBqjK3oMEPAeIuO5aJZ2qFFg6ie84kBUvfMFMM9knusXuxgYoleM64RJ2qYm4QD7PnXlo8891nPi96k9UsxeTaKUUv+kfR3JAn12bKGz2tUrlk1T1fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028259; c=relaxed/simple;
	bh=UdOW4Xv9ck1ciZLr3sl0n8S6T96DVmCSHnMPmzsMg6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TORL+AGuh/egIV1AYfcPnAasCo6BQ9+Uk4gEqQXqAwt3hYtEqlpZ65mC5J4FRlwdqSGuDNurBqLfzTydU3EOHe7GXu1D6tpJUrvQ2hOh0YEqRUf5NtqJVCt/HL0QEPTRAazT5KCAB1in4aWNrOnPPd7s4bCMbRQJ+vmQxVQihcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AhGA8/wn; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qESlj4L/gFFZal0aPzQKqMmASnFcKXz7POuxYo1sn1+mJQSd2zsr+BGuLcQt7PqC7E7EoCbdDR79dhEt32HLUQISAsTQvyQhNxQPQBi477Q3pyKKX5gcyD4KYuRWIbMOaPZr4g9l7Wlme0MSxg7EPUEZmoT0gFcpFAkloIb1jrM/tdBOv36bgTeZIFIgZP/6bxGLW3EOrR8tD7IlGmMH9x522Dd0EQQSKQihhQ7mvwrtFmnd1mcQ6CEMTXA18yMdllpjmUcNjOK41uPe1O0hq1vNJyWaQvfmr0vVPgMU07tQwflUUtn+gsiRM3Hl3wDjkZolO4WgO4A4cbHdhUwiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZfSkrHvi1ViZyJT1KnIxWHHVP4d88vzNaqipoDWFJ8=;
 b=vHCKkEuOoN1wD0Pz0oyJ5XDiDTSVfdes1m8XOFyKAbCKdUeToum2prGJdYlPqPL4D5wkoiSW5o7xZ6ifJiXu3xbhIIBrfqh2rgLEupXA1cxv5HJ5M7iSk1vy0NctVhQglplYqY4q1owpyJBLruNP3Y7wFcxhu9BaTC32rfbooj+EBnakvgsoEQeGazj1KkuKqQItO1iLXACwf0q+RWAI4WAg6olPm+DNBGj2w2E+6twg8xXAmgzrqYzXA0pQwhs2s7GngEmj6zuAzc0Y8C6RxPH9b4YK4RdNz1qvGYIOuo9eN7exla6kDuVnkDDDL6CPrsjXezkoEWngHYGSj3ByFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZfSkrHvi1ViZyJT1KnIxWHHVP4d88vzNaqipoDWFJ8=;
 b=AhGA8/wn/9P+K9ymv1tBjyKWLtgqfo2xcnnQTXLVHtiSreH4JmtyiyztMjQbaHyMUqch92WKBoZbD7LD0h6LqO3b9ZJTUULkx3pKqFf0TjXklyvmxqgzGUOH8SxgJg8nqQYE1og6NRIKMsI7T0Fc3cpkDpOhl2dliuI8UoZmEqs=
Received: from BN9PR03CA0657.namprd03.prod.outlook.com (2603:10b6:408:13b::32)
 by PH7PR12MB6836.namprd12.prod.outlook.com (2603:10b6:510:1b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 21:37:30 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::4a) by BN9PR03CA0657.outlook.office365.com
 (2603:10b6:408:13b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 21:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 21:37:29 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:27 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 07/14] platform/x86: hfi: init per-cpu scores for each class
Date: Tue, 15 Oct 2024 16:36:38 -0500
Message-ID: <20241015213645.1476-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015213645.1476-1-mario.limonciello@amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|PH7PR12MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b058f2b-c499-4f6f-2524-08dced6191c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yVbRAeqZrKZUG2DISDLiCRx/RTU/QGZmBwzxtWW1jmR9WenxcKWg+ELKsSsk?=
 =?us-ascii?Q?WRe8g95pKlSbnCtV0Al8CcNDzclQfgX0FnK5GJ8x8JeRw1JTwvbmofirCKRD?=
 =?us-ascii?Q?qtQCt8TKBbWSGcNnX/hCUZ83uHkj9BvtzLsXpJcSlmuGke8N1IDscug7ZkYZ?=
 =?us-ascii?Q?6s9vcGEBQmuJiZ96PAgseJIt5I1z5H2CAAf0wN11arzOT4urJ1Qv+RUgB861?=
 =?us-ascii?Q?eOX2GEoCAygyiEtsKOUZXx69jgU4bI1s+CDJnG7JJvLRqKoZwyz66pKn1AFg?=
 =?us-ascii?Q?N3J1lnmDUhTMID6wTlgaBLc1IZ+wLsK7uku0Ygsqp3lyywIG831eQrTJB+yI?=
 =?us-ascii?Q?6/k6qWOylmEHrjQaBcnYBkyN2WFAtLPw+C8HydQyQqjGGxfl5pjmJ+Y4pbpd?=
 =?us-ascii?Q?K7IL3KSFe7htJVNZ/Tc6aD3fNIoj8iuJY793fyxv1nf6nQ+TlqGLpeE/NNUy?=
 =?us-ascii?Q?UzYn5CBwPalZmxwNkqdDAxqNI4rYCxtkwkm6zi1BD/QVJMU1Q6EIWtzRhfFJ?=
 =?us-ascii?Q?fm4gEqqewLIFvPETF8bc7UfhZc1tHrqZ+igCCUCeRjgwGWkc/OiKzLHKqxgY?=
 =?us-ascii?Q?t8lI3a8llbp7nybCdCm8vVciLR3//Kvp7VQ46Ey6fthzNHQJRj818XTEiS9S?=
 =?us-ascii?Q?rcpcEC3rdspr354pWU6LgYiZxyla68MdNbtGA+Xwf1gWmEcT2mEhh6ZznBqv?=
 =?us-ascii?Q?T8YPCE+w9xoijmkbf1H+CtukqDN2BWX8UowodfLuDFmR245XqB66ggSbNVKP?=
 =?us-ascii?Q?OFQMrOpaEq6RftUWfy0jTecBlFgp6vb44CWTcUqjp4n0ex5x+R+wlhlICiA9?=
 =?us-ascii?Q?hcqWiAETa1/S3yMuo108B/HhTBcVmXX9CwgH48Ps7sn4VPh5IViX4eStmmX4?=
 =?us-ascii?Q?4mq6rl00QDJmsb3cj0Ra/SHB9V4G8YyTcZdCEucvQRMyrOBTwVpF7qKEDb8a?=
 =?us-ascii?Q?uF9KHqkCDkv+suIOItTrzxstYcFARQr4VZYofOIJbUrSqXsax1umx+HQx+Ph?=
 =?us-ascii?Q?dmWf6w7JHUhVtubUFwzA4x758ZiCal2O4gD91SvXGQXqClbIR4o4R2EMBx4O?=
 =?us-ascii?Q?dOrgR92DpF/eFCjR/M2eTKqf1VnzV4ybiRfnz3mLUEMGXBshGKYWewRkzw1H?=
 =?us-ascii?Q?Xj9qjJXJIzavkmRZobn8U+nW6BYZ8Yb5dbpXdQl57laFIvGyxvgSeaUxYm4o?=
 =?us-ascii?Q?1TEHh4zVSiCzqXDUQYWPKsAuzaPJazrZN2u7/3pbYJbcBUgQHpn78lDGKhul?=
 =?us-ascii?Q?CaMu9BWy79E7hE8P2mLnuYIR4NMeAadtGQ4tsmWYCDmGOzwLpddCd+0FH/QZ?=
 =?us-ascii?Q?AM9b/yDYYfOdAHg79r0LtBqq7H4lv6oca6xqQ5fd3y5X0qcarkX0i/8w6p71?=
 =?us-ascii?Q?nJ6c0Hs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:37:29.2304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b058f2b-c499-4f6f-2524-08dced6191c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6836

From: Perry Yuan <Perry.Yuan@amd.com>

Initialize per cpu score `amd_hfi_ipcc_scores` which store energy score
and performance score data for each class.

`Classic core` and `Dense core` are ranked according to those values as
energy efficiency capability or performance capability.
OS scheduler will pick cores from the ranking list on each class ID for
the thread which provide the class id got from hardware feedback
interface.

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
index d2952233442b..63e66ab60655 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -118,6 +118,8 @@ struct amd_hfi_cpuinfo {
 
 static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
 
+static DEFINE_MUTEX(hfi_cpuinfo_lock);
+
 static int find_cpu_index_by_apicid(unsigned int target_apicid)
 {
 	int cpu_index;
@@ -238,6 +240,31 @@ static void amd_hfi_remove(struct platform_device *pdev)
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
@@ -321,6 +348,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
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


