Return-Path: <linux-pm+bounces-25132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923B6A84840
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4E24E13CE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB5A1EB9E1;
	Thu, 10 Apr 2025 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mux6jYFP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF31E990A;
	Thu, 10 Apr 2025 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299656; cv=fail; b=hPBHbUnNjWamDdMSMXMXSCcZso+K+eJAPoePMg95THTRGVBrz5m0y5X0ZHGBpZ+cjJeyBcRgWQFYiTscxHytihrS9lHizVf/kYKeChF60yNBZ5GLLXpFoyNrFNwJP32pZ6WUmz90v17u2x4b+h2C6ZR2cYSZwWfV8AY1225OJ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299656; c=relaxed/simple;
	bh=sC34rv3qKqOPHR08ZWQVR9Sm5hFWhJJXn16+Pqij9LY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U8f6cyoQ7VZN4HJIKFhSs+QW6OEvekNhJ5wEXxUXfu3QTSrQTk2aNLynwtD9xSFu0vH088Iw8TE6Rkd0NJcbAWpi9IOVcUmTxUFcLWQgSgYTS4wr9eKBUcRcUwNI40o6g4s6sWnRWWyJXFLFfiekBfSOl8osgjROsAN0uaR16ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mux6jYFP; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAdnz+xBOV1VnC4e+tfHoNypjvKioy/U96FDFIm2oCBl15loWCDKs0HuIDV6TpRpwphFPhGJf31lebjKZyX5xBNwhKSc13FNzXgWv081UBPrn3az9dUVDrlQZ8DL+X4YT3aYO5jPLQew7O6WPB3w2ZyY76AHzLv2sr15VuaGtP8TEAuYAxn8QQy93VvofFBJ2Oww85jQGWVZCZCJaBC8EmZo6/9VlKdLhR5RO6kVwnTFfvPhQZtuTyYIuo4+xjgYg40xO3/uICwyJg4uHIsNZLdgSambrR8ILbhACTkR0Bte1WQieS3fvNPUhBw1GdLbaUyFbM8H9vL172j/sW5kbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ayX3UXRdwDTkHu9MVJ2+t6aCpOLMazlxvw4GpzE+yQ=;
 b=RlCdVklOjjOIDRyo6tBpuG/gjuwqlWHEXFDPomNmHteZ1+NUdEqLYDGHaLZZyt4AStJjatiESQw0gx8PSjOMm40pcFd0DVwa67Adt5Xrg76lrZxTbw2GMQD6SBhaCC6vqO+DsUi5tpYbI1ibPnwE0r4uzgU8f1M8HIi4u/voUvhgJ3o00wzri6N7cjiojDcKzIuFWPCHU50ZU2ZE/wS7MSVnqsKsgDHntlizyH8LS3sBy2sJGg97PXmRdeLRaYv1iVpIkLfq6nbRNGM9KosrlLddhlUdXqKWo5rdgF30Z+AnSNJNOaY7mzvw0A6WxuevQ9U7dqt/9cgPmtIG4VosSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ayX3UXRdwDTkHu9MVJ2+t6aCpOLMazlxvw4GpzE+yQ=;
 b=mux6jYFPYoJ6v4zEOa5nTlHu0S16sG8WV7ZGaXwlvKyIM3CjjT944o5v/gUI3lLzpPE/VGb9fR6ptIWGTmcG5TQsHU71UTH3ZlvrXGAuGBTXGzQHbqvp07fHLEO8+n9sPsBaJ7arXcUgFtR5YS1bmPij8USJIYVrWFZb8iS2+pI=
Received: from SA9P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::28)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 15:40:50 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::40) by SA9P223CA0023.outlook.office365.com
 (2603:10b6:806:26::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Thu,
 10 Apr 2025 15:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 15:40:50 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 10:40:45 -0500
Message-ID: <c72623ad-2e52-4aaa-b2f2-11e88dfa1648@amd.com>
Date: Thu, 10 Apr 2025 21:10:42 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] sched/fair: Dynamic asym priority support
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Waiman
 Long" <llong@redhat.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>, Huang Rui <ray.huang@amd.com>, "Perry
 Yuan" <perry.yuan@amd.com>
