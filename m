Return-Path: <linux-pm+bounces-29626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D81AEA99A
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 00:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDFBE7AD8C5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 22:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFEA2676CE;
	Thu, 26 Jun 2025 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BM7dIuCH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B311DE3DC;
	Thu, 26 Jun 2025 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976887; cv=fail; b=NbLU7mVYlIkjU6A2jS2dn1EEcQAw37pExTxkqTYuP21mqac3B0MdDNv5X6jx0o1evKUtyjO2nwFAB05HlIqKynxu5ZCs0jDc01LFlpvH38duJMAuJEz/HMG73BDlBRtAKz5bcKPNTLIO9wi6mPv9di6WZJeE+qyRWBZ15v1unrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976887; c=relaxed/simple;
	bh=bg82Lkgf0Zkck31TV11c83Ex2xc4frCcckzWZpoz+MU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a0+tGHIJicVkO3+hUJE6+YZlggBFWH3/XSqnxOiotUs/dPokOf5y9XLLgkcMnJBVLY+gBA7BMaiZ9jDacxGIdpcaxKNlCgWQTK7a03Ixt6d8q4ykd7bV6yUFwO0IqsjpCK+/ly1kakas37JewO0flADwdPv8CjfBwrecTELVXkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BM7dIuCH; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT4z3DBzGSS3vGbwhLYKwEZslsme3S8gSkP6WJ1Vbun9uRgPLdA2+E38N2IAiaYS3OovZjlrJ9AYXqpk85oqzQyEeRFwO6fbNcyFuVX4gpi+g05eED1uEGj581SmzvgTGPv5QpAANuMlXr2dPhj2S+QotcyWbVBB3bFfGAzuDCsTNJ04cyfdHdFwvYUmGtNoL2+QePPjMA/U1Mpz6hOrx8fBR1VKoAWgzvbSoNrMfTe9nDm56qL1WoDmuocfzt9ycTrb47nems1NqqA0ceyTRLUj2JpSGZoA6vlTxGGYw5kHgeKlIPh0s+trCTtc2wYejhUdz8+uJ3d7p+54T8FDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PjHRszghVth2bJS2j+Wn8W7FGMTqPjalR0cF+q4xdY=;
 b=iCggtWzNaP++b5kppVTphCVQyI6sCSugZepqFu31KqE6TW4mH6oVBRdJaZfxajP30j+7f3yM4n4zsT/7fZnObiHd8uFbYVeqn7pZsJAup02nS6xpFI3blrg/46BD79ON/M+ea0h0QC387Px/0l7dmk3XGXd9Apj/QPMl/NVk95WfUvfvEYwILZ6byIlqgWdsbWrwK+7dQF6V2dNLG+l7/27WxvvCN9We9UUWOtkwbKzS7j8+U8tLK2UabPjzy+9vc2ynh9050tsaUjmvd8kOxJp4vFi7WmDX4UGtBiJnUk6NzeRiH71nadXsOK2+5mFIkOiowUV6pKS85PVAyf/qRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PjHRszghVth2bJS2j+Wn8W7FGMTqPjalR0cF+q4xdY=;
 b=BM7dIuCHf7mXF4UIUyckybGjZNQCDVs1E1e04BMwOorkVzqzi8NOgJFBpkM0voak862D5K3lzwu/0/ywdkgGeFknSEoAW40r8789MYMsnEcuWYr9jxLx8sJ2utfgFSN14yvTZ2/bfupofNieVhSTu+XlXbq2rQir+3oV6+eAxKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 22:28:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8880.021; Thu, 26 Jun 2025
 22:28:03 +0000
Message-ID: <5a6d0684-3340-43ed-b520-933654515943@amd.com>
Date: Thu, 26 Jun 2025 17:28:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v4 0/2] PM: sleep: Handle async suppliers like
 parents and async consumers like children
To: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Chris Bainbridge <chris.bainbridge@gmail.com>,
 Saravana Kannan <saravanak@google.com>, Sudeep Holla <sudeep.holla@arm.com>
