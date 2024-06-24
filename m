Return-Path: <linux-pm+bounces-9877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6799142E8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA738284B88
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262913C684;
	Mon, 24 Jun 2024 06:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sfzSSg0R"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88293BBC2;
	Mon, 24 Jun 2024 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719211159; cv=fail; b=vCIFElg5Bn8BNNFpVTSO1myopiaCjGR/NgxM1FdrsE3WOryRaxZXvTUcM5nv9qgI8rsEIt0HcZkV58VxYGZ/v5tLJZXbMcbq8JXdZQdv5EF+WiLhvzyXLOVIJP/HLFzG11NSLc86MV0B24GDKxRwbneqFNTjsLzlHwGQkw9nWpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719211159; c=relaxed/simple;
	bh=z79sT/BGkOzVjZNG6SYShpQp+1hOy+Rh4hau3hczsa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xc4cP6v4/PozgtJJxk8IO9Cy7Hc9PVziEzxJyyjZMYVFXLDX0SarFm7r2eG/ppPuuvRXHH7ippouVKGUtuPpeYiKiZAPwFLsTZassK2t568eIMBBnGj31jSKkEGOEmusRifTafYjnhczcRS7UIqa/L+ZwcKCIu+RB+78ebilopU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sfzSSg0R; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kz/YpudkTnexXX3GSNFRw10hrFLKbz/RsCByC/YbzjX7yb3f3xSw878VSkGLWUJaPSdHPtlRDAeGUyR5yaZGSZd9MAHVgSo9l5RUBN4SzOdFoAM4VkNWUKhwrohzKDPrCTxANsC3WGOQNAmasIbLYnO7Ri/BoMmBbxPO0KjTimDcfUzUDWQ/kCP+BIvTWup26wmMbi9S3BFmMXdkZpI3z0NR0+xvnXBdO+EyWLiiCze2k5ckOZjxCndYWJ3reUvY6gT9eYR/XSP6y2lKXac73m4W/lFb/UkVoQOsk0vPlThvdZ953HKJB9LgLIE0TQsAZuD2cvOJUj6H7E8dDiRGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJOPF+/q8MQ7xRB7Z6D6kDajcKnyujjYO3CWF0fQ6F8=;
 b=KHNJI/cxR9BybmICLCLjz81KT5WxQTgfEQE96rZuo2d6Vn1sVpZ+VSmj8cwy8fRnK5gyeBgkA99+ShBgzlKl3qMqhy7X62uGf5cu6pxtBYJoaz4hiTpTTsRnrGQxs01F7YWt/F4H9h4JfThxxALcxjjsLQtQTuzBmOi/rbcHCMKbbwVi0j9p2zWzUID6OI0r7lQmdSmINlp4ZsnpmUscwGibnPEtOaZurnF8epe3DYPZnqLshfxF70/VZUUWFL5+9QfsQoqHkJd2U0SyjTw6vZwuo0MAqy0D5QeCQiMpJulnt6i9PtLlYF1FVdYb5JK5xFJ2vmD4NluhBgkk/132HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJOPF+/q8MQ7xRB7Z6D6kDajcKnyujjYO3CWF0fQ6F8=;
 b=sfzSSg0ROkpQ/L6WUlhSkyXDq9dn2OUYRMzhrMPUvkSaKjKVvrWYaA/zJ3qlYfbifYc1RnFnyr0qAh6lwLbn6qmC3cXMVtuFHiUV6W0p5W/hWZKRHEqmRjXXANzYpCersINd9eM+dzIvCFRjVM1sNZLkkykrPAiUUl5dYpw67ic=
Received: from CH0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:610:74::6)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Mon, 24 Jun
 2024 06:39:13 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::46) by CH0PR04CA0061.outlook.office365.com
 (2603:10b6:610:74::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 06:39:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 06:39:13 +0000
Received: from [10.136.36.140] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 01:39:06 -0500
Message-ID: <0afc09f6-da93-dde5-45ad-d4784b9b4227@amd.com>
Date: Mon, 24 Jun 2024 12:09:03 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 00/10] Add per-core RAPL energy counter support for AMD
 CPUs
