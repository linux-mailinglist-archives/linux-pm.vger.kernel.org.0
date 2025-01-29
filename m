Return-Path: <linux-pm+bounces-21091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFE8A21C3B
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 12:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F32D3A36D7
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 11:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5A71BCA07;
	Wed, 29 Jan 2025 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QfuO5f/V"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07243186615;
	Wed, 29 Jan 2025 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738150202; cv=fail; b=HSMZUwg1ebNR4DQgiZh6RKs1LIPxlXsVXQUvz/IkIigKqxrwNjfuTVDtp0DMGy684PUTE+xD8H1woywerLNOTdc+IKxVqRgcd9hrchNhxNgQdexZeTeo9SKO2JqVnqPkdgonxOdiMdRkqyerAq09qxfAAEIYFT9nG3xRkKun+BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738150202; c=relaxed/simple;
	bh=JMXmosfAIP7GhBWe87kM6DKPbriVwsOJ1Sch4UhEeoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l4tTNI/EGRelgBQ6n9PCsbAezPT6S3pfmMRyuqvxAo2GkHfFExm30qR8d1fPjxMwFIhpUS2n0KDr8KqOz+xJpRQT9VgRJ+692ZRP7VUuZcHam5qeHn+t0YyhfAkVijtZFpFkFTkWq0teWD7i4GKxoWQTFdMvRHsfLRX4nLBL/Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QfuO5f/V; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7KAOhM2dN9XtMtg6KaunmDgfjEi3eXN4V1ygHwTZRhTub7LaQYTPavuYn01svvabby3BgsT8FSTBM4P07p2W1CAKj8nNEHfemZJzqnsliSrPTW4bwKtPPmSt937heMiyfhXUd33CfkkDGdeMOBcK86219rGBoCw6FUkBMSmieABs/7huRcn4UtA7OEa+uyJsTVEUc0qoRJF9/Z1vdD8qGEaQnx5iJQTbLnvyutazcguPYjKsj53KXC7tY0fgcErBexoHFxgtm0PonhbUPxj9n0YT0AwsBcTPRgC5AHL1tnTLUVithueu8B0IWqsXfLZnv8HT2InMnghxy7JEG2ewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+fuA6zWajZ9RrmhgJDg/yMWDsD69ynTq8wlKHUEbLk=;
 b=ad5dfRO7sLKtdZOc6CfkPFMknMA5vzcZxjDBpMeuO4cdT4DgZyC//HLvMVNmiSbVnGHQ7DT2fp5cZF9ZzOXfSerbGpvgrZINnxzEer6mZ1T4Sx9oB3dL4mbUmANB0FeopzvttWpcTTL9zUcwL2ODu2sblEO1XSjQCB4C++8ju7Sm1FasgAHEZIqFNZ5LkkzhjGi44TEvo0PehTp1RGCYIGp98TFjwEzT+ZUUo/kDHSRxZC6RoGOlMVwfjXh0DvWb25Q6MfTD3W+NwY/8cC1PSkehyyiFkkkE3oiN4GGVuhqJvJN1IKfWEFfgg0sdOYZmuIMwR8cqmhLdCmoOWEjqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+fuA6zWajZ9RrmhgJDg/yMWDsD69ynTq8wlKHUEbLk=;
 b=QfuO5f/V6xgJ42johXPsVTWPEGlkshmwcCon0T24sZHMeFGKR9mPnC4UB77VJfKw4fPJcQ/HjaQXbZO/8zxKBq8wPGlAx6LGkKciz92K4YNFAx9JfB3QL4iONaMaE3NpWnVDk2uedc31z9QcfUKe+QNn7/O+WZbH4kNEDauHHkgrcvRDIx0RfKfADdNAosVuMgA3Ero9JqPAoo6vp32eenzBmHBsmAdA1m8V61dfRWD8DATw/LSi33tZt0GiX+cLLwNIoXu6tpCGyyUSk0nZhlcZFjZH7IEZwz8zH5VR7cPsKbhQDonMbwd4oktLfofxmAAjAt4laz4e1uFLO65qhA==
