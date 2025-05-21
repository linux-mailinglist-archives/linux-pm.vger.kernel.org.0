Return-Path: <linux-pm+bounces-27446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C771ABF1E4
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 12:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A034B3A9B3B
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 10:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6B625F98F;
	Wed, 21 May 2025 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nu5ssv0h"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40CD25F972;
	Wed, 21 May 2025 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747824258; cv=fail; b=My9WrTcUVaCEuwwfiZ4Q3wIhDqDuQdh2zBzTyZunuwigSa4vtPysyif5OVQ5LLN2okhkw9en4ysuCLU1dDiVUwoZv1AbyWgctR7DtXEVm6yC46sY+gabY6X4KSs0M9oxobSGjz2kbKMF1mquoUxUr1S7iiDlWIBcZ8waeNosPsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747824258; c=relaxed/simple;
	bh=jd8Mj3fgg6M9ZM6KJyMVss7Yn1ENf8vI0BA5/hGfh18=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vFaybrV2VWZuatUyc3ZA+8zw0k2GybkNyzumfWX4z/ZH5QDoHhfq0in0V4dU4180xt7iOM75Z3zjeSSsLTzuuBCB+IgP1DZxiShc4L0rTioDTulkCL2LXLzyjW4wee2e4cp9LuHWwhwxnV4Ftq2HtOieenpZBEM8ASEipp/FZMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nu5ssv0h; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6Igty8XFdvnBojM87mwBsS7udVbwl4VLUUqsJIKfYSF3VQELTB3PIw/yg55PoRBMJ3JiE6IolG29I8TG3g9LVbAdMJejyexBbDVvVtOOGdN5eTbqiHu5getHVsSI+cgHQLBFdX4RnFH1w4eIq1pk8ooe1JhK31aaiYcYpoyoRv84Pl6KAfg1MVIn0ivgOyNl1x/5XBT+tKXBQEpgTLNzePApnefFIeFE52O7D1Zx26L7zSedR+cTKArS48fRI52U1LOiiu7ZZqEdPW+l3WRR4IIOgcYsdL8unjmwm8x4akNwiC5O9P7EExglaoxj4UCT3hIhObVeu36UUkL1thJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j73jbV88UiiQk9nK9TBNoXJ3ZeXMNp3bKR/PWS5J1i0=;
 b=T3QELaDSDkVNh/zDR+U0FVHUycDzwqqkBNABNJyoNwjcjbxCepW+/Rdv3YlyMkCRGktw+NT38ZaoGBF2ad7lqw9roWmuO/NqTjthQHBCUJRk75eB9QYAA29gDEBerwH1wUZ2clsXFztpmhl4E8gBOpN6AZk2yRUtxjKXxmy3mhquA8ZIyMEq74J4aSVVAKbu4yLvy2IEJhUSNTjH1KVWl6Hut6VXng9dBf8Bqj0nV13DB6FLrCdms1ZSgMQNUVTFgYl2s04lksWMEVMoBCxxWukAcPpRFajP4c/NzBnMCX/nQrcRQeV2oVUJB4Gcql/HToS8dmMyhyiAcmsAzcbYZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j73jbV88UiiQk9nK9TBNoXJ3ZeXMNp3bKR/PWS5J1i0=;
 b=nu5ssv0hqx2zt27W2Xazx0zOSWCKK4AAzGmGoDmbsVvzcCTZm6BmIQ6sOd3Iv/jHRJ8xw4TuYw7o9iGFALiKkq4ag9h6RKF20oqHdG/DZ8Wp1D3NGKy82PodHm2KxpEA7Mtgu/hlf8s0Q7OPPfHxM/UABguWQJYbg1EnRuL7bQDk+Dp5KQDCnxTPrTfDPSwQaZqJoKrF0zIfKJcosKrM/XpUEKR2Xg1tPIAqFSQYakJ8g7YNdXT6GjLWbjLq8v0G2vNjuYnF4/vw9u2QKocoBEuKmAe5KeHq+6DyEBYuXg/9bd6FdChS8Lu/3/rJOFLdszNcCin+4qxtPbwuqtPDnA==
