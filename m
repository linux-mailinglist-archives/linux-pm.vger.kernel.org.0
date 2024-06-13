Return-Path: <linux-pm+bounces-9105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FB1907A53
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 19:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D9C1C24DBF
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 17:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC87614A60F;
	Thu, 13 Jun 2024 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bfgngWNr"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520C14A4EC;
	Thu, 13 Jun 2024 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301322; cv=fail; b=XPbE/gaUeNmQWR3dB87A+8D6Id5LkJHbE1megeEv+vUz5dwOX+x7nsJVQopu58g9Wfl0cthxnniWpN708Y7sv4U5JjgFKFLpgrmvhurLYhJ6ghORGtRQcu9pDuLFCdJbiOY9sBSnbS+b2b6GuCHAyZ/qWQT0hCXS2Tdo7Qw9zQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301322; c=relaxed/simple;
	bh=O9sdtKUNPq6nhvDCkxeEw28KkMnVV5vihgQpoo7uu+Q=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rQdUvL/cM9+7WRMwHzif0e9osLdJ4dNNm2wK1i7otS//z40cMxWAObrCIAzUJU6KDiYWCJxhAVjr9Xv4q8Ld2hWnP+kgShI8vw7IvX3Xb4SuIEqjhRbzavApq5/OoQRaPblT1SNnU6I45ILqrE45QGqlZapBZ3rYtrQJ77so03s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bfgngWNr; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjyySRUM3q1sLV499bS5MRQ9LnUom9/BeyfWzIOi9YhvK7MnaCeSTRrj20d1URVCRCr8qjRuZy8O7FqN09kqt/IoLGkVU/w9S4EX5IyujKZqXztOZhd1tMgZk6z4zvxOYY2VW3NyxY0ot17BN/j7N9fq5aSjOMnVE+3DeTqDJBBVCU90lxtg5yVbyf46byjHzKq/T1oksBLZOT6+sYnFLB+PaPzbta/ug81z5+hT0z8dNeBizklX1jqgnOACsfg3RgKI2xuuExnBI0WJwMnDU9iZRebSLQiYSu1U2sQrqgwOQpFTJY2UqvU48CKBbeY3GziPuiRrTeKcNqlv5zrd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0sbJoWRv5lHH1Df1KtQlz0WTKTwPP/72A/jEGsaAtg=;
 b=XnUX9z/VOosIiCwYlUY0wAwfHRlxK44h8tFTs6WnfEnQ6a4sBm6T0qSuBywDLklz/igacHNrqgk21ygzsI1VK3ZssDI6CUQuKBq2jsB5RdLoIUGJlKAivFYnJhwE9+/Swkn5fO0tjBUYtzcqsK99kXVpV3TOrCnp++83KJYhM4cZV48uPLllIGKGzAQ74O4MVzUdZCYkq4hhVx8shZGaHBDVPWW/18kDyxXmFHMmdEzdwcIxqscglxH98jy5jiOlkXAiif+/67UrFKEpT1zHg/9w75U3+EjzsgTKdE3tpGiviigSpHwQD16QvIV+F5uC2UCVB5j9pEXXeS5MydN1DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0sbJoWRv5lHH1Df1KtQlz0WTKTwPP/72A/jEGsaAtg=;
 b=bfgngWNrvmX/fcEgioBVtZQJpMI3u+1NWJQfBC+nvgB29JVaxYWhcNIdS2ijzb2Ow6nzHFUGa9plS9kFgBlg3/HgZF3JqTTIKM8GcefeBvGiefBfEhQplLHCPBiumy0nSkcQ3gyVIxyRTGO3o0Ao6SCQdWUr0FujWuWn7WrCVvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 17:55:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 17:55:18 +0000
Message-ID: <c6b2fb16-bdb5-4c53-8fee-a031be1b298b@amd.com>
Date: Thu, 13 Jun 2024 12:55:17 -0500
User-Agent: Mozilla Thunderbird
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v11 4/9] cpufreq: amd-pstate: initialize new core
 precision boost state
To: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org,
 Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718262992.git.perry.yuan@amd.com>
 <b5faa3f5e27a5991402c356f8dfb8299aaf03a09.1718262992.git.perry.yuan@amd.com>
