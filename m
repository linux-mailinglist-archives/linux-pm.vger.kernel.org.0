Return-Path: <linux-pm+bounces-18709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369859E75B8
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 17:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB5116CC1D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C2220CCFC;
	Fri,  6 Dec 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wyk1IFbv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE98207DFA;
	Fri,  6 Dec 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501813; cv=fail; b=ZnYjVeIOr3lw88KX3yxef2/BM6V5KlenFb67UAfdqVr7xnVqNCtpokK7JOblIKV+DOjGCdSAYf6xFK104LIJ5wT4VQU1hsqdZzyPTPC+ImEHJQn6+FYE5g+JhbwIFr+1VivsJFtFPrQB5WbpvpJE/9bJ0FYsrCq4r0PCsP+Hvcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501813; c=relaxed/simple;
	bh=3IRCb3RRaGpy3q9+nNlXw2tGjdV+gqgyA1vb+aVCRm4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WHoXCCPAsWJBVdBcdu43mlqcjU6tjccDB2sG1GIfeDVqgDQgJhAdGZ+QxKeNbn/xKWBcMpVfVOowgDi8p0MnGaoUIt2WRRTwUKnjR/EHhtNTTGUJlyPAYJ4/qtiCprLpWTlJeIieh/A0NYtGWTKnCATDmRt3OtqLrE1+XpX1JwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wyk1IFbv; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOGAtfNTCCYF9O8dU6fpSADUHgsGUV+JKEdjjPSwNcc+X0XipV6T7108epQ02jBqmf9K9jLoD6MKGWjrI7Jb5g8SSSxIf5TNyh2BkksqZ6GGKveJj9tr5MOgGJ3f43ogNjzIncStm5q1QOF0N/PpELOeqPO33xrYkAK3YUG0b+o9QegOj3IF00cxeWBLqMFERinjWP5dcDWn2oNZl5BHAr7gzG+nzj6TUK2codrRtP148WPK6dExdBJX/x+gTFf7TZe1nLJ2WfjpUYxbGwjInGV4zV4pi8APnZzQwoxGMLJQ1Z3D0CjISXn+Rt+mXBQH7lk6IANLjRUFly8uRoY7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0SBn4sjN4zTbNbf8uuAN2jeFJLnx3Dy7mHAw4XLQ/0=;
 b=VDDY0HDZenZtg+Ci2KHc69PI72itPCIK5sOIsX+ueteYPihI6onCKR6mSQFDz0FG8R7M3unOJ7em77mn1hzATChTEMgu6IUZz2seVVS9BltpblgB04qxZj/FAzQUPXFkiTs5YpAJpLvtnPMSycsgLjs5YztYKUCaiz5hMvS4MLD1qLWqBhDTxc4TKuCPm6hVi7UCIvqA44H54NfRSshLPzZz0fFvKFIRLxP3YtnSW9+7EaK9WrDjoJYDq94tf0bzdntDIbGn+aZ8vcMCKX3SF65fZwbJcKlk2Kdxw+HnK25Y37OVYSRfgwGRn1X5Mo5TViTvykEgdXMxf7T/U9iWHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0SBn4sjN4zTbNbf8uuAN2jeFJLnx3Dy7mHAw4XLQ/0=;
 b=Wyk1IFbvW+yfRhJfXPiaH/IWJz3wLOCQNbUoi4KNyRRz168ysn33kj4RXWRMjKXIK3aC4AW/KPBMCOcL0IA3kO3W+/5+OrHzDE3ppsm1K7mHTLQgLbCBCJ582Jbl6HWItc33pg/rNartw44RNUQZc00RJRdHNmpXaqrTKJ8uTzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 16:16:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 16:16:49 +0000
