Return-Path: <linux-pm+bounces-9107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CD2907A5C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 19:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9B91F24363
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3744D14BF92;
	Thu, 13 Jun 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r5RyQap7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71F14B964;
	Thu, 13 Jun 2024 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301329; cv=fail; b=kXu/n9lMPhqIH1i3tNxQzQx9AI7pGNz3d02actFCCVvzIoShoagNbvXJK2zePV5eoF3Hf7i5Xhde0nzNQOozw5EdhTL9oPVj+O7uZY6JG0zKK+5JKbavrIm/x189Fr+y6Nz2IKLm9mjR9BJzzPrpK985WzEI8F4ryUXHsBLtHSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301329; c=relaxed/simple;
	bh=DuCTfhth55z43bnGyPn0JL9tcuBaZUbeLlhK0tc2oPY=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pDw56ylL/ZT0bbu/yRHaqY5U900RWypvwgGwz23i7vlo/r/0KSi3gABskuM/7HkSc4L5e0xpSDdyKSSb+Feih2ygNAE5hVebWpf+4fOuyhwXrDRScht6ysFZJojJpvDb41xP6M+qAFcvlP91ltpHUhEB/VF9gIwRiQgeyp+Kcbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r5RyQap7; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X36g8mxfjxd/ijpwyUQ47fg+3YN4nTuRrIr0uYR2Cmbbnh9fWD6tC5W+OEAQX6Fw66m+GK6960JYTp2NNjEnxiTxWJ0n6xag46Bxky2MwscL6y9oaiwr0q7CITIok45HJ6c17cNpouGHbuYQNwyefwtdcCGVs1MhiY0HbTkCGC2LrxjIr4QQ8J4uFNLbUlAsYY67YmjXBk82rg+Eixn1XXWMnDDtXiu98K9aiDWtDBgAMhc6Lo+WC+aDwtIH/s1+sI5GgCe5/Ydv6pm8lzSOriX+vggvZ8p1SfM6CVx9azNHuWcQNDKaTIB2gzQxwETKy8CUSM2j4vGlVzo6VpnWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLXtv5rCHOMeA9j/FuVxGBa3TNXT13tcGMe3Nxt2elk=;
 b=jKFxDYMBcgt1xjJelmlr0iWUw7TWqJUnN8BEq8+4tY6aP9EDIkdGCdrzSPa30TuyTfXYg8IlnQCHuVR4u/d8xfMlMsBZz6U32qTvoT980Q8M0zGcjq/7LIVmcpYg4N/EDkX+nm6BUW8aBr8gCbihZKrCNrImlc5C6VciYXUs7BN3OD6hv1lVsA41RK2Tba9moYOc+7gKwL7MJbFwuvvW/077UjjQk/dmzeiwFOchhZEqVasLnyJofvMaPmDTA1ZaKxQbq3cif0lyIW7EUj0CtyrHMweAiIMJiH19LEkiqOzKl2ls5Xq7W6i1nFFBfonij8xBdsQN8ZjWYF7w0I3DPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLXtv5rCHOMeA9j/FuVxGBa3TNXT13tcGMe3Nxt2elk=;
 b=r5RyQap7yiz4NcFL8kOKEzR5eKogiFll2nDry/enfAE+5Vl3L1abxOyaNFofNlgiNXnhAfPazGZNbz25VUEa6J3gDVCQAeKRbGewWnDMhUvC+RwpjKar+0WmS1upKV0O7aWqZhCQhpJ4+hohql58wSEBrZK5toMzNI/mSDMu8eE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 17:55:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 17:55:25 +0000
Message-ID: <cb824650-1d89-4573-b0b2-067a80b9019f@amd.com>
Date: Thu, 13 Jun 2024 12:55:24 -0500
User-Agent: Mozilla Thunderbird
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v11 2/9] cpufreq: simplify boolean parsing with kstrtobool
 in store function
To: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org,
 Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718262992.git.perry.yuan@amd.com>
 <490341a4cec543fb95aad76b257a2bee525c515c.1718262992.git.perry.yuan@amd.com>
