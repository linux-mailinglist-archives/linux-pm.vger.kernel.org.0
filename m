Return-Path: <linux-pm+bounces-43770-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NdOCWKmqmlTVAEAu9opvQ
	(envelope-from <linux-pm+bounces-43770-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:03:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A1321E605
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A1E1303853B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D9634B18F;
	Fri,  6 Mar 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1XH4gZ2n"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096E30E84B;
	Fri,  6 Mar 2026 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791107; cv=fail; b=Bs35qD9dHnd0nzhKen57B4g8f42SzhsdmBuZRrrLLF7XLTCLTIKuXOVX38pDzsfqWtUyg9J29xLLcot106FTaWXj2b1chBg+DBXwi3zwcjm2Wjar7Z5iTH8QP7X7AbeTyRhEbjDRjTtkVisnLEsaK8rpStK9+Zo1Fyz4OimYQyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791107; c=relaxed/simple;
	bh=RsLXjmTmLO4zoo+Q2hYavT31soTnP0aH3I/93PjQpnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6eV1WbfcFrHDvWzV6CyIvqTNy/sb6wOmawnhBtY+BLwGTfriiu3NNgooKk+7Y27yuy/+Q1ACMUH6g7QYZXI6XeRBGZsihC373DRZPAKlbxaOodPXS6TKro0fwzOWHYwfBFk89PzIKL0dyjCVB1dgsggLNddg6Wzc3zCIDb/fRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1XH4gZ2n; arc=fail smtp.client-ip=52.101.62.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1n3Q4BjD/LwFDNB2bTv/S9SYg7rgBr69zVlHQAyZMHVllssiIVLm6hDZ98NXhPzK/vbYiwCGqb8qkHdDy0Wdqoi2H0Qyc9xmaB9QQDn3F2I3FMsv1vYVHjpb1Bgh5h3EP9h/Jhkme0qnPjwIh7DW2TKCGjdmrXM9Ufjfjaa4slCC6abEnSIMsMi78nFTdvsDBMWvdn6LtsQmAYJW5Jxz5JC4VNt/40WQjXQX+AOvUd5ED/zrxX3rifY0Z+uX0Ki1zlvnP3xV/1ppOdBirWxS38ZnSEFzK3DVVS4ZPkTSuGV2RTsmolGVKXh2UTQYOOZUHAIojs+UURGTCf5o2RXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGG8WtcXwezD+YanswTAk2t8UK1UYmj2HPpiCvH81E8=;
 b=RWkAjwtisnQ8vaUvlV3ES8XO2iMWTKxgsHe6EG2iQZqPcbXACNkC+H9tlid6rYREXtHqvgEsHQxwqlGGdSSreJ+Ahi/p1KmOU4HUfdy2QgQPTcFld8QaDwsAzygHX7b/Kqs0/Zblpv0lSFBOBZaMo+B0GhST9mYFZgpKurYehhse+W2tlpfM6qWeV5cInBV3shCZ0Kmj5RJPWW6Ayp0ebcV29113d1NQCOuaiv1VQ3miVSoSPiI3QlCMyBavxrHHpkbMJBJKl04SOdIr1KuyXmFqZLY5Bep7hmg8wLkKxseuQd3p0hfiuTGLjaXx+M9YkVchZaCmFCdq7RQ4gNQh7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGG8WtcXwezD+YanswTAk2t8UK1UYmj2HPpiCvH81E8=;
 b=1XH4gZ2n8QNShTw4Ow456rp2c/Og97SzYlvz+fWQvwKavdjwMatoiJmgcO2q9RnQHBHZ9XPao+aAzN+VAyiCIRUucfM8GILhTuaXPtk4mnh0uVKM5eBkIcXarfrOxQnuDn5u3tbYbYbQH6mPLZ6MU1W/Z5AGFVQ6diDj8b+NrLs=
Received: from BN0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:408:e6::14)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 09:58:21 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::f6) by BN0PR03CA0009.outlook.office365.com
 (2603:10b6:408:e6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Fri,
 6 Mar 2026 09:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 09:58:21 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 03:58:18 -0600
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 1/9] amd-pstate: Fix memory leak in amd_pstate_epp_cpu_init()
Date: Fri, 6 Mar 2026 15:27:45 +0530
Message-ID: <20260306095753.17155-2-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306095753.17155-1-gautham.shenoy@amd.com>
References: <20260306095753.17155-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b55f00e-d5a9-4edc-8063-08de7b66e62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	Inzh72+nNGsnytlQoFTkEbP+MZXBXaAwx4F9NlbRkEM52y0R5vY1rMTHP1etV0qzwEjWWAvJyYuaXMt/ou02BOSjSZjlZ6dxq4GZh2D2ct7d5ccUHMYbY63GZl4Me8Zac33NptzvaKeVEBqaUhldq8w04FnTvP95N3hhjH7BftA7CWqxT352AcWbpcvzvamSO3jI+qA3ZyCjWz2HNnj/nU0jcj/ZqZFkh6Hd2sUnV2AlQF3dEbtKZRIeprkrNaRMJyWHH9GlmLDt6lme0vRNwEtef+QtWkI1C90CefMZajpw/oisDTP9wm6O95dQdxgecindR8n8Fgt94DMRZmFGOD7C9HEd4XdEjGaXqcyNesB3L1saVwK4j7bcTGRQCqBvyX6R1zktH6Kzd1qi21JhrwHQ4wkoGL4ZPFwPuZqzGxlzqcKLJUO06JHI8gQcyTLCKKxvuG3MRkFLXnIKWZyK16HNnUmzcOGUZF98VKdsbmH8Gzcc36zBZDqGNI1FyhDDjkTsh8b5oy05rqI3CYfukxoEjvqZxcsGmsj1p7MJMyUCP35JHjFHwfEvgvi2hgxUPKVj8a/+sJNcTbRE5S1MumG5vL3yiZzDJZEB1+EGUhTHAINpL5z8tnZKiJ5ep7iGkfmqiSKLV2TTTZN+M0lv91iy+BaTTVzclFr2yiqAI9FiDEHzfLYCAOTOgdlkXlEW7eerkU49olwmaC7lHJvJJqQHrX/Ato2b7xDycr/iJuxVysQPn30rmQ32PaSgha7iqxhdhXcqCRlySEEmyCRx8Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Zy9b05qViGfu2jmD7n+V6leKDn7WNrQYkg2WIdsbpgBMO6toJPRFUc0fy2s+HssbXN9jQAKKvfYSjz6kW8aUyDO5AC9MLOVqH1fxkvRoeNHLeZiqhCmQIATC8pMk7dpTrpgt++aMi/5Msua9ZCR5uvPPcLZ2AAorFxSFpUttNgPs4PIidoeiB5u2xHfDn+8AOl/lI+CprkMCKOYABYJitNyCwyf9uRgbbi/5lGVa17LfsdG6BZC019t1KFQR/tuOsPRgO7CDAxhV1wR2ixujmoG1suoRRh8nBtXUMgJ1wVOmqKzGUx9aoSZyZ5AEAVLEk5AEhgwXuU5D+eq0jE1u/1XAQIyMw1D/Un9xWzLVAQzyPsg9tCvT9eQZ1E7MHub5kWrFRPpKE39I+J91ds0d+OWyBTmaBHd4E/gROyfBpuxQIbwUBhJQ6ceeu5NdF3zm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:58:21.1384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b55f00e-d5a9-4edc-8063-08de7b66e62d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044
X-Rspamd-Queue-Id: 92A1321E605
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43770-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gautham.shenoy@amd.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On failure to set the epp, the function amd_pstate_epp_cpu_init()
returns with an error code without freeing the cpudata object that was
allocated at the beginning of the function.

Ensure that the cpudata object is freed before returning from the
function.

This memory leak was discovered by Claude Opus 4.6 with the aid of
Chris Mason's AI review-prompts
(https://github.com/masoncl/review-prompts/tree/main/kernel).

Assisted-by: Claude:claude-opus-4.6 review-prompts/linux
Fixes: f9a378ff6443 ("cpufreq/amd-pstate: Set different default EPP policy for Epyc and Ryzen")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5aa9fcd80cf51..d57969c72c9dc 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1533,7 +1533,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
 	if (ret)
-		return ret;
+		goto free_cpudata1;
 
 	current_pstate_driver->adjust_perf = NULL;
 
-- 
2.34.1


