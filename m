Return-Path: <linux-pm+bounces-21384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C0CA2893B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F973A444F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 11:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0B822B8DF;
	Wed,  5 Feb 2025 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l8BcwIB7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688F522B8C3;
	Wed,  5 Feb 2025 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754889; cv=fail; b=Eb7r/OyvVqYrOMXKYnhXLWNR/7zWxdMHnB2It1bx7H1Nl6tASldOHrrw1Nxi08SZS9DNCMxa6RuvPZ+kFP4A2qZzYU+9AeJi1NIjNR0xxrRVhMdevpfX1E77+uyahIiVeOPEooOF4WK0fbNiW1PL0V48a/z7eFuxqBM24r8GOeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754889; c=relaxed/simple;
	bh=LCA67j4SRTzHf5ebtKdg/ruoq70kStorWw5YNVcd5G4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dt1R2uSXMl7Q2pdefQEN0nUTPxkUUqf4nm47a8WcPKahAUWKBrlPkDowv5S3HGQXEhL3F4qkFXZN69W5FIWXJSiN2669bzMx4yxVouq5maRfFNF0/BviYKYp8e0/i2vEG5eFeOFKQi+5vIJ9CaVmwb8myN4OAJP4ijcqdPREJ0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l8BcwIB7; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEDZXdxuoI0Aos3aUmkEmo1H4GQK/OO/R7lW2VnnWZVWHHPn8FfFr9XuX1uIT2717rnY+4+CNvzqV/kGLQc5wevvE1ypxYD6t2P/Y+KlzCIjQZXFyNSxlISG58TI0x9v/HgVDN+wESwDqJqjDicSwNJOjTCtCbwM2ueFnFnDMQn25reX9MJ4CMWpTa6dDkDQCX2ToJ/YT0WroBYx7i9BxfvU1sef7/eBoBVFm6FDZEsYVK/6d3tUN9QaSRc68CgfzwE6Js2QT/GWeHOHhDSL2sjuWHmlf7IhfLJtPa5BLEl3oV/rbPMN2OKXKIT+vqoDyQtQ0Ef72qx2sTu0XL8syw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Gc14Rk8iBgnPPzY+p+srZJw+PVpuSU5XWgaHuWoytk=;
 b=EMbeWEE2BMz5ImZXEx6bPHkd3knf+/L20lHzNcAuOZBizQ7xWg9JspsGc21F0EKl9LVF6lItj8OMjabGUP7FvZlsePcXFCnaqN8xv3GC6sCtFEPVjQ/CKozLCZCSfNludPtnHmeWuokOj3PpBdu8gMPc46a7nFd0l87DtLvw70vgfiKsd0CUHkLoKotgqk0dfd4l0RNQKekWrXZikuLnu/Rou7GaXPkEnKUZj+nlOlGpKW/SsARs17l7jYk2nMKEOg9SHceOv2zxv2fwMQay2wat3egz78NCnFRSwLGltiSXjLodeIc86rnmdiV2eTcQidZbI99f66PclJtKScAOxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Gc14Rk8iBgnPPzY+p+srZJw+PVpuSU5XWgaHuWoytk=;
 b=l8BcwIB773O6644OP5h7la1yuHzqfwtr735mR8eKf/rDkP36gJaO0DeHw/QhSyh+rY2R1Outnbs2hKGFRilaLOE33OEdSjGFZykWYegkyB0w4YHAqhhTBLP44wBGIxw8pdvI6/oAoP4NMOpkhWC9Yumzx7Sc8v1EJZroz2XNTg8=
Received: from DM5PR07CA0071.namprd07.prod.outlook.com (2603:10b6:4:ad::36) by
 IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Wed, 5 Feb 2025 11:28:05 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::87) by DM5PR07CA0071.outlook.office365.com
 (2603:10b6:4:ad::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Wed,
 5 Feb 2025 11:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:28:05 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:28:02 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 09/12] cpufreq/amd-pstate: Fix cpufreq_policy ref counting
