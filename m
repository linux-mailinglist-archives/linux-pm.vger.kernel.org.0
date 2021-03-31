Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8963503FA
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhCaP6f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 11:58:35 -0400
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com ([40.107.94.49]:28417
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232372AbhCaP6V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Mar 2021 11:58:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtSXOtB/SkW9MunfGnBs4RZSwc7m3MasyBKCWAkZMuLP1Qn3aevFvjKSV5MELH1yMFWJ1J0j5fx6icbSv86HqU8uaghEjHEgtWdMmG04oQ+TyGbOOxDmkx7Uxa/A1ZfWfGZ8UTuE40XkY73bHAV9XgAsRXJ3xO4k1ahJ+7Eny5pRhxddxOHEhGt+nCy2YeDnbBDPnMQXs5U4kRTfb3FHf0j/XIXJQz86V5/okjb1yiQNp6dnkut+aw/BcKQMTQ7e5CB97UT2ChD5KE0bXOhY8cNQeTqR2qo1Vh68m3DfKaeZ97EScvlCvMt9Lcp9z+VgQU2QYH7dVseDseSMVgMbxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQv3xu0yNBo5UPgmsdqhb+MvPUKXC+5pacTRcyOFaiM=;
 b=IzGuF+cCrKUGwuQmzKSdqkSkfjIK3TnSDwPhZ7u9KStR+1KoNG7TcW9xps1dF806Nv0DgQHmwSp2uvgSjtlu3U24Bb2yYv+ZbHMd1hBc4ljhRGWV6PrlxFbk4BrBZQTRXRSthOElC+jc8nldIR9gyqoTnfLkViJrNWHrW2r2Z0DIsFaZnPxGZdYgq9vkVeqCX7mZkD3W10gVRr+sgMNOBnq11MIyyBz0DO5JQJHIHXbD4Rnp3ETJoGDfpZR8qvi+AEmY+IuNRybrdcwl0UkAnFUGWHj+iHJdChk2dU0P6yIhgDIyi8RAM5P7x9wKat483FHvsT+2JaH1L1sFxs9tlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQv3xu0yNBo5UPgmsdqhb+MvPUKXC+5pacTRcyOFaiM=;
 b=Tp2iN7TcvnQW5n1HZoufUOfMfsZfrxxqrrC09zNR6yyAAp9GfA2vG92AdO2irudGF2duteRBKc9gve+1yP1gYYT6GGPvZLMlKwAVbXlU5ayA0js1mJ8FrBinTRgsRL5p61X+H4MdudJwIvNkAaAaU2uIx9eF4OlqgKD8BvbEapg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 31 Mar
 2021 15:58:19 +0000
Received: from SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::3e:b8e1:a378:413b]) by SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::3e:b8e1:a378:413b%9]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 15:58:19 +0000
From:   Terry Bowman <terry.bowman@amd.com>
To:     lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kim.phillips@amd.com
Subject: [PATCH v1 1/1] tools/power turbostat: Fix RAPL summary collection on AMD processors
Date:   Wed, 31 Mar 2021 15:58:07 +0000
Message-Id: <20210331155807.3838-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR01CA0008.prod.exchangelabs.com (2603:10b6:805:b6::21)
 To SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolxb27ehost.amd.com (165.204.78.2) by SN6PR01CA0008.prod.exchangelabs.com (2603:10b6:805:b6::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Wed, 31 Mar 2021 15:58:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7fb6c93-5f0a-446c-48af-08d8f45dcdd2
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2542D572F65EF202A9D20397837C9@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w5eoiyATxwN9wb2zgvT1MfAFViOKR5SLxTBAMRSa6VceKGJosEUrplEXnJhcWtNcVzU/iohJgzTaP7yz3tRxKZ1rHLDw42xk/SA5/0PUQg63ZYpNm6rk8jnvgMvGsu6GoiXjiCZOeIGLClHaDJWThEm0L9Z3kbKaxr9is/SQzQ3ccrg7hQIB24Rczo246sBnlv+7swJoZX/3kuUFzhKcUBrozUBsJKril3roWQpWgf/VB1Nqb+OdjJyXq706nAqgSAjWrzb7YaQn9TyNLL5RFuXFBk1xBUb5CMFJLmoVgxkjDi1i2n7qN+TbKMLPMdwGF0p+MkNIwHT8gDW+2xV+lWPbapOVk7CEMXc9vvR92R925o607YF0hEw0T08BKSxpPLnh9TZiza3tKJMZ6Chc94nUFkWriiiElqRPyPi1eTpmqv0Vm4kUT5fVWYiekNNg8RN4qry09j6F/5OKn16rtRjW5tJuLXBhGWFabYxNjASJQG5u4uk5TEGEkPyW3ZT0J6u3YH+sqcoQUs+jjUxVmIB7uuWj+6DQA5U/cLIifboWNlo+SFECjIB7TX0VB0vD0sUeiCiwLnX6mKrHelT0anC7SikK4BrjBjlyYrwl8u90Wl2aeEfNk4NHlqSVHAwYOsxI7e3smPri6RnoQwtVQb7rFSgB1HAv+ANS6k1yxqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4512.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(36756003)(16526019)(186003)(2616005)(956004)(6486002)(4326008)(66556008)(478600001)(66476007)(26005)(316002)(5660300002)(66946007)(6666004)(1076003)(8936002)(86362001)(52116002)(8676002)(7696005)(83380400001)(38100700001)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UhBExAiVoK9Qgw66CJH1eb8t2tmV5vdmje/Fmvt2eBi+wAw1gfyxhkxMokh1?=
 =?us-ascii?Q?nn0vFhz3TIGZQCWla1hbYHWzyqzSkvkhwLt7jeC5e24Wha71QWAmn8nf+rbq?=
 =?us-ascii?Q?Nm+bgzDZHPmBUu/+64K2XztkMWpgROW1LYjBlD7DJDTnI2SinABve/NdM9ZI?=
 =?us-ascii?Q?TyZlXTE740NSGthTxkqbtV5RvH0WxUZ0X8E0ua9Acr5Xhmdzisb/1xd4pxK9?=
 =?us-ascii?Q?y5Lx221LXMp24GJdzWvZJuz+HytbvKhKWNQtX1l6I6emNiI3JyR+G1JBuJl4?=
 =?us-ascii?Q?E8cUY2YhZzzoon/JKwqIdPQ8XkhpM77H5J8AAWAYRjYOjr66HqPyeOXI5cts?=
 =?us-ascii?Q?+DGa0Od+kEI1nOKePCuXkhDQ/vbcyRrm93g1nA09QAdVkhfXWZtei9OUcO+O?=
 =?us-ascii?Q?uu5S3j9TMTRT0WMc1d3rDGysWRVzFjUIkrjEHs9lm4Hdp9wdauhn5DcWmri0?=
 =?us-ascii?Q?WyKocEu+IIhrAFIUd9cYth3s2+NDk1NsFyWOs/vcDeuy/BRTZpvqUZNtSYPO?=
 =?us-ascii?Q?paf3AY1PjznW6COyXDJ/B5ujhQd2Idlwktts32GKcRYFyH1RA7k98X2mgMeg?=
 =?us-ascii?Q?pPYTHwtAL0kHsHTwi5i3TM+zomQo32zON5y6wRykyyMJo/QjwfKwJjyJhskk?=
 =?us-ascii?Q?84t5a0yvudYu+7RHUkui3rkKLOk2XjgK3lmQrQNhwUNiWyGuz/Use4XgGC5h?=
 =?us-ascii?Q?nvjVYCXIuzOhwcz9hqJTraDkqB76jrrgjb7gxcjqAHtMfyZTc3dk/WwDvkXS?=
 =?us-ascii?Q?eiqIBEF1AZILusgfQLpnFzQUT5XtYgSe+aPVsxsYvsm593n8G7pQtsZ7VT1k?=
 =?us-ascii?Q?FWMp25eXLzHfqL0DYrNm52qKWYHaX4p3BzV4PD3EZsQkGBntLVLNZQAu3z/Q?=
 =?us-ascii?Q?sWzquu9Pk8D9eLFyd3GyrOBV3lIowT/QNwH6gdV285pjILqpLcfMYpPt0uxM?=
 =?us-ascii?Q?NoBPy5RZCvAWmcXFJFGuxQ9Ln525FM6KiwGbe130vNavhS+8UyrtlxVRl9pd?=
 =?us-ascii?Q?bq8C5GYyVMa2Pjyat6WXa+Z66Fk8YayMR0csVC5ogfijCQ9qxrduED6KFviL?=
 =?us-ascii?Q?3yaN2FnMs2Zgz5qXw6he6MQWFZXiR9U4yQcyplUeqm3IHd7gzMBcTrvQXF2t?=
 =?us-ascii?Q?BZu7/+MSEs1f8aOyDGhdQVxNEaq94ZVf7azrLbtD4O/fKPQBWRxTwFsPUPd0?=
 =?us-ascii?Q?Y5+DIc5vO6J0D/IaLmbXN4sxXJ52zfWzWCskF+CFtEoyrrmCKodim3+yL/zd?=
 =?us-ascii?Q?An3095uz7pjYPxrsZ0FCRiRLXpeJotb4S9cdZ17Y2BNB7uuRx3qQq1OMPYcW?=
 =?us-ascii?Q?08L32/8+sSdNE949UmlurTn+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fb6c93-5f0a-446c-48af-08d8f45dcdd2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4512.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 15:58:19.6416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPyoho87FTVn/tNT0zXp4D9+YTjYnI19cpm5dIxPydgvRgbZS9bAQBPGjrHkmTDh5CDQWMxXj2O7k8vquccBbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Turbostat fails to correctly collect and display RAPL summary information
on Family 17h and 19h AMD processors. Running turbostat on these processors
returns immediately. If turbostat is working correctly then RAPL summary
data is displayed until the user provided command completes. If a command
is not provided by the user then turbostat is designed to continuously
display RAPL information until interrupted.

The issue is due to offset_to_idx() and idx_to_offset() missing support for
AMD MSR addresses/offsets. offset_to_idx()'s switch statement is missing
cases for AMD MSRs and idx_to_offset() does not include a path to return
AMD MSR(s) for any idx.

The solution is add AMD MSR support to offset_to_idx() and idx_to_offset().
These functions are split-out and renamed along architecture vendor lines
for supporting both AMD and Intel MSRs.

Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL display")
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/turbostat/turbostat.c | 61 ++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a7c4f0772e53..24c7f380485f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -291,7 +291,7 @@ struct msr_sum_array {
 /* The percpu MSR sum array.*/
 struct msr_sum_array *per_cpu_msr_sum;
 
-int idx_to_offset(int idx)
+int idx_to_offset_intel(int idx)
 {
 	int offset;
 
@@ -320,7 +320,7 @@ int idx_to_offset(int idx)
 	return offset;
 }
 
-int offset_to_idx(int offset)
+int offset_to_idx_intel(int offset)
 {
 	int idx;
 
@@ -349,7 +349,7 @@ int offset_to_idx(int offset)
 	return idx;
 }
 
-int idx_valid(int idx)
+int idx_valid_intel(int idx)
 {
 	switch (idx) {
 	case IDX_PKG_ENERGY:
@@ -368,6 +368,51 @@ int idx_valid(int idx)
 		return 0;
 	}
 }
+
+int (*idx_to_offset)(int idx) = idx_to_offset_intel;
+int (*offset_to_idx)(int offset) = offset_to_idx_intel;
+int (*idx_valid)(int idx) = idx_valid_intel;
+
+int idx_to_offset_amd(int idx)
+{
+	int offset;
+
+	switch (idx) {
+	case IDX_PKG_ENERGY:
+		offset = MSR_PKG_ENERGY_STAT;
+		break;
+	default:
+		offset = -1;
+	}
+
+	return offset;
+}
+
+int offset_to_idx_amd(int offset)
+{
+	int idx;
+
+	switch (offset) {
+	case MSR_PKG_ENERGY_STAT:
+		idx = IDX_PKG_ENERGY;
+		break;
+	default:
+		idx = -1;
+	}
+
+	return idx;
+}
+
+int idx_valid_amd(int idx)
+{
+	switch (idx) {
+	case IDX_PKG_ENERGY:
+		return do_rapl & MSR_PKG_ENERGY_STAT;
+	default:
+		return 0;
+	}
+}
+
 struct sys_counters {
 	unsigned int added_thread_counters;
 	unsigned int added_core_counters;
@@ -3249,7 +3294,7 @@ int get_msr_sum(int cpu, off_t offset, unsigned long long *msr)
 		return 1;
 
 	idx = offset_to_idx(offset);
-	if (idx < 0)
+	if (idx == -1)
 		return idx;
 	/* get_msr_sum() = sum + (get_msr() - last) */
 	ret = get_msr(cpu, offset, &msr_cur);
@@ -3277,7 +3322,7 @@ static int update_msr_sum(struct thread_data *t, struct core_data *c, struct pkg
 		if (!idx_valid(i))
 			continue;
 		offset = idx_to_offset(i);
-		if (offset < 0)
+		if (offset == -1)
 			continue;
 		ret = get_msr(cpu, offset, &msr_cur);
 		if (ret) {
@@ -5348,6 +5393,12 @@ void process_cpuid()
 	if (!quiet)
 		decode_misc_feature_control();
 
+	if (authentic_amd || hygon_genuine) {
+		idx_to_offset = idx_to_offset_amd;
+		offset_to_idx = offset_to_idx_amd;
+		idx_valid = idx_valid_amd;
+	}
+
 	return;
 }
 
-- 
2.25.1

