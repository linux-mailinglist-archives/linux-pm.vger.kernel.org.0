Return-Path: <linux-pm+bounces-9104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F2C907A51
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 19:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FAE1C2313B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA04614A0B5;
	Thu, 13 Jun 2024 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hYpoOW0d"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538012CDB1;
	Thu, 13 Jun 2024 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301320; cv=fail; b=Ll3JAxQmrR+fOTNYYldke8o2OFKsn5PWiJFbgUwavKb7Vi4HgAhJkf7NiybogJ+zPcWhIt97xG0jtKgoovx7H7TK3EWabDh8a4ovHdrE09NTL4PjqP6v5i7cXRpcysFAcigSDCq9bDBVc/WzfEovRUDV5M6u840rMZcMCZKpIFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301320; c=relaxed/simple;
	bh=O26equOwoZN0bdryiHs/HUNmd8IV+PZpI5BU6D3PwCs=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=avlgVmopOXeZ9EoKUMfBuKijInz8WrlwcxhxJL+erYfkKAU6iRNH8tZO/xIOmtbowYkLcDBB00WAePrkJyuRzcOyHhJf4pznCw5g7AjvLIU5F17vLOvSM7k+PaGNeqdagkv8xUvSXOeRF3SYak1NlJVvaSkNVAcYM3sdvo47/OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hYpoOW0d; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3m84GEg0khkiSuJgz4WrJxROrKhr/xYdnk1sli6hGXUNOgzMSddic4KFav0lc6laH8j5Yrd16D/qnyn8m2B3M/D7hcEiKIGuV37A/3sTrZk+I8v/L78u4drX0l1YoLhN7LEwe5cOVz5g2QetKvxz/QXL1GWy2VcQiRvbKodlCHZ3ah3Y2L50awlLiEqDbtfJul2DVEMje5/IEldye+9j+78e83AEHeBwqDcLql4Mfx1hWC/uV71q0jzXKTWqokRpfRdVxB/gOkRWC1UBvgGkAatPmCAmZfqJaw9c9tM9RODzjShk1o4ZsdiY4ONjt8XaxitPKKv47zGU6CFVHCLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5R8SvX+9vhiSTb4Kh5/7WIXapHZxbw5J025IRbozps=;
 b=BGtXBaVZmpcosVIaMbLSaDwpDJiFOmdCo/1STcVLS39ut4qWs7l3NGUGSPM7rA3crpPJ61m2FsKUjWIGqN/g5XliHbR8f01Q+gMol0Uqx3sD7k1OQDsxIq4OhicJNVsI1tiAw/pQOe820gsS8i462/MljJLmb0Jqx8gTUD813KoWkJGsr2dQ7myABuUzlCgjWoPPFgmMKNXYAYX29Tr2wbma4yZalvQI1DDaX1yWablbrtzZDd+ec+DNBsouDiacFXvxcuqPu05/2VRlFoq5GHw2bMw6AD1nYhxjHfFmBC5wIwSNdt88yIPFm28Ot88aezaPEi6yNijTlqnVxUeGEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5R8SvX+9vhiSTb4Kh5/7WIXapHZxbw5J025IRbozps=;
 b=hYpoOW0dKNnAwdsNePrNx8uV3u8OQgpnCx/PIRyKjwDNmS3dzHxvhMDLfDH7RObIaFYhZVSFGH9EbPOOK9iCHn4grTAAivXd6Tmtty000W3g6Ubv/sWQhOQnMid57Y4/8+zTgEDik9FAjW8job+yEtgbIJPT/WzF9uxi49MDxSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7262.namprd12.prod.outlook.com (2603:10b6:303:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 17:55:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 17:55:14 +0000
Message-ID: <0a1cf7fb-5d2a-4737-bbda-cb866270a523@amd.com>
Date: Thu, 13 Jun 2024 12:55:11 -0500
User-Agent: Mozilla Thunderbird
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v11 5/9] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
To: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org,
 Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718262992.git.perry.yuan@amd.com>
 <35464456ab468f389ff3816829647db77924a6b5.1718262992.git.perry.yuan@amd.com>
