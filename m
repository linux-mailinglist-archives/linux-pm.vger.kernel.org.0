Return-Path: <linux-pm+bounces-39283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B29CABE06
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 03:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8258730413C5
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 02:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411E829BDAB;
	Mon,  8 Dec 2025 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UbnZ5r8X"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC45529D266;
	Mon,  8 Dec 2025 02:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765162053; cv=fail; b=UIDRPzWj0mQxQMVOLayhsnjwxfJMQptjCJdyqRwZSGgj6bZbyJSY0T027F/92VjrJVEW0qOrml1xx7n9zfDfn11yRno15CYwXI0qMSEMmKn3SogTnhkPq84WBTNx2xn7KU9tRVGkiAAvEczXfGjuuPu0X6lxKirJcmSCtzE4ozc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765162053; c=relaxed/simple;
	bh=f7Ikb2FuNNfM/W93lGodHxgpPbqoLknqFZY4MEbAeyc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=F4fe5anOzVvRB9f9/6RY0rpuoNkiqdueOB+01K1eMyXfFfzozQ8zaTJ8zpGzi6TvmvD3c2xADPw67k6jOOkBJB3RYm2ZsQrM1bTpT/5ZxYLWrrC3ZnxXZi7cj7u0wCQgXlYdQKnpJEdBWr9yTrs7MZVdVBHRguwd83WI6jjASlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UbnZ5r8X; arc=fail smtp.client-ip=52.101.52.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNPOTdvkyZmEcou7ltpCOZdZusabI63Ipz+RFp7La1Lfmm7QsHi8HXbuT+x6ZnptGYtN6bQbFqeQU2BqZSN5NT34fWWsL6cfVwYm1LMXPfizL88JF4e3rNQ1jRbZRyFr2P/bfM7G/Dn/c2DGB6b57PbCQfAFCoNcAN2SZ53SGtZ+cnuSShoDYeU9MblsuWl2YeQLwscq08oGIP3M8+y/CvIM8GssOOpI4jvCK7LvnL4NacmFJKkjbw1Um9SLi9duLRk7FGj9P4SEzvF/mGKqOtSETdyPjeauEOLMaWbInr8D46Tj/z7hILfQff2MW0nK43jCzY3f4hx7PRGiEuOddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wz2OIwWsLCOfhMCPGBMEztu2F/g+Lrs77w/cLN3i/PQ=;
 b=QtcO1l/9joIjVFQXtvwfmsxZwb1NFuhCsTP9MNBD+fniyBLGNa0EGjEw9iN4prILwN4BoT+cq907S5FDbR/X+YI+T2+FHWvUA7J3W21qHT3WWj+xyM6SQqGRzh/fTaeZHLjD5LZ30+Nxt+qDvnf9qpFs7AO22FMURTX+WQ6oLSBmSi1r6epNYBwa6hZf5cTQJjbrPH0/bTMw3mJE8AiS4O2WQxJEXSnKg1U38KlEILuCVgjJicoBI5GtajY6XN5uCBfae3GIpOINFiEdSfq+KsEAcIHb6meuLzRiLqo95y0941Klo0pwny0yNOfaQUdWefy6UjMUICGLTpYpwmBUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz2OIwWsLCOfhMCPGBMEztu2F/g+Lrs77w/cLN3i/PQ=;
 b=UbnZ5r8XdtRi/wOK+hdNz46bSkyTMM254Fp1+fU4YCyTdZ17Jn0UuqNUu5h7Tu2exg2pbWWgA0aBVkQIkyo1Xyil7i2nk1w6/V1SMWVcZbmtNHJhazfqhX8MJM2iO6IvYHcr9TlVScbDl8dLQBmP1t9P36WQ1+i1G1PEQXGu4+LzWDZVRxE/G8xnz/62eaOsKUvwUktwPNNHXEpxfX1BYHnxr6PedL9rG4YE6zBhfOOno6mths6qH16uZ9KvXVMpFMD0Wp6zCRKAzW3q5tLYi3XWIC9dgCNkWtFYFLklYGhcEWaO3udpzndifwrneBO3jOsT1HxMDwiLqzUJ3ow1UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 02:47:28 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9388.011; Mon, 8 Dec 2025
 02:47:27 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 08 Dec 2025 11:47:02 +0900
