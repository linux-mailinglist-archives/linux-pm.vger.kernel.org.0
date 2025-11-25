Return-Path: <linux-pm+bounces-38525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FE7C8363A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 06:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 692CC4E0F3F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 05:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C89280A3B;
	Tue, 25 Nov 2025 05:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="amQ0ZjaV"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329F13777E;
	Tue, 25 Nov 2025 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764048552; cv=fail; b=oqDsdIOXrzs2TKVlg1NOEeC52dpCiZ0ziECYcPfaoobjDNZOAT4HpdnvcxfIsEkmDSiXpuqsEO7o51AXtlxc0kK0MPXc+I6yutKyf8zNxtJMRvRgPhX7AO05b0w8p4VyomTlnoUh66qD6t2fC5FVLCScYkycUQ0bspDzl+quDz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764048552; c=relaxed/simple;
	bh=PIn6xKIcP/ln/+NmUIhaD23titQ8tzXVBJJeGEj3hJo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OX4FuC5SwLtamosH+dusiN+AFOOhKE/k7n2l9e4kY/gnMqIY9At4/OJs3e1I/dpzc/IkDLApNl/UxWgZYRCQIfBmIDcUHR+U028SL5zLAAoDO1ChnZAp50mPvvlo137AMHtW133a37e94MxvJSSySHOYfYhiT/uPE56tUr87/eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=amQ0ZjaV; arc=fail smtp.client-ip=40.107.208.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4vxJUMqypckX2bUBuqrjOtm3j1glmsbus9TAKHLUULG8Z28zReRSdxpuHXJzxLxK2jvb3mzqF1pI+neLyuiqxPvWepARZ5elVaYaCbQ+kyKDY0N6U9bLXG0SOpTK3YkJL3aHDqIv3nOqaHR44Kt/NF01ibO7WCmN7tGd8fitUvDWOciPqmeZ+a5ENnzb1mKSTnb76kEV7NkAm1Mg/PxVLmsamN2ob3I+CMJLX8+hPP3dNPY8sI/8ntnYxU7AIFG3wt+3Cm8UsYHABNjZibhmTNT3lutI+v49l7UAD38M6PdVqSdhifqQg/0E8yJ0d2ZVU8MxjDdgfQe+zYeiRZ3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAmoBGssPGe57xdUv3REo9ejyXbr58iwl3TZoW9aQus=;
 b=lBJVyFiBs5ZjGRcDKIJ82IWPiP8kuS7RYOZAa6y/VXgQDEnRgSDPVMq1gXgo1BPKvnt7nUtApd6fHimHxv8Q3YckXQjt8LWqsMN/XYhQEcqmd0Y8P5yVxq7FbI4fAuevxzTBPM0zbpd6e4kpVs2g2l/0iMqSiAAXMS755++De/1gzUd7tcvs7fpvfQvwz+NjfJb80k2YcKUhaG50d2A7KcciTm6pYXsVAEMLHVNKJsyCTLPLnjGgtTSK4SGhpFeZvYLN4paUfWnf0yXuCa692EzMFsPr6WXwgW3jRTYQ/BE4ol5SwPxFuGCbPhoTg7dShPUHy+hWtlE7wHnqY6/jDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAmoBGssPGe57xdUv3REo9ejyXbr58iwl3TZoW9aQus=;
 b=amQ0ZjaVEFzWQ6h0ooB/oIJhh1MQ3fAwjKsoGAnU7rQYFf5pkw2uwUqS2GNIXR7mpzaCx2zxj6jpU61bJ3AjqRKbFQKdN8tqEg/1TQqPGiGDslRI0gHzyT4X6ggJ6UWEiDYHgeNsbS7nkWdn59X+cg3cLSrb3Jx1mxYu1Ptc71A=
