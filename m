Return-Path: <linux-pm+bounces-7592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA378BE6A9
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 16:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A871F21E2B
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E9415FD1A;
	Tue,  7 May 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dj+VIsXb"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4315FCF0;
	Tue,  7 May 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093744; cv=fail; b=Dy2xSSLNeUUbHtS8rM3U9Q8yuRUzbWlwkXxjNL15TsZBYegH5J5R2lRmGP7rHMRVeWQU3ZAwaQgcetV1SfbcIF12WJZTjChvyKJ3exlRpagJ8Ch6SM+TKgf4xNvvp0j+CbSYW0dnWgdmU5VcFjOiDf16IQdQBCjpgVTIlkxQg+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093744; c=relaxed/simple;
	bh=nh6bSr5s+R49QUJ0A8f5s9ZpS2kxhaPKMnLZSsqrVrw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hcUqzgWmntp4cIm8yI/ymrXfdECdV+7WWRa4fvrZWvdNoghz7PFRAvZ7fcYK8xzlfBV4e0/UkNIc8jwvHCd/vdiDUMQUsT8bEOB82LezJnPbMpsJVvkM6UxdtzLm9CpFZKKxuZ4invqBG9T16HgFt73R5L499TAv9I84Kq0jcz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dj+VIsXb; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dK7WnO9ngVoaiun0/Y+jX4DwAs5ztWwQJ6gHakPHJoA7c4v6boU62P07h/i5gdZ06EtSRMzaXou8KOMzceS6WWhe5CgNRUlvK4fu9bs2xvV/9XnR/efHgRIg8ANpuR8QCZBSk/GW+NSwyGrXQgOI9nvlErvyn0Iym7d8HPMp8Xi6jUzRmoO+bxszHnOF4SCG8pbMJXNEVUGJxEi2hn5wZQAalxtqEzmBTBDpv4iYn2s58Q30Zk1B7NYHVv/QH4bKCebdC09zd6V2BbbIKjw8nwCQRTFv7sf0XDy5Erfch2PEjDnzft7Og9FvexkxEVeUs2PASvtaGyYugRRdPK7FTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtdJ67AAhr4VZW19n2Kz9BYcuuldQ71mkQmyt6XAlOA=;
 b=JFG/NIgQeiDFUFh5W63TLBZg3dUPkqMjmVLSiWZyh35xwjjIFdnnye14Sjfv8eG8Suj6+LdBMK5xpY7lQMqrODAMnlhwCr7qH7i61520BKze92dM33vHPa27KowVcZfpDwnADZWt4PEoIMXzHVx4TW1JFZZMEjHbLGZeS8PrISzNWD76QxYe18wFGlUSTuWLbkPktjZbuqCI/5oAkzTnbc9uiI38Z0zJ5KHR/XO2+ntWGOYrQKwOhK9Aix/gUoCMDfPaF6LPA8UtF+V7zyJZBmQ7wkYToxewQO5/WSDAOrPX0Ivfkyy90y0HMhgy6SwBehrCtpV8wV7gunAFqy71EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtdJ67AAhr4VZW19n2Kz9BYcuuldQ71mkQmyt6XAlOA=;
 b=dj+VIsXbPygzN4EziIHwu+OCB8o78oJ2Aa/QIW4v58rxrWYnBb5UB5cFpeUrbAQXFyYxmN3emLIW0ie6x5oFiwXy9RwttVipKxcJQNQ6MPXHZigXPvrZFvON6HJMCiKcJSLyCexnUFL0H+LkI2WRJjouzR0ezQuGoexSDnn6O0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 14:55:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 14:55:34 +0000
