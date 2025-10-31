Return-Path: <linux-pm+bounces-37233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6828DC26BC5
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 20:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8804C465F97
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 19:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCA23546EF;
	Fri, 31 Oct 2025 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fhx6EhfQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7CA341644;
	Fri, 31 Oct 2025 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938614; cv=fail; b=NW5CggMNOvWLRsDyhaPnMYOOyqadKfUdHf44Plflc4KGj8UNj4b/ccOGUXo3ELRkRphpPqd8RLcxwyX7C9V/to/cPaP+TmGvWsLJmcYHNK+osytshvpkq88ZNHbbSLqjqNKuJ6ldOUA/WYwnCItH0CZKQ3ispAJiFbfXGDoh85I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938614; c=relaxed/simple;
	bh=Kn6zFeCikJa0B/gMC/iJcJRIjZC1L/deY8SqAI2EmUE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oD43m2alz3PPQmK8/3a4fKiQ6eBHYR+0ygs4rzSj5Pr//NQhIzyS6AZz4ABMhEC59dyviVtWZXAI+eNn5k9j8FfFMMcwb8gfSEkCNvqfYW5vkDRdCVHAu35n4s6y/qrQIOI21N4ij4UruPsVb7rYftvyX2G0bBXhUCnKB9MJpKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fhx6EhfQ; arc=fail smtp.client-ip=52.101.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pK2Fv/N7ndyESRB1TIB06F6/p4Iapr26x+r4H2o4Hh5zSrCYva7qRXEKJ4gNG9wqzWAOFi4SwZ6L/fZQGxgKl1/CXtAeEipZbNLhMQoj65shL1JEgTVCFecRA1JALGpIEffX7rWt2pjaslMcJGp9rXuPXdHEQqvChP3rBLqDiII7ovQrYjqQnUkHfvqLC8ZUh0NW93HVv/hKWwBGppSGy25eRGNOHL7sSDjLq98mog5df8HS+q5wJdyfxxasvpERjjEy0XZTJdi6CZcgzgBoLqQNhAFpuv3cwxLqcmEKAiaj+QoFlhbgplUiU5o4ibyqopbwiXQisfOaN5QW/pkraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqYKc8BALkN3bRHMxdanIbA4HUYKB24U5nSXnj+UavU=;
 b=gBkP4JdXP6Todoaugn3UhgpbMeMl8YMD9cuVd2EwP3uBO1dDnB9jdS7ubX1NojK1D55wGIWshqFX3PdtNrLMPBY+9gqnfnjK/BaRMDXjWVGuR+uqnvlI8/F0dZnI2I1cYivMXqZEP/JXC0g0EZmxCz72Bad4GIsVhbKaVZT08hKTGT1xMcgAdP3f9XSOWuY4vGC3WACpGo98KsCOO5Px271zOklLanWCxUtY1SnN/RmrGccTf8A+3KA/tTbML+bAkcqV7jgziwmGLq0VDaxl8hhskdgfijyb1c0EoRU2ZCkOfnSic+0kJ80wN92VQZfB3pt6ITjSNkHo3+1UzeG2hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqYKc8BALkN3bRHMxdanIbA4HUYKB24U5nSXnj+UavU=;
 b=fhx6EhfQn5VHrozFY1nN7+BbNXiJh9rM8yIgf/PJQldHt23sfTldywP3HoocFaBZnt6nfTVM3fCXvv88rxqZo5ymECj1Oin2d6CqtbG/wh3NgTEU1jbFwPaakSkoqQdi17HokDAGdRXy48l/FrbMFt7HbVe6P8dbzbcZCx1Dtyc=
