Return-Path: <linux-pm+bounces-18089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A599D88EF
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 16:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EB32849AE
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C701B412C;
	Mon, 25 Nov 2024 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aWvkkIFC"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421F1B4123;
	Mon, 25 Nov 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547683; cv=fail; b=En/IdL/dR/79u2JDGD7n4emKQwR9hOdTA8vlsgvVdkqVs9+vvtPaADfvtLHMK2dal/lpxEJWN1n67ZtbARvCSso1VI5wJe+boQASwexZ4PBuyJLUk65QmKPiQIStOjgNWJFZb21PzJ43BRmH4AaI6Ns3fYBNdRSK5JS7aTLkETE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547683; c=relaxed/simple;
	bh=YW4/Z2evo7jV8AxpDDcyLtYICwxcrE1BMAMCeM8EZOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pqosByd1O195JzYbS38y3E8hDnomzoEy3ZDroIzpaK54aBJ51P5bW1posAe5PkBE8wQbB6pRLqHhvWPMoPcHNtphe87koJKwUE1HFe9tg4q9bJLdZuWDWpDw/HYQhVfQBH09J2R5u6qJwk9ZCE0dhgoG8VgzVe/kWGfgBrNjHBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aWvkkIFC; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSevxh1QLJQHQo+78H0y7Kl06c2SimE/r0BKsr1hRBjYW+dIxGYn7RSuS332Zex16u+XqC9/KiAFKmad3to8JqM4klnHo/E11+jD9OfaVZZ9woYV+51LKA751yVgRAptDouiF6J+DmCDQGkO8U13t1M+T6P86WU+FeRnlNzliva3quzrwb2P2ETbUTcdxXonHQmSISPxP/Uiy4kpmCvFG/0giwGxPobnZN5zhWzeZdfOH9aGOujMUEbYI8YfD2veDxob2zyRU87KrYz7UMIsFQYTZd+3d8vs0NUwMpc6MkPNd84vXWZXoM7rkCZswW5774x7hQybDjVZEXoGeU0bcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=752lBuNtbohIQsAXL+7Gk6REIz+6q6p5yCDpvzPQEbc=;
 b=chN9/aVOQDUhmNF0+ghCcZGgXINf67/RXyzBovyotOMzqE55aqTEuKmBfBKKisElkoMIqPMQ/hXyg/OTu6FyZBFamjuqipO3LcKpoxuR80Q2N+n/O2vjQ+mQAaPvu9S+Jmd1FNjWQzE4fSaE37YpnTj3OJJWEH3flxDwN8KXc0KYL1v7gXCcL1WiYqfaFMbwBPRkTky2WjbT+iYUxlMljOJQJcgCr1gETGBln7vfeCrhY3f9vcNIzQecJ/FhkVPeJJOyhHT6CDepVrFzRx8adActr/DsipGPfGrKWDlS3zGjKsup96M6cJ37GZ1B3Jx/vkpSiAgn3NhNXR4YMzIGFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=752lBuNtbohIQsAXL+7Gk6REIz+6q6p5yCDpvzPQEbc=;
 b=aWvkkIFCaB0WVkDxs7GEbHMJ5wz9dUNmx60QDyBlsaP8lb4AMEzGD/eXLerHtn++CPNFJ0Z8XonJioPfjNGikc5XAJFGt9t2GfjBSGXLtFWHklDftI4oZ6SpveH1u5XEKatRwy8GMojXoJIahANhA1CGha6Gc1+bYr39XHtQvnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 15:14:38 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8158.019; Mon, 25 Nov 2024
 15:14:38 +0000
Date: Mon, 25 Nov 2024 20:44:27 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
	peterz@infradead.org, tglx@linutronix.de
