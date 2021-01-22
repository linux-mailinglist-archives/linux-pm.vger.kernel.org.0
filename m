Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D99300A41
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 18:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbhAVRuj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 12:50:39 -0500
Received: from mail-eopbgr750051.outbound.protection.outlook.com ([40.107.75.51]:45732
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729194AbhAVRmJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Jan 2021 12:42:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IR+zsExp6jkUgZl5rkHEB0ofmBjvLQyfmvm7Hz2toR0LuAIXNozH3RcCmnJ84XSSv2/afVXIutwjbXuHx2oBxbZqn+l3qCP9lizP0eiDC8z/FPrE8gFkJd8NIXP/GDtjjc/xA9zyAG9vnjugCWDkkbaA1rjNqLad87MaQlomqmzsf+ygNCRMH62M1164GrwGVOOf8+vVeeOwEfw6FrGCvLRy2e/APPYP7x+grJJDSnCzdzmyt2nbqdJ2AlcyhDEWeMR22zHCNXzUDUCuLB4g6PilNNWpCaGibJwC6h7Go3ChAfnEYF+jPq8hWj1wjjyqvXJN3Rkx9w2AWgx3evbxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNDm1aRoQ3tc9/79od1t+dZqam/WZcpmnoz3H8TSuR4=;
 b=QzhisZeORRUzumR41Ggrz7jMp1lIGReyCUpjY93ptOsVSfUjrhXQ3cqy8bIzacsD+I6kMfycO69kEyMWSgsu+5lW8DXHZ+l3Hib+gP/1fBP46jEonFseI6++JxXv9YEktBXfS+2rBjh5hjPV0KncpR9u8M6N9dReEpHZBPIdGUow+DBKocpknOydW1t8VVo1PaWjlQWEtZoY0so8oKmDOEabdvdoGrMac+Sg8iKlTgnuedSY0JeC/WzeJScE/7dxHYN7E1k3WBqslj0Cx4ocGDvAIN4fE9Aefx+cLgfBWaKmSIz00+Jl5xWZowOzv2sgWpL77W3JOHSJfZ3C1/1vUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNDm1aRoQ3tc9/79od1t+dZqam/WZcpmnoz3H8TSuR4=;
 b=jKPPEVdSrsYooL6c3qvbLwc+6HYGo/8TrSopnroQCj8Y6pdHUhgwga16eXspsjUzSWMDXqyg9LtHtJQeAGbCJGZpxbG6X3KiTQvP/Ey4AK2/7wAbNV5maJ7qrjrSWbreol/KOx72xn4YWSpBrQLm5NvBO9XsjrwuXevHv0R1JXQ=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 22 Jan
 2021 17:39:31 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 17:39:31 +0000
Subject: [PATCH 8/8] cpupower: Add cpuid cap flag for MSR_AMD_HWCR support
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Date:   Fri, 22 Jan 2021 11:39:29 -0600
Message-ID: <161133716957.59625.16797245497945634973.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
References: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: CH2PR14CA0058.namprd14.prod.outlook.com
 (2603:10b6:610:56::38) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by CH2PR14CA0058.namprd14.prod.outlook.com (2603:10b6:610:56::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14 via Frontend Transport; Fri, 22 Jan 2021 17:39:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae93474f-6c2b-4dec-5631-08d8befcacfe
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2846771DC32306FF616CC8C1ECA09@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7eRN+RiYiKNydR72oTccXIKJ2B9Lv+AcQ1cLNG+EolqfCtSujSntq5APybzHBuAxhBCgjvFQkfhCqQJilYBzaSlTHeFZg+BWixVE9iXUNAK4aRbwuf1bv1oiuPudc+cIl68N+0GlnJAn+2FBgiqW8ELBeXbWaotqrOqPtQKzZj7G4n/0NA1Nn6h1kyCnGxQQj5IZQevtc/hyayFHps/QJlL+V593LrWBwjvyshVrdRd4W+n7e1+GS9W1OXn2ioQ7PAhkJYpsUVFJb9GqsXIICPoJ0qgXYLZTyaaHWf1d5u/rBmRTakXzftz2YNNZRi/M2CnegwSPTb5NaMVvhmq0aKROlHRAD9tPNFPZeWVEgM92xG84oNMt9mEB0nMgTZMFuNh4r00Uv9MDFae1cw3Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(103116003)(8936002)(52116002)(86362001)(44832011)(7696005)(66946007)(66556008)(66476007)(956004)(5660300002)(316002)(83380400001)(55016002)(478600001)(186003)(16526019)(26005)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L29ZT3FoQ1BTTDJCTDR6Tkprb2o2bU1PMXlsWW9PTnBVRWpQZ1JrazhrdDBv?=
 =?utf-8?B?aVFuNVVmL3g3dm96NHozR2o5S2Q2NGpOaXpOdENtb1dsaFlubVljRlMyc0tx?=
 =?utf-8?B?M1RYRUJ1Z0hBemVLWGMyWjZMdFRpenVGeGtIamxFb2puYUNRLzh6TUFZQURj?=
 =?utf-8?B?cGd4YzlaNFpBbzVOZmY2OWM3dXU4ZktZY1MvTDgwZWpBb01ZUkdqRk5vdXFJ?=
 =?utf-8?B?MElRb0lQUi9pQXVIU1JneGpra2sycjR1Q3R4NE0rVVVFQ0M3QnlqbittbXgv?=
 =?utf-8?B?VU1XWmErNXZxdEhnQ2NXc0RZWHNyZWk2SmtDNWk0bUVhczFtYnZPUGxjWTFZ?=
 =?utf-8?B?elRVY2R4aVRrcUo3NHIwMXcyZEdVb0FWQU5xbGxpRUo2dno0YzRiZ2o0cW9J?=
 =?utf-8?B?VTV5VHBnUW9WUDkvRmV0clhpRkVabmxRc21mU2pNc3IrYWtxUCt5OENJUksz?=
 =?utf-8?B?blF5aUpIbmFqcUZqQzduOFVWYklRWkx2emdkZng5OU1xMWZkZUlVSjRkRTRB?=
 =?utf-8?B?RTYvQnIxMTNsM1hSaHh4dWxWKytxWC9zWm9kbkFYOG1NbU1TbXp0cWVWZUFX?=
 =?utf-8?B?c0RVREtxbXNIa2QzM1VHSkpWMExLTmphY2xDUG94WUg1a3Z0Qkx4bEJVY0Fy?=
 =?utf-8?B?VFZDQ1dDMGRpMkxtYm55QStKUDNsUW9hZmlXTFRCZGRoUEYzNnpUbGJKbEhk?=
 =?utf-8?B?QWlzUEw4SGFhMFJPYWZVUVhCdkxEWjR0c3hlQ3NhTVpKNHVsRHdkNGZkS25v?=
 =?utf-8?B?dmZtSWpsblJIckxySWlPNjhjNllmR3RBNGdlZzh1UGRQTFV0SnhFVG9NVmw5?=
 =?utf-8?B?R0RVWXBLT2ZVT2lubklVUjIyRGZvbmNWV3cwbStkQXcvbXMxbjJwWGJZR2FS?=
 =?utf-8?B?M1B5V3F5THpzMitIN0FrNmNQTkhQR2oxMXVWTnpWVHJUcEdhY09HcnBEOGlj?=
 =?utf-8?B?cTh3c0p3NEtwdmtRdnZUUzBwdVNwVGxSOWlpblVKdTcrc2xuUGkvZlRPTm5D?=
 =?utf-8?B?SVhNeFBXd1NvNTZSMk9PbDBxbHJGK0hzWitnLzJxWkc3L2dQYWhYZkVPVXNx?=
 =?utf-8?B?WW1PSDRvVzB5VHd6LzdicVpOeEI3dEF0WHBOV1NONUpnbCs1dDAxa05GREV1?=
 =?utf-8?B?VzZId0dBSU51M3RCU1plTER4eHR2L0UvYnF3aTlIcXZUR1oxOXhraEF6UVFZ?=
 =?utf-8?B?dUVDNlIvWWliRElpRGdBOEVUd1V1djJsZWh3dXN3eDBxWTlTOW9iNzVjK2xt?=
 =?utf-8?B?bXdLWExsTFd6eG1jWW11M21WVEZNSmc4WDdmL1dsbTBZZlNFMS9ScVNCc2Fj?=
 =?utf-8?B?WHRrSUJPcmxYMUphbVpIWXl4UW4zODBLZlp5WVJwYTVJS0lYQTBrdHV4RmF6?=
 =?utf-8?B?N1FnRGdwejFncWhSUS9UamJXVWNYR05acXk2NlNQUXRIVk9wWGFlbXQ5MzNm?=
 =?utf-8?Q?sjv+dVlb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae93474f-6c2b-4dec-5631-08d8befcacfe
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 17:39:31.7469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZAIBtJwMUt9s4UIcDNBcVtonDezZsokaNTSRYM3YkIYw6fMeOkF76dzAzmpi0d5KZC0O0Sq5vPGs7BKFosrEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
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

