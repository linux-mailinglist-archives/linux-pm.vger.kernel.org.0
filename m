Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB82302919
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbhAYRiY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 12:38:24 -0500
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com ([40.107.236.56]:9184
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731062AbhAYRiC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Jan 2021 12:38:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwDgP4ttdc1YF8xqouccZRd1G8RmNTJ/jBCh/k4mVnz7WtyqCobo4JeySmu52IXBcfdYhynXdcP0R4gvjp/P7P7zJrToKKb1WxVoqP4VT+81M4KP9RZvbvj0CQFPfh4HAVGnyjL3Us3Hmc2iJIEDQY4rcMhyp8GyU1V/LTIra4AQ7sfgUurnItFIFYyBWn2Sw1OTEUKqTYSPdxAF4Cb3cWxNlZluj05dwsokrRUzh8GlqrHGDQZEux5lSF5glO/ZsUDoEhgrzh39Rv5i7yxc3NXXC7ANhbbyHbiJrMphZCEqP6b3mdC+QEmX3Mm2F7WHYkK/ZDwqx91K1EPTde+g3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWHDiV8j8OmwLOw/CF0KVffpbO2qgqqJDz1z/1TqlAo=;
 b=CM6TESDvh4tVIF4YEc6jeV5xjpke627N0Fda1GkrhD4NRIRQPtB9FFGykylkQAHUMLaODMM25f5FMZjajupyPgIhjAYoEOC0AkvBAjd9816PfX+eYn7/8HTiN82v2vYsboO+uPMsRfbcctWFIpa8Q5KpfXUHs9gaE7DMfYfvl2rOkLBENC2Kw3DWAU9YekQsy6qqYHSoyP95J8kmPsAkJOxdflCIFph51L4o0hUh73TqVUZnffJGHGRPIvBPMU8tnIhjssMmlLJP1kC5B6Cs5Blu5cJVG1tVc7WASH86PSdmB6OQ4/Fge2NZghFDPCdmBepK6+GRTgEkkoxoiqc3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWHDiV8j8OmwLOw/CF0KVffpbO2qgqqJDz1z/1TqlAo=;
 b=G493KOqh/vMRClxsxHBMLPCdHFcdoUvA0tEg0Q06XloDNPJeYzlARlbaogNRETa3D5/Vc7pnFdAOHEoKc2vkhFrSgQY2PxH4NPI5JrHK424mYUNKNuqI3IelDdfVmXs2VzSy6SKi69cJKuIwe9NJ5D90RDZUM2F/MTXwNnYYNPI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2765.namprd12.prod.outlook.com (2603:10b6:805:77::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Mon, 25 Jan
 2021 17:35:14 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 17:35:14 +0000
Subject: [PATCH v2 5/8] cpupower: Update family checks when decoding HW
 pstates
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, joao.m.martins@oracle.com,
        konrad.wilk@oracle.com
Date:   Mon, 25 Jan 2021 11:35:17 -0600
Message-ID: <161159611702.68367.3845483997295905170.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
References: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:805:66::32) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by SN6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:805:66::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Mon, 25 Jan 2021 17:35:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0ab65ba-b309-4cf9-d911-08d8c15792ba
X-MS-TrafficTypeDiagnostic: SN6PR12MB2765:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27650AB64B5EC63CC8B2EDA1ECBD9@SN6PR12MB2765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9LlNbzZp65hTlar+Nqb/cLWds+cuApVkPLhDMak4euuQHbM9Xlu/XzjJ4PReSbJBa1ZkjSgAyWvRUnKsLx8/5fai8IYXwWYJjFfOGIXxPe1fo3r6LgUTKhuOFhtGkx1o31aK7+vfRoWMm3dF5U2TJIeda1MWDgoYv8wcjiPWo+oAsIXzIZvMCDbmseU/JSrU571UGcFKajReXEwXDysi6QY9g1BZrlULNxkfshsvIAOdKhPUknwpAfHyjG28Pa/yGXpfFfTpXi4jiUcSyEqoulRhggvx+qW6NnW0V+8kZsww+KUT+/t0gO8N1a8N9w27fIIOeE6/6yeRlYnDxhWwvQ++XrhGagpWiIAqHpuhcQ08yOl2oF/6c9UvVjoz+DBd3ZKDD+MgOmgVUWs4NALG7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(316002)(186003)(26005)(103116003)(2906002)(16526019)(8676002)(44832011)(52116002)(7696005)(956004)(8936002)(83380400001)(55016002)(86362001)(4326008)(478600001)(5660300002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QVIrQnJXay9qNU9teUtrRUowT0U2MkFEOXRaeUxwWVRxZU1YNEFSUlpmZVU1?=
 =?utf-8?B?TlJqUXNzamN0ZWFZU1pMSEtwZ1pJc0VQQ1FISjRRbm9kOTAvSW5LNm5EK0xS?=
 =?utf-8?B?cERvUksrTzVGUkJ4YldFbzNJK2wwUDdLZzN3L1YvVXFqTWVaeEZuTE9sbWxu?=
 =?utf-8?B?UDBqejJPZHdFVE9QOG5UM1QyRTJDU2lneDMwR2dTNkNibFVEcEdWdTlZZVh5?=
 =?utf-8?B?RnJMVytycVdpb2NRNC9TSW41WjVuemJCelJvOFFWQlBaRWpJSzhycWZPR2U5?=
 =?utf-8?B?RWQxeGFPYU84OVRFYzRRVkk1bzFBL1B0Z0VXcmt6QkM4ejlJQjYzUkxlK0pB?=
 =?utf-8?B?N3dxUEVPWWJ3TXJRL0Y0a2k5S1hQQzdRVzdOa1RPZFMyc01xWm0zRTg5WVJk?=
 =?utf-8?B?NHJIR1VKTzkyY3owSFJoS2Z6aDFYSnRiZTIzV1kycks2cENvd0NLK3hZa0pu?=
 =?utf-8?B?VnFyWUtHbDZoZVNpL3JWa2h5a20wdEdsdUxodTFZVExvWHNOdEVoc21vOUNz?=
 =?utf-8?B?L0QvNnBQUTh2cWtDVEtHTmZoL3k1bEpLaHBQNkNZaEkyTzJuZlQraWdXV1B3?=
 =?utf-8?B?MWRJOW1oTXlwZy9wbUJTZ1BYNUZlcDdwWUlOK1pTRkR2SXFtZTg2MWl0eXVQ?=
 =?utf-8?B?dU9EdUhSQW5nTUVVY25zdFZDZjJsV2VtdUVmT2VpUlE3d1V5eEY2WDlBYUhQ?=
 =?utf-8?B?WXZCMG5ZSFVWMy9KMmFNbGMxZFJkczlnSTVSbzU2ZDQyTTJUYXVCbDIwUG14?=
 =?utf-8?B?RUNUZ21uWTdoU1lDcExQbW80bHc4SzlkV3FJM1BPa1djV1FqclQyLzh6WjVX?=
 =?utf-8?B?TnRWMy9vZ0VtTzdJRXArT2VaODJieTEzbzUxTVB3eDNsQWdlbS9FazZYS1dh?=
 =?utf-8?B?RFJuK2lORUgybVA3aUs1U2NQTmZuMmhsNWEwYkt5ZzJhUFBFN0g1cExCc0ZL?=
 =?utf-8?B?NDhXRVd1ODVsV3haODNST3ozTmlpMzFiQUhaa2NFWUw5KzllOEozWk5QYmll?=
 =?utf-8?B?NEU5bTJaOVppSDRheENzNDhVY3BVVWNCelAvVStOQUU2bnB4Yy93cjRyb3Ft?=
 =?utf-8?B?V2dTdXNvL3V4ZUVGdlMyMEF6SlFMU1JkdDJVeWpYaTkwcERhMkVUb0RXRHBa?=
 =?utf-8?B?YWpoYWdJZGt3Q3A4OTd2bnk5S2dUUXl3VE1MMW1JeTd1UTJIWHhaQVVpMHd0?=
 =?utf-8?B?UE1ZbzdHNFp4ZGJNaHJmSTUzK3dkOFdCYTBTdWZjbkV1R1l4WVNNdExBTEZz?=
 =?utf-8?B?eFBtQW42L0w1UmFnM05QTnhUNjZkRkNBSVd2dEh1UTloNUhuNkRMZGhuZ0xa?=
 =?utf-8?B?eXpVOEYya2ZBanJta1pLZkMrL0ZBRUVmKzhqVll1d0JOYXhFRWZIeXFTcVg2?=
 =?utf-8?B?dndvcE5taDFFTTdIRk0zZU5CU0k4WEljOUpINDFPaTdnSWJYbCt2L3IzT0pR?=
 =?utf-8?Q?uanSQ0yP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ab65ba-b309-4cf9-d911-08d8c15792ba
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 17:35:14.2318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSlUjDA6rL+ZJSTmELTUU3qlF5iAH/xZpGvpGjq+wfSDQtUIThByJrXgBQuzP+SphahPqLCJ+zyMBG13rb0e7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2765
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
index fc2ac1e6bfb2..b4731daa6820 100644
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
 