Received: from CH2PR14CA0049.namprd14.prod.outlook.com (2603:10b6:610:56::29)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 11:29:56 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::85) by CH2PR14CA0049.outlook.office365.com
 (2603:10b6:610:56::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 29 Jan 2025 11:29:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 11:29:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 03:29:42 -0800
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Jan
 2025 03:29:36 -0800
Message-ID: <75454544-f23e-4de9-bc12-64d134fc5027@nvidia.com>
Date: Wed, 29 Jan 2025 16:59:33 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/5] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
To: Beata Michalska <beata.michalska@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<ionela.voinescu@arm.com>, <sudeep.holla@arm.com>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <yang@os.amperecomputing.com>, <vanshikonda@os.amperecomputing.com>,
	<lihuisong@huawei.com>, <zhanjie9@hisilicon.com>, Jonathan Corbet
	<corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Phil Auld
	<pauld@redhat.com>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	linux-tegra <linux-tegra@vger.kernel.org>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-3-beata.michalska@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20250121084435.2839280-3-beata.michalska@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d0f82f-6121-4604-23cb-08dd405841fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUhRd0xkNWxZMTFXaTd5RlY1Z1VvM2FadTFoamN3T3E1WVdIYzk3cVZreWlv?=
 =?utf-8?B?b2daYlFrNnRkVzNKZVpsaG01WnJmWkdGYTNpT2xPNlB3YUl2WTd3eGJHT2tx?=
 =?utf-8?B?RU94QzFGKzVVb09iVk1KZTRkVzU2RmpPSHozWmVJVU0xdnZGVmd0dXVPdm5J?=
 =?utf-8?B?cEd4aVFYbHRCSlEvZTN3K0cwU1M2VkJHZUlKSDQwWk5sWEhwOFdaaWcvTHRi?=
 =?utf-8?B?Y0ZjSGhFSXJBcE9CMTY1YnU1OXdUSjZ3RzIxNkdSTWkzcTFNOFBndi9xaUM5?=
 =?utf-8?B?UUx5QW81aDIwbnBWeWFwYmg5Rmx2dHFPUU9nc1hoWW12L2J3TmNmek1uYk9h?=
 =?utf-8?B?TDJFYkxIbTZ1bTJPUFpDSzBBdFZSTXJUaDU0QnZhakdpZjlmOG1ZU1Z4bXcz?=
 =?utf-8?B?VWliUGZTSEwvbEkxaHVhekRWV1NPbzJubDk2Y2I5bVR6Z2Z0RHI0NktlZHZR?=
 =?utf-8?B?QmE3d1BaSzRZblFtNTJCVGxNVU03T292M0ZUdHljUmp3bDh5ZUh1T1RkT0w0?=
 =?utf-8?B?ZXd3c1Z3ckNDTWR6SFAzOUZCNGQ3amNMYTR6OHZHT1gyeW9IMVp2UFBYOWdh?=
 =?utf-8?B?ZEhNUkQyZFV6WkJJYkdkc1JpUTFVSFRzWFQ0RHo0MFhBZmRFbUZlNGIwNjB2?=
 =?utf-8?B?ZUpnQjlSR3lDaXhsUysxVUZXNi9Dczlod1RybGkyRERwNFBsRVd4aVhhbXpV?=
 =?utf-8?B?L20yT0NiMXpvbVN2SnVSWXV2MHlVY3pQZFF5a1RnOWNWV2hlZDFKRmQ4NGlv?=
 =?utf-8?B?UmR5N0tJNUU3S2ZUZGJUZTlRWWFOb0dLTldpaE1mVHlBUVhUS1h5SUJPY29E?=
 =?utf-8?B?TkhIOVg1TGpQUWxjWm1xYTBjY3FTZnFBV2FSM1IwWEIvamRmbFMyTlhJd1F6?=
 =?utf-8?B?UktobmNDaXFBaXVBcU5MV2NzdXR5eXl5aXhkOGFNQTNHbzFDY2VzWUpMaUxQ?=
 =?utf-8?B?YzVpcnMvYTR6OUk2RHU5QnNIZWQ5azFnajUxcElzbG85V3IrZE1ONzU3cjYw?=
 =?utf-8?B?Z1huejczenY0M3VHVHplMzFHWmE4M2xwUTVNa1djM212QlFMRWFncmc4bEln?=
 =?utf-8?B?UElkaHUxTDhvc2Y1MVV4bURnVTlvTEVsS1dMclRxaElxQUtNOStGYVQ5ZkIv?=
 =?utf-8?B?c29weUUxUSt1OGRxT3Ewc0J3RWNBQzA4SS9NNytReitpdzNGR0UvWGxoNlBT?=
 =?utf-8?B?eEVYNEQxTk12MTF5MGR3bWlKWXhmTmRGR09nWVptZ3NDQVFwNkhkQUU2TktB?=
 =?utf-8?B?ZWtiQW1aU1Ftb0ZiOWpjRnB5MXlYUlplZ2xjdG1qTnc2NGZGK2tLQW9adWli?=
 =?utf-8?B?UmxQV2xacDhUTUFERytzSmt2ZWdodGxjQkU5N1RQR3BXS050ZFFUUlU4ak5N?=
 =?utf-8?B?SWEvbkNES3krZHB0KzUxeFh5OFlLYVVrejk0V29xNzRYNWlqRVp5Ym1FTkht?=
 =?utf-8?B?dFA0TDRCNEdwdDN0NUxoSHdJeW5aRnVnaU56TDV0bVZNaHVKeFplKy9ZUVpS?=
 =?utf-8?B?QVFOajdZa3NFclJxNGluWkNMRmR1RWdnZ1Q4d2t6VDNpczhaREg4d3ZkRlNK?=
 =?utf-8?B?UVF5UDlRMnFGMmw1QmtoczFNbHVsU2M5L2czWDcyRmNCRzJocHdEdHE2UmtL?=
 =?utf-8?B?VXFYL1pqdHJsZS9STy9NN0xJYnBCVEp0REQwOG5PaWxoODQwdzJ5S1RkcVZ0?=
 =?utf-8?B?bkRPNXFXSW1CVkZCUWYvRURxc0NtRm1FWTRIRjhVdVh2TWU4and5Zld6NG9k?=
 =?utf-8?B?elFYMyt0bXk4a1VwZkpGaVFUbTd3UldRc2cyMXVncFoxR3VaRGMzMHNXNGI3?=
 =?utf-8?B?dFBuNEJEM0RwK2NIaUo3eWgrOU5CZXVXbEJoZU83SXF3UzNOa1RXejdTaUc1?=
 =?utf-8?B?ek9WWkZvalNNUXNtbEl4NFRFOWM5VGZKbGFBYXNhTFJzSVR5ZnE0RThYUC9y?=
 =?utf-8?B?eEE2NThxRnBrVmg5VENQVElSaUh4ZzAwVnl3MVhTQ0pnU2RWdU82TGQybjV0?=
 =?utf-8?B?VWxBc3FlSVhKM1VYU2ErbEtCeGVqVE95UHFRRE9IVkxrY1FSRGtOalB1ZnQ5?=
 =?utf-8?Q?eMpzkn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 11:29:56.3324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d0f82f-6121-4604-23cb-08dd405841fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482



