Return-Path: <linux-pm+bounces-20338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD19A0B958
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 15:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8923A0264
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20749233138;
	Mon, 13 Jan 2025 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="24e3WVig"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B40A22AE7B;
	Mon, 13 Jan 2025 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778181; cv=fail; b=cKzkMfqqcRNMNrUB7WUHxOnA/7+F61oMUQBnLsKA/cpynl4hxx1NK2SQ5910rKsBNBGJmu6sM2uCuLJSFaNRyFDHp7vTomz5yo2RYO/ubL8wxqI0uN6UdVZ2vzfZq6Q4tXCixjCO25LntQZRVeg7IC4na1PKACst8xvBZh9cXDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778181; c=relaxed/simple;
	bh=04cJB/jntktWwt67rpvqCA5YuqPMRfo+sY1auaLYjcc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ognO9Kr7GtbwWe4cF2fyOLL/NHdBkxW/2lUDlMMD7xAbmxE4V2Wi/h67RLAD7s05QKlp/TIEtlCWNciOsKb3VQmiQvZ46F381GNpAJH4Swnq+Xh8Oq1ItFvJjoZPni3hs1HsKnboGk6c/H443TJNBqQx30Wq3SW9ANLWjqoIDxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=24e3WVig; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlQoTX7wGxN+oM4TXqdOM1ZdGqwW3HVXYE4b6HZRjqh9JLtuYmv7XFpYUtlbvj+7rc8crCHZpI3d3TTr16N8Y7q9RquOu6RAY5UCCYMqpHcdBbdZfuDJPTdild6n9tU/I3rIMPvPDqApiUD5BYibc1SpFaexYtcGOTJPwAHFWaH/iIO0uby/LibgIos4ErP68Elmv7HLg5Jv3XkjBXQyfZDCLPMdN/C75HYFf8XYx/9hvHcjVKaPl/GbPiQ/uUW0ZBC7tAyLY8tV+g86O1tE4toDic4EqpSLi8YqXa9OPTLnlxve48EMnMOyUOHr2IKDNPZD/Kb1oQS6gwcKA6X4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDiYEd3SQrJAQBppetr5+znHtoyTt46lxoKrKboVoeA=;
 b=E8MBIYAdZ7i9J4nfg3lOFMOzCRttKbQCFmyVFytSYnK0fzFAbzI3Oc5qNrlfEeDfOUohaDuI8XJPP0nuJyETvPLV1lDkHK2D+F3zclD5NNfabk3ICc8YHVaMBascyR5tv4yic1fsCf4vbUH5/5eqGq33kyDunT1WzVCjNHQS08XvW2Dc0m3+nehmLlN5FcjOVpyExpWwwZwq4OIQ0W38InzxpGg03eNRq7HiPHMs3WQKEJhW4FDY6K14eQ0TruYyfAzHnR6bZqNWHHKorjTIEeoUwoJSQsyZOSYsBBdITxo5uKa6ChKk6WNJ8ZD2bM3t8DzE8GuxmwcYSInz13gvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDiYEd3SQrJAQBppetr5+znHtoyTt46lxoKrKboVoeA=;
 b=24e3WVigCJnIY8tzVU6h7n2to2ViNa7f7XR/JyH54+r0wrVyqZz9BuqY7tndNvuBwrnpY8GNzN/h8V8+Y7e1gWnhOB45R3Go3LdiMMta1SRr+9k1qG9cTtmuZZKfmZyRlidIG5NEWm3yoOi8wYNv4F4CFkBf+L3pQfiAtJThCqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 14:22:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 14:22:56 +0000