Subject: Re: [RFC PATCH v4 7/8] acpi_idle: Add FFH cstate handling
Message-ID: <Z0SUU+dEeF5NqNBM@BLRRASHENOY1.amd.com>
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-8-patryk.wlazlyn@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125132029.7241-8-patryk.wlazlyn@linux.intel.com>
X-ClientProxiedBy: PN3PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::18) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d49ebaf-5355-4dab-04a9-08dd0d63e08e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IAiDN3r7lgnAzv8JWBHIUyRVzSViYBLuWBF8gAUrNmT2LnEgrTrscxsYE4ch?=
 =?us-ascii?Q?tZLPKF6FP3vlqTNqBZXS67QNWI8zaFAMY3opPyIeCIadNpsnxuAuteBjwpfA?=
 =?us-ascii?Q?hMICZr5xXwUbFyw2zUdiNotaGyogRXnNKjtIPYoXK0o8SG3cMlYkiOOAgXP8?=
 =?us-ascii?Q?wBXIqY9BHmfuyHGBSj/q3MNoGkT9IZ+pJ45kNXidCxKfEoi197hUbj3rexGQ?=
 =?us-ascii?Q?LzbnxY26llViU09P3AbJLH0nUplw0CVFzopz2Gzf5nh3B7+n1kAKQiVUC2tT?=
 =?us-ascii?Q?PZdQB2tU0mZaSF471lqiLj8etY9nWCqHcesWmEwrWTWedf0Uwqf9PKlVxP1p?=
 =?us-ascii?Q?u+U54XAsDNA4H9CkhLbB9YP3pI4rgHn0Ctz8SINir7l0e412t0HAyU4dSRWz?=
 =?us-ascii?Q?rTzrkjhLnLwgYkVeCT1HGoLcssG813LIsyJNbj/zvfMd352ZLcCRtFJyUNV/?=
 =?us-ascii?Q?eebYz6E/8vBpBSBATtOZxhewJcQp0gRYbnn73/siLJSauEbcjZMD34Apr6DF?=
 =?us-ascii?Q?iE2/iZJTEqkkdEQcyiu9pmbmsyToG6tdwCNCstg6dnP9EQ0G3Kgjiv+gtgmo?=
 =?us-ascii?Q?jX1hY65WXUTirtij3SDaFRN3oTrKhf2ckNqesJA+vExjFLfO7LDulz7UR9Ai?=
 =?us-ascii?Q?tSQrxCo8IpSVlQGIwh6xUFMu7mUW/C44a3HlUvVNkDOPSzAE0FVYIhYYkSir?=
 =?us-ascii?Q?vv8CD8YDfHzloTHrNCkRoiJRw92ssPJ6WiHzxB/EivU1sFZl0l9J/HF4YPBv?=
 =?us-ascii?Q?kOwtq2WVNNRhwrfJ9LPTCXvQ3Fu0xS2uHGKdgFgUBpnaVnLylCXKbyOPhVWj?=
 =?us-ascii?Q?+PaR2Di2oKpwFaGsdQZoPm6pkGeFcYjLlkrdDM+6hkOI6cxsmH2pTMb0dcoR?=
 =?us-ascii?Q?D3SyBHE3/DTu264QqICvBhEr9YImooIr7duDcFA2YbT+s2d9cko+Fd6Mixk9?=
 =?us-ascii?Q?F0NQsB6g5KlIgJ7WKhwR/vtzH0Su/OFNc+tjUMOaVstN8kzuD206PQrdRmPu?=
 =?us-ascii?Q?SHVFbLsXJcQFHxVa7MH9pGgsNxmWby6j+Jm3F9lDM0dNiXWTVFwDqwG027QN?=
 =?us-ascii?Q?MY+K0UHVRgrwjBuWgs6jUzsv5jW3y/PRBYMehjeiZDUas+d48ruShKxrDBYT?=
 =?us-ascii?Q?GdAUYcrPol3eH6j1hUb/kNn9UZXUNITdOGqWm+vHfj+yHSDcwPj/sDY079e4?=
 =?us-ascii?Q?KORFWEfEMSQHJmSABVsoqg3F1KChBbG1YAVwD66SDMdtPol4iOxvd/zX+J3T?=
 =?us-ascii?Q?+rBCfOP4tWkP0bbaPVhKkPG4pdKm1hwBWS+aDU1taOyCcW72HYOaynM24w5E?=
 =?us-ascii?Q?+A2gU1Bq3FS9Gx8fTbLrGEc3Dfil6EQiOIWmQzCJ0Mti+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wm16YU9Fwobs1RZmmLNokpPPTgjvHJZp8HV8j7THbbfKYV15b392oNeiHIRO?=
 =?us-ascii?Q?0ZjBiDm9IbtktztlcaHVYOU/PglLad/91/dVa1nDIHmCOuoY1B3pBud91f38?=
 =?us-ascii?Q?jGdRBdeSdQum5UT3CrLkW+izEs4bLvVnHWvp+AuN4eQk1VFoW98NGIbBo8jj?=
 =?us-ascii?Q?xaKml+c8SCU/uMdrvpi6SVc01tfDvOw3hUYb08Xixb4gvvaLCdPLfJZ9jVLp?=
 =?us-ascii?Q?jmt2qhOihjf70Q+bxV0iBlJ1+sM3FS+d1LBCmAF9KTtt8lDH2ZhxFa9S7YBS?=
 =?us-ascii?Q?d77gy94cEAsx8bVxbrC/dRz4jI3MgOP4IfSFGiEfSAAdbUXkPJIai8VFwWC2?=
 =?us-ascii?Q?5X5VS0h7ItmP6icnctoY1CEVXOhXzrdeIpcTexgsSEP0k5ocGLJUlB/paKDm?=
 =?us-ascii?Q?+XuT+22vqZtf4SobI+OmryGPfwxjkbTV8L1wSP4XQxsiLqdXT4tv1KQ7XGn1?=
 =?us-ascii?Q?wnU5dhhwj1aeF8PlI1ff/4VSwCThn5Xszp680b8kJLfmk99YlHrNPXvOA9uE?=
 =?us-ascii?Q?Wg0JJgACUDbmHPLcytDjPdeHC01GQ1DuF5uSMzIKQ1bbp87zSOAvQvC9emKa?=
 =?us-ascii?Q?X2Qy5CGz3/ef66HtoQdlsI2TMMcrBdP61KuOkqSyOUWP03d2W2i3haEfF1p/?=
 =?us-ascii?Q?9NaAySwgHAT4se8Nl2D73qDldQi9+z/QN9YGTm8R3cLvdAby1EHcFi3SdnHr?=
 =?us-ascii?Q?zqpCMmX4khRMN98mQcdjPyLHL4BAis1dqdGVMXIbcHcpIsYnTDdUnqbUaXcr?=
 =?us-ascii?Q?K+At66d7Mhl1Vgh95UPZQilWoQ+yLxHAtO60e2B4UOJdGXqcxex+6d3z30Ko?=
 =?us-ascii?Q?eNRvtOmrBYC67T9vveB52b5aV3r9rrSANprg5B8pLKzX4jxMN03u7UGCeOui?=
 =?us-ascii?Q?QHbkRIPYwYeEKVMvQPIxECPP3BaDeuSgTEXh9qDBRWXp3px723Rh/1WFk3Tv?=
 =?us-ascii?Q?7Yr/yzVtXkWcEGRPHkmraRlBnxVdeLflaGPXeRjILmPjOc3HrtOavQFIJgTU?=
 =?us-ascii?Q?7kfskYdoVXQyFDZN8zzYuV7RYNemdMR5MAvbCaxWDJzz0Dy6cxJVIgkCs2SN?=
 =?us-ascii?Q?TZJ7dcOBEPpJctUDCp8owX1rGANA5JBEN2bWWTStYTgbAmi0KFzd7q5wxRx3?=
 =?us-ascii?Q?oEuIUJfbIOwqYe2CxeiEyDKC3TChJYSO2TgpvwsagHbl3rBgCui57o8pTcId?=
 =?us-ascii?Q?BA8CLRU0Zl9w6ZvJ4RM5h6eN6nI6GJ/bwP61/0BIb2eupTNtqdwFYsI6UFjH?=
 =?us-ascii?Q?0roqazMzfCh36gmJU7797UTjrtakgtWxg9jMnfJCkg8jfGbpXIHwuS3nb6gC?=
 =?us-ascii?Q?5k2Paccw32fKyiUcZNT6Y8ca+kCPPEg5WrOgArkS9rG3JWtqLgU9Du1iYPGm?=
 =?us-ascii?Q?OC+1+oLZDXoS0iHTPXGspQOB2Ip7J4+WYiY0DZWYciGEUI7oUD8G3XZOpgRw?=
 =?us-ascii?Q?cxIec+Md5xHYIc4X74Jcm+h8QspfyquLOWkk1RLXyRsgtpaYGzEEQPi22BLp?=
 =?us-ascii?Q?vDoFuAhPSczrMPuwflJT8hielz7FmmIVBJjIwMjbK2eYkHNL2DKrDqAd4KjM?=
 =?us-ascii?Q?28W0JOCKctNcVgv4RT2kMmo5mlGPJMi0v5XTGx5V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d49ebaf-5355-4dab-04a9-08dd0d63e08e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 15:14:38.0999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9sg6Hp5h0OEPKsULr8WziNo64YvWWjABNVKCVCnfEKGWB7RQnx6bj5Vgx3z/C6RxgCwRV0K+zZVq8i/0Boxxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317

