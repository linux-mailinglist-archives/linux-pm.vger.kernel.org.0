Return-Path: <linux-pm+bounces-9743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13EF911E9B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 10:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A60D1F213BC
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 08:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ACC16D317;
	Fri, 21 Jun 2024 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="srH4FgSX"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9C127B5A;
	Fri, 21 Jun 2024 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958279; cv=fail; b=ckiWpAWIFJQze/SGzJ8ibWArzj11yXqx02ca6pa9fCJXpRIgcVb2Q3yiXe/AqE+2Bo5NQglPNRXF3rA8jskoZ5qTNBc7yb0sQgwWCC7RyL2FI5l6F7j87KxdzzFx/bZMWN+zvLDD8MI2k+chXoV9gQdmjGZiyUk7d0SwlWBvKyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958279; c=relaxed/simple;
	bh=frrQUpi9pWxnTQ1j5fnEsIcVkqYVZ+nUvpBGqHSNJAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GYk3wDfGK8QApsI251wAsXaJnyTh9JIH6ueByxrnb1pDm450hqBmBQXWeqXLhsCzWK22nUJ15uL4uBB0XVHMXplnLXe8jKuFdhMbc4bsbe8dJXEVlpwYHkml+Zw0yZSEtbXlR5HhrZbVEb2kGYVfBxfx7PTRc3rwQVtRAstfP4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=srH4FgSX; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPkQEM+4som/FByBfhd7ZwNmWEhHxZ/ksBaOryGNUAhHslnodA7KrfK+v2DODb1+bwxlrDSugC6132nV50VvclK4YzqgLoNTjg9aPHu4+2knUoOInZYpQTNQ+20RmfpMRSujm/cEivd2ZyPVTBZmRn9Fmxg7ij2t636eCA38Z3x7N1sPZUofpvaCoepzIiuTyIO6lvypwSE9Jq8u3GN9vLITq7KOq2J9V4ixNQ94RImxg9PEDsLUOvwn/QLOw09WquJJBtATLGU3pzS1e3ikdCNSjDU6f0tGmad45yzwDKzlmeX8uOqkAtOlUqSOPw+dtf2ZdxTUCnrQoku5fFcQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGr7UX0Te0wMya+7F1XKgIKopnVFsLhKqvZldSDQtyA=;
 b=QTVCkIb1Axw5g6LIwmO0WgPgz2kklR318gUvNcrXR25CPGklg3O2L/OZhWU3cb0P/+L0bu/pjtjcYfQ6Uf+PLRidxD0rqCZeJnHRESM1AjCmQ9vhOPy0GQIzDWoqndO3l/IDDTYTEYsOn0B5JHjS4ipEWNrBlI88VxUd9eFQJQKZg46+62U4GurBsJzIZDLsicCce2w0gyLUl9biitpBZCOn9YC4c1y3Vm21CTMGeA7PhsNcZZwj0CuY56v9nnRTQmcyW7M1cqfxreIZEJT5W12EQzCkTj8dILwXoylI5gqZpFmTzLLDENINxix7W9DHdOQivQ3AvoF2Uby8zQWHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGr7UX0Te0wMya+7F1XKgIKopnVFsLhKqvZldSDQtyA=;
 b=srH4FgSX6QcdLuNm1dGWg7syJ1cBCUZygTnLVsU0Mu8krDYjYA7c4jfZsCeVS36wIgAOnC+8TD8GMDl9pI6b8Nz0+0VIWtrtPNUQoEWM3i2u0U3jjpEDuc0DjCbVf3eZnSCeC3EovPh2VB6NU1i3Z+0GfHKkmBiciwBOjcHam1U=
Received: from BY5PR17CA0007.namprd17.prod.outlook.com (2603:10b6:a03:1b8::20)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 08:24:32 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::65) by BY5PR17CA0007.outlook.office365.com
 (2603:10b6:a03:1b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 08:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 08:24:32 +0000
Received: from [10.136.33.236] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 03:24:24 -0500
Message-ID: <a26b9774-f9da-763e-aebf-5d66a6d44377@amd.com>
Date: Fri, 21 Jun 2024 13:54:22 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 0/9] Add per-core RAPL energy counter support for AMD
 CPUs
Content-Language: en-US
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
	<linux-pm@vger.kernel.org>, <rui.zhang@intel.com>,
	<oleksandr@natalenko.name>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <kees@kernel.org>, <gustavoars@kernel.org>
