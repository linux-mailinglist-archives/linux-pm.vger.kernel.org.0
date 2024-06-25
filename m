Return-Path: <linux-pm+bounces-9959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9B0916C6D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 17:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C8A289326
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B91517C7DC;
	Tue, 25 Jun 2024 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LVvzE6lz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C8517C7D3;
	Tue, 25 Jun 2024 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327910; cv=fail; b=WqSQVU8quwv0MbMtp9uAG4XKiO61iHxi/PPiCU1S4+U3WHz+630BVPPeHBGtHH4wM3Lb4QzouFoJAH7rxls2f2fnkWzfHQiAtnWCJFovBgeUn8jU4WAYIgbXKwlFu3JsspW6vKOewqswaex7nchdVi52HHZklER3wDkbbvIiANE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327910; c=relaxed/simple;
	bh=MFwjNMspgzQCWGvJtP5tzT/BVR0p6YUDExx957KL23Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J0zs5qktQR97s0+L8cTZsvnk4dCkrkpoc7107X9NvNX/gtmesv7B1LEEjIYWidqZAp62w3b0LxFw08S3PiBgYSG1VSNuYMkimLwmYlKu8ptKczu2mnADYt9lZdO3yI7OrQPWjW9758xsqGau2+Fse1+E5janGINHqeG0EQrlNpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LVvzE6lz; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSKb5IGZfv2GvucIpllnVV0APN8Mz8Th6yOxteO/HYX3RCSzkJG1xv8UApA/Gma1LU80kyBiyjbu3XQUkmTpfQOFD/Uv9Hm3lE+O0dwC1Ln5xaP6R5G0kE1GNSN8xsDHDC9G/GQJ5tB7xyj6BeNU9ehOYTnW2icYZdMA58GTAiMorfB6aQWZ+zM6XTe7kOc+C5XuMjo7Oi/x8tRucIB7qNn/7dUBdCyz1HT8PwF4vjgaE6A9HuDvfNAFXMX1BuH3eBHKUQtRhqwcdc4ImbQ0MShxezhBTF87UndOe1S6R8T894shTDD/egI6In+YHf1FyO+yDvygtdsI+/nhDOKkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEMXsrfWfwIT87sUSLDeDEliXCJRmsOxC6n4bq/y8i4=;
 b=Gw6HaH9GHJzZ82LY+hroWNQffG3ZWfBTF63E7IB7MHCdD3MVNLf9fPwdiz6ywhxpq6YUJGDhGqQDNdu7iRFVurutOe1+mtss5u6sJM8ru7v0uJcNoBeiUlzlyvVl+MUJJs5BgJJDI0pZaqNZE5C0s/QBYgnBvgOajhPBs1e3HiEYiau+aRwE52vJpIYCXbfit+sDIpr0wgzZRswL6rI/n8JGuWxKLj1LVLduTR3xXVW/28SY8buFgUjSERfMlBrYw2Wv0NJ5VAgp4Hf11FlXmQEQZn5bnlOzeK6wm+X4F7DHInqtMZw7XcUnGYhf2ZLOHLtdD+QsZgvTDXh10bDXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEMXsrfWfwIT87sUSLDeDEliXCJRmsOxC6n4bq/y8i4=;
 b=LVvzE6lzaUpXZk9AiIYv6AnPPCx8NWnieS75DWwwAUf01ixHYr8J1D++X32bUhPHKL8SYvRFytCJXP6HamN84Z2o0BMaVkWYng14zaRmLr08nA1/+WvFjY0uwoFua+d7zl5f1NAxqAgFbQWq72Gq47cD6iuAxA5jLCjsBb4VJNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.30; Tue, 25 Jun 2024 15:05:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:05:04 +0000
