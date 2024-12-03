Return-Path: <linux-pm+bounces-18396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873739E1275
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 05:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F7E164B10
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 04:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53953166F29;
	Tue,  3 Dec 2024 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NK9zEHPp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B121514EE;
	Tue,  3 Dec 2024 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733200654; cv=fail; b=BvEtcCkFE4wXcx1Hjf2t8L531hbUR3aSseRWm/8UDEsYhXapIycpeSRIIaK7qtPwDYwx6QYK7q89Bh8cPHc4zcx3yui13kN82PTNCcX3rZA48Oc9uoKcEGJwBWaReJfFTM13OvHzi/7TgDTEdLD6Gytq8EjK8E8wnBcjzoVZZSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733200654; c=relaxed/simple;
	bh=cnZ2JztMJoYdjxjCSyLTkYsbWAH0ZHb0DZTOMk8dVPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BtIqUCqFHGOvSLBeRDyOXiemCkkFSv4dicm+Rec3rkZv8GRyYq9Ctgu46MUYb4TkBAFdEOURw01U75bMig+K4Ez1ctlGuAgOo9M/+R8LyKkpW/Yq5hkGMRqPTQV5MjRE28+KqRudZxq8psm5PWIpO/YxhH8BCsNilZZMY5L8eXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NK9zEHPp; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtbsY/C21na2LSbDR4Ew447/JjZWIfTPalwqAUoyFhg83+GSzmYfU6uLDjBs223SRfipMhJDA1tyzfkfyGV8VKDIrx+DZvbQrfelVJdFzYjK4Aj0bB6FVo/IttnDBC7Ti2ryqGZzV5xNKXtbCl1qaMXFmJf9L3d0469MxqN74nf3wZWjGWY89OV/FJrWjZFIMkZN1ud1htfwphQyIPcE3F47z3U7Ph28V4MRBwGLpIz1agwEXU0tpLpy7W/+ew5OmHWW1x6a/zCrVPZkfzQ6y/XPs/RKEnRGZhhiZmmgzh2xXdZRbPx4abLELN8NeCDePTWqg/KS1jFBqYF0dPRhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq+tWep50DpcU4m3sb9iMyNGv8krFiNpqgo2+MXpFos=;
 b=xrBnNA43OGT0r5nUcGDyxhO1RzguGnm6DORVDIWuN+xzqMpB+yS2itlC1AboBsQKHi4rU138biPxgSLDXEqFRZv/OgC9Vt9eba13oce1AZcQHYEwAFKx+mSFQv0F/T/2aaHV0l8e+HAmvy8K51UFteL93WD+l7RyNnKJlpdTv2a89eZd8g3UaWVZsqCmunOJja4LVxC8Ff4F9JZ3cA/LIDN7v5DMeS8KsUjb6zF/0XY4jCQDeFWSbo+44P+9wPmdrGlXRnBKjxVVsPI0tmuERKPPastgVyidObtLkbMNcNDmPG8qtPfko3ypGQFPmyGvIjPWG0Zt1dPaJBfhcOonKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq+tWep50DpcU4m3sb9iMyNGv8krFiNpqgo2+MXpFos=;
 b=NK9zEHPp3E/ZNs2KOEDfauVL6vVat2lSXDeljg7L6m+Z7OIcNnKHXMOD3WCn1mk5U3mvMpo4mdrGRrg1FroJU8pmqGaclpsn9743MQ4T9diZJA2pe5I3UuiyoI3u89ARakP+wNkIRrZbxlHm9oaq2UKYKt6S4za4FDpCzjVXAZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 04:37:29 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 04:37:29 +0000
Date: Tue, 3 Dec 2024 10:07:20 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, peterz@infradead.org,
	dave.hansen@linux.intel.com, tglx@linutronix.de,
	len.brown@intel.com, artem.bityutskiy@linux.intel.com
Subject: Re: [PATCH v7 1/4] x86/smp: Allow calling mwait_play_dead with an
 arbitrary hint
Message-ID: <Z06LAJybfN1mdWAk@BLRRASHENOY1.amd.com>
References: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com>
 <20241129182232.14987-2-patryk.wlazlyn@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129182232.14987-2-patryk.wlazlyn@linux.intel.com>