References: <20240620125703.3297-1-Dhananjay.Ugwekar@amd.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240620125703.3297-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 961cea88-776d-48a3-3b43-08dc91cb93ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OENJTDh3T0lua0Urc05sSFJiVXFrNHlnVUtlMldwVkJHSGFZa0p6YXhyRkpo?=
 =?utf-8?B?S1ZabStscmZyRTNsejg0WkdNTW11bVRXb0NCSER1YVhISHlXaWJJdGJ5Y0xS?=
 =?utf-8?B?M1JHUGVUcVhTOG93bVIrczdtVGdXamJXUWN3dmVOcitWRW1rRk5ZRDM3cGFY?=
 =?utf-8?B?QXdiL3RsMGdPS1p0TW1OeW0yeFVxUlM4QWppcnEram4zendKbmxoZDZ3azla?=
 =?utf-8?B?Y0ZMcG1qMXJ5bDljZ2h3VDVIUEtjOWFOQ3E3c1ZKdnY4NWpBS3FGbzR5Kyt1?=
 =?utf-8?B?dnFzd1VReUJ3dTF5bDlIZ0ZZUDZqQzZVZlJla25Nd0p3eG1IOVhHKzFkTVhk?=
 =?utf-8?B?Tm5lMjZpbXF3bzk4bFdXQzgvS3EwMkwwazlRMFV3SE5iNUJ4cG1VZ0phanBn?=
 =?utf-8?B?dEo3N1VTNVlNVmVqNlh3L01qTWU3N3NjM2YyM1I1anJGNkQ3c2xLdkRib0o2?=
 =?utf-8?B?bWpoVEd4VTJNdE15c3FkYVJJSzhwbEwwRTdIYnQwMFZpQ0t0eEk5dERSczA3?=
 =?utf-8?B?LzdmbWt0MVZvSTg1ZnNMbGdpQnBiZTV0N29XQVpwK2tzMnl1bkx6OXFOY0sx?=
 =?utf-8?B?UzVCNm5mcFY0R09peGtleGpZQm9YUkVmeTAyZzRBeTVMbnhGUlJpSzFpVXFZ?=
 =?utf-8?B?NERmRVBJVmQ5Q0FUY3JJblBRSi9kSjBIcVNKRW1mcFQ5REJDU0wvenVzQVlT?=
 =?utf-8?B?bUVFQ3k3QThjdnVmc3NIQVFYM292SUw3cEFWeW4rc3d3MHYxSkVrcEpuSXBw?=
 =?utf-8?B?aVJ4eHZCc05zQWs3Y2V2Vk0yWHA2TkRjeTF5NDNVVElkbU5wMjFlYzBsSDh5?=
 =?utf-8?B?TVdldzVvKzhEZFJxUE92NGxoRzlOcFB3SWlkMDZUdXlQVEFMMWx6QzNERXc0?=
 =?utf-8?B?VXE4aTJ4WGVFM3VhSURJVFFSeVZkMk9EdWw4NGRHaHdhTTVBM0lnRkdnRkk2?=
 =?utf-8?B?OUlwdmpmTDRTdjg5My9GeDZGS25WQmpTU3IwMlFhREk5VHp2VzllbXpJWjBD?=
 =?utf-8?B?dUF5eDBMNjZDKzJTS3cwRTlONG54UHd2WEpzMkYwQUh0YWhsZ2VpQTFSZ25X?=
 =?utf-8?B?cDJKNzJ0b3Z3YXQxZFBMWU4yTWhOa2V1TllZY2xGazVySWRmd09HM1dUajZr?=
 =?utf-8?B?YnJhUzNhWUNuNkxKR0x1V00wekNIc09sQ2FWM0tkeGl6YUtrbVNXQS9SVlBB?=
 =?utf-8?B?ZFRFWUkvSlJUdUN6QnVTVjBHRHNDNUsxc3QwTk9ERU12bE9nS2JnaWgrVnZa?=
 =?utf-8?B?QjhHTlQrR092N1RPQ3V2S1dnT3c2dVdKNjFLb0E0YmtSRC93T2lKa0lEemRp?=
 =?utf-8?B?RDBabGJ1aG5GV3krNldPTlUwU1Jvc3diK0ZqMkVpUEJtTFJOSXdtVWd3ZFA4?=
 =?utf-8?B?QTNvOURud1Y4OTBFZTFueEZaQjlWWXphNi9MWlZjRWVlV0pPcDFobkxNYkdG?=
 =?utf-8?B?ekJYUGQ3bmpQaVlKdnByZE1YdE93OXFJWjYwWGxPSUdOQ2VBWElTOHl3a3pH?=
 =?utf-8?B?V2FFQkVySDlMcGZjUndDYUVXeHlCNWNVdjFFRkUyMEZsRUp4UmZFWXZkRktT?=
 =?utf-8?B?MlZ5K2M5L3laUTJqUFJxTnduRlBoajZ1K1h1dnRsZGhCWjQ4Qk9GaDJ3VjBK?=
 =?utf-8?B?aW82d0lpUzRNdjF1VStZaTJJbU1iUC9RM0U3MVpETXVBY25yb2JOdVkyelhO?=
 =?utf-8?B?aVB3U1JqK1hKRWQ4ZE1PWE9sbEVSRGNDV2pRUU03MWtKSDVNaFA0QWpFZHlX?=
 =?utf-8?B?M0NMKzNYMHFMUVdLSXBEMzJXWm5jNVNrMkdKRDZVanVwbkdGSkpSQThvUk5R?=
 =?utf-8?B?eG10TDZpLzFGUkdQUWxFdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 08:24:32.0737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 961cea88-776d-48a3-3b43-08dc91cb93ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443

