Return-Path: <linux-pm+bounces-30499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF91AFEEE2
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 18:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4AC14E1985
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 16:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F4F21859A;
	Wed,  9 Jul 2025 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WF7QMTxc"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7DE21CA0D;
	Wed,  9 Jul 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078956; cv=fail; b=oSVBpq6JOOspQUdojt8Huv4ADzYHdO1YGWAlgjPWXEUAWoT+yXVUcT0xGPwwASniCe/7LdnXrKlc0Vd4Qs1rP3sBEQgC03/iqgD2Qa0D1uiD37PHf27HD3/K+dRtxrFtAZL2QbWmEEmD7k/86Q0iBivQ8ki112oszfhVMlJ8u4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078956; c=relaxed/simple;
	bh=bnnbGCNQx7OVZ8Hl2/YymAxbNeKvz1sWspF16+lvJw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GHonLtcXi3qWhVnl3dGm7Nk2kfzbEMg4zsJgqHVXMyjssRQnMkxx5FWmaZK0Ph/CR3Jnq/5NhTpmFXdxxn7QrtlumJs61/rAiMx4LoLffJvjEuWpdx5A5rZiMEDG5KuawjxC57oq/oIF3ej67XC86iSd1WkryoAzfCE6ko2oCms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WF7QMTxc; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pu/NB30F0sa5eZ9Sj8fMYZvsn41DFzm4REZFU/rIAOfPwfl23vCcazOGLhVR4fSI1PcX97zyYZ1R2XcJSO0mCIi+S00xoNGHehM5j00r/3XLTw4gKm7JSiH3xjFr31wcF6nWKIhrTqeVzvTv3JqS+H80U4ptv7tu8V95tUYl3wGusOTxu/SYzNzVeBUyrr6hPKAtvvnMA96FJRDKj9bC6+yXbHV+pBCAFcUPlO4qQuwa5TZpMsrUNae3LWMoRZoDhXY1NNJEU3wyOo0PhjAcGPvtnoUBjj1WoTHhXVugCehbiCt99Evxfn0HHm6gBl3DegPgoD9EZWXB3jQwo5kR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIsxSlUk6Ji3SJKMWyPEL/6aK8OVowyKGxXQNJirpig=;
 b=EVQ/PWH1mteNXOCm99RbFFhcKL8V2DesjIho39BSxLuJOoT2A81/sEdTcshM/dd6ovaV+oUUiEeYCtGDmFi4JigAeo6shhDLva0LHP0bsfHURZ2ou+I5ILgmy+JPsd9qpJr5+1KtpVHA074Q+XH81dglrUHjEWNU/mLQMUB2qUUBJvmnFt4tkJds9OfWL3v20HVzmGogvr5L0OzR0itkD8Ube0Vv4BHqbO5VbtSbKdWM2PTstdoxqJsxL1Zhgjo29hF/dYXhI8325FbsjOH8Ujc28eJs6+cGGCQPUNWkm/ecmGHAawEk3jbshmY3QqzEqasYC4rjnj9FCksMgpzxrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIsxSlUk6Ji3SJKMWyPEL/6aK8OVowyKGxXQNJirpig=;
 b=WF7QMTxclI0P77l12pIAniPFj9ELvnPjHZznfnEpz3b/9Z/iZWgh/k0duyZ5CyZdWDM83MESbIoHdiR0/7mSvA0BGUoTaeQ1qaNclFA0cdaWDkCziyN2MJTvygypJDj6DGeuky+Bn1CZEMuiN8NpELP164dCVOS70hQpvGTl7yM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 9 Jul
 2025 16:35:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%3]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 16:35:51 +0000
