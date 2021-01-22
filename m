Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B3C300A5B
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 18:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbhAVRu3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 12:50:29 -0500
Received: from mail-eopbgr750049.outbound.protection.outlook.com ([40.107.75.49]:65531
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728499AbhAVRlM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Jan 2021 12:41:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQMn79JOYfBET+ry8LPwO7yheD5v1br7TAJICN2cWrvtHLTuTrPydwM3VusPBv/P3gSTL79YmnIIW8R4IJmEXFcmL1Z3Ami72ak0Yh8sHll9PiXqFF5zHEcYGOewoOMhYoiAv/fS54vFTfIoFloMRFbeqrJOAmSRjPjmgfCqKVyG2VP+JndAWdxZ0fKBcIoLHsRirBPnibyuFWYci6whHcENo098eWuz1yrKDCGHWYrJjlnrVd3TBUvssg6KWZM9SH+Tuc0+Q7ZYMBuuJSnF7JF4b+TCjbXjBmGKadbSgf98c6VHjJwy2M/kwX8dzdVhxsVkcrKwbd556tVER2v02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMJ3hvuFNrjL/0qR4WRV+UarsQBnqKw5GoB5Z9n+Wlo=;
 b=fJ8B5N1ilw8uvYrUig3W3IJq16xGJgBPZ3a1L1nz+8liL+OJwiTSPkTvY7ehBOZCH/qL0eVUcUWJbdT5JcUx9ZPJfCDzRBJGNTVq5DvaJsVplzNpspYInbMt3lBE+H1hCpHn17EzojchhfZxEp6r/HWRPqdVQPCugaziAkS9xQbhwcbPQfD7YgITcz1Ctvbwb0D/WqOMVxQqOS4fvIw8NNOpwLVH7zeZX//uRdggvz0qxOMySrP6Ub7FJIx+Ki6Lw9tzNNbj4h3GPnAx55kulIZwgOXMKORyglmhiIny5rt8nRsoCDwNYB8UMQTJi1CCrq8MIi0cR9JkEMPCb4DeaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMJ3hvuFNrjL/0qR4WRV+UarsQBnqKw5GoB5Z9n+Wlo=;
 b=i2wnxdAySLTBENOIvxllK9MjsAf7Ekg5wMpGfEwHCa0Jx+3J4W/AYYEI4J4J+p0nmxVk/4zo6QddcLYrYy8Uq5+MEsbtRNe4saMZtu4Wegx7rLZmY3uIDcov8xZ1AGrg75TaiD+HA66McMlFKXwzun8JbXT03lWm6RhQ40X/MT0=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 22 Jan
 2021 17:39:24 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 17:39:24 +0000
Subject: [PATCH 7/8] cpupower: Remove family arg to decode_pstates()
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Date:   Fri, 22 Jan 2021 11:39:22 -0600
Message-ID: <161133716232.59625.8399970891746681982.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
References: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: CH2PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:610:53::15) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by CH2PR17CA0005.namprd17.prod.outlook.com (2603:10b6:610:53::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 17:39:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 53bc23b0-effa-4952-1aba-08d8befca888
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28461566D3D17F279AFF9752ECA09@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gjhy1MKG/yMTWaKVN1zcNSdvAX2fJwYwNGvAAa/uJG51ycdq5G6GCNAiOd7ghoLDDt5bmu+3tmMmfmlG6wA6UVhzxjVpAvMVycN/B5Oiyioj0eB40W8HmAdmFv2lng/svabhyIjOvqsEuaqyU6iECuWYVdg/msOGXQ1NSf2ofwGPS4uef4zSHPzXMdN6/+BImvpxUXItnQz8S4en9pq99SBP4ek8tkPd78y6UvwaD4wGioB+VGgWkEDN4CZ/mXFNQo3/Q+z2UdS03GwZvDzac+phs81iBzYbk07oPvluwRq6bksJxPq0IHUoXph+cwHb6Y2yKLEB3V+kWdnbLUWbrnpvSK/qi6t6tephBnxkwHyXKczL153iIR6/2aIjdxtoFesj0Hm7SHtM3foz0E5fqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(103116003)(8936002)(52116002)(86362001)(44832011)(7696005)(66946007)(66556008)(66476007)(956004)(5660300002)(316002)(83380400001)(55016002)(478600001)(186003)(16526019)(26005)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R2hMQmdxL0diVHE3Z3hVWklPSTk1V3pRZm5Gd3B3UmVHeXh2SDdTWWFaZ0x1?=
 =?utf-8?B?dXErWjY5MEErdHZINnAwMldiWWgyNVRpcmZWNDZzVGpHT0UrUTgzb3Y1ODlx?=
 =?utf-8?B?RWhGdUVpRnZXMWNLWHZFaE53RWFmODg0UmMxWkFPMVMzRExzejRZdjFMV1hO?=
 =?utf-8?B?RmNzZ3o1elJBRjFFK3J3ZUFGRFdIVlB2RFJMSXFKTkJ6Qm1Ec216ZlpNSGR0?=
 =?utf-8?B?MER2QkZ5MnFwcXNmcE5ZVTdzOGsvblNqWm93Y0ZaSjRsRGx2VlAxRnpYZ0R3?=
 =?utf-8?B?N0RwWUJNV2YrSlh2Zkh1Tk81Rk13RXN0L1RKcFVwVE45NWxUakQzV2F4ZHRD?=
 =?utf-8?B?ZEw1QVlQejA4MlJ0YjNaMVA4TEVyWGFWSmVrRUVaUnlwRE5FR3ZJK2VvdUF6?=
 =?utf-8?B?NVdzOExXQ295Qy90UTluUWhnMFM1MGxLL1lmOUJHbituRm9KdnZ5cmVoeTk1?=
 =?utf-8?B?TTdGRUw0WmpkYUFVcVFQYkN3YmdNWGx4eVFRckxSUitNQzExdnZuUFhEWWRt?=
 =?utf-8?B?K2RWL2pBeDZ5T3dRWWdkTlpEd2d0czljMXF2Sm15ZVU3bzdhdnBYTHUyU1o4?=
 =?utf-8?B?bzA3YnVjTmNOZ3dYNmdnNUVQajF6a3JPZVY0SVBJT1R4WXNjR3J2a2xUTmlU?=
 =?utf-8?B?VjZwNTlZdVZyZEhaTDYvaUg3b1kyR3ByWmxzcEp2blZuSFNWWFlNOGdJVlVG?=
 =?utf-8?B?dFlCK05FUU1mNEhLaGhZS3A0NVBROE14S0piSm9qQU1TL0oxb1hNbnFiNU5I?=
 =?utf-8?B?em9jOGtIZnQwM3FZQWhtcEpucnA1VnhmakpXanpmOXc2TTdqQUg0ZXNiUHU4?=
 =?utf-8?B?SFUxdEIwNkZ3M2trQzdHMVc5WjlLQTdacERDd1NKdS9nVE5lN2FPU2pNYXcv?=
 =?utf-8?B?UFRkRE5JRnpoTTRwb3Y1YlZld05VVm03dE14TFM1OStiNUtqVUhPMzduY3hE?=
 =?utf-8?B?U1RQdVh3LzJ6TnFxd0MzQ0x1WWJsekdYcU9HZDNQMDhKTGNXUU9MS0Yrczdx?=
 =?utf-8?B?ZkwveGN3VUJsU21pNGZ1ZlBuaUY0WEQvdFY2dEJ5UlZGM1V3WHl5RG1VN1R4?=
 =?utf-8?B?VGhpWFpOMTM4WUhHYUgwNi9PdnVSMURzSTJCZWJUMUZrWHI0WllCanU5NVhh?=
 =?utf-8?B?MVZ2TnozczVDdkhWY0NDWExEdW96YU5iekMyQ1FyOGpJcmtlRGkrM1MwTUpD?=
 =?utf-8?B?T09FR3kwMUxGdlZZa3cvVDBoRlJDZmlSRFlGUjl0eWFZTUtLcDJ1dWxadHR3?=
 =?utf-8?B?WC95WkxPb1Frb0JzK1VrekRQMURNK1BtaVFlQkJOUFluelY0VHNqQ0xVWDNj?=
 =?utf-8?B?aE9YOUo3UjBibWFIcTBrZVFXWklJSU5PK1hzNzdSZmlWWUJWN0JBMkdobzN4?=
 =?utf-8?B?K3BFWk5VOTdWRnhKdkVUWmpkSytDZ25zMUZyK2ZZM2ZDSTh0d0RCY3JYVW94?=
 =?utf-8?Q?V1/r9vWE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bc23b0-effa-4952-1aba-08d8befca888
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 17:39:24.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reKWG6G22JmjookkMt3cRvkkN5D6mFRILE7X227fcZPNxIDiDhBSdARjfvF3hyrCrBTG/cbXCBDi/CCYLL3aEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The decode_pstates() routine no longer uses the CPU family and
the caleed routines (get_cof() and get_did()) can grab the family
from the global cpupower_cpu_info struct. These update removes
passing the family arg to all these routines.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 tools/power/cpupower/utils/cpufreq-info.c    |    3 +--
 tools/power/cpupower/utils/helpers/amd.c     |   19 +++++++++----------
 tools/power/cpupower/utils/helpers/helpers.h |    9 ++++-----
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 6efc0f6b1b11..f9895e31ff5a 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -186,8 +186,7 @@ static int get_boost_mode_x86(unsigned int cpu)
 	if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
 	     cpupower_cpu_info.family >= 0x10) ||
 	     cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
