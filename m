Return-Path: <linux-pm+bounces-9665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D11691055A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38101F2225F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777181AF6BC;
	Thu, 20 Jun 2024 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nU91jyQB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCD1AD9D1;
	Thu, 20 Jun 2024 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888510; cv=fail; b=rkYCJC3Yk/sMHlMo0hla/GeeD3ZoRNc9Hi015ka03lf/GojfqIOTOuYU7YMc9VVSnmIQon3yrSt0fhzAe7mHPIUurvoWoVraqW8RuTg7UOQhYxz/pqpT1riXidTafkzcmXuqnBfUXMi1TH2yGWQ5xDMW/Xg2BatmYMaM8+SCshI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888510; c=relaxed/simple;
	bh=Gk0eDrWkM4+6BcmWgg9Zn5wMFoL1/BiV+SJ4lOA/JBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQR4rZYIEZErkbikqrAZQssMY4wuH70u0UKUrpsaGt52QUTYwVADj9HlkgUFkTaORivyEtAsfMo3lF115uw7QegSRBn/xwkywBrStiKywcP6FvLbcQqOftDVFrrk2SKixxiL8WUw2G0o53I9C6KnkW9ISAc5tJhGgroZNBM4k7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nU91jyQB; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbhMozW83tmHVyY3+Jve9TcLpd4ltsZ+44ewJcIbuLL03WJx/M24K39XWcwys917nojyXbLcN2WHYKauVnfPEtw4MhPhA5UyzwbpgNNAR9svde4FnG/FuyYEt/2qTTEIPQwLLUA4qsJVmdOd7MgUbTTdZBV+rHLiEbNuc7p8SUO7JMqJtM/9clD2PB5vUva41hWsMK+4VMnwgaXx1rK4qIruet7GnO8myFc5l+7pFxGcExaPUCr+ocE/oLCFs7fFnbd7BVnCV2cNbBm3TfvLpVgSUx0Y0wAf1fGfvRqZfmpM/hDcdP4aMYrRuVvaqkxJG0atHzGECb334pKI/xjW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XxBOYQHTq6+VWT/1eEZw5vU3Ql+de6j2SbkY2U/TVY=;
 b=Erpy1POcfDbJ/icyJml5PRtpC0xxRnTSmGD4wtiEENR8OGW0aWiz6vn+/LwFmj1gD9pKHCKB1x9sM0/znn06jQl2otWiP1muoJNa/iJ1PzQwnwBzDRXyI8nFKyxQqp51eEJ5LWw5Tbp3GNN/wdgieOMABP2KH1IYjn/WMbSVBqDd2uN6NkzNpirvjoCKwVT5Klp6rjPOutCTKr+j+W4HRpOWR1dt9LckP+2glqR2e+mSvcn2ljsDYGsKKJP07woaM4qz6YsKme6rCXGGiYYznHfytkrvL/0vrUk/msdTNTOEmJgEDtjg6an2EP7kl9xe49IkjgRXcDU/tXEnHChnZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XxBOYQHTq6+VWT/1eEZw5vU3Ql+de6j2SbkY2U/TVY=;
 b=nU91jyQBBgyTfyR1oxZZPJyMNZc3bab/bmSoe1z+9TmZ2/JaXBh0VYMms8Yw6cJ+8r+RTvIU4ydI767QtwwZNZJCQn+4u2vOrJY5ORSgPlT2E4xfFX0BEgRdm3q4N/1sFOzZKF+QDDo9oCkYymLlz7yb1oSpe2tCWc5mhXJXBeo=
Received: from BLAPR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:32b::18)
 by IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 13:01:35 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::94) by BLAPR03CA0013.outlook.office365.com
 (2603:10b6:208:32b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 13:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 13:01:31 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 08:01:23 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<rui.zhang@intel.com>, <oleksandr@natalenko.name>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>,
	<sandipan.das@amd.com>, <linux-pm@vger.kernel.org>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v2 3/9] perf/x86/rapl: Make rapl_model struct global
