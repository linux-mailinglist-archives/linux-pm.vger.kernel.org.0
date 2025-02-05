Return-Path: <linux-pm+bounces-21419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C200CA29804
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402C216254A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 17:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA701FF1A8;
	Wed,  5 Feb 2025 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FbyOye/H"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB83D1FCD16;
	Wed,  5 Feb 2025 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777879; cv=fail; b=TQUVhdwvPjCLIwvMH4eDg3rAQ95wOYOTjlsrYo4jbR5u/zAs+ePlEXBgFVrLVtOoLR7pfFnGZm/X80bL9S1e26PoRk1KcVM23E48AkTe5VfHgFNJ/9N8eSQCJqIJ2/YqPC0Qcfn5cbcl3LZOILWuPPO+27Z8cL8sBLXcaVDkPv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777879; c=relaxed/simple;
	bh=cT33qZtAVJPb1ZAu/S0ZuEMjNjuzQIF0Zk63NL+QxuQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NuIMKoyuwHACGUKp0M4kt2l+EJzUWgDxFSlTPYEaQsK6Xj5KqzvRPknaQbHzH0yGlnxCiH3xr3pncqsaIvI7awMWj7YE1eIUMkLvM/f0+ZDIXlN45TNfthRovvvXKxl5CxRtwJcCS8kNJ4m3Xe8H1NNdZc63E6N4lrh9f60d/Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FbyOye/H; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fxc5kQnbjj4gT5F1E2RadJljt7qY8hZ2mcHqYL0IDdllRUdsURp693WogZjVSbfWPAqZBiSUeknxdLxrGJz14euMbrkhDLwHh9W4jBBv+VrBKI10GN/wlIVkszYe17fs8I0xDacOc/zUBkNt1R7szVoFjsEWPLqezofyrvNgJPoTgeK3xopC7/Yxr5GLt5wZYl/Q+ZxG7EyeLVqPFKk45YoYnUGxxUxza+OliYM9P/bKGlKQIcngAJYpbran1n5KZH/v2ru9eKRF1f/2O2fjmWsTyKqZysYpJLDjoHIlDIddqAcNNXh4DJqy+xgrkkO7dPo09l6j+Dwj5Dbvi7x8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPItegaSicYH6bLWUzX5aDS7Ra5AihpqAsLr1WA0Foc=;
 b=f7U+CAfglartD2tzNb4Ivwbq9iuLkPsNsrrCH59cjFZY6BIHnOrjhiMg9kc3crEsHywR6tOS/H7JxbF5AUMV6nuNv+mLse4XsqF7pDbIkAeH3PvJ4iK0RlaLF+Zn5SZIEGct9PFPXjWbl56CqBNrC91iCOuT0abtyxXphdBt0K8O0hFrCLGzSU20xzbcz8HjE++OrwCTJb4mJcitkY8Q7P3uPK+18i/HQncHB/UZJRKbRbDmTm0JBiYgkygSN6C4/OCHgUa8nU679ceKP4etG4p5a44L+TR+b/sI1gTBxntZ4BkrUSNag37Gmy/OioYu103yznNP2FE3TLBcGMim6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPItegaSicYH6bLWUzX5aDS7Ra5AihpqAsLr1WA0Foc=;
 b=FbyOye/HYA/oN/IYBhN7sdBkDnWJz8rOgXEcmikUH4/Yxyy2o7SmSNOfw+5AxM3HA6ZBJv7L25ZnlOkCSnZHBE6RiDPpGabizEO4zCYuvFexruIq9dRFWB2D9sLYsvCyeJ2iHPY0ZCmjFXxMSn/m7EkSvPwmRXcDTRxuq63FVR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 17:51:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 17:51:13 +0000
