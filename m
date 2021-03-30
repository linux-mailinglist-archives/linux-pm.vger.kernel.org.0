Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B552134F3A0
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 23:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhC3VjN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 17:39:13 -0400
Received: from mail-eopbgr680066.outbound.protection.outlook.com ([40.107.68.66]:8449
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232307AbhC3Vim (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Mar 2021 17:38:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bU1oVYoJxWPvlPbdfzPajdYYrTag3qQbrY9ypTeAC3ZCRkMoJByXTEvRmB8J97nyh8Qv5a/OPfsAFYW8+XFKO4vLQXNbcU8QCBX5jLf9Vl9ObjVlGTjnhbCWJpnMTEoEzupobX/mW26fFCcgM787G+f/gFapMjMicOtmmcdHp6iHGhVweROjFQJSGX796ajIP5Y2x5kQ0jU1jyQN5RvrY65S3Zle8jp51NOwW/ypfzo9Q+/BjFxOXVnNAkJ28ycxL9JU6U7ZEeniIoE9t2jL4+o78OUwtgUe0jDQpNSPprpH3TH7y4CXwry3p8DCiO5BTBqHWYV4iC0Bn7scilGlWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQv3xu0yNBo5UPgmsdqhb+MvPUKXC+5pacTRcyOFaiM=;
 b=YcVgBGRhs1pS4On0me49ie3SLJNYv64TeQBdlbdpKa79UMcI+tfFAuSwwWkA8QZ2C0d+wE5/uT2VemijREHsZnztl1KtGlaUaRfS6sfRq8YOLp1GX6TYDR9NYlO4oz5A1s9ZxCfwcz87L3IKerfiVVyPjKcVQXuuBfNASaAD951FZWoDI5a/kjOea42Km1lRCP7MLUFgexoRFTIAA8goxwpa0mGDurEedc/cjj1ASGx8+Sn/uE6vX3gz4jI9tQOZOzgUjIaCP5qfr/gmUPgltJfjaPUEwHf2jzR6cL+O1/kfud6T/L0eYjXtIWDx6ispka9Z7YQshMCoyArFlEA83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQv3xu0yNBo5UPgmsdqhb+MvPUKXC+5pacTRcyOFaiM=;
 b=BNhB1nje0YR5RerHlLAZqbXnhiqddNiKQ4jQoHA0aKyXKiOp5fqIDrIQJlxEs1JU7qHL9BN4UO+5x1kS7AYWwaCseiZmcjhnAhh1MOwFv6BgvD3cua6Y/0lATVke72ZMmF8Zcjg8i3yij1VrvYb77YuesUMypCO1KMhG89+iysE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 30 Mar
 2021 21:38:39 +0000
Received: from SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::3e:b8e1:a378:413b]) by SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::3e:b8e1:a378:413b%9]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:38:39 +0000
From:   Terry Bowman <terry.bowman@amd.com>
To:     lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] tools/power turbostat: Fix RAPL summary collection on AMD processors
Date:   Tue, 30 Mar 2021 21:38:25 +0000
Message-Id: <20210330213825.77294-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0801CA0012.namprd08.prod.outlook.com
 (2603:10b6:803:29::22) To SA0PR12MB4512.namprd12.prod.outlook.com
 (2603:10b6:806:71::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolxb27ehost.amd.com (165.204.78.2) by SN4PR0801CA0012.namprd08.prod.outlook.com (2603:10b6:803:29::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Tue, 30 Mar 2021 21:38:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 875277b2-9001-459d-f85d-08d8f3c42ec2
X-MS-TrafficTypeDiagnostic: SA0PR12MB4509:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4509ABC482EA977AFA0A7BED837D9@SA0PR12MB4509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FhILu0GWvqRLpnPSso8SXQR4QiGHaM+5+k8OvjRx5wpXf0CHXNDqvHn3jJnI/FliPdowVRtm8DJPPWv/CzmNO/G+JJ299cisj5ZP/bejf/5I+Q2R3cRIMS7w9y+jUNkHV66GKsSGAdSONdT6bnQgv1IL+grq2gwzq7DfhL3KxQd3ciwBy7vCFyHk23Hxi3ZHbDu+KCp3F79GxbwgEjKFXOUQQDhJ94rBzRugAnRKML4cksLXJsKHt2ekp4ZwQLiGxvwCl+HFkE9tFfmSG/Ej+u28Wvu3AGfLemuP7zJM7+FghioQp+7QsguFLCtmgx6znsORtLJk406HysYTpJZq5QVZ9STt8sOQBj1AQKpx0dM723fccJ0TDkq5p3QcZXuh30vLUaLZpganzObwL+Id/vbDV0G8jSykRWaQSQ3d5LjxWPOUt2O8Q9WT1aMEoZHoH1fKNff6Lw0fPMi3PsW0IXtOssuR6gkg5EV3Hd3wUTBpJfhYwf/45ALvzkktdJ+8cEgO8IPjUiODbfUKmsfl1HK6v+ZuKftpxwA8FPvq25lj2U1j7xyIIehlZ1BERGaMibTDHCPhhYSfN6dXiljA6HtneGwnB76F4bPWKWCOk8P1RmrR0LPnW/VXtJbN5Wrjl/CUhF/vClTNIJUJhOh0RQ+OjUv9MXiRBj5eN63fCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4512.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39850400004)(366004)(6666004)(956004)(2616005)(26005)(38100700001)(186003)(83380400001)(66556008)(2906002)(16526019)(66476007)(1076003)(66946007)(36756003)(478600001)(8936002)(5660300002)(52116002)(316002)(86362001)(6486002)(8676002)(7696005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xOiiBLWDKXUmKy/sghpil28oWG/iXdSuFWx+zNdgi5wAMvgtCkytrZtb6/5Q?=
 =?us-ascii?Q?3ac2O6PkkLQqBs84QoC8XrUPhy6bfdFUsIWD3mdxU82KZUihJQOVLi+8eONN?=
 =?us-ascii?Q?1lLlKuxifdq8vJ9PQoYgQRI6SjGfxxBWjNrKMKQA1mgU7qwZe84gcXGopXzW?=
 =?us-ascii?Q?8IIcSOlhaIQIA25msDwhl0kZNOPfhGO0JzxyniU6IUXpA4yn+fL5Vr26rS2Q?=
 =?us-ascii?Q?5E+10a85FmjqwZD1pQlGzKKBA3+QrU3c74io3ZxV1GhlAMqpYmAegqziwKFn?=
 =?us-ascii?Q?Brv+6fTvX0pHU8Db2fXcQXvlTow1wzGowRZ3lkh74EYhURx0urorUs3tvkJL?=
 =?us-ascii?Q?wiIJ10KYUvojzgquGSXeiPUwkqke6WLP3SM8Tsm/h3bA+YAG74Bgj2BjgRRW?=
 =?us-ascii?Q?QCdpGTtyl/Bw6eCv+WREISN0HnzGRImuq/aKnrGiNulm1cXxxdO/RkPoh3Q+?=
 =?us-ascii?Q?rEeihEwZNKXP0GuhAkVCGSxBRDTa29g0ZlC6OUxRG+N/2EC5ynHaG04cg+eF?=
 =?us-ascii?Q?2oGC8IMC9mCqrThPisTrVkvevyrVnPVX33d6ircmn76ByCEwH+3m+5N3t5Cv?=
 =?us-ascii?Q?bBWHKwI0LjGXHST0H9434oHGQyIiYA7Lwf5kxLlxdW2kHR3RCyxZ/zf4QOL6?=
 =?us-ascii?Q?y5Br4gYRAOMqNyf3j1ZDUksXCfcQ/XEsjBOQ8EZMkF+2IljpurkyQmKA8Cma?=
 =?us-ascii?Q?NKyE3zeppbtBEtelMoDslmypjrTsb4BUxKtRzkQv4uLQtTW5wF7mQ71n5zXn?=
 =?us-ascii?Q?iMQEArciGHfou1cmZTqAZ2hlbUlEQahjMbhQ+IvYpjQ2L9DEn+vu2uKsArPX?=
 =?us-ascii?Q?FRmTSnFvnmrKWY1Bwc8rcjLWYbUyfv3AEMKhk9831xr5oRsKgedzw5P4lWRr?=
 =?us-ascii?Q?ZN9JjE1pzXGhN9UMddHzsme8Vo5GgKQjof5GYtLN6maG+29lvKRTQVJlYXxq?=
 =?us-ascii?Q?gH7u5Xq0xn0MJKhPAuKVefFyqudzqkXJxr7PzoMka2kDNcBg9LeQ/Ua/gpJA?=
 =?us-ascii?Q?UD+Vi3Qw1uVattm0VOzRd0BsIFaLt5fz9KbY+wkgIU31pZ5qv+eLBMK8XMXB?=
 =?us-ascii?Q?1GlYSkelL6OxZ7Fl1kjyS1Ho9bEc49uVoZdpn3z4d0JclnFEVSxo9gwc0TBx?=
 =?us-ascii?Q?v1/WQYrvMGoQTSGtSzUS8wNtWl+na7CQTQ8stwxq7PEQ794Pe31EliRUofVo?=
 =?us-ascii?Q?9ji4CWsHJVy8QsrRJdksBb2N8yM099d+e9ZByL8lrLoxDVGK2jO9LYDCAaHj?=
 =?us-ascii?Q?W86gg/dgB/jmM1pLoMSOF9XRl7lYVv5mvQTtl2a05bqJkHl+IVnKXzBm2Zkd?=
 =?us-ascii?Q?OhlruGH7txPDifxO2Asc/r8U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875277b2-9001-459d-f85d-08d8f3c42ec2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4512.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:38:39.7699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cS2hab5MNzceq+L+RFm3OyA4+0Y/K+E3hhMwww3q0kLT607H1FsERjVr+SzA5JXw0cUd8CD2Jz3F7KE38eS/sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
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