Message-ID: <98bcf90d-0bbc-4bb5-b678-67296e476680@amd.com>
Date: Mon, 13 Jan 2025 08:22:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi-cpufreq: Fix max-frequency computation
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Adam Clark <Adam.Clark@amd.com>
References: <20250113044107.566-1-gautham.shenoy@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250113044107.566-1-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0111.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 05466be9-d513-47ae-be26-08dd33ddc5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTZSK1dPUEZoUHRZaHFyRG12Q1BoV2tkK3djK0FEak5MZzJ6ODhJT3BlcGV0?=
 =?utf-8?B?N2VVcTdmeXc2cno3elFFc0daekEvS3o1VlMzTzJuSjZsclBIc0drWnhuclZ5?=
 =?utf-8?B?akkxQXd5Uy9MRmdLMFdaZVlSbktIUXpFMDlnRzdnUHBiNEdkdXBIRlRxWFFW?=
 =?utf-8?B?eE9WL0ZZa1hPS1FCbHZJenRDcEw2ZU5MM0p6YytndXVMc21xL0pqYjNQTnV5?=
 =?utf-8?B?cnF1cFl5aHBaVnFGb0pHSldmZk9kZjB5M1IyamFPNzVJdm5IRi9mdEhsRTFT?=
 =?utf-8?B?NzRpVnFGYmd0emxzUDY3YTUvc1ZMb216d21xUXVSYTA3ajkrMVN5NXFWVTJ4?=
 =?utf-8?B?Z0NweS9XT0lqZER3OXlLUDFCZCsxSGt2QUlsaUVLVUtwalJkZkV4NThxYVZG?=
 =?utf-8?B?UGFDZTV0N0dLK1psQ1Ztc2E2bE10Ny9PSEFqNmJSRHlGcTFPTzc1L3NlUGg5?=
 =?utf-8?B?bnMydDYxQk9FUXNuOWtxSnZtdDZBTHBoUTB3eHF1RFIya3Q3Y293Q2ZEUE5E?=
 =?utf-8?B?TEt4QzdIQ2NHK1p4eVEyNlFZN2JaVU5QdWx6SWt6WEx5ak4zSXdaazNycWtR?=
 =?utf-8?B?WkJYL1gvQ2hkclpmdTZnYWhpV2RBMzcyeC9RcFBDOElpQXFTQ2hFVTU5dHJS?=
 =?utf-8?B?L004Y3dERjJmUXBiTXQrYlF4TXJJdW1wWTVJWHBQK1QxOWR4ZFRzNkY2dHA2?=
 =?utf-8?B?TWN5MVAxaWJFamptMW5rUVVzVlFNczM3b05XdDZMOXBuSGFVQlYrV2dIb0FO?=
 =?utf-8?B?ZGNGNEZjMHh2QlYzT3BHM2RROHpTa3kwWUxUTzR2akxpQmQ0b21GQTNmOFVL?=
 =?utf-8?B?eThlUUNQaytnNlQvR0lkVjFRTkVIbUt3T0VGRGtlS2FpZm1jTS9uMno2ejlZ?=
 =?utf-8?B?Sm5tZ05ZUEJMSC9pMWI1ZHJCL1JNbkwvQXBGVUF2bWdLVktpRTdsQjFHM0RC?=
 =?utf-8?B?Z2s4TVFpSGVKQWdybU8vZ1owQklqNEJqWWxIYmVmK3NMTXBEVnlXeEI1cVl3?=
 =?utf-8?B?S29sNHBkRXJ6VXFqckk3cHFXc2w4OXpzdjR4VTZVTmtobUFrYzB5a1ZDaThj?=
 =?utf-8?B?SkhDZGJ6U0ZWbEFJeXRlOXhPMnp1bzIvR3Bjd3JRd2xlSFBJQkhLMHV1eHcz?=
 =?utf-8?B?MWRhT3RHa2JpdnpBOWtFM0s3U29XeDVtb2xuc1lPTi9EM1JCUUE3ZFRFMUxC?=
 =?utf-8?B?MjVTcHFFbjFHSHl3MzF0K3djM01wcGdkeGZQQWdjZWg2bDFORDh4VXpUTitI?=
 =?utf-8?B?YWZjZnRONDZiL3RpTGhmV1MraDdrNFFqLytsMXlzenRSdlhrSGRVczhIWHRM?=
 =?utf-8?B?cDBNemVKWjBkSVp6VVhYQU9SVEJ0VFRvaTkxY3RkYldIN1c3bmY0VTVLUGN3?=
 =?utf-8?B?RXVFckR4WmRyYWtxOEZOcUkrM0hHODhVVHZrQTZZQlNpTjRLUE9kWm05VHA5?=
 =?utf-8?B?N09YQmxISytlM0ZjbXJJRC81a05lbEhaSTEyQktuYWVuY21BUGJEczVwdVZM?=
 =?utf-8?B?QUk0N0UxQU5xdHFHbm0rNEYvZzJRMTRVQ0w5bFU3cUh5YVZybDB4L1N3eEQ3?=
 =?utf-8?B?N3ZNV1hodjMyRWs4d3lkSDBHRHdFcW96WC9KQ1NZTjYwdWJPbVpISFE4eUZa?=
 =?utf-8?B?UHRxbEZrdDVxT2hlZTl5TFVTVlN3STZpQVUxckxkQjdxTW1Bc0RsSUI0RHRE?=
 =?utf-8?B?RE5KNHh0YXh4NEhRY2l3M0NLVEdVZWlqcUtNQlRuRDhJb1NyUzlhaFZRRVc0?=
 =?utf-8?B?ZGdCUUsvcXhaZWlqMEJBUDlmalhGZnQwSDJFMXVoWjUxRU14eTNobkpGZ1Z1?=
 =?utf-8?B?M0V3eG94Qi9QOThQVGJyT3l2OHdad0hOUHc1Z0dWT1BPWXR3aEMzNlR4MFVC?=
 =?utf-8?Q?iDyFBkNU/syCb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVRSakZKeEgzbVFncHZ0Um42Q1UzQlc5MXpnRFhKQlhGa2xuaWUxMDRSV3I3?=
 =?utf-8?B?UkpXampVd2NBeHpDeTN1SFlSTjhOdGJNaDVBR0lycjdQYTJuc2xTTmdVcm5Y?=
 =?utf-8?B?WU9MeWdNL2JuVFppc3dvdXVqYmxpendZWUxySnIrUUZRaFFhT3YyeGEzZDFQ?=
 =?utf-8?B?bVNiN2VQNnhZbmNaUG90Vk92cG1NSWJpalBUaWdOSW1XTllwaDB3UzNNb1Yx?=
 =?utf-8?B?VlAvWGxOLzcyNVZ1OW5GUDFVOUtRSytyL01MR1Y4NlllcEViRmo0WGMyVjdZ?=
 =?utf-8?B?SzNNZ3ZJanB4My9yS25nSy9FQlc3WFEweW95M0NVWlQxMmFBak01SiticjN4?=
 =?utf-8?B?Z0RMK2tVNkhwNERYOW5xMWdyMThSYWt1czNQbTk3MHM0WUNmU09LekpsK09r?=
 =?utf-8?B?bDl3ZmJqK3Jic0RaNksrcWlQK3N4VkpBQmpQMG5JV2czYlFGdkRIL1F6cWg5?=
 =?utf-8?B?QTBpRFR1V3EwbnBtQW9va2VldWVmdEJUVmUzSzlycU1oOWF2bTJtN0NCSm1z?=
 =?utf-8?B?eWlmU2lHcE1uc0VwMTZxVExYcitJNkN1SFVWNEpwdnF2d3g5dit4SmJVaW9V?=
 =?utf-8?B?bFpZY2tEUlk0SFNEV1ZvUzlrcWY0VE5NUkFMY3FZKy80UGxJdVhrTDJKazVz?=
 =?utf-8?B?cHEzd2J4cElvR2NEQkNoYjRRbGdKTlAzOEx6Uk1lSXh2WkhySko0cVhOWDdN?=
 =?utf-8?B?ZEw4L00yb0UzdzVjYmtiZmN3bEZGSkFlWlRSSTNvRHd2T2t2djdWT2t2b1FM?=
 =?utf-8?B?emFGOEpPSDJFeUIyZm1tN29pR0RyRVdkUTgzNmowdFl4eDcwWUtjazlmNUVE?=
 =?utf-8?B?UFRXSUlGWFprOXQ1YlZBUjJmLzUxTzB0T3U1bDZUMFBZb1RFb0pvRVRjR25r?=
 =?utf-8?B?b3N3OFdwOTJicEJCNUkrVXUvNExBRk91TEFycDBXYzRKay8zanl3SjlkaVdr?=
 =?utf-8?B?czM0eXExVVpza1pRL245UDlWQkRSbzVTVGlLVnFuNC9PdE5kbG1YdTlxblRF?=
 =?utf-8?B?WnI4WGpaaVpsTEZGRHBaeFF6U0llZDFUUy83NU84VmlCbzNDb3RRVW1oUW93?=
 =?utf-8?B?K3lHc2QrNTQ1anNsRFRaaENDdkpZSHZIR3dCbzExQ2JOZ3o0bS9BT2V5SlFD?=
 =?utf-8?B?NEJrbDc0V3M0STFnQisyME9VUG40QVNFVmErWlJHTlpWWEkzaG9ocXJiOTlG?=
 =?utf-8?B?V1ZVRDhzeG1Rb0M4S3orWjZieXpDVVFyYzlpb0hOUTdJN2xYbnQ0QjZ2SDdJ?=
 =?utf-8?B?OGFWcHY1NEVpRy9jZDViSGl0ZzRLVTJqR21XSUM4c0s1VnVkOFVQSUt0OE5W?=
 =?utf-8?B?MlBZWVRFS3JhWndwWTl1YmxuMVFsZWxjN1ozWVBxSXVCQTVBcnI3UVdlbEEx?=
 =?utf-8?B?SE13THI0TC82L1hUaFllU1RUREZyc2FlWHdlSjJtY3B0Zm1JbzJIdmc0eW01?=
 =?utf-8?B?cit0Ynh1WGkwcFFqKzlGQnNPN29XZFpuWm9hWFFUa2VJb25sb1J5TWticXo3?=
 =?utf-8?B?bDZodTdOWDNwYmY4REMzSDdtUUlzK0gvd29qdGRUb0s1S1hrcXpsZ2J5Qi9s?=
 =?utf-8?B?bmFSdGxWemNzcisyM29Pb3lpQkJacjRoWjdUQnRyMWpUNnY1Mlo3aVJiMVow?=
 =?utf-8?B?VlA3WnpoemtSQzNYSm9EUUE5MGRxajNMR3F2cWF1UDhnZXdCSU9td0Z6czAr?=
 =?utf-8?B?aU9zNGhQZVo5V3NiTjBMK2xrNStSMEZFN1BWdTl5UWpyYU5YMVlzNHh0Qi9X?=
 =?utf-8?B?T3E2cnZkdzdQcDJsTG1rSWxJbUcvMEp1cmR2RE1sT3dxSFhLNW8wQ21KSDJx?=
 =?utf-8?B?RVk5WUxlcG5JcXNKTndEa3UyTXZPdFF0WDRlNStlRkJDWXUyK3NoM1pLSnB1?=
 =?utf-8?B?dWpiMHZZOGFoR1BLOTVmNWYxYThYaWFpSjhVRzV6QjRrb1BDeDRlejdzazlx?=
 =?utf-8?B?d3hrc3c0dmEwNmpUL0d4Y1BreEpNeXNlNXgweDVJWkp6OFAwTjFrOW54NGM0?=
 =?utf-8?B?dXdnaUgzSEZva20wRjg3VUdkYjJCQ0NZSyt6STBXb3VLaCs3TklRdlIvZ29Q?=
 =?utf-8?B?R0lUYXJDZ21VQ1cxb1RsejkyQmsrOEovdklmdzVSYThyUzl3SjVVbDlKK2xZ?=
 =?utf-8?Q?RXmoQ6c6J0mv66S+pLqFjyCa4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05466be9-d513-47ae-be26-08dd33ddc5f2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 14:22:55.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvoJlezKMy9RcSzOPwuunudzmk1+t4l2Kj9vm4cCsyn6jzNG14k9s0VTMXG3GgLBajHgGkFa4LUeKmb1Mczdhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296

