Return-Path: <linux-pm+bounces-30134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 712B0AF91E6
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 13:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7CD61CA5D67
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 11:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E93E2D63E2;
	Fri,  4 Jul 2025 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dzoTGRzX"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F7C2D46B7;
	Fri,  4 Jul 2025 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751630007; cv=fail; b=nHprJKItWjpDKnEYsYvQKHBAQhcPRxckbJH87TofAIsSptR6XPgs/mZTZpqml+1Pl0U5yzQx4KVLqVMi27pkmMFMmG5D/daVx2u3T58Nv426b/MW/dbqRST7dkyOOed5ezQwsYI70HF6uKkT7FQN9KBP/pGS0PO7GihTYibuxHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751630007; c=relaxed/simple;
	bh=9ADuLggZMAmIVYw1Bn8dQYcIdooDzaMazHzMsmylSuE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SJyCpaYjPXfKqoFrwZsH92/eeInkJKtQQWwyDdGQqhB9Oy1d8JIVeo0E06RpHLdUNs27bokdfgMOSwyqtEqeZUjE0ZmsbLAoDbx/0zoWPAJeEMcM2DlQd3WkRW93v93L6iwME3DfY5V+3Z7uWgE93XyyC54cCuLF+riPqbEAaDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dzoTGRzX; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goos1kIWlzbYd3FrabYYIH+XyhLR55wURAHvB5aXp45uCT7rXKJ0bsMmuZ1MsEN5lXDvAbcLnFqh4Kwq5LysO1R5F1WQCBa2Sv3vyW9nfUXOIJ1k8XFjXfXkZ3kwZopVWiUoSSb+HYcnUirzg8otwJb6OKpW+UTTsIgOdRv106d/JaOneF+9n3EQhimHbni1BzFeQ+2Jzh8U1CywK6Mrscu258d93fY0Roj4CWjdvzOvV5BcoE+txRK1+XZBNwiP5i28Z+JQXSFSephPL78nqrIsydZpsMGLaC205qxLqMmg5F+fshULCjBi9Xmngdc1AveD5mq6oY4FJ/Vy4jV7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HbxajB/nvy45y1Bs3KbL2k/1hHIhR98oxBa6bby5tI=;
 b=nJGzqRVZdzJfqeFIsP33j1oxApHVZp7ud4fF2UDiZPz0g4R+LFVU9wPjuxOzaRPWwI/2cBRx8fMYoXi7w/+A1eW+Ot9mpWH1lGqCYi/LkKpGKz6QoUOz4Ul5/yPXzu3Ug0/VvT8UVVRvuuTdq83lobUkYbpXTPYLtWRRrVA0fFkpW36AOw5hYqnHWvvnXaxkXm/G65R8u3SDALqrxRPclt3eL9CyAvv+FbuEvTKiclgEdB8eMaAmvvYrCpDtX1b/fHRFtYD3AiXjiIgvoozfbPjehYxj9XXSwPS8w/6FVYfkCyOP37E8sPhnGfdu4c/CA22nAr7bG0NSkDX9ceKk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HbxajB/nvy45y1Bs3KbL2k/1hHIhR98oxBa6bby5tI=;
 b=dzoTGRzXMWh59K8ni1+16evL7g27uU4RoTe1RGaCmvgZFen7r1jt0PT4AzcJfvxJtcKLyv0kwdTXuriHT72EqLPh1ZN7U7Vhvrbnj4B8185J72e8VpaL4VYgqSMcjYB/lB+v8CmCIlWfwLA//tpcy7UcydH4OJH+y5CvdTEvlDQYxmbZCNMogdhyogn6vTLI/RtdSMCMgIz3jTFUY+2Q5BqVplxoo+2uQ9xM60/HpgMBhIYVMitp/j/bjQZe7fmdyPX+9CQX5vQgEsajugiF6zXZSHjAvBw7ksOOUvG1X3VvweDi0PHMUFbObahRa+EVFUHxzeas6OxeVKflnuYDtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 4 Jul
 2025 11:53:21 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 11:53:21 +0000
