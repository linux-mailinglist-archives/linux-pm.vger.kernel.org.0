Return-Path: <linux-pm+bounces-39008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B598BC98F6C
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 21:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4693A3EF8
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 20:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E223C519;
	Mon,  1 Dec 2025 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Da/DsLcQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6671260578;
	Mon,  1 Dec 2025 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619661; cv=fail; b=snDb+mrOUdnmb81zRaDvLdVwRgR+7k5h3pA4PiQkIxSWTjnGH5TkIFrY1BADsel+Xn7WjZSwOQesU6bzeq7/jRimhlkBMx3/4MJdkKHz9vcA0N6a4RTv2LRv6XO6aeixfQnB6AGaNvW3JRiNh0inxT0Z+GdCikMIJh2i+aVJYm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619661; c=relaxed/simple;
	bh=4vHV/dkrU2SWNiMwaeGjVw2VhNwjBcWzAY8YjPDm4b4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=En1QdgaKTqfWeAz01Cy3HUUpNhUrs6umA/XgJYxtO0EXxN6LOZAZ36nfxdY03ryDHOgTepyiBc2mgfj9dkpDmlJ7/ZamVPnmKPCgqK5vM1GocuUhzGGYl/XHj5s6FnMC0cimK/7QN5Sgw6butnW4pWyG40H2RrTW46HcGnwhxyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Da/DsLcQ; arc=fail smtp.client-ip=40.93.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqQd2nTyyWWfsjeGHdGaZy+rZXqnnIsvaNsBm66IhXfjTavkJhGrlJpZ/IJptlssrcg+2LiqOQBuay5NfnDEOwx8ALjYmK3p1MY0ROFJjYCxZl8HkQDuhgGlEVqsU/U4h2Fgw4VE4ja4jvJKTM5nqpoxJ2OSy18pS6aQom3Exn00ehKXrPucJNr6rdy5X2Vw4LNI5AH+ZewK/gBrJyFq0KoOYtVtRqBgHgtuYGDokOafiHH8D0IKYVPVjLC2a1oZYDpWqeXOEdSnHvKd/NNG3o2J6nEQLHhaUepLbge2Lc8nq7aaLUbcepWDk800vbK13Z5qKO8SsAc5+hQvP1ipTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiY+b4iyeq3cFRIhRQdxiLfSkgUSVuMtNBOp/hE7bOw=;
 b=jJbN70tLHvPE6eK3UlymoipGjf0WZuYhz7HVAp9gSCX6WZ8aIhQ4JbHbTwDIL5ZdqlkKffQ1vFUhsWrUgkDg3kgxiFb5lTyYd3RcxrBnHE4r4bp2wOC/ddR9C4q1MIgBRBtoerHJo91uqgaWo2BEDrCS9v9RuNzoyqtd6Atk4iXA3+OnrsEt3CfQ+1aDamoLYO6ZYAo4Zo2u7xkg95n44wMa0V4RB5DkUl6aQJLkvLI0H8bDEU3Q2wpcT7QihBUa+oWVOI0zFKWbg5CBqAXVB3wwgte4Z+omcJMiMhbZ3pqUDsrO8Ud9j4Kz/RsqS/Mnh+i/SAohz6oeOoDvkh2nnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiY+b4iyeq3cFRIhRQdxiLfSkgUSVuMtNBOp/hE7bOw=;
 b=Da/DsLcQ4mp3y/KFHiZ1COf6qzGeYhknOSbZnqQbY+XTXJdIDH1ECJnvLmJ5B05lnY4HUe2q275bN3XGmyg/xy8jrDdtTd5yPDltajtFETstuKeD/UkK8OiFd8xTMMYGrHDVyuvnEbC8AlOrQZ1m6cPiCOystPq6SH4r+oiYfrKtwSBHwcW+oWBGwyb2Z2ZKi+xbNWSfN1qrP3J2JWSlO8rx+ImdngLsqEfZyRMYQAIIt2/4aHmQidk8E6JLvrehICeAQO5ejk62v9dNmuSkukOwMV3SyfIyxBCBUb4RdSC5c4DigtTfAzTqof6CS4YxuFBSFDnMyTd6egF4ryeWqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by PH7PR12MB6764.namprd12.prod.outlook.com (2603:10b6:510:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 20:07:36 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::e73f:7d5f:7a1a:f363]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::e73f:7d5f:7a1a:f363%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 20:07:36 +0000