Message-ID: <094167fa-e4c8-42cd-8d28-d6423f86f597@amd.com>
Date: Fri, 6 Dec 2024 10:16:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] cpufreq/amd-pstate: Cache EPP value and use that
 everywhere
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
 <20241205222847.7889-12-mario.limonciello@amd.com>
 <Z1Mi7hclcaSaRRjO@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Z1Mi7hclcaSaRRjO@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:805:de::43) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 851c04a9-4b2c-4b33-e896-08dd161162f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGs2d0xvYkhQam1JcDlNQkF1VTFMaXdvYWxiZTlTYThPenM3RkFERGQ2c0RK?=
 =?utf-8?B?K3pMcnU5UkZuOFRORldwK0tXQzloNUlpRUlyYy85VmN2dkZoZUh6TTJUS1pq?=
 =?utf-8?B?ZjN4RCs3eCtnbWtpZ2FOTmV4T0h5dkpIcnJYbFZudWIzcnk1Y1VhM2x0Myto?=
 =?utf-8?B?LzVEUjdJdUtvSmYrK1o1QU54RlVMc1dzWTVzWlhIM3ZoTEQwNjczN3MzZGdK?=
 =?utf-8?B?SmwrWXFKdWNXcFQ2RDZYaTBLd2pSMDJxR1NTS2Fkek1jWGVSMEVpWHZNencw?=
 =?utf-8?B?S2xCcmc2RVduMlpxWkhoaGJyQXJHdmxFT0RYRlJMT3ZQNEdTRmgvZUNJd09x?=
 =?utf-8?B?VmpibFdEMDFVUWJXbW9xK0dnMVU5NFE2NUhJbngxaUdDV3haTExkdWNXcGRH?=
 =?utf-8?B?Z0d1KzFscExNOHM5dGxiSWJOb0RUMC85ajF0a2crZmpsakdLTWh1ZitFRms0?=
 =?utf-8?B?aXhySlM2UHUzWUV5T3ZoOE5QcUhZZE5YQWhZR3F4RnI2V2tROHFsdi8rTnVO?=
 =?utf-8?B?dEdWYTRWbkRScjNuYkgyendQMDlQb2F4NEcwR3FGS0V6YU9qUlBvV3Z0WllB?=
 =?utf-8?B?MEdMcm5qSHJuU0RkSTU1RzRTTlhVRm1PY3hHQkxEMzgzNWx5U09KUHJ1T3RY?=
 =?utf-8?B?KzBDWjZBWkQrQ0FpbVpNNEIyV1lnYURUc1BNeVdpWm0zc1ZhMWFEZ2FnMTFX?=
 =?utf-8?B?UzkwTzUrdUpTeUEvTXF2cS9tc1BtMmt2ak9ER2VHU3plZ3ZGQXBzbTIzQlpn?=
 =?utf-8?B?R2gwcVFaYU5iZms0cGhFem5LV3ZqRDcxWm9JNUdqckp2dXdsc1IvbnQrdmta?=
 =?utf-8?B?NzdQWmdHdWYyd2trYTZON0dCRmJyMElVdXI5UVBWMlhVWktJSGJrN1NNcFV5?=
 =?utf-8?B?TzlpajVITndNQ2lUbU0yd1o5VUNCREpWdWpwWkJDMDhkUURubGRWeWNQUU9v?=
 =?utf-8?B?Z051OXpsSHd0K1htNzdqNGlEOXcwWWtuanIzTTlLejVMZVNMSnNDNGQ3TVlx?=
 =?utf-8?B?L0RKc0VzUHh6WnFBMkxsUjJDc2h4NXVmUXhDLzlZNFRwNWJNZmpNMUplaWFw?=
 =?utf-8?B?Nk5aUHFnd1N0R2RZTldPWXlqYy9nQmJubUF1bS9WWVR3bXVTUW9aUVRxTVJQ?=
 =?utf-8?B?TGpxdGlHeU9tY1lhRTVEcVl4RFlvaEFpbys2d1RVSnhsTWN4V1NKRFhCTU81?=
 =?utf-8?B?WmQ1QmlmUUpWajBQUmpVb2w5K1BWUVBuOXpPWTFkVDFiVmdqTkhmRTVDdFF2?=
 =?utf-8?B?d0txSSt5TlB2SUlhU2s2UGZnN0JtdXpjcjBlaXFRNzRHT3M4Uzg3dlZxVU9r?=
 =?utf-8?B?bVJZc3JCYlhMSnNaUjRDMlltWk1tVXVWQm03QTYxVE5lZkREb2FQK3JHNVFO?=
 =?utf-8?B?VG5MZUNhbHF5Y2gxTFk2bUpJcW9CdWhPNEdkaFJ6TEZYVVNkY1d4VDJvYTU5?=
 =?utf-8?B?VzdJR2dJV3djYTBsNmthKzgwR2NaTDBzTlpNMVNWUi8zTkpISzZDQjcwdEp6?=
 =?utf-8?B?NC9ydVdsbEEvYjE3eTh1blFaZ1VJdXRTODRydlcvSDFQZndzOW5tdEw2NjlV?=
 =?utf-8?B?VTM5TzV6S21XaDZUOWNvbmVKMTljb3dzRkVjbUVweEVOK2I5VjNXT2k5cEpW?=
 =?utf-8?B?WGZaa1drRk9NM09ndW14c0FEOWZqS2traEhEdDYzc0pRMk84a0hsQzg3OFF1?=
 =?utf-8?B?Uk5uNHpaVGdHNHpReTQ5TlNMUGJkV25Nai9mMmhrbk1QY3pvVG8rZGdHa0Fv?=
 =?utf-8?B?TU55enFhR2FyQnJnYUlneFlDR1pmRitKcjU5QytpQ0FUdVV5OVdBSk02aDdm?=
 =?utf-8?B?WWZLelZGVjFtcjRRQkNDdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmFBQnJaSkd4cUpkY1dyL05uWTRaYUU2bzhsZml5NElRSVJpNDJBNm1hL080?=
 =?utf-8?B?Q1NwbVRvbFNlNmNjNTBodzlOWlhWOVNsYUFVMHZQRk5qdEovem1PeG0xemFL?=
 =?utf-8?B?Z0xwRGQrOWpxc0UwejhxZ1E2c3RyMklFaWdONnJ0aVNUMncxTDVQNkZUaEVS?=
 =?utf-8?B?OWR0UElHanRRUDQrcm9wMmFsenlRNE5VaDJwbHF2Zmo4VDJ5VEEwU2doNW5E?=
 =?utf-8?B?NVUvQ05JVi8wQjA2QnN3UFZVWVJjanR4ZEtUNTBUWDRNNGhnWk1Wc21HaUc2?=
 =?utf-8?B?VTV0QUd6UlRYWnRRbVVYK2RYeXMxWUNzeWxaVytLUUVCZVR1c3RQeCtBd3R1?=
 =?utf-8?B?RkY1TUk5L1hsSnpkUTN4VU8yc3dTQVpkYUZNUEZRRzZ0V1BhMlpncGlvb1Vw?=
 =?utf-8?B?WXltTU5pTWxjalRENE5EYUhjVnRtRGZEeEtrT3dZUDN5RVA3SzgzeTNBUk1p?=
 =?utf-8?B?Rm1WaEF2c3JKTEl6K1VTUGQzZWpCUjdSMHp6ck1Ycm1GMFE1Y21RK3k1c3dS?=
 =?utf-8?B?dEg2TzhJRWFZK29rcUpTaERvTk51Y1VhNGd5ZVhlQjRKMTBreGMrL2xieVNX?=
 =?utf-8?B?aWtXK29aT0hhY0JmUlAwVDBuNWVFMnE5Q2RwRkNUSjJ4dEc2R1lqK3dOMm0r?=
 =?utf-8?B?UE5zb1lPdTFxWXpySHk2eGdZaXR2UGE2dW5CMWVmRkk2K2hlYVh3aHkvUnQ1?=
 =?utf-8?B?ZEdvWGdibHpnY3FlMEJPWFNzYWJoOGFnMUo5OWx0YnJwd3VTb0Qwejc1Z0lt?=
 =?utf-8?B?cGJXa05jc2c3OHhwdFJQYXpuZVVDcy9kRmRhamo1WlpJeGk2T2tvejF2UWMw?=
 =?utf-8?B?TWd6R2ZzaTJHZW8yN2Z1anZEUkE2VGQwalVaUEh0YWlBeU1iaTZvZzN2STNE?=
 =?utf-8?B?eVFjQ3Z4dkhBZkFxUnlDUENERDc3RmhZVHFFUjRiVm5GZ1dnVUtZQjFNaWoy?=
 =?utf-8?B?cFpwVDE1MEtRdUtkWGhIQkdhY0hiTXNQZHFYc01MdWg2WEpLZUNtcjJFRWUy?=
 =?utf-8?B?RHNVYzZrNjlVbEJxZEQxRTNEbkc3c1o0M2FiVzQrSTFlbEdVNk5wR2lkcEs1?=
 =?utf-8?B?dWM4V2YxczFYSXQ5emJwaHBDWEh4Z1VOVHdQT0J3enpyd0FGbTljY21hT21y?=
 =?utf-8?B?UVg0eklEY096ZUYzSk05WjN0QmdxRUJSQ2c0bnluNWdxQ3VtUFR6M2VxWmJF?=
 =?utf-8?B?eWlrcjVCM0R5bm9nL0V1K2dUNkdNbExwbFkySE5rUHRlOS9nZ21GQmtsUkVH?=
 =?utf-8?B?dWdLaW9PRjN1S0NPay9Ja3djZ2hjWTh4VHB3aW83T0FQZFFLWU5rbzQxR1lL?=
 =?utf-8?B?QW5zRTNwRTlwdndENHRCR1pPckh3bUFMTDhJN1c5L2NhRDJ0MXkzQmNaU3FM?=
 =?utf-8?B?Q1RwRzNrTFZITnNpMVpJUEVPdjBGY2NhZHArNDdYeEZkZEhGSG51Q2RIQlVB?=
 =?utf-8?B?Z01LRjRwaGw5d0taaUFWSThwS05HMlZlcnlCQi9SYjd6bk5leUcxNVkzNzZZ?=
 =?utf-8?B?bC9uTEhYaTJOSjM0Q1Fwa0tRdVliZHZKUzdzNHJjV3dZRzU2TVRRSmdPaWg5?=
 =?utf-8?B?b09Yd1B2NTcyWUhyRlNSWlQ3cjNEbEZRVzBESXk5NFVvMklEcW5VVDhva2w0?=
 =?utf-8?B?dFZKZ0FlUGw3ZlgyOEt1NVJNV05Wbk84ZVlHMEs3SUNoSFJGaXEraGwwUVlL?=
 =?utf-8?B?Y1BaejZjWVlQQStISFRqeGRNZ01CZDZSbCtFT21Dc2tmWTM5NWZ4MXdISTJH?=
 =?utf-8?B?eXMzT2xZMGxPU3QvaE9Pb2ZJNEs5ZDdnQ25ycUZFWTNwdjhTV2ZvdU1TQmNn?=
 =?utf-8?B?U09Wc3RRU3ZXYktoRFpCSkpOaXhuMWJVK3Q1SCtqU1dsc2x4d01UVGI1S1JE?=
 =?utf-8?B?Znc4WmQrN0t2QkxrMUs3eWNkRC8rSEdoKzh6a1dQQXo5MCtoUVRORng4M3JJ?=
 =?utf-8?B?elhrWW53V0VMSHp1cU5HczVkZVBqMzNzb2Q4dlBMNGtDTmJ3Rm9MTG41akxh?=
 =?utf-8?B?YWhIbzBUWWg4QzB1ejNJbVFNUFhWTWZuUEJhNU9mU01UelZlM1pWQ21uUFJW?=
 =?utf-8?B?OFBqaHNHcUJ6ODV1OEJobGFjdkozWmNhcWhPcXM5UTBSTkdad2hXZTRzUVJS?=
 =?utf-8?Q?tnTt/DWNnLkh4fjnQ6EHsUttu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851c04a9-4b2c-4b33-e896-08dd161162f2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:16:48.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +K0XFCB/5fuOYFjSnTEiqaEzRPdhOGNChI2i+xrZhhL6wSvG8vjOLJJHQNm2ndLTR2GoRqa3/+iaP8qRnKnPig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315

