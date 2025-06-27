Return-Path: <linux-pm+bounces-29670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163B8AEBA19
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 16:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA4D1C46C05
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 14:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BC52E6D37;
	Fri, 27 Jun 2025 14:42:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D982E3AF8
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035331; cv=fail; b=uoj7TRh4FZ/qz8dLCZbcgS1RXu6AVfThG0fd9yNqoB35+ASysxsr2KGPitIIh5UWJAnVbNtTrsq9M0EqMFZ190FJet36XNGs4d3SerJ2+zT9P8+KMIITMfAFRr65XU0wImvB2o8giyqELLmf3TwSk0WvL7eqBJBYU6jTH0galwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035331; c=relaxed/simple;
	bh=BWQ18vANDjqkRW4npgEgtsZ4saHL3ZsoUsEA7ugO+hU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=paKrNRLiYeKmVevAbD1Hhr12F+hySub7G8g5Wa9QhJyJSYItNuKm250axH23gMmnm8b5Z93TX4dBVJiY0cHlMsveQWLeRkJBF8F22bE0zeFfaCEBQHegXOY4bKoeGvuGdbPVivjjJCcSYwxDUGYnq7weoDOiXR6n3UJUtEw9EWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R5doGi023301;
	Fri, 27 Jun 2025 07:41:58 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47dv8mpk9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 07:41:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOWIdiAsgZWVEP9epHHuQafIP426XPRz5gUlhHW500AneUnPdK9Cr/1uXTIAH3GnuDBnGCq9ew4ClbEwG7yjFGlQLCZpvUBr5QI8xGJRmbD7w2sPZcdgS65im0kapivpt0cWTEj9BrnVd81fszxJu5IvIDG/5Eaoa5TcFEzyyO26d5pw6Ui5NfTUIKPpF5hbS+zDb/2J0xds1AO5fwm9d6cHNCDiJOGhRFE28N44J0h2eNu2pOwguxGjcsDVehVauYtwUdm6VHcpPDuh+9j6Gy5AW4oScuv3zL2K9DrIWxAEoJsW78vqyEEvKt+532IUNlVtH5ghY9rA3gbfDCreRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMusKl7WeO0fOsuwsYTXhqXiAm/QLtaxL/B+sHtfQ88=;
 b=tHzMyPB8Ctn9YNUep/YQMtbVeV/UO0IBXSkJVDv51DSs0HJUy1xtg4cT1ajk8GqXUfZkXFkr4ks8eVvbaZvFNJMG/zOS9vnCECD3lYPpgYyBknQ35UopOg67uScRnXFuTXLpnlqTc7PurALqhDVTDT0bNHs7O90vNNb7bUPoInqfSmGI2UT77ceH6Cu0TzVocijjNPqQ3TMTQgjkQ/1D/esQwqQ9ELaR+mcMwTTeHR6YuKogv8ZIXwF67xY7b/6k1r4W470lQQcm9drPuOdWtOKY1VkMo8t23H/teJAAhgVrgNXgDqWMrmJcqrZH5jVORmCItjUz47I2g/C/VykDMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 14:41:55 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8%5]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 14:41:55 +0000
Message-ID: <d234a1cf-ae50-46d7-ae48-26da6a4f738a@windriver.com>
Date: Fri, 27 Jun 2025 08:41:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: question about behaviour of cpuidle on 6.6...seeing *many* missed
 estimates
To: Christian Loehle <christian.loehle@arm.com>, daniel.lezcano@linaro.org,
        kgene@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-pm@vger.kernel.org
References: <0dd1f3be-3bdf-44c9-a6d5-623077714149@windriver.com>
 <7d43a796-d831-430b-92d9-53b3d8351fb6@arm.com>