Message-ID: <0785e275-5c0b-4cf8-b8db-4396a81949ed@amd.com>
Date: Wed, 5 Feb 2025 11:46:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] cpufreq/amd-pstate: Modularize perf<->freq
 conversion
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-8-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250205112523.201101-8-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ROAP284CA0223.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:73::7)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 62aab46d-401e-404d-da1e-08dd460daeab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTlTREpHMWY3OVpzelgyN3JVNkxHL3JPV2grQXZjV2hkSHlnTGZLdFphWjY3?=
 =?utf-8?B?NENmWlJ1TXMwUmhheXM5aHRxd0tnYU5ZV2grTFRiT3pPZmVKQlNNTDNPK2Iy?=
 =?utf-8?B?Tm9jb2cxSEY5SG1PdWU5V1IyamZaU3o4Rzc5TTNHQVU3aXRlSDBrUFIxMnQv?=
 =?utf-8?B?bUxJdVpmdFcraXY3QUhYUXIxMm9mLy9iU1c2VmpBRGVWaDdYMWM5TVAwVXNH?=
 =?utf-8?B?ZEw0SVRSSTFwT0JwMEZ6a0NhOWV0dS8rd3ZRdGVBTUtjYTVCeUMvTmlFamJk?=
 =?utf-8?B?UnJjSG1VN21HTXIxOTNzRUY2RUpIUTR5MW9Wd25PKzM0S0ZHVXBHOG5GZytM?=
 =?utf-8?B?ZEprK0pCWmdscDNjSmV6TkRBV2h3T0RLbC9SZGUrZWpUWTlMQklOeGlnRmQ4?=
 =?utf-8?B?RVJLMit1RlVHMTlYQ0IyN0tXMnBuc091UWU0aE1iUUJzcTlkOGpZVmpEWDUy?=
 =?utf-8?B?bTZJY3QvaW04SHQwK1hjb2dTM1BTRTBURW9GV2Ryd0dUYzRjUVR6RU9xSE0y?=
 =?utf-8?B?dUw1S1psVmRqa3BRUGZmTFJwdmRMRnZ6a29US3Rzck8rU3pHQ2xnanFYdzB0?=
 =?utf-8?B?Q1FyMzZGSFJoZmpVZi9hZjVUejFJWUZBdXE4eUxnR0lEd3Y5NjhyYkNlaHhX?=
 =?utf-8?B?WEhZM3FXWWNhMzdhR3lTS3kvczl5ZWlNMnhlZUR0YlQvcE1QbmNmOGF3Slcw?=
 =?utf-8?B?T2NGOGlTR2xCeE5NZ3RyYzN1SGsxbWhqMXZSdStJcVorcFBJdjdhZnd1NERZ?=
 =?utf-8?B?RUIrWWtNWnJXVDBLOTNBaUpQNkx1cVFBUFM5Q1E5VU5Ic01OQ2VFZ2xKUmNp?=
 =?utf-8?B?UC9JMTVWMUUwYy9TbFVBRFI5SXg4b0l2RWUwcXJzTUJhOTZYTjBzbmJyYk9p?=
 =?utf-8?B?c1NnOWJNODNmR0QvbTcyN2hhNHpqS3IzM2Y2a3QwWUZZYldVdFVTRm1Sdjh5?=
 =?utf-8?B?YTJDWVlOaUl5c1ROM1NrSlNJOEJjdFEwSERRaWxLTmQ4aUluNTdSYzlNS3RK?=
 =?utf-8?B?bGF6NzZCaHJLSmZORU5pQXo0b0VHbmdCbmtmR1BNWUR3TU8ybGMxeURLOVlD?=
 =?utf-8?B?V2Jrc3NEczlmU1ZtQmhremt0cHgrdVE3MGpsd05Cc0lEYnNlOE9veWhnYTRP?=
 =?utf-8?B?dkJkdHVUNnFxMHBmOWVlTFZIS1EvZUhGS2d2a2tvZWdHRnRGMDJDZ0xyTThq?=
 =?utf-8?B?UXFlYVhOckJnK05IMkdPdnBUaERNSGZSYXpwdE42aWtJL1g1RXBMODZsNG1m?=
 =?utf-8?B?MUJmcXZ0TXBYWE9qMFlpTkx2ekNLRnJtUlRPNHphSkFLL1ZvQXFtK2sySWhp?=
 =?utf-8?B?bzB0b29hY2JLUlJnbE8wL1plbHBQM01WdzAycVJ3R1A3WUZVVUdOaHEwRUQ2?=
 =?utf-8?B?a1V1bE1oMGlkTVdZZWtERUphdFZIcE9RY1g3czZlaXliV1NYZkxMUk1ibWts?=
 =?utf-8?B?bFZxWHdLZGtwZGZaOSt2Q25NT3NZT2EvM2hKTE9OQWFlN0NyZCtaRXdNSFpy?=
 =?utf-8?B?TlV0SGxub3gzck9VSzJLMUZVNlVYNjhDbWxpMWlwNXJrelQ2THBxZXdaaUNK?=
 =?utf-8?B?anM4N2xWNmc3WCsyU3l6aFBFcDZ1bW5WU0U0bHU5VVg2dytuL0RPVmFmQW1Q?=
 =?utf-8?B?T3R5N29BUW5US2NEYXl2NXJhQkVlcVh2M1QwbnJFTE1EWUQ2bDhSUFpoVHN0?=
 =?utf-8?B?SVpsMkRzeXI1b2tFa1BhdlBKNW9ZKzhsZGQycEJCNTZXUmVwc0NPMHBVbXpS?=
 =?utf-8?B?dkN1eWxhdkJiSjNFTGVoTGFOaGVrYUg2NlMyYm1BVklUa2Z2UllqcG9CQkt4?=
 =?utf-8?B?YldFbzZBVVJNRldhV2lMdU5sa21nQldDR3pqMGRodVF3c3JJWmxOa3lFeTly?=
 =?utf-8?Q?90+XijjZA7RLv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VngwMDlVUWh1QlVHR1NZQlNtVjJzRWMyd3NyY0dKM0pRTjQxRTNycmxmdHZQ?=
 =?utf-8?B?enhBYnljWWlENVo5Q0JSNXVaYlFaalltS0lFcVUzWmFueVRVZkZUWm1NRzNQ?=
 =?utf-8?B?ZGFwOUlhQXR4WWQ5WUNySmVIZ2srbFpxUUtCSlJsT1dlSzY5Z0E5MFBDZUVu?=
 =?utf-8?B?ZFJJU29iZEw4Z1FhcU00MXB1V3J2MEFFQTFLUUNOL01xRGpNSmNDQWRaUnI4?=
 =?utf-8?B?K2x0bGN5UDlPVXVhbFMyTXR2blk5RFNXQW5hYXdkWHFPN1phd1pYR1pGOVFR?=
 =?utf-8?B?MU9LVmtNUXhYS0JtVC9oWFFZVnJ0M3lvV1NlRGZiL3NHd2xuM1NtSmJmVEkx?=
 =?utf-8?B?UkxXVmdpWTdudXNtRjdXQVg3VytiV2RqbGY2UGVMazdmNHZZNWp4Y1FUOHM2?=
 =?utf-8?B?ck95MzRZZVdnZnAvb2I0aWd5eGtzTmxtZUN4ekVxd0ZjeTd3K2p6OHA3a1Yv?=
 =?utf-8?B?VHF1Z1BmY3VLK1NoUm9IMHhhSlhZUFBtUUxVb1QyeWFKTjdkekFyZHd1bE96?=
 =?utf-8?B?ZDhIano5bHdKeDlZM3NRejY3NGlLVHlBSXJjdWY4cERCcXpVRXJTVGR1MDBY?=
 =?utf-8?B?MkdZUDJLZFVMQmtreHJyWE5JWTlzaHRvcjVVMGR0MEV2bkF1VDdrZURuck40?=
 =?utf-8?B?TXJCNDFhd3pDYkRzSktldktGSlBMem9pSmVwamZoa2lRc2IzdlZPL1N4S2Ez?=
 =?utf-8?B?ZE5zVjFSMjlwdnM3S2ZlVzd1YUdqZFpXS3Eyb2kvR0dGaXRvYklHOGlybTNN?=
 =?utf-8?B?RUYrU0JDSGpMQXhuZ083SEJpV1VEY1c3K2sxaUg3cGIwaUcxZzJlL0JiVU16?=
 =?utf-8?B?S2oxeVBOZWc5MWlmSEhmczhENGxJbHd5bnZoNE5UVkJqTXdxTExvS0szNEtV?=
 =?utf-8?B?RzQ5RHIxeVB2S0k5N1VXZllYWFZobnZpd1UzQzlCWUl5OWpKNHMzeTVmcWht?=
 =?utf-8?B?WVk1bnFGU2tjNUdSZ0NzVHJKV3dqaDIzSnlGbndwTFRHczhaaXlqMnVoY09t?=
 =?utf-8?B?S0FKOUk3d1hQMGovZzNKSUlNQlF3UTlCZ3BTdjFwTWtzMzFHYWlRMXBoR0hq?=
 =?utf-8?B?eVNxZFo3Sm5OeHY0V0RoOW5pQmEyV0Y4YzVxSUplZ3ExeWg0LzlYcG5TZyta?=
 =?utf-8?B?aldibmhncWFzTGNkUGZIZEdIcDdFZlBURW8vVmtMa3I3SFZ3REE3ZjBYdmMw?=
 =?utf-8?B?NnVzWjNJUmdnNjBmcDd1U2Y1ZlVmN2FnOVdGRzBqUmdQWVVQZC9tWUUyRmx3?=
 =?utf-8?B?N0hzeDVsNkp1QlJhemZ4aTNVRy9jdjhiSUpTVVViOUZ0TjZMc1pnZUFmVkNt?=
 =?utf-8?B?ZGtlZXp1QmRrQ1A0WWcxL3FTL0RUVlRFamNkbDZrZTBZM3NKODBUTHpsdWNJ?=
 =?utf-8?B?dXB5QTY2dXZHZ2xDa1EwY3FXdmRreEk5Z1h3amZObHhCMHMxc256UHZLcDE2?=
 =?utf-8?B?Y0NaOHZ0WU9QOEdNdExVVitFQVhkeUx1UjN2emMyVWZLamRoZ2U5ZHlWVnpM?=
 =?utf-8?B?QllWTFhsd1hDRzhFa0t5VUpjSUhsOUt3dVdoekdESFpvdnM4bk5Uc0VQVjdW?=
 =?utf-8?B?VXJlenNqeWxDeWloZGtoM3JyWS94eml3UTd6K1EwNDkxY3BrV0lERDhFNFMy?=
 =?utf-8?B?SVlYTUFuK2VYU0NBc1F1SFJ0V1c2d01xNW9NSGNUendXbUx5ekZmOVN4cTlN?=
 =?utf-8?B?ZGFrMENKMnh5ZE0yK090eTI5Yi92VTZhMWpiK202a1EvbkIwWmpvalliSUVH?=
 =?utf-8?B?NWNhNWw3NGM5OFczWGtXTHdkRndvZUJQN0N6SkdKNjJyVUg1L29FaEtMSi94?=
 =?utf-8?B?aE0zTWgwZXJVOUFRMGZHMmoyRTQ4Ymo0MWErTHIvYXFReWdkczdobjVHcnNs?=
 =?utf-8?B?d1lTRlVHekZTUnZab1ZJYmZYU3gybk5wL0Zha05tUi9Gdng1UXR3a0I5dHdK?=
 =?utf-8?B?SE9Fdi9kbk1nTG02U2IwYi9lN2VZWU52Q2RiSmJhQkVNelVpYnRBQlgvZFBz?=
 =?utf-8?B?N2VGZ21QU0I3dGVreUdUbmdtNnptcXR0MS9sRS9UVmlKdFNkUkkyZlhmaVMz?=
 =?utf-8?B?aDRkQ3lKQ0NBM3J1bER1aHNydHJFT0lBYndBWlp1emx5dWorS2JWSkMxMHIz?=
 =?utf-8?Q?jzruFLpF1vPw8crDrX0nx7UpA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62aab46d-401e-404d-da1e-08dd460daeab
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:51:13.7587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9XcUmuAeqp3E9QSJx4B7v1LIvL4+U+Mlk8RDLxJRaDOvMMsuYKzUVko010V1GeA+HG/fhy0QdxRYMXdRE3CeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881