On 12/6/2024 10:14, Gautham R. Shenoy wrote:
> Hello Mario,
> 
> On Thu, Dec 05, 2024 at 04:28:43PM -0600, Mario Limonciello wrote:
>> Cache the value in cpudata->epp_cached, and use that for all callers.
>> As all callers use cached value merge amd_pstate_get_energy_pref_index()
>> into show_energy_performance_preference().
>>
>> Check if the EPP value is changed before writing it to MSR or
>> shared memory region.
> 
> The patch looks ok to me. Just one comment below:
> 
> [..snip..]
> 
>> @@ -1610,6 +1591,8 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>>   
>>   	cpudata->policy = policy->policy;
>>   
>> +	guard(mutex)(&amd_pstate_limits_lock);
>> +
> 
> Shouldn't this hunk be a different patch. The changelog doesn't say
> anything about making amd_pstate_epp_update_limit() call while holding
> the amd_pstate_limits_lock.

I'll drop the hunk entirely.  I'm intending an overhaul of all the mutex 
handling code after this series is landed.

> 
> 
>>   	ret = amd_pstate_epp_update_limit(policy);
>>   	if (ret)
>>   		return ret;
>> -- 
>> 2.43.0
>>
> 
> For the rest of the patch
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Thx

> 
> --
> Thanks and Regards
> gautham.


