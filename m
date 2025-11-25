Return-Path: <linux-pm+bounces-38526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9203AC83676
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 06:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FC33AF19A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 05:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACA721E0BB;
	Tue, 25 Nov 2025 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R7UCo+1g"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9814520FA81;
	Tue, 25 Nov 2025 05:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764049163; cv=fail; b=JleLU52v3kNkafUBUndtyslj5A5imXxTUMEc8JnVCFHHhHiQJjLQdv9H8EdoyffEyEPDV6CPEaYzIukerlCwPzUhKrOdAmQRwHra758P5Un+0oo0ulYEKCUy+5JhNgzmKfFQoVLQkd0auyObOvXt8nsialUbH2ZM0Njfd1A0Z0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764049163; c=relaxed/simple;
	bh=9k9gioewkKuYt1Yt+oTrrvPaOUfsVfyYKfZ2mYZwRXk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNtWXlkOJfo1nCxID+HGiU0bW0RowIPVikrI7y8LpkUK1NUajSXRo2mpD45N/KnkkjRkWJVAklI+wn4C74iIVEqTR5DJksZTR8Yj0TRsd8Z3iVHRwXzD/b9nPa9sUixWjtOAaLqfEjxpM87nMfYl4sAa89ctR2fhzs1PsWReEeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R7UCo+1g; arc=fail smtp.client-ip=52.101.62.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoMOjazIdyIirRu5pdWFjktxbYHE/tFEtdv41kxaMJRSTNVLVsj1vpFEZrFQbZ4sAGyC49h2uAU9dsKy6dNS2Mfok9X+PleeqovJ4A+2V14A/+LLAtA85WFlaRR06ZLEE+sWwnbsdAywN3Uktyd0mxrWyIvCTfjGc2tjn6y+iGC7CzA3yxnIv8HI2hIT7uCeC2xwYaHFJIGzLL1ltnd38ep4N0opKApQma6eLcfE7dWEPGnEXNS7knSMhcUEervzH4onwPj0QLwHwgEmXRQjBQ6L02QpbtjxfnOR3VcWrN6DxQFqg6mCXRUODvDCjYMTJXTHxjqUU3Xj9btoOIKyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tw48d+HnM/IgkREmFmk0M6Dc+nwAhQLWh2a3Mp6oii8=;
 b=lgEEEOn2WweT2C15S/PrSWrzAcx5D1pjjCkzoEMPqwEnDoWXCQb4r9wMvj9IXqvbjf/ZcAdD44jsuQzpiPYBSUouehPMoxE4qqzkMlbjjlxvScjYApPUwN87yUaI+c7T2dvRLbIUE5TpFQl3sV+J0mOW9e3WzYKRpXHHnFgFELLE04xRv3O8Z4ED0U5DtXBvJ0EsgTQdTiUl8kvZTSOfu9UG/u4VgO1+0gvK8aWUq655bRYYjWLuNWbE1I6xWOfRrnNz4HmkThEYflrRnZXkZsR2wzcj+HyRtkNSDg7LC6lZyBQEbEegNcc0Z6WHZ6zwIXWzkUbDMMWohhRLlYBdmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tw48d+HnM/IgkREmFmk0M6Dc+nwAhQLWh2a3Mp6oii8=;
 b=R7UCo+1gJ5b4gSJYcSbwVH0dfmTK5M1XkwakiXIaR7HPdKf1nuhM3NSFCLKkB4LPBuYi+FHeGJGJddexIYTt9dTNuP0er/H3xONPOhybFdfrc3KpG+rMXpvnEkJwaHNC8H2cKTbtgWGLmvDw2RfRECnjkNTKWi7h/lMns7xSBGA=
