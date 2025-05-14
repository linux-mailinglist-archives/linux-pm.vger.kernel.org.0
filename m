Return-Path: <linux-pm+bounces-27130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0923AB68DC
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 12:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4743BB406
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 10:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F280A2701B8;
	Wed, 14 May 2025 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d2pBLYav"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4667E42A82;
	Wed, 14 May 2025 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747218725; cv=fail; b=m349c4FjcVgIpFvLjj6BMg5P1Nvbe0hJHtC7TzTpcMMfACB9K6QKBy9aSO+c7ARAa5QLNsXQeebSiR8lMdmqJS+RFJW15F+HhhWWYCkZlnpg1qgrcZx9zlbof5NzfuUsXdzd81AyLgvK7xfmIpe6SQDW4fzES6gKzvcz6PpIBQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747218725; c=relaxed/simple;
	bh=FqeJ+u6AcnmIyWUadsDliP6pyjCjVmrg++reNAFYGx0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TYoSaTaKLm5j2ZlzwwuxGmTqOOO0pM4EUAuGu/kwPMBEjYpc0qBTyT41YC7VXJUI4Q5FhRSG5hKL6/si5M5VuhgHr1hox4kahjr50ZuaLe6NwiOxcv/qty+2LTcxeU2QsNgTZY1QBrj3qjTWU79utJzf2jnf9QbymjDTqoxjK7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d2pBLYav; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oq84SgZx6EE8c5pD2AamUSF4zHI2OL/CK5P3zHIz/HpKBGfwl2Xftx1qN3HWLnECxzKA7TJN7bm0rxJz6Yy6jWTs7WlQodSpNruP5xdOtBR7SyvD1jjsbiBN986ISykMALtwvti24o2/57CSU3D1A5/RW2PfM3LS3r1LdgnU0/AXwjpo8TwquECbHz/BWyxejJHYtHkCxRMXAmQ2Efg5OegGVF85XJXDZiTISzydr7f+d7Q2116SdYOzQxh4rvQwUHSJq19DFx+tIeR1t29BVP2QB0Lt2HsDYaSkZaTVDbmDTF7EQIhLI8ZQheMbNZvqtOhkBVWo8b1y/O8pueuYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3CvaS1dKZAy+NE73h+FE3kDH5yr5oXpDryWOfxkv7g=;
 b=dE0pUQkZH5hou0A4TPOzwkTGXMgW+w+FdwDoAuznlKI2mRSeQWLt4suU1nri8mS8laY8PjfP8TGT1r1BfgFLLvv3M2b3o+VZCG4pIZY2o3xd6nO1P7zOKmcYfkGtIgMrAOyUiKDXWGVOJzMy69Ez2kHnGjGscX3mPvKZAAIu59JD1z1Y22vBwiel6Q8HT/FEzgcCZDG6fHJsssaUVZp6/B47d8EKUJfOzxvEe9g4p/c7bkB6uxnyJwd5o39LCTHAoRNgRNJ5dmq3gGnHZ2a1UwVxwGkd2AVOHVX3dMpII0+MckWVWYEqFlliZN3i0cgYSs2nJyiqnknEEFyb1i8w9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3CvaS1dKZAy+NE73h+FE3kDH5yr5oXpDryWOfxkv7g=;
 b=d2pBLYavrZiJ3AdUe1uSTgR8yb97x3v8kvTGZ9Wn/9Zh1+u+ZpZLzU0aia0abgUnD2JUXM7zAmbiKzbCMmoY2JOjXR2pXCHCxfd5W2Af2ne0DTAQx08o4mr0s99mabGhCN7COg4qGw9d4yX9+8VwDh9pCNxNbqxhQG5BZ8P8IeQZ1VRvSsdv/zrdIr1MuDGtrKHLWQJAA/klR0fK4+jXtylQGa+jJEKJk3cAZyjcK0ww4U0vFTpYChPDrGa/F3gcLxhaiTxRzKd8IVdiXhb9NAxRuvXs8K5+LhIZ0F4ua8o7GeLxk5dQ3IDrv6VrvJMl2ged7AT5dPhLArGqqSaUpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 10:32:01 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 10:32:00 +0000
