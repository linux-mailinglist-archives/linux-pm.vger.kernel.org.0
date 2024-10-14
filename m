Return-Path: <linux-pm+bounces-15628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CAC99D5C7
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 19:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F60286138
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 17:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E02B1C6F70;
	Mon, 14 Oct 2024 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eoA8t1oH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE313A25B;
	Mon, 14 Oct 2024 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928022; cv=fail; b=NkPSCn1GvwOQP50n02aq79i9d5HNB6y+ojr7YZZMrGLFnA8g8Rxxr7dypSmN4S98Xad6wntZT8pbH990UHVFW8KnG16FVGjUUzWNyxN0N4f0j2WN/RPsYLSDmB4h3EFQzcrJTRYLYDtb6LutD3+OpxX29eOJRqP2BGSmzL6Rs2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928022; c=relaxed/simple;
	bh=H10RPkvlnN80DWqFx9fuwgAispl3GRlDV2+3fXHMU3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CfnKrL9u9JnMEkpDheYfrc31cyMf1MKznW5g5pIyUdAk0YnEkKvLhg9qMRBnntt0rSVLp5oYcmLrKhjROtfDa7re7s/qDP8x46jP/2dEw8FX2knwU92q5VVmjk3jd5BZQpKovKIUe459zRNXGkSb6O0ynX5zq480qLOhy8u2Klk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eoA8t1oH; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJWxGoIVbac4App+H2poiYG1LpC9Yy4A/iweWXQ7PB+K7QfYci5cUOPCkY2OvPsA4zU5HVNd2tZWUlIHzf6mShLlBEev7faIeFWct4v1aISuYHAZs1BLQNeYKoHqdtn0mUIPbSLEa5bputMX0DtrMX5wXTmYw4d4SodChn9v7UkgFbWenlUufmfLV7d0Tk1ZNuyoJpqNMI7p9oiu/ya1JA3QnvqZc1UVbBBnTyCAWqPdRbmX+WQKXHuzsPOzgtyJWjjYom45AYbFehvblIjiCU5AERPEob0dvBVw3U2xiYQAqUyjSchDCeg6nxd2mD4A3ykxXRQRjB9/W9V7rGn8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMLfFyeVfKkYqVwk+CnDu4cyTe0Lg1X8WSLTpvuFMKg=;
 b=hzP8axcWatbqJRTY1+Fa4eBYrThR5xYvMz8sJuvLYRGy0Wwo42tZy2dXIVNV5Y8UrheqAUY5CUNzhlnkvPvp1v1DWFPX+UdboB5QTe6Fhi5sTfGtBvGzgV4mCmHWpRR9mq5avE6GdInzg4989q+m2+Qm37RA1QI2E7hdITlq6aaqaXZlszACZLZmmMG1HWCL4AYP1HYATSXMDre2Tyt21gadlh/Pavbd7bkUq2bFEXNv9osZ18LB4hWEBoU/+rE5RI+i1dHT+kh02U3mdWUSGeUSn3GRRA3YhGr++IT0TTivw5UaOFBONUpeA+Il03OQ/gMr8sryOXDi2A+1uWp4LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=os.amperecomputing.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMLfFyeVfKkYqVwk+CnDu4cyTe0Lg1X8WSLTpvuFMKg=;
 b=eoA8t1oH05DXzo6MWXqPWndKtnHiYAQgaJtPP9NzBGbUjn7pYFnLcQpBNtx3D3/TrjKROAAffAHb90V8BD8clJdB5rU7gUmvOQlmrtuHBqHltPc0F/L+btiT5DFK4CO+0o8ndOVa3T+6phBZCO6Yk0W+oHiHNDT8fD0aE+r2iEf0OKdJ6ALL5DbUWZ/iKDidj2oKbKEcPtx/a/91SL/77CPucYG3yHV0hRU6t6zmCLbPcN2t6f6CAMuOU0EI1BF2yTD7eRHCLRSLtkU692iqOqTsQ51AyQHVvwKck9vml1562O1VhRdb8drLNJ8wps0IXl0r2aDruS4/Cog1TfE90Q==