Message-ID: <29441021-5758-4565-b120-e9713c58f6d8@amd.com>
Date: Wed, 9 Jul 2025 12:35:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
 Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, rafael@kernel.org,
 pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org,
 kexec@lists.infradead.org
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org> <aG2AcbhWmFwaHT6C@lappy>
 <87tt3mqrtg.fsf@email.froward.int.ebiederm.org> <aG2bAMGrDDSvOhbl@lappy>
 <87ms9dpc3b.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87ms9dpc3b.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9c8c57-6d44-40ac-d892-08ddbf06aa9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXRUWXl5SU1HRkVuYzk0VlpiOHpobm91SHg2eXR3L2VaMG1jMVdrRFd0YUhU?=
 =?utf-8?B?cGY1dFRpQ1c1VXJLb3pQeVRXK0IraTkvUXB4SXliamJMT1V5OTZaL2xHNnhk?=
 =?utf-8?B?cHlUVVU0Skh2c3pvVnZYMVhjUGxWemV1SENpRDlmZU5RcGRzcnlGa0JBSG5i?=
 =?utf-8?B?ZVhHYlhTaW1rRCthTy9SOWFBeUVYaFZ2TExsTGZvbzBDb09aSktYMVpQNmpU?=
 =?utf-8?B?K09Md2VBM1ExTGx4VVV2YmJaNThhRVY0TFRoOUZxMlJ0U0FRRENiN040Vmxl?=
 =?utf-8?B?MlVrNjRrWkR6Z1hML094K2JZVE9MWDNyam9RZ2xqOVRmSWJsSlBwNi9ucDhF?=
 =?utf-8?B?cGxmMk5Oa3FSTWpYM25LSTR6RW9KWXJkdWJrTEVnY2h6WmM5SDVOUklnbk5o?=
 =?utf-8?B?RmNIeTY1ejVTYU5kNHpmcmtic3hrVHJva0svM0p4MzBnSXhMVGdWMTNKYU5j?=
 =?utf-8?B?RkpRcXk0UzF0UGUva09INXVaY1FKY0phL0J3eUQzSWhZSHdFSTJTSTd0d3F3?=
 =?utf-8?B?enpNM0tYaEsyazk2STczeTZ6UVNGdnhwTWxwVXlBcGw3ZDZadEhud3FMN25H?=
 =?utf-8?B?UkVDd0ZIYkdCdklBTHVQT3V5VU4vSUN0TlJtRWw4WXpMVHhibGY0VUdnK0lL?=
 =?utf-8?B?WHdUbzdQUmF0ZWJwdnE0UHRxSElrWkJVajJzazdJczY3TDArUXRydGhpTm1L?=
 =?utf-8?B?OHhQbElLTzBNb3VXc3BGalpOcW5MWGRnOUpyYnRxWTFYN3VUTVRJN1lPd2xJ?=
 =?utf-8?B?Vk1KSXUxbUxJWVdLZDJKNVAydEk4WldwcDVnOHRsNlF3ek5hQXk0T296KzJZ?=
 =?utf-8?B?Rm9GUWRhVTlDei85MUc1anZsZHVoNVJsY1psci9ra1VYSlRHUHN3OTZxZ1Jx?=
 =?utf-8?B?dFVBL0lWSW83aXR2ZmF6ZFU4VVh3MzhkK3UrRFZQS2hlNnNPeXo3OUVyU0RL?=
 =?utf-8?B?MzlyMzZaeVp2Z1E4KytJc2tqbml5bGNYdEh1UDNMdXpPWDhvMVZNNm9YRDR3?=
 =?utf-8?B?YWVkL0xVc0RyTkFuVUhZbnkrckVob1lzSXZqaHZ1REd1U3pjVFZUZ0pXYjlB?=
 =?utf-8?B?c3B4aWsyWFhtNHp0VVlFZzdqaDNSdUxvc2NXTkJmT2dGaU8vaTlkaldEMW1H?=
 =?utf-8?B?clJRN2crR2Y3b3l3Ymt4T2ZmOVFlZUVHQ3kzTXptQjFaNmlWTmdUZXNXQUov?=
 =?utf-8?B?WEFrUlRBQkhZcWRxNmZMdDJxSGFYbnBNK1psa0l6NElXOE1nYVk0bFA3eU9q?=
 =?utf-8?B?MmVWT1hIcklLVk51eGw3aFFjVkEzOGlwY3hMVjgyelplb0c1WVBpTGVZS3VC?=
 =?utf-8?B?NUF0elpFWkN4c2k5RVNWVVpVVFIyQUQ4SWg4aEtLc3o3QVFTbDFzYU5FR24w?=
 =?utf-8?B?ZUk4clpEQS83ZzdRS3pLQlc1U2wzZTFTdWFFNnZUZ2Y3S04wN3VTWW11Y0J5?=
 =?utf-8?B?d1ZFZVNIU3RKNU9JYmw4R3o5aWtXU0hWbmVtemVYcG9wNmM4aTc2MnliR0pZ?=
 =?utf-8?B?Qm4zdHdOWXQyTDFUbVZGcVBGdjNwS01HS2lPOEZlY1hwRXNDa1BORGxKOUxS?=
 =?utf-8?B?K3g2MGh6QkRDUm5BWEorcU15RXZhSE9OL2VWblJ6Yy9GcUEyU3JzdkxxZnJ4?=
 =?utf-8?B?U3VLWTdLNHhtbkJ3UXJleW5XY2xyV2pCRmU0dEduMDVIZ0RFQkhuMVl4Tzdv?=
 =?utf-8?B?WHc4TlhnNGZrcFlVWlBiWG9Ca1BpM2ZsbzhBTEoyNis4WCs2TG4xYWlySG5P?=
 =?utf-8?B?LzBRQ251Sm1WcUpTOHQwQzNOWmtDVkZ1cGVLcy95eU5WbG1DK0ZiNm9LSFR1?=
 =?utf-8?B?a0dtaXlGL2VwWEEvdjhxMjBoNkcrRWE3VTBRKzJQNysxaldaY0EwRGVxS3Vl?=
 =?utf-8?Q?xAe7gQgm/zLGR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHNub0VrUFBrTlZBUUxPUXlSK3VCVkxROXY2RnM5ank2N2tTNW5rS1FFZUc1?=
 =?utf-8?B?a0ZhWUFzZmRHM2EwV3kwaTcxdlFWR3VaSEVUT1JTV0tmcXR2NWtDYld2R3BN?=
 =?utf-8?B?ek9xMlVXYnNIOTBZeno1VG1pQTkzOVhPbkQraTZNTmhTMGhqSGF6alE2Wk9t?=
 =?utf-8?B?dnpOMUE1U0dIWjZvRGcwUG9wTUN3S1NvbDVFejF1ZWZKa0tRSmg5Q1llNHF2?=
 =?utf-8?B?bTVTOTN2WWtRbkQxdkI2QjhMY1hHL2RnMHI2MkJJUElETC83bUFFd1g5Y2Ri?=
 =?utf-8?B?RDZxdjBQWDZMMUJJUTFNYnBISjZUOFo0UHI1Vjc1TVhvcUhsbWw0aFhudDFS?=
 =?utf-8?B?cW1nWFY5eWV6UHRTYSsva0xmb3pZQXI5VzFScGZVbDZtL3R5ems3clZ4VkxS?=
 =?utf-8?B?UEVlVkF6TkNsTXY3OUxHazgvZW5vWmd6c25nUHU5TUp1Tkt3K2ViT1Yrd3JT?=
 =?utf-8?B?VHc3ckpGNGlkZFE2NzRWK2w4aDVDVVNlSE5rVlR1cDY3dldZRktJY0hTSXVZ?=
 =?utf-8?B?YWhXNk1EZWNzRngwVE9SQXhsa1NKU09wdTB2SlAxczdGUmdKUnlQMG4wanFW?=
 =?utf-8?B?MDJWaytmaHNncXltSzdHeWNvNjhmKzlJYXJmMDl1VEZvTVAvMFFNV1ozcEZJ?=
 =?utf-8?B?bWtHSUw4V2V3dE5tdFJPQjBhZ1hwNUdrcWFiZWJ3bnRocCtFU2xqRnRHMFpG?=
 =?utf-8?B?SFBqbENFaXJuc3hIdTBwWG01UTJiZ0NHZUxhY2cvTnRwU1VaVWtZa3lYQXhJ?=
 =?utf-8?B?Y2lha0taTmhEVDBmc1lHYkVEKzNFWGJxYmpDaitFZzY2Um9YTDI4bkVzRS8w?=
 =?utf-8?B?UjEvZFgrb2hseVpkOWlNV0Z1a2s4a0FhSHFPcm8rcWhVUTV2aGVEYjhXWEhW?=
 =?utf-8?B?ZjN4WWdtdTJUN1BkeEt4L2NXUlcyMkNhNGwrdk9XTG9rWE0weDQyYmN0eFFy?=
 =?utf-8?B?SDZhT1ZLRFFFelBzQlJ6NHJwUlVISTg4V1lKMEs3WXcxdjV1NW9OR1pWTC8z?=
 =?utf-8?B?WTl6MHZnd0pRcEFZeXUvWTlqUkZhSm1IZ0loQjJVbW1GYUw4V21MMFBFbmdt?=
 =?utf-8?B?QlpxMmc3Vmg0NWFRdnFkcjdDMERIcTljeDhwVHZyRFgybzFCMURLaFN3cXpi?=
 =?utf-8?B?ZEFtMzRuNEpydStOb3ovRU5ud0xMM09DZGlVMTdsbDZ0U0xQSjIvSDROQS9t?=
 =?utf-8?B?VkM0SWs0T3ljYjVNUkcyR0sycjVVTmhGMVJVeEZRYm90RE1pdHVyZ1RESnNw?=
 =?utf-8?B?cUZNaGVIZnZza2ljejhxQnczQUhmNVUveG9GakozRjE4UmhPMmhTWmFpaDYz?=
 =?utf-8?B?SDIreHNrMFZKL3BKYUl5ckRZRzVzQ1ZxWDYrb09xMXNhbVZDWFpMYXF6M1FM?=
 =?utf-8?B?N202bUFYT0hPU0FZcHYzb2RRYkJKUTVTUmxKQmMwN3VZTVFzRW9COVJmeEg5?=
 =?utf-8?B?WC81bEJHallWQlhsalNRUkJ2Zm83UnJWSHZ6OGxwc0c3WXAzejBIV2g3ZTJW?=
 =?utf-8?B?YlY1TGN5ZjB1Q3YveTBJdWd6L0RscWpkR1JhMlpNZGpZRy9waXpvVXFPOW5E?=
 =?utf-8?B?TWR6bnkyNER6d0t4TE9rUzZhWTA1Z2xzZml4a1Z0dXJEcmZrNEczVHVzanVO?=
 =?utf-8?B?L0NKUGZUdGhkQjFJZ0R1VXdVdG5RUnNuTy9WQzVoSTNHMStPc09qQzhFSXFx?=
 =?utf-8?B?ZnNjUGVERyt2WVR0d1JSR245SFBtY2w4WEV2b1pnMmVoS0JLd0xpeHFQRWc2?=
 =?utf-8?B?VDBKTGo5VGgwMkorVlR5SmlHL2gvZjduS1lkdGNXczQySEllNEUxVUxibWd6?=
 =?utf-8?B?YzZRSllSbWl6RFV3eVlWWWNlOTd0Y09Rc2lCUDRGMFNpcTFYdzVxUGdLSmt2?=
 =?utf-8?B?KzRhQXZCdUVMMThnZUEwZXBic0I3M0xkMjVqamlWamgydC94MHNrLzBsQzVm?=
 =?utf-8?B?NFVOem1jSDV1dmdRMnJsVGpGWTBvNnVBNG52Z01xYVFGcnVIazJZYkt3SDFK?=
 =?utf-8?B?MXZGUFNHUE1nS3NwaHpaY0tWbkIzZ2NBMkxFK3VEazEzMUNnSTVGOUVoaGdl?=
 =?utf-8?B?SWxHOVJYQ09RNU5maU4wN1Z3Rm1pNVBnOGV0WTU5UjkyMXdSMHU5RnluVlJq?=
 =?utf-8?Q?4aapRdyc4Zv3jd7THiS+0FiZk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9c8c57-6d44-40ac-d892-08ddbf06aa9d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 16:35:51.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pib0onzSGNBBt1Schd9XaX+ZV59q2k+y1O81aA+5edmmV6WFuvFB6xFNxNNyVFQQ/ECeTA/4/1Jw6ptvGISYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431