X-ClientProxiedBy: PN3PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::14) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d3fa95-4510-45fe-d1a8-08dd135431d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hsyav+vAanmYIL8xTnydy46lRfihMWRArDilvh/zqqmXNt8AK6IyWY7dkOE9?=
 =?us-ascii?Q?Th14Fx5mYD34sqg7M3NHeZ5LBqkljF4pHiBfUsDEdgNzgTSgGHqh7HdPLyv0?=
 =?us-ascii?Q?7Ih60ebij/dvxUVrq4rjxBM+JfcEoekbmS/wBqJJBvYf16DP58ZGS31FH9Lw?=
 =?us-ascii?Q?9T7g/eLfYsEsT54Zt7bl9BQAIGbrpif2Q5l4TkkuqZpB7Bi2gnPkBMf4ShW7?=
 =?us-ascii?Q?S3DFOFBek3n3R4z1aOkchydbgH1pIMXGUwzJ1YRj+hcpKiPZdrNa8FWGkJyV?=
 =?us-ascii?Q?uC3UNobEa2yWP9gCAHcE6Jpnpi/SHDWWeIhFLTEaAN6wck6s5SBq6Ld9QmUG?=
 =?us-ascii?Q?DGXmnxZpjrV6y00kS1Hkn1cI5YXEHO3rpMATf7p3gXQcuTeYEeSSI/yv7Tse?=
 =?us-ascii?Q?ghI8LZjZDxxxlw6WX5/wS6hBZ29i+vZsuxcH6Nlzhv9KQ2uLMZ1OY+Z7Okzl?=
 =?us-ascii?Q?no1NPlylDXrEXrAaEH0hf+I83QCj/naH1wdfxLLALtfeBDNfxRI+K5ZD5PHr?=
 =?us-ascii?Q?c9iRXvWP5AHaje50RNC7tktIV/lHBm8eO5046ZXUCcNqpeqmIOORk74zJ+Gf?=
 =?us-ascii?Q?8jLKrl49b34/qERmKCaYBQPMxO6WNAQzB9l68DJti51HocJV9vYctmSRf0zN?=
 =?us-ascii?Q?OINe8XRSIYJgDkMMGBroZdk0bkwxJSJBCoZZpBjM0gFYsEjN4I+2NnuXhEy4?=
 =?us-ascii?Q?OgCKCx3myjXUoCcwDjc25gcSvmJspvNumEU8vanQG7ocKGuuzjCfQigT2avh?=
 =?us-ascii?Q?j+EEvgZiIyRZHzXS4K8p1K6GisohLcyeXBCIXQ8vmVsQFjcHzXx0tZdZ9Tar?=
 =?us-ascii?Q?AgEWVRnCJBpN+zUYEIzJrMF6Oi682Pp0wPWF8OzA9EXEH//BNq9x9wlV0eah?=
 =?us-ascii?Q?tjla6qUC+RN2nzCP1gyjdEt3tP1ba49Xg5J6xQypCE/V3idSha8nHhg384M8?=
 =?us-ascii?Q?Irpl+eQ3YocCOWpXcXpK/O+srhoj7FGedQVV7YhMSTlTGX0qW8l8RYzYK1Ac?=
 =?us-ascii?Q?KtX1ktUV6fx1zCgdY3C90SW2yDfxTx47sEspYKlxIFhBudbdzovjfOt4kPms?=
 =?us-ascii?Q?fKczrNuPMArc8jRgkgv07OcTRqxj8vb9WCZDcyd/XAwHVanMKz8rfjV6x/fE?=
 =?us-ascii?Q?AMcACQxuacIy+l74n3H2cq+JEtdGXTRrEh2BMnX7s8E7STLfP0vzjHTu0RfK?=
 =?us-ascii?Q?43yZWmxRMuQWiqP91+umdoRyafMXHmTW47vbWtvlxQPBSPSrq/Bk505ER/pz?=
 =?us-ascii?Q?L9H48WYaYjvZyGZKzgUM0Z55ikxIjtUR8BPlFvFb/EDpo/hmcTtewmUwiaf3?=
 =?us-ascii?Q?Rm9R5ML8HihiQzWzmlPC2EVaVFcg+qq6HTxZYfuP38pFSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fNXHSX0P7Zd1VHydfcBqbW9ZI7UfpbpLbs//Oso4xoCRYhexmj+FTJyWYdFp?=
 =?us-ascii?Q?HpZGe4EUh1CYTPvEhWN2Lg4byqs3VkM1BGrIIQF+KQshbPnSAYZtC7GIYdWF?=
 =?us-ascii?Q?V/c6zffMQ9fuH0ZV52EImVfQcP3DsZiZ8HtgIQzOwBFbNKqpPAC76mjUz3aB?=
 =?us-ascii?Q?ujP+cPG1tLblQshNsFoMsEbjvXYQxd/0HsoZ5igMMEgf3C9elBuD2b5LUDMm?=
 =?us-ascii?Q?CfVh7Ve7CJPfD3t6btYJzodwfsckNgLW+FjhSWAWIsOHe+V3oskuGtgv0/QF?=
 =?us-ascii?Q?rG+iUomo+Un33x03nKFX+jAY1l+Fz46CZ2xHVN/nFMLe9AF2+Ok5W2Jicqgh?=
 =?us-ascii?Q?jE88SMSH5h+g9Pr4Si26svTyRCC6L+TpVjIPDT9wm+/LyOhRRv+xbBzVFFrN?=
 =?us-ascii?Q?WbNF8rctT+/5xHGyv9Hl+GbnZm+bTGq4ndHZtvxtDj6Map6yOhkZV/DcA29Z?=
 =?us-ascii?Q?QzjjuNAeNwGFF6MW3Z54clwIOv8S4noSi2BkopxcsUsYonNeyx45jlr16ttY?=
 =?us-ascii?Q?WFiQD0ZCFdogyvUFdrBam72jglAZNKm/La5DTqDXUJprKUzwb3WN6WkeqG1w?=
 =?us-ascii?Q?EvvqQvYlqJOHPJZMkY6ppkfi3mjnjP9Jjl/vMQ+ircHQONEmxUANv/FEae9y?=
 =?us-ascii?Q?o2FViEWWYr0JIHehVzJdRa/vd31lSPoBUNevFQV4XqLSLbTtkbZ5viA6lwce?=
 =?us-ascii?Q?MkoX2fWyJiRo/VSmQTzJ3PjSMlYe8GmBSXdurAYNhjdUGyjq57uMQ4M4PV+p?=
 =?us-ascii?Q?56oSLOCqDikBhncWw8bcrGT8a1to+pMgHdxWm8Dhiy4MNeZHVk12iRTX+dSO?=
 =?us-ascii?Q?fQgEJZ0HZBydOZDi6n6mJ+5cGfM37Mydg51Q1B+LpGOnTjkKOG4tWIgy2WQ9?=
 =?us-ascii?Q?LrzETdMtlBEUMSf24Wj4P7Lq9Dv1bOPNOXgSF8C4VCVyBP5uSjLaxPneNvy5?=
 =?us-ascii?Q?LsUoxkowZ8rn+GepPa6IhF0k+z+VKUq0WC+ths5WOhCTae5feWA50Wj+GceS?=
 =?us-ascii?Q?XWD76A3MfdqJv8UeLsUJAGKNFJdUtlEYdY3p9rGpFZH6U88ZL8GrfGem/AcZ?=
 =?us-ascii?Q?9DG6st6f8Bwo/1JUYU5Sc8PsuXbf4S/l4Fopikm/jzoQQhOpbGHxYk+06tIv?=
 =?us-ascii?Q?vUkAKYO2z2XW8PKxQuiF7gLFAs0dMwcTXOiycrrgS3/KKbCEAQqfwQBGVINA?=
 =?us-ascii?Q?MKRGfWTac9EkLyeb82qGgSpPrqKb/FwNAf6KxgFHAKCpc3AVZEO618ypVUtA?=
 =?us-ascii?Q?bk/71pToAjsB9wZQ6M4SdfjlQWI6RVmlawy2kVCI1lTR3YzDto2XtscKX76E?=
 =?us-ascii?Q?3qVKKeCuxesMgrpYyEzu/V3pt9762Hur58BNi6ZV/jlDai3Ll24239OEOSjw?=
 =?us-ascii?Q?IIHbr07EA5ANpMjBq/bBQlgHXm0sYAsVceqqCkHZvWAyv/BnVA3wr8pYD8LC?=
 =?us-ascii?Q?7AB7S/33bdhM6FGlmHybrCl9r7eHEAvGlKdPObmdYOM8+glCkL7mnm8CK4gQ?=
 =?us-ascii?Q?0S8b4/wbv2igbJ+YpgLfDDg5FEzlhnE+fpM9JoJH/dAaRbt+ZrjjHye2dQD1?=
 =?us-ascii?Q?wD7lskfD+mKfoc2KKkL9cO/lGe0rxrVQKmadvcgQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d3fa95-4510-45fe-d1a8-08dd135431d3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 04:37:29.4998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADhGgbSc+4gPIdwbqhpXN7NCBpiMCeqHylbdIYO7KDMQ3AD7YQefgtHVF9F17LG+iQxANkxmYh8J5nXaeu9xTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033

