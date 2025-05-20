Return-Path: <linux-pm+bounces-27404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB725ABD421
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 12:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297293A19B8
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 10:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC7B26A098;
	Tue, 20 May 2025 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZpYdZ1cN"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8D213245;
	Tue, 20 May 2025 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747735428; cv=fail; b=rpHn2sANdfAi2KlnvXktqDk1sbSFyLExJ+L7iWtnmDEPdhO0BWMIHORqxAUYsUElxnmrnXXUnq8WkOR4Kna10e4RbXzg31deooLXRCb4D/EKw6uFpYqBhUGCF0cDNkxutZ9UHNxbNkqRGBnKra41Bg0a3o03mr/O4evz+Y/GoNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747735428; c=relaxed/simple;
	bh=9aJPlnh7yq3FGe+mBxo1qkiWEFr5varPn8bJqiC52JQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GY/pIg3vhCAIlX08OwyUiu+Ay4cJQdatXRIHNfN7c4neTI2QIHy7+E0BWhil6BCkIfToHzlja+cn5+KS3cze2Vjly2nsIoaCMfnoPNIy5RoKqiyMPfaasgcjU38V1kmHL1mXVsttMqnQbbpm6nGU4NhDy+esh7Nwv1qA0AqtuIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZpYdZ1cN; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBnFATb0aDwu8IZzGaXIbUw7qPa/giIhq/O+hCtW3zC0014HLLliThl1bLtDFjuUQJ9lKKFq8Ooza61SA2G+AiWxznShjK+EC1nalgh938x+JhlOgCB5SPoBvJ53NMrX98F9g6Ypq9zVpA+i5afZ9h08RFcBVQhfShDS87RDBUU1s+ZXhZsoM2aFPcghhoYXdsCN5QiFQBT5W4v2L6a+4N1tmenLr4tuVao/Q7qtGmB3yrn7qK6aEfkqoknL0h239Dc/gG9MwRFGQ8VRsX3FwqhydklWtA6Ziw/n2CStBIDU5ciwCQQWZNrPUBXrkhHXVzVPlqSWGYVxFyhRHkfkjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8whUdlZA+GcwGw0LwYWsgGyMkvEwRLb9X3VcqEdSMNU=;
 b=B5khwoIHkyeQ2rbWjrOemclaW1/TwjtbDhgeIU6Ea3j5306rp6jKJpFz3ceM19OK0XvSUwUqzfVsaVtzaFw9POKKA70OSI/b9+ojmwdwLfJ1B7icjS/hGSqIsTgTRZNQZAY6zCx30D/gy2W6Rz/KnWlACMh6hKouQrSyKW6TjpMxfYZsBY1bBLz2ItEHKLWAbiiPnUNdXPBW2XUCfLkBbD/d/4J8uLV5GcVqF3RM0qvLh8+SHaglCuFN2GivrXIy4yKVs9Ujk7LL4WyXD2A9xo84jZibyN5KYnXZMRWj6QtJlDJlXeWNGXFqQkynenZzUqxsL0wyC242ZwrXdV9y6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8whUdlZA+GcwGw0LwYWsgGyMkvEwRLb9X3VcqEdSMNU=;
 b=ZpYdZ1cNvWAAITDAIxuCcexV3VpSXZWp6Wvb4MAIXhZNEWEIlob1zmi7H8/PsDGQd4m9N6VH9OVKK3XA0vn5CBRY/rnYbtbs3QTXf5MK1OvnaiVv3us3eaz5RQAjZtUmTqbJoCOA7S/InRN0xejpdHTjpa0xVOvK0FRaSHh4L1FQ+4QgyP0o4ykP360hVDdmwvEzMD0Q7PQb3MIcjTodylFgfNSoMtRbn0Dh/sniCqZtl2bIUNeMaxR48GJDBpqdgIIf9C0MrnJ/z48F++fMq/jN1AuzJFhwy1A9jNYGVnwL0LOBQg2bEqF7/OIr1YwS/KZYeOsmch+3Eq7TEzhq0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 10:03:43 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 10:03:43 +0000
