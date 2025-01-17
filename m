Return-Path: <linux-pm+bounces-20638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A0DA155FF
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 18:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED3B3A24F6
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 17:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298B01A0BFD;
	Fri, 17 Jan 2025 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hJK9synC"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA486324;
	Fri, 17 Jan 2025 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136315; cv=fail; b=urjMfSTaolb566PNidcdWv2+JCd8upYhq0VuhNw5Vbff/K2XCHSTL35wasTJZs+VnzQiO/N+m3EvV/de6Yi4VXSNl9UxzN7fLpTgt5KUBP5tOvtHcFMPmMpjB0S4uWkL6Akn7+yL6uuX/6Nf74aJP8GBtB8e4xX4JpRsFUVbS1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136315; c=relaxed/simple;
	bh=YHccOzTQsWNPc7sSkPahh/JS9hl0/7BiEnsjUIzgXhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PKG4NH8d1rtn8yp596dQFb64wIpsm9YJ0KRhQE8yOh5Q2WblOpnfysODPJVd8Te3kG+TVHU/iC/HAjez2zeTAsVSeZCCcsIlrLUwjSz83IM7Znt7TswiqT5JKKSR637uIA0jEQqdGFAm22KqaVQPTTTf6tf02KHapI1+kwrUszw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hJK9synC; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHF2impKKqEHqsxDE1GXN2vct/43fEvSh8Ksd0GI9PiYtox2V4cbkOe1N/h2OaNesrMpJzI3pK/r+yheYg9bQaEBgeB7UoYWjjf/fLYDQXy24rzPyEtZLthLQ/l9hDdZ6Ow/Ms27vyfa6GTUE/hJ8GjBDJFvOGgIkVEYkX2BEUB6dm7oqwf6oeE8JWj+3ou55eQeTz79hfgPeZVCpuDxatq6OQjbyhgopF/N3R1tK7CuaR9PxvSLxfYgNzdtklQPpwiREP/ss2zMbmGytLEHkrzS9kVNM3NBarvpOD9XVriAhVGzvlda+whFETC/vUlCZfWLUd98akuAYeTYZF98Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ggrg9n8QqMl5Q45beqaZb3T+yQFot8r8XsSa0lJfio8=;
 b=vrFk2Ma80KfcuFPUuthdZlf4CpSBEdBdkB06MUAq0Ge9wDZSpAsJXyH4PChxxHOdw4IMIOO47jVvGGam3kZ9QEdaAG1oKHKLMQJucPzFm6x3p2i8dP+xKld9JTt6FjfxM9XBWMv9Dl0DEcEm4HM3/xBO6iThXS4OHxQYD1u+vkB+pLt7B2O/A65Si9rhYtms4ASY5uqVk4NFn6L/fuLjGIHorO9xBJQx8N6VF0f6TCVA+p3kvgPHZ7F6IAID/hoHPPCi1bxYaUiGzQ9TVqqhLqw5v/ULRMONulkgBk9XArHvLAE7grjpFtwlbq96lvLhXT9H4RjPOuh2UuNpcR8/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ggrg9n8QqMl5Q45beqaZb3T+yQFot8r8XsSa0lJfio8=;
 b=hJK9synCA5H5/piUErC87oiGDjq53j1IOH/9e4Fg73Ogg0/BVDSaA5jx5a9dGkRU69/FIR1nGiToEvqQJqaR/5vDSZdZboTZRmK5iLrTwIuJDbOGrExAWmhg/ZBlCFJS4QDeCax6Iw+pv2z6v8PQbFcyj8vttHfI4W24eHCCYxM=
Received: from SN7PR18CA0021.namprd18.prod.outlook.com (2603:10b6:806:f3::12)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 17:51:49 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:f3:cafe::15) by SN7PR18CA0021.outlook.office365.com
 (2603:10b6:806:f3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Fri,
 17 Jan 2025 17:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 17:51:48 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 11:51:45 -0600
Message-ID: <8278ff79-9acd-4f5a-8525-fb800fac4775@amd.com>
Date: Fri, 17 Jan 2025 23:21:42 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6 v3] cpuidle: Handle TIF_NR_POLLING on behalf of
 polling idle states
