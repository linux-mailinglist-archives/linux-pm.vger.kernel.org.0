Return-Path: <linux-pm+bounces-21681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DFCA2EC16
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 12:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D381613D6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 11:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3221F63D9;
	Mon, 10 Feb 2025 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w6mBjvil"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7421F3B9E;
	Mon, 10 Feb 2025 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188775; cv=fail; b=AAzz22VOuuogc+oNi1v97t2yaAG5ewdS+Qy804YiwvMa1xCFqF9fm0dfAkk7pIS2n8bmqZFWXJptupXfDQiec+BqWB4CPjcFoi7SjYbE/C/gQqdtsaCYW4nFU0nm8+XJGtXrcWHa3DY3T3HCYnUM9zMCy1NP0IOk6fcRxGWDVHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188775; c=relaxed/simple;
	bh=dyGA9QkNM70YfdQHI3XYb5uuk30HPGJqro7yiA7zsI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O5E+3v4gfFmKv9priksPTrJUI1fwn2yT/g4MngUoVznWrHfqLXcOhk6p9WkzG/q61HvMsHYk7RWhJPzNQJJs89dj8lCEurUcR88szY0bCgDLP5CocbQTd9rpmjN0LDYhJ/UDuZ6Jj/oKye1Vxr3tEkNlD3Xech9yXu4SLJ2tdZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w6mBjvil; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHIzEjZuh9x/cY6s+wQHjSJMtzapxW6gKm2xajGS3Abktdsc3gw1t5oT6YvNeoSBv7fXJlH5nHMwl0yhz5wSKB1/Ry77kHkWvd4LXIGA9FZRtX8bKYCY2XJ61FXsl0VRQAxuC2hc3J+K0/fODuubJM6A2GpKOcIQ+FZI2+zpZYDa7OkOXINBqPr4BVebYXQXQ3Ah5wH5a63hO7sdKRoEKJpkOPIT4yUKmIuNuMUnO3ZeB+mUTMSlmMTSPOCNn5k+nOz700QCjBH8UfwnirtAJXxu6/0zxNoFEN7tjMB04qvBXNVQ65qb+D4Sn0ZlJj+tbvlvPeaFruOvjwo0Xr2o0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gckZMlJz4HFZGKzbxs6Y2ZE/018ImfxwZrhCzmoyqvE=;
 b=jB4g9oJ+R5jKiAey8SuTwCEugMLq/H/KSMrjM0xoUzVy11P8BGEULYP2RmwrAkE5aJH+VFgto7tL680pTSjSE1mr/b2UAwIcH0k1Z261wvpA74zhUWNqXUpKGQ6MRNl48CEoyAC9/p2p+st5dTpmNh26ChC8JhX72xKmBto07qBNsRZHSBmJBtppmYjeBxZHmL44OAYSitvrNgdZToU9lcqCzlu9VMlRUnzulcSCBlKM/+8XKpATKB62sRUNWF48sFOtAElvPrpfy+oFPkhaZLSgCmUb5ZkIxEn0ILzP7NAY3KRqvgl43KbZ4wE45uyve0XHtIQri0o2aOtNTW3uJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gckZMlJz4HFZGKzbxs6Y2ZE/018ImfxwZrhCzmoyqvE=;
 b=w6mBjvilfUEru0DT/p+TY18zJ4Ong3teph4/j8MFfAodGgp3xLe/f/3ydtEA6Em5bQdivo4gemL0HeMFEYQMtxT7lbTqlZO2x4bX8dEM2quLSkLSR5TpDf3Kl3mtYTw33a6LaPSKuFpQA061Kt0p2ZwevUx6u2nqabKHxtULkCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 11:59:31 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 11:59:31 +0000
