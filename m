Return-Path: <linux-pm+bounces-13424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E678969ECD
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 15:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31201C23846
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 13:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B061A724E;
	Tue,  3 Sep 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RZfYj+df"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC551CA689;
	Tue,  3 Sep 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369272; cv=fail; b=LOK1HmHJ15sDxZFrYcMTlCBCKQQhsv1qP8dqJXm4YD1yG8zc0VPVopQrDfBRFba0vJ6FqJTqRUev8w5Z8LR1Xysj7f1mYW+Vss6dlsl6a6s9j2Spkek31NuAkggPnDF363ZXjQKtaWnG2N6w/zypX8bs2vQQgi3eFIliEihOJFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369272; c=relaxed/simple;
	bh=gervbDFeGsopKPvNf2Zm7tsa0oIT4HWnPhIf7YC93RU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tgl2gvgscOPNjDei5rMzvLMdvzdqkFAcR9LyEe5PfyhfqNA3e0KMdSYww1KmHCoi8cTEFnEWRYs57aksP6DWf3zKYy+7ILntpTS1iG/7LNbWTGIpzW2RwkNiwD53UQ/MkSLXOr6/dCrazktxFwXJEdAhfb2h9Tf1KK/lvMAY8nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RZfYj+df; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYuWdemjxC5HYmG+iOzHaPoXRphG38FTsqAqnEtix1jm2VyQMQXTxSDaKVeV/0n4iJbSTB7H11+XwV0Ukq+37rubBjSjpU+Z8aUmmVPHCG3xurEexXhs0blLr7ac3Hs7wp4DZFKPDQyyt/2OFuzXSc7hUOOxBrX8BjMDuB764/C4J4I6So2mW5k4di/e9JPbMEqd2gHe+JPuPofoitmy5RkS0yiG5WM8l2eEAvCCyBT9HGeIBbTaCq895aEUlmUIQzbt8KDWuxeW9Gc9Nzm6jmHvhEo207NAwGPiilE0iT3SMWxDjB7h/qG3orpdM6/jDZZp0SXtCj1wV6k1A+tQWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0tH1ddazRXSI7B1mloGEfJSCtaLVakufr7aIw0myA8=;
 b=PLFtJVZYkzXNUqiCIoP49C5UuxPzZ+II0NO5wIYULCe+zlYtfblAoYdBpjrbiea1cf2GTfUHda90ioofatzjMUcTP9LExLNhshGSCInrBrMnXgN0C65GBAs8M7S5FHGXbtMWyma9Abyx+EXxb8hu19smIQBb4azw1O2D1iGdzpfR4plNFCMZi1nCPZpOfa5rDwootpGiksPGVD1jJ0VsKUyk7JRxzhf//7scshi7XFxgR9leUJyh5A326s4WjRt/yJ24YVPSL+eH9X2+Uaxe+YR3ISaojAoJLeasHujHLpfeB76hh+cTFTknRAn+6rrPnbC+PhZlSWqWzbboY+FjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0tH1ddazRXSI7B1mloGEfJSCtaLVakufr7aIw0myA8=;
 b=RZfYj+df2rSvkYrmZkYd30tkBEOJuA07H8tOlivivBJazcNA9o5DbQPkvJ9a3cmkr2/G4ssKZy2y7WFfNoeHw8yfXbO9TXvq9rk0Taakumyy14x9wnOlK5SelXMPzxluBPN2F3EBz+1M4UQOW5uJMtsamXzlNcS+5WTOsmaIYzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 13:14:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 13:14:25 +0000
