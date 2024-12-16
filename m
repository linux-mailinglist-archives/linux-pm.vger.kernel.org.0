Return-Path: <linux-pm+bounces-19312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E179F331C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 15:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8A916A0B9
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 14:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CD8205AA5;
	Mon, 16 Dec 2024 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c6U4Huae"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F770204585;
	Mon, 16 Dec 2024 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358898; cv=fail; b=ZGp9XWglfY6lIUaQfn2qwX9ffWWBdGVCXuSk0TOSjgHrthvy2N5CflCmlBY5Bzxgo8eOv0JI0V5itfdI2Py2U2J/bkw0oQa3OXcUDBi5DPHgBo9kHoRv04TKtwP+yNZejW6ixPhwTTxHSp2BWF1pcfwuvqNWS9LboeUvHNYdsuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358898; c=relaxed/simple;
	bh=JUJEh2picZ2BFWaT+tFeMOMLasVjiliFurQIAraQ+oo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XMLuC4isSLCQYHxqVB6k3ZEXib8jDjxVP9i0EGkRsxNqogteaAXw86Qwo54bIqGB7atvrxRuvEz4NgoKdH7fwL1Ack7wlVUo/lWNGd2OUBSjgeVK7cxjd9Nr/Dz56idZKeMSx35HEfdMgGHkXzjte5Jdre1YmI9EGNIfBBU5/MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c6U4Huae; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9H8y0m15m6IbDpFRChGeZ5IdXbHuKj5Lnlu+TQc+TZtG1jFg1Oaf3bHxzhv0Kj6D00jW1378agVIm8FPwtbC144O8Ic2scQ2g7pliNN4guIRPC3oQ5W0gYBb/7CfbhO+mY1mH8m1I+b5Phv3hdiGETWV+zvtk35AfPP+WYqXRp/FWw85+MtXVrTB5pS/uG8Cl/kIseJUEK6+gPGOjS/MD1pMw5Y4R1uKlRVOyIsPNtRW5HMDqIAuBBam6o1XJXDdCHvNP08dCNDPx1h7Fi11lqtwLyOowCdXOhbqu50FbyS6Cpu0cWg85uRpQVtj5BLaxbg/3GLYPtpvbyaFcKiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIh9hVAS8FKQ3GHHrvsjbfvmlDS9s591jKdtpYDZ8V8=;
 b=ZxJboPjxknKPyDRTCavx761cNhYztbSz25/3LIjG33x9b8WB6gzoyp7ryHEPkJpPAng6J5YOPF1OPr+bizQFnsdtXpOGQNP3FMmJikixD3AViZbZq8NqW5010qI6Klza0fpxK0DI7KHLzG3e3hGSDYruCz+6+xazsRQL5MR5MN5NRj9cvPTP/7onUF1P79offFSzq+bOI7tm1uSrEcQJvR23Qq5BugdYdDQJ/0iL+QJ3LRptwZXay2DtDun7MoW1EPx3/UkEpVJKUP8BRUfqaNOxldoJ2g0dTA5mXX0fIBir193X6g4rcpILrjToJ6NXwfUQlVRUwVKVTM/h4qpIeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIh9hVAS8FKQ3GHHrvsjbfvmlDS9s591jKdtpYDZ8V8=;
 b=c6U4HuaecmaWS/ixTo5hhMCvXtOrCJMVfxRZgg+cW6GnH31d25mQAqTYkZ0P60qizyUlDuSkfjy+ZAXCJnM0+8JEInMxGY4sAF367n6YX0ABTPz4Zbh6Kqn+5v1oG0yFI+TxV03Zi5E4RXtUvb4rXu7Slci45LikT/CHe+LKaqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Mon, 16 Dec
 2024 14:21:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:21:34 +0000