Content-Language: en-US
In-Reply-To: <35464456ab468f389ff3816829647db77924a6b5.1718262992.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: d73721e5-26c9-4f1f-cc01-08dc8bd1fa6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGtVc0VwRkpRV09MNVc5am95NHFtb1RnOU9FVGQyQzkvMFUzSnFYYXluUHJ0?=
 =?utf-8?B?aVRnUkhZSHJ2NDdJeHJ6dXBzZ2FzL0piUHY0aWw5MVE5TlNFeW85SndHSUpt?=
 =?utf-8?B?RVlhK1M0SFlYTkxnVlM3NHRCL3VoSHg0bUQ4SVd2MlVhcDhlbWJibWk0cFRz?=
 =?utf-8?B?L2NQUTFBZ280VjNxS1cyT2tpZ0xUUUFRSk5XaVE2T2Ntb3lBWEY3RU9RRjY4?=
 =?utf-8?B?amg1aTJKVHBVUm1nWmhzenhXWHFBaU5uTXh5ZCtGbU5TcnFhR0VyajJkL1BG?=
 =?utf-8?B?cERIazhyRWJlbFE0b1hlL0FHU3I5NUZiVkl2eTZ6RjJOSi9kUzM4ckZjR3lm?=
 =?utf-8?B?RjZBQktUMTE3NkJkeWdod1B3TG1TQlJuQVd2L2VVSnR0Q216cWw3Y2hWRFp6?=
 =?utf-8?B?U3prR1ZYcFMvclpUb3VreTB5NzhvL1B5N0U0VlB1VEkxVDBNNUhZQzZ2NHJw?=
 =?utf-8?B?cGVRcjFrTE9MN2lDaW5rdEloY2FFVk0wSHE0MVE3bm1XWlZhMTZ0QVJZcmNp?=
 =?utf-8?B?Z3M4QmpwR3NISm41UyswNXkvVVdZTXVDcjE4aGphaTdWand0Ky9rOE5SV2Nq?=
 =?utf-8?B?UFhpekUzOU5kT2VkZXJuckRDV2sveDErRm4rUWNiNi8vTkVzNGk5WEhnSDdP?=
 =?utf-8?B?QU8vYi96Q1FmcnhXellPaVlkRkJZU2RqWGpVZEpnckhEdlVsUFd2VFRPaFFH?=
 =?utf-8?B?ajc0S2NTaHJvb3MwVjV6U3l6QmpwUjVLcUthbDBZbGVBejhJWU5kWHI1bEYw?=
 =?utf-8?B?dTI0NXA0R1FoTEkxOUY0Tkl3ejNFWnEvQ3hIeW92OEZ2UUtFY2xheVRpaVhi?=
 =?utf-8?B?cEhmbjl2anJwbml2R2JwL3R1eUF6K3IwTU5vc3BhazZBQUlnNFNWZkd0Mm1r?=
 =?utf-8?B?YU0yeGRRT0p6VStFRzdKMVJBTTZxS1VWTmlBRW9mZmEzU2gyak55R1BKS1ly?=
 =?utf-8?B?K3NaMXUzQmRFeWZEVm1LWWYvRFk0U0ZIbytwTXNjMDZiRlh3T1BpUENJSm9s?=
 =?utf-8?B?bjFlcFBqZE1NU2pNTVc2Um1LTEdBa2t4dDNLMEhGWDJUR3FwWFdCUFBVczJH?=
 =?utf-8?B?Y0pndVMrTVRVZERQeVZvVjd6aWMreFZoamFwSk15Wk02MVlOdzkyS21pbzhl?=
 =?utf-8?B?QXZ2VEZRVitVajg2M0FYT2RPSU1uY3dPazZmN0JWVFM3cHFialFhVGtLcW44?=
 =?utf-8?B?Y1NjQzhwOGJzUXZ2Yk94bFIrc04zUUZiRUpHTUVDSi9CY3VSY05zSHhoakh5?=
 =?utf-8?B?WjI3Q0dFSjdrZSsvejVJV3lNTGtwakoyNFpyQnp6MDJpT3NPUnJ3cENscDJz?=
 =?utf-8?B?ZzJSejZTWVI5dFpaZVZSS2FGeDBoeFJQSXJTRURrVWhuZHAwS1hmMnhEM2Iv?=
 =?utf-8?B?NTcwQ0ZHZzg1blFURVFTd3hhYzBLQVQ4SUE0VFc1UzhRNitzMkIxTWJNYU83?=
 =?utf-8?B?REJRU2liWmJFVjR0a3FubFdud0lZNUVDZEpJay8xS2xiL0ZEYnIzNTArUmov?=
 =?utf-8?B?WlZTMkNNZ1pXRVpxdkx5NHJZSlVtVytBem1RWU1rWTRSbG9xV2d6WWM2U0JH?=
 =?utf-8?B?d0xRRG9xcjZwK0lxTXcvbjJhQXppMERlUUE0MEM1WnovdFB3N2FuQzZsb3ZE?=
 =?utf-8?B?MjY5aGFNSGVidzlpcFRkSGFUK2FtZGNINS9CU1Z6OHNrNWhES0ZpamtXcmpH?=
 =?utf-8?B?SEVFZ2NuZnJvM21GcDVMbXpHbUU3a0xNemIrQlV0emwyeGRPYW1VZzZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUQwRGx2WmhBQWZFNHdKdkY3N1VuQ2oxNWwvaS9aTk9kUFhVWTdnc3liNG91?=
 =?utf-8?B?Z2hNa1drN3RveVZoSkdkT2dldlordjVHUENYYWZZM3lKVWVCdml3Z1VsNFQ0?=
 =?utf-8?B?OWZQelFCWDNadms3ZjAzTU5iVU01aEoxMzV6bm1VUDJnc3NTb3lJNmw4NEhG?=
 =?utf-8?B?Y1pSU1V4a2MreVk4TS83NHRlY0VxVk9HTDllRlhxaW94NFlpNy9FTm04MTdQ?=
 =?utf-8?B?VWZzM2V5MWwvSEZIU29xdnpuTnNjOURvcHoySzRqTGVYQWhycTFNMGlnOVBF?=
 =?utf-8?B?Q1ZSRGpYODNHd0NTYlphYUlrS1c4bFpGazU1dUl2WnRZN3JGSlM3TVNtVytn?=
 =?utf-8?B?OHpPZ3RmejRMVHhYbnIyRlRYdk5KUCtLbEs1UVc4aDZ1QlZGR3JQVGtkRGlC?=
 =?utf-8?B?YmQySHgrUERtMUxKRlNmU0JvdytMSWZwS3dNdVoxZVFLU2p0Mk9yRzh6VVl0?=
 =?utf-8?B?ellZN3dSUE9CMFFlcElmMXNGekcxTjFnNmRkRHpoRGhBa1gwYnU5Q2RrNWZU?=
 =?utf-8?B?TE81Zm5lUTUxV3JFaWc1b29HMk8zN2Nsem5QcXFGcjN1UlA5YzRpWGJsdUEx?=
 =?utf-8?B?YmVIUzdDV2Z3S1UwaFVqQWhFV2lWQ1VJa2dtYTR4YmhleUV3UGhhWkdvbTJI?=
 =?utf-8?B?eHZzSENGK1YzaXVwQldrWmQydjljYmRJc21veVZJNzZzSkxIREVqUytNWFRl?=
 =?utf-8?B?QXJscU1lMllFK0dsNWlnMWtCM1VmZXpwVzRGeTU0TXc0d3lpbzVaOXdwT1ZQ?=
 =?utf-8?B?VWxjNTBPenBWTk9HM3NvUzdsME4rS0p4c2pxRGpmeTN5blF6dEEvTGx0VDhy?=
 =?utf-8?B?RklXYWQ1dmgxU1JXNTlYU0dZQUVQckpkZ2crYkdDd2ExNVNkQTlXZVdFeEVH?=
 =?utf-8?B?M1hvVmpOQVFDdE91OGJNaFJmY3lrbnNhd0o5MGdUSWVpK1h0QndBVFpWUjJz?=
 =?utf-8?B?UjY4SzhuZVp1bmF2VkZLVVJGcENYckE1VUNwV2VoL1QyYnhhNWY3N0ZyOWFq?=
 =?utf-8?B?Z2pkNXZuL0xSZS8zWUtNaUtaK21sd0RKWW8ySURwN1R1cEErRmt1QVNEVjRn?=
 =?utf-8?B?dWJ3emk5RzFLcWNqV1RZNWEzTW8vY0xBdlp4SnpaVFJzWGpHRWl2LzcyRFNM?=
 =?utf-8?B?T0ZNb1BNblc2a2tBbDV4UWpuVjdLazJMdldSL0RTdFZoRnJ4RytCdTk1b2hJ?=
 =?utf-8?B?MVlZc0pvZ2xRMEN1UlZBMlhqaTQ2YVhyZ1RlM2xDVkVkTDNEbStteXMyZHNO?=
 =?utf-8?B?alZiMXcxT0NaMnVXSC9JWFZ1VldpMW5aKzlvZmNXa2xsU29MWGczd2NlTklk?=
 =?utf-8?B?SlVYaG5SZWZzSlRNZjFUUWZWV2pzS3pHMmVQZ3dQWW9sMzk1NlJ1aWtHT3BK?=
 =?utf-8?B?UWMvODg2UE1oN2haeGh2dThuK1g0UUlOcURPeGY3RE5tcVhYN0tOVEIxeDNF?=
 =?utf-8?B?TGF5aUFkZjc5aTUvenBRYTJzK0poZEc5ZDlwd1A0V1ZGVjdZNUVMdWRYQm1h?=
 =?utf-8?B?eXh2YUxLTU1hY1NreFFZb1F1aVNZM0h6cytINWxoa2dacEd2YmhLdUF3Vm1o?=
 =?utf-8?B?UGkxdDJTVlpnZHowQjFSQ21MMVc0eDdja1g4YytncUFuYW8wajZLNGNscFVM?=
 =?utf-8?B?ekZyeEhRdFNYMVNiNWtCL1ZoNlZheE9IcGNIdC9yOCtrN2I1b2RoY1F5Uis3?=
 =?utf-8?B?ZXlQK09GTUN0cnBld2Iya2hQVmZCaGxhM2psa1pkSmk4OGV1VkxvakVyeVho?=
 =?utf-8?B?STVKT3k1YVJaY1hUc25UQUxZakw0YU5kT3BGcXNISW5FZnJyc0lMMjcvWS8r?=
 =?utf-8?B?WWIzUWcydUY4ZHNPNUdsTjhwemJQOEkzUW5NS3dMUGdJTXFKOERCcXA2dUdM?=
 =?utf-8?B?a1psM0kwYWxlM3JaZjB1alpLS0hYa25vYjlqVE94Q1BSQlA2ODFlM1g3aUxH?=
 =?utf-8?B?UHAwR2Fzdkk0LzFtaFJxV3FvSDFpRXQ4V0tISUQrMjIySjB6NDhYd3pPQTVC?=
 =?utf-8?B?LzQ0Q1pOazEwa0QybFNZMy9VZGhtS2JMZm9NWjRrRDN2bkNvTjFPWWtpdnZO?=
 =?utf-8?B?YkZEUUJWTnBveTBFQy9aRkxRaXZFVUE2cDJZS1NSU1J6Qkk5QTdjdkZLb0tD?=
 =?utf-8?Q?TN4FVoeGWPdU0Kl8+TTqxLWJv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73721e5-26c9-4f1f-cc01-08dc8bd1fa6b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 17:55:14.7268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2QuCKz3FV/aLQNauyBkH4/5i4kDD3EmNuOo0fw2i295f+sHvx0I/hPvj6MOSbkZDd9pfqeHa+9X9MG20UNIug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7262

