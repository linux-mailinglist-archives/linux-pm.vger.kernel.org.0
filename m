Return-Path: <linux-pm+bounces-20067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 131C3A05099
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 03:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F07B188597E
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 02:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86121156C71;
	Wed,  8 Jan 2025 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yOp0NttE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F91DFFD;
	Wed,  8 Jan 2025 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736303180; cv=fail; b=XaaQYoJF48v/v/Ml6Mk3J9VR1lTyxbU0ZQhm0iFh69Sw6oTwZJKU9IJFjVDMIxx++DVswEPwylKztbTYKkmqTmGXUfNdO7/84DlvEUeFCsD7nRsgVUMw/pd067myyLjUf6UygnBpanWm0EJX4cGBmO09ZAGRGsd8R9qI5Wefc8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736303180; c=relaxed/simple;
	bh=F2p1LGPBr0v5Wx5s7UhIVwNhYWs2qGOiJdBhC2AncUc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bhFMsI8XE3IPBqbKuQx2Gs1knH7mJ77IjAgclsbuWUcQ10c2/80UxOhzIg/1IhBeK6t4+LEAnxGxShyOgZkh4254ufoZQFcoGSbKwUefOGQj89z00W7zK4Wdhoh6U7O8cP+Wl4gOpB9ydcZ9xFaguKllf0zLMlkJmN/wvdMQTM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yOp0NttE; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHRMdjNzEu3PbezcOIMa/X6dYqa/EHZJZcGNmRNlJ1HUkrsDYlpFlKZqsbxU3iJGwh6wyOXP31tjMDdUmFSja24IHHhxzCDARPw5z/FudMp+IRP3NUf+5AVe9V0m6TMFpobVTU6bSErUsf+aQvDgUXEACaY30bNkphHAdzB7psW2034jAt6E88z7+4mFKXCyxunNj7LdAF5MRIfXulcu0RvL/M51FXNOmYIKU5zqVZHBG70GbfwKedM5ANk+tLmKrc96OeBcXPJD+x9+NPgIm1BDiqXCY7//ScqG0Juu8yEqocgH/kgzdrtjoTJkpF+U/tOzh/g2Mb0QQ4xIOgbtYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyA8O6yqIbA8nKl1kMkX/KN36iJhM9H8YYCoqEIBQ5o=;
 b=pm7tETeKSnh/oJBmoF3qbUphdjAaRApp4veXw4Wjb1aTbuKGGG63sEWT7tPYJNFYyHm8YSF+z8dG3Qeg8Rn/wvehYcCAKngG71imgvgBlpRJjBaic16NGyQoPYizCOekjpwFoOQHRfV65a3SGgzuzaFGpw3eX7ZvxeS63N3TNiQQXmaaOF2ohOvbAVI4Lbme7JfIF06z2aGQdcSuQDyOxaDcNOmIpTMQjOuHFkGT/B/AbXtG1NS6IyE2QnomrAZzwAPYcDWDkCQLtEpQaeUUQJQz5apHKqIkYoyKWBvNb0wwLcGXb4m3HJeVDGwvPR8YxwcA5RWqfWbhdjnXpwlf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyA8O6yqIbA8nKl1kMkX/KN36iJhM9H8YYCoqEIBQ5o=;
 b=yOp0NttEuXfaO8DMbvc98gijKz7mxihIlu1eFZCx9UeFVx9hkp2S1soQZok7Yj4BxG5BvfN9WwNo/yFBYF2FgNVOE11WU+mjp2egtJibQ9SkcKtYk+xNcFWoB1e5DTAmBoKecVvyyr3iUVblFiZ/0gFFFzSrTgnWhEKLVfuAiuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 02:26:15 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Wed, 8 Jan 2025
 02:26:15 +0000
Message-ID: <4d4ba2f4-a294-44cf-b79e-c93c4e23cb2e@amd.com>
Date: Tue, 7 Jan 2025 20:26:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix per-policy boost flag incorrect
 when fail
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, perry.yuan@amd.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com,
 fanghao11@huawei.com
