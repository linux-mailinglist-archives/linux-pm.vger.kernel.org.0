Return-Path: <linux-pm+bounces-24982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD65A81C3E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 07:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068081BA33D1
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 05:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD921DED51;
	Wed,  9 Apr 2025 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0IxJauRm"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D5F1DF247;
	Wed,  9 Apr 2025 05:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744176988; cv=fail; b=gLEeATBPITGYuzbWsOQ/1TyfQU53BYTAviorHnvk/wZ6Lr/ipnNlculWJMtQwssHA0BvVnnnUt3K6k6IfO1bHF3LRkuLzmygxCarM3WS2SvE//HOjdQHlrHAnNbKvzP4f7buvp5neg0O39ma/zwwhRwuL8LqT9j5UiFGtj3NEfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744176988; c=relaxed/simple;
	bh=DVBe/TEGUI7mOGHYw6uyfB9gT4CiC7o3ljDY1foNWPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pW3v+qxkHtn4+htJR301hwH/IZzu9b/FVdpW6RvTRD2QofMr9HKNIaMhlTk5cGCdJMNjRePA0xgpb/rpVQj25i+JzLaeuHItAQhcSEkiFgvGE7RlDGileVKYB9he4/uhxu6+1mexx1UOGYnehSkX+CX7cg8zwgjqq+YEzH/sBZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0IxJauRm; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoVtvH1RwK/qHht7NHJ/a7jF55ejkiF+vL9zxnj6ysN8NIZA1pBMiXC8V6W6Y68he+k5WMjksBMihtur+1nQn0WUiyKSUlmw3bUduLPznh+oN80fIp5EzDStYgwAY7xFyysKmYYWT8avNK+iRdY3yfbStsVGG0KExRsAMnPOtKbve7Y1488q34sZ+tUsAj3+o/wRjqzFkhBuAIFs/q3+T0pKAP76gD3Opjikof5I5me+VgvQ2rBxrJvVNHyALAb5GJN3c6t9MTLDY9Ki+QoKYqkeCAmMqkeFkxuAAz6xd6pdbgHBQ6gVTVaUNp8Pg+GSPzWE3ogsgZuw7/L5cMLGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyhI86zUUpoVdaaGUWJureedRCIR+v50GLCqgAHDC9k=;
 b=taRyZ+hF7V83/6V9Oq32klAgXZby2WrhDp4S6SE/AEZGb+c48VfgG3ejpnoKNHXCeC9TisVBWAfvNpdDBwR/rfM01kpELKKt7uwIrNAucf8gcsBusVhhf1k6MparTfe6sBQlfRzeUCFVj3cuFzY7gVnkfsp2zgT2im74D1/vIGr+ZRy+y2dARGIzXDSP23Sf5wj2ZLOe8e8Y/bG0gcoHCzoHBYHgEw6DFbMe5+7iGH8ZTyEfiUuFCFpeTA5c+oNPPtlne5ER5MAxo21dxiYDsOqqxtFEEXLQJw+v8Kg8Y6/BGXEoidr8iG9Qspa6r4CkLTufCUzSrNUcRlBCk+yG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyhI86zUUpoVdaaGUWJureedRCIR+v50GLCqgAHDC9k=;
 b=0IxJauRmmyjTMxqtlEDblv8nyvqsgMIuhZyyglKijgvrY39b/3kCaJ1UjGwlBxL2+pjYse9mJZa0JL+tv5/j/vBz4fM/m8E2LbJ3g7DksBWCmqtPc7jmDw7Ncz2U9aoYmn/8Y2QbDJrWTqRQhBmnuSTBZdAqPlRbbD1aVPSJDY8=
