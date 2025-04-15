Return-Path: <linux-pm+bounces-25463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CC3A899E7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 12:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DE3176EE5
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435028BABB;
	Tue, 15 Apr 2025 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pOfmTEhy"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D922328BABD;
	Tue, 15 Apr 2025 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712653; cv=fail; b=WwKNNqj8V1SxEakTfCJiSbnrUNxju6/JjG8TdxqwZn/M/fxqJLGp3x9BrMkMQzAEVA89qLGfdhYrFgck1So6rJOjz4xnxcOHAtdG2APfb3lqY8gx6Vm7yeqruklo3UL2efiahfYkjMODMApgZGc7Dfh7a1dMBYcy5lu5DNTi+uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712653; c=relaxed/simple;
	bh=8oxEX0dRpKzlVUPKgWqUEyEKZd/qDGhoBBOcTQusB/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZeN/sykzNCKKMHT0QcLGNSoPZwbJGhaw7s9L3Ov/gtoRP0/xydVIa3A1D3sqnos4+ZgZjqpEsUPcWSR8fzVqL9CkX5+3NxovFqgIwnXOgFKMDPylXouAqLXHMI+EpOub5z095Ah4KoxaMIfNfXr0B4pdMdw0ySIqLN6KQffVuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pOfmTEhy; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luLNWsRmx2ngoU0h8nYJjd86ikCwejxawh5T4VxjBu11JJwwpFec+izeVdkoEpsdsbIPGV6IKkvEic80I5mzbWVU6JpzZ7s3OJV5TmvmsProvXkWPLeNfjaoP/VVYzNvqsB529xk6eU6hOKT2M6UlcU9CF7pwVNJz85SpUPWI5vNMLFUnz+X6wiNTqkBbECLK0qB5s0CRBoK8NRqJaW/mHBk+NrphudwQUNPb9B9WDEXroVkbcFtkTGAejboxqTvjWx2ylSurEkD2DMa8xv2DQtS6b+cmCgm69F5OO+8IzbQdm3nezbRmIkX7uvoxPXIf8QEUbqjb2KF7287YFR/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8megq4SCOBnLYK1On4eO4x51s5yidYNQ4ztX//4H+XA=;
 b=ZjTNXdFKge+R6Flr0ssTI7B8a9n2YTPGSFfbdeXV+KG3ztWNlB0Dq9uH3xXvYkOHWpkiOr2taR2UgtHKBTKdXOd9l/Stnkpw7TiiZuFMDNWRJZjFtWST0jjLMRmHqEimae11JcYBZYOyUV14NOfQHZCQAdQs4KkCXJIHNA6GhWnabZBr1uqeVbaz2KVNCs1C15DyWWMpNWq0dvkb8xZRViggcwcHFGLt9YAu81e+LzvJpinYGOGX62yKq+EtneYgxNeBdgSUhGVBLnHexpXz9l8xWmfMbmoYuklft7zr/+6IBEP+7oDBbt/5OnsVh95jRGvbBu/RTORCW3QsWXv36A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8megq4SCOBnLYK1On4eO4x51s5yidYNQ4ztX//4H+XA=;
 b=pOfmTEhyC7LSVqSzAWJ9Xe3Ah97akgD18kLhVRqljkJPq0lPpZf899VyxbFAXGsCIGKG9nou0IwKCUBycDis40IOAEO2rITmYST0CUYyabmCQcazzdqtvtPWpxTpGNLur5cddQ2fr5PQJ00gso/h0+yvu4D8GCl5xPH7euE4dQo=
