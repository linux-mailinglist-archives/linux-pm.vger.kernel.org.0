Return-Path: <linux-pm+bounces-8968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EA8904420
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 21:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13AD284BD1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90CF74BE8;
	Tue, 11 Jun 2024 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0EHtfkwz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25169475;
	Tue, 11 Jun 2024 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132448; cv=fail; b=cqB1wD3SeGPLbdctClZbE7J4i3NMBEm5/yXO2kskHfOZxDBsM8cvGrNXPObrVdhHWFq0xYXTGuPy4qgopynAjU2UnagMl4XbG4ho0d4CiHZZ7B+Q9l2h5bpBkpBBtsZSAjcM1RbEGlhRXzOsLfc2M4BP8rId4YloVKROQ3uFmzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132448; c=relaxed/simple;
	bh=pATmLLLtRqw2MQNz7orW+TfQe9GeeTJzYVU2X3rwW34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hwLS7wLuLrpkmlL+dSR4fRdF+VpfmqgjnIL2QNjaRIY88oatOm1cndk8gyowPtlSKWSV5euYhLn/QMYZeOymfeKA3NzYJzY5v8fkC6+/cAIcaTka/qC+Zg5jksA9JMq9aTxCh/bbHGsG4DISpV4fD5kAAzzwhLLCmk2qO78ypXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0EHtfkwz; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5J0sSL3Qsow1WQFK0YpZnIK7bXdqPBPF4JVsNxvgFA6osWeVoJl3s8RhIG1Nfm8ATSvdjLaVF22GVRDwsD4jsrOhUWeWgKbJt5ucWi9+iAS5yy6ItJhV8UnrKRdjDy4bEh6siIiI2V2j969EW2pDuYb/iuN5YcfACldrTlDY9nSC+91f1hFbNlkzAarXOisakgAlhqvo2HQmHDhQWLsJWOalBskvY0SNUYSvIkGHCEFSLoR84n3pXNF+YnBJgki62a4yTmA1oQ02TOhApMap6qQ4MoWbQebNvahrH2Jm4w81bkQ+bQbGX9hAEWkXVob+faD8K6xl+oBIxGHko65NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2chL0eL6F2bFKncyPxN2Wf7AjpLvC/04TuPJhXq55KA=;
 b=Cyib2WtG8s2mSWcm6NxxI17xlEmpKY53YpOoYNccDJvuuXLL37sZioF3FbqYtZ+Qv2La/eAqQRh/hqHr8P4XdvMWU1MIg+SI+uqc1TBS+0nZDjE/RIczk3OCQnuDoeQt6wwWBNyzKGqXGtjOJugTUKQw2Wq5jwfPJoWgGJn5zrU3Ex7lkq8ipqQAMIbXqLMMcdA7T4Mc29ywdsx8FORfs9HtbGX6JZ7USY1IADB0KLfOu96qsYsTU6ctk2pCDyeS0SavJ4/yLYJ+uWYjD4C3hrOkwqsDKzJKset84ETy/XffA/emMe8eOZeQSYv0dnM78/CLV6Ljsr0g1uYjbtHs0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2chL0eL6F2bFKncyPxN2Wf7AjpLvC/04TuPJhXq55KA=;
 b=0EHtfkwz7JouciK/jy94OquWrwDdPwyNqOCdrmD2vyg92onacyBaEshqNH8OcYCaJ+VFZf5blugFp4xDDWquC9R2fOagcusnC7EYPCuZJi+pth0r+PYrt1t7JG+ywS6HGrQATMEfo/hLHY0sQW0CTJ3pQFl5PPJSsTE+Hl2Q4FE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 19:00:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 19:00:43 +0000
Message-ID: <109e470b-b408-45c4-9ba9-96a2b3120b02@amd.com>
Date: Tue, 11 Jun 2024 14:00:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] cpufreq: amd-pstate: add debug message while
 CPPC is supported and disabled by SBIOS