Message-ID: <af76b544-a7ee-43da-878f-cadc1599d7f0@nvidia.com>
Date: Mon, 1 Dec 2025 12:06:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] rust: io: always inline functions using
 build_assert with arguments
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
 <20251128-io-build-assert-v2-2-a9ea9ce7d45d@nvidia.com>
Content-Language: en-US
From: Edwin Peer <epeer@nvidia.com>
In-Reply-To: <20251128-io-build-assert-v2-2-a9ea9ce7d45d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:a03:54::31) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5182:EE_|PH7PR12MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 0290cd48-8d58-4a6a-c636-08de3115455e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blh6a21GcEJ2eEpEVFhOYkx5R2pXUitKOXpldWYySFBMZkpoeTloMVk4WVRt?=
 =?utf-8?B?WWJUZDZiWk41VEhDbnd5QWZRVU1zMkp4RENCbjI2TmtIQUxNd1MyZzNFdkV6?=
 =?utf-8?B?YmovaTNzL3QxZWlweXd2Z25WRVVTejB0cmF0V1NEcTBlYmMrWHlYUXJTMjI2?=
 =?utf-8?B?bi9BTnBRUmFXcTBzME1LSWY2U2pqU1FlejdjeFRNMUdhRW5iRDBOVER1RGpv?=
 =?utf-8?B?by81cEpKbGEveDUvc3luMXhid2ZCM0tldGt4eFExTFZ3U3NmVTZZM2l5aTht?=
 =?utf-8?B?ajc4djcwY24rQU1kWERDVDlnQitvZ21yVHNmcE5sdmF3RkxEVFhCeVpSOThq?=
 =?utf-8?B?enJmK09TSENuMktqdWsvdjB2RFdiYitpaDZOMTE3OGgyeVk0cTl0OHBicDV3?=
 =?utf-8?B?c3FyQVBCa1BHOHFFTHRKZW82N3JYZFNFQ0ROdFRucytmQXRhVXM5Sm41Q0tM?=
 =?utf-8?B?UFB3YjB2TzdvM2NlV0ZUa082WjBVVUhjQ2lDblVzTHVJTUkzd2UwLzFYd3k2?=
 =?utf-8?B?SG05aHc1U2lxRmtLM2NtR2RvRG5qRElBYTBXR1dqRXBmbFlmS2JzM2MzUk4x?=
 =?utf-8?B?d3MzdjBUR0tnOURsajI0VnAvdFBjQWdHOG9HdERjRFB3d2diL0dEcU9RSVp3?=
 =?utf-8?B?QlMxSlBZNHFYaDRiRFBDTDB0eFpCeHhDRkN4UWtyS2N4NXlCdWRyWTRhQjZH?=
 =?utf-8?B?YytlV0dLcXE1TnNyZjhXY0VJcUhRNEpDMnBBV1k4UTVQT0dkQWRHZ1BudXdo?=
 =?utf-8?B?T2hOZkpXemVQNnhTTXV5Tm9YeTE0YXV3UlByR05VdXkxTU9BeXJSODd2aHNv?=
 =?utf-8?B?NzdJUndtcUN6aTZjbFltWTJMUjgxMzVHNHdnR3ljRW9yY0JtZmNHZUxONDgz?=
 =?utf-8?B?cktPOFpyVVFIZEdZWXJOSWNjNU5KZkdpQ2J1WHhaWFRDc2VZOFFUUnk3dUFE?=
 =?utf-8?B?UWhybWg3QXFtc2UydklzbHFVWFd0cjRaM25SNUI4RW5KeWtpSXFSQmlFdVJv?=
 =?utf-8?B?UFBNQmZLeDBRczQ1SnJQWjFGeEtFc1k2NnNIZGRNS2sraUNhbXlHUEhNM2th?=
 =?utf-8?B?NGFXaGgyOEd0NWtnTnM3bk96ZnF2SmZrQXdLMXBqWmxQb2lYaTlmRExXVXZF?=
 =?utf-8?B?WS92czdaaEwwOXNqYVBTV2dPeG5JTXVDK2JBeTlYNGQ0UmdqUG4vbGVHQk5O?=
 =?utf-8?B?ZnJXdUg3MDZpL2FXbC9rR0VLc2xQOFhYejhZN0tnWStLS1BIeTdyNWtaRVJr?=
 =?utf-8?B?VjE2RDN0SldBNHFla1BJcStwRlhFTmlxRWhSRGg0UDY2WjNhMm0yNVFTSEdO?=
 =?utf-8?B?OUVlMm0rQkU4MUJUSjFibWsvZUo0aUJESjZFWTI2bWxqbjR3Y1ZWSUw5U0cx?=
 =?utf-8?B?Mi8vNlByOWIvNndlWmhUZkFiUGlSL05tU3d0dlFya0loYWJNNjM0cUJnVDJF?=
 =?utf-8?B?N2NTN3JnM3J6RnFJTDZjWFhBcWNodmtOckhza0cwampXUUlSYjlJb2xORENX?=
 =?utf-8?B?MHpDUlhWY3dUUGhQS1hReTcwTGFvN0R4VElqcHY0c3JKaUthWlpMRzlyRndl?=
 =?utf-8?B?OU8rY1hJbDVaQUxSY0srWEpBL2pidGE3NVFqRThoNDFTQ2FHZFhOQkVhYUhM?=
 =?utf-8?B?MzFkTW5hRm11dzg4a1g3RlJIQ3J5ZktFRWg4RWRZNVd4T3JRM0hQWXRDR2ov?=
 =?utf-8?B?N0hGV3hud01HRlRDbXNBOXlrNnRIS055MTJhZXNoMEpNK3hVQ09IOUlnL3Bl?=
 =?utf-8?B?L0tORmxJaXRqdndXbjN2aGdBRE5HMkhyTGJkR1hPdWRPdXJaV3ZZWXBlTklv?=
 =?utf-8?B?OHFhZ2NyTWg1Q2hhSUt0QjE4Y3FaR0V0NU1FaDhpMTBuTVBpcmZFdTlCSklp?=
 =?utf-8?B?dXdDZFRiL1dKOC8xUEQwODhMNnAvVncxVTVFcVgvcVNhTE5WbXdxTmFMaGhJ?=
 =?utf-8?B?WHBSMjJBQnNFamsyTFBBUG8zYS9VWU8vNnhnaW9qNUxxNFE2SWlhMDEyTXdG?=
 =?utf-8?Q?hxuvleB41r5mYPSIxx7Tn/7SdkUCgw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5182.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDJWam1JYmFCWENHUUVUd0ErMnVpMktGRVVGeURxU001UGVtZ0UwMzBZSUMw?=
 =?utf-8?B?YzZGNGlmQS9iSFhIS2VFV2JhZ0JJKy81eE5vbjh3bmlvTFk2UTVCODJFOGdq?=
 =?utf-8?B?am1WS3NaT0tQekE2RkVwQkhlRCtvUWsvdmh0QTUxMHNPdURMYWJncEVXOGRx?=
 =?utf-8?B?dXh3dzJFcWNkS3VEelhDNXBjQXh4OWM3aFFlUHNaRFlOZS9ERkozaHJzSlU4?=
 =?utf-8?B?TU9CRUQwZkpqWkEzU01DZFdLdUE2K1l0R1dSUDdNZkRxMk9MYVdzREl3c04x?=
 =?utf-8?B?VVpCWU9TTWV4d0xVOThLNFlYSUFleDcwZUZBcUozbEdMRkFWQTBHSFJ6Rkt4?=
 =?utf-8?B?eE5JbzhmajFpVTZyUnhqeXppNExObFNNMVVOdVpxYUV5NS8rMHVZOTdFaVp4?=
 =?utf-8?B?M1ZJRU9sNElxVkVqWG1xTXJSV1krZHltU2ZDNVlJeU5ES1YwcHVuTFVvL0dh?=
 =?utf-8?B?RWphREliNFJHNTJlcVI3Y2gwT2lXV1k3SENxRWRjbXlVQ0Q1NWpKdDJocXQ2?=
 =?utf-8?B?L1lLa042UHdFVHB0TzIvMEFHNzdLMGk2MkQxM3AwemFWU2VBcHgrSWtuUVNZ?=
 =?utf-8?B?TFU5YkU4TDgwZGdLVG0yMUVTUFVzUzBaZEIrZ3NDbXZocTMyNnp2MFl1bXV5?=
 =?utf-8?B?U2VKV1NXY05yaGlDWVFxUEpYTm5XUHVzbTdjbHBJb3IrUWNkSGZRbWgvSGZa?=
 =?utf-8?B?US9DSEdEVEFFNW9kMXoyWFlzV3RCMGVjWjR1a2hubjFFU05teHF6aXNUc3Bx?=
 =?utf-8?B?eFFrVWg0MGZsU0V0U3BYRVp4MWt0QU8yTGFDUFVRNGZ0VGFyZTMwbEd6Njk2?=
 =?utf-8?B?MEtYaWhDN2lqL21MSDNmb2dXdk1vbklLVjJvcWpLeVpIK1pjaTV6Rll6cWhK?=
 =?utf-8?B?d3lkdVNkaVdFWnZHVk16WlJIUUpCSmtPTFNwQ21Kc2tlMlVHdU1sc2VPd244?=
 =?utf-8?B?Z1pKaXZUK2t0M1k1aSt5Sk9Wb09YbTh6and5MTRKS3ByblZ2UU5kYzVuVFR0?=
 =?utf-8?B?OFpKd21oWnFSNytWeWtrZjdPSnk3aGFaOGF2RkprRGg5eW1MZU5mZzljUXkv?=
 =?utf-8?B?YkY4SUxwQ0ZEd3gvZlBKc1BsYnlsVi9RbFJVb09qMUo2cXowWHhWWi9oNGZV?=
 =?utf-8?B?aEw1SVI3ZDdaOXlKK0NWaFBPTlo3V3VabzV0bGI2Rkw1Y21SZTdFVGhodjVH?=
 =?utf-8?B?UUJlbEFYWGNMNm1XZzVOSmtGbjhKT0tQa2R3L0YwRm5yanFodlBsM012ZXBU?=
 =?utf-8?B?bGdJZjAvL3dZOFhjYjd4R3dDMVNYbnl4QVRQSFBieGhnbzFDY3FKQ0FDRzY0?=
 =?utf-8?B?Yk1yL0hrd3g5OEVLaW5vZlBXdm4yZDZkWFBMeEt4dGlxRFc4dHBaWm55ZUpm?=
 =?utf-8?B?RENtaG1sZWJtaFU1OGlUTDFqcEF3SnhRSmdMVXpLdnRCVEtweWZTSjIwZlYw?=
 =?utf-8?B?VFhNMW9EcDhWdnJVOHVMOEdFbW5ERTNPWlVWaFdEbGh6ZytVMFQyOXF5VTIx?=
 =?utf-8?B?c3pWSlpJV3VCK2FCRy84SWdOdzJFcW5KeHlaMXg0T3NkMm1XUHYzM080THpN?=
 =?utf-8?B?NGtVeDlpbDlDT3AvU3l1bnNiaEVLNllTV3ZDaXVncGlnUTJHMEpQclc0RVQ5?=
 =?utf-8?B?aFkwT25xeGp1MzEvcnhoOCtoZC8rQUowZjJNMEdoUlJpaTdmcmJZcllFNzRK?=
 =?utf-8?B?VE9BbDJPaG0ydkVWTEVPbjdzTi9jU3NKT1NNZVVQclR2c2RWZDFiaktPaERF?=
 =?utf-8?B?cnBvQ0huaXpyQ2h2ODY2S3pBQlRiYU1MU3RkRTFjR3I3cG1KUUFQaWk1d3Z4?=
 =?utf-8?B?ekhPT3F0WWZFM2FWNWF0L2IwSXN6WHhqa1BISmVOOFFzdjVZay9qZGNXdEJZ?=
 =?utf-8?B?SnZ4OWx6NFNOVzV0aVU3bGlwMk05djRrelNDOFJsWVRaZFpFS0dWLzBSeWdI?=
 =?utf-8?B?WGxlR0hzdWZyMjA5dXVWeTkzL0NDT0RxWUUvOW1EWm95TmRITHB1eThCQkx0?=
 =?utf-8?B?STRlQ1loWU5DL0wvbThJQW01bVp6VFVjSHlxRU1SV1diM1V1UzI0ZE54dEZS?=
 =?utf-8?B?a1BQYU5wTDhJQ1VRVUxoNHNJTjVnKzAzSFBwdFA4RGVDSUNRWm9TSTdDMU5v?=
 =?utf-8?Q?1uPGjXWPiA5lGRjwC9dtoOfq2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0290cd48-8d58-4a6a-c636-08de3115455e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 20:07:36.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXHQJKP8FhmjQF5Lw0DnXtjcZUkNl0pER3udSrdYUZLVa3lqXOL2+Qq3uVM8EMHpKDMKO60Iin+RUTY2EVJlZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6764