Hello Patryk,

On Mon, Nov 25, 2024 at 02:20:27PM +0100, Patryk Wlazlyn wrote:
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

The patch looks good to me. But this needs a more detailed changelog.

--
Thanks and Regards
gautham.

> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kernel/acpi/cstate.c      | 9 +++++++++
>  drivers/acpi/processor_idle.c      | 2 ++
>  include/acpi/processor.h           | 5 +++++
>  4 files changed, 17 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index ea33439a5d00..1da5e08de257 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -236,6 +236,7 @@
>  #define X86_FEATURE_PVUNLOCK		( 8*32+20) /* PV unlock function */
>  #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
>  #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
> +#define X86_FEATURE_NO_MWAIT_OFFLINE    ( 8*32+23) /* Don't use MWAIT states for offlined CPUs */
>  
>  /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
>  #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* "fsgsbase" RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index f3ffd0a3a012..c80a3e6dba5f 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -204,6 +204,15 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
>  }
>  EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
>  
> +void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct cstate_entry *percpu_entry;
> +
> +	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
> +	mwait_play_dead_with_hint(percpu_entry->states[cx->index].eax);
> +}
> +
>  void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
>  {
>  	unsigned int cpu = smp_processor_id();
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 698897b29de2..586cc7d1d8aa 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -590,6 +590,8 @@ static void acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>  			raw_safe_halt();
>  		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
>  			io_idle(cx->address);
> +		} else if (cx->entry_method == ACPI_CSTATE_FFH) {
> +			acpi_processor_ffh_play_dead(cx);
>  		} else
>  			return;
>  	}
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index a17e97e634a6..63a37e72b721 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -280,6 +280,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
>  				    struct acpi_processor_cx *cx,
>  				    struct acpi_power_register *reg);
>  void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
> +void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx);
>  #else
>  static inline void acpi_processor_power_init_bm_check(struct
>  						      acpi_processor_flags
> @@ -300,6 +301,10 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
>  {
>  	return;
>  }
> +static inline void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
> +{
> +	return;
> +}
>  #endif
>  
>  static inline int call_on_cpu(int cpu, long (*fn)(void *), void *arg,
> -- 
> 2.47.0
> 

