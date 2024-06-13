Return-Path: <linux-pm+bounces-9048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 510079064AD
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12A51F22B87
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 07:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BFE1384BE;
	Thu, 13 Jun 2024 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DBCzcuY8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AB112CD9D;
	Thu, 13 Jun 2024 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718262851; cv=fail; b=VywcHLPt94ZkBhhPhYDkSF3IrxZ+4AI5v9lpWxoks/9pEPM5SujBE7V88WIUSbUyGRl1XQanLNFUiOkuIO8G6nBuyyO3oksBHUdTawPlPegv8TzLjBWhDWUiNJQcQe8eH85W8Cc9XXBJjWlnh+IcYPcdzjbPkMuY8iU56POjhv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718262851; c=relaxed/simple;
	bh=d1Vg9vidtoLELt5qEBq053fWLhbQBNyX+rOwtOSSNy0=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P3CL5PFuYNhnqhlYyWpezTkijJjfGS0jC1WKoBRJ6BIigPrxnHvRQ9bW3bzOM2i0fIrqFBCisg5ePwJde2kUjda7yOEerw7wKpz1riQoxe28WHVHOzeVAq3NcHJ6xb3KPYfTNrrNZsfMbrL/1hVstx1nFgGH8KoXmBbZSkGoWfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DBCzcuY8; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Blo2s8FFZgml59eUzryslCGSJqxNDgQTTvoU4ZS2k0Z++gNGPCj3LHB4BdWiaRPxWvLPsJc04EqBZb9XxkhJhFwp3SZxBYq0h4QOw5+ncXvIPNXABKVAYuUcDzSub43faFZnICzFbvS2EEKgACDz9jdtqV1Vho45eoVKeWSSpHBSyX2REsGPsj9OJeXTOjyE8b/vFxEU43yko1iRD95xoaDSWwSgtWw9rDVtV01tcYPynJNdbhWihPmjDymGD1ZnESfFM1ypHIgd1jK2NrNg0DdZvqD951dQdUIDG+9JBWRnrwc1uJ+QDDm7SMTFfUZq+aKrR5w0rm0Oprcivu/K/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxNwsp/isx++u83ZmPchbbXVj9mzTzL0Ch3imV17VOw=;
 b=bLJepYSiWkyxuLJuZ00+YVEaDMajlCBuByhSWk8OxlnbppGLpHbOVcUSUs39n24P1dyayrHZA6g9Z+t67MsMJiaw15hIxcQzeeMnO5hZB+SaovJx1lNVIl+W83myNVlwoKpiOhdGBKYQRORGNH00hqwR4eAf1DtxDyPhDz7ARSH9zS/9GpzV63R2MZfG/UZR+l+RdADhoX6NYfthdtjbAQPlNmiJEyoGJPpsuVD0mUHpUtIisv/H1SiSmJLk0XJB+C7+mIzhBPR0vGpWl2sqfZLTvfA4dGZDDI1crc8gzABm2I0UWCp9ZJdZRYE3FLActz/Ad7AfYISKn+wMQDrtmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxNwsp/isx++u83ZmPchbbXVj9mzTzL0Ch3imV17VOw=;
 b=DBCzcuY8Qde4FDWGyeCQ4Bp/2UHDWi/2MEn/CSuvsnQN+vnJM7XDp5+V2b7FmcwUIs2CihDtdLQEqzHe45Nh5HZWRSN5KGWpJyoycgD4M2zH+xakGaB7TxXWzAtHH36BSWVXQ5/XB+s1XYnW5blKrru+BS2NF64Z9vH7ru5R+mo=
Received: from CH0PR04CA0069.namprd04.prod.outlook.com (2603:10b6:610:74::14)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 07:14:05 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::97) by CH0PR04CA0069.outlook.office365.com
 (2603:10b6:610:74::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 07:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 07:14:04 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 02:13:58 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>, <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] cpufreq: amd-pstate: implement heterogeneous
 core topology for highest performance initialization
In-Reply-To: <97b65a2294154dd469377a7a76ee738de7bf7aef.1718095377.git.perry.yuan@amd.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
 <97b65a2294154dd469377a7a76ee738de7bf7aef.1718095377.git.perry.yuan@amd.com>