Message-ID: <c7b4e115-91b6-4964-ad4a-58e8924997a3@amd.com>
Date: Mon, 10 Feb 2025 17:29:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] cpufreq/amd-pstate: Show a warning when a CPU fails
 to setup
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-2-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250206215659.3350066-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::7) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 936e2076-d5a0-495c-9f1c-08dd49ca6045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWhNeGFscEl0QS9xZ29lQ0FOdUdSOEM1RlNWeW9hMVIraXIwVWhUTWFjMDNp?=
 =?utf-8?B?Z2xLQ0tZS3R6WklLRmc2KzBFRENGNFF2Vi9kZ1o5VitTakxUaHpWWkk0bmtm?=
 =?utf-8?B?d0h3bWNGYTRWUGNRTlpEdlkvNUhOYVVLaDgyMm5NSC9aQWtISU4rZU1XTGFW?=
 =?utf-8?B?a2dwdy9zejJUTHI5dGRKeDlsZDBIM1ljVzBKUm5Cd3dpK1YxN2RXZzZ3WXdx?=
 =?utf-8?B?emV4NW1TNjlPRWdGbS9iTVU1M1VLRHdIcTFVdkRWNk1hKzRKZnVLekc1VW9w?=
 =?utf-8?B?U28xS3hoU3NDbXpjUXB0KzhaMjltQ0h6Z0JlQk1VNXpaZ3FZL002cVk1M3gz?=
 =?utf-8?B?Z05mbmdYSktQMXdxZlBPTE10amQ5QWU2Ymp1NTFMUXlUalM1YWJwZk96b05L?=
 =?utf-8?B?NWhBaEFhQi83anprTXdGQWlrZ1h2N1YzY0dvYkpWL0hXSlkzdUgwTW95ZWly?=
 =?utf-8?B?RUN0TFY4SzRudUR3RXg3QXVJMTZVQTROQnA5ZGtmWjhLNTd2WGhqQmY0azlp?=
 =?utf-8?B?Q3JUbzNzMVBBMnp0Y1lpblY3Wm1IMkc4Qlpzb1dSOStWRGoxMEhhUzh5cFhN?=
 =?utf-8?B?VmE2dkpyWkxTZlU3Slc4dFl3cWhwc2IrZWNlcmpJNG1FQkJoeFJBRnQwaTV5?=
 =?utf-8?B?T1JiV0gzTnQxcW5hWkJERWtNSmdSVXd6blBSaWxvMk5tcHVLNkZ5aG9FZ0dX?=
 =?utf-8?B?aEtsQVRVLzlrSUIwdXFkUUhmbkwwRUgxUUhDVGphNzJOenNOV1pXVHUwdGdI?=
 =?utf-8?B?SDlwUkhwMWM4cmJRbXJJMGRneTc1QUpYdVNvVVdnR3NsbzE4MXRZV0ovK2l5?=
 =?utf-8?B?WlB3R3lSeklQS2NRNnFWSEZJbFFQQjhuQ3ZEWDc0c1d0OW1jaDJlbkpwMlpv?=
 =?utf-8?B?VGFtZFRwbDBjbHFKN0lUdWd4UGN4OTZFTzZlNFlYbmdqUjZkU2JYanZhamh0?=
 =?utf-8?B?YVJ5bDdEQSttaTZYT1hZU3phNzZ6c0tTNzd3K00rOElLcmxub3pRZnUzS2Rj?=
 =?utf-8?B?czRJd0ZZUWhXNjhCZEtZdmRianM3ODhBb0YxMDdNWkRzK0t6aGZ5V3lhTGo0?=
 =?utf-8?B?NmR5R1JLRVpaRE9TUzJ5emtiTVdWMzRvL1pESGlnbnlsOTBxSzVrYlF6TVB3?=
 =?utf-8?B?Q0kwcXQ3T05GV2xLN0g3cTJIVzUrT2tJeUl3dkhKblgzUGN3MFNaSVNvYVpT?=
 =?utf-8?B?K0VrakxYSVpNVXY1WTJFU3ZlK2JaUFBtZUduMjhRZDNLVXR1MEFKaTFMSTZJ?=
 =?utf-8?B?dFhZYXplNE13STFwcldlZnJmTmN0K1NUU3BKcStDSmlHazlod2MwZ0VPL0I3?=
 =?utf-8?B?cGdIY1BoTXZ3Q2h3NUFGakxCWUJYQkVMaVQyVE1hMFVmdXhXZFp4WlRxd0t4?=
 =?utf-8?B?ZlBydnNBVGNTWGN1eWMxWkkvbmh5d2FUbE1TaWN3blpjeVc1d1lSQVowek1J?=
 =?utf-8?B?SUU4ZFExeG1PbVJxMkphNVJYTVNEZXdUODZ6WjFWSFJnV1N2NlV4aHAxc2tD?=
 =?utf-8?B?aWNJSjBTdDhzUlN3bVVNMzhiaWRDcHJTcmJyNlZnTXkrSmtQMkhTTjZZTS9n?=
 =?utf-8?B?eHN1bzJSbWpjYjlJVjljdS8vdDNlNGVoV2FqdkQ1anBEU21kZmpRUnB2UFhn?=
 =?utf-8?B?akx1Zk1KN1R1SUxSNDRoUGFDekFHZWRBbnI0UGx5RHVhSTErd00zNXMrZTkx?=
 =?utf-8?B?L2NWRHhabWJGVm05TFNIWG5WVXY4VnVCczd5WXZOUWdlc0UxbUZJM3FOZjRO?=
 =?utf-8?B?WWhOZEkxSmxHaXVWYjlWTk1pNkt5RDBWNG54N0lFYUd5SWk2UXhMam5DbW1P?=
 =?utf-8?B?U2tQNUtKSWZ1bUNTUlU2RVJSNkU2dndxdkJiS0N0cDVuQ25UVTR5YkM1ZmtK?=
 =?utf-8?Q?0hh3UqeNHTvFy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGVkUDBRLzNvK2Fwc1ZKTjdaelNrSHh2UkFLM0NKQmZnTVRXL1pvSmVRcE5v?=
 =?utf-8?B?V0k2QmdJdndUOCt2ZlVBMmtRa25WeFF2SytiSThUakQwM2xZQSt3N3FQVFB5?=
 =?utf-8?B?QlZDYVBGK3dQZjlNTVNpcGU3Q3NCQ0h1aWdHYzgzcGVqa3hzTkhOQ2hHZUFN?=
 =?utf-8?B?NGdnbk80UElKYVBwemZoMkt2L0pnaXpYRkVHM2loZWxBeG8wS3dhbVA1bW9W?=
 =?utf-8?B?VjdqcHV0WCtlbDVHYWloVit4bFF1RWVhYlBQUmpKV0hXQUY1cjZhVHFoU2RH?=
 =?utf-8?B?RGwxZ2x0QS9yR3gvYTA1MlpLaTFlVFo4RFR0UHNUYWwybm9TUU5sTzE1dVFG?=
 =?utf-8?B?ZG5MY1FiR3doendTSXJVZWNHVytaLzNkSkwzeElkbXhseFNnU2dFZlAvZDlO?=
 =?utf-8?B?UXBybThmODV5VG5FcU04RzIwWlZUSTRXc0w5b1RPWGpjMDZSZTd2U3lUN08z?=
 =?utf-8?B?S25BY3pmclVUWmpzWE9aMExnMHBHNDNPQWR0ZWduK1dialB1bCs3SkZYQnc5?=
 =?utf-8?B?VUlwNWI5WTdkYXhWY0ZidnVpdFF4WTBoOUQxMFdyVlBoZVIzV0JlbGtkakxG?=
 =?utf-8?B?ZVlSNG9XdWNOc1RWWldXWCtOOEcwS0NPaW9wNHg0Z2VGejNYSGJkRHlHaWk2?=
 =?utf-8?B?YXVTb3BIZ2ZRWXJoR2k2amVpVnltNHF5Lzgyb010MVE1dk0ySWZHNks3R3N4?=
 =?utf-8?B?b1JFa05UcG10ZktwcmEzVk1uZXBxNWhjN3NhRmlVV0ZPQlJoZkZwaUdlemJa?=
 =?utf-8?B?cVozQWdvOGJ3anR0WmlOT1I1UmNodXNjU2dEayttY0NvZUE0bVgvWHE3aXRT?=
 =?utf-8?B?SVk5ZVJCd0MyVFpMV3YwQ1dEZm1SdGgvbFExWDg2bHVCMzBBU0FsTXM2dW1r?=
 =?utf-8?B?OHFWenU1ZGdycE12MkY4cFF6cHRxQWNZZzdXVzZSd1dsaTZQVkFMMlN1Y0ZU?=
 =?utf-8?B?L3hYbnY2ZE9CN2gvWHpyTUh3M1J5cDB2MExwalVrRVZDMThBZE5ZY0Z4UFBj?=
 =?utf-8?B?ZmxOazEwK3dld0RZdFVib0xkc3BRZ2w2T3p6ZWNxZTU5TmdQMmR6WGd4U3N5?=
 =?utf-8?B?YThNdG5rZWhwYlg5Y3kxUEVqeVdFdS9ROXNoaTRXbVlDU3NnSXdqNmFRM0Ns?=
 =?utf-8?B?dnBqaXg3S3NOWGFnTmdIMkg3UUx0blJCN1JkcjBudmFSeGVIcE1qRWFZVWtI?=
 =?utf-8?B?aThlRXFDTVpWVXdjUkZOYnRPalNRcjdWY0ZSRjRVVkRPaWkrOWwvbGNnc2ZX?=
 =?utf-8?B?WnNJb05IU0NJNk42ZjJYQ2FYeHhiYysrelZsM2doY09henRTZzkrWTdLdzZM?=
 =?utf-8?B?dGJnY2l3ZjJrSkdxQmgwcWlGTUdQS2pjYVFpL2NTUXN1T2dFQjZiN281ZWky?=
 =?utf-8?B?bXFMdjBuSUlsRjFaNVp5d3gwVnV3c3kzeWRubHVSUHFtb0RvSkV0MEVEOXBO?=
 =?utf-8?B?Mkg4K3ozUjNaVG1DMU9Dd1BQSjA0alllMENETVE2QU5qYUM4Z2tLL2lSc2lm?=
 =?utf-8?B?UjBKZERKZTlnSUlWNTVkVFg2QzduV3N3QkV1SmI5NUJDZHFnMXo4bkNUbUtJ?=
 =?utf-8?B?ZHBHUzJPbWJYQitML3BvT2FWTVUzVDdIQlkrUXRUM2k1RnBaaXFZMmpBUjcv?=
 =?utf-8?B?RGJlWXNKbGlZOGFoaHN3ZzhxTTJZNWdOYjFhbGtoM1AvNFZOR1BzRHpRcURS?=
 =?utf-8?B?WGFYb1Q2N0pnT0oxdnZON2dUSTJhOG00RGxwTDRTMTFQTTZwSU5rSEk1eWRW?=
 =?utf-8?B?QnJ4UXJJUU41UDhVaEJLZzQvYkh0WDk3Mlh5L3RTY1dRUFcycDhyVG1yYXhC?=
 =?utf-8?B?Y0I2aWxlL3pxY1A2YnJEL3RTOTdNWnhPNnVxQm9TMmZIMXN3N3RmKzQ4dmdK?=
 =?utf-8?B?WXdsYlY0M0JKRm1CTmh5WXo2ajF5MUNqUGcrSVp5QVpmVlpXenQwZkFYVWx6?=
 =?utf-8?B?MG43YjErekxPNkxPUTJ6UlJmMDJVS2FwdEE4a3d1UFdSOHFsdnY4ZWdkOUR0?=
 =?utf-8?B?U2VqcVYxNVJ1R1MyWG1jd01nT3NGSThmR0EyTm56NEhmVjBKa0FPOFByYlBq?=
 =?utf-8?B?b0YyemdFM0xSKzF3QUZQQUp1MHUzY2ZYZ3Nta2NFUHhrcGFaQnhYd09teklq?=
 =?utf-8?Q?f5G8fg+b9xboE8o1eYPzWYWTC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936e2076-d5a0-495c-9f1c-08dd49ca6045
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:59:30.9633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBGZ/CYtctrjfpSajK9rRYX7IRR7SN/llbI6jYECNVNA2UbZHN1Pth1SbXKjI7H9kP14jQiYL/i72zFna2WolA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870

On 2/7/2025 3:26 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> I came across a system that MSR_AMD_CPPC_CAP1 for some CPUs isn't
> populated.  This is an unexpected behavior that is most likely a
> BIOS bug. In the event it happens I'd like users to report bugs
> to properly root cause and get this fixed.

I'm okay with this patch, but I see a similar pr_debug in caller cpufreq_online(),
so not sure if this is strictly necessary.

1402                 /*
1403                  * Call driver. From then on the cpufreq must be able
1404                  * to accept all calls to ->verify and ->setpolicy for this CPU.
1405                  */
1406                 ret = cpufreq_driver->init(policy);
1407                 if (ret) {
1408                         pr_debug("%s: %d: initialization failed\n", __func__,
1409                                  __LINE__);
1410                         goto out_free_policy;
1411                  

Thanks,
Dhananjay

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f425fb7ec77d7..573643654e8d6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1034,6 +1034,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  free_cpudata2:
>  	freq_qos_remove_request(&cpudata->req[0]);
>  free_cpudata1:
> +	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
>  	kfree(cpudata);
>  	return ret;
>  }
> @@ -1527,6 +1528,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	return 0;
>  
>  free_cpudata1:
> +	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
>  	kfree(cpudata);
>  	return ret;
>  }


