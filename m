Return-Path: <linux-pm+bounces-19951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB7CA00C75
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 17:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675AD7A116A
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 16:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C791F9EDF;
	Fri,  3 Jan 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CsTRtHcB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699E6155C97;
	Fri,  3 Jan 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735923406; cv=fail; b=VttTuzSu6M1KJmv2rkHsr6sW0qbNee9LPDY4jyIDzbUBWwR6OlglSASaS8bWLEOTxl7MbhQJu0VgK9riO45uogjMjSulSXqba8fOYulCtYWPD85O2IyW1/wyNs0JVAUn32NucvSGK2ZfirM689xG3ysZ4C8MTli6ETYSswuEjaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735923406; c=relaxed/simple;
	bh=Qga9vjKKcxPQHScdQPevQ9K5tX02TeiMlVkmxHrEhV0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uMR3zGeOek9kUEBHwLNA3BPjYLIY7njqLkdBDGRBm7kVPNyxfSWs+r+Key8dLLLangA9zuH60mzyBpuUCMRcbMPlAELh/SP0LbPboHGm+QM6AzsITIVeSI7cKlmcEMIguGsddrGOMVehoaBKo0nyVRPDjtM0IdA3i/T8VrW3T6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CsTRtHcB; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIPpJl7elnmuWWP6F5vqZGe9HSWfQE4/X6RlvpOIcD7Kjio+YneiTHfJuHunk7UHKFnzcK5w2q972rl760EdX5bsBaP8PJG85stRcTwYtD2Oyuo7QY61geUr0orw0WzrCRUMejKlXVOQ8b+7mHyJNjg3OCikIZXOOvFu6Wyk6yZg6JTXj+uvvOlGhGCN8dJkeiny4O9NC2zYm8dxi1rCczRxtGY/cbTwG+AmOjsMwdEKaaWY11p8I06vPPuHyFs3oeNbpL7t9NqUh9lx4AUdTAZdtOZ8cnGaesD6snyaNfLwlm7+PXEtmzUxEv91uCcK3Kt/jHa9HnswEjAl5weVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IB0zjMsug4mrbeRp7jP9uVOyGEWqgRjtKKmXkrIR3bQ=;
 b=dYfWzFmjEfMweh7ejYR85RRtpI/NjId7CMIm/S5XYmM0k4z/Ic9K32p3/UF+pSO3Xc6/EDdS39sfEcW6qs1LU4tffL5qwgHyouBAdeMDKJkmp6nmuvrdv+fnvCLTpu7R/iBNqpN0fhtgQDs9A0mMajZRtYj9DPYJD4RrjF8HLKo8AqV60joBf0/ZbTvD/K1qbDZZ1KnwUI4fbSTDyt7anROUqgmBag6TLTeaJxB9UKwhyziDpw3YnhOHZSpU65G6PV++mkGcnkj0LNEJeyDrowp70g2IDAOk8cK1AguriR07xm9GC0JkmO1T4FyZ9vIxPQR3mQYajaQCRGwD4T7tNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IB0zjMsug4mrbeRp7jP9uVOyGEWqgRjtKKmXkrIR3bQ=;
 b=CsTRtHcBtmzQ9IFmroY2MHtp+YDCcPYQFewVFxVb4QMfdt9FuOqMqBBe7a/iMmfIn10K+6FpjaUqr4sEcc8jPPtvs1zthFy9IdRbZkYfoBC9WSdcoZFP4UIIip3u4THKWfBdRpVbxc9mfT2X2rSURADCfZLjJaIbug3ObmY4+lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.12; Fri, 3 Jan 2025 16:56:37 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%5]) with mapi id 15.20.8293.000; Fri, 3 Jan 2025
 16:56:37 +0000
Message-ID: <7e777177-417e-41eb-81d0-3635769d3a83@amd.com>
Date: Fri, 3 Jan 2025 10:56:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix per-policy boost flag incorrect
 when fail
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, perry.yuan@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
 lihuisong@huawei.com, fanghao11@huawei.com
