Return-Path: <linux-pm+bounces-19284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9489F2C01
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 09:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0643F1888845
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 08:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E180B200121;
	Mon, 16 Dec 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FzHmcwol"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD2D200118;
	Mon, 16 Dec 2024 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338023; cv=fail; b=sMw67bKWTUrLJ3/66kXeEh+4nz81AoF+ctw4iRHqFC0SSZaw/zv8b7XTlh4l/a1lTmpMOeAz1SE6uhdgNS64SoYV4j/DcBKWApVZGpO6Raqg4iufiqY2DhJPFAqlTCRDF06mZiqN6QFxqtDCaS2VL9t3bDqfNUgLUi/X6ULu+/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338023; c=relaxed/simple;
	bh=VTDxOn+dcpK8K2Z1uGrNV2NpwnjDd0XYcLuG5Qk7zKc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QN8XRYifDSZtSdSZ6EdBLakabnU6WoRpJQYsH4QjTppcb6NyqG1flCjQUEc07CW5DuAJhRwNqenMAg5EcDKwsc9P9GVTXMLx7JRp2/5ipTWbg/52sZRbck7nIKmq0HTFuuAFdMMVmjgQmZlB3SMb8iS+aHEV5ibz+r1HB2kgzp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FzHmcwol; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvNIKSzo85OIHaTf23BxiqodbNXeYSmc3ydArCqeXsr4VN6L57biQ4l63oLpj/bufhZlSvRPr7uCrLL5HyVjlNhl/B6NWR33XinSKy1rTx9Wdo4zuceJ9XImHBZ5I1J9C96RhuZIaRJQTprCov1+1MALFsKo8dm/ozF7M57kswdlkRaIu6IE8E0ojwdeyRBfsPkkJHozhyWH/FKVNjHfq68v9gD5uvnR9w0viwSSH/hA4KO9cqDT05cXeqDDhtXuh/ofdZkrbGAGC8ncSPu2388RPvXj/swzIGFY7+WHYs5frawuyK/L9ia1mkdhm7SLzGIrhEOE4d8By+J0iwbgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuNAjqKjwyKGK8IG0c/K3orojS5A+QV4EKg8bq93ExY=;
 b=fQt2JtEWOsf7tOJ6eSWHAGzxoygWmxcDcV/kiplCpaI8mTKOdp6T1XGuIi9qbmOXvpx3e2HqfaUgKof1IfqpmRD7Qrinf7oQJsOrNFzmZXG8DMhm3zqudgRvk5toHIHeN3TsCMsdvsk2FyWpsXIPuAGGohPoiuqaoaZD0al88PpQp8s5KvECV6xbj0BqUtVu2WYVvagqnai0XW6NavdIvnn2u3l7JUZMVgUb07adh3lQiBLhHJU+7V+NAIxHR59pnttUbQhLxEp0vr7AeR4g2C0M+Dw4Ukaid5Hg/LbWlRGyuIot+oEHkaQQUi52PvmaaT2mWJnJIcfU9pypexpr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuNAjqKjwyKGK8IG0c/K3orojS5A+QV4EKg8bq93ExY=;
 b=FzHmcwolkm2AH8NGR87VYUg6LQjomTaPV7MwBdETM78aiE0c+jirdyGrmByIUiGNtDrmGqXpZ+aI8h3oboxngEiLXmke60KSgK8+XU+q4aNiPSzIEczCD96dr8JAJAFikkufjX3fBUcZoa01xGRD2YRmsnGSKkCDQ0TWp5CCecytolxXqP/HESxIgdQwPu4JA+wmA+HZmF4nI94loDVQF5wShqkAO4JP4JN5Wsf8y2bFCTjd1kw8YoL3YK/DpkUVATRggrQn7Kl/JLZMRQsTetXbICJX/wWNt6F36w8QKJW7MRHsETs3Wf4WFF5mmbw5Ue2KfBHxE8JFj2WmFy9dXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 08:33:37 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 08:33:37 +0000
