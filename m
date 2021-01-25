Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E76302913
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 18:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbhAYRhz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 12:37:55 -0500
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:64288
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731165AbhAYRhb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Jan 2021 12:37:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQFlFlxWMIRWp9E60xmfUaIOQtDmoQQcOgvcMpSdWu4jWtApBI1AKa3GPWmMz6qxLgD8WgkSEGtINBxO+iqQVKWdV+keezl99nIv6spBkslNaxR08lZ9MLxoakwz07wyhK+I/JHvPVGYedJGlgTw7RiAe4u4eySFZaOJydJcwaxK7+u59Tu2N5TeHdKdf5gb6OqG7DJiVoyqybqLWLLfH+m+As6Zwt2Q1cppEJGU+v1R7GY44BRjxuLTu1lGbDFr1iqRda0ROpqurdV9o4hqWHDAuZ0H294WBw4hTwxkY6cydKQu3AMT6MD2zBsf6zV/DD7T8qxD1I0rTxbR45f1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNDm1aRoQ3tc9/79od1t+dZqam/WZcpmnoz3H8TSuR4=;
 b=i5QWLEqnfnSJhz4T+K5NGfeXlyRjegkeQZPClJ2YQn2ZSy/OnYnLG6KRft/ZyWP124+2xkK10AN7eyufG6svUAlWfBorlcgqD9wEFT6yrkIVEnmtLMt+s/r4aN2A4Do3vJzZUF6NgERRrgUK+sl3j3WpvVi3HhoW3xgo2KQLuTQnHGawejTsVH67EEc5P5hYJjanChvCtAzh8/cSl4VwOTHzgntqs4NxRmh23GxTi+YWZZYf8bLIsy29EyMn9HlTkG9gMcrXmVvFo8LjyOEAkDNOPWSH5oQZxO5oM+Eh28GTPjYhFW1fst6F/+kFQu2EIsqn13z/0qoIkpEqtm26Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNDm1aRoQ3tc9/79od1t+dZqam/WZcpmnoz3H8TSuR4=;
 b=AE+tmfxbugAPWlFPBevCgg30PK2+GTFaNcjl7534WnB3Ro6RsPkVI2syjG+tOiJTfSdm+UxxBjxtuvi5ccMvf0SU3vlBFLO72aimk8RUaFKP3iSH4m0rREBbnk3sj4PJtj5PWIBrQ3DOI8QrsTOQrnl5w83YbrPjg26v0UotHZ4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN1PR12MB2576.namprd12.prod.outlook.com (2603:10b6:802:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Mon, 25 Jan
 2021 17:36:20 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 17:36:20 +0000
Subject: [PATCH v2 8/8] cpupower: Add cpuid cap flag for MSR_AMD_HWCR support
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, joao.m.martins@oracle.com,
        konrad.wilk@oracle.com
Date:   Mon, 25 Jan 2021 11:36:23 -0600
Message-ID: <161159618336.68367.17545859893619697961.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
References: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:805:66::27) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by SN6PR08CA0014.namprd08.prod.outlook.com (2603:10b6:805:66::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Mon, 25 Jan 2021 17:36:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7c64a63-8166-4bfb-2711-08d8c157ba5a
X-MS-TrafficTypeDiagnostic: SN1PR12MB2576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25765AA5DBC2090AE438D644ECBD9@SN1PR12MB2576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZSgtZxUIG78YBT3ho+l69I+/VILYcbzXqV/tdrlCEUY+fgUsFxwhJakPfgLYDsE5A/m0pWP4uJdMkIVQ+z4xYnCLLwSPBJosgHRbzwRfoAYdrotF+1BsKsXnEyvuLlIdhP1tLMtz96E+GJNimO8vmc7gahuWCHlloh3ZcPzK96076fJl4llwYD4MVrr7C3TsW2+wXHh89HGlhfGImHUBh+AqTPv57KSxa7c/8VcW1dyxTx8Yss8hsODrzYxe6K7H8fuxOxOEVJ0Elnl8BpipxtJ9cXkV9pyg+S81HX1ctwhEUQpAaW9Cy4YbwNCItXAAoje7+XYC9yYKADvvOuL4RBChl2f1er/GYVT1iKWOrNkA/lCHfxJlXmaz7PhgLsTpBv9JP56rs3f2ebRHMKiNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(66476007)(66946007)(66556008)(5660300002)(7696005)(52116002)(316002)(8676002)(956004)(4326008)(83380400001)(44832011)(2906002)(86362001)(8936002)(478600001)(26005)(186003)(16526019)(55016002)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?empoMFVGZ0Q5TXhTQUVjU245R3pmbXdtbU9ralZFWjBpTEVEckpHMzRVZjFK?=
 =?utf-8?B?Y2ZMelMybW9WM3FhbjBvOE1jQ1NUb0ZCUkxBcklzaU5GbWM2SVAzRkZWVkE0?=
 =?utf-8?B?U0ZSeVMvbko3WVJhNGZPdHRrU21CMGFtVDU2eEtNalpTSzgzblZPQi9rK3d2?=
 =?utf-8?B?RGJ1OGNmYkhtL2tHcUlaTkYvdklVWnRTaVp0L2FyNjRKb2ZhYXJzbzNxNkhp?=
 =?utf-8?B?Z0lJOXQxU0tVV3IybDhqRUVRaU83VWw3RnEwdWNFVHdZWVVTNDF0UnRJQ2kx?=
 =?utf-8?B?Ykp0Qzl6NmE0Q1JOVG9QT2o1SW92YWFaM25sTE8zcFNDVkFzSUdiYU1tVDN2?=
 =?utf-8?B?TmhGWFZiQ01ML1RjNmk4ZmVYOFg3bmlnVU14YlFhTnJ2RmR1NnBOcG1KOHNM?=
 =?utf-8?B?eHVaMVlWcmVVUlBpNDNzdVZQbXhmZmNGQXNvR293c0RZL2tWbW5yZnZXeTVt?=
 =?utf-8?B?MEhxSGhSWXFPMHFQdlM5aUFzci8zaEdXMTBZMjhtOU1iMXUweWoyTFI4eWx4?=
 =?utf-8?B?RzF3eFg3SitESS8vcDFhV3FRMlZOWnA1aGVLTWQxcm5obEVlSlR2dVVVb3kz?=
 =?utf-8?B?UlF6OFNiZkNkaVUvTi9KLzVaSkVybnJVeXdqVEZDc1lIaUFJR0MrZEtmOXli?=
 =?utf-8?B?eHVZbVJiNjdJbGU1eDROSUNmSitWTjdXUU1jVFFnWSs1dEc0VFdhVld0WGZH?=
 =?utf-8?B?aHd6TjBoWUdlWUtnanlvMnVBUTVqQ1h3VndRMC9IWk8xdUM1ZVY4Znlrd280?=
 =?utf-8?B?amhaV1pZTms2MkEveDFjZUk5SkdMdDgwbkxaSDRsVzdCNU9ZbTFaUXdyT3lB?=
 =?utf-8?B?ZWdCWUxRSmdIbUVwYytWMlY3dkx1a2RCZWllMGtISVhxN0ZEdjQwVzUwaHAz?=
 =?utf-8?B?OHBkQ2VuaDB6Qm1sekZyVUhMd0N1S3dKNVI1bTF0c2hmNkVtdVdnMXBZRkpI?=
 =?utf-8?B?MkpKWmpTdERlZlczUXlpdk1za014SjZMOVlYN0FHU01ubW1ZQkppVm9vQU5P?=
 =?utf-8?B?L3NjbHlJSE1qSmYyQmt0WVZiOXRTKzBvSHVqYXBMQ3VtZm5Tc1BhV1p4NWFo?=
 =?utf-8?B?VHlPTllhdXQyZk9jN3crTXJ3dkhyU0l1U0JIWE8reTlkaUZnYUJuUmZ3aHoz?=
 =?utf-8?B?OGdUTkJneW5LVmFwZGdVS1g5MlE4YzBSdnBublJ3N3dkVWI0Z1JDVk1jSDZp?=
 =?utf-8?B?ZXovSXN2b0Q4dFRITXJjSjJPbDJMdjVFc3dXNmgrenp3WWNZM1VrSm15L2V6?=
 =?utf-8?B?SnpWanlIZ1NKa05WM0JtM3NUVVFUNjBKakF2N3lNYis1QVJUaFRvbzdYTDhX?=
 =?utf-8?B?SU93QkRrQitpTVllUnZHUnF0cFpWdUdzdnBINkJlSTNrbE1jb2xjUFlDYzQx?=
 =?utf-8?B?b0RWdmp4NnBUVEtLdituczUwNm5KVzB4cmVkUFlEOS8vdTF3bzNvQW9OVGRt?=
 =?utf-8?Q?/ujVwnxb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c64a63-8166-4bfb-2711-08d8c157ba5a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 17:36:20.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4y7yHrb/0kzoVVSJsH8HaVHgbZK6s/Sd1tLDvzKbJG1T1RatT5+tMiQEtLqcMWCmnmoNAmBQvf4F3JHbwmnBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2576
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove the family check for accessing the MSR_AMD_HWCR MSR and replace
it with a cpupower cap flag.

This update also allows for the removal of the local cpupower_cpu_info
variable in cpufreq_has_boost_support() since we no longer need it to
check the family.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 tools/power/cpupower/utils/helpers/cpuid.c   |    6 +++++-
 tools/power/cpupower/utils/helpers/helpers.h |    1 +
 tools/power/cpupower/utils/helpers/misc.c    |    7 +------
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index db2e88ceb67b..72eb43593180 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -129,9 +129,13 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 	if (cpu_info->vendor == X86_VENDOR_AMD ||
 	    cpu_info->vendor == X86_VENDOR_HYGON) {
 		if (ext_cpuid_level >= 0x80000007) {
-			if (cpuid_edx(0x80000007) & (1 << 9))
+			if (cpuid_edx(0x80000007) & (1 << 9)) {
 				cpu_info->caps |= CPUPOWER_CAP_AMD_CPB;
 
+				if (cpu_info->family >= 0x17)
+					cpu_info->caps |= CPUPOWER_CAP_AMD_CPB_MSR;
+			}
+
 			if ((cpuid_edx(0x80000007) & (1 << 7)) &&
 			    cpu_info->family != 0x14) {
 				/* HW pstate was not implemented in family 0x14 */
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 8a0c11c6ec63..33ffacee7fcb 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -72,6 +72,7 @@ enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, X86_VENDOR_INTEL,
 #define CPUPOWER_CAP_AMD_RDPRU		0x00000080
 #define CPUPOWER_CAP_AMD_HW_PSTATE	0x00000100
 #define CPUPOWER_CAP_AMD_PSTATEDEF	0x00000200
+#define CPUPOWER_CAP_AMD_CPB_MSR	0x00000400
 
 #define CPUPOWER_AMD_CPBDIS		0x02000000
 
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index f9bcce9c72d5..fc6e34511721 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -16,16 +16,11 @@
 int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 			int *states)
 {
-	struct cpupower_cpu_info cpu_info;
 	int ret;
 	unsigned long long val;
 
 	*support = *active = *states = 0;
 
-	ret = get_cpu_info(&cpu_info);
-	if (ret)
-		return ret;
-
 	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB) {
 		*support = 1;
 
@@ -34,7 +29,7 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 		 * has Hardware determined variable increments instead.
 		 */
 
-		if (cpu_info.family == 0x17 || cpu_info.family == 0x18) {
+		if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
 			if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
 				if (!(val & CPUPOWER_AMD_CPBDIS))
 					*active = 1;

