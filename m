Return-Path: <linux-pm+bounces-18833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652749E9BF5
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 17:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB0C2838A2
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 16:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5300514A60D;
	Mon,  9 Dec 2024 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PBSh1qSX"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F71487C8;
	Mon,  9 Dec 2024 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762472; cv=fail; b=gp/biqgy2q4JBEoDozh9Gb1plJKpqMSpHPjUm3zoGnInPkOX1rDSCOoJgCST4vPpPwXyRLHqRq57ajSkxt62q+jeGJtrZh0VY2dZykA9BipfpP5LefDNVJnaPQs8OBOfuj2IsGtWgiR7Q2xMHKhOMOgpMcEuE2ZQbY3UNGOBXqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762472; c=relaxed/simple;
	bh=DI4uIW4BVY65G0juAo9RxSFzLqWVb/YmPKQVkHe/l1s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dFKUBPB4L3SDbMpBKnOwCDp0IPmHb5Mthn+G4xFvVgrlOxYn/skhUqU0JfAEuyIwm/esdN4mgrkIkmJMRAXnOM3bM7IoxxZTdpWmc4XLv1ONRErWAVlMyr3fnqiGoYeopdfrVtC/MaVFQLgiw4GYm9ya1+clgB/EgkgIYi0aUsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PBSh1qSX; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbSjJkWSTZiG96OZKp9VIOykV2qEQg279fv/cdhaAHJ6tXLGt23UpEjld16rwmJ9kNDnoiRYwX8cQ9WCKbTw9frMRwJJPjuWKoS6tMSy0q0lc/Ub/Z2CPmrR5B5MPZ/JqTSDNURFPkeWCWV9nPm9N2p/KH35yDI8FLh/V+KcxFaI9g0U6/5mY9LiYbvoT6gXzfKcUWMbL5YQsETtcHjRXx8/q5atX2vqSpuM4Junr/npPdHWQaWUo0tEFv7NFcJX4rX6d74D/LKdg9OcDgEREMaPWwi238X8RDVoP2MInoWz2DOKqEKI3ZmPRGLPsTBQedI8DyqILm8rrCQVmLXtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsYONRhLZhX7TwCmLAsQLWHrRjknScxkYXtpf0rNY64=;
 b=D7fg8K7MyuR4iKfcuqhU5+aVaDAoB9/vF7MwnYz03HfJVRbunGDwiK0aMxjn5lwdCn0uaa9QdjGclKjm4ClcJ1UgFsZquiIWx0+uhgxXjR38RC9zcxsXLcwKj7DY7aJV4854S5QBix2oRhh7s8XqDRl0PzOdCYNuxaAPU6/l0PFQ/XneIamNKqqgojFvCCw0C88tmNCMz2r4ycJUMvqRTEU+K+5RPUk6qRA28JRBhNon4/DNlCltAjq69EiWcOCDnQDSJL0tlwyrAxG/ZtWFTQYB6ZAA8h7aAi/79dF1k6gY2v6c1gX4QxcnbPIT0lHwVJzXPh2lhhmYf35t7pARfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsYONRhLZhX7TwCmLAsQLWHrRjknScxkYXtpf0rNY64=;
 b=PBSh1qSXS4YcZmN9wZLF91XpSX4m7SBP3xcOKmpLeTBQY6ry4ESXQpPtvm9+TvTyQppDhzLvuoV2zjWqv/LoHJHSTPXT+JyxfaI6jLuhP6Y06YS2N46+rIyzlojq4Zk9r+ismOaVc+O7SDPWurHYM53MtC+bPBmNkKmAVmEKYIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.25; Mon, 9 Dec
 2024 16:41:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 16:41:07 +0000
