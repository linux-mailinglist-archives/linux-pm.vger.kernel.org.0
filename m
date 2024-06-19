Return-Path: <linux-pm+bounces-9628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A117E90F72A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 21:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B301C21935
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 19:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7DE745D5;
	Wed, 19 Jun 2024 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GJ2+/vLl"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD871876;
	Wed, 19 Jun 2024 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718826370; cv=fail; b=VYj8ks2jxLz6atDQfHUksikdVSM9wGjRMB1ef1Fu3WKAZLkafdkwJAgANoivKqPamfKQNXbg00tj+HtwIaFGUXnDvpIt3x2HdAVJNay7iqqNrmmv4KMHV2NOcOReQKEOpHKqucHVi1dSjhYNd4as8CdqIuI4jUPVI2ksV8QtIgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718826370; c=relaxed/simple;
	bh=bMteXh039JgtQpl/471nDRgFoYYW0bdQ6aWXw0+QUZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SqHFhGT03yKo8aj+LB5seTnnpV4UKW/kh9pXvH6x6aiJu24YyaIZYv/Q/+0Wxk/f2UdXMfyP4MtuapRoyXbXhl2PxCQvad00yoibq0j7p4keo8jnyoQpendOOhuvRicJcrEraLEoJ+mORVs67jkyBjV6k6K018ax8Ro5h/0dKlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GJ2+/vLl; arc=fail smtp.client-ip=40.107.96.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EV1uF8jjRrOIoKZJ9wloROiFDzbO467Wtdl2j2rF2n9miYgsdATW+roxCj8pO1gzc3mYpN65xw+lzvJ+TnTRbZAmOG0EPq0zuyUZYmderOOSpBX1ewqIUEbHohu9+ObsLfvBWCN7K+ZpwqZdmOA90whyn15qs1h904AxJE4LgV3TbP3gfI1g2UfVSVmRCsnLpwtWBzxhSZoCINmZF3FYxqVf/gD+nw6fCC6xUgRHIGJekZ2tz0DQwFpNdKr9uVJzMgLFXst7PWsuYwFJZoXst311rgtO4LLrGsyJUik7Px+VSY8nminsf64fpEcp8T7EAAuGzwhmOMRyw+aoRgBpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jAsdNCZD/+GTRHSGWV32p7JNIZRRv4udr8QoA78g9k=;
 b=n+xyTyCLdPP23NJ/HECLQboY11cEBtJo2nUgELSUw/EEnZnwQPU5hqsCrbyRWPRYq4U0yT6QoZH1ycNTZXBRsM3qjWtO8NIWLYWjyk/MNrM92SNiXCurgYFtPq9GOkxbJeOQ9ljijX1h7AIUOZ6wyc8WtRfuQaszZsSvKAYL0VkI8Vo6ofp4RYhjxZ/cY1uy1dIXdDsS233R0NPvm9zuNWkF8WrB/Yl/yBm44r/7OF72w2rnVqt81Ns0EyXWIZje7sFOmcPqO00+DlE+VnzbDfsKgxVHbhODiSrdikSxjpJsANSl6q+rfo5Zn2AMX7VovlDuqprY2/nB3PGg/nhpFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jAsdNCZD/+GTRHSGWV32p7JNIZRRv4udr8QoA78g9k=;
 b=GJ2+/vLlHR0H4gMRrGiiiEjWKQsT29PFjvRds0iLPKWBz757XqgMtgPamJLfRZiC9Jeabc1mc3ASb8KEbHR8wO70jeMrf31TcyzYBdpZuFCpZlmEhLvTYwEweVtsAQy4ppz/8MhLsHR/2lw6A4gb4ykwNLGGJFURy7B4AeBuO9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 19:46:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 19:46:00 +0000
