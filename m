Return-Path: <linux-pm+bounces-37175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F9C24A60
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 11:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FF41897E7D
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 10:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE54342CBA;
	Fri, 31 Oct 2025 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wDDJTonU"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9482C342CA1;
	Fri, 31 Oct 2025 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908257; cv=fail; b=LhBZwlQr5xTB4kqydC5/KidnrRr938xeaV0tcz/ZraQqGlMrN+NVNFx0Ik//WglBcNgGZHUQFIgzxV1apXlcRBFzE6k2I7O10TfQ4zpstrc8ac2BfPQH7U2/uF4q0iP2ozH6Ph6koo48PXHhuOE1G1eBOB1M9825YAVl2IZCKi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908257; c=relaxed/simple;
	bh=qMmMLcMRHvMyt7y/yxDWAOGzySzLp7xsip8U9yuq7UU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYkIiqXsyBAcLisl7merwSioH6Ukghr3W0mefHxsLr6X5kJOrt1Mi37ki5lT8wGcw7B3rmHQGy63Ph6wzOu1GxgCnQPFRv/AQn2kwlQ/x7L3uWQJRQoCAwgOKHJ0R87tqWH2wFaDutoZYu5oapC4yOPt/1uktKa7Xx3r47g5xgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wDDJTonU; arc=fail smtp.client-ip=40.107.208.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSXhZ3EtP5onSFKc5fIJRKq1/EYy+0r+Kzic+Vgts3yOSIBee8gq8unaPL7LOXPCI4E0SbVPGF4Oi4/wW3OsaIMuXtFoccUT7BYBJdkoDiisVZszO+Ah7g1Oolr2Tzk6pmm3mkMKfRZt8ZnSTg1DCj0OJLmmdqkxAIMhaPCle2Rd9qPCkfTKPmYyZL+UiAUOWMzZwiomDJafHSHif8C+mXBiK1Aqa7r/2FmBrD3EwGoRlMkd6nWR6+DDperrZbPs5ig+hZM5WadbONlWNkCpSLD42nWBHAPAp2HBDXcwMePvJV6furSIfX6sE7jBpHs94VG/qelnIaoU/r7GFpiTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zFkSYqCTYzkKJkR6H8CX2D7qgvTt0kEZyLrM8gr6Cs=;
 b=PZWXXw9elVLgZCjB4HczD9cjsTYK2owXkK13uZ/Lkt+JDqfD0f1Q1EFYFuGUmKItAAP96Yt208fZANBAtwnXCh5Lf1YsJKCbCjWOsSP0WzMWN78FmvA87x/hSOrmMbZGxNDSdyHwKswN2xHAWA8/1SWKLO3gkF61dYtqux1Ts4tjs2/xlgQYvWqQFF7YiN+B4e6RQWUn0ISAwO3n2DXB3JNS4kMftcV9XqFC1XZcWd6ObHgrjCo7vsXtU1R+DNu3S5p/cKFJssXsdUcgXSv1u0sOvFyu6N1P6h9H/mPSwAVP4RKyHHnHpnmsJAthyfnahuAvwyvCY4uoGEE8TEVeOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lwn.net smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zFkSYqCTYzkKJkR6H8CX2D7qgvTt0kEZyLrM8gr6Cs=;
 b=wDDJTonUmjoeEJ0G4Wg0TbLDBPaExt9PxH95UdsuwWxCClCIbGMfNgPuK0b1OycA/7eyIh9I5miAN2icev4OPbaagcye/bVAF3bcn0yqJiqcXPwXRVpoE78XUXgPh960xixxZGZVUyegAY+KmBuu3X/pFxPzJDC1tCsymnZ9jjk=
