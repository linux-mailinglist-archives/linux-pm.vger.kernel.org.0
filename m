Return-Path: <linux-pm+bounces-14483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C00A97CD0E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 19:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E26285574
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 17:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E1D1A0B16;
	Thu, 19 Sep 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yP7cVinC"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCA91DDD1;
	Thu, 19 Sep 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766953; cv=fail; b=a2JRHFyCHUvYQuR21E5YAObTIvVobIICF3XBPxnunn0BHH03l42iGhQ7wykuWWD43ofXERGUssr7TEoFfEHGSS/8ICvOFuBkqchIAv4p5ez8kJ1zv6W+nINkDpaqVj/7F2I/ob7eCxoxcyFgOeMl83WpoUIUie5m8LYvsdKdrhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766953; c=relaxed/simple;
	bh=6xx5sG1mivUm8oXalqaxBa7znUlnOqvwjScf3gaKQ9A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bjt4xB4Duvls372jmydey5d+uTwr4hXIGwVyK+Hl0e2Tfyyt5nBHo+Z86ztB0pa67nvXK8XsFeKkDzojq4n3rv5bP0njlzr2zoZ4hkfAOPpFNfatuWjcvcSdJNvARO06R1F1NgwlVBvpvxrKBoHgKA5M30bh2a4FNCgHKcbXSBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yP7cVinC; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+Z17PgfOhgtveszc53BDaK7ixndQ4evr2EdmUp1rWp8kOwF02jhqZ6zH6vy4guUYQcqJ5lo2WWGoQN8EyLwjBtWbo6mc/ZH4YBMD90S9rcWkjTYoogGEMsYroBRchc0RSbcOEL9dcPoEI27+bL8jIwXX9ndvxNTFQ2ujP9TOPf+w7cJM1Ap+4bL4ifYH/tmQebNO9NLiuWX7q0MhFl/UoOj8G7Pw+RMHz7/yfstJ3T+xRZjFZKLIM6L7by2ie+VO6v1hA3QhZ9fdY8VctcG5P9LmuxDRKVJG32pLYQBXUfqdFrXEEJgEr6GThyXc27Q9mf4/4n3GLghKacO4HApYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2f5t5OG7OU/TN2wS+eVtGHQ1VRV2Fsx8pY4SSZaxwc=;
 b=LKBcRLQDyH7b+URIQnxmI+locKafFuu+5exio9/h1o8bhsZuAFS4srVl0+qXds1lxlrQepUzpfNg0D8S1VspY3tbMnND/ilAlQ1Y/mrpbA5uH2UwI0bxZYhwsFNpNqbusOjHD8QdYjMRAvwGOWi3GXnkglAxUlfgSMxm871YijIRzf13NfHfZvefdw9YhHlQVcS7FgHIrw1ZOXklxSvgh61D2oJPbgAuq9ujDaVNXPdv9kKtROI+3swXjmzcTFkBozZAzUgsPyufjTw3nkgRjGEe8KTuR6/SCnoB7Sl8195AYkZjAIIkakQ89I3xDNp05T5RDZfdPJ9mLvCkeCEGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2f5t5OG7OU/TN2wS+eVtGHQ1VRV2Fsx8pY4SSZaxwc=;
 b=yP7cVinCmKYgY1Bvwmy2NwNM87+eSy6Ai8vo3Yf7YFK3UfLroY5WE2D7zsZC7jKp7tVagRGI9olL3+Bizns0d/LxZV2FUyMxjANUhah8P26a9pww+1tUcg9rUqsNyYwYt7fj8wef71lgrzdNTnnM7CzQEkk8lAmBWZIr/XqoNMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 17:29:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 17:29:08 +0000
Message-ID: <0f758a1a-958d-41d6-a572-cf544590450a@amd.com>
Date: Thu, 19 Sep 2024 12:29:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] acpi/x86: s2idle: add support for screen off and
 screen on callbacks