Message-ID: <19cbf20f-cf06-4776-8d14-973b090f7242@amd.com>
Date: Wed, 19 Jun 2024 14:45:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 9/9] Documentation: cpufreq: amd-pstate: update doc
 for Per CPU boost control method
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, gautham.shenoy@amd.com
Cc: Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718787627.git.perry.yuan@amd.com>
 <6b705dc178d484dd4f99e6bd134bdf09ee0a879e.1718787627.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6b705dc178d484dd4f99e6bd134bdf09ee0a879e.1718787627.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0072.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 25dcb8d9-0950-4239-e2f6-08dc909871fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjZXWHZQaW9Pc1RSQUNseFh4ZG50RVlRRzFudUwwWXZRMEozQW9BS1V0ejVS?=
 =?utf-8?B?OGF6VVd2SWJTSmxtUVNYL1FHT09hZUxTS3hZaFBydjhlRVJPWGpmQkUrUnph?=
 =?utf-8?B?Zk4xMzRPNlMzS1hnSXNvWElEdFczaTFBUWJqTURRbnpjZUQ4TUFsWU1ZbXBx?=
 =?utf-8?B?SHdrVnJwQVo0N3RxUms0TVoyOFVkK255Y1NJL1lrSUZSQjh5aDA2QUNVcFRu?=
 =?utf-8?B?c21nZ29OU3BzcXpSVThPUnlWTGZIcFl2WjkxZ2I4eU9xMmxQMSsvYjFqenJG?=
 =?utf-8?B?Yjh2bm9CTzFmaGw3eUczQk9BekpaUk5Hd0ZyM21VaHkybWl2V2UyTTVLRVpG?=
 =?utf-8?B?c1QzbmdVYTVmWWViaXF6OFA3eTYyRWJJTjIwb3FodlFXd09UdnFYU2NKWGV0?=
 =?utf-8?B?VDZBM3lOeFhQYlhZR3g1K0VmRWlKU0tXMW5SRVdKVUwwbmdaYk1YMXBwaE9r?=
 =?utf-8?B?YTlqVHRwbzc2U1p1UlFpdDkwd1NjVWd0NUdjcDAwR2RkOGZkMFM0NGNSZlFm?=
 =?utf-8?B?V2FaM1IrTzZrZll1Z24vQ0VJWW14NTFtUll3K3M1STlzK1hiQkhST2l4dlll?=
 =?utf-8?B?bURvSDdDSVNrL0RncW5wZE43TzBFVWk0RXVKK0dtNXhQbHNHK1BQNXdiYldy?=
 =?utf-8?B?U2Y0MzEyUXl0T2QyTEg5T0JBL1Z1OFVkT2IraGIxT290MzQ4Z2ROVFNKOFBS?=
 =?utf-8?B?citwWGpGS2llcU1maERaeUVlY1dNYm1VTHR0S1VUSjViMDd5MXFTQnNEM3Bx?=
 =?utf-8?B?ZEhvK2lFajg1aENlenUwVEk2TnVzTzQ5MnUwSDFNSnUxbElpWERsMW9KdmZT?=
 =?utf-8?B?MXVtYm5Cdkpua0lremU3QTdVZ1hJUkIwWnhZNDZNNjBja1Y2R2JjdXBCY1p0?=
 =?utf-8?B?QWg1bldadmZWczVTVmJnaDBQOEJYMjRhZ2FxTWo2cWNKeVpvK3BYcGt6aDhL?=
 =?utf-8?B?bmprSS9QOUtFWUo5bkZtUUxFeWdveGhvZnd1Z2VzZ1JENEVnVk9ObzlidUN1?=
 =?utf-8?B?NFhGeHVGeWgvUHU3K05EcWd6bFdYejhwbnJYaEdKRnhSS1QyUE9nMDJTQXo3?=
 =?utf-8?B?SGd0MU13dlhhS3Q0K1lmU0d3aWZhU0l5cTd0V2grdS8rRlQwZEQzVFlTbGxx?=
 =?utf-8?B?TkJDOXhucXNsZzh1V0M2U0Y1M0F0UTdDbWV5WmIybkJXKy8xYVYvUWg0K3g2?=
 =?utf-8?B?SEJkNHRFa3lwWjFTYWxQTDdSUGxZUzk5aStXVzBubmw4Uys3Z0cxZFZxSWhn?=
 =?utf-8?B?dEpRdjBMUXFxUTU5a0xRT1JoRnYyWk9PSUoyeDNLNkwva2c1WUdyd1BEalYy?=
 =?utf-8?B?K3J3bncvVVY4Q1FHN1pyYXo1dEpYdFI2MWNtbitoVFZrTW5ZcER1bS9DaU03?=
 =?utf-8?B?K09IYW5LQkRCTDIvU0ViZFpVWkpFOE9QUjdnYjZ6SFNLa3BhNFo5Zlp2M2VZ?=
 =?utf-8?B?VHp2aGkwTHBDVlRGdkFpZmJHTHpwdUhUVUxlTHYyMldpWStHYTlCZHgvTDNI?=
 =?utf-8?B?Z0M0eENsZHI5L1dTU1VwUElJWGxQazRMZHpRa1had09RU2lUdXRuWEYwZWtD?=
 =?utf-8?B?RnU3T0M4VEl6VzFXM1ZVZWtEQm9QREJxM1dLVUtIaWZKSGJwaUVYbmNLSG9q?=
 =?utf-8?B?Zlh4K1Jlb2g0bjh0UWdmOFAvejU1OFBaTy83MXBXZldDMVBYNkpiajJPMWZZ?=
 =?utf-8?B?UGlSY29vZnVrZlpwSHBmUllranJmWVF5djFCZGYxaVFDaHpsSVBTZUlHc3Vi?=
 =?utf-8?Q?GzVEowL/KHY7ykZQhi+eHm/csWouGybczsCfPtP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXNvYkVFeEUrSTJOVjlqQWhzODlMVDRsSUlPbjI5SDZXRlNLeGxsZTJGK3Ev?=
 =?utf-8?B?YW9oRXRTQnYyTGZRL2I2dm1kMEtoS0x3OWJIR1lrUVhteEl3dWJMWnRGWTh6?=
 =?utf-8?B?VWdhWjk3dmNIYkwrVHNKN2VEbnZyTFh3d00wVUtuSi9NcXdacHMvT3RGMUdn?=
 =?utf-8?B?eXo3QjhRSkpTanpsNXlNOEYxeExUT2tYUTgzZUtCczZmaG5hOVVHejY5cmlH?=
 =?utf-8?B?cjZleDgwcmFQMk9KWnE1ZkZGUTVOWVpETVhzMmtzdmNtWEJRMVRPTStvQVlM?=
 =?utf-8?B?SnlpRktNRVh6V3FiVVNUZzBCcE1lYjV1SVNRVC9SVWpGRDZHN3g1UVh3VlZh?=
 =?utf-8?B?N2kyWEhMNUhsS2VBNjYrSlBQMlpHS1dQLzV4ZTVqUWhJRGpJQTdlL0l1QlVI?=
 =?utf-8?B?OXRjRTVKTE9JbldEbnI3RWU1UU9PR3VjWGpCZ1BCRlRmSW5VTmN0VGlzTVEz?=
 =?utf-8?B?Y09HdWdXbmNtUTczUzhzWG9wZnFPVE1CaWIrSGdoZjdIcU1mOElWNUJBOStu?=
 =?utf-8?B?K09zZWFpR0pxZ1l6cmxxUW5HdFJ0NlBTNjh2Z0xlckdTaXFtY0hhV1FtLzZm?=
 =?utf-8?B?RzBnOWNISG5TVVBVMVhDVlpEYytEQkxmdjRCYndDaFlmbWR3dnprWnhUZi9K?=
 =?utf-8?B?aWZwd3dDbVhYTnh4UlFnZHlMM2oyYWI2Unh5VXlXbkMyUlRiNnNUMkRrRzJU?=
 =?utf-8?B?Qzk1OTFtNCs2REUvd1pweEJaYVJKRXRZUnNCWkpKdEFTRHFoa1NPWnU5d3pu?=
 =?utf-8?B?VkN3bjNhVjcyNjFwQ1ZBNzc0b3JtRFkxSWRDSmplc2wzNGxscUcvSW4wanpl?=
 =?utf-8?B?R2NTekptQnMzdU9ua1luVFhFajdzTERkQnR4TytaL1o2Unl3TE9DaDhWcFRG?=
 =?utf-8?B?SzBBYWQ0Q3RBYiszU2U1MEdISXNwSXlDaTN2VnJMN0ZiL3p3R3M4L3g4eWtI?=
 =?utf-8?B?b3c5RVp2OE5ENTh2L01zcEZrZDI4NFlOcFdqWUhWK0M4Q3UwdXNFYnpETHZy?=
 =?utf-8?B?QWF2OGJhRHpBSnJCS1grRlRGaGRYQjBrQXpTK01wYndLT3ZaUi9rTS81VkZq?=
 =?utf-8?B?K3dTR0lzR0lacDNmbEJ5UW9yY3FMRmM1TGhaSU82UkNHSmQweWJZcmZpMnN2?=
 =?utf-8?B?d3FLckdxM243SDV5RUxDSWt5ZkNCS0lkMHdTVTBHdGlIdFBjS2RmYTd2K1Zy?=
 =?utf-8?B?SHBiOXJnSi92c1BJcktXY253Z3J5ZVRrR3lIM0FvcVdNV0RIN3ZUZEZYRjNG?=
 =?utf-8?B?MGpNVTVucmh2RU5NTzVsUUZONHNhTVZ0MC9wUmtCTVpmN2lUVERqWWl1ZUFv?=
 =?utf-8?B?TWtEUHFtM2dsQVhMcHIrSHE4OERvQVRDOFBPTitzbFZDMG81cTFHMlFMbGdt?=
 =?utf-8?B?aysrTVZESktscGdxY1ZPaWVwNVJrYTZ2VysyZjZwMFdIZUZDZzF3WW1ucFEx?=
 =?utf-8?B?TWdWNUJLaUNrSDFsaUtXdEk2YUFwMTlFUlpOMnNPSlNjSnljTFlUNzdEbTh5?=
 =?utf-8?B?RUZjSzBTWm5IaTh5Y1NaQ3JYU25TVVltTEEwSzlWdjU2R1greUMwQWlRaURP?=
 =?utf-8?B?UzdHby9JVCtONWtEVE9xWUxNZEVnTUFQQnFBUGpGZ296ZTFoY2hJaVhWUi9U?=
 =?utf-8?B?bVRDN2lvaUxMTE9zZUc5eVRBVmxueVVHRkdXTEp4MmxWYVJLZ1MwTzhQODJB?=
 =?utf-8?B?SWQ3ZmVwQzhHZ0xJV1FWVERUaEVjQXdZTnN3c0ZVOUVUaTYwaUdEOFo3eGFi?=
 =?utf-8?B?dU43U3F4dStFaStXL2V4NGZWRDZhTUs0SHhLZUMwUFBxMy9NTnV5dGRvV2ZM?=
 =?utf-8?B?Z3A3VGIrM2hJYWJEUnJNbGYydGttVHFZK2l5YTB2ay9oY1h0YXRvVVlnM2NH?=
 =?utf-8?B?bytKSitYeTE1KzZKWVlyMUQvU2hmM2M4Vmh6TXI4ZFpIVldlZnhEcTRaV2hS?=
 =?utf-8?B?eVlhUDdham9xVVdudkxDUUJESHFDcVlRaDJWckl4Uk9tNUNxdVhnU3ZLb0JX?=
 =?utf-8?B?blIwK0xNbHpndWszR05TM1lxR0s0OHVBRWdtbWdxQnZEZHpnZkhwMXVRa2JX?=
 =?utf-8?B?U0RDTFF6UVBGUmNES01SRmNrODJGQUh5eTdRdFRoY3ZhOVdSMTlsSWZqa0Qw?=
 =?utf-8?Q?KRSng17cPUgsUgcAaELmrwrpl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dcb8d9-0950-4239-e2f6-08dc909871fe
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 19:46:00.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVa6/w5GhmdsxRrhh/FvXOgySMeK43FoYiECKCEOM3pobZ/LUt9eglPg1qTaz/XHl07sabJsTVWzx+gts9NaVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840