Message-ID: <6ea8c643-6977-4ce2-be1e-b0b0a73e8306@amd.com>
Date: Mon, 16 Dec 2024 08:21:33 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] cpufreq/amd-pstate: Move limit updating code
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20241209185248.16301-1-mario.limonciello@amd.com>
 <20241209185248.16301-11-mario.limonciello@amd.com>
 <d120814f-7393-4d10-a6de-ba09948f4243@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <d120814f-7393-4d10-a6de-ba09948f4243@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:806:f2::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 4189bc18-fab6-42f6-d5a1-08dd1ddcf206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3dJaW1BY3JITkJha0RwWnRsNWt2TXRTdmdQQjIwb2pYalpvTFprRTZjdE5k?=
 =?utf-8?B?RUVBUTFlRjRGMThpYWlzZ095TW1kWEI1MWFiaXl1Zmt6M3hiRkJCS3VqOCtB?=
 =?utf-8?B?MzJTVW5yaWlHVUFpU2w3TWw1ZStZMGxvS2RFc1NyUzMrdkpnWk40RzNJK29a?=
 =?utf-8?B?SUhFVitpd01CbDhTL2ViSkttRXZUaU5VcXhWYU8rTURJZitiSGNGK3A2M2FI?=
 =?utf-8?B?NlRJdmkydzVNa3IwL0Y5cXd5NUpwaUw1d0cyTHZpaXVFQUdiZWE4SSt6bndH?=
 =?utf-8?B?VDUrTHFnWVZNeUt2S3NiMkk1dTdEU1N1OUlmMHJndzlYc21YZEFPZitySUFP?=
 =?utf-8?B?aVhSdUJNd25ydmVhRmlWeDBtNzQ5YTBPZjBWWE8rdy9BemRaVCtDbjNHbCtt?=
 =?utf-8?B?TUcxaGhmS25NcGd3MFVFRTY5NWNwbU9Oa1NxeE5SSzMrOTk2M1IrT2oycHV3?=
 =?utf-8?B?eUtNQkJBSldZUFU3TjBRYmhQWWZITkF2YWVUaDE2amsvdS9wT1hpNURaTnBV?=
 =?utf-8?B?WTQ1Zkl4QTMwYzBYc3RFdnBFVkxES2Erek5ZbnRBSW93anBRb1p0S3hSUXNk?=
 =?utf-8?B?aGFmclJCbWdOS0ZxbGN2TFBTaXZaejFHRlJ2WGJWSGVUQmRDVVJkVklPZXJ4?=
 =?utf-8?B?WHlEd1V0MnBKM3ZmaWxhMHAycGt2V2JjalV5amtLaFhQS1U3TzJKcWMzTXZY?=
 =?utf-8?B?K0c0WkxieTVHMWVtSXZneWYxd2lnekVGNlQwS0tkTlpsbFZvWHBoVGVzaUxQ?=
 =?utf-8?B?QXphREtaMzJiZ2grYUxEK3lzaDZ5Tk85eWJtR3FQWVdKVGNvbXFwWDlGZlhZ?=
 =?utf-8?B?S1BnMzhIQ2FhUDB2RFlJaEVBMHBpeFNHMVhRdTV2VldIV24xQldIWkgyM1Bz?=
 =?utf-8?B?RG5aNFBMMlZ2bGE1TTBna3RYaUd2aldYNVhYYVJrMXlMYVJOSGZCY0lEakR3?=
 =?utf-8?B?Y1VmSjNmY1dMS0sxNHVsWDVEMEF6VnQ1TmJKTXh5dWp1Uk1na2Vnc04zcXA1?=
 =?utf-8?B?VWJlMUdaY2JZeTMwUXpUUndYbTl6c29JMTJwd2s2SUlZRGFCT2FWczE3MFRp?=
 =?utf-8?B?RTgrZkxzMzZzZEs4aVNMZWFsc0FOK1JLYTR0eDh5WlMzak5lRC94eXNVRzB0?=
 =?utf-8?B?YkwrYy9FZlpYK2s4Wm1VYklPNW1lbnkrcWlSNlJpWmQ1MzRmNWw1K0h3MGh5?=
 =?utf-8?B?cm8xN0QvTlNrTWZkOVR0QmgwM1VuUWE3UUVkMjF2aXFhSWYwM0dmWHY4NzNM?=
 =?utf-8?B?bmJoM0VCQnFPVm1FK0ZoamRCRWxGeUNwcDZIditzdnZUWDE3WXRJSGF2MkNM?=
 =?utf-8?B?YmlhSjhZNHFWb1NIOGdCMXUvS0hGZEtCQmErNXphV1hPa0M1QnNsUGNqemM4?=
 =?utf-8?B?RkhRTTVYdHRsUGs3dng1U2NRc3I5SDhjdzJtcTFIL0ZrUjc3UG1KcUZ2cTlL?=
 =?utf-8?B?MUNBeTdGTEQ2MUNUMDNNa3BqM1VVdkViSC9KRWxld25zdVBodmlQODRUdHBC?=
 =?utf-8?B?YnhEb25RS0xuWGJoM0crV3h0TVNYeDNQcEtCR2ZEUmVlU2orUlIxQ3FpN1JE?=
 =?utf-8?B?cHFPSXY1eGNzc2xGUERNcXlrYmk4SVpTRktxR1JjcGY5Rkx1aFMvaFcvdzd0?=
 =?utf-8?B?NzJGVyt6b1FDWDhIdm5zbk56cmY2K0tNSTlWNGZPUDB0NXF3QU5VYVJZWWtv?=
 =?utf-8?B?eGdrdkFON3A2cHlRMnZmSGluMVZDcWxKWXE2NkhzQ0drQ3JwVHVhT3JpaVlp?=
 =?utf-8?B?UVJLREVSY2prTGtkaUF4VUxoUFFRdzNSVnN6T0NEd1RIMkltUmFWc2pRQXZO?=
 =?utf-8?B?c0xhbUxGTnlWU1dhRGZtZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWR1MllDMTlROENsWnZOUGsySXZWMFFZTkVJL3JTVVZidFVBQU5Fai9ycUJz?=
 =?utf-8?B?bDJINzYxWXEvRWFlYVdqdjZtamErMkRVbnFjM29ZQVlESngrS0NCbHRtQzlE?=
 =?utf-8?B?d1AwVnc1MXZ2ZG5ZRFN3M3dEbDVIYml4emNIanRzajF3UDN3ZXFlRTVXa2JG?=
 =?utf-8?B?N1VKaWhnYXdxVXBnZHptWWJ6MTcvNDBZaEp6dlZkKzRod25ZYTBKUklscnNz?=
 =?utf-8?B?aGRuRE9jZWo4RTdQdzAyamc4aklJbzdQSzI4YzZRSFhjQnBZYVJBb1JtOER3?=
 =?utf-8?B?bUpCdUJrWmpFZW56SE9Hc1pXTjVqTWhKK0psTS9WaE9mVWNMMmtmeE84TXJO?=
 =?utf-8?B?SnR1ajBTb2dFZmMwZS82RjhjRGRJL2hXcnlTUkY3dkJHUjhvaGJRSlhSeGVW?=
 =?utf-8?B?WEpva0F3K2hQUHh0d0lHMDJqb1dPZE5YMVRSS1gzQ3FldnZPQ2FDUWZjKzBu?=
 =?utf-8?B?UHhjcWR5UHBUT21NeDNWMG93Q3AvbkQ4NGhLdTRkZEhKU1lHUVlia1NDYzlY?=
 =?utf-8?B?MHBRUzR1dng2USszMnhLOW1uWCs1MWVDcGJ2ZjJSTFBvZDhGdVM3MUdUakcx?=
 =?utf-8?B?RWhOaEp5SDQ5VlAxU0Q1Qmphd2o5Wno2K1NMNlBVc0xZU2F5UlEvUXRPT3V4?=
 =?utf-8?B?QWw5VHBZVmVBcjZsN08zTEQ2SllySGdVSjU1WmhRc2UrVGtVcjB1a044UGRS?=
 =?utf-8?B?cEFsSXlXMEtmSUN4WWNIME9kc1F5RG5VYzhuYlhCSVJVb1lkaUhJT3lrZUYz?=
 =?utf-8?B?R25jUDR0R0wrbmhqSVNUaU40ZUdodmdHWE1KbXIzNjRkSUU3Sm5mTGZoQ0s4?=
 =?utf-8?B?R2wyQUlmTWEwVXNvWjhsMzFaNkVJdUZxNmdHamNOM29OakJ2UkJ1ZFZvUUhi?=
 =?utf-8?B?ZlpRZE9NV3d5ZStaY0w3TTVGRVlKSUtaZ1dHL3VnTEk1RHlQa293MU81STJu?=
 =?utf-8?B?SWxCZStnRU1xZkd2blpZYW9lcTFrMHhJNEY5Qnh3YkpsV3pML3ROREo4dE9U?=
 =?utf-8?B?aVZPUVJPcHI1bUorM21xaldNeEt0dUQyYjBKZHFJVHZKcWxyMnJOeE1SOEtK?=
 =?utf-8?B?dEkyYyt3SmNoQlptTDd3MDlFOWkyZzJWZHhtNzhhZGxvTWdLaHE5bHNsVEpI?=
 =?utf-8?B?ODhmZWRaeGhxSFl1TGtjVjB2eTNNVHk0SWpDU2FGam5XRDZ6cENxRmFBZU9u?=
 =?utf-8?B?QVlTSExjZU53anl2WTBzRXBHcExscmJCN213STBwRTNCNDFPbk8yYit6TVJ2?=
 =?utf-8?B?WkwrT09IaGl1MEQ0SnhKb2thQWFJRHJ2Wm9nYnlmb24rSTVWL21ZbytadFRh?=
 =?utf-8?B?TnlLQnRVMDM3RW1zTHFmS3pEaUxlSWhWaVIvNTAxRlZQTlFkYlY0ZmZ6QmUv?=
 =?utf-8?B?QnZDckZVQ21HQzlmeEVnMEc3T2I0NmdFbDR2WDhaZHZVOXZ2UDNsakFNTlpU?=
 =?utf-8?B?UjhUcWVuRkZSajVqU2FkZ1doTkp6YWVLVmVMNzZPNnp0NitvdnU0dEtCRW9r?=
 =?utf-8?B?c1pTRWU2R1JhYmtWRXFLRmF1VnhuV3V2OHUvejNJd0MveWk0TmdQb0l5NFk4?=
 =?utf-8?B?ZkpORDlwWjN2UFI5bk5hTVBqa1Y1enYzQUV4NTNDcFQ3blhYM3krdzdMemhP?=
 =?utf-8?B?OHM5T25GUnlid1JXN2ExRXJlQmU3Q2VDL01HZXJZNW5XOXRPN1cxUFh6dFl3?=
 =?utf-8?B?M09rcDdoN0lvaHp6OHZnTVhoZDFPUVVXMTFNREZCd2VFZk11c3NCS3JRbHpZ?=
 =?utf-8?B?QTZQaGt5a09Fc0hDdkVha3hkQ2NUNFJad0NVenl0M0plSXpRUng2M3k4K1dX?=
 =?utf-8?B?cEJNVmJwTWZuTXM1VmNnQ2VGaytrOFdHc1NkeEFqakRncmNnMVBzd21wRm85?=
 =?utf-8?B?a3FYNEdFR3cxYkJqRTNSS0RsQWwxdGg1TmozcmkveVhkaFZmeVQyMVNlQ3Y1?=
 =?utf-8?B?QmRrMHR2K2RrTmRPeWdiSDMvZ1BENy93d1FROW11VXVsZUlkVEU1QTBDTU9l?=
 =?utf-8?B?YlZUQkhQYmpycTNXV2NsRDB6SFBGcEhIM2hjZ2hWQzByMk81N0lsWWh0T0xN?=
 =?utf-8?B?ZTFyNUlhY3l5UzQwdC94VWpLQnRvd21mcDhOSXRZSUVTOWpxZnBtRjZ0Rmcv?=
 =?utf-8?Q?vqK7lTzoZHhP+hrQ4Y+4S+zrM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4189bc18-fab6-42f6-d5a1-08dd1ddcf206
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:21:34.8536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IknUT7OTXbJZfLFQZ0gnGWinW93qBB3TtPrPhEnPE3bz0P7+b/X5WC1+Wc76GobZOjvnRT4QW2cTowq3Hlazsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286

