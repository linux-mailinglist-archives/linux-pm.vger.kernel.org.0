Return-Path: <linux-pm+bounces-16125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3269A71BA
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108941C220F6
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C05A1F9AAE;
	Mon, 21 Oct 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xMQivzP1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C201F8EF1;
	Mon, 21 Oct 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533805; cv=fail; b=UfbTcKgQn0BcNLGm5la2mGVVJ41MEjXiX7jfkECONDnHYqBglCtlAbQt9sGa7UVMiKfm72tgNNHHUW2DV62FvFuTI4ILjjhFleNT4IIt7PVwhLlI/JEykMpTZa533KZg3Znici7EuDt6aZmMiTRiu85/RRPHhWjj7Pe2ySdxTKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533805; c=relaxed/simple;
	bh=tqMgaDDnCyjCP8Vj7sLdAJDiXkijIqTRLnupDNMtRL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2Wj9dbcbEI44vJf3NxIHiqfOmfBZalv+LqQ1XMtlHXDceXQbv2vUtQ1APSAI0d+2ZSN3YLL/+xHGTLAlN6mP/KR9uO8RwBajdTAi1aFNFX2Be8SV33u4rMIoc1F1SWn7UTFyNSsvFhyIEvfvhpTKqes4xRdabiDm8OcDMka9wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xMQivzP1; arc=fail smtp.client-ip=40.107.212.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4Ye9Q8z4BMjIUT6CbzjUS5rzPMXkglxba+FMX8XbR9M1KCnI2zg+bWNzkxVtMDA5flFLMCrPHDA8Jq5HMvc5H1zLdZNXWvRz4dekFOiu/tkzCfHIUYjTpsUtI1fNvkBC2iOsWt4Wmkh9OcdcWi0jzXHoDR90CLjdUn4lRUyOZ/p9sCVgOIKVEXDH+Ja/x57wPndBaxtF6cMgB5QaoVpJZrOIFiXJigY8JJdYDNQIQJMh+9MFAqL4S8mYKMT0G2EPvi2o1l+dZ9FeDVGo39SoPa/GUBh14biNd/Uikq8OMFyaK0i7OESMC1Fgq5BceQcBOJp8iS7blh7+lqEgj98Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+zqhKq88bW+CZIXZtkwhqbuSw5OJJmvxROTIYIWXsU=;
 b=LeT3jVCB9/YdHcCeMNs8s0V+1Bc+LJUB6Z2PAsjIcdQWWMdRBRgXDrsj3RLK3A/xsia3XP+NMwNuXwN9pPIpnOXKftOXIaW9KXPZbJu4ZVHgazRKoI61zOB60Mc9wH2A7zYmv3UrrMY39hvyTn9PM3f33LXQm9KcCIGqCZfBvLzv6xcmMZD0y0GjI1cH2BLjYnhXW4N4zO2vK/E3ZzZtiMUMU7eg5VPizKYZmE2R/Rbd8/JqNjRk6AWaQF+q5pmChwTIpSmcPr8tp4BzugmBAfSqwbRYM28Kg1X4f3LH+KuCHCFImtBd/S7HgLxqqfsYpdRPdytZfb1O2owS2I96WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+zqhKq88bW+CZIXZtkwhqbuSw5OJJmvxROTIYIWXsU=;
 b=xMQivzP1X3pmkRIaSCjcpzR+IjaVD7RJ4fL3nA7sTAqdjbsaYpRKHENcvwJ7BYjAnoIUmyCZurlNm9URljoWYBgnUj5e6eZRs+TRx4aGrZ6huDSZ2aB4YxMk3ZOpyPRMmo04Dm+2eIx1kG3N0KH74bDYzMz8GOCN/o3RHnd4gBE=
Received: from BY3PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:39b::29)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 18:03:19 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::2a) by BY3PR05CA0054.outlook.office365.com
 (2603:10b6:a03:39b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 18:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:03:19 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 13:03:17 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v4 03/13] x86/cpufeatures: add X86_FEATURE_WORKLOAD_CLASS feature bit
