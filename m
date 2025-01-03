Return-Path: <linux-pm+bounces-19918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F30A00379
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 05:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A791883DB7
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 04:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3312629C;
	Fri,  3 Jan 2025 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bgwY1TKE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C6C2581;
	Fri,  3 Jan 2025 04:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735879897; cv=fail; b=BAb1xdVe8sYo8/vSbLHrM8b+tzRZmSNup6sG8rlCT4eIqWPtOm0O4Bo5bxw0qwFuLwby8Ky4hs3eZVDzKcxV3vI+2rvcJmIv+o2yCOqeRA2ZoD6xoBIvE2lWEMK/fpEvt/qLH9YEh83PM00JqTSYJIpWdzfWFyucyEPNTcZA4Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735879897; c=relaxed/simple;
	bh=Zg5AnslL6Rzj6zcznCU39sgUdM2o37/ZR+DWPlCMXo8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DyKKFp9NdIsKhP034VVJQ+Yvig67gnCPXaCN0ayd60E5Snjf3i4bwq4HDi/OaM8BWAMAq4PaBfJMrMhws9RtITIXqn6aFp9kIQZ0y49CVoI1lvE1cATCTcVwAwYin96BBkXBDMzQEFZG7yAp4EEs6JhGGQawKqGavfvJFq0UYAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bgwY1TKE; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hz9pnEV2EWWSsOpwRxS20KWb4a1qYJG7i5AbogbxUByb59UpqVIoJTOtrHK4EfhLgb6J2L2/98LuFC8qFkXMW8o0pi2QVFPgMJOhhs3jFJ2nO8kq6NFfS6lGkuUyXt+MtZRtGnG/xvvaHIut9WKWRXGSa5eNB1zpShiWi5cOXiC1lVJbyWdw9Wj2hnJfakQBUsx+arPJSw0loOl9GetUowdskNvByn5q5TkipjaGO6B36Mb4l4ut1oeuJqOd6H8M/kPoHxBxuLFnt7EPf4WhfJwfiaA2+lUUxQ26W+2BiYxzeLJ0tUiSJAhDJEnOZ+J2xrpPLLAo2pQWv2Nksz/Lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyXGhwBTrloRvnIjhuP8tlLKFVTmuaTJkckg+AsV7HM=;
 b=hl3RaDTeDw/MXH7QWTWPQg7D7nN4YrpMpqf8yK5ArwilXa4zA7x0E+mJBm+q0NoFo7Y8F1arQltqmE83WiGfROJA2sxDE5d5028h0pHj943E+y+I89TJlwN/yrNuiXpzIxInuKTCMIV+2Gmt74j1yMsTt8mLl1bJNyH8Lktjbj8Pm30uwFAtKF02/lb+Z6wEFTHoNpGTY9M8Q/WXn4zDIfSwDvtgJ937kTORuqFyM/mBkyfpGil7n5BWiYi5ET4uPyoACxBJVNmcwFq+7pwXpCPmHUKKJyCURNApvpllL77gLZl/gwoxFwC+vMP1hyy4C2SXPHQS9nFWWMhjUoohVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyXGhwBTrloRvnIjhuP8tlLKFVTmuaTJkckg+AsV7HM=;
 b=bgwY1TKE9iTelv7eiUKkbTTockezh7FDqXIMSjtnaXeZuyQ3Y4Qu4yO+kaEjh8U9McQHkuhdWsV9t/bDEgB14/2RK/MGMuTxUl0l/zoyi6jmQYi1Dw85uOTuDNVk4c1wNzHGB/U7Awl9CQcNFlprxWmNkI4lyfNEOIBwCqW/h0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 04:51:29 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 04:51:29 +0000
