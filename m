Return-Path: <linux-pm+bounces-10028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DB1917A60
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4816A28370C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E4215B10D;
	Wed, 26 Jun 2024 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s1ubS77g"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B181B950;
	Wed, 26 Jun 2024 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388971; cv=fail; b=InsqGc7ME6N9Y8WoborhY6qBD2FtYKyCsyJVwC7sjhRn7ciC8KME+5rL4p5YAP71W6OYKKpGYyMZLjsM06n6eryjY60HEnQZbwmDqoFhnAdiqz+zB90bPBb4iL7g2p5mzgnyhpdJRiSAqkQJk3chN+TQ7Qfh9ppb0REgDA/E4mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388971; c=relaxed/simple;
	bh=LLBIcbNbbXvY1eNMlKLJtrGZ5dAqaKeNKvXV4VrxH0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fXb84Vc6b60NIATieT+wAWqjjLHSIKge1x4ltTs5WZgHssnegGJiohfxOxEVkweSXLWbIQG2paYTvxLdc0ornBNWJsTappBMfD9g7qJQo/Rly6OixmnuzEpE1dIV3i1Bn82sMMmhIycAmdOULkRCM25hFKDoILEcQOCw/LLKr1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s1ubS77g; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGipWVwfHD/ZcJytUB4dgvg08VV+VLPlpNH2HPIJXt0RBYs/C7+Mn5Pp44jtWKTMWkf3/7t3KMHp9ZwVnrBrPE1z44ntkO+iMRKohMlSYJNiRyUkcRaFCd+O/ZLG3FVVm26ssWFPESL03DawYLIzB5xM0PoK+xc6bBKtgtfd7qNvYFFSetJ1ZxjWBMGmlqLXUAfusTgYDhuvaF0LyNyHAEktGr+0clChPK7N4AOFa58SmD8qJDhDkJOlmDkr+eDT8vpkAZ1xwdwnYi1BaGFPbjq3J1bvm//Jw0HWNfqWYuWFexDs9dvtVQvcNttAGiTxtZ/A9ouAknuOonAroiCX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnddAdxyCbn7dWkp0jps4DaOA3rSE8DnBBpK6fcXXU8=;
 b=PC/9DQvoKkjJsi/coNaZ4m/gBqBqFnD0+f0BS9wqqrUHUNKPh/QEpZDaBL8byGvNX6l0sB874vd9oTHXd9g6qKFmb7Ghm414Wy7bCbUn1A/Y+BRgUzjyDGMtOkOUdxGi3JrpVYF+RD3YpmEJI9tI6mKtheffqxaIGKiWyM3U9nXq02DOstEBi9d7jItWBaEV0oIxjO+AZhTd/zIHbS799MWYTuHKVzhYXtE+JWYqQ+2nRDVMIbbhw2juh+yg1Z2aTIVyo+bT16NNtnWxwPNCnxHbtKvrlGZoElTBG5gSlzOmjOHCq1UN+dGkxq45Ra7qMr9jVhK5+uuXb9yTaLyMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnddAdxyCbn7dWkp0jps4DaOA3rSE8DnBBpK6fcXXU8=;
 b=s1ubS77ga7WJvr6qv8y7ZULsgiXdGS1IWxnpIH7sMs07HH+A56nCFerz1X0zTONu/zvBSSIa1lHy8BCExFwcCC5IctYa4JyOyfFkqkcSAlffZbYoI0SWUrkZBpC0tSqQnMCRJ+GTEfy3GdO6+wyWqWKIjlnLwfAMJfarCfxYxPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 08:02:44 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 08:02:44 +0000
