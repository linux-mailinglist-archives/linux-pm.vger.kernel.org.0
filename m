Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6006C300A13
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 18:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbhAVRnX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 12:43:23 -0500
Received: from mail-eopbgr750049.outbound.protection.outlook.com ([40.107.75.49]:65531
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729994AbhAVRkn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Jan 2021 12:40:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Trz46bQM3bIREqEhvRNCqV1Peq7xGuP5Zt9PqfjzDH9UPWrp94GMi8GO/JX8lZdzAr+NfMuSgvy9N7L4W0wvnLuUf3OUEc1jsv9oA2GAuA/lrHw3roLBASOoDbeBjaTNbcO12l91r+lvIteAxUboGiLHZvETCLafK+ZcJcBMzJCXqLLsYM/M6dBnBT3sniT9hM9lxRrgtoOFm0bU/EsCd9EdDNt7FxQ2dIUz9DUxiyvBB0C3PXNuyvD9n6vXsrYRAHtmOFlSWarc2KfAog06q7NataV4/Pale7x43mUlDfgx2qjvyLOETkRXW/3y1rGcsjt0y9Mgx7efPmM2kUR+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35NZcGzNKLvl3GTTFopu6Pul61xhg7f8apjvx0INRNM=;
 b=juh0M3BPwSqEhIk1W/I/c/YEcoOR88Lpyo5O7co3ba6BxkvilZeI2OZ1BnIDYuvH0NztH2AJbU3q3K3GpsjPtjbN3L99i1X9/+GkktZ0OLXAaBjaexnn33F7TBl3lhBIu2Jy7bkha9Y4uDon8lLnqXXXsC4qvASYEE0Uxa/AFza3L8wEYVLTOITVZzW8arwh1gsVSHOPf82XIvJlo0Doz10CtR5mMRfYItjanmc//8OSuzWODHzwkgMc5vo9pmYv7aY47ndqxqhE+RbW0T1XtyRGyscAQbx9x38M9rvoMYJkNRf4adqbH9g7SdUhpT2zMduH00VXLirnEEftahxi1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35NZcGzNKLvl3GTTFopu6Pul61xhg7f8apjvx0INRNM=;
 b=WzU5ydpLqrB0oyVQfZwpA+fEzJW/igodNvWgpjFrw6gU2ut3RXhCXcWeR+SuGyq1/9A/OHfpZ++9vvifFYOvnJvDC9H2d7e9XVHEUzah+WLoJp6QXPVY2f26KEeVEMJeqWq/8sNWJZdTr4Fhgo5R1PcspXGI1weBmOiyH4Hftek=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 22 Jan
 2021 17:39:09 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 17:39:09 +0000
Subject: [PATCH 5/8] cpupower: Update family checks when decoding HW pstates
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Date:   Fri, 22 Jan 2021 11:39:07 -0600
Message-ID: <161133714713.59625.6299790565871909582.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
References: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: CH2PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:610:53::19) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by CH2PR17CA0009.namprd17.prod.outlook.com (2603:10b6:610:53::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 17:39:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14954904-da75-454b-25b4-08d8befc9f9f
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28468C6AD02688D6C80254A9ECA09@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0MEg+OVOIF+tUWTe/scu6hBeDz6amIqR3ovG8sZkH9XcVBBYwCKQFVzPl7ujFwXS7muF88ZGdSfLrYX8PrFVWPZlayUt7RqlO1KqPh+xF02YQ0FhECind9WRmaIkuMW2gVOyYhqntI9Skzfm+2UOs5QYSNztI4xWfR3uNBMogL6LmmSsgjhWWiGH34bydQY9Q/ofYsjPnIb4UyJYnLCd0PLRt8bjGLICAKj8xtBmMoGyJei2J2S5bZObCnKdPOJ0vzMpd+kLIU5hkylSdVC4X+qG9vug7CMsUY8WOKQpWubO9p0CAQG88GBYyuLuwkI5UfP2XBiayix8mn/Kqd5h31nReGL+tedX2nMI+CHEsk0utrmanzKK0Rx1NUdizgJZBhHPByO6eyQ1yqFyQaKWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(103116003)(8936002)(52116002)(86362001)(44832011)(7696005)(66946007)(66556008)(66476007)(956004)(5660300002)(316002)(83380400001)(55016002)(478600001)(186003)(16526019)(26005)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S3BnWGZwMm5jMlBzR0ZocU01Z2VEUWZOMGxTUkdpMHpJdnlRUUtnTEdNaGVQ?=
 =?utf-8?B?OCt0T0xtdFh6VDZTWEx3aEhpbkk4WE5sVThmL1g1U3FQOGhPS2syQzA2Y0Fy?=
 =?utf-8?B?NGxERnRnMS9DbzB1aVlCVlQ5R1Bsak5QeSt5V0twb3VKaEZ2NzJzd0o2Z1Zp?=
 =?utf-8?B?dGVNb01QU3VjQUxXQ2hzbUNiVEJnM1MzSGxNa05UaTV3YTVJc21wdUJEWkt3?=
 =?utf-8?B?a1BKUW1GOUNzL0pzcmFTVDFwWnQwK1VPMGs1VEg2SnZKdW05a3ZNMzRsOG4v?=
 =?utf-8?B?QytUNXRBVDJ4czFCVHB4dGhwRjRCeFFWc3ZMZjFva0srSWs0T2tzVlhpK0pI?=
 =?utf-8?B?aFFsR2Z1VmRBSERvd2ZXSDZENkZWd3ZYeDUzYkVDRENNOC81VHRaaHBYUEhz?=
 =?utf-8?B?dWFOWkFlZEp2Q3lkMXBuTndWS2Z1QWpHczhvZkZacjJYY044bGE5djRFSmd6?=
 =?utf-8?B?NDBacEI3WDMzalJwS2JGeXFOUnFhUWpIYzJEVTI0M1ZDSDlBeGpmY2NmalEz?=
 =?utf-8?B?cjRJUCtzREUrazZQbThEVVZxWllYN3hoc1NGc1RZTTNFOGltcllqZ1VJVEg2?=
 =?utf-8?B?MFp6bTM3U0ZZZXdOVlFTTEVtbDZiZEQ4dkxOY01VZytHck05QUlRSUt6azNE?=
 =?utf-8?B?VUhnNWUxS3pGa09oSmU1Tk8rYytWdCtMWml6SGgzUWZWRjdud1gyVldvMm1w?=
 =?utf-8?B?ejhqV0NZQmF4bnRuU0dlbERzU3ZnaHVOVVdibG1GRldTb0tEOTZOejZZNWJQ?=
 =?utf-8?B?S3ovSnZMc1lRcG8wTXFseUxMaDJOUzNhMDdnSG96RTB4a0YzQ0pOd1E1OVdO?=
 =?utf-8?B?YjVmbXdyVVJEYytGL2t3WHA3ajNiRGRxZkRoZnhuR1RCZWh2MUpocWFIamo3?=
 =?utf-8?B?c0NoazZOaEtEaHFFRHZ0QVQ3RHVNSTlCblBLMDBCdUZTelR6SEVieTQrdXBR?=
 =?utf-8?B?YnFCRE5jUjNsS21FZ3RTUjlEUGNkUE9jNkpOb1NGTW9IcGxpcWNJSTJxZU5u?=
 =?utf-8?B?bnYrU1VaWTVxR0lHUUNWZDBuWUNxS3plR09xMkNEWk10cUdSNXdkVWRieVRi?=
 =?utf-8?B?aTFWM3RaNURiMUpOZ09QMXFNTWx4ZTkwYWxYMldyMGNRRUtzRXRiRnFNR3hl?=
 =?utf-8?B?UlpKeG9EVVhUeitqY1NtOUZmblBLcHViRnZBc1l5dlhncWZzTUxnbi9FRGRJ?=
 =?utf-8?B?SFlmWXEyNkRlcVRQbUh2c3BDMkc1d2kzd2dtcGxUWXpnc09WQ3lUUEZPMmYy?=
 =?utf-8?B?NjdXKzhLcVdsTVpNVjh0cFd1UU0zT0RNS1d5UFl4ZmtSOTd0L0VkYzJpbi8z?=
 =?utf-8?B?KzNsYnB3eXpEKzdLZ1ljc1lSbXl6bGt5ZmFuSHp3Tzl0Yk5TS1A3SUJwUTlB?=
 =?utf-8?B?cFcvUitVMzFHRlJYVFYrU1dmbnZxU3U2TG5vanoxSXV2ZTc3bXQ5cVBGcW5O?=
 =?utf-8?Q?iqUh9O//?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14954904-da75-454b-25b4-08d8befc9f9f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 17:39:09.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuDEbv5UbUbIJTZctUUGCeHIkvt65tZ2P4ZKdE+ldOMhBNzjOh1Yv0uXScnEqkI2XrT8khdMpsYa5cvcU5nMSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The family checks in get_cof() and get_did() need to use the
correct MSR format depending on the family. Add a cpupower
capability for using the pstatedef (family 17h and newer) to
control this instead of direct family checks.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c     |    8 ++++----
 tools/power/cpupower/utils/helpers/cpuid.c   |    6 +++++-
 tools/power/cpupower/utils/helpers/helpers.h |    1 +
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index bd4db2e9a8a0..519a21e92666 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -45,10 +45,10 @@ static int get_did(int family, union core_pstate pstate)
 {
 	int t;
 
-	if (family == 0x12)
-		t = pstate.val & 0xf;
-	else if (family == 0x17 || family == 0x18)
+	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATEDEF)
 		t = pstate.pstatedef.did;
+	else if (family == 0x12)
+		t = pstate.val & 0xf;
 	else
 		t = pstate.pstate.did;
 
@@ -61,7 +61,7 @@ static int get_cof(int family, union core_pstate pstate)
 	int fid, did, cof;
 
 	did = get_did(family, pstate);
-	if (family == 0x17 || family == 0x18) {
+	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATEDEF) {
 		fid = pstate.pstatedef.fid;
 		cof = 200 * fid / did;
 	} else {
diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index d577220a193b..db2e88ceb67b 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -133,9 +133,13 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 				cpu_info->caps |= CPUPOWER_CAP_AMD_CPB;
 
 			if ((cpuid_edx(0x80000007) & (1 << 7)) &&
-			    cpu_info->family != 0x14)
+			    cpu_info->family != 0x14) {
 				/* HW pstate was not implemented in family 0x14 */
 				cpu_info->caps |= CPUPOWER_CAP_AMD_HW_PSTATE;
+
+				if (cpu_info->family >= 0x17)
+					cpu_info->caps |= CPUPOWER_CAP_AMD_PSTATEDEF;
+			}
 		}
 
 		if (ext_cpuid_level >= 0x80000008 &&
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 5f61eefff5b2..e4dc44ced770 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -71,6 +71,7 @@ enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, X86_VENDOR_INTEL,
 #define CPUPOWER_CAP_INTEL_IDA		0x00000040
 #define CPUPOWER_CAP_AMD_RDPRU		0x00000080
 #define CPUPOWER_CAP_AMD_HW_PSTATE	0x00000100
+#define CPUPOWER_CAP_AMD_PSTATEDEF	0x00000200
 
 #define CPUPOWER_AMD_CPBDIS		0x02000000
 

