Return-Path: <linux-pm+bounces-26503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0660FAA5CC3
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 11:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE9E3B7F8A
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958DE211A1E;
	Thu,  1 May 2025 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GFYUrU6P"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1267126C05;
	Thu,  1 May 2025 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093090; cv=fail; b=s6muc7LiQztPWkxpQE8umN1wJh5Y7BfiAHqny5tb/Xe5w7JMCM2d83sNMQlmA/hFZd/xQ23/5OiiYAUh2fB6zj0SOuGUztsNXBrz5YRPBNHcPjffCRgueSoxlhcDm+KeIYLNUahGYzty6FoaeFuELi/rM9hXvJbWzFT/WUwQQrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093090; c=relaxed/simple;
	bh=9ClBtFhdQOUKajPygRJnNqr8gkKmJMwXeuvG8CYgOQY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pDccC+1glSeRUh4kcMcHO94S634YA8lorVnNeqVR3AsxsbAryXto/pMV4T3Q28yiHtieeIDdef32eon97c7JVrspwk0oZIF7hSxc6YTbGm8Wy7NV1e3Ec6k6wbO4OI+3kaa6MLXAUQFrXULmzgqmQ8UYDSCm1e1lyRdDXt4P8HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GFYUrU6P; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjvoZSY1KUpDgtKZhoprjgdNsbcVdIq4JAShQTFt8s2fCR4cUABRbe2NDD2MjIrCGXylVG9uCKpL3CMlumzlVVXfjRucGrXo9gI4IAB27+uQE/9FcJjfR6DMGzAgrxJ+yYlBhVybhkg55g9Aj7zlJGoVIIJXdEywjO1xoTqNChNSK5FAXyKbC5ILBvm7NkGLRaOzJMMP0zt2BCA43Zf9JkwyD+3uKI2phwJDIPOKAtZepRbk8IA/tN0kCUMXfeRPXYpV2rmv5qUTsoZPEyTvd5j31N9auKQfyc9qphP+jJ+o+bdW4+pkShn+zWAgA9iLvTKHZx8lhkKFZcsrOuhrpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh2hd5H6hd4bQmTobYfAzlKPeojmUN7DU6RyvdwyCSQ=;
 b=fCL8EQHUjImhd+NNvrE0YO9ec30LoUjRuSHg/cJcoJ5wBp2MiWhEnItSJAzkOw3y+gTKDUv5hvq2LByePdfL81KF8wcDd6iYdRHFl49KerSoJ9kNF5bzRMNAhLFKmFNr2UxtIlKxMt3EHZaYcQ3BTCCSEl/R1E80JVX0fcRCKSNsLa5yHIqc3es9RSDMrL2yN+dC6zRPmiWrT0ZeNgLXtR6O04I8xi3PWlMlNjuKi1/mR/M8W9xvfjfwK/+Eg15W+uYjft9tubU/Sr39O7BCxitb+Q7Uu431ZlhlWd23MLB2ns5NkicAhnK7Ree38uY0SQMLpDsrXr61OeeBLh6jMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jh2hd5H6hd4bQmTobYfAzlKPeojmUN7DU6RyvdwyCSQ=;
 b=GFYUrU6PJuJOEwprK0KXAQAAJkKL4nHpxRgLG+LevaebVUCKAc7GqoJjEKWbME2A9Gt7SyxXCj2fC4wsMxtOPPd/dsm7X7ns2JsT5FA+6JV4TMnQfAWyu6zYq0pIbQzn1FPdyGkpQWSQGqq8v+LczTb4GVskTgk9tyoyXTvHPDmPaQYWQjtZYw1LrkGBQdKAkX/k9iMe9xYvYSb8TotKjKjd7WBVxx/2+1uY3lJVlDbPjnXtbiT7H9tAd4vy5ffjUe05UuKBiSP8JUJOhIp/Z3ogRNv5amAicCzkRSS8f0SBjjBhuoJOrRbSlGGDc4vm2lXYp+vb9p8pvqrWCaoqwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Thu, 1 May
 2025 09:51:24 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8678.028; Thu, 1 May 2025
 09:51:24 +0000
