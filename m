Return-Path: <linux-pm+bounces-38934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C565EC954FD
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 22:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694E43A1AF8
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 21:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F721D590;
	Sun, 30 Nov 2025 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rf1Qyaz3"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90CA1373;
	Sun, 30 Nov 2025 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764539097; cv=fail; b=a2oqZ77Gbnmsf5V3Rkji//s2W30T5ycvPwU7+AgS3mwM/Gybb9BvEKGJRWgMqWgQvffkcFsURi7gyy7Z6mCkM0qsdI4Q1e+Q5kXJMeahQ2E4K29DZvcIoKnwZ6xZYbjvGBx6XpyvJEpRjhYwfYyQ5mHtqBochjvvMLC+K76yG80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764539097; c=relaxed/simple;
	bh=EX+lGJvhE9/Jp8lezFSCtR1V9oWbqFHblJDKaXwj5dk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tIV3L+zzoLRPL7XNC6olHOoNQkILc1TD5QQcjO0CMrko3oI60GDvse//ZwOZhnFV6WiebvmEikkRZdZBX9cBEqqpuJPxMjJolXylHF4TRZtODIxwwBtjey4t0H9fRgW/MD/tkTOu2FOHpZ5soF4ASmIlyvetu6JzVkD3rELgd9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rf1Qyaz3; arc=fail smtp.client-ip=52.101.61.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jq3qh0W7qQ38X/A4y5pTZe3V0C80BX45iPs8GkyqYihXB445euvytTlHmD1e8MqEDgqrHUHfg2Lv9NgRAG2iu1Y5Sszx8ZWZZb3NGpO882WrguAZGHV+zKjVnH4w+OrV2zIj/FWOTPx6WvAsmvufsjsMGenk18SITMRXyOQWSNreVsyecBIODkYPTHAB9tCUdVub0XwyKSFA5OAavJAa8rLMhNaqV4wqihljQTIH+7qUMu8V6vk7NGhypLeNa9M+y3ln5K+6IuQHJ3tWLm9rP5eI7dtPQJcIhVuv1qdv0DAMxAXUqQKCQNtyXFw7s6zEVNOFLCHmoAgnwZLWaFpdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+rEQhJYCgvZfSDyxyFyZMPLKfFjoJP77rog99CnBuU=;
 b=vP+O7gTphKeYAvxarTfmFiOzJQ2ODnr4dOlz8N7+Gzgg9QGphSnukIVKdWEChprIfh3HK7w1MSoToJ/PB59f2kbQ5Wx2fNGMSPuWw8jLCv6Xo+Dv/LJxJhm02IIwg/DNiY6GZTHU3x2cKeWKL+799UpOruS0ORoyKt+loq9FWEHTzYzpZAQ6nPtB3llnXaC6KFgPPdud397jr7kaF03TW5LBmDvHNtwPuzGr4KWvWTjvAdh8SzQ6tI3WnhlOkZ4RnayY8waBmEWUoOYsDI+P4WbLWlEDHIJHiAL1e+IxlBpg8QY/G2cmtM0EAdEII7CtDd9IK9yLnJ3NSLegApKyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+rEQhJYCgvZfSDyxyFyZMPLKfFjoJP77rog99CnBuU=;
 b=Rf1Qyaz3YR3uAdNN53yLyazNowTfx+KHt7VSKjKEYQKvEr+9gy3tOVDuRn7Ic1CARSWolDkN0DAdKNpXqfBF6C8xxWaYGeM5HjDrZZz6mYtd1T1laWuTFUUaoxxc+SsgIOU4kKy97Fdq4fuZUQq9aHC5bLP9CMuHFTvBj2C5csuQ9ROug6Fn0OKrknk/SpItmzaWRSqI+M5dLDTxgqGh3k2+tF33I0uD9yhwi3+/4jhYhP8YTAKZGS/TM/dSoXUuVNsEBN94/T4DPGp5RR6fX0KAhtbRkSyIU+ke9ZfO3iRFFf68TzqnSXCjgzIu6rB8rhG5DstVE6zWbkW+4BlgUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 21:44:52 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 21:44:52 +0000