Hello Dhananjay,

On 6/20/2024 6:26 PM, Dhananjay Ugwekar wrote:
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
> $ perf stat -a --per-core -e power_per_core/energy-per-core/ sleep 1

When testing this on a 2P 3rd Generation EPYC System (2 x 64/128T), I
ran into an issue where it seems like the energy reporting for the
system is coming from the second socket. Following are the CPUs on each
socket of the system:

     Node 0: 0-63,   128-191
     Node 1: 64-127, 192-255

Following are the experiments I ran:

   $ # Run a busy loop on each thread of the first socket
   $ for i in `seq 0 63` `seq 128 191`; do taskset -c $i ~/scripts/loop & done
   $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 5

   S0-D0-C0              1               0.00 Joules power_per_core/energy-per-core/
   S0-D0-C1              1               0.00 Joules power_per_core/energy-per-core/
   S0-D0-C2              1               0.00 Joules power_per_core/energy-per-core/
   S0-D0-C3              1               0.00 Joules power_per_core/energy-per-core/
   ...
   S0-D0-C63             1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C0              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C1              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C2              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C3              1               0.00 Joules power_per_core/energy-per-core/
   ...
   S1-D1-C63             1               0.00 Joules power_per_core/energy-per-core/

 From the energy data, it looks as if the system is entirely idle.

If I repeat the same, pinning the running busy loop on the threads of
second socket, I see the following:

   $ # Run a busy loop on each thread of the second socket
   $ for i in `seq 64 127` `seq 192 255`; do taskset -c $i ~/scripts/loop & done
   $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 5

   S0-D0-C0              1              11.79 Joules power_per_core/energy-per-core/
   S0-D0-C1              1              11.80 Joules power_per_core/energy-per-core/
   S0-D0-C2              1              11.90 Joules power_per_core/energy-per-core/
   S0-D0-C3              1              11.88 Joules power_per_core/energy-per-core/
   ...
   S0-D0-C63             1              11.76 Joules power_per_core/energy-per-core/
   S1-D1-C0              1              11.81 Joules power_per_core/energy-per-core/
   S1-D1-C1              1              11.80 Joules power_per_core/energy-per-core/
   S1-D1-C2              1              11.90 Joules power_per_core/energy-per-core/
   S1-D1-C3              1              11.88 Joules power_per_core/energy-per-core/
   ...
   S1-D1-C63             1              11.76 Joules power_per_core/energy-per-core/

The whole system seems to be busy this time around. I've verified that
only half the system is busy using htop in either case.

Running some more experiments, I see the following:

   $ taskset -c 1 ~/scripts/loop& # First thread from Core 1, Socket
   $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 5

   S0-D0-C0              1               0.02 Joules power_per_core/energy-per-core/
   S0-D0-C1              1               0.21 Joules power_per_core/energy-per-core/
   S0-D0-C2              1               0.20 Joules power_per_core/energy-per-core/
   S0-D0-C3              1               0.00 Joules power_per_core/energy-per-core/
   ...
   (Seemingly idle system)


   $ taskset -c 65 ~/scripts/loop&
   $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 5

   S0-D0-C0              1               0.01 Joules power_per_core/energy-per-core/
   S0-D0-C1              1              16.73 Joules power_per_core/energy-per-core/
   S0-D0-C2              1               0.00 Joules power_per_core/energy-per-core/
   S0-D0-C3              1               0.00 Joules power_per_core/energy-per-core/
   ...
   S0-D0-C63             1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C0              1               0.01 Joules power_per_core/energy-per-core/
   S1-D1-C1              1              16.73 Joules power_per_core/energy-per-core/
   S1-D1-C2              1               0.00 Joules power_per_core/energy-per-core/
   S1-D1-C3              1               0.00 Joules power_per_core/energy-per-core/
   ...
   S1-D1-C63             1               0.00 Joules power_per_core/energy-per-core/

   (Core 1 from both sockets look busy reporting identical energy
    values)

Hope it helps narrow down the issue.

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
> 
> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/
> 
> This patchset applies cleanly on top of v6.10-rc4 as well as latest
> tip/master.

P.S. I tested these changes on top of tip:perf/core

> 
> [..snip..]
> 

-- 
Thanks and Regards,
Prateek