To: Frederic Weisbecker <frederic@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, <linux-pm@vger.kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>
References: <20250102150201.21639-1-frederic@kernel.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250102150201.21639-1-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: 549e00de-de3b-48dd-7dd6-08dd371f9dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3o4SFYvMnVqTWYvOTlqVkowc1VPMHNpb1FKNFJ5RmZaeUY3c0dEYmU1Sndy?=
 =?utf-8?B?NVJtc2FBSXJ0VmpCM25tdlc3MkhaSW1jNXZCNm5aU2pnUTd2dzhneXU3dHdX?=
 =?utf-8?B?OTBtNThEOEVOaTNERHJhSUZxVVRUZWk3ZmxLekdGNkhVeDhENG1rOVNnZzl4?=
 =?utf-8?B?akNLWk9Ya21BYkZYUXhLZWhnNG5DanJYTkVVc3pUNmhKMUo5N3JjbSt4RjFs?=
 =?utf-8?B?L1Y4WThJQkMyM3IzODBtUWx3bXBPN2ZFUWttM2xuSitKVFdHTHpwR0ZlbUNs?=
 =?utf-8?B?bVE3dVlQWnliZWV2K1crb01lbmo1eU9QeUFtM1k4bjNkZ3dQNFVCZkFTLzd3?=
 =?utf-8?B?RG9PbTU5VWxzWTlUUUdiTzg4RHp4cHljUkFMNnhDZEgrMHFFcGhUdysxNzg5?=
 =?utf-8?B?NjZuUWtYVVlsUit3cFE4bmRIc0dqeEJUWWxEZEs1Ujl1NEtsUTFIcXF5MWpr?=
 =?utf-8?B?bGR4SllTdEVWbmxyeG5DNml3eGdvM0VKbHhXQ0Zjay9ya2dDekRGVnJpSGhR?=
 =?utf-8?B?K3Q2WUh2TXZuWXlQNXlpMHlQeVpqaE42bWQvUGFtMXNkVFl4RmV5eTNsUU1V?=
 =?utf-8?B?TGsvTktWc0YyTk5ndUpidzdIaUNLNGEwMWp2ZVdZa3g2UDlHS0VUVGNKZjZT?=
 =?utf-8?B?Y3VIY1MyTjV4UWtQRTFCei91TGg0THU2cWQrVms0Y05CdU1VdGJLZVBKdTYv?=
 =?utf-8?B?RmJlYmUvL21RVXMvT0pVMHlMeHRWRWVHQ2JRSmNJamNOL3hUOUtleXdHSU5H?=
 =?utf-8?B?NCsyNVFKT1hYWk9jb0xYcHdrVXJ6aDNLZFlTTmUxTEJtVjAwL3B5b1FZVldB?=
 =?utf-8?B?OVVvNG1YTmRwNHhyY2VwcUpkN3JZdVpPMGNuT1kyNkxGUnRJMENreVpsako5?=
 =?utf-8?B?cG00ZWNLemV0QTZxZlh5aCsyOTBicmwwbFRyTms0Rm5Na1RvckFBNWU5V2NN?=
 =?utf-8?B?aGEzSlAwY0FDWG9QVTBEMWk5TUxPcGkxcVBCUUExWm5qSFMyK0JvbDlkaGlv?=
 =?utf-8?B?alV5Z1BOVWl4ZE1hWVNTa3JpYUlSMWlDRnYxZS91N0FpVXdHM2tubTZJMmFx?=
 =?utf-8?B?MnNWL1phRm8vYUNEUU9LQWpuaDFCYzU3aFpjb05pWDlsOWVCdFNXZlNMcWRX?=
 =?utf-8?B?ejgyQUxFZnRsbTVnNncyU3RwczdMQlVobC9aMytTbHJQTUp2Wk1naWs2Uncv?=
 =?utf-8?B?bTMveVQ3d3dkeExLSjJCL3l1TXI5Rjg3VncvZC9WdWgwNnpwZlN5bGJpdERl?=
 =?utf-8?B?Y3NEMEt1eFpQMGNORkFjeU0xcDVFVW5Ra3VhU2ZIR1hHcVRMZEFoc0lzZEp3?=
 =?utf-8?B?Nk9RN3REMWJ1THp4blJXR0tkSUJ2bFhFaHRTNjJJOUZiM0xtNURYTVdTK2VF?=
 =?utf-8?B?Y1o2Qk51K04xNDRMbTE2ZThGZjFUa3ZRYWJBV2JzRTdjRmdQWWxzZ25ZQ09t?=
 =?utf-8?B?cW9LV0hXWnNJUE5jdjh4NG82Y3VXemVIMDdsUUEzczg3WVhoc3FvZXVIYlNi?=
 =?utf-8?B?dTdGbWZaNm5sSmtWbXJFcm1nMnA3Ky8wcmZvc0lQeTFBTjhGMlFKdzZ2OXl2?=
 =?utf-8?B?blBKYVpVN1RibkhySzUrRHBDL0h1MWQzaFAySVRYSk55YkpvTFdHNWNzdkd2?=
 =?utf-8?B?emUyaVg5L0owdlhYeWdCenNuajlUMDhEaGJMblJQaTVhSDlsdWxoK0tRK2Za?=
 =?utf-8?B?SlZoaWY5MkY3VlhuT0NkaTZZdGdTZzdtWkhSbVJIODBsclhTSlp2d3N0K2I0?=
 =?utf-8?B?UmxWZ0ZPYkF4OU9NdEVJQlZyUGc4bi9oN0Z0anZKcEVxeDQvVEVMbi9Lcy9I?=
 =?utf-8?B?ZGpHVTVvRkd2NjBvRm5LNXFoYURUR2hnUTZGcUsxcEl0VjBJTUxUa3lCVXNU?=
 =?utf-8?B?UFMzRUhDK0hEeEJGTk1za1Y5SGQvc2l5RzRHbHZOOXYySExpZVl6TysvM2lE?=
 =?utf-8?B?ZWQ5ZTl1dklBcEw3NEMyekxia2NpcFNpWHZKRGpralE2Y0pVR0ZaejNLNmd4?=
 =?utf-8?Q?bniJE2eB/Ua5UzWy5Bl0u7AANoG8lA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 17:51:48.5718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 549e00de-de3b-48dd-7dd6-08dd371f9dbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050