On 6/19/2024 04:16, Perry Yuan wrote:
> Updates the documentation in `amd-pstate.rst` to include information about the
> per CPU boost control feature. Users can now enable or disable the Core Performance
> Boost (CPB) feature on individual CPUs using the `boost` sysfs attribute.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index bcc0d9404c18..98e43c53c387 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -281,6 +281,26 @@ integer values defined between 0 to 255 when EPP feature is enabled by platform
>   firmware, if EPP feature is disabled, driver will ignore the written value
>   This attribute is read-write.
>   
> +``boost``
> +The `boost` sysfs attribute provides control over the CPU core
> +performance boost, allowing users to manage the maximum frequency limitation
> +of the CPU. This attribute can be used to enable or disable the boost feature
> +on individual CPUs.
> +
> +When the boost feature is enabled, the CPU can dynamically increase its frequency
> +beyond the base frequency, providing enhanced performance for demanding workloads.
> +On the other hand, disabling the boost feature restricts the CPU to operate at the
> +base frequency, which may be desirable in certain scenarios to prioritize power
> +efficiency or manage temperature.
> +
> +To manipulate the `boost` attribute, users can write a value of `0` to disable the
> +boost or `1` to enable it, for the respective CPU using the sysfs path
> +`/sys/devices/system/cpu/cpuX/cpufreq/boost`, where `X` represents the CPU number.
> +
> +It is important to note that modifying the global variable
> +`amd_pstate_global_params.cpb_boost` will override the individual CPU settings.

The whole point of the global cpb_boost is an easy way for software to 
turn on/off for the whole package.

This makes me wonder if we want a "custom" string for the global param 
if one of the CPUs has been individually modified separately from the 
global flag.  Then software can very easily tell when it's been toggled 
for a given CPU or via the global flag.

* Basically if userspace wrote to a single CPU store a bit in the global 
structure to say cpb_custom = true if it's not already set.
* If writing to cpb_boost from sysfs then "cpb_custom = false"
* If reading cpb_boost from sysfs and "cpb_custom = true" then double 
check all CPUs.
   - If they don't have the same value return "custom".
   - If they all have the same values this means software has updated 
them all, set "cpb_custom = false" and then return enabled/disabled.

What do you think?

> +
> +
>   Other performance and frequency values can be read back from
>   ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
>   