Received: from MN2PR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:c0::34)
 by DS0PR10MB6918.namprd10.prod.outlook.com (2603:10b6:8:136::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 05:29:07 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:c0:cafe::59) by MN2PR05CA0021.outlook.office365.com
 (2603:10b6:208:c0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 05:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Tue, 25 Nov 2025 05:29:05 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:29:01 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:29:00 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 23:29:00 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AP5Sx9l3126109;
	Mon, 24 Nov 2025 23:29:00 -0600
Date: Tue, 25 Nov 2025 10:58:59 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, Pavel Machek
	<pavel@kernel.org>, Len Brown <len.brown@intel.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Maulik Shah <quic_mkshah@quicinc.com>, "Prasad
 Sodagudi" <psodagud@quicinc.com>, Deepti Jaggi <quic_djaggi@quicinc.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] pmdomain: Respect the CPU system wakeup QoS limit
 for cpuidle
Message-ID: <20251125052859.ircunrhwwwnpw7pl@lcpd911>
References: <20251121100315.316300-1-ulf.hansson@linaro.org>
 <20251121100315.316300-4-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251121100315.316300-4-ulf.hansson@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|DS0PR10MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 707ddeec-3bf0-4661-6ebb-08de2be38cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wBIbg2L8trabHNdjsd/uQ+RrxKD6GS5EIGP6dzeiRnTrIeC9sKOibtr/MTw4?=
 =?us-ascii?Q?ieJ+ybZz0un0Jpz+1qyeY/Ktdya3p/gCOQ0mhfP03PI51Q7YP7UXO4FWlWrr?=
 =?us-ascii?Q?OfWXv1y9ieWRuUFZGxBUJ6kqbPpkFu6/h/WIKzbVEM5Y79RGdVb4FTRdXF82?=
 =?us-ascii?Q?XJEE04r+vJAlfU9b6yMU43+v3rqa4KMj29GzT+RIT/eHQkDNAUdVpfB6ynLO?=
 =?us-ascii?Q?VWxt5d8FMk9/NYi9d9ZwYpzYktiHQxH/4DSzL3FTxxosAXwBUEjuELb0Vw+k?=
 =?us-ascii?Q?vOL5UiET6DD9zfltCyGpzx2DXT61qIgl6LXgDrE04ZNYYAcQebwMy2hVg3H0?=
 =?us-ascii?Q?F85VUWox+3UnebpDlp2wBftBMI8P7a5MaZeVPxfgoZRutTASes2nqXCzrVX0?=
 =?us-ascii?Q?yvRe5n357hC0FS1rX2IbzdOAO22Qw0TKLB94vf4leJLsru2dq78AKlkVGgDL?=
 =?us-ascii?Q?OKRvmASMGuTyx6mcmSrojwW8FHof88ApBnceRBofWL5bDQVOaIr3pBFQk8/6?=
 =?us-ascii?Q?tNkXgPSwElMLl0ITx8nXc1fak8gRePNYozDInsCS1q01HbwSmrwuIDnJjQRG?=
 =?us-ascii?Q?bYZ3xUo2gfUPcDrCPe/t01zk261Ai0NNO4ObATZcVOZ1u6KahuEtMjrbHyvA?=
 =?us-ascii?Q?vXfutNeX5BmT12bNk5ZfMP2E7PPMLXOwAgPnkk+8pgeB3d7yZIrs0Z5U+Zjt?=
 =?us-ascii?Q?DyZ/Jy5bCYkcOO0WHfUlc+2dxSOMqJFPYoGyDWoXaTxZ4wB5h6JVt+bMiyEX?=
 =?us-ascii?Q?KH+fM9JW1hpbCOaCv3oLV+foIH8rv7xScqPkx9IQulbd2dvOi6/qfxKPxlfe?=
 =?us-ascii?Q?saTWevg7WZIaRVGb5/2JSNcm2QW3qRqI4RrobXePeoD2hceTmb0lZGIKWjPr?=
 =?us-ascii?Q?503j4BGrwsEkiwYMvw+oiUZa0Fr1cCpg1O3Ln4fModeTOGq4f6Ys/YB2opZu?=
 =?us-ascii?Q?TOiXZIdxVo01te+Sa8ROvAxtrrIDli8dU6FQpYcPA73Oyv5Z3NDZADkqvAl5?=
 =?us-ascii?Q?SYJXKXF/Y/CnjY8ete5IJfBKzpD8+rjRYQMpMONLhkmo3Bo+c184GGcW1Jd3?=
 =?us-ascii?Q?55RTXqRfMivMg8bMN78E2Fai8O30MxT9dSkH1KrAJTaSeu1oUnqWkV99EwRc?=
 =?us-ascii?Q?QQ402Ws2WmyeF8XmGNVFRtTz0z/h0NBRBlE+l8BNuj4HHTiEKUmEdAX8CkEh?=
 =?us-ascii?Q?TQTBiRCEdCJv9uGThGZDR+t65azcYbRutVdAtWZwWRpf2Byr1fxr+giTlsf6?=
 =?us-ascii?Q?UrY/mjspqoGZAKtcVmuPfWlaIJu8UxUhczMgUN3K9jJr5z/BhOYSDfkH8Hhw?=
 =?us-ascii?Q?Uphm+qbXYlaiI1QYw7M+KpECLyr284Ul+XzzBgwMDI2HosFmPLYVoyfZYkOf?=
 =?us-ascii?Q?vTeGt9TjI6Vsmh6vQMY4WXKHd610Lm7CBqnGsJgxrTOlCqdubDbF52BWYdtP?=
 =?us-ascii?Q?etvQkNE3yU9JiDfnQrbuxYtZ20iGd7nxdMFznpQizkErZPEMvxKyo1O4vSju?=
 =?us-ascii?Q?up2jf5/No19MjZB0jIXK5m9E0whNMoxzkGf58IaI9KqT9sGkKj2zP7LsBO2W?=
 =?us-ascii?Q?g7otUUvP0+Q+QkxfmF0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 05:29:05.4235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 707ddeec-3bf0-4661-6ebb-08de2be38cf2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6918

On Nov 21, 2025 at 11:03:09 +0100, Ulf Hansson wrote:
> The CPU system wakeup QoS limit must be respected for the regular cpuidle
> state selection. Therefore, let's extend the genpd governor for CPUs to
> take the constraint into account when it selects a domain idle state for
> the corresponding PM domain.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v3:
> 	- New patch.
> 
> ---
>  drivers/pmdomain/governor.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
> index bd1b9d66d4a5..05e68680f34b 100644
> --- a/drivers/pmdomain/governor.c
> +++ b/drivers/pmdomain/governor.c
> @@ -351,7 +351,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>  	ktime_t domain_wakeup, next_hrtimer;
>  	ktime_t now = ktime_get();
>  	struct device *cpu_dev;
> -	s64 cpu_constraint, global_constraint;
> +	s64 cpu_constraint, global_constraint, wakeup_constraint;
>  	s64 idle_duration_ns;
>  	int cpu, i;
>  
> @@ -362,7 +362,11 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>  	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
>  		return true;
>  
> +	wakeup_constraint = cpu_wakeup_latency_qos_limit();
>  	global_constraint = cpu_latency_qos_limit();
> +	if (global_constraint > wakeup_constraint)
> +		global_constraint = wakeup_constraint;
> +

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