Message-ID: <db6a6b28-c0be-4bd8-a0b4-70431df7737a@nvidia.com>
Date: Sun, 30 Nov 2025 13:44:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] rust: build_assert: add instructions for use with
 function arguments
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::29) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1dcf17-25d4-44fd-4913-08de3059b185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEl4T1YwQnNxS3B1TXplT1RMbGY4NldmM045aFVGM2t3cTdzYW9XU0djTFg2?=
 =?utf-8?B?UmxyV05McFBGWEN4WjFPMDJZN3dvWGMvZWc1NEhUZ3pFcUMwTCsyWThxMGpx?=
 =?utf-8?B?d2ROUXA1aExMWjF3VDdFSDhjSjg3eDBHT09wcEhtOG0zblh0ZTJyMVJ3MCs5?=
 =?utf-8?B?bW02WU1TUVJsR3BON2VRYVZJU0JXbnpyY0s3WWJaUVAwVVZWMWtrNHpzb3lh?=
 =?utf-8?B?U3JHTEFreUhLWFJSQnRmTnAreSswNjJsdWovK2tzdnc4dWVmelNSa2FyYUxl?=
 =?utf-8?B?Q1JGV3pQSEZteXpkd0drT1JrYmZVV2VzdnJsWjZjUWNlSW1tRVZkc0dML2tt?=
 =?utf-8?B?Szl5OTZJMmFpTzEwdXNxMmdEUDBkTkdhLzNVcHNPazN3ZVdheHFKR2FaeFl5?=
 =?utf-8?B?SGh2VmNoQ3VkZE44WWtyY3d6aHVqYjZQNVc2Y254dTdsbmY3cllYRlhsbk1D?=
 =?utf-8?B?ZGhjb1R6TnJGWHV4RVRwTjErQlkvb0dTMGJWeFJZZVZyR2xsMExVTlVEd2FK?=
 =?utf-8?B?OVpydTd6eE92MjFxd2tndHhjMkc3bG94VHA1NGFnNVR5cVROSmlVbThGc2hX?=
 =?utf-8?B?MEZtMzlmL1RuSUtOZG9zZlZpS2poeEhtdlp4ZHBDaHBzamx5UzdiRzR4NzJN?=
 =?utf-8?B?SFZGR2RxSmYwK1lTSGVoTG04dysvYnBVY2g1UDRieHRjdXYwcHVvWDBpbXdq?=
 =?utf-8?B?WjN2NnBhdm1RTldDc2x3Nm9wUXNNSjlVV2lwQ1Rhdi9PdW5wSTEvUS9LWXRh?=
 =?utf-8?B?VDFsbnNYTHNnQXRYRHpYTFNJOXkrQ0NDT1E5aDlLbS9iblV0ckpnQkxOenhO?=
 =?utf-8?B?VkZNeXFvVmJmZlpKVWdSd3FndTFnWVc5d1hnaE54VEVZWU1zclpKb0VmOW0w?=
 =?utf-8?B?R3BONWUydTFKdm1iaXN6TldTYloraWUxeFdkV1Z2Tm1TWDdaVWFQSmdaWU41?=
 =?utf-8?B?dnZTbytVbVNXQkNPZy91WEhwcUNKN3BIUkx1aDVtNWp3RlRGTUU4WEJBdTJz?=
 =?utf-8?B?UmxrYXRReGhRKzlEb3U3emgxVUlmbEU2b21EbldPd0JHSjljdzNtaHZrSFlr?=
 =?utf-8?B?MUN4OGJvK2tsQlc5cnZWK3FKNXVRcEhZSFBXVU9QSVpVQXZrRmRzREV6b3p0?=
 =?utf-8?B?UnVSeG9wNFBPblB4SXlhaitNSlU4Z2JzRDhETk5Qbm9wUXJXU2xaa1l0cTdj?=
 =?utf-8?B?bHZ0bHVnZlFSL28xeHJVWEtTYk8zVjJPaHF2S09wSDl5Q3pLSGRSclhwcE84?=
 =?utf-8?B?U3ZMRmx4M3J2OWRueGxJUldxa2pFbFNiR2lCWGtFa2lNby9QcXJqNUVhVC91?=
 =?utf-8?B?a3AyVFBLRjhJRURkK1hnc1dqWEthcGlaWjk4L3NPZk9ta2lDSis0OXVrZFNo?=
 =?utf-8?B?SDRBL2YzVzdTeFVxbUhTWE9CNytQb3VRakhxYW1QSE80Qisrb0pPY2JVbjFx?=
 =?utf-8?B?WXdUU2pIR3M3VmNTblZkY0RBbWlia0g4bjFFR3M5bkNObmpmTitPZ1hVaGxs?=
 =?utf-8?B?ZUpYUGU2WUNjRlJWdGxLaHgyeHovYmlqWm5sVm02eGxISEFha241U01kVm84?=
 =?utf-8?B?VFhtM3BHM3pQelM2K3NCbTR0Q01oY3FKVFpaaE5ma3U5bnBwRTk5OXBCcFNi?=
 =?utf-8?B?dnp1K3NnV1FUTzcrZmdLZklmT01uNGNBTmxoSGFaZ2tLQkY4OFdGOVUxTyt1?=
 =?utf-8?B?clVjOEdnOGtzcmhLOGQxNkhvUWFyWE1mNTN0ZnFIc2J6VThPZHlHQVo4WDV2?=
 =?utf-8?B?NGZaZEYwWldZbm5iQzZqMXQ0T2Jzb1ZBME5ZbHVzRTVDVlNQZFJqTU5MR0oz?=
 =?utf-8?B?a2xyYlYzQnpIczFPUnBrUksxS1VyeWxFSWdBVDRnTVNyNWdKY0p0S3paVVJ4?=
 =?utf-8?B?cnpKRWJzYjFKRThueEJtZ2p4b293eGxPWnA5c3kzZFZPRDRYaHdYV3o1M1Z4?=
 =?utf-8?B?cEc0QzhrL0VsdDViRmFuWTJQOWFoV1FqK3lGTGVNVGdWZkNoY3ZXNzBxWU8w?=
 =?utf-8?Q?4qTw+mXEgUArvCg8FTA/TMn8epSKto=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEdOVElPVVdHTkxBMHZtbERxRDlHbC9jUFQrdDZVSXRHcTF3ZXNvcVYwQjho?=
 =?utf-8?B?NlNLUk0wY1VlQkVIQ1JqSGtxNzVwc2ltSjhCNWRXZXd4N1Nkc2Fnb1FCNXor?=
 =?utf-8?B?QzlvMDZPRWFSbTBkWDNhWlJHeURHNDViK2V0TFFBVTkwQzRCMC9jaFNHSkRO?=
 =?utf-8?B?NlRqdkh1VENOMVo1NmdGdldyTTFwQ1pvZzQzZlhGbGtuNkNtOTBrdmFQcWJG?=
 =?utf-8?B?OUhBRUJxME5JcHdrKy95WVdaaGozbm02R2Nud0tyOG9TQnYxZUdVbVUxenRC?=
 =?utf-8?B?UGp6VnFPZzNVZjc1ZjZIeVdTeUhVQU9VdHJWVG9hSE12RWZMb0pCN1NSRGdq?=
 =?utf-8?B?S0dHVHcxc09VMzFNWTNpZ0dVRGYzamN2djR6bnFoV3htOEhPM2tRU3FNZXMy?=
 =?utf-8?B?eFpWTjB3aGFnK25QNGc4TUlhMWQzaEZXeGxiVDl4ejFWcWRDNGV1NlJvOUNN?=
 =?utf-8?B?cUxJQ1pCamZPWW5vYmlzQ2E2a05ibzY0TlVQRXk5WktQUTlVUzhFazFYNzVG?=
 =?utf-8?B?KzJHSjk1WUJoTDZBeDNzV1BoOEYrL0Y1ZHFxM3Q4dUFRUFZmU1h2dk1hR3ly?=
 =?utf-8?B?QkRiNTM5NDR2b0tiNkl2bjJ5RUxVSWloa1lRL0FuTTJqakxXdGh6d0NpZzlJ?=
 =?utf-8?B?NG03UVFQWWNVQ3JXTTAxZUs0N2k1WUtEVUplWjlWS1l6S1hCbnhHU0RwWkNi?=
 =?utf-8?B?NGZNbzNhZlVrWGlqRUhUWFUzUms3akJnYTVORkg1Y2tYRGpMU2VidEJQc2V3?=
 =?utf-8?B?SVczZ2d3MVVOYjE2MTEwVFJSN2dmTUNQeDRqRXoxd3VxUVN6TUZ1WTVIUVhk?=
 =?utf-8?B?OHNiSEpDOE45YVB0ZnlFb1RGeTdBS0NHOEd3QXp2SjZPUWQyTWFjRWhzR0xa?=
 =?utf-8?B?VU9aaWJCYkRqRnR6NSt1YlUzVXdBZmE4YlA4cnpNS09TaUM0Z1BRWEJzZ2pw?=
 =?utf-8?B?enlLcXRxRHc4RjZuNGJxaFg1bldJczBTeEEwZUQxa1F6enJoQ0tCa2FYQ2hm?=
 =?utf-8?B?aEVXRXhNMnBkeVB0eXJoWEJEVlRaVjNON09QVjJqak5VZzJYMytwZmdZRUlV?=
 =?utf-8?B?OGxWN1FNcUU1elBwVHBSSnV3cjJnVmk1ckY3N0REaVVlTGlUNkxoTkhrR05X?=
 =?utf-8?B?d3BLbzdkZUhaRS9JN2M3eFIyNkYrZlB2SWhXVm9QMXJRcndNdnpTb1V2Zmdp?=
 =?utf-8?B?OXZINDdiV0xVSkRmMCtlaW5ka2doMGdCR3BlVkk3RTZjdFgxN1JSVm4vQy9Q?=
 =?utf-8?B?bmp3QXg5dnlTK2JTc3NMVEhoS3hEdHdaeGVjbTE3R1Fsb1Z1aXk1dlcyZm03?=
 =?utf-8?B?RzQraDdYZVVjRE9TMnVoRy9YeEw0bzE2WldlN3c0MkdIRHozZTZidUdkSHA5?=
 =?utf-8?B?WkNTeGRKQ3JCcEh5cFVjMVVWQ3VCclI4SS90OXU3RmZWNjNqOHFGL25XMmxE?=
 =?utf-8?B?LzduTXlTU2JCTzJGVGxBZUJRQ2Q3dEQ5b2ZIRHNCcWd1Z3c5a014MGJBTWN1?=
 =?utf-8?B?UFlqVG9ycDBtWTQ0N0trdm9HeVc0bTQ0NlZNZGdjN1F0Zks4VUFCRVUwMUM5?=
 =?utf-8?B?UHZCRWl0OWlyWEcwZEZXQU1yZXgyMzRpMHFGdmFTU2VkSHMramRzMURWTTJs?=
 =?utf-8?B?bmQ0cklmQkVvUSszRTM3elg1OVRpaTdrOFNsQmdYcXlpMVliOTNuSHB3YUpT?=
 =?utf-8?B?VCtwdUpFQ3h0SlRqNXpudGtUNk5ndUxlOGNrRS9hS1dvUDhicFpEV21lL2NT?=
 =?utf-8?B?bUI2Z2lVeWtBanpxQkxPNUl0bURtTitXU1ZITHNhSS82WHJUMXdpNHBQZTd2?=
 =?utf-8?B?clBIU1dWdkluY1BNT01velE1ZjNManJkK25QSUxBdWl1S1hPMkl3VktqYnF1?=
 =?utf-8?B?MzRHQ3Jsay9zMytUaG9HZGVIVlNuNG13TDVBN0hQMDRPQ0ZCenYzS1lKWktO?=
 =?utf-8?B?Zlp2UnFWUGJYd2Nva3VUM3hQcVhMZ1kwSW5PZGtPZURCY2hreUVlUUhUYnox?=
 =?utf-8?B?MEg3Qy9GNmNxdU9GNVpxNitleTZDK0dOL0FFN2ZNdU5YRXpFcFpIM3dGNnI5?=
 =?utf-8?B?WDYwMHM5Y1dtR283NnBZc0cxOGRrTFd1bythVEozN2pKVVQrL2d1ZlNIbFRv?=
 =?utf-8?Q?zFbaJ+82dcvUTwBfBPGYN4QwF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1dcf17-25d4-44fd-4913-08de3059b185
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 21:44:52.3227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkWEDFvkO/iVR74C7R3WE3NgfIkfHUmqxy2buW/VLFP3kCsXuQYScEH5XOb/2k/NDEXqtF9m2Rt7Fe/ZzMoENw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151