Message-ID: <972984d6-a9b6-4847-be76-fca50782682a@nvidia.com>
Date: Tue, 20 May 2025 11:03:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] cpufreq: tegra124: Allow building as a module
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: webgeek1234@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com>
 <da080e61-4e54-4334-a239-1619bf8fea0c@nvidia.com>
 <20250519102618.4thbahapz3lfmfo5@vireshk-i7>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250519102618.4thbahapz3lfmfo5@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0158.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::17) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3e0bb7-baff-484c-0371-08dd978599ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWQ0R3h0aW4wZVBvcHh1ZzJyQ05JMks1VFgySDc5SkRkSFhhTzBVckdyNUpr?=
 =?utf-8?B?VmdKSEVkMitJSUdkM3oydi92QlFIV09iaTR3aFJXcFdVUXNSMGZJbWUzUDJE?=
 =?utf-8?B?aTgxeWl4MDhXVkliZVdoa3pRaE1mYnkvQUNSbEc1SXIrTlBVcnJDWDl0TXBS?=
 =?utf-8?B?ZHVsZFJyRjZxU1UyL05NYyt1d2ZVcXpTQzh4SC9hSDZSRVYwS01oVWRpN1RF?=
 =?utf-8?B?YkJrTjJacE02cDVsN1BEUkd3Z016UnRxdVJuTWRnUWY5cWdsdm1RNXNqT0Vn?=
 =?utf-8?B?UEYvbGVwcUJYZERDczZXZXF6TndNaytaUWZ5Sm9xc3hmdlplaTk2SUlpRi9G?=
 =?utf-8?B?UnROcUYvL3lpa1FlaUNjRm1zcjdJM3k4VTg4RHp4eHJhUHRSdFYzWHBRSW05?=
 =?utf-8?B?VnEvMUNWdXlOOTJZQUpmbXh3TVZBTGh3OStNd1RXSUxTY1dqQUprVmtxZTdz?=
 =?utf-8?B?NGVtSTl0cEJ3d1F6bWN5T0NkTDlxOGgrWDlZL3k4ai9SaG1qdlFUbW9oaE1O?=
 =?utf-8?B?K2pySHpMcTdzUkdKL3JVZktpQlVhU1U5ZS9GZGUvVDRyRGVCbEU4UFhieEwr?=
 =?utf-8?B?VU9HQm1RVE5xZUtMU2JCTEl4UnA4N0U0Um90cnBuMTlSc2t5VzdnQThvYmxr?=
 =?utf-8?B?TlA4Q0hRdVhMTTlTbGFQUnE5YTVGU2Zqd3RWQWNjLzFDbkFCRWxJWUhvVkJK?=
 =?utf-8?B?MWdTMjZ5R0FKNjFwdE9vdUFQTHVvZjN5OXBjU1Q4alBYUXBYMWgwMkpQMnF5?=
 =?utf-8?B?UHFXTTZGMlQxVG5DVXFtSzlUR1doMitkbHdNQ3FGVVhscmhVN20zQjZseENv?=
 =?utf-8?B?NjJlSGpRVVJXbmt5Yko5a2ZLQ0V3L1ZFZkpncWFwWk5HM09lZTdnVGx0U3hy?=
 =?utf-8?B?SVlFTGVhdjBmL3RjcmhYRmhBUGdwOXg0RGUxT2lwQnlLektYZVA1dGg3MFp3?=
 =?utf-8?B?cEoxUXBvMDNyTzlkVzBZOVdYOTFWbjkwV2Y4NFdiclhZZTVxMFg4eFNDRUl0?=
 =?utf-8?B?QXIrUCt0cGlrbmVHRGVtRHQxUjViR2hLUE45bW5sMUdNMy9sZEVuaUdaM0xa?=
 =?utf-8?B?c042aEl1TGxmeHpLTUZVNk42aHpaOC9TV3NIR1NZdlZLUGF5d2dmMWlEUjN2?=
 =?utf-8?B?cUd2OWJiSThQMVUvR29xYmxuSGpFTzJRZXdqUmhXS2t2MWJQK2tpQ0lpVEdZ?=
 =?utf-8?B?K2N2aHkxdUIxdXFoMkhGQ25XbDN1aE0ra0FoWFRGd3pnTjdXbi9aQ1BlY3BJ?=
 =?utf-8?B?WnVNZTRUL2NHNGhBQlBaN0E4MG5SZHQ5QmxseHZNKzk5QkpGTVNTYlBHZ2Jo?=
 =?utf-8?B?UVdHb2NZVHZ0KzNmTWFDZkYxc3ZvOUlQUkUvUDZvNXNXNTE5YVZyZWhWZFVr?=
 =?utf-8?B?ajJjUGxxMWM1clRQWUxpaTczdnR5dDdHWGJubGhQb3l1NTg0VS9HUnRSSW9H?=
 =?utf-8?B?VVBmbW5hZERyUThpWjlPKzZqalV3cUhxZnltSE5GNUZuS1dEcEhRd3BvRm51?=
 =?utf-8?B?aWZLMW9MODh0aDdRM09XQUZMeFlrR2ZtU2paTHlUMTlES3NaQWNWSnBhdTNk?=
 =?utf-8?B?dkhzTU95ZjNDUVBuUVJ5YXNQOHVXQzBMb21salpmUDZudkJOUHVtZmdGQndn?=
 =?utf-8?B?SGEwd1FSYzFWMFprSkNhenk0S2dGY05mUXhxc0x5alpTb1UwYTRGYlBSa1Zy?=
 =?utf-8?B?TlpZMTZnYUJqNGx0Zkd5TGUxeTJKaDFMRUlMOGE2a1J6L2Y0MEVRdGxaT3pS?=
 =?utf-8?B?UEhWZEZJNnJGbW5ic3JRbzNzTk9OcGhsZDYvOHl2cHBuN3lPdnpqakM5dU9H?=
 =?utf-8?B?dmoyS0Y1TXJmd0gyZkNFZGNUai9uWFlxYVU3M2hHeklhQXJ2bXppR0N0UnU1?=
 =?utf-8?B?TXFFa09mMUFac2d6TlVnRmlOZFhMSTJEWkFYTVFUN2JzZ1AvblA0L1JCYlVS?=
 =?utf-8?Q?uW1HGLeFVOI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUJTcUpaM1lVbUtNVGNZT3VMdml6dHdaNTY5dWREVDI5dWk1UEVBVDNMU2hQ?=
 =?utf-8?B?WTVaNGRQQXpYa3ZIOWFERytRTnhqSFlwRnpISTBZZFRaOE1WWnd0RHFCL3Np?=
 =?utf-8?B?OWRqM3hSWGlENSsvRmRDNXFRT1BOK01nVElEVElrVmRIQ2lnT0U0cHBDMDRy?=
 =?utf-8?B?RExlVG9LU0xrUStDZUVjUUdwUm0vVlpkekxhaEdNTkFTUHMza0JZaFdueGFI?=
 =?utf-8?B?V3Z3cXpyYUtDcHRsQW9xNlFCVUQxSnRBaTdUYTBLemdpdGlOa292OVdKVlFM?=
 =?utf-8?B?TTBNZDFTT3hiZEVLSVIzWDJjbmdxc1I4dVJ4UC94S21ERjY4NTIvdXdlOUM1?=
 =?utf-8?B?c0FjMVJ2WnM1L0U2SVd2VnZMVzlhVllyVjVObnBGbnBtUDFtR1B4bmpPbEsr?=
 =?utf-8?B?ZHVhT3AwdzU1bkNZNGgrcVpaQWxhOEI3TEtPTzNwVXFhMFBrb1JWQnJKMXNN?=
 =?utf-8?B?T1FmWGg4Z0pFSkJvT3lMTFFIdUx2TmF0WUtUZVQ0YXpKMDB6QUlYaE5SSEN5?=
 =?utf-8?B?QTZ1NjNHNlIwWWQ1OUs4UWd4R29DczVCVTNVVGFiQWRDbEZQK1ZQWXR0enVz?=
 =?utf-8?B?OERIQ1Z2THRPeW5ITFVzTjJKa1ZMZXpncUVGaERyMkc0cXVxUzRpVEEwenVG?=
 =?utf-8?B?cDdhYWpwUjZPNUVvNkNSV0Z6LzRJT3FkSHhFOWVCTVAxT3pyS3FBczREbCtO?=
 =?utf-8?B?ek9uNVFrOVU5ZnZnWmI5UHplUllGSVNKMC9oMXV4RGRHZ0g3MXhxNkptaVlo?=
 =?utf-8?B?azZhQVdwUnBVb25oM25ya0h4eW42OE5zNkV4dU10WFRVWnRUV0RVVUJWOEZE?=
 =?utf-8?B?TkV5dzNNaDNvYThFQzZ2L3Bob2JJYURKS2NqVDVMRU81b3IvdDBkdmMwV1pO?=
 =?utf-8?B?d1ExbnBPS0ZIaXR5cGM4TXdET2VPSUxmOWdkOTBYcWYvVlAxSzl2TnpNVDhv?=
 =?utf-8?B?U1pkVnlxQUdjN3l3VW14dE84OTNscWJGbUIybm1JelY4bXhpWmJWUm83aXdW?=
 =?utf-8?B?UThjdWVaN2RNVnBOa21BL283K2NtZkRsODd5NXgrWUtQeGFKOXdrdmlpL1g5?=
 =?utf-8?B?ZUxqNzVrYk1xQmR3NTUzenZyZnJEM3l2enhFaHpocmZKVWFxUXZkRW93TzZU?=
 =?utf-8?B?ZzU0RjBubmRUQ1NZMWdydzVBNlhJNkNNaFRoOUtaTmowa3lKUUFrVEl2UE96?=
 =?utf-8?B?d2EyUjdxaGRqN0I3dHFVNjM0QVd3cWc2d3pkS0ZzNFZGN1hMbUpRSGNpa01z?=
 =?utf-8?B?UW96b0NZUkZTK016MXluNkFsVWdxSkd6Mm5WM0xEcm5VUVptU3p6WGp5Y25w?=
 =?utf-8?B?Y2hSK1JSMHJVQ2dnTmhhVmlMM2x5OXpUREpiU1VUYTVZd2JQcFF1MUpCZWt1?=
 =?utf-8?B?d0ZWL1VSRmRUZ0toMDhlUHlDRnp6SmZMUGxIZ3VSSm04cjU5dDVGVHBaazc1?=
 =?utf-8?B?clkvL3ErQ3BoZHNkUWZGeVhoQXpPRDJ5TEpWeXRqanNJbGNCYUxDb2hxL25h?=
 =?utf-8?B?YVdteURWSk93Z0pGMmgyRW4zbHFKU1ZkZVdobE80eDl2cjgvOVZ1VnkwS3BV?=
 =?utf-8?B?SnNVZEgzWVRSNXE1UWNiWm9OMW1zT1YwVk5rNkx1KzlpTVc5TjBwTUFXK0dG?=
 =?utf-8?B?c3VlSlNGbVhING1Yak5ETkFrS3UvSHErYlJHeVhMTUFBOEQrNnUrSmFDc1Nz?=
 =?utf-8?B?M0ZJVWZVN0hveEZlekkrYnRuZkxTQ2E2MEw2eDhCTjdFMk9tdWxJeVdJZmVL?=
 =?utf-8?B?T1p0clJaRzNidmx1cVVYQUcvNG9ISFBNTzhGazJSak9KSWNhSm1lNzRTcmxs?=
 =?utf-8?B?QjZaeHk4SnNzYW55a2duRHRaaS91THhsbVdTbW5WUzcwVnZNMDZKRit3Rjlu?=
 =?utf-8?B?YzNqRG9Lemxjb2F6WWhHUEhwNFBubExsK3lxWE5xUFA5OFM2bjRNVkpFNDAz?=
 =?utf-8?B?eTBXRTJoVTdaanRYc1hKYXZQQ3gvMzZGODZRZnpPdUsrT3pPaWxNcEdOQkk4?=
 =?utf-8?B?WFBXM3dZRnhDZFVHZllZcHJiVWlvUllpWmVuY3JxZFBuQmdGS0NUZDg1ZUdr?=
 =?utf-8?B?Nlk3YXdlL1hpOGFuK0NwNlJyN2xDNjgrTVBXZml0blUzSEdzQlZOK2tETTRi?=
 =?utf-8?B?b1Jncmx5NU1Rc2ZXekJNR2prVW15bGhIV1hoYjlRYVdCeUs5cFNaRmJkRk1B?=
 =?utf-8?B?L1lLYUpLRlBKN1h5T2x0VkU4YnFJbEthQSt4ZTd3ME9EZ1ZFWVdiWXRTVmZS?=
 =?utf-8?B?ZzJSVlZxMzk0amREYzduMHZuUUFBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3e0bb7-baff-484c-0371-08dd978599ff
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 10:03:42.9320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIsjofV3H6oKL38eVMiGlFddIJ13nOPEHRH0ZA/JvygpS5EaABiGaHx779j3fzNuEo5s9qPlIC+XNiiR7DM4EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920