Received: from DM6PR03CA0062.namprd03.prod.outlook.com (2603:10b6:5:100::39)
 by IA0PPFDDA81179A.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Wed, 9 Apr
 2025 05:36:23 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::c5) by DM6PR03CA0062.outlook.office365.com
 (2603:10b6:5:100::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Wed,
 9 Apr 2025 05:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 05:36:22 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 00:36:16 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Waiman Long
	<llong@redhat.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>, Huang Rui <ray.huang@amd.com>, "Perry
 Yuan" <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v2 4/4] sched/debug: Print the local group's asym_prefer_cpu
Date: Wed, 9 Apr 2025 05:34:46 +0000
Message-ID: <20250409053446.23367-5-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409053446.23367-1-kprateek.nayak@amd.com>
References: <20250409053446.23367-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA0PPFDDA81179A:EE_
X-MS-Office365-Filtering-Correlation-Id: bdcdebaa-67c5-4675-7b3e-08dd772876a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VSPpnPRFXhbYqWRmEgkGR1CLp0ZcGU310meUHFU9Pym+xacWfcXV9VmKn1YM?=
 =?us-ascii?Q?kXYmYNxXyVRJBQo27PVXkf3s6X1GYqDowhozQor5LkWQF6g+ylWrFicnxOqQ?=
 =?us-ascii?Q?QpFXPYfPSXVyMDFw2p22Vm5fd0WHZDVSFgM05K9Jlm2i24A+0qWbLwbkHZV7?=
 =?us-ascii?Q?UwGT5OololYCbZO3gmCqjNzTfC1t0UnhCnfUQwcYjpS/Unx8QswTr+LMNtlz?=
 =?us-ascii?Q?BhAcZDnScletzHDest7uwtRM3eDdvzpJ7iyiBJaYy6clJXKN/IjN0p4H8itB?=
 =?us-ascii?Q?zU+ln08/6Z+Uz0GLDDAmzoGUQWMcNEug2NMUfux98e5ExyW0R+aofBuXNZsv?=
 =?us-ascii?Q?v1vrEuOgqLK7aO+J3OiY0q5EoQSOODuZncDgjQTnv0RCkWEaaHkRX0EnDPWA?=
 =?us-ascii?Q?aRTB0GiMRoTjlg2hLHoDneOfAOFG/gpTnf9o2isO9SUae6XgtGwy6GgDNOb8?=
 =?us-ascii?Q?vLRjpXsdLM62e+FTQaOjAzUHMPAOKMRwS3apyHXr6FpvHqBReeOXyprAZTnw?=
 =?us-ascii?Q?Wos2szKGXU6BZre437WcjheheUW9ShFFDFVeZzt7scZNLCQBLiDjHiP1DfbK?=
 =?us-ascii?Q?qgany5pfxiMXKqMc/8ag84SUoCQBKfMMMimsIsTcFIVtIwPKues/JPXGhNmB?=
 =?us-ascii?Q?qpP+YdGQ8ROdE7QGTS0y+Q9NRm/rSNWpTwOmGK6/EdoP6JOIjh8g0tpBnncp?=
 =?us-ascii?Q?i4WpgVojNLmrVe2IRMwIf9PR+v1GbD9JB2rmTPxViNSk7YsvkJ/cOMIFKrrB?=
 =?us-ascii?Q?EtmcfuY+SVOomgwaHqG8eE87ahZ1M1WDwDsl0xFIj/2u34+F2GBWyGbeCKu6?=
 =?us-ascii?Q?d3MDqSiZSb/pC8297VNuzJd3c5jRsR8pqT5iMznHNFgXc4RBYacUmi0r93dA?=
 =?us-ascii?Q?gApdqzOSgBXdTagdSWWazpjwxxBwtYJmqj5PlvTt5mGdth8U8YtkZDYg8kje?=
 =?us-ascii?Q?iL+tQBbxPTv6Om5qSzbh8Rr0PlN/iJBKcIBvUjbN+9V8mqvmDfeebJnJOhS0?=
 =?us-ascii?Q?o/8dbOBCZaCRWcp7Sa/eMIV6MpT68RMGELWkA3NDOUzZ8YfVPBlOWRSPb03G?=
 =?us-ascii?Q?xELvuGOEbNg0+OG3PeaKbxFELuH5DqDhM2BlSGHq6B1qi1a5+4oWiWg7EwE1?=
 =?us-ascii?Q?i+sJ64ITpHzgJjGbFmvwn+dFh0OKYvmJjDglkdBi8+/q49W/WMWNgNlnSJ4c?=
 =?us-ascii?Q?uSciESlUHv+2ciZGxbuQ4ycgtxYI/KnvrmbBVJXBs20j66xE7Bl7htiP7im2?=
 =?us-ascii?Q?jLOl6dqF2d11YT/pWjr8fTQkrfKmevll4aLiTg2uKw0C+UnHFNSwJqqu2Ei7?=
 =?us-ascii?Q?S4K0F6pGcYA+XWOnjHwRy4t4VGNKKV3uW1eA30in7eeC8Jt3fehbFyCTK2S3?=
 =?us-ascii?Q?ePKW3CzxgBCdYyyY+QXJMfXc4VW2cZVS7sHDNd/TPWxA3pI8YE96KhWsUWkP?=
 =?us-ascii?Q?5rkp8sVxbEXb4sVAYgmU1KItSB7nwj0LAWxIcYnX2fkyfuxhVjFJEj7SSsD7?=
 =?us-ascii?Q?Lmy2eV1EPJTys8OvhFSgbbaOuEB5vPbOEqRets2XrbO1tB4u6tO3l+x+Kw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:36:22.8560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcdebaa-67c5-4675-7b3e-08dd772876a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDDA81179A

Add a file to read local group's "asym_prefer_cpu" from debugfs. This
information was useful when debugging issues where "asym_prefer_cpu" was
incorrectly set to a CPU with a lower asym priority.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 56ae54e0ce6a..557246880a7e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -588,6 +588,10 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
 	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
 	debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
 	debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);
+
+	if (sd->flags & SD_ASYM_PACKING)
+		debugfs_create_u32("group_asym_prefer_cpu", 0444, parent,
+				   (u32 *)&sd->groups->asym_prefer_cpu);
 }
 
 void update_sched_domain_debugfs(void)
-- 
2.34.1


