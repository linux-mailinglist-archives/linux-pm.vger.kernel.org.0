Return-Path: <linux-pm+bounces-6813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3738AD08E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 17:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE071F22CBC
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 15:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127BB152E00;
	Mon, 22 Apr 2024 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pUhoMSZf"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677DA14F10C
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799520; cv=fail; b=Didx05pfNBcFZMg8sTPo8ldbgcqRNBKTNrtBFeFQJ9eB5vtS1bZVhv5IwBaOSiGH8d67mMly3kqy81ISMEWr4dHngofv8udMmMTaVDsRa3vKMQOoT7+1JwY/XGwHhhJ+iqoZ/g632bGvmzNjgb/EPQVZ0jpqY4fQ8ZGGpFXMnVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799520; c=relaxed/simple;
	bh=CfCfzUqpY+4x1bxZvjQhZAoSNu2Xwv4Tnt0HG+HyEuI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UUVEIBchyPn8KPuTlXvkb38/wtvyFc1lUG5j1jL5qBJNFgUcCKBhxgYKOy9/4JHCj1RnoD8nUfIEUSDdNW3tQ4wn1jx/Kt9rFoUvZTcDxlpkrU6u7Rv6HWjqh6N6G6cP5Psf+gVTQKMvMvlTHKHuOlK0FhH3+j3LVN/WBX9nrds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pUhoMSZf; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJcgxoybQYZwCuxhdGCCA2kLTw/y4MH62J2L1r4xroSAes0d7yBCBp8ef6yVokOQhropeOspve+Xfb46xxXtLfEWCiF2LLx1316s8TGrRSoKpkHDKk4FOg9PXN7GTur/Uwbt/DD/axilBl75HUc8l6cfEr02Oy4wwiSooqsdVPzEpvQsvKWzKAndxSkMvxLB9KYj4jgqqIZAkJIvmfN2niF5r6Ytdmb5DqtZhQESY9CCETahVIUhfBLjbm1wfqY6cciMs2jn71pV5PT6IJ35nMjtyE7kMjgQv+guVGP3lqOSsvY4E5k+SsRrQsBJZE0n2Ay/zczwICzoMHTv+2T++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uXqSahPx1bDjmT18YPG+E7Y+ndhmTrLmuzd0p05qLI=;
 b=c9EVH1u6Y9obvyxnYETXtuBskXknKJanttMQv93lX4FgwTx5V7M5IWZhScJ8xSmbhwW+M9iguo+ABRgt08kmfMH+iq2AmdKPtM55bSAaCIVzH7eCV4Rrc6PI2qb927BNZ83ydZXH/+WpU5K8V7rdyEG2Uhi890D8tmZqRm0noDvB28fJ+dPqpBRt3Zg0FWMakLvMP1SK6YH4r+jbuCkPITsVgeNFttBxKiQOKbwd/x1tGpwQDPLLzPiDYuYQodVD1pvbbU/PNLHSrqpxrfCWu53ZUWzrtPKe3j7wIHIe2LDtLd6hiPOH/kB7CzNNmm8lwMwm47ayWxQiCUMYgVIZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uXqSahPx1bDjmT18YPG+E7Y+ndhmTrLmuzd0p05qLI=;
 b=pUhoMSZfSs3bvb70iTDt4YNEyLDiKKkah43dFwsr5A8wp5AZ053hSU0NiWUQ8MAzIQ9PgYp9FlrD+eNL0Yfy2hdRdWR5Khk/fwCqTkJ/FD/N3cBq8uvFfqK4i4EigYo9xBFBMgHCTlZ8fQt9Xqg8uiL1yBoFKQEL0XWnuuISNSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8333.namprd12.prod.outlook.com (2603:10b6:208:3fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:25:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 15:25:15 +0000
Message-ID: <7b739eb8-573e-4479-9225-be3d2f4adbff@amd.com>
Date: Mon, 22 Apr 2024 10:25:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "include/linux/suspend.h: Only show pm_pr_dbg
 messages at suspend/resume"
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: xiongxin <xiongxin@kylinos.cn>, len.brown@intel.com, pavel@ucw.cz,
 linux-pm@vger.kernel.org
References: <20240422093619.118278-1-xiongxin@kylinos.cn>
 <37847b26-1c1e-48d3-a74e-bd2bcc6e1fda@amd.com>
 <CAJZ5v0gmF0Lcy_nHSvTDnu4C3N0mipaeJqHff=00fgWdtwOzMw@mail.gmail.com>
 <2888cd41-65d9-4832-a913-399a074de7a9@amd.com>
 <CAJZ5v0ggFGSsPKWxowqn89WtLbmXVjUWZvc5KO-ab-UZHagR+Q@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0ggFGSsPKWxowqn89WtLbmXVjUWZvc5KO-ab-UZHagR+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0100.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 984c43f0-08c7-42f8-669d-08dc62e06924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1pPVUNFT050eG9SWTJmUjdoS2lHdkVDbkY2NHd6OFJlK2V4azExVWN3andk?=
 =?utf-8?B?OWYzVHAyQXBIbDRWSDd2L1BleGV5NHk2a0FBWGd6bkpsdkJMMHI1WnpwRElr?=
 =?utf-8?B?VFdlK3hFZk9NQmpsVlBKNXhrTlFDZW9STlc1N2wvYk04YjBDV0FQQ1pWakVj?=
 =?utf-8?B?aDRINjdjRkpMSXlFU2NQMDR2anJxbldBM2NHZ0orYU9DTktNaTFGNEpHNksw?=
 =?utf-8?B?UnYzSHBRL2dFdFJKaEttaUhoRlBMcFZORER6Ti84VVRTemJZVVBGbmJ1emhU?=
 =?utf-8?B?Y2c3YjN5STJRWmpkUTNEbDd4TWtWSFA1am5NNnYzdXZUenFkcDRxY2FtK2JJ?=
 =?utf-8?B?MXhvR3lBOENLdytNU1hJcDVTRmFsTkRKTTZxK3B6VUtOTlNUZm9kK1VmTlhM?=
 =?utf-8?B?c0NZamVBYXVSRnBBeTV5NGlRWGpwMzZqT2w2S3BTUlQzN3J4NDdQb29iSENS?=
 =?utf-8?B?Ly81djluNVN1SXhsTXZCczFRUkRaRXBJeHlPRXZMc1VUaHFIT0ZOQk5WZk9R?=
 =?utf-8?B?MWROK2FIdUVOVkMrOVZ1c0t6R0dhRXZFM0oybzNJSDRQTVJrU3hiUmhSSWtt?=
 =?utf-8?B?b2tmcWMxRjhKUXl6QS81OFE4Mi9kZXJWNjNLVDIxS2xteTMzWTRSQU1ySHFx?=
 =?utf-8?B?N3RiM3BDWFpZYU1VTzVyNWx1S3FwV2JPZHRSNlhOV2FRZjBoQlY5ZjR2ZUFD?=
 =?utf-8?B?amtCaFlMc3dMbEJ1OXhLV0JHQlJxNzE4Y291MHUxcVhyVHpVSllOZUJzNkwv?=
 =?utf-8?B?NnJqVTR0NTVwckxsRlR1NzAzT3JncjBCMWhqaHQ5K0RnT0tOZFQ4S1pxSEpY?=
 =?utf-8?B?WGFXblhJcDRwNllVTzRBSllKRk83Mm9vWGR0ZklNcVZ1NTZRZk53Unh2aDV1?=
 =?utf-8?B?bFNyT2JTYllHVjZkS2crNmQ3cSs2LzNwbm92WFdsNCtSOEpKYnZRSWRkSTJn?=
 =?utf-8?B?MFhibXNRd2paeklzc21zaDE4dmhabU1IMFhCSUUrNWFDTzNibjRBZ1pHSmlX?=
 =?utf-8?B?ckJqVHJPMCtBU2N5T3ZSU1ZjRVhkcFZZaW41S1kvUzkrSXUwZi9aNnZ0RU5l?=
 =?utf-8?B?NW1YQTVQZzJaNE9BUXRSck5oQmV3ajZWaU1JMUIrMUh1OFFCNjM4N3JqbjhW?=
 =?utf-8?B?QXNlTVNFbXVvNzFNT0N2RDQrRGliM2l2dnlreVZsUkp5MGdoNVRkNlhnTThN?=
 =?utf-8?B?Qlhwa0ZUdFNxYXc4Y1NTaFpXOWJaTHNoeVBjZ1g2ZmZaRElwaE5yeE9vbHIy?=
 =?utf-8?B?RTB1Mk1WNmFCQm9TU2IxK3A2T05pa3pZTmV6OWNhdjZ4ckFBMURmWERVNHl3?=
 =?utf-8?B?UXEweDRRVDJXbUs0U05YVXQrV2RtcnpOdmNoTWpUV2RyeXJSQnFTVnF4QkYv?=
 =?utf-8?B?M0xZRnhDcXJZUE5PT2hCanF4cDlZU2J4QzU4ZzZOcGpqQ2VGTHYzeEQwWEVZ?=
 =?utf-8?B?VTBYMXRQbkxIbUl5VzFUNTRXWkdkZ2VyZTZhdjdlUmd0YjFSQUtldWZBbXFM?=
 =?utf-8?B?SzNzTW9WVkFVL2lVVVBYNlZrZlZ6bTdZUU5wWjFBVmRFNnpWb1kvQ3VyWE1v?=
 =?utf-8?B?T1BTdDJVSFZoY3BkTnhsZ0NVN05mczFVT3FweENsSFAxS2RyYWp3V2hxU1pn?=
 =?utf-8?B?MXdURlJvRUtVTlF3TzYrVmdHZ0huaXZUWXdCQnlzcUpuNmN6NmEvTDhHRzEr?=
 =?utf-8?B?VTFTam5UdVlINkFwRnFnbHliWk5GeEtNV29DajBGWmdkRlBwUitWYTlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUlVUGRteGNyMC9GSUdyRmJuYk9CczVxNlZyZzFVMHV1bTdMNG5nK1JSdTln?=
 =?utf-8?B?T2RIYkRNdU5Zc1RjLzFSTlg4dy9jNnUyVXQwbitCWnVuWVR2VHBUV00yKzVG?=
 =?utf-8?B?QjQwMWIrYnluRzVxM2h1dTZLM2YxeFRwakRjNVlPc1JycXppbWJVNVRJeVNG?=
 =?utf-8?B?TURQVzBmOG8xaTBKSXlwamlCUG4relM4dE96dVNGdWl6ZHFVM24xTGhqWE8z?=
 =?utf-8?B?Mnh1SENFNkdCQ05EekFjVVJyTkZiV21rWW9qNFZhRm9OVjMyemNhdklkb2lr?=
 =?utf-8?B?TmZCemNGdDFENnBLWE9HbUkrZmpqcXhCbUxxTU9OVUFsQzAwc1FGZEp6QVVy?=
 =?utf-8?B?WmN2TU5XNXk5ZkVKWWtIWTdvc3J2R3ZteE5oaGtJZkJSaHgzS0Q0a3VKOVMv?=
 =?utf-8?B?TWR5Y09MQlpKZ3dEbzlidEZRRERjMUt6WGZMcUxqNDRKeXJJMDk1K2pPWS9E?=
 =?utf-8?B?UC9nZzNsV3htREM0RVRkYjh6ZXF4M0lZV0dzS0RYMW4wd3VvM3QxdHNaMTQw?=
 =?utf-8?B?c2IxSkFaei9KdkcvZ1NLLytlTHlaQktyZ2FyTHg5ZU5SaXl0UmtndkY4NWo0?=
 =?utf-8?B?NkdRenhPOXY4S3ZFRi8yR0xZOFF3TlJLUnBtbzFHMmlnOVliUjVEQS9XL2NB?=
 =?utf-8?B?VDlwQU5BekdiYU1kelFBQjdLakpjT2FxaGF6Vjk5czFRZVh3NkoyNGFrOHNM?=
 =?utf-8?B?U24zSFhKbDEwOVg4VVllMVgxbTB1M2xKMCttNUNJQ2tzRFpxa1VIOStLS1Va?=
 =?utf-8?B?RTBNZEJjS0lrM1hkNU5QeEdnMTlBRUo0dG5rT01PakUydkdQZDkvOGpia256?=
 =?utf-8?B?RDhOd25tUVlWWlorNVBqK1oyUWVhVTVzUFJWcnN4QjVDMkVtVlN3SFNaVFpM?=
 =?utf-8?B?WS8xajhucit1TUp3TTNFUUMzK3gxeisvS0VBbndpY0NsS1AvNXJhOFM4d3dC?=
 =?utf-8?B?bm1pbW9IRzJSVnlXblk2YTlMZkFmWmRZRFQwZlU1R3Z4ZXkvSFF4VGREN01t?=
 =?utf-8?B?S0l4NU9JUXVMblJ0UEo4Nmlqb0NqSC8weE0xTVlFZjJ4RkJnTXEvMTBwNGdN?=
 =?utf-8?B?VHpUU2hCVUNjREMvSWZEejlyeGRsbEJYbEVIOU43ckZKMlVEdEc1cFZuSm5C?=
 =?utf-8?B?V3JaTGJWT3c1a2xBQVhLTERiMUo5a3A1OTZzUTF6WXlZeDBaRVkvVzdNOHEx?=
 =?utf-8?B?ZDRDZ2RKcTBlQ201cU1UdFJkemltdGJxQndyYjB4TTA4V3JuSUtNaHRmUmts?=
 =?utf-8?B?bjU2WkVyVUdpNWthMGU3T1VXZVErdTNPd2Yrb0tyRDcyZjJlSm1WZFdwMVpp?=
 =?utf-8?B?OG5TVHpIQmJGb2xFdnRYVmRUY25NK3lIMGNFNE16MGRjRUUwT1IzSDdITVBr?=
 =?utf-8?B?VEwzWlB6NjZYWmZrVGgyVVZvOGd6NHBOOHRZYVRMYVVqV2xLL3F2cGs2MGJx?=
 =?utf-8?B?MWVRVUd6SDg0aXJub05QalZXNFMxZFZxUlFtaWhmeStLWmg0VWp4anhEMFFG?=
 =?utf-8?B?L3E0MVhlS3NCaFhvQXp2Zklvam9NOHFMbnQ4bkRpdFUwdkNxVDdYSXFzcVNC?=
 =?utf-8?B?cVZ0L2pOelJRV3VTa1YzZjRTZTc3K0FGYWo0M0doWlV0cmN0OEtaVlBqTUVp?=
 =?utf-8?B?WkxBVGYyMnZySEV2YmE4QVVKM0ZQbitlYnI5Q1F0ZndsV1JBYlMzOXYrU25R?=
 =?utf-8?B?MWZUMEp5YXNtYXJsajRpMWFERzhuRitXcmJ2N29JeEJZRWczVGVYTGF5WDU1?=
 =?utf-8?B?cUxjNFpLZWh3WDRZWFp4MndlN1NZZjA2VU9taEpld2RkSytVTVB4cGZvYTRN?=
 =?utf-8?B?eGFIYW1GbkFIWVZZWGZrTnFwTEM5RU8wd0o2YXJYcXlkK0lyQm5maU94WEFt?=
 =?utf-8?B?aUhuZFNybEJkampQTDhBN3V2U04yOUFER0JlY1lxeUdRZVdGbnpyeWxrM0Y5?=
 =?utf-8?B?ZzQwaG1hamJDRlZySGVLZ2tMdnhrRG5sUnFwQnh1MHBSRXFXM0wvODZpNnBV?=
 =?utf-8?B?OUg2RmpZbllpbTNGS25MTkFrUFl2RTkxU05mTEQwcDNPdDF4ZjhTaFVxcGhm?=
 =?utf-8?B?SjU5R2lnenVQMjVtMGdwSXRwa0h2MDRWY2xpOW1xUFM4dENsVjBwbXREc056?=
 =?utf-8?Q?Sys6NYua//81C/XUCPG8g7SVb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984c43f0-08c7-42f8-669d-08dc62e06924
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:25:15.7782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w74hPaz0mgG6OBn07vS7IP1G8ioIXDoDdFsx5quH3dn/Mq8GJ4i3kmDcXNmXzsTBp7u75GtW6fOdahroyGX5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8333

On 4/22/2024 10:18, Rafael J. Wysocki wrote:
> On Mon, Apr 22, 2024 at 5:02 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 4/22/2024 09:45, Rafael J. Wysocki wrote:
>>> On Mon, Apr 22, 2024 at 4:33 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> On 4/22/2024 04:36, xiongxin wrote:
>>>>> This reverts commit cdb8c100d8a4b4e31c829724e40b4fdf32977cce.
>>>>>
>>>>> In the suspend process, pm_pr_dbg() is called before setting
>>>>> pm_suspend_target_state. As a result, this part of the log cannot be
>>>>> output.
>>>>>
>>>>> pm_pr_dbg() also outputs debug logs for hibernate, but
>>>>> pm_suspend_target_state is not set, resulting in hibernate debug logs
>>>>> can only be output through dynamic debug, which is very inconvenient.
>>>>
>>>> As an alternative, how about exporting and renaming the variable
>>>> in_suspend in kernel/power/hibernate.c and considering that to tell if
>>>> the hibernate process is going on?
>>>>
>>>> Then it should work just the same as it does at suspend.
>>>
>>> Well, this is not the only part that stopped working AFAICS.  I'll
>>> queue up the revert.
>>
>> I just tested the revert to see what happens to other drivers but it's
>> going to have more collateral damage.
>>
>> ERROR: modpost: "pm_debug_messages_on"
>> [drivers/platform/x86/amd/pmc/amd-pmc.ko] undefined!
> 
> What about removing the "pm_suspend_target_state != PM_SUSPEND_ON"
> part from pm_debug_messages_should_print()?
> 
> This should be as good as the revert from the POV of restoring the
> previous functionality.

That would probably help this reported issue but it's going to be REALLY 
noisy for the pinctrl-amd driver for anyone that sets 
/sys/power/pm_debug_messages.

There is a message in that driver that is emitted whenever a GPIO is 
active and pm_debug_messages is set.

It's a really useful message for tracking down which GPIO woke the 
system up as the IRQ that is active is the GPIO controller master IRQ 
not an IRQ for the GPIO.

But if that change is made anyone who sets /sys/power/pm_debug_messages 
is going to see their kernel ring buffer flooded with every since 
interrupt associated with an I2C touchpad attention pin (for example).

So if the desire really is to back all this out, I think we need to also 
back out other users of pm_pr_dbg() too.