To: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 Borislav.Petkov@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
 Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1718095377.git.perry.yuan@amd.com>
 <adf1b81c44806e73a391aa6bb49a9fddca95550c.1718095377.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <adf1b81c44806e73a391aa6bb49a9fddca95550c.1718095377.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:5:60::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df29e7a-0349-447d-3d4c-08dc8a48cb13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkxQQ0RkTFJ5VWF1TFlHMkMzdFJteXl2QnJNWFRNNVh1RzR1cjRXR0ZUZU5j?=
 =?utf-8?B?Zy90ekpKUWpsd3NOTnAwL3hIbUovQWpCS3BGK0RrclFIUnBMaVFObzRnMkl4?=
 =?utf-8?B?QW1xQ0RmV0dzN3JEY0VPOEZIbHprRnl3SjFEN3VSVFZWVXlQcmJYbkpNTjFF?=
 =?utf-8?B?VHhZckgyUWpVZm5UZjFFdFZmRitSV1pqQTA4NFVVRXdSalpxTGwxOWZxendF?=
 =?utf-8?B?MXJNcXJYVlRtTkRWeHJvbXlQcFBzMVdCdEhQUW5JQzJQdVpKZGw4KzUxbmRF?=
 =?utf-8?B?K2xHdkdEaU9NWmNta3NHbGFyYnkyM21Ha3NLempad1FiMzJFSnQ4Y2Q4bDBp?=
 =?utf-8?B?bjc5Y3owdlVFNE0xM2IxMTRuRzl5dGVHazJzUjljTGZhbHh2eitRd3FtS2Ix?=
 =?utf-8?B?eVpsMlRxTWNZSTBONnp5Z3MrUmc3THB2ek5HUlJCbzhMUkZxK201ZDZuRTFi?=
 =?utf-8?B?KzYxQ2Y3SkFhWTNUNXY5VjZhTHd3YXdlTHBUQnRlc1VLejh3aDRiMjJiSjB4?=
 =?utf-8?B?QlVNcmRqZ0NYbkIxZGhEdWdxL2FuZlc0L3V6eDlyNFJkc0puemdHRXZjRzFa?=
 =?utf-8?B?ZWI1b0o2WkoybSszTUkyM0hCa3o0d2dDQ3N2RExsbkxOSW1xV21WRnZDUEtP?=
 =?utf-8?B?MmFWcWlOLzg3MGVvYjBDeE5EVGpIcnNPdkdZRkh0RFR1ZDYvNkllUlJYZXUv?=
 =?utf-8?B?Wm01N3BkN2IvZ24xMzJBdk9qTjZNeGdCNC9mZU1BQUgrajV3K1Z3Vy9oelNR?=
 =?utf-8?B?eTFFYlJYTms4MENKVnd1NUFtSFJsL0EwRisyVHpZaEJwVXZ3UWxnTFJ0RmJ6?=
 =?utf-8?B?VWEwREg0QjZUMHdwVzRwWWpQWU45K1dYQWo3WHBTT3lJY04rMVN0OEFPKzlx?=
 =?utf-8?B?R1RvcUYyVHV0VXlSNlUyaGllODhwcHJMZzlDT1lrV0lobUIycndNYmZDZlFu?=
 =?utf-8?B?amsvM2xGSWpRTktZVExlTHZ3ZTBmVzh3RXpJV0FUeDVxcjFybEtGVjBkdjNO?=
 =?utf-8?B?NWZQanZRRTVCaTRYNFk1NXVLSW5IOEJoTGZjaDIxRTBjRTQ0WjRHckxIS1RT?=
 =?utf-8?B?aVhLNzdBdGEvdXRZemJTWFY1NkZ1d0Vtc2EweTB4K0k4UEZ0cE5WWC9BUXJo?=
 =?utf-8?B?NlhkS3NHREtVWUtNT0R5aUtudGJ1bnRCOTdNTUNuNldwR01GWnd1aGE5dk9B?=
 =?utf-8?B?VUZGcmllZzdVR3VaNlEraFdEZVdpMmJ4SkovcEgrS2UzRlJWczVmdGttRFJF?=
 =?utf-8?B?QzlTb0p0Q2lOWEtodktyQVA1cjc3UGI1dy95TXdxaVRIUGpKdEJpbUQ3SUFP?=
 =?utf-8?B?MCsyNHFiREcxR1ZSU1h5c0YrZmdxS05SQVAxaGRKam95aW90WTZLWUpwTHZH?=
 =?utf-8?B?OXNUdy9JaTM2c3JGaVE1Y1NNdHo1bS9hNnZmbWNlOVBGK3dwdVhteGFSNitZ?=
 =?utf-8?B?S3ZwVHhTeEhtaHJHN2ozbnZCMkg3NndRb05wK3B4M2NTbVRKMnRvSWRrcTBz?=
 =?utf-8?B?R2duZSt0VlU5c2VxdkFDZWZHbzlhQmhqQzVxOWZpVUFxNjlEaWRrYnZGMDdF?=
 =?utf-8?B?SHU1NjJ2Y0dQMER2NHk0bFpWSS9PbTdSS2RvV0tYcDlQK2E3RUpCL3BnbXpT?=
 =?utf-8?B?R0Jzbm11N3ZudWxGL2txRVNIM3g0TTROem13ajB4K2Z1S0dTL1p3QTBWMWpK?=
 =?utf-8?Q?UMovy0lC8aCZibnWjuqI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGZKTjBNVGUvRmNiQlhuZWJ5MVMyRThqRFN3am1CTVAzSHJETjkyYkdqSUUz?=
 =?utf-8?B?QjBna2h5azBtK2ltcDNhTUd6UEhKaE54TktKUFlLV0loZWRZMFRzWUVpdGxE?=
 =?utf-8?B?cXhOV3dSUjNmTFFuS1o3eTRBL0NnbXBBdEVNMXNoUndua0krNHJoTjVsN3NG?=
 =?utf-8?B?RHg5UE1NcDFpeHA4QUNveW12eGZTQW1yZVZ2cVEzUWRSYUtwblV5T216eVlw?=
 =?utf-8?B?TUpidVExMUhyS0ppd0d4NklZZG5pVkdVZGZvWDhsQU83Y014WUwxT3FtbW5i?=
 =?utf-8?B?ZUU0UU1qWVc3TldZQlVyYlNnQ2xBRDJ4Ui94SmNhUWliYmFrT3c0eUJQSXVv?=
 =?utf-8?B?VmlFQ0I0LzhpOXNjbUNVdkMrVzJTQ1VMVDd4SEM4c2d2Um91eU5sY21XN0Js?=
 =?utf-8?B?UnE4Wk81SnJVYldIMVYwcExIbGNLWit5UldtWnhQL3Y4clQwYU9GaW1sV0M0?=
 =?utf-8?B?TXJmYWdRNldwNjZ2QWZaWTZjUWYrUkFjbEl3SlVFMjRYRG45N2xrL0U3dFEw?=
 =?utf-8?B?YWM1bkptek9QK3gwMHNHMkpjY0UxSWx6elNrMEdmdk9Wdk80OUdqV0owOE90?=
 =?utf-8?B?YUJRdkFncDhLeUFwSnhVS1JnU0NNalFPVWxyZHlxWlE3TDY5WG8xVndxeEM4?=
 =?utf-8?B?a0YvMkVrOGgrWlFCdnAwMmJuaStYVkg1cG5YdGYvN1FaQ1ZPZUdQWnFNOExS?=
 =?utf-8?B?bHBNRGJEc1VjaHVzbG9GOU5ZT3k0VCsyUUsyUDJ5WU00KzNWNE9laTN6WDZX?=
 =?utf-8?B?VHpoWHZWczdGb1JZRVlVcHk4NWY4ZG4yNEdnNmZ0T3gvZ0k4azAxWnNiNHRQ?=
 =?utf-8?B?Nm5ibGQ2d0FsY0RoTFhvb1NYNERBYWNJNVhrQmdIVU9pUTI2Y0pFM053RUdp?=
 =?utf-8?B?bVgzd0NNL0VxUEZta0ZGa0FCeFltc1p3alJCT2lLUWZBYnBLQTBjZnRCczZO?=
 =?utf-8?B?R2hPR3l6VEdNQ0Q3T3grSW45N0hJY0FDOWM4eXlJdlFGRmZFLy8zcVVXa2tx?=
 =?utf-8?B?UUNoNzEybjNvemcxYUZ6WUVvN1hvUHJNeTc0anNvQ0ZoeUU2SStXdk5GNDhm?=
 =?utf-8?B?OVREUDlWd3VVcTZwV3dyTGFKZEQ0dS9vMmxuT2Q0ZjY5RTZ0OFpBeitDd1Ix?=
 =?utf-8?B?VHgrNDdiZTh0OE9Ld29XOXBaQ29WQ3pZalNpdFE3U21EWVJXSEp2Qk5kdnpK?=
 =?utf-8?B?dkF3aSs5Um5EREl0V0RkWUNmTVNSYW1JejkwTkJzWEtyMWpZQnBSS1hnUHo3?=
 =?utf-8?B?TkFhZmtZd3dPOG02SWVaclYyTlp3RTVQMWNhd3NOcThwZ1JMM2pTekpUVVMv?=
 =?utf-8?B?RjhVdGtGbm5kMkNDVThnaUdIZThEa1NNQ1QrK05yZVVYTVlySVc4bS9Ta08r?=
 =?utf-8?B?L2w4bm5TN3dlN3VzQno2WFpNQXBSZWN1amZ6RkZrYnM5c3J4ZlhiZ3ZPYnBa?=
 =?utf-8?B?RUk4dFBxVGt4RXViK25ySER3bkJsVnh6UXJVSHVGaTkzd1YrZ2w4Y0JkZG5R?=
 =?utf-8?B?SVhlWmd1OGNHZ0x6dEttNGZKdjcybms5YWlrZUZ4c0xuMU9tWll4M2tpeWp2?=
 =?utf-8?B?cExqeFBkR3FDTHk1d2k4UFg4ejRJVkNLejhubjRmNnh4M1FXRjZER3RKWGRl?=
 =?utf-8?B?K013UlVMQlp4ZVc5Y3R6VHpOY0lqT0REVklWUC8vZGxZNjN6L3ZOa0VEaEtt?=
 =?utf-8?B?cXAwZkxFRzUvZ1FtVXYxYlpkTURId0drd0VHTml6elVORmlRQkhsb0NaZE9m?=
 =?utf-8?B?dWRwajhobTF5L3pxOHAxbm5vY0c0MDdCMTNySGovYzdBUmVWOTBvdEoxaHY2?=
 =?utf-8?B?Q3c5ZHFsQ3pBcEhCc3N2dEltdzROSmpZUkxldzhGUlQ5T2FhazlLVmlVQTd0?=
 =?utf-8?B?VWdRMW90MExSWTE2b3g3aEg1OXhEd3l5USt4cnJkL2d2MWlLc2szeGJUYjlH?=
 =?utf-8?B?d08wa1VFU3oyOVV0MDVTdXJzUGUxRHhSbHo3MUF1L1NkSTlVaDFLVnZiY0Ro?=
 =?utf-8?B?ZEMrU0JLNnJjaWFNT09tdUVJRHNEUVZNa1pOZjdQUkZ3b3dnSHVaajZCUUVh?=
 =?utf-8?B?dGNFNFcvSW1YUU9HaEVaVi9yRHIxL3BmY3BxUVVGOHp0UDhnZ1RabXcwdytr?=
 =?utf-8?Q?kGRG0A2Uz7YyRE/mByEVazu0Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df29e7a-0349-447d-3d4c-08dc8a48cb13
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 19:00:43.0799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8dn9DwDYN1MJKxTQ13ZZCJdQeEsykHfoDfEnWHvpxyi5o7v97UZLiFebgrC/O0oDYXHwrw1195zPDyRIuFH6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720