Received: from MN2PR20CA0050.namprd20.prod.outlook.com (2603:10b6:208:235::19)
 by MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 10:24:05 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:235:cafe::76) by MN2PR20CA0050.outlook.office365.com
 (2603:10b6:208:235::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Tue,
 15 Apr 2025 10:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 10:24:04 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 05:24:02 -0500
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 1/2] cpufreq/amd-pstate: Add offline, online and suspend callbacks for amd_pstate_driver
Date: Tue, 15 Apr 2025 10:21:19 +0000
Message-ID: <20250415102118.694999-2-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415102118.694999-1-dhananjay.ugwekar@amd.com>
References: <20250415102118.694999-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|MW4PR12MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: dd64491c-e563-47f3-c4a2-08dd7c07a620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y/NOWa6T1bJE73nNBQF3qQ0DahBUgE8+c/9xiXO6kFdox6KHBWu326cc0fsT?=
 =?us-ascii?Q?nqSsBG57VujeMcoFXznFioQhht/vJD8MiIghYwOC3ygQWDQ2F4+j1kh+AYkg?=
 =?us-ascii?Q?Mevv2zS3Dw1iFJaoF4/UpBdO8fJJDzQBmGnx23r+1VNx0iWxpMHUmNi3904K?=
 =?us-ascii?Q?4wXXCj/yi81CKHtlaDgY9qXAxO2BDn3+rYWuZj4vWs9FZu93poYmQYBH1aO8?=
 =?us-ascii?Q?KIjOvPfddmdyoMB7V8+4uVcRwFzA2sgBWQLqp2BRlgcibUZIzrDb9e7N2nAu?=
 =?us-ascii?Q?G/UU3fECgSi0wzzXjN/0pw7jkwqQsizpbywmDfYbZ+6g1qa3P6AlkISFR4YK?=
 =?us-ascii?Q?x5N51XAerSmo7hhHWnrg7NTVjimUc8dGUIYwLthdO4ugA7BSYcFAVh88f2Jk?=
 =?us-ascii?Q?iHKFomqnWSItvjF3UziHelPJbjgVayFFlBVBEJ14xhZGnnI+lVKZe6mYRTXV?=
 =?us-ascii?Q?mhlhM5RTy6N4Btga85mzPOdjNRhFG138Z3uGU0jqlJK2BQy3rR1fQW2Z70iH?=
 =?us-ascii?Q?/gTe6oFAiOVZilBbpTEChqnVPlVAwQ6dpvO+Mj6f0CSzOowclum0ZmGyCzEr?=
 =?us-ascii?Q?jrb20kqPsr2U1dPXzlnEFlea8uC+O5bzUslt1PhCyuHr1b2ZPD7dBX/cC0xg?=
 =?us-ascii?Q?viPlONjkkemYbrIRMqhbnRIYpEisLxgQZSwuuldtAc6keeCiWBmkoXbWK3FV?=
 =?us-ascii?Q?D1m+x3l6v7X6YwFOtA+A/vDt5vlgHHncEG5YHxbKOEP+em+efLgeFdQ6teMa?=
 =?us-ascii?Q?3Y63a/6c8YmYW4UIm9QXUojuo8c9STVY17gRTdXKiHSRQUVdlpvHgAYFXFNK?=
 =?us-ascii?Q?KCugtgkMr7ZSVRvqbMR+0E18prMOPzewj8mjUL7kbE0+laDtPsGfwTVUmy/9?=
 =?us-ascii?Q?ecwiv457n59vYsrp7DT/8HEAp1a1cTk+P/ig5m0yT4edeHNo0MSZIG2WcK34?=
 =?us-ascii?Q?CzJc0lj5KfTe5w1oGIYVveUMXmvFMZN/ILMwGzaKuYBufetJPc5CRzTk/Wuo?=
 =?us-ascii?Q?oJDRZn/r0l3AKfE3FIVIZi71qBWQEnMkgGYvyuzQodu8nPoD0Al6uclhr0R+?=
 =?us-ascii?Q?yGeoZUtKczCo9maDHji6lZkxENLu5ztcnhh7PXhranmAwqQNztXIutADNIBU?=
 =?us-ascii?Q?rvKIanbUH/v268sixF2KWkt3nr6M2YfVYirWiht+9BUq10Y57unOH5CUOWWy?=
 =?us-ascii?Q?dPYP4JNr8ldJe+9jMh4QTD+3dgWPsGnkFw6f+H7bWMmIkfOi/kD8DpXwE6wj?=
 =?us-ascii?Q?mHxfXlq0NmZNoPVwT8o65jDgB/JVrGtIvu4wX5NvIDPipZGeMgcLWbXv6x19?=
 =?us-ascii?Q?fPDCq0s6hjPySXTDYs262xHcUqH3VYJXgYcPUjDM11EUOvRLDzZa+vt2vGLP?=
 =?us-ascii?Q?p4PhOxI6JxVMle3SrxN2uZxKlvRDGoTq+xwy61T01TXoQ4N56CvD/NEPzeU/?=
 =?us-ascii?Q?VcmaEjpbewMEUpQmKnvIe+PicXhNf8uACaPyDvKNlXTsCxtvTe96VkEAHp+Z?=
 =?us-ascii?Q?UgPGooAKA8SjcmaV8mTcjvCyBPihNMgQYMEz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 10:24:04.9830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd64491c-e563-47f3-c4a2-08dd7c07a620
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849

Rename and use the existing amd_pstate_epp callbacks for amd_pstate driver
as well. Remove the debug print in online callback while at it.

These callbacks will be needed to support the "Requested CPU Min Frequency"
BIOS option.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c29840ba3b30..02de51001eba 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1568,19 +1568,17 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
+static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
 {
-	pr_debug("AMD CPU Core %d going online\n", policy->cpu);
-
 	return amd_pstate_cppc_enable(policy);
 }
 
-static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
+static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
 {
 	return 0;
 }
 
-static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
+static int amd_pstate_suspend(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 
@@ -1618,6 +1616,9 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
+	.online		= amd_pstate_cpu_online,
+	.offline	= amd_pstate_cpu_offline,
+	.suspend	= amd_pstate_suspend,
 	.set_boost	= amd_pstate_set_boost,
 	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
@@ -1630,9 +1631,9 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.setpolicy	= amd_pstate_epp_set_policy,
 	.init		= amd_pstate_epp_cpu_init,
 	.exit		= amd_pstate_epp_cpu_exit,
-	.offline	= amd_pstate_epp_cpu_offline,
-	.online		= amd_pstate_epp_cpu_online,
-	.suspend	= amd_pstate_epp_suspend,
+	.offline	= amd_pstate_cpu_offline,
+	.online		= amd_pstate_cpu_online,
+	.suspend	= amd_pstate_suspend,
 	.resume		= amd_pstate_epp_resume,
 	.update_limits	= amd_pstate_update_limits,
 	.set_boost	= amd_pstate_set_boost,
-- 
2.34.1


