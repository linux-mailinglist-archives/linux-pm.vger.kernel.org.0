Return-Path: <linux-pm+bounces-23637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50750A56BA6
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 16:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8892218982D3
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA36221CC70;
	Fri,  7 Mar 2025 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fEyDiOwk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3EE21CC54;
	Fri,  7 Mar 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360557; cv=fail; b=u5nFJ/toyxrcdjCM++R+u+iDFvGmNjYbtc0YvZdgyLw9I3UeE1JBLHivB4t7nUOkleHb38V9xKaZMPdsKo6V2icE5aP/CRlZmiUrNJHRMj3Ku7g0O60zvY7Q7YjSXRL/3MKIBYEyT51AA+IflCDwvfhE8UhnFdFo78h3my/p/EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360557; c=relaxed/simple;
	bh=26U2HYSooBSQxXdrsKKWaCp4M2OQfOKdx9czzYtkbIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nG2GZxcADKklnddFy+FmrWMzjWtAosRpKHe0jswbvwZ6zBvH8tkJF7thTo79O9LtseHeXG0BQjIxpAqkIcYU0NxbceodnNVfHj3bXvLMkwBkb/cAz6ljjnR2Kne3pjQbwZ7mFpOqxPRum33a3jVJROjCMpWbVGdyRxGBj75s2SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fEyDiOwk; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYSOBC4UaXBgOHlXNUW3IDmvyuC4DYUIktMBydFuWjyDvpVY9KOSz8ZvkbfJAwr5JVZOdPAa68kcnbLHbqP3sGcoHIAi7n6OtI1yftFJV6KmMuGLmNy3vkIAprFSLWrPYxkO4+RUGNXABW63TR3VQtMbSRqBDZh/bJHNNoWH6U69jevi4vzEmjFyRgSnhNbLGSWo5qTlYz40/YU3fE8lxrin5r95ItsJsnlxIN+b7j4OGJG0TNKGspEk5FE//dohaPP5ZoapLQ1TzPpF9HdiMws788QdSh9RU0D2AeZIzXkEzb48acJFoWPcRqq5s3CJlAh6qo6c4tNMxUo5Vp6s2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSJzCpmzRE2MJD9aKlUZKUX0tD2CMTEIOmGSdmUM+Jg=;
 b=j1y6l3xqXvQII+H2CHHeqWjrp0JjH+dfWscStuOGMK0YSQd3fFFhvf5X3NmbSpxDvPuvxMw9MX8eQgDeeVakYLrwOE3sNVxxkVJtYk3eGh0NAy1gVFFDObu1+FhhQAJbZIbeCMhDIs1AokfiXohfLTETQAIRjrRdtIo733p3GGL2CRTtMpGZOWnXO85KQiuNUh5pEdfQgKeWpQKFbNwXhfVxqmypQOEt4EGamhK61rKDPdy4q2zgZs2pAyNTCGX/d/geweb06/r/vKbG83i7J3PvFXs8vdeNchEtT+IfnI883ujTPvuPSAtTqFUlxCKVLfzM0AIMEDrQ/nOKjcV+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSJzCpmzRE2MJD9aKlUZKUX0tD2CMTEIOmGSdmUM+Jg=;
 b=fEyDiOwkxJJdygwVpJn3dcLsz7eYbUFYM+q0gQlMHbJV3+romdeoupAWK5OIGpLwLvrG5LQ+M8RKMs8LQ0tUY4Kll8e0CtkuTuUs7kPYV9m3DRI/hnMDLRnfJ/9mr74dU52ZGcnH41BDLd2oqMzjACtjiUYuv7eX1e9RJxVpwrgz4z2VyJnniE/5PGYCabyhxAAS+m3E0Zz9thO8rT8Abx1BEm5crU3kUaJ4wq4AGmDwABqbAAb52rqNz8pNjkNZ8zvmPfI3yWqpxvT9kLOetdi+5uWO7rz+n2vLQ9uQPTP4LNEhfMlLMMcxDTj7VTeeSPrrzAMWj9LUU5VhEGaxqA==