To: Antheas Kapenekakis <lkml@antheas.dev>, linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, luke@ljones.dev, me@kylegospodneti.ch
References: <20240919171952.403745-1-lkml@antheas.dev>
 <20240919171952.403745-2-lkml@antheas.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240919171952.403745-2-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0107.namprd12.prod.outlook.com
 (2603:10b6:802:21::42) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 7293b0c9-2ce9-4765-1013-08dcd8d09190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djJtaEFocE9FallaaVpzUnBDUC9kRVV4Mldzc005cU5HSUl2REJWdlFyYnZa?=
 =?utf-8?B?ZGZ3TThySFRrWW1SYnBaRTc5bVpNVkVkNUJ6MnNkRHlnU0xZcWJZUVVQek42?=
 =?utf-8?B?ZUR3dHdHV2ZqSklUQ3E1WTlob1dTdjJvSDBuY0Jad2tEWGxDanZHOU51dlFR?=
 =?utf-8?B?OTZOVFhaVlJZY3JFcitUbmVBWFFyME0rcW9NV1dIeXpMTkxxTlgwUnZtK1hI?=
 =?utf-8?B?RjJMbldkbTlWU0gvb2NZTjJQaWFXclFSenRuUytSSmFDd1N3YmMxa1hkZXZi?=
 =?utf-8?B?dWdiQThDV2Q0ZEVUZTlUSldGYVdOWE93SGYvdkl5Y1FWRFVXbjg1YXU1dE5p?=
 =?utf-8?B?VjNEVnZTUGIwaVc0QzZwYmRXRlpjck5hdVd3S1RURWZ6VTZISU9MRmhxeFEx?=
 =?utf-8?B?MzhFYUhBNS9nbGZ4M3dMRFh0NDJMcjNwRTR0SHRsSERFcXlFQ2ZzQWhnNWxa?=
 =?utf-8?B?L1JNMEdwZkI0Rnl6QllWN1pORHFQNnBwSE1mck8xUVFTbWxLRW5tZHdWUEpz?=
 =?utf-8?B?RzBrdDM3OGU0QnJ4ZTR0UVlsREVMMjB3TFRYaG9lMzBoSnpoT0h6Rk5PNzdM?=
 =?utf-8?B?WklVc3ZnYUN2Nmg5MjRvR0MwdEYvdVJuK0VveURodk1lUmt3NlBQbGxaNTht?=
 =?utf-8?B?cjl5RXFIK3Z6aTlQT1RQeU50SlltVzlicXFqMkxyNHg1SDJVQ1Q5aGpjRHBh?=
 =?utf-8?B?ZHpOeDY0azIxSTFIbklheDJSaXNYNklWZW5TeWExK0FkRUZqTzU4YzNuZUJz?=
 =?utf-8?B?NmF3MTB5M0htQ2FLNlNwVnQxUHdpdHFvanBpR0tRbFB6OFdsYlZSa0s3T29H?=
 =?utf-8?B?NXMxN28va0NpUG9qQURtMUpXVzdLMUkwQnNoNjNybWRHWG5tY3FSYklTRFBw?=
 =?utf-8?B?QUROOG9peEZLQnM5aFNrZzRKbHBCTzk1NVJ0UWNlZ1o4dkNTT0hKUXRQZHZ0?=
 =?utf-8?B?em9hQlNoTHR0MFN2VlRRUVB5TkZpQVRyc2hGTnFJUVN0QktCOTJuSE5rKzJa?=
 =?utf-8?B?dUUra3ZPbHdSWWw1VlF6YUhWLzhjblZCQTVKMzN5OWZDQXdwMnNrbmFKdU9r?=
 =?utf-8?B?ckdlTHdJU0dnOElIZHJFUHJwZnc5MzU0dWNoWnRDaDNlZkNyUStCZ3ZrM2M1?=
 =?utf-8?B?QzVYd1JGNlIrYlJBOUNoT2pScWVkUFhsTkdlb2Fub1k4eFZ3YTUxdC83di9x?=
 =?utf-8?B?MllpRy9SZDhhMnN6QXhQeFJuMnlZSXpqU2ViVzBZbVN5NCs3UHRPbUhYeFVS?=
 =?utf-8?B?UXovaytES0NIamRNdVVydEpBSi9Ya2RjRCs2UVVLTHRDcFNEZzhLVWYxMWNX?=
 =?utf-8?B?SldWUzEyNGgwKzBRei9nQllvVDkxellBQ3RCdUlxb0RBTjQ0ekJhTFJUUk9P?=
 =?utf-8?B?WGhYNTRHV1JTTW4xUXhRWit3blVhRW5GbEtyU1F2c1g3WTFQTnczNUVSNmF0?=
 =?utf-8?B?aWhyN250NEU4QUFtcGhjK3NUWjVmdStFQ2ZsWUltL05HKzBrSzhhSXEzV3lB?=
 =?utf-8?B?NmlWQW5uL2JpSkUzN3M0akduMkJsanZucjQzYWNTUHE2TURyYkxlWWVveDhk?=
 =?utf-8?B?dlcyT1hwbktQeGU4RDhVcnE2aWUrWWJNMEs0UWk0eGhYKzJHK2VSMk9Oa2JI?=
 =?utf-8?B?ZW9ISHVhbldURk5oUGJGVlZWMHpGNFRVS2Q4WUJHRW9WZXQzandkMG0xMjVG?=
 =?utf-8?B?TlNPbXo3ZmdCTUtSMEQ2dmtqbm12TEIvRlNWK2J5ZXBNckRtZGRoQzdCdHVM?=
 =?utf-8?B?YUJhRENwbk9YVWc5TjlvQkRLZWV2NEdzM3JORUQ1LzBlNExlN1o1U0Y3cnUy?=
 =?utf-8?Q?BywqQVZmK6/UHvPgsTAW3Tiy7Ky2GO7TyWZO0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2dGVWZPcll2emFaMEd4M1gxUlJKdHAxNHdSRXp1QWE3a005dDIySTE5WDRT?=
 =?utf-8?B?MElMSGZGV1grTUowcG83ejZwMGk2M1oxSEIvd1FLZnpoVlFWR1lYVmNKcVA1?=
 =?utf-8?B?UG9CeUZyRHlMNmo2cEN0Q2dzcmxwU1VpRlJWWnN3aFVkYzlkbWdkS3BRV0E4?=
 =?utf-8?B?b3hTeUcrOGlGZ3ErNlByR0NvQStidW54cWdtVGVKL0JRQTZvRW05cG1McDZ2?=
 =?utf-8?B?TUZVQUZLdFFuRnFIY1Jac21zRThEa0ljSUJQUFhkcjJzTXJMUVFacGJBWVUx?=
 =?utf-8?B?VXpKZE0vNE9qNitXa0RpejFTT2ZOb1E4MXh2Z1Q4RDQ4VFI5MTM4ZXlORGwy?=
 =?utf-8?B?N1dJTDNmNjYwb1hoSUpxcVY5RmtEeXB5NFNXUnFURms1dnY4bTMyTlpDMkM0?=
 =?utf-8?B?a2FGak9rQ0lJWkt3KytjTEZjZUg4WkNoZTNBQ0Q5R2s1T0lKSU1rMVB0Vm5H?=
 =?utf-8?B?dWRwdGt1d25PYnpBV0pET3Y3RnA1SlN4UE4rcU1CZ2YzSHcwL0xxdlVUeUVT?=
 =?utf-8?B?bEVpQXpUaisvV1dhaGVrWTZaYWVGTll4a252T0hHMlVLZDQvOHVKTVNieW1C?=
 =?utf-8?B?VDJCYkZmSU95eWJCV2tqblRJNWhTTWhmR1hpWGpXR1I1K0lsby9IY3paNTND?=
 =?utf-8?B?WHNraWZNWjZLWURpQnNqM1k2RndkME9WcEFzeEhxdDN6NDdrOW45REl3bDRF?=
 =?utf-8?B?VkNtUTNsbEVYa09PbUtzVTlOWlJVQ2xLNjZ6bmR1V2EzeVM2cy9FeTEySTdX?=
 =?utf-8?B?Y3djc083Vm9WZS82RUlmczIwMDBaVGpDYXdmdkZaWWNTKzVUenZEL08xY0ZR?=
 =?utf-8?B?WkVXYWp0b3lFd2VSWStJTVBiZnpVTTE1Nmc0OS8yODdrZ1VibGhjY0IxaDNR?=
 =?utf-8?B?V2VsLzUxVDd6TURZRzczd2IraWlQZjFSRGlKN01kMTBBVVFCaEIrcCt3UUVI?=
 =?utf-8?B?Wkh1WjRrL1ZxNjBwUzdBLzlRTlJSRktEZWtxY1NLdzl3UXZ4SGJ6enl4UzRD?=
 =?utf-8?B?dmN5UFR4NnFJMStGOVIxaVlaU3lpQnVGVWtyd1hiV1ZMdkc3c2Fjemx4QXhQ?=
 =?utf-8?B?V1VSODdPOC82ck9Pb1pQRmlWRXlUanpYcEVicEMxeS9xa0lWZFNoajF4aHVN?=
 =?utf-8?B?cStWWFAzNzZsd09FcFRxTEljZTkrdE1TaEtneFd3aHpYdnNlMzAvNVFjMUc0?=
 =?utf-8?B?SG1Nd1YyaWpPZ3d1YisyMmY3cThTV25WREM0M0ZoUjRrbS81STRqZmNKNExn?=
 =?utf-8?B?elhldG0wcXh0cFNDQi83VC95S2g1V1hRTG4yVXppVnpSSDdYelYraWNNOERh?=
 =?utf-8?B?d3pFN2w3TndmL3ZJd284azI2blVvKzY3dHFZR0JkVVhPRmFVRVJibGNVTUlX?=
 =?utf-8?B?K0dnR1lwcWQ0RlBDbnY4QWhieUMwd1RqaGRodGZrWTVVWFhtTUM1VW9OSXFS?=
 =?utf-8?B?NnUveE4vRXQ0T3Y0MFhYcnExRUtuY0JJS3A0UllCbnpFVW5HVThNLzhaTk96?=
 =?utf-8?B?aU16cHJ3QnRxM25aTEJVQlJGUncrWVNBSEtYUFpSbkgxSE00alB2bnl6R0tO?=
 =?utf-8?B?dHdQbHJ0MTgzOTA5OTMzVG1oOERCOWFGYjB4UGlsaElWUUZ2WUt4WGgzZ0Ry?=
 =?utf-8?B?SXlLZkR3dzJSUGR3Z2NEZllnN0t0dnNrd2FEOGhWOGpMZGUvTFlzYVNEMVVN?=
 =?utf-8?B?aG9oaWVqYm5BM1RRbGh0L1c4VkthWVlyU0l5U2ljS0dTcGZJRHhLNlZpbUFv?=
 =?utf-8?B?WXVocTBhUUVOYUM4ajBYM0pLdElDR01QMmVkTnF5RHE4ZVlPbzhKZU1pR2ov?=
 =?utf-8?B?dUJmT0tWM20rUEhJQXVXVnY5V2ppOW00MUlaVGtRMGw4U0hGK2o0SWFJOW1G?=
 =?utf-8?B?ZHU1S090UU9JcC9qZ01tcGNBSTlpOVV4TXFLUWtPK2RjeHlCTDFwc0R4TUNP?=
 =?utf-8?B?cUtPb2dVZlQrWTV3V1VXRUtrS3o2aitpamJTMnhtVlFVTTBJdGFYNHI1TVhk?=
 =?utf-8?B?Tmw5WEczalY4cDYwNU56UVpLbG8zR3M1cnNGREMwKytJUDFiYUlsVEtJMnNJ?=
 =?utf-8?B?SmZTc3lpTFhvWFVQNVRONHYyaU4yM3l2V2c1TENHcUdheTlCRFRjakc2eWlv?=
 =?utf-8?Q?mBuzSDH6xP3COdxfWLQX9Muaz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7293b0c9-2ce9-4765-1013-08dcd8d09190
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:29:08.7995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEAtrwk8ZbK0u12DKKabBO57yPUvs5wi1wqg+EQiWvsWmwY5iM4GhzUE7rYliwO3MJtKm4HjIyPnxw0wL6vxlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511

