Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14403302935
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 18:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbhAYRnu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 12:43:50 -0500
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:64288
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730850AbhAYRgp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Jan 2021 12:36:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjD+urSjvrz8V8PaFn/a/hRk8W/aqvr5FHePPOekKqj1U1mgy8vfMYRRc1AhRJ7e2nQeueXsFp3X8fNbPzXemalcGqdShwyTpdBSS2Yz0PkCs4L0hhWUT8/MojWlQEsMs7+YKeUP0Su+/ljIy7tjaj+r5AVdfUD/gtjjkYP/tB3Xb/2GEjtAc70JdubHGqI+W+Z+aPWneoD5iYXg/kkl1cUlJSgoTapSrP9b/kRaXgcdC8D/nDVf76kwcWh53QEfJ2gqeRr9cDgIaru+mpF+twjpLXHjkKz9nvcp+Q9rX0mDOurXVM/jJrpu8qVemd+rF3ce9xPwZSFNlqr7MVSqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XceB1BCT5EN97DuHT6dB6Q54FxGRuygR5bRGOk5yhbk=;
 b=iZSdw0aVL1i45c8m4vuw7WEmWF82rlqeA8ZG9iFVmL2oYReQldT2y+kz8e6wb6c92rvKtYoAH0ZrTqxbhym6uCfoP7Vt8QpM4ew9CgnTvL38X6mqvcvpxQmvxNUlbbaTstiYJEPH/K0TlWY5gs0NgIDlZD/SEMsaxvnKPis39CJCR0+OVa+gSNgUSPm8OEZ36+r49vUA2n/iKY7zZQASuBI+nHJguUOodh8tUZ9mk7NfJByeva5g69hXRf98qwCTHh5Ncy8yofbzK0n66Ovcj7Qk0z1Y9dbOo+qwfqpIJ6YKicklv2571VhE535VSOu2S4ZuMBapNpfp0Po7aq3FjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XceB1BCT5EN97DuHT6dB6Q54FxGRuygR5bRGOk5yhbk=;
 b=xD9ORPsJ+yzxfhANipfLEp4/hu/q2h6AGsfciaFUwRZjITpFUw1MvIn71k4GgiiJHahjjfFJZTBPGopxuOdU3VR3My+G9sH4dgI0AiCFHhjOmnYbfPE2FT+pk9OHfQ5xuIfjXDwpDnOPi5ufEGGpDA2iogYcGX/RCrr75lRiY1g=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN1PR12MB2576.namprd12.prod.outlook.com (2603:10b6:802:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Mon, 25 Jan
 2021 17:35:51 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 17:35:51 +0000
Subject: [PATCH v2 6/8] cpupower: Condense pstate enabled bit checks in
 decode_pstates()
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, joao.m.martins@oracle.com,
        konrad.wilk@oracle.com
Date:   Mon, 25 Jan 2021 11:35:23 -0600
Message-ID: <161159612365.68367.13306256100078302569.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
References: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN1PR12CA0086.namprd12.prod.outlook.com
 (2603:10b6:802:21::21) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by SN1PR12CA0086.namprd12.prod.outlook.com (2603:10b6:802:21::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 17:35:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4ac6ab13-0961-47e1-c60b-08d8c157a913
X-MS-TrafficTypeDiagnostic: SN1PR12MB2576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2576042FB4E4036DBE6E33F3ECBD9@SN1PR12MB2576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2JM5vLy8wUd6NII0FxsQY0IKq1M2+WEZlTPrDh9RtSJ/6VDSbpazIwhT5s/uU0+JZP63hE29JceKlkpSRpkxeR1U7dyTcIb0k4aYnS95l8syvTde/xGV+U7C/25rCr79ipW3nP7/+1Xd1+BwONT2SJ3kZUqAF4T06Geg/OScNWMizT0iekK2KrNHOP9XzzDz3wPtV+2vJWu6DmpAuo7awtRzPPv/+XIMxzkH7ZHWHrAs1uoIpPVp6qOUNh9qAW4Yt/BtUNOYb4SagQQva9QC6ezDsQgNDnn1AjvYpuicDk/oqRMvjOLGbjwkKtRxfyQBkRpWA8Youc3KgLHxLPa3aWkJQle6oRwd0dOv6/llFrs58klNnQJ7uAasOoYhk3jjiLntTB9TIvmlZxC93MMvLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(66556008)(5660300002)(4744005)(7696005)(52116002)(8676002)(956004)(4326008)(83380400001)(44832011)(2906002)(6666004)(86362001)(8936002)(26005)(186003)(16526019)(498600001)(55016002)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RndXVWxoMWxDS1BYaVc0aGs0cWl0VURaM1g0ckVZNG02MmcrRXh2SURTYnFF?=
 =?utf-8?B?THBsM0ptMVlvMCtkWHgxMkhQYWFLOHg4Nk9VNnpTZDhKSVdYcE55S2ovTFJI?=
 =?utf-8?B?RHl3RFdPVnN1dDdhYXpSRUc1MUxmaEV5bjZ2bjY3cU56VFFWR1FnZEt4QjMv?=
 =?utf-8?B?c0xkcm0zNkRDdHk1YktwQXNzcUxvMjNYaXpxQi82cU5PVE1HNlFyaG5yS3U4?=
 =?utf-8?B?MUF2Vk9Sb3lNTWY3OFFNTGlUVkVpbFg4Q3lwV2JvZmd6dFhhZmNUNW8zRkxR?=
 =?utf-8?B?VGVTZWZYMnNld083eXIzVHZqZW1ReU9RRktNMlVybFkwY1JRaDFZb3JHVzlU?=
 =?utf-8?B?VVFoT1JucldjeFBWT08ycm5qTTUvVDNXOUVDODJsTW5PbzN3LzVIYUpEVEtV?=
 =?utf-8?B?eDlKcXZ0M3lDR0hQeE82RlAxR1lNOURhSFdLMWhBNUJ6ZzVDem1zZldhMFpa?=
 =?utf-8?B?NmxEeHcxbE9HWWpEa3B1aG5adTVwYmlrM0c3cXg0WXhxQmRqbHdLL3RPbnds?=
 =?utf-8?B?VDJSMEljSWdwTG1wZ3VmNUFwR04vdjdNejduczVmOFROaHVPOTJFWHJia2tj?=
 =?utf-8?B?N0JaV0tyejhtL044ajYyc0xGa2ZzR1VyMnJLenFHMkdJRksvZnh5Q2FYQTdE?=
 =?utf-8?B?MC84bGpXRzl5UWNUcUhWd3piaFhTSTFXb05sdkxmVmpkd3VhTzY0cjR2T1dS?=
 =?utf-8?B?YTc1NzlWcVNZVDZSMGU3V3ZSODd5S0IvVVVIVEZxb285anY2NWJ4TDk3cGxD?=
 =?utf-8?B?UHFxTjFqS3BMcloxelRyQ0tvR1p0aktYV0xkaG9WbExkT3NubDlVaGRZRmpT?=
 =?utf-8?B?eWkvNGFEWCthcElxTXhjdUk4V1djbklsKzF0TU1SUzVaSFdYWTZXQnllVzB4?=
 =?utf-8?B?K1ZIYXJ3emVsc0s1cm5rbWJXT2V2TCtpZWxYM3hWcEMwRDNaUTBBTVhhMkpN?=
 =?utf-8?B?dFA0NjhwN2l0c1JpZ0ZWTkJ4ZXd4MlZYczJkMXdkaTVvakdtSGZYelROa0FP?=
 =?utf-8?B?THZQdWZhRE5TUERPai9uc2dtMjY5OHl2RWtPa1IvL3dxdzROeFNPYWdJWGpr?=
 =?utf-8?B?Z1RNV1JDeTN5TFNhQTBqNHhzZlY2eTk4KzNRcGxWVnAyUUloTDAvT1k2WHRR?=
 =?utf-8?B?UGZlRVBvVlpQajdyMXJ0TFdaYnpSLytqMEFLOGI3dlVVYXFpMzRyMzR2SUJi?=
 =?utf-8?B?eTZCekVsZ3VOamZTekw2ZzYrSmUxK1N6MDlBS0l5OE1OVjk0YzBVRm5mNVNE?=
 =?utf-8?B?UGhwbFVEQS9nYnMrMmViQUFVUXRuVVRVRFlwakhXSFRVVEFUL1ZNMEJyQVZk?=
 =?utf-8?B?aVZXVUVYdHRWQXVuZThFN2RrWDFrays4bEk4QjA2YithcnEwVDIvbGV2b3gw?=
 =?utf-8?B?VnFpQ3pTUVNjNnpVUkRFZU91c3ZSRzhpbnBIUE9MaTBEV0pwMUFtWjlVcE1i?=
 =?utf-8?Q?ehmCVOH5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac6ab13-0961-47e1-c60b-08d8c157a913
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 17:35:51.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxNeFQjZ0rKxIYjvP6fdUsjEPVwzruH5yiAq4G3QGvzzFZl1d6S/EspF6+2VQaKco513XCbTfWAG5jQ534SVAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2576
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
index b4731daa6820..216240e2b771 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -113,9 +113,9 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
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

