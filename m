Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DB3300A0E
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 18:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbhAVRnA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 12:43:00 -0500
Received: from mail-eopbgr750055.outbound.protection.outlook.com ([40.107.75.55]:28967
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729886AbhAVRj4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Jan 2021 12:39:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AamTa1AminTNpsCegRoqGIQi7fab78aJNwLOYW9xHjJThzvcA4PydSI44pmQRLzF7nfgFrJ/OMSSOgdVoSZzsT71y8e4bx1ww5Z7WD2NYA7s85ymdee4YWCUzBHhlXrrahG71jtSMZ37q7+c5qjmO15Qk1JHk1JdZ8axIPFoaenw/yN1St8XmNaot/xlb+rN0kn4bv3LmwnFuiSqREYhrI5io6dSkPwRXnlHMm7uVg6uTlHJbn0Vcrw2Gd3c7xdJEYJF7EAfdVWutfxHCt0Wx/q5KZ+DjYKPs9n/w3ynLFRxvWfmkUHxZlaAAedzBAe73r8nc97zfilT/CaDil7mNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTrsC0sm2d5Uc3hxMyML9fg0zQNw7jGsvtgEWX1uBdI=;
 b=ja7y1eyY7oajsCHO56QfpbwrtCbIUQWoLKMGLnyHsZQaNZskkg8wY05x8RoLAkSXIclnAg3LKxs6/yVezV8qL7l44Uut8jRBtkkIZhjTfJEowm7dXxTb7m3HGRgQdSSIS7L0tiB+YKU74farI6q/3w/W3mDm2WgifAC3u22nqQj6Nb9blEc4U3H4ThxlN+kvV9glof4wONRONvDMWDktysVHYMXx1s6bv1zO5gGcesNoLrPFSpCxelGGiX3uhc7p3q045Y59NZA/niUGzDD90qYXJuoXn4pelWWSrZfC6gu9kq1qlczWGhigEKHvx6JPaH74a1Sxl1yQFyMvzpovmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTrsC0sm2d5Uc3hxMyML9fg0zQNw7jGsvtgEWX1uBdI=;
 b=UG0LGn0rsfkGEL1xVWJCr0U0YLBvG0mNfFZZM0caUh1za+ypxm/2cy13cvKP9p7fR5hy6azfk2UmxVxEtxtccWP7OyvIMCfeDmM1F20NhwbpPVvDb/NXah/xXy8cvRPumW854XnyVFC76G2oP9pItwPJC2u8TeOzcgWcgELBgYw=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 22 Jan
 2021 17:38:37 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 17:38:37 +0000
Subject: [PATCH 1/8] cpupower: Update msr_pstate union struct naming
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Date:   Fri, 22 Jan 2021 11:38:35 -0600
Message-ID: <161133711513.59625.9843026563692886689.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
References: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: CH2PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:610:53::40) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by CH2PR17CA0030.namprd17.prod.outlook.com (2603:10b6:610:53::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Fri, 22 Jan 2021 17:38:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7edc9c06-8de1-4b9d-5b16-08d8befc8c85
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB284649FBE0AB5E4F0E530C9CECA09@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zl3NNcb17aIQ3Fm7xH4z9meIXHvP5D/RseXEtfgBMCJXZh/FxUnKl7QECSfdMX4FJ6W5awBjwlapS03LeE95w4qlhLA/rzJ4W1F/TXfCRPXx5948v9LGwHMr8eBELbjHchbxA+tcQCBoEuq4yVl1iAchp2J1hhXisGbM9cPwMhr/jQm18ACcsEq8M7PxNQrYaftxWgPWccscF9yVwmhC4tkIsO0loNlmPeYIzV7Yt4mxQoBbMsYGm8I4Rli8DRcv6Qxf0B/pjJUVYt0XPMzW3j9Bgxakt+6nEfqouCjaTZb2GLsTE02WZJf80Y3u+mxItKu0L9PfVGdJxFZLfRSBF1FmqBCWUW7rZWM0LRlk6s9N38/f42DqPJZ7i3efHC9gFhL4EdDGnRegXFjtpvJa+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(103116003)(8936002)(52116002)(86362001)(44832011)(7696005)(66946007)(66556008)(66476007)(956004)(5660300002)(316002)(83380400001)(55016002)(478600001)(186003)(16526019)(26005)(2906002)(8676002)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bjZ2SUZJdXlFMW1GVHVXTTZndTg5dC9WZ3MxK2Z5UWxDTlIza29ZR1d3Ny8z?=
 =?utf-8?B?enNPVng5bE5GRC9iSzBvTUR3RUpNV0lJb0RpVTE0TDZzMnZsZit4Q0IrRFB6?=
 =?utf-8?B?eE1vUDhaR2luZUhJV24zL0MwOVhMSmFPeHA4UWFPUk8yRmdXWFVaNDR6Qms2?=
 =?utf-8?B?UGpNMjAxMFVVU2tRYW9QcnZMZWE5SFI4NlNScERZQUhVdFBtNk0xV0ZnMEN1?=
 =?utf-8?B?cEVtR2s0YUZxcnVoVS9tdGF6R0RSME5sb2tHVGRMcFRTcWlRck0zSzJFS2h5?=
 =?utf-8?B?ZUI5ZEJvWkw3M1MrUGVBVWtGZWhVMlFnZE9BU1FNWXhPSmVDVXJXelpxeWlO?=
 =?utf-8?B?dCt6aDFoc1dORlFvMk1WTXdZdkZaRTlraUVmSC9nZm5jR2FaSWlqdFIzQlZV?=
 =?utf-8?B?RmZxbTdlenNKTkZmWHlqaDczWEwvVU90dmRIU2hJYTBzNGtUMnlqdkJzWWlr?=
 =?utf-8?B?TStPaEM4Yk1tSzViR293dFJrVzVtTlhBRWZRcndDVWxnR2owQlNpZkMyL1dr?=
 =?utf-8?B?dFRJcVEvOUIrL1J5Ym1jbm9mREU4S3I5YTllWDhBWEUvNnVXc1JZODQrZXFJ?=
 =?utf-8?B?eUIrc1FJYVVHdnhJSGE4bk1pUWdtemJQd1N1alFZWi9zdndBY0ZSekkrcnJL?=
 =?utf-8?B?UUtBRVVORFcwQ3lsMnZUVVpjb0o3ZSsvMjlwNGJEcU5tSkljV2FSUzk4VER5?=
 =?utf-8?B?Z1UxdXZFWXJjamJVb3JDT0pPanRPMFdsWkNmNVNQNDduWFY2UlFtbnI5S05v?=
 =?utf-8?B?THRMY3hlS0pvRHozUXNHKy9KMG5LSTczSURHMDlUcFZ1OVJXVE8ybGZ2b1pX?=
 =?utf-8?B?R0pNNkV3NC9rQXdjb3NxcjQ1bjlSVXA5dW9JWlo0OHJ2OHo1M2tuUEkxT2lV?=
 =?utf-8?B?WGhwS1NSSGlURTc4R0xtcG14TThja0YvV05zMzhpNmk5RytOOXpCZ240T0Zs?=
 =?utf-8?B?YUxPN0VOY2pON1hKczdXNTlvbExjdEUvNkZpMTNBSE1kQ1Q5UW15WEIzdDFx?=
 =?utf-8?B?cU9maFcrMEZMbEdqc1V6a1RrMDd3amxHU3V1QXlMcXNxY3hGMTk2bWJUWGQz?=
 =?utf-8?B?MzRIdC9mblpsOHpjN0tqZWc4TG5mZWpkVks5V0t4aVJUY1Z3WVkxSm1JNjJQ?=
 =?utf-8?B?OE00bGJ3L3lNUktHWUp3MGJUYWZpdnNUa2p1c1ZVTXdzYU83bjZhYUVrM1Ri?=
 =?utf-8?B?TjVCamJlZ2RnTksyZFd4TC9HdUdMTXV0Q2JHQ25Rc0hVQUd1YnBYRzF1SCsx?=
 =?utf-8?B?L2hFN25zb1BocDdvclV0RDJBWDlrRW5yQ0FJYStsNGVZTFg2RmVZNnUyTmRU?=
 =?utf-8?B?Z2M1YjhrU2NMVDVocm4yK2E5eWRTa1htbm5IV3JFZDI1dWFDK2RuUy9Nd3Ro?=
 =?utf-8?B?dSs0eExHcGF2Q3JLRGUvZWYvZXJ1Zk5YVks0MlhuTXU5Z0ZGa3I0THhIZHpx?=
 =?utf-8?Q?x1jvYPnj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edc9c06-8de1-4b9d-5b16-08d8befc8c85
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 17:38:37.2480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q54u+i/JQQ1blm6/sJ+svKVF8dhUYFxDYW34Y5ScVGKzqm8rhBEbqKIUVBNXMDQcGiaZqB6LGTOJ0+9MHX2qSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The msr_pstate union struct named fam17h_bits is misleading since
this is the struct to use for all families >= 0x17, not just
for family 0x17. Rename the bits structs to be 'pstate' (for pre
family 17h CPUs) and 'pstatedef' (for CPUs since fam 17h) to align
closer with PPR/BDKG naming.

There are no functional changes as part of this update.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 7c4f83a8c973..34368436bbd6 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -13,7 +13,8 @@
 #define MSR_AMD_PSTATE		0xc0010064
 #define MSR_AMD_PSTATE_LIMIT	0xc0010061
 
-union msr_pstate {
+union core_pstate {
+	/* pre fam 17h: */
 	struct {
 		unsigned fid:6;
 		unsigned did:3;
@@ -26,7 +27,8 @@ union msr_pstate {
 		unsigned idddiv:2;
 		unsigned res3:21;
 		unsigned en:1;
-	} bits;
+	} pstate;
+	/* since fam 17h: */
 	struct {
 		unsigned fid:8;
 		unsigned did:6;
@@ -35,36 +37,36 @@ union msr_pstate {
 		unsigned idddiv:2;
 		unsigned res1:31;
 		unsigned en:1;
-	} fam17h_bits;
+	} pstatedef;
 	unsigned long long val;
 };
 
-static int get_did(int family, union msr_pstate pstate)
+static int get_did(int family, union core_pstate pstate)
 {
 	int t;
 
 	if (family == 0x12)
 		t = pstate.val & 0xf;
 	else if (family == 0x17 || family == 0x18)
-		t = pstate.fam17h_bits.did;
+		t = pstate.pstatedef.did;
 	else
-		t = pstate.bits.did;
+		t = pstate.pstate.did;
 
 	return t;
 }
 
-static int get_cof(int family, union msr_pstate pstate)
+static int get_cof(int family, union core_pstate pstate)
 {
 	int t;
 	int fid, did, cof;
 
 	did = get_did(family, pstate);
 	if (family == 0x17 || family == 0x18) {
-		fid = pstate.fam17h_bits.fid;
+		fid = pstate.pstatedef.fid;
 		cof = 200 * fid / did;
 	} else {
 		t = 0x10;
-		fid = pstate.bits.fid;
+		fid = pstate.pstate.fid;
 		if (family == 0x11)
 			t = 0x8;
 		cof = (100 * (fid + t)) >> did;
@@ -89,7 +91,7 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
 		   int boost_states, unsigned long *pstates, int *no)
 {
 	int i, psmax, pscur;
-	union msr_pstate pstate;
+	union core_pstate pstate;
 	unsigned long long val;
 
 	/* Only read out frequencies from HW when CPU might be boostable
@@ -119,9 +121,9 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
 		}
 		if (read_msr(cpu, MSR_AMD_PSTATE + i, &pstate.val))
 			return -1;
-		if ((cpu_family == 0x17) && (!pstate.fam17h_bits.en))
+		if ((cpu_family == 0x17) && (!pstate.pstatedef.en))
 			continue;
-		else if (!pstate.bits.en)
+		else if (!pstate.pstate.en)
 			continue;
 
 		pstates[i] = get_cof(cpu_family, pstate);