Message-ID: <640f7ba1-c016-4d77-a65b-93477be9cf3b@nvidia.com>
Date: Fri, 4 Jul 2025 12:53:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] cpufreq: tegra124: Allow building as a module
To: webgeek1234@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20250702-tegra124-cpufreq-v5-0-66ab3640a570@gmail.com>
 <20250702-tegra124-cpufreq-v5-3-66ab3640a570@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250702-tegra124-cpufreq-v5-3-66ab3640a570@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::35) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 9772383b-80c5-493d-4ab0-08ddbaf15fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnAzL2JJRmFkdmhLYW44MFM5THQrejNGR0xoNHo3SUVLTkQxNURFcmlOdytH?=
 =?utf-8?B?WDVlR0lMSUdPUWkrK21Mc0NJbGt2Y1o3SFFhb29TeE52RlYvM2Vmd1FnVGFk?=
 =?utf-8?B?Vm8xSmRLeXRFWXZkbUhNNHJsdlk3ZEQ5STBSbGtZRmtwSFVTYkhNcklGSjVB?=
 =?utf-8?B?dTJiTlJBd1VzMFg0dkF3WituREhWVE9YREFYUVZsNE9pM1pONWRuV1RlZDZF?=
 =?utf-8?B?R090V1JqeUlDcUFwZVU4ZDg2M3BQemtYRDVJNkJxN2w4Rm1uSmFVbUlYejZq?=
 =?utf-8?B?MjIxNFBwOXFKT3NHaG5KYUNoM01pd2ZWWmJQSldvYmI4RDIydWxhZlZsdktN?=
 =?utf-8?B?RHpVdHFMWVRsZG1yUG95T1ZhN3pLRTRRcEcvNjhKYkZ0VURqUDhYbFdPZWhj?=
 =?utf-8?B?MVRYdktqMkx6dTBCZHlkcFJpS3loQitNbUlTZW5BZ0R6ZllBTmxha25ab2N0?=
 =?utf-8?B?QlVDVEl0ZWNEVkpIVmRJdU1xSGtXVkEzWEx5WU9zc1lyemdaQXFSWkNRbS9z?=
 =?utf-8?B?ZnBzU2NBeWpvUWNCSTJlVFRWSEVDNGxialM0SEhoL3pVN0oyZkliMU9oRlVT?=
 =?utf-8?B?OVJOUGw4Z050S3FkeFNFZi9wdzBsVHkvaUxPd3p3VDNSdkJYSDNtQi9kTGlW?=
 =?utf-8?B?QkJ1UjVKdjZLNTRYSFp6RjVPNGZyV3lBNjZGRGpGeFlsTXRrcU83aVowTmNm?=
 =?utf-8?B?TkVzenNWMEdBN2JFVHFMeEZFT3NCWTFscURTQkJXZ0lNQy9UcVZiWkt0WEhY?=
 =?utf-8?B?ZFo1U015d0FZZHB5alZTZG9wUGJpcmc2SlZCeGN4Z0JBa1Jlb1hWZTdSTjRT?=
 =?utf-8?B?SWRrNWR5SFVzcDFvaGdTU1llUWY2dzRORGYzZ09CMGlFQWRGMkU5LzVSVVpO?=
 =?utf-8?B?ZmZMaDR5cFU1QnVsOEVndWs0VnZtYVJ6WEJRRTFkUStMMGN6U0RRc0J4aWw4?=
 =?utf-8?B?dzA4UVRlKzlVTDcxOHJsZTVrakJHRWZGYWlGVXZEOERxTFY0SzdNTVh0OXBR?=
 =?utf-8?B?RTRlVVZydlVleW5DS2JnTk41T0RDcTdJbkNlWHhIYitYdE15Y1dGZ09POXMz?=
 =?utf-8?B?blQwOTcrd2hvNjh5eUFrL0M1Nzd2MW1wMUdNc0JjYlo1ZFdhb0pmK3JkZkcr?=
 =?utf-8?B?ZDFySHhUckFicTU1Z1RUYjJxZFJsa2hTZTNldEk0bVYxK2FVUDgwZE1tTjEw?=
 =?utf-8?B?R0RYUjRjcE5TVWtkRC9tbU11OXI5N3M3Q21GVXp4MU9QeWVxY0VlWXVLd2JF?=
 =?utf-8?B?aThJRjdJdk5LMVlTWFFSR2xQUFJRT1RHczVaTmlROEFkbEVMUWU3Ty9rNGNH?=
 =?utf-8?B?R0lQTEtuc3QxZ3llWm9OWUZCNU43QXh5VTg1a2V3SjVYYjFvZWdDN1ltSUp2?=
 =?utf-8?B?K2VLOE5QOSsrU0pJYitjTWZ6TEFVM2IxNzg4RUlBZWJnUEdFZTlNS01jZGVM?=
 =?utf-8?B?cVhTVXU4eVJUQjN5KytxVGJLWjRYQjI3RjZrTGhJdVNzYmJaQkt5d1VQODJM?=
 =?utf-8?B?NFJ1ODlMbWJ4TTFnV0lvcnVZRUZueVR3cDgzS3pJZmxPc2ZPNlhjNUdkWnZn?=
 =?utf-8?B?VzhhTmJKbllHSkgrNWFEZ05Bb3VXMHU5QWFIRURLSUJILzBTRWdJdlFQK1Rr?=
 =?utf-8?B?TWFWbzhiOGRXR2NhU05RaEJhVVhYSDFCb2ZQYk50RHFKMDE3TFZSTXJuS0Uw?=
 =?utf-8?B?UXh1MzA1a0xmQXo3WVF0WnJ3NGJzN29SczZLbVBqTHZ3dHlWMDFRRXQwMlA3?=
 =?utf-8?B?bjlERy9GOU1FZlhobG1xNnAzbmpvR3NWak9idHpNcVZWU1BYU3NXTU00c2U3?=
 =?utf-8?B?TC9hT3pZUWZESEE1OXpSeU9RemdkcktFOXpCQWFMOE9leDFXL3A0dm1rbjhh?=
 =?utf-8?B?cFcwUTlHNytXU0lZUENCbDl1c0FrWmRQRHk1T2dIRm5WK255OHd1b2Q5SlRL?=
 =?utf-8?Q?9XewmscbCW4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1NUU0hvcUNYbGxrbGlHckhZTzZ3WnlVaHpSOFd4VHlPK3I0WHdYMGh2SUE0?=
 =?utf-8?B?dENiTFdTY05ablM4RER1V2w1NFA3VUg1UUtYejZYOG1kT1FCNG5WMFJNK3ps?=
 =?utf-8?B?MzRnYXNYRzFLa0k4MVRLeXozUzhibVFaSndDMCtXK0pVRTVzT0hVZW9hQlJu?=
 =?utf-8?B?UXhRZ3F4MStGTjgvTHFORUI4Z1BDS1FXOXdnVldFMi94L25BYVNKaDBnTjVn?=
 =?utf-8?B?MDFDSkpWVk1hbVErYjhwSGNzeXlBYUJ1aFlXK0J6aDB3dW1JUmxTL3llQ25v?=
 =?utf-8?B?Vi9ScEJ3VW8wRDhQMWF6cWloQ2JzTVhnNnhldFhuN2RyOVgvRDA5MDNXanVq?=
 =?utf-8?B?bE9qUnkzOHpybG52aDAxL2t3cU9ORGxmVXhmdzlHZE5lVHFoTlpteUc1YWpJ?=
 =?utf-8?B?dzdCd3RHc1A2SHNraS81RjB5UXk3NHBCNi9YbDYzdm80UzJCQmxIMDJHY2o3?=
 =?utf-8?B?Rk9TcmFJbGlLYmsxcWFjWDFNR0NsdjRYSURlUU92SUpFejQ1VDdjSHdLL2x1?=
 =?utf-8?B?UTgrQ3luOWU4TXRyNUM2LzdlNlcra1Jad3NkQXVxbi8wSkNjZGYvWDUxbXpk?=
 =?utf-8?B?aHJ1VmZVTVlBMGsyWnAreFNOVkFhYldmbkV0NFlxSThvZVh4S243elNjQkl1?=
 =?utf-8?B?dm9mUVVKYVJJRGxCSTZSMEZYVk9FdGsxT2xNRnVQSUdnaDVQcUZDYlZlVGgw?=
 =?utf-8?B?VnZ6alFrd0VieE4zY2JiM2VCaHA1d1owZGN2dlA5M1lmSk5hQ2tISURRL28r?=
 =?utf-8?B?ZER6Rlo2WE04Y3g0dklzMGhqTGlNWTh2M215bEd5bGk0dWFoQTlua2RxZWNO?=
 =?utf-8?B?YW40QXNoY2tvcUh5blE2MVlhS1lNRER0Wm5pRWFPMmlxQi9BUE1SNHAyZ3hI?=
 =?utf-8?B?THZHS3VWaS95REpaUVdzZ3U1RU1nMlh4YUxFcjFBWGg0NTVaanY4Nmh1NFEz?=
 =?utf-8?B?UzlLWGxwUE44djJLb1JmYTIxcFFZbjJ1Umdya2pzZUs2RzdNZTJtT3pxUzd4?=
 =?utf-8?B?TFJMQ01lOGNVcU9HQUM3NmFHWXo4aDlXdGVmbWlKbWI5dVZTSE1MOXFZZng1?=
 =?utf-8?B?dzlSdXA0MWRLYWhzUDd5RjlMcjhCU21zYVVEQnZJVDNudlFFckpqdjdUS0x0?=
 =?utf-8?B?cG5jVDgrSEE5OWR3MkhFYmlEanZrYTV3bXR4VlVLQ1B0S1ExbjN2dGRHbnk5?=
 =?utf-8?B?MmM4K1lnaWlHNkc5NlJiZk1MbTBrZHVCOWJqbklPQytLRll0RFF4UmdCY01x?=
 =?utf-8?B?QnRYQUs4V1c5bkJ1b1FzcjBaT3U0Qng3bVY3YVc5Y2ViN3FORkpiSHZ5TWRG?=
 =?utf-8?B?ek8wYUdnek5DNkVEQnBBa3pZYWdhNjlMWlNhTVkxb3hFWlJoZGl5RERMNU9S?=
 =?utf-8?B?Vm5VMjRsaUZxdkMxakZWY2FPZlIxK0cycEtjV3RNaVNLK0R6N3hNNWhFTGJ6?=
 =?utf-8?B?b2huUHN5dHJBWHZONDhxU29sandybm8rbFpuUzZpM25PVmk1UlV1UzJtemVX?=
 =?utf-8?B?ejQ0c3Z5Y1d4TmUxazJhMFNHeEs2Mk0ycnZnUHVhaTFmNjArV3FlTzRQRE1Z?=
 =?utf-8?B?Ulo4Tm56VDRGZ0ZFc3pQRXRmNVNxU2VqYnNtblIwVlRlU0h1NHVkaVVKa0N0?=
 =?utf-8?B?c1pHbGYzckpJNjdiODcrUzdIZWFkRENpL1oxUGIwNzlOT2dKcnJTUkpxbFVt?=
 =?utf-8?B?S25uTFRMNWQxRG1kU2trbFV3a2l0czFZM0dHOWMrRlNyQzRYZEhlcmQ1VHAw?=
 =?utf-8?B?NXpHL05pS0lweEtIM29Zd1M1M0tiZGgva2RXM08vN0tuVlpJQXAvSUZTTFhZ?=
 =?utf-8?B?dHBHc1lXV0dtS01EWmZGRHdxUW5xUlpDYnFCbDBzSlVIQTYwdW5wL1ZRTUxl?=
 =?utf-8?B?OUFYaThiUnpCaGhEaG53NWVOdUZpZURrYXpBS1paWXk4YmxYRXRoTW5zdndC?=
 =?utf-8?B?ZFdNb2Jxc3YyZ25tODVvN2o2MWlqQllqdFJlN25RQnA5OHJUZm5QMnd0bXpO?=
 =?utf-8?B?WklWQ0MwelhzanAvN2NrSXBoUVA1VUs5eEhaK0J5a3VGdklFTXlTWHlmaFEx?=
 =?utf-8?B?RC82UFBTS0JMZ0dCNFM3NzZQY3ByMjBSaGRXelZOa0NHU3F1Wkg5N1BPYlRn?=
 =?utf-8?B?QmZFcnFSejBiVHQrMlFiUjR2R09xbFRJYTRyam9ZaHQ2RjdyVXlTSGo0bzZK?=
 =?utf-8?Q?krPlScpDhjF0kAqyHFpHSGy0iJAy3sjOi6QsuRmWpWkJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9772383b-80c5-493d-4ab0-08ddbaf15fc3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 11:53:21.3870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kt8QAayfalYVpWvx/I7ZMA6me+rz/llGxj1HLeeBgFEQwT9N10679H9kOvguoj69hzl9vi0CicS5KN09GiL61A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431