Subject: [PATCH v3 4/7] rust: bits: always inline functions using
 build_assert with arguments
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-io-build-assert-v3-4-98aded02c1ea@nvidia.com>
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
In-Reply-To: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4P301CA0055.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2f0795-83a1-489b-4f1d-08de36041fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3VXenBtTGFCVUJ2a0xRZ0hqZVl4QVlJRWpUaDJFRjhiOWlQc05OV0JMbDRq?=
 =?utf-8?B?aVRqYzNhQXVMTXNqamtKNnNBc2VCQURqeXp5bzFFaTVtNzgxRkt4bGY1azFY?=
 =?utf-8?B?WlRJZFdQa1pmUlBpR3RSYnZtMGM5NUIvMWR4dzB5aDFHLzhDREZhUm9JblYw?=
 =?utf-8?B?OVRMQXJLcXJkUHNueEJtQktqNHFycG9nNVN2bmdJaXBzeUhGWHpRa25MT3VV?=
 =?utf-8?B?aE42c3dpd1JTamc4cUFnYXdlUzhsUjBzd3ltOU9sL04vektkejBzcDdMSGJw?=
 =?utf-8?B?a2FZaTBrQ2VvYjNpTG94emNRRG5NSEY0Y2xCV3dJNnpQcnczelhmMC9ka0k0?=
 =?utf-8?B?ZXJPNUkyUHFKZ3hoVHNPTkNuRkFKcTlwL0EvWFhKZzJ0NjJVTHd1Ymlwc05m?=
 =?utf-8?B?Qkl4WTNKbGZQNWZFZ3NVZjJxcHp6K3RmWklMSmxKMERIRFh1UWZ5VXhGSnY0?=
 =?utf-8?B?bE5JdDlxZW9DNGFid3NNSExuTEhwNURaTllWMmxkZnBkYlFrcC9laERrQkhP?=
 =?utf-8?B?Y3gzTmVnT21FVFFtV1pXV3BXaExPT2NmZEtLWWFQWWdVeTdiS0lvaEp5NnJZ?=
 =?utf-8?B?VGYxbkdkRGNMRUdIVU1jNHU0Y2NJWWptM3oxMnlXNzc3cy9nY1BwQTZoS083?=
 =?utf-8?B?WTQ2Z1FXN2VYWlRDRmRMRDJEMmNsZmhCNnpqZXZzendaVVc3SGpNRGZOcUFY?=
 =?utf-8?B?bjk0ZmpqNUd6dDlkZDJ1cTVRWi9aQmdtbVhkckl5bE1CL2NLMGtXS0NnbkVE?=
 =?utf-8?B?V2huU1ZzK3NCVTdiQlNvbWdrSXR2ZG9CM2tqMkpLbWtaMU5ISWhjeStuUHQ2?=
 =?utf-8?B?K1ZDeHZZMmJXYy9wKzFZVDNCc1hYTWFlaVFUZ3pxcEU0eEhDRFM0MXAxVm9m?=
 =?utf-8?B?SnpLVjl0cXBFTlhaR09sV3NYMnZ2Wkw5QWlOZW53cG1BdWxzOFhtNWlUYTZR?=
 =?utf-8?B?OXRmRk9seHkzaEpoV3lCYkFQMHFJUWNSOG9uUU5XdjFHa1dmT1pSWlhhdGdG?=
 =?utf-8?B?SHNlV2FmcklGd0ZRRXJzcW1VTDNxY3BDeUk1LzNUdHZEYi9lektjQ3BRbmUr?=
 =?utf-8?B?K01jNkJlNEt0aDJMTHNMZ243ekZpN0JmeUxVUnlZcGFsQkFzd29HaVhRSWMz?=
 =?utf-8?B?NmZZYW9MRnhRRGxsSWtRS1RjRjZHd24ybklaV3hEMlRnWDBpVG14cTVKVEFB?=
 =?utf-8?B?Vm9FQkFlN21LMG1uOVhxL3FmK09EZjFoRmd1MlpNVFBMekdRTFV5Q1ZHVjlq?=
 =?utf-8?B?QTl1ZlpUTVZqd0x1N2FleTBPV1NVRVhxTWhZWGprd2R1Mzg5R0ZNUUFBMGQ0?=
 =?utf-8?B?Z0hXTVV5dGRYR2VyVFBKMHJ3UXhvZU85azJ2NzNvckNWbDE0NmxwdjRoSkpj?=
 =?utf-8?B?SHN3Y2I0dnU4dStKQ1FkZXJieXNZbDcvWGEzM2VkZTBlS0NwZmxMR0FXZFBI?=
 =?utf-8?B?Y0dZaUQzOWpybkpRWDBpNG81WlBUaC94M0w5SGVTSXFqSmwxazNjMURHNHhI?=
 =?utf-8?B?N2E2WHk4ZFZNaVZZWThBdXFCZkN3a0FnTmVSWEdMSXpEaHJkdjR0bUwyTnNH?=
 =?utf-8?B?RXNGTmZpaGVuNXVsU1FneWF2Nm9OQjRRRm9GYVNieEtHbnFDRTRzMmdJUjBZ?=
 =?utf-8?B?cHFwbVRTaS9XN2dEcWQ4ajJIZ1g5eFN4ZHYwV3dBWVFSaGlUMzlXVHB5ZkQz?=
 =?utf-8?B?TEJKM3N6bU00QndYNHY5Y3JQekdxRlZTQ2tLTjB2b0tBd3lQeHR3K0ZvSnp2?=
 =?utf-8?B?L2ZPdUQyUGtyWkNZMDZDMWNYcnBaMVNMdEMxSW1WdmNDUldqb3poenZvRlpj?=
 =?utf-8?B?enR6cFprSzYxaFQvSlpSK25Xbk1LTHRZK2VaVWpqR2tNV1lCbGNCZ1czMDVy?=
 =?utf-8?B?WjVnaWVhd3gxMDJGVnRWU2EvVk95aGdsaXJnSklyYWNRekMzcmsrVkg5T3B4?=
 =?utf-8?B?ZnM5WWdPRXMwUXI0UHdqV1VJZDg1OWhyRmxKWDlXa1lGb09RRlpXQU5pYlFt?=
 =?utf-8?Q?dvKAYpoCugHUtHh/bnX6AhgCGTSMBo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0ZqR3lCcDVXcnlQeGlKRjI1QlQzYStuNUV1MGNwOWsrTnVDLzZuODlOdWg3?=
 =?utf-8?B?cFc5cUw2M3VsRWs2R3lEVHVWcUNEdURBd042UDNIUHhTVkFxQzM5SlRnU3pC?=
 =?utf-8?B?KzlmZkNtdzY1WjFzRlNoUTB0TlRDZE5jTTl4elB5TGxKcHhpak9iK0hUbC9Z?=
 =?utf-8?B?aHNNc1dTbStxWk5pOHRZcDFKSUdQQndKZ0k5R0w1cmhZaHVOaWt1VmVIOW1a?=
 =?utf-8?B?dXc0WnNBdUZtYk1NUzN1a25YKzNQS2pWRVM5eHFuTkJnbW5kTW5JOUNrekoz?=
 =?utf-8?B?TW0vTmlZLzRqZE1vQlE4bnBBVExxZmQ1dE1Va3NXNVZVMUVudENjcElJK2JV?=
 =?utf-8?B?WVEySFNqeGtYM0lyY2FpcTFRU2RqUDlzOFo0ZEl3cUdESHBsVjZ5OEt0TFRz?=
 =?utf-8?B?MktxYVRYODBNbjNadHd4RlNNYzBRRDJmWjA2K2E3UUlNLy9nTFhHL21ZOVJk?=
 =?utf-8?B?UEZ3S1J5VGt6bFpRK3dIbyt2R2wzaU1kam0ybmNuVk44bDVxZm9vOGF0U2Vr?=
 =?utf-8?B?SFJRU0VDcEVKNWFLbWtpWkM4elhtTmVVNHNzY05oVVNaQnlyNitNdGFFZGhv?=
 =?utf-8?B?dnZrM3hWOHphaG9KWGwvc1ZtWGwwTzdKK0Z6QlJNL3NJaDVaVVFzQzRJa0lB?=
 =?utf-8?B?cGM4ck1FNERrRGJOYTJJTlRLTlBOTno4K0MvZ2ErUFdyS0tHT2ZLQVdqRkdG?=
 =?utf-8?B?T2FZOC8wUE5TVHRKbEswWkpGczBHRmtKK21kWU9KNnR2OUFlc3lTaGl4aVdt?=
 =?utf-8?B?blR2MjRQSktMNlAyWWtwa0E3Ulg0OVBSaERsMTg4YUVrdGhQdlhwWmNaWllG?=
 =?utf-8?B?aCt6Q2Z3NWUzNktTZEJxSGxlWU9iVWVQbEcyaFV5SGxZbTdteHFuR1gyeUdQ?=
 =?utf-8?B?cThqUTFyc1ZvT2d4bU5RbTNlYS9VK2ZjQWs0TklQUFVid05YQlFFYVpLR2pU?=
 =?utf-8?B?L1UzNFdMSG9Dd3Z0Um1HZFVEb2gwZ1JHSG53dGVnQWs2Ykt6K3l2ZWxvZ1c5?=
 =?utf-8?B?ZlJDaGpsdXRmOFBralc4L3FSeWt3WS8wNWR3d2VqdEJkcnl2UG1lcGRhR2c1?=
 =?utf-8?B?RVZMUU5VQis4MVQ1TWE3RUtDaVR3eHQ3ai9tSnZNVHFXaGRpMmErMjdYQ0ZP?=
 =?utf-8?B?M1VZdlI3VHNEQlA4UXVIWlcydFVmK2h5ZzJ0aHl0TUUvVjBRTmpuZytVWmFQ?=
 =?utf-8?B?MGJLa3B1dTJDSzN6d3lEUkMzRThCaWtITjFxbmFnd2VwajhHemtVbm4zQTFO?=
 =?utf-8?B?RGFUZzFvMks5VC9ySnQ2OXdZcGdpcFpReldJd0UzY2NyUng4V0ZIajNhWlRE?=
 =?utf-8?B?VUE4MkxRWXFINUYyanplZEhQL3lBcTVjZFdNb0xMMnhuRHR1eUVZSVVYUUl2?=
 =?utf-8?B?NWdTTEhudVp1K25wRmEzQlJVQWlTNmw3UW9sTXJYOHI3S0paZnRobDNGbEZv?=
 =?utf-8?B?VmtDY1lHbndQSC9OQ0F0WjFPZDhSRk1WVWtQRUtObGVHZEJoajVrSFRCWVVx?=
 =?utf-8?B?dzZqSU5nVU1RTHg3ZHBHSmY1Y2JoQmoxZU5naGhRbmRaUWVxak5YRU00dDFZ?=
 =?utf-8?B?dDNQeWIyOVNtYXFvRWsyU21mQVdaSEppUTdDcDlNanZEU2FEWUI5cmJCWkRT?=
 =?utf-8?B?R0x3NmtvbVBTZStRa0tUQ1hEbzUzQlZiQVBlUlFtaTUrOUI0WkxpbnI2bVhM?=
 =?utf-8?B?U1BLSkpFbW9peFNXb0pPVzBFZi91bHBnUmp1RUZ6RzlTd0RtS1ArMTM0OEYw?=
 =?utf-8?B?dU0zSThhcWZnd2N2cm5teHR2aTdEK0hiRjFPZ004OHNIUFFxV3UzZkV4K2dP?=
 =?utf-8?B?Sjd3RjJPSWpKekdRSkM5b24ra2FiYStjWFg5T2VUZzRFWDllaVhhcklQemxz?=
 =?utf-8?B?ODVLYWJrRmtHSkhKM3BpNWdVSmdLU0FpcEV0MzVKMnRPM0kya0FWSVQzV2g3?=
 =?utf-8?B?SFVvbmU0amxuTm51Y0YzSTVnMU02NFNtUUowSkx6YkphLzV0cHU3ay9NWmVl?=
 =?utf-8?B?UkNTU3N1RGd4bVNxUENhamlMaVVRRXdiaWZLektEOXpoMXUxTk5JdFVCdU9M?=
 =?utf-8?B?Sm9QVnZKcVRpTFlmckMzNzFLS01xa3M5NndtTURXVTlCWlpsRXlqdHZIeUVq?=
 =?utf-8?B?dVQ5ODVzalYyZ0FFdG1DeTZpYXJ0eXl3elpXSlJVZDVtNlBpaTBNaWVlckl1?=
 =?utf-8?Q?QXXJubuXk3CA70XQxf7E8Y3aqxsx02KGdW2SlwNJa0Qh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2f0795-83a1-489b-4f1d-08de36041fee
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 02:47:27.7798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKmK4q7VQYIErvcfZD5+rRMxK2ltcf9xHnR47U2Yxno6n2HZCmqJKdbjycAfCw9/5CWS62jqgxMpXUfLQm+YBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347