References: <20250103074139.1080092-1-zhenglifeng1@huawei.com>
 <7e777177-417e-41eb-81d0-3635769d3a83@amd.com>
 <8fcec19d-9f3c-4ec9-99e9-d3003a94efcd@huawei.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <8fcec19d-9f3c-4ec9-99e9-d3003a94efcd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:805:66::28) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d64bee-e625-4056-fa47-08dd2f8bd368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajd3Mk1hOWFZbFU2aU12RlZXTkg3R0VlcWFRb3M4OTZWS1kvY2h2UTg2VUhY?=
 =?utf-8?B?VDVKcEpCMk1SRXM5Q0pJbkoySU4wSkg4LzZwTFV4OWtheVgwY3RwM2JoVzBl?=
 =?utf-8?B?eVBYL3VNSkRmV0NqNU9YZjM2VU5oektDejk0Si91Zkw3UU90L3U1ZWY1ZXV6?=
 =?utf-8?B?aTUyVUt1eFJ2Uml5UHRLVnpNTjQ2c0ZweDZUNkhQcXd4SDlsMWZXL3dEMXlT?=
 =?utf-8?B?K0orb2hTWEVKc3l6aVBSRlRINEd2ZDNXdmxFdnJFY0l6QzRtYlZzN0ZMRkZG?=
 =?utf-8?B?RWlqTERhUjdFMmdueW5aMTBZQit5K0ZFT083UDdLb0l2MzR0dDJ3TEIxSUlz?=
 =?utf-8?B?TlFXZWZSRUY4aHpxNDIrcG0rWTJvRnN4eVVGbjJMQ1FMa2hiZVNjaFFBSVZW?=
 =?utf-8?B?S3A5Z00zdlkrZHZpT3hEa2JIdm8zdGw1Z2ZtRG5CVnpUd2lIS3d4TGhSREZI?=
 =?utf-8?B?VTAzWTZWNWM2MTJyOEdCSTNWVnFFYlNEOUNsUEtqcTloWW1kWHo5RTlJdUU2?=
 =?utf-8?B?bjhTV3o4bGJ4T04zVGtBWGhWTmJPWVpBR25IazFPOVQ1bFNpU1VrazcxenRH?=
 =?utf-8?B?YWJSeG00YVBWd1cyaFhjcURqMU9aaVFpL1ZQdXpKREhGeFFUUkhaWE9SWit3?=
 =?utf-8?B?RzRBdzErZ2hUMFdjemVKZFViT1lOaGM5U3MzbnJHY0FVMzJ1dUU1ZEJnTXJV?=
 =?utf-8?B?YUFYRk1rbUJDWnhpbmVlYU43SlNRWkhlb1FBQ1AyTHdmL3pvb1RzdmhCOUFY?=
 =?utf-8?B?Tkp0cmNIY1dJWDZiQUdrQjhpbWtDc0l0M2Q4bFdSVFN6dFNmOTJodWhPZUFI?=
 =?utf-8?B?V2tUYVF3U2hnQWZKS2JhdlpRNmQ2TldXWG5hakJveThxdHNSV0NtQ094VTlG?=
 =?utf-8?B?MjlaK0Vlb3hlbUUxMThTbGRxWTdiNXFqZCttTnBPbUViK29oS2prSytJeFc4?=
 =?utf-8?B?KzY3Y2xzQkxpbTRkOTVEYkNaRXVEQjk5dTZ4OG5jKzZ3UlRXVHd4ekp1VHhW?=
 =?utf-8?B?a1Vld2ljSXZFVnptUXFoTGJBdDZBbUw5enBBcitLNW8xWVZtVW8wMW40ZTA5?=
 =?utf-8?B?T2wrYklqU0xwdHJicVZHV2UveFpPRjhLUHRmcTU1emNDdDNmMW1nK1l2cjlS?=
 =?utf-8?B?QldJN0tQRElzYlJqbmpZUEt2UUhlMUs0bExLVWRZVGVnSDl2UTdzU1FyZGNm?=
 =?utf-8?B?ek03ektEelR6UmV6NVIxUFA4L3FvR0xTRzdhL2dGYThPQ0hQQmdMV3hNMi9m?=
 =?utf-8?B?UDRHcXlMYVNLRGY3Ujd3YXpGVW1Fb1Y0OC9XYTEzY3gvaFFNaEQzTDZqSE5t?=
 =?utf-8?B?U1Vod0xwcTFxWldkbGxBVCtsdVdEK25PeGFYMFdPb3pLMVN3cU9ickRXem1F?=
 =?utf-8?B?RzVjbGIxS2Q0L3pINVJ1eTRrdHI4ZkNMa1Zpem1hMlEvdnpBeXM4TmsvWU9V?=
 =?utf-8?B?LzMxVTVkTWxPZ0NNTGRYS1lvZSt6ZmtUTjkvaDBxeElqNHUwbG1tWm56ZFB1?=
 =?utf-8?B?cjh6L0F4K0FpSzV4aXdqeW5lVC9OSnVqVG9CYWRkdWgzdmoxL3FQSloySnhJ?=
 =?utf-8?B?SkdndThFcnI0aS9jZE4zM0NNQk50UlFoQ1kxdHF5VVVWZThBd2NKQmhJMUpU?=
 =?utf-8?B?Uk5xQnU3aC9lU0tQemJySHpVZmdWUFhaTC9RcDY3OUx2V2dGbEdTUUpmS2hX?=
 =?utf-8?B?TjBZV1BSV0dueGJsUCtmNkNoQmk3U1g4eTdRL3h2SFdiTmtHaGJIblFhUjdV?=
 =?utf-8?B?ejloOTFQbTZVU0F4aEJUT1V0RWVRTFp5WTZQamthNVNwT1Bxb3VpR2VMZDEr?=
 =?utf-8?B?KzNtUHJqRWZ4NTA0UlFIWFhoTGgyVjc5STV4NFB5SG5GUFdJalhCN09BSDIv?=
 =?utf-8?B?WFZTYjNXNGhiUSsrM2gvbHJvRzJzRjROcWFnWm10M08ycWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWFxY0wrcWI2M1lwZmxhRHVWNGRSd2J3ZnJRalBzK21ITHpJcER0UElCMDBH?=
 =?utf-8?B?a2NWeFBZT0JWNXZ1U1pxZGo2WXZxT3M3ZW5KYWNxMitjNlJDMDhpdG8raG5w?=
 =?utf-8?B?K0xRUXdEVDdCSzVQY0w1Ty8vc0t5ZkFtdWpjZWxKUVBEcmU2bnphSkZjakdV?=
 =?utf-8?B?UUhpVnc4VkR4SUkrRks5emhTbit1ajhXaFh4SWY1Q2swUmpQWXJZN1pCTGJr?=
 =?utf-8?B?Vi9pKzlWb01aMWxWaTh5Ynh2VDB5MXhvY0xUWGpXcThPQUs5YUNTYXJCdW9N?=
 =?utf-8?B?WkpMS3dOK2hhRnBXOXU5N3V1QUdJUUdzalZXclB0VlBBb3E0eEV5Y1ZBQ2Yr?=
 =?utf-8?B?MWZwMDlka3ZrNWlCTGV4SXNsY3JiZGFnWWtac2JDVXJ6VWFPQ0F6K3l1YzJO?=
 =?utf-8?B?bllaQm5CN3ZWUDY0dExQY1N2UlNnKzNYekl3TDA4VkRjMW1WeVZFdi9wN3dI?=
 =?utf-8?B?ajczV2k0M3lna2VKcTY2ZnJIand3QUN1NVpFS0l0aVJQVGNBdXcrSmhtOUkv?=
 =?utf-8?B?SWJGQWduRmRpcytUcUl0cTVIdnhKaXdQT3gyME9PaXJOMnY5eGNkOXpRVmd2?=
 =?utf-8?B?VU1SSXIxOEgweXBudzVlU3lhRGxjK2UwdzNyQ3B2eHB0YkRkdDJSYUUyRncr?=
 =?utf-8?B?cmxTeXVXdHhkdEo4bTUvOGJTMVg1dVZOZVNBZGpVc1lKQnllV0M3Ni9UUXVR?=
 =?utf-8?B?N2xSelJyQjZOV1BabmFDcFJhdDF2anZiNjUxZk43RVhJTWZsSmN5ak1LWFhS?=
 =?utf-8?B?QURKUzFKdHRVWXAvWDNvbG9mQW8za1Z2eU0zNHVsdUpPYU05Q0IwV3N3YzBY?=
 =?utf-8?B?bFZnUnR4Qmx1cFoyZTZCWnppRjZ0WWtjMzM1MW1sUnIzZEkwOVNlYXAzYWcz?=
 =?utf-8?B?cUJ2SVcvRXNFQXlrWDdrTU1BcXNOb0hzNmdoTkdtVG53cG1wMVFOTHV6SCth?=
 =?utf-8?B?bTArYlNXc0pSRXBvQ090Y1g4YW0rVWcvaXJORHdwSjYzejNjZENEQlFXR3Rq?=
 =?utf-8?B?VUdZNC9ZSkgwTVdxTDA4cHBBUTJzM216R2psamRCTDJZdWxNL2pJbWppcnNM?=
 =?utf-8?B?OHZSWWp4Unlsd1RZV2pCQjIwQldablNNN2lZSE5ZcHFhQ3R1UXpic2hscUlS?=
 =?utf-8?B?OFd2ZFdYRGVmVzR0bUtFaUFrOTRUSXNHenVCRkNFaGFBYTRuTWY5MzVndVZW?=
 =?utf-8?B?NVRwNldaUjdjcXZQU1ROQ003K3h5blRJWGxnd3hEQUdBM2J0SXJ4K2lJalhO?=
 =?utf-8?B?TXUxcTJTSzl6d1B4cXp1NDdPd1R2MkwxeHhOcmRuaTVlTzNVbGQzZVVSM2hW?=
 =?utf-8?B?WGRPdlN6WktHTGtaL3ZZbk1vNXN5cDlySW5Mb0FtcnA0MndFK2E3b09qcjFk?=
 =?utf-8?B?RDVpRi9WOE1zWkNYdHdNWFltU2QvSTlQYllqMjBmK1Z2UDZwNUpxcEJlekl2?=
 =?utf-8?B?MVo1OFViVmFzNUhLdnhUZ2Nkd0I1Wk1mcEVsUzJiTWdpN3V2MUE1MXRHTk9i?=
 =?utf-8?B?a21Zb2xMUzVsSEpvRFlLQ2RkcVVMaTBKSDJzZllseDZId1dSN2Q4ellvaC8y?=
 =?utf-8?B?SEVFUTBGei85cmVvSjZtdlNhWnBiT0o4aDhrMXJTWEpMY1l6akdDWTdvWjlM?=
 =?utf-8?B?VEZFOVFXbnVVaG51OThHWU9QZGcvemIvUjdRVy9Mb2hGNFc0TFJsVW9IUGJ4?=
 =?utf-8?B?bHlTMTdYekpxdVJCKzFKZllWUjZHc2dRUXZLUWt0UW8vejBKZHI3b3k2WkJM?=
 =?utf-8?B?R2pRT29OOXd1aFM4d1Q1T2R2THVuOEhJdXMxYzZBNEpGL0pjMi9pL3YvcjVU?=
 =?utf-8?B?YW5oUmJOWEwvRFpnaGl4WHVhcTlPaHprUGxhWDB3ZEIzMjhsZExZd3RuWDNS?=
 =?utf-8?B?OXpxbmhXeG1FTVJCSU85ODNwSGpzQWQ4aGxKWVJZSUttSm0yNFpOY3pWcTRr?=
 =?utf-8?B?RHM3aUd5bWVMbC9ibi82NGhHZ2t0TTJTekNHZ0x3TmVCK21RemFFbWM1c0Z1?=
 =?utf-8?B?S0tmM1ZFenlDcmd6TlpLM0NWWjJCQW5odkVRMlFVNGpLSlRPeE5xV3M4bVQ0?=
 =?utf-8?B?ZDdsbHRJT1UxS0FRV25PdExRdG9GdWZhTU42cldvR2UvRW51OFRsMFQwUWFo?=
 =?utf-8?Q?Cv8Un88sHpDkEPAaRk2lhUj2g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d64bee-e625-4056-fa47-08dd2f8bd368
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 02:26:15.1818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLLAPEFtrysohw9I7K3m9V9A4HN94V6VIspdC0yHZyqO3qhWya1XUQjQNDwzDEDqekVX0JhyQiW21l9JN3PknA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581