Message-ID: <66bfb2f2-074c-4d13-a3d7-56c6558f7010@amd.com>
Date: Tue, 7 May 2024 09:55:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] cpufreq: amd-pstate: add debug message while CPPC
 is supported and disabled by SBIOS
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1715065568.git.perry.yuan@amd.com>
 <0ec1b203bc83c1acdaf1c5a2f3e51031b4374da2.1715065568.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0ec1b203bc83c1acdaf1c5a2f3e51031b4374da2.1715065568.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0165.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 818996e9-fa75-47c4-49fa-08dc6ea5bfad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0JlejN6V3MvL1dzWjhoUElaYkt3M0ZIcUkrM3ZnU2ZEdkFHQ3h2YkZPTzM2?=
 =?utf-8?B?R1NsV3ZBOUloQWtZeTJWR21WNkZmMzNnRHpnd08vdDFaTDUvTWFmOFRFNHdi?=
 =?utf-8?B?NzlkQU1OYm9kdHpMZnVxeCtPMmxMd3NDZ3Z0R1BSRlM4RlU4TTJLWkpVdUU0?=
 =?utf-8?B?R2hTK3UvSnhPQVVKNUxnL001cDh5MlBwQU5mTUlKcDROWnF6TGlBLzdqMXk0?=
 =?utf-8?B?aDFqSllZVlpZcTlGSFhsTFZ5Z2VmYU0wT2JTNk9MTmYvYXVxMHQwMmZzRXRv?=
 =?utf-8?B?L0FGWUNRQzl6dlZsdVJxNU1kZ2RxSGNrUUVHMHRYaG45UzRneXJ3SmZkYkZm?=
 =?utf-8?B?ZHYzeSt4SG8ydXFEbHB2Y1NyTk1CMllWdGdFUWdHYkJoNXVzSFN1SC9hNVA0?=
 =?utf-8?B?T0hJa21IdTFhWnJqL3ZPWlo2Rng5dGQrTmdKN05aVDZSUnBZQjBTdXhSbHJG?=
 =?utf-8?B?a0JBejU3UEgyaWx0ZWNTWVB0Y05yZ3RRT3hMeCtIMjBZSEtQTnROT29jN2VS?=
 =?utf-8?B?RXhvK05vcDZUdXZCV21qR3FMd2tiK2lJOWlMM0dXZDRodjEzWGZqRmp2L29v?=
 =?utf-8?B?OWoyaG4yd3c3b1djcUVRSW9BdFRmcGNEUG1NeSttcU0rWWZEY2dNTGpIZFA0?=
 =?utf-8?B?cGlXZzhJUFhmSkhaREMrbjhwbmt2YkdZenpQZTUveHhtUW9QeElLcWdOY3hL?=
 =?utf-8?B?R1kxVURpU1RtV3Flek5TUnJTOUFwdXF6QjV6UXI3SndocGdvUURrT2crWitw?=
 =?utf-8?B?YzVpME1kWXI2SWlSckpJRTdVVUhqL2ZVOVJTK3NXMVFFM0Nuc3BQMWFPSGE0?=
 =?utf-8?B?bmhJUjlCK2Uyd25jNWNFUGdUSmhDaUN6M2MzVVZqQnhXNm1LQ1N1ckdNMFEv?=
 =?utf-8?B?eHg1NkdnMkZKSXZReTdCU0hIZFBXdWJTSWJ2VHlJUmVpRXBrZjF6QUN2K0Zs?=
 =?utf-8?B?QkcwdHhGM1hzRVBBRTM0WnNFMmJ6L1Jtem9IaWNNK05Cc1QvakdDbVRvdW80?=
 =?utf-8?B?YWUzdm1seWZnOGdqaEVzY2pzVFcvcGgra1BiWVJYai93dWhJK2tXcTRuR3A3?=
 =?utf-8?B?SWpHZnBRVWJFUWVKZEhYdzR1bEt5VXBPekxvSlBHZjBOcFVITENLZEt2bDJi?=
 =?utf-8?B?QUlxZWg1RUIyNnhCWTlPY21kQTJDc21NTGRHdXNXek1VUEhpQ0swN1BLanU1?=
 =?utf-8?B?M2xlSnV5aWhlc1BxaGo4Y1EzUWtwQ1FGc3hSUFR4KzBPeU1XM0thSWlURGN0?=
 =?utf-8?B?WTR6OFR2MDR1KzJKN20xNXRlSmNHQ1V2V1hTL2kzTGFyRXB5YUo5cXpiTlpt?=
 =?utf-8?B?am9ub09oKzAvNWlKNDFyenRERUxQZnNWWW4vUUtycnh6SG43Z0V2SE9NSVh3?=
 =?utf-8?B?ZTZEQlVKK3JleUFCWlJpTEhnaUxPQmQ4eS81QmMxNjd0NWNmU0xFVXlpa3FT?=
 =?utf-8?B?WjBqWEZqSWNYYmRXTkJ0TVk3Tjc4V0w0MUZQYk9FL1ZKT0thS3hGbC9LVWlK?=
 =?utf-8?B?aUFDdXB1K1pWdk5GZHkxblN0SHFFTk1pbm9NWEZFaHRoa1JvM3ZxZHp5NzB6?=
 =?utf-8?B?bEEvb3RPaW9aK0hUeXFtODRnaUFpWWwrQkhUYUl4NjR5SXcyK0ZKdFdHV3dq?=
 =?utf-8?Q?nsmcfttkWlqbRYWMkLLne5ebYpImjn+D3Cs4ZF3GcY8w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2ZSTmNadFVjWWJiNjJPWVN3b1ZIUEdrblRLeFhxczROSUc1cjFHSm5TY1dG?=
 =?utf-8?B?ZkVZeVZHYmNYdmhMWnp1WGx6dk0xbVN4a0pMZ0hpWlNLTGNKZEs0S1BZZFJU?=
 =?utf-8?B?K01WeStVWjRrYkk2UUpncDFvVjJhdW1aZDlORHhMZUI1VjRWWWJhWWN6OTNZ?=
 =?utf-8?B?STMxczNTNTd6N2JHVGRBMWxMTkhKUUNHZysvU0QxOW1ySEIxb2dWUU0zOEM0?=
 =?utf-8?B?cEM3OFZwT09YN3JxOENWT3hzYjNSLy9kajA1alNRZGI5ZDk1Tm5kQU9yRUZt?=
 =?utf-8?B?dnpqUVZMaUJ0cU9melc4dndFSzlKcmhqM3ZadnhJUDExa0ZzTjdqUXkzQVFE?=
 =?utf-8?B?ZWNHQkFGMEIwMDdNWU02RHVTbEdtQWdPaTZha1IzTWpxVzBhRHVLVmZBcWE2?=
 =?utf-8?B?dlI2cHNwSHJ5TUtYcEZTUi9meTRlbWpzU28vbVFQc1hFMVgzd0tqcWdLdjJT?=
 =?utf-8?B?Wkx0dWhoNXhLNHJHQktnTU1FaVJEMTNwNlVTVXZ3Z1ppcTNiOWdQeVN6ZXBh?=
 =?utf-8?B?aE9tVkE4dEUvcndRc0FzRSt4UkxYRU50a3dRZHpuU3lNTlpLTHgwTUZPelJG?=
 =?utf-8?B?VStqSGRyMmJJbzlYMTZiZlQrSXNpU1BIVVpuV0RvbHBaWndCb0x5V0RuNWhw?=
 =?utf-8?B?ejZCWWNnQjVqYWpFOXhmcnZ0RWo2VUN1Q2FxaEdTYzU4WHpmSE54MnJIV1kx?=
 =?utf-8?B?d2h0VTR4MXVEbWFta2VjbjhZSkNiaEhWVmpRejhVQVRyUFhPUXJsZk4rUlFC?=
 =?utf-8?B?MEZhZTBoYlJocy92R1JPUG16YTY4MmU2M0RETE5NbEUwWU1UNURWakwrSjFJ?=
 =?utf-8?B?enNwOU5oQ2dPTitEUXh0UFIrOWdJUmFQNUdrdi9RenVkZUZOV3VOaEF0UU94?=
 =?utf-8?B?Ui9wT0padnN6WXdnR3FFRmNYaFBNUzgyZlJXcEEwenVzSm4wakZXa3dwakFZ?=
 =?utf-8?B?WDJ6ZTdpR2ZWOUw3NnBLa1h0MEhTdVpmTElzUlpQTzg2NHMrdE1BbXFPMTlP?=
 =?utf-8?B?ZHBRV1hEUmhMNWNQSTdxdG5HWjRja3pDbW9ZVlMyTFpFdzd0d0p5ZnNtMEM0?=
 =?utf-8?B?dFpiYVVhcGx6Zm1VdDZ1VEdEVzlwbEVaM21PeUN5bHJNMjkrVHdqKzVvSzNq?=
 =?utf-8?B?SFFEekREcHl3MEZkWUZxZVcrZjFhZDhlYTM4clhWRmNNeHpXMU9NMEZKK2ti?=
 =?utf-8?B?dWZOOHVGNDZXSWM3RjQvYUd0Z0NTU0dQeFI3aUNHZDhWcWJEZUFVNVUydkla?=
 =?utf-8?B?cktzaGFZQ2VyNjFwNFlRVG5IY3ZDaGxUUlhqUEI4TXRaYm43TTVvcStHMWJn?=
 =?utf-8?B?UXlnRUphcW1sWWJMZmZ2dGV6M3k0dTFVaTR4Unp6U0tFUWpJMUNUSk9rbTZH?=
 =?utf-8?B?U2kxL2RyNWQ0Q25uRnZiZmNHYm1weXhiYjFXb3NIYmk3OFFRZkdkeGNHWFla?=
 =?utf-8?B?ZTdCMjVsdms0VnJCRjdCam5JZS9MQkZ2V2NSeXRnd292ZmJTaHdzb29wbjJi?=
 =?utf-8?B?cnowekNyWldtNjkremF6c2VweVBQOHpGVGE0Z2dsSi80T3Fmc0dyRm9tSTRV?=
 =?utf-8?B?NERSamxBRk1SMEthc2JsaTBkUUxadlAvTy9WWDJYWng5Znl0UVZmeG9iQXhw?=
 =?utf-8?B?c28vNS9tWGJPdlFuT2lxZWVOdlQ4UUFwZ0d3WGlWZGtsMDdrdllaYnpodDRP?=
 =?utf-8?B?aDV2RzBLZ2xEQmtUTXdlWTF3WGlwNHJTalVBR2dmQmlla2hYNm4wU2lVVmU5?=
 =?utf-8?B?OHBUeUl6ME54YjFueXMvdFVUSXd5TXF3MmNHRkl5OEpoR0VWNmZEUU5sekVq?=
 =?utf-8?B?YWJNQlVVY3JLVDRUd1pFK0MyMmVQT3NNb2hxUldZVWZyM0VqTWlUMjhJT0F0?=
 =?utf-8?B?QTV5RVlDMjhxdWF4YUxrUVErUGx1MS9HWlJnQ2VkcWgrNkZXczA4bG1Nc1RZ?=
 =?utf-8?B?TjlxdXZVbTRWYTRMRC9DbFpLRzdXYkExT1BZY2dSSUhwYTl3eW5uenRRYUFZ?=
 =?utf-8?B?eDE5L0RsaEJFeHUwL3hwOUxYa2ZqOWhWcHVrNS91U3lzRTNaaDFVVWxyYm9H?=
 =?utf-8?B?VldGamhKTFMvQ0JGeUl1cFliNkpXMEYvdDExT0NaajFyMDNiVlN0M2lkK1Fx?=
 =?utf-8?Q?ZQoIaswcgkuGrZu1GovuFzCgE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818996e9-fa75-47c4-49fa-08dc6ea5bfad
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 14:55:34.5706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMBWvxAaKTFl0xqTD5c6MZHz+w219vCaxQO9vkcNb0GX1BQDADNRrMbluDqu4FvW292lxSj8TlnMVR4i/2WHFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024

