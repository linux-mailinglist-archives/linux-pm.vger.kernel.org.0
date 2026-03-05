Return-Path: <linux-pm+bounces-43681-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOL9EH2CqWkd9gAAu9opvQ
	(envelope-from <linux-pm+bounces-43681-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 14:17:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 770DE21285F
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 14:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C83630166D3
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 13:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9033239E6C9;
	Thu,  5 Mar 2026 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SjIQqbo5"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A85335DA52;
	Thu,  5 Mar 2026 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716478; cv=fail; b=R3h+Utfv39+en6A8+oq7frU13ESby+d6T5eetcFRb2KF/MAKHFgFmMShOHFXURZxOFza9GABXmgT3zD+McoaunJ1ixl4lXXITsz3t0zGDi8vrzk3dM7/Q/Rz6xA33AXuCRfQuxHuWIL0oPkqoOVA/37Er9/2qD/NlpZVszpEzUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716478; c=relaxed/simple;
	bh=/Ii//w2Jk9U/l1Ed/vgOBQma5HBB711jLNVcIxTsRWs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dkA5Yoe82M3TOhAVurGCWA1wV5SpPCXpMZbon1FnY1f845LOmj/a35X5y/pK2j/zGMMgsDnHf6T3cJtW4NJ7AofMnjgJmzFlmm3EUAzJj7EIwLXbF/OZ/wfVhHRvH1vDgMPsTXtpqw840DcvgFBPCznZ1wVuGRyNeqR1t+jVcFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SjIQqbo5; arc=fail smtp.client-ip=52.101.62.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fADco2kzeb2g7LG0ux3KNNBph7fPg3Yoclu2T1A9ykZlc1bfdnp07VcomEylilMNbTmR5i4Hq9sLuiUzFWxVF8ywa87k1I9QkVo1J6VnF8/XIsPusMKDJu3gj4uqsVzHR9Rxcb5P3stBDeG8nUqp8sWCYRtM+j//Knz6uuep8t49NZ2HAy5a3e3g/Tu4dlQCGrV7xubOBYX7mBKqnSyXEweBaP4r6tFlHWcDgHSGfYChY8V4QVMofRDCoI4tAVP1Wv5cpnJHaG9tHj4duPTGcR6NQHIhbqBq931It+0VUV8idl4DA3OeGjYWrf7XVAsiLWdxx0SQ2nsdiGxIkWHd1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ALMZQwzm6N5a7HGiFz5dvx0V6TmnMMfOl5+uhe/eZc=;
 b=V7ArVU+DzNsraLjJE7fVRsc4VEn9Ak2fqzwegusN99/g/nM3Xh9SqvWiRRQmFXTE/fvEcWGxcRFnFSneEhE7TcQrBOvhX3agnn6fUYdBUbPbgDMTEHUm33VGtHY8KSdoxVEv7n7tALCIeY2htA1IyI8LcIK0e6+KNkfi0oRsSlG1b3sAMAQhnj94oL7MraUnDYbViELD1qpEVh/8bGsKQDcTnx59e3tk/P6x05Chf7OKNKjTE1kAZi77cki6ZNE3jNUiwXncYWjgYLq3ns0/g/OZrR3LWea1j+3WhRr72MK7dJaEWp6Ymo/vhY4luXO+kLfK3lLvPu0KIYTGf3qWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ALMZQwzm6N5a7HGiFz5dvx0V6TmnMMfOl5+uhe/eZc=;
 b=SjIQqbo5tqGF1H3iG0fzLK8PtSSaNOAAqcxVILRNlrEbobhGkHlF0+gOpDt5xvZyQRVMirY8U1zlyV8slXYIVbhfh3BbQiNKD/ZJkrcOIr35o5ID9UTcLeKwGyn3HswRgehIWSava8NCy7o5th6mGQroKjdM6bBLxPr88zg42uZpjBFT24pnDdwfmxmAOk4Hal8BGfe1e21eLmKWrS3TiLyN5CTPkGLX0xJ3BOmQGxPP5jptZzmf/ymT2dmAD1XEoqnbbMp4HLjr8IWbgaXzpGkp4uWRngeR5DA+ByRAyQUoJbmBa5TVQFkonJTN1vtJM42dXbWyqCLiuIDtMzlOCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 13:14:33 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 13:14:32 +0000
Message-ID: <d7352cf1-632d-48bc-981c-568e61c8dba6@nvidia.com>
Date: Thu, 5 Mar 2026 18:44:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: cppc: Clamp default minimum limit to
 lowest_nonlinear_perf
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "zhangpengjie (A)" <zhangpengjie2@huawei.com>,
 Jie Zhan <zhanjie9@hisilicon.com>, Pierre Gondois <pierre.gondois@arm.com>,
 Prashant Malani <pmalani@google.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, beata.michalska@arm.com
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhenglifeng1@huawei.com, lihuisong@huawei.com,
 yubowen8@huawei.com, linhongye@h-partners.com, linuxarm@huawei.com,
 jonathan.cameron@huawei.com, wangzhi12@huawei.com
References: <20260213100633.15413-1-zhangpengjie2@huawei.com>
 <54f5795f-2c0b-49f2-a319-216c17657c0f@huawei.com>
 <ixm6xascso3hjfwhrocnudr7kv4o4plpmywsd2pwksr77nowup@l3ngfnctk5xh>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ixm6xascso3hjfwhrocnudr7kv4o4plpmywsd2pwksr77nowup@l3ngfnctk5xh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::17) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c5660f-2052-4f92-e3d6-08de7ab9240a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	DgVEJHpDj+ivDbqZQhSxaODInz/Ajo/X/AZnoqM84z9IQZIi+k7OfFqOuvAIH6IaGBCnt0zRn3r7fLb8BtyaIx91VCXe6MeYDoaq763hDYA8+KndEWtyPmIVsxUxZd0+l76KR8D0SkhA17aJf31Ukdpib11LUFstjN8G2EIPOIqEO1ojSje7r8EIQUSbS96r6X+Xeeud+kWw9x2Ri99zSNAEoPQz2R1D8p8aHO0THoOC5WLcmF7t+1MXwPOXBwLdzYiqq3VBSmaLUaOGiMj5fQlTYN55IQxGhS0wXOxkBAP4nAp7R6pczvbrm82Lbn3TyfuBHacD9umAgvZUTxe9xgsbfeOG2ESKKBV3zLImav6ZYXMtzNiOq3LgNT+RMpP26BrUBrUMwbt51VJ2DyV1d/mFl6EyvbdJTFHlb2bhhr5wUxDhl1TLYDx9/LxBN1m9oPSXKwu0A/YwBlLP/zroQP3MCsxF3mCua6cw4fWdG4wP4Bo1LMFYDhGeLYT3TtSaj2q48/ZxR7aWyIP546FaQ97yJ+eMzXllfovrqR0f0+cEOtuTFNOZA8RWbp1Uv+ClgRrg/gIEV1LzpnZmYxa2rCGmhtrSfJjYkwzsMCxgeBHmYql2jWcG1jCW+19sFKGGd87pK93w4R9Q1AZ5TjBiCUUEGJ8ttwLpxeYVHRfGAPbAblwdeyRwxm8Ag2IC5cY51YXM2PVaqeh097mm3v+JStCoZ0AsQKBcDrhw0Z7sy/M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDVicld5bk5zTXp4YlZOc1JXanZUZzJENGtsQkNnSC9LU2RYTUg0SDlGeWZn?=
 =?utf-8?B?U2h2ZUFYUlVOZzMxTHVDQXlnbm9lakhjN0ZzYlpBZ1JpT1ZwTGtaZ2tIYXdK?=
 =?utf-8?B?M0VpQitScEFEcXY5aFBmSFFpOXdaRFU2WnpuWHJ1NWFuNkh1aEpGNU85ZW80?=
 =?utf-8?B?TU8wcW8wdFYzdm9aOEJVNTRNb0hRdEtZNlQ4QzkvcWwrd1dZaHZFRXBWZGJX?=
 =?utf-8?B?STFPVGdyMGlTMXdYS2dPWmltZGpnV1hEeDN3eEFOc0hJV0lVNGRGNTJSRDFn?=
 =?utf-8?B?d3I3VHpSUlczaVNqcmJvcjYxQ0NZTHcvMEczdUg4djNMWWd2TTR1Z1hodGdV?=
 =?utf-8?B?RDVPeHRQenBkMjFDRTc2WUdCRC95RXRaNjBCTFlYUjcvSkp5dERBKzVlNlNG?=
 =?utf-8?B?d1lnbmFoNWhnVW5SS1k0YWFMaUdCcUlHaHJSYm1rQ3dKY3BaMkFnbVB0NFRH?=
 =?utf-8?B?RURxcDZ5aEhKZ2VCYVdadnpTSi95WnhxNlFjdEJZcjJpN2t4aWhEVEdMcG9B?=
 =?utf-8?B?QkxxWjI0T1ZFNlMxT3JrZWI1RlMyYnZkSVBQRkhlV0F6eWZkWllmUmxUVVJT?=
 =?utf-8?B?WFlkTEFQejVYQlpKWWQ3U0EwVmhwRTVwdTBYQVNiZTJ2dk01NWVvMUFqNmlU?=
 =?utf-8?B?dHlmSm9FSDdVTjUzRlRpdG04S2xLNStFK3A0QnovMGFHL015bnlqdFI2Z01o?=
 =?utf-8?B?ZmI1YlpIOXkrUm9CQ2lIM1VVOFVsQ21tUHVDTVN1aDErTkZXR3dLUy9ObEhH?=
 =?utf-8?B?amp0a0Y0NXNNTzZITlFKWWsxNmxkT1FtalZHeHQ1ZkhwWisvSmtQZlE5TTN5?=
 =?utf-8?B?NjhjMS82ZUMvanRqZytaM0tEbnpnciszUDAzTFhsWDh6VkZMV2xuaW1rWkRP?=
 =?utf-8?B?cFJMY2diOWZKYmpwelI5MXB5TjJ4emI5ZEM4OHh4b3NKUXFGT0hnM3YyZDhM?=
 =?utf-8?B?cXNuSE5JOVZ2UlZHV0lmbmY1eXNrM1diK2wvMVFmNXJoOW50c2ExTFFJUVQv?=
 =?utf-8?B?Z0dtd3hFSHpGaER2U1R2TXcyOWloMEVDTjFWOXhlNlh1d0RHdUlUSjJSb1Vq?=
 =?utf-8?B?dHBzdktaUUNwZ1piTHczMmJSNVFOUUNuWXQ1bWFrbFp1bE5HcjArdVhPdVdH?=
 =?utf-8?B?QTFrd0NNa0VrUkFLcWdFTFpKMHQ4cTJFNDdEdytRNUoreFdFc1NrbUtsT3BT?=
 =?utf-8?B?RWVSSlVKQkVPZzByc0RHL3ZhNmdxbHdRdnlpd00rR0dMU2h0MEhKbjIyaVBG?=
 =?utf-8?B?TzNXakJEQjRTRld1U2g5QVVvRVJ1ejEzQ0p1QndWS1Jma3BvV21QbENIb3NZ?=
 =?utf-8?B?U05oSUZMMm55UU02Z1QvOUFXdVA1Ujg5Y1lkR2lkSGc4bHJIQjhTcG1HS0tu?=
 =?utf-8?B?aEllUEZCamx1eVd4ckFnVGxzZnJGeVlTY04zNjV4ekZGOGIwbnRYNDZuT29J?=
 =?utf-8?B?R0JUc1NrVWxkdHhkWmVIcUxsS3BtT1BvTm9iSTg4STBnd2dlWVhXTDJYMk9V?=
 =?utf-8?B?ZUN2ZXg2OUh5RmVhUU1wQWg1QWlRYjFjRUhWYVRla2lLWC9WbE9BRXBFMndN?=
 =?utf-8?B?MkhJZGhBTWw1dGQ1NDVVb1JNYzZzbk13TGhyTGxpRWw0Y2QzbmhJNGRpK0sz?=
 =?utf-8?B?RitlYmlEbUY2YzF6Z3VKZlR6QktPM3lleWdhbTdRdGx1RmRyakRaK1UraWdt?=
 =?utf-8?B?a0ZXbU0zTWx3N0pkVWNpSzY0SDNJb3drb0tvQ3VrZUJ5bFBBNE10VjRLZzdU?=
 =?utf-8?B?b0J0Q2JMdkwzYmx0K1d3ZnFsMkZCL0g0QXA3VkQ5d0Q1NWZTQlluVkhJUk5s?=
 =?utf-8?B?aWp2bjVmbG4xMHdQaG9BZ3cvdmY5VGJUQjNHOEI5aUlGaDZKQi9nay9YV2o3?=
 =?utf-8?B?ZzNuNEkwZmRrRnR6Z3ozVEJJRmJDQ0FlM3A3dnhZNE1hd0JaaVBlOFkyRUM1?=
 =?utf-8?B?akpsSjVaTzVkNi9kRG9YeStrSzJ0dzFhanRFYjVLRHQ1WE1EaVlBRmJCVW9I?=
 =?utf-8?B?dXVPaFphM2ZVVTYrdHh3Ymk3QzF6aHdITHZnczE5a0JWT1FrM2lPcWpvaytW?=
 =?utf-8?B?blMyL3ZYOEhMd1ZERGhYRzBCMEh1R2hWRlBLUVBlUEpYaGw3bEZKbzZRMmth?=
 =?utf-8?B?Szk4UzBmMzBHNVNnUnRqRHNrU1lBOExFZkpxZmlLaURUWUNTdHJURlZaQTJW?=
 =?utf-8?B?SWVJd1RHVzBWY29BdGlWWUloRlhqbXdub25seXMvOGIzaWtabTBsaDVxYmpl?=
 =?utf-8?B?RmU4TjFIT1dBRkVDWlpLMEI2SXVFa1VmU3MvbktLcm80OTVndjZ3OTBYbmVr?=
 =?utf-8?B?S1RLVnUrOXU2dWFEcWJrZDNCcFowNXFZN251NUpMZWZ1elVKazlRUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c5660f-2052-4f92-e3d6-08de7ab9240a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 13:14:32.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmuSvVv98CfdaHtMY7UfsjdUAxRg3nxpLdCmfDg5W57f6ckWM4Q9RlGIZYCrgtlUumMksfOJ0wjTBIyzTAH/Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
