Return-Path: <linux-pm+bounces-24869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520F1A7D7A9
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 10:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCEC16CD93
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 08:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E657226883;
	Mon,  7 Apr 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Piop0/Qn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E36224B1C;
	Mon,  7 Apr 2025 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014138; cv=fail; b=NjobMZP2NiCRwSAYO4Z6B9fx5LX3Fq6GbVcA2eNzvz6+CDhCxuiWoWVSaVURSQqqkRJIBUVumonwwFAJ98lGIQUsh8gZlwVL+++l2mh8zol3bjTA72qUN+tthj0iziq4J6TNNpqM4QrpjqJVYmCBHxZDXOKH3PioC9+aimJo3mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014138; c=relaxed/simple;
	bh=GOAkZOs5o+bJ/hI0CSUhA93aYvcSZ9u73NEYNE7Q8Dg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a8u66JptJxJ7h162q6EYII+lN1QJX5N5FkNnixkKtRpXZ0COuTuy0gRQHs78r5G4AorExTZQxr3cQGsazYk4Gwlid+WjO+jM7gSZj5Hp5NRBvI1nmYRnrezZ6R3w5QUzhjYfphbATZoQ0Q+D6wLB2aVq7jNNoDo02IYmmtAITW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Piop0/Qn; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1AnK8eCUj4q62Z3eARsLluwic0EBxzBiKyaPVA/6C+NPwY9/NVLnw8e0xDAgr6q/raFh0zQNMVx9nWPw7eG6gazqf+B8yxxvSsWKIqiFXfM+0lRDIy+WaWWRmmjybRbjD/IaHwIf927RoTX9Ar9tYWzZLHS63n4G+0EINnMz3jUM/p42WEv3qjsE/Tux0UW2AYiMswfeeT7LTnJaKc3Vr6BB3hF0qccfjsw8ec3gJAD82ZQSZo6Ns01lbRmzwNU6S9yG0pQQnEafVGgMN5La+BfGmfHta7xTsB+QVA/W39qx88siVqo5rix/3YRNc/GorJ4yNWgHgiRDI4qugzMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akAerm4Z/Wl06iS9CiMszjs/wxUoPUCfVhzqpIB2eWQ=;
 b=rQcPnOZG8CpHo6JGDLf6TN0sfyfH7QHWJ1dKBIrjMKKZ+1kwmtCG0KA9ZtYhw1CT9EkZe/ncsAVMLTf+dSzqyVKgGKWZcFYp4jPz+cORgyyblxQcz2Rt2or33cWU8jOjnD8tzkmuw0Z6ohL+r1f07QgBtQ0AH/njehpW+5VEuPwrfQUQs/zNVLSBB8lkLnEUM2AczWnVtye4RGF8AZdWabq9DQLewTYyXZa09RyVujgUIKRoZv5UFaAjLjYhIlwi0paSzwoZUCBc1ZNyVPbKhXY8o/bUG1hRKdYnKBp9IS1tF5KzkbcXurRd4d+ADljwqMBfQxFBxJnvSUvHNaMAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akAerm4Z/Wl06iS9CiMszjs/wxUoPUCfVhzqpIB2eWQ=;
 b=Piop0/QnsRUXiOaKj/dnJJWCJq6VrVSQwWL52wJKvcY6svNquYTV7P6uwdvXL75LSWMRMXZ7aQoux+QrOLCfoE+ft5xyESO2jqf+aUXtZoQUF7ATOf6XO+PLOD59BQmc3i5+qabKtRVfu90uJHs8IiU8pp7XU1PXmki9WjDVsUA=
