Return-Path: <linux-pm+bounces-38496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E31C821E8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 19:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E733A8DFE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 18:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F097631985C;
	Mon, 24 Nov 2025 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kVVWkzXb"
X-Original-To: linux-pm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D5B3191C9;
	Mon, 24 Nov 2025 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764009426; cv=fail; b=A1Iyp3XpEXs0wj1/Nhh2Lm8vinTiaE10xAUig4oHAWDF4/GkyXe+G2M7R39YYgiuUYxW9sIRDve0EqSOuVw5A+Efh0sl6gRagUFzMslukBJNa/7ZlyaOt6inc+Xd5k6KZNh/KebWEJxoW/01fI2m1hsFXje8xtjUJ0frm6zy5gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764009426; c=relaxed/simple;
	bh=hw0oC95Lq1BEp7YwZLUUdSgebhg4tH/zSQM010fup3c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBn7fNCXutl2L/xRNk2KTggRR7SABz8ZiFv9LC6t/2LnFXDtbC2/XLARQxWRS9R9LQddSEr3ZetD5miJ3CfWPByI0P//M0HBzWCznwKbTAKl5TtbENxL7zExoiAPZ5aPHasWydZkUItjaHhEJ7dKAt5XwNyqJUStG1vLbvuYuE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kVVWkzXb; arc=fail smtp.client-ip=52.101.85.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lshghe0oW8wei/M6iTdzWiaDkyxKFQNuobE2CWjJcMpRQbl+KRP5pxI/XaIC7sI+JY7EhIe81nSYrID3MMAQU0r7ktJrREckwxkDm5kiZMkqf7bKqeWbMxdHpbctyIGxWPI+l5oxJ1kExmO2/EXaPmvc6z/UquvvMlll1J3lsaYhcylpv6drs16YEbccHZ5hGfIRwckcIxPZd15H6T/JQB0X+MB3QXZM+loNTxK5i/gFGmN6n+eNVCsUR6fwfWvYThQhX1bMDlT7YFFN02NtaasYSjhL8FdAO/NHLIwodHLlx/zW6vhlVNpMugg92NnFrpLKPrEH9ATs0WqxKNKzFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU9ePL5OUPWFHiV66sfrnX5tg5wV/iOVfuH9LncIPFQ=;
 b=QVr9DMLd7whC+3hyo9EcRlT93lVBNU2rpFr2ZbqAmPI9OJR9Xqv8MpFL82zk9AtaYedOssbiNpdFFaaOykqSM6wanjkTTLiFhLrLQFrmCtxzicR3SnFz7C8FB0csRfmgfEhycg1atXFr7GvLD+C+afKh9ZiuFerYO5Nc4RBiCYmRw0nZ/Rum3EgnG/lWLLqUAXyCR5lZBiEyxecvyBtdWvByPRD3+HACR28CoPlPwci9bpq0K0oHUxu7bY69uUnSKjS5/K9KEWH7cvYS/tCXYmsqhrKmAYmZpktLYxXzpuPfVRwmtbgi3keyDIJ2/mefFB2j51qSyaHF17wtdReRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lwn.net smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU9ePL5OUPWFHiV66sfrnX5tg5wV/iOVfuH9LncIPFQ=;
 b=kVVWkzXbU/JQhuvQB53kRDYCexRUra7rCE7+rgW2rAC5cTgK0QW24+7gdSeQtk0SBEF3GOJvVV8JQp7W/YbEgHVjbVmg0JqpdgolSEdda5v4L7FA4L+KsYvwpVDhlBxGH3OziD7Fd2isY9azv7YRBhGPqzsnR1XPQyHS8HHKMJI=