Received: from PH7P220CA0178.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::17)
 by PH0PR10MB5681.namprd10.prod.outlook.com (2603:10b6:510:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Fri, 31 Oct
 2025 10:57:32 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::92) by PH7P220CA0178.outlook.office365.com
 (2603:10b6:510:33b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:57:31 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 05:57:25 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 05:57:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 05:57:25 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59VAvOnD3756675;
	Fri, 31 Oct 2025 05:57:24 -0500
Date: Fri, 31 Oct 2025 16:27:23 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, Pavel Machek
	<pavel@kernel.org>, Len Brown <len.brown@intel.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, "Maulik
 Shah" <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 4/4] Documentation: power/cpuidle: Document the CPU
 system-wakeup latency QoS
Message-ID: <20251031105723.iwhrpoluzwlikpwf@lcpd911>
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-5-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251016151929.75863-5-ulf.hansson@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|PH0PR10MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 4620c709-7844-49db-36ce-08de186c4a33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|34020700016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rSlW0+gHdTmAZQqf/bsCsCVfSyS4Y3ty2DBsO827CoBubvcSRuDTKyyJWKUP?=
 =?us-ascii?Q?FehV7lPOY/Uy9iUPk8IZZS0g1Wy82d3i3Fp9bTmdXCYI4KD7Op2CMmGCDvfq?=
 =?us-ascii?Q?3Ol4xBODawKliO1vzy/3RRcPimNUOtIe6tkJ4VBUtjtApz2GESYbvt5dqePj?=
 =?us-ascii?Q?ha+g4FgNdjtBUTTGwNkuflmG8pNIeggQxc0uybsnHK8LiH10MoNkFuEhU0ht?=
 =?us-ascii?Q?6RawMkBpc2BjSc2o2eDXo5VNQLg18Gq+EyqEvL/pa7TW3Uxd2URTbM5RLHVT?=
 =?us-ascii?Q?DlXxRHBZLSsZoGMuG900H2Rypdl+DOSFAy5eVPErRHowtzAxnA1wNcSJqFT0?=
 =?us-ascii?Q?npMRaB37/wwgiEwayfnDkgGcNp6EKSxA5NgZ78HnCM+T7G7DZqahgy35Punn?=
 =?us-ascii?Q?BCr9o20Epd3rpTcdBIjrD+14MpkR913vvNwxkMw9mzOBeI3osXjLO/o52f4/?=
 =?us-ascii?Q?8O2RPfUacXEWzqqWW3qFktaHwholOwEDRYCSgx+4mT8VzhFv1IlaBKbo1Pd5?=
 =?us-ascii?Q?lAvliWyWnh2qX5khidTvB1kdxeFuDdC0nNNPMRiRU+kd28ZOM+/OiVW180dL?=
 =?us-ascii?Q?63fQ5Izsd5Ee/bMxL4BsNpMXNpWt8v5vgzrjubxcjVRDDF/ZGBrJ8J0iMghV?=
 =?us-ascii?Q?GAoY9I53YolNUibSRJsM76SM74luY8nLNMnmEecl48RP/qHPxKiT1ZH+WAP1?=
 =?us-ascii?Q?d6rxtSTXZUuTM2VVL8Fk4OvnJxpVjzpTAbeZiM4wjsWLupkpDLfQXs8oDf3E?=
 =?us-ascii?Q?Y/k2gfze7IVAzEg3cmKQUm/U0nYgXaPPdU+q9tWBzSoyZTILI31BDEv2Q241?=
 =?us-ascii?Q?inSjXYzUfc1INCV8KBLqPkeuosQrjzBgozwzddo9lNGrANv2YKC6wNAinTTE?=
 =?us-ascii?Q?dmn9tsMn93JiNtvicSsTz6LLEfntBkplo67arReP6jdhzqZjVUuiu1Wt2n3c?=
 =?us-ascii?Q?zVUKYEmrWF0ULF7q5QIvdsEgVc60+GbGIwbq4gr4jV3KDfwPQxMA+Ys8GFj1?=
 =?us-ascii?Q?prKYKP+rtqkSv2Vo5TmCkA1II2l/ypYDgiazcdtzmyPjeSjpvb6RA+/tWw7h?=
 =?us-ascii?Q?YSfN7kh91u9X6kdF1dS1EQXHtDOAt93sl29249yQ2JbOr9EMK8bncSBMyjeB?=
 =?us-ascii?Q?wWK13zMdSst6Da75dGFb8qPwJ44kJok7bXcW2Dvz5NMCFQ5KT76dGWbHxwy2?=
 =?us-ascii?Q?x+0Sk7mTzpePXZpHMn4tugE2DJ6NbTjpVF2bSpSpeiH5j/lM+09/ftAklxmn?=
 =?us-ascii?Q?BiMUYNYxOCx+Lfa5VIdODGr6SiJD415gOX3ho+h9pvNujmYML4az2D32+nzx?=
 =?us-ascii?Q?zICcWbsntQfTvUKZZwO94BNQ7r9+QPihPCIGiK2XUmTED0jgOh64ZAUmjFus?=
 =?us-ascii?Q?z3FxK3PkGXvqhuwzgzSJn0oUKfYr7nlonMQOYBavVRBtAsjKyIoz8C6Hab3P?=
 =?us-ascii?Q?Zn+Xc+tiprlUSZn7AV2/xa8AX4jhXZBaWx1LiAawac9wEvUsgdBOwlXndgca?=
 =?us-ascii?Q?SlO1pWAn3kPnkr4j/3PS9OLqi0y4W3ypPiAc2X4dtP7atyn2fr5sukHw3YBv?=
 =?us-ascii?Q?OCwI9ayjTDV1lRz26dg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(34020700016)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:57:31.3051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4620c709-7844-49db-36ce-08de186c4a33
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5681

Hi Ulf,

On Oct 16, 2025 at 17:19:24 +0200, Ulf Hansson wrote:
> Let's document how the new CPU system-wakeup latency QoS can be used from
> user space, along with how the corresponding latency constraint gets
> respected during s2idle.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- New patch.

Similar to how I did for v1 RFC,
I have applied this series on a ti-linux-6.12 branch[1] and have been testing on
the TI K3 AM62L device, my 2 cents:

> 
> ---
>  Documentation/admin-guide/pm/cpuidle.rst | 7 +++++++
>  Documentation/power/pm_qos_interface.rst | 9 +++++----
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
> index 0c090b076224..3f6f79a9bc8f 100644
> --- a/Documentation/admin-guide/pm/cpuidle.rst
> +++ b/Documentation/admin-guide/pm/cpuidle.rst
> @@ -580,6 +580,13 @@ the given CPU as the upper limit for the exit latency of the idle states that
>  they are allowed to select for that CPU.  They should never select any idle
>  states with exit latency beyond that limit.
>  
> +While the above CPU QoS constraints applies to a running system, user space may
> +also request a CPU system-wakeup latency QoS limit, via the `cpu_wakeup_latency`
> +file.  This QoS constraint is respected when selecting a suitable idle state
> +for the CPUs, while entering the system-wide suspend-to-idle sleep state.
> +
> +Note that, in regards how to manage the QoS request from user space for the
> +`cpu_wakeup_latency` file, it works according to the `cpu_dma_latency` file.
>  
>  Idle States Control Via Kernel Command Line
>  ===========================================
> diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
> index 5019c79c7710..723f4714691a 100644
> --- a/Documentation/power/pm_qos_interface.rst
> +++ b/Documentation/power/pm_qos_interface.rst
> @@ -55,7 +55,8 @@ int cpu_latency_qos_request_active(handle):
>  
>  From user space:
>  
> -The infrastructure exposes one device node, /dev/cpu_dma_latency, for the CPU
> +The infrastructure exposes two separate device nodes, /dev/cpu_dma_latency for
> +the CPU latency QoS and /dev/cpu_wakeup_latency for the CPU system-wakeup

If others are interested to test this out, I have a quick and dirty C
program here that you can compile on the target to test setting
constraints [2]

>  latency QoS.
>  
>  Only processes can register a PM QoS request.  To provide for automatic
> @@ -63,15 +64,15 @@ cleanup of a process, the interface requires the process to register its
>  parameter requests as follows.
>  
>  To register the default PM QoS target for the CPU latency QoS, the process must
> -open /dev/cpu_dma_latency.
> +open /dev/cpu_dma_latency. To register a CPU system-wakeup QoS limit, the
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

Here, can we please also mention the units ns or msec? I see that you
might have changed from usec to nsec from v1->v2, which may not be obvious to
everyone at first glance.

Also, In my local setup I have a single CPU system with the following
low power-states:

8<----------------------------------------------------------------------------
	idle-states {
		entry-method = "psci";

		CLST_STBY: STBY {
			compatible = "arm,idle-state";
			idle-state-name = "Standby";
			arm,psci-suspend-param = <0x00000001>;
			entry-latency-us = <300>;
			exit-latency-us = <600>;
			min-residency-us = <1000>;
		};
	};
[...]
	domain-idle-states {
		main_sleep_0: main-deep-sleep {
			compatible = "domain-idle-state";
			arm,psci-suspend-param = <0x13333>;
			entry-latency-us = <1000>;
			exit-latency-us = <1000>;
			min-residency-us = <500000>;
			local-timer-stop;
		};

		main_sleep_1: main-sleep-rtcddr {
			compatible = "domain-idle-state";
			arm,psci-suspend-param = <0x12333>;
			local-timer-stop;
			entry-latency-us = <300000>;
			exit-latency-us = <600000>;
			min-residency-us = <1000000>;
		};
	};


---------------------------------------------------------------------->8

Now, when I set the latency constraint 0x7a110 into cpu_wakeup_latency,
I expect it _not_ to pick main_sleep_0 because it has min-residency of
0x7A120 (500000 us) and since 0x7a110 < 0x7a120 I expect the governor
should pick the least latency state of the cpu which is the CLST_STBY or
maybe just kernel WFI (which is the default lowest possible idle state?).

I decided to go even lower with just setting 0x1000 (4096), but even
then s2idle picked main_sleep_0!

Only after I set something very very low like 0x1 or 0x10 did it pick
the shallower state than main_sleep_0...

I haven't dug deeper into where things might be getting miscalculated
yet but just thought to share my experiments with you before you respin
the next rev. Curious to know if I may be just confusing the units or am
missing something obvious here?

Few of the other things that I tried that _did_ work was, setting
constraint to 0x1312D00 (20000000) which is obviously much higher than
the highest min-residency , and then I can see s2idle pick the deepest
state ie. main_sleep_1. So that worked as expected.

In conclusion, I am happy that this still works in a way that I am able to
switch between low power states, but just not in the most explainable
way :(

[1] https://github.com/DhruvaG2000/dbg-linux/tree/tiL6.12-am62l-s2idle-prep-v2
[2] https://gist.github.com/DhruvaG2000/a902b815b5db296bb7096ad7cb093929

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