Message-ID: <e3284392-4f57-4b5f-a79d-40b588e6c70e@nvidia.com>
Date: Mon, 16 Dec 2024 16:33:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
To: Sumit Gupta <sumitg@nvidia.com>, Beata Michalska
 <beata.michalska@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
 catalin.marinas@arm.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc: yang@os.amperecomputing.com, vanshikonda@os.amperecomputing.com,
 lihuisong@huawei.com, zhanjie9@hisilicon.com,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Phil Auld <pauld@redhat.com>, x86@kernel.org,
 linux-doc@vger.kernel.org, Carol Soto <csoto@nvidia.com>,
 linux-tegra <linux-tegra@vger.kernel.org>
References: <20241206135600.4083965-1-beata.michalska@arm.com>
 <20241206135600.4083965-2-beata.michalska@arm.com>
 <3f19c5a8-9ee6-42fe-8b4c-3a66c65c8d35@nvidia.com>
 <955a7947-3053-490e-a803-d55699dddd0c@nvidia.com>
Content-Language: en-US
From: Kai-Heng Feng <kaihengf@nvidia.com>
In-Reply-To: <955a7947-3053-490e-a803-d55699dddd0c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::10) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e8d5a4-95a8-471d-6d46-08dd1dac5594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFUzTm9WSzFLcmJKQzVXUUJ2R2s4Q3hKT28zRVdMeWREQmRTNU8va01zQ1RD?=
 =?utf-8?B?N2xTVXoxU0RoZUovT3JSV0FlUk9PZnA4Z0Z1ZjljK1VUY1J0RE4wYm5tQmQ2?=
 =?utf-8?B?N0lnSUI5aE9vYWJ6MjFwaStyRFdDejdwbTZMN2JwUnpjOTFSMERRL1ZrUzgv?=
 =?utf-8?B?Vm01RE5Hb0FQaGNzVWFGbzN5cDBlRFVwdXBoVU0zMVB1bUtPK3UwbXNzL0lX?=
 =?utf-8?B?MGlvS2R4eG5ZTnBoQ29vbnQ1SWk0MERFMTFCQXRPQmtQQ3Y4ampObEgyQTNB?=
 =?utf-8?B?NGQ5YnJOSHRFTmVsOWtsMWIwY0VWSXZLb045eHhrVzRCck9HTzhpTGUwaGJP?=
 =?utf-8?B?eUxkN01pcmVNWjQzbCt4NS9WK0x6OW5qczNBUW5reEVya3E5ZDlibTJCQklv?=
 =?utf-8?B?V2dYZlMvZ3hxeVFhcXB2NkdDS1pLTmxIdHNrZHFhL1grQk1NMk5mY2hrMERB?=
 =?utf-8?B?MUkyeXYrbXdOdTdLa0xPU1pFR2x6QTArdTlncTdINHF4a1BIWU5xODJ5bTZa?=
 =?utf-8?B?NmtZNFZKQ3k2NE4yR1NZOHdqZmdBRTB5aWNIOWpTdGxBSVhhQm5RbHZlRHdl?=
 =?utf-8?B?Wnd5dG1KMW9QNUVkaHlzbExzMWdjZEVpN0R4VnNuYjVLbGJvdGJZRGpEcW4z?=
 =?utf-8?B?UVdsbVU0bGhOYVFFb3FBa1M0SzkydnFQYzAwTTdyWEczMVB2ZEdyT0plY24v?=
 =?utf-8?B?d3hmWWVod1U1bjdDK0dVL3Via0JKQmE5OFExQzNEWEtPYzVMRFZ2bVRsd1Yx?=
 =?utf-8?B?eVZxOXl0UDk0Vk1TMnM0RDBSa2tiMU5sbk12T3N1dmhsTUc2MytkdnI0Y3Zh?=
 =?utf-8?B?dDdZZkpONStidnVVcVVvbllpK1dYT21xaW5Na29CdE9xVXpJUUE0YUR1SWp5?=
 =?utf-8?B?RFJ3QW5aVEJPZFgwN3lQN1JQdlowUm9VMStyazIvWnRFTDhRUDZncGtLZGJl?=
 =?utf-8?B?QXNDNCtONUhBK0gvczhlaTI5VTJ0amJvNDEySWRnV08weENqS1ppQnJIYmZ3?=
 =?utf-8?B?OHUrTitUUy9sOU9VWVdScjVvR0liTUFwUWJDRVpuSmxwMXQ0b20zZFVPUWpB?=
 =?utf-8?B?TjQ0clhhNzJIMlQ0ODFOMzBEM1B2SHdGdEZvakZnRHA4dEFUWW5PYUNFTjho?=
 =?utf-8?B?L3lDL1BJYmNTcHFGZjZyc1FVRk5vczYzZFdROEk1eU9nb21OMURIdXB2R0dF?=
 =?utf-8?B?MVAvTkJFcmdsUVRqY0JmVVFLdFhRY24zQVJTRFc5aHRLaGd5YzB5Tk0xalFq?=
 =?utf-8?B?SnRtVFB5OEtxMjBuTU1kYlRlQzVVQXczUEFIekU3TXk5MTZJRjcyMHRLZnlU?=
 =?utf-8?B?ZjdMTEdoNVFFQkVQa2JqN1pYcXpxOUtENzdLMzJtNVVkU3laSzg4V25laWo2?=
 =?utf-8?B?QThxSmpsR2FJaVRZWkRVZ1RTKytsaTFtZ0w1Z2RhVEI1VG9ubXg5enZNVFp1?=
 =?utf-8?B?cHdLekhWNFNVKzV1M0NmanFKSEVWVitBRDFMaWZ5Wm5VeGRjaURMRUU5M3lB?=
 =?utf-8?B?RU41V1dGcG9GQmNPaUxkcWZqWHJsS0tXbjU3VUdYMW1HT3VEQXYwSS96MEEr?=
 =?utf-8?B?M0ZmOTRqbVZaY0d3bTN2M2o0R0gzVGc5TXd0Rzc3eng2d2V4S3hYVERaRTBM?=
 =?utf-8?B?MmMvSVh1bFdIWS9TblErRUh6U0drVGx4LzMvQzVLdkphS3FQTzJLUk9RM0Zv?=
 =?utf-8?B?SkFaaG83VnZ6aSs4K1RoREF6NGZNS1ZPUG9sQUFMbGlTS2lqZ2l4M2Z5UC9I?=
 =?utf-8?B?TjAwd1E4cUdLQ0dzU1J6NVZhU1FTQVhOL2xMb0k0V0JqaVppTWVTajlEU2Nn?=
 =?utf-8?B?VG12QU5Wc3VETFVDKzRSWXR1aVVSa1JwQUIyS1pOcXR0VW5sRko0ckdCa2pl?=
 =?utf-8?B?NnZoay9ib2FvZmhOV0ZGOWwxb2svNFZsN2hBUG1TclpZUjFWL1IvWXF1NmFV?=
 =?utf-8?Q?nY6x8+Xr1Yk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czhNWElKN3ljcXZqRjBkQWZRNGtacE0vRU1ZUnAyRUpHdmo4bndvNmlXYjZD?=
 =?utf-8?B?MEVlZDZPOXNaQk1sTnpZUm91bENJVkk3SFVoejlqV0ZmOGxLYi9pQll1TDBM?=
 =?utf-8?B?K3pJSUw2KzQ0eUE0SE1USkdBOS9pMFlCd21vNmFlWkFpZE11WHF4ejRLSlZ4?=
 =?utf-8?B?Tm82amlyaUo3SkNXZm1HNk1nTDJKdnRVMVVLU3prUVhGTFpxSG9pZ21EVnVN?=
 =?utf-8?B?ZGJMMlc1c1NYR2l5eG9TMk1iVkhFUGxhQURkemRKSmVrQ3F6WmFLaFFtSXFX?=
 =?utf-8?B?Tnh6WjJSRE5nZlFTaCt4UDYxdFBaTVgyMTcrT25vc1JJYnpsaDJVT1V5S1lY?=
 =?utf-8?B?ZlZXekpMeCtCbm1xY3NwK0U2eHlvK2IybXpycXlDT2hwWGxQVkpBWVdQeFgr?=
 =?utf-8?B?dy9Jbkd6NGozMDF2ZFBsV0l5Zy9sTHNVMlpRUUM0NzFWaUZFSmFQUnF1Uzky?=
 =?utf-8?B?T3pJODhSRWoyT1BGNTZxL0tBSTlZRTZ5ZjlxVS9DZER4U2UvOFhSdm82cWhO?=
 =?utf-8?B?TGU0dWM2dlZlZ0dyTlhFWC81S1FpODlFbkpCVFhBQXRFdktWL2Y2KzdvU2Yr?=
 =?utf-8?B?Ky9jTnFWdjBYMlhBYUhsTUI3bnh2RHVmRjZPd1FiUWlwNlVQS1dWUzk5R0tx?=
 =?utf-8?B?K3hVc1lWRVM3ZTFCZ21jdyt4SUZwVGo3KzUzcVFpektVRkJqbGlmNWQ1Y0J4?=
 =?utf-8?B?Z0RhdmlmcmEzWkZYNGpwVm5PalFmZ2J3dGxEQytvM2VvNW9pamtBMWhVNXpJ?=
 =?utf-8?B?ODJIUEw1a1c0ZVg2TSt3Q2QySldnR1pNeU5LTXh3QUdmNDFZbVpVUGhKQnVN?=
 =?utf-8?B?RlZodFYrai8rS1pHS1BQeG1LWDRYdkE0LzJ2OE1IcHlVdGpMRjRsaWpSdkdY?=
 =?utf-8?B?ZklCWlJaQzR6TTBpRmtoQmNZd1lNdmZxRjllV2ZUVGNsNVJKcUJESCt2clJp?=
 =?utf-8?B?OVBWTnZEaFBPT0dPZnRYdk9zalA2ekZRRzA4NGtlN3ArK3NCVVdpNGJwRVdn?=
 =?utf-8?B?RXpYS1hoMXZlS0ZjKzNlaVlicnhUanVZSDRQSjRuM0VkWWtJZHZNMTNsS094?=
 =?utf-8?B?VHZWOGZ0UGlRc01DYlV2Z0FpbVRDOXJ4Q1IraWI4RjhJRnNqMEJBQWJrcUs3?=
 =?utf-8?B?RDRCSDNJUHh1S3BOTnduZUpnTStTaE5FY2Q5bWI5bkQvenpqaWZtZitmYXBR?=
 =?utf-8?B?TVVDQjlDaUpPcm1BQjJqcXVKU1FodEo5VUI0WG1ITWxVb1gybENQWDhBRXhH?=
 =?utf-8?B?Y1dXL2pnYjIvbE5hUm5HdDdnbkRFNXMra2d5a0krSUlPVUxYZTJsdmJNUDB4?=
 =?utf-8?B?dXhCT2FQaWg3d3NVeGNPVVptUWt6UktiZlVqNXpWc0U4SU9JaFM1UWVIQUVj?=
 =?utf-8?B?VGZWdXR1Zlp3SXFRWStPQ0s0R0N4akVicmZNRUtUdmNrUGhVelF2dURGTTRG?=
 =?utf-8?B?MUUrQmh6ZEEwTW5mZUMrVjRMWnlrckN2MFZrVHFUeEErRTU1YVp0d3hTNGdS?=
 =?utf-8?B?YlZMdHdKc0lRR3ZiZit5bkIvL25iL3BucE8yMGVUTmdmZDdYUGsvVkd3YXN6?=
 =?utf-8?B?dlBJUC9NZmYvdVVGdU13U21IN0JoeDh1QzVhbmJLcXhqVVhua0NjNlNWZWo2?=
 =?utf-8?B?V0hQbE9nc2lWTEZ2ZlV2M1owdmIyRklMb1phR1F6T2doa1VmRHlWUXV5blEx?=
 =?utf-8?B?MjEvMTVQbTUxdXdXNytIMjU1OWRtUFB3d1VMY0pmTFhhUUZNeGNCRTY1UUtu?=
 =?utf-8?B?bC84WVpNNUh5VFVSdXFYaURsR3NtYWZKM04yTHBQSWgxdHYrYzZLMVNWaFBq?=
 =?utf-8?B?Y1ZjdTUzV0NQc0ZWdDVJd3BBYmZkRVBpUmpXODVvYVlMZGkyNS8wUytwS2h2?=
 =?utf-8?B?enlnS0hYbVI0VjhCclhUL0MyTDBuRkVramlCNktzaFBhckd5T0psWDg3b1Fj?=
 =?utf-8?B?aDhyVXc2bGtsLzhwdFNSS25KaVVpUHFFUTcvb05PaDdVazhSU2hDQjZYZjIv?=
 =?utf-8?B?bDJvcmNsK2pXUlROZnJKQndya3ZoSXhjTUE1NmdOcmxWWDh3WEw5ZkJlSmdw?=
 =?utf-8?B?LytjTmZDU25iQmdFNWlpR0FzREI1bURUUGFzV01iR2RGRVZvYmxzVjRBVTJo?=
 =?utf-8?Q?5Jlateld/fQI8pkiCbeyE27Go?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e8d5a4-95a8-471d-6d46-08dd1dac5594
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 08:33:36.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQKlKlNZamTdsKVrWt4vOfjEjTFUdoYuLrjszsQQKmigqDMjnRYBsDvTrT1zBR3xvI1jJ4N6OSFdb+CnBZjSHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855