Message-ID: <7e1c6afa-3d9e-48a7-926b-39c368f1ef37@amd.com>
Date: Wed, 26 Jun 2024 13:32:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq/amd-pstate-ut: Handle the inconsistency
To: Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, gautham.shenoy@amd.com, perry.yuan@amd.com,
 skhan@linuxfoundation.org, li.meng@amd.com, ray.huang@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
 <20240625134127.4464-2-Dhananjay.Ugwekar@amd.com>
 <9ffb50b5-ee71-466a-80bb-42660d1fe237@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <9ffb50b5-ee71-466a-80bb-42660d1fe237@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::15) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 79834932-e86d-419c-6ea6-08dc95b65bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFpGeGxRWTdKRWxqemdET1ErRnkyRW1iamVEQk5kdkhRT3FpdytvTUdjbXhB?=
 =?utf-8?B?aXFlT3JtUDRtN2dNSWhCdnpubXRleDhtZWVWeGdwTFVWTW9KaWZlL2RTQkJO?=
 =?utf-8?B?VldJclBpcjdwdUJ5RVJaYi9LaHV1UFN3UVg2N3hqOUxMVXhLYnh1LzAxbjlE?=
 =?utf-8?B?UmsyTkE1NkFwZWliTy9ROWtFRlpxai95WUZKL0tETWdDUmpUKzB0VUl0ck9I?=
 =?utf-8?B?TEZzT3Z6MHREVjdrSjBSU0oxKzVzT0pIVFlqVUNkbU11MGcrdTVxTHhaRk4z?=
 =?utf-8?B?YWRxRStsU3N0ZFBOTlZ4ekJNZWY0VFQxS2JjalMrMWRITThLakRVTGprQUdy?=
 =?utf-8?B?UW45Yk1CbkhFM2pVU2NGbVdkRXFZOXdwOSs0UUlYK0NkbjdtSFNGMmg4QStu?=
 =?utf-8?B?TWNCbmxGcmJFY3RZY3R1aGduQm4xMTlBaVJidjRWWXFtN1dsOFl2UHFYdXU0?=
 =?utf-8?B?VGlZdG4ydGR0dmhNS1ZQVm9XU3V4c1NUekdnZ04wVU5HeXJ1MmNvYzRkUmFE?=
 =?utf-8?B?OWI3b0FzRU05aWMycXJ0OXQyV0dkUENvSVRUL2hBT0hNSU04N3NTTzJyWGZj?=
 =?utf-8?B?VW1LN25WVnlibzUvd25oY1pGdmpmdTRhc1I4M3hmbzRtR21USjNFMXBvdmNQ?=
 =?utf-8?B?NU5FdmNWTlE2bHhEZUx5ZWdxeFZ5VEJBVzRacWdpYjdCZ2VGUGxmZGxEUmly?=
 =?utf-8?B?NVNaMlg5LzZ1aU9vWUdzZ3RoMzRpdnQzMHhha1VXb2ZGazJjeFNqRk5jMVBF?=
 =?utf-8?B?bFdlSWhiQnZzRVFtS1p5d2k3QUhOMUpzMUtTTktIOTRWMGJFSjlGclZHY0ta?=
 =?utf-8?B?WkVuZmlCOVZRMzdrNHF1Z3BBZ09BV2xOeVNuUlRaSkV1dWMxWTQ5V2FPTURZ?=
 =?utf-8?B?Q0tkYTJmZE9aS2Myb1dtYTdNNm9xcm80Z3FYMkFpY0VHUi96QVp2WENMSFhH?=
 =?utf-8?B?eU5QcXQ0bXpCQnRTSDJaUVpya2t1Nml4WEo3di9EdVVRcklha0FIcklGUGlR?=
 =?utf-8?B?QTF6QXhhN1MweU9kOU1ydUJ1ZzduRXJSNElUeVphT1YwcWtGbXE4Tm9wVmNk?=
 =?utf-8?B?cDQ1NGtMTHdhdTMxOEJueU9DTUMweUJ1R3N2dVE1eSt4WkZHS2FNbkV2dEF0?=
 =?utf-8?B?SzlKakMwSm1ITWdyTEVKQW9iZVNzd3lNR0VFT0VvWDl1SyswVVJMQm5IakpQ?=
 =?utf-8?B?Q0thQkNLVEYvb0ZTKy9YdDR2WTJ0Z3pIOFVqayswSVkyMXlWSThsY1hML3J2?=
 =?utf-8?B?ZEdQeHY3dFNVcnFRTVJOMVNKTmZpUlNJWWtORWxOTExYWmZvL0lGYVFybHNr?=
 =?utf-8?B?UkVHYzZucC92NkYzWW1GVGpqczZsOFMwSlZmUzdpbFVuY2FibVYvUmhONW54?=
 =?utf-8?B?T20wK2svdE5QUmhOTTVsQkV5ZW1tdVd4U0VIZzZqaEcwV0FvTUdqSGFZeExE?=
 =?utf-8?B?MXhndURYQlhJNW9tV3kzNTN5dVlEbTBzUVZpQ1VJUHRSbWwzVlR5b3A5ZmQ2?=
 =?utf-8?B?d3B6b1JKekpWOGh2VlJscmVtMG9sdUp3SjRnUjFFQ1dYTGxyeXpQOGh4Wmpq?=
 =?utf-8?B?bHFUSG1ubXo2NmxJaEtZM1pIaVk1d3JJdDBHaGhielJuSmU4MExnaDRXby83?=
 =?utf-8?B?aGFzWUZIMWozWnpEV2tMRi9FVERURVhjbDZJVUNEalpTTmtkdUMva1dkcHBx?=
 =?utf-8?B?NGhWSXNkSWhYYmdJS1pjZW1CeVlwYkhCTGxwSmpzc0tYdU5RbUxsRkRudjlY?=
 =?utf-8?Q?SeAyHOh55VWMhsTw6oj91vKCJZ3FKEJsDIjb2uA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGsvMzUzSjIzZkRTSmtlQUtwaERMeVRmQ0JuVnQxRzBZaWdrSEtQd2VueVdB?=
 =?utf-8?B?aSthVkhnQzErRm8wU3pmallXUmlDNFRSU0Q4Y2F0RXVHVC9wUGVtNlNPRWFT?=
 =?utf-8?B?M3hBUE5rRk5QMjVYNExheGZxL0xKOHNwemdqRHkwaHBLVnVISTkzTlg3YW13?=
 =?utf-8?B?b2NBR3dBQUxaa3U5SG5sTW5KVm5yTEJtT0ZPbDdNRUg0MlZSbUQwMnNjYzFo?=
 =?utf-8?B?T2JxZGluSVdqdi84SWF0NFd0YWthY1ErbjMyd25ON3N6Rml5RVlpTnNFN2hH?=
 =?utf-8?B?VWswc2FxT0kwbFVuV0phOCtXeXpUbmhjMy95a2tCU2tjSmorOUhRQzNLZ2VQ?=
 =?utf-8?B?cFpLZUxucWQrYzdJR0tleS9qclZ3TWEzRnh4bWZ1S25zNXBhYUs2RkZRejVH?=
 =?utf-8?B?bHlJakRMQXNSSG9QNERDYWpvejBLbVJ0WDhYMytKbU16UUV2cVd0dTQ4RkVu?=
 =?utf-8?B?R21rQUNhNExYaUFPSTNhVC91cTNsejRkRnc0UzUxQ2t0V2lKQmNVMDdpelVa?=
 =?utf-8?B?REw1S3ErdTd5VEdrZGZGTktGTVpWMG5jcUFmSklVTUlPT0NwOGdGODBOamFU?=
 =?utf-8?B?a2Z3bmttQllFSmZvYTJXU3YwLzlMODNZTGp5RWlObndMSjlwVmRHbEd3Wkx0?=
 =?utf-8?B?VWM5WktpU3ZyRGJwZ3VTM3NpODFXdHliODNQUnVRTjFLSExWWHF4YldqdGNh?=
 =?utf-8?B?dEVaaStYNlRQcGlpV2hpYnUxT2tnYTl1UzNNVk1NQ0l4ekR0bU5hY25mcnRS?=
 =?utf-8?B?SmtISGZROTNjbDVqSDFUWFhUc2dwMUV1TjVScUpoblB6S24xK2dSK0JaTTFD?=
 =?utf-8?B?Rlp1ZHZkc1ZhSTdLaGhBODhDY2tRekh1U0g0Y2t3Sk4rWU1jbkhQZVdObzRB?=
 =?utf-8?B?K1NhVGViWS96MmcyNHpBVlZzVC9NUExlaXRKTXJRdzhIb0RtSFlPY25zN1do?=
 =?utf-8?B?MFBXYlYvZzhWQUZEYTdqcGVYNEJablArSjZpcHZic1Q5YUpZSWo4bWxiU0g5?=
 =?utf-8?B?a2F6dis5WTNPUWZtSTZ6UllzM0g5VzJPRkVEY3JpdmloMy9uRnJtZGw4K3po?=
 =?utf-8?B?b0xQTlRzQk8renZXcTNxMEZSeXBKQk5aYlVLTENjcWpmSG1wSnJ6c3ZYa29X?=
 =?utf-8?B?RmNIVXVURW94WnNvdHI4NkRObjVLK1hDK0VLL0MyUDBTTWhxeHV5UWdENEJY?=
 =?utf-8?B?L0lqVzQxRXozd0RJV1BYd08wdW1aN20vK1ZUbTN5OWRId2c4MWI4NGtjeVJp?=
 =?utf-8?B?VE04UG5uM1RCRmY3cDB1QkRMWE5DdXJpeVh0bWdkdjhGUHo0Z2wvSytYZDhl?=
 =?utf-8?B?Tkx2S0hqRG5BV2ZaeUF1UU5RUTQ4b21RMHNucDllZ0JzQTByTm0rbzRZaFJB?=
 =?utf-8?B?azBRWXlBbFQ1bk1ReTcyOXZsL0g1aHhmSC9vcjIxN1FEOSthcnRtVTdzMGho?=
 =?utf-8?B?MitZbVdQMkdlcEwwdjVaUW1oZm9HcFFVV3lycms1djFMZkpaSU9FMkVXL0JV?=
 =?utf-8?B?ditVVTFITmFTWGtSOTVYM0EvY0pka09FOXU1d3RxZS9XL0tCZWMxa0EvczUz?=
 =?utf-8?B?QnpHeDZBN1Jjd0tjVlpDV2M2MGNKWGxoNFRtS2M4aDZydnkrYXM3UFJEWno2?=
 =?utf-8?B?RC8wQXFjaXJVM21uNUtzU05VeGlMVkNkSjhHdWpieFIxL0F2ZFF5WkVYdUI5?=
 =?utf-8?B?c0JoRlgwMkNTNFN6aDBOUzlpVjc2aC9Cby9VM1lOei9nUFRHYWRTWTNtN25i?=
 =?utf-8?B?czFLSDlSUTNsNEFsbDNpNk94UFZUYlcxYWVjQWhRWVpKVmVRQUl5LzU3VGFM?=
 =?utf-8?B?UXNIeE5EeGF1bVZXa28ybXhlU3N4VjhiRDA5bmVkTnJ6L2ZoYVdXYXN3V1FH?=
 =?utf-8?B?OGc2YndEem5yU2VRSGJZNWsvem9qaDZZSjZPYlRsaHh2VmlTZkliaGlpbms5?=
 =?utf-8?B?c0R6akFLbmtqd1M3d05UZHZYaWNlbjhQVFpSbDZLbjlUbThMSk9qSWZnMkV4?=
 =?utf-8?B?T24vN3NlKzgrYmptcDVDN1ZhRzZKNHdNR2NHS0RiRXJOejBkL3RWWEFPS2tw?=
 =?utf-8?B?amdRWFgrSWdoejF5YlMxV1VTazNENXdVVXNsdGxXQU51SXZPNFUyeHR3a1Bv?=
 =?utf-8?Q?gzK0iJgKR4bLoGQ8uvxXKJASK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79834932-e86d-419c-6ea6-08dc95b65bd6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 08:02:44.0205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6R+oylTSKPkLVCCE8rDvXc4x+03KsrQ3TwJRMiDuWsdqf24ktz9q96AXpqQK3tML8uGpLKPZ8pCafFXbF03EDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943

