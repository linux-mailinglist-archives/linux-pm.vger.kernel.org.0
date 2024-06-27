Return-Path: <linux-pm+bounces-10122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36991A9B3
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 16:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90AF81F22365
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 14:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F50197556;
	Thu, 27 Jun 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oG8d5vDO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22721822FA;
	Thu, 27 Jun 2024 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499701; cv=fail; b=bO7w5/CJw2bsRinOeY0f7ajKyUv+zLpbLkWCAdSa71BNi88mafIbF1Fdn0HJMkrn+SB7hIE70aJS1qBKC98P6dhtnH5lMP49MsdwaJ7wVaWAcS+ew/MIYbEcFlm3GmnHjFkjfvaI+iVd0CjaAmnKXHxI7RuuUoLTYJW8fyaTsC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499701; c=relaxed/simple;
	bh=8DINSJ7JSfWegUiwqAzQEbc+lKiB+FftSAh5MEEhBuo=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hXJJ5yGROSsUUwbj20M7xyy+iKJUpH+6lJ9m5jkdzfVCRKmJKszfIFv7DD5z87BPIKQa8XtL7biH+FwtM6LPEFLlMb/MhLuCgeZU26LKqxP+aF9UykzY+3qJy/BwyNKp6GaeDzny/VhWZe+EHS/TnX2hZRWP68UJ2YpbZN9zjek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oG8d5vDO; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqQAj7l9GqXMntnB+98aBbEg4INDmRgYyGO8/pRsdIhMicwabcervy60Toq5g8zhGesMYWWwOykZRs7PaOgzkWdAntQl/yHOoC+STJDaHAlru6DSt1uNZWVVdN771aNfisWMh/qWFLVHESANy+LLSZh/+N975U0NRgBKosgfzzeDiO0R0MhoB846/k+tg0fYJ/O2PhzhttLxMhWdhhtcJgQTHg4N852ib/vmyg/94H9VFIqr6kSA0tpUHWbZhNH0NpnYySbN4+47n2pMndPodjjDY3Mj8kG+GjBf5lHQ9PWXoWrO55oRAk9dD4eewWFju5Y9yGxxlA67DGUjYIPwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fg9yAGGD9FzXTS94JvNVsDh8wOOeqzH7E+izq3jPaX0=;
 b=dhiQsiqUpixd9c/Q1u2S7nKw1KP5OY5tiWbFQA9ozEAlaT69Y7oN1cauSnA85RBNFru5/dYYXhkMv380uHjl25ZyJCVL+HmtpOfa7f/QR1ANkgoNcGuNEBWLp+PKRrZVBIeJT1NOqkKXtXVAtRlcZGtiHBp8Q28Cm03+HUaR++J/XZ09ibTYJZkdE8zPVO0kdqZt6DoonU+6+tqEQgn/wYPNGOpQkS05Y40473Wyl1TISxW0+fRAiV8N656U5SeR1tS+CsMYYnzAiaNlSV16MdvHZ7AH9QCCuuwWyBNafKxVME4r9KNtyGYa60pgMcLBD7Ki3jRXKgSqz8PRFYcx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg9yAGGD9FzXTS94JvNVsDh8wOOeqzH7E+izq3jPaX0=;
 b=oG8d5vDO5TSL10QBCQl2uXAECy5aQZPx+fqH6hgDy0anQqSiIjLxZTlrRcxhsPGg/KtY88WnaKIqfSxWhVO/K9EFyCnB4eCNrNozvf7wZRrAa8kgU11efQODXgwjPcYVBdmBIp8CsQsM6eeXsCVU9V5Imrz2ct1VNwn0ciYeqtM=