References: <5011988.GXAFRqVoOG@rjwysocki.net>
 <CAPDyKFpBTz0M8DmWHLLm7x4c8G5PpQNv0Zj7mrZ9BewTBi1skg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAPDyKFpBTz0M8DmWHLLm7x4c8G5PpQNv0Zj7mrZ9BewTBi1skg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:806:20::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a3581d-72f4-4f67-b1a0-08ddb500b707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SS8xTXhuSXdGMkI5SFo4VmhRZTRhdXRMM0k3Q1B0NWNRTy9PNy9FeG5UZ283?=
 =?utf-8?B?c01wS25lemE2TE1NckZTWFp1ZG8zMHVIN2x1M1ZNM1FPN2NQZW1hYjIwZHJG?=
 =?utf-8?B?UzRDWGVOT2ZwMEFORmNYajhRYWtCd2t5Qy8rbjVvWXNuRFhxbUhKZDhZelFB?=
 =?utf-8?B?UFVxWGovdE1aL3B1NzI2bE0vWUVwejA0U3ZKK09CRXpaTG45a3RSSHBRalJU?=
 =?utf-8?B?cFdjalVmNjcyMHFxcUNtUXFwWDJoUmlwcjJSRU9jbUJ5MzJWQVR1V1pyVjRw?=
 =?utf-8?B?NStQbUpLdElETjlnSEZ0Q0kzTTBBaEZxYUVRRThHRXJQVVVDQ2ZpTjJOWFpN?=
 =?utf-8?B?YVZBVEJFTTMvTk9ReWlZWW1ueFdrVTRzS2d2cmsyMUNBNGYrRGoxcW5Fb3NF?=
 =?utf-8?B?bStOWm9WNi9kcHlheStudUdUOWk4VHFCaDlkeEpZZms0Ty90ekpKa1ZKT3M1?=
 =?utf-8?B?eENraldlY2tLZFhKSm4zdmMva2hjcnQvSnZPUlBvV2dRRm4zeTdDWWlNRnBq?=
 =?utf-8?B?L3RBOUJpK05TZ3h6ZWhNeUJhYWpMWjQxd21TU2VmZVZUeGhtY2IrV1p3U2Jp?=
 =?utf-8?B?VWRvcFpJY21lc0RJcDNVM05ORlFidWF4U0FQMHNFT0U3c3VnVFM2ZGVOYnhu?=
 =?utf-8?B?T1Z1cGEwelZtUFh6MnFtdkJRdDFPTTdIVTZ5YU40WDF4eHRWSGp6MUhRU2Vv?=
 =?utf-8?B?MXJOZ0l2MDNyV28wUDVEV20zYjR5ZkFHVzNjK2tJeitpbUpXbG81WDhsRDhj?=
 =?utf-8?B?OUJuZjk0ZGMwLzM3WTRoRkE5UFYrZWhsVFQyRk9lMVhmWFBGNTJhUXN4M0M5?=
 =?utf-8?B?Vjhxd2JVbVFudE9kbDFBaTNpckdYK0JweVYwZUh6MWwxSTlLS3cvT0dlb243?=
 =?utf-8?B?eDY0Q0I1V0huZWZXTHFkUS9kMXV0ZkJOYW55d3lDc250UVBwOXI0azZKQksy?=
 =?utf-8?B?UmpXNDNRSnBscGFyVjZBRkYxVUFZQTNhM2NkblU3RXlwR2RUT21IcGd0ekVa?=
 =?utf-8?B?RXV1OGl3TjFWSUtUTUhlWExXYlcyUEtqQThWL0F3TFdUWFN1eFVnUFVSRlhB?=
 =?utf-8?B?a2NYZ0dneDdCYWoxcm1QY1RNbHFyRmhSaTcwKy9YbWlaVWZtNVczQVNhc0xH?=
 =?utf-8?B?RCtFMlJuWldsZlpFeFBQcmFhbDNwL3B5VEkvYmhQaFQ1d1ZDUmUyYjVTS1Vl?=
 =?utf-8?B?NmRXRkJsV3FEVXNjQ2N5Q0p6UlpaMkpGakd3Mkd1bXdSTXpqalA1QlkyTHU0?=
 =?utf-8?B?NFpZakwvdlBTSHVuYnZtZHZ1ZkptSjd6V1hhcE9yUXVzT0lHU3pvNEdKWm5N?=
 =?utf-8?B?b1lWbGFhczE2RUdXUjFoZDViNWZHTzQ3eHBkbkJ6dmVzQXNxWWo1aXhuSjZB?=
 =?utf-8?B?Z01JNmZjb21TK2Z3dzJNQ0VhN2pwcjJTamVTbVhucTd2Vkx1TGduZGl2N0R5?=
 =?utf-8?B?TlppWS9sWUk1cXF5R0NyUm90Y1UvNkJ5OVVRYjZOUW9XRjNmUWMyYnIvWU9l?=
 =?utf-8?B?VVVuS1h5dmdVaFFFRUh4M3Brc3lQc0hUaWZMbUNoVHdISUlSRm1JeStOVGJB?=
 =?utf-8?B?ekNNSHFmMWxoYW5udWVXOUVVcFZNQjRYMFRRQm52SnJBWWxwMFoyeWtJM001?=
 =?utf-8?B?NTlOcFMxVzY5SksxVEo1UG5TNUN6Rjl1Smc5Q0FQaE8vYjQ2QmVvMXdsRkh6?=
 =?utf-8?B?ZWdCQ2xKNlcyejJodmVXcXN1bUlGR1dPTmpNdDNwR0d3bmVPTVMyNEtZMk5y?=
 =?utf-8?B?MGUvWGZBZmtIVVNFT1FYejlBbDZlODhZL0xucUVwNWk0d0lvZUYrdHRDclhk?=
 =?utf-8?B?MjBlNEtnU2JBVVVGOGJ1K284MDNMblFJbERqT1Z4OHk0ZVFicDU3NnE2aGs4?=
 =?utf-8?B?UUtqUmFrREZWS3FmYmM5cnpvSStsRXBlZlowbHJJdzZhMTFFclE3dXFQcVVt?=
 =?utf-8?Q?q0nJDmeFQxY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGdnSlNmYjdrM0NWZllvZldoRjF5T2RMRHpZaTRYdEl3Tmw1aFBPdW9KRmlD?=
 =?utf-8?B?cFBJeERXaUZuT3c4NDN2MDVUVDk1Tm8wMDErT3FjNTJZQWhoYlZtWGR4ZWNW?=
 =?utf-8?B?Yy9TRW5odG1qRkZGM2s1UXcvRUNTQkV4M0U5eHhpV2hVUlpJWWI4cGllZjUz?=
 =?utf-8?B?TzB0RjZwckxRTGUwTTZmWVdmUW5YSnZZd05JSEh6UEIxbTAxK1hTanhiMjdo?=
 =?utf-8?B?dWp0T2RCN1dCL2FnYk4rRldMc3VWeklidG81Tzh2L1JHZnp4N0N5TVlOeDBv?=
 =?utf-8?B?QnZTUHZKNWtyWFNpU1FuUER6anpPWDlhb0poMG5UWlRMYjVQUmkxR2dYcG11?=
 =?utf-8?B?YzVicTVXZ1NyZUhpRDNmelhDUGp1Mng1T2pJY1FKVXZKOVo3MnNOSmFPemJ5?=
 =?utf-8?B?V2tIYllLdjVJeHl6NjNlb29IZ2RPMnFoMmZLMVcvNjZ2TTdHYm1FL2RpRDc0?=
 =?utf-8?B?UC9CUEt4VkUvbERiaGRXUmp6ZDF6T3N6L0s4SU1LWmJWL0NUazlJNXQ5ZmdV?=
 =?utf-8?B?Y21wZ3VvREE5ZWZxN21Yb2tVSTA5Y0JjVnNkTm5kWndnbFBKRUxwY2ZHSkpm?=
 =?utf-8?B?ME5aMWZiM3pReGtqN211R0NrNnJwajVyRGdzNUlPK1h0MysvT1U1VU43Z001?=
 =?utf-8?B?VitkeE9wY2RpRlV4RU8vOUJ4a3lUalpxbGZXcmJ3UXdWSXBOeDQvYnpvSjJl?=
 =?utf-8?B?bkMrbzBnRitOVlVjdFljRGpyWmlUNlJnU3A4YzZqclBNam9hNE1RY2l0blh6?=
 =?utf-8?B?bDV1dmlYUWw5M3dJZFJtMFYwMDcvVVEzaFo0NW5PcVViMmhKNDF2OGk2Yzdm?=
 =?utf-8?B?eWp4VUtQQndUcHlrZWZWKzVCYlFOMm9hZmwrNjZMQnNMaUlhajc5M3BUa3pz?=
 =?utf-8?B?Zk53bkZQZCtBY0V3TUdQd1M3OEpXdWtEUnhKTU5DSktha1FQZnRYKytzZ0xZ?=
 =?utf-8?B?bGx5UWpRVWZWY0JYQWtSdGl2RkNMUTdmTzRRNExqU3N3eW0zNWJTZitYZU8z?=
 =?utf-8?B?aGxiaGFRMmk4UGU2WDZseWpSbFNITFBpTE9XWDUvU092ckJ2NDBNNnJDOEl1?=
 =?utf-8?B?MFJjVCtMaEtiRERHTVlOU2tTU2pGWjFraW9XSHY4a1AxRWhrUnNSQ2JoWGw5?=
 =?utf-8?B?M1VuQ0xMTGFhVjFzME4rWjU0TlBIYlNua1JKUDRwYlc1RE16aGxkT3dGaEpE?=
 =?utf-8?B?ZmJYVHBVVXFYd0tCY21CSHlVT3l2T3dmYVlSWTdxN3lBNDc5ak9BZVdQaW4w?=
 =?utf-8?B?Q29vY0d3VkxhYXhsSExyMmdBU002VUQ0eElZYWlUc1hDRUk3YUhoaWpLQWM5?=
 =?utf-8?B?aURPb0lNZlhXaVRSVVpxUlFjK1lpMG1sb0dGbGVtVThVdkZIb2d3dWxlbzcw?=
 =?utf-8?B?dXozdzdtdVRXdzZKaHREb3UzWlV4d0xrQXZiUURHdWxKOGM3YlJON1Z6WUFK?=
 =?utf-8?B?QnFhenFGRktqMTdhL3NJcHVxcDk3TDhJNldHekpBUzJleXUydTQ4dGp5cVVF?=
 =?utf-8?B?TEs1QlRZdE9keFJld3gxbnA1RmFPNGhqbWFvd2pSRDFlaDFIVHgxb1I5M3F0?=
 =?utf-8?B?SGJIVGlUbVRoS3JYZlFDOFh0ZW05U3dFM3FRdFdZZDQvZTJjMlg5ZkxEd3dm?=
 =?utf-8?B?bUx5VFVBTzQwS1BrQ3d2UlkvdGgyb0c3UHBKY1pGTUQ3WC8ybXZNdWw5V1RY?=
 =?utf-8?B?b0N1czZUd2puajI0M2l5d0tBSy90OTlMaFMvSU9qMmRJdFZFU1I0SmF6Q2ZJ?=
 =?utf-8?B?QThqaU5pQ3BWZGdkL3VMM3Z3ZHdQRlNLNGdteHU4NldnZERiYy8wZmVTb1Ex?=
 =?utf-8?B?R1U5c0tmL3hZRmo0V2VkVXVqelFGYzlmMmh2NzVLVlcwWFpwL1dwOHk2RWx5?=
 =?utf-8?B?ZDVVWXV4bFlMQ3BLY2kremVjRkN6WVpEemtvMWRQcHdYa3RLYVZ2MTFiTGJG?=
 =?utf-8?B?cHNvSk96NWdwNytMaE5xSTZHcWEzQ3RuTGNxdDRkSEtwSUNsTWVTVGVsNDJr?=
 =?utf-8?B?cktXcUdmQWxuR0d2a1I3VnJsTDB6Zis1anQ1UURCbWFRTWdMblZIc2h1MThS?=
 =?utf-8?B?bFVMY0l6WVI5ZVAwSjVicFZUT1QwNC9sQ3BtNS9oZmh1UlZVS3dFTHdkK3lW?=
 =?utf-8?Q?vJXxFkI2GQZLfJYXj7FaBnkHM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a3581d-72f4-4f67-b1a0-08ddb500b707
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:28:03.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bi19wW/MsSiuvy0vO1gOR1ph77aOfhcay70ib8Ah1QvXowc2pSyI99uBiQVnCojFoq7ybSjju7LLJj9PpILqQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184

On 6/26/2025 4:46 AM, Ulf Hansson wrote:
> On Mon, 23 Jun 2025 at 14:55, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> Hi Everyone,
>>
>> These two patches complement the recently made PM core changes related to
>> the async suspend and resume of devices.  They should apply on top of
>> 6.16-rc3.
>>
>> They were sent along with the other changes mentioned above:
>>
>> https://lore.kernel.org/linux-pm/2229735.Mh6RI2rZIc@rjwysocki.net/
>> https://lore.kernel.org/linux-pm/2651185.Lt9SDvczpP@rjwysocki.net/
>>
>> (and this is v4 because they have been rebased in the meantime), but they don't
>> make any difference on my test-bed x86 systems, so I'd appreciate a confirmation
>> that they are actually needed on ARM (or another architecture using DT).
>>
>> Thanks!
> 
> Hi Rafael,
> 
> I haven't yet got the time to test these, but the code looks good to
> me, so feel free to add for the series:
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Kind regards
> Uffe

I passed this series to some internal guys to test on a wide variety of 
AMD x86 hardware.  The initial testing looks good.
Will keep you apprised if anything pops up.