Date: Thu, 13 Jun 2024 12:43:49 +0530
Message-ID: <878qz9jowi.fsf@BLR-5CG11610CF.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e302e4-c805-4c30-5f35-08dc8b7868a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|36860700007|376008|1800799018|82310400020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?63jk0CEuZ9BevSo1XKUVbIOkINcB2r31MZmuE1ekEslnFmldAaHjUVeB+OT5?=
 =?us-ascii?Q?9+R+8vTOZPhc1VbAw7ZMEDQjLFbziizMrrYR0qx0ldlK3U5q6V20i8bw4uJ8?=
 =?us-ascii?Q?/28dnqB/wdZLvDXtO+EwSuZiWTkegS+kOq6ns7DL7TeToMmtSpf1EPXt1ymX?=
 =?us-ascii?Q?IV8woSHFh8t/Z0yGyVXqvGXwTYHBAWVAQ8W7IbysgYJPBbz+pmKJg+j/aPTD?=
 =?us-ascii?Q?3y7DqBOH+xvjT6Asuvc2Oat0wsxPMK7CypGlmRzAJYSQaMyCdUBreDHflUe4?=
 =?us-ascii?Q?XNDapHRbss8rAodNc503IU8qdAhTUH8TJbRQ5ccL9aNqZ/XVUa6ru7t7piBJ?=
 =?us-ascii?Q?WJs7EwLWnCqHATbdusQsHe1FUuBLwZRNhK0Ql9qCt/A3f5I1llW/wNX56iOS?=
 =?us-ascii?Q?kmfeVIXe3uLA4SE+ePa3YJ7GluMqNLl43QVWpBCwm387r8z7bp39O78+7DM4?=
 =?us-ascii?Q?jrGuocha2nTeF7YrsWHT0V+p8+604V+Ja5VNmKDL+Sqp/MJ3U1S6mN7Ul6k5?=
 =?us-ascii?Q?5eaWjPvEHD1v5giygJh+wq4yyOTU4KoHjHq8eR0GggJbEL1Ygw34c8WLG7/V?=
 =?us-ascii?Q?DkugHQJrhW9tkT/tYj4+b4BLhNOIJSbZW0ZHwzDjvVY053ZJdds3OLEiHjnz?=
 =?us-ascii?Q?urFNwSBwcoRlEkQKsK2DDZ5OHHaNv6SsYo76gnbS482MlvSjGZvvMl0BcGhd?=
 =?us-ascii?Q?vxmYbKlc7meMDLbZZs+okrMghVGU412V+qDOqcc3MLOUKynVTaz2qzBaXSu2?=
 =?us-ascii?Q?/UGqpry+ayEYxN7R5CPSoTNKxUhVypqVl4tL5zI0c2ba8LT9noQeQ6/gXhtm?=
 =?us-ascii?Q?Wp9okMm+DwCT4ug3KepD9L0B8vX0IbCoHQbbgx1QRvx3sth/oIWQNIXBY2Mr?=
 =?us-ascii?Q?m9X9FaF7gS5DCGYOpe4fiJ1sOMvIYS+Pj9Sb7/wXoCh9E2LwMFgABUFGd/GX?=
 =?us-ascii?Q?ID3uSPIlh+T2Mwm6KCiBGPo907r/isdcnmy8/ALTPjWEbHAoWELsZdo6JZEJ?=
 =?us-ascii?Q?IT74R6zO0x9VNSl3fHdf2lmsAAHypgpVrtPU7snWLyNurin/qjGkqD99pHtI?=
 =?us-ascii?Q?Aa6j+wTb/n0u1qNjroYhVGaa9420dRs16bQCg5/KOjhIcMrR0CM/t5bC1x16?=
 =?us-ascii?Q?eAOpXKoQp0JvWQu8p5dziDlBdj2B0jaedlXwIeJwHFlp1/LDUacunQ1gYqJL?=
 =?us-ascii?Q?4mEoAiEGGBx47egWmTee6OmHA6iI9SsBXWiUcfNgfG0RvtHkYiN7WIY0YM7H?=
 =?us-ascii?Q?16MP0F/o9uFGXJpMpq+44Rz2otTltVZetDq0v+TS85UPJyZ7OXsa4KxtZpW7?=
 =?us-ascii?Q?HyvWOKSjJcrIPL4GOdRcVxzYhUDN+ifnU7tCpO+XtOdfQ4QSZU0NO3uUy+IX?=
 =?us-ascii?Q?NWq1kdeKB9Hit8J1UaSbhoLH5+FXKOF1H9KnUqtRt1hjU54hBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(36860700007)(376008)(1800799018)(82310400020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 07:14:04.5388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e302e4-c805-4c30-5f35-08dc8b7868a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

Perry Yuan <perry.yuan@amd.com> writes:

> Introduces an optimization to the AMD-Pstate driver by implementing
> a heterogeneous core topology for the initialization of the highest
> performance value while driver loading.
> There are two type cores designed including performance core and
> Efficiency Core.
> Each core type has different highest performance and frequency values
> configured by the platform.  The `amd_pstate` driver needs to identify
> the type of core to correctly set an appropriate highest perf value.
>
> X86_FEATURE_HETERO_CORE_TOPOLOGY is used to identify whether the
> processor support heterogeneous core type by reading CPUID leaf
> Fn_0x80000026_EAX and bit 30. if the bit is set as one, then amd_pstate
> driver will check EBX 30:28 bits to get the core type.
>
> PDF p274
>
> Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  arch/x86/include/asm/processor.h |  2 +
>  arch/x86/kernel/cpu/amd.c        | 19 +++++++++
>  drivers/cpufreq/amd-pstate.c     | 67 ++++++++++++++++++++++++--------
>  3 files changed, 72 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index cb4f6c513c48..223aa58e2d5c 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -694,10 +694,12 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
>  extern u32 amd_get_highest_perf(void);
>  extern void amd_clear_divider(void);
>  extern void amd_check_microcode(void);
> +extern int amd_get_this_core_type(void);
>  #else
>  static inline u32 amd_get_highest_perf(void)		{ return 0; }
>  static inline void amd_clear_divider(void)		{ }
>  static inline void amd_check_microcode(void)		{ }
> +static inline int amd_get_this_core_type(void)		{ return -1; }
>  #endif
>  
>  extern unsigned long arch_align_stack(unsigned long sp);
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 44df3f11e731..62a4ef21ef79 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1231,3 +1231,22 @@ void noinstr amd_clear_divider(void)
>  		     :: "a" (0), "d" (0), "r" (1));
>  }
>  EXPORT_SYMBOL_GPL(amd_clear_divider);
> +
> +#define X86_CPU_TYPE_ID_SHIFT	28
> +
> +/**
> + * amd_get_this_core_type - Get the type of this heterogeneous CPU
> + *
> + * Returns the CPU type [31:28] (i.e., performance or efficient) of
> + * a CPU in the processor.
> + * If the processor has no core type support, returns -1.
> + */
> +
> +int amd_get_this_core_type(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
> +		return -1;
> +
> +	return cpuid_ebx(0x80000026) >> X86_CPU_TYPE_ID_SHIFT;
> +}

