Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC39302939
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 18:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbhAYRnn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 12:43:43 -0500
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:59840
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730772AbhAYRgj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Jan 2021 12:36:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb/ChoI5shzv8Cl4e9DzepMQZ8nDtlzLLiP877cA7hDyhvHGv4qnUjI0lKi61ggTyu94FzLmsyXsWFAy1XX2he3emnKtO7VW2Dwb1VNXI51eUgYL7t47pfZQ5byELCeTBoBp+/7YiXrKroiIJfno4wqvfxCQLOwHupW67kpsNO/v6qrMEUOfoeM4+HliAMOOiN+Jbe1/csJuMyDAgOuyEl+i/3f+qm1BuSiVqjdYuxjK65ktqwuXfHlTHqSm7X+SB9RpPkuN6cKEBFrWkSHe1ERjTZfVH70dQOL9ipnFSeD0a98KkV5w0iRWumLn5NKtAb1j6M13AysEXE6jzXzjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cL6i9wKjzgDN86at3L0bVNq1WXDu2CSE5wnmq5MADU=;
 b=oSUIXajq2L1UI1nz0DQrhmSIfYJ9i/ibjmZyUNziaAG61sRMWLNh3s9ASIeqA0OkvsajVkdD4YPNAkI3kW/hSl2rCgLSvG/mljckIttEspkck/GaKk4p6CMa4d1Jo01kO2xmmQGVM35y8hXkwy8P5ktfdZdtRGzcMnlKRv3f0epy0pC9oIQsTumNH26f4f9+8T6iYrKZP0L7k2XZOYNnQF2Bx03N2BnxUNmlQd/Wznqvs6gOW15zkiVP6wK9vaPCU/iR2T4+OulidGu/4rTXyHPUtHEsWD33srGXOVIc5YCqziGC3NYxP2tNCgvxDsrhZrCi6Cvn+F/nTl2e1V3UAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cL6i9wKjzgDN86at3L0bVNq1WXDu2CSE5wnmq5MADU=;
 b=LxN6sBkdnLy0QSGNJGhSSIw69D8YBd2Lis0pLEZotgUnGr7pSkrjw31sFhZ3grZLKgA74XY0PVJM+4LzTPyHw+LepGYyIz1KEA4bS1o1PUjbpuZ0n47fk+VAamcF9eArSKAjGZ12K6IpVJp0mJ9HTzqxfe1xxYRxlKzN19USDpo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2765.namprd12.prod.outlook.com (2603:10b6:805:77::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Mon, 25 Jan
 2021 17:35:01 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 17:35:01 +0000
Subject: [PATCH v2 3/8] cpupower: Add CPUPOWER_CAP_AMD_HW_PSTATE cpuid caps
 flag
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, joao.m.martins@oracle.com,
        konrad.wilk@oracle.com
Date:   Mon, 25 Jan 2021 11:34:49 -0600
Message-ID: <161159608909.68367.2355673294254507345.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
References: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SA9PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:806:21::29) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by SA9PR13CA0024.namprd13.prod.outlook.com (2603:10b6:806:21::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.5 via Frontend Transport; Mon, 25 Jan 2021 17:35:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b98740c-72db-4864-1e7b-08d8c1578b26
X-MS-TrafficTypeDiagnostic: SN6PR12MB2765:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2765191FB02670EB2491AF15ECBD9@SN6PR12MB2765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4QYuDJ0sTlZzpLbrL1mlxe7qljytCcW8djnfutgnqdbcYgy9F0RysSRnxBYq9HkVtsiOZGZYIVOVjlKO1VtdPnGesScc84QMUf+7g/I7eDI0al1klz8HpWv8cRNkYAE3VzvsXHF41v+ab6Ha20gTQT23Ji0+9G1Nqji9oPfe3H47mKpNH2OmwJYovq8SAKAiy7p/T+qaBtkk9Fw0DsHU5dMeuiqndaywJJPbeJD3AQ+4EVtj4M2xjHEgj8/YTIRMJN18UnWDSTPYwCEZ1pEFwA6kTLSH49MjU3e3Eyf8QVxJwhsvqTsN/hlStKUpfjHdQNiA+kkhrNrKwtC5K5cB3Koe/m98Mtyx9nVPQipKKxPWfibNcdKOg5GpPTt0RkiuVAuBMh0Y418JBbx8a1inw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(316002)(186003)(26005)(103116003)(2906002)(16526019)(8676002)(44832011)(52116002)(7696005)(956004)(8936002)(6666004)(83380400001)(55016002)(86362001)(4326008)(478600001)(5660300002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NWxyMzU1TDJtUEcvb0llSXJjRGdnak1CNjBuWkU5UE1TeFc4TEN6Y3lXSks3?=
 =?utf-8?B?Vm1HSTlDMnpJK2NrYk5KWjRHcFlGWU8xVGdGdzJqckNpOVlXalh1TVlWY2tO?=
 =?utf-8?B?WWZVOTkyQlVOaHY0OUpLYmVKRk9nTkJwVlcwQzhPNXYxbGNFN0R1RzlQMSsy?=
 =?utf-8?B?dXJibktYT3JLQ0FZRFMrdWhRaG8wWDRETFJLYkNLd1ROQTlrQXZCTWFDN2Rp?=
 =?utf-8?B?dm84NmVCUmVyNGR4MjFTK0VtcFJtNzVuQ0lFZFJkMnJQR3ZPcnNJbGU4N2lt?=
 =?utf-8?B?NXoyeDBZMXhMVzJ2VFFXUXZ6UzRDUmZPMkdNSCs0VGdhcUhSdVg3N3RXTXZx?=
 =?utf-8?B?cCtlODNCNWFsZUJmOHVwSHY5MWZydVRQTFB1ZHFFbGsyNG1jV0s1NFhaVHpr?=
 =?utf-8?B?cFZJWml4TGIzSnh1RE50UU04VDVaWGNIeHZuWDRVaVJDcUFiWFk3SzN1ZmlF?=
 =?utf-8?B?TDYxdzVqMk5RdTAzdzFLVXlZL3RKbFRmOTAvTXdSc2tLbmEzVDhYbWN5RkZC?=
 =?utf-8?B?MjFQM3VMSThXTGdLNW1meWJKMlI0cnlBZ1ViRzRnMWdTWUZKeENMNGpodmdF?=
 =?utf-8?B?VWxxaTFMUUxJQi9URnk3c2R6MytMRHVPd1VWQ2Mwckc0RS9BOThkOE5rQXh3?=
 =?utf-8?B?OHV3TC9HcGZPcWRSL0I1bmFWY3pFOFdiQzQ1TFdhRWwzMzJEeUoyUTl5OEtJ?=
 =?utf-8?B?RzU0dGNLNEI1bjJ4RmVaTnZWSjk1aEUycnp5aEE0ZTNZL2lkNUs0MHIvNnJ5?=
 =?utf-8?B?Y2dRb0txSnoxSDBoeFdvb2F0eFJzdkhmVkRSbXZiaVNQcGVQSDFId0RiZDZi?=
 =?utf-8?B?QjRjVjFyaTMrZDB1aElkMm1VMVgvZno5STV2NVlWcERhTnY3UjQ3OUdXTlR3?=
 =?utf-8?B?YkJGaFF3WTZkdHZxbE16QzVWVWp5cjl3RWNqekFwVnhtM3VFdGtZeUxmOVlR?=
 =?utf-8?B?U3JuaGczbXUzOXJZTnY2WnBRQ0QwWXExOUFOYkR2bG4vZ0d0OWlaaWUzSC83?=
 =?utf-8?B?ajFmVTdDWFdxWXM0cFIxUGRrRk4vUy85NktKdTQyRDdodGRGY0YzWmJkQWZq?=
 =?utf-8?B?LzB2Ni8rMElFQ2k1b2VMaUMyQmg2WW14V1JXM2ZESlI0a3hrMlF4cHlRaTJS?=
 =?utf-8?B?dWtIa1ZlYVZjMUZGYzNTZDlGWTN6NjBhTEU0ejI4Umg4c1VLT1J5Nk9XTFIy?=
 =?utf-8?B?Szd2bTQzaUcxUVoxN2N6UDlYZ2tsTG11cmZldUoyTXZ1MFhWYlBoaGU0ZGRs?=
 =?utf-8?B?V3owWXhVYVhtWWN6R2Iyb2RsenpBcHJ4R2RpZkVtbm9aRVkvOFFnMVI5TU5V?=
 =?utf-8?B?YXVZaG51WVIzWnFZRmRoMDF6eDBreU93OTg4dU85Z01BSGdqSXZnK3ZGU2o2?=
 =?utf-8?B?a1NHZUVlY1VSeTdEWEhVaDRJLzNxM3JlbGdwUEsvYjE2d2VpY29BbCs1bFdK?=
 =?utf-8?Q?b0n0e8OK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b98740c-72db-4864-1e7b-08d8c1578b26
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 17:35:01.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wc4s6h1EEd2n0e94xDlOnF9JTdfLT5gaKIj18yJEeEkY3ZlXTM+K+g6TI1qgKVWEBEpAHhlp5IgW3fxrhbnLVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2765
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

Updates for v2: Update and add back previously removed comment.
---
 tools/power/cpupower/utils/helpers/amd.c     |    9 ++++-----
 tools/power/cpupower/utils/helpers/cpuid.c   |   12 +++++++++---
 tools/power/cpupower/utils/helpers/helpers.h |    1 +
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 34368436bbd6..8b69c7ff639a 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -94,11 +94,10 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
 	union core_pstate pstate;
 	unsigned long long val;
 
-	/* Only read out frequencies from HW when CPU might be boostable
-	   to keep the code as short and clean as possible.
-	   Otherwise frequencies are exported via ACPI tables.
-	*/
-	if (cpu_family < 0x10 || cpu_family == 0x14)
+	/* Only read out frequencies from HW if HW Pstate is supported,
+	 * otherwise frequencies are exported via ACPI tables.
+	 */
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
 