Message-ID: <da080e61-4e54-4334-a239-1619bf8fea0c@nvidia.com>
Date: Wed, 14 May 2025 11:31:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] cpufreq: tegra124: Allow building as a module
To: webgeek1234@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0161.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::29) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: f6681187-d6b4-4bf9-64a4-08dd92d28f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alRKaVJOcDNuWGJoUWtnR3pJVlhTUk16Tk9Cc1IxckF3NXMrTjhnd3dyTEZs?=
 =?utf-8?B?dWo3MUhuMllzYUdFeUl5b3FsaDRnTWxqY0Q0ak14REcrelZ1MW9GMWQzMHJm?=
 =?utf-8?B?ei9ReUg0bWsrWXlWbEhwNW9aQVIySWo1TWlzT1FuMjdPb2h6c3lmeVY1NDdF?=
 =?utf-8?B?OXk4OVJuSmFKWHhCYWxUQnVWSEpTVW5RL2l1T2JNdW1oQzMzRjFUSGRTT2dV?=
 =?utf-8?B?S0QxVVh0bDF6WHNjODcxRElFNE1yTkg0dEEwWDYyNkIrWXpCVDlmZGpiZUd5?=
 =?utf-8?B?aTB2L3FYUUo3TEFyQlliMTd1eFFKcG82emxwOEdEMVU3T1NmUnd1NExNaUJ6?=
 =?utf-8?B?T0tvRmtWQXlpMUN4dVNtYlFCeHRPTWFLWHZYSmFFbjgwNVU0dkVwaTRzSGp6?=
 =?utf-8?B?ZXFCTlgvM01OZkhwQlVncWdIdzFjdTBGdlBmZHlad0E4Y3lFMmREQWJJRGpK?=
 =?utf-8?B?NWx6blpuZmxTWHhlbERydEUzZkRTMkpMTzZPS2Yzc1kvODNMUU5FKzFMUk1M?=
 =?utf-8?B?ZW9TOGc1T1JmQ0V2UFBub3FvV0xXMlUvWEwwSTd3b2U4ZGlpYXljRGUxbnp1?=
 =?utf-8?B?TTRhV0J5emdGZ2RiV3pPZDIwcUR5ckFZVW45SUN6U0VnUExCUVFoSjlBSnJQ?=
 =?utf-8?B?TFZRWXRSOFV6aU5qUnl1c1JoYVBvQ3FsNDg5THY2L0hBWmNtQkpMbTVWS3BU?=
 =?utf-8?B?MWVESnFlUWRPTlJISDVMdGJkWm5NbmIzSHpzQUhGOWZsM3kvZS92WERXRHR3?=
 =?utf-8?B?T2NDa3ZrZ055a2pTYVNXVGRlTVVoV2tCOUQ2S3RDYW5pLytUODQ0TitmUC9q?=
 =?utf-8?B?bkNmZVNuNzAxZmtUdnpBVjlCcVBYZXlvVU1adExaTC9YbUEyZUFCWDNZV2Ns?=
 =?utf-8?B?VGhuSm0veDhFa2ZBSkc4TGhCMHlRektVQmY0Yit6N2pxS2w0UEdnTHlVbWxw?=
 =?utf-8?B?ejBoZXZDNnNLaWlaeEg5K0R6YWZRYmNMMmZmdUdUelRrU09lcmN4aVJScVQ2?=
 =?utf-8?B?MVRtZkRYdmtjNEQ5ZTJCaTBHeFd2MjhqZlAxcUYwMTlXQ2lQSUEvTDVRWmJ5?=
 =?utf-8?B?andhZUZLQVZBbVJvRVJHNlZqcVBLa0RpUStJUGdqdFJNaXJjcUtBU0pTTVRS?=
 =?utf-8?B?cy83dHR5RXpFSVo3enRKSjY2RHgvY0J3aGFKMnVzSG5XQmJlWXloUUxpbzc5?=
 =?utf-8?B?ZW5RaFJndVpUcWtMYkg5aEhGVlluMCtrUU41aUNKQm1MMCtSZlQ2dkU4Mllw?=
 =?utf-8?B?dDljQ1FrQWhZbktncnRhaWlmWjIrSVRxaklqUVRUS0t4eXY0RzJUangvUGky?=
 =?utf-8?B?RHZLeE5Ud2xIaVQ4ZEdFRzlvQ0NHOVdKenM0S0lrMDVOTy9iUW8rMnp0UVlt?=
 =?utf-8?B?bUlVV3VGNEtDUFhkV0FkSFBVR2lYOXpmUmZhYnh4a041Nm50U1ZLTW5WUUw0?=
 =?utf-8?B?S0JENzRQSnpyUngzSTdJYXdIOVVFVmlwdG8rZFc1WnRPdlVVMkRNdzUxZUk1?=
 =?utf-8?B?d0cxMVlRbXhxeXZLM2NjQ2tCWS9ZUkUrMFFlUWxZMUxnVWdESFV4YWpSdk5W?=
 =?utf-8?B?Y3FBdnE5b04vVVR0MXA1QVpzNlNZRTJyYTI3T2JRTERWT0dqU3dtSG0vZW9T?=
 =?utf-8?B?ZnpBRFFpLzNDKzRzdXA0NitXSlQ4TzNROHh6elpHN1E3azFqM1lKUmpNcjRh?=
 =?utf-8?B?SWlzaUh4Ni94dTZlYnVTbnlmc3p6YTRWYWdBbXAvN0MwM1NvaFE4VVBhckpi?=
 =?utf-8?B?bGVtcSt0MkRuTWJpT3lqYlhycC9TZjIyaXN1SFVYdUVnRklTeUViNFI3RXFB?=
 =?utf-8?B?K1NPNmtNL2pqL05aZWRXOVplalJ5VUlTM2FmZlVjVy9HS0dwb1doVDdpUjRR?=
 =?utf-8?B?SHFmbXdGZW9QK3VaRXQ1ZUwyQVlmbi9XUGIwdWcxUkYwNndtYUYzK21KSVVp?=
 =?utf-8?Q?jgWJtqiDKFg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWsveEMwbjEzVC9CSVdLcXRicWhJTWNWOTFCUTFxUEpkYzdUdk83NllRQjVi?=
 =?utf-8?B?THNxT1VJOXhqYndYS05oOUl4MVFMUTJhYTY3Z0ZDbU5JaXg3N2xjMllDSjNZ?=
 =?utf-8?B?dE0xQ0hBT0JEa2NxQThQNHBIZkM5STBrd2FuaUIrVldvanZIbGVpZWJqRjA4?=
 =?utf-8?B?MlFTSldLUWZUclBnREhvaXozYjlsc2M2dFhCbk9TWUw0WGhtT3Z2OUFxVmpG?=
 =?utf-8?B?NW15bUFQZk9iZldCU2t0NGNFSlVBVlFKSm1vQ2NkaWZ1dEp3N0F5ZWdyRzdM?=
 =?utf-8?B?MkpGQjdWY0hNS2JrNysvZEgyOFVVcmk2ZVNaNG5qTnVqbjRTZHIvV3JzWmVD?=
 =?utf-8?B?Y0N4SnZLMk8ycHcvbUZNMGU2TUFSR0pXaVdxVEMyZmlvVksyUmFCUFRqMkta?=
 =?utf-8?B?dzVTRVpBeUozN09WdEJOQjNvU2pQa3N0cmJQQzVoYlR4anhKNUJ5YmgxYk96?=
 =?utf-8?B?L1VFMC9CZ1J6a1lpTUtHTDBIdDJGNThKcEV4RnFHc20xNzd1dnBSZUJPVk9t?=
 =?utf-8?B?TjR6K2JZdVpjVHB4VS9qTnZUT2x1OE9HWkp6RGFveXhIZ3A1cHlRN0pVQXU5?=
 =?utf-8?B?NkNha0kxUy9KMXRDK1AyQ2J0N1RuSEpqZVViaUMzaDZQdFh2cnhmZytNeGlS?=
 =?utf-8?B?eUlpc21DZHNpSmw2LzBnRkNndWpYZTcxcHl0NHJSdHZKSmttd3NQWklOelRI?=
 =?utf-8?B?U0lSQkNRTkFOWUY3bDFYbXNqT3hWTkVhOFp1VThRNnZzeVZ0eUVoRlNqbDV3?=
 =?utf-8?B?UmRFY1ZWUTFwNnp2dlU3NTNpaGNGZVdaMFFybVpCT1NYcmJBekMyZDJvcVQz?=
 =?utf-8?B?M3Urb0V1UGhRemN2RVpuMFFVRWNxK0Zrem9NeU9KNWJYSWpGMEd2VVNYOTJH?=
 =?utf-8?B?SjV1TTZVYlhuNUMwTzE0amRRUENOT3AzUmlQUldxS3RLenB4ZnR2T0w3eFhj?=
 =?utf-8?B?QlJPM3o3RmxYVGpOdWMyRlJwSEx5MnNxNS9aLzUzNkp0OEdhZFZibGQ3aXJW?=
 =?utf-8?B?YnZxOWVhUS9RN3dLNlhzR3BwRGhXK3BDQ2NrZFhQVGkwWGRMaW4zbUxDVk5V?=
 =?utf-8?B?bTFiNnVuaVVDb1k4aTc1bjF2L1FCbHFwMEVDd0lydzdZV1J0bVA1TEIxTXBH?=
 =?utf-8?B?Q3AxSG8rYkRyMERiS215L1BxNjF1a0luQldNYmR3U2pOQUwya2IzNmFlOVNB?=
 =?utf-8?B?VG1kUmZLTFRsY1VtMkpUYm9tLzgzUkMzNTdTdXAwMmh3QmtwbTNEeC8rOXJE?=
 =?utf-8?B?WmFUeWR1U28yN2FWK0pLVDdoRWNxcTUyeER5NVRhd2RhM3M5c1RDY1hHOVBW?=
 =?utf-8?B?M2g5WmpaUHE1ZlFtc0M4TDlNZFlGb0x4Z3JGSldFNDgzaWpDenFOTTBscjRK?=
 =?utf-8?B?UExncHViSC9qR1NGUk9Ba3RZRzY0SEZhOExxY0RjcXdlcXFSTHJQRlNNWWtQ?=
 =?utf-8?B?MTVKZWM0bVZNcVNxZCs0czNwemFKZkc5U05sL3B5MnR0ZzFXNnBwQUM5VHdj?=
 =?utf-8?B?cFMrWnpQOHB0WU1SWm5yOU94V1h1SzBlaUQ3VElhMGlGN1l2M1hWWmhVOEpE?=
 =?utf-8?B?VXVGRDV1ZWI0aXhkZm4rdzNoNFhrd09KcGZoSkNJa0RXWEVVR3o5ckV5QXhQ?=
 =?utf-8?B?NHlFUm1nUzFBUWlPS1RSZ1oxT1cwdmJmUDk0MzI3WUNCMnVxVWcwbGFtWHNr?=
 =?utf-8?B?NkNsTVoyQ3hsVWNnbUpSaCtNTk1zSTZXai9rQkwvN2pCZDA2M0Z6dVZQR3NG?=
 =?utf-8?B?ZXhlMCtTMlBCS0Qxb1cwYlAwKzZQS3B6WFE1M2Fub3ZiNmJHczR4bkxWZ0pj?=
 =?utf-8?B?TjFEditQbFhVTFE2anlSOHEyMzZVeUJXM3RJeUtHVjRodGlKUG9uMXAyQVdP?=
 =?utf-8?B?TjVLdDZhdVF4WkpURnY5QXR6aWVoTWd5Vkp6YVJhTzFFdytGWHYvc1lXeFc5?=
 =?utf-8?B?ajQxWE9oYS9wL050ZVh1N1AxcWFiZms1VWZtRkc0b3FpckZDODlOUUJiYkpy?=
 =?utf-8?B?bDJDZ2JZVVVBN3RFQktVLzExR2lRdktpVDY1Sjh6S05Xb1RaMjV4K1YrY0RX?=
 =?utf-8?B?SXJzaG1yeGZWeG5nUDNzb0lMZGRYUnE4a2h3YlkvUExHWDQ4NDdER1Z5QUxN?=
 =?utf-8?B?M3NXaVFPNEJWZVY5WFBnS0kwZDYweCtYZVJMcjdGQ1FrM2FlbURma0xsYWdr?=
 =?utf-8?B?b2VCNXpkQmpxaTdVUjVSOUZrR3ZTRDJhV2QrQTNpRDNVQVpEeXFiZHZ4TUFv?=
 =?utf-8?B?ZDE5dnlSbVhlVHhKUVpSNXlLdWJ3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6681187-d6b4-4bf9-64a4-08dd92d28f4d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 10:32:00.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/ZLFlAFEjbdOEYPh8jvbMzhSbsIh6inBc4sKiaKF3//TPN9/bFlyjL5P4EVkNqNC11KTqwPaWU4tKcAbkxXAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548