References: <20250409053446.23367-1-kprateek.nayak@amd.com>
 <20250410105231.GF30687@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250410105231.GF30687@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3e644b-3b9a-4513-e7d7-08dd78461221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2lVUEpFVy9hQUVQR2xxZXljaGNsbjdxdGd3TEY3VjNpVDRMdFZGNXVrc2k2?=
 =?utf-8?B?NFh0K0ppcHZNMDNBMGM2dTh5Z2xFL3VlajhKc0kzQllRYWROT3pwSjVEZFdQ?=
 =?utf-8?B?L0NkY252dlZaK0hQQmpSL1pEQis5N0hsczBjZ0pTL2hFczRaMjlqZStiT1di?=
 =?utf-8?B?WjBWVWo0S0RleEtNZ1c2TDBmdUxHbU12K1BFQXZ2eVVLMXFXVThPK25tby9U?=
 =?utf-8?B?d1RaVkJSc2lQK3VpNW5HY2thVEVCMUR6c0pad2dUdTBLdXJHc0ZsUE9IYkhv?=
 =?utf-8?B?NURaczBwb1NobnlKRTVKVlNYM29PU1RLOFVQTjFrT0dMdHd3RC94OHJwVUlT?=
 =?utf-8?B?ZUREbWFOYmdpVDNkcjZrbENSWnRzekxuTnRpMitkZXIxc0F4NHdTTlhHNXlo?=
 =?utf-8?B?K2xYZ0l1NDV3SFRSekg2UkRSWG94djRaVUhnaXpQMjROaG1GT0FwNUdibnpE?=
 =?utf-8?B?YmdUVXFIZ2NzWkd5WWswNkRIcWhyOFM3SW9LaGg2MHc2Qm5rTHdJT2gwallB?=
 =?utf-8?B?d0trYjc5aEQyMytxTWg0V2lCb2ZSVTh2WWM2NVpyS3ZiazFmZldxd1Y1a0Z0?=
 =?utf-8?B?NWk1RlZHVFdhSDhQOE1mckxXU0hBWDVPQ2lHbHArOTNuRXBSNHcvMnBEWXhx?=
 =?utf-8?B?MGhkbGJaZ0NIWmh2NXBaRWJGbEFSVVpCclRlbERWVVZmL1g2cWxRM1ZDNzhF?=
 =?utf-8?B?Y3l6c1R0a1F0ZkQ4NDVVNjd2UFV0SjBJRkgxazFKRU90eW84UzY4NVBzcWls?=
 =?utf-8?B?U3NmRmxQN0FES3ZtTEhaRWdoWU5xVURPaUpqc3lyZHBZRUtSdFA2MElnUzVG?=
 =?utf-8?B?UUxnTVZpamY0dUdpbXZCblNXL3JVRVJ4N0wyUzcxRStpYjYvQktNbWdaSjAr?=
 =?utf-8?B?YXc5TllzQ014eU52djlrTkQzRTJRRjRLNzZteUtQZ0ltUitoZE5IMVVKb1Bx?=
 =?utf-8?B?ZWVqS0JSYkRIWnhqZGpUUFRYYm05Y2dhYW5mc3NkUUhUUkxodDhhT042K2lZ?=
 =?utf-8?B?T1VLWHBLU2dKTEl3ZGZsSU9oVXdRd0NqR2pzbWkzRDkxRkcwY3E3czNvdHFX?=
 =?utf-8?B?VDNxbFdxRmJUR3Bjd3FySjEzZFgyNU1POWRKbDA2TzdTMmxPcWt2dUtweWRH?=
 =?utf-8?B?S2wrbFhDU1V5T3JWMlRLdHNRbGNaVmpoSmJaTHVYTmx3QXJOTDc0ZDArelhG?=
 =?utf-8?B?YmVpelNjZGQxUlpQNy9POHVCOFNjVFFVZzdjakR6RmYwVHZrVEtCdGxZVm45?=
 =?utf-8?B?M1dxbWZMVlJ2NU5CbUtLL2d6Q2xNMXJ5eEpwVU56STRhcXROeHhHdGRTM0xm?=
 =?utf-8?B?MytxdkN3RTZBTVFJaHdEZHl2OEloelREVXJ1YytnUW5QSElpN1BabHBUZWty?=
 =?utf-8?B?N2xCaEdGWElmdXBoOE05YngrQjFRTHJkbVAycWNVTG5DRjAzTVVVYU5Na2dQ?=
 =?utf-8?B?VStvZVl3SjZjWGNiSXVjWlVZS0w5eHF5U29CWGMvN0tKbTlQNHRqK0JRSmNN?=
 =?utf-8?B?ZC9wVDFSRTJGTnV1anEzMlhVaUNQTWMyeFFhN0EwTnplNnEwNUg3dWZaVDZW?=
 =?utf-8?B?RlZlRS9oMEdYVC9nSTRFcnJ2SUxGWnNNUGdPaVFOL1FsU0dsenM5WG1oNng4?=
 =?utf-8?B?Ym5PbXlGUlNyNmdZRFdwbzQ0eW1NOVhBQnNDV3hLOVJKemlpT3I1QVlpdmc3?=
 =?utf-8?B?TkRqYnFiUmR6TnhCajNOUnZPdGhxUEZQd0dZMzZSRkZUVGJXZ0tRaGdqYVJp?=
 =?utf-8?B?d0lrcEJFeWJ1eHNOZGQ1NmVYU0dYQzljdEtXMEVNMjVNUEdLZGFQSGJWRUk4?=
 =?utf-8?B?VmkrY25GTk55YjBhVmFXOFpJcEhJb2NRYS9lSTJJRVpVYTFzTWF3dnlFaGZP?=
 =?utf-8?B?VFp5QlF0T01id1V1NGFONHJNSjlMVC9yMTJZTm9nOURKMVlsdUd0U1BFVjh0?=
 =?utf-8?B?dytjRXVpTURxU3BYd2xDQUhuY0JJdzhNMnh6U3dISU1XdVNGMEZpTDJIZFNS?=
 =?utf-8?Q?jvokTsOI+qFsHrJWSId64Cto5RGJ28=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 15:40:50.3265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3e644b-3b9a-4513-e7d7-08dd78461221
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902

Hello Peter,

On 4/10/2025 4:22 PM, Peter Zijlstra wrote:
> On Wed, Apr 09, 2025 at 05:34:42AM +0000, K Prateek Nayak wrote:
>> K Prateek Nayak (4):
>>    sched/fair: Use READ_ONCE() to read sg->asym_prefer_cpu
>>    sched/topology: Introduce sched_update_asym_prefer_cpu()
>>    cpufreq/amd-pstate: Update asym_prefer_cpu when core rankings change
>>    sched/debug: Print the local group's asym_prefer_cpu
>>
>>   drivers/cpufreq/amd-pstate.c   |  4 ++-
>>   include/linux/sched/topology.h |  6 ++++
>>   kernel/sched/debug.c           |  4 +++
>>   kernel/sched/fair.c            |  5 +--
>>   kernel/sched/topology.c        | 58 ++++++++++++++++++++++++++++++++++
>>   5 files changed, 74 insertions(+), 3 deletions(-)
> 
> This seems reasonable. I'll queue it up, and unless someone (robot or
> real person) objects, we'll get it merged :-)

Thank you! I'll be ready with a fire extinguisher but hopefully I won't
need it :)

-- 
Thanks and Regards,
Prateek