On 5/7/2024 02:15, Perry Yuan wrote:
> If CPPC feature is supported by the CPU however the CPUID flag bit is not
> set by SBIOS, the `amd_pstate` will be failed to load while system
> booting.
> So adding one more debug message to inform user to check the SBIOS setting,
> The change also can help maintainers to debug why amd_pstate driver failed
> to be loaded at system booting if the processor support CPPC.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218686
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index cb766c061c86..e94b55a7bb59 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1698,6 +1698,17 @@ static bool amd_cppc_supported(void)
>   		return false;
>   	}
>   
> +	/*
> +	 * If the CPPC flag is disabled in the BIOS for processors that support MSR-based CPPC
> +	 * the AMD Pstate driver may not function correctly.
> +	 */
> +	if ((boot_cpu_data.x86 >= 0x19) && (boot_cpu_data.x86_model >= 0x40) &&
> +			!cpu_feature_enabled(X86_FEATURE_CPPC)) {

I don't think this if statement is correct.  The intent behind is is 
family 0x19 but models 0x40 to 0x4f AFAICT and then family 0x1a all 
models right?  This message will miss any models that are 0x00 through 
0x39 in family 0x1a.

I'll give you two ideas:

What do you think about instead doing the inverse like this:

If (boot_cpu_data.x86 == 0x19) && (boot_cpu_data.x86_model < 0x40)
	return true;

if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
	pr_debug_once();
	return false;
}

return true;

Another idea can be to look at X86_FEATURE_ZEN# to decide what to do. 
For example all Zen4 and Zen5 should have the architectural MSR.

if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
	if (cpu_feature_enabled(X86_FEATURE_ZEN5) {
		// do stuff
	} else if (cpu_feature_enabled(X86_FEATURE_ZEN4) {
		// do stuff
	} else if (cpu_feature_enabled(X86_FEATURE_ZEN3) {
		// do stuff
	}
}

> +		pr_debug_once("The CPPC feature is supported but disabled by the BIOS. "
> +						"Please enable it if your BIOS has the CPPC option.\n");
> +		return false;
> +	}
> +
>   	return true;
>   }
>   