On 6/13/2024 02:25, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> With this new sysfs entry `cpb_boost`created, user can change CPU boost
> state dynamically under `active`, `guided` and `passive` modes.
> And the highest perf and frequency will also be updated as the boost
> state changing.
> 
> 0): check current boost state
> cat /sys/devices/system/cpu/amd_pstate/cpb_boost
> 
> 1): disable CPU boost
> sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> 2): enable CPU boost
> sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217618
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate-ut.c |   2 +-
>   drivers/cpufreq/amd-pstate.c    | 117 +++++++++++++++++++++++++++++++-
>   drivers/cpufreq/amd-pstate.h    |   1 +
>   3 files changed, 118 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index fc275d41d51e..b528f198f4c3 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -227,7 +227,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>   			goto skip_test;
>   		}
>   
> -		if (cpudata->boost_supported) {
> +		if (amd_pstate_global_params.cpb_boost) {
>   			if ((policy->max == cpudata->max_freq) ||
>   					(policy->max == cpudata->nominal_freq))
>   				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9f42524074a9..fe7c9d3562c5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -104,6 +104,7 @@ static bool amd_pstate_prefcore = true;
>   static struct quirk_entry *quirks;
>   struct amd_pstate_global_params amd_pstate_global_params;
>   EXPORT_SYMBOL_GPL(amd_pstate_global_params);
> +static int amd_pstate_cpu_boost(int cpu, bool state);
>   
>   /*
>    * AMD Energy Preference Performance (EPP)
> @@ -738,6 +739,7 @@ static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
>   	if (amd_pstate_global_params.cpb_supported) {
>   		current_pstate_driver->boost_enabled = true;
>   		WRITE_ONCE(cpudata->boost_supported, true);
> +		WRITE_ONCE(cpudata->boost_state, true);
>   	}
>   
>   	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
> @@ -745,6 +747,7 @@ static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
>   
>   exit_err:
>   	WRITE_ONCE(cpudata->boost_supported, false);
> +	WRITE_ONCE(cpudata->boost_state, false);
>   	current_pstate_driver->boost_enabled = false;
>   	amd_pstate_global_params.cpb_boost = false;
>   	return ret;
> @@ -1348,6 +1351,116 @@ static ssize_t prefcore_show(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
>   }
>   
> +static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	struct cppc_perf_ctrls perf_ctrls;
> +	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
> +	int ret;
> +
> +	if (!policy) {
> +		pr_err("policy is null\n");
> +		return -ENODATA;
> +	}

This is dead code that can't possibly be hit, because there would be a 
NULL pointer dereference above for this line:

	struct amd_cpudata *cpudata = policy->driver_data;

Furthermore, the caller for this function, amd_pstate_cpu_boost() has
the same check already.

So drop the check here.

> +
> +	highest_perf = READ_ONCE(cpudata->highest_perf);
> +	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> +	max_freq = READ_ONCE(cpudata->max_freq);
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		u64 value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +		value &= ~GENMASK_ULL(7, 0);
> +		value |= on ? highest_perf : nominal_perf;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +	} else {
> +		perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
> +		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> +		if (ret) {
> +			cpufreq_cpu_release(policy);
> +			pr_debug("failed to set energy perf value (%d)\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (on)
> +		policy->cpuinfo.max_freq = max_freq;
> +	else
> +		policy->cpuinfo.max_freq = nominal_freq * 1000;
> +
> +	policy->max = policy->cpuinfo.max_freq;
> +
> +	if (cppc_state == AMD_PSTATE_PASSIVE) {
> +		ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
> +		if (ret < 0)
> +			pr_debug("Failed to update freq constraint: CPU%d\n", cpudata->cpu);
> +	}
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int amd_pstate_cpu_boost(int cpu, bool state)
> +{
> +	int ret;
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (!policy) {
> +		pr_err("policy is NULL\n");
> +		ret = -ENODATA;
> +		goto err_exit;
> +	}
> +
> +	ret = amd_pstate_cpu_boost_update(policy, state);
> +	refresh_frequency_limits(policy);
> +	WRITE_ONCE(cpudata->boost_state, state);
> +	policy->boost_enabled = state;
> +
> +err_exit:
> +	cpufreq_cpu_put(policy);
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static ssize_t cpb_boost_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", amd_pstate_global_params.cpb_boost);
> +}
> +
> +static ssize_t cpb_boost_store(struct device *dev, struct device_attribute *b,
> +			    const char *buf, size_t count)
> +{
> +	bool new_state;
> +	ssize_t ret;
> +	int cpu;
> +
> +	if (!amd_pstate_global_params.cpb_supported) {
> +		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = kstrtobool(buf, &new_state);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	for_each_present_cpu(cpu) {
> +		ret = amd_pstate_cpu_boost(cpu, new_state);
> +		if (ret < 0) {
> +			pr_warn("failed to update cpu boost for CPU%d (%zd)\n", cpu, ret);
> +			goto err_exit;
> +		}
> +	}
> +	amd_pstate_global_params.cpb_boost = !!new_state;
> +
> +err_exit:
> +	mutex_unlock(&amd_pstate_driver_lock);
> +	return ret < 0 ? ret : count;
> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
> @@ -1358,6 +1471,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   static DEVICE_ATTR_RW(status);
>   static DEVICE_ATTR_RO(prefcore);
> +static DEVICE_ATTR_RW(cpb_boost);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -1382,6 +1496,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   static struct attribute *pstate_global_attributes[] = {
>   	&dev_attr_status.attr,
>   	&dev_attr_prefcore.attr,
> +	&dev_attr_cpb_boost.attr,
>   	NULL
>   };
>   
> @@ -1420,7 +1535,7 @@ static int amd_pstate_init_boost(struct cpufreq_policy *policy)
>   	if (ret)
>   		return ret;
>   
> -	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
> +	policy->boost_enabled = READ_ONCE(cpudata->boost_state);
>   
>   	return 0;
>   }
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 0b75a6267fca..9eba854ab7d3 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -99,6 +99,7 @@ struct amd_cpudata {
>   	u32	policy;
>   	u64	cppc_cap1_cached;
>   	bool	suspended;
> +	bool	boost_state;
>   };
>   
>   /**


