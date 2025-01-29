Return-Path: <linux-pm+bounces-21086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A701EA21BDF
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 12:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA91F3A3395
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 11:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7811B4230;
	Wed, 29 Jan 2025 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a8UEfx6h"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68151A76D4;
	Wed, 29 Jan 2025 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149223; cv=fail; b=eLrly2Zf+jOLP5+3Ac3gP6ur5SQjLuzW32XzKdsDTNTHKx/aMu/HRiwpkxckP5R+dHfDnNjYi4BniXbMOoU64vFin14oA7LwoBlO1rQMI3FJEIAE56gCthO9QRaCIPrR2GvnsY2CaKD8zToyBTtZHFyfxyBkNMIkf6n9RV6DYPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149223; c=relaxed/simple;
	bh=6LsklPxqkySQzKbUt6aSCXTICRCXBjEeS/30MUbhD6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XSF58yvp2RmSDw4NI0ZW0BClz7b5F7XiIcHefw0EOAJhCHApoV3pE0Ff/OusPBluQZO31M+YF35cHKvDiPhjTGkXraFWszk6X643Hz4rPJdeTo9eqK6qnvEsauQ/hdm+uxBziSKXkQpPUE244UBkialIIQFajBXC1KvaLBoq9og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a8UEfx6h; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qr5pm1bMutxy6ovz9Bm9SPf+7WYMg8/Dn1m494Qibboy0FKApKQ71t4lJ4tDz1CwqFYZQ5DWh+lwNI/rKlh4R35vLp+lL1S4Xpi4KrZi2pXRqI0sxyZpBlw1hEyzUg2Kcgbum1644smtxSWIkvzjNoF3T6bda+LHMBM4Rzz8Fy7/ytQQikajf6IlgbfU0B/vYl+m00UZxPDecFe/akU3Gis6CQuK0vRxOjXztv7MOXVn85L1GwB/6Iom9wNxIY9XcSbb/09vhkDXVEYeb6syT80A9lsuiq8dFo900CaMm9jBk1lqyc4JW0utNNLj0tUJ6shqA+LJRrxzCaLGI37hbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4Ycv0jMEYqaIs7d4/u1YE5aqPU6fHIXAAMoEjHkM6U=;
 b=oiXnPTfgT+IPNPWuUJFweX2xrcvT6NTTnmYHYg2SwTjH+zNSg8l/AN38a0RZta433+0xwRZoHwuof7CCddBBDcIot1hr8HxByazyRVeizFFfuYVS0ueP09m9vfB91YUuH+JPJb5qT3e9XZkUq8QAvTLjQjeFJsruc1O6ir4DWq2hCx6Vjy5pXWyFkokLo7GAMGWuHAQBlU+4Hb8rs8huxUl5kSm9Tf9kEmhVkwRGDUYA/TVCr+uPng2wUJ2v4ZrCDvjNwv2ZHJKkeXqSkBhWkaViPppqcj59rdBLdcijiqaAxedocO75aX6fl/uDjv/HBd9e/wdi4CNAcP6rIlYhVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4Ycv0jMEYqaIs7d4/u1YE5aqPU6fHIXAAMoEjHkM6U=;
 b=a8UEfx6hMmLLMD/xjmxREijNRmftdhuRdIAR6VxSPwzqQWfuF8dleZzmTF45FtRSn/kIsy/TaE7vYh3Z46btaiVDfSHZ/BPqdyDiPTmC8g9l+Fua/iAiHPSsKfVrA1hq0B+0ptyj/ch87rcQanHLq17kZf3f4OWbPMvQynP5bV3bgsYvIuSdApV9vRhueaBVUs7KrWLIIwsrYom47fMYkg8nSwt9/zG58h4SDTFq2N5Qpy7QCpdSX2vYIze6V5Qf4S5v+KKVhfIena/MO/wFmKFhG+nXcBcl5s+BNvESQ2wrdsGFk/Uidx7ArYybgYzfksy+E2+VRYWtE+yJcuDlZA==