References: <20250103074139.1080092-1-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250103074139.1080092-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::20) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 84cf2150-820e-4cac-9563-08dd2c179607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3EwWUEwSWZzaHdkTGphTzlzT1cxT3NvdnRGZlpndzFIUTYxZ0E0Ym90aTUy?=
 =?utf-8?B?NUNOK01QRC85aWtpZDVpNk5hK0FLK1FqdThaK3hFYnpQYVlSM1hJQUNmRjBU?=
 =?utf-8?B?UFpmR0s4STJ3bmU3ZVUvNmJ3RUpLS1poZVJJclA4YkVOOVMrOGJ5M2lBQ2NP?=
 =?utf-8?B?dzArQUp6RXhKV3VMUk1vNnFhZWpRaFF6VkNrSkFjMG42a050L0N1MzR6VitK?=
 =?utf-8?B?TVJleDkrTmdtYmJQbjVUMGE4c2hWUDd6QmNXYWt3M2xSWFFkOGJwWnRMNHBi?=
 =?utf-8?B?ZWExcnFmNU50YkRyZFdzcnJ3bTBWaEIxVHdoWkFvT2RrWU5zK1J5cVRSZGdL?=
 =?utf-8?B?MkpPUjlaVzF0N2crYytBSjMybW0rdThtSFptQnJsWVRMcmxtdXgwa00wMWNM?=
 =?utf-8?B?M1VSNXkxM3RsNlYzWVpWZnh2Smx0cG9oSFU1dDRkUEV6Z1MzZ3JpbU9ZOHJF?=
 =?utf-8?B?NjFwa3dJK2JJWkVwc3FjRllOeFNEOXhxemYvOE84bFgySlZpMkZwOUw5QlRX?=
 =?utf-8?B?UUMxYk41NU1ydlB2WjB6VU95a05VeS9VVkpmUHlhZUJnbEZmK1JpcjFzQTJ0?=
 =?utf-8?B?NVJqQ3NNdzd2Z05xZWVwNXI4dkE1ZmplazNjQXIxZkFoK0duRHlVQVRwdjdI?=
 =?utf-8?B?N3dkdGdrbVJZY0RxWFRCdlF1aFdvUGZJNlBybzJ3QXRVYjExVnpZZGdHYnYz?=
 =?utf-8?B?MkFGYkFqREs0V29zb1hVMitGOGQyOGYyVmtZa3BCQVhyWHNSbHBOWWEyQm1O?=
 =?utf-8?B?MWJ3VzZiRFNZTGIyNFkwTENyTkwxNWlqVDR1SXJibGl0L2lKd2lFWUZid3kv?=
 =?utf-8?B?RkZXMzlpUHA1N3JLWTZLMXVLUjhRMGVob1FNaEIwOG5wK2VhU0ttZ3J2U0l4?=
 =?utf-8?B?ZHI2cW9UMFJUTFJDRHp3NUFHYU02N20yV0JOK0g4R25UZVJZdk94Tlp5Tkx4?=
 =?utf-8?B?clNPZ1Uxb2dKT3dhR3pUQk5OM0o3RHU4ekZiRzZYUDRKRkExcEJ1WWVRSnNx?=
 =?utf-8?B?aWg1cmdvakE0a0g1d3JkY1BIemFIR2lES1VqSkdibGxUNkpnNCt6OGl4SElI?=
 =?utf-8?B?STI2RzVmemVZK016eExHN0JMVmJRb1Z5ZG8vNUpaSzkxTU94WkhiMXd6Rjgw?=
 =?utf-8?B?NnZaRUZmbzhjTGVialdYTTlPa255UCtOeTB0NWIyNlBtdkxBblFQVVlKRHdE?=
 =?utf-8?B?Z05pRHo5clZ6SURuUjNDOFdESlQ5THc2c2Z6RXRPT255azFQTk41aDVtbzEz?=
 =?utf-8?B?eTFyTFJKK21pc0JrQXNqc09BNFlRK3c5bTZTdkRrQlE0b1VDNE1BKzVxTEIr?=
 =?utf-8?B?elQ5NEh3M2plUm5mL3pyWFVrS3ZwNDYvT2dJWFd0TFgveUxxS0cyVTZVNDlF?=
 =?utf-8?B?SUh2bWhUWE9wcU9hZUdhNExteXMraHFZb09GZWlsQ0ljQnRLQWgrYzdsWlQ0?=
 =?utf-8?B?T3M0N2U2TjdXQ3JGdUFKcVk3UjEzWXAySitHVlBINDEzNTRxWjVacDNDcGNX?=
 =?utf-8?B?WFRKbjdGaDVZZC9SQkN5czc1Y1Q4YjZjZUtxZ09RL0h0Z0tsWjlLQ1lxYmRt?=
 =?utf-8?B?WXUzaWpCRlVkRkZqMzdJRng2S2hVbkdVV0N5MzAvOEI4dnlYM1AzWTFMYlFU?=
 =?utf-8?B?N2NYdXRIQnJYSnF3N0tqSE4wV1hxTkt0ejh1T003UWVKQUZHRVg0QU9HVVBk?=
 =?utf-8?B?OWxFMWV1c0tSOG1OVGtHeGxqS2xOeldPbnpMUzhOdWpScWc2WkVGc0RMQjFj?=
 =?utf-8?B?Vng5ZElQMDNsMFRmSHZlb3p4NThuYzNXYXd1MXNsN2c0bHJYVHRISXJlaEFN?=
 =?utf-8?B?N2t1ZUszWVVBVFhpSXQra2tuQis4RTk1cmdJZVJYWjl5dSs2Ty9Cc3p2SE9I?=
 =?utf-8?B?RHNIQkFlWndubmlCTE4wcVlXYitDMDc3OVQ1VXR0UlhkK0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlFmbUF0d2FzU1hnSFV6ZkIydmNOWXlvd3NIVEZjU1dicHhIeVFrejFLWDA3?=
 =?utf-8?B?bHk0VGlyR1dSeXY2WVNvb1ZuWU04Q1dpczFmZ0lJTlp1UHhHbDFsUUZseFZh?=
 =?utf-8?B?Q2R4c0tJazE4NjJoNVFwRUhCZ0QwK3JIY3NTZUdQNW9PanFWRjZtV25pTklp?=
 =?utf-8?B?K0FHZm56YnN1cmNZSHptSmZwdUJpa2Z6WTJIWHNnMC9MY09YcWlQOE9kTmlH?=
 =?utf-8?B?dHNYM3l4eHNyMTM5QzBxNCs1a2NVcFpVYnNqQkY3UkxBMWw0bnRqYklFbWdm?=
 =?utf-8?B?MWpxdnpRWkRPRnFJRFlmRmpreUN4NitVOEdDNFAySEw1Lys0cTA4dkpHbHc5?=
 =?utf-8?B?dVB6cUQ0dE41aUtmZS8yeUp4NWY3a21RYkFJTnV2OThReWkvZDd0UHhhSDkz?=
 =?utf-8?B?YUl2R2k2UGlzQjNXcWtaai9Xd0U1eEtucVFmcEtva0JldFJya2k3QUZ6ZlQ4?=
 =?utf-8?B?YkFkb09Pa1RYWEFlQS9xQmhYeTRiMkpaaDRGWThJV2dwOTd1V0VZTkU4cVJa?=
 =?utf-8?B?UDJuNlhBK3BLeFhkQlhyVGl3WUVCZWRQOW93dG1VTTJZcnUxNE85SG90QnZt?=
 =?utf-8?B?eXdxWmpUMTFVS2RSZ0xlNFZvNUZIbTIyVWNhTXVjMHcrRUVuQ1B3eVVTYzNL?=
 =?utf-8?B?MjVWclBBTFNITlYzOTVHNzRCY2tWaklCL2pLWVhpcXhRUUhUemc3amt6R29n?=
 =?utf-8?B?YWRaSjNJWWpDenRvTGxXNXlHcDJmTFMyMjRINDA2a3M2Z3psenRtcU1hdlcv?=
 =?utf-8?B?VzdFTm41UlZTWU9pNS9YOTFTclE2SllTZTdNSXZ6R2g1b0Mvdy9PeFAvd0Uz?=
 =?utf-8?B?MmpMTWlibUJSamdyYWRwbjdTODQ4Qzc1K0xGdmJ3U1M0L0tCbUxyV2Y1NVNO?=
 =?utf-8?B?UVZkVG9wanRuYVpwWVRzTGxmeGdJRTJGeTlBZTdobWExS1piWTduRzhQT21w?=
 =?utf-8?B?em1IYVNtMjZoaEtCZkwvdWJGRUNJZjU2WG5VQktMdUFUNmdqalY4M3ZNU0lR?=
 =?utf-8?B?aXlrYnVHSFBkaGtwQ3hpdXZNMHJ4SlBLT094TFptdXhsVnFzalZveHBCS0dC?=
 =?utf-8?B?L2xIZVVGcUREck05dEFlb1J4MVFJVDNrcjFXeGpoSFNCQm8wcDgrVytEZzZk?=
 =?utf-8?B?L1hvbzRGQjVFUE9iKzVMWXFTTmh5RVhOclJZK3VKZmkyQlh2OWFrazdqMGdm?=
 =?utf-8?B?Q0MvVW9JWkxmRG1CZnZLM25IeGZZTjdxWFhXc2k5NDc3STVBMHdrN3V0RTRM?=
 =?utf-8?B?UFcxUXk3c2FIWEVjRmozeGxMYjI5UTRNSlNJY0RiVisrYmVpRlJRKzQ0VUw1?=
 =?utf-8?B?QW9LM25WVExIREt3d2UveEJtc1pkcm4wUnFLbmRuYUxIeUZRR1RKTXZhTURK?=
 =?utf-8?B?ek1PMTd1Q2dkWngwL1FFVkVFVzhVbDJuK3RQQi8zL0h2alhyc3diNk5JVXR2?=
 =?utf-8?B?VTJoUjNESlNDbExGTFJHd1ZOVzJONGlzb0gvUDdlam1ObnFQMmRLY3o2UlhK?=
 =?utf-8?B?UzZQcEVMTCtpSzgxa0pSU0tzdkY2MXpwYUNmRXczbVV1ekUzci9ZY3pXbkFF?=
 =?utf-8?B?cFlkbm1TRnJCWjFmMVVzdW1DWkdRQWVwei83d1pVSzV5dWVON1Q2NGhaNm1G?=
 =?utf-8?B?VkNpaW9jSFFWb0JsNEwwenludHBnREhyRThoY0xBMXNiQmVNRE9ZeWlqL2tj?=
 =?utf-8?B?MC9uNnlXbUxhMUI2VGJJQ0JyVW85OUNyUDRMN3EreWxjbVFkcnlCZ2s2dDlh?=
 =?utf-8?B?RHBrTTlrdjNKUUl1Q1Q5blVkb0Fnd3lCbHB5ZnlJdk9nSzhaVGw2V0YzemtX?=
 =?utf-8?B?QkI2d2lMc1ZZZXR6QU5iYVB0NW9RUVVjdGh0VDMwamU1U25JbHdvQ1pJWWZD?=
 =?utf-8?B?QWRubE9UVFFuWkMrN3d6WW9zKzV5ckxlTkcrQ0JnY2M5K0RuNzM4SkhEWC84?=
 =?utf-8?B?NXA1L04rWm9xdHVYY3duNEdBMndUQ0NQMmF1SVN3M0ExVkhpM0E2UlJjcEUy?=
 =?utf-8?B?TVoxYXoreStOYTNac0ZXbEJ2bG0wSnVBd3BIbytkSGpQQzFTTHJKejhLOUZk?=
 =?utf-8?B?Sy9RNWtJdUxhb0FCVmd6c2VyanlZbmovdm44c3VFY20zSE9aeGRHeXNjaTJG?=
 =?utf-8?Q?sJTMDAUy4BAZ7+iYkXTK5UCIQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cf2150-820e-4cac-9563-08dd2c179607
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 16:56:37.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uO8byakSoQdxhx31aW2+yC+cmGrMkw+yYqew7m5q0Y8EX02grCrOprTl+w0ljOdp136DfuaRHiWIangs47qtgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070