Content-Language: en-US
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
CC: <rui.zhang@intel.com>, <mingo@redhat.com>, <acme@kernel.org>,
	<irogers@google.com>, <mark.rutland@arm.com>, <jolsa@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <peterz@infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
	<linux-pm@vger.kernel.org>, <namhyung@kernel.org>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <kees@kernel.org>,
	<gustavoars@kernel.org>, <oleksandr@natalenko.name>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: e86476be-0b67-42e3-c445-08dc94185c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|7416011|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3Rqc0x6dmVJTU9jTG53cDJ1eTRpblVtcU5OeXhPK0s2QzhoaldmclFaN3Nm?=
 =?utf-8?B?QUxJMVN6M0FsWTZSUW9HUUExMkF6Vzdrc3l6dnozNmc4N1Ftek0yMTQrUjZt?=
 =?utf-8?B?TUhkbFJlbTlZdm9CUDVUa3FkU3VvS01OUjI4Z25PZnJWT1N3aTFKcm1Id0tF?=
 =?utf-8?B?dkloLzJkbnVGbzkwRjYyYmRUMTRzbENydzNuVVNvVm1tSm1yVGtFZEFYeUJm?=
 =?utf-8?B?dkx2eFJ3cFozQ1NWc2Q3dm1UemhQMzJPRnVUWmFYWUQwWitmKzlHdi9VUVQr?=
 =?utf-8?B?Y0NoTUFHUWxIdFdMbG9sVERuY09GNDVaVzdiQkx5VzJkbC9XVWFrd2NVem1G?=
 =?utf-8?B?Z0J3WG80Z3BycUhwK1kxaDZBRmM0cUhKZjE2ZmNYTFpHdUxMNnBtckIzalVL?=
 =?utf-8?B?QkliUkdsTkNxTkdYbU8yT3cyeEFrRDkrMHRLMXJBay95RWxmcXF5bTRpUmpF?=
 =?utf-8?B?dG8yZG5BVnVVY2R1ZTQ1dnlFczlxRldSanFrRTBOUi95YkpxRG9hNVJlaWpW?=
 =?utf-8?B?U1VDVHdhYlpJKy9wWGpra3VDQk01STdsdjlURTZCSVQ3NUVld28wN1UzeW9G?=
 =?utf-8?B?eWkrVG1jTUYxTDdyajlJbEdQa3BDRVRpN3hLeG5rTElsREQ4T2hjSkJSN2FF?=
 =?utf-8?B?OHZqT2J3UUNMTzdwdWEvOU14RjR6aGlBTTBDRVlxNUNHUTZYY05GQ2lsb0da?=
 =?utf-8?B?MEFxczE3ZmVMT0pDYTMyQ3ZPZzNodWMvTjJlV3B5UEExcUEzdDVpS1E0cHRL?=
 =?utf-8?B?dU41a3h3MnJLdlJXZzFaL2xLR1phTUxwcEFuOTBEeElXSkk0clB0STFUZXN1?=
 =?utf-8?B?RlM2S2RzN2RnaFVucGRva2JLV0RWU2h3cXRQWkxiVUFQYmpJYXZWVUxCL2RM?=
 =?utf-8?B?emR3MjUrTFpoMks0U1NramZDck10Vkh2SzRGay9QMlZHVU1DWnY4R2toZTZh?=
 =?utf-8?B?SE9vZkhlUU9SY200Y3NXcDhJL0tGNU9Ecm40aDZYbXVqL2MvMU1hcmxpbjdM?=
 =?utf-8?B?dFlWV1NGdnhINE1kdmErZWRQVy9xSVFxVEdVeFJzckVXUC9BSWlnSzVncGU3?=
 =?utf-8?B?bS8yc01LcUg0MEhOZmpUbEovb09jL0FVYmRHMVEyVXNxNFR1aUp2eTRDd3R5?=
 =?utf-8?B?a25COGVRRlgyZXIwdUZZRmx2VWtBRHJZOG9TZzdBMEpDS3FrUmFSTmdNOTE4?=
 =?utf-8?B?Z3Vlck1GT2t0cVc2aytJcG9qTzcxMHhtQU8rRExuNFVDWkp3aHBFZVcrMElU?=
 =?utf-8?B?MURvcXNyRVZoYmNub0dJSFhTbWVOY29LY3VIaXlQby9GdExJendrbFZ5RERx?=
 =?utf-8?B?MzZ0ZnFQbjFVbjYyejVsaFVZeEpGUGgzY2Z1eVdqbTZlLzdPQ0NuZXZuZjNs?=
 =?utf-8?B?NkxMM01ITURSdWp4UEIvazBHVWpHMmE3VlZJWFFoeUtsV0VtOXFRRGQyeFcv?=
 =?utf-8?B?akZnUWE5VEF1T3ZIcnFVMkZuaG5TbnVMOHF3Mm1oZkxVQlhGTDdmbXZDZmZR?=
 =?utf-8?B?U1JEV1l0Mi9rQmhDQlZPR2wrcmJUSXgyMjVFYXduc2lTZWE5TWV6UVUvdmFm?=
 =?utf-8?B?dENNVFRBdVhDckJGWm8vRXBGaEMyK2RoaGtZWG5Vd3l4MWVkdm9FNE5TR3lL?=
 =?utf-8?B?akFoYmc3a1VrSXdXVWdiVDQ3cHo5d0tyTnFPa0oxZVVZYi8ya3l6bDhCN2RW?=
 =?utf-8?B?LzZkYTl6SUs1NDNyVTFVNTdHM25tNHVMVHdtUWQ2WWYyQlpiR2lFU0J3N3Uv?=
 =?utf-8?B?eElVZzJNbWlrbmUvdDFYdG5kZnVrNklqZ0txMkVZNmRGQ1hPN3dIWlRpd3BN?=
 =?utf-8?Q?dn1BrUpCNQoRH63LLro3rJKqlyMJ8T3gCmDI0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(7416011)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:39:13.1700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e86476be-0b67-42e3-c445-08dc94185c91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704