Message-ID: <05c76dc0-0cab-42e6-bfe2-cab4c28efbbb@amd.com>
Date: Mon, 9 Dec 2024 10:41:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] cpufreq/amd-pstate: Check if CPPC request has
 changed before writing to the MSR or shared memory
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
References: <20241208063031.3113-1-mario.limonciello@amd.com>
 <20241208063031.3113-14-mario.limonciello@amd.com>
 <Z1awrnPHwTVMht4E@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Z1awrnPHwTVMht4E@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:806:20::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: eaee5b5f-819b-4730-e2d8-08dd1870474c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emhwbitpSk5ubkpLcGNpOTdyYzNLSkVDTGtMSWVRWkdZS0ZKY2ZsUHR6V3Vi?=
 =?utf-8?B?aURjS1RwbldPMkplSnkwNjU3aGJzNGI2SzU4Njhwa3c1V3lwMzNpUmV1WlVG?=
 =?utf-8?B?bWNRTjJjc2JQQkNJRUNicUVsWGJPZ1NZalRBRWxFaXFueW1UUERRWDVCUFpJ?=
 =?utf-8?B?bGdnVU5HZStMT3ppdUZoL1Q5Z2Iva2VXdDFmTDVPeFhDRlB2WHU1YWc3SzEr?=
 =?utf-8?B?ZTVmdGQyRFNRY1I0NFduOTl1c2dKNWw3MjJhbkJwSENraW84dnBLMDh5WVBO?=
 =?utf-8?B?ZVlTSldkL0h2OUY0MmloN2tFcGs0YW5LTThnWEF3d29qRnM4MlBEZWxBKzNv?=
 =?utf-8?B?VUlMK2VsVlRlUU9iUW56OWVSaVVSR2h4cVFheVNKMVMvR0Fyd09UL2dtbDcz?=
 =?utf-8?B?N056blZyZVhBblV3T0pxT2hZQ0NaeWR6bnZsblVzVFM3c1BGS2pVa3hLTGhZ?=
 =?utf-8?B?RjU3NUxyRzVYUVVyNHY2ZXVxU2EwcVhDOFQzVEVRTEowdzMrV0NUUjhFL2x5?=
 =?utf-8?B?MG5SRjUzOEVXYUt4eTBRaTRjUlZvT3hMcnppY3J6NWZuZTNIdFlySzhPQ20z?=
 =?utf-8?B?TDRpc3JkTVNGY3kxZm1KVWx2OGptaEZUeVp6VElHanhKdk41SDA1UWt6bW0z?=
 =?utf-8?B?aWpxWVdnNzl1MDArcTdvL1JvcUUrMDI0MS8vRWRpeXcwSStUU2w5MlU1blBG?=
 =?utf-8?B?Z3JBMWJBMGhzY050TlQ5dGJ0aVI4RHpCQ0tNRExNYUZVR2NGbHdnaEJJTG9h?=
 =?utf-8?B?b3ZodktLQWN6aVBTZ1hZSGkxTndSZ0ZXSW9VY1kxbkc4WlNZYUwyUU5GaEJJ?=
 =?utf-8?B?MXlyaFEwSnViTUxua1l0emhJbk9xM1hFY0RCaUJTMDY0YVcwNURkWFlhYkhG?=
 =?utf-8?B?c3J2STRsV0JwcDlLRkZkV0Vkeit4bzQ5QnJZQnBxcG8vODFwMGM1UW5YZWRa?=
 =?utf-8?B?SlNIZWNQcEExaGx6VlNsUXJlMDV1MnBUMVZPbEhPeUVEaXpUUkVQNFc5QjhV?=
 =?utf-8?B?NXB0cGRmbjVUamVYQ3JEUm1nd00zRjIybmk5ODdxZE1hbnh4WjJ6MXNaQWc0?=
 =?utf-8?B?a3V5T3k2M004UWlnZVIrT00yeEVLK2FnZmVaWUtQanNpM2FvN1dJWnJLUThu?=
 =?utf-8?B?cE9nanZzTGN0ZXNNaWEvMzBHc3VQeUp3YTdHYk0yZzdpK2FybHRmYUpEbmZU?=
 =?utf-8?B?b1FvbEpvbnkwZ3UwTHcrNVlxUVJKWVMwWkRqKzh4eElRb01EZnJLMlVrYi80?=
 =?utf-8?B?Nkp2YzNGc1ZqZk5vY2hJRHhIWjEwQ0FOekE5MThMQ3B0aTlPdVBZTllCTkQ0?=
 =?utf-8?B?R2wwWFFmbnBaNEhDY00xb0lqM2FYWHRjaDBpYnZMNGxkR3dMeU52SEZMN1hq?=
 =?utf-8?B?RkhaTjlILzZaT1ZxekZUYlcvZksrY3JiMVZINUk3bysvcWFwUUs0ZlZqQm9h?=
 =?utf-8?B?WTVMMk5EcmJ3VlgzREpVRUxhWVdaT3RGMjRTVXFYUlMzQzM2dTUzUmU1REZO?=
 =?utf-8?B?enpHU0hZeUF3eXRSWFBFSXVrVmZRT24yVFRTR0hEWDBjSzRleDZ0SWlNR3Z2?=
 =?utf-8?B?Uk16NisweTluVERmSE5JdmVTd1llbkpCUXowLzhxWWtyZGhzcTR1d3lSQlVU?=
 =?utf-8?B?UXBaRFltaEk2QngzWHo3UlVBUXl6a0F5UTRPOUhLS3hsSEhONTB4NkFUZ1lW?=
 =?utf-8?B?aXo4RnJiRkRMcWJZMHVESlBxVFRZWFAvWC83eFlQWFJobWZ3SWY1UVpIcVh3?=
 =?utf-8?B?TE9HSXFWREpKYWZmS3NvTi9pcWNkczkzb0xXdHdHeFhYLzYyRUZiaVN1VnpE?=
 =?utf-8?Q?t6uvP1poSIS0V1BeeRNPuMSWGdgNgZjr0zw6s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHB3c01Rb3pveUV6VDZOVjVSTmhVcnVIQmNYK1BPcU5wVTYyYVJndEVCWVI3?=
 =?utf-8?B?ZGNTSFdTOWszWGJNSExYajZaUGp5R29zalFYSUZHaXEvSGxNdmNQK05tNU1i?=
 =?utf-8?B?R0hETTBvMGlKd2htYVh0b0tQbERpQjYyUVZKR0hTQ1RjZVY3STdZK2Qxd2xZ?=
 =?utf-8?B?VVJzVnF2eDNYTHcza2RKZTJBd1BsazJXYkM5NDNpS3ZYWHp3R01Fc2VmWHVE?=
 =?utf-8?B?aE1vejZNMnRpNThhRXR5R1BxbWhYTzJkb3FZbFpjbXkwSEJiSERFTEhxRUU2?=
 =?utf-8?B?aUJ5SEJLL1MyMm9DQjFhcHJCRUVvNmJzL2diblhUdzlrOHo0U3JqK1FwZ3Qw?=
 =?utf-8?B?V1p6ZTNsV2s3NW5NUjdUNHROTFVJdWoxbHBoRlhWK3NJRzNCNlVaNFd4QS9N?=
 =?utf-8?B?TXZIK0krSUVrZ2RCWkNGelF1amdlUlVsZnNrVUI3YURINnFWWjBMdHVsaExH?=
 =?utf-8?B?QlZJNU5laHZoMXhvSk5FbGdTSUhTZXA3M2ZDdE9UamRhTGZJTUk5aHF1anll?=
 =?utf-8?B?QXdsc29JMWJsQUdWTFNQeThKNUFwRUJUd1BvajJXQk5ORmluL1ExdmlhNFI0?=
 =?utf-8?B?Q0lCT3Zwd2tZZS9xcDgwZ2czdStaMjJzL1RQYUdJWUVXUlM1N1BiR1hpTVpF?=
 =?utf-8?B?ZUpwZDlUOFlKNEN4V1dUUkNqNlpGNTlRTVE5cDlMMmo5ZEJQMkFUdHdzRmlK?=
 =?utf-8?B?RkdHSG5lVCsvM3RpTEpOQ1dSSSs0V09ZanRyT0lNVXpoRnM1WDY4NTZ1SHdx?=
 =?utf-8?B?V0lMWHJSMjVzTmVPM0JVaCtHMWwwVm5yQVpjakNaWm9ncWFveTRyQ1l2aEVU?=
 =?utf-8?B?azlTdm5NWCt4ZnlnMkZPdUYyMWhOcGxuK1VMd3VZcWxoNDNHSVdQUURrUFlk?=
 =?utf-8?B?RGJtaGhLN21xZFZwa1gwZmtLMXJhMEZmSFhvbTNzdTY5eGp3aWM4V25OU3Bo?=
 =?utf-8?B?c2gxaVFIREtTbUxBamxIM0wxdy84UEtCRTlNdFIwYXVtU2NSTHI1NlRCVHpl?=
 =?utf-8?B?cmpDcjBhamd4dlJTdEhaR2s5NWVENDhURDg0TUI2SDU1TDJHeDA3S3ZTSzZo?=
 =?utf-8?B?NS9qWjFXM3AvdGdaMFIveFA4NkpNOS9RM2IzQmRIMXF1NXZwMTFEL2hncmZT?=
 =?utf-8?B?TUNpL3ROUm94RUVMV0dMTDNlSHlSQ0JsUE5md3REMzh5ZTFlbTRaalErUUl4?=
 =?utf-8?B?cW91TENDRExndjVMSjNnMVpGZEM3WHo3bUc2bUtYaDdhOTVJNkl1b3Z3amhq?=
 =?utf-8?B?UnU3dEtpdWJOSHk0ajE3U2NhdFNreUtBQ1hIdHFJNjFVOGJKbFRkdEtaWDdp?=
 =?utf-8?B?eWFQWWFQNVNoTmtpMzBOSTlMVDBhS0hKeEZrVFlxa2Y4VEh3QUlDVmpRWCtJ?=
 =?utf-8?B?UG1wV2duYlVDeEV5WkNtYWRaUzlwN3BXSnAvY3JQYlRpaExhOTVHUW11UTdr?=
 =?utf-8?B?SnErMGk1c21qTzBiVW51Z0N3T01BaHJmd3A4c3A1YUs0S3hFWTlQQkROSDZN?=
 =?utf-8?B?THROWkhiRzdrYkozdW5BR293YkV5cmg4Ylo2b3AwN3FoanJVQ2wzNFZZT2hy?=
 =?utf-8?B?UmhNQWp5d2hNQllXR3NBNEFCOWEva25kOHZZV3RJY2hBU0R5Rmlmamh1OEVS?=
 =?utf-8?B?WGNwc2kydUM1ZEQxZHF0WVN2blFiS1RPaTZxQVBoaGV3aVhPbjVQU3lXT0xL?=
 =?utf-8?B?SmdnNGtnWlduV3NjTk1tWmMyRVlqcXFUUm9aUWRLOXhpcS9Td1kzWDk1WGhE?=
 =?utf-8?B?ZG10QUVnRnlLZjM1Y1dHckpFa2x2T0xoaW95ZGVsS0xqZWlBRkFXYWdacm1D?=
 =?utf-8?B?Q29ISHNPSDdXWmo0M0FMTzBGNXNrNkdLalRZQ3dKdDhycEl2M3k0SGdIQWIx?=
 =?utf-8?B?NUZKc2RwUHo0clJjL1g3OUNIcW1UNFNyODdldTEwcnlIY2xKNStZanFmblN2?=
 =?utf-8?B?NGFLY25ZV1dzZjdEMWIxQStkanNNRURGellGbGVoZGlqWEU2MldhdXBsdVdR?=
 =?utf-8?B?ay9RTzJ2bDQzeVJLakk5NGY4bUgxSnhoQ2RWdUMrcWloSmNOUm85a2o5blgw?=
 =?utf-8?B?eldaUnpYeEdVZENBeUo3S2NBbFdsMnAzaHJGY0ptUHRCMnI5Q05FVkxQKzVG?=
 =?utf-8?Q?lurWykJNDOJrdTVuBn8j/Bm9X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaee5b5f-819b-4730-e2d8-08dd1870474c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 16:41:06.9652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbzHdd3TesGDk2ViIKCJ+HXJ428nRJUxX3quVjDR9kzgi4J2pLI68A6ZvW9ORzNeFONx0mMP+UeOj2Zw0uslFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771