-		ret = decode_pstates(cpu, cpupower_cpu_info.family, b_states,
-				     pstates, &pstate_no);
+		ret = decode_pstates(cpu, b_states, pstates, &pstate_no);
 		if (ret)
 			return ret;
 
diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 20694c3f367b..01bb85121216 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -41,13 +41,13 @@ union core_pstate {
 	unsigned long long val;
 };
 
-static int get_did(int family, union core_pstate pstate)
+static int get_did(union core_pstate pstate)
 {
 	int t;
 
 	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATEDEF)
 		t = pstate.pstatedef.did;
-	else if (family == 0x12)
+	else if (cpupower_cpu_info.family == 0x12)
 		t = pstate.val & 0xf;
 	else
 		t = pstate.pstate.did;
@@ -55,19 +55,19 @@ static int get_did(int family, union core_pstate pstate)
 	return t;
 }
 
-static int get_cof(int family, union core_pstate pstate)
+static int get_cof(union core_pstate pstate)
 {
 	int t;
 	int fid, did, cof;
 
-	did = get_did(family, pstate);
+	did = get_did(pstate);
 	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATEDEF) {
 		fid = pstate.pstatedef.fid;
 		cof = 200 * fid / did;
 	} else {
 		t = 0x10;
 		fid = pstate.pstate.fid;
-		if (family == 0x11)
+		if (cpupower_cpu_info.family == 0x11)
 			t = 0x8;
 		cof = (100 * (fid + t)) >> did;
 	}