Message-ID: <c6cd714b-b0eb-42fc-b9b5-4f5f396fb4ec@nvidia.com>
Date: Thu, 1 May 2025 10:51:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the
 parent
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson
 <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Saravana Kannan <saravanak@google.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <10629535.nUPlyArG6x@rjwysocki.net>
 <22630663.EfDdHjke4D@rjwysocki.net>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <22630663.EfDdHjke4D@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0551.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::19) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 0644b1ae-419f-40e9-d609-08dd8895bbd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzlZSFNMRW5iTHlPL2d5MlB1c2hNWFZPTkxuM2NWQm1qZm5rNWVheFBobWFE?=
 =?utf-8?B?aWNRY1dDTE4reVVDTGNQNEZzS0tMNmJIaDF3d0M4RjRKNkNRYVVoMzFRa3d0?=
 =?utf-8?B?bFduaHFNbHNhYktiTkFHVUFGQ1ZjWXF2NVZacTgwUmU4SUJTSEp3S3BqTjRI?=
 =?utf-8?B?QUlvZ3FjOU5EUjBNTnRYZUJUUmVvT3NTRGF5SDNPWXhiNmJhcDJsRThlYnR5?=
 =?utf-8?B?TUxsUTZyRGUwWE5NSXZnejJkTXRHQ2d6MEJIT0NvbHFsZzNIV0pjcm1wTWFS?=
 =?utf-8?B?MVNMVXhoMVZUTlg0WEorTjNvZ3NOQS9qK0llaWwzZHE1cTErUlBhdms4N0JY?=
 =?utf-8?B?eEtjWVJodzRvN0JtZ0MxSFRoaTF5eW93aGNFZGxET1YyZ1ZMdnF6ZTFxRnZT?=
 =?utf-8?B?aU01bHAyNFVpUTJTdGJ1TXIxMXUzWEc5Ny9nK1o5ZHJaQ0I0cUhDT2s3bjhS?=
 =?utf-8?B?Nm5xdzQrdUNTKy85aGM0L2NYNlhVdVN5cWNVU0hIUWhlSHZYdmhkZVRwN1Q3?=
 =?utf-8?B?QjdjTDFKdnBwM3J1M0V0S2RzeGJJbSt4MG1FWGJQRkp4VFRRdHEwTW1UM25p?=
 =?utf-8?B?Q1BldWk2WUwwVnN6TkdQdTRDRyt3SU1xUlYyQVN3NDR0NFhRa0pNejBTTjNR?=
 =?utf-8?B?ZVBKSFZTZE9OVVA4UHFhK3lHS011MUFsTWV1RGpuaDNzV1czVGtsV2ZVTmJQ?=
 =?utf-8?B?N3gyeC9BU0gyT3VVcXE5ODJzZXNDcDZjakd6cjhXT0dWQjh0YWlJSXdMSFlY?=
 =?utf-8?B?MFI5elZOa2IwN3o2amdvS0NCakJONXB5TzN3WFlVZjZvWkUwbWoyZkl1T0VD?=
 =?utf-8?B?emxTOTRqVitqS3N0Z1hGOFZ5VDBvY2tPU293aUxmdE8wek1TMVRPNzVVdDc1?=
 =?utf-8?B?eUQvQlpreUw5STNZZEhXWi9nc3FYOVc5cVdxNEhUaWlBV0Q2d0xnVWZwbXJy?=
 =?utf-8?B?WWxPSGE0RkgrSVVDVnRzZDBsZFBFUnE2Zy9VNXk3UnM4UTJpZzc0Undmb3hs?=
 =?utf-8?B?QktSK0lyYkVSKytBbkQvcXg0WFVlTGM0UGw0VStWVmtoQTFEbzkvVmpHWjY3?=
 =?utf-8?B?aEx6aGhrb3h2ZlZidGJJQmxYRG8wZXlubnZoa3QxblFaOWZEckVOMUhnRFBy?=
 =?utf-8?B?SjNxRmd0SkhqVitqTHhNUGI0UlExRFBwb21MOWtQTVV6VkplS0lpcmtRVWk0?=
 =?utf-8?B?RkJUd3ZxVkhoVW11RzFEc3hYcjh5NFhSWGwrNG1JVzgzNlBaN0x1VmNBNHZC?=
 =?utf-8?B?MWRLeDVjMEZmUzUvVk4rV3JBN2FmWE0vQ29TRW1USHBSS0ErSTVXbHp5V3cy?=
 =?utf-8?B?VWVPZUdJOXp1Wk1nMTdEdDRnZXNENG52ekN3Z1BJUXJhbUNndkl0cU1WK21E?=
 =?utf-8?B?Um9uNWwzeUFsclpSbFgyV3NUT0dOUEkwcUtLWVJZVmZ3RDE3bERMWXJnbnRI?=
 =?utf-8?B?Tm5OQWNObnpzNnFtRlI5MU1mQk04TlFVdjdDbnNvNkpjMGZKOUlhMkJoekt2?=
 =?utf-8?B?MVN0MmZQRzZTaVhBMDltWFNFTU5SR2tKYTR5bG94WWRZTzBIUHUzWWU1R0hj?=
 =?utf-8?B?QVVwTVZVNk95YVUzQU5WcWhTd1BPcDFKVHp4QzYyMU5tU2NPOFFDZ0pVUko4?=
 =?utf-8?B?VFpRSWQ2RnBYK0pScU81a3NETjZCbDZCak92OWVlYkgycnRsaUJ6K01KS1F5?=
 =?utf-8?B?RE9IVjAxUURMc3QyQWhIMjhoUldvK3ZsQ3NHNlM5V05SQnM2RTRZemE4Qnhm?=
 =?utf-8?B?NHRKS3lXZjF4bHp4dlVvc3dtOXVmWk0rd05hTU5IVVFYTjgrcjJmL3IvWnpD?=
 =?utf-8?B?ZkZzWWVhTGxJNDh6amFmd0lMMFBrNlY4dm5SdjBkTXMxa2lPWDJFMThvV1pm?=
 =?utf-8?B?QWtNQmdPLy9JSUgzbUZWN0ZjNFJ4TlcxQXpxSm9OWGNQd2s0VXZjdE9CT2da?=
 =?utf-8?Q?4ONgBgY3884=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1l4azNZS1JKS3RjTjltN0VaVklUZ2swSGRNdFoyN1ptbWtpR1FuN3NuUlAv?=
 =?utf-8?B?a3UzZ0lKbXlzNUpoWnpBSURBSTF0TllxWGdVczRULzJQRlJ0YzB3NGpZbTJj?=
 =?utf-8?B?ZktRU3JhY0V1L3EzMFB5QWFxRjVrT1ZyeUZxak1HUnhzcThZSWRBRkNHS1dL?=
 =?utf-8?B?dW9Ub1ZDaTZkRzdMVHBNVWM3M2xJUmgwS2NUM2tRWHptRUVPdnVrTURsOHRP?=
 =?utf-8?B?bGdVYWo4RVMwM1RHR2lpU3poczNpRjduSzVrMFdQejBvN0pXd2ZuMDVITW01?=
 =?utf-8?B?cnRhTU1EamV5Z2Z6d3pVOFVzVDdERzYwV2cvL1VOVmhrK01jRmQ5QzZUd2Jr?=
 =?utf-8?B?bFZTWFg2TUNFMCtXTDVXN0UvdVRZOGZRU1pkMWc3a0xqNmFuZzRVMjhyb00r?=
 =?utf-8?B?M0xTcGhJVFFlL0VWeklGNkZwUWFINHJ1WXhxV1dOaHNiQ1FPZjJuUTVwS3pV?=
 =?utf-8?B?YXVmTG9KQXl3VDJiVXVKL3RZcGFrMXRvTFlNVFdRa1hraFcxS1VDY1lDc3JX?=
 =?utf-8?B?ZUVQRkZxYktyZDNBWWlhYXdwZExteE11aWtIUDAxN2w0Wko2VWxHL2Z2WW41?=
 =?utf-8?B?VDU2SFo3c2U4cWZ6bXVuY0pOdW5OTHgzSVkrcFpoU1RhQThraFdhZWFDMW14?=
 =?utf-8?B?QkNFVWY2ekFaYjk4TWpJazliYTV0VTNtYUVUNUIwcTdtcEhFb3NhajZLb3A0?=
 =?utf-8?B?eEx4VVppczR6UnIwSUR0TW5pR3g5T3dsekZ5OGsyME9wb1lsWHFZQzNJcHRE?=
 =?utf-8?B?RUFMdUdQaWFobVhHZitxcEFEeHV6YVpTT3JteUp1WGlhdDJUdTc3dkRVZXN4?=
 =?utf-8?B?Uit1U2x5REQ0bm4wU0duTFh1M1dvVzNzZHdVemdwVTlNQ2xPYmR0ckhIU2tk?=
 =?utf-8?B?YWM2MVVDSFg5RWRXTWRZT2IzdnVCYUFnSjM2K1laRStlb2pkRllnUHc5V3lr?=
 =?utf-8?B?TmU4VUxZa3ovRFNvMEY3NnNPTmp5TUxyZTZqeDhkOTdsMXVwNFlmbWRYcTgz?=
 =?utf-8?B?OE5MQmJVUWpwODcwUkF2NGZKMzJ1L1RzcmNtK2dnenU5dE1NVFdGcTJybVVU?=
 =?utf-8?B?b2tMZlVrU2czSGFMcUNQRUhISU9ZNVFJa0IvVEhpdUs5cnpJNmdTbys0VE1S?=
 =?utf-8?B?L0srRXdzVnJQa25iU3Jrb0ZvSWVmSkIvcTVpOHI1bko2bk84VkZST2hRWVgw?=
 =?utf-8?B?UFNQdnFNR2ZZRXZlN3IrUTBSMXl4Z0NoR2FDTnFhVkRUYU9oN2xmVlJQM3Fm?=
 =?utf-8?B?NllTV0xrOEdVQjNldnU2R1RKM2VXcWJHMm9iY2h6VmNTOVcvVFpaZkJxZ04z?=
 =?utf-8?B?Umx1NWJ5eUhNS2kvaDlDc3EwVC80eGlCU3pjcFlUS2tTZUxSUDFqSTc2NXlG?=
 =?utf-8?B?RWp6V1VxRkJFRmF4K1F4UFc2OE1qdGp6bFJoN2ZZUW9nVGhnekM4TFI2S280?=
 =?utf-8?B?aUpSTTVXRG44RU1ObTdGVGZQUVdDVnV6L3hWTFM4OXB0Z3I5VEMwUHVMcUNL?=
 =?utf-8?B?K281M1VHY0ZzZ2RQam4rYjcyYUhNcitPVjBaNnk2VjZ6UWtNcy9tMDBBNkNN?=
 =?utf-8?B?dnFtUENhaUhsT2kzR2Z6RHE5b244bkJLcUxERlNySm5uRHp4aUwzWUVaSXNw?=
 =?utf-8?B?UWRUU25ta0FDSlE5TFk5c3BmSXB4bnoxdFFTK0JDeEk5d3pRTFNRa0htVnRa?=
 =?utf-8?B?NGphVnd4WU5tQUtGV0hkU2xBMXQrcEpVVm95SVJkM1loekFoNHRNRnVvVUxl?=
 =?utf-8?B?QTF5M0hqeEFvd1V6UDJsc2prMTV0VFgrT1dmaG5MNzNXL0F5d2hvRE43cmJ1?=
 =?utf-8?B?cEowZkFtUCtvbkhyUXd1MjFLTGxScUtmeFJ3TE0zMGpXdnhRZXF2NFlsOTh4?=
 =?utf-8?B?MVZsZ0VKbVllNDd3WmJOT2dqTTdOQ2RxVUFyNjJMRm56dHkwR1hnbWtkeDNa?=
 =?utf-8?B?QUtjMGlMMm5COEluY2hTdnhsT1hRLzhWb0I3d3kwWUhWMWtiYXBMOGtNWEov?=
 =?utf-8?B?eFByaDdadmNOV1NPVjZtQWZrdDVLRERaODRCMktRRlloT3gwSHFCaGRtRDFW?=
 =?utf-8?B?YVNCNksxbFdLckFSYUFob05NMjIzOVdoNWR6MTdod0pPNjh6K2dTRitPMUhY?=
 =?utf-8?Q?lcSlgCvKj3TU7O6PoPbXwUGqJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0644b1ae-419f-40e9-d609-08dd8895bbd9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 09:51:24.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcOrT1HVV0U3td5DjXwP2V2m+aVqoGWqO1VjkYsTVBUqtk2JdKbSHDpLa/nSBpIR1OOVDvRXgNA/jXz4hJWzxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577

