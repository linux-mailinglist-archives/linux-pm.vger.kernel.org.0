Return-Path: <linux-pm+bounces-18855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2539E9E69
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E679282844
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991201993B7;
	Mon,  9 Dec 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cMbtmK2L"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51D9198A37;
	Mon,  9 Dec 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770402; cv=fail; b=EwTJNkhNqr0dH02GKZ/xVKMXM2Oc4GoM/Nf59kJlvUR94qgTyJ3KpImSQSHzXom48Uua+IeeBykPLwCco8u28c8tLmnhM2H/jsEFvumjSD9o1C9RbnKbdeTX70GX7+QiLO0ZhN6wwHW7+9vOjKxhLjUe1G0FLHUwmr72MxrbVRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770402; c=relaxed/simple;
	bh=1qO6n/C8t9LKZSkIGzDJx2RTReZncXFg7OJdetw0nTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opA1I1JboUZhaoMaxCWOombvADUXjMO8bzi3ueM9EUJaF7OfZeUz4ERBIx3+R4pnmkcXkMAxIKDOYuxjYdc5vfDtxF95yeHfcHh8HeakCElkOihGk5rfQnLZ/X9LSoMibiD+xyeSHY01jUaA0g5xpoaXkeKwvuqVK7qv630kE5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cMbtmK2L; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxwtD3Rbbnf1FVUw/Vth6rQLIzFL6wNHwfUegi6Wa2nnxpah8dLpJFFAKmrNB7g4jTw84SnercdxkD3Ntgq6e4qu7rkZro7fgERSpBj6GUiPCJ7pgiaa8ACbEgNqoOEkxoCqFWa6MOoEi3KzxVKXT/Ew/inkeMFRev6Y+wG3h72177xPlOWScG45fhY1bUOqH167Nuv4pYsLiN7Z/SYD09n8XB3okBIHPxpMZYrTH/uvtJZVZbedgvcMqnF9VqCqd1xDeUZ/LtV+Pymzc0jw3vTfbOCBTRM+T1FOvykUyO8U+wY3wtFI+miqY/BBPjaXyIoys7zyXZ37aYMBu+RNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr+LLu42PNwm+12VgTsevRYY2mCXSkUtQYPNq6cSIVw=;
 b=Fq/qkbYolpBZB+Y2f99ziPYZARLsAM7F/3XTlg0Rlh5IhkgyDB+tmMv5Ku2VffeGLm65KRh6H7MUVAhACHvREMmsCp8fPBfM2H8b8WeMZl3RWE5zdd9owO23qTrm7/sABufqbQOeLXQNrcoJjX/lRWOJlvChZJpgCgnKT/5c4xcr17YCCXJ3it0XoLcJmr2AvZH5dCdrN9L/u6EJzpZievIQt77OgCl1wNZDVIaaG4abS8RTgcdHuiPTz59bUePiusfVMGg3RKvkIg7psQ/eTiwvtsIBCbb4lWxuP3K8unaVXInZyioIvlNsvt7/YF0FSkSOxW2Ikar3qiMX7OusIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr+LLu42PNwm+12VgTsevRYY2mCXSkUtQYPNq6cSIVw=;
 b=cMbtmK2LU59jMwIEiiXYux7/xyRWCuubcgiz4OxgITnpxjffwR0a5HECouZ1pmHXpojH+xOFy7wQWQf8/DCPlf+rpO5ChjJYrheZ4TFC9Gh7JXQCPEyuhmmoKRtD7MR9edGNdzVWoI0YNJNRX/1YQhPU+EfSkQvzm4b5Q4gRTrQ=
Received: from CH5P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::22)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 9 Dec
 2024 18:53:17 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::c7) by CH5P222CA0002.outlook.office365.com
 (2603:10b6:610:1ee::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Mon,
 9 Dec 2024 18:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:53:16 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:53:15 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, "Artem S . Tashkinov"
	<aros@gmx.com>, Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v3 14/15] cpufreq/amd-pstate: Set different default EPP policy for Epyc and Ryzen