`build_assert` relies on the compiler to optimize out its error path.
Functions using it with its arguments must thus always be inlined,
otherwise the error path of `build_assert` might not be optimized out,
triggering a build error.

Cc: stable@vger.kernel.org
Fixes: cc84ef3b88f4 ("rust: bits: add support for bits/genmask macros")
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/bits.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
index 553d50265883..2daead125626 100644
--- a/rust/kernel/bits.rs
+++ b/rust/kernel/bits.rs
@@ -27,7 +27,8 @@ pub fn [<checked_bit_ $ty>](n: u32) -> Option<$ty> {
             ///
             /// This version is the default and should be used if `n` is known at
             /// compile time.
-            #[inline]
+            // Always inline to optimize out error path of `build_assert`.
+            #[inline(always)]
             pub const fn [<bit_ $ty>](n: u32) -> $ty {
                 build_assert!(n < <$ty>::BITS);
                 (1 as $ty) << n
@@ -75,7 +76,8 @@ pub fn [<genmask_checked_ $ty>](range: RangeInclusive<u32>) -> Option<$ty> {
             /// This version is the default and should be used if the range is known
             /// at compile time.
             $(#[$genmask_ex])*
-            #[inline]
+            // Always inline to optimize out error path of `build_assert`.
+            #[inline(always)]
             pub const fn [<genmask_ $ty>](range: RangeInclusive<u32>) -> $ty {
                 let start = *range.start();
                 let end = *range.end();

-- 
2.52.0