On 09/05/2025 01:04, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> This requires three changes:
> * A soft dependency on cpufreq-dt as this driver only handles power
>    management and cpufreq-dt does the real operations
> * Adding a remove routine to remove the cpufreq-dt device
> * Adding a exit routine to handle cleaning up the driver
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>   drivers/cpufreq/Kconfig.arm        |  2 +-
>   drivers/cpufreq/tegra124-cpufreq.c | 36 ++++++++++++++++++++++++++++++++----
>   2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 4f9cb943d945c244eb2b29f543d14df6cac4e5d4..625f6fbdaaf5fd774e3b0bb996eb7ce980da41ee 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -238,7 +238,7 @@ config ARM_TEGRA20_CPUFREQ
>   	  This adds the CPUFreq driver support for Tegra20/30 SOCs.
>   
>   config ARM_TEGRA124_CPUFREQ
> -	bool "Tegra124 CPUFreq support"
> +	tristate "Tegra124 CPUFreq support"
>   	depends on ARCH_TEGRA || COMPILE_TEST
>   	depends on CPUFREQ_DT
>   	default y
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> index bc0691e8971f9454def37f489e4a3e244100b9f4..b6059c91f2474c56809c403eca94eacf51df734f 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -16,6 +16,8 @@
>   #include <linux/pm_opp.h>
>   #include <linux/types.h>
>   
> +static struct platform_device *platform_device;
> +
>   struct tegra124_cpufreq_priv {
>   	struct clk *cpu_clk;
>   	struct clk *pllp_clk;
> @@ -176,6 +178,21 @@ static int __maybe_unused tegra124_cpufreq_resume(struct device *dev)
>   	return err;
>   }
>   
> +static void tegra124_cpufreq_remove(struct platform_device *pdev)
> +{
> +	struct tegra124_cpufreq_priv *priv = dev_get_drvdata(&pdev->dev);
> +
> +	if (!IS_ERR(priv->cpufreq_dt_pdev)) {
> +		platform_device_unregister(priv->cpufreq_dt_pdev);
> +		priv->cpufreq_dt_pdev = ERR_PTR(-ENODEV);
> +	}
> +
> +	clk_put(priv->pllp_clk);
> +	clk_put(priv->pllx_clk);
> +	clk_put(priv->dfll_clk);
> +	clk_put(priv->cpu_clk);


If we use devm_clk_get() in probe, then we should be able to avoid this.

Jon

-- 
nvpublic