On 21/01/25 14:14, Beata Michalska wrote:
> 
> 
> Currently the CPUFreq core exposes two sysfs attributes that can be used
> to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
> and scaling_cur_freq. Both provide slightly different view on the
> subject and they do come with their own drawbacks.
> 
> cpuinfo_cur_freq provides higher precision though at a cost of being
> rather expensive. Moreover, the information retrieved via this attribute
> is somewhat short lived as frequency can change at any point of time
> making it difficult to reason from.
> 
> scaling_cur_freq, on the other hand, tends to be less accurate but then
> the actual level of precision (and source of information) varies between
> architectures making it a bit ambiguous.
> 
> The new attribute, cpuinfo_avg_freq, is intended to provide more stable,
> distinct interface, exposing an average frequency of a given CPU(s), as
> reported by the hardware, over a time frame spanning no more than a few
> milliseconds. As it requires appropriate hardware support, this
> interface is optional.
> 
> Note that under the hood, the new attribute relies on the information
> provided by arch_freq_get_on_cpu, which, up to this point, has been
> feeding data for scaling_cur_freq attribute, being the source of
> ambiguity when it comes to interpretation. This has been amended by
> restoring the intended behavior for scaling_cur_freq, with a new
> dedicated config option to maintain status quo for those, who may need
> it.
> 
> CC: Jonathan Corbet <corbet@lwn.net>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: Dave Hansen <dave.hansen@linux.intel.com>
> CC: H. Peter Anvin <hpa@zytor.com>
> CC: Phil Auld <pauld@redhat.com>
> CC: x86@kernel.org
> CC: linux-doc@vger.kernel.org
> 
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>   Documentation/admin-guide/pm/cpufreq.rst | 16 ++++++++++++-
>   drivers/cpufreq/Kconfig.x86              | 12 ++++++++++
>   drivers/cpufreq/cpufreq.c                | 30 +++++++++++++++++++++++-
>   3 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
> index a21369eba034..e9969174026c 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -248,6 +248,19 @@ are the following:
>          If that frequency cannot be determined, this attribute should not
>          be present.
> 
> +``cpuinfo_avg_freq``
> +        An average frequency (in KHz) of all CPUs belonging to a given policy,
> +        derived from a hardware provided feedback and reported on a time frame
> +        spanning at most few milliseconds.
> +
> +        This is expected to be based on the frequency the hardware actually runs
> +        at and, as such, might require specialised hardware support (such as AMU
> +        extension on ARM). If one cannot be determined, this attribute should
> +        not be present.
> +
> +        Note, that failed attempt to retrieve current frequency for a given
> +        CPU(s) will result in an appropriate error.
> +