Message-ID: <bfb134a3-521b-49d7-99da-483a627e2feb@amd.com>
Date: Tue, 3 Sep 2024 08:14:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq/amd-pstate: Add an early param to disable MSR
 mode
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20240901050035.1739935-1-superm1@kernel.org>
 <20240901050035.1739935-2-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240901050035.1739935-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:806:21::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c079a7-52a7-4455-7acd-08dccc1a556d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L05nV2xsenlKdTdmRnBJWHdhUWZaQkdhcm1UTXBWZENDclVoc2haY2VDVmUz?=
 =?utf-8?B?WFJBdEFyaWZVLzNQUXB3L3dRcldSSlJOVGZoRWQ5MVM3ckppaGRHTjhuVTEy?=
 =?utf-8?B?M0h3N2JZZEYvVkNEVmdtYUZjbGkybmpNc00zdTFOczhDdnJEN1Q3dlRiMUpl?=
 =?utf-8?B?dDVHZnlXVHJaZjF2TnRTRXU5UHBMQ3RUaXIzdXpJdEVHWEx4T2VyZ2IyN0RP?=
 =?utf-8?B?SllRS1VEWVRQNWwyVEZUZHlyU2U5bVRQZEdHRUJ6WWMyNXZWNWsyL2VXMTV1?=
 =?utf-8?B?aEhJajc1NzJuNGpLZE9MMGhmVlJFRjJkbk0yeHV2UmVsSGxyS0ZlaU8zTVZB?=
 =?utf-8?B?MklhZmk0ZC9ydkk3ZHBSS29zdUNlR3ZrTDhsSTJvbnkzdCt1NTBLYk10SE83?=
 =?utf-8?B?ZFkzNjdQMnd2QUhxYXNsZ1J6RzllRmJFaFZHektnRTlFWjNSNjBWazRkMkYy?=
 =?utf-8?B?aDcxeU96NWhUSGNFcjFUa2tCRlRvYisxODlyU0VFRjN6S0huTW5pdTFxYzNK?=
 =?utf-8?B?NW5hSlY4SDZuUjluUEU3NGxKT0FFYWJVUHFwZmJGa245d2hDVVNnZ1pkZDlo?=
 =?utf-8?B?ZWx6cDg4ZGdyVVBhUTJuelpqeXpFN1lQV2cxZXU2bTNWbE1SandSQ2xmTGhp?=
 =?utf-8?B?RFFpNCt5bm9ON3ZhMDVUZnNoTldnb3FDTWt1bGtIS1ArNmZwVEk4dXlrWUg2?=
 =?utf-8?B?SStodFFwTXpuS1p0VEtPWWtBV05TckN0czFVdzBGeHZUbUwxeXNWditjMjZ6?=
 =?utf-8?B?cHJEaGRkeU9ldWIrN3ZHNmloU2s4MXFNQXcvbjVhVnN5dFpiY01PYzZyaXV2?=
 =?utf-8?B?blJzZ0xxTkZZTEIwQlBmcng1TGNBd0RrMm0wQ2w3VzJjNEptQ044T0hxMzAx?=
 =?utf-8?B?TFRZMlFLdmVhQ2RBYmY5VmJqQ1VPK1dCcDdJclpXZ0FwbFR3a2NrMC8rQ1Np?=
 =?utf-8?B?cUdJY2xXMGVMT1RQbktnL1lhYjNKcVVZeW10UW5NM3ppa3dqc1gvMlhIMkxX?=
 =?utf-8?B?T0J1bjVBNUNzalpudjZkMkRrd1k1bUR6dFh0RFlOTTdCYm5sMTZmOXlLV3Nn?=
 =?utf-8?B?N3BKQzQvSHRJQ1dmYVkreHBGdi94SWlzQUVaRmxRMVJoSjFaMkczMmRtSDVv?=
 =?utf-8?B?bmZYZW5MSkhwYnptWHJpbmpVUW1KZXZKTXhOY0NkbXZGcGt2UTkvNlpMZ1M0?=
 =?utf-8?B?MC9wQkcvcFIxZXNLeDlYa0dXTHJWVXhnSzF2b2VTSk5GVktXSkgvSWc3RENv?=
 =?utf-8?B?WE1HVjFXTUpOZjNFV2hWVEd3K2JldzA2UWpDUjNURkVaQjlkRis5cEdFS1lt?=
 =?utf-8?B?RTIzQWRLN3UxUCsxUnc2ajJCOTE4Tnp2cU5TNkVSbXRYMjladDJXSTBYT2lp?=
 =?utf-8?B?bXBKaUFBckhKbzZEZjhkWjdlZ2FaVUlHbW5idU9VRXBXU3hMWlN1NmV5eENp?=
 =?utf-8?B?Sjk5d1NqVWhjTExHdUR1V3VTcHdHa24xZ0FEbC9iZUdPcE1sRExaWXBQNWZw?=
 =?utf-8?B?OVI5MUlHbU9DK0pqTFBpYmhmNitQUUxGS0d2VXpDd2QyWnFtYzh0WmZ0TTVP?=
 =?utf-8?B?WVE2R0dNam1rTlNRMjZXNnVlNmZEOE9tUms2TU1zTldWUFl6SlNYNGM0dnJ1?=
 =?utf-8?B?ZjFvaVZMQ0QxbHhiUzAxUnNDSkxYRkkyMGg2MHZqeDgyQnNUTkRza0ZiOXpR?=
 =?utf-8?B?QU1CWUQ0VW9pQzZrZ1V4eEFlNk9VSkpTMmFsWGV3RzJFdHBoVE5XRkZORGZN?=
 =?utf-8?B?TDRFVUhEK0dIUlNHR3pISG9PZE9jcXJhSWNEZmJNeUJDOEo0ckcvRU1CWUly?=
 =?utf-8?B?M2J4UnhKNjhCbG95bHAvZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzVsU0dydU9pb2lNcWlMdGlBQWowTXErR1pNR1ZsUForalpMK0JBVWw3YWtW?=
 =?utf-8?B?VVJvN0RUUWV5aFVGMXp2Y1VjWGEySlhpWStWem1sbStyVkx0dmJGY1ZQRnlG?=
 =?utf-8?B?N2pxOERJMUpuYWl5YW02SEhJV0JNS2Y5aXlpdTllR3F0bjM4cGxSV3JPazgy?=
 =?utf-8?B?UVZ6ZFVpaWs4bHR6VTI3Yml6SWJRRHFrR0hUM0pjVHdJVit0cUtORXgwWmhS?=
 =?utf-8?B?aW9jR0JUVnNSRTVDVEptR3VyQjk4NkJaLzZ6RkxpangyTjlDQXF3TVpGTUk2?=
 =?utf-8?B?ZENFYU82WlA1YUxxWGlnWWt0WVVwT0pyaWhSWEg2dExFcXpzeTBneStkT3oy?=
 =?utf-8?B?Nm1yY1B2MitqZlVOOUcwcUVtazROcklOZ09SaVZDUXVaeEtJTFNKZ2ZiWWZm?=
 =?utf-8?B?bk1GOXNpZDJZQ21zK1RWeDBnUmNod3lObmxTckQ1cFM3Zzl6TWFXMXVsZlNZ?=
 =?utf-8?B?VlNGUEZlK2FmdUJ2UlFMMUxwdlV2dzhXVHY0RHltWFlsYzVkU0ZWb2VGWHBw?=
 =?utf-8?B?enIvQUNBWXRZWmFHNndSSFpKMGJaRStKbEdvdWtDbzcyTXdodkZHd1dLV0po?=
 =?utf-8?B?dWpIM0l2MjVtVnNodXpjd3NDWnpHSnlHL1dxNXpwSlUzZTErS2JlM0Z5d0Ru?=
 =?utf-8?B?UzQwbEszRXJ0cjJPTC95T21MUHhuYnVtd0ZGbmUxbElHU0J0dDJnbWNXeDEr?=
 =?utf-8?B?UTgvTnJHUVFSVFRKQmcyUkRjT3ZlemxqQ1JtNm9kUGZsUTVXMU1XT2hFYjA5?=
 =?utf-8?B?MjRwY21yamNyR2JYUUZHbXZuWU1MODJPcGF0K05wYUlJQkhxUWdiRlFEdno4?=
 =?utf-8?B?V3VVV245Y2QybnpOa3kzeEJUblVzdDJ5TkdQcGdLc3A0MmhTRjBIMG5FYU1l?=
 =?utf-8?B?TDN2My9VVG1oWWdZalFEL200N2ZXTzMrQmpuOUN2Q1h6aEdYZm92V3N5MWo3?=
 =?utf-8?B?UTBPSGZ1UU0ycDRldHNvZVBZRVhUY3o5bXMvYXE3V2dsUXNGR3FBMjhTblRw?=
 =?utf-8?B?T3Nkd2RUUy9obmtabnhQNUV4WWs1UVZoVlZ6WXZjWFV3YXRraDYvME9md2xB?=
 =?utf-8?B?Y0g1TU55bGJqS2xQOVRrTERpbXArWjc4OWNkdWxyUi9Qbk4zS1RaT0tIckpE?=
 =?utf-8?B?dWpqeFdNbmdXa012Z29wbXdNQmVLZVpIVnV0UjZnc24reFdwdVlOeFJ3SGZ0?=
 =?utf-8?B?MFJVYU0rV1ByV2VlTnNhNWdZMWtpczU1ZE9lYVd0b1VGWHhTc1NEQytxM1U1?=
 =?utf-8?B?YU5mZnBmMDdkMWROUDFqb0xCZmIya2dPZk52Qm9MR3kvQUs4RmQzUWRyR3FR?=
 =?utf-8?B?MDVrZjNoeXRKOHRESFFxSzRoOEc4MGFnLzBxME12eFlBSFU0b1Zuc0czTUFY?=
 =?utf-8?B?d1orQWpicVVaNFJSQXNXK3hlM0Z2dlNRajZKQXZPK3lHaGppdnYzVXdQN0h6?=
 =?utf-8?B?YllLdUxCK3RBZEIvZ3djNjhkdlVLMXZpbytjckIrRCtEWVhWRWZTa2FnQkpj?=
 =?utf-8?B?Si9Iakw5YXNXaE5BOUlNNE9QamdkYnRjVWFYSWQ0bFgyaHRMUjExVVJvdCtq?=
 =?utf-8?B?eTNwWmhCZFpPZENCOTE4ZS9XV3Q5VjhCbXBLV3puaTJXSEhqdWhveEVpa0dq?=
 =?utf-8?B?QjVGVk1aSkhoQVRKS05wSGdWeTZzSTJWUmo0a1k4NFUzR2pHNzdxZVZ2WEtG?=
 =?utf-8?B?R29tdWViRFByczVDUndNcWZ3aDg1bkRPd0xyQkNGemhQcFMrMjFqVG5BMlZv?=
 =?utf-8?B?eURPZXJ6KytueDk1SFRmSEROTGM2Y2RNZHRydWJnM2lKYU4vUFhVYnJWUEFz?=
 =?utf-8?B?TXhpdFNHb29QUE4wVVBoQUhqMFc0OGRWaXRwNzN3K1N3Y0dCOUNjWTRBYmQz?=
 =?utf-8?B?NlpMblFET0Q1RS8zcjZHenNTb3E1TmJuWERzQ1JZUGR2LzgwSVErYW1HWnZD?=
 =?utf-8?B?Tmt0T09nOEJzdFVTUFZtOTVFOXRSKzZJaGwzMXd1VlJHcytVc2F0N2xIYUpP?=
 =?utf-8?B?b2JrNkVWTWlCSFBsV3BiRUx1SHZlWTRtOUFXbElVdWV2OCtYdy84VVZYazZK?=
 =?utf-8?B?U08zcm1acjBCYVdkVnpZVXJLVUZzck1XUmptanJhSDBacFRpUE9qTEpHU3Az?=
 =?utf-8?Q?D5Nx/k1AwtSmXFYk2crNDOUB2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c079a7-52a7-4455-7acd-08dccc1a556d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 13:14:25.5875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0jQIwyVjSQGkGJKMPMxAMf9P2wOAiOBQssj+pe6aq0Dybh7KDhOZoPfVVRcBiUH/gVDFpBjazY0/Ytj15Sz6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863