Date: Thu, 20 Jun 2024 12:56:57 +0000
Message-ID: <20240620125703.3297-4-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620125703.3297-1-Dhananjay.Ugwekar@amd.com>
References: <20240620125703.3297-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|IA1PR12MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: 1222e7ef-1a33-48f4-1655-08dc91291b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|7416011|376011|36860700010|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zkWq7cZaPH2vCRHCCPQcQAIMEBHC168pOi0NtfVYJnmQnBe13meaNNrI+4or?=
 =?us-ascii?Q?M+66Lspj9BGPQRBWGMntpPjWq31gTriPwh61/EhBqEMAv0LuG4ft/EHv5u00?=
 =?us-ascii?Q?lR7BwBvoNCc53ttqm35Fu9jRAF7GkcX9wjr9hd1Jgt+6YVOWZC/fdoPDhhp9?=
 =?us-ascii?Q?CkFmPbxx1kH3iQmV3V53+F/Df4zRljZ/5a9su77n42Oh8po2ANh0c3Eyng6W?=
 =?us-ascii?Q?Qm5U+iNJYc3g4sQ278MhyA5APUZ9piq62DxyeFrQyRo1Ahk3oAhiT02Ht4t3?=
 =?us-ascii?Q?eV1TV4DjFIWrjeD5FyhIXSWcT1RLToCyP8qadQqQEajt47SxzZ5pRfmw4cvZ?=
 =?us-ascii?Q?izf7PuZsZoaR6VUqFRzK9lePgLdj8QZDgvSDKRFLVStXEhaIPfbKRQXzWAYf?=
 =?us-ascii?Q?dv8Bc/DJudz89oAq8WdQ2GFTgQW5+P73KPUIFfvtm5w7U7iX0/TMeKo2Szm5?=
 =?us-ascii?Q?C6twffOPosRxCchkZVj7Gs4jDuBGA/3+XgdDPF8Zw9mrPfhokvis4aGgY5wG?=
 =?us-ascii?Q?iYr2f9T1jopRi/WNqus1WZZgKo3SLOzWOMvbjekUaxWxdl3/pdvy+90SYOZx?=
 =?us-ascii?Q?lSWzp/nlCvMHkCkTHPEhD1lqSHM7FLPJvROK9ETY3GR5if4HScEiYHITpJwM?=
 =?us-ascii?Q?AWmJfvJk5VrkBxLUFEd9M9OW/fMpGBL7rKGHZr86voC0wbgcbRkASVS9PGHv?=
 =?us-ascii?Q?sXsRhB/wlOCrTeCWxPxxsPev5jikNSK/gcSpq6Gq2EZW2Q8QzQqjMbJUZHkn?=
 =?us-ascii?Q?ifVnkKv5GzbuTdmr+8Ng1eL3sYVQSUPFalJnYssTQXVCAbvgAMP36zxOMqEW?=
 =?us-ascii?Q?YtHOuRI3Bfs/4stVmO3byZF4K8vecjNTZVi28Xfh4qY1Kr2exQhHbraTDXPD?=
 =?us-ascii?Q?NF2q/WBnMGcwhae/9UfwZcNMDMvYWxSrbnIvAWhBbnr7W41kmt30PcZ80Q0d?=
 =?us-ascii?Q?hgQXCf8YCqXLSwf24tvio1qTu0Szt2V+hs2MwNsFcm9hCNYLeMyVMfxhhlKb?=
 =?us-ascii?Q?Z6cZdhAmn09bHjfQkqcnx2DFBd4dGa6aclYaPaM4XaRKI6cCUWnK+p5MymNE?=
 =?us-ascii?Q?VFsEWnyGEARTS59dOuvBGJjHtC5bdUqfx81FrSQbHApdimQrGBjWcun0usMk?=
 =?us-ascii?Q?VU0Yj6BKBXOAjo3sncuwS+py4cHRpb7XMEBtb5sMWic7Ku+bWRgLB/JYukyT?=
 =?us-ascii?Q?1z0/y5dfBf7W4G433aVQsv4jW3HpSfNkwEF1hvwRk1a43jQ9mU+Ja8CfWd7q?=
 =?us-ascii?Q?+uS4Vufaa2g66FrlkNFM5N2aQHVI+NPUg2LxZ3aNaSY3aHf4IREKXWwU3EUk?=
 =?us-ascii?Q?MEzjAu70Ma4mLi0hcBgGaFsEkf5F4aR7Uy6kJIRO6xEXH3TvXhYwkR3DuE+m?=
 =?us-ascii?Q?AfNHvIiSD6857RX+CgvWiykxDbzj5fAATnDHGnTR+jfP1BeyrHYf449yb2tw?=
 =?us-ascii?Q?9BxgigVCmWU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(7416011)(376011)(36860700010)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:01:31.4350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1222e7ef-1a33-48f4-1655-08dc91291b29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6435

To support AMD's per_core RAPL counter, we will need to check
per_core capability of the current rapl_model multiple times in
rapl_cpu_online/offline, init_rapl_pmus functions, so cache the
matched rapl model in a global variable, to avoid calling
x86_match_cpu() multiple times.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index b4e2073a178e..e5e878146542 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -143,6 +143,7 @@ static cpumask_t rapl_cpu_mask;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
+static struct rapl_model *rapl_model;
 
 static inline unsigned int get_rapl_pmu_idx(int cpu)
 {
@@ -614,18 +615,18 @@ static int rapl_cpu_online(unsigned int cpu)
 	return 0;
 }
 
-static int rapl_check_hw_unit(struct rapl_model *rm)
+static int rapl_check_hw_unit(void)
 {
 	u64 msr_rapl_power_unit_bits;
 	int i;
 
 	/* protect rdmsrl() to handle virtualization */
-	if (rdmsrl_safe(rm->msr_power_unit, &msr_rapl_power_unit_bits))
+	if (rdmsrl_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
 	for (i = 0; i < NR_RAPL_DOMAINS; i++)
 		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
-	switch (rm->unit_quirk) {
+	switch (rapl_model->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
 	 * different than the unit from power unit MSR. See
@@ -839,21 +840,20 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
 static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
-	struct rapl_model *rm;
 	int ret;
 
 	id = x86_match_cpu(rapl_model_match);
 	if (!id)
 		return -ENODEV;
 
-	rm = (struct rapl_model *) id->driver_data;
+	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_msrs = rm->rapl_msrs;
+	rapl_msrs = rapl_model->rapl_msrs;
 
 	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
-					false, (void *) &rm->events);
+					false, (void *) &rapl_model->events);
 
-	ret = rapl_check_hw_unit(rm);
+	ret = rapl_check_hw_unit();
 	if (ret)
 		return ret;
 
-- 
2.34.1