Received: from SA0PR11CA0181.namprd11.prod.outlook.com (2603:10b6:806:1bc::6)
 by PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 17:46:57 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::99) by SA0PR11CA0181.outlook.office365.com
 (2603:10b6:806:1bc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Mon, 14 Oct 2024 17:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 17:46:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 10:46:44 -0700
Received: from [10.41.21.79] (10.126.230.35) by drhqmail201.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 10:46:39 -0700
Message-ID: <a183068c-9244-4448-b81c-d1c0556bd43b@nvidia.com>
Date: Mon, 14 Oct 2024 23:16:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] arm64: Provide an AMU-based version of
 arch_freq_avg_get_on_cpu
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>, Beata Michalska
	<beata.michalska@arm.com>
CC: <viresh.kumar@linaro.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<ionela.voinescu@arm.com>, <sudeep.holla@arm.com>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <rafael@kernel.org>,
	<yang@os.amperecomputing.com>, <lihuisong@huawei.com>,
	<zhanjie9@hisilicon.com>, linux-tegra <linux-tegra@vger.kernel.org>, "Bibek
 Basu" <bbasu@nvidia.com>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-4-beata.michalska@arm.com>
 <aa254516-968e-4665-bb5b-981c296ffc35@nvidia.com> <ZvU4mR_FZa7jXUgk@arm.com>
 <ylcfqw4swz6xjxxfoyljyifs4ibbueywogqxusxfz3a3fgh3du@cfaajchbwgvn>
 <Zv8PKlr_PJgxazro@arm.com>
 <5y3yz2ct2o42c53dc6rwpse3andstjx74lowt2b3hohj4ogbct@nu2szdnxvxid>
 <Zwe1p0La_AFknglf@arm.com>
 <evllzzjufritriziohz22gm5qs44jedpft5lcfjfwnekarqtdx@eg42ik2l7bxu>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <evllzzjufritriziohz22gm5qs44jedpft5lcfjfwnekarqtdx@eg42ik2l7bxu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 drhqmail201.nvidia.com (10.126.190.180)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: f13a06f3-9527-4c7d-4b16-08dcec7832a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmVyelU4U2pVSWY0S2ZEL2FZbkJVSmkwZDh6MXc4T2NpQjNQTlVjdHZ4UzZ5?=
 =?utf-8?B?WVozY2JkZHJSaTg2aDIvZ0p2c0lPcFdvM1dpdVUwUG4xTjF3MlBYd2pqa096?=
 =?utf-8?B?T0YxM1F5UzQxMnZrdWs2c0tQR3NIVE5tKy9YUmxpMVA3M3JiR2R6ZGt6dVBo?=
 =?utf-8?B?UlpGKzdBWUZ4OGJpZUVDUk94b0tRaTVZSVRUNDNIdVA1Y1IzeW1QeFl1Y1VS?=
 =?utf-8?B?UUkwVGlwY2toLzhScU53VWhnT2lxWHN4QmNudzFHMnUraDVUTDBKSDJxM3Mr?=
 =?utf-8?B?c0FJbXNDNElQL3FydjJzWmFFWkZwdjFmaDhETFg1Nm9DU0tkUUxTMVg3bHZD?=
 =?utf-8?B?TlRxK0tzNlBGWXFMaTlIM282OFJZMzRtRGdhNzYwYjN4SVFzay8zMzd1Uzdt?=
 =?utf-8?B?VlE4OTRCcDZKVGk5YWhma1NPaWxQUHlZbUoxSEFjV1dJQjRWVmRqUERyQ3Jn?=
 =?utf-8?B?RzZ6SG5CcTJrUndMRExOZ0QyclRXaythUXVtOFlPVnFNbmt1bEpWT3A3MXgv?=
 =?utf-8?B?VHBNSGhpNWlFNjlpNFBRZDVnaWVBbTU0M2NhMlhiRlFpMzNvWENnaVQ5aWli?=
 =?utf-8?B?b0k0QVBybDFkL240Yzkxanl6dHN0REh3T3VIaDFUWWc0TFdkVHNxOHhuR2Mx?=
 =?utf-8?B?QTBsT1hTU3dDUDNKWXNXTlRhK21jTnZQYnFrdXNXNW9NZXRtQnpKWnZ1NkJ5?=
 =?utf-8?B?OWFVcWJwWUxuTnNnNkJreTNKK3NxVUIvVEpUT0cwWWxKcS82dml5K0tFZ0JQ?=
 =?utf-8?B?cmVuOTMrSldGN0RpN04rQmk4RzU2eDlURUhjMmFzVW9VVnJCNjZnNGVuSVNY?=
 =?utf-8?B?Wm1oNjZDWGRMalhvRU9xRno3bXdndzJPZHc3aWVqYlQ4QzcyWVlGV253WSsw?=
 =?utf-8?B?ZmJPN2NpK3FVKzRGVFBaVFh5WDVyekdBOUhBMXFhMnBJb05YdCtPWktNSndT?=
 =?utf-8?B?SmlxcThPYjVyRXFObU96OXBjenhnYnFGRGtQdFd0Mlh4aEFyMWVWNzI5Y2g3?=
 =?utf-8?B?Mml3TU96Mi9IZjN0V0FRVUd1akxmbTVFM2FrNHhsNm9yUzltckdQM091MkZr?=
 =?utf-8?B?d1Bzb2J5TUJsYnBlbmJhSi9CZTFsS1hvT00vRlNkUkVFcWhJS1U4UElHYllm?=
 =?utf-8?B?UEp2WXB2YzJxeStIcVdKNkU5WlZxMVkzNXJRS3Fwbk5xeG9sY3NuNjNYWFE5?=
 =?utf-8?B?S1crUzNDekUwNDhTc2ptMEJGQ1NVYkpOWk9pblFYUzNUUHJhQ0hGNWxNaVlz?=
 =?utf-8?B?T20rbE56UnhxVFBnTzlhOUpKS0RYVUQzNTZBT1o0Z1hCdCt1U1FKRjBvblM5?=
 =?utf-8?B?TURUY0dNUmVJOUUwSkhRbDRkdGJLT05nQXNzcm5lM1FCbkt4VlNIcmY4eEtk?=
 =?utf-8?B?N1FUVmJNb3V2bW9jRVJvZWxmTXY3MWtKVnkwSkxpTFV1N2E4aFhFVXlUMlRt?=
 =?utf-8?B?VDd3TDQwVGRQNjl3L0RlU2pkN2JKV1ljYThmOGNqVjZOcDlsSHYxdHFyMlpB?=
 =?utf-8?B?SXhPRURSR242NFh1VHJabjVLc3p5ZG1WYndQMWYyUjZXOUN6MnVsSzd0VkJY?=
 =?utf-8?B?TzJ5Ui9pSUtvZWNoYkRVV0NEWkg1c3VqTysralZObzR2ZTc2Wjc3Zi92dmNy?=
 =?utf-8?B?enBoN2VwVURJcnhyVHZETUNuTEwyWXV3andQU0c1WXZQaTZzcmpWdnc4aXFq?=
 =?utf-8?B?aVdzNmlvR0NTZk45TERqdDErWUFVcHMzeHVSL1BydmQ0NW5tQ2p5SXJ4TlR4?=
 =?utf-8?B?VTV2OEo0ajc3cjgwejAzbHpUMU5uNDRRQTVjYm5nUkRCTjBpdjdVMXVUQzlD?=
 =?utf-8?B?aU5rdFdjS2d4di9TTjNNMVlDWHpTbXRXVS9CbWp3citPMVdqalBkbUM5ZWdh?=
 =?utf-8?Q?TDJEX3SYUkNcS?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 17:46:56.8154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f13a06f3-9527-4c7d-4b16-08dcec7832a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125