On 9/19/2024 12:19, Antheas Kapenekakis wrote:
> The screen off and screen on firmware functions are meant to signify
> the system entering a state where the user is not actively interacting
> with it (i.e., in Windows this state is called "Screen Off" and the
> system enters it once it turns the screen off e.g., due to inactivity).
> 
> In this state, the kernel and userspace are fully active, and the user
> might still be interacting with the system somehow (such as with
> listening to music or having a hotspot). Userspace is supposed to
> minimize non-essential activities, but this is not required.
> In addition, there is no requirement of suspending post the screen off
> call. If the user interacts with the system, the kernel should call
> screen on and resume normal operation.
> 
> This patch adds a set of callbacks to allow calling the screen on/off
> callbacks outside of the suspend/resume path. It is based on
> Mario Limonciello's patch on the superm1/dsm-screen-on-off branch.

Based on?  It's nearly an identical patch [1].  The screen_off/screen_on 
lines in struct platform_s2idle_ops are just placed in a different location.

IMO there should be more attribution here, either a Co-developed-by tag 
or sending my patch directly and adding your S-o-b to it.

Link: 
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/commit/?h=superm1/dsm-screen-on-off&id=7b80581428315f973410dccf0402a86266fb0d9a 
[1]

> However, the intent here is completely different.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   include/linux/suspend.h |  5 +++++
>   kernel/power/suspend.c  | 12 ++++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index da6ebca3ff77..96ceaad07839 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -132,6 +132,7 @@ struct platform_suspend_ops {
>   };
>   
>   struct platform_s2idle_ops {
> +	int (*screen_off)(void);
>   	int (*begin)(void);
>   	int (*prepare)(void);
>   	int (*prepare_late)(void);
> @@ -140,6 +141,7 @@ struct platform_s2idle_ops {
>   	void (*restore_early)(void);
>   	void (*restore)(void);
>   	void (*end)(void);
> +	int (*screen_on)(void);
>   };
>   
>   #ifdef CONFIG_SUSPEND
> @@ -160,6 +162,9 @@ extern unsigned int pm_suspend_global_flags;
>   #define PM_SUSPEND_FLAG_FW_RESUME	BIT(1)
>   #define PM_SUSPEND_FLAG_NO_PLATFORM	BIT(2)
>   
> +int platform_suspend_screen_off(void);
> +int platform_suspend_screen_on(void);
> +
>   static inline void pm_suspend_clear_flags(void)
>   {
>   	pm_suspend_global_flags = 0;
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 09f8397bae15..19734b297527 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -254,6 +254,18 @@ static bool sleep_state_supported(suspend_state_t state)
>   	       (valid_state(state) && !cxl_mem_active());
>   }
>   
> +int platform_suspend_screen_off(void)
> +{
> +	return s2idle_ops && s2idle_ops->screen_off ? s2idle_ops->screen_off() : 0;
> +}
> +EXPORT_SYMBOL_GPL(platform_suspend_screen_off);
> +
> +int platform_suspend_screen_on(void)
> +{
> +	return s2idle_ops && s2idle_ops->screen_on ? s2idle_ops->screen_on() : 0;
> +}
> +EXPORT_SYMBOL_GPL(platform_suspend_screen_on);
> +
>   static int platform_suspend_prepare(suspend_state_t state)
>   {
>   	return state != PM_SUSPEND_TO_IDLE && suspend_ops->prepare ?