Received: from BY5PR16CA0018.namprd16.prod.outlook.com (2603:10b6:a03:1a0::31)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Thu, 27 Jun
 2024 14:48:15 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::31) by BY5PR16CA0018.outlook.office365.com
 (2603:10b6:a03:1a0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 14:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:48:15 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 09:48:10 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Borislav Petkov
	<bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE
 (32-BIT AND 64-BIT)" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Huang Rui <ray.huang@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Nikolay Borisov
	<nik.borisov@suse.com>, "Peter Zijlstra" <peterz@infradead.org>, "open
 list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] cpufreq: amd-pstate: Use amd_get_highest_perf() to
 lookup perf values
In-Reply-To: <b0682b62-a690-4776-b2bf-444b6838cb05@amd.com>
References: <20240626042043.2410-1-mario.limonciello@amd.com>
 <20240626042043.2410-3-mario.limonciello@amd.com>
 <87msn7ezoz.fsf@BLR-5CG11610CF.amd.com>
 <b0682b62-a690-4776-b2bf-444b6838cb05@amd.com>
Date: Thu, 27 Jun 2024 20:17:58 +0530
Message-ID: <87frsymogx.fsf@BLR-5CG11610CF.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e23644-b761-4066-1a16-08dc96b82d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zB3I8HtBUChx2hHsPVXTGFj2LJ501mAtviEIr3LCjxaL6F1EFHmfI7dHkGfO?=
 =?us-ascii?Q?FxITdS4GLpuomcJG14J/5aUM+gvts+9aFYCdNlfovBOAY/+CYfyOeAkxVW7P?=
 =?us-ascii?Q?UvxVft5+4rhmgTa434dwu+bCQKAIW1KKNsP9fV/omKEQBic4l/9XOUmAWxz3?=
 =?us-ascii?Q?fs/mOStCDP0OadW9tU9edXgzORuReecmv+AMkvZ5dypt0cn6gE1JO3yfM6Tn?=
 =?us-ascii?Q?ax0jeReVLqhjSuJSctUm5tpZAPRBKhL8xXfrMJDixn6HoE4mglNWRSTAwrHD?=
 =?us-ascii?Q?WItRWfy6duveBCHgSZWAGjkYeseqcUDUcd2Kq818Bzcw/kQmOEAQGwsW2XnQ?=
 =?us-ascii?Q?HxTqVWvlH1cPYoycsq2LL9VGf3xeijgGvtLEXDrwtwU2UxIcjY8l8KRW33B3?=
 =?us-ascii?Q?yVzNW2akK/lznR+8iZ2bTgnebh5N9vgAsEdCL+i5Dz1FB8Z2yHXQdeYCUW+C?=
 =?us-ascii?Q?HVuvUO8JdToNq41h3aYaOML9Ox0sJUs8yvaaxgucbvJmMr6E6yzESOVJF9F+?=
 =?us-ascii?Q?l9DZkVXXOAMgJinmWpqjiabC+qrHVn/Foo3Q28a0v8C7VA3m/5YNNyl3jCpg?=
 =?us-ascii?Q?9sMWMKHM08iYF7HjYFSqBq23azX3JK8opp4tBdkfPGkU8tGYn5xtgUIGYBkf?=
 =?us-ascii?Q?WeTCrek/ny3ZMJtKmnMob/ShiR4MuGBXFGtozMQ2nVrZs4XIZeMO+gSeX2wl?=
 =?us-ascii?Q?1IEidvZJrdzMglK6lL8zZSFuTQz4Nq23kkDsG85+SaZYP7YNd/Ik9E/2p6OZ?=
 =?us-ascii?Q?9OOQnNzcdwpcLYWQSDtCvQY3fdqi7bCd+EvAJSx6jzYMRdFVJ5vyY3EGBqDf?=
 =?us-ascii?Q?94i9NDbFtTffE/991JPAXAeLrAC7T6L7L7w21dPjReo4CkfTZJoLEtjhbN7y?=
 =?us-ascii?Q?RJ2WIhcpjBnujB+yHhAdArYO1PxOkH1AlTcDiGrufcgsxDNwpjS8MeW8Xtvg?=
 =?us-ascii?Q?YtTxLC5y+r7KPSzbDbA3qNeLn3rUa1fD39kmGzhmWhNFuqkXfJOZJt3367TU?=
 =?us-ascii?Q?ZuOG7cINv6B+FR6WCGxhZkH52VKX1/jWmm6GCxwEEwNDzf6cgupCPwpVzXT8?=
 =?us-ascii?Q?uE9zfNV7wLxIGcxZIsBq+OcIQqjvmZTjZiJuACN1Wvj8fom6PkJ1Tb6vPxKV?=
 =?us-ascii?Q?z0L54YGfvUEPJ6a54F2e3fNXYb6PxsxMs9Qq8p2UA2QcQnwUPBbMOg9rXxtT?=
 =?us-ascii?Q?rHnfduYrpu/s+cxCZaDa6OtQN9pd8pjGuLXl7Q8tkS7X6UDp4GlN7V/UYvSd?=
 =?us-ascii?Q?JPynbw3RvISxI/eFQ6xEVajs45WP61kKTn53gSv9vE6HyCCMJudHln1X6t4f?=
 =?us-ascii?Q?ziLMGQVw/S/YNQvua2N2xGQgh+le5C3EyROgyaS4IEzV1gpVh1F478IiXl76?=
 =?us-ascii?Q?w5rgbkVpSq60DKeBaGl/JVMtLOuS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:48:15.6422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e23644-b761-4066-1a16-08dc96b82d50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832