Hello Mario,

On 6/25/2024 8:35 PM, Mario Limonciello wrote:
> On 6/25/2024 08:41, Dhananjay Ugwekar wrote:
>> cpudata->nominal_freq being in MHz whereas other frequencies being in
>> KHz breaks the amd-pstate-ut frequency sanity check. This fixes it.
>>
>> Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> 
> The code change below looks fine to me, but I think the tag is wrong. It should go with the "fix" that caused the inconsistency.  Here is what
> I think the correct tag should be:
> 
> Fixes: e4731baaf294 ("cpufreq: amd-pstate: Fix the inconsistency in max frequency units")

Makes sense, will update the tag.

Thanks for reviewing!

Regards,
Dhananjay

> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
>> ---
>>   drivers/cpufreq/amd-pstate-ut.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
>> index fc275d41d51e..66b73c308ce6 100644
>> --- a/drivers/cpufreq/amd-pstate-ut.c
>> +++ b/drivers/cpufreq/amd-pstate-ut.c
>> @@ -202,6 +202,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>>       int cpu = 0;
>>       struct cpufreq_policy *policy = NULL;
>>       struct amd_cpudata *cpudata = NULL;
>> +    u32 nominal_freq_khz;
>>         for_each_possible_cpu(cpu) {
>>           policy = cpufreq_cpu_get(cpu);
>> @@ -209,13 +210,14 @@ static void amd_pstate_ut_check_freq(u32 index)
>>               break;
>>           cpudata = policy->driver_data;
>>   -        if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
>> -            (cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
>> +        nominal_freq_khz = cpudata->nominal_freq*1000;
>> +        if (!((cpudata->max_freq >= nominal_freq_khz) &&
>> +            (nominal_freq_khz > cpudata->lowest_nonlinear_freq) &&
>>               (cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
>>               (cpudata->min_freq > 0))) {
>>               amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>>               pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
>> -                __func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
>> +                __func__, cpu, cpudata->max_freq, nominal_freq_khz,
>>                   cpudata->lowest_nonlinear_freq, cpudata->min_freq);
>>               goto skip_test;
>>           }
>> @@ -229,13 +231,13 @@ static void amd_pstate_ut_check_freq(u32 index)
>>             if (cpudata->boost_supported) {
>>               if ((policy->max == cpudata->max_freq) ||
>> -                    (policy->max == cpudata->nominal_freq))
>> +                    (policy->max == nominal_freq_khz))
>>                   amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>>               else {
>>                   amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>>                   pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
>>                       __func__, cpu, policy->max, cpudata->max_freq,
>> -                    cpudata->nominal_freq);
>> +                    nominal_freq_khz);
>>                   goto skip_test;
>>               }
>>           } else {
> 