On 12/16/2024 08:16, Dhananjay Ugwekar wrote:
> Hello Mario,
> 
> On 12/10/2024 12:22 AM, Mario Limonciello wrote:
>> The limit updating code in amd_pstate_epp_update_limit() should not
>> only apply to EPP updates.  Move it to amd_pstate_update_min_max_limit()
>> so other callers can benefit as well.
>>
>> With this move it's not necessary to have clamp_t calls anymore because
>> the verify callback is called when setting limits.
> 
> While testing this series, I observed that with amd_pstate=passive + schedutil governor,
> the scaling_max_freq limits were not being honored and I bisected the issue down to this
> patch.
> 
> I went through the code and noticed that in amd_pstate_adjust_perf(), we set the min_perf
> field in MSR_AMD_CPPC_REQ to "cap_perf" which is equal to cpudata->highest_perf (which is
> equal to 255 for non-preferred cores systems). This didnt seem logical to me and I changed
> cap_perf to cpudata->max_limit_perf which gives us the value updated in scaling_max_freq.
> 
> I think as we removed the redundant clamping code, this pre-existing issue got exposed.
> The below diff fixes the issue for me.
> 
> Please let me know your thoughts on this.
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d7b1de97727a..1ac34e3f1fc5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -699,7 +699,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>          if (min_perf < lowest_nonlinear_perf)
>                  min_perf = lowest_nonlinear_perf;
> 
> -       max_perf = cap_perf;
> +       max_perf = cpudata->max_limit_perf;
>          if (max_perf < min_perf)
>                  max_perf = min_perf;