Message-ID: <9ffb50b5-ee71-466a-80bb-42660d1fe237@amd.com>
Date: Tue, 25 Jun 2024 10:05:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq/amd-pstate-ut: Handle the inconsistency
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, gautham.shenoy@amd.com, perry.yuan@amd.com,
 skhan@linuxfoundation.org, li.meng@amd.com, ray.huang@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
 <20240625134127.4464-2-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240625134127.4464-2-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0142.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 508e6a4b-e66c-421a-0dbc-08dc952831c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0pMcUsxclFPTWNidE5mMjExV2hqaWJINzZtTEhEZGRyRHkvWWxEeEJsdUM3?=
 =?utf-8?B?b2dOUTNRa1gvRGsrb0w4THZHOGQ2dlVqYlFsTUFrT0x3S0sxTU5vQm1wSXJI?=
 =?utf-8?B?ZzZxTzU5UFliRFVWTWxKZStlU2V6ajVMbVNwVGpudW0vOGJGa3dNWE5NSFZm?=
 =?utf-8?B?T0xqeHlMSERoT2VsejUraE5DTGRwbkE1QW84QXJ6UGZQUkVhWnVYaHBXQ3Zt?=
 =?utf-8?B?c0hzYWEwWi9tZnJDMHd1QmJ5dFRJdlNhRXUxMjNKVnJoY1gxdERENmV6Qld5?=
 =?utf-8?B?bVZwbC9UVjdrSmVXU2YyQWRvMTByODdwTEsxMXhsemIrRTJiWWdtbTFZaWxj?=
 =?utf-8?B?Z21kM0VJZll3MGtwbTJoWmdaa2RpT01hUmN3MStyaVBVcDV1R3VKRXNEcVdV?=
 =?utf-8?B?SnZPSXFxTzk3OWVydnhrVlpMYmhMOXI0clRpYlptNkpnRjFxME94N083Q2ZY?=
 =?utf-8?B?ZEhtVlpUZkthYkJqMFZFZUVORERkQ1g5S2tuaGxmT1JTMGlnSTFuSDBmRzh2?=
 =?utf-8?B?UUo0dmdpRXUzdmp4d0UzbEFUTEpZWjhMRlZvVzlvY1YvWnNkNVlVUXBtS25s?=
 =?utf-8?B?VnovVllBU0Z6dzZjODVSOWllamYxb2xySW0xVmpwaDE3aEluVmlUc1VjZloz?=
 =?utf-8?B?d3Z1YmVSblV1eDQ3d2Y4M3lzUjRwSmN6ck92UjRYWXhRNUtkL2N1VVBRWitu?=
 =?utf-8?B?QnhmUjc2UThxOHYzYWQ2WWpkbXh3M2FreURJTGJRRUdlaDBkb0poY1h4WFhU?=
 =?utf-8?B?NGJzODBhaUh2SFBNUkxDMDNhbFpHTHdyR0ZndGF4MHpuV25UWjViaWpvYklJ?=
 =?utf-8?B?UE1XLzRiZlBCSXNKd2FJRG9IcURHT01ud0hRMnpHTXc3Q3VMak1ma3VuU1Y1?=
 =?utf-8?B?aDFzMWJpekxqMWpSVG5nMm01RFVPTXBoeVk4TjJnbEY5dG5TaXlsKzJLYjVv?=
 =?utf-8?B?R2NHUUJUWVZ0QTEwaURJQWZua210V1grSllrcjVJR2ZpeXZoN2tqWjRVcENW?=
 =?utf-8?B?djlWazV5WE03ZVhkMzlHbk14ckhOemtOVXByNzVUT0FYTkMwc1NkKzRTZUNl?=
 =?utf-8?B?VlVMc0tKNEZzVU9zVDMrY2VKd1pqYTV1TTlaMjFrcldDeDlMREh4Q2JYZk5G?=
 =?utf-8?B?dFR5d3hRdzJJMUE1Sk91VjF6QlppUUN2dk9CMG5pOE9XZG5xU3h2ZzVicXNM?=
 =?utf-8?B?cjI3QW1VRWhqcmJuL3h1VFR6RG9MQ254eUVlbW1TalJPOFpoVE8rVmZicUYr?=
 =?utf-8?B?dnFYS1NrQ3k5d0JRM0hZKyt1MXBXNUM0NXpORHBWYUhCcERCQitvcEZVMW53?=
 =?utf-8?B?dzRhVHhKTlJBMTZJcElXVTlud0NCMXA5c3JOYmpWS015SW9JZVNlRGZERjkv?=
 =?utf-8?B?Z0pReGRYUUkvczJhdEVMaXQ4dUdtSitaWVJTMUhCVElJZklSYXVYSW1iS2Nl?=
 =?utf-8?B?bkNnZ3dvVTF5dGk1Wmt1cG05YnRIamJ1NGNVZU5QQjBacWdhWUtyZVIxa1Qr?=
 =?utf-8?B?V09XVnZNRGEzeGJMMWxJdWhUWjQ5VWI2QUNpSlF5ekFaNHRqdjdNZEM4SjJm?=
 =?utf-8?B?UEpVMXNic2NNSGhydlU5WExZaW1SZTBwRlFLVk5rNzlSTFJVMU5JN2F0Wnho?=
 =?utf-8?B?amQ3M3JIQk9zSkNUaE1KS1laWXZqa3RjeU1veTBwdGd5dDdTT2VBeTQwT014?=
 =?utf-8?B?QjhLazg3UnczeVpUS3hmSEF2bklGZzZvRkJhdUdWaTk3cW1tbDYyUEZ6RFRC?=
 =?utf-8?Q?VUKUSRe1dVK8jbhBjbXICKhkNwtWX47iHzolYig?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHR1YUNnWFdvSUEwWXJBdGFacFc4WlJMcm5TazRRYzdFcmg5ZXFYemk2YWJq?=
 =?utf-8?B?VlJiOWRnY1BpajkvMm41ZVZVVUw5d1JrbVFwMGcyOTFKMWxYQUtiRnZyY29o?=
 =?utf-8?B?SW9mQVhjNU5QMEhNa1pHclNKRWg5clR3Z0QwbUdXaktNRDdtc1BWKzZSZWdM?=
 =?utf-8?B?LzA3TXdTaDU0amsyKzFjby91Z2RZaUJZYi80T0lTNzFXWHlYYTJ6MGZONEt6?=
 =?utf-8?B?Sk9YWkJvRzNSenU0SURONXl0cVhvUVlpQi8xWldqa2x3bVhVeGdCcWx3SHIx?=
 =?utf-8?B?bEZnWUluK3ZkVWtDMld4bzR3TkF6cXBkNkRxdU5zSlgzRU1qUHZDM3JxR0JJ?=
 =?utf-8?B?R2VETW81cnZONmEwZnhnbGtRWm91Q1pNcUZwUXhtWE8yM0t5NnBWdUtuS2Vx?=
 =?utf-8?B?dmFaTlhoU0t2Q3VLMHB6cGtHenNEdDZIWDJzL3FwR3lJT0JDMGdid1IrVE5q?=
 =?utf-8?B?ZlRoUUhEN2hoblFjUlNMMERobnNXLzNoOUhzMzUrU0dsY2VjeW9xSkg1MWZP?=
 =?utf-8?B?TkxGUHk3dWsvN1h0VHZUWXgvcTBxcks4SThtWHkwR2YxT3hLbytmN25yUFF4?=
 =?utf-8?B?aHp1aDIwMXQzQ3NGb3JLSjU2S1VCYk5xSFpub0R0SkNmS0N6eVdaYWxyMGx0?=
 =?utf-8?B?aEdlTU9WM3ZBaUh2a3pndFlVdVlzcTg0QUJBNkhGc2pkYWtmVTVkdTBPeTNz?=
 =?utf-8?B?MUJ1OEE2NVMvYVZRZjJGUyt6OFBOcHA4M3BOZEh6NEhlWXl3Z250cGN2RzFW?=
 =?utf-8?B?QzlIZEYyRkI2RUl5S3B2SE5jZjdaQ0Z5TVlETnJmWW5wTW5iQ3gyMXg3NzFT?=
 =?utf-8?B?WEZVMnIzbkNVd0JKWEljejU1eTNsVHh5SmJjcEpjdzA3SkJkMUwyUHFobG1I?=
 =?utf-8?B?OUQ2S1BkN1dQcVEzWTZPWUladlo2WEpIRjgrRTBVRVJTb2pFNFRvUnRRVVZ4?=
 =?utf-8?B?a05pZXVDNy81NFgwWWg0RThQNWh3SXBNSW4zR2dGRUtNVWpKa2wrbUMrTkZw?=
 =?utf-8?B?L3doVkRXQ0oxby9Pa1l5V21LT014R25pZEZZMjhDZ2JiZytFdmpyTm9HVFEv?=
 =?utf-8?B?NEp1Qnl0dC9QakRMaTE5aFJFKzhLblI1WFFJOGFxR25VWG0yMThlSXRRUzV2?=
 =?utf-8?B?SkwzVDRia3hQMCt6ODJEbGltbmhWZjVBYWxsRVg1M2pkNUg0bjJLakNtTjRl?=
 =?utf-8?B?cmE1UjQ1aU5jaDlwV0ViYTZyMHBRSzlLZ001cTdENzQ2cHRmSWh3cFFSbnp6?=
 =?utf-8?B?ZVgyVTRwVHhMd3JSTytaZnkzQi8vd3dYbElYZWF4RE9pZlo2N2lTUlgrVDA2?=
 =?utf-8?B?ZGFxeXppUHdWZEJCWW1QRDZ0MnhkYVg2ODBaenVhcnNKQWFBWThBZGkyVDhx?=
 =?utf-8?B?VzEzbUg3SWtKV2RrMnpLd1hxS1VVQ3ZVSHl2eXgxd0IvQktnQ0RMa29hb3dl?=
 =?utf-8?B?Qk9WVlhkaXFtOE96d0VrSS9uckdFV2ZOZGFkUEpnYzZRM256YkNDTE1VdXVG?=
 =?utf-8?B?akU2VXpYQitSZW85azZ0ZjhkRVpob3V3VHBuNzNOcmNVTGpyajZyTXMvdHZQ?=
 =?utf-8?B?Z2s4U01JNzhrUjhZZlA1T09lQzBGWFZPSTFOZHo1T1BLK01FYmxTaW9oMndQ?=
 =?utf-8?B?RHpTR1JjREtlcWExRmFMbXV6ajV2MXdIblhLWjJMM2c3MzZZOStmRVQ2QnQ0?=
 =?utf-8?B?ZlN4Vm9tSU5Qc0VHT3RjK1JQSFQyZVhET3NCUlVrekI0Rk9TaWo0ZDBrOHNa?=
 =?utf-8?B?UThsNEFwcGRCc09ZU2VodHgzLy9wU24xcitlM1pHRTJqSGxrcEx2WTU0RkZ1?=
 =?utf-8?B?ZDI1aVEvNEUycjZ2QVo1M2dIOHZRWjNWbG1BdHFDU3hlYlRHZDJicmpFYWk0?=
 =?utf-8?B?eUNTMS9CZllYYmRRdmpYVFBIRnJueFo3VlhpejFjMXVsaVhZdkNaVks3Q0V2?=
 =?utf-8?B?enBxL0VaQkRadS9ySVZrWWI2VTZRc05nL0o4VU11NktUeG9xTjV1NkNSdFE2?=
 =?utf-8?B?L0J3WXAzcjNmRHh6SmNXZDc5bEJaNzh0OE5IYkpkTHkwNkZuajNjL3A0TlZK?=
 =?utf-8?B?aVFtME1BUGF2cDZ1ZVB2Ly9jRmkxcTF2dSsrR3BhWk5GZ2p3QlFwRDNDVFli?=
 =?utf-8?Q?Gviq2Z50OvhSl0yqq54HwJ4s6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508e6a4b-e66c-421a-0dbc-08dc952831c8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:05:04.7613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ShpRXvemPmo1hogRNzodrbbbLuQpMp7epIL5Lf9i7+2EmeBblq/JVjB+Kea7moR/COWTF4hPM3P/e2BtgJWTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285