@@ -76,8 +76,7 @@ static int get_cof(int family, union core_pstate pstate)
 
 /* Needs:
  * cpu          -> the cpu that gets evaluated
- * cpu_family   -> The cpu's family (0x10, 0x12,...)
- * boots_states -> how much boost states the machines support
+ * boost_states -> how much boost states the machines support
  *
  * Fills up:
  * pstates -> a pointer to an array of size MAX_HW_PSTATES
@@ -87,8 +86,8 @@ static int get_cof(int family, union core_pstate pstate)
  *
  * returns zero on success, -1 on failure
  */
-int decode_pstates(unsigned int cpu, unsigned int cpu_family,
-		   int boost_states, unsigned long *pstates, int *no)
+int decode_pstates(unsigned int cpu, int boost_states,
+		   unsigned long *pstates, int *no)
 {
 	int i, psmax;
 	union core_pstate pstate;
@@ -115,7 +114,7 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
 		if (!pstate.pstatedef.en)
 			continue;
 
-		pstates[i] = get_cof(cpu_family, pstate);
+		pstates[i] = get_cof(pstate);
 	}
 	*no = i;
 	return 0;
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index e4dc44ced770..8a0c11c6ec63 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -127,8 +127,8 @@ extern struct pci_dev *pci_slot_func_init(struct pci_access **pacc,
 
 /* AMD HW pstate decoding **************************/
 
-extern int decode_pstates(unsigned int cpu, unsigned int cpu_family,
-			  int boost_states, unsigned long *pstates, int *no);
+extern int decode_pstates(unsigned int cpu, int boost_states,
+			  unsigned long *pstates, int *no);
 
 /* AMD HW pstate decoding **************************/
 
@@ -145,9 +145,8 @@ unsigned int cpuid_edx(unsigned int op);
 /* cpuid and cpuinfo helpers  **************************/
 /* X86 ONLY ********************************************/
 #else
-static inline int decode_pstates(unsigned int cpu, unsigned int cpu_family,
-				 int boost_states, unsigned long *pstates,
-				 int *no)
+static inline int decode_pstates(unsigned int cpu, int boost_states,
+				 unsigned long *pstates, int *no)
 { return -1; };
 
 static inline int read_msr(int cpu, unsigned int idx, unsigned long long *val)

