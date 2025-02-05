Return-Path: <linux-pm+bounces-21417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B12A29803
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AE3162E5E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 17:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0BA1FE45D;
	Wed,  5 Feb 2025 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u8p5piE2"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259CC1FDE26;
	Wed,  5 Feb 2025 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777871; cv=fail; b=bfbQIM6pqF9BZnOB/km0x8aFDLvBGZONEGmwNT7cKoJMvo0f1ZE6o+exH2VsIO3AUXNDLJaWaFDf2wYAI+/TnWH5GoWLWT3Q7SEm2pcjcfKJaZ/jMu9iXxS8m3YnP+mYRRpVUhlBSzXV1Tbp5WA+4TJFh7spg376rdSqRYuzsXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777871; c=relaxed/simple;
	bh=vW9eRllwsmMeaGvQVMtXKcL/vcBLszzOn+YKO1/ERi0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C6iCvCNrs/39Afn8lJn6MDGxJE8gAvhwHq2l4be8HFDLYEPzQJWIONv/S+7iuNZLYoIUKrfvxULP9vjew3kercnu5qL6eHuxA4rnIq5LrkCvZEq4eletVnjXjYVfDp73s0sZ5DKEw25bSD5S9f4rbElxRIu/R1YFRN4ZKxIPuBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u8p5piE2; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ow4+1LoKttg+fIwXY0wIIVwHaeedSY++1U8Gv7L4PMINA7gy/hWSrmJ2Fse/So1moS5teLsgd9hEMacZmc/yfSD9Tj6RQgwQ0vj48tOGnrrTickjwo0gg3T4BDpB9UsA+vK8JURK0t/vrTMghWtkR+cuxt2T2x/N9aIVfvurWRgTysRZKKq/PJcMt/0vVw+8CEu5gcxai4F7FHh/MHdyewM0X7GCFUY+g8CDT69Et0u5cR7jxJtIpBhtO2rShiJDNDKBsDGIJ9eYb1L3XDLz3pdiCyAk17RN/ez+dNygvNmNTPFzP8wJsUTpq17jsOiJnwKTIALlv6H99t/OFCKpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDrUac2URnTqX6VR66X8kcpCqjup7G9ym3LpDZZpaYE=;
 b=H/XSUDAQRbxK1AEP+dpm2EL/H9dDhfQaH1D23skDaPFBGFcTtxMnKGfxwvA2DJ8AZIAdKeENXB+kYg4zsVXNGYlqNCsuTq/bYNDcZ0F+Yp6ERcMuezHnW++XwqmF/dSn9KsWcB1cGA+ZQ/MjXNY19HHaMwW8ITdINT9AUes1SA1cQEC1OUkPUvX6HTDFfDRgIC9hyWlqAGCHkhexrSMzzSIPrR+M7l2L07WpGILMC4/s8sA53F/zAjk5uMJw7KwftChmGiFcnR5m5uaHC570vnkMPY5qYO5SQgQWiLBgOTowZCevR32tLXcA0VLOS/b4ae7crFIpsMMVIRDX9hvIGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDrUac2URnTqX6VR66X8kcpCqjup7G9ym3LpDZZpaYE=;
 b=u8p5piE2uQUs7IBy0hax/KkD7mzF5AGydu4NOXLv3nnypzeTMFyeSqBggutDSWG9roSdVAydBTRXAcqLLB0vfkbfZtPh1Vb+MB2Iwcj0MnLvH1iQAB1riwupxFJWd1qam+kX4y3Zejy8XlTzn/JsC1R4Zgu5XuHefKIsZ8Uas9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 17:51:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 17:51:07 +0000