On 11/27/25 6:11 PM, Alexandre Courbot wrote:
> `build_assert` relies on the compiler to optimize out its error path,
> lest build fails with the dreaded error:
> 
>      ERROR: modpost: "rust_build_error" [path/to/module.ko] undefined!
> 
> It has been observed that very trivial code performing I/O accesses
> (sometimes even using an immediate value) would seemingly randomly fail
> with this error whenever `CLIPPY=1` was set. The same behavior was also
> observed until different, very similar conditions [1][2].
> 
> The cause appears to be that the failing function is eventually using
> `build_assert` with its argument, but is only annotated with
> `#[inline]`. This gives the compiler freedom to not inline the function,
> which it notably did when Clippy was active, triggering the error.
> 
> The fix is to annotate functions passing their argument to
> `build_assert` with `#[inline(always)]`, telling the compiler to be as
> aggressive as possible with their inlining. This is also the correct
> behavior as inlining is mandatory for correct behavior in these cases.

Very interesting. So by adding a partially faulty build_assert!() call,
these functions were actually wrong when they created! Maybe a Fixes:
tag is warranted.


thanks,
-- 
John Hubbard

> 
> Add a paragraph instructing to annotate such functions with
> `#[inline(always)]` in `build_assert`'s documentation, and split its
> example to illustrate.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>   rust/kernel/build_assert.rs | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/build_assert.rs b/rust/kernel/build_assert.rs
> index 6331b15d7c4d..f8124dbc663f 100644
> --- a/rust/kernel/build_assert.rs
> +++ b/rust/kernel/build_assert.rs
> @@ -61,8 +61,13 @@ macro_rules! build_error {
>   ///     build_assert!(N > 1); // Build-time check
>   ///     assert!(N > 1); // Run-time check
>   /// }
> +/// ```
>   ///
> -/// #[inline]
> +/// When a condition depends on a function argument, the function must be annotated with
> +/// `#[inline(always)]`. Without this attribute, the compiler may choose to not inline the
> +/// function, preventing it from optimizing out the error path.
> +/// ```
> +/// #[inline(always)]
>   /// fn bar(n: usize) {
>   ///     // `static_assert!(n > 1);` is not allowed
>   ///     build_assert!(n > 1); // Build-time check
> 