Received: from DS7PR06CA0002.namprd06.prod.outlook.com (2603:10b6:8:2a::16) by
 DS0PR10MB7398.namprd10.prod.outlook.com (2603:10b6:8:135::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.17; Mon, 24 Nov 2025 18:36:52 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::1b) by DS7PR06CA0002.outlook.office365.com
 (2603:10b6:8:2a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 18:36:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 18:36:51 +0000
Received: from flwvowa02.ent.ti.com (10.64.41.53) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.20; Mon, 24 Nov
 2025 12:36:50 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvowa02.ent.ti.com
 (10.64.41.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.55; Mon, 24 Nov
 2025 12:36:50 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 12:36:50 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AOIanca2404242;
	Mon, 24 Nov 2025 12:36:50 -0600
Date: Tue, 25 Nov 2025 00:06:48 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, Pavel Machek
	<pavel@kernel.org>, Len Brown <len.brown@intel.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Maulik Shah <quic_mkshah@quicinc.com>, "Prasad
 Sodagudi" <psodagud@quicinc.com>, Deepti Jaggi <quic_djaggi@quicinc.com>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 6/6] Documentation: power/cpuidle: Document the CPU
 system wakeup latency QoS
Message-ID: <20251124183648.ud4emydldv75xr33@lcpd911>
References: <20251121100315.316300-1-ulf.hansson@linaro.org>
 <20251121100315.316300-7-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251121100315.316300-7-ulf.hansson@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|DS0PR10MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7c8d3c-fff4-468b-cb40-08de2b886f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BawtZx4+g6oCpJeX9zkUl6tbKokz3LrrKwuJwPoC+rdTq51BG6PMrgrvHzqP?=
 =?us-ascii?Q?DqSRj5BGSAHVHVnxhmbs3ZtrSX5Mzl9PS317UccWH2bAOGAj3tBWD1sQXNQ5?=
 =?us-ascii?Q?3C5lQobs7nbk+6zn/v3EyfYG7vSXiMyjf2zdqaquuGL2u1NE5M0BFUmuPjBe?=
 =?us-ascii?Q?VvuNUizoUa2cEScmcoz+3qHFzOL9Faxz4n25ppcdTllAOXU4tRRaRgxjWNE9?=
 =?us-ascii?Q?9MyLpwg7zgANc+1bYu1qvKyR8S1cdZFdYzxsdS1ymRUfgO7FxYf5261ztlWC?=
 =?us-ascii?Q?qS24tw6S6nYwBbB6dShmM9MWcu1mD9MdlKERa62BxTSvkLewW6bcEEzud8pS?=
 =?us-ascii?Q?Ky8VWuZLhk9z43qcuEVPrYFij/EqFOR0zhNngb9YR8h12dxHYeq/ueYHi5VQ?=
 =?us-ascii?Q?w540hA79zE8Fka/giUMF9RpF+1biPvnkXU4vnQ7IwYdkloKrKMfRVVTR+WQF?=
 =?us-ascii?Q?R/XPanaIf458zVmH44a/8QKs8/3wIl6oo0LsC9nT8pjBf+QDTCG7cvMICWqT?=
 =?us-ascii?Q?yrtgTWSaes1pQXOR48sFrs7ViDQP1PwgYDiMJe8vzEjsbPssiZjzic5U9HmP?=
 =?us-ascii?Q?rBFm/5VYdMBf8kJ51WEkSB1EoTi0cZX2DW8XfVWLZuK8uJQniDv4Fgjzp529?=
 =?us-ascii?Q?t7yGQYBtbWdQXZBCc9HOJK8eJRrSBvasa3TljG7Fwgzfqx7Uc1+a+n1P8uLM?=
 =?us-ascii?Q?qeexEkS6RKFCii4eOWcswRtPV8kR3dLFpYisCUoAIxRJQDAIfpD4SQE9KkCU?=
 =?us-ascii?Q?VBLqq0HSgyCJuThZT309evhKIpcAc0fRl9puCGHdrZCJ6qn2fYFl09Ms3LDa?=
 =?us-ascii?Q?sN65MEsf3Z2lAWgY0YeRbNPhgzICbE2hKdeobqwy2z2sAFV2AZHvliQLv9Bb?=
 =?us-ascii?Q?EzbrnQCb7ZQWsm7rRxurAkZZj/Y3Lxz+xTh41tw8z19yNaVxahUiYv6Zv1Sk?=
 =?us-ascii?Q?TbKZ01kPvz5b0LNlHbnGmQFNXb+uwCPRJYbIF/slkcGOQ4YK8fNNN/dLMy5z?=
 =?us-ascii?Q?MplABO7NFIqandpLnztOnl1InVfT+1PTy7o9aunpIi9ZxO+QmqbWG3ilmNuw?=
 =?us-ascii?Q?UxY7RW+4FYn93tI6Q65JthgH1LsJ+Hu3VR0bsdy4yWj8PxFtm3UHdowXaunl?=
 =?us-ascii?Q?uMh3bLxZtmdrXA7SfCoY4ArkY7niLQsMALOfms3A31TGb0cfuyFoWknA60Jp?=
 =?us-ascii?Q?JyBelZ2TJxcsZYOwvSAlf2TPWHVWWYDIBr7qvEQNwfnLJfPEg7lbnvI8zkiO?=
 =?us-ascii?Q?U7xrUIcanbmmot4sUONcwvg/JbSTaZf/4kiEBBXgp5iO4Rb+aomh5FmeTYGk?=
 =?us-ascii?Q?z5IRz+dBCSce1+lv/jA7e6gHg4IoiYTul17FeAIj3FXmHPzS4gAI2MpOg4wo?=
 =?us-ascii?Q?YfQgDMqqvDQ6dJsQCx1lyvSb1Tkts1C4xv6YdlE7YFUWtVo0B9QYoAUeRFyU?=
 =?us-ascii?Q?7amIRiw/myQyhVJpY2hbJk5Jl1sR+DEhejPQHkCcZ9XfQxuLmQSTDQqVV8s0?=
 =?us-ascii?Q?neimTGa1i6qvlMZq96BfNZYlcKxNoCHrLgZuteexVSyNt5lRUavuZwaJlzhk?=
 =?us-ascii?Q?sQIvwps59wM3UyedRDg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 18:36:51.1909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7c8d3c-fff4-468b-cb40-08de2b886f1b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7398

On Nov 21, 2025 at 11:03:12 +0100, Ulf Hansson wrote:
> Let's document how the new CPU system wakeup latency QoS limit can be used
> from user space, along with how the constraint is taken into account for
> s2idle and cpuidle.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v3:
> 	- Improved documentation.
> 	- Updated commit message.
> 
> Changes in v2:
> 	- New patch.
> 
> ---
>  Documentation/admin-guide/pm/cpuidle.rst | 9 +++++++++
>  Documentation/power/pm_qos_interface.rst | 9 +++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
> index 0c090b076224..c39ad6ab99d9 100644
> --- a/Documentation/admin-guide/pm/cpuidle.rst
> +++ b/Documentation/admin-guide/pm/cpuidle.rst
> @@ -580,6 +580,15 @@ the given CPU as the upper limit for the exit latency of the idle states that
>  they are allowed to select for that CPU.  They should never select any idle
>  states with exit latency beyond that limit.
>  
> +While the above CPU QoS constraints applies to CPU idle time management, user

Nit: s/applies/apply

> +space may also request a CPU system wakeup latency QoS limit, via the
> +`cpu_wakeup_latency` file.  This QoS constraint is respected when selecting a
> +suitable idle state for the CPUs, while entering the system-wide suspend-to-idle
> +sleep state, but also to the regular CPU idle time management.
> +
> +Note that, the management of the `cpu_wakeup_latency` file works according to
> +the 'cpu_dma_latency' file from user space point of view.  Moreover, the unit
> +is also microseconds.
>  
>  Idle States Control Via Kernel Command Line
>  ===========================================
> diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
> index 5019c79c7710..4c008e2202f0 100644
> --- a/Documentation/power/pm_qos_interface.rst
> +++ b/Documentation/power/pm_qos_interface.rst
> @@ -55,7 +55,8 @@ int cpu_latency_qos_request_active(handle):
>  
>  From user space:
>  
> -The infrastructure exposes one device node, /dev/cpu_dma_latency, for the CPU
> +The infrastructure exposes two separate device nodes, /dev/cpu_dma_latency for
> +the CPU latency QoS and /dev/cpu_wakeup_latency for the CPU system wakeup
>  latency QoS.
>  
>  Only processes can register a PM QoS request.  To provide for automatic
> @@ -63,15 +64,15 @@ cleanup of a process, the interface requires the process to register its
>  parameter requests as follows.
>  
>  To register the default PM QoS target for the CPU latency QoS, the process must
> -open /dev/cpu_dma_latency.
> +open /dev/cpu_dma_latency.  To register a CPU system wakeup QoS limit, the
> +process must open /dev/cpu_wakeup_latency.
>  
>  As long as the device node is held open that process has a registered
>  request on the parameter.
>  
>  To change the requested target value, the process needs to write an s32 value to
>  the open device node.  Alternatively, it can write a hex string for the value
> -using the 10 char long format e.g. "0x12345678".  This translates to a
> -cpu_latency_qos_update_request() call.
> +using the 10 char long format e.g. "0x12345678".

LGTM,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