With this change I think you can also drop the comparison afterwards, as 
an optimization right?

As this is already in superm1.git/linux-next after testing can you 
please send a patch relative to superm1.git/linux-next branch?

Thanks!

> 
> Thanks,
> Dhananjay
> 
>>
>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Drop lowest_perf variable
>> ---
>>   drivers/cpufreq/amd-pstate.c | 28 +++++-----------------------
>>   1 file changed, 5 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 3a3df67c096d5..dc3c45b6f5103 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -537,10 +537,6 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>>   	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>>   	u64 value = prev;
>>   
>> -	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
>> -			cpudata->max_limit_perf);
>> -	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
>> -			cpudata->max_limit_perf);
>>   	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
>>   
>>   	max_freq = READ_ONCE(cpudata->max_limit_freq);
>> @@ -607,7 +603,7 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>>   
>>   static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>>   {
>> -	u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf, max_freq;
>> +	u32 max_limit_perf, min_limit_perf, max_perf, max_freq;
>>   	struct amd_cpudata *cpudata = policy->driver_data;
>>   
>>   	max_perf = READ_ONCE(cpudata->highest_perf);
>> @@ -615,12 +611,8 @@ static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>>   	max_limit_perf = div_u64(policy->max * max_perf, max_freq);
>>   	min_limit_perf = div_u64(policy->min * max_perf, max_freq);
>>   
>> -	lowest_perf = READ_ONCE(cpudata->lowest_perf);
>> -	if (min_limit_perf < lowest_perf)
>> -		min_limit_perf = lowest_perf;
>> -
>> -	if (max_limit_perf < min_limit_perf)
>> -		max_limit_perf = min_limit_perf;
>> +	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>> +		min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
>>   
>>   	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
>>   	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
>> @@ -1562,28 +1554,18 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>>   static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>>   {
>>   	struct amd_cpudata *cpudata = policy->driver_data;
>> -	u32 max_perf, min_perf;
>>   	u64 value;
>>   	s16 epp;
>>   
>> -	max_perf = READ_ONCE(cpudata->highest_perf);
>> -	min_perf = READ_ONCE(cpudata->lowest_perf);
>>   	amd_pstate_update_min_max_limit(policy);
>>   
>> -	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
>> -			cpudata->max_limit_perf);
>> -	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
>> -			cpudata->max_limit_perf);
>>   	value = READ_ONCE(cpudata->cppc_req_cached);
>>   
>> -	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>> -		min_perf = min(cpudata->nominal_perf, max_perf);
>> -
>>   	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
>>   		   AMD_CPPC_DES_PERF_MASK);
>> -	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
>> +	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, cpudata->max_limit_perf);
>>   	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, 0);
>> -	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
>> +	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata->min_limit_perf);
>>   
>>   	/* Get BIOS pre-defined epp value */
>>   	epp = amd_pstate_get_epp(cpudata, value);
> 