Received: from DS7PR03CA0333.namprd03.prod.outlook.com (2603:10b6:8:55::15) by
 CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Wed, 21 May 2025 10:44:10 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:8:55:cafe::f8) by DS7PR03CA0333.outlook.office365.com
 (2603:10b6:8:55::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Wed,
 21 May 2025 10:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.4 via Frontend Transport; Wed, 21 May 2025 10:44:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 May
 2025 03:43:52 -0700
Received: from [10.41.21.119] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 21 May
 2025 03:43:47 -0700
Message-ID: <98c87824-2c77-4ae3-b466-badd8e8187ad@nvidia.com>
Date: Wed, 21 May 2025 16:13:44 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
To: Lifeng Zheng <zhenglifeng1@huawei.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <pierre.gondois@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <mario.limonciello@amd.com>,
	<yumpusamongus@gmail.com>, <srinivas.pandruvada@linux.intel.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <cenxinghai@h-partners.com>, <yubowen8@huawei.com>,
	<hepeng68@huawei.com>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20250507031941.2812701-1-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20250507031941.2812701-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: ab30a8b9-5814-4baa-ec05-08dd98546a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em5lWCttMEFQbWVRMHRTcE1xdGlqZWw4VnV6MHhGeS9HbnZEKzFDYXFpMVY3?=
 =?utf-8?B?MlFBZzBKOFZ0T242c2g4UXR6MUNnaXpTUUhFQk5xMnZUOUM4aGk0cE5DWmdw?=
 =?utf-8?B?RUlWeHJVMjFtNFlOTDk4b1cydzhGY0dFZVZnb1lEUTZsS3hFc1k0bXZFUzIr?=
 =?utf-8?B?Tk1udFJDMDlvNnZsU1VYTnZvQWVVSnRtbFRrU0RJQmZxY3QraVllNzFhZk45?=
 =?utf-8?B?TEhoRG9JdUtacVc2aGZLWVk4VFFKQmFEb3ZvOSthakE3MklOb2I2YzJOWGFt?=
 =?utf-8?B?UGRocHh1R09sSFRTZDdtWkRva0NwS25vTkt2L0syMkJEN3BXTk1McEk0NlFL?=
 =?utf-8?B?Nkh3cVBHVERPSkRPalUydkNXb1FwMmJkYTNpU0NLYWI3N3F4cG1Gb0Q2VzZj?=
 =?utf-8?B?VzZLZEpzREFEZWtNUzRmaDgyOG9WMHlLSjJrQTVpSnBMMGVHWDJ5TjMrRVYy?=
 =?utf-8?B?MldmblprbGdiNnpTQjlOTzNkank0Z2loM1hYN0lJL0Y5eXBNN0lmdE9NbUpj?=
 =?utf-8?B?bXdlV0VKSnNTK25MbkRJaU5oRWlVa2Z5RVpaRGV0bVRBSWk1a3JCdU1TVzJK?=
 =?utf-8?B?WWlVVG0ycXVYM1FBN3RQWmlBYTV5clVWVzRxeEw5cjZJaXA5N2ZMT01jUXpj?=
 =?utf-8?B?ZGk4UW1zeGJkenRBTUZUSDIwQURBVEQvUHN2eDVMcnJXOE15b2FLaFlpbWRz?=
 =?utf-8?B?OTE5M1EvblIvV3Y3SURvZ2g0SGI4WTJkbHVKRmlLbzJKTE04bmNhYllJeGZD?=
 =?utf-8?B?Y0lYYTJQOVp5RFF2bTNOUUVvY3NsVVJmY1Y4Q0JHMmpQV2ZwbTlmakxXdEYy?=
 =?utf-8?B?b3Q0R1lYc1B5NVB1eE52WlJPdDZPVzFmR0EvUnowRFpxUFZWS2FKUERIblMy?=
 =?utf-8?B?MDJweVlDV2dlaUVQN08vdm9SSVV4Z25xZzBrZGkxbTJxNG1TQllwUC9pUUsr?=
 =?utf-8?B?Q3Rjd3k5WjV0TExzdWVZYmw3Yk1kS21jeCt1OFI3NFcvTTVubitoQ1pXamtX?=
 =?utf-8?B?VXVWb0xlSmljOUUxOS9kZ1Jzb2pkTmVPR2h3YnFWK3FyWmhJVXdIdEc4dU1x?=
 =?utf-8?B?NzVQOU9GRFZ1eW41WUVUVUo1L0gxZnFmVm9PUWJvWFA5cW9NNjJJVDdPL1d1?=
 =?utf-8?B?SC9DK3V6L3g4Z0t6Y0U4ZCtPVld4YitQWmdUQmdubkR5Tm13ODNGZVF1UkVm?=
 =?utf-8?B?WUVONWwvTDMwbHI5V3NpM01VUXdwcmU1d2lxU0ViVU1UcERiVkt5SWRTZTA3?=
 =?utf-8?B?ZDR5eFl6VEY1N0N1aVlZN1lyVUt5aldaelo2aVppKzNiMkVoMlBpSkY4MEds?=
 =?utf-8?B?amNjS3Z0N0wzNHE4RmlrcUQ0aGdzNVV5eTN6NWJmRlVSSlBnU2YvbTdwdm1T?=
 =?utf-8?B?T3QwWitETklFcHZhN1hEa216TVBaeUZRRzhZdGh2MjEwc0NZT3BoZ2tRWmc3?=
 =?utf-8?B?WVo1VDU3eVg4UnN3TWFxTVJNRkNWbXZPSGVVUzh5T1VuUXJyS0RnM0Z0aHND?=
 =?utf-8?B?N2ZrT0g1QlNtdW1tOSs0Q2NSZEp5WGdoenIwVjNRK1d2Q0NodjFIdExjRzR5?=
 =?utf-8?B?aUFzVHdsRmppSUNmZVpCVkdvc0tuUkszSTF3MHhXb0pNSTdHY01PZGw3Y2U1?=
 =?utf-8?B?aHRMUVVtOEM4R2ZnTVlKUk9BV011c25Cd3V2d1pidG9aVlNvdjl5SXZySVpu?=
 =?utf-8?B?TFZ2NUNLeWNQVDl0TFZicnZvbjFuZ3M3bm9NdzYxZStZQ0t2K3lmVFNrcC9Z?=
 =?utf-8?B?emV6L2tKanJ0TkVUdmtiVC9CdnRESjQ4eXJMQzVqQkxoTkkybE9vdEpLeDBt?=
 =?utf-8?B?RVUwMWN3Y3NOdEc1UVFQaXdRUXV3a3ptWi9UV1dXRUtLRU4xZzJiZjZpNE1q?=
 =?utf-8?B?QXZvc2dwQ2lwUm1GNVFQbmd3RmhwcDNDeU8vQnZOSTlmVDljQkpqelUyd2Vo?=
 =?utf-8?B?VmlpWk1jRUtFdCsxY1A5WjJ2Wmp4TWRWRElxL0txMXZEUlc0R1Y5emp4bHRt?=
 =?utf-8?B?RDVCdldXbWlMM0lDdWsxb0JnRzNVME9sRjA2elJtbkxCdG5CSDRYZ0g0enJh?=
 =?utf-8?B?enR2MVl5RStESHdkTkNKdy9HeFY3ZFZwS3pNdz09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 10:44:08.4957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab30a8b9-5814-4baa-ec05-08dd98546a6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990



On 07/05/25 08:49, Lifeng Zheng wrote:
> External email: Use caution opening links or attachments
> 
> 
> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
> driver.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>

Looks good to me.

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>

> ---
> Hi Rafael,
> 
> This patch is the 8th patch in [1]. After the discussion in [2], Sumit
> is OK with adding sysfs entries under cpufreq sysfs node, so I resend
> this patch. He will later send his updated patch after.
> 
> Any comments appreciated!
> 
> Lifeng
> 
> [1] https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
> [2] https://lore.kernel.org/all/20250211103737.447704-1-sumitg@nvidia.com/
> 
>   .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
>   drivers/cpufreq/cppc_cpufreq.c                | 109 ++++++++++++++++++
>   2 files changed, 163 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 206079d3bd5b..37065e1b8ebc 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -268,6 +268,60 @@ Description:       Discover CPUs in the same CPU frequency coordination domain
>                  This file is only present if the acpi-cpufreq or the cppc-cpufreq
>                  drivers are in use.
> 
> +What:          /sys/devices/system/cpu/cpuX/cpufreq/auto_select
> +Date:          May 2025
> +Contact:       linux-pm@vger.kernel.org
> +Description:   Autonomous selection enable
> +
> +               Read/write interface to control autonomous selection enable
> +                       Read returns autonomous selection status:
> +                               0: autonomous selection is disabled
> +                               1: autonomous selection is enabled
> +
> +                       Write 'y' or '1' or 'on' to enable autonomous selection.
> +                       Write 'n' or '0' or 'off' to disable autonomous selection.
> +
> +               This file is only present if the cppc-cpufreq driver is in use.
> +
> +What:          /sys/devices/system/cpu/cpuX/cpufreq/auto_act_window
> +Date:          May 2025
> +Contact:       linux-pm@vger.kernel.org
> +Description:   Autonomous activity window
> +
> +               This file indicates a moving utilization sensitivity window to
> +               the platform's autonomous selection policy.
> +
> +               Read/write an integer represents autonomous activity window (in
> +               microseconds) from/to this file. The max value to write is
> +               1270000000 but the max significand is 127. This means that if 128
> +               is written to this file, 127 will be stored. If the value is
> +               greater than 130, only the first two digits will be saved as
> +               significand.
> +
> +               Writing a zero value to this file enable the platform to
> +               determine an appropriate Activity Window depending on the workload.
> +
> +               Writing to this file only has meaning when Autonomous Selection is
> +               enabled.
> +
> +               This file is only present if the cppc-cpufreq driver is in use.
> +
> +What:          /sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference_val
> +Date:          May 2025
> +Contact:       linux-pm@vger.kernel.org
> +Description:   Energy performance preference
> +
> +               Read/write an 8-bit integer from/to this file. This file
> +               represents a range of values from 0 (performance preference) to
> +               0xFF (energy efficiency preference) that influences the rate of
> +               performance increase/decrease and the result of the hardware's
> +               energy efficiency and performance optimization policies.
> +
> +               Writing to this file only has meaning when Autonomous Selection is
> +               enabled.
> +
> +               This file is only present if the cppc-cpufreq driver is in use.
> +
> 
>   What:          /sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>   Date:          August 2008
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index b3d74f9adcf0..3c3d00cec298 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -808,10 +808,119 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
> 
>          return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
>   }
> +
> +static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
> +{
> +       bool val;
> +       int ret;
> +
> +       ret = cppc_get_auto_sel(policy->cpu, &val);
> +
> +       /* show "<unsupported>" when this register is not supported by cpc */
> +       if (ret == -EOPNOTSUPP)
> +               return sysfs_emit(buf, "<unsupported>\n");
> +
> +       if (ret)
> +               return ret;
> +
> +       return sysfs_emit(buf, "%d\n", val);
> +}
> +
> +static ssize_t store_auto_select(struct cpufreq_policy *policy,
> +                                const char *buf, size_t count)
> +{
> +       bool val;
> +       int ret;
> +
> +       ret = kstrtobool(buf, &val);
> +       if (ret)
> +               return ret;
> +
> +       ret = cppc_set_auto_sel(policy->cpu, val);
> +       if (ret)
> +               return ret;
> +
> +       return count;
> +}
> +
> +static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
> +{
> +       u64 val;
> +       int ret;
> +
> +       ret = cppc_get_auto_act_window(policy->cpu, &val);
> +
> +       /* show "<unsupported>" when this register is not supported by cpc */
> +       if (ret == -EOPNOTSUPP)
> +               return sysfs_emit(buf, "<unsupported>\n");
> +
> +       if (ret)
> +               return ret;
> +
> +       return sysfs_emit(buf, "%llu\n", val);
> +}
> +
> +static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
> +                                    const char *buf, size_t count)
> +{
> +       u64 usec;
> +       int ret;
> +
> +       ret = kstrtou64(buf, 0, &usec);
> +       if (ret)
> +               return ret;
> +
> +       ret = cppc_set_auto_act_window(policy->cpu, usec);
> +       if (ret)
> +               return ret;
> +
> +       return count;
> +}
> +
> +static ssize_t show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
> +{
> +       u64 val;
> +       int ret;
> +
> +       ret = cppc_get_epp_perf(policy->cpu, &val);
> +
> +       /* show "<unsupported>" when this register is not supported by cpc */
> +       if (ret == -EOPNOTSUPP)
> +               return sysfs_emit(buf, "<unsupported>\n");
> +
> +       if (ret)
> +               return ret;
> +
> +       return sysfs_emit(buf, "%llu\n", val);
> +}
> +
> +static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *policy,
> +                                                      const char *buf, size_t count)
> +{
> +       u64 val;
> +       int ret;
> +
> +       ret = kstrtou64(buf, 0, &val);
> +       if (ret)
> +               return ret;
> +
> +       ret = cppc_set_epp(policy->cpu, val);
> +       if (ret)
> +               return ret;
> +
> +       return count;
> +}
> +
>   cpufreq_freq_attr_ro(freqdomain_cpus);
> +cpufreq_freq_attr_rw(auto_select);
> +cpufreq_freq_attr_rw(auto_act_window);
> +cpufreq_freq_attr_rw(energy_performance_preference_val);
> 
>   static struct freq_attr *cppc_cpufreq_attr[] = {
>          &freqdomain_cpus,
> +       &auto_select,
> +       &auto_act_window,
> +       &energy_performance_preference_val,
>          NULL,
>   };
> 
> --
> 2.33.0
> 

