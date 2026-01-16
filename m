Return-Path: <linux-pm+bounces-40967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 591CED2B9BA
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 05:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCFC73013D69
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 04:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59013347FC3;
	Fri, 16 Jan 2026 04:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CHQIfs0u"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AA1347FDE;
	Fri, 16 Jan 2026 04:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768539054; cv=fail; b=NPBiBnaxr9C0+yFu0H+WABUVhvvKgGYHGMypvV7yGbb1iAl347Zcb4j7ho46oge+fqierkEEEMtRJl516uzbwrvcWq3vaYRLt57/kA6C5vf5yaPK8UpGdoxShLcLPzPYf/DcaDaUZ2f8HZxbT8po3TF7z0joQbNa35byvGca0Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768539054; c=relaxed/simple;
	bh=LsABI3zk9VvI8FTIJ1Jo/g09t0B5vuZdeXCX6xNWgCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iVq5vdaLt0Wmtv4qXRGMILlCWVUagLG+PVE9TpQ2cayb/Q7yB/mWHV+nmYbzJLDMuqMX82/07an6xR0iTse5bcsF9WvB6f0/P2rh5bnnK5uPHGHEifmURa1Q78swh8+LVfkpL2A5MwAw9l76unXzIqcvPAVIWFLgM5nsJNbN8j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CHQIfs0u; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfOvKhCVKeYEiPy+SSiga0bY0qL2Rvo66sNXGSNIXCztk4/4PCx13rCdsH3S08xQfVz4REP11XHt/EIzs20rSxWJlQzzPpmXFQYKf4PJ48V19RqSPn4BiwTZdfD5XBw1RiPbGHystykLNxUo3qt2aLsA/+1QMBf/WdnpS1psIhIFF578L6i6xt8EF4KbZVsS/OKkmFbMAyG5/1fJWVuaO8vVRI+0xvhWwUWBt07q+l3KrlGFoCwyqdFmEaD16VEC1eqp73hC0ytJuLELUlafig4BpLD+weUBvhnKVBXzYL2pEMEheJ5PUGGnel+Xm8Vh89X/LHhoW6NnYLwyIbLQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SRf3nbhIftAWscw7N24nCin5M7j8I9v+56LW1Zlkp8=;
 b=faYOFLhQL8/lNKFjQsUGnpG3O6Al5SbqTWKIYenK89jddTK/wgqpoyUhK8t5O5laHs4pfOeSwjAEqlLWg+Tw/7U3IrB+kjnsXdVDBpBlVgvnzt3yxr0tEEv3oXJrISR/jGKAkvxK7AFgWRKXnVv/Ks/7s/dat/3w9xcLXJQHdiX9CmEoibLJmu8MxDH3nvXTTCeuamojlPZHNQ2gYLAcFlj3JPDDaF8n8nmAGvvqD5KYSdVY2HQU7RE21gQ0Oz0LZwJ1jK4gncxoMLM7vJUXRul85IpQYlP5UfnMgyfP8YMOdMiJAH2kRpSJxarT4ClnnEpFW43xGbu9dnd82DYkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SRf3nbhIftAWscw7N24nCin5M7j8I9v+56LW1Zlkp8=;
 b=CHQIfs0uzIENLaTnlIcNLidzgHVL6M0vPyQxOsiBw5Zhl/OO9ngPGOGfuCViM/TVHfQLSV5OWRl90pnlC09u1Ff0MjBcXaUolXJNh00gTfAj988XUpK/1c4k90XNwYiitFUjRTVXX+EfzTl0zviBJA8Ep994hE2Bos4pQYZGRio=