Message-ID: <4a0386d0-24f1-4b13-9111-6e4ea34083cd@amd.com>
Date: Fri, 3 Jan 2025 10:21:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix prefcore rankings
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>, Sebastian <sobrus@gmail.com>
References: <20250102141204.3413202-1-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250102141204.3413202-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::31) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|LV3PR12MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: b41ce7b8-4322-47ad-d8cb-08dd2bb24963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elhqbGIzQ0FQZ0pidHJIcmkzU1dmSTJTQVRnZUl5SGZxM3IxM3UvK2h6UUdE?=
 =?utf-8?B?Umt6elI4UEpmS1IvVWVYUVpZK1NQZmN0bHc5VXhsVzdyaFpqaUphOWk1RDJH?=
 =?utf-8?B?bXRsTkRjSDgxYWxDNFBvUzZlenZPYlBOVXJNSnUwK2hDTXlySmQ3SDF6amtI?=
 =?utf-8?B?ck5TdVpsWnNqenJHejQvVWR0dG1hdTV4UGVsbjR0RzBSTjUvUmgzbFhqSlJW?=
 =?utf-8?B?WFJSaEpwS3gwOHZBZWUzRStLdTdPUzlGVk9OMXJ2N2E1cFV2ZjRsbzNPbXd3?=
 =?utf-8?B?WTdLT2U2clJjUWhyb3lNUXRzdVM5NE02ck1jQXBLQlg1YU9oaS91V3JuclV0?=
 =?utf-8?B?YVFwcm9BbHBGZy8zYmd5V3V5dk81VjlmczlzMWhpRWdyOHB2alhDT0RpOVhh?=
 =?utf-8?B?Um9vbEJFejNXb2h4bkZwbFE4ZCtjQ29hZmdpQW5CVy9LOURqMjRobDNxWXd3?=
 =?utf-8?B?TmVaMkFJd1d5Szc0d29QRWVzN1R3S3FYcTRkUURuNDZDRDBEeWErd3lTdDJP?=
 =?utf-8?B?U211UkRZd1ZHZWZkeFFuVXc1NGx0NUVReVcyRDRaS1k4WEhWNFFNa3pwK3lh?=
 =?utf-8?B?dCt3SG9JMzBTSTNuV2N0Tm9DeVg0NXkvSUZiM0kwZUNGbjBDOCtrdTFWSU85?=
 =?utf-8?B?N3Z5UktOOWtmSFBsYnBkU1FVc0FnWkFjbGQ5dlRRYmQ4OVJDUjNQcm1ROURF?=
 =?utf-8?B?NlZsV1h3QmVXU0QxMXhnbVRDWWFVbThFajQxOE5tbEVFWWtqTjhVTnIvWnZ2?=
 =?utf-8?B?eUh5Ti9FRHpSMHlGK2FDK0xmTXhucjFJY2RtOUFpN0xFbHR2NFQzZzBPcHpq?=
 =?utf-8?B?U01BUjAxOUVBN1RrYXVqckQvWE5UVVU5ZnIvdEU3TGhBTHdFamI3S3hpNSty?=
 =?utf-8?B?SGZ0OGRLQUd2dmVZRS8yNzBXUGptWUU5NWFEWE91dVNOYXdHWGhCeWNrQ2k2?=
 =?utf-8?B?U0tlR3VleXc5YlVKbFNnMHhmM1lGY0I1TEhCamxJb1VmV1JmUzlENVRaSUNZ?=
 =?utf-8?B?MFZuWjlSd1dnYjJLSytMWnVGZlU4RG5obnR5dlFSaXBsM0V5LzJwSWttL2Zz?=
 =?utf-8?B?bnVzZnhTZjdzUGlPdWVjc1RnaGhNdHEzZkxHc3JuTEJjcjUxRi85TjdvbW1r?=
 =?utf-8?B?ZGgyWkNJQzFGZ1RTR1JQUy9rMHpURWNFMnpXa1dQVHJ3cm9lUHVacGpFcml0?=
 =?utf-8?B?TFNPV3V4YVlJWTBVN1R5S3FJUGxocFl5SWlpMmg2cGhRRlRkVmxrcG5MWWpZ?=
 =?utf-8?B?dzdBTjN4dUs4cVk2QmlWazF4ODc5TjRGazJCdStXaWJMWkwyK0I4Vm9ScExn?=
 =?utf-8?B?elRYV1VtNHpMS3Vvc1Uva1NBcUQrWWRqYTIwbXUyN1ZZS2lpcFdZTzJyaVh6?=
 =?utf-8?B?SDV1UktkUVFjSW1JSXcrekxjNUJvMDBRMGhwVjRndmZaamV2VHdXWHZCSTdj?=
 =?utf-8?B?V0ovSDlDM1BUYTZ6cnpkSGk3YXJqd0F1aFA2cWsvcFRzQXIrWWhPRjNZRHU1?=
 =?utf-8?B?L2IxUlJ0T2R4WTNLcFE0bXRnZW94WXZ0T1lhVVdNQkx3eEZqQlBtWFBiWnhJ?=
 =?utf-8?B?RVJPcFpFTmJOTTFsN01uTUpnMUFwZ1pvWnRXYzJUbmhuRVlKNnR1YnFJNVRs?=
 =?utf-8?B?a0JuV2trK1dMc3drTks0VTh6SDRQNnF1ak1GcVRHdFRXdWFKT3JwL0dlRnhX?=
 =?utf-8?B?dm1kblhJdFZReE4xV3pDT1FScEdKZDNVUk1BVjB3WTVzL1UwcUpqMHJzZzdM?=
 =?utf-8?B?eWh5eVk3aUZTYlpJLzdaaVNKeGx6aXAvWHBTZXZSMFc1TExsWWFjek1HcktN?=
 =?utf-8?B?VmVVblVXSDJPZWNNOUM2VWFUUkxpRzZaM3pNQW41SCtPTTBVY290SUh6SUFq?=
 =?utf-8?Q?rffAnnMiH4DLW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFVDcU5uZC9rRTNrVWppVFR1Nk4rL0V6aG8wbDFmOC8yM2ZBeS9MMkdNM2Zu?=
 =?utf-8?B?NnVMaWErdWN0dzN1QU5nZ0ZoWUhybncrM3dEdnpCUTFrWHphdHljSWUyM2VL?=
 =?utf-8?B?OEE0VGdaRm9vUFV4bXgxcFBtN1c5WTJla2lCeEovT1RHeDVDZlU4ZzgzMDhX?=
 =?utf-8?B?dzBrZllRcGxzK2FjOXB1ZjQvb0dBdVBQamFPMVNuN0pZZ2hKZnVjclFCeUVS?=
 =?utf-8?B?VDBwSEZQeXl3L0JhQkZtdWxYOUJuZHFGY1R1MFdiYlNYMlExZDVjMWZ1VWRU?=
 =?utf-8?B?SWFCNTVUdVhUVlFQTVJIRTdHeDd1V3J1RVZneDR5M0Vlb2ZiRjFFVzk0QmYw?=
 =?utf-8?B?ODlKZFBPcE1uT2JLQ2NMMkhaRU1selloL1grbGRIeWJzQWhZYk1HUGhhYm9U?=
 =?utf-8?B?bWh4V2VPVmF4QjFLZTNyVEhDZlpOdE5QajIvWGk1cTNhb1dQVmwwcmlrb1Br?=
 =?utf-8?B?Qlpmck9ZTGxoN1Y2a3lVRmNvVzI3QmFUdWltTTVqWEd5cWx3K1VpVWxQWjAy?=
 =?utf-8?B?T3JYbzZqL0g1bHdJRy9aaWVSQUVtMWRONWE2NWp5alFOK1E5NG9IclZ2dkZB?=
 =?utf-8?B?Q2hFYVh5TXlLeEJONXlKekJTbHJWc3AySlFETFoyT1Q1MUMzTnYyN2JEQjNp?=
 =?utf-8?B?bDBZektyYU9qMVBGRjJDVEVxeituTGZHYlJWcklva1RUV0VlelNxSlBveXdY?=
 =?utf-8?B?dGVoMFBYQkU2a0JYVEd5T3hJVDVnT0hoNnJsTzA5OTJpTWdWdStWNmNWMDc1?=
 =?utf-8?B?Q1JxWElsZ1J2akwzWUxtMXdSYzZwbkxzUnVPZXIvTzB5aVE3YnRDTjd5RG90?=
 =?utf-8?B?aXc0Z2thejNGazFIaktCQWJObWFNa2xVenpEYUgzSjRlL2pOUEl4UStWR1l6?=
 =?utf-8?B?bC8xMEdkbHdyejhremJ0YjVwNjdXc1JYSm5Ib2RPcUx0SjdUa2lYaG5NRElV?=
 =?utf-8?B?aTUvRWFDQUFuZk1pdGlvQ0J5Qkd4L3k5YjZFMmFtNSt1VFdkN3VZOElvTndB?=
 =?utf-8?B?aGxkYXpPNGIvd1FCM3pTMGJKWGUrQjVFaEZZcWlNUWJHdGlQTFp6ano3MkRj?=
 =?utf-8?B?eDIwa2N6R015aWNPWDNBdWhmd0pSRkhDcnJYQm5KR1ZleWtnMjNiVFEwbGQ4?=
 =?utf-8?B?RnRkRUZocU1kdHlpT1l2WWtPcFpTeFdJMEJQcDE1NkZjUWYwQmg0NUo3UG4x?=
 =?utf-8?B?WmtDUk4zZTF1MG0wNEEwR0lUWUpReElxTDl0NGFPSVpLeS9YUlhNQnMwTDhq?=
 =?utf-8?B?OHNQSjZhZnNqaExScVVaWFFMNUtLWkdqRDE4MU5vcnUyeTA4OXpPRDc5UG1o?=
 =?utf-8?B?OGg2andqSkt5RmdOdTRLS0k3WVpGR1owM3RweWRwWWhHWUVGRG4wNmRJQzdw?=
 =?utf-8?B?VkdpSHVWV1VQRi9rSG4yZk1GdVlMd1RHVjRhdmlJNWNwSGhuQlZybUw0bkdp?=
 =?utf-8?B?dlJGV2ZPUzlzV0lwUk00dVQ2NlgwRGFZUkRDNXM3cld6SEl2dkMxVjlmTVAz?=
 =?utf-8?B?S2NLbUU4QVA5Q1d1ZEtGYXlhT2ZZbTVqTVgxZnFoV3A2Z01MYWZZR2tybGlm?=
 =?utf-8?B?QWppU2t6eXF5YXhRaks1OXEzM1BXd21Bb1A3VzkvdC9LMUE1eXQ3aEYvTXly?=
 =?utf-8?B?VHJ6R2ZyWWRKdDVsemhiQkwyVjU4S2ZWQVJWTE5lTmZMbGhsR2pPTXp6MUxy?=
 =?utf-8?B?L08rTmd1eFRxNGNIdHJGSDdVUHdFakxoRGhTUmxVbFJkcG05SU5nLzJHWVFN?=
 =?utf-8?B?R2M1bXJBYmRZeHlIZFAySFhPMUU5VjYyaVBhK0FCVlNjeHpXRG1KcWM4c1Vu?=
 =?utf-8?B?aDhlRHZtZTIyMU9BL1BzaXZMMXY3dy9kUjJnSiszSUlkNmpON1hUZisybnJs?=
 =?utf-8?B?YkRlNUV5ZjlkSm5lcFhQQjVJWjR0QWtkdkdMNGNkbmFFOXNPYitzdmk3bEFR?=
 =?utf-8?B?NkhVRFFiVTM0V0RzOWw0YVc2Zy8vTCttdWl4eExDeUgwL0J4aDZEWEc0dG1m?=
 =?utf-8?B?NTQxaUgrTExuZVNSWVUwZ1ZhTHhuby9DbHVyUjcrSFhydnJZdVNuYmlsVlJ6?=
 =?utf-8?B?WkRZOTVjRnd2V2g4NGY0WmR3WVptdFBmeURHREhIZTVpc0M4SDN2eHpFRmJK?=
 =?utf-8?Q?0mbSP+K2V0gE6iK909YYJCoav?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41ce7b8-4322-47ad-d8cb-08dd2bb24963
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 04:51:29.5499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mq70FYi3oaNIJH1B+ruUFbBfVEghdodznK4B38lJF4lnUXmOdEO3+ZLU1wcNe9vbS4W/yAzovtdZ2hrvhSjtzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268

On 1/2/2025 7:42 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit 50a062a76200 ("cpufreq/amd-pstate: Store the boost numerator as
> highest perf again") updated the value stored for highest perf to no longer
> store the highest perf value but instead the boost numerator.
> 
> This is a fixed value for systems with preferred cores and not appropriate
> for use ITMT rankings. Update the value used for ITMT rankings to be the
> preferred core ranking.

Looks good to me,

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks,
Dhananjay

> 
> Reported-and-tested-by: Sebastian <sobrus@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219640
> Fixes: 50a062a76200 ("cpufreq/amd-pstate: Store the boost numerator as highest perf again")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 66e5dfc711c0c..f6d04eb40af94 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -802,7 +802,7 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>  	 * sched_set_itmt_support(true) has been called and it is valid to
>  	 * update them at any time after it has been called.
>  	 */
> -	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->highest_perf), cpudata->cpu);
> +	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->prefcore_ranking), cpudata->cpu);
>  
>  	schedule_work(&sched_prefcore_work);
>  }