Received: from SJ0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:a03:3a1::14)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 11:13:37 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::86) by SJ0PR03CA0369.outlook.office365.com
 (2603:10b6:a03:3a1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 29 Jan 2025 11:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 11:13:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 03:13:26 -0800
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Jan
 2025 03:13:21 -0800
Message-ID: <391cd0ea-3eec-44ae-a297-9e2d69000e95@nvidia.com>
Date: Wed, 29 Jan 2025 16:43:19 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/5] arm64: Update AMU-based freq scale factor on
 entering idle
To: Beata Michalska <beata.michalska@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<ionela.voinescu@arm.com>, <sudeep.holla@arm.com>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <yang@os.amperecomputing.com>, <vanshikonda@os.amperecomputing.com>,
	<lihuisong@huawei.com>, <zhanjie9@hisilicon.com>, linux-tegra
	<linux-tegra@vger.kernel.org>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-6-beata.michalska@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20250121084435.2839280-6-beata.michalska@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: ca502889-52d9-4dba-9194-08dd4055fa5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUpEQ1VXTjVXeVcrdXo4LzM2QnhzRFkzVFUxNzZwa1FrbUswRDZwSzg4Mjdz?=
 =?utf-8?B?T3BFWVhjRXhzTTlyV0daQTdqZGhtZjd6bE9ZeTNpcStGY3JmK2FLOU8wS2N6?=
 =?utf-8?B?UHU1TEhsUllCMXlwSG1rNHd3Z2dZYU9QVzhYMnNJejNwU24xVlVuU1EvUENk?=
 =?utf-8?B?Z3UwY290WHJUMEx2ZjNVN3lFbzFQY3UrN0VlbVkwaDhMVmRadklsM3c1U0lw?=
 =?utf-8?B?VlZkcUlHbENKS0lXWno4VnFndEJZNktLWU9Jano3UUVVTC9tMVpKeFpWYUNF?=
 =?utf-8?B?OCtzMVl0NW5HSE5QWVpFY3lha3F0dlZCYlZpd0V6MHJnMmwvbkFpQlU1MEhj?=
 =?utf-8?B?bk81T3JndmVEWlZzdlhEYWdHbHlNZlhDcy8zQ2xiM2dhSFZzT0hZZlBEZjMv?=
 =?utf-8?B?N0syWWV5SVRaNHNJL0tLWVFybjdjd1d6UVdTY01qTlVCNGpSclRtVFd2NmN6?=
 =?utf-8?B?UWtHODZ4eXZsTjNNelpieXJZdldmd0tzYzZMVTlMejVOZDN4VTF4SElJMUNR?=
 =?utf-8?B?MDhNVFl5amFSNnordjJ0ZE5aZjRUNlNEd3BWdUZpcmhha2FsOEVhMDZqUnRn?=
 =?utf-8?B?Qm15WWdiOVBpV0wyVEpIT3Z4aVMrQzFMd2IzbHBFUXJJY21taTBCM0xVdFRu?=
 =?utf-8?B?eEFUdldMbEo0Y3RNRFVKOWQyTW9ReXBZWnQ5OWJIMVJaY1ZXaXptN2VJcXJs?=
 =?utf-8?B?WTNsand6VHdXNGlsVjUyRnZuL21SUnllTi9FSlR0Ym9DWmxqMkZ4SnZ1U1p2?=
 =?utf-8?B?Q3AyYXB5THFOaWw4QVlQeVpLOE1ZK2sxZDl1eDNQN0pEZ0ZjTUwwb09ONzl4?=
 =?utf-8?B?SFJRc3Q5V2J2b3h4MjFqeVJlNUxLNVpSWjJjOG5CUEtMcGlvaXRRYWxvVG5a?=
 =?utf-8?B?VHhBQ0tNM1BmeVRNVXBCdUg5UXM1U1dFTGtEelNvTnFjbHg2cHRRVGo0dmRn?=
 =?utf-8?B?YXJzZjh5TEVna01hWERQN0FuMFpJdVRFUHl3MjJOUGx0OWZtcWp3TW4zRzVm?=
 =?utf-8?B?aTRRZGRUdEtLblpvak0reDNHa3UvMzhOTlFzYi90R1NGSmwva0Fta2YwcHhZ?=
 =?utf-8?B?THoxRVRXSGZ6V2trR0U1QXlMS1hhZk1rZVR1SDVpdWZ2NVFaaDBhY0NFc2xm?=
 =?utf-8?B?THhvWGdaN2JDYkdMQ2Nvazg5UDFTZ2tNeWlNenFab1NmRGM5c082czNYNDhi?=
 =?utf-8?B?Tk9mMENUZGxVcUcwYUt6K09kdFlqT0R5U3Y1YWhvaUMzdEY5V2NBbmx3Z0py?=
 =?utf-8?B?Sytyejk5ckZXaUJrUDBXbjJ4VDZBNUlRdDdBOWVFdGtrNWRsdzE1dWVpK0k4?=
 =?utf-8?B?ZDFma21ZbnBjZjVQaEdMaldWa0l3RW5HSW1SVGZmNFc1cXN6WTgrVUl2andz?=
 =?utf-8?B?ZVZLYzczdTVYWEJ1Vi9FTWtqbksxUG1RODhNTWZTVEpDSFQxeU82Mkg5RDBp?=
 =?utf-8?B?cDdXRHR0L2dON3dOaFVUa2YvWFJFYXkvelF5cHF1ZzdXVHVZTEhsenE0cWxn?=
 =?utf-8?B?ejhZRWhVK0M1WGZSSHVwVHZiRVpCbk9oS0trd09NS1Q5SE9WdlpTNG00RTc5?=
 =?utf-8?B?YXV5WFhEeStRNTlMUDdMZFU3eE5OWkpzeGZQaEJ6eWlzRXBORFFFZnkyWno4?=
 =?utf-8?B?SFdoZDM1ZTMzMStzb0NSYkpRYnNKdkN0UFE3YlIrRS9xWFN1cGtXU2pxRnVo?=
 =?utf-8?B?NFVtZ2J0UzV0aUp2NkEvNDhPbjVvYjdCMVJVU1lJazRzUTRWcElxQ3pqNlI3?=
 =?utf-8?B?SzZnSzQ4L2tSNGtSaklMUkJhVjZoSFlRWjVtUWUrYzZZNndodUtIZkswWXdz?=
 =?utf-8?B?bGhYcmxQWTgwYkZQSTBiQmtuQlJ5Qkova0g1N0t2N0hYakVNUHBiRlpZLzlY?=
 =?utf-8?B?cmpuekZlYVFOa29PWENiaE1ibVhSd1V2UjY2VWtkWlhzMU1XWm5saklwcGJy?=
 =?utf-8?B?SUIvUUgrSVRRYUFNMnBMTFVqUUFNcGNnc0ZKeDVRVVJxM2gxdWtLeWowM2R3?=
 =?utf-8?B?SW1sZzJWemZFZUdoZDc0SHVuM3hLS00xdUdBNlRocVIvUUhCcm1xU3BvZEp4?=
 =?utf-8?Q?YU9iCd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 11:13:37.1346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca502889-52d9-4dba-9194-08dd4055fa5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573