On 1/7/2025 19:31, zhenglifeng (A) wrote:
> On 2025/1/4 0:56, Mario Limonciello wrote:
> 
>> On 1/3/2025 01:41, Lifeng Zheng wrote:
>>> Commit c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision
>>> boost state") sets per-policy boost flag to false when boost fail.
>>> However, this boost flag will be set to reverse value in
>>> store_local_boost() and cpufreq_boost_trigger_state() in cpufreq.c. This
>>> will cause the per-policy boost flag set to true when fail to set boost.
>>> Remove the extra assignment in amd_pstate_set_boost() and keep all
>>> operations on per-policy boost flag outside of set_boost() to fix this
>>> problem.
>>>
>>> Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boost state")
>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>> ---
>>
>> Hi There,
>>
>> Thanks for the patch.  Unfortunately, it doesn't apply to the current linux-next branch at https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> 
> Hello Mario,
> 
> When I try to build on this branch, I got an error:
> 
> arch/x86/kernel/relocate_kernel_64.o: In function `virtual_mapped':
> .../linux/arch/x86/kernel/relocate_kernel_64.S:249: undefined reference to `saved_context_gdt_desc'
> scripts/Makefile.vmlinux:77: recipe for target 'vmlinux' failed
> 
> This error occurs when CONFIG_KEXEC_JUMP=y, and doesn't occur when build on
> torvalds master branch with same config. Please check if there is any
> problem whith this branch.
> 
Hi,

It's because the branch is based on an earlier 6.13-rc.

Two ideas that can help you:

1) You can pull this patch manually on top of it to avoid that issue.
https://git.kernel.org/torvalds/c/aeb68937614f4

2) You can manually rebase the branch on newer 6.13-rc locally to make 
your commit.  That commit that fixed it landed in 6.13-rc3, so rc3 or 
later would be fine.

>>
>> Although the issue you identified is still valid, there have been other contextual changes in the function [1].  Can you rebase on that branch, test it again and send a v2?
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/tree/drivers/cpufreq/amd-pstate.c?h=linux-next#n750
>>
>> Thanks!
>>
>>>    drivers/cpufreq/amd-pstate.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index 66e5dfc711c0..4ce923788f3a 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -730,7 +730,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>>>        mutex_lock(&amd_pstate_driver_lock);
>>>        ret = amd_pstate_cpu_boost_update(policy, state);
>>>        WRITE_ONCE(cpudata->boost_state, !ret ? state : false);
>>> -    policy->boost_enabled = !ret ? state : false;
>>>        refresh_frequency_limits(policy);
>>>        mutex_unlock(&amd_pstate_driver_lock);
>>>    
>>
> 