Hi Rafael,

On 14/03/2025 12:50, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> According to [1], the handling of device suspend and resume, and
> particularly the latter, involves unnecessary overhead related to
> starting new async work items for devices that cannot make progress
> right away because they have to wait for other devices.
> 
> To reduce this problem in the resume path, use the observation that
> starting the async resume of the children of a device after resuming
> the parent is likely to produce less scheduling and memory management
> noise than starting it upfront while at the same time it should not
> increase the resume duration substantially.
> 
> Accordingly, modify the code to start the async resume of the device's
> children when the processing of the parent has been completed in each
> stage of device resume and only start async resume upfront for devices
> without parents.
> 
> Also make it check if a given device can be resumed asynchronously
> before starting the synchronous resume of it in case it will have to
> wait for another that is already resuming asynchronously.
> 
> In addition to making the async resume of devices more friendly to
> systems with relatively less computing resources, this change is also
> preliminary for analogous changes in the suspend path.
> 
> On the systems where it has been tested, this change by itself does
> not affect the overall system resume duration in a measurable way.
> 
> Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravanak@google.com/ [1]
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


I have noticed a suspend regression with -next on a couple of our Tegra 
boards. Bisect was pointing to the following merge commit ...

# first bad commit: [218a7bbf861f83398ac9767620e91983e36eac05] Merge 
branch 'pm-sleep' into linux-next

On top of next-20250429 I found that by reverting the following changes 
that suspend is working again ...

Revert "PM: sleep: Resume children after resuming the parent"
Revert "PM: sleep: Suspend async parents after suspending children"
Revert "PM: sleep: Make suspend of devices more asynchronous"

I have been looking into this a bit more to see what device is failing 
and by adding a bit of debug I found that entry to suspend was failing 
on the Tegra194 Jetson AGX Xavier (tegra194-p2972-0000.dts) platform 
when one of the I2C controllers (i2c@c240000) was being suspended.

I found that if I disable only this I2C controller in device-tree 
suspend worked again on top of -next. This I2C controller has 3 devices 
on the platform; two ina3221 devices and one Cypress Type-C controller. 
I then found that removing only the two ina3221 devices (in 
tegra194-p2888.dtsi) also allows suspend to work.

At this point, I am still unclear why this is now failing.  If you have 
any thoughts or things I can try please let me know.

Thanks!
Jon

-- 
nvpublic