On 12/9/2024 02:56, Gautham R. Shenoy wrote:
> Hello Mario,
> 
> 
> On Sun, Dec 08, 2024 at 12:30:28AM -0600, Mario Limonciello wrote:
>> Move the common MSR field formatting code to msr_update_perf() from
>> its callers.
>>
>> Ensure that the MSR write is necessary before flushing a write out.
>> Also drop the comparison from the passive flow tracing.
>>
>> Reviewed-and-tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
> 
> [..snip..]
> 
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index dd11ba6c00cc3..2178931fbf87b 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -224,15 +224,26 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata)
>>   static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>>   			   u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
>>   {
>> -	u64 value;
>> +	u64 value, prev;
>> +
>> +	value = prev = READ_ONCE(cpudata->cppc_req_cached);
>> +
>> +	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
>> +		   AMD_CPPC_DES_PERF_MASK | AMD_CPPC_EPP_PERF_MASK);
>> +	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
>> +	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, des_perf);
>> +	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
>> +	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
>> +
>> +	if (value == prev)
>> +		return 0;
>>   
>> -	value = READ_ONCE(cpudata->cppc_req_cached);
>>   	if (fast_switch) {
>> -		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
>> +		wrmsrl(MSR_AMD_CPPC_REQ, value);
>>   		return 0;
>>   	} else {
>> -		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>> -					READ_ONCE(cpudata->cppc_req_cached));
>> +		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
>> +
>>   		if (ret)
>>   			return ret;
> 
> Ok, so you are recomputing the value in this patch. Does it also make
> sense to move trace_amd_pstate_perf() call to this place?