Received: from BN9PR03CA0352.namprd03.prod.outlook.com (2603:10b6:408:f6::27)
 by MN6PR10MB8069.namprd10.prod.outlook.com (2603:10b6:208:4f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 05:39:17 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::5) by BN9PR03CA0352.outlook.office365.com
 (2603:10b6:408:f6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Tue,
 25 Nov 2025 05:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Tue, 25 Nov 2025 05:39:17 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:39:14 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:39:14 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 23:39:14 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AP5dDJS3139508;
	Mon, 24 Nov 2025 23:39:14 -0600
Date: Tue, 25 Nov 2025 11:09:12 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, Pavel Machek
	<pavel@kernel.org>, Len Brown <len.brown@intel.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Maulik Shah <quic_mkshah@quicinc.com>, "Prasad
 Sodagudi" <psodagud@quicinc.com>, Deepti Jaggi <quic_djaggi@quicinc.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] sched: idle: Respect the CPU system wakeup QoS
 limit for s2idle
Message-ID: <20251125053912.nxtqotznyxib6nev@lcpd911>
References: <20251121100315.316300-1-ulf.hansson@linaro.org>
 <20251121100315.316300-5-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251121100315.316300-5-ulf.hansson@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|MN6PR10MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d0602d-aab2-4a35-3eef-08de2be4f9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Od0kv2Njhgbd+s6JKMpQJUmTzW3xTBeNxq1E5sj4lWc3OLTWiYWuBeR1Ihm4?=
 =?us-ascii?Q?t8YKNfb+Ro5ggCo1CieYxVApccrEWs0qCAmg3/hzGkqDOCtcpPc8+Gb/Hv65?=
 =?us-ascii?Q?QnspjLm+1NSvLQgLGJax34PmXDHJkOSidDz9/JpRLDgHAMkMXliw3JRDaQgA?=
 =?us-ascii?Q?974l27sayFkGLj4XGKEVLXgl9xGYtSP6+PbijhITWm8LyrmG4OsRI2fw3J+Q?=
 =?us-ascii?Q?8ZRKTz3DiowdaMmNtkMFYJxBYYz+joqeVxzG7YFiaL3XfI33gnCaDgzkiJ/Q?=
 =?us-ascii?Q?Dc6dqTs7Sp41Bp5aKTE/YvpuLUPGRRkGu8SPzKoP902YxAnYYiadlyJhj7i2?=
 =?us-ascii?Q?ct2ygrX8evA75/lt3I6sy9XOxOpyiD9LRCN3hGJgVF+qdzVN91xfFkN5HV7v?=
 =?us-ascii?Q?1JmSXeAHPSxPUcquLNtHGI373yFeqR2vtRlslkQfmNU/IDjACG5SFqAJFjpM?=
 =?us-ascii?Q?DNRRrpd3Wi/+V/XHfuQwnWl24LIaAuEvRGg6+4BdxN4r2lWwcVsyl2/mP3iM?=
 =?us-ascii?Q?nCJ0kZxxY9BnYgfuopN3E4GgL8JMkss6fV+KwmaOBgIb/XsqEzB+AHp+TfBf?=
 =?us-ascii?Q?6euPcKl2LwoJtWPkRXOxDQq+fqdHUTCa0iQF6RLbVjDMzxE9b3VVvFH7GKHA?=
 =?us-ascii?Q?6dOaGGBVM7+5B3A7VLX5HuU78A8nAnM7yN9PB4thI0eEr62O+KwEalZ577+L?=
 =?us-ascii?Q?dwgqZm7XZF2tEdI4s83nv4E1OEA0o7olRDeIViwXW7PGdXp8LSxCSwnRtK6T?=
 =?us-ascii?Q?Yckt8LNd4J3igtahFzqamouV30mzm2W0+PS4aM65HuI6O9oXercNbk6a4yTq?=
 =?us-ascii?Q?sRc3/X6gj5iMAtkZhUHp5WXXsrdTqbOqRH7V/kToOgwgGn/lxxuPYyrXMkRw?=
 =?us-ascii?Q?EX7T79ozM0oPhaBfJ3XLbmKjFcXdIYtfQ5oIxczdGASDuZmXP6PE6JzecO9O?=
 =?us-ascii?Q?FC+Dq50VLQrboaWwfVtpzHhCP+zUw5omL+GjXtsiUkOnesLTUt1lH+9nnmFY?=
 =?us-ascii?Q?r4tpQ6Jy7WT+IdruUbkh5/PLFIuwKx/htTSU4wAK1Zyf+M2mDa2i7+XwrdMJ?=
 =?us-ascii?Q?0AdeJSZfVpZ9R6BHXcSLxARrksFBbCIRd1rhKUAiWIEqSkLOVXD8dnxpMJ8S?=
 =?us-ascii?Q?jA6VLBImgBywLep9AdIQx0y1qGjLeVhOvxdV6f4Qn6W6yOkaU6ra2FtHmtjt?=
 =?us-ascii?Q?dYAX5AbB/OfWmmuKIS9a6FQIAZ0TdCZgntAZkZfIHqfbDVUX7S47QqDJhC5U?=
 =?us-ascii?Q?BnJQNf4/pFXAXKFlSFP7SQedPf5NhcbzI7g/sN4MPWv3qfxnIDkZ8WjfK6hC?=
 =?us-ascii?Q?uor2KdE8i7mpu0tKRDi9aLDtPr0LisHXfe0x2rhAfQ+dG6M8X9FurM5w4c50?=
 =?us-ascii?Q?g+17S7nYeRm5m0UHMQWU5C9lcDun+1ZnRSP+JLvFjm++UaAWEsYgijDangXj?=
 =?us-ascii?Q?Pvf798DKpFcG8JAwjnJP3Y8zCNLYfVvCEBO+KXUKJKEm3/I9uteYRRQjeuNa?=
 =?us-ascii?Q?eAl23ojOBES1pLQe1iRmCeSDW+TGO60QOsgYZw5Wo7RoyW5De8d9qmJNAn3D?=
 =?us-ascii?Q?6hpvNPZczPwJCsu5GHI=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 05:39:17.7358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d0602d-aab2-4a35-3eef-08de2be4f9e9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8069

On Nov 21, 2025 at 11:03:10 +0100, Ulf Hansson wrote:
> A CPU system wakeup QoS limit may have been requested by user space. To
> avoid breaking this constraint when entering a low power state during
> s2idle, let's start to take into account the QoS limit.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v3:
> 	- Updated commit message and added ack from Peter.
> 
> Changes in v2:
> 	- Rework the code to take into account the failure/error path, when we
> 	don't find a s2idle specific state.

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> 
> ---
>  drivers/cpuidle/cpuidle.c | 12 +++++++-----
>  include/linux/cpuidle.h   |  6 ++++--
>  kernel/sched/idle.c       | 12 +++++++-----
>  3 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 56132e843c99..c7876e9e024f 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -184,20 +184,22 @@ static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
>   * cpuidle_enter_s2idle - Enter an idle state suitable for suspend-to-idle.
>   * @drv: cpuidle driver for the given CPU.
>   * @dev: cpuidle device for the given CPU.
> + * @latency_limit_ns: Idle state exit latency limit
>   *
>   * If there are states with the ->enter_s2idle callback, find the deepest of
>   * them and enter it with frozen tick.
>   */
> -int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> +int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> +			 u64 latency_limit_ns)
>  {
>  	int index;
>  
>  	/*
> -	 * Find the deepest state with ->enter_s2idle present, which guarantees
> -	 * that interrupts won't be enabled when it exits and allows the tick to
> -	 * be frozen safely.
> +	 * Find the deepest state with ->enter_s2idle present that meets the
> +	 * specified latency limit, which guarantees that interrupts won't be
> +	 * enabled when it exits and allows the tick to be frozen safely.
>  	 */
> -	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
> +	index = find_deepest_state(drv, dev, latency_limit_ns, 0, true);
>  	if (index > 0) {
>  		enter_s2idle_proper(drv, dev, index);
>  		local_irq_enable();
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index a9ee4fe55dcf..4073690504a7 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -248,7 +248,8 @@ extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>  				      struct cpuidle_device *dev,
>  				      u64 latency_limit_ns);
>  extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> -				struct cpuidle_device *dev);
> +				struct cpuidle_device *dev,
> +				u64 latency_limit_ns);
>  extern void cpuidle_use_deepest_state(u64 latency_limit_ns);
>  #else
>  static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> @@ -256,7 +257,8 @@ static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>  					     u64 latency_limit_ns)
>  {return -ENODEV; }
>  static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> -				       struct cpuidle_device *dev)
> +				       struct cpuidle_device *dev,
> +				       u64 latency_limit_ns)
>  {return -ENODEV; }
>  static inline void cpuidle_use_deepest_state(u64 latency_limit_ns)
>  {
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index c39b089d4f09..c1c3d0166610 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -131,12 +131,13 @@ void __cpuidle default_idle_call(void)
>  }
>  
>  static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
> -			       struct cpuidle_device *dev)
> +			       struct cpuidle_device *dev,
> +			       u64 max_latency_ns)
>  {
>  	if (current_clr_polling_and_test())
>  		return -EBUSY;
>  
> -	return cpuidle_enter_s2idle(drv, dev);
> +	return cpuidle_enter_s2idle(drv, dev, max_latency_ns);
>  }
>  
>  static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> @@ -205,12 +206,13 @@ static void cpuidle_idle_call(void)
>  		u64 max_latency_ns;
>  
>  		if (idle_should_enter_s2idle()) {
> +			max_latency_ns = cpu_wakeup_latency_qos_limit() *
> +					 NSEC_PER_USEC;
>  
> -			entered_state = call_cpuidle_s2idle(drv, dev);
> +			entered_state = call_cpuidle_s2idle(drv, dev,
> +							    max_latency_ns);
>  			if (entered_state > 0)
>  				goto exit_idle;
> -
> -			max_latency_ns = U64_MAX;
>  		} else {
>  			max_latency_ns = dev->forced_idle_latency_limit_ns;
>  		}
> -- 
> 2.43.0
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