On 2/5/2025 05:25, Dhananjay Ugwekar wrote:
> Delegate the perf<->frequency conversion to helper functions to reduce
> code duplication, and improve readability.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll queue this for 6.15.

> ---
>   drivers/cpufreq/amd-pstate.c | 57 +++++++++++++++++++-----------------
>   1 file changed, 30 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index dd4f23fa2587..346fac646eba 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -142,6 +142,20 @@ static struct quirk_entry quirk_amd_7k62 = {
>   	.lowest_freq = 550,
>   };
>   
> +static inline u8 freq_to_perf(struct amd_cpudata *cpudata, unsigned int freq_val)
> +{
> +	u8 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * cpudata->nominal_perf,
> +					cpudata->nominal_freq);
> +
> +	return clamp_t(u8, perf_val, cpudata->lowest_perf, cpudata->highest_perf);
> +}
> +
> +static inline u32 perf_to_freq(struct amd_cpudata *cpudata, u8 perf_val)
> +{
> +	return DIV_ROUND_UP_ULL((u64)cpudata->nominal_freq * perf_val,
> +				cpudata->nominal_perf);
> +}
> +
>   static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
>   {
>   	/**
> @@ -534,14 +548,12 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>   static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>   			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
>   {
> -	unsigned long max_freq;
>   	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
>   	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>   
>   	des_perf = clamp_t(u8, des_perf, min_perf, max_perf);
>   
> -	max_freq = READ_ONCE(cpudata->max_limit_freq);
> -	policy->cur = div_u64(des_perf * max_freq, max_perf);
> +	policy->cur = perf_to_freq(cpudata, des_perf);
>   
>   	if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
>   		min_perf = des_perf;
> @@ -591,14 +603,11 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>   
>   static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>   {
> -	u8 max_limit_perf, min_limit_perf, max_perf;
> -	u32 max_freq;
> +	u8 max_limit_perf, min_limit_perf;
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   
> -	max_perf = READ_ONCE(cpudata->highest_perf);
> -	max_freq = READ_ONCE(cpudata->max_freq);
> -	max_limit_perf = div_u64(policy->max * max_perf, max_freq);
> -	min_limit_perf = div_u64(policy->min * max_perf, max_freq);
> +	max_limit_perf = freq_to_perf(cpudata, policy->max);
> +	min_limit_perf = freq_to_perf(cpudata, policy->min);
>   
>   	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>   		min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
> @@ -616,21 +625,15 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>   {
>   	struct cpufreq_freqs freqs;
>   	struct amd_cpudata *cpudata = policy->driver_data;
> -	u8 des_perf, cap_perf;
> -
> -	if (!cpudata->max_freq)
> -		return -ENODEV;
> +	u8 des_perf;
>   
>   	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
>   		amd_pstate_update_min_max_limit(policy);
>   
> -	cap_perf = READ_ONCE(cpudata->highest_perf);
> -
>   	freqs.old = policy->cur;
>   	freqs.new = target_freq;
>   
> -	des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
> -				     cpudata->max_freq);
> +	des_perf = freq_to_perf(cpudata, target_freq);
>   
>   	WARN_ON(fast_switch && !policy->fast_switch_enabled);
>   	/*
> @@ -904,7 +907,6 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   {
>   	int ret;
>   	u32 min_freq, max_freq;
> -	u8 highest_perf, nominal_perf, lowest_nonlinear_perf;
>   	u32 nominal_freq, lowest_nonlinear_freq;
>   	struct cppc_perf_caps cppc_perf;
>   
> @@ -922,16 +924,17 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   	else
>   		nominal_freq = cppc_perf.nominal_freq;
>   
> -	highest_perf = READ_ONCE(cpudata->highest_perf);
> -	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> -	max_freq = div_u64((u64)highest_perf * nominal_freq, nominal_perf);
> +	min_freq *= 1000;
> +	nominal_freq *= 1000;
> +
> +	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
> +	WRITE_ONCE(cpudata->min_freq, min_freq);
> +
> +	max_freq = perf_to_freq(cpudata, cpudata->highest_perf);
> +	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
>   
> -	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> -	lowest_nonlinear_freq = div_u64((u64)nominal_freq * lowest_nonlinear_perf, nominal_perf);
> -	WRITE_ONCE(cpudata->min_freq, min_freq * 1000);
> -	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq * 1000);
> -	WRITE_ONCE(cpudata->nominal_freq, nominal_freq * 1000);
> -	WRITE_ONCE(cpudata->max_freq, max_freq * 1000);
> +	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
> +	WRITE_ONCE(cpudata->max_freq, max_freq);
>   
>   	/**
>   	 * Below values need to be initialized correctly, otherwise driver will fail to load


