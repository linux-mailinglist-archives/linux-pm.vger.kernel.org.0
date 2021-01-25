Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DED30291E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 18:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbhAYRiU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 12:38:20 -0500
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com ([40.107.236.67]:55220
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731068AbhAYRiC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Jan 2021 12:38:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bb1jgxKcuqJU3XjzTPyIk+ex3IcRoGVtNVs++zcDst0JXi0bo6C9bvV95V8w7GMmNFugnUCCI1YERoAwgUpld1PnUv03SRFtuPjQVWrt0gmIxW1QqU38y1pxyfjO4n5cd5kTTpo5rNn2HBU5I/sWqflbauBx2aj5GKgbg/N1f5sibTScWCOc465XoH1qXHkODhwmbJf3B6IDDoIDBg908aatKpC2/nySrzU003CxNh1TQzEj2Zvs3q1mERQTcnerXTaKwuvtGu8bccsuJ8Uzne8bGseYHWlXy5eQQMzQkPuiZE3GOnkjl+W8hh9nZBujwrh1/ooylmYYZMSy8RUVqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVCXZm7orfvAjfcDNWKOf/1kAYD72qGKMCGdVVvrBf4=;
 b=QHSb/jwN4rci/KVwMJiZGxxbuSjgzuSxDMR7oVlQCxyp27Q6F+fl7dawYpJJQW3e7qMvAifuB69ibFy/vGYObzgrSlsqT3JkVhBOzWM+9PdKzUo/A76goPEfJ4hDppz5CxJPRpHs0ph10OaNRYoHXdm4YvDByb7vBRy2oeo6Ljw/rhCJnHC7F/JG8ONL4MHNFOl81tQb/PlKqbkVj1Tactkbam7eduB3YmZo1nPYJTPtilVZqFwDy6MxhU9ttRrX3ZNs/kersM/ln6h4PibDZfMForSaY3BFJ3gthgSkJ1XWHz2Tiu+ttTkHlhRwtjFmsijw27SUwzZkOd2uVJgMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVCXZm7orfvAjfcDNWKOf/1kAYD72qGKMCGdVVvrBf4=;
 b=gCuXFLK75dcVROrHk67nZozzs503rSEbCbJXjVpwsXxFDdKyMAHL39o6+9jsjHD1G9yUO5AfrMAne3O9Pan1uajBIoIC1GE5A1rTR2cQhor+IzkgFROIPzG8TqSnyc5Mp9diWdxBf0PhxRESI3QqW/YdxZfzNke/WPb3yINz0XI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN1PR12MB2576.namprd12.prod.outlook.com (2603:10b6:802:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Mon, 25 Jan
 2021 17:36:14 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 17:36:14 +0000
Subject: [PATCH v2 7/8] cpupower: Remove family arg to decode_pstates()
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, joao.m.martins@oracle.com,
        konrad.wilk@oracle.com
Date:   Mon, 25 Jan 2021 11:36:01 -0600
Message-ID: <161159616115.68367.1898001254335287663.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
References: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN7PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:806:126::6) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by SN7PR04CA0181.namprd04.prod.outlook.com (2603:10b6:806:126::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 17:36:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c1a4438-3342-4d13-df6f-08d8c157b651
X-MS-TrafficTypeDiagnostic: SN1PR12MB2576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25763E621B6DE7FB3265F0DFECBD9@SN1PR12MB2576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lt6U1ZR63PDiwXAIzmI8o+NlkAp1VqVXj2KX2FaJrtSwv0sETmghrMqF3RrdRA9XAGBN0NWDA3vPaxb1EUepGxD9X3+YDdDtUj6lPjHhTZjAxB747wX7gasz2KP2wLTP4lsNEIzJWQstXXpuEwy14Dyw37oFtypZJ5oYRei83PGgWClAHtSVJn6XuklR6R4HXtRb2slQLYzFPrVk6zluN2RrnXft1tVCF69Q20oUwA+TlLVf1PU8qJzjobwOsundA5pmTqu/Ppk0dip74J4l3ElTfard5oOFAYUQykRXM0l1ERadtNXN2hlpkYJjsxw8jGiSxK9zi6DeyAu7H0mszaPu0b80/1idvgYcAfyibfN3wuaR4V1v/GBeaTXzgZ9eps75yHkwENfFau+jF9amKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(66476007)(66946007)(66556008)(5660300002)(7696005)(52116002)(316002)(8676002)(956004)(4326008)(83380400001)(44832011)(2906002)(6666004)(86362001)(8936002)(478600001)(26005)(186003)(16526019)(55016002)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OGw4WStxM0M2NFZ5T21ydmtseFZjb0dGN3QzV3FYQ2xsTStzcE5mZEswUzFM?=
 =?utf-8?B?WjRzeGdOUWhVZnFyMG1CRU9SR1F0WnBxK0xVdTdhSTNqeWY3cWtWOVhjRUJl?=
 =?utf-8?B?MkxxekwvNXJRYW1yQ2JlZFl0ZzA0RHozMDdSY0l4S2FsYytHNHYxZVpHRXFR?=
 =?utf-8?B?SDcxNFVsc1h6eE5BQWRDZ0UrTWFYcTdBc2lHcG1xZmo5bm9GMUhVWXJwNUtt?=
 =?utf-8?B?d2RxK3RlREh6L3lsSG1XS1VUZ0I5KzdxV25hSjJUaFVmb2VzaTcrZVFzY05R?=
 =?utf-8?B?TGFGbFVab2JIK0hxb2JjV3VWRGR3MGxra3poMWdkRWpSWmFNWHNMYmNhYVB5?=
 =?utf-8?B?VHlLaE5acC9BRnI1WElkUTF2ZzFiUnRzSEViME9OSGRnZE5YbFlZNHBHaHQx?=
 =?utf-8?B?SHJlRVlXSjB4UlVyS001aWZrZE1rK2R4ZVBHejVBZFJ5RTV5enFLWEIwcjhM?=
 =?utf-8?B?bEFmSU4rMTJPWFJrWG0rM3RPbHoyWTB4ZktVQ1FZcks2aGpOMnJMNzFWVkJX?=
 =?utf-8?B?NkwvMXNCL0NlUGhwcnlveUZtSXVvSEVvUmtPaUxwdjZZWDBaaFAxOGlNcFha?=
 =?utf-8?B?SkdyOUNqV1lTYjhsSnhiMTRzc21jK1d4WVM5KzRza1NYeW9ZQk1FTXMyZVNv?=
 =?utf-8?B?WGI5STBZZFlzcFMySkJqcGtnckp6QURBalo3clNRdWpVTkJ4akF5Z3BuY3BX?=
 =?utf-8?B?cStKSkRlUXpiWkM5R3BuNkc1V1FWRmFMVy9iLzRuWitEQXhFVGxWUjRqaVYw?=
 =?utf-8?B?SnFodktlSUtwUjJ4cjAvcFZrbWMvaUdjUFVzVmFnc3dMN0pQNWZwTXhMb29p?=
 =?utf-8?B?ZDFxbUVrQ01LYTZEU2Q5cU1LcUFhTjlMMWYyZmk3THhrcDFhV1BZSWo0TG9t?=
 =?utf-8?B?amtGbEt0M1JEdG0rRTh0aGo5b05xaUVIR2MyanVXc1daRE9LV3R1amtoUm9X?=
 =?utf-8?B?eGZ1bW40TjhaQ2JCNThVRDVBb3ZXemJaTmNNcnBnSFI3ekliUjFNQy81cW8w?=
 =?utf-8?B?QjJFOUxhTys4b21TYzBjSWdOZy9BaEQ4a01PYkNhRHJIZmI0SERhUWszb0cy?=
 =?utf-8?B?TERGMkU1dG15TGl2b05qaUgxMkp1QytXMFRUbGx0UUdMWXFRWTVlUlNmK25a?=
 =?utf-8?B?ZlByWDN2NXRZNEhEYS9PdUpIUStreTBzbW9rN1VqMUZJaXVUd0djV3ppZ0dY?=
 =?utf-8?B?aEx2dDVtRS9RNEIwT3JyRUcyS3hXU3FlVzlSUXFyYTlLR3pVSnJ4ZllSTVlJ?=
 =?utf-8?B?TmFuYjZYVW5RZHk1bGpqNTdOc0puSlUvMTRkMjhLZHFCQ1NhcCsza3VTK05v?=
 =?utf-8?B?S0l1NlhOeER0R2xGaHZUaHNCdyttVG9tTHRQOWZUc213K3JYVXdaemlyOHNN?=
 =?utf-8?B?bDhRRk5ib3pMVUhtWSsvNmYvdWtTYUI1L1J3L1FNV2NEVE5NNG44Wk81NVN5?=
 =?utf-8?Q?RlvenIXA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1a4438-3342-4d13-df6f-08d8c157b651
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 17:36:13.9268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrZl8+s7SwFcwwrYNyL5ctvRKYUv6ii1sh9fh1O1VuYw9CT0V5FoO160k1fcvmD0gGcbwIwk3X/E5Ue+E0lZHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2576
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
index 216240e2b771..97f2c857048e 100644
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
@@ -118,7 +117,7 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
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