On 11/10/24 21:59, Vanshidhar Konda wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Oct 10, 2024 at 01:08:23PM GMT, Beata Michalska wrote:
>> On Thu, Oct 03, 2024 at 02:54:22PM -0700, Vanshidhar Konda wrote:
>>> On Thu, Oct 03, 2024 at 11:39:54PM GMT, Beata Michalska wrote:
>>> > On Thu, Sep 26, 2024 at 04:21:14PM -0700, Vanshidhar Konda wrote:
>>> > > On Thu, Sep 26, 2024 at 12:34:01PM GMT, Beata Michalska wrote:
>>> > > > On Tue, Sep 17, 2024 at 05:41:09PM +0530, Sumit Gupta wrote:
>>> > > > > Hi Beata,
>>> > > > Hi Sumit,
>>> > > > >
>>> > > > > Thank you for the patches.
>>> > > > Thank you for having a look at those.
>>> > > > >
>>> > > > > On 13/09/24 18:59, Beata Michalska wrote:
>>> > > > > > External email: Use caution opening links or attachments
>>> > > > > >
>>> > > > > >
>>> > > > > > With the Frequency Invariance Engine (FIE) being already 
>>> wired up with
>>> > > > > > sched tick and making use of relevant (core counter and 
>>> constant
>>> > > > > > counter) AMU counters, getting the average frequency for a 
>>> given CPU,
>>> > > > > > can be achieved by utilizing the frequency scale factor 
>>> which reflects
>>> > > > > > an average CPU frequency for the last tick period length.
>>> > > > > >
>>> > > > > > The solution is partially based on APERF/MPERF 
>>> implementation of
>>> > > > > > arch_freq_get_on_cpu.
>>> > > > > >
>>> > > > > > Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
>>> > > > > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
>>> > > > > > ---
>>> > > > > >   arch/arm64/kernel/topology.c | 109 
>>> +++++++++++++++++++++++++++++++----
>>> > > > > >   1 file changed, 99 insertions(+), 10 deletions(-)
>>> > > > > >
>>>
>>> --- snip ----
>>>
>>> > > > >
>>> > > > >     ..
>>> > > > >   freq_comput:
>>> > > > >     scale = arch_scale_freq_capacity(cpu);
>>> > > > >     freq = scale * arch_scale_freq_ref(cpu);
>>> > > > >   ----
>>> > > > >
>>> > > > This boils down to the question what that function, and the 
>>> information it
>>> > > > provides, represent really. The 'unknown' here simply says the 
>>> CPU has been idle
>>> > > > for a while and as such the frequency data is a bit stale and 
>>> it does not
>>> > > > represent the average freq the CPU is actually running at 
>>> anymore, which is
>>> > > > the intention here really. Or, that the given CPU is a 
>>> non-housekeeping one.
>>> > > > Either way I believe this is a useful information, instead of 
>>> providing
>>> > > > stale data with no indication on whether the frequency is 
>>> really the 'current'
>>> > > > one or not.
>>> > > >
>>> > > > If that is somehow undesirable we can discuss this further, 
>>> though I'd rather
>>> > > > avoid exposing an interface where the feedback provided is open to
>>> > > > interpretation at all times.
>>> > >
>>> > > Would it make sense to identify that the frequency reporting is 
>>> unknown due to
>>> > > cpu being idle vs some other issue like being a non-housekeeping 
>>> CPU? Would
>>> > > returning a value of 0 make it easier for tools to represent that 
>>> the CPU is
>>> > > currently idle?
>>> > That is an option.
>>> > Another one would be to return an error for those cases. This would 
>>> make it
>>> > easier to distinguish between valid frequency &/| idle CPU vs 
>>> tickless CPU
>>> > (EINVAL vs ENOENT) ?
>>> >
>>>
>>> That seems like a good idea but I suspect it would be confusing to 
>>> the end user.
>>>
>>> If a user runs `cat /sys/devices/system/cpu/cpu2/cpuinfo_avg_freq` 
>>> they would
>>> get an error in some cases or get a number in some other iterations.
>>>
>> That is a fair point but I am not entirely convinced using '0' instead 
>> makes
>> things any more clearer as this is in no way a valid CPU frequency.
>> As long as we document the expected behaviour keeping the interface well
>> defined,  both options should be fine I guess.
>>
> 
> Another option could be to list out the reason as 'idle' or 'no entry' 
> instead of
> returning EINVAL or ENOENT. These wouldn't be valid values either but 
> cat on the
> sysfs node wouldn't return an error.
> 
> Thanks,
> Vanshidhar
> 

Ya, listing the clear reason sounds better.

Thank you,
Sumit Gupta

>> @Viresh: what is your opinion on that one ?
>>
>> ---
>> BR
>> Beata
>>> Thanks,

....

>>> > > > > > +               cpu = ref_cpu;
>>> > > > > > +               goto retry;
>>> > > > > > +       }
>>> > > > > > +       /*
>>> > > > > > +        * Reversed computation to the one used to determine
>>> > > > > > +        * the arch_freq_scale value
>>> > > > > > +        * (see amu_scale_freq_tick for details)
>>> > > > > > +        */
>>> > > > > > +       scale = arch_scale_freq_capacity(cpu);
>>> > > > > > +       freq = scale * arch_scale_freq_ref(cpu);
>>> > > > > > +       freq >>= SCHED_CAPACITY_SHIFT;
>>> > > > > > +       return freq;
>>> > > > > > +}
>>> > > > > > +
>>> > > > >
>>> > > > > >   static void amu_fie_setup(const struct cpumask *cpus)
>>> > > > > >   {
>>> > > > > >          int cpu;
>>> > > > > > --
>>> > > > > > 2.25.1
>>> > > > > >