Content-Language: en-US
In-Reply-To: <b5faa3f5e27a5991402c356f8dfb8299aaf03a09.1718262992.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0126.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 28482f2d-5592-4206-993c-08dc8bd1fc80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?allWNFhNNzQ1L2lHWFRLUGhGYmM2R3E4b3NQVWpWTitVcmtQVzhEQ21zYXpl?=
 =?utf-8?B?WGFXMDQ4bWprT1lwWGsvLzhLYTNwL0grVnVqYlNDaXd3dnlTUldYdHpXK0JQ?=
 =?utf-8?B?WU9od2VhVENBWDJxaXpad1p4cmNYbUFOLzVFQXd4T0hVVStPUlMwRlNmMW1Y?=
 =?utf-8?B?ZnRSSG1xdDRSQlRPL1pSS1pESFFYMmcrLzlWRHMvZlUySkorNVMrdXVBbWFM?=
 =?utf-8?B?NEczclhPOGNEcmtaQnJ1b0ZRa2VyQnlYK2xrU2V4d3FSRlVNdThpa1NrQ2dB?=
 =?utf-8?B?WnV2YkQzK0hyT01OMkc3RUJOZmsyeG1XQVQ1SE82NFlxazFNRW5ZWWgrdXMv?=
 =?utf-8?B?amxILy93aXd6bGJ1V1ZZY0pNR1dMTnhRSDdOQlU5N3JTR3IyY214dUR3QUh4?=
 =?utf-8?B?dDRzN01ZRGVtM00zbFFBcjFNYlZJMzhja3hIQjhNOTY5Y255WXRGVS85S1Q2?=
 =?utf-8?B?MnI0YTlyZWxXeG5ZMGRnbTlDU1JlSVUvRjhLTzV1dkVnZWVyT0tELzcxWHZK?=
 =?utf-8?B?NXhxMFVwcnQ5SjJwVkh5cW5hbk9vRXRGUjVpemlSaVp2ZCsvYWs0dHdDOHRz?=
 =?utf-8?B?bkEzd2RSTzJ0QjFJbElDU09nZzdnaE9aTjA2Sk1DSHYrNjdZUWdZUi9LZ2NF?=
 =?utf-8?B?ZnRNZWpBOTl4dHJwZHB5YkVMWHNJNHR3V1REb2lST0xxLzRIMHpjQ0lOSlA4?=
 =?utf-8?B?Mlk4Z0VsTUR0YlVRbW9VNnpZYkRweWJzSCtpbkkrTHNQUlJhdGFEREZJSWho?=
 =?utf-8?B?UlFpdmxQVFBFWnRwZ2F4UWk1ZEM5ZEFSSmF3VzJlWThXam12SmVnbDl4dm12?=
 =?utf-8?B?NHp1bkM5WVNFOURnV0dSY1NuY3V6RmwzSkdaQjJoaDVSdHJUQmNhc005bE9J?=
 =?utf-8?B?WkRDSFNvMVptOFBJRlkwdVVKbmdmQTh6a1ZSRUZhdGM1MUJOajN2Mi95b1hh?=
 =?utf-8?B?UW5uUnR0ZDRlaEJMZHNHMi9BZ2wwTmtUdFJBK2dOQlAwN0JQZHBtZjMxVkla?=
 =?utf-8?B?YnJHTGd3K1hQQ2J6MzI0TVhEU0FoSWs3TExPUWUyQTB2czBlNVVvUktKZzBF?=
 =?utf-8?B?cVVnekZiUWhrMGxNQUdBZFhrVnJIMm1qa2JQWlF1UzNvdWdGYSttUkU5Tjk4?=
 =?utf-8?B?cVh0amNJUjhsMmZZelN1VlFxQytqL3c0S05Xb0pjak1XL0JlSkZzU3hXMERy?=
 =?utf-8?B?aXVudGg5aUdXeHU3VStCbkk0ek83MFVHRjFDdTBCVE9wWnJTL0xsa05MUThV?=
 =?utf-8?B?cGd2Q1ozR2hWZEdwd2xLTXAvVW9qNHJaSE9IUUoyL3RYalZDVWIrdFZ4T3ls?=
 =?utf-8?B?MzU4a2Q0ZnYydnM0MUI2eGhUYlVscXNUTW51cHE3N3FEYzk5T0o0dGRkbGRV?=
 =?utf-8?B?Y0tjWkNYQTZEUVFWSE1iUXJpZVNVVThtRlFLQzR5Y0lnSHVHOTB0NWtpTSsz?=
 =?utf-8?B?SkFCMVNhSWgrMzlhd2JqYlZVVThBYmhVNkw1aU4wQVFxMDNRSVFBMTlHbmc0?=
 =?utf-8?B?K05NNVNWckZXMUk1OXlzVWtjejk3M2dsYnMyRTZyWFNRWFpFeWR5cVhqaFBa?=
 =?utf-8?B?ajgrQ3RraDRMd0gzcmJqZFYvbWlEN1ZGT1ZhTnVzS1QxdUNWaGtVdFNKbzFj?=
 =?utf-8?B?OU41ZmxlUS85RnQvbkRrVStLeTlhUVNLRCtvWGFhbEJYQkZXY3k0bmtJMkxm?=
 =?utf-8?Q?U4Iyi6ZYXcFX7QGjC/rg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlF3RUE5K0UzaU9IMllkSG5RaWVmS3VtWmZjaStZcWRGNG9IcDJWeG9pUDNp?=
 =?utf-8?B?R05PNHM0ZnNZQnplbmlLM0J6V3AydlF3ZkVsZjQxZHJaSWRRalJDVWVVYUhD?=
 =?utf-8?B?TThZZnlJYTBOa1FicWVIbjd1UTUrU3JXYzF2WDBqYUV6VXBnVDlFTVZYVUJt?=
 =?utf-8?B?ZGlnY0V4eUNWdUhycWtJS0wvNnRtUXArZTJxYlJzcHduelBXVzFXTXZDSm52?=
 =?utf-8?B?dDZwcFo0RVRtVG5FcHVmMnZPRFUzQTJGZmxGYU4wRVhncno3MCthNG1vRHgw?=
 =?utf-8?B?U3pYdFhybldzMTF2T2NWdHJKSUpuRWZPajVWUFNhdkxRcUhGM1pNS1llM09K?=
 =?utf-8?B?SFh0TTgxQjNuek1FaERRTzF5L3JnTFo1Ukt1TitXU21mbXhCMXRmYmdtV3c4?=
 =?utf-8?B?THJwZ3RrcVZlb2xuK25ORy9ITERGejhLNHpOUGt3Tkx1MHFNbzlXWU95Tlhu?=
 =?utf-8?B?QmdSZmR6eHV1NlZzeXZwOEJmN2lUUkFFTFlQN3JSaUNjcXdXUmp3bWJNTTZR?=
 =?utf-8?B?dWpBVEU1ZmdIRk5EQXlXYmFKZGI5UmZlSWprU2ViUDRoRkxXUjhZYWdOd29q?=
 =?utf-8?B?eSt0d3p4Yk0wQjJMcmp4YW93b3hsSFNWZnJldTVqNFhXN09udWtEY0dneEt2?=
 =?utf-8?B?S243SXJ3UFUrQzVWWDU5RG83TUZ0dUt2LzdQYXJ2Y1V2T1lTQko3ODQ3V3J2?=
 =?utf-8?B?LzJ0MVdMRllkWXFpZDVkZU9qeEN6N1ozZTR2R2NyOFoyUU5QRkU2dkNUWVRO?=
 =?utf-8?B?am1xbnFMTTRBb3BZZFRmWmJmK1NaWGVuOTQ4LzYyU1RjR3ZSQlV3a1RkekRM?=
 =?utf-8?B?c2UxZE9XMm9Lektyczc0TXVDSG5iU1hxMGRrMW05bzhnZFI1WTl5WjJyMGd3?=
 =?utf-8?B?U1dsNVVJTjY1cmloMVNRWW15M2hQV0VybHdkRkdGejJSOFM2a3JwUDdnbmh2?=
 =?utf-8?B?UHllNkFKZjlpK2VhRHVMcEo2UnJ1YnNNdXdOakVYcis3d3RyTEIrTkZ6V2Jw?=
 =?utf-8?B?S3lncTc5M3VTdk91Nm8yOFJuSDNJc2x0elZyeDNPc2hkM2RON1p0UDlXWmht?=
 =?utf-8?B?OG42U05adTIyeWg1dmdjUE5obHJuakJkYVFGb2w4RVBhN0RYeHJZbGh6eEhN?=
 =?utf-8?B?clhSNzdTZVAyWHBXb0tuUHlNMERPLys5UENlY0pkNnNUNTAwb1dZdEpLaEI1?=
 =?utf-8?B?M2hGS21kVFV1QnN5ejNWcU5GdHVMSVlYZzVoRzNDZHVjZHRjdXMwQzVaSUtZ?=
 =?utf-8?B?NHJzVk5VanRhak1tNGV4ckF5dE1uemFUTnZOcTBXd2szTklQcitWa0tCcXJo?=
 =?utf-8?B?SU5PRlNsYVBpNFluc0pVZkJ5T0QyOWhySEU5OWVhZXlrYitDZnVXNTJnUmlQ?=
 =?utf-8?B?OC9KNjF1QzVXbG4yazhmVUFJMHdkeUVLdUNUbjVIL3djTzJWZ2YrMkVrSUhW?=
 =?utf-8?B?Y2w4eTlzWUIwT25zTnZId2h0eituRlVrT1A2UHNKTU5hTkNGcGQ2OWtNOEFL?=
 =?utf-8?B?cVBqbkpva0lGdXl1WFZyZ3pZS1oxbVZqMDV4WHdOSE9qTUhzbS8waHAycFNY?=
 =?utf-8?B?RHhwSCtTRnptd3A3aGxLZytFSnFUcGxwbk1zcjdiM1hZZG9Ub2tZYy9pcDdC?=
 =?utf-8?B?SGhqMFFBZkdpR0RSMEh3ZXdZTW9oZXNIV1N4aHluVndQaUozR1RaVGtIT0tJ?=
 =?utf-8?B?R09kblZ0MGZZMGtwWk9EcFZzelhPOFlWM2RSS0gxVVpKUDlXSjNIL1NicGhm?=
 =?utf-8?B?QW4wTlVQMVQvV0FuR2wrZy9nalJhd3YyZmlkZmxlWitWYjdXbUpnVVMwamgx?=
 =?utf-8?B?ME9uWmNXc254aE04SmhIbHB5WDB6VjBqTFZCQnBycDNmNFNCSW91ZzlwUE9l?=
 =?utf-8?B?MXJadnN6SndMWXVFMUZaQ3JoR2VDc2xlbC9ycmt5SUdINWh2WE96Tzl6bW9B?=
 =?utf-8?B?ODQ1dmNUUXN1Vi8wcnpMNEkvSFUwMmRxeVA0U0lMYkNFbE9UejJZT3Y2VDRq?=
 =?utf-8?B?dUxYU0xVWmFJK1R3Qzl2VnZUd3ZKeWRXNEhWTFFxejh1UWxvM0k4amJrdHpk?=
 =?utf-8?B?NGZzUjJlNWFZcVRFaW9YU21vZmN1aXREK3N5UUZlSzdJWENYWmdXZXJFKzBk?=
 =?utf-8?Q?E6f6y334VjQKCUSfUSrvJ65dq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28482f2d-5592-4206-993c-08dc8bd1fc80
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 17:55:18.1882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avka0BuM8LjNdjT1ko75lVzODxZVCY6vIWu49TPCEbyObvT+Tm17/jPEHfl2fhSgxCY3lVAgn9p0xD8NI+pXTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074