On Fri, Nov 29, 2024 at 07:22:29PM +0100, Patryk Wlazlyn wrote:
> Introduce a helper function to allow offlined CPUs to enter FFh idle
> states with a specific MWAIT hint. The new helper will be used in
> subsequent patches by the acpi_idle and intel_idle drivers.
> 
> No functional change intended.
> 
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

This looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  arch/x86/include/asm/smp.h |  3 ++
>  arch/x86/kernel/smpboot.c  | 90 ++++++++++++++++++++------------------
>  2 files changed, 51 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index ca073f40698f..dfd09a1e09bf 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -114,6 +114,7 @@ void wbinvd_on_cpu(int cpu);
>  int wbinvd_on_all_cpus(void);
>  
>  void smp_kick_mwait_play_dead(void);
> +void mwait_play_dead(unsigned int hint);
>  
>  void native_smp_send_reschedule(int cpu);
>  void native_send_call_func_ipi(const struct cpumask *mask);
> @@ -164,6 +165,8 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
>  {
>  	return (struct cpumask *)cpumask_of(0);
>  }
> +
> +static inline void mwait_play_dead(unsigned int eax_hint) { }
>  #endif /* CONFIG_SMP */
>  
>  #ifdef CONFIG_DEBUG_NMI_SELFTEST
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index b5a8f0891135..8a3545c2cae9 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1272,13 +1272,57 @@ void play_dead_common(void)
>  	local_irq_disable();
>  }
>  
> +void __noreturn mwait_play_dead(unsigned int eax_hint)
> +{
> +	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
> +
> +	/* Set up state for the kexec() hack below */
> +	md->status = CPUDEAD_MWAIT_WAIT;
> +	md->control = CPUDEAD_MWAIT_WAIT;
> +
> +	wbinvd();
> +
> +	while (1) {
> +		/*
> +		 * The CLFLUSH is a workaround for erratum AAI65 for
> +		 * the Xeon 7400 series.  It's not clear it is actually
> +		 * needed, but it should be harmless in either case.
> +		 * The WBINVD is insufficient due to the spurious-wakeup
> +		 * case where we return around the loop.
> +		 */
> +		mb();
> +		clflush(md);
> +		mb();
> +		__monitor(md, 0, 0);
> +		mb();
> +		__mwait(eax_hint, 0);
> +
> +		if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
> +			/*
> +			 * Kexec is about to happen. Don't go back into mwait() as
> +			 * the kexec kernel might overwrite text and data including
> +			 * page tables and stack. So mwait() would resume when the
> +			 * monitor cache line is written to and then the CPU goes
> +			 * south due to overwritten text, page tables and stack.
> +			 *
> +			 * Note: This does _NOT_ protect against a stray MCE, NMI,
> +			 * SMI. They will resume execution at the instruction
> +			 * following the HLT instruction and run into the problem
> +			 * which this is trying to prevent.
> +			 */
> +			WRITE_ONCE(md->status, CPUDEAD_MWAIT_KEXEC_HLT);
> +			while(1)
> +				native_halt();
> +		}
> +	}
> +}
> +
>  /*
>   * We need to flush the caches before going to sleep, lest we have
>   * dirty data in our caches when we come back up.
>   */
> -static inline void mwait_play_dead(void)
> +static inline void mwait_play_dead_cpuid_hint(void)
>  {
> -	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
>  	unsigned int eax, ebx, ecx, edx;
>  	unsigned int highest_cstate = 0;
>  	unsigned int highest_subcstate = 0;
> @@ -1316,45 +1360,7 @@ static inline void mwait_play_dead(void)
>  			(highest_subcstate - 1);
>  	}
>  
> -	/* Set up state for the kexec() hack below */
> -	md->status = CPUDEAD_MWAIT_WAIT;
> -	md->control = CPUDEAD_MWAIT_WAIT;
> -
> -	wbinvd();
> -
> -	while (1) {
> -		/*
> -		 * The CLFLUSH is a workaround for erratum AAI65 for
> -		 * the Xeon 7400 series.  It's not clear it is actually
> -		 * needed, but it should be harmless in either case.
> -		 * The WBINVD is insufficient due to the spurious-wakeup
> -		 * case where we return around the loop.
> -		 */
> -		mb();
> -		clflush(md);
> -		mb();
> -		__monitor(md, 0, 0);
> -		mb();
> -		__mwait(eax, 0);
> -
> -		if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
> -			/*
> -			 * Kexec is about to happen. Don't go back into mwait() as
> -			 * the kexec kernel might overwrite text and data including
> -			 * page tables and stack. So mwait() would resume when the
> -			 * monitor cache line is written to and then the CPU goes
> -			 * south due to overwritten text, page tables and stack.
> -			 *
> -			 * Note: This does _NOT_ protect against a stray MCE, NMI,
> -			 * SMI. They will resume execution at the instruction
> -			 * following the HLT instruction and run into the problem
> -			 * which this is trying to prevent.
> -			 */
> -			WRITE_ONCE(md->status, CPUDEAD_MWAIT_KEXEC_HLT);
> -			while(1)
> -				native_halt();
> -		}
> -	}
> +	mwait_play_dead(eax);
>  }
>  
>  /*
> @@ -1407,7 +1413,7 @@ void native_play_dead(void)
>  	play_dead_common();
>  	tboot_shutdown(TB_SHUTDOWN_WFS);
>  
> -	mwait_play_dead();
> +	mwait_play_dead_cpuid_hint();
>  	if (cpuidle_play_dead())
>  		hlt_play_dead();
>  }
> -- 
> 2.47.1
> 