Content-Language: en-US
From: Chris Friesen <chris.friesen@windriver.com>
In-Reply-To: <7d43a796-d831-430b-92d9-53b3d8351fb6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:208:329::33) To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|PH7PR11MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c15e624-f81c-42c7-0457-08ddb588c33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RU5Xak5zVzFYUU5hZlU5WWxDOGNoVTRZY2tENGVwR0pMczlQakg2dXBDdnBI?=
 =?utf-8?B?SWFSZmtGbkpsd1kyL1pYblc0akswUXlCNWxETTQ5SmV3akV5d2xyVkVmRjhF?=
 =?utf-8?B?UkptTmVIQWh6N2c0S1R1aGNZOVRSd21VR2d3aW1YRjZZWFhqbUJjek00elNI?=
 =?utf-8?B?VXVBcTNCMVFPcGUrcUtZMndORnNncTZHN3BVWTAxUjNTcGFXSWdyVVZld0Fw?=
 =?utf-8?B?YUlCdmNSOXF4Q0FUajZhVXZqQ0FPS09ESGY2RXVMeEd6RUVwSzZra01RWDFG?=
 =?utf-8?B?V2JHaVZwN0l1U3luOVhYNDBTUGF2bzg2YVc3cjdMKy96bk1KMFJDcjkyczNk?=
 =?utf-8?B?dEl3UkJVTDl6a2NOa0IxWmpTdzk0VG5jVE9mb1BZUldtLzc1UG9Gak1GMzNp?=
 =?utf-8?B?bzNENXE3dUhBb0lMSnhMYUxScFB4Q0tKZDJQaFpkMXpFT1F5dUtlYVBlQ3lv?=
 =?utf-8?B?Vmp1cUtzRjlzV1ZTQWV6VVRYVzMvbHQ5UmxhZmx4dC8yNXhoTWFIdHV4UjRj?=
 =?utf-8?B?NVFmbE44MFlWUDl5WlYxMU1sVFRRLzMyTDZHZVgvcVNtdGt5TDJrU0NOUlVl?=
 =?utf-8?B?MTl3RTNyUkpmSWVDN2Z4R1RJc29NWTlwZExGM1FUZjA0dXhlNllsSXpuZFkw?=
 =?utf-8?B?YjdzUHQ2WDJIQjdSdEFSeUtDbjNUK1JQZ0dhYzhMZHFZY0FYMlZjam92NmJp?=
 =?utf-8?B?bzk4cm90MHV4dGJ0ckpSRExzYXVxVW0zYXFDSmdQMGRWTTJtbEZzUmtMNzBU?=
 =?utf-8?B?bEhwV0traWJMQ1JVc2FmUjUyVFNWWEVCa04yYmJiUzEzM1JOd25hcHh3S1Fh?=
 =?utf-8?B?aHlnY1dPbW1tZE5oSEtEVEd5eUNyb2xVS0cwUVNnRjZKc0lhT3R5UXlkMDZu?=
 =?utf-8?B?SEdpUEJlTGxDNWZUN1FOejg5b3M4WW5PY1NhRmxldUcxZW5xb0RyZEplU3Ns?=
 =?utf-8?B?R253SkdCT08zZ2RxeEFUNFdNUjY2cWI1eC9LZXYzVldiZy81WXlMc2pKSVo5?=
 =?utf-8?B?SnJyRVd4K2dPeitGbG0rckM4TDEzR0tVVWxTOGhCbXdjZXhKZlk4Zzd4T1ZY?=
 =?utf-8?B?ZGhBKzFPRGRMS0dBeXFnWXNIN0F4VUdrR0ZNT3RhL2ZhS1phdVhmOCt3N3pz?=
 =?utf-8?B?MXc0bEZSbUthNzN4MEJiTklCNjc1SDlGWGNDaDVYQ0hRbzFRa2VCeTRETERt?=
 =?utf-8?B?N0xYV29NZ1R3STQxeTdlVi9VZEExRFE4bHErU3hZTGVWVzQvNW0vSzJJNkNP?=
 =?utf-8?B?dFFJRkF4S0gwMTdENjhqYW9qM29RbmZlOG92dUIvRGdtNmRGblV2S25sT0Iw?=
 =?utf-8?B?Y002OVlJK2NFRkZpSVJzQVk4b0JpbjZpRlU4dHBHVFN0ZDEzU2JXSE5oTXZk?=
 =?utf-8?B?Tkl2ait0R2lqQTBqZVBUNytpSFozQnhmV09jTURMd1RoeXIrS25ZdjRoeUZI?=
 =?utf-8?B?VEsvNnRlcXE4K0xKUmViYkRuVjVOT1hHMnRSVW1OaVBub3crVXFmSSswUHl1?=
 =?utf-8?B?MURVYnBsZWRrQXc1NzJvbUY5RU1neDhHMXZYWnc4Y05acS9kcUd3VStPZWE2?=
 =?utf-8?B?TXVzaWlxUjhmWFJDa1JFUTFJU1drSllGYVhSRDRLbHJUNCt2UkRUeU51aEJY?=
 =?utf-8?B?VlFIOFVjSkRSaUxzNXlCYVpkaDRvUlNtRVlMaUJWZUVDdkxJN2g1V3NDejJl?=
 =?utf-8?B?SDB2dVRZSXRVRmpNdDhxMm9ZdFJmUDR3dDh3OThxSVdtR3ZCcHRKendwKzU0?=
 =?utf-8?B?V3o0RDlSZjFNMld2alY2ZXlyemhiWnIycWNiSkFzMk1CNVdjcytzUDkzTVp6?=
 =?utf-8?B?eTlSOVdzaEpaQlhuK05kRjFuYXpESXBqbXdqS2sydjlqVDJBczE5djljRjNY?=
 =?utf-8?B?akRkcDdraDF6ai9CS1ZNY3U5ZHFRR2N6U2pJYmMyK2hjc0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB8806.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVBoNVJ4YS9MTHBVQ3BicWNJL2ZxUUpiSHpsZDdlcHovVXp4QUNxVGI3NDNF?=
 =?utf-8?B?cGhQNnlGMkZlWExTRHNFalBGK2lKVUs1eDZ4dmpHVTFlR0d0QzQvcHFwRXUy?=
 =?utf-8?B?YmVURjJ3TzZBSW9QMVZ0WGRVdnZJUEdEOVdSR2wyYnROZ0FSZmFaRVFlZmQv?=
 =?utf-8?B?bEZOU1BtSmR0T0pxbGJnY3FIbDZDZmpMZlNOWGx3TU5GS1NJNjBTWXgveWpO?=
 =?utf-8?B?UDBpdUxOUW5mN0ZNTCtDaWxtTUNRcFNaeUFRakQ5NEYzeC9XcklXUnFnUU1n?=
 =?utf-8?B?QlBQU2ZsZmR1Tm5Ib0FhUlZJamJSM082N2JqS1FBeGVlU21BeGp4dHFESE50?=
 =?utf-8?B?dzh0UEd0UlRuS3g3azEzZS9aK2hXSlVDQVk5V3N4N1kxOEVoTWFNTXBVb2l0?=
 =?utf-8?B?VHZpMVdtYThsN2k0MUo0Y09iRm9za3YvWExYZVcvSjhHdDBtRk5rNHlETlRr?=
 =?utf-8?B?Nk5UMFhDeUZ1dUpiQWpCdDJwdm5GV0N4VjFLSnZJQ0ZHZStjMjcwMm5HRjZM?=
 =?utf-8?B?dFZDU3NHMGZKSWJsWGxkaTdHYkRDdUJxWmRvODZtbGRMVHZ1VFQyTDNuTG9z?=
 =?utf-8?B?TERkMkVqNkEzaXA3aVRMb3dndkdBQU5HS2o0SWdPOXRiTGhIM210Z2prMmhU?=
 =?utf-8?B?ZE5LMDlLdzIrVnMrVWQwQ2dSNU4wWW5tSUVRZ2JYcEJLR1NsZUJRbEY0M0xr?=
 =?utf-8?B?Y2RmMjd4L1VabDNhMGFCRmZtTUh6ZHV5UU51d0ZVVWd6bGhLeE5mZlFpMmcw?=
 =?utf-8?B?a0FvVityeEMvR2hUelpTaG5sK3FVV2RMRUhnNzBXeGRxUld1MFMwMEhMeEdI?=
 =?utf-8?B?TDJtMzkvVHYxZVk4Nm9HYW9CbDF5LytuREZoVUp0NFFMSm5QaG0vTjBISDcy?=
 =?utf-8?B?TzZtZzl6ZFZ0VzVmVm1kWDNDNzZLMzl0RkxjZ3RHRDdnLzdKQkRrVG9UaFFH?=
 =?utf-8?B?UDExZ0dJWHZjVUtpVGpWUXo5bEM1S0VOL0FFUVpic05DdDZkU1VFNUxpQUJC?=
 =?utf-8?B?Uk1SS1J3Y2IvcEhTSnZuSURObTRTMUJGSldWdERFemNYdDdlNU9WSUdmMXhU?=
 =?utf-8?B?NUNIY29qNGgxcWpuUUMrWUthK1ZzVU9wQU84WWZncm9QRE1Jd0lrNWJWQkUx?=
 =?utf-8?B?V3EwTjkxdlVseStud2dBM0F6RjVmT3BJMUxBeFQ3YWluOURCNDRjYjdVazJ1?=
 =?utf-8?B?Vk9weGFxR3E5cEFmUDNHZjJ3QWVKTzdLc3ZTb1R2cEVsbnJldjlqaHN2dXRm?=
 =?utf-8?B?c3FZV2NVa3RRbGRLR2Rtblhic0RFUDJYVUw4TkgxTFlkb0F0UmJHQ2Z0cWJ5?=
 =?utf-8?B?OEltbjUzQk1BSG9JMWpqZVd5UnpnS3FBczBZVkNYQmtSVTZPekFSK05iS1RD?=
 =?utf-8?B?bEFPbUJUeW9nenlWMTJseGtyUHRscHpJR3JIZlhENFNVUFA3Mm1CQytaVUFs?=
 =?utf-8?B?M2VJRE8zY0Y5VFlhYlN3ZmsrcVJvcW9EY21SYlFseS91Rk9hU1ZJOFQrRkJj?=
 =?utf-8?B?eDNlQlplWEswWVZyOUpLWE43N2VBanI1L2NhNHprQkt3dTdqVDNna1V6U0tr?=
 =?utf-8?B?cE02Zmplc2twVlF0dnZ2YXh5cjJPakFETm82UjNLNml3QW4wRGRBa0Q4TXB2?=
 =?utf-8?B?bFRrMk4zRVptWUM5VVNPanhrWjVwMCtxWWlYZUtjcy9xVkhOYkxXM04zZ1o0?=
 =?utf-8?B?UGtBNU1oNlUyRjhzODQ3c09ZcjFTdmNQQ0ZRQjZZY2lXbDV5bVowWFRVOTVS?=
 =?utf-8?B?ZU5XRmxpTExucTFoOXgzVGVhNE5jOENsbGR1QU5OQ1BIb0ZlajBlVit6aDlZ?=
 =?utf-8?B?YzlWcFhpTnV0N2w5M2dwamtOWlVDSXBPSUY3RUc4YzY5SDNjMFl6Njk0bkF3?=
 =?utf-8?B?eVg1eXo5V3JRRSt4K3RhQkZRRUtXSEN2TFdIcGZlMU50Nm5uVVNkMm9OMTJW?=
 =?utf-8?B?dVY4QmswM2hWOWdmeGU0eC9hcy9TTEplb1lRVE40dEpJOUc1aWVqWG5PU0pi?=
 =?utf-8?B?R1Joand3ZG9uMTVEdlZ1QkMvZXdOK25FbDNFejU3UDdPd29rMGRMSXpLeHpV?=
 =?utf-8?B?UkRCRVJ1MXNUcEpxeVArVlFQWXZJdnA2bWZ0WEZEUmxHRlc3TWJXd3Iyekts?=
 =?utf-8?B?ZlQ5VUVnSmpmOWVCckNRTUpRUFJMdjF6djNSNVhvcmRyV1NhZjlMdVB5S1dL?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c15e624-f81c-42c7-0457-08ddb588c33e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:41:55.5337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ij/l9H1tDW3zC/0Lg9+jsvIzTvU2ASDwzj0eZz3jTIL0j1mzPzB2R2AHK7lXN5t3OvC4dtfsxYQZlqhm+a7YXsvMquXYwT0vdkK+XabcVFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyMCBTYWx0ZWRfX+YDRfSaec4Fq EjRuuDHdbk+l8f65vCLSUfYuoRFcmRSc7bsyjJtMhm558MQjRdk0xnQouUmsn2fxH/atg5zxKM2 49f9WJkKpadg0td8bIzFoXv6FZA2dxU7ippvSoZYbQcxS2LBNM8eUyTTvx5qMUuc1vLs670OtLX
 hEdU5sTi+GwsH1As1mMIUHDjODe2vk/VoRbCvN9BxpGdkkEVYvp7MqdPEku9Ugc732/JytyAMF/ d2a+2UAn7ua3VJZWlcOJL6Zv7NUF+DhJeSOExvpfAcRWhVKjYQ2Ipfd8zpzt96NfIogurFdByJj wObemnQuS8farhjF6FrKTg8uUM2SbIfGP4GOL4QMQVbI1p26K78YuKr6wlBUyLMZBJcFloLc40W
 K/0GkfxETeVqBhsC8imkvNYqpQQ46Whfcbg0hKVnSbw3WRmrS4rSHj3GnqTRjDlQunXRDtKd
X-Authority-Analysis: v=2.4 cv=MeNsu4/f c=1 sm=1 tr=0 ts=685eadb6 cx=c_pps a=UKvgJB4ZXemRNA6BSV974A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yCOTQmV8_SjKz6MKC4IA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: t-du3Q50saOrwGh-hCR-mKUmuHj5XwvX
X-Proofpoint-ORIG-GUID: t-du3Q50saOrwGh-hCR-mKUmuHj5XwvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=960 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506270120

On 6/27/2025 1:49 AM, Christian Loehle wrote:
> On 6/26/25 19:26, Chris Friesen wrote:
>> Hi,
>>
>> I've got an Ice Lake server running 6.6 PREEMPT_RT, currently using the acpi_idle cpuidle driver and the "menu" governor.  I'm seeing some weird behaviour with cpuidle and C-states and was hoping someone might be able to shed some light on what's happening.
> 
> Does your kernel include
> 3cd2aa93674e cpuidle: menu: Avoid discarding useful information
> (since v6.6.93)?

It does not.   Thanks for the pointer, that commit looks potentially 
helpful.

Chris