Hi Sumit,

On 2024/12/16 3:11 PM, Sumit Gupta wrote:
> 
> 
> On 16/12/24 11:13, Kai-Heng Feng wrote:
>> Hi Beata,
>>
>> On 2024/12/6 9:55 PM, Beata Michalska wrote:
>>> Currently the CPUFreq core exposes two sysfs attributes that can be used
>>> to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
>>> and scaling_cur_freq. Both provide slightly different view on the
>>> subject and they do come with their own drawbacks.
>>>
>>> cpuinfo_cur_freq provides higher precision though at a cost of being
>>> rather expensive. Moreover, the information retrieved via this attribute
>>> is somewhat short lived as frequency can change at any point of time
>>> making it difficult to reason from.
>>>
>>> scaling_cur_freq, on the other hand, tends to be less accurate but then
>>> the actual level of precision (and source of information) varies between
>>> architectures making it a bit ambiguous.
>>>
>>> The new attribute, cpuinfo_avg_freq, is intended to provide more stable,
>>> distinct interface, exposing an average frequency of a given CPU(s), as
>>> reported by the hardware, over a time frame spanning no more than a few
>>> milliseconds. As it requires appropriate hardware support, this
>>> interface is optional.
>>>
>>> Note that under the hood, the new attribute relies on the information
>>> provided by arch_freq_get_on_cpu, which, up to this point, has been
>>> feeding data for scaling_cur_freq attribute, being the source of
>>> ambiguity when it comes to interpretation. This has been amended by
>>> restoring the intended behavior for scaling_cur_freq, with a new
>>> dedicated config option to maintain status quo for those, who may need
>>> it.
>>>
>>> CC: Jonathan Corbet <corbet@lwn.net>
>>> CC: Thomas Gleixner <tglx@linutronix.de>
>>> CC: Ingo Molnar <mingo@redhat.com>
>>> CC: Borislav Petkov <bp@alien8.de>
>>> CC: Dave Hansen <dave.hansen@linux.intel.com>
>>> CC: H. Peter Anvin <hpa@zytor.com>
>>> CC: Phil Auld <pauld@redhat.com>
>>> CC: x86@kernel.org
>>> CC: linux-doc@vger.kernel.org
>>> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
>>> ---
>>>   Documentation/admin-guide/pm/cpufreq.rst | 16 ++++++++++-
>>>   arch/x86/kernel/cpu/aperfmperf.c         |  2 +-
>>>   arch/x86/kernel/cpu/proc.c               |  7 +++--
>>>   drivers/cpufreq/Kconfig.x86              | 12 ++++++++
>>>   drivers/cpufreq/cpufreq.c                | 36 +++++++++++++++++++++---
>>>   include/linux/cpufreq.h                  |  2 +-
>>>   6 files changed, 66 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin- 
>>> guide/pm/cpufreq.rst
>>> index fe1be4ad88cb..76f3835afe01 100644
>>> --- a/Documentation/admin-guide/pm/cpufreq.rst
>>> +++ b/Documentation/admin-guide/pm/cpufreq.rst
>>> @@ -248,6 +248,19 @@ are the following:
>>>       If that frequency cannot be determined, this attribute should not
>>>       be present.
>>> +``cpuinfo_avg_freq``
>>> +        An average frequency (in KHz) of all CPUs belonging to a given policy,
>>> +        derived from a hardware provided feedback and reported on a time frame
>>> +        spanning at most few milliseconds.
>>> +
>>> +        This is expected to be based on the frequency the hardware actually 
>>> runs
>>> +        at and, as such, might require specialised hardware support (such as 
>>> AMU
>>> +        extension on ARM). If one cannot be determined, this attribute should
>>> +        not be present.
>>> +
>>> +        Note, that failed attempt to retrieve current frequency for a given
>>> +        CPU(s) will result in an appropriate error.
>>> +
>>>   ``cpuinfo_max_freq``
>>>       Maximum possible operating frequency the CPUs belonging to this policy
>>>       can run at (in kHz).
>>> @@ -293,7 +306,8 @@ are the following:
>>>       Some architectures (e.g. ``x86``) may attempt to provide information
>>>       more precisely reflecting the current CPU frequency through this
>>>       attribute, but that still may not be the exact current CPU frequency as
>>> -    seen by the hardware at the moment.
>>> +    seen by the hardware at the moment. This behavior though, is only
>>> +    available via c:macro:``CPUFREQ_ARCH_CUR_FREQ`` option.
>>>   ``scaling_driver``
>>>       The scaling driver currently in use.
>>> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
>>> index 0b69bfbf345d..a00059139ca4 100644
>>> --- a/arch/x86/kernel/cpu/aperfmperf.c
>>> +++ b/arch/x86/kernel/cpu/aperfmperf.c
>>> @@ -413,7 +413,7 @@ void arch_scale_freq_tick(void)
>>>    */
>>>   #define MAX_SAMPLE_AGE    ((unsigned long)HZ / 50)
>>> -unsigned int arch_freq_get_on_cpu(int cpu)
>>> +int arch_freq_get_on_cpu(int cpu)
>>>   {
>>>       struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
>>>       unsigned int seq, freq;
>>> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
>>> index e65fae63660e..34d8fb93fb70 100644
>>> --- a/arch/x86/kernel/cpu/proc.c
>>> +++ b/arch/x86/kernel/cpu/proc.c
>>> @@ -86,9 +86,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>>>           seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
>>>       if (cpu_has(c, X86_FEATURE_TSC)) {
>>> -        unsigned int freq = arch_freq_get_on_cpu(cpu);
>>> +        int freq = arch_freq_get_on_cpu(cpu);
>>> -        seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
>>> +        if (freq <= 0)
>>> +            seq_puts(m, "cpu MHz\t\t: Unknown\n");
>>> +        else
>>> +            seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 
>>> 1000));
>>>       }
>>>       /* Cache size */
>>> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
>>> index 97c2d4f15d76..212e1b9afe21 100644
>>> --- a/drivers/cpufreq/Kconfig.x86
>>> +++ b/drivers/cpufreq/Kconfig.x86
>>> @@ -340,3 +340,15 @@ config X86_SPEEDSTEP_RELAXED_CAP_CHECK
>>>         option lets the probing code bypass some of those checks if the
>>>         parameter "relaxed_check=1" is passed to the module.
>>> +config CPUFREQ_ARCH_CUR_FREQ
>>> +    default y
>>> +    bool "Current frequency derived from HW provided feedback"
>>> +    help
>>> +      This determines whether the scaling_cur_freq sysfs attribute returns
>>> +      the last requested frequency or a more precise value based on hardware
>>> +      provided feedback (as architected counters).
>>> +      Given that a more precise frequency can now be provided via the
>>> +      cpuinfo_avg_cur_freq attribute, by enabling this option,
>>> +      scaling_cur_freq maintains the provision of a counter based frequency,
>>> +      for compatibility reasons.
>>> +
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index 04fc786dd2c0..70df2a24437b 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -747,9 +747,14 @@ show_one(cpuinfo_transition_latency, 
>>> cpuinfo.transition_latency);
>>>   show_one(scaling_min_freq, min);
>>>   show_one(scaling_max_freq, max);
>>> -__weak unsigned int arch_freq_get_on_cpu(int cpu)
>>> +__weak int arch_freq_get_on_cpu(int cpu)
>>>   {
>>> -    return 0;
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +
>>> +static inline bool cpufreq_avg_freq_supported(struct cpufreq_policy *policy)
>>> +{
>>> +    return arch_freq_get_on_cpu(policy->cpu) != -EOPNOTSUPP;
>>>   }
>>>   static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>>> @@ -757,8 +762,11 @@ static ssize_t show_scaling_cur_freq(struct 
>>> cpufreq_policy *policy, char *buf)
>>>       ssize_t ret;
>>>       unsigned int freq;
>>> -    freq = arch_freq_get_on_cpu(policy->cpu);
>>> -    if (freq)
>>> +    freq = IS_ENABLED(CONFIG_CPUFREQ_ARCH_CUR_FREQ)
>>> +        ? arch_freq_get_on_cpu(policy->cpu)
>>> +        : 0;
>>> +
>>> +    if (freq > 0)
>>>           ret = sysfs_emit(buf, "%u\n", freq);
>>>       else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
>>>           ret = sysfs_emit(buf, "%u\n", cpufreq_driver->get(policy->cpu));
>>> @@ -802,6 +810,19 @@ static ssize_t show_cpuinfo_cur_freq(struct 
>>> cpufreq_policy *policy,
>>>       return sysfs_emit(buf, "<unknown>\n");
>>>   }
>>> +/*
>>> + * show_cpuinfo_avg_freq - average CPU frequency as detected by hardware
>>> + */
>>> +static ssize_t show_cpuinfo_avg_freq(struct cpufreq_policy *policy,
>>> +                     char *buf)
>>> +{
>>> +    int avg_freq = arch_freq_get_on_cpu(policy->cpu);
>>
>> We are seeing issues when reading cpuinfo_avg_freq on an ARM64 system:
>>
>> $ cat /sys/devices/system/cpu/cpufreq/policy1/cpuinfo_avg_freq
>> cat: /sys/devices/system/cpu/cpufreq/policy1/cpuinfo_avg_freq: Resource 
>> temporarily unavailable
>>
>> The CPU is in idle state, so arch_freq_get_on_cpu() can't find a good 
>> alternative source for frequency info.
>>
> 
> Hi Kai Heng,
> This has already been discussed during v7 in [1] & [2].

Thanks for the info!

> In v7, we were returning zero which printed 'unknown'.
> The discussion was about printing in more descriptive way or with an appropriate 
> error code. In v8 we are returning 'EAGAIN' instead of zero. The final decision 
> was of Maintainers.

Is there any cpufreq driver that prints "unknown" or error when CPU is in idle?

I think it's more unsurprising to print the lowest CPU frequency when CPU is in 
idle state, instead of any other error code.

Kai-Heng

> 
> Viresh,
> You have any preference on this?
> 
> [1] https://lore.kernel.org/lkml/aa254516-968e-4665-bb5b-981c296ffc35@nvidia.com/#t
> [2] https://lore.kernel.org/lkml/Zyh-uVSW-0d0r8oB@arm.com/
> 
> Thank you,
> Sumit Gupta
> 
>> One way to resolve this is to have fallback methods in show_cpuinfo_avg_freq() 
>> so it will look like this:
>>
>> static ssize_t show_cpuinfo_avg_freq(struct cpufreq_policy *policy,
>>                                       char *buf)
>> {
>>          int avg_freq = arch_freq_get_on_cpu(policy->cpu);
>>          int ret;
>>
>>          if (avg_freq > 0)
>>                  ret = sysfs_emit(buf, "%u\n", avg_freq);
>>          else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
>>                  ret = sysfs_emit(buf, "%u\n", cpufreq_driver->get(policy->cpu));
>>          else
>>                  ret = sysfs_emit(buf, "%u\n", policy->cur);
>>          return ret;
>> }
>>
>> But that also makes show_cpuinfo_avg_freq() pretty much the same as 
>> show_scaling_cur_freq().
>>
>> So is it possible to consolidate show_cpuinfo_avg_freq() into 
>> show_scaling_cur_freq(), by making CONFIG_CPUFREQ_ARCH_CUR_FREQ also available 
>> to ARM64?
>>
>> Kai-Heng
>>
>>> +
>>> +    if (avg_freq > 0)
>>> +        return sysfs_emit(buf, "%u\n", avg_freq);
>>> +    return avg_freq != 0 ? avg_freq : -EINVAL;
>>> +}
>>> +
>>>   /*
>>>    * show_scaling_governor - show the current policy for the specified CPU
>>>    */
>>> @@ -964,6 +985,7 @@ static ssize_t show_bios_limit(struct cpufreq_policy 
>>> *policy, char *buf)
>>>   }
>>>   cpufreq_freq_attr_ro_perm(cpuinfo_cur_freq, 0400);
>>> +cpufreq_freq_attr_ro(cpuinfo_avg_freq);
>>>   cpufreq_freq_attr_ro(cpuinfo_min_freq);
>>>   cpufreq_freq_attr_ro(cpuinfo_max_freq);
>>>   cpufreq_freq_attr_ro(cpuinfo_transition_latency);
>>> @@ -1091,6 +1113,12 @@ static int cpufreq_add_dev_interface(struct 
>>> cpufreq_policy *policy)
>>>               return ret;
>>>       }
>>> +    if (cpufreq_avg_freq_supported(policy)) {
>>> +        ret = sysfs_create_file(&policy->kobj, &cpuinfo_avg_freq.attr);
>>> +        if (ret)
>>> +            return ret;
>>> +    }
>>> +
>>>       ret = sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
>>>       if (ret)
>>>           return ret;
>>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>>> index d4d2f4d1d7cb..a7b6c0ccf9bc 100644
>>> --- a/include/linux/cpufreq.h
>>> +++ b/include/linux/cpufreq.h
>>> @@ -1194,7 +1194,7 @@ static inline int 
>>> of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
>>>   }
>>>   #endif
>>> -extern unsigned int arch_freq_get_on_cpu(int cpu);
>>> +extern int arch_freq_get_on_cpu(int cpu);
>>>   #ifndef arch_set_freq_scale
>>>   static __always_inline
>>