Hello Dhananjay,

On 6/24/2024 11:28 AM, Dhananjay Ugwekar wrote:
> Currently the energy-cores event in the power PMU aggregates energy
> consumption data at a package level. On the other hand the core energy
> RAPL counter in AMD CPUs has a core scope (which means the energy
> consumption is recorded separately for each core). Earlier efforts to add
> the core event in the power PMU had failed [1], due to the difference in
> the scope of these two events. Hence, there is a need for a new core scope
> PMU.
> 
> This patchset adds a new "power_per_core" PMU alongside the existing
> "power" PMU, which will be responsible for collecting the new
> "energy-per-core" event.
> 
> Tested the package level and core level PMU counters with workloads
> pinned to different CPUs.
> 
> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa
> machine:
> 
> $ perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 1
> 
>   Performance counter stats for 'system wide':
> 
> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/

Tested a bunch of scenarios on my 2P 3rd Generation EPYC server and this
time around I'm seeing the expected behavior. I'll leave some of
scenarios I've tested below:

   $ for i in `seq 0 63`; do taskset -c $i loop & done
   $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 5

   S0-D0-C0              1              10.82 Joules power_per_core/energy-per-core/
   S0-D0-C1              1              10.87 Joules power_per_core/energy-per-core/
   S0-D0-C2              1              10.86 Joules power_per_core/energy-per-core/
   S0-D0-C3              1              10.89 Joules power_per_core/energy-per-core/
   S0-D0-C4              1              10.91 Joules power_per_core/energy-per-core/
   ...
   S0-D0-C63             1              11.03 Joules power_per_core/energy-per-core/
   S1-D1-C0              1               0.19 Joules power_per_core/energy-per-core/
   S1-D1-C1              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C2              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C3              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C4              1               0.00 Joules power_per_core/energy-per-core/
   ...
   S1-D1-C63             1               0.00 Joules power_per_core/energy-per-core/

   $ for i in `seq 64 127`; do taskset -c $i loop & done
   $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 5

   S0-D0-C0              1               0.17 Joules power_per_core/energy-per-core/
   S0-D0-C1              1               0.00 Joules power_per_core/energy-per-core/
   S0-D0-C2              1               0.00 Joules power_per_core/energy-per-core/
   S0-D0-C3              1               0.00 Joules power_per_core/energy-per-core/
   S0-D0-C4              1               0.00 Joules power_per_core/energy-per-core/
   ...
   S0-D0-C63             1               0.01 Joules power_per_core/energy-per-core/
   S1-D1-C0              1              10.51 Joules power_per_core/energy-per-core/
   S1-D1-C1              1              10.50 Joules power_per_core/energy-per-core/
   S1-D1-C2              1              10.52 Joules power_per_core/energy-per-core/
   S1-D1-C3              1              10.51 Joules power_per_core/energy-per-core/
   S1-D1-C4              1              10.51 Joules power_per_core/energy-per-core/
   ...
   S1-D1-C63             1              10.59 Joules power_per_core/energy-per-core/

   $ for i in `seq 0 15`; do taskset -c $i loop & done
   $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 5

   S0-D0-C0              1              11.16 Joules power_per_core/energy-per-core/
   S0-D0-C1              1              11.21 Joules power_per_core/energy-per-core/
   S0-D0-C2              1              11.20 Joules power_per_core/energy-per-core/
   S0-D0-C3              1              11.24 Joules power_per_core/energy-per-core/
   S0-D0-C4              1              11.25 Joules power_per_core/energy-per-core/
   S0-D0-C5              1              11.26 Joules power_per_core/energy-per-core/
   S0-D0-C6              1              11.25 Joules power_per_core/energy-per-core/
   S0-D0-C7              1              11.25 Joules power_per_core/energy-per-core/
   S0-D0-C8              1              11.42 Joules power_per_core/energy-per-core/
   S0-D0-C9              1              11.43 Joules power_per_core/energy-per-core/
   S0-D0-C10             1              11.47 Joules power_per_core/energy-per-core/
   S0-D0-C11             1              11.43 Joules power_per_core/energy-per-core/
   S0-D0-C12             1              11.44 Joules power_per_core/energy-per-core/
   S0-D0-C13             1              11.41 Joules power_per_core/energy-per-core/
   S0-D0-C14             1              11.40 Joules power_per_core/energy-per-core/
   S0-D0-C15             1              11.41 Joules power_per_core/energy-per-core/
   S0-D0-C16             1               0.33 Joules power_per_core/energy-per-core/
   ...
   S0-D0-C63             1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C0              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C1              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C2              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C3              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C4              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C5              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C6              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C7              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C8              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C9              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C10             1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C11             1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C12             1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C13             1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C14             1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C15             1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C16             1               0.00 Joules power_per_core/energy-per-core/
   ...
   S1-D1-C63             1               0.01 Joules power_per_core/energy-per-core/

   $ for i in `seq 0 7` `seq 128 131` `seq 64 71` `seq 192 199`; do taskset -c $i loop & done
   $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 5

   S0-D0-C0              1              18.68 Joules power_per_core/energy-per-core/
   S0-D0-C1              1              18.20 Joules power_per_core/energy-per-core/
   S0-D0-C2              1              18.27 Joules power_per_core/energy-per-core/
   S0-D0-C3              1              18.41 Joules power_per_core/energy-per-core/
   S0-D0-C4              1              16.94 Joules power_per_core/energy-per-core/
   S0-D0-C5              1              16.95 Joules power_per_core/energy-per-core/
   S0-D0-C6              1              16.92 Joules power_per_core/energy-per-core/
   S0-D0-C7              1              16.94 Joules power_per_core/energy-per-core/
   S0-D0-C8              1               0.39 Joules power_per_core/energy-per-core/
   ...
   S0-D0-C63             1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C0              1              18.59 Joules power_per_core/energy-per-core/
   S1-D1-C1              1              18.39 Joules power_per_core/energy-per-core/
   S1-D1-C2              1              17.50 Joules power_per_core/energy-per-core/
   S1-D1-C3              1              18.29 Joules power_per_core/energy-per-core/
   S1-D1-C4              1              18.58 Joules power_per_core/energy-per-core/
   S1-D1-C5              1              17.62 Joules power_per_core/energy-per-core/
   S1-D1-C6              1              17.75 Joules power_per_core/energy-per-core/
   S1-D1-C7              1              17.53 Joules power_per_core/energy-per-core/
   S1-D1-C8              1               0.00 Joules power_per_core/energy-per-core/
   ...
   S1-D1-C63             1               0.00 Joules power_per_core/energy-per-core/

Unlike last time, each socket is reporting accurate values for all the
scenarios I've tried above.

> 
> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/
> 
> This patchset applies cleanly on top of v6.10-rc4 as well as latest
> tip/master.

P.S. I tested this on top of v6.10-rc4 this time around.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> 
> v3 changes:
> * Patch 1 added to introduce the logical_core_id which is unique across
>    the system (Prateek)
> * Use the unique topology_logical_core_id() instead of
>    topology_core_id() (which is only unique within a package on tested
>    AMD and Intel systems) in Patch 10
> 
> [..snip..]
> 

-- 
Thanks and Regards,
Prateek

