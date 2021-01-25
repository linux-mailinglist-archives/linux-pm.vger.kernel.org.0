Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6F530292E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 18:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbhAYRgR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 12:36:17 -0500
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:8288
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731131AbhAYRgG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Jan 2021 12:36:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOuBVLM2pE1/Wjwgz69VYK/dm/0r6XsivOhirtcQiCr775VctuUfsQrKO1tTTQi7zscxLGErgjhZjThaHTHRfK/eHxlnEMMjCHH9/+M+exMcX5MdnWsZFjrerIrwjkSDmv0JTcdXIQ4ndfvgWdfIk1JxBdmd2OIpyUKXfrKSQBqSlfPhx/NmZ0ZA9gZ0EurWU8sWrLWEDgqVY5AUCaTilg5brbFCsFmTiXFiXiMcWVnILqURtyS9h2ca/x/zlEOou74eedP4I5pfr1MmmZh4buSqilm6easnzmT/CBVVKSG1HDH/UASTyiT9Mg18YjEyW1zt/ZoY1jiGrF69IeATQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cn0bBx0QSOwdowiDo83k/VfMBKecf7j2Obn72M1zODU=;
 b=diRu0cQ3azoFneNFMil7CZCY3wshrTlJhpREUFV16U/IsomipfLQu/FPv8RuV4ybz0ghLo/l0pNPi0k2pujlOxx7sZUAeu9Drg52dlRf6bxc380Ze46SmMkMP59yQfbSw1Ap1VyJpGC+0rPsARQvvZliEMrXCu9wiMbAiA6IVPjHZPeeSB9hF9Z3jqeuJwu9HChPP+ehQ32fsbPP8bXy6Tb7CNXQiKrSOwLJptAC8mNEg6H/nUMty2okc5RYNrvPhdsrQ96IJ2vVqFTqPRaSfPQ+Qbe1Zblo+TPcgkur1nSVRriQBvMcU1aSjZ/0k3slxB586V5/UwjaOjAENyH9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cn0bBx0QSOwdowiDo83k/VfMBKecf7j2Obn72M1zODU=;
 b=L/UCdZkjS+lXjv8uQl8BLgaMBi/bP1c8eDBHypbGSBp8vev6pi4WwKJZXeqsYK302WPm1vx9YwvSzZy+FIxviqhHQbZt8s+5k4mib0yCD+RLhTd57Ti2QbuJSOSLqdHS7IYuFxd34MQfHW78E4TD107AdFGukRQXyjVo5oy8LHE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2765.namprd12.prod.outlook.com (2603:10b6:805:77::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Mon, 25 Jan
 2021 17:34:39 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 17:34:39 +0000
Subject: [PATCH v2 2/8] cpupower: Correct macro name for CPB caps flag
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, joao.m.martins@oracle.com,
        konrad.wilk@oracle.com
Date:   Mon, 25 Jan 2021 11:34:42 -0600
Message-ID: <161159608261.68367.2896652465354925993.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
References: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:805:66::35) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by SN6PR08CA0022.namprd08.prod.outlook.com (2603:10b6:805:66::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Mon, 25 Jan 2021 17:34:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b13e174-6c8e-48b6-6912-08d8c1577e24
X-MS-TrafficTypeDiagnostic: SN6PR12MB2765:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2765A866F59538C5D2A8DBFDECBD9@SN6PR12MB2765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tsSQJrDcwENMkScIv2Xr3FzNuWGehSPBBeHcH25TKbDqhkA9wNdYrjEg5o4PQ69l2UIFRBM1U/9ePWEgXemtLJd3Kqyp5kcoKh9d42gg79eOYaMe4ehzBOnAC455AI379HejbnaOM2oVWggUlIPz8Ory5IOz4RpVw3sX++R3khUADHX4xcfTLgTH3V7Gaf2Bx5EfGR4V+dhDLrudTx32oG9NvFz2AtlWHm5TtsTaS4BUy8yMHah/TY/BbM0vVTwSmkWhEAnE+JyzC4EtNxheyw/6E7GF1JPgnXsHrG5HUbgCr7Z7vSUwNLKTfPIZkpX1dDjE3ZPHqbG1uEO7ftoAonfpfRKQbrr+beVIFe8PQ9D4sqJupnfS1pFqrgYaln8V5bjNmoaVygeU0iSHjQBPkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(316002)(186003)(26005)(103116003)(2906002)(16526019)(8676002)(44832011)(52116002)(7696005)(956004)(8936002)(6666004)(83380400001)(55016002)(86362001)(4326008)(478600001)(5660300002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RS91OGQ0NE1jaHh6NG9TNGd1dE1mUEsxVE5ZcHJmVjNRQWxJSXI2Q3RUZmMv?=
 =?utf-8?B?bjdEeHVPR2YySi8ybTN3aC9lQkVRcU9aK0MyK3gxSTZjbGx5cjk2RFdVRkJW?=
 =?utf-8?B?L0lnOE93a3dXVkt6UmFFNEkvdTg4REp4N2QveTZUb3IzMitGWkFHY1ZmOGsv?=
 =?utf-8?B?Tzl0d2FxSnRPMDNsQjIrcjRoczZ6SGREQXRYa0tYYW1yR29QVTlkTGJmOEZR?=
 =?utf-8?B?bnc1N1E0TkN2Slczdi9HSTdURFpCRkhOU3BuZUdJdzBnYXlDU1ZyVjBXL1Ew?=
 =?utf-8?B?Q1VZYU5OM1NSOFhIMWdtNzlOQStERTB5SnZyTzFkUXdiTVoyeGFidTZ2U3R0?=
 =?utf-8?B?VE5wb1RYU1JycHNCSVlFa0t4dGJnM29sMEVtRWErSzNnQlNOU1lFemNmR0tN?=
 =?utf-8?B?d1MrWjBZY1BqdHROeUF3M2dwcnRrU3hTQ3ZBZ1czOW81Z0tIY1JyNDUydWhI?=
 =?utf-8?B?N2FyTXNoWS96VStTV0Qyb2J5R1RURngwdlF2R3VJWEdqQ2VmVUg5NzlPVmRB?=
 =?utf-8?B?QXNsVTRvUzk0d0NReWxINk1TbnoxdjNOaTk4VVdXVzZzYUc1NVRyVFRIODBa?=
 =?utf-8?B?aTZTbTljT3pLWElrUm1XSFU4ZjBxWU9qNzI1L2twMVI3Wi90V1h4aHlXNmZO?=
 =?utf-8?B?SVdpTVBXemFDUFJQYVZZR01DTHdNaThvN1M5WS93OXpwMTFvL25iTTJxRUt2?=
 =?utf-8?B?NHFSeGM3aDdQVlpyVDZpdzA2ZGVjTkY2ditzQW5QTXRCZVZXSFBXbklRTjRT?=
 =?utf-8?B?TVdvdmQ5a0wzVW4vczlFZ0RZMG1wWlhqWkN2NjVrNW9QR1JwRDRaYjNlY1NT?=
 =?utf-8?B?SlNVY1JubzZWa3lCbGhKc0pnZnlJK2ZRWnZZU25TaTQ4SVFKdHRLek1sbml3?=
 =?utf-8?B?dFMrSXpzRTUvSE9WbmNkUjZQSVdNalh6UXNpeWkyN1phTHF3ZUt0RHNCUnZV?=
 =?utf-8?B?L0ZPK2EwUWduYnBZUGVjTXlGT1Jkc2cyUDlqRStvNnNkbHpVckxWaDBzN3pT?=
 =?utf-8?B?TnN2LzNtQU9uNnMyMW5QbzQxWkwxcTBvQ29TTzJLNms5MzJCN0RiNWRpUzEr?=
 =?utf-8?B?TE9XUHhvbmxJMno0b3NWUzBTcFFpMzNoMWtFU0xNSDd3NGlMNmdYN1NwR2Zy?=
 =?utf-8?B?Z2tSNEJmODhPZ2tiRW1iazFqNDNuTmtlckNqY0xTVHZ4VlY4Y3kvaDN0NW1o?=
 =?utf-8?B?WC9DK2RReURZcGd5aDBCMDZ5K0orSHNid3ZnWXVGSzRLZzlrbjNxMm40QnRo?=
 =?utf-8?B?bmIrVWFQVHV4aVJRVzNMM1huMDhKdjZhY3RlTnhINVc1Y3BVcGdaRW1abzlu?=
 =?utf-8?B?VnBiaTNnMENmOFh1Z3ZQbEdWajRGbXlnZG40eC9zcFRlb3BDM2U5Ty9rRk1h?=
 =?utf-8?B?Z2YvUjM0UFNjTUlZVjNyMHZScHExNnZ3UTVkcHQ0c3pzbzJZTENDRVhOcVhK?=
 =?utf-8?Q?iZvTTy91?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b13e174-6c8e-48b6-6912-08d8c1577e24
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 17:34:39.6845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFzU78FvezwvUnoIpEf2M4oqLslsFM70KXCdtJ/fWqY39tYpiy1TkE4gdI1CU03NCEjP5/j8bN/3vrV5a1K8mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2765
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

The name is Core Performance Boost (CPB) for the cpuid flag. Correct
cpuid caps flag to use this name (instead of CBP).

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 tools/power/cpupower/utils/helpers/cpuid.c   |    2 +-
 tools/power/cpupower/utils/helpers/helpers.h |    2 +-
 tools/power/cpupower/utils/helpers/misc.c    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index 73bfafc60e9b..f9a66a430b72 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -130,7 +130,7 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 	    cpu_info->vendor == X86_VENDOR_HYGON) {
 		if (ext_cpuid_level >= 0x80000007 &&
 		    (cpuid_edx(0x80000007) & (1 << 9)))
-			cpu_info->caps |= CPUPOWER_CAP_AMD_CBP;
+			cpu_info->caps |= CPUPOWER_CAP_AMD_CPB;
 
 		if (ext_cpuid_level >= 0x80000008 &&
 		    cpuid_ebx(0x80000008) & (1 << 4))
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 0642e60a6ce1..a84f85a9dbd2 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -64,7 +64,7 @@ enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, X86_VENDOR_INTEL,
 
 #define CPUPOWER_CAP_INV_TSC		0x00000001
 #define CPUPOWER_CAP_APERF		0x00000002
-#define CPUPOWER_CAP_AMD_CBP		0x00000004
+#define CPUPOWER_CAP_AMD_CPB		0x00000004
 #define CPUPOWER_CAP_PERF_BIAS		0x00000008
 #define CPUPOWER_CAP_HAS_TURBO_RATIO	0x00000010
 #define CPUPOWER_CAP_IS_SNB		0x00000020
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 650b9a9a6584..f9bcce9c72d5 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -26,7 +26,7 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 	if (ret)
 		return ret;
 
-	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CBP) {
+	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB) {
 		*support = 1;
 
 		/* AMD Family 0x17 does not utilize PCI D18F4 like prior

