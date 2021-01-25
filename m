Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039E9302937
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 18:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbhAYRoA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 12:44:00 -0500
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:8288
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730979AbhAYRgt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Jan 2021 12:36:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6Hb+n+kwrYFGKYbeli8I6dLdDDWiYP1sE3Y4r3aPcy2hXv9BSe//6EKCB1qH34HS1Z8TdwYn85+2iB2ndlmG4V+oRGoLUI3wfVrBG1rFS5PrIoipKhaEnDu5Bt7PHCn8siieiEA+Rw6PlM23JEx+E7EV5h+igru+ScYKlZzweaLi8ceWy1B6N7v4CA/rcWqqh60enZLOdLOXZIxRE5J3bmN+bYPgufWURTtWBUrYrS8Dfv/jfSupQHkRxJQT6fE8Aza7fFKT/7zg2xySTGSlLNTj4FXWKKOZUBLHC0occtWlFPwDKYb/jJWRJYhl3agewwZ0WZWtmUc+WorB2x3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J8Om4WkwaoWHbFFZPAnY9swnA9beeLe9Zi5T8DaBuI=;
 b=CoeMG21WVU5+4yXnbSN2K92hwsPGPy2lmzGpHih9+HMenfOQpEfMpFKGBaH1pHWjA6A/vFfUTdPLKCNTe0cvFrhHGIHl9bYnmrbPo7m2sdAEM3wF7qKoXDZXqM6w1ODK8Rt4FMFvKgYQndV0+L8iWSQbdWnxL8INMqrk0ln3CMuhb/oJkbfbiUSYrOX1eS83M1yEfWeV2aK0zM5tKZg85x8Cdh7hWsL2QF5xIVZZfCWxkdQAIikPqL8MgTBHX5eAoSInmP1ZwQviK7Ns1t5GNnR2uxbeyGH4nMYKFKVgRmEwaUfJITYreZlIO41AOytjGzk/18QE2txr31iudEit1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J8Om4WkwaoWHbFFZPAnY9swnA9beeLe9Zi5T8DaBuI=;
 b=GmMnKf9T671YiQr6GqAYJNQF7ADRGzYFJrkbEy9fId8tK2BU38k7a40DhDPi17enxGbY2DYyakvaBQzM7og9z1Q4h3yc6tqxCwokIJjQCDBfLlFQqfj/Fk15iTYxGVD5qzlhN+3SHHsa0VZlfsWoNMartHVxQnL4fBzEXDGtq54=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2765.namprd12.prod.outlook.com (2603:10b6:805:77::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Mon, 25 Jan
 2021 17:35:07 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 17:35:07 +0000
Subject: [PATCH v2 4/8] cpupower: Remove unused pscur variable.
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, joao.m.martins@oracle.com,
        konrad.wilk@oracle.com
Date:   Mon, 25 Jan 2021 11:35:10 -0600
Message-ID: <161159611089.68367.4122824171734411902.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
References: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:805:66::41) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by SN6PR08CA0028.namprd08.prod.outlook.com (2603:10b6:805:66::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14 via Frontend Transport; Mon, 25 Jan 2021 17:35:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47b999cd-ce89-4b68-94a3-08d8c1578ec2
X-MS-TrafficTypeDiagnostic: SN6PR12MB2765:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27658A22CD1EA8E2BF805561ECBD9@SN6PR12MB2765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QITMOANpANLQ2b4HdLNASZxNthd1uQ7g5h7clWvPrv/tTx60+cZ992gusp019KYfuTb8Ql98DA4CyFbIS6yySP4OpRCsosJoJ3yIqiNL+5DlLb/n69F7mo3/e38em6gWotwLQPSdcgcr7RwANgnBJHtEyokgqa4KSQDj7avi0dVQNvtntq6/Nl+uE+qnRfd+22ZbeWSwEZMVVVkZ4dQdJmH3ODMjTIA5PmMBIGEwQBo9oR3flhg13rmwqJXUFDHDQ229w9O5p3rnw7VtRUXJgbWWJ8XqwIL6rmILFmhCG8301r0341mi73Az5pT+GqSb7DtbpdkvRVSU7c9RN6VIHOba7mZvrsEdjvJ0DfPSjsEjiyLcL2jv3yMmlM1gvUQd40rHQXM6GU6mYLNXMAPv4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(316002)(186003)(26005)(103116003)(2906002)(16526019)(8676002)(44832011)(52116002)(7696005)(956004)(8936002)(6666004)(83380400001)(55016002)(86362001)(4326008)(478600001)(5660300002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MmQzVTlWM3NhTWhvQWs1Z1dOVUxqckFOOS9EeXVYVzZKS0NrZW1Dbm1tSzMv?=
 =?utf-8?B?R2xGcHRQclBnaXM1ZnRZa0tZQUFJQjRKbmQvZlpGdlRiek1zenNYYmJZUkhj?=
 =?utf-8?B?YWNuQTNSL28rK2lCTlhtazliWFZGTjdQbXJmK0JPREVtSkJIZWxYVlB2UUNY?=
 =?utf-8?B?SWg3R1huLzhzQTFiNTF2dERhc3ZJS1kvSXEvWThYNlVoMXRGTWhXcndPZGFW?=
 =?utf-8?B?QlJTbStrVWNFY29xUHFFVmZHUThJQTFXL2hoc0tDek5CdFc5SFV6Z0d6WG8x?=
 =?utf-8?B?UTNQYUU3dVA3eW1reDJUVi91dUp1Z21NUXZWeXJXcG1uWGtreWM0U05nREI5?=
 =?utf-8?B?N3NucEJIZFp2eEFJQWdmeXJQdEk1ZDBiVHhpMzE4NE9qT1hGMUNXQ293bFRK?=
 =?utf-8?B?VEQ1Nm01YWFFR1pSdXVjeGFCcmVVMXhoRjVYdGlZME1VK1B3SjM5ZzVoaHdS?=
 =?utf-8?B?ZTdHRnNJajZYMG9ybk1BVGRjdEtjbWY0RXlTOHNoUy9HbHo1Q1FGQm50UVhL?=
 =?utf-8?B?b1grTVRxSGY0MkNXWi9FSmdYRFZPMnlWMEtKeDNCSHJXajhGdTFQODdoL0lk?=
 =?utf-8?B?bmlteVJNRXJyV2xwUFdWUVM2TjlsTTBXRFo2WDJjM2dOZSs0OWg3M2wrdGtK?=
 =?utf-8?B?b2ZRUVhDc0JlSHZVa1VjeE9uWFRmMkdWeTMrQ2JTVGxRR1VMV1lWQklrck9V?=
 =?utf-8?B?NXlrLzBBMEx3QjJ2T3N6RXFTREVuMStpdytHNDdSbGtHbWw1T1JaTmRTa2U4?=
 =?utf-8?B?T2tDbTNxejlFWU80b01xUTB4NmQxR0RqbkdTRHR4UkxpTk5hYlNMRUY4aUxm?=
 =?utf-8?B?cXlpN2pwRWxXSngrYUNxUnFaQlNhTlRDY1VvU21BRmc3aVlFSXJXL2h6SXFa?=
 =?utf-8?B?bVFDdXQxQ0ZOZnhBMGFSUU1XeWpqRkNmN0lVOWdQa1BKNXNpV1Rod2FlbXRi?=
 =?utf-8?B?UnJMQTdrdkVQNGZVNE4rQWdNRkltbzJCTll1SlllMUl2THhuMFhYVGplQzNT?=
 =?utf-8?B?WnhXUlM5eitOUis5SHo1RC9ZTEhlRnNZS05mdmtEb1ZBRUphQldRK0htNkZm?=
 =?utf-8?B?Ry8vdWVEcHJYYWtLRHM3QnIwVUY3L2FNZXZESEY3ZXlqVmhBa3BUMmp6ZUlH?=
 =?utf-8?B?WFdTOUJQYXdldlgzV1hCYzN2K05jS0hhRU12ckJ3TzJiWExEbUhCU2ZhVStj?=
 =?utf-8?B?OWlLMHAvNTBCNytoRGtYZ2lMMmNBNWVZdjBGVU5pUGdIUFl2Nkk4Vmp1NWE5?=
 =?utf-8?B?b0hMOFBWcHZ0YWlrRTc3SExuYkNxQ2YrWnhlYnY3clczQzIvNjFjUFN1UG9P?=
 =?utf-8?B?a3ZlbUhCR29EaDA4NkN2Rm10QTU5dWUvOU5EVTRZcFl3L1lBQUlmY3VBbW96?=
 =?utf-8?B?Q0JXbE5MYjZ0cjRRQXVRa3lubXVyTnVZdFdhaEduZHdiVm9TRkNhUEp2bitC?=
 =?utf-8?Q?9wXRyfIC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b999cd-ce89-4b68-94a3-08d8c1578ec2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 17:35:07.6006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75Qok1YIIDSA127/xmPXCKxwgMhWTjkn7LwhDG4IuQU02kHbFDvhJMdX3I0ZwybRxsO0AkYMkiYSIsxCU0dLEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2765
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pscur variable is set but not uused, just remove it.

This may have previsously been set to validate the MSR_AMD_PSTATE_STATUS
MSR. With the addition of the CPUPOWER_CAP_AMD_HW_PSTATE cap flag this
is no longer needed since the cpuid bit to enable this cap flag also
validates that the MSR_AMD_PSTATE_STATUS MSR is present.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 8b69c7ff639a..fc2ac1e6bfb2 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -90,7 +90,7 @@ static int get_cof(int family, union core_pstate pstate)
 int decode_pstates(unsigned int cpu, unsigned int cpu_family,
 		   int boost_states, unsigned long *pstates, int *no)
 {
-	int i, psmax, pscur;
+	int i, psmax;
 	union core_pstate pstate;
 	unsigned long long val;
 
@@ -104,13 +104,6 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
 		return -1;
 
 	psmax = (val >> 4) & 0x7;
-
-	if (read_msr(cpu, MSR_AMD_PSTATE_STATUS, &val))
-		return -1;
-
-	pscur = val & 0x7;
-
-	pscur += boost_states;
 	psmax += boost_states;
 	for (i = 0; i <= psmax; i++) {
 		if (i >= MAX_HW_PSTATES) {

