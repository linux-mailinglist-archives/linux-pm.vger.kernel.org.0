Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E57300A3A
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 18:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbhAVRnN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 12:43:13 -0500
Received: from mail-eopbgr750049.outbound.protection.outlook.com ([40.107.75.49]:65531
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729888AbhAVRkE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Jan 2021 12:40:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBgvDlf/HjoHMwqEPQwlkq6DV/opPfh4tNmeAvJMe+ipSL7HgKA5rhpzt2owDcs/49WP23Ui7bvNtMNDmvD7WH3547qjrfkus0KUEItdU73jRjtZOJqQoJEBhaHC0tLHmxml1NEsmoOAgRlrbvcmCluLCOZpaoCVR5Kp7Myy5yzd6O5QsXc3J3kvdeUb2y96VddRIrfcflumd6y2y7mwteTcv1vAMvpFE1WCEuIB9r3hi/F4aXMHWdR4Umv0cM3+cocKf4kIj0bOqFRmBMyzsZ933zA2iReGF7PABbi6zGuGUytkRo57LCQdrBe6IQZ9uwBdbYi0H5DdsC6L4cqVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJUoQ3StMdxRzQQX9xHGFjdmDfUqzYLE/+49817GFf4=;
 b=ZDfV9+xyt+3hCH7xeMIPbtinTxbMW/FM73cZxJYENVX1JolnwvnTdCgh2sNsODpJVxpEwEq7dpBKzfJJ7IF6h+QFAKf495Gewen7C1zuJrLoNp719zWeX5I519gBLA3+xZY9B7cy4a/oSOfdW7ursS+h69JdULHHmkYHSXGFTp80nQ0HTKzAcBIRCivlshLvz+KijzYNILv2wKkr+IVdURcwWZh9W2T1o7GBOnqz88p5SSx2js6BX/WtBSp4nIIOdg6fgqz/fh/eOP8Tt0rIVX815kR99sCsoup00q366PTXaPIiM1MRLGY7qILKejtgADc9SiClPXIHDaR2Eol7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJUoQ3StMdxRzQQX9xHGFjdmDfUqzYLE/+49817GFf4=;
 b=VQn1FFt+b6THJ4IpqAh1yQlplQ/32JFepW1pPYcej3YAXrid4crQrckTpzh0C4MolTXeAQrPkvqWEdo32RmWxxvxp/8eHqXfiBLihyxDBuVXQkTd9LvJBj5GEwyrgAI1utxx/Sx0cloeQGROnDSsN5p3CJtbGmYiCbXXmKaCu/o=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 22 Jan
 2021 17:38:54 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 17:38:54 +0000
Subject: [PATCH 3/8] cpupower: Add CPUPOWER_CAP_AMD_HW_PSTATE cpuid caps flag
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Date:   Fri, 22 Jan 2021 11:38:50 -0600
Message-ID: <161133713035.59625.1577978944767511822.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
References: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: CH2PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:610:53::38) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by CH2PR17CA0028.namprd17.prod.outlook.com (2603:10b6:610:53::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 17:38:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 52c3414e-b678-4af9-8990-08d8befc9697
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2846474D346F683175D96C5AECA09@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6NYZYvWVqxsCXKGQK6U0IKJ7/C+gARtD5SnCbPJOWsZxCSGvN4LEIPt7kyoaBlQhJTWUkBAgqx3nkgVE6dreV4OjwTI7Ukdog0nK1r5MnPhdAHFfO3rwz+O3Xo3ar37bTu6h0xZz2hVF5tJAiAYyFTL3mkC61QKQQsL64OVDtmcllAt+54qVFl6nXVpawHXqwVaLV7u4yJ6jL1ZjE88Fe58gAfyofMgRxqwp0TLUghxzJbfPMzUz7RHJRl1HifvzFP96JxYr+/lPItVf/6K+hIypp9wgUqWEKwmajmy6H+c9y0MGZQAM9tnr9CrFPfdp4OW4yJOlDE3Va+qnv+Cdg1kF2eNgZs0GWO873CSUEhG+GBkuV7nsqwLnRyoZ5EGqwfjoUJAkDFDM/YMYnPqeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(103116003)(8936002)(52116002)(86362001)(44832011)(7696005)(66946007)(66556008)(66476007)(956004)(5660300002)(316002)(83380400001)(55016002)(478600001)(186003)(16526019)(26005)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z1RRMEdVd3Y3WGxjZnl3UVRMWmwvdmI0UUZNV0lsOGdMeXdWZE1YdjdPTk40?=
 =?utf-8?B?UDNVZ2ZkTVI1WXRwU1JKUThDM2N4ZTlMeWdvdjRVaktsUHVNRFFRWGY4OXYz?=
 =?utf-8?B?eVB3OVAwbHV6L3Nyamt3S3pyb1djQ0ozTFJWMUJNNk52eDltOTZtQ1lTTERq?=
 =?utf-8?B?YUF5VVhFbjZDSUNqOFEzcUtXamlFekQxNVRpVFRYNkZGTzRVRjZzZFloZGNY?=
 =?utf-8?B?M1FwVm1mMytXUnQxUStJRFd3TGhIdmhQaVdrL0t2Y1ZMRGpnYUFEOU9DbmtS?=
 =?utf-8?B?ODFmdy9NTU5hZ0RwM0R3ZnJMemhYNkV0VlZWUmFvcnhTNFk2TjF3ZWlLZWtp?=
 =?utf-8?B?YmkwcXlaMHY5U0tZMFdLUzBnQXJqN2hZa2xiRE0zbTJrU2ZydjBnU2RtTW9K?=
 =?utf-8?B?TWZKSnJEV1FGVG01b2ZreHBSRU1Fa3VreldES3BNdm9BVXN1Tm1SWnJSZ0NY?=
 =?utf-8?B?c2g5eVZzZkkwYWhYVjJuY3NUT1ZJTGJ4TWJZM05uYmlWcHVYZkh3ZEtaM0Jh?=
 =?utf-8?B?Q08wejI3VElUZXY5enRVWWJ3aGlad1pvSFgrQXdScGNNYTc2SEpTK0VOVnZy?=
 =?utf-8?B?NWpKZnM5ZHY5ZzFudXZBVXdEem9JQ0d4QXZYVXowcHhTRXpxaGk1SjRQYVVJ?=
 =?utf-8?B?QW9Tc053YkFzOUJNcjE3YkNyQ3ZRY2kzTTJMRXpkK2w0cWJFNnpBSkJSQVFV?=
 =?utf-8?B?M0N5L3BORG5ZMHN3MXpzTmQwc3ZGZy90ZzhFc1dreFlSOVYxb1RFMC81STBT?=
 =?utf-8?B?U3dKRUM5RG5RRGpUK3pUejVPRFRLRzFmODNJS0YzYVZHVEVPSkJ3cDFqaWRs?=
 =?utf-8?B?a2I4SzdrbFduZmZuMWw2SlNLVHhhOCtnOGJHMjBIV2l3bG1LTURYQStRTVJ4?=
 =?utf-8?B?UXoyRXBDLzJORDZlRVVKajVoRnNaNWZhVEdLbXl2SWM2a3kxWlRCaDV1MXVQ?=
 =?utf-8?B?djlROCtmS3ZHYWQvU05xTGJUakE0eHNoRXdyNHZqUGZDTG9kcnIzdGlqMElO?=
 =?utf-8?B?WGxmeHN5aUk3ZHJOYnFtbXh3ckJaNjl5dG4xN0xGaXZkd2F4Qlp6cXd1ZjhM?=
 =?utf-8?B?TDNTdzEwSFl3cmRIL25MV1RKYy9ma3RTK3JKSVUzZkx4VXNESDZvZnFXOC9m?=
 =?utf-8?B?Z0xiektrYmNiZWFGdi9FRFIvNWYrU21ldDZzcWRKK0JlYXpUSmFwNlZCWGVO?=
 =?utf-8?B?OGJsNWtkemUwOWc2Mk9oSW9SdG1hbkV3T3MyR05nSjhjS29IdmU0KzdYSjlI?=
 =?utf-8?B?R01PMjJ2R1ZESFJOQk5RY25JN3I5dFkrK2xtbFF2U1Z6SlpIWi9CN284QkJI?=
 =?utf-8?B?Nkk1anhSdnZCZHFHRU1OcU0zcVlRSERVTlVtQXg3S0toeUhsUHlLY2x3STlH?=
 =?utf-8?B?WXJ3eGw4Wmd1R213ak01VGRxYzEvYTd3OWt1UjNIOUcvczVzNVF5ektGKzJ3?=
 =?utf-8?Q?jcOZ0L2D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c3414e-b678-4af9-8990-08d8befc9697
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 17:38:54.1734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZR53DGNqD9VNOcL6aVv26MFENQCcsZifapByK/qGoAYkBvRVQEf/lAL+z2hsSFbAsy/3uhKlFY1hwQqV0o6iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a check in get_cpu_info() for the ability to read frequencies
from hardware and set the CPUPOWER_CAP_AMD_HW_PSTATE cpuid flag.
The cpuid flag is set when CPUID_80000007_EDX[7] is set,
which is all families >= 10h. The check excludes family 14h
because HW pstate reporting was not implemented on family 14h.

This is intended to reduce family checks in the main code paths.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c     |    6 +-----
 tools/power/cpupower/utils/helpers/cpuid.c   |   12 +++++++++---
 tools/power/cpupower/utils/helpers/helpers.h |    1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 34368436bbd6..496844a20fe2 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -94,11 +94,7 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
 	union core_pstate pstate;
 	unsigned long long val;
 
-	/* Only read out frequencies from HW when CPU might be boostable
-	   to keep the code as short and clean as possible.
-	   Otherwise frequencies are exported via ACPI tables.
-	*/
-	if (cpu_family < 0x10 || cpu_family == 0x14)
+	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_HW_PSTATE))
 		return -1;
 
 	if (read_msr(cpu, MSR_AMD_PSTATE_LIMIT, &val))
diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index f9a66a430b72..d577220a193b 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -128,9 +128,15 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 	/* AMD or Hygon Boost state enable/disable register */
 	if (cpu_info->vendor == X86_VENDOR_AMD ||
 	    cpu_info->vendor == X86_VENDOR_HYGON) {
-		if (ext_cpuid_level >= 0x80000007 &&
-		    (cpuid_edx(0x80000007) & (1 << 9)))
-			cpu_info->caps |= CPUPOWER_CAP_AMD_CPB;
+		if (ext_cpuid_level >= 0x80000007) {
+			if (cpuid_edx(0x80000007) & (1 << 9))
+				cpu_info->caps |= CPUPOWER_CAP_AMD_CPB;
+
+			if ((cpuid_edx(0x80000007) & (1 << 7)) &&
+			    cpu_info->family != 0x14)
+				/* HW pstate was not implemented in family 0x14 */
+				cpu_info->caps |= CPUPOWER_CAP_AMD_HW_PSTATE;
+		}
 
 		if (ext_cpuid_level >= 0x80000008 &&
 		    cpuid_ebx(0x80000008) & (1 << 4))
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index a84f85a9dbd2..5f61eefff5b2 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -70,6 +70,7 @@ enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, X86_VENDOR_INTEL,
 #define CPUPOWER_CAP_IS_SNB		0x00000020
 #define CPUPOWER_CAP_INTEL_IDA		0x00000040
 #define CPUPOWER_CAP_AMD_RDPRU		0x00000080
+#define CPUPOWER_CAP_AMD_HW_PSTATE	0x00000100
 
 #define CPUPOWER_AMD_CPBDIS		0x02000000
 

