Return-Path: <linux-pm+bounces-41145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9E9D3BE58
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 05:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 24F6E3549E7
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 04:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1EF345729;
	Tue, 20 Jan 2026 04:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iy+BivWM"
X-Original-To: linux-pm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51934253C;
	Tue, 20 Jan 2026 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768883198; cv=fail; b=rf+PES0tLXqSGvpzhMXaaDcLUNDu3buH2xO+cJtzhM3B1KHDuy+uJG61KTqaxdgLTuehXoqanH1epj4BzHP6gIkAB55v+hMhFVYwuZ4w8AwApFxBHH4MEQz0fXZSg+S+j/aAqH0ZwS+QhDDgU8vexkAxZHNGKvrtNaPA8JUDhiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768883198; c=relaxed/simple;
	bh=ZAxweTuG09op3JbeeGlwj5lkZ37lsMdHNCyoIO/8MHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ofHzqy24K1iA1W8jTnh2EN8sVNzEbjcHfBTAIFMr8Da+zl01q01VeFuHY/RLKEIB///aAYyMLs++11ne/bDUE4+MEfx8UVefZ+/EbGj6XamPPrdUCDlLfmEF/8JNbUc4DAscfXgg0+VvyzKuYQjs2kLcmmGfFaivBzl6E98OC8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iy+BivWM; arc=fail smtp.client-ip=40.93.194.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMg4I57bJWvW0r+hQmMOXU+qOXHk2y58N7Vw5iGLv+yhQE7Tl619MgQAvxxHNniHgF3LkxNEE5WT04d855NpGH7kiMUS6MMU0cBNpCstKFnNBuMxhLcil06U/cS1B5Ov5MVo78vjYaOmcmDoHE4kjtF/INuEXg+hiqJftS3ww6nicSU00AKv3sEOu0uHeGrrlhS8RQL3E/W18EwKQ1YaJbB63EInwWGugegbRF3eDshJDvaE7g6788bodLY2pVfBT1PPKSPXGTeWTjDwRmD7W3MtjtY8HA6lSQyB1kBNsd7rR+eZI0wFZonhOBeY3nbbHTiSwX+sw/Z6zY4H3g37Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGiGywc3TY5DG7+SAEV+h5XnPCOzsETv8/1UfPQyolg=;
 b=RcZupDzCO3h26AviXJ1/lNdCikz3d9ETub1DdUtbrCAutg2ZsxUTUlOIaSXqV8bzH1PEoaE19OB/1zscsvEgWmUt7C/qXKioj+SVy4dh0Wt5Ub7iFhJYpI0ll4DrARkUdrcnfrZFhTRdWg42bZtRagZRyA8UhIcXRwL/nCLuPGFwMOmJPUTHr4DeVzSmX4cuEY8Jt0lqmL9gsLYooJQriqyjmnP3TjBnx4UpDQo3HcfnKuCMQ3dEZr+jAVROprjEHm3IcLcJjZOY2EB780YVpjaXbhyXsCLP79RiX+0zCep9lCVUs/n0ddbmy+RtoR9NmM+B/hcedIvkYE577EzpkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGiGywc3TY5DG7+SAEV+h5XnPCOzsETv8/1UfPQyolg=;
 b=iy+BivWMtTM6CEeKGgfE7jEeIHgPm7H3xuIPLq0a1eIK6KITlvDnJ+jUcSXEuPXTya44ONiKttxAmPd4DnnyM31qohUWWkzNE4dCTPsuMwt65ohBVnES6Y9bhOzdL1lHm5JskbquuLPMe0TFwublCAUw9qS986HebqcMQKiTP2U=
