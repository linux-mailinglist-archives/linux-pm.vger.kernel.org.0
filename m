Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CB8300A3D
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 18:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbhAVRuT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 12:50:19 -0500
Received: from mail-eopbgr750077.outbound.protection.outlook.com ([40.107.75.77]:62028
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728555AbhAVRlL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Jan 2021 12:41:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBbCFmt1I2qzImAtbNVFZRSFv1JlpfC51Hj+Vfje5f+ibbO7k5uYq7P/uNjvh2mo2wkHfXYOnkHSrNn8EVEcd3TRxLydmNAVqd6UJNRCGMP6B1+TzYt4jpdgj6BWfvFY7H/pPjMfh3Uy8qzggTQzfd+WAZfbEFbpVnCZmslJLjcC/pYuFn28yZRt/A3YYHL7z2sM21iaaGVnfGdXLse15xHecmTGAOxAuPLlhkGLAIW3TGOSGcKgt5OgRtUEBViNhE0Qzce4SnObYBMTEsqKVCLViAEOzr8WIjmD/a/y0HcMPKqgF5F24zwutZB5mCE7LhlEbCNcz9o52wf4pbfiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rvc6+K4QVeMwEz74t3Y47bkKLZj/lGJC+zumFr89ZxU=;
 b=b6Daf1wjGUxsrMUkprPieqMp7g3EZPmb4BzZFTip8QplcBO+Xrd2Nw+gPwDJQc5K7Q33MgdVdg1J4XDUrxWv5mqsFiCJjHWvZ+noqofg5j9X5OPo64El4WnqL2AMmrIUyGsipNpwiysT6Dkg+Hvd1vOq1bNhpGX0hmJMfsNL5zPaJG+89P9KztoTdt9/wrE5gGEuYKPFx9X5WsisUO8J0pPUzKcL14Kos/Q7rnt8V5U4I/kHEIyR4+JFJXdJnUngxr842EiSwGgyRA6Z/M2K88jL6P0ZMV3gqE6BkCBaBjRlWwaNSJsOlXeuJpTDio5vKkVAlTWZtrWw0dd0Xs72Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rvc6+K4QVeMwEz74t3Y47bkKLZj/lGJC+zumFr89ZxU=;
 b=GigE/4RSdn2z3eZ3qOjerBebICYSdDpFlxaS5C0ItMyXn300C2UoV1mO0x3DdLf4QeATn/xpGeoxzcTccLGaMQSqnz3AqOz313fzmVMM0amzM6hfWnC3Ko6Q1gVltM7TpjHM6SVbdg1QlhQQhTX7wNtpLOzbNodr7ksv1ddzN5M=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 22 Jan
 2021 17:39:17 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 17:39:17 +0000
Subject: [PATCH 6/8] cpupower: Condense pstate enabled bit checks in
 decode_pstates()
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Date:   Fri, 22 Jan 2021 11:39:14 -0600
Message-ID: <161133715479.59625.495972759377981936.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
References: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: CH2PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:610:53::31) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by CH2PR17CA0021.namprd17.prod.outlook.com (2603:10b6:610:53::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15 via Frontend Transport; Fri, 22 Jan 2021 17:39:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa641c56-b00c-43d3-f6f8-08d8befca432
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2846E0E2A1DE6319808BA8ECECA09@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLwNqg4NHBxdjrNx0Y31/bo5rFUZDpAOUgHAPMrPJeI/Ojd2n4XY+WRoUquM0JornVHAfQfp6sK9eJxrKfzVRlIBM1XZo1RFhOoSAQaxZ5ibtN9n/hpCbAZoSOLbBWhaPdK4rfzDv8P4NoZoEO51uftcL0hK+94TWF1/w6YllbJadu2PXPOLhOe5maPqXns7HagDJg1AolBf77CR8TVYxKprP3hOk8p1Nx/CMi1b4LSXX2ISy/0ipUCimmoCbGe3JUYGqzENk+4GXJnKLij4QV/air61K6lxAv72ls7//h4So6R6GjftPFT/VOSUWtwOLodQnnPNllJLha/BbRzr8UtQVGcMu4gPhnP5Os7uFaCQEggxLXydmvLKf3jvRKvdtSJWE3Vszta4TN6fceZXQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(103116003)(8936002)(52116002)(86362001)(44832011)(7696005)(66946007)(66556008)(66476007)(956004)(5660300002)(4744005)(316002)(83380400001)(55016002)(478600001)(186003)(16526019)(26005)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?akpuazlZWlVMaExjL0VjZDZQNDdsTGlzWWZrdS9NTGJJN0RoZEliRmVzekc3?=
 =?utf-8?B?RndCdWVWUUd1Slh0bU1ta1ZBU0ErREN4R00yQVE0cmRtL0hGMi9yQ051bDRM?=
 =?utf-8?B?bS9pVjVjNVZnTmhSQXg2eGxENFdVbFA5ZlE2MEErRHBLVVNKQWNPRVFaVWU5?=
 =?utf-8?B?YXRzbytQVVZXaUlTR1dMU2FJUkVFMkxwRFVMRzFHaVlyUmxtVUE5ajNIOG5u?=
 =?utf-8?B?VFJ4dTk1eGNzYStLMUE5YVpnREh4eFNEaG9VcjNPaVVLdjkvU1prVXFwODl4?=
 =?utf-8?B?NW1NckhqYnBJbGN5eTBjMlRtV01SalkrTHQzUU03OWlMSDBScGxuR1ZoeVM4?=
 =?utf-8?B?SDh5SmxZQkR5QXBRcXcwVW5yNVdGZ3pVeWRNZ0RnZlo4bDN4VGFWRk1wZHFr?=
 =?utf-8?B?d3hEQUNLN2FQK1BWRDBGTnA0dkNDNnZiUWRXZ2pHeFZrd2tKVVdSTVR0SkZs?=
 =?utf-8?B?M1FteFh4K1FuVm9PUmFuci83bEZzTnhvZDdUeHREdGZmRk1neDNUdGlPajdy?=
 =?utf-8?B?Y2RSV2c5aURlSVFSQ2QvRlpDN2hLallnUGUxMzRKbWl2alNUWCtjKzNkMVBG?=
 =?utf-8?B?VUdjOTN6Q21lREQrb2FwNjhBbnM0SEZ6Rllud0w3bUpOenA3RG1xRU85OWpq?=
 =?utf-8?B?TGdQd00yaUd2NzBMU2I0UVBUN292dGFuOFNBV3gzdkc3amF0WlZSeVgzT0lp?=
 =?utf-8?B?RkUrR0Z1SmlvSUdxZGlxSXhoMmVOQ1FPdmZ6a1Yxd2pKazd3ekJ2ZTQrbzkv?=
 =?utf-8?B?YUIxT2U0Rms1WjVUbFIvRFRDZE1oU3h6VXFvRU1wbmhYc01FTmhzOFh3SVlm?=
 =?utf-8?B?WDRZeHFxL2JoN1YxdUlkZVdpbHp3TWtIVUdBV2R1ZkMyUVoxeDdBN1ZKaEk2?=
 =?utf-8?B?TjArb3luWUtVR0NObmx3MUovbStGeDdvWEY2blNmMnUwZmd4UmtFUDJuaHZP?=
 =?utf-8?B?aTlnN2RtRDQ3RkNIa2FMRlpxRTVTbUIvd3Axb1J0ejRQTVZvTVlBdm1FMk8z?=
 =?utf-8?B?aTdHcFpqM3FHVEIwSVorOWtFNVdEckQ3ZDRreHRzRWFvY0hQTE9WaXpjSUJi?=
 =?utf-8?B?TDVNMXVLNmM2ZFB3eFZmVTJNWnF1NFVPcnJCb0VHdnljTUlXUjU1VTdLSm9W?=
 =?utf-8?B?V1lSalljc2Y4NDZ2STdwQnRFdFBRd3ZqaStQL2FKSHJ5MUJDK1drK29TVnp5?=
 =?utf-8?B?ekhDcE1ZTHNmOG1hZjREYjBFSlNqQkJvTjNTSTdJSVFJTFJyejlvZzE0dlVR?=
 =?utf-8?B?c1lUSWQvNlorcnFoRnBxNFlNQXgxVGM4cHpZY1FJQlhzdlRCTzdmRnJ6Uk1L?=
 =?utf-8?B?L3Vnb2k2SFY4eVVFNVlGeEVtQUl6VEJtUG5UZzdvd2hpY0NOOFluRkRGc3ZX?=
 =?utf-8?B?MjdsZGZuMDFCRDVQZC9pRE5tM0h5WGwyUWVGbmpaOFRkZHJwZXdYY1hSNmhY?=
 =?utf-8?Q?mPERJ32U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa641c56-b00c-43d3-f6f8-08d8befca432
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 17:39:16.9864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQsBMK8tAVh+TI0Kceh4dwMno4w0f3Y9kM7TEjo/ejr0kAUtq8ACb2yCyCUNSACmVu5zgyBnMYEaPiqRL1eJSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The enabled bit (bit 63) is common for all families so we can remove
the multiple enabled checks based on family and have a common check
for HW pstate enabled.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 519a21e92666..20694c3f367b 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -110,9 +110,9 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
 		}
 		if (read_msr(cpu, MSR_AMD_PSTATE + i, &pstate.val))
 			return -1;
-		if ((cpu_family == 0x17) && (!pstate.pstatedef.en))
-			continue;
-		else if (!pstate.pstate.en)
+
+		/* The enabled bit (bit 63) is common for all families */
+		if (!pstate.pstatedef.en)
 			continue;
 
 		pstates[i] = get_cof(cpu_family, pstate);

