Return-Path: <linux-pm+bounces-43773-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGx7K7umqmlTVAEAu9opvQ
	(envelope-from <linux-pm+bounces-43773-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:04:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 026AC21E67F
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27B2A3135358
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF8E34E743;
	Fri,  6 Mar 2026 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3MlSD4sw"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051E634D905;
	Fri,  6 Mar 2026 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791115; cv=fail; b=K0dnxdgLcMzCf5Lc3BWus1jdtinbAM3Hznw9KG3bqNjqUcEUBpg/dMkgBXqLG6g8STtl+G9kLGggX/4G8V7cj4JLEsPOddM21JKaGO9z0ljCpT6bMbwxfS7PM5IGNtpj86je8nPxO8cy+WNJ4pgSlpn1Ii3yiUhkwoUyoybEep8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791115; c=relaxed/simple;
	bh=cmXFmMBQZY4pDsHdKE7krPPNQzFJ4EkH4YIqCx4YWx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQL8Muew7HNIgQmrkP25abK0BQmqTA2Ds8KVB/tEIGy4gzx1Rsxm6CpjCJ06H/EWoGF6SYTCV6ZCr2d/JgC6y5AmnD3msdQsBdz+97cdjrAo+0DbhaQoMSqNEIVGlN/+enkiyolEkIa9o+YXQS1zXyktkPQMnsr/4rhdQzMaSnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3MlSD4sw; arc=fail smtp.client-ip=40.93.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWiF2F/VMdvs64AmqWCvSPL10TCJksYBYZSmbDnZiRvhBl/tKtJueH9luUMvlu5TpPoF7NNAn1VU0lBFSdoDI/NKxW27req7vUOzmwMAJAwKJxaSIKOWxySotiydVY+vbbAtE2xfQSIQq+bhbEnYnW19ixYFGFx2mGEYnmWM03e/UYCmcZ7zlgalN55rSpEOu57thYNbcgir3w19L6k0cZthhMB1tCJib4genujDbl77nJFXl+NPEmgAp+4kwH2rHjI4iewjvSZh7GAgGH+jjq9cYF+XC8ncWuNF1V5vy04Ddxb9FebkFayMr/s6n8aOni5sSsRx9r97/kCpDEzNDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhAXrTiULSqCL7nlE68RWQlrJaXreztSsEPR6GT4514=;
 b=lfNEMpOe469aJ17Xq53yo/dVftww/lJZSwED2SicyzODNEPVIkRdLQ/RewCidBYhKgRPC6zEIja+jFlepbkR2jFRNzZz8Qn1Wvz6TzR3T1eNGLbGx9xrYBIGjWUTFJLMJNgzNaoG+Ijm7AX2vCG+p4zD8Bw/WsadwhWp1cY5cRch5jT9uVAhsFsD68He6rDM1qu3EBZQRRrLUHM7anXzVuFHundwmK6E1aln3ZiPVFZtEYkd0Ht0kERiS0iV76hIHYSdQa0LOBrFa4zWsSixYEnoUT9r8TKHQSiYHVCpEKMKsFkEGzwjk8HJDfZNJvmQHvENXtcajawAlttt/t+K3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhAXrTiULSqCL7nlE68RWQlrJaXreztSsEPR6GT4514=;
 b=3MlSD4swFzubPLDFYXR4mG6QsKFxIVdjH8ScuV6jdS+cS2Fd74vYWnOgfZtwjXdhs5dO/1UAUkS4OPuJrUWhoW/6xQBZYOKu0TyUnM6J5Uce+oyxsn4wjLXELt7bjRLUnFHcUrY/43xxLcVzOQ4t8l4RuXfjjvkLj63H3W1b5vc=
Received: from BN1PR10CA0030.namprd10.prod.outlook.com (2603:10b6:408:e0::35)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 09:58:29 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::e4) by BN1PR10CA0030.outlook.office365.com
 (2603:10b6:408:e0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 09:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 09:58:29 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 03:58:25 -0600
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>
Subject: [PATCH 4/9] x86/cpufeatures: Add AMD CPPC Performance Priority feature.
Date: Fri, 6 Mar 2026 15:27:48 +0530
Message-ID: <20260306095753.17155-5-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: dadc753d-93b6-4671-e2ee-08de7b66eafa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026;
X-Microsoft-Antispam-Message-Info:
	IObXAOXniIN834kGQtEL95uLFfBuvHlWAWWRDM67wsVlhBs3pV3odf6k4L4BH90WfQTsToZFPR4Ig9seHuwJkjZxjJpzlfSXVVjDzOR8Qiys+w16utUTed2Q8Q1rD9pr6DRWFgpNRqrCeyF1014HoJFfdmdIqhiOhO24xsmlNRBQJSZCa2mZ0mjo9B6gaypIWiyan06HcmDs69XQr2VSDpHGU20jLkpi4UW2Yp24XUcmEfV1fCZG/Ky49TQ22eJvvR8r3usmMkc7HaU/ddy1MGulLgMqy126rNhjs04CjfPA5GFEadEJ63P4w2nNvTlq2pz5u8zRH5jjfc8YjS1CH7iNnEYKnp3aGL2/zjzWXlgjVZuIArD/XavRChIsVfBHitHxJ3vLvi/DxzgPcpW5mMi6y9iEyOZBQe4OjOh0/9u8YWfuA4VhGyC4o+CGqfbsA52/0pS555eNbvP1ckPRvyWFhLk+Ny8V4tIeO4RvuaFF6HNo4103dvcjAinUHycWcEeW2rAAymf2lZYM5N+2TiVE9BRN1NznDaV7zSRhZD5iWAgDjB9fxP44Mc5Jn0KyYXx1gFTsBNGX1yv34aHBd/qG7/nUHJz/dDM9SQE+/CggCAazhTkTMyoEGVAoGiiHRq2qezAo86praE3hC6/j/Av5JLMUDekCMi5XQw00aRDu82gVTGFs7Qx+4Rm8c9VKq+4DMvqV1zapAfdzjczqZvyAyTg+Q2B15mtf1SqrN0JJlpqP+6TwaX4yYVwjFKNHGMPA8EbIBupSv2t8LUK15mK7ZSuAY1iz029jI0J/Y44=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iDKc7hrbbfytlrBv05W6XOzxwdOf56I6tGr4OT8SXG9HS/rz1UDRyM73UOYa4AO0c/7j9SjTDYsTESI0sUJgtl4ygwaRtcOD3NruNorNVRRsY++fajMZz8NGlFDBJD519rMvoEyFoSwl3P+WoEW/LrnQxaelPSmp33wyh+WRGfiHeVDysN+qIglDFLXLRD34FzOAvk4rk8FEf81DiGY7sUd4HXh+RzDbXdlC1LtqwYP0KMo2knKYiYZ7ktuLBASfAHWJLmrtXWENmUXpBU6Rve5kqE5QZRB8Lt6ZIqFEkztpUu+HXSSm/f0tlOENkhjMHTXUOB3EI2fDdE6QZQ2PxcWh7AKTSRzKh1f8uIiiDD8JkjZHaV6kRhQ0LtBi4R17VKC5MoDXa0ASTN3sklZa4TR4lCGpvUfxErftEoi2fv2k3MSUZvLrbjuqNd0sdSRb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:58:29.1952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dadc753d-93b6-4671-e2ee-08de7b66eafa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
X-Rspamd-Queue-Id: 026AC21E67F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-43773-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gautham.shenoy@amd.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Some future AMD processors have feature named "CPPC Performance
Priority" which lets userspace specify different floor performance
levels for different CPUs. The platform firmware takes these different
floor performance levels into consideration while throttling the CPUs
under power/thermal constraints. The presence of this feature is
indicated by bit 16 of the EDX register for CPUID leaf
0x80000007. More details can be found in AMD Publication titled "AMD64
Collaborative Processor Performance Control (CPPC) Performance
Priority" Revision 1.10.

Define a new feature bit named X86_FEATURE_CPPC_PERF_PRIO to map to
CPUID 0x80000007.EDX[16].

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
Link to AMD publication describing this feature: https://docs.amd.com/v/u/en-US/69206_1.10_AMD64_CPPC_PUB

 arch/x86/include/asm/cpufeatures.h       | 2 +-
 arch/x86/kernel/cpu/scattered.c          | 1 +
 tools/arch/x86/include/asm/cpufeatures.h | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dbe104df339b8..86d17b195e794 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -415,7 +415,7 @@
  */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* "overflow_recov" MCA overflow recovery support */
 #define X86_FEATURE_SUCCOR		(17*32+ 1) /* "succor" Uncorrectable error containment and recovery */
-
+#define X86_FEATURE_CPPC_PERF_PRIO	(17*32+ 2) /* CPPC Floor Perf support */
 #define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 42c7eac0c387b..837d6a4b0c282 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -52,6 +52,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CPB,			CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,		CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_AMD_FAST_CPPC,		CPUID_EDX, 15, 0x80000007, 0 },
+	{ X86_FEATURE_CPPC_PERF_PRIO,		CPUID_EDX, 16, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,			CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_X2AVIC_EXT,		CPUID_ECX,  6, 0x8000000a, 0 },
 	{ X86_FEATURE_COHERENCY_SFW_NO,		CPUID_EBX, 31, 0x8000001f, 0 },
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index c3b53beb13007..1f1aeeb151337 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -414,7 +414,7 @@
  */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* "overflow_recov" MCA overflow recovery support */
 #define X86_FEATURE_SUCCOR		(17*32+ 1) /* "succor" Uncorrectable error containment and recovery */
-
+#define X86_FEATURE_CPPC_PERF_PRIO	(17*32+ 2) /* CPPC Floor Perf support */
 #define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
-- 
2.34.1