The 0x80000026 parser doesn't have support for discovering and recording
the heterogenous stuff _yet_. Eventually I suppose it will get that and
until then amd-pstate will have to discover the core type by itself.

Even this, I find the bitfield way of doing things more cleaner instead
of using shifts and masks. Something like...


int amd_get_this_core_type(void)
{
        struct {
                u32  num_processors             :16,
                     power_efficiency_ranking   :8,
                     native_model_id            :4,
                     core_type                  :4;
        } props;


	if (!cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
		return -1;

        cpuid_leaf_reg(0x80000026, CPUID_EBX, &props);

        return props->core_type;
        
}

> +EXPORT_SYMBOL_GPL(amd_get_this_core_type);
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index cb59de71b6ee..fa486dfaa7e8 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -51,8 +51,9 @@
>  
>  #define AMD_PSTATE_TRANSITION_LATENCY	20000
>  #define AMD_PSTATE_TRANSITION_DELAY	1000
> -#define CPPC_HIGHEST_PERF_PERFORMANCE	196
> -#define CPPC_HIGHEST_PERF_DEFAULT	166
> +#define CPPC_HIGHEST_PERF_EFFICIENT		132
> +#define CPPC_HIGHEST_PERF_PERFORMANCE		196
> +#define CPPC_HIGHEST_PERF_DEFAULT		166
>  
>  #define AMD_CPPC_EPP_PERFORMANCE		0x00
>  #define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
> @@ -85,6 +86,14 @@ struct quirk_entry {
>  	u32 lowest_freq;
>  };
>  
> +/* defined by CPUID_Fn80000026_EBX BIT [31:28] */
> +enum amd_core_type {
> +	CPU_CORE_TYPE_NO_HETERO_SUP = -1,
> +	CPU_CORE_TYPE_PERFORMANCE = 0,
> +	CPU_CORE_TYPE_EFFICIENCY = 1,
> +	CPU_CORE_TYPE_UNDEFINED = 2,
> +};
> +
>  /*
>   * TODO: We need more time to fine tune processors with shared memory solution
>   * with community together.
> @@ -359,9 +368,27 @@ static inline int amd_pstate_enable(bool enable)
>  	return static_call(amd_pstate_enable)(enable);
>  }
>  
> +static void get_this_core_type(void *data)
> +{
> +	int *cpu_type = data;
> +
> +	*cpu_type = amd_get_this_core_type();
> +}
> +
> +static int amd_pstate_get_cpu_type(int cpu)
> +{
> +	int cpu_type = 0;
> +
> +	smp_call_function_single(cpu, get_this_core_type, &cpu_type, 1);
> +
> +	return cpu_type;
> +}
> +
>  static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
>  {
>  	struct cpuinfo_x86 *c = &cpu_data(0);
> +	u32 highest_perf;
> +	int core_type;
>  
>  	/*
>  	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
> @@ -371,7 +398,26 @@ static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
>  	if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7f))
>  		return CPPC_HIGHEST_PERF_PERFORMANCE;
>  
> -	return CPPC_HIGHEST_PERF_DEFAULT;
> +	core_type = amd_pstate_get_cpu_type(cpudata->cpu);
> +	pr_debug("core_type %d found\n", core_type);
> +
> +	switch (core_type) {
> +	case CPU_CORE_TYPE_NO_HETERO_SUP:
> +		highest_perf = CPPC_HIGHEST_PERF_DEFAULT;
> +		break;
> +	case CPU_CORE_TYPE_PERFORMANCE:
> +		highest_perf = CPPC_HIGHEST_PERF_PERFORMANCE;
> +		break;
> +	case CPU_CORE_TYPE_EFFICIENCY:
> +		highest_perf = CPPC_HIGHEST_PERF_EFFICIENT;
> +		break;
> +	default:
> +		highest_perf = CPPC_HIGHEST_PERF_DEFAULT;
> +		WARN_ONCE(true, "WARNING: Undefined core type found");
> +		break;
> +	}
> +
> +    return highest_perf;
>  }
>  
>  static int pstate_init_perf(struct amd_cpudata *cpudata)
> @@ -384,15 +430,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  	if (ret)
>  		return ret;
>  
> -	/* For platforms that do not support the preferred core feature, the
> -	 * highest_pef may be configured with 166 or 255, to avoid max frequency
> -	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
> -	 * the default max perf.
> -	 */
> -	if (cpudata->hw_prefcore)
> -		highest_perf = amd_pstate_highest_perf_set(cpudata);
> -	else
> -		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> +	highest_perf = amd_pstate_highest_perf_set(cpudata);


Without this patch, on systems without hw_prefcore, highest_perf would
be derived from MSR_AMD_CPPC_CAP1. The value of the highest_perf could
have been 255. 

This patch changes the behaviour and sets the default value to
CPPC_HIGHEST_PERF_DEFAULT which is only 196. Am I missing something ?


>  
>  	WRITE_ONCE(cpudata->highest_perf, highest_perf);
>  	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
> @@ -413,10 +451,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>  	if (ret)
>  		return ret;
>  
> -	if (cpudata->hw_prefcore)
> -		highest_perf = amd_pstate_highest_perf_set(cpudata);
> -	else
> -		highest_perf = cppc_perf.highest_perf;
> +	highest_perf = amd_pstate_highest_perf_set(cpudata);


Same comment as above here.


>  
>  	WRITE_ONCE(cpudata->highest_perf, highest_perf);
>  	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
> -- 
> 2.34.1