On 1/12/2025 22:41, Gautham R. Shenoy wrote:
> commit 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover
> boost frequencies") introduces an assumption in
> acpi_cpufreq_cpu_init() that the first entry in the P-state table is
> the nominal frequency. This assumption is incorrect. The frequency
> corresponding to the P0 P-State need not be the same as the nominal
> frequency advertised via CPPC.
> 
> Since the driver is using the CPPC.highest_perf and CPPC.nominal_perf
> to compute the boost-ratio, it makes sense to use CPPC.nominal_freq to
> compute the max-frequency. CPPC.nominal_freq is advertised on
> platforms supporting CPPC revisions 3 or higher.
> 
> Hence, fallback to using the first entry in the P-State table only on
> platforms that do not advertise CPPC.nominal_freq.
> 
> Fixes: 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover boost frequencies")
> Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/acpi-cpufreq.c | 36 +++++++++++++++++++++++++---------
>   1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index c9ebacf5c88e..744fcdeab173 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -623,7 +623,14 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
>   #endif
>   
>   #ifdef CONFIG_ACPI_CPPC_LIB
> -static u64 get_max_boost_ratio(unsigned int cpu)
> +/*
> + * get_max_boost_ratio: Computes the max_boost_ratio as the ratio
> + * between the highest_perf and the nominal_perf.
> + *
> + * Returns the max_boost_ratio for @cpu. Returns the CPPC nominal
> + * frequency via @nominal_freq if it is non-NULL pointer.
> + */
> +static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
>   {
>   	struct cppc_perf_caps perf_caps;
>   	u64 highest_perf, nominal_perf;
> @@ -652,6 +659,9 @@ static u64 get_max_boost_ratio(unsigned int cpu)
>   
>   	nominal_perf = perf_caps.nominal_perf;
>   
> +	if (nominal_freq)
> +		*nominal_freq = perf_caps.nominal_freq;
> +
>   	if (!highest_perf || !nominal_perf) {
>   		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
>   		return 0;
> @@ -664,8 +674,12 @@ static u64 get_max_boost_ratio(unsigned int cpu)
>   
>   	return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
>   }
> +
>   #else
> -static inline u64 get_max_boost_ratio(unsigned int cpu) { return 0; }
> +static inline u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
> +{
> +	return 0;
> +}
>   #endif
>   
>   static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> @@ -677,7 +691,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	struct cpuinfo_x86 *c = &cpu_data(cpu);
>   	unsigned int valid_states = 0;
>   	unsigned int result = 0;
> -	u64 max_boost_ratio;
> +	u64 max_boost_ratio, nominal_freq = 0;
>   	unsigned int i;
>   #ifdef CONFIG_SMP
>   	static int blacklisted;
> @@ -827,16 +841,20 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	}
>   	freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
>   
> -	max_boost_ratio = get_max_boost_ratio(cpu);
> +	max_boost_ratio = get_max_boost_ratio(cpu, &nominal_freq);
>   	if (max_boost_ratio) {
> -		unsigned int freq = freq_table[0].frequency;
> +		unsigned int freq = nominal_freq;
>   
>   		/*
> -		 * Because the loop above sorts the freq_table entries in the
> -		 * descending order, freq is the maximum frequency in the table.
> -		 * Assume that it corresponds to the CPPC nominal frequency and
> -		 * use it to set cpuinfo.max_freq.
> +		 * The loop above sorts the freq_table entries in the
> +		 * descending order. If ACPI CPPC has not advertised
> +		 * the nominal frequency (this is possible in CPPC
> +		 * revisions prior to 3), then use the first entry in
> +		 * the pstate table as a proxy for nominal frequency.
>   		 */
> +		if (!freq)
> +			freq = freq_table[0].frequency;
> +
>   		policy->cpuinfo.max_freq = freq * max_boost_ratio >> SCHED_CAPACITY_SHIFT;
>   	} else {
>   		/*


