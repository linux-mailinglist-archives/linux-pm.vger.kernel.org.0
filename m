Return-Path: <linux-pm+bounces-38936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F992C9550F
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 23:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9FBC4E028A
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 22:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C79B228CBC;
	Sun, 30 Nov 2025 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uEBOoK1p"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010064.outbound.protection.outlook.com [52.101.193.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2C22B5AC;
	Sun, 30 Nov 2025 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764540075; cv=fail; b=Cok+M3D4fXXZQ+joLd51tmtz2jlO9yqlEns7ZzaaChkJUaaog+4I+YAGDSb/8WtNhcCycUCX8WSec3oo64jnhDxK84z+G6lLGJbuWbgo5ac/vZZIoeci3YkoOXBTcFW6U49R8sM2m5A5kbeavriw65jDzf+Q/a/eZjV6q7+8X1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764540075; c=relaxed/simple;
	bh=28pn3mOLNlT975tTG0cXw2ED9HZTGoekelQY5UfP1aw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D9g7kdOduknTdRsGiBQKjgeBWsQXsUVleROa/w+bRNYs/RhTho3ljAkuTkV89wsxseQburVtN9NVLZHSOjEuFj8nrcB974Ese/hNVUkg3xySRDvAo7udGOPq3nsWhSj2a1GrIoe5oa7PK/RIrB97im1sXhu9+AMsp9cxfudLEww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uEBOoK1p; arc=fail smtp.client-ip=52.101.193.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+n/27au+YD6qomoc1usjgcrdnUdPCBArR4o8xWQc8C9ul0TbJOhocT71lqHzdCQQMvQSs2vHllf/CmqTkiFozJt2cQVQfLWyEDfAnQrcTIcvJnwS5uveBYsgNOnlUpKiZH9wMkN8eUAm0kdNqU9Cqy9ZzunV1pgronfRf7hGk0rL6LAQmodUza2q3cvMdgEP5nDrkn/9zjf5rbIl2WdNX04LUIaB7AGPCfQ7pCNZhi6IV2C8UnA8GXDmyEpnfJn4KpftVm+MKEZrxF6vIeqXQEcydTIFWSWQjPeIw3yiQR+NthRjarJWwA7/xiRRYlNVjk6AY1PNXrO9LA2kFj3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGRUSC6cmaR4GlA4SEBaQWu/XxToASOyNwnYa2wHUd8=;
 b=Jt6O1s+L6x2oAVLDkqK8DuWvtrqWySYujIR1U9S0Wgu8cgIfXJO1lctfJoRqYbwIuJgJSpmBrb13GzYtu9AF2ddPNr5je0pZj7/4/2sB1vJh6qGOGMQp74mT3S9C3Han119dcuz33TWW4zoOfpOb3JMQ52LRGJo6/rU09MofnFvmR30RoTb4+3yaljglweY0T3TLH+YiAIMltuLngOXnb/Bm8wU1i8OFsXDcUF5pg1XPtTR5b/D4UkdbjqhNLvOJU70x/ElZjCqZv11DZKYRsC+h4JHOREAdZ8y2rbv7OFYcfLrEtVkQTcMJG5MpVCE/lsef+5afdD1eWUjYzWFjxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGRUSC6cmaR4GlA4SEBaQWu/XxToASOyNwnYa2wHUd8=;
 b=uEBOoK1ppyD3onmplb2Mbmo1z7o+5AmCJ/4SAt6AMdR561NfNQGyzAsL8Davd1gKbvdiNX+cEQPgb0EdI49ZV2v2t7bj8cFIybvKPbT0L51orYTx3kDQE89/KEzCDYnW0DJ+k6zlpLO64gZTrljdHLzK4PBeGEwdcmrWwpiMWbATJu5zyqvOTI31p4+lZzQNvMP8Qo3n/MSdKlGeCcjb2rIOLsbr7RyS7RSOvswtA9In4/zacd0e3ZnruqEbg6ULi6jMVHYbnAYUFhKU5/eHOdmmbM8CKK9utuEE+91WI3cjHNT8fGrbGt4CfhGcljQ1xcQnFi1B44948CHiotMtcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 22:01:08 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 22:01:08 +0000