Received: from BN0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:408:e7::28)
 by SN7PR10MB6523.namprd10.prod.outlook.com (2603:10b6:806:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Fri, 31 Oct
 2025 19:23:29 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::f0) by BN0PR03CA0053.outlook.office365.com
 (2603:10b6:408:e7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 19:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 19:23:27 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 14:23:24 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 14:23:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 14:23:24 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59VJNNCT171995;
	Fri, 31 Oct 2025 14:23:23 -0500
Date: Sat, 1 Nov 2025 00:53:22 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, Pavel Machek
	<pavel@kernel.org>, Len Brown <len.brown@intel.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, "Maulik
 Shah" <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] sched: idle: Respect the CPU system-wakeup QoS
 limit for s2idle
Message-ID: <20251031192322.kpsy5biokvuywzdj@lcpd911>
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-4-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251016151929.75863-4-ulf.hansson@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|SN7PR10MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8ded1b-88f6-448b-2cae-08de18b2f7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|34020700016|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5pILgFxCWXvbVJ8Zn+uxEVlRA3bJqg4A5fltn5MZnzKNGBBVSuOTM5VLOSYT?=
 =?us-ascii?Q?6sdYcJoL4wYZMy0lbXsuHOAUFZvovA9MFBkXdcSc/l/VI9BrSQDZVBQ99RKR?=
 =?us-ascii?Q?5DpSvxivptcovbTyJkyiVjiXrYCZa7gFhmR3d5v2SLh2xw/cuhJZ6nTaTyeO?=
 =?us-ascii?Q?491iNKRrcU3yQJVpxb7mxqVUDs1OWjJIOua5YqBKnizP6ENP6OoYdcNe/h4n?=
 =?us-ascii?Q?EiTbXYR5vvGtweFr99jXzLLEvkj2h+cB8DaIcdfMUM08IKd4oamoEo+mEiZM?=
 =?us-ascii?Q?sCLr7ymmRQ3BDMq3sDLVUqSBjlLJgxk0GLbZk1Dbn2OtLYv8qyAhPAW0kw3v?=
 =?us-ascii?Q?N8dBW3GuNAIAT9uiWMnXa2VZKvbeAjpn7M/aNBcpEsZ+5JXmgL/cRP9Va6cn?=
 =?us-ascii?Q?o1sxzq2esWAIwam7n924c/DqgtZvNP58GPCEiZmJKnJiRBKH9H8/FkkpohA2?=
 =?us-ascii?Q?ayFbTwR5tuNCcTRMCtl/XBsXK1BVrbVo3EFDFL+3v1cReg+f032T5SXRXFb8?=
 =?us-ascii?Q?PcArRiQTuf1EWALNyL9xipoj4B/mkJ3m8ulzgl+2mamEaSXUxnYl9axHtBcR?=
 =?us-ascii?Q?wLFTQxchv33dBjF4WQmmLhwEMeZdKWIipoW7ASBoqgUAD6UjlQgNwUWxIvSw?=
 =?us-ascii?Q?Z/XaIJ/rR2KvwNUOKNKdmG+x+hoEUiQpu5h3iTEasyXTxIlt1JVu/E6txaV0?=
 =?us-ascii?Q?QITRgWG6WEvVjp9TQMDB7a/6wXWP+dKwH1OAQpXhaKsbuRtAtxjOjfcED4K0?=
 =?us-ascii?Q?+/SQgFnWeG+O0JaWiKjBG6RQ2V6qZnNm5fwFvecjQ5fXolL1PY3v7raNo5wh?=
 =?us-ascii?Q?a6l2LK1JvKGdWwuoUjY4TxEVIgzY0Pq7nkSOs99dgZJuogHos6xo/a4iC8NJ?=
 =?us-ascii?Q?NuG8nQQ+ItLCUSnIxfmhWE2t6u2TrrsXUeL/dsWoBNMKisZ42z0jDdz2UODG?=
 =?us-ascii?Q?pyH8vxB2gEljUfiSXSmpcvZ0M4JyCe89obQUz/KULVy8Tp6N4BfsWU5ZCURg?=
 =?us-ascii?Q?x7o4Ql4kZ8e4BDWrDjC+zg4jlI/b2XmBvtY9j5IAdWnzecOLB7gaq2+wc+hF?=
 =?us-ascii?Q?tVJX1ZG24WaRrPJYG9jBWD7KBCRNWR8pWFi+Vr+cnd5M5ceHz555UPaX7vo1?=
 =?us-ascii?Q?Xb3jx3651qBfEM01c8dYoT5N7Ei6neFKHuB+tH++gtYuJhZKyxC65hQPQjGX?=
 =?us-ascii?Q?3vGu5yLe57KUZTibB8fKuwfNQCDuX+2tuABpeMmdu5zurgCtU6xWhtvV/hVo?=
 =?us-ascii?Q?gWfl1juU8CVeawX9bpWemhROdExBdPDTsyFlpC92K2pO5Z+S3Jbdv4fmg9fI?=
 =?us-ascii?Q?ktEVpWjY3tFdtdOGTYtQ/I3JzNIi8+8LipIEHJJIl3mtUTW+P1pPkSzoIPWX?=
 =?us-ascii?Q?JhXJHo7UW/HmHKRRXKhQ0NE9QYbcaVhPvqvd7PBvYxdAHT44p35W6fChjBGz?=
 =?us-ascii?Q?zP+A4ao1aaTYZnb1HMvN7gnz12NhVsq61o+gVy+nwiGXG5XL/igo+DmvYjUr?=
 =?us-ascii?Q?oGU4e77VtCb5WdziLyAaVhvbwOXWIY4x/1mCsHbB2fRgU71u4RAsKBfIMY31?=
 =?us-ascii?Q?m63LUmq8i6iDXX/OZac=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(34020700016)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:23:27.4758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8ded1b-88f6-448b-2cae-08de18b2f7ed
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6523

On Oct 16, 2025 at 17:19:23 +0200, Ulf Hansson wrote:
> A CPU system-wakeup QoS limit may have been requested by user-space. To
> avoid breaking this constraint when entering a low-power state during
> s2idle, let's start to take into account the QoS limit.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- Rework the code to take into account the failure/error path, when we
> 	don't find a s2idle specific state.
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

This is only taking into account the new API for the
cpu_wakeup_latency_qos_limit, however what if someone has set
cpu_latency_qos_limit, doesn't that need to be honoured?
Just trying to understand the differences in both qos here and why one
is chosen over the other.

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