On 7/9/2025 12:23 PM, Eric W. Biederman wrote:
> Sasha Levin <sashal@kernel.org> writes:
> 
>> On Tue, Jul 08, 2025 at 04:46:19PM -0500, Eric W. Biederman wrote:
>>> Sasha Levin <sashal@kernel.org> writes:
>>>
>>>> On Tue, Jul 08, 2025 at 02:32:02PM -0500, Eric W. Biederman wrote:
>>>>>
>>>>> Wow!
>>>>>
>>>>> Sasha I think an impersonator has gotten into your account, and
>>>>> is just making nonsense up.
>>>>
>>>> https://lore.kernel.org/all/aDXQaq-bq5BMMlce@lappy/
>>>
>>> It is nice it is giving explanations for it's backporting decisions.
>>>
>>> It would be nicer if those explanations were clearly marked as
>>> coming from a non-human agent, and did not read like a human being
>>> impatient for a patch to be backported.
>>
>> Thats a fair point. I'll add "LLM Analysis:" before the explanation to
>> future patches.
>>
>>> Further the machine given explanations were clearly wrong.  Do you have
>>> plans to do anything about that?  Using very incorrect justifications
>>> for backporting patches is scary.
>>
>> Just like in the past 8 years where AUTOSEL ran without any explanation
>> whatsoever, the patches are manually reviewed and tested prior to being
>> included in the stable tree.
> 
> I believe there is some testing done.  However for a lot of what I see
> go by I would be strongly surprised if there is actually much manual
> review.
> 
> I expect there is a lot of the changes are simply ignored after a quick
> glance because people don't know what is going on, or they are of too
> little consequence to spend time on.
> 
>> I don't make a point to go back and correct the justification, it's
>> there more to give some idea as to why this patch was marked for
>> review and may be completely bogus (in which case I'll drop the patch).
>>
>> For that matter, I'd often look at the explanation only if I don't fully
>> understand why a certain patch was selected. Most often I just use it as
>> a "Yes/No" signal.
>>
>> In this instance I honestly haven't read the LLM explanation. I agree
>> with you that the explanation is flawed, but the patch clearly fixes a
>> problem:
>>
>> 	"On AMD dGPUs this can lead to failed suspends under memory
>> 	pressure situations as all VRAM must be evicted to system memory
>> 	or swap."
>>
>> So it was included in the AUTOSEL patchset.
> 
> 
>> Do you have an objection to this patch being included in -stable? So far
>> your concerns were about the LLM explanation rather than actual patch.
> 
> Several objections.
> - The explanation was clearly bogus.
> - The maintainer takes alarm.
> - The patch while small, is not simple and not obviously correct.
> - The patch has not been thoroughly tested.
> 
> I object because the code does not appear to have been well tested
> outside of the realm of fixing the issue.
> 
> There is no indication that the kexec code path has ever been exercised.
> 
> So this appears to be one of those changes that was merged under
> the banner of "Let's see if this causes a regression".>
> To the original authors.  I would have appreciated it being a little
> more clearly called out in the change description that this came in
> under "Let's see if this causes a regression".
> 

As the original author of this patch I don't feel this patch is any 
different than any other patch in that regard.
I don't write in a commit message the expected risk of a patch.

There are always people that find interesting ways to exercise it and 
they could find problems that I didn't envision.

> Such changes should not be backported automatically.  They should be
> backported with care after the have seen much more usage/testing of
> the kernel they were merged into.  Probably after a kernel release or
> so.  This is something that can take some actual judgment to decide,
> when a backport is reasonable.

TBH - I didn't include stable in the commit message with the intent that 
after this baked a cycle or so that we could bring it back later if 
AUTOSEL hadn't picked it up by then.

It's a real issue people have complained about for years that is 
non-obvious where the root cause is.

Once we're all confident on this I'd love to discuss bringing it back 
even further to LTS kernels if it's viable.

> 
>>> I still highly recommend that you get your tool to not randomly
>>> cut out bits from links it references, making them unfollowable.
>>
>> Good point. I'm not really sure what messes up the line wraps. I'll take
>> a look.
> 
> It was a bit more than line wraps.  At first glance I thought
> it was just removing a prefix from the links.  On second glance
> it appears it is completely making a hash of links:
> 
> The links in question:
> https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> 
> The unusable restatement of those links:
> ROCm/ROCK-Kernel-Driver#174
> freedesktop.org/drm/amd#2362
> 
> Short of knowing to look up into the patch to find the links,
> those references are completely junk.
> 
>>>>> At best all of this appears to be an effort to get someone else to
>>>>> do necessary thinking for you.  As my time for kernel work is very
>>>>> limited I expect I will auto-nack any such future attempts to outsource
>>>>> someone else's thinking on me.
>>>>
>>>> I've gone ahead and added you to the list of people who AUTOSEL will
>>>> skip, so no need to worry about wasting your time here.
>>>
>>> Thank you for that.
>>>
>>> I assume going forward that AUTOSEL will not consider any patches
>>> involving the core kernel and the user/kernel ABI going forward.  The
>>> areas I have been involved with over the years, and for which my review
>>> might be interesting.
>>
>> The filter is based on authorship and SoBs. Individual maintainers of a
>> subsystem can elect to have their entire subsystem added to the ignore
>> list.
> 
> As I said.  I expect that the process looking at the output of
> get_maintainers.pl and ignoring a change when my name is returned
> will result in effectively the entire core kernel and the user/kernel
> ABI not being eligible for backport.
> 
> I bring this up because I was not an author and I did not have any
> signed-off-by's on the change in question, and yet I was still selected
> for the review.
> 
> Eric
> 


