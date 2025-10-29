Return-Path: <linux-pm+bounces-37014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1560CC18FF5
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 09:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2914561F88
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14523128CF;
	Wed, 29 Oct 2025 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r6YurKlr"
X-Original-To: linux-pm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011021.outbound.protection.outlook.com [40.93.194.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4975527F00A;
	Wed, 29 Oct 2025 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725426; cv=fail; b=R/a7b4ZNqxMBh8fUgo+T64ETyfaWdimr3ptD8PT164cwRuKt7KhPy/byYllef9lT5uOwdiEx5S07p5OxnW+Mim56260Zs8b+efXbY0KUdWftuTdiKffTMFNeAL1KJwRQ+UECG5NcBB1nUodxqBLuypWj8xBoU2BHdd+kalqYaY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725426; c=relaxed/simple;
	bh=18MsjrkPFZWZLTUKiuJqqRFfavsqzRldl/yalBqsbtw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCcCST43JvAlLQskadrciyPknM1e1+zMU2yWszyMShlS94TmEBXjpe831VoANr+Dd2+1Po3K+ceX533ntbT5/re3adt/OKwnxHRnfbZ1i9UtD4scdrffFv6cNXAHY5m3vikYFV2ApbyownLHst8lU73AVENwgEEkExhEn0Q71KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r6YurKlr; arc=fail smtp.client-ip=40.93.194.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYocuR0xLU1mu6K8eMuI6iR0gz7L0uPIoNjh/usLbGMlp3nq4ijs5UWuyrx6zZgvBOyT1cbebVssuhN9QRKBWUnfI+XsvLXmUpEaF99iZ2Ad8sLT7DElt4CwUJJ2M16fQiaqvkkdHVuhAQ6RZ1EZCufVn/rLErXScVhpW7w9Nu/f4a5tRu9B8iB2auMZiQAswrlkNIFiZUvn3PbAk+Wqs8Zt598DvcFnrbopjR2yAsPg0D6XuZIEZoL27qlYn6abC+DXmFeX6pVwCbEZnfIeGcBFtfrBa79lNOExUiX5I4mLDEAGxwHD0eMBpV7mJwBmHhf5GP+wgT+JucxOp/vSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buYNfnxBxAoimM4zUaAhYe0fb87lE0Pa1f3FFlt60lY=;
 b=Hev6XEvnXa32+TimlDDBcAIfaI6aJefC/bmy4O1hJ4ct1F190xKEK+dVMFCp6M4DR9zIbCYL4SbY3zzgdMqfWMm+xuw9Pv73MIPs1Xf80+2CTcIZdiAnkgyTh5aN43dMuIWqE+NFqid5vdix9N5/YsgVykuCQhF66TWWKRdnkqJIaxrlsxmN5mZ+Kn7IqHJZfdURdYgXohWnefCQ88hYQ0uuyudpnz4jIctiYC1ZrWEvi+SoCHlTkuXKTbFXxLOxvrlwtEIYlfYfnezSQbm3/xxqf34QmN0mJYA9PhZ6lVLQWUOmxn/yzNL500bGTaIPILtxv2K/SBsO8eJ8zNmrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buYNfnxBxAoimM4zUaAhYe0fb87lE0Pa1f3FFlt60lY=;
 b=r6YurKlrQ6aKnhvED7Myl4rfXfGrHGXk8NiHN8i+86EM1zaSUDO83kpvNZ9vZIgWX2G2VZn+wyWb8hmVDdraceZiihgaENFjWdfhXCcLlBf9V5Z6VvPGt41i/bfORl5d6CgEDEOfk8UAaBfY99HAU156wGaz49Y02sXdfl42heA=
Received: from PH7PR10CA0007.namprd10.prod.outlook.com (2603:10b6:510:23d::7)
 by CH3PR10MB7610.namprd10.prod.outlook.com (2603:10b6:610:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 08:10:21 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::b9) by PH7PR10CA0007.outlook.office365.com
 (2603:10b6:510:23d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 08:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:10:20 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:10:16 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:10:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 03:10:16 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59T8AFBQ3711640;
	Wed, 29 Oct 2025 03:10:15 -0500
Date: Wed, 29 Oct 2025 13:40:14 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, Pavel Machek
	<pavel@kernel.org>, Len Brown <len.brown@intel.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, "Maulik
 Shah" <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
Message-ID: <20251029081014.443psmqznd2pqm4i@lcpd911>
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-2-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251016151929.75863-2-ulf.hansson@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CH3PR10MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ba7758-8bb1-4dc9-a40d-08de16c29a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|34020700016|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W55oHfNQdj9Gad6nV5Qh8EgO2BpK7ff6ivThd90cm1x1IGl77n37nJPBOKxd?=
 =?us-ascii?Q?Wt/hhOPt+xvmS4THg5ipVdTCyrUnwKzKHbH8LUv1N0zz4F9K4XsgK+qh/pSi?=
 =?us-ascii?Q?UidJ1vdClT5Ql7qXSGHPZf8kaylDtyvmC6yrJxLNVNR8VxACGALejMUfn7un?=
 =?us-ascii?Q?yeoQG2ErLpdyrRYCMDGmu2lPyQL0+aeXt4aBokuktA2buWhEJUw7m7wnB/gr?=
 =?us-ascii?Q?+y92eRfIJWEBZtskucO6UIaYpLi8taFkJ+0jVuNzUlJmFOTXMSK7Dw0FV2at?=
 =?us-ascii?Q?iF8hM5sARYF7z5/vsYTUbu1kvH65DaTTfsK5wdmx51gWqWW4/S2x3Qjz0TqT?=
 =?us-ascii?Q?VboWLLzwCtT2VWlgcjxRzr4GQiOaYF906ZocohnZpAoOI7G2S2B5l4C5BRmA?=
 =?us-ascii?Q?+l5RzfnLx5bBGCg1PVSvlrcbzNszW3IxHQYDSSYReFQ1Fw3ZBP7oRT8Jh8cf?=
 =?us-ascii?Q?1okvQ9vY0Yjx9wYWaSBnxZEmm2qt/Et4TwTmQNkNRM3G8bX/HapTtrYp9Vf1?=
 =?us-ascii?Q?7WzCq5xCYa+1hAVJGj6biX1Fx1r2inAtah3b96LFyVWsAp7q3ZSx9PRnp9eB?=
 =?us-ascii?Q?LeDJBGs39eEdq6H1WtK9rx/Rr188B85Xt28EYaa4P+XlrydNuyS3f16leFnp?=
 =?us-ascii?Q?UpvobkhDuY/tN+E8y6EtbIyCpjHG521qbWxJ820wIZGCA4gfW70KdkMKjHsN?=
 =?us-ascii?Q?amrTc3lsBlao1OC/ARX4aYxwMJ2+gniTyMOCULrpZlrX+d0kQPwEC95xEiN5?=
 =?us-ascii?Q?0AOxnLZqQ59hnntG5zRCO8urOPKZYMkzMLpZyqkJHWdgvYU0sD0MfSbSuSvh?=
 =?us-ascii?Q?Hs9Q9mlnxYE1N028zL7etffikMz3uju5jn7Cpoh+eKW318xQXRvcehwav4qj?=
 =?us-ascii?Q?Euiwr6cWlO0aBM4WEubmnpb4BAcZnoCQIQ3ib4lKy3rAZj/Ifa3oKNvNi0hi?=
 =?us-ascii?Q?9IXhriqwwmx4UCQ8ZXbK5X84TXi0OJloeiB60vxb8qnkErKb2F4wrRoARJgj?=
 =?us-ascii?Q?4p9inhLG+vlZds2uiKeAPVIVO5fI9NiB3mBywkx1N2G559wFzFou5i4Vc2DF?=
 =?us-ascii?Q?PcwP0qxO+n4kHtTDs4WpyjYvlSCW6Neua/L7rdB49zQ38lJMDnvcJyD4nALn?=
 =?us-ascii?Q?KZXziqoFKTam31t1TKJyDEkcW1exn9ASjMUiCg4kfGepEjHl9ydavQQo42mr?=
 =?us-ascii?Q?deKGZX4brkyYWzFoFNsH34UvdZvECT8zh40zcCVOA6D6zRdg1LWASE/s8pTJ?=
 =?us-ascii?Q?Nkrml3LVWBOI4jki9kmyy2bTt3h04LWQbtwC98a9nF+Ej9aQ+Qa/NTnj0n3h?=
 =?us-ascii?Q?CHt5VqLTkPJ0/RZwSA0Mp5XALIi7qwso1pg9lbfPuFYvbYasfZSJefLjSUep?=
 =?us-ascii?Q?xkDm67DufIST2L3rVHyfcKXBiMTXvfkekOtlELDIc4COS+HOyKYYgLvUGeRa?=
 =?us-ascii?Q?Rmvo9y9doK0546dIRNiVD507VvdmwwHoBtx9m+vomsqMJr1nUITZux2sI+hj?=
 =?us-ascii?Q?oNuLEa4r04hIBQ4L5MfdZDq3bLWgu5M9kHwdP4BYBhvrEGN/JteRYYs4k+5E?=
 =?us-ascii?Q?SBMh0Cni6mkXUi5WbKs=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(34020700016)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:10:20.4538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ba7758-8bb1-4dc9-a40d-08de16c29a81
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7610

Hi Ulf,

On Oct 16, 2025 at 17:19:21 +0200, Ulf Hansson wrote:
> Some platforms supports multiple low-power states for CPUs that can be used
> when entering system-wide suspend. Currently we are always selecting the
> deepest possible state for the CPUs, which can break the system-wakeup
> latency constraint that may be required for some use-cases.
> 
> Let's take the first step towards addressing this problem, by introducing
> an interface for user-space, that allows us to specify the CPU
> system-wakeup QoS limit. Subsequent changes will start taking into account
> the new QoS limit.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- Renamings to reflect the QoS are limited to CPUs.
> 	- Move code inside "CONFIG_CPU_IDLE".
> 
> ---
>  include/linux/pm_qos.h |   5 ++
>  kernel/power/qos.c     | 102 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+)
> 
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 4a69d4af3ff8..bf7524d38933 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -149,6 +149,7 @@ bool cpu_latency_qos_request_active(struct pm_qos_request *req);
>  void cpu_latency_qos_add_request(struct pm_qos_request *req, s32 value);
>  void cpu_latency_qos_update_request(struct pm_qos_request *req, s32 new_value);
>  void cpu_latency_qos_remove_request(struct pm_qos_request *req);
> +s32 cpu_wakeup_latency_qos_limit(void);
>  #else
>  static inline s32 cpu_latency_qos_limit(void) { return INT_MAX; }
>  static inline bool cpu_latency_qos_request_active(struct pm_qos_request *req)
> @@ -160,6 +161,10 @@ static inline void cpu_latency_qos_add_request(struct pm_qos_request *req,
>  static inline void cpu_latency_qos_update_request(struct pm_qos_request *req,
>  						  s32 new_value) {}
>  static inline void cpu_latency_qos_remove_request(struct pm_qos_request *req) {}
> +static inline s32 cpu_wakeup_latency_qos_limit(void)
> +{
> +	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +}
>  #endif
>  
>  #ifdef CONFIG_PM
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 4244b069442e..8c024d7dc43e 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -415,6 +415,103 @@ static struct miscdevice cpu_latency_qos_miscdev = {
>  	.fops = &cpu_latency_qos_fops,
>  };
>  
> +/* The CPU system wakeup latency QoS. */
> +static struct pm_qos_constraints cpu_wakeup_latency_constraints = {
> +	.list = PLIST_HEAD_INIT(cpu_wakeup_latency_constraints.list),
> +	.target_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
> +	.default_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
> +	.no_constraint_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
> +	.type = PM_QOS_MIN,
> +};
> +
> +/**
> + * cpu_wakeup_latency_qos_limit - Current CPU system wakeup latency QoS limit.
> + *
> + * Returns the current CPU system wakeup latency QoS limit that may have been
> + * requested by user-space.
> + */
> +s32 cpu_wakeup_latency_qos_limit(void)
> +{
> +	return pm_qos_read_value(&cpu_wakeup_latency_constraints);
> +}
> +
> +static int cpu_wakeup_latency_qos_open(struct inode *inode, struct file *filp)
> +{
> +	struct pm_qos_request *req;
> +
> +	req = kzalloc(sizeof(*req), GFP_KERNEL);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	req->qos = &cpu_wakeup_latency_constraints;
> +	pm_qos_update_target(req->qos, &req->node, PM_QOS_ADD_REQ,
> +			     PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
> +	filp->private_data = req;
> +
> +	return 0;
> +}
> +
> +static int cpu_wakeup_latency_qos_release(struct inode *inode,
> +					  struct file *filp)
> +{
> +	struct pm_qos_request *req = filp->private_data;
> +
> +	filp->private_data = NULL;
> +	pm_qos_update_target(req->qos, &req->node, PM_QOS_REMOVE_REQ,
> +			     PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);

Please excuse the delay in reviewing these patches,
I was wondering why we have decided here in release to reset the
constraints set by a user. For eg. even when I was testing the previous
revision locally I'd just commented out this release hook, since I
wanted to be able to just echo 0xABCD into /dev/cpu_wakeup_latency...

It seems an overkill to me that a userspace program be required to hold
open this file just to make sure the constraints are honoured for the
lifetime of the device. We should definitely give the freedom to just be
able to echo and also be able to cat and read back from the same place
about the latency constraint being set.

One other thing on my mind is - and probably unrelated to this specific
series, but I think we must have some sysfs entry either appear in
/sys/.../cpu0/cpuidle or s2idle/ where we can show next feesible s2idle
state that the governor has chosen to enter based on the value set in
cpu_wakeup_latency.

Thoughts?

> +	kfree(req);
> +
> +	return 0;
> +}
> +
> +static ssize_t cpu_wakeup_latency_qos_read(struct file *filp, char __user *buf,
> +					   size_t count, loff_t *f_pos)
> +{
> +	s32 value = pm_qos_read_value(&cpu_wakeup_latency_constraints);
> +
> +	return simple_read_from_buffer(buf, count, f_pos, &value, sizeof(s32));
> +}
> +
> +static ssize_t cpu_wakeup_latency_qos_write(struct file *filp,
> +					    const char __user *buf,
> +					    size_t count, loff_t *f_pos)
> +{
> +	struct pm_qos_request *req = filp->private_data;
> +	s32 value;
> +
> +	if (count == sizeof(s32)) {
> +		if (copy_from_user(&value, buf, sizeof(s32)))
> +			return -EFAULT;
> +	} else {
> +		int ret;
> +
> +		ret = kstrtos32_from_user(buf, count, 16, &value);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (value < 0)
> +		return -EINVAL;
> +
> +	pm_qos_update_target(req->qos, &req->node, PM_QOS_UPDATE_REQ, value);
> +
> +	return count;
> +}
> +
> +static const struct file_operations cpu_wakeup_latency_qos_fops = {
> +	.open = cpu_wakeup_latency_qos_open,
> +	.release = cpu_wakeup_latency_qos_release,

> +	.read = cpu_wakeup_latency_qos_read,
> +	.write = cpu_wakeup_latency_qos_write,
> +	.llseek = noop_llseek,
> +};
> +
> +static struct miscdevice cpu_wakeup_latency_qos_miscdev = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "cpu_wakeup_latency",
> +	.fops = &cpu_wakeup_latency_qos_fops,
> +};
> +
>  static int __init cpu_latency_qos_init(void)
>  {
>  	int ret;
> @@ -424,6 +521,11 @@ static int __init cpu_latency_qos_init(void)
>  		pr_err("%s: %s setup failed\n", __func__,
>  		       cpu_latency_qos_miscdev.name);
>  
> +	ret = misc_register(&cpu_wakeup_latency_qos_miscdev);
> +	if (ret < 0)
> +		pr_err("%s: %s setup failed\n", __func__,
> +		       cpu_wakeup_latency_qos_miscdev.name);
> +
>  	return ret;
>  }
>  late_initcall(cpu_latency_qos_init);
> -- 
> 2.43.0
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