Message-ID: <c815cc88-b414-4841-9fca-42453328a664@amd.com>
Date: Wed, 5 Feb 2025 11:45:59 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] cpufreq/amd-pstate: Pass min/max_limit_perf as
 min/max_perf to amd_pstate_update
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-6-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250205112523.201101-6-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ROAP284CA0223.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:73::7)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dae5bf1-7f50-4c56-cf40-08dd460dab2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUp6aEptVlIySHY4Unk0b0lZdVM2UVRjbzM4eW93QlI2SjVuUHFSTDJlQzln?=
 =?utf-8?B?MEpqUTdvWWZyQXVaL3kvYUxEbmNTNmo5VVR1UVkvSXRLMVlzZjVmd2hHN1Jr?=
 =?utf-8?B?dEdGaVNOVCtoUFpKNHJKR1RaQkQzN1BvM0MxNUcrM2ErdVhxdDhDcCs1OTBk?=
 =?utf-8?B?b0xQWkxLVjRCbWk3TEhVN016OUluaHZKb2NDWkE5VFZpQ0Irb1puSzlTN0d3?=
 =?utf-8?B?RExtaU5CZXo5NW9JeXp3dmhRVXpKTnhvd2FCQWtpdlVLR3VnTUs2SFNiWmdJ?=
 =?utf-8?B?aFNZR3NSc3dzNzBvTnVqYXl6R25ubGVJNXhPbXlYdHNOM1BJQ29TdkFEYzQ0?=
 =?utf-8?B?KytNVHpMMXRvN01UN3h1bEN1M2tIdVBJOEdCR3VkK3B2U3pOdmtpT3RjdXlv?=
 =?utf-8?B?KzJPbFluckZGY1ZqMWFxMnZFMWlGeWhaVVZGSWdHYnJ0YWNUQmFEbkgrenVN?=
 =?utf-8?B?ZnlNOEJFYU42VGhkVjIwMWRvNGFCUG1aNXpaSDVpN3F1VHRTR285czc0MklX?=
 =?utf-8?B?VXgvd0NRdTdnKzI2OHhoZWtmSEdDN2JZRjBJdStPcHd3cXJpNmxaSWQ2K0U0?=
 =?utf-8?B?cWVReFA1cTI5WWZ3M2R6dUNibWM2b0JoMWR5N2dtQ2FPSk1Ib09VbG40dUhY?=
 =?utf-8?B?S2hvNXMyalpOWFpxUzhra3pKc0NBdTVRWXZYZkI1WGQ5UjB5eGFwNGdPY2ti?=
 =?utf-8?B?NDZTZzk5QndoaytjenU1M1lPRFU2OUcwSDZIZk9QbjA0NU96TW45bVdUOVVn?=
 =?utf-8?B?ajkxRlR5bjM3N0REbVVFY21yVE5KOFlFeUdkVjdjYVUyUFRKSG5iREQydS8y?=
 =?utf-8?B?VXJycWxabU1jbHB4di94d3c4Q3d4QTZFR2psbmJFMWNuVngydnd4NlFVRG9S?=
 =?utf-8?B?NWdqYVYyenFlR2pOZWVCZ0Q3R1RQOWFCdzVZaUtkcml1L0o3S1NBbnUvQ1Zw?=
 =?utf-8?B?QUhoaU1uY1ZidUNheUtSMXhLQUpnaGFvR2NlYmFlRGN6djdYUUxkbmVmT0lD?=
 =?utf-8?B?dTZrdzlQaktNZ1ZIZE5yRnQvYWd5aVdLRTZOU3UybDdCTGp4NExydFZDeVRz?=
 =?utf-8?B?ZnZCaXltTUJRZEpHRFdRbStjTkZrSitTay9BVWJ4Z21oKzhRelZONEZPUnRp?=
 =?utf-8?B?Y0w5Q0IvcXgzSjlNcm9BMmNMY3NTMmtLRFpQMnR6S292dUdRQm1EOFd0TDdE?=
 =?utf-8?B?TFhGUjBzYnhGTW1JQU5vK1lFSWZRb0JmZjgrT1JDZ3hqTkIxNXhJMDlLNGg0?=
 =?utf-8?B?UXFjZks2UWtLSk14dlc4LzI2V25LVmc4dmx5R0VoMHluckJaQkZ0aytJRllw?=
 =?utf-8?B?THZOME9xM0h6L0pSMEx4RWx5aTRtSmtIeGJtSXU4WHZVaHk4Y20yZmxmQmpC?=
 =?utf-8?B?L090Z2ExQ3I1WFZObjNFc3hpdTRNSGpLaGU1UFJyVUE3UlFwSTFxbGJUQnRj?=
 =?utf-8?B?enUrUWxEVWZlYXRNRVNPWGNacVg1NUxXaEFlU0tybFRCNmR0Y2M0MXQ5cC9T?=
 =?utf-8?B?M2VjMWloSk01OUNwMkJxTEU3WnhUM3RhVEpUbjNTeU5TaFA4NVFNSDZXOFJD?=
 =?utf-8?B?RXYrRUtFOUpQUzc2WTZoQjA0elJURndWeUpTQ3p4SG5rb3RHeDNpUkNSS0Yx?=
 =?utf-8?B?cDUzblI0b053S204SGk4WnlpbGVYd1g1SU9xalZyMHRibG9reHZVRnZ5cUdB?=
 =?utf-8?B?d0h3SUFsYmZnOUFzSGhIUkZXeG13bmo1ZmlCTS9nVllnc3RmWjlVMmxUeHQz?=
 =?utf-8?B?eHc2NU83UUNPUXliZmFHdjdZakRFeWpOMnlmNWpZUTJ0VHVXNk1VajlMZzJZ?=
 =?utf-8?B?R2tmOHk0L1FJaFFkQzFoTmtDL2JqWkkxR0xrMkxWNXl2dTR2d0VJSVY0Y20y?=
 =?utf-8?Q?X2rMakF3HZxxP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUNyaTlvQm9iQmx5MnAwd09DbEpiNlp0RUg3VjYwbFFCT21VakhGZTAwQlZj?=
 =?utf-8?B?VE56MnFrdlBrQVFCMDIybGswZER4U1A3NWRWZmRYL2g5T2NjMFpsRlR5UUt5?=
 =?utf-8?B?WDZOZUpFZU1lblRVWGVDN3hZQktCdlhRRUVOWmp2Q0Q2dDg0TmZnTkxaZWc3?=
 =?utf-8?B?Ujh0ZHB0K2kvcWZpMHdzV1BMRGg1dDViSGgvOGtGWUxMMmJQeTB6U1pLZDNu?=
 =?utf-8?B?VS9HZTRLUHhJSUNwV1NhelNzbldWN2VtR1VUUmJRblNmTUtSSEllTWs5dG1K?=
 =?utf-8?B?TVc3T2dVVHhMR1Y5cmYwRXNkMmduZllsV1krNXVNTXdwTnJ1eFUrc1NNZElo?=
 =?utf-8?B?MHBwVStrWmRqMjVBM0dOdUJnU0pmQ3g2czR6TDRTaWlFMDJjTU5wVk1mMnJU?=
 =?utf-8?B?RUl1eHArZmRSOUMza1JkVHJOR1BZUVRYOXAxbVRqNjZkVytkWEJRTkVWeGl1?=
 =?utf-8?B?TS9rUjlTWWxyamZBbHFDcFQveldvVmVqNlhkZU5QeHd4bXRwNWJsR0JxaFhi?=
 =?utf-8?B?ZWg0N0dVSWtjcWJpSnEzOURmV3hGZldhM1NmcU84UnVPbGp5Tno2WDRldmc0?=
 =?utf-8?B?SlVnN0ZCc3FZdlRvZTBuSlU1RTRsYU5RZm9GL3pqWk5Zd2gxTU56cmt2R2dp?=
 =?utf-8?B?SEZOSEtSaTZjaHRBVXMrbHpRN1NnVnYwOGdrbkZ3NENwemtEUFNDRHRuOE4r?=
 =?utf-8?B?VVdZV0JneFZKUjdIWllLQjRCcmFHSDdORjdsc0QyZWhvYVZxcUJKaUJiaDA1?=
 =?utf-8?B?clVNcHFzS0xuVTZBazA2WTlVMEIxMmEvdDBuRDF4L0o3SDFUM0oyMytNWXBa?=
 =?utf-8?B?VGFBRkdobGh2WjZWUVA3NDl6ellOZnhsa0lhcGh3UHV3TENVc3FhVnRSSnN0?=
 =?utf-8?B?ajN3MDJwL2thMGUvc1hldjRHZU8xT1VKUHVRQXZzMzFJNU40T2h5Z292SE5z?=
 =?utf-8?B?bVZZS0JJRWJna3dzRnRPWDc2U3I5RjBweDVHK1hjeEovMzZPMjBsMUVUQ1pu?=
 =?utf-8?B?ZXEzMmxJQ0x6dFg1bXRwM2t0bG5MZlZWRTVjc1o2d1NXOU83M3VmM1lsdjRn?=
 =?utf-8?B?NXp5ZXZiY1pyZHhjVGd3NGpRNzVFY2c1MWhCN25hRHR1bHJEcEtBRjdMdVRP?=
 =?utf-8?B?VGF6cllUQXhIbkVydWpmT2NwdUpVVnZGZDFTRHZjZXZ3WDU3VW0vcDMzbnZQ?=
 =?utf-8?B?N1MrTUxPSXlBdVQzY2RWSkNVSnluV3pQK1lKK1pBSHJyYkxyNCtBZUkrSXdS?=
 =?utf-8?B?YjZYYm00ck1pQmc5RzllVzVKcTVnd0t6cXNHSG4vOEdsQzMveWFnQ1VwcHc3?=
 =?utf-8?B?WElHTkVteE5DdFpIb1NHSTR6VklDRzgybXU1dUx1eUt4V3l6QUE3M0k3RFo0?=
 =?utf-8?B?U01BbThYVHZHNlB1TGcxQW5ZQWJ2eEdsVWp5eGErazRnSjlqSFcvQzk4bkRk?=
 =?utf-8?B?V1lKZUFzOHpQczBxTy9TZ1FINDc3cis1bk9LT2JreGVpQlJnZDN1Tm1Ib0dP?=
 =?utf-8?B?aDdPbVdEOC95Q29DL3dIOGtlYWlTdDU5bXZ0MFUySHJlOVBqUUJlTllwejVw?=
 =?utf-8?B?YVphdmVpTUg4UU14cnVlMlMra2ZnNGw3VjVEVWpFWUU0Y0JYSVRyRnhsUDJ6?=
 =?utf-8?B?a3crV2tOR2lxTm5lZzUreXBXVG16aTQvWFBkbU5vdmRZMjlZR3pzdkZzWk1Z?=
 =?utf-8?B?R2hvR2ZPYnZTYnNJVUpUbE52QUhoaDRSSnZoM2FoOCtQd1d4dE5JVUVVZUoy?=
 =?utf-8?B?d2VkdmdIME80VnlwcDl6aXA3cGJHNlFWeUJxenI2ZUJCNHZPRnBLd211ZGxW?=
 =?utf-8?B?NEJmZjZud0VhSm9jYVI4aEhMbDhOQW92Tnh3Yml2RWNtT3hkZ0VRaU9LSkhi?=
 =?utf-8?B?eEFlN08wTU5mL2FuRWcxNmp1dXhNSnQ3YmVMZmNmTHhzQjZVaitMS0xMNHdG?=
 =?utf-8?B?SlBxRDExOXBZcXVuL0JlU3k3ZDZQSjZTSXpPOGpKY2QyOVZUMUtiTW9WSVhW?=
 =?utf-8?B?SEJHNFZ0c3c1MEY1VGRqdVoyWmhBL3V0LzBWS3E3VWRUUW42Y0FtQVZaekti?=
 =?utf-8?B?bnpCWUZxNzdzcXZjNkVqVmVMVk5VeWFpKzVOc0hONzZUT2RCMEdaanZ4VUww?=
 =?utf-8?Q?reUvKQ2817cK5i3/7uw9HSA5A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dae5bf1-7f50-4c56-cf40-08dd460dab2d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:51:07.9155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvD2bO/5jGOlIO96di/WOSoCEKxHOZjVw7HVzdi1Ys7Hp7kubw/R3wFKLSh3vDxdioWPa9y5Clwn4HUTHrvNuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881

