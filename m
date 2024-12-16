Return-Path: <linux-pm+bounces-19281-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6E19F2ABD
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 08:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB7997A1C6A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 07:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982951CEE83;
	Mon, 16 Dec 2024 07:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DMrK95te"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA141CDFDE;
	Mon, 16 Dec 2024 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333095; cv=fail; b=bHP+oqSrXv85QiublTuI1l9xcsAsXgaQskpK1QAEwS576BLq3cwMOjP8LaAOV6Xxxapa0e9AqLQb9yv7506ClI+m6rVEEjmz3M7BCM5J2aNYuNbPXn0+TGHY18ybclH5aFj2A/bT9bDmMvqYwXroRJKBaZNekvz5ky5b/nu21fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333095; c=relaxed/simple;
	bh=PBVnQKJRwLnIQLLnh6ScW5jA9XRTFuTS0PF/14dHunw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H2NEImFECG8JOYZsaw3urR6gvMqAzveFAdsoDTZwVoQ4gEXHcSKE6yb3IoYDnwZkGVskumc9kLmA7REHffiQyjXCr5aWIuiygi5+FH8KmOB5IHYwEPhm+qQyDrvxJZp0/QNlkxf1kzNGYB8PH6Cdah2a/oLYPNvnLDIURAXrU48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DMrK95te; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dp32rST7D5SI4UkLPvIiLegmYqhoI4jAbsiR+2RwJIajPMB+ch2l6fRdMoYHf2oPan3roeAjPvve6gDh3jpMVaiHT6xp3p5HfBIn52gDd4fkl6A0dl85QoiHhn5OvkyjiprID2dfYc7e6DwrUXmBH2jVppNy/8G5CWSN62URxLnakhlhjFE8hNcH60HLRkZUCETZ0yuLGDGiSTQzmgb3gGlEOjVMNB6UEKMAS9U0I6/DtjqaX6rJZFoQBSSj9zFADec3qKl3jxjfFABZuT0yq/ChADgYm033I+axlPo2JSVOvwAen/pny8gkFXlfSznkhFFxmaQAvOi5KuoxONpfNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C72USbM1us3JeuVRWlMKvOSmEZph8MRvBnYdYalvavE=;
 b=M0+G1DJXH3HlgaiDkEgVgyYLzeVt0gxG6QR8CR44UwWeT4zSXoTofwstlRJqH5HUsAMOw0uFdmu23DQVDkX0oColPBTXnUxWWcyj7PKbXVmaW09C9ymTy++Sp8tm3nWGUHGh8yVdtLuH0fa4duxVrKNG5R8PofKnp98w5e6S6AeHniCqn2ei+ISyogAXJPPj4k7MjK7Tq+Y0FY9zQEZousjkKKbyT2yQu+1k7O39Nm+NpWfZ6Zd0nvETn0e0maB8cxfJv4xSa+zq4eklCTH5oiWydd+L9Dn1PcaxsFhnOZPe2sJggIozjLCnmEueh20mhVAImgBqVc3iCDlR0ciipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C72USbM1us3JeuVRWlMKvOSmEZph8MRvBnYdYalvavE=;
 b=DMrK95tezjwAjIKTaz2tPtFUz6QFdIQdbhrg2MQpgb1l6aTTIf8ZB2mp8TSHIELopOH7vSmbN76rhReNhv1RTlsJMxTgaNAW+J0Rqx6aTN0vycxrtfw8v33uujV53p8RDlgBY67xSR13a4YQKaYTNF7B3rm2AKI6t8hO5mVCr4p+uN0j5NBOOctHy/+RsNw6J4hkH8qjGmcGDmoDT4W9z1B+JFmkAxJWeT5LZE+3UUXgp2JW8HJQ0RhEoicG3geaKa+d1xxp5eYBmVEjrVKNd4DmeJurtZbOseaouxVQ/otbf2Buyjocbbd8MBaMkZmu7LiGlZ8caaOlpE8NvsXkBw==
