Return-Path: <linux-pm+bounces-40407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFE7D0027D
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 22:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 184A2300180D
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 21:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D822427EFEE;
	Wed,  7 Jan 2026 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KaTlZxt8"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F7277CBF;
	Wed,  7 Jan 2026 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821085; cv=fail; b=nz79K1qUTEgfISX1TF0XDECXNpvmf++6vV13dXewxIueU0NwMkZoHxq5QLi5zQWQlUdXzI4nKgid+oKFEaUHnWv2qoUScyeJ46EqzOG876Q1ikRhCUIhZMT2YuY32ADIQRrAVycDBAYOkshBq1q8pVStFvrHkaCNmfioxJSGj9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821085; c=relaxed/simple;
	bh=TfD/CUwM+LVPPKPdu+oyT8Pafca13rNjZdunn2CvCs4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MpPZSEWXO+lUpfybllls936AQk70CIHxL0TS7RH+DWQuiJziT03x/5y98XPrFN5PDDgmYCIT5YpPNlvAvg50Rn1fZ7TsmhwlC/UMoiktlrI9TQ2v6DoeZkBFhOl7qi2Iqaj1NAEECFho3WhvtPvWsz1h7t50sNSFwwm38nv3ldU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KaTlZxt8; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwmGbEzqh7fGWQ7O0t9qwc8ZTwcYcNe1paKXLEzydOZkdwpkXSiVsxMI22WuT72gUeQO1GoJYycaL+1IFT52Bp6DIgvsupvNsenYgQM27UF+hn/FeXMdsRKkBVnNEzfxbAgPzdqGedJ4XnVVSOdO/btFAusqnHpYzOduJdUX4JUMg0xJbZuw+LfZcmVPGJFm/zOD65ZeyrVxEUlrxWE3mBGK7rqn6FlpobngRmdrcdE0DwIDMspbzFQavpI6JHX2fnWiPWLvZ/fqvsSDKr8JIb71oZqM8UUrtvgNGTJhzAEjlKEeSuXwGODb+gaFTiG8B3iCSVLwSz8Dl4QpT8BpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIOPMt5EsSW1aN0qrxvTMnID1VCvbGEnXpSetHVLI2E=;
 b=Owx/R0beI+oV7OKpmurf4aszB7xLrNJmThOW02+gTf965/LXw9FwjWawfBa/5COjQpeqfsID0gpv9ivKuE9VzOmWBaBk0VxEatYEH7dfHpUA2br8sTxZ93B1zK8jINOPCzQruHrar47j9JgMVL0Le02KVTWZ9jVhOna1LzgHAESAADazazfln5/Prw7D7oLzLerk96MqdF1Kgig3IRFQfGFOdBvi7Pera/LLJeUnWvbIwTstQ0GIaqobphA9GukRtR92k9ACZm8/3UogWRxuy2aNE9Bsyj7plTEZYCzRcXy3+Qf6cPNfkDuPfyriCiICGSN+rIE9ltzidV9xuDFLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIOPMt5EsSW1aN0qrxvTMnID1VCvbGEnXpSetHVLI2E=;
 b=KaTlZxt8I/0O7QaEs5DmjZw1fbcn+JfXvTpG851xWOITL1LOYgHWATwufy58ceSTP0KNC6Tzw9tjx8OBqDaI4mxvjEX8MSQET+ctsF5RLVBL4ob6GF0hC8uBgNYYZ//uwziZavbVea25VZsk+gb/am2rT2p1irxcGE9j++g0zBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 21:24:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 21:24:39 +0000
Message-ID: <25a4653c-4d95-44c7-a957-c3ac9da214ad@amd.com>
Date: Wed, 7 Jan 2026 15:24:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix MinPerf MSR value for performance
 policy
To: Juan Martinez <juan.martinez@amd.com>, gautham.shenoy@amd.com
Cc: rafael@kernel.org, viresh.kumar@linaro.org, perry.yuan@amd.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Kaushik Reddy S <kaushik.reddys@amd.com>,
 Huang Rui <ray.huang@amd.com>