On 9/1/2024 00:00, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> This lets a system that supports the MSR run in shared memory mode
> instead to help replicate and debug issues.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

After some offline discussion, will drop this patch.  Second patch will 
remain and I will queue it up for -next.

> ---
>   .../admin-guide/kernel-parameters.txt         |  5 +++
>   Documentation/admin-guide/pm/amd-pstate.rst   |  5 +++
>   drivers/cpufreq/amd-pstate.c                  | 32 +++++++++++++------
>   3 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 09126bb8cc9ff..041c609ed50ea 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -383,6 +383,11 @@
>   			disable
>   			  Disable amd-pstate preferred core.
>   
> +	amd_pstate_msr=
> +			[X86]
> +			disable
> +			  Disable amd-pstate CPPC MSR (force shared memory).
> +
>   	amijoy.map=	[HW,JOY] Amiga joystick support
>   			Map of devices attached to JOY0DAT and JOY1DAT
>   			Format: <a>,<b>
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index d0324d44f5482..b06632556102e 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -411,6 +411,11 @@ For systems that support ``amd-pstate`` preferred core, the core rankings will
>   always be advertised by the platform. But OS can choose to ignore that via the
>   kernel parameter ``amd_prefcore=disable``.
>   
> +``amd_pstate_msr=disable``
> +
> +For systems that support a dedicated CPPC MSR, ignore it's use and run
> +with shared memory instead.
> +
>   User Space Interface in ``sysfs`` - General
>   ===========================================
>   
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 93adde45bebce..89438a3654002 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -88,6 +88,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>   static int cppc_state = AMD_PSTATE_UNDEFINED;
>   static bool cppc_enabled;
>   static bool amd_pstate_prefcore = true;
> +static bool amd_pstate_msr = true;
>   static struct quirk_entry *quirks;
>   
>   /*
> @@ -187,7 +188,7 @@ static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
>   	u64 epp;
>   	int ret;
>   
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +	if (amd_pstate_msr) {
>   		if (!cppc_req_cached) {
>   			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>   					&cppc_req_cached);
> @@ -260,7 +261,7 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>   	int ret;
>   	struct cppc_perf_ctrls perf_ctrls;
>   
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +	if (amd_pstate_msr) {
>   		u64 value = READ_ONCE(cpudata->cppc_req_cached);
>   
>   		value &= ~GENMASK_ULL(31, 24);
> @@ -813,7 +814,7 @@ static int amd_pstate_get_highest_perf(int cpu, u32 *highest_perf)
>   {
>   	int ret;
>   
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +	if (amd_pstate_msr) {
>   		u64 cap1;
>   
>   		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
> @@ -1058,7 +1059,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	/* It will be updated by governor */
>   	policy->cur = policy->cpuinfo.min_freq;
>   
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC))
> +	if (amd_pstate_msr)
>   		policy->fast_switch_possible = true;
>   
>   	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
> @@ -1288,7 +1289,7 @@ static int amd_pstate_change_mode_without_dvr_change(int mode)
>   
>   	cppc_state = mode;
>   
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
> +	if (amd_pstate_msr || cppc_state == AMD_PSTATE_ACTIVE)
>   		return 0;
>   
>   	for_each_present_cpu(cpu) {
> @@ -1524,7 +1525,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	else
>   		policy->policy = CPUFREQ_POLICY_POWERSAVE;
>   
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +	if (amd_pstate_msr) {
>   		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
>   		if (ret)
>   			return ret;
> @@ -1612,7 +1613,7 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>   		epp = 0;
>   
>   	/* Set initial EPP value */
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +	if (amd_pstate_msr) {
>   		value &= ~GENMASK_ULL(31, 24);
>   		value |= (u64)epp << 24;
>   	}
> @@ -1657,7 +1658,7 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>   	value = READ_ONCE(cpudata->cppc_req_cached);
>   	max_perf = READ_ONCE(cpudata->highest_perf);
>   
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +	if (amd_pstate_msr) {
>   		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
>   	} else {
>   		perf_ctrls.max_perf = max_perf;
> @@ -1691,7 +1692,7 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
>   	value = READ_ONCE(cpudata->cppc_req_cached);
>   
>   	mutex_lock(&amd_pstate_limits_lock);
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +	if (amd_pstate_msr) {
>   		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
>   
>   		/* Set max perf same as min perf */
> @@ -1936,7 +1937,9 @@ static int __init amd_pstate_init(void)
>   	}
>   
>   	/* capability check */
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +	if (amd_pstate_msr)
> +		amd_pstate_msr = cpu_feature_enabled(X86_FEATURE_CPPC);
> +	if (amd_pstate_msr) {
>   		pr_debug("AMD CPPC MSR based functionality is supported\n");
>   		if (cppc_state != AMD_PSTATE_ACTIVE)
>   			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
> @@ -2002,8 +2005,17 @@ static int __init amd_prefcore_param(char *str)
>   	return 0;
>   }
>   
> +static int __init amd_msr_param(char *str)
> +{
> +	if (!strcmp(str, "disable"))
> +		amd_pstate_msr = false;
> +
> +	return 0;
> +}
> +
>   early_param("amd_pstate", amd_pstate_param);
>   early_param("amd_prefcore", amd_prefcore_param);
> +early_param("amd_pstate_msr", amd_msr_param);
>   
>   MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>   MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");