Message-ID: <46b5eef7-2e8d-4801-93d0-6cea10f62dc9@nvidia.com>
Date: Sun, 30 Nov 2025 14:00:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] rust: build_assert: add instructions for use with
 function arguments
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com>
 <db6a6b28-c0be-4bd8-a0b4-70431df7737a@nvidia.com>
 <CANiq72nGUuK9VTYJGob7pnXU5zuuCzqfw6fezAFpbqvte1sDFg@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CANiq72nGUuK9VTYJGob7pnXU5zuuCzqfw6fezAFpbqvte1sDFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:a03:40::48) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 362a8d63-1024-4bd4-f413-08de305bf75a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NElyN3dSSGpNRWZFUnVGanRUWjliZ1pQcS95RmQwZ1lhZFhMY1BMU25Hckxu?=
 =?utf-8?B?ai9VaVlmYkNtdTl1WWZ3aU1FOXMvcG5ZU1J6VHV2eURnYUtpR1Azb2Z5NG5m?=
 =?utf-8?B?RzNsUjBneC9mYTRVT2tHbGZnVW9GY1BGK3FBNWJhazBEU0ZqK2pva3Fnc0c4?=
 =?utf-8?B?UlJTNVZuQVprTXJ2R0tlYXVTSndFaTdMdUpFRC93SXZOcG9GNlpremdRMXZi?=
 =?utf-8?B?K29wMTJIY1BvZjFycEUxQXdzZlhFeDZCM1VJSTI5U09McVRNVzdBMXEvMEor?=
 =?utf-8?B?YU9PTmFOQ2xFQXJpa3hKOFcvSFdyL3RPbkR3Q1BhY1N5a2RUVUZXQmJUdE03?=
 =?utf-8?B?ZVlrUWxNU0dtT0hNOC8yWTFaRktkYUYrSzlYK05HcU9YTFdBODZGa0EwL3lJ?=
 =?utf-8?B?OXdGa1pxNTFlZnFlaXdDYzZXY2YwMWN1UXRkRUxCdXFQamJvNmZuNXltZ2NT?=
 =?utf-8?B?VFRZN08rQmd5OEd3QzlQQlZxQ0lNZGUzK01yTGRLZUppZUd0VTFISk9YR1ND?=
 =?utf-8?B?ZUdPdWlOU1dxcjQwUVcvbjJEcHB0cGtDZzFiUFVmZ2ZmeVFaeFFIeXA0U09B?=
 =?utf-8?B?eWtUbTI5NmVPaGNyVXZJbWgyT3dNbDB1NzBwWXlGNTVpRUlqbzMvRXA4UHNK?=
 =?utf-8?B?MWZUakhZRHpNa0RTYW96cFJTQ0x0b0JxS1NwWDNhZ0VGMkZ2Q3VPYVBXVXlF?=
 =?utf-8?B?Ukl0QjdJSm41d3ZNMEJ5OXdmVjlVeXIwdzFBSjVkMzhNcEJWWThXTGZRUmN3?=
 =?utf-8?B?OEdrWjVybFhMK0NiajVQYTR2ZkNleUtlZ1dVRnVsVjFzWGZNdTBQeG1jWTRx?=
 =?utf-8?B?VnZGZ1RUb0F6NEhjR0NTKy9LNTl4dHI4U1BhWWhPWG5Fb3BIK2V5NXNqNFB1?=
 =?utf-8?B?U0NKR2NCb3ZBV2lESmRXVWNBZTVZWnlXRnFoamphczlKcjd5ZnNHL01DL2gr?=
 =?utf-8?B?dEMwa3piV2FlVWdUWGd0Rkt6eXg1eVlPelpKRElDbHRQejNIUXlWTHhzNXY1?=
 =?utf-8?B?aVlqYUJhUDU3eDFxWlBMa1lDMEZIL1VxdXh3TzlMa1g3ditwdGcrL25EMjRq?=
 =?utf-8?B?UEh3T3NLMTgvNVBKc0tNSzBzNWZwWkh0eCtuNEFzaTdKRmY4U1RVT0VSM2Rq?=
 =?utf-8?B?bFdUN25aV09TcDV5eElyOSthRk1nWVFCUWJXeG5DcWtDTWwrMUJqK2gxdzJn?=
 =?utf-8?B?dVVzU1RENTgzMjNPUTF6eGkxQ2x2emNnZmRlQ21NWUNiTjA5bXRESU5LY2JK?=
 =?utf-8?B?cExVeEp1MGVDdDlZbXlJOEJIbWEvYTFkTVhoWEozOXNlSTlUa0lISEZ2K2VK?=
 =?utf-8?B?dmdxNURjSEdQT283UWNwaC9pZ3BNMm9iSlF0K1lBT0ZWMTJsbk5ZVzBpL2tM?=
 =?utf-8?B?cCs4ZEVLY0hST2htQUhnaHNndkZJazkxSnNnN1pVUE8wQkxKQlVreXFtdVd3?=
 =?utf-8?B?SnVjTEFCeHNpWnVheERnU2Ribi9KRnEyNXhQUU1EeVdVL043bzdmT3dwWkVL?=
 =?utf-8?B?QjBxQkJPM0FlMzlVd1g0ZkhlMVlTTUFFRTY2MStId2FpZlN2ZHUxSDNuY2hR?=
 =?utf-8?B?dERaTWZFdFF1MzBFMlNIeE9CRWptUUhubE9YWjBlMjlJSnhJd0JobFIrM3Z5?=
 =?utf-8?B?UmM0WkMxRHAvSDRUY3V5UVRoYUpJcW9RQWUyWW5zZFFMSCt1RDBLOS9vYnhy?=
 =?utf-8?B?aGNwdFRlUVdPc3E0Vm9lRU5xNDdJRGlDTThBSE1USzd4QWllWHVQWWFNVU4y?=
 =?utf-8?B?OUVtV1JPNlZpS0hQVEtwOW5sZjZxZ21xMEk4Z3MzRHZQVk5aWXd5RzZMZm1a?=
 =?utf-8?B?bmYvRlIybmhnVk5PdVo5S0RlczJhK2dvRHpXWWF1RTFtS1ZyWWR4NmJkRUpp?=
 =?utf-8?B?MEJEY1luMCtDamx5VUN0MVRPb2RTS2JrUEJXcjd0bVBTV29ndFZ2R0V0b3Jx?=
 =?utf-8?Q?ezGy0VU1pSjoQZUnn5nq1No91RTU0jQ+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzVnV0RUQXJjYUE5QXVYcTN5YVBpVDdtMUE1UUtnSTZJYk5yRUFnQkI0THdj?=
 =?utf-8?B?bExFODFCUzJ5T0hrWmpjbVRYL0dncUNVNDV5Vm9DdnZmRCtmQTZjVjBwTkZP?=
 =?utf-8?B?WmxQWTdNTnBFWjdGN3dWeHBnSEN4Z0tkQ2dUK0hYajQvMFJualBraXd3ejNz?=
 =?utf-8?B?ZGMxbXZOMGtUTXlkcDRpcjE1VUphVjkwVm9QTURWVGRnL1Z5NFF2UmEzNC90?=
 =?utf-8?B?eXMxODRNRnJxM2xDdlovMnJpaGtqTy9TY2pOOXd4NUswbjVRL3o4Yzd2ZnRS?=
 =?utf-8?B?WW5NeEFzZ25xYkp4SUxSdUNnaGM3NmtaUWdiYktRaWZIL1JOL3RUUE4xVTdl?=
 =?utf-8?B?QlFlbUVvWWEySnpvUWk2QW1meVJtZVdVcFRYMlFtc214VUd4QXFHU2ZXaXI4?=
 =?utf-8?B?NFAxRHFrZ3pyTW9jYTNKY2o5cnk1Vi9MN2llRHNsRTQwUHVkWUtPbUM1Tk96?=
 =?utf-8?B?WTU3cEhZeDV1bERDMTdHUTBhQ2pzWlNLWDhTQ1FDSHFyb2ZCZnNyalB5aWZK?=
 =?utf-8?B?U1BqWE85SUNwSnlrbVVFbVhxZSt4QjVZZktpcDMreS94dGVZVEhBeHZ5MjM5?=
 =?utf-8?B?RDJZaGJoeTcrZDZLVnM2alovUmlxbFg3V3BzQklEb2ZxUXBibE5IdGRpYUF0?=
 =?utf-8?B?bHNwb04vTXFmMlRFeFJ5OThCaEJhcUNoaTJZeXY5Qi9mbHR5K1VtM0ZBVExp?=
 =?utf-8?B?ZUltRzI4SHFtMkhhU1FJeThvaVRtd2o1djcxcVZpVFJKbTM2YkJYU1h1MkJm?=
 =?utf-8?B?aWJQd2lLZlhHbXFnSnBxYk8vcVVrSEdLVEN0QitaTnJrekpPU3kxaXJ4KzhN?=
 =?utf-8?B?TER1RUM4ZnJNNjkxZEJTTWdVbUVYdS8yRXRKMlAxZllFaWdNOFVRTFJBUlh3?=
 =?utf-8?B?ajBjejlFZTlmcXB2bnV1d3Q4UnpZaDlDZlM2YVVOQmlLSWc2bVZrZC93Mk82?=
 =?utf-8?B?TWxyUmZtbnNYdittdDh4eDJXSSsxcG42Q24yRTNINEtOWGRqTzZMTFptVmRa?=
 =?utf-8?B?ZnVPQmFxcGRzYlU5YlJzNWp0b1NpclJWY0FibDI0WGllYWI4eUZGSXdPRUsv?=
 =?utf-8?B?dGMvREhvdlBKbjVIUlRxd2U0RVExVXZOdVE0OE9wNC9MUmpHWG5wMk14TkdK?=
 =?utf-8?B?eGVGOHhkQXU2QkNxV2tjSmFodWF1cWE5UlNvMHBkMjZyR1pDNTFvTWcrSUQy?=
 =?utf-8?B?bGsrYURJbmZCNEp6UzdIRytnZ3NKYlB4WEhsbXVrNGtwaXNkZUhpN3ZvdTVr?=
 =?utf-8?B?R0hKSFFNVXkzTFNCdkc5ZWl5TGwwRUZiZ1VDSmZXeit2UEdJZGpYaGRhOXJK?=
 =?utf-8?B?Wityc0tsRW9zVGpkejdFUmkvSEc3NnNoSDYyazRGdjg2OVZMOVlvNW84a1Mw?=
 =?utf-8?B?Rk9wTDN1a2J6RjJwWWw5OHNZZ2hmZlJDN1ZGUkNJdHlON0p1bVU0b1lJTzha?=
 =?utf-8?B?WnkvRXNSUTRhYm41SjF2NWhveGo2QnNSRU52M0Y1eS94Q1dIenQ3bHplRkIv?=
 =?utf-8?B?b0grc1RpNFVkQlFpamZveHNHL3pvT05qdDV0YUJmOWg3YksweUhkNTJUT0Y4?=
 =?utf-8?B?d0svc2Vyb3pnSHUzaDBoRTZ1dS9WR0hoOGp6VmxFbEtUQ1p1OWdGbkhmT0Ru?=
 =?utf-8?B?VWNNcU9YajBLMjVyeXowbGhVQm83cXNlbzQwS3YwSm9vR2NLMTQ0Qnc4S2pJ?=
 =?utf-8?B?K2N3WjFsNW1YODV3T3FHRzUvaHRGcUltSnpmZ0tpbFNMS3J0WVZlck9CbWx6?=
 =?utf-8?B?WUlvWXBKckNPbVlMVGdVZjUzS0dNcnJ6M1d3YjBQSDRubytjcG12ZEdQNXRG?=
 =?utf-8?B?Z0l3T3JiZDRIRS9VWUlHTStHeTZDRlBLVnZNUUgydjlSTE5mdm1BZ0dKWGxM?=
 =?utf-8?B?N1Y2a3ptS2hBdExHY3lqQlhMVHI1NjNlUVo1V0grNHRDYTQ4SFpGSVB3TGJt?=
 =?utf-8?B?UkcwR2pGQkJUcWVSRktyZUk5Uys4VzBDdmpnM2lpaE1KT3c0RHF4VHppL01P?=
 =?utf-8?B?Ni9teGg3am5Za1JDd1VmclBzYjRZMTUwUXNxRHVVdkdwazdYMzhlcmNycGl1?=
 =?utf-8?B?VjBFMjNzSm0xQXhySTM2VldyWlBsWUFjSXVKNDc5M01BUlVQUVRpRGxCb1M5?=
 =?utf-8?B?V0VqS3ZNVXlRVElaYldCamRuYTAwOU1IY25JZGJoWlZyOU9xZisvVmtMRnpW?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362a8d63-1024-4bd4-f413-08de305bf75a
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 22:01:08.4724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJbQUnAqa65b4Np3iLBgfp8B3ne5fJwiPZUksvKzaFguQMpgUl6yjhlwOPbXt06DgmoQ2aXXYYdbo0y1byH9sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669

On 11/30/25 1:56 PM, Miguel Ojeda wrote:
> On Sun, Nov 30, 2025 at 10:44 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> Very interesting. So by adding a partially faulty build_assert!() call,
>> these functions were actually wrong when they created! Maybe a Fixes:
>> tag is warranted.
> 
> To clarify: it is the lack of optimization in certain configs (-Os,
> CLIPPY=1...) as well as possibly certain code patterns that may
> trigger it, not that the calls were faulty (note that `always` doesn't

It seems pretty clear that if one writes a *build* assertion about
a function argument, then that is just conceptually wrong unless it
is inlined. Because it can only really be a run-time assertion.

This is what Alex pointed out, and looking at the code I agree.

Thoughts?


> guarantee it either anyway).

Yes, understood. So maybe "Fixes" is too strong. It's more like
"Mitigates:".  :)


thanks,
-- 
John Hubbard

> 
> Daniel suggested Fixes in #0 -- if any of these trigger a build error
> (like the `Bounded` one), then yeah. Cc: stable@ too.
> 
> Thanks!
> 
> Cheers,
> Miguel