You mean so that essentially it only logs events that REALLY write to 
the MSR/shared memory region?

I guess with an ftrace function call graph + that event you can 
effectively determine that is what happened.

An alternative is to move it right above the (value == prev) check and 
include "prev" in the trace event.

I think that's my preference at least - you capture whether it changed 
and what the intent was.

> 
> 
> --
> Thanks and Regards
> gautham.
> 
>>   	}
>> @@ -528,9 +539,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>>   {
>>   	unsigned long max_freq;
>>   	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
>> -	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
>>   	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>> -	u64 value = prev;
>>   
>>   	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
>>   
>> @@ -546,27 +555,14 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>>   	if (!cpudata->boost_supported)
>>   		max_perf = min_t(unsigned long, nominal_perf, max_perf);
>>   
>> -	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
>> -		   AMD_CPPC_DES_PERF_MASK);
>> -	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
>> -	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, des_perf);
>> -	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
>> -
>>   	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
>>   		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
>>   			cpudata->cur.mperf, cpudata->cur.aperf, cpudata->cur.tsc,
>> -				cpudata->cpu, (value != prev), fast_switch);
>> +				cpudata->cpu, fast_switch);
>>   	}
>>   
>> -	if (value == prev)
>> -		goto cpufreq_policy_put;
>> -
>> -	WRITE_ONCE(cpudata->cppc_req_cached, value);
>> -
>>   	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
>>   
>> -cpufreq_policy_put:
>> -
>>   	cpufreq_cpu_put(policy);
>>   }
>>   
>> @@ -1562,19 +1558,10 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>>   static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>>   {
>>   	struct amd_cpudata *cpudata = policy->driver_data;
>> -	u64 value;
>>   	u32 epp;
>>   
>>   	amd_pstate_update_min_max_limit(policy);
>>   
>> -	value = READ_ONCE(cpudata->cppc_req_cached);
>> -
>> -	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
>> -		   AMD_CPPC_DES_PERF_MASK | AMD_CPPC_EPP_PERF_MASK);
>> -	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, cpudata->max_limit_perf);
>> -	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, 0);
>> -	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata->min_limit_perf);
>> -
>>   	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>   		epp = 0;
>>   	else
>> -- 
>> 2.43.0
>>