Received: from CH0PR04CA0090.namprd04.prod.outlook.com (2603:10b6:610:74::35)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:11:28 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::75) by CH0PR04CA0090.outlook.office365.com
 (2603:10b6:610:74::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 07:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 07:11:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Dec
 2024 23:11:15 -0800
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Dec
 2024 23:11:07 -0800
Message-ID: <955a7947-3053-490e-a803-d55699dddd0c@nvidia.com>
Date: Mon, 16 Dec 2024 12:41:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
To: Kai-Heng Feng <kaihengf@nvidia.com>, Beata Michalska
	<beata.michalska@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<ionela.voinescu@arm.com>, <sudeep.holla@arm.com>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <yang@os.amperecomputing.com>, <vanshikonda@os.amperecomputing.com>,
	<lihuisong@huawei.com>, <zhanjie9@hisilicon.com>, Jonathan Corbet
	<corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Phil Auld
	<pauld@redhat.com>, <x86@kernel.org>, <linux-doc@vger.kernel.org>, Carol Soto
	<csoto@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20241206135600.4083965-1-beata.michalska@arm.com>
 <20241206135600.4083965-2-beata.michalska@arm.com>
 <3f19c5a8-9ee6-42fe-8b4c-3a66c65c8d35@nvidia.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <3f19c5a8-9ee6-42fe-8b4c-3a66c65c8d35@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0c6eb7-fd29-4da7-e776-08dd1da0dc1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU9hWHd4Zml6RjZkVDFhWjZSa1VRMFc1cFZLUDR2d2tERmUvUFFhaFVtRjhD?=
 =?utf-8?B?MGxXeUhpOCt4ZEdZZzJLLzJWSzUzdGZmUk5GY2haVkEwbmRCd0tBci9DdUlz?=
 =?utf-8?B?NXppUDZqamFVSjRuY2Zmc0ZacUVZbHhsSi9aL2VwVTQwb3poTnEvdmxBTW9U?=
 =?utf-8?B?Q3Y4WjRRNkVrMjI5MzZvcnVwcW9DTWJFQmhXQjhUZHIweTJveW5VSzl5ZmhE?=
 =?utf-8?B?TkxyQWZWVHR6ZjZ1TDUxSitMdFFzN2lXV3RFVzlVZHVFMVdRaGwrcEJCSTFX?=
 =?utf-8?B?aWp0QzIzb05ZYzBOb2VmSUtGOEhFRzRYTUJiY0VRNjFwL2VjQUI3eEhaOHlY?=
 =?utf-8?B?eXN0NXY0QkRTKzQ3OGtxY3ZsdjlObmErR2FQTTcrQkRWd1l1T1VWOXBBTkR4?=
 =?utf-8?B?c1FIZ2padnhmSHdiZDZTamtSdVFNVXlaMW9nSzJpNzRiRlcxUE80aXJNSklH?=
 =?utf-8?B?anR2VCszb2szdWpyQnpjWUhQQnJDNzVVVVdtYlVJODJxdFNweUhZZ1JrdjQ3?=
 =?utf-8?B?Z3lVL3dRS0M1cUhXeGp2N3ZGemNCNi82bktzWldSUWhvRVdyT2o0Ynk1TklY?=
 =?utf-8?B?b2E3eDVGSEI4cWIrZUNmbWpKS1ZYaEFPb2JPaG5wRTlsdFJraEFFelFiZ0NJ?=
 =?utf-8?B?M2dvYzlab0crL0Ivdm9xOWN2ampibW11ZnQvUHU4Y3RzbTY1a2s5b2FwRUJH?=
 =?utf-8?B?TkgvckdHd25Ncm5LbXllOVY5eENseUtMb0tCQ2RDWTZVaVdrMVN0MTRUUXBV?=
 =?utf-8?B?UjRrakIvOEZzOEJJWVlGK2hqY2o3OE5FOWhtaDVNdmxUS0RvMmZFdUpMWENn?=
 =?utf-8?B?Qkl5YUw2cFRvaVdOOWdoWit5MmFqd2lmVHVTL1RPVFZUZm5yTytaYWJCT0gz?=
 =?utf-8?B?bmFiaDdhYmxjdUkzcUo2M1ByM3QvS1VONDFKNjBqREZ1NWIvN3JaYlJEQmNk?=
 =?utf-8?B?RzNyMzhlMXQ0ZWF1MTdLS2p4bGl6M1dncmxQZy92WDFGMHJOTVBnUlRwaktL?=
 =?utf-8?B?c01EV3F0cWpHVHJsb0ovcTFDYUQ1anJQUzlpVjhrZXIrdnJuVlFlQmxpdXhZ?=
 =?utf-8?B?MThNeXJJVGpmNHNjb3dDdmt0UWM2anY2Sy9wNUxnRDFDZkp6KytGaktQV1Jl?=
 =?utf-8?B?cGNzbnBKaForMU9hanY0bXIyeXZ6WFNXdXpHbzBHL25CN2pLaWVUeVRTWHEw?=
 =?utf-8?B?azNSTVRPV2ZzYjIwNDJwcnMyeWVJUWJISWhLMmdVR01LcElNcTg4ZlhNYWJE?=
 =?utf-8?B?MHNKQSsyR3BHSzIzTG5ZT3l6NTBRVTg2SzZld2lMaVZvVXFra2JZY2JBbHFW?=
 =?utf-8?B?eTd0VlBwTXBnbXZXQkpwQzQzY0JaN2l6R1QzR1hURmxZeXNpUkZLK3kyYUta?=
 =?utf-8?B?Uk5rYUlsdnBJa1FHeXBrM0xmRnNBUHpyNUF3cityT0Z0TlR2cHJ3c0sra1c3?=
 =?utf-8?B?ZGl6QlpLdTVZdmlER3NpQlFyVHB0cFRIVDhBTUZhdlJuZFZtVjVRbmVKb1VE?=
 =?utf-8?B?bjhFcUpTZW5xSHNqUkxWWUp1alBOM0pqdzd5RnZnYnlSMGliMlhCN29ZYkEx?=
 =?utf-8?B?SnptbExWT29EWnpHMHFRaXhYMDV2Kzdkc2xJQ3NtYi9kTFZOWkxiY3FaN0hB?=
 =?utf-8?B?R0xzd0QxMC92b1gxcjdrT1hqR2lkd29VNVNGbmlrMXY5TVFWb3djc1QwbG8v?=
 =?utf-8?B?dEVFNWdnenFaWUlYY2dWVHNyQ0IzWFFJU091aXlPVmt4WEpHbzdFQ2NUS2JQ?=
 =?utf-8?B?MXZNcm8vQXRTNzVRTGpPZDlaSGozY1Q2V250OGZBVi84UWRNTXByeWNYdllt?=
 =?utf-8?B?RXprUm1aODN4OW5LeHBjVVNHcm5ZZ3QyREFNRWIvVnFwVHRTZy8ySlZtWlBP?=
 =?utf-8?B?VG5FbWx5MnJQWmVxMHZ3ZDZaMmgxcnY1ZUNjMUhuRWlWSDUycUp4TEppZnJZ?=
 =?utf-8?B?SDRZMVcvRW0wcG1LTzltdDYzaVVpRHRKQW5HZXhIMUUvaHZTYzFCR2UvVGgx?=
 =?utf-8?B?S09FRVpKNXVjUzJ0SkxadjNMbXloMWtjS0hIb0JJdmJmaWZGY1pBNCs5SFZG?=
 =?utf-8?Q?9t01F/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:11:28.0370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0c6eb7-fd29-4da7-e776-08dd1da0dc1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505



On 16/12/24 11:13, Kai-Heng Feng wrote:
> Hi Beata,
> 
> On 2024/12/6 9:55 PM, Beata Michalska wrote:
>> Currently the CPUFreq core exposes two sysfs attributes that can be used
>> to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
>> and scaling_cur_freq. Both provide slightly different view on the
>> subject and they do come with their own drawbacks.
>>
>> cpuinfo_cur_freq provides higher precision though at a cost of being
>> rather expensive. Moreover, the information retrieved via this attribute
>> is somewhat short lived as frequency can change at any point of time
>> making it difficult to reason from.
>>
>> scaling_cur_freq, on the other hand, tends to be less accurate but then
>> the actual level of precision (and source of information) varies between
>> architectures making it a bit ambiguous.
>>
>> The new attribute, cpuinfo_avg_freq, is intended to provide more stable,
>> distinct interface, exposing an average frequency of a given CPU(s), as
>> reported by the hardware, over a time frame spanning no more than a few
>> milliseconds. As it requires appropriate hardware support, this
>> interface is optional.
>>
>> Note that under the hood, the new attribute relies on the information
>> provided by arch_freq_get_on_cpu, which, up to this point, has been
>> feeding data for scaling_cur_freq attribute, being the source of
>> ambiguity when it comes to interpretation. This has been amended by
>> restoring the intended behavior for scaling_cur_freq, with a new
>> dedicated config option to maintain status quo for those, who may need
>> it.
>>
>> CC: Jonathan Corbet <corbet@lwn.net>
>> CC: Thomas Gleixner <tglx@linutronix.de>
>> CC: Ingo Molnar <mingo@redhat.com>
>> CC: Borislav Petkov <bp@alien8.de>
>> CC: Dave Hansen <dave.hansen@linux.intel.com>
>> CC: H. Peter Anvin <hpa@zytor.com>
>> CC: Phil Auld <pauld@redhat.com>
>> CC: x86@kernel.org
>> CC: linux-doc@vger.kernel.org
>> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
>> ---
>>   Documentation/admin-guide/pm/cpufreq.rst | 16 ++++++++++-
>>   arch/x86/kernel/cpu/aperfmperf.c         |  2 +-
>>   arch/x86/kernel/cpu/proc.c               |  7 +++--
>>   drivers/cpufreq/Kconfig.x86              | 12 ++++++++
>>   drivers/cpufreq/cpufreq.c                | 36 +++++++++++++++++++++---
>>   include/linux/cpufreq.h                  |  2 +-
>>   6 files changed, 66 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/pm/cpufreq.rst 
>> b/Documentation/admin-guide/pm/cpufreq.rst
>> index fe1be4ad88cb..76f3835afe01 100644
>> --- a/Documentation/admin-guide/pm/cpufreq.rst
>> +++ b/Documentation/admin-guide/pm/cpufreq.rst
>> @@ -248,6 +248,19 @@ are the following:
>>       If that frequency cannot be determined, this attribute should not
>>       be present.
>> +``cpuinfo_avg_freq``
>> +        An average frequency (in KHz) of all CPUs belonging to a 
>> given policy,
>> +        derived from a hardware provided feedback and reported on a 
>> time frame
>> +        spanning at most few milliseconds.
>> +
>> +        This is expected to be based on the frequency the hardware 
>> actually runs
>> +        at and, as such, might require specialised hardware support 
>> (such as AMU
>> +        extension on ARM). If one cannot be determined, this 
>> attribute should
>> +        not be present.
>> +
>> +        Note, that failed attempt to retrieve current frequency for a 
>> given
>> +        CPU(s) will result in an appropriate error.
>> +
>>   ``cpuinfo_max_freq``
>>       Maximum possible operating frequency the CPUs belonging to this 
>> policy
>>       can run at (in kHz).
>> @@ -293,7 +306,8 @@ are the following:
>>       Some architectures (e.g. ``x86``) may attempt to provide 
>> information
>>       more precisely reflecting the current CPU frequency through this
>>       attribute, but that still may not be the exact current CPU 
>> frequency as
>> -    seen by the hardware at the moment.
>> +    seen by the hardware at the moment. This behavior though, is only
>> +    available via c:macro:``CPUFREQ_ARCH_CUR_FREQ`` option.
>>   ``scaling_driver``
>>       The scaling driver currently in use.
>> diff --git a/arch/x86/kernel/cpu/aperfmperf.c 
>> b/arch/x86/kernel/cpu/aperfmperf.c
>> index 0b69bfbf345d..a00059139ca4 100644
>> --- a/arch/x86/kernel/cpu/aperfmperf.c
>> +++ b/arch/x86/kernel/cpu/aperfmperf.c
>> @@ -413,7 +413,7 @@ void arch_scale_freq_tick(void)
>>    */
>>   #define MAX_SAMPLE_AGE    ((unsigned long)HZ / 50)
>> -unsigned int arch_freq_get_on_cpu(int cpu)
>> +int arch_freq_get_on_cpu(int cpu)
>>   {
>>       struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
>>       unsigned int seq, freq;
>> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
>> index e65fae63660e..34d8fb93fb70 100644
>> --- a/arch/x86/kernel/cpu/proc.c
>> +++ b/arch/x86/kernel/cpu/proc.c
>> @@ -86,9 +86,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>>           seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
>>       if (cpu_has(c, X86_FEATURE_TSC)) {
>> -        unsigned int freq = arch_freq_get_on_cpu(cpu);
>> +        int freq = arch_freq_get_on_cpu(cpu);
>> -        seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 
>> 1000));
>> +        if (freq <= 0)
>> +            seq_puts(m, "cpu MHz\t\t: Unknown\n");
>> +        else
>> +            seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, 
>> (freq % 1000));
>>       }
>>       /* Cache size */
>> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
>> index 97c2d4f15d76..212e1b9afe21 100644
>> --- a/drivers/cpufreq/Kconfig.x86
>> +++ b/drivers/cpufreq/Kconfig.x86
>> @@ -340,3 +340,15 @@ config X86_SPEEDSTEP_RELAXED_CAP_CHECK
>>         option lets the probing code bypass some of those checks if the
>>         parameter "relaxed_check=1" is passed to the module.
>> +config CPUFREQ_ARCH_CUR_FREQ
>> +    default y
>> +    bool "Current frequency derived from HW provided feedback"
>> +    help
>> +      This determines whether the scaling_cur_freq sysfs attribute 
>> returns
>> +      the last requested frequency or a more precise value based on 
>> hardware
>> +      provided feedback (as architected counters).
>> +      Given that a more precise frequency can now be provided via the
>> +      cpuinfo_avg_cur_freq attribute, by enabling this option,
>> +      scaling_cur_freq maintains the provision of a counter based 
>> frequency,
>> +      for compatibility reasons.
>> +
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 04fc786dd2c0..70df2a24437b 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -747,9 +747,14 @@ show_one(cpuinfo_transition_latency, 
>> cpuinfo.transition_latency);
>>   show_one(scaling_min_freq, min);
>>   show_one(scaling_max_freq, max);
>> -__weak unsigned int arch_freq_get_on_cpu(int cpu)
>> +__weak int arch_freq_get_on_cpu(int cpu)
>>   {
>> -    return 0;
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static inline bool cpufreq_avg_freq_supported(struct cpufreq_policy 
>> *policy)
>> +{
>> +    return arch_freq_get_on_cpu(policy->cpu) != -EOPNOTSUPP;
>>   }
>>   static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, 
>> char *buf)
>> @@ -757,8 +762,11 @@ static ssize_t show_scaling_cur_freq(struct 
>> cpufreq_policy *policy, char *buf)
>>       ssize_t ret;
>>       unsigned int freq;
>> -    freq = arch_freq_get_on_cpu(policy->cpu);
>> -    if (freq)
>> +    freq = IS_ENABLED(CONFIG_CPUFREQ_ARCH_CUR_FREQ)
>> +        ? arch_freq_get_on_cpu(policy->cpu)
>> +        : 0;
>> +
>> +    if (freq > 0)
>>           ret = sysfs_emit(buf, "%u\n", freq);
>>       else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
>>           ret = sysfs_emit(buf, "%u\n", 
>> cpufreq_driver->get(policy->cpu));
>> @@ -802,6 +810,19 @@ static ssize_t show_cpuinfo_cur_freq(struct 
>> cpufreq_policy *policy,
>>       return sysfs_emit(buf, "<unknown>\n");
>>   }
>> +/*
>> + * show_cpuinfo_avg_freq - average CPU frequency as detected by hardware
>> + */
>> +static ssize_t show_cpuinfo_avg_freq(struct cpufreq_policy *policy,
>> +                     char *buf)
>> +{
>> +    int avg_freq = arch_freq_get_on_cpu(policy->cpu);
> 
> We are seeing issues when reading cpuinfo_avg_freq on an ARM64 system:
> 
> $ cat /sys/devices/system/cpu/cpufreq/policy1/cpuinfo_avg_freq
> cat: /sys/devices/system/cpu/cpufreq/policy1/cpuinfo_avg_freq: Resource 
> temporarily unavailable
> 
> The CPU is in idle state, so arch_freq_get_on_cpu() can't find a good 
> alternative source for frequency info.
> 

Hi Kai Heng,
This has already been discussed during v7 in [1] & [2].
In v7, we were returning zero which printed 'unknown'.
The discussion was about printing in more descriptive way or with an 
appropriate error code. In v8 we are returning 'EAGAIN' instead of zero. 
The final decision was of Maintainers.

Viresh,
You have any preference on this?

[1] 
https://lore.kernel.org/lkml/aa254516-968e-4665-bb5b-981c296ffc35@nvidia.com/#t
[2] https://lore.kernel.org/lkml/Zyh-uVSW-0d0r8oB@arm.com/

Thank you,
Sumit Gupta

> One way to resolve this is to have fallback methods in 
> show_cpuinfo_avg_freq() so it will look like this:
> 
> static ssize_t show_cpuinfo_avg_freq(struct cpufreq_policy *policy,
>                                       char *buf)
> {
>          int avg_freq = arch_freq_get_on_cpu(policy->cpu);
>          int ret;
> 
>          if (avg_freq > 0)
>                  ret = sysfs_emit(buf, "%u\n", avg_freq);
>          else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
>                  ret = sysfs_emit(buf, "%u\n", 
> cpufreq_driver->get(policy->cpu));
>          else
>                  ret = sysfs_emit(buf, "%u\n", policy->cur);
>          return ret;
> }
> 
> But that also makes show_cpuinfo_avg_freq() pretty much the same as 
> show_scaling_cur_freq().
> 
> So is it possible to consolidate show_cpuinfo_avg_freq() into 
> show_scaling_cur_freq(), by making CONFIG_CPUFREQ_ARCH_CUR_FREQ also 
> available to ARM64?
> 
> Kai-Heng
> 
>> +
>> +    if (avg_freq > 0)
>> +        return sysfs_emit(buf, "%u\n", avg_freq);
>> +    return avg_freq != 0 ? avg_freq : -EINVAL;
>> +}
>> +
>>   /*
>>    * show_scaling_governor - show the current policy for the specified 
>> CPU
>>    */
>> @@ -964,6 +985,7 @@ static ssize_t show_bios_limit(struct 
>> cpufreq_policy *policy, char *buf)
>>   }
>>   cpufreq_freq_attr_ro_perm(cpuinfo_cur_freq, 0400);
>> +cpufreq_freq_attr_ro(cpuinfo_avg_freq);
>>   cpufreq_freq_attr_ro(cpuinfo_min_freq);
>>   cpufreq_freq_attr_ro(cpuinfo_max_freq);
>>   cpufreq_freq_attr_ro(cpuinfo_transition_latency);
>> @@ -1091,6 +1113,12 @@ static int cpufreq_add_dev_interface(struct 
>> cpufreq_policy *policy)
>>               return ret;
>>       }
>> +    if (cpufreq_avg_freq_supported(policy)) {
>> +        ret = sysfs_create_file(&policy->kobj, &cpuinfo_avg_freq.attr);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>>       ret = sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
>>       if (ret)
>>           return ret;
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index d4d2f4d1d7cb..a7b6c0ccf9bc 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -1194,7 +1194,7 @@ static inline int 
>> of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
>>   }
>>   #endif
>> -extern unsigned int arch_freq_get_on_cpu(int cpu);
>> +extern int arch_freq_get_on_cpu(int cpu);
>>   #ifndef arch_set_freq_scale
>>   static __always_inline
> 