On 11/27/25 18:11, Alexandre Courbot wrote:
> `build_assert` relies on the compiler to optimize out its error path.
> Functions using it with its arguments must thus always be inlined,
> otherwise the error path of `build_assert` might not be optimized out,
> triggering a build error.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  rust/kernel/io.rs          | 9 ++++++---
>  rust/kernel/io/resource.rs | 2 ++
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index ee182b0b5452..ccdd394099cb 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -120,7 +120,8 @@ macro_rules! define_read {
>          /// Bound checks are performed on compile time, hence if the offset is not known at compile
>          /// time, the build will fail.
>          $(#[$attr])*
> -        #[inline]
> +        // Always inline to optimize out error path of `io_addr_assert`.
> +        #[inline(always)]
>          pub fn $name(&self, offset: usize) -> $type_name {
>              let addr = self.io_addr_assert::<$type_name>(offset);
>  
> @@ -149,7 +150,8 @@ macro_rules! define_write {
>          /// Bound checks are performed on compile time, hence if the offset is not known at compile
>          /// time, the build will fail.
>          $(#[$attr])*
> -        #[inline]
> +        // Always inline to optimize out error path of `io_addr_assert`.
> +        #[inline(always)]
>          pub fn $name(&self, value: $type_name, offset: usize) {
>              let addr = self.io_addr_assert::<$type_name>(offset);
>  
> @@ -217,7 +219,8 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
>          self.addr().checked_add(offset).ok_or(EINVAL)
>      }
>  
> -    #[inline]
> +    // Always inline to optimize out error path of `build_assert`.
> +    #[inline(always)]
>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
>          build_assert!(Self::offset_valid::<U>(offset, SIZE));
>  
> diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
> index bea3ee0ed87b..d9851923562c 100644
> --- a/rust/kernel/io/resource.rs
> +++ b/rust/kernel/io/resource.rs
> @@ -223,6 +223,8 @@ impl Flags {
>      /// Resource represents a memory region that must be ioremaped using `ioremap_np`.
>      pub const IORESOURCE_MEM_NONPOSTED: Flags = Flags::new(bindings::IORESOURCE_MEM_NONPOSTED);
>  
> +    // Always inline to optimize out error path of `build_assert`.
> +    #[inline(always)]
>      const fn new(value: u32) -> Self {

Does the build_assert problem actually manifest for const functions?

Regards,
Edwin Peer


>          crate::build_assert!(value as u64 <= c_ulong::MAX as u64);
>          Flags(value as c_ulong)
>