Date: Mon, 21 Oct 2024 13:02:42 -0500
Message-ID: <20241021180252.3531-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 91096a22-dc36-4d32-0845-08dcf1faa50e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x3R1Xp8sGxNX9arxpSmE4p3951Wq6juoA6tnc9kEG808DlhClctNO07q1Pjy?=
 =?us-ascii?Q?LQ60Ci3PqXI2QbH0WtVV5N5N/hqnN6MNT756yoGzlHpIH/zelKoUF5e+O1JF?=
 =?us-ascii?Q?vQgf+D9DTPrWXNPNlViO7zFRrcvQD1yeBFbW9WzzwQSSawKFx5IpUOBIdBu1?=
 =?us-ascii?Q?jzgqZbVkWl5YDht9+KGYoeDmXk/IR70SpgG+RZB9M8qamg4lCqu5BP/ILNvV?=
 =?us-ascii?Q?pb49yBO22jkPYh8WpkWQcphpZv4cLs8oupviHv6aJoJG5SicB1VWIi7Ul4YC?=
 =?us-ascii?Q?Z7fYwFKeYigxRvvQKQyhCR57u7ASpT2D8HyT1rjL9WZCNbIme7r0e3UfTWm6?=
 =?us-ascii?Q?I/HfY04x8I6lBXJdpskWuLyzmZ1BPqrrjxxSd4DTZPeSq3a4F0w2/IdBBhmg?=
 =?us-ascii?Q?g6fyqv6+Y4dxq724SnXNJLxkdExKvfRdqC7GCuw4lz2cLY0n5ga1FsnV0VMJ?=
 =?us-ascii?Q?QFRmbeEGrnn1XftuAp2EvK0Qbf35Hwr2uF/Be6RmC7DpQ9sYlP89Y9Vqtnml?=
 =?us-ascii?Q?a29QoozXgpkz0CGph89b5JElXei0FwEUO12obd84UF1nRfkUDbrOUzf4OwHi?=
 =?us-ascii?Q?pQUDTNUeiy5tXcQzAGQa03FmVFypAeGDtyFKgpua17mnRI3p4wzH8TIa1u13?=
 =?us-ascii?Q?fDLz5q+SFgGUCwK69yJ/sJhQk5dPSTv/rxfFsrvk8eVDZPqREvUIZjw12aBH?=
 =?us-ascii?Q?UN81ghbr17hJBzbpU9tcyRyhAd+gfE4L9N/KhY9WB7VW+GrxtZqB5wOQolLA?=
 =?us-ascii?Q?kFq2mhiX+AdA1gQx5pD4eyRI0kaJq6qOEvwR8v/woHtqBDIHFrPGuhd5Gbb/?=
 =?us-ascii?Q?6p3UxmQIllvEOPIkQEtQ2PSxXHFBtsA+6PEMVsu2Di1iMe6bfC0ZRPAz0IH6?=
 =?us-ascii?Q?euTnfP1SevqFLdVloPN/vYu3IBuPRwrD/Ls0LbTyzK2PD7wo4HCdrDY9m3fY?=
 =?us-ascii?Q?1NkH9EF94ZnEGciT2yD/62w8EdY8mC66rXvq3N1C4tIYFJ8SOqw6du1USCb7?=
 =?us-ascii?Q?nuHwEvEgNdSQ9D0McD6v74Tq2G/ScThHb/94x1qui7/IvDqb9CHfBsLApJ3b?=
 =?us-ascii?Q?k9Q9ryj9zHoxgSfle0M+ie+zx3PwYJOD9tXsa23bEtYydgF5QCK1taxjFQxA?=
 =?us-ascii?Q?6EEXxkqvs1MaXK1mRqyVFMpjjtlO8CCNqE9jG8SfAwdYZVTn1/OWRzQoK2Rt?=
 =?us-ascii?Q?KbojVaKbQda21gmAV0ptGtM9v34yc5DERcUI7uzfWszYAediEClnha/cY9NA?=
 =?us-ascii?Q?7glDzkB9u2lLCozuLc4km2MUqaeFdY3+iHKZ8IOEltAGpbGWNUqHDuPrxFa4?=
 =?us-ascii?Q?MoSKHwM+kmEtHyk6sGwphuGYYKe8dUywld7yWDcuUcHLI2xJtyWas2p5unY+?=
 =?us-ascii?Q?p8N29LCehIi9MOgKMMydRVNr7RqRMTPdTGLb/Y7kD3pg+Sg4dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:03:19.1639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91096a22-dc36-4d32-0845-08dcf1faa50e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602

From: Perry Yuan <perry.yuan@amd.com>

Add new feature bit that indicates support for workload based
heuristic feedback to OS for scheduling decisions.
When the bit set, threads are classified during runtime into
enumerated classes. The classes represent thread performance/power
characteristics that may benefit from special scheduling behaviors.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 7f6c9fc465293..360bbfe8dd44f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -474,6 +474,7 @@
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_AMD_FAST_CPPC		(21*32 + 5) /* Fast CPPC */
 #define X86_FEATURE_AMD_HETEROGENEOUS_CORES	(21*32 + 6) /* Heterogeneous Core Topology */
+#define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 307a917415343..1e54332594443 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX,  22, 0x80000021, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
-- 
2.43.0