On 6/13/2024 02:25, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add one global `global_params` to represent CPU Performance Boost(cpb)
> state for cpu frequency scaling, both active and passive modes all can
> support CPU cores frequency boosting control which is based on the BIOS
> setting, while BIOS turn on the "Core Performance Boost", it will
> allow OS control each core highest perf limitation from OS side.
> 
> The active, guided and passive modes of the amd-pstate driver can
> support frequency boost control when the "Core Performance Boost"
> (CPB) feature is enabled in the BIOS.  When enabled in BIOS, the user
> has an option at runtime to allow/disallow the cores from operating in
> the boost frequency range.
> 
> Add an amd_pstate_global_params object to record whether CPB is
> enabled in BIOS, and if it has been activated by the user
> 
> Reported-by: Artem S. Tashkinov" <aros@gmx.com>
> Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 59 +++++++++++++++++++++++++++++-------
>   drivers/cpufreq/amd-pstate.h | 13 ++++++++
>   2 files changed, 61 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fda8f86c90e0..9f42524074a9 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -102,6 +102,8 @@ static int cppc_state = AMD_PSTATE_UNDEFINED;
>   static bool cppc_enabled;
>   static bool amd_pstate_prefcore = true;
>   static struct quirk_entry *quirks;
> +struct amd_pstate_global_params amd_pstate_global_params;
> +EXPORT_SYMBOL_GPL(amd_pstate_global_params);
>   
>   /*
>    * AMD Energy Preference Performance (EPP)
> @@ -696,7 +698,7 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>   
>   	if (!cpudata->boost_supported) {
>   		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> -		return -EINVAL;
> +		return -ENOTSUPP;
>   	}
>   
>   	if (state)
> @@ -714,18 +716,38 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>   	return 0;
>   }
>   
> -static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
> +static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
>   {
> -	u32 highest_perf, nominal_perf;
> +	u64 boost_val;
> +	int ret = -1;
>   
> -	highest_perf = READ_ONCE(cpudata->highest_perf);
> -	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	if (!cpu_feature_enabled(X86_FEATURE_CPB)) {
> +		pr_debug_once("Boost CPB capabilities not present in the processor\n");
> +		ret = -EOPNOTSUPP;
> +		goto exit_err;
> +	}
>   
> -	if (highest_perf <= nominal_perf)
> -		return;
> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
> +	if (ret) {
> +		pr_err_once("failed to read initial CPU boost state!\n");
> +		ret = -EIO;
> +		goto exit_err;
> +	}
> +
> +	amd_pstate_global_params.cpb_supported = !(boost_val & MSR_K7_HWCR_CPB_DIS);
> +	if (amd_pstate_global_params.cpb_supported) {
> +		current_pstate_driver->boost_enabled = true;
> +		WRITE_ONCE(cpudata->boost_supported, true);
> +	}
>   
> -	cpudata->boost_supported = true;
> -	current_pstate_driver->boost_enabled = true;
> +	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
> +	return 0;
> +
> +exit_err:
> +	WRITE_ONCE(cpudata->boost_supported, false);
> +	current_pstate_driver->boost_enabled = false;
> +	amd_pstate_global_params.cpb_boost = false;
> +	return ret;
>   }
>   
>   static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -1007,7 +1029,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   
>   	policy->driver_data = cpudata;
>   
> -	amd_pstate_boost_init(cpudata);
>   	if (!current_pstate_driver->adjust_perf)
>   		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>   
> @@ -1389,6 +1410,21 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
>   	return false;
>   }
>   
> +static int amd_pstate_init_boost(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	int ret;
> +
> +	/* initialize cpu cores boot state */
> +	ret = amd_pstate_boost_set(cpudata);
> +	if (ret)
> +		return ret;
> +
> +	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);