Content-Language: en-US
In-Reply-To: <490341a4cec543fb95aad76b257a2bee525c515c.1718262992.git.perry.yuan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 82e43c57-9817-476d-aae7-08dc8bd200fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHBMcGZjeWRrTFpCckdlK1MzQ1UvNUxIU0FRdDJ3VU5LbDQxdWdPMDVFYU8y?=
 =?utf-8?B?eFlkTDJMV1JGU0RQK1MvcTRSOEwranRzVEtrb2RHQXBUSXdNY1BlcVN0ZG4r?=
 =?utf-8?B?Z1NmNlpHdFRkeWNYVDhEUUJPZmo5b1Z2MXdqYXRkMWgxTUc5OThZTEVmbzBH?=
 =?utf-8?B?NU9yTXlkRHhtdERzUlBENmtjYXdBOU5KLytoRWViN0lja3M3WmFEblhiR1JQ?=
 =?utf-8?B?d2RTU1kzSGdPVzAzcnVEb0REdi9LYTlHM2w3UTY2aXU0b1RHZ0c0Y2hFYVlI?=
 =?utf-8?B?Z0JqNHphd2YwZjhuaElFRW9kQVhBblE0MC9RNi9qdjAwMHpxdTdnUVVlRVJo?=
 =?utf-8?B?S0hEL2ZTSGNvenN5T08xRGFSYTN0enBvSy9vVllFMjdHdXFnT3dEQXAwVDJX?=
 =?utf-8?B?cmRaSEVLeDhGS05tVmFmTUk5bDdvSWc0dE5NandtdDNUbzgyOUVVQ1VmMHEv?=
 =?utf-8?B?bi9HcFNRZTJkTTZWY0ZRLzVNenA1elBDYUZ6Slo1L3lpY05XVkxkWnRHMmpU?=
 =?utf-8?B?YlJvZzNXUTdscFdxc1ZiR2JPRHkvYXA1Z2ZUN1l3R0JJd0VzNDhnb3praFdB?=
 =?utf-8?B?WGIrUGp2Z29OalU3MzVzYlI1RkFNd0xuQjNiTWxQdkdydEMxVFIwTlZKanc5?=
 =?utf-8?B?TWlQZGpTSGtxS2tHUTRsU1lZN1lFZXppQlpLbHJXd0dHMG1xcGpKUEJiWDlI?=
 =?utf-8?B?aWRMSi9Wa2RWVHVhZFFVSlQwazBCd2NjK0p1WGxsOXZKK0ZPSXdJYUg3dUts?=
 =?utf-8?B?dmVMaENyWHhTZkFjZ2Z5K244empTWXVHZE51OFY2ZFRWNmtTWnVpczJsVkxj?=
 =?utf-8?B?ZjFlTk9qT3A4alo1NUxUZC8yV2ppbmNHeW5NeldJb2lrVU5KNm94SzlMaUpY?=
 =?utf-8?B?bGczZEloN1QxamZzdm5lWEVSWXRuR01NMXZoaWlUeFZzbUt3ZkEwR25WMXF0?=
 =?utf-8?B?S29SMzhuOTdsU0xmeUl0RUdRWGU5Z0Nib3Nxck9kYnh0WG5xR0ZqS21BUGZO?=
 =?utf-8?B?RjgzNkpPQXYwVG5oYWl6K240VWRKUmFNL0pWYkh3YXYxcmRLallKaXJVTk5L?=
 =?utf-8?B?Wmg0M3VRcEJNQ2duZW56MVFHeVowcW5sNm14Q1VGLy8velRxU2lZK1FnYmlz?=
 =?utf-8?B?dWc2UytKK1pkUjZJZVl3OEluWXBweEpMTWdSRE8zMzVmRUd2ZUMvTncwWjFL?=
 =?utf-8?B?bWg2dkhoZnZ1dnZnTFNQa25Rekl1aklDTXN1UjBlRFJHUC9TTzBmNTZMQXJ5?=
 =?utf-8?B?N2tRV0t2SmF0WVFrM2loQjdBZ3Boekg4TUpwSU5jUWczZHlmQ0hZWkhmSHpt?=
 =?utf-8?B?b3BTajZRWnRYS3FSMVR4SVFIa3IzVUd3VVFsTlYwMGVnUVN0RC8zM0paVEhj?=
 =?utf-8?B?Wm96dmFLYnZSUXVrL1RlNWFPTkpvb0JoR2UyMlFsZ25kVjNzRjNmb2xobExE?=
 =?utf-8?B?Vk4rcHJZSEovNlFuTXR4Ni92Q1FQT2Vzdy9qSjBpOFI2b2VqOU43VVI0dzUv?=
 =?utf-8?B?Z0d3WXBUWmxIWG1sVDZjS3VPNjh1eHNwN0JVem1Ca0pKRUtNZWU2eUkzVGlI?=
 =?utf-8?B?N1p6bnoxVWZDU1Z6Q3krL1dMNDVNRjJpZGtOVWd6aSs3ZkZqSTdNV05pQWJE?=
 =?utf-8?B?eUJQZVZDVmtBU0JQZEtFVFlITWpROXp5NGx5SHM2WDdmZ01OdDFkNzB2UnA3?=
 =?utf-8?B?M1VRdVU5RmhJYndxQ05hS3lFTDNjcnhiRzg0VkZiVjVBYjFGb2Z2TFVZbUx3?=
 =?utf-8?Q?NBpv9fDIgjH/xPC3jW2/T8/FuyjTZ8tHE2oRvKl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGFldm52VW5wMGNvdVJEU1dGQ3o0WTUvVzlpYnF6bklxRVN5d2loYXQ2Ymdr?=
 =?utf-8?B?ZTk3bjczMGgrcng4aElFa1FJemZxdjh5ditHUDB3SlRseCt1V2VGL1dTQjdD?=
 =?utf-8?B?UURtaytKQk52SHZ5TUVGcGtkM0pwMVZjOEI0MUNMbXFkWEtYOGFXb0RGTnFV?=
 =?utf-8?B?dnh4eE5lSzNXa1BlU1Bhck5iS2M1WW1xbjZCVDNJc0YvVGlrd2Fad3NseTU1?=
 =?utf-8?B?eXJJZGlabzVCd3d1VU5CUG9FWWdmSDgwUDJZZGI4Y21tZGdoVjJkQ0NrRnM3?=
 =?utf-8?B?R2s5b2xNai9xaXJmYy8zRlJER1hXQTB3eFJJVG5pNS9tdFZGRjR3YUo2eTJ2?=
 =?utf-8?B?dkRteXpaajkraTlySjlXblArdmlCdUR0dWhzSFh0QlVLWk1CdGRvRWZJY2dF?=
 =?utf-8?B?NFh4UU40a2J3dFJOU0pHdlQ3Q3M0ZE03NEtwajE0eVVzcHV3Yk1CemNIOFZl?=
 =?utf-8?B?YnlveHhuZDFEMzRFcTdTQi9ZaXgxU2praVNCR3lwOWlmODJROXJMaUpvYmRD?=
 =?utf-8?B?VURiMC84VHAwOE1BYmRwd2VicmtDeUtwYzRGN2xDSFlmL0RvUUliWDZ2MDYy?=
 =?utf-8?B?Z0M4Y1RrUUY5cXEycHJ5WDBzQU9FdUtybTFGTXJxeEYzNmh2azV4Z3Y2eExl?=
 =?utf-8?B?RnBPaFM3VDh5RmgyL1JwcTJHUHpWU0tUNXl1THpEWS9pTTRqNUs5bmppWFkx?=
 =?utf-8?B?cE5tSVVReG1NcE1PZ0FZa3VlMDVPT1MyWEc3LzJXZjhWREhWeFlkSUJ3UERB?=
 =?utf-8?B?VG5lUTA0NTNWbC96dkV0V1NuNEVnQ2JjR2NmNVdQVXdUUml3U2U2aGpVV0Rt?=
 =?utf-8?B?aVI3NEJDRVE4azZ6dThZZzltditjY2xCeVU4Tk5ESkl6dDF6OTBFZS9jMHpi?=
 =?utf-8?B?c3pPTDlMb3VHOWxzRWdIeGFyYmljRFhuaXpqL0FIZ2FRTEsrRVN6SG5hR2Zt?=
 =?utf-8?B?V2JjWlIySjNHRmR6eXg0RkJYSWpMV2Vsb0dCWmREeENvRkVjTnZvbjJ2M1JD?=
 =?utf-8?B?Q20rZDEyei9KWXNVKzljeDZFV0lTUmtQU3pTSkVzWVpTZm4vdDkyK2YwVURQ?=
 =?utf-8?B?UmlMWHZuTXdLZG1oRUt5WGk0UWdFRzhPTWVZWXh0NTNzRGUzMHpvcWtUWlU5?=
 =?utf-8?B?U3BCZ1lVbThiUEIxSHlFaE50b2V1UEdNaWVaNkozRVhoandoaWlERlRsK2ha?=
 =?utf-8?B?SmRBZUdvbVRLVGl3ZEs0d0FGVkV6alU1NEJpYnRucXhuaGpHK0ZsQmZIYVZ4?=
 =?utf-8?B?c0RvTTJWS012NzRPeVM4U3BJeXFTTHhueHM2RTBLdFFCY2FpUmZCT29qSEJL?=
 =?utf-8?B?WGR6M2NlVlBKbFcyWnZHNndSeEQ3c2JydnluTFF4cEpRQlgyelQzTjFvN1Vp?=
 =?utf-8?B?QzEvY2g1c3l6ZUdjUEF5Nk53cEVSQWd0Qi9HRG9yYXlQeWkxK3RKVlptYXBE?=
 =?utf-8?B?em90RFZlblAraXA3dnhGTldKRENVZm9yNVNwb0RFcW8wRzJ0M0NnZm5aalA2?=
 =?utf-8?B?aXJEc2ZUaTFBeDFxS2VqNWU1eWkzRmFSdlZFV2pOTzBEOHVTY3ZkS2dlV3l4?=
 =?utf-8?B?N3B6RGlPU2N2b3pCci9RbEJPMW9HUHVyaG5Fc3Z2L0UvTFBzSmVxWWh6NFFY?=
 =?utf-8?B?Nk0wTGoxeDF0ZXFOYXNja3F3VDFnSnc0L2tabGhROC9qSTJMR0xkRCt4ZFY5?=
 =?utf-8?B?cWxEL0JtZVdzY1NsUXFUZGRhL3JSQ1FsUVJoMzIwSm5BbzVZYldmZ1RDNW54?=
 =?utf-8?B?RmIrd0ZCUmNFNzB5R1ZkcG1Wa0pQbklyWFBPa1dIbXB1VCtpczRKb0RkdGVs?=
 =?utf-8?B?UGFteURWcVdwSXlRbk1TOHdPOE91L1JJeHUvWnFtOEJraGNMTGMyN2xndk5T?=
 =?utf-8?B?amY2b1NiM3A4L2tycmJPT28yZ0EzVkJ4OEdzSEVBNTY4OFk0VC9SOWxObnBW?=
 =?utf-8?B?ME9xTlpxbjVLdVZ2SkZXS0J6NUc2WXFJZVlHYkpPam5halhhQ2FrN3k2RmRK?=
 =?utf-8?B?eEdKVW5hajAyU0tVdkRzOGFKOURIQm05RlkyZld1YlJxa0xBQ1NDOUpZZUJx?=
 =?utf-8?B?elBZczJReGswdHRCNkNNcDhzQ210R3NOUUZFTWUzZllmMjRKT1lKQkRaVFEw?=
 =?utf-8?Q?9kI+gEqlyhP53OsObf+noejxS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e43c57-9817-476d-aae7-08dc8bd200fa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 17:55:25.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REQAXOIHRIkR1KZFc5j0MfpT1nOXz8jweTPlze8pkxmiKxz/OHx0mGjXKJ/8THpgSb5LYFjpPH4459tIqGcBRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074