On 21/01/25 14:14, Beata Michalska wrote:
> 
> Now that the frequency scale factor has been activated for retrieving
> current frequency on a given CPU, trigger its update upon entering
> idle. This will, to an extent, allow querying last known frequency
> in a non-invasive way. It will also improve the frequency scale factor
> accuracy when a CPU entering idle did not receive a tick for a while.
> As a consequence, for idle cores, the reported frequency will be the
> last one observed before entering the idle state.
> 
> Suggested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>

> ---
>   arch/arm64/kernel/topology.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 5f5738b174c7..6c43aafac77c 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -213,6 +213,19 @@ static __always_inline bool amu_fie_cpu_supported(unsigned int cpu)
>                  cpumask_test_cpu(cpu, amu_fie_cpus);
>   }
> 
> +void arch_cpu_idle_enter(void)
> +{
> +       unsigned int cpu = smp_processor_id();
> +
> +       if (!amu_fie_cpu_supported(cpu))
> +               return;
> +
> +       /* Kick in AMU update but only if one has not happened already */
> +       if (housekeeping_cpu(cpu, HK_TYPE_TICK) &&
> +           time_is_before_jiffies(per_cpu(cpu_amu_samples.last_scale_update, cpu)))
> +               amu_scale_freq_tick();
> +}
> +
>   #define AMU_SAMPLE_EXP_MS      20
> 
>   int arch_freq_get_on_cpu(int cpu)
> --
> 2.25.1
> 