Because of the change I suggested in patch 3/9, I believe you should 
move the check for

if (!cpudata->boost_supported)

from amd_pstate_boost_set() to the beginning of amd_pstate_init_boost().
Something like this:

static int amd_pstate_init_boost(struct cpufreq_policy *policy)
{
	struct amd_cpudata *cpudata = policy->driver_data;
	int ret;

	if (!cpudata->boost_supported) {
		policy->boost_enabled = false;
		return 0;
	}
	ret = amd_pstate_boost_set(cpudata);
	if (ret)
		return ret;

	policy->boost_enabled = true;

	return ret;
}

> +
> +	return 0;
> +}
> +
>   static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   {
>   	int min_freq, max_freq, nominal_freq, ret;
> @@ -1467,7 +1503,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   			return ret;
>   		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
>   	}
> -	amd_pstate_boost_init(cpudata);
>   
>   	return 0;
>   
> @@ -1706,6 +1741,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>   	.exit		= amd_pstate_cpu_exit,
>   	.suspend	= amd_pstate_cpu_suspend,
>   	.resume		= amd_pstate_cpu_resume,
> +	.init_boost	= amd_pstate_init_boost,
>   	.set_boost	= amd_pstate_set_boost,
>   	.update_limits	= amd_pstate_update_limits,
>   	.name		= "amd-pstate",
> @@ -1723,6 +1759,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>   	.suspend	= amd_pstate_epp_suspend,
>   	.resume		= amd_pstate_epp_resume,
>   	.update_limits	= amd_pstate_update_limits,
> +	.init_boost	= amd_pstate_init_boost,
>   	.name		= "amd-pstate-epp",
>   	.attr		= amd_pstate_epp_attr,
>   };
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index e6a28e7f4dbf..0b75a6267fca 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -101,4 +101,17 @@ struct amd_cpudata {
>   	bool	suspended;
>   };
>   
> +/**
> + * struct amd_pstate_global_params - Global parameters, mostly tunable via sysfs.
> + * @cpb_boost:		Whether or not to use boost CPU P-states.
> + * @cpb_supported:	Whether or not CPU boost P-states are available
> + *			based on the MSR_K7_HWCR bit[25] state
> + */
> +struct amd_pstate_global_params {
> +	bool cpb_boost;
> +	bool cpb_supported;
> +};
> +
> +extern struct amd_pstate_global_params amd_pstate_global_params;
> +
>   #endif /* _LINUX_AMD_PSTATE_H */