Mario Limonciello <mario.limonciello@amd.com> writes:

> On 6/27/2024 00:12, Gautham R.Shenoy wrote:

[..snip..]
>> 
>>> -	return CPPC_HIGHEST_PERF_MAX;
>>> +	/*
>>> +	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
>>> +	 * the highest performance level is set to 196.
>>> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
>>> +	 */
>>> +	if (cpu_feature_enabled(X86_FEATURE_ZEN4)) {
>>> +		switch (c->x86_model) {
>>> +		case 0x70 ... 0x7f:
>>> +			return CPPC_HIGHEST_PERF_PERFORMANCE;
>>> +		default:
>>> +			return CPPC_HIGHEST_PERF_DEFAULT;
>>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> Should this be CPPC_HIGHEST_PERF_MAX ?
>> 
>> Without this patchset, this function returns 255 on Genoa (0x10-0x1f)
>> and Bergamo (0xa0-0xaf) systems. This patchset changes the return value
>> to 166.
>> 
>> The acpi-cpufreq driver computes the max frequency based on the
>> boost-ratio, which is the ratio of the highest_perf (returned by this
>> function) to the nominal_perf.
>> 
>> So assuming a nominal_freq of 2000Mhz, nominal_perf of 159.
>> 
>> Previously the max_perf = (2000*255/159) ~ 3200Mhz
>> With this patch max_perf = (2000*166/159) ~ 2100Mhz.
>> 
>> Am I missing something ?
>
> Yeah; this is exactly what I'm worried about.
>
> How does Bergamo handle amd-pstate?  It should probably explode there
> too.

So amd-pstate driver calls amd_pstate_highest_perf_set() only when
hw_prefcore is set.

Thus for Genoa and Bergamo, since hw_prefcore is false, the highest_perf
is extracted from the MSR_AMD_CPPC_CAP1. See this fragment in
pstate_init_perf()


	/* For platforms that do not support the preferred core feature, the
	 * highest_pef may be configured with 166 or 255, to avoid max frequency
	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
	 * the default max perf.
	 */
	if (cpudata->hw_prefcore)
		highest_perf = amd_pstate_highest_perf_set(cpudata);
	else
		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);

Hence it doesn't blow up on amd-pstate. So it looks like it would be
better if the prefcore check is in the amd_get_highest_perf() function
so that it can be invoked from both acpi-cpufreq and amd-pstate drivers.

--
Thanks and Regards
gautham.