Minor nit:
Should we also add: Idle CPU's on ARM will return EAGAIN (Resource 
temporarily unavailable) error?

>   ``cpuinfo_max_freq``
>          Maximum possible operating frequency the CPUs belonging to this policy
>          can run at (in kHz).
> @@ -293,7 +306,8 @@ are the following:
>          Some architectures (e.g. ``x86``) may attempt to provide information
>          more precisely reflecting the current CPU frequency through this
>          attribute, but that still may not be the exact current CPU frequency as
> -       seen by the hardware at the moment.
> +       seen by the hardware at the moment. This behavior though, is only
> +       available via c:macro:``CPUFREQ_ARCH_CUR_FREQ`` option.
> 
>   ``scaling_driver``
>          The scaling driver currently in use.
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 97c2d4f15d76..212e1b9afe21 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -340,3 +340,15 @@ config X86_SPEEDSTEP_RELAXED_CAP_CHECK
>            option lets the probing code bypass some of those checks if the
>            parameter "relaxed_check=1" is passed to the module.
> 
> +config CPUFREQ_ARCH_CUR_FREQ
> +       default y
> +       bool "Current frequency derived from HW provided feedback"
> +       help
> +         This determines whether the scaling_cur_freq sysfs attribute returns
> +         the last requested frequency or a more precise value based on hardware
> +         provided feedback (as architected counters).
> +         Given that a more precise frequency can now be provided via the
> +         cpuinfo_avg_cur_freq attribute, by enabling this option,

s/cpuinfo_avg_cur_freq/cpuinfo_cur_freq/?

Overall looks good to me.

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>