On 02/07/2025 08:46, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> This requires three changes:
> * Using the cpufreq-dt register helper to establish a hard dependency
>    for depmod to track
> * Adding a remove routine to remove the cpufreq-dt device
> * Adding a exit routine to handle cleaning up the driver

And populate the license?

> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>   drivers/cpufreq/Kconfig.arm        |  2 +-
>   drivers/cpufreq/tegra124-cpufreq.c | 44 +++++++++++++++++++++++++++++---------
>   2 files changed, 35 insertions(+), 11 deletions(-)
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
> index 514146d98bca2d8aa59980a14dff3487cd8045f6..ebce62be9a9c17724d50dadeea1bb2ec81538421 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -16,6 +16,10 @@
>   #include <linux/pm_opp.h>
>   #include <linux/types.h>
>   
> +#include "cpufreq-dt.h"
> +
> +static struct platform_device *platform_device;

I think that this could do with a better name than just 
'platform_device'. Maybe something like tegra124_cpufreq_pdev?

> +
>   struct tegra124_cpufreq_priv {
>   	struct clk *cpu_clk;
>   	struct clk *pllp_clk;
> @@ -55,7 +59,6 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
>   	struct device_node *np __free(device_node) = of_cpu_device_node_get(0);
>   	struct tegra124_cpufreq_priv *priv;
>   	struct device *cpu_dev;
> -	struct platform_device_info cpufreq_dt_devinfo = {};
>   	int ret;
>   
>   	if (!np)
> @@ -95,11 +98,7 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto out_put_pllp_clk;
>   
> -	cpufreq_dt_devinfo.name = "cpufreq-dt";
> -	cpufreq_dt_devinfo.parent = &pdev->dev;
> -
> -	priv->cpufreq_dt_pdev =
> -		platform_device_register_full(&cpufreq_dt_devinfo);
> +	priv->cpufreq_dt_pdev = cpufreq_dt_pdev_register(&pdev->dev);
>   	if (IS_ERR(priv->cpufreq_dt_pdev)) {
>   		ret = PTR_ERR(priv->cpufreq_dt_pdev);
>   		goto out_put_pllp_clk;
> @@ -173,6 +172,21 @@ static int __maybe_unused tegra124_cpufreq_resume(struct device *dev)
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
> +}
> +
>   static const struct dev_pm_ops tegra124_cpufreq_pm_ops = {
>   	SET_SYSTEM_SLEEP_PM_OPS(tegra124_cpufreq_suspend,
>   				tegra124_cpufreq_resume)
> @@ -182,12 +196,12 @@ static struct platform_driver tegra124_cpufreq_platdrv = {
>   	.driver.name	= "cpufreq-tegra124",
>   	.driver.pm	= &tegra124_cpufreq_pm_ops,
>   	.probe		= tegra124_cpufreq_probe,
> +	.remove		= tegra124_cpufreq_remove,
>   };
>   
>   static int __init tegra_cpufreq_init(void)
>   {
>   	int ret;
> -	struct platform_device *pdev;
>   
>   	if (!(of_machine_is_compatible("nvidia,tegra124") ||
>   		of_machine_is_compatible("nvidia,tegra210")))
> @@ -201,15 +215,25 @@ static int __init tegra_cpufreq_init(void)
>   	if (ret)
>   		return ret;
>   
> -	pdev = platform_device_register_simple("cpufreq-tegra124", -1, NULL, 0);
> -	if (IS_ERR(pdev)) {
> +	platform_device = platform_device_register_simple("cpufreq-tegra124", -1, NULL, 0);
> +	if (IS_ERR(platform_device)) {
>   		platform_driver_unregister(&tegra124_cpufreq_platdrv);
> -		return PTR_ERR(pdev);
> +		return PTR_ERR(platform_device);
>   	}
>   
>   	return 0;
>   }
>   module_init(tegra_cpufreq_init);
>   
> +static void __exit tegra_cpufreq_module_exit(void)
> +{
> +	if (platform_device && !IS_ERR(platform_device))
> +		platform_device_unregister(platform_device);
> +
> +	platform_driver_unregister(&tegra124_cpufreq_platdrv);
> +}
> +module_exit(tegra_cpufreq_module_exit);
> +
>   MODULE_AUTHOR("Tuomas Tynkkynen <ttynkkynen@nvidia.com>");
>   MODULE_DESCRIPTION("cpufreq driver for NVIDIA Tegra124");
> +MODULE_LICENSE("GPL");
> 

-- 
nvpublic


