Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F76300A39
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 18:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbhAVRmw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 12:42:52 -0500
Received: from mail-eopbgr750049.outbound.protection.outlook.com ([40.107.75.49]:65531
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729615AbhAVRjT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Jan 2021 12:39:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4bCNmV7ux4ogjrJuIm+Uv8dejuhaaPLhJwq0ix5iZxFht1ykVXSZD58huwVZ0eVflh6lk4/w9JCIRXwjY/knp/uf0Faw2VJDRJuN9gNRZn20hey3kq1oL8qsS2+C8azWsC96z612de5hCG7bmEbeU/C4B6EsvAf+1UglJJJE9hFiQjuJSuvzlN5ucvVyVl78Rl6GPcWC7U5Yy2QWqpxLQJ+c4eDCZr1a4j21Wcdk5EB+8cGZccPGFKRZNYW7D59qLg+Q/Xv5iXtlOd/tX+YwdWafMSVrpDeybDNjXqUj4H4Lrmi23bBgDYszI+nCxmTwTkmH6rCXZRcyWpM6wb4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek3z8lK0lusmaTz8NlufGNTUvIUldEExjxJLitKaBPo=;
 b=ThBBU4//SnXmJfggBLk2eYG0g71qIojo1QhxjbTIGiJu7x6AZJKkySxFV4zgew5BN65hu6Gmyq4WYnvclEs8iiNBBZMjkJMjEjIEMZ2nwP22KERmPj2pJBv13B6jL7uLKjSvpydKb3IHXbUbn4yns/vyjbHGmRiS1clfcpy2DZgvEjGNaG/9OAcGxP2kodibMpZV02pZfbLCq9MeYdUyxfDjF1LLlz44cEXcOLw5SR3NddsUluk7YF44wbQax4sbeSsxLE9UXuagx30NoiTOO1IGKuc8+eYzZn8RORLVCjZ4m1zwyQI4wwVh8WZJkuMYkIsu37rkIAsn3Q3oOsfTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek3z8lK0lusmaTz8NlufGNTUvIUldEExjxJLitKaBPo=;
 b=iIXb5qXkkHQaZQKDZMfpUPM2iEG48KojQFIM5RimKpL9XlhZpBFVBzCb9IqXFrbeMUAWkcrArrN5eUsxczVO25IvvXNFaWGfJeiKfHCR1lTEXXfGtfrm0KB56blKIFW3G7eCymb3k4IbW2p/69Ice3CCj9uoHp7dpDHf8crZHlE=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 22 Jan
 2021 17:38:29 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 17:38:29 +0000
Subject: [PATCH 0/8] cpupower: Updates and cleanup to support AMD Family 0x19
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Date:   Fri, 22 Jan 2021 11:38:28 -0600
Message-ID: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0501CA0083.namprd05.prod.outlook.com
 (2603:10b6:803:22::21) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by SN4PR0501CA0083.namprd05.prod.outlook.com (2603:10b6:803:22::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.6 via Frontend Transport; Fri, 22 Jan 2021 17:38:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01ff6c3a-80ac-47f5-d04b-08d8befc8820
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2846505C57434DE21D932A03ECA09@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFSCfZTEEZruMPnCHm4nLgyZfnx52Fte/jdzwvTh2RBgSnVwctfuvhK5GMteZJtKBVcU5pRKlQn9K5aFm6BAmSB2AZilqwhgcCaQDi4ZQvCdT6BP2/vfexGxvrfFx7+XOoUpnIB9gIHzJ0ls3+x4eZu6FUsBdZwPViDeBR3+j4kZ9OmwfpEhlfr1cbcEO0VGjXOSnjeyCqG2X+LYX41zIrpdlwhanvYVgIZGC1eqPFy4e37KLSdFuj8EJXJZzf8wkpetiqSbfEg8TMc14iSGv1Q5qDJynb2K/XjaV687Jk0mdNPWIF2HPKFIyzd346yeEHs1LIBOLpKHtH+btiLccV2ipqf1SnJry7CNVzOUK2eoo9jFkLe24svLM+tUxQpNlQEasAskjsJzP+5+mbH5xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(103116003)(8936002)(52116002)(86362001)(44832011)(7696005)(66946007)(66556008)(66476007)(956004)(5660300002)(316002)(83380400001)(55016002)(478600001)(186003)(16526019)(26005)(2906002)(8676002)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aTJBbGlwYTU0Uk9OSW96TkNtYVNCVnkxTGY5a2VRcEg2dTgvUkNjVGVZK1ZC?=
 =?utf-8?B?bHVsVTlzS1hGYi9nUm9nT1FiMHQwUUdua0x4eEo3K3Q5Vm5QNUdPVEl6THVW?=
 =?utf-8?B?cTI1MjUwZGxCN0hJdlMyamtWa3p3R1kvMUxieVEvd001bHBsVHNHZlltM1Vz?=
 =?utf-8?B?czRTdWdGQjhQYy9Ka0tMMnJtek9tUmk2ZXNaQnllSjV2YUNqYVZUQ1pXbG5u?=
 =?utf-8?B?OTlSZ09PQmNBMjlZS2hleHczUDh3RStoNDc0cWNLY2NSTjF4NDlheVRENFlt?=
 =?utf-8?B?QUdIbW55YVByd2pVclBaeFJMZ1NGK2sxSjVMSzVBUmJlY0syNXhJMHJmbCti?=
 =?utf-8?B?M0N1dk5QNU5ualUrNzFOL3RtYW94SkFJS0s0N2lhays5eUVJam12Q0tyT3M4?=
 =?utf-8?B?eHZnVUNoNy9SaWJvM0Jzd2NtQ2V4K1lYUFZVTmlxNm1TRVpLSjJxejZzV3l4?=
 =?utf-8?B?SDBTQytpbXR3d1pqWWR5TEZMU1owWHEyZFhnU0RuNjhCSmtUaTV6d1BJRHdj?=
 =?utf-8?B?UFRydk5Ya3JlSTV6anhBZUZiaUZEbXVHMHlWdyszanlsdWdaaWhzSzd2MHlu?=
 =?utf-8?B?NkgwSWVZSDlERU52T2JxVjVuSGVaVDZrUUc0cmZaY05EQ2JXSnRhNVdhVjRB?=
 =?utf-8?B?THRMRkI1UXhWVklGVjZZeUlLc2RmOEE5SXU1UXJPQ3VvSjlZVUhZZ25WSVV3?=
 =?utf-8?B?dXFXZEx4eWM5dkV1cDV3eTdXR0U5ZllGMVVETVhuV2xHOTF1cWtTZFJ0WnF0?=
 =?utf-8?B?VnVMYUdDTE1QdmhWMnJiYVQ5bkFmUlRwWDRNbEV6ZlNyeTdjTXBBMldoOTZ5?=
 =?utf-8?B?MmlITE1MRlFzQmtwL1lIMnZLNWxicDFEZFg4VzA1UU5HOW5RM3NHVVJVVU5y?=
 =?utf-8?B?VHJ5Z091aFRrRFlUd0w0Nzh1RVZJK0VjTVJiSE1JSElNSXkxM0V0NDBCbUV2?=
 =?utf-8?B?V2tYbit0NmxrUWw4RWdRcGVFWkh6VTErYnQ3UGR1RmE2QXB2WStCRzhmN1BH?=
 =?utf-8?B?ZW1rOGtZcVZiZkdiTzlUTUtOTG91MlQ4Z3JCR001aGM5bFdGdnNCU04wcWdp?=
 =?utf-8?B?OGRFSGhjZk5FRVFoTWU4cnlWQUoyUXYvU3YrM2ZSU0xVM3pVcXZlUVdYMlQv?=
 =?utf-8?B?bXM1d08yTHdtNCtxbUdLUitCd1l5eWx5VGhiMUxnTW55UjZ5ZEtXM3dES3Y1?=
 =?utf-8?B?WGxZSFlJODFKc2hudTlzeVV5eWl4a2QvUWJNclA4R0lndmJ2ZGlyS1k3aTA4?=
 =?utf-8?B?OHFGUU56VGxpUmVzSm5BTnRBQmExTXFUWlBYQmp1Z1pvZFlLRXRjeTk0TzJr?=
 =?utf-8?B?cVQya1lob3Y1VmkyT1NoWkhwZURZckRHSWwxM1c3Nm1rNzNBekJXdGhXQmlw?=
 =?utf-8?B?YkJBWEYrY1RuZXhSNlFpemdFd1JObmJKSkRpeWs0SkJGbWtCNDk1aDgwc3do?=
 =?utf-8?Q?Qxyh5VY6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ff6c3a-80ac-47f5-d04b-08d8befc8820
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 17:38:29.8762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQDbAmSPMeYyD76LB2Tc+AsClaw7Br5vJIMiKgHZezMlBtSmnv2FRQa/WkNVGqHhm8Lw+tLYf6hBguxQ/qwhaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Updates to the cpupower command to add support for AMD family 0x19
and cleanup the code to remove many of the family checks to hopefully
make any future family updates easier.

The first couple of patches are simple updates to rename the structs
in the msr_pstate union to better reflect current support and correcting
the name of the CPUPOWER_CAP_AMD_CPB cpuid cap flag.

Patches 3, 5, and 8 update the family checks to either replace
them with a new cpuid cap flag based off of cpuid checks or check for
family >= 0x17 where removing the direct family check isn't possible.

The reamianing patches are cleanups to remove unneeded extra enabled bit
checking, remove passing no longer used variables, and remove unused
variables in decode_pstates().

---

Nathan Fontenot (7):
      cpupower: Update msr_pstate union struct naming
      cpupower: Add CPUPOWER_CAP_AMD_HW_PSTATE cpuid caps flag
      cpupower: Remove unused pscur variable.
      cpupower: Update family checks when decoding HW pstates
      cpupower: Condense pstate enabled bit checks in decode_pstates()
      cpupower: Remove family arg to decode_pstates()
      cpupower: Add cpuid cap flag for MSR_AMD_HWCR support

Robert Richter (1):
      cpupower: Correct macro name for CPB caps flag


 tools/power/cpupower/utils/cpufreq-info.c    |    3 -
 tools/power/cpupower/utils/helpers/amd.c     |   62 +++++++++++---------------
 tools/power/cpupower/utils/helpers/cpuid.c   |   20 +++++++-
 tools/power/cpupower/utils/helpers/helpers.h |   14 +++---
 tools/power/cpupower/utils/helpers/misc.c    |    9 +---
 5 files changed, 54 insertions(+), 54 deletions(-)

--
Nathan Fontenot