X-Rspamd-Queue-Id: 770DE21285F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43681-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,huawei.com:email]
X-Rspamd-Action: no action

Hi Viresh,

Happy to help with the reviews. You can add me to the reviewers list.

Thank you,
Sumit Gupta


On 05/03/26 12:02, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
>
>
> Added few more people
>
> I think we should updated MAINTAINERS with a list of reviewers or maintainers
> for the CPPC driver. Who all want to be part of the reviewers list ?
>
> On 03-03-26, 20:03, zhangpengjie (A) wrote:
>> Just a gentle ping on this patch.
>> Thanks, Pengjie
>>
>> On 2/13/2026 6:06 PM, Pengjie Zhang wrote:
>>> The ACPI spec defines 'lowest_nonlinear_perf' as the threshold for
>>> linear performance scaling. Performance levels below this threshold
>>> are typically inefficient and should not be used by default.
>>>
>>> Currently, the QoS minimum request is initialized to 0. This defaults
>>> the performance floor to the absolute "Lowest Performance" state
>>> instead of "lowest_nonlinear_perf", allowing the CPU to operate in
>>> an inefficient range unnecessarily.
>>>
>>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>>> ---
>>> Changes in v2:
>>>     - Renamed the patch subject to better reflect the logic change.
>>>     - Updated the commit log to clarify ACPI spec details.
>>> Link to v1:https://lore.kernel.org/all/20260116094555.2978887-1-zhangpengjie2@huawei.com/
>>> ---
>>>    drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++--
>>>    1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 7e8042efedd1..4a3031d9fcf4 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -333,9 +333,23 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>>>      return target_freq;
>>>    }
>>> -static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>>> +static int cppc_verify_policy(struct cpufreq_policy_data *policy_data)
>>>    {
>>> -   cpufreq_verify_within_cpu_limits(policy);
>>> +   if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
>>> +           struct cpufreq_policy *policy __free(put_cpufreq_policy) =
>>> +                                         cpufreq_cpu_get(policy_data->cpu);
>>> +           struct cppc_cpudata *cpu_data;
>>> +
>>> +           if (!policy)
>>> +                   return -EINVAL;
>>> +
>>> +           cpu_data = policy->driver_data;
>>> +           policy_data->min = cppc_perf_to_khz(&cpu_data->perf_caps,
>>> +                   cpu_data->perf_caps.lowest_nonlinear_perf);
>>> +   }
>>> +
>>> +   cpufreq_verify_within_cpu_limits(policy_data);
>>> +
>>>      return 0;
>>>    }
> --
> viresh