Received: from BLAPR03CA0083.namprd03.prod.outlook.com (2603:10b6:208:329::28)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 04:26:24 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::74) by BLAPR03CA0083.outlook.office365.com
 (2603:10b6:208:329::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 04:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 04:26:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 22:26:24 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 20:26:24 -0800
Received: from [10.136.37.139] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 20:26:13 -0800
Message-ID: <ec1fbc52-3e72-4a0f-954c-9ecf581f9e39@amd.com>
Date: Tue, 20 Jan 2026 09:56:12 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] sched/idle: Handle offlining first in idle loop
To: Frederic Weisbecker <frederic@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>, Ben Segall <bsegall@google.com>, Boqun Feng
	<boqun.feng@gmail.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Heiko Carstens
	<hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jan Kiszka
	<jan.kiszka@siemens.com>, Joel Fernandes <joelagnelf@nvidia.com>, Juri Lelli
	<juri.lelli@redhat.com>, Kieran Bingham <kbingham@kernel.org>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, Mel Gorman <mgorman@suse.de>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>, "Paul E . McKenney"
	<paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sven Schnelle
	<svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki
	<urezki@gmail.com>, Valentin Schneider <vschneid@redhat.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, Xin Zhao <jackzxcui1989@163.com>,
	<linux-pm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-2-frederic@kernel.org>
 <20260119125347.GT830755@noisy.programming.kicks-ass.net>
 <aW6ccexiQaPLQcS1@pavilion.home>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <aW6ccexiQaPLQcS1@pavilion.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 111d7472-34ce-4c05-5add-08de57dc1269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUFnT0l5YlNJU3FxQ0wvQjc5WmNUcUgxZjF4NVdqbmgvM2J5MFNCQ01jMlZh?=
 =?utf-8?B?Z1hOOUFhNEpMc2owUk5RN1dtaXUvbzBGOXBlOTlnWDR4bXlUZERUaGNuQmho?=
 =?utf-8?B?M2FITTZTUE5LTnZ2MzZwaFYveHB6czZnN2RwZDNxcnJYMnNmK1pjL2tDaVl4?=
 =?utf-8?B?eW9tWFU4WE5FcC8zSERIcDJnY21pWURIZ0VsMFdLMmlicDJrUjVVQmtjSXM0?=
 =?utf-8?B?eFRGRW5zaFpGT1d5bXdTU2J5VUw1Zm81S0MyTDZkTElxV3FXdU44d0RUdmJa?=
 =?utf-8?B?ZzV3S3lvclZQRDVoc0NDdi9oZitmOG4wVE8yUmpZQzREMjZpOE9UeVU1REtE?=
 =?utf-8?B?U3RYRHA2Z2JIRHVNR2RkUXpOWDhpd0pMQ3lzNzVqTEI5YkpnR0J0UzZvTGtu?=
 =?utf-8?B?SUxacWpGL2tCa2Q5bXVUbnMrc0dTcEpnbm1lZm1HNXRUdTNtRHZZMjQ3UzBV?=
 =?utf-8?B?YS9YZGtHMjc2MDFIYmJDK2hNVERuc29Ed2dXWWRqWE5Bek44UXhvcjJPbjda?=
 =?utf-8?B?bUlZMTU0eXgxUFRrTElyMm5JbUIyTWJ1dTFoTWQ1TForMDdPYW00RHpOT0Jm?=
 =?utf-8?B?bUlxU3psdFY3WXl2RG0vR2Fnd0Z2TnVqeE9kQzBXMytSNVl4Zzg1Y0dtbnJk?=
 =?utf-8?B?M05JQ0dyc3hTTE1qVkV2TzlncU55clYvVnEyTkY3Tzg0eUNKK1VaYTZqMlIx?=
 =?utf-8?B?Q3ZLUG1lVFBYLzlFYzdIeU5QL0ZsNjNnS3Z5ZmVZUVdXMlZPb3JUcmd1cHlT?=
 =?utf-8?B?UmRCQUdxa1RRZ01CZlNXanB3UlB3VlRnZ2VvaWJTWEVveEV4YzJ5WTU0Ynp1?=
 =?utf-8?B?R1ppZFY4cWRtTTRXa0x0elB6aFhybWNjb3R5RHBvTnQ0c2FRQ2tURkMyNkdO?=
 =?utf-8?B?RllZdDh1cUZSWjgwd0x6aStlTUVtbjIwbUNrdWpqZkNoQ2p0MG1VdU9renhx?=
 =?utf-8?B?bnlaRW44VkpQQWdHVnJCN29tckpLYlpXRGpadFloa3BuVEVSeFBiQWpOMmt2?=
 =?utf-8?B?L2dJZkJsQ1hhOXJRN1FBVEIrbjRteFdRMW9BMEM0RnpDT1YxQTQ1eFpLMWJv?=
 =?utf-8?B?Vlg5S2t3SjJVWG5mT29SVXJ2dncyY2QwNWdWaTJsanlLUXRHSE81Znl6SlJl?=
 =?utf-8?B?UlBvYmxPcEE1cTVSQ1VJSTdKU3dPN3lpUmU1NFM4M0t2VDBLSVpXcjRPNk8y?=
 =?utf-8?B?Qzg4S01pSlpSWkw3UE13MnV0bkV4UndnK3pmK21IRVhWNzQ3QlF3NGwxeHVl?=
 =?utf-8?B?RldFd3pMa1JBd2ZmQUZDOHZZMDQwZWEyZmhCTVozcmxwYnp6c0k0cnM4Q0hR?=
 =?utf-8?B?VDRCeGVST0JReU1FNTNER0F4WitPTEdjVkg5dFE1SWZ3bXl2ZDNhU25YNVpq?=
 =?utf-8?B?VmhhQnBKblN5YWRFWlIwaHdoOE0vVXpiTCtPZmVZZHVhelMwRXpiN0dySkg5?=
 =?utf-8?B?eWJRTWIxRmk3TmNMSllsWlpkdXlmTE9FQXdoUm1TNzFnajR5T0d3OE44U1VR?=
 =?utf-8?B?YUZibTR0K3NzNWVYblBSMlZQMDIzWUJnUTZ0QnVkb2F1eE9zblJrVEMvb29M?=
 =?utf-8?B?clN5dGdGNmNuT3k1N1BEd1Zmc1VBMThmQXgySXpacU1UR1huV2pCMjlxdFJU?=
 =?utf-8?B?dTdIMmtjV05JSGI0OU11b2JrQ1RSby9WNzJHZlFXOEc3Z09DOE1Rdmdkb1du?=
 =?utf-8?B?a1dpSll4SlkyQW51VVNpOVc0aVYzUkM4Qk5LSi9JY002ZkZ2WWU5b2FOcFNv?=
 =?utf-8?B?QmpoUURoaXEzMzAzQnI3RXVyd0xsNHZQYk9JSjhkWmQwT01lQkJHSHc1aXFh?=
 =?utf-8?B?dnFRRXQySlhNV21sWllydHczclp6YVVrKzNWSVhXYzY2K3ZzcjRlYStSK2dB?=
 =?utf-8?B?TWxCQ0R5dng0ekhWOWZIclA0OFd6cUNUNm5wNm93SXNNZTdXUDJ0MWU2SGZr?=
 =?utf-8?B?c1EyaUticlBIbzNVdnRENGplalArZ283M1RyWDlFZS83cEQyeHhoMU9CVkhn?=
 =?utf-8?B?WnpzaDJiY05sRUtnbEtsYitKVmNOWjFGdllUR1dIS0xVZjNsdWhUQzZkMVYr?=
 =?utf-8?B?Z2tCUnVSRFpmRW8xUXA3VkxWRGNZbnJxR05heml2aW9FYkJZRVZFeEtURGpK?=
 =?utf-8?B?M0JPakpReWJDNGxPR3oxbFhpR1Z4cGM2eHk5TVRHUnU0cWNLbFhKQUxTTnM5?=
 =?utf-8?B?OFAzTVA2elQwUGZMdHFLcm1GVmhSR0RvVWRSdXdYbjJ3MjZicGhtajM3SVh6?=
 =?utf-8?B?Q3hXYU1EMjBZaWdOWjRvMHpab2tRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 04:26:24.6078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 111d7472-34ce-4c05-5add-08de57dc1269
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781

Hello Frederic, Peter,

On 1/20/2026 2:34 AM, Frederic Weisbecker wrote:
> Le Mon, Jan 19, 2026 at 01:53:47PM +0100, Peter Zijlstra a écrit :
>> On Fri, Jan 16, 2026 at 03:51:54PM +0100, Frederic Weisbecker wrote:
>>
>>>  kernel/sched/idle.c | 11 ++++++-----
>>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>>> index c174afe1dd17..35d79af3286d 100644
>>> --- a/kernel/sched/idle.c
>>> +++ b/kernel/sched/idle.c
>>> @@ -260,6 +260,12 @@ static void do_idle(void)
>>>  {
>>>  	int cpu = smp_processor_id();
>>>  
>>> +	if (cpu_is_offline(cpu)) {
>>
>> Does it make sense to make that: if (unlikely(cpu_is_offline(cpu))) ?
> 
> Yes indeed!

nit. but don't we inherit it from:

#define cpu_is_offline(cpu)     unlikely(!cpu_online(cpu))

so it will end up being annotated with unlikely() no?

-- 
Thanks and Regards,
Prateek


