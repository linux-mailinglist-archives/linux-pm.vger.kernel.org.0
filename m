Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F99834F3BA
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 23:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhC3Vtk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 17:49:40 -0400
Received: from mail-bn7nam10on2079.outbound.protection.outlook.com ([40.107.92.79]:34752
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231951AbhC3VtO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Mar 2021 17:49:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmMKxUSPQZkwMLiSxLT6LcyJamHxTapBfLRZqi3JBzNd65754LSuBVFxhoHGHLP4cRf+r8LaaddY7bR6MdxbOmS/hZM8CA8iwE8EB4qwXyuo5xxTzDb6CQGkw78zhPzSy9FkhsdvrCRxq61h5Aix0nGhu2XntdJWLFCz9S+4v2NV7gcj/QpcLN8mfR6cYWVjLeNtTGzxD3owamgicTCvwweK5RS0AKrjsmsqZatms75aoOC4LJHVFDCkMxSfnGMJ87FKd/fW7wUGBseKwOXTTX+l+ikFndTfPJ5zAls6D40xeI92dEdEiMIgQue3AO9du42A+DH/tCiu3GYELuNO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQv3xu0yNBo5UPgmsdqhb+MvPUKXC+5pacTRcyOFaiM=;
 b=DSBL9T7fFBFLPapR+8UFdN0ufObFP7R7yt/otgeBe+JIYf5DES4mzXDtvES1JVC7ydRKj/SIyHMt0rR/Dv91IC9OpbGHmxJGDg6BvuSCuCTPl+EZUgxCLU3N/kowQK2iYkVUxjCC9nwkDMdNML6Ra+Lp6LZ8pn+VZX48Z152oZT09oiB9HtiPdOz6vyaMuDviVk1zcf3jqXwKmzotLpbU6qEjU28dMHEQnwhX4RrRStO/XrqkccD4a3UeUA49JlKvE7wyDQcAKrNJ7+zEXPduel1KuzAFERwCPtkTw50x+rpDXcBzuiqewht7OG8B38w1jqlNRqzZWA3MBQHT8+n0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQv3xu0yNBo5UPgmsdqhb+MvPUKXC+5pacTRcyOFaiM=;
 b=UnkuRCynnaQr8X944iET7cnRvFT2C9oU6uP0ArRxESunN1jSeaSAVN+WqkSmmX5DVndS0CeMN+m99jCc2RJu697Xfx2TcOLpdOKqhO9MZVscfOnAcbucyZoVFLUzdTNyq5uwOrWNJsDDSSCwuHkotgCSpHq70rL1V3HsmTWs0ZQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Tue, 30 Mar
 2021 21:49:12 +0000
Received: from SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::3e:b8e1:a378:413b]) by SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::3e:b8e1:a378:413b%9]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:49:12 +0000
From:   Terry Bowman <terry.bowman@amd.com>
To:     lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: tools/power turbostat: Fix RAPL summary collection on AMD processors
Date:   Tue, 30 Mar 2021 21:48:56 +0000
Message-Id: <20210330214856.77547-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0501CA0083.namprd05.prod.outlook.com
 (2603:10b6:803:22::21) To SA0PR12MB4512.namprd12.prod.outlook.com
 (2603:10b6:806:71::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolxb27ehost.amd.com (165.204.78.2) by SN4PR0501CA0083.namprd05.prod.outlook.com (2603:10b6:803:22::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Tue, 30 Mar 2021 21:49:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e7593d6-be5d-48e3-ce45-08d8f3c5a7ac
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24471AED131571F30E9D285E837D9@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ucYJjCURKZKXQEnzFgTarEoLq3sb8Aj9Y/ohZggxL7G4T2wcaEHR7bLSSjUyJ65v8/ee6LXzG7Qo86E+YTZAHnU3llGFjgE9sOivMRk730MYX2ZnqIq0tdG7gEa/X6kMJEjDmBE/YoScE85RbMxn37mgRgJ8EV05yysDbSY4RV4wvoetdqs4eu5TlGlzEVIarCOg8daaxItnTHD0LXfRQaRnQbomfT5bvTZwVgCbwRr6bI5JtHgA9z2jg3U03iWisPKNwhPZhWbux6gjivDOW6Rye0pxuCaZLi2h6sxUp7XM5KatTgkbOv7SGB2l4RVBMj02xsEKvEw6xIdPg6ltxPB1r+AMBGiG4ySOdPBTWbpTNlGtLJBK6+1WIc0QNapfyODOBDoT2kkyPM4rEhLYHoIyr3s/S9veuhMeWJSSXz60R8Cpw5vEMayLKtl4eZOtszwU0g5AOpUAMlXmhrRaj+/ItUbzBoUrsRdv9qD+Lgl8TGdm5IQOEqN0YsX53lpCKhsaxBxwzJgf8BD+fp9jINKq9kU5CwK+KMBmNwZlKbZRw58kS8GT1f/wPl9oqn/aggquJvEF8QoxkdZRFvumoNamlkzeKycbYwPW/y72scVkAxZcCyhlhMFwcwRHcV/DAIMwxSZDVNvUqy3bxf1GddIsN3rrnm672djmWtGjK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4512.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(26005)(66946007)(6486002)(86362001)(52116002)(66556008)(186003)(66476007)(478600001)(8936002)(6666004)(5660300002)(38100700001)(2616005)(83380400001)(7696005)(36756003)(44832011)(956004)(2906002)(316002)(1076003)(16526019)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AIlVYGOpRuClWOOvTtC04mEB7QFQNm0t2iAywSY/Plk2MNcTYy2isOZ4CbK7?=
 =?us-ascii?Q?TGmTyuHUceuS7ToT3JWdUyJmva1e9W7UrjTQx3201hz+fBGlA9XG69ODvev1?=
 =?us-ascii?Q?ZnAdlRMsRQ1f54PnQCgPu6GAYPfX4TDcOzwBwaQyix4ZYkqlRELIGHON1pYm?=
 =?us-ascii?Q?BY2ZRnlhkOtNU4iof6vai/t1Yaxn3+78mKN4GPKUfzIt1IcecnWvFovlkxiF?=
 =?us-ascii?Q?SUgyyO4MTJ/hVb0Dx2hBbR8Lz2Id9idDYHcmb7Od8dHAH8So/tG9ssoUZoiN?=
 =?us-ascii?Q?dEupXW7weuvus6waEk1VvCMrVr0/FkhKSwD63neDtEnmYJ1fsc3HaEBBWib9?=
 =?us-ascii?Q?fLkfYN2s7DEbHN6uFw8nsrMqCPBt8V3KdG29NywS+2zLNSTI1JDqmsWRFHVl?=
 =?us-ascii?Q?sX8pG3lzpehti46Ogu7CyZZPQfzJRyTFgEu3LNhMPskaeKp9sR1Ii9rn9yfF?=
 =?us-ascii?Q?9e+QgXoDkHlA1ZYoMhbahUsL75jfsXKTMmSPaMPu6Xhu8gS5+7NxcKITZ5vx?=
 =?us-ascii?Q?KQilxTDqYbkC99Vub3BGUuZrwxyqy235ry8IwPEh6i8mBw73w52c/08CL8av?=
 =?us-ascii?Q?gZ/6vEZVEbYaGJCJ1C86rvVCtbYVQ9cD2EA/s7Ny4iqudUwAASBQvifLnNFH?=
 =?us-ascii?Q?goEibQM0AGT9ykPhQ/hHoverG22p2NJST2p96zDdT1bVmTxuNlZA5t7qaESi?=
 =?us-ascii?Q?n1W+LVbjOnyEmy4MkHa2bplYd/9vyKAACvvH9+X23I6jU1fFe724LMFOqAbG?=
 =?us-ascii?Q?KCgKpbK+zt64BQca9SnSEy6WXXNJy9C3z+ojb8KtgJYvslhlloYFdvWOsZ6I?=
 =?us-ascii?Q?seF9FjlbOgIXIRlO8Ys3SNMiX7yTwzMWptJDAG3mpfb/Ojh3AJnH68ColQAS?=
 =?us-ascii?Q?RYuiglDPXCYOvVh39YP5PG8fQrHBbcAlcUCK5oyFSlMrCQXP27jXD6DCInHx?=
 =?us-ascii?Q?P0ryba4q1u4YhPRVJEFOvGEMnVKZKvivsp1sW7wog6FPFDEJKK570XYWnKXO?=
 =?us-ascii?Q?CtHY/YdmlE45/JMcIRAAyVfB59Avvo7aTqTljSmsTwnPdNWaJiYcxNJQcCkJ?=
 =?us-ascii?Q?uNHcAh4IXPeSgP7RawqQ2xv5YPlynpGW4Sjn+dT2rRgWHk06j2yQwYDz7IcV?=
 =?us-ascii?Q?VZ3AtnbQV65GnP4T+mYS6jeTVEg5+VOE0GORZNRI7p8avJ3LISBm6w9tAsFz?=
 =?us-ascii?Q?oh/lxpSmpJUDVgSsTyB9Fz6j2CDVBj7iV2SXXRLfBfAN/EelLrVi7eMe04/J?=
 =?us-ascii?Q?tq301if/gaT5gjoaJitcordWshNbriBTuEr1CqdovMIhFdPLyRjAVCLtJL/x?=
 =?us-ascii?Q?JykXmwFk8+ZQbpWr97R9Y5Oi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7593d6-be5d-48e3-ce45-08d8f3c5a7ac
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4512.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:49:12.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nN/6c5RtZMGPWTVPXQVkh2gc1kVqnIAgOAJAmen7lTL1Awbb242aYV3K+/nd1+qxXsmZEaQmzBVLTOpAQZCbyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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