On 1/3/2025 01:41, Lifeng Zheng wrote:
> Commit c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision
> boost state") sets per-policy boost flag to false when boost fail.
> However, this boost flag will be set to reverse value in
> store_local_boost() and cpufreq_boost_trigger_state() in cpufreq.c. This
> will cause the per-policy boost flag set to true when fail to set boost.
> Remove the extra assignment in amd_pstate_set_boost() and keep all
> operations on per-policy boost flag outside of set_boost() to fix this
> problem.
> 
> Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boost state")
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---

Hi There,

Thanks for the patch.  Unfortunately, it doesn't apply to the current 
linux-next branch at 
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git

Although the issue you identified is still valid, there have been other 
contextual changes in the function [1].  Can you rebase on that branch, 
test it again and send a v2?

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/tree/drivers/cpufreq/amd-pstate.c?h=linux-next#n750

Thanks!

>   drivers/cpufreq/amd-pstate.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 66e5dfc711c0..4ce923788f3a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -730,7 +730,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>   	mutex_lock(&amd_pstate_driver_lock);
>   	ret = amd_pstate_cpu_boost_update(policy, state);
>   	WRITE_ONCE(cpudata->boost_state, !ret ? state : false);
> -	policy->boost_enabled = !ret ? state : false;
>   	refresh_frequency_limits(policy);
>   	mutex_unlock(&amd_pstate_driver_lock);
>   