Date: Mon, 9 Dec 2024 12:52:47 -0600
Message-ID: <20241209185248.16301-15-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209185248.16301-1-mario.limonciello@amd.com>
References: <20241209185248.16301-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: db0cc331-1415-4167-4b3d-08dd1882bdef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pTJ2nVNIek+AAJwQG75SKVAPYR8XzADQ6+jskPm9exw5LW3npzng0D6W9TDN?=
 =?us-ascii?Q?FNIST2g8JQtjHpNOKSP86Okx4H5zIbbyjEUoMcE1QgQcUdAyTn8qjypfL+GS?=
 =?us-ascii?Q?xY28YB6jzjfZw+ES8S0ZTW3CiOBWtXDdiPAsKNphroScNdQAiHfKdFZFtGeq?=
 =?us-ascii?Q?wwnU/sCL92btxZx3BPmSvJPH3vtCXPqw7GUveLJ7SMsPBb40gnfDA6FBExhX?=
 =?us-ascii?Q?A60QEgS4w0jSh2ym8gZRX9dNj/xCdT+RtIdVtiQvL09/WlKntcIxFrXwCC5y?=
 =?us-ascii?Q?Uy0pKHX0Ozhyl/qumXejfIh86IM2RYMlVH6siwY7m6hpOM7KKGGRLDorkTIN?=
 =?us-ascii?Q?GvarropPVZXS02DsawbNzMMwfv451wxqlY1v8jkIVsQTBPLk9vzfSV5jssIn?=
 =?us-ascii?Q?1duBzy7wHcMpN7LOCo9NPSIXB9qwW2TZrWvCNEVCrXTSRYyM9afnUzT0lSEP?=
 =?us-ascii?Q?8/9CCrTzolwphIPPWmuh/K0H+EJVbv8JD/C2sjof9B7XVnt6/wotY0jq/1SK?=
 =?us-ascii?Q?XTQfSRWC422djIhsvw5TruEObDqlKvFJ3IyHJ5H9Jrd7LN3RJDyanmBxA8q8?=
 =?us-ascii?Q?yC4FS+O+JZNw6IeTR24RpDgM1SZQBbk8BzaZKSeLqyj/v1H73iw8pf3cz01d?=
 =?us-ascii?Q?EnCm/Y4Lfw5yCPIPVMG/rsNRumoXkx/zQIr6ZnUb5aGCTHSxWMAD8FdIaILw?=
 =?us-ascii?Q?NGbmRpckZAqEXCHh0zpzg0Tu1wj3JC/ku6VaLHx1Lgt85fwBjXaoP2P/kTe1?=
 =?us-ascii?Q?g/e1d1fLfqINdqArjP93SjulPSuqpFEFk5RuPVBIFB7Y52tJARz0fKIShkkv?=
 =?us-ascii?Q?1Kwiuak7HgmeCmmRCq8Usjc9Pqg8krNg1nYCvGwRCrr2RudPA0rxRcAkKE9t?=
 =?us-ascii?Q?qfWVEr/7wsk9GG9rWQNMBcimGtSXGKjNC/Hh5JCj8xu6srywUQcmKFV2+soh?=
 =?us-ascii?Q?bRovCdfwRK/TY5Tdz1aEdM4zdfwG76A2tl3wZp3YnD4EOmNpyvTKHu2DnlJ3?=
 =?us-ascii?Q?ZmGKgNOTV+GLNZQsjWDvaTJ1QVwx+oIg8NEeSfa1yyiMJ4PVMBzivEOmzYe1?=
 =?us-ascii?Q?GOUjtAczrV0CFNhVpuPrlKNtuJtkR+MzMVKbNw7YcWfspJ5JeEVPb40k1PtC?=
 =?us-ascii?Q?34wV2F48c5f6xy+bMeoGFIMwm3moy9mLgrqOjom+gDNcE2fLNGpSUhcZ6zow?=
 =?us-ascii?Q?3f7FyrIdOaHdoOi0yGWJ76/u+6OXOvAuQ14CsEBCYf3WWxttFE7R7tcjDCHj?=
 =?us-ascii?Q?jJPHbhZ40vV0Ox5XJKPFwePXPf8WKdcEX6Czad9ztOu/wb9m93xDU2UEoZDW?=
 =?us-ascii?Q?g9tZHZrVIZiDnFOtr196dyCPTZXFNZFT/qxHYJ9s6Cei0u2E9yPDJVRdsH9s?=
 =?us-ascii?Q?IUL+NKnT9jQAlWuVTorToUZaNU2BpH6HLUmQIG7e6mvIQpeXjlEdH1QXLEH+?=
 =?us-ascii?Q?K8DxeQ+a5RGxkAWQO0lx4zE3IH1FxEFI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:16.6932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db0cc331-1415-4167-4b3d-08dd1882bdef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319

For Ryzen systems the EPP policy set by the BIOS is generally configured
to performance as this is the default register value for the CPPC request
MSR.

If a user doesn't use additional software to configure EPP then the system
will default biased towards performance and consume extra battery. Instead
configure the default to "balanced_performance" for this case.

Suggested-by: Artem S. Tashkinov <aros@gmx.com>
Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219526
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ead3a47570139..308d30a25f100 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1501,8 +1501,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	cpudata->epp_cached = cpudata->epp_default = amd_pstate_get_epp(cpudata);
-
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
 
@@ -1513,10 +1511,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	 * the default cpufreq governor is neither powersave nor performance.
 	 */
 	if (amd_pstate_acpi_pm_profile_server() ||
-	    amd_pstate_acpi_pm_profile_undefined())
+	    amd_pstate_acpi_pm_profile_undefined()) {
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
-	else
+		cpudata->epp_default = amd_pstate_get_epp(cpudata);
+	} else {
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
+		cpudata->epp_default = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
+	}
 
 	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
@@ -1529,6 +1530,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
+	ret = amd_pstate_set_epp(cpudata, cpudata->epp_default);
+	if (ret)
+		return ret;
 
 	current_pstate_driver->adjust_perf = NULL;
 
-- 
2.43.0