On 6/25/2024 08:41, Dhananjay Ugwekar wrote:
> cpudata->nominal_freq being in MHz whereas other frequencies being in
> KHz breaks the amd-pstate-ut frequency sanity check. This fixes it.
> 
> Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

The code change below looks fine to me, but I think the tag is wrong. 
It should go with the "fix" that caused the inconsistency.  Here is what
I think the correct tag should be:

Fixes: e4731baaf294 ("cpufreq: amd-pstate: Fix the inconsistency in max 
frequency units")

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate-ut.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index fc275d41d51e..66b73c308ce6 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -202,6 +202,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>   	int cpu = 0;
>   	struct cpufreq_policy *policy = NULL;
>   	struct amd_cpudata *cpudata = NULL;
> +	u32 nominal_freq_khz;
>   
>   	for_each_possible_cpu(cpu) {
>   		policy = cpufreq_cpu_get(cpu);
> @@ -209,13 +210,14 @@ static void amd_pstate_ut_check_freq(u32 index)
>   			break;
>   		cpudata = policy->driver_data;
>   
> -		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
> -			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> +		nominal_freq_khz = cpudata->nominal_freq*1000;
> +		if (!((cpudata->max_freq >= nominal_freq_khz) &&
> +			(nominal_freq_khz > cpudata->lowest_nonlinear_freq) &&
>   			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
>   			(cpudata->min_freq > 0))) {
>   			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>   			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
> -				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
> +				__func__, cpu, cpudata->max_freq, nominal_freq_khz,
>   				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
>   			goto skip_test;
>   		}
> @@ -229,13 +231,13 @@ static void amd_pstate_ut_check_freq(u32 index)
>   
>   		if (cpudata->boost_supported) {
>   			if ((policy->max == cpudata->max_freq) ||
> -					(policy->max == cpudata->nominal_freq))
> +					(policy->max == nominal_freq_khz))
>   				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>   			else {
>   				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>   				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
>   					__func__, cpu, policy->max, cpudata->max_freq,
> -					cpudata->nominal_freq);
> +					nominal_freq_khz);
>   				goto skip_test;
>   			}
>   		} else {