Received: from BLAP220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::14)
 by CH8PR12MB9840.namprd12.prod.outlook.com (2603:10b6:610:271::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 04:50:38 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::b9) by BLAP220CA0009.outlook.office365.com
 (2603:10b6:208:32c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 04:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 04:50:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 15 Jan
 2026 22:50:37 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Jan
 2026 22:50:37 -0600
Received: from [10.136.34.241] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 15 Jan 2026 22:50:33 -0600
Message-ID: <549095b9-c12e-4415-999a-f2589451f5e0@amd.com>
Date: Fri, 16 Jan 2026 10:20:32 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq: Pass the policy to
 cpufreq_driver->adjust_perf()
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, Perry Yuan <perry.yuan@amd.com>
References: <20260114085113.21378-1-kprateek.nayak@amd.com>
 <20260114085113.21378-3-kprateek.nayak@amd.com>
 <bqvpt465nowq3jipfsciaoafjpjhu42l63vi6p67qscwx5oil4@t2tkh2u5giuy>
 <6eabf604-9168-47fb-8fd8-b2f0d985db6a@amd.com>
 <rs4z34vntq4inwbl6nhzwsmefcgud33a4jpec44ff5ylrxtnur@rczzlmhgejky>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <rs4z34vntq4inwbl6nhzwsmefcgud33a4jpec44ff5ylrxtnur@rczzlmhgejky>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CH8PR12MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 28398957-3c0b-4c2b-f208-08de54bacb27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2ZKNis4b3czSTFGVGtCY2pvZ3htUTdzTnlMdG1hREl2MTRCMGNyYnR3eExi?=
 =?utf-8?B?YWdla3ZzbGVjc2JaUlpReDVlYThxZnFaaTBlYlZrbzRub0diQTFHRkpYTmdt?=
 =?utf-8?B?U0JORlhsR2IvOHQyMUtXakZGQ3k4eFJIYUJBb1Ercm1mRmRDS2tvRWNqU2kx?=
 =?utf-8?B?S0JqU3lDSUkzaW9kRVBoeHJFZ3VqM1I2ZC9xcUpTajZpalNsRVMzVnBDTzNa?=
 =?utf-8?B?MWQ1UXUrVTYzZlYwVmZzZ1NqSkdSQTRJOW40Mzc0a0RTYmZYbkhpeTBlVzNE?=
 =?utf-8?B?S05WVWt0RHVWMGExYldJMFViL2kybE9hblpQNzA5dmI3R0ZDVER3QzN4VXBh?=
 =?utf-8?B?MkJIdkhySlFaMTd5NG4vUkthZU51L0dHdVowT3dDcEMyYXl5VitRWDFnRFA0?=
 =?utf-8?B?dkVDeUdjK1Zya2F2U0VkLzlnNXdUN3FZNmdISzdnSXVmaFl0RTd2b0wrVVRv?=
 =?utf-8?B?Yk53NUlSaUZZME1MWTRYdXEra0FvS1JxbkR1V0p0YVVEemtUZnR6Wkc2VjRJ?=
 =?utf-8?B?YnN5MnJQcy92ejZVazIrdnFHRTBsZkFkZm45WHFNdjVFWU5MR3JWTnZ0WnA4?=
 =?utf-8?B?Zlg1L2FwNjBKSGRCWWFpQ1Q0OUV2ZFZVbzJMSU11M01TQmVBa1B3cDlwT1Az?=
 =?utf-8?B?QTBSY29NM0s3Z0dzWTdUNGRCeTVKNFFaRGwvekVIZmlmV0ZiKzM4UUZWQjND?=
 =?utf-8?B?UW1aTCtmSWt5aE5TbEVDcWFDWVJhM3lMaWxsUGhGMjRKOU8rKzdRZmk5dlZL?=
 =?utf-8?B?QW9yVkU0TXpaeXEzUlpITnNJZ1puM05HOGpaZEc0ZW51c29vVkltcDVNNEFs?=
 =?utf-8?B?anlEVmEzV1VUV29nc1JjQnF4d1RXbFRHNlZud3F0cWlLdEg3L0N6NXFNRzR4?=
 =?utf-8?B?WTBwM1h4TUdZMTVFTGE0N2xBTUQwUnFkbHp2ekZtd2gvS0JjYllxVDB0eVBY?=
 =?utf-8?B?M0FlN0VMTStOTExwUDB5VUhwbkE1YmRvL1VyZERrdGN3OVVRNVM0YVUrZ0Uv?=
 =?utf-8?B?VDAvb01yckVnL3JoRTMyOENPOG96WWJMUHBxQVFsUHNKZjZSMXpTK3BlS25N?=
 =?utf-8?B?UnorbHBIOUZWcks0MmxxcjhrT2tZVUVtVmR6dXhINjFQRkZ5Uk9kVmJwRGE2?=
 =?utf-8?B?NXFERDA5czZ0alF2dTlONG1zeDJVWStucmFrdHpiVkluUUlGcDJlQzVnT2Nq?=
 =?utf-8?B?V001MGN6bmFhUGRpRGxBWEhzdWFTT2xiVnhFdmFmNDhLUVFoZkFUZlAxNFpx?=
 =?utf-8?B?UkNFTy9RWjRHYVZUYUNRMHEwcTdxZnRFREhJbS9YN2psNHB5QlpDSGsyQy93?=
 =?utf-8?B?eURYNStUMXVIVVRnMnN5aktTOFdnNFlHaTFmQVdEUGp2UlFxL1B4V1FBb0c4?=
 =?utf-8?B?S0xnUDFyeXVIMFpZTUkyMDBrcmt1WGxhc0dkbEY1cGgzR2VnOU5OMFVoaWQv?=
 =?utf-8?B?L1BZY3ZZT3JPWnJoYkcrY2lsak94YlowcGtyd3FvYkRwaEZDb01HUGV2S0Nm?=
 =?utf-8?B?ZWNhTGxpTWcrekZWUzRQSml4V0JxY0Q2UjVmUmpvQlg4R2hWYXZIcVFqbDQ0?=
 =?utf-8?B?YkVkdW1TbVc1bDlSREdSWmVrZzAyQmdlcGdnWWM2Y1IrbXJ1dXF1MTNvazhp?=
 =?utf-8?B?V1Nhbm5tUUpBVEFrNWNTWWNxa2RTSGRKdTZIT3NNUGhNOU5relpxT0J1ei90?=
 =?utf-8?B?WVl1QmZxclNpSmVYZEZpdXhEeVltaFhPUm1QeHFudk5VU2xaek1UaU5Genl6?=
 =?utf-8?B?ckNMSDdzcE0zRHp2WlVkRk9WWFNKMUdWaVI0a3k4cXpFS3k0dmFCeFl2VVF1?=
 =?utf-8?B?NW1uTGlIYkZlTkJXQTBRZEdVajVRS3dlbkhoa3lCUlNNL0hUQUFLdE1ieFFR?=
 =?utf-8?B?Q1FjUjdhUlB5NjVtREYvMUVVYkdZN2ZwVVpJSVQrcnV3WXMydncwMWhOeUxv?=
 =?utf-8?B?dktKV2FRVHp1U1lHM084V1V1V2ZqOHNkTitpYUNPdGFORTgwL2Q0RUc5M2xN?=
 =?utf-8?B?ejRRT0Z5MXR0V2k0c2VwaS9pNmh2MDRWdGFXT3VuaGw1ZzI2SHhKQXRlVFFh?=
 =?utf-8?B?SmlxeFVDY01qYnFTY0dkbW1OUDRoRVpyQzduMmhDUCsvWXA3VlFxY3pUYzVm?=
 =?utf-8?B?aTBpTVZxMlFNRTJPSW1KNVRmd2Ercko1SVdZNElrNldKTkxOckNERlhMNnkx?=
 =?utf-8?B?UHNuV0NIUFNXTk5CT2wybWdOY0p2UGp6TjBZMDlpS04yOWlsV1FZOHdqVWpL?=
 =?utf-8?B?eDRrUU1hSi9nZWVySmtNeG9nVHVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 04:50:38.1791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28398957-3c0b-4c2b-f208-08de54bacb27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9840

Hello Viresh,

On 1/16/2026 10:14 AM, Viresh Kumar wrote:
> On 16-01-26, 10:08, K Prateek Nayak wrote:
>> Guilty of not having CONFIG_RUST enabled! I've arrived at the
>> following after tasking a look at cpufreq.rs (specifically the
>> fast_switch_callback implementation):
>>
>>   (Only build tested currently)
>>
>> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
>> index f968fbd22890..bea109f8ff78 100644
>> --- a/rust/kernel/cpufreq.rs
>> +++ b/rust/kernel/cpufreq.rs
>> @@ -1255,18 +1255,17 @@ impl<T: Driver> Registration<T> {
>>      /// # Safety
>>      ///
>>      /// - This function may only be called from the cpufreq C infrastructure.
>> +    /// - The pointer arguments must be valid pointers.
>>      unsafe extern "C" fn adjust_perf_callback(
>> -        cpu: c_uint,
>> +        ptr: *mut bindings::cpufreq_policy,
>>          min_perf: c_ulong,
>>          target_perf: c_ulong,
>>          capacity: c_ulong,
>>      ) {
>> -        // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
>> -        let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
>> -
>> -        if let Ok(mut policy) = PolicyCpu::from_cpu(cpu_id) {
>> -            T::adjust_perf(&mut policy, min_perf, target_perf, capacity);
>> -        }
>> +        // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
>> +        // lifetime of `policy`.
>> +        let policy = unsafe { Policy::from_raw_mut(ptr) };
>> +        T::adjust_perf(policy, min_perf, target_perf, capacity);
>>      }
>>  
>>      /// Driver's `get_intermediate` callback.
>> ---
>>
>> Let me know what you think. If you think this is alright, I'll fold it
>> into this same patch in the next version to preserve bisectiblity with
>> CONFIG_RUST (or should I keep it separate?).
>>
>> Since this is my first time dealing with the rust bindings, comments are
>> highly appreciated.
> 
> Yeah looks fine. Just make sure it builds fine.

Ack! Let me give it a spin before sending out the v3. Thank you again
for taking a look.

-- 
Thanks and Regards,
Prateek