Hello Frederic,

On 1/2/2025 8:31 PM, Frederic Weisbecker wrote:
> The TIF_NR_POLLING handling against TIF_NEED_RESCHED polling/monitoring
> idle states (mwait and also software polling) is a bit messy, with quite
> some wasted cycles spent on useless atomic operations. This tries to
> consolidate this state handling from the cpuidle core.

I tested this series on my 3rd Generation EPYC System with ipistorm and
I've not observed any regressions in IPI throughput to idle CPUs in
TIF_POLLING mode. Additionally tested few microbenchmarks and there were
no surprises there either. Feel free to add:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> 
> Changes since v2:
> 
> _ Handle buggy mwait implementations (thanks Rafael)
> 
> Frederic Weisbecker (4):
>    cpuidle: Remove unnecessary current_clr_polling_and_test() from
>      haltpoll
>    x86/cpuidle: Move buggy mwait implementations away from
>      CPUIDLE_FLAG_MWAIT
>    cpuidle: Remove call_cpuidle_s2idle()
>    cpuidle: Handle TIF_NR_POLLING on behalf of software polling idle
>      states
> 
> Peter Zijlstra (2):
>    cpuidle: Introduce CPUIDLE_FLAG_MWAIT
>    cpuidle: Handle TIF_NR_POLLING on behalf of CPUIDLE_FLAG_MWAIT states
> 
>   arch/arm/include/asm/cpuidle.h     |  2 ++
>   arch/arm64/include/asm/cpuidle.h   |  3 ++
>   arch/powerpc/include/asm/cpuidle.h |  4 +++
>   arch/riscv/include/asm/cpuidle.h   |  2 ++
>   arch/x86/include/asm/cpuidle.h     | 12 +++++++
>   arch/x86/include/asm/mwait.h       | 27 +++++++--------
>   drivers/acpi/processor_idle.c      |  5 +++
>   drivers/cpuidle/cpuidle-haltpoll.c |  3 --
>   drivers/cpuidle/cpuidle-powernv.c  | 10 ------
>   drivers/cpuidle/cpuidle-pseries.c  | 11 -------
>   drivers/cpuidle/cpuidle.c          | 22 ++++++++++++-
>   drivers/cpuidle/poll_state.c       | 30 +++++++----------
>   drivers/idle/intel_idle.c          |  8 +++++
>   include/asm-generic/Kbuild         |  1 +
>   include/asm-generic/cpuidle.h      | 10 ++++++
>   include/linux/cpuidle.h            |  1 +
>   include/linux/sched/idle.h         |  7 +++-
>   kernel/sched/idle.c                | 53 +++++++++---------------------
>   18 files changed, 114 insertions(+), 97 deletions(-)
>   create mode 100644 arch/x86/include/asm/cpuidle.h
>   create mode 100644 include/asm-generic/cpuidle.h
> 