Received: from BLAPR05CA0038.namprd05.prod.outlook.com (2603:10b6:208:335::19)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 15:15:51 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::79) by BLAPR05CA0038.outlook.office365.com
 (2603:10b6:208:335::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.11 via Frontend Transport; Fri,
 7 Mar 2025 15:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 15:15:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Mar 2025
 07:15:34 -0800
Received: from [10.41.21.119] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 7 Mar
 2025 07:15:32 -0800
Message-ID: <c4ef9787-aaa6-463b-8c7d-6772fc208a48@nvidia.com>
Date: Fri, 7 Mar 2025 20:45:29 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: tegra186: Share policy per cluster
To: Thierry Reding <thierry.reding@gmail.com>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Aaron Kling <luceoscutum@gmail.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, Aaron Kling
	<webgeek1234@gmail.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20250216160806.391566-1-webgeek1234@gmail.com>
 <20250303100306.rwaosbumr7omcqce@vireshk-i7>
 <fndrufuwpt4nptgs7hlucio6j7ia5sc4yeyasrherdv4dxs7s5@p4y6wsa7mxin>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <fndrufuwpt4nptgs7hlucio6j7ia5sc4yeyasrherdv4dxs7s5@p4y6wsa7mxin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 478202ff-004f-4e82-2a46-08dd5d8af2ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1diOUhQSktDUTAzdFNqVHpoSjFzT1FPMk9KY25kKzcrazY4SVdETTZla3ky?=
 =?utf-8?B?SnZRT3prR01LeUJKblBKcnhBWmMrWTNhWHQ4bnpEVVJvRmxVOUpJUGRDc3Ja?=
 =?utf-8?B?TUJvVngvN3hCWGRrQURMMXlndkJCQjRteTF6N3dPWHdEajJLMlR3em9kLzdz?=
 =?utf-8?B?ejdUODF2ai82QlRPSlRRaGxhUDF4c2xqNTlTOXE4L2xISXpXcjQ1S0xrRmtR?=
 =?utf-8?B?V0k4aW1DLzJWWW9QRDR5L0VxS1hJNEFMV3BSMk1KQ0JTWm9wY1pFdUptdWdP?=
 =?utf-8?B?cHlRZkJDR1VJVkFITUthMFIxS3U3Y3hKYWFmdEpTdE5Sc3U3eEZGdGJGeUNl?=
 =?utf-8?B?aWJGN1M2blo1MWVRMUtERko5d0Rhamg2aUo3bDdHTUNoZk5SM3RjRThkWlRE?=
 =?utf-8?B?dTJVRmpVMzN6M0lNNDJSM2g1WUVhak43N29qeTdhUTlBOGkwdnhkRTJtdDFp?=
 =?utf-8?B?TklFSmVLbGpXd0xUTDFyNUJiazFQRnFCSGl5YmwvSGhBeVpCYjRMaG15bUgr?=
 =?utf-8?B?UWpNMUFSN2ZUYzVMbzNRcjluUVFSRjY4Z3ZVZ0JQR1FMS0NqK1JVVGJoZCtl?=
 =?utf-8?B?a0tMOW1GWGhQZTVDVmxSYkY4aGh2ZkxaOVU3U0k2ZzdLRGlTYVhYNFRvNFl0?=
 =?utf-8?B?bDk4MGR2RFNDN0NTVmp1V041bWVLSVVUUXkrY29KWHVsRWpheHZRVHhySmFQ?=
 =?utf-8?B?NkZ0bG9aQ1VTbDZySzZSaGhoODR5aGtqb0hVWFZuNXY2L3dScDVZazNBYW0r?=
 =?utf-8?B?SVVINzd2YXp1TkxRcU1iQU1RdThsQVF0eThPTS9DOTF2UlJPUExWWVovemN6?=
 =?utf-8?B?TWdZT2RWM1Y2VkwrWUJBOTVlM1pBQ0lSa3Axb0RkZmsvSFl4WnFFRUhlMFBq?=
 =?utf-8?B?VEFqZStRWTgwLzRrcjJSNkNaSUdERzdVaWQ3TDVyU2k2d2VCaEdOUHpJa0V3?=
 =?utf-8?B?T0pSUHk5endRVHd4akJiTmJrYTZVUG1hSWlaK3BGdmVNVzhsT0gyMnpsd05U?=
 =?utf-8?B?enZNUlNNcmZZYWhuWHlreVpKTXltQXdxZjk2N1pJU0FvVUZ2NFJIdnQvcHV3?=
 =?utf-8?B?V2I5aXVRVnc4eFR6M3RhYVVwM0lOZmdxY3ZRTnlmUTBibFdwOFZDMFNaaUw1?=
 =?utf-8?B?bTU2N2hKaTQ3bVJTRGxNa3JNZFRRQ21BY01ockZxalFKVitzd1k0ODh1eFNM?=
 =?utf-8?B?RXNOYU1RTWVmQm9wVUZlQXFZU3FxVDRtcHBSR3ZyVlhORnhhVktKVC9sdHdU?=
 =?utf-8?B?dGorenZVNDh4KzFEM2hlRTlsN1g0UGFWWTlkVEJqNkU4TkNoYnBrZjlKYUdx?=
 =?utf-8?B?aGlKQW1PWVVyNW9NcTFGQmtPVWx1a3V1NDlSOWY2Z0NUeFR0anZoMEovSkhJ?=
 =?utf-8?B?QTA2eTA3VmQvVCtCK3EwV2RNUVFFaGVXYnd2dWNtdnpsNUFDdXZSUElpQk5X?=
 =?utf-8?B?NXdKaER4RmhmU1JBOHdlVGJrMDBsZG9rVElZM2RvbWxLNkExb1lQNUdXS2l4?=
 =?utf-8?B?OUNTUXlhUmpROWlFSmtIdzQyTG42VFJwSkx4ZnFmZzBJdmRadmJyUDc0OGlH?=
 =?utf-8?B?MzB2TE9LSC9YQnBNYmhzUHg4Y0pwZ21UbVl6emZMekhiaUNQRzhmRDFtTnFJ?=
 =?utf-8?B?bDEwVHI4L1cweHZlTEdwSFZxWHdXUGs0ckNFVWhacGxUcWZuVEZZbXUrNWRt?=
 =?utf-8?B?WThnUURQdEJiKzdscWVLT3JnTU04NEhaai9FcW42dS9meUEzcjI0bnBoZ3JL?=
 =?utf-8?B?WFl0aXFBQzZRRkxMUCtJTnZkTE5maEFkZlY5Q2MybzU0VGV1V3ZJWHdveXBE?=
 =?utf-8?B?c2ZEM0N3RDFCT2MyeVNyN2c5cjFsSFNjS2lrYzFNZjMxcWx0YWJzaXBKR3dG?=
 =?utf-8?B?SmRhUTl3aVBLVCtkS2JKSHp3WERVbUlaVHdwckxiTTlaVTNaTng1dWFjRExW?=
 =?utf-8?B?Q0RlSS82bjY5VTcwSzN4YjZLUUpkZWhtVG5mbktRV3NISjJ3VzdrN3NjWHg5?=
 =?utf-8?Q?Fo5IGpVDsGSngLvx3lm3N0bhtUp4Tc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:15:51.3977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 478202ff-004f-4e82-2a46-08dd5d8af2ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802



On 03/03/25 21:18, Thierry Reding wrote:
> On Mon, Mar 03, 2025 at 03:33:06PM +0530, Viresh Kumar wrote:
>> On 16-02-25, 10:08, Aaron Kling wrote:
>>> This functionally brings tegra186 in line with tegra210 and tegra194,
>>> sharing a cpufreq policy between all cores in a cluster.
>>>
>>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
>>> ---
>>>   drivers/cpufreq/tegra186-cpufreq.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
>>> index c7761eb99f3cc..c832a1270e688 100644
>>> --- a/drivers/cpufreq/tegra186-cpufreq.c
>>> +++ b/drivers/cpufreq/tegra186-cpufreq.c
>>> @@ -73,11 +73,18 @@ static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
>>>   {
>>>   	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
>>>   	unsigned int cluster = data->cpus[policy->cpu].bpmp_cluster_id;
>>> +	u32 cpu;
>>>   
>>>   	policy->freq_table = data->clusters[cluster].table;
>>>   	policy->cpuinfo.transition_latency = 300 * 1000;
>>>   	policy->driver_data = NULL;
>>>   
>>> +	/* set same policy for all cpus in a cluster */
>>> +	for (cpu = 0; cpu < (sizeof(tegra186_cpus)/sizeof(struct tegra186_cpufreq_cpu)); cpu++) {
>>> +		if (data->cpus[cpu].bpmp_cluster_id == cluster)
>>> +			cpumask_set_cpu(cpu, policy->cpus);
>>> +	}
>>> +
>>>   	return 0;
>>>   }
>>
>> Thierry / Jonathan,
>>
>> Any inputs on this ?
> 
> Sumit,
> 
> does this look reasonable?
> 
> Thanks,
> Thierry

Looks good to me.

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>


Best Regards,
Sumit Gupta

