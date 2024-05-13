Return-Path: <linux-pm+bounces-7747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F658C3A00
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 04:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D7B1F2106A
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 02:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F112FB2D;
	Mon, 13 May 2024 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="41vKpEeG"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B20185C4E;
	Mon, 13 May 2024 02:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715566072; cv=fail; b=BudtrBWBYXsKixR3GO3tOO7lJ9xn7yaFah1pZ8DCUmXndk3ZBdOT23C+KNal+qCGlutrlVlVrVQosIEt1axpJDe/Ia8ZlVCYFkQFj46Vb30sXjJTVP6YhZnu8Bqre+4pvLCaLeMHINXHclClDqRdA0XhKut6c5HdkH9PT7vESdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715566072; c=relaxed/simple;
	bh=H+xYJwbz8YnQezNx+x8BVIf290b6zBXVKMgpfUNP3Is=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kv4as5/C62UBVqldbsysQYhN+g9OopK3P/oGqrez6ESaiHigevNXRsfjkyYXeIpwXlOhYdxsRmTakqphaxPL+pqzpb8Q5ErUdYpNayXQhfXIVoMuEvkEe0pvxIrc5wjHbj4iw4F0o8PUs66LkJBMWm+vnliThoS5di2mWcTtXGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=41vKpEeG; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vq4SK29UZ985Ne5RfG8jodBDrs7zHjMVzrn9l9qwVCrasuuaqNt6BXtjbPrd9AU8axQhAioWDNlPZbBuBmD4YAwHWO8eY+jfVwk5AVZsqtR12wgm132nG1V131f/VRSsHBusP6dozdzAxBlsQcvE5MgKaTKQ8t3sP6GxA1dwBvORLFqk6Zq1wjxcNqav6L5nOobFT5Jp61JPKxKSv4QwFld4oEXhRVzcCDUSS6pYdSx/CKrHcOFjepAJnnkljqdTQvCr2qbZ3vku1qVS9l9IUCFmJTtXq+Oa4VH7ad7XbzlOat9hmX8x29Cq11zQrh0sA92DLNguHzoT3k8YDoRaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8bkUq9XQ8EktmkaHrkozON4ce4H5PdEQXIPdMJ5sG0=;
 b=G8ZrYhPYB/Br0DLjR9kIlJ9+OvxiREjFgR+CkaJEk3ergmftF1ITRaTRkb5y8W62yONzPta4ugUHsugOyQ4ptiOXOSU0EYNCagQZtVq+Z3LrEv3kwxt61XW4YNz4aNI6498LDayjd9Lx6Xi6iN4Ene7aOp5MmAgfo87NjpAFPteUlKgdt3UPFNn53pOHcwZpLUgIZ18PAsQK0UMR8rY0p04+4i3yz1q/YaExoDqM6QgDaGN1OaXTlP/qgVgI/WJEyk2geqsK0spiQAwdk3bx5pWKVfWYbeiHkTRpUzfifEXKCIwDdo0G7gvnvqjaNlhXI5tTTKX60P2uZ1pFL2xjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8bkUq9XQ8EktmkaHrkozON4ce4H5PdEQXIPdMJ5sG0=;
 b=41vKpEeGlzDtM2XfJE/P5hYTQzjzreJmdxyz0wv4tXrRhd+RgLU5+MzVTKod1xnGLdJsIOuddYsEaqfzOEq95GYY2JiIJRVl325nwCT1SQuqB7EzqUmigLDfUiI9c9w9wJEj9LTSk5wN1i9O8ohnMeeUNlBLEyMVt+m0//mGZwg=
Received: from SJ0PR13CA0206.namprd13.prod.outlook.com (2603:10b6:a03:2c3::31)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:07:47 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::a0) by SJ0PR13CA0206.outlook.office365.com
 (2603:10b6:a03:2c3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22 via Frontend
 Transport; Mon, 13 May 2024 02:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 02:07:46 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 12 May 2024 21:07:43 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/10] cpufreq: amd-pstate: optimize the initial frequency values verification