Date: Wed, 5 Feb 2025 11:25:20 +0000
Message-ID: <20250205112523.201101-10-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 52080a01-1e3c-4534-1945-08dd45d828da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DdIz6jryQn4ueSetTiadYKZl41neyIqKwwwVa5Qp0ToqEOKWOUF9PJLjK9Km?=
 =?us-ascii?Q?T8k6X+/V/cZQtmAQH9J0s+xrpWs0LiNbjucjswoF981CheiN1H2gjh4x4Bdv?=
 =?us-ascii?Q?ChU9wr+XW2tvK6SIMy21easyvIckMKhxckD2entCVIPvauIjIFDAfL/NUamy?=
 =?us-ascii?Q?SL9fA0LybNPm6hpmXLGVUvIhyZlymwDk/WkLw9v1kKhkrYncEBPf/dvASd82?=
 =?us-ascii?Q?YNQECiVhiwLebYtLp0W6JeV23Q2/ttDrWImYlEtvLp79m9qclG/dqb2vh/Bk?=
 =?us-ascii?Q?TJ9zOyKMrmd3rQBD843r+EO2n/5MW5146N+p07rWEyIfs5VJQ185e5rDUkNl?=
 =?us-ascii?Q?2bQQnZ5S4yIyWhmblBmXsML1MDR2b1hlINBj1UeeL/2hhd9MIEwpWBT8bSHq?=
 =?us-ascii?Q?L7zT8ltdCHJv+0+jK8iVraPF8kbquHmyGESG0+TXO/z9W7jZ7fT+M/mGva9U?=
 =?us-ascii?Q?qv621VjWt2r6FUZVoS42MsRkAOAL0bHoV2oL3yZ81r/pYO4q4Zo6/TMwAWn6?=
 =?us-ascii?Q?e/Qi3705zLgGgmFLRnpq06drXiwA5Ck8yafJVJsABS5/SrzrdQA+o6wvzPdN?=
 =?us-ascii?Q?8pP9nnVM3MA1Qvxkte5Fuu1vMPxrtjv9nHEbQFTJRjaDy6ASJaYJRQazbEco?=
 =?us-ascii?Q?gX8xVolBcn/Fzhm+fSHyKGFnOijQisvX3+4ApQdDcPp317/+fDYt5A74g2Ns?=
 =?us-ascii?Q?c8t8ePtlUQyx4mRLiPpPBbZv19nKRyn+WjLOS+pC8rM9JAzHRJa4k8f3N+LC?=
 =?us-ascii?Q?Dnl4+AcYKvtqY5aSHQz9XIPSlPWTFqxhMtuX/RmFit5rFRBFyDCHEYqy3lki?=
 =?us-ascii?Q?7GfJatT18qm50QloOS7VrRndEnjblHuccMR5xBz6trP5XgKzY+527xzgfzxE?=
 =?us-ascii?Q?dLiXAa9bCyBFj1BmYp2rtukIC3WkbUKKZZb9r5jkaPvmnGKNu3swT1Rvzs1w?=
 =?us-ascii?Q?7a+z8xTio4jvK4QHIH5IaT5t3hhyVBCpqeQHZQQ+Bxzp6EBUeY5iK9hNV8zl?=
 =?us-ascii?Q?E4lJGlzB6BnCmAx9bsrgwIrI5tOUe7ej2lUpsLoU2xbJRjN/2nbSl1C2PU7G?=
 =?us-ascii?Q?cCyh6BsZSYTYSFAdNrlJUoWK5jlIpPZD3UFVkC4re6AT4lqvF/3J4mHW7gB7?=
 =?us-ascii?Q?JDMShtwQpsUr83fgVeQnJd2c9otYj/kJDbGOCMH3zOTS+HOmhRkORcp+n0YM?=
 =?us-ascii?Q?8x+5NpYRqIiXkFQrMh0ShxHfApYH6tUOdN7x0uRoRqAtDV9tT8EJB0H5ZYSA?=
 =?us-ascii?Q?ewslheeSP6pK6Sp21I3/AvfQCHTr21Qrndv+BhHbMLEvDhoGNlfirVmU3thq?=
 =?us-ascii?Q?SIno22vWM97dwoF+RdqfbRzMBEcPeCbwbu2cCMobX219zi1VJqhVpddFiz+T?=
 =?us-ascii?Q?D6Z9waVN+zSY848brNKw1YU5DsdLnTLZaneJiDVnWfGfjPb9vr/CXCHEzIsu?=
 =?us-ascii?Q?tF48TkPgew5hLzBr6X9Vdrddxb3okOPOr0T94FdwDuSZWpjvZinolOozEtvV?=
 =?us-ascii?Q?hWsW+I05kzQ+U9I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:28:05.6019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52080a01-1e3c-4534-1945-08dd45d828da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905

amd_pstate_update_limits() takes a cpufreq_policy reference but doesn't
decrement the refcount in one of the exit paths, fix that.

Fixes: 45722e777fd9 ("cpufreq: amd-pstate: Optimize amd_pstate_update_limits()")
Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 107ad953ce43..9c939be59042 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -821,20 +821,21 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 
 static void amd_pstate_update_limits(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct cpufreq_policy *policy = NULL;
 	struct amd_cpudata *cpudata;
 	u32 prev_high = 0, cur_high = 0;
 	int ret;
 	bool highest_perf_changed = false;
 
+	if (!amd_pstate_prefcore)
+		return;
+
+	policy = cpufreq_cpu_get(cpu);
 	if (!policy)
 		return;
 
 	cpudata = policy->driver_data;
 
-	if (!amd_pstate_prefcore)
-		return;
-
 	guard(mutex)(&amd_pstate_driver_lock);
 
 	ret = amd_get_highest_perf(cpu, &cur_high);
-- 
2.34.1