On 6/11/2024 03:52, Perry Yuan wrote:
> If CPPC feature is supported by the CPU however the CPUID flag bit is not
> set by SBIOS, the `amd_pstate` will be failed to load while system
> booting.
> So adding one more debug message to inform user to check the SBIOS setting,
> The change also can help maintainers to debug why amd_pstate driver failed
> to be loaded at system booting if the processor support CPPC.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218686
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f166b3b94091..6b9fc24001f2 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1746,11 +1746,36 @@ static int __init amd_pstate_set_driver(int mode_idx)
>    */
>   static bool amd_cppc_supported(void)
>   {
> +	struct cpuinfo_x86 *c = &cpu_data(0);
> +
>   	if ((boot_cpu_data.x86 == 0x17) && (boot_cpu_data.x86_model < 0x30)) {
>   		pr_debug_once("CPPC feature is not supported by the processor\n");
>   		return false;
>   	}
>   
> +	/*
> +	 * If the CPPC feature is disabled in the BIOS for processors that support MSR-based CPPC,
> +	 * the AMD Pstate driver may not function correctly.
> +	 * Check the CPPC flag and display a warning message if the platform supports CPPC.
> +	 * Notice: below checking code will not abort the driver registeration process.
> +	 */
> +	if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +		if (cpu_feature_enabled(X86_FEATURE_ZEN1) || cpu_feature_enabled(X86_FEATURE_ZEN2)) {
> +			if (c->x86_model > 0x60 && c->x86_model < 0xaf)
> +				goto warn;
> +		} else if (cpu_feature_enabled(X86_FEATURE_ZEN3) || cpu_feature_enabled(X86_FEATURE_ZEN4)) {
> +			if ((c->x86_model > 0x10 && c->x86_model < 0x1F) || (c->x86_model > 0x40 && c->x86_model < 0xaf))
> +				goto warn;
> +		} else if (cpu_feature_enabled(X86_FEATURE_ZEN5)) {
> +			goto warn;
> +		}
> +	}
> +
> +	return true;
> +
> +warn:
> +	pr_debug_once("The CPPC feature is supported but currently disabled by the BIOS.\n"
> +					"Please enable it if your BIOS has the CPPC option.\n");

This should be pr_warn_once() or pr_notice_once() IMO otherwise people 
won't really be able to know there is a problem.

>   	return true;

I don't really like the goto and warn label with two identical return 
statements.  Instead how about something like this?

    static bool amd_cppc_supported(void)
    {
	struct cpuinfo_x86 *c = &cpu_data(0);
	bool warn = false;

	.
	.
	.

	if (checks) {
		.
		.
		warn = TRUE;
	}

	if (warn)
		pr_warn_once();

	return TRUE;

That would be a better design pattern, especially if we end up having 
different classes of warnings to show to users in this function in the 
future.