On 19/05/2025 11:26, Viresh Kumar wrote:
> On 14-05-25, 11:31, Jon Hunter wrote:
>>> +static void tegra124_cpufreq_remove(struct platform_device *pdev)
>>> +{
>>> +	struct tegra124_cpufreq_priv *priv = dev_get_drvdata(&pdev->dev);
>>> +
>>> +	if (!IS_ERR(priv->cpufreq_dt_pdev)) {
>>> +		platform_device_unregister(priv->cpufreq_dt_pdev);
>>> +		priv->cpufreq_dt_pdev = ERR_PTR(-ENODEV);
>>> +	}
>>> +
>>> +	clk_put(priv->pllp_clk);
>>> +	clk_put(priv->pllx_clk);
>>> +	clk_put(priv->dfll_clk);
>>> +	clk_put(priv->cpu_clk);
>>
>>
>> If we use devm_clk_get() in probe, then we should be able to avoid this.
> 
> Not sure if we can do that. The clks belong to the CPU device, while
> the devm_* functions are using &pdev->dev. The CPU device never goes
> away and so the resources won't get freed if we use devm for the CPU
> device.

I don't follow. If they are allocated in the probe using the pdev->dev 
device by using devm_clk_get() they should get freed when the platform 
device is removed.

Jon

-- 
nvpublic