References: <20260107211919.38010-1-juan.martinez@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260107211919.38010-1-juan.martinez@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:806:23::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b862c3-fe0e-4a48-545b-08de4e332a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkNEZUxDdVVhQTZPajA4VDJnSWdYTHlST0RRVGNja3UwZHBGNTYwM21XbjhN?=
 =?utf-8?B?MUtXcTgzamZLT0MwVGI1YytCS0RGbC96dThBaDZmcm5CRjVkbmlNUlFlcTJC?=
 =?utf-8?B?ZXZQQ3NpM1RrRG9vR2ZxTXpiak5wNVhVSTFTQmF1dXdjZUM4Sm1UZi93ODh4?=
 =?utf-8?B?NjdqY1BoMGkyeVdkYjNlZmVlR1ZXTW9BcGpEUXdTMlVERGxTblRTR2REanZN?=
 =?utf-8?B?S0FTeXBPTHlsdTF6TUpOSzdESld0cXpTeEQvcGR6aXZWNG1tYWdlTUE5UlRE?=
 =?utf-8?B?Y21FenJoWjlMZ3oxL3F1QlIxZkg4UzN1QnJ4N1NBYVdFZEZkVm5reDlGYkQv?=
 =?utf-8?B?NVlhTUFmZjhsZXh4d0ZQb2ppYUtrUklzaU1hK3ZxMm9ESllQQ01Vb0E1Wk1W?=
 =?utf-8?B?WGo3ZkdUR0t1NmZ3RjhWKzE0cDdaeFlrcFlPQ2pGY3Q1QUJwMDc5UkFiQU1j?=
 =?utf-8?B?MGtnK3RBazF1bzZWUGFGSW5hTURGUWpnZlk2YXVYb25qUExtT0JjZkowbWk1?=
 =?utf-8?B?SnlUbWxraUs4V29LUzNqcjkzWGV0RTdkbXNPb3pqdzFLVjdXb09iZ3FDSkhN?=
 =?utf-8?B?bmdhWFJvQTFuWmdGVWg2d3BsV0w2eVVONlFBY2gyTU1hUkRSK3ZnMXllRGJV?=
 =?utf-8?B?cFhoVEl5TFJuT3dQckhoc2lWaElLUVFJNzlRV1krVWh4RVhRbjc4SHFzN1BQ?=
 =?utf-8?B?RFFMN0wxYmpBMDgyVVU1TSs0SFViQTZYemtldWN0WEVXYmloclRzMnFlVHMw?=
 =?utf-8?B?cjdIZzRJZjdGYVNPSCtKeEx4VHpKaHVsME9QOS9OemxVandTZ3BoWFBsMjdF?=
 =?utf-8?B?bUp6M3docDNoN2RaSnkzNFFGTDdqdVcwWERMT1BLNW0rbmluUEdGMjU5cEx1?=
 =?utf-8?B?aENWTzlGRHJBVkMwZjJnTy93VTFHSUFtUVFLWG1WVzNHKytocVBMMGFWSkMv?=
 =?utf-8?B?YjZyRC9HY3YxclducDRPMWlQcFlteWZjOVd4Q1BPSURyQVdZUmdGL2pHZWJ6?=
 =?utf-8?B?WnRTZUlOY2ROYVU5Q2ZxQytSVWd2MWR6UHhqb05PZElBaVdWQVNSQi8yNmEw?=
 =?utf-8?B?ZjhFQTdtMGMvWnZsYWJQT05LSG1JTG1QY1gxN1VFbXR2b1EvTmNVMXhzQjRB?=
 =?utf-8?B?QnJ6ZUVGTXJNMjcwSjdaSDJPTktMY3NxRFVGUi94M1dQbXRSNXlOOUR3bHFE?=
 =?utf-8?B?YjgvYWoxS0NxbzAyMDJwSHMrRU9YTE92ajF2cWcxTUg0VGt3UldpRnVCdWQz?=
 =?utf-8?B?NW5EZXhlSUUwdEdTNVltT2VXckxMakxXbGNZeWVlZlJCNi9GYS92dmJnVGtU?=
 =?utf-8?B?cy9GNmRQREZoZGRVWGFHT0tSNDRGbEVKcTlRamZ6YlNoN1l2V3o0clo4V0hm?=
 =?utf-8?B?aE1yRkdkRDFPWXRWYVppSHMzNHZvenVTT2RmTGFJWklTOU5mL3BPTytvUllm?=
 =?utf-8?B?alFuUWV4VDNOS2VPVjR0WDlNQ3JMWCtLUGJiaFpLMlUwR0EyUTIzc3pEZzVz?=
 =?utf-8?B?Yk9jaktRZTdRbDRlZ2t1OWx0bFg2bEhCRXFFYkMxNW9lTStyVWQ1ODZIK1VY?=
 =?utf-8?B?SFVNV0FTWThHOW5UMStWT1I1VDZPV1NzcEphVXFHWThsWmRuN1JlUU13N3Vo?=
 =?utf-8?B?VXpONXlUUHArY0NUdjlnVXFLOElMWkpWRDNPY3p3NHVzZ3FYbmljVU1wa3Fs?=
 =?utf-8?B?bUJtREFGYTVsQVAvN3RlWlhYRlVJRU1wTjRvL1ZZUGlHdGFEQytBZEhxbnBo?=
 =?utf-8?B?Wi9ublc3TWgrNzRzdjFsY2R4cGVLbURlS2NHQkI3TXo3dGZDYVI4TkptbThR?=
 =?utf-8?B?UlF4TElxcGdxbG56aFpHei96alNtUzRKa1NUY1p2bVlyQk9neG4ydW8yb3Aw?=
 =?utf-8?B?OW9LYzc1UklvMjJuVlFSZnNZaHI3NnlSVDJCY3hPWmY0c3czYkxxcDFEKzQz?=
 =?utf-8?B?aS8rT0VyaTFHb21Xck5HUnZXZHpwbEg5YjZJaVBEek5iSE5LVlN0UWFoZ2Nw?=
 =?utf-8?B?cjZXeklzd1Z3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2MrTk9qYXZVdFcxZEdhOEhnZGREbVhYZ2drZnZjYm01dUVkUS9nMkdHcjQ5?=
 =?utf-8?B?SkdnOW9aT01QZjJ5NFJUMk1ZcENVU1JWQ3VZRWNiMzlLaG93Y3RWUXlGQ1R1?=
 =?utf-8?B?Wk9XNW5FSDNvdUlGMnlUeTVKZ21nUFY1SjFiVHkyYmN3QVFMRGZvZE5Eclls?=
 =?utf-8?B?M3k3QU1sOHBZVU1hOVlJRndWSmI2SkcwWDh0ZEd2YkpLMHJYN0dEaEs0SlVJ?=
 =?utf-8?B?cUxVUjdHNzR2V0ZrSUQ5THI1NjVWdksvWWdURXA5SDd5dXFtdFMvbVhKRDUv?=
 =?utf-8?B?eElRUGdBcFc3VVBDUlhBL0srN09rN2Urb1BiakJKRHpVNGMwbCtYUmI1TDAx?=
 =?utf-8?B?dlNra09NcmZ3RS9rdzVJajhRb1E3QUR3ZmxaS1RrQ1IyUGo2N3hHRW92RTNw?=
 =?utf-8?B?TXhTdXMrSzJuVUtNa2VVa2plSDZtOU41dzlnbnVjRlhCalMwYW1hWVZqZmY4?=
 =?utf-8?B?VFJPejdhSDBuS2EwNWpOWlgvV1VrNXVhYkRiSFhaNlBIVDRkQ2FVU1VGbTEv?=
 =?utf-8?B?bGpxNXlWZFJOeWhqOGdFd3JrTk1SOERmTWVEUUxQRVZpV005Rm5TQjZJTXpW?=
 =?utf-8?B?MmZaVVY3ZVRsbkV0ankzempmbm9oVFRjQWJnWmd2OWtOUHVld3Q3YlQ4TDhr?=
 =?utf-8?B?VkhreDg2QU9QUk9DcGRXWVQvdmwwSGIwc0RGQzFvcnlhM2Rlc2dXQnh4Wkpw?=
 =?utf-8?B?SE43VHluaUJyVVVZL1l1cFJ4R2ZhV3dkR3g4aGUvOEhIeU1NdnJycktPZVd1?=
 =?utf-8?B?YksyZlNFVkxBajkrT1JqSlpxTHdDNXF3QkVHZzVhZDlzNEp6VEdxSFUrRm0y?=
 =?utf-8?B?MlpqMWNVcjRTTGN5bGc0Z2RkRUowZ3JSOGlGWGgvM2FuR2hIL0VnNmJPQ1kz?=
 =?utf-8?B?TjBaVTIzRm9xeUNQZXB2aklJSnVBOEdBS3JlNW0wRkNsSW5vYU1Zc1Z3dkNv?=
 =?utf-8?B?cytwV00xNjNHNDFwRjUwS0JVL29neExwMURlUXN2blM2anRQa3lUMk8yUVNS?=
 =?utf-8?B?N3R3K1lTRE5ZRUcyQVpnL1FCSm1EYnIyQi84bGZOVmR0OVFDSjExeHNXaVFG?=
 =?utf-8?B?aVk5bk1XTUNsTTFEY3E2QkZoK3JXOGJyRDNMZEhzMVVPQ2Z2RXFEa2hRMEda?=
 =?utf-8?B?MlJlN2pDL1dqZjRyUjhXbWpldTdPajZkL2tUV1BGODRMTUovU2d4YlhTN2RK?=
 =?utf-8?B?RFp0ejRPVllZbWFTWEJ1aEdQY3A3am5VTHd1cEYzcEhQL1ZCeTQwaDJKYjFm?=
 =?utf-8?B?dlZhNFJFZjBNcWFOOTZJQ3plWlVzR0FwTnprTEFOYWN5RHlteFBJVlBvVEpa?=
 =?utf-8?B?c3M3WmpMZzRQc2hYQ3V2ZzBxTEdXUlJKV295bHErS3E0Rk1RR3hzMlhtMEUw?=
 =?utf-8?B?TG0yTVhXQWMvU0MvOGxrWDZRSGlZZmNwYVBFTDQ5OFZJa3dwZ242NTc0amdi?=
 =?utf-8?B?c0E1YmVBaTF2aEdieTIyais5VmNNcVdROVdYdDZ0RlhXcGJjeXgvUFVFVEZH?=
 =?utf-8?B?OWJMVi9JQkN3YURueUZyM1VnN2RLOHF6QmtSM2czQU1uM1RBQXRtWUM5TkRJ?=
 =?utf-8?B?bUNFcmZpNHFadlpOd1h0aFhad1lJaDJBcmg4OEtCK2RjUXA5YS9QVVR6T1VF?=
 =?utf-8?B?WXA4UE9uMTNtd0d5VE5kVVlUVDJsVjVNU2FFSXZxRU56NExKUkFIRStXWU55?=
 =?utf-8?B?NTFydFEvaUJqOXpQR3pqUEJkWFl3MmZOajhsU3Urb1FsMkZ6SVhCdTBpRkk0?=
 =?utf-8?B?VjU4YWExMktBSmI4T01KdzNKT0FSRHNia2g5Qmh5L0h2NEVCaWRKVzY1SXhm?=
 =?utf-8?B?WXR4TEdHdjh5dDhFNkZWME1BejhHaTJuQ2x5cGpVNVp2ZVAvMVlET1ZQTVFW?=
 =?utf-8?B?QnlwUDhmUmN4VFo5MzBUVTRoa1VHUSs5SzhWZFBENHk5Ny8ydW83QnEyWlRS?=
 =?utf-8?B?bUprYVBmWmRrQ0tVeTkxZUg1Y2xYZGkzdm1vSVBmTkRoSVZ0MVFzRWVNK1N3?=
 =?utf-8?B?QVk1NFR4VEtBRGp0T0FWL0dWUGlpUFN4NklCT0p2SHFZbElNRDFBcUY3eDNm?=
 =?utf-8?B?cHgwNGFyZkptbW1LdG5Cb1RzSFFVZzhVek9uZU4yOFhsY3VoSnUvb3JTWlhE?=
 =?utf-8?B?R0o5bFk5T2lFWk1OQStnOCs5bi91TXpENWxyczZ3Uk11OGZGSlp2anp5d203?=
 =?utf-8?B?MFZ5anlmTmlMbytqanBIQWU2dEtIMm05RlViN1R2TUZmVUNSYi91MkY0aE0y?=
 =?utf-8?B?SzYyMEsxTUE1Qms2UTlnM1p1dklmTG5NZDhlYzZmekFvTkhVZklpQkd4V29P?=
 =?utf-8?B?dFdXQnczZ0ZOVUs5UmZlRndqcHovcjRlM3QyYlY3QnZROC9IV2h6QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b862c3-fe0e-4a48-545b-08de4e332a34
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 21:24:39.6598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+LhzKv13EETqVj96HRs1b7r+Pq6lLwWyuOaPcPQ0X7vk1yNob2iBevAb8gO3fYhi0kTFQuvYMo9veHGIcUuDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF

On 1/7/26 3:19 PM, Juan Martinez wrote:
> When the CPU frequency policy is set to CPUFREQ_POLICY_PERFORMANCE
> (which occurs when EPP hint is set to "performance"), the driver
> incorrectly sets the MinPerf field in CPPC request MSR to nominal_perf
> instead of lowest_nonlinear_perf.
> 
> According to the AMD architectural programmer's manual volume 2 [1],
> in section "17.6.4.1 CPPC_CAPABILITY_1", lowest_nonlinear_perf represents
> the most energy efficient performance level (in terms of performance per
> watt). The MinPerf field should be set to this value even in performance
> mode to maintain proper power/performance characteristics.
> 
> This fixes a regression introduced by commit 0c411b39e4f4c ("amd-pstate: Set
> min_perf to nominal_perf for active mode performance gov"), which correctly
> identified that highest_perf was too high but chose nominal_perf as an
> intermediate value instead of lowest_nonlinear_perf.
> 
> The fix changes amd_pstate_update_min_max_limit() to use lowest_nonlinear_perf
> instead of nominal_perf when the policy is CPUFREQ_POLICY_PERFORMANCE.
> 
> [1] https://docs.amd.com/v/u/en-US/24593_3.43
>      AMD64 Architecture Programmer's Manual Volume 2: System Programming
>      Section 17.6.4.1 CPPC_CAPABILITY_1
>      (Referenced in commit 5d9a354cf839a)
> 
> Fixes: 0c411b39e4f4c ("amd-pstate: Set min_perf to nominal_perf for active mode performance gov")
> Tested-by: Kaushik Reddy S <kaushik.reddys@amd.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Juan Martinez <juan.martinez@amd.com>

I think this change is reasonable, but I'd like to get Gautham's 
comments as the original author of 0c411b39e4f4c.

> ---
>   drivers/cpufreq/amd-pstate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e4f1933dd7d47..de0bb5b325502 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -634,8 +634,8 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>   	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
>   
>   	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> -		perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
> -		WRITE_ONCE(cpudata->min_limit_freq, min(cpudata->nominal_freq, cpudata->max_limit_freq));
> +		perf.min_limit_perf = min(perf.lowest_nonlinear_perf, perf.max_limit_perf);
> +		WRITE_ONCE(cpudata->min_limit_freq, min(cpudata->lowest_nonlinear_freq, cpudata->max_limit_freq));
>   	} else {
>   		perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
>   		WRITE_ONCE(cpudata->min_limit_freq, policy->min);