Received: from CY5PR19CA0124.namprd19.prod.outlook.com (2603:10b6:930:64::21)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Mon, 7 Apr
 2025 08:22:10 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:64:cafe::5a) by CY5PR19CA0124.outlook.office365.com
 (2603:10b6:930:64::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Mon,
 7 Apr 2025 08:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 08:22:10 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 03:22:05 -0500
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Fix min_limit perf and freq updation for performance governor
Date: Mon, 7 Apr 2025 08:19:26 +0000
Message-ID: <20250407081925.850473-1-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c8ef14-b067-47d2-db18-08dd75ad4b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dSiQKx/8mg3Ns/f4zr8wfJAMF6xvIPcXaBNr510xqw7zE1aR+DGUHBJNGAGy?=
 =?us-ascii?Q?hAWm8GAoTLMVBzH/vmWAatiZYvqYE7qZYyejEZYSeYGDCk40xtp4bded53UI?=
 =?us-ascii?Q?8M9BdtVhTC+L1BVJvoZITJPiiROyE2kXezicpTVyP3ZVgaszG256qZNtCXT/?=
 =?us-ascii?Q?Z63M0HPEikKQyIQVKBIRsx1q4hl/GpHv8mqRdRaUv4rq9UQgmQ28uQobIBvv?=
 =?us-ascii?Q?M1cW+cdvn8FqH+3Sv2tEX9My+wsGKIs77D923nHnKWy9pcZlK1x0CLBJdi7P?=
 =?us-ascii?Q?5lFNOLZoMv4UWRBccA/Tu0snPawAzH/VvUTTEDuKBg4wZrxIL+64+iC/A+gg?=
 =?us-ascii?Q?J6Ly7k5SE5wXlW+NQDLHI4nbyaBRompv3CyxN8tS67LKddPtxesdUrp9nNvh?=
 =?us-ascii?Q?/fjME4NNre59M4sMJAFiSDCRkyu251+OtJUmoaZcULIuphIC0rLMCHlzGIrT?=
 =?us-ascii?Q?SiNboZVjflD1aMXumd6S9XMz0V0PX9dzWRDo6koG+QMQBpphfHYFonhkt47g?=
 =?us-ascii?Q?5/VCwI3/fxqkVqxJ1f3Tkb2kP+x5sHA7P5auMa5gycOH5pYeIcpvpb7pCX7v?=
 =?us-ascii?Q?vQR/ha7pWxaO9mxuEEsnuGX2Guyc0w51XtdJnJAmdzae2/OMgzOLiF/mjwu5?=
 =?us-ascii?Q?FkTRhz10Y2J2kFlKdlIaX2sPrFkv1cc3aQ6/JIiQligEKNuAcHLcJmNgxq5c?=
 =?us-ascii?Q?SFUA/QcTaC8Qylg5XttUvQuPKGaaYQ85qHdHTB5eUEcueXrlaqv/wi52rBFP?=
 =?us-ascii?Q?V6lXn32jqo+Mb1CD9BkLYOzui84LUGbqANqoQ19UqBaipQtQgASDH2ad2BKO?=
 =?us-ascii?Q?lUPu27Xo9PulEkfvf6jDPcXpu+Sw7aBnEwfp1pKkPMIgu2g9rLrpHeNndHGk?=
 =?us-ascii?Q?C01QOSnYA32FWZNYJH4+LQSlUfwHvOOOBpBv6f5QElDjRu3xcJpUjfSZvuKc?=
 =?us-ascii?Q?/t0lVGGyBwOUccfggG8FKTMfKceNeQh1hskKxMLIrMC08nSKC5OVNJIhRe18?=
 =?us-ascii?Q?BV0J3xDDq+6YupH59sdm33LiAWOOljP0hGSFXjC6SBgkcO3ha95UE9WCSmTC?=
 =?us-ascii?Q?LQbqZw1vI7YxitmsragqfKFJi68+byB3lCytZEX9F9sV8WyqFZGjk/inLRFs?=
 =?us-ascii?Q?21Prat9NwMfyEQ0+tVcvkdd/Qp1Rl88UBF6hrybxUU4eto3iPzK/qdKGvZaI?=
 =?us-ascii?Q?BLdmibWOXWBEfY+57A9ROJP9VyMtII5XjWjg+j4gyGyyvJ93ziKaQFbsO1cS?=
 =?us-ascii?Q?PYIEMSXoL5Zo8CjuRDvmvXT2slBD8cK8sXNppAiSotBBcmDkey7ELTC0i7bX?=
 =?us-ascii?Q?IK0XSkxmfqbiqRjUM6ed59r4HlWKKtbGNaUiZwPvhKUEf+FT8PFP1GUHNw59?=
 =?us-ascii?Q?L8uP46HovyPGslVwPW0fxOqnu9v9nSlEUJTDOjqxRtG9wIMjO/nRCIb91l9K?=
 =?us-ascii?Q?zrA+qhhkmqPJJ6a67KbwFW/mDFJ+2LMTJKXT8SBMncfL7jbtpVvXNUiU6TnD?=
 =?us-ascii?Q?TYbIGxqv+cRqkNQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 08:22:10.4562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c8ef14-b067-47d2-db18-08dd75ad4b17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950

The min_limit perf and freq values can get disconnected with performance
governor, as we only modify the perf value in the special case. Fix that
by modifying the perf and freq values together

Fixes: 009d1c29a451 ("cpufreq/amd-pstate: Move perf values into a union")
Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 024d33d5e367..76aa4a3698c3 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -607,13 +607,16 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 
 	perf.max_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->max);
-	perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
+	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
 
-	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
+	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
+		WRITE_ONCE(cpudata->min_limit_freq, min(cpudata->nominal_freq, cpudata->max_limit_freq));
+	} else {
+		perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
+		WRITE_ONCE(cpudata->min_limit_freq, policy->min);
+	}
 
-	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
-	WRITE_ONCE(cpudata->min_limit_freq, policy->min);
 	WRITE_ONCE(cpudata->perf, perf);
 }
 
-- 
2.34.1