On 6/13/2024 02:25, Perry Yuan wrote:
> Update the cpufreq store function to use kstrtobool for parsing boolean
> values. This simplifies the code and improves readability by using a
> standard kernel function for boolean string conversion.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/cpufreq.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a45aac17c20f..1fdabb660231 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -614,10 +614,9 @@ static ssize_t show_boost(struct kobject *kobj,
>   static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
>   			   const char *buf, size_t count)
>   {
> -	int ret, enable;
> +	bool enable;
>   
> -	ret = sscanf(buf, "%d", &enable);
> -	if (ret != 1 || enable < 0 || enable > 1)
> +	if (kstrtobool(buf, &enable))
>   		return -EINVAL;
>   
>   	if (cpufreq_boost_trigger_state(enable)) {
> @@ -641,10 +640,10 @@ static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
>   static ssize_t store_local_boost(struct cpufreq_policy *policy,
>   				 const char *buf, size_t count)
>   {
> -	int ret, enable;
> +	int ret;
> +	bool enable;
>   
> -	ret = kstrtoint(buf, 10, &enable);
> -	if (ret || enable < 0 || enable > 1)
> +	if (kstrtobool(buf, &enable))
>   		return -EINVAL;
>   
>   	if (!cpufreq_driver->boost_enabled)