Date: Mon, 13 May 2024 10:07:19 +0800
Message-ID: <c7bce101b2d7d107ba3c89779fe6800060e8edc4.1715356532.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715356532.git.perry.yuan@amd.com>
References: <cover.1715356532.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e6ca92-189c-4c05-1506-08dc72f17beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MquwzWO+LNaGCV18Kwf3lBvMw0iSRZ1n+iarvL6RXcRaO1MbStp+kmflvrcM?=
 =?us-ascii?Q?CnYZRm2WcbbYRBH1mes842w4K2JUFvX4LORVFPmm8WyiVXplJM0GoC063J91?=
 =?us-ascii?Q?LYTMecQhdEvPKCQSiLIYbAh51iGP4USfQPXMoUxju6FFBCLfkpIG+3PZjHnr?=
 =?us-ascii?Q?zLhMW11ZtZN/mDjmh5nB/i2bdiMA5IJQNeLum/NiZtJwzR3cgzTUtz7YHhoa?=
 =?us-ascii?Q?h2ljuCC3HW0phfd8QIGMdk0/TrzWxkHogzWLm+8cKwKGd7DXoI1EIhRKQpet?=
 =?us-ascii?Q?/z2+AeSHe/H6Np5wu7zDZiuPIh0KfY/TtXQ9pKNao81/AOjjhP5LZwqXabKh?=
 =?us-ascii?Q?C/6D2udELc2dJxDNgmAzEq/B30hC9qjYNn3l/cH0ZHJUosP2QyISQ9A8rGlk?=
 =?us-ascii?Q?uHuBEYdLVOI/rx2BqtpoovxSRvDZKYCFGsDG39YtelslrGlqVyA3Z15zCYLg?=
 =?us-ascii?Q?O14/x82A2sZkHsw2GFebN7QdEl16ddZbEokhx8UJrd/B4/gJYM/x28uiKmYh?=
 =?us-ascii?Q?g5yzVoRbHOe2tYUEe3Y7sFqk5SHM8li4Mlx/1HG4VSDFq+KlCHELpiwan4DM?=
 =?us-ascii?Q?Iev+e6WEBpq3xr4lhWVyXbkt40Q3TYk0D+D3tgjrFQGOYI03boxXRaWRzifS?=
 =?us-ascii?Q?p/1W74vAIog22FCuz6CtCkIHK5jU2rgnMoBpQ1g3+r551nHXDDCOivDq0urE?=
 =?us-ascii?Q?BmSFkSzSAc2PDtYjSnzp2EA2VrkkmoK+F5BG448m7GAqL6el/9OEF6eA2DgP?=
 =?us-ascii?Q?8QI3q8FOp48xXuYUskRhYrCpUnJPMrYi6wXNhPIV9e+AdOrS8Eet3QxJt4ay?=
 =?us-ascii?Q?/gIr/RlXwv+RpSGbmpMPKM7xFMx+lLENbiF3n60JyDZ7L5n4QWCflnDLkNHh?=
 =?us-ascii?Q?7d9d/rUd+J28MhWlW8a4znfa2z2P65gYz49ZlSH5tPiIw++Aqc4t3WG1cHi8?=
 =?us-ascii?Q?6kmuzL1GLF7/N/dnZQhAUBes77bt4mD6ZXmlYC57Vp7o5mkeXPPLPR77wfEB?=
 =?us-ascii?Q?BFM2NWm84QInz5eRZYrRjmoEaexev7mKM75god5afThfRNRESTOiQSwPS5Rg?=
 =?us-ascii?Q?5BO1bqDsec7VjG3BkHzLPl+DTZ8b6F5Y4a7pdjDSPDS/tmjPpE0MgeOVIciA?=
 =?us-ascii?Q?68ipK3YeXGUH+mjoT+Is3tCQZArSWLwP4dwp4Vv6QV3uasBCWEXDY+ylYwVe?=
 =?us-ascii?Q?1UvAk84AdRT1YvoFx8iWSY4Ic+Yi3otr9FRfxb4MhKZp+HWjTeVWXIdFjYiF?=
 =?us-ascii?Q?uK4NxtlK/ZW2a6UV52CNuToOqwzZ99CH0r1eUsYQpam9ObmOFbmmKnNFGHux?=
 =?us-ascii?Q?Jnru2Fu+vsVGucKwx6s6yQFU87v29qnk2aTVa8oNcXNKzUVL0+jbTYck63Ea?=
 =?us-ascii?Q?hqRvVe0k8KTMfpqgzDYDEQL+ekzz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 02:07:46.9581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e6ca92-189c-4c05-1506-08dc72f17beb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272

To enhance the debugging capability of the driver loading failure for
broken CPPC ACPI tables, it can optimize the expression by moving the
verification of `min_freq`, `nominal_freq`, and other dependency values
to the `amd_pstate_init_freq()` function where they are initialized.
If any of these values are incorrect, the `amd-pstate` driver will not be registered.

By ensuring that these values are correct before they are used, it will facilitate
the debugging process when encountering driver loading failures due to faulty CPPC
ACPI tables from BIOS

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6a342b0c0140..614f6fac0764 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -889,6 +889,24 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 	WRITE_ONCE(cpudata->max_freq, max_freq);
 
+	/**
+	 * Below values need to be initialized correctly, otherwise driver will fail to load
+	 * max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf
+	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
+	 * Check _CPC in ACPI table objects if any values are incorrect
+	 */
+	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
+		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
+			min_freq, max_freq, nominal_freq);
+		return -EINVAL;
+	}
+
+	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq * 1000) {
+		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
+			lowest_nonlinear_freq, min_freq, nominal_freq * 1000);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -927,15 +945,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	max_freq = READ_ONCE(cpudata->max_freq);
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 
-	if (min_freq <= 0 || max_freq <= 0 ||
-	    nominal_freq <= 0 || min_freq > max_freq) {
-		dev_err(dev,
-			"min_freq(%d) or max_freq(%d) or nominal_freq (%d) value is incorrect, check _CPC in ACPI tables\n",
-			min_freq, max_freq, nominal_freq);
-		ret = -EINVAL;
-		goto free_cpudata1;
-	}
-
 	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
 	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
 
@@ -1388,14 +1397,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
-	if (min_freq <= 0 || max_freq <= 0 ||
-	    nominal_freq <= 0 || min_freq > max_freq) {
-		dev_err(dev,
-			"min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect, check _CPC in ACPI tables\n",
-			min_freq, max_freq, nominal_freq);
-		ret = -EINVAL;
-		goto free_cpudata1;
-	}
 
 	policy->cpuinfo.min_freq = min_freq;
 	policy->cpuinfo.max_freq = max_freq;
-- 
2.34.1