On 2/5/2025 05:25, Dhananjay Ugwekar wrote:
> Currently, amd_pstate_update_freq passes the hardware perf limits as
> min/max_perf to amd_pstate_update, which eventually gets programmed into
> the min/max_perf fields of the CPPC_REQ register.
> 
> Instead pass the effective perf limits i.e. min/max_limit_perf values to
> amd_pstate_update as min/max_perf.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll queue this for 6.15.

> ---
>   drivers/cpufreq/amd-pstate.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2926f292be7b..e179e929b941 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -615,7 +615,7 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>   {
>   	struct cpufreq_freqs freqs;
>   	struct amd_cpudata *cpudata = policy->driver_data;
> -	unsigned long max_perf, min_perf, des_perf, cap_perf;
> +	unsigned long des_perf, cap_perf;
>   
>   	if (!cpudata->max_freq)
>   		return -ENODEV;
> @@ -624,8 +624,6 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>   		amd_pstate_update_min_max_limit(policy);
>   
>   	cap_perf = READ_ONCE(cpudata->highest_perf);
> -	min_perf = READ_ONCE(cpudata->lowest_perf);
> -	max_perf = cap_perf;
>   
>   	freqs.old = policy->cur;
>   	freqs.new = target_freq;
> @@ -642,8 +640,9 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>   	if (!fast_switch)
>   		cpufreq_freq_transition_begin(policy, &freqs);
>   
> -	amd_pstate_update(cpudata, min_perf, des_perf,
> -			max_perf, fast_switch, policy->governor->flags);
> +	amd_pstate_update(cpudata, cpudata->min_limit_perf, des_perf,
> +			  cpudata->max_limit_perf, fast_switch,
> +			  policy->governor->flags);
>   
>   	if (!fast_switch)
>   		cpufreq_freq_transition_end(policy, &freqs, false);


