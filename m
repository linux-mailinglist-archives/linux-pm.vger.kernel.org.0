Return-Path: <linux-pm+bounces-36091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1FCBDADDB
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 19:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B753AA91D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 17:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0383016F5;
	Tue, 14 Oct 2025 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AO2zdpM4"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012024.outbound.protection.outlook.com [40.107.200.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D992FF166;
	Tue, 14 Oct 2025 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464557; cv=fail; b=KoGDjb8rL4R451/6Wkzs5vgfNzUHpN5Q5WRcTBsxO2w7C2BY4uM+6z7GXKMOFjYmEXtRGS6InUxIqhfYTtZ6s0OBWIMv522SUlv7r0lm+A07okQh7tjZKVrWANNPZS9ZI/GNwJETH0501LiwKm4ssJGOZILwCPjqWy82ETBtdgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464557; c=relaxed/simple;
	bh=A1EWKNk0o1K08Vh5WTNbghr6MGFvN33si+BcdEm6D9Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fmWEtAfnJpg9Pcmt3i/edCLKhiL9lxTe/p8GiC0o/CxTr2s8yKG+PV5Vid47dT6inErEm0WNgTX+fc+a2Dq2h3FkMTfF1x0J4qloW+t7QnvxXcjnuO52jpXPGc76lw6PmiH4qp8ZGCkaqp9g4vWcBknn63OGlS1Ntc57S3Ie9bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AO2zdpM4; arc=fail smtp.client-ip=40.107.200.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSkc6O4sfe78VJvjfKEWLshgEExo0MbRLTzz7j6g0zJKOQzpL9SlHAK4zKlhS/kVR2LgUAssOf0paVsiDm89DdKiF1a9MGYrIKyj2iuvybetUi7xnRcl8p0EI4wZTr8+BmXMAox18uZkQueklSw2Z3Xo87iC2aXbxeaU9zdB3CLVgcIZY180mz4Eiqgru+neraWtVvwWGoMfKp0PTmayHGU3stFvS1uoTJ/IBw1Cyiq38E+RaVMwBYALo4qUDHeUIH5ez69mPPcJQMXn0A3HwPbnDzKoOTrgRYRdFHCeYM+AVhZYqsAWIYs1XYRshvEUmvtzahe4JGhRfMXOdkWVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XC6f6kqd/FjuNAnXdUuh1LIpn1ExytmmSsSB+8desg=;
 b=ZnkVgzFhwvJKVP3AP1J7jPWTMUbs7FNs2osA//973Bvc/2pYCpGGMOGQOx9TJi2G6dmwJGaNOhwbAuS0pQDPOGevibE6VLEOS91pi59u6DuorQzGWK7yaYzy3rKNvsErGEFxaCnp4F4Bv9f66+Q1Sjm2kkTgs2h0+reo0A3BbB0uD5MCFwz0uNF/4bWhByomBzbEWh11eIJgWRkAPZquIewZ5ZfhuNTtIFZ4skvnEFr7IrHJLM8KLo1HQeFkz93jexF+H3Bl1zibWCG/QhBop14TdzCgNgEnP/R8FFIFQBOhZ70F+iD7LZAmUocHnxZbXkPMDwE8Tk+qK6rbkJ6jFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XC6f6kqd/FjuNAnXdUuh1LIpn1ExytmmSsSB+8desg=;
 b=AO2zdpM4PTsTCVUvHO68I9Vig/v/g3t3VcbfoF6vrcmSKMEgD/AbPM46Rd2bXbnTKlQM8qGl7ti76sMehGWTs3BzvCet88Tp95aV11u5iZMZ1SA9424DYRAG699CocZXg0Bh0kpZ6xcUBux318EXjwMxc7WVVLtTP9QU+pJ1MByp8nr1lUMwiGhU1azzCYLSYh/LZBcXcuc0KshSh/N469ovwh3uTZwDGOMkcPf3mqDoLTc/5eMp32iqOsUY3L7T4qjqErlN6lxqinATwIhs7KG8KqHm+T5QbW52uaYSwPI8gGBfE5xa3r5LthuOw70RpXM151Y9lEUXzn71eC6jhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 17:55:52 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 17:55:52 +0000
Message-ID: <4a237ec0-05ae-439b-a1cb-6b7f451c0d7e@nvidia.com>
Date: Tue, 14 Oct 2025 13:55:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/17] preempt: Track NMI nesting to separate per-CPU
 counter
To: Peter Zijlstra <peterz@infradead.org>, Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-2-lyude@redhat.com>
 <20251014104839.GN4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251014104839.GN4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:a03:54::26) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b395cd-b297-4c02-d62f-08de0b4aeaa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmVkRDZLUytiNkRteEM3dThsZGh4a0NKb01ObW5Ram96MER4b0VRc2ZrSDNH?=
 =?utf-8?B?RWpscVFwRTFhblRRemJKc2hudTBpWWpwQkkvSklKMDBYL01Vb25vejFDc1Q0?=
 =?utf-8?B?ZFBWWUZ3eDFyNExDaTNRSEtORk9WVlBXQTNwanFSYi9ReUJnRWQvaW5QK09U?=
 =?utf-8?B?ZC9JS0oxaTEvSVBJL2NsaFpuazF3ZTJIMUlPd2kwZ3FhRjg4SDk4UFRWL0RY?=
 =?utf-8?B?RzRLQmVOVlJTWUlTUGd6cHJnbGhRbGhvdUVDcWtLamVRelFaTFpKSkwzOGtC?=
 =?utf-8?B?cEJRaXVsOW16aGg5WUpYNkFtTkVKUGs5Z29ML3Vxa0JzaTlBcVdwMjJPUUJz?=
 =?utf-8?B?b2MxWEJxN0l2SzRQcC9JR1pJNTR2NEs4MVlDNXVMQ0JmcTNZVlFxTHk5ODJU?=
 =?utf-8?B?R3h3VmFnNzhxbkxKeERGM05QWHFRaFc0Ukdjb2JUY1d3a0Z0R1ZuQlRpNnBT?=
 =?utf-8?B?L2lnRnI1dWg4UUNnaS9NeG85ei8zaFJ0emY5TXNXUUpzVGJucUdzSVJiN0w2?=
 =?utf-8?B?cktINUFMMEIxOUp0Q1FZN1NwcTNXdEF3di82ZnpkWDFwL2JJT3JjNXBtdXFI?=
 =?utf-8?B?Rks3SFlEVXhGVG4wd3Z4R05yQlJsUFNvOW1qNTlJdnBsQmJkTHBZZXVPeGlj?=
 =?utf-8?B?U3loOHYvSHM4c2RnS2l1UkRleEs4aDZqaytYK2xlWXNWN2NJb2dMYUJCa1B0?=
 =?utf-8?B?Ri9IQURFZGJDK01LZXN4ak00Y0xPTHlNdmpya1Z3VG1ZU2JEcUtFYm16RFUy?=
 =?utf-8?B?NzErRXA2bGtHYnVidlRXM24xcjFGZ2N5SXEyeGUwVnc0eVprY3grTzQ3Z0Vw?=
 =?utf-8?B?aUNtNEZ5MzhQZURDcFhFRE1ycU1ZQldHY0hjVG5kaE1pOUdTa3pZcFp0UTEv?=
 =?utf-8?B?RUpWN2ZjOVF3MDBuSnY0blRodEpaZkJLTXM5cXcrTnVBZUIzdEJvai83N1VU?=
 =?utf-8?B?NFFxeElDb1preUVES0dMTCs1Nm9KRFhNY1BwY0FsRmpwR1g1bmxRNzFsZlcv?=
 =?utf-8?B?bVVZMlNXcDRXdmFqVzhvSTlGeTVZOVRuNUtOZlBnb1hyN1Jxc0IrNWc0SlJ2?=
 =?utf-8?B?MXdqa2kyK2doKzNLRXFsTEdJTGpaTDRudkFsWGsyNWFwdUJISHhqaHhpWXl1?=
 =?utf-8?B?VnB6UEdMZXFEa1NwekZ2RkQybE1peUNHVjBhWklrRmxLcDZMQ2RnbmNHaUxT?=
 =?utf-8?B?WnV3Lzc1YlBzUFVDVmdMQUtaT2JKL2VjR3hrWEk1a2kvM0VqSXJaMnM0RFhi?=
 =?utf-8?B?MlpieVhyYWFaSHhhckIyTndlRW0yVHUrb0xDcDNJZ0h3a1BSeDhRcEFseTJr?=
 =?utf-8?B?TURBeGdNa3BPMU5FbHN2WXlmZDFUa01hNzJ3NDY3cStRenlQd3IvYjJHS2RR?=
 =?utf-8?B?ODRDcTRwbFNJTDJiSzIwbGU4bS9SYTc3RHFkRjIwcXAzbmk5eXpDY3M3dFVs?=
 =?utf-8?B?OFAvelRhM3FZazdzc1lJdmVycmdrLy9JODk0STRlbEhCNHBDdlo4RDZJYkdX?=
 =?utf-8?B?QW1ESG9FU2xVaGxkWWdGRFBtbU5XTXB3VnFWOFFYZThSYlVIUlNjMmZSclRt?=
 =?utf-8?B?dWd1Z0owUDllKzdBSXZTTXB6U0hkdUJKQWNyRjU5MmF6bGNHWm9XQk94ZlRh?=
 =?utf-8?B?dGd6S0hsTElEM2ZiVlZseEVSMU96YXFkb3BGaG1VT1dIRFVCaGNLSTBXMzdy?=
 =?utf-8?B?Ri9GallKc3Qrekg2Slk3eXJsbk52MU5oRkxONXp0bEtId25pTkFpZDM5Wmd1?=
 =?utf-8?B?YkN3aDAwU0FNYXJCM0lTRldnYXAvbnJLWktVcUhDRFlRR0pHZ3BQM3lzdDlS?=
 =?utf-8?B?MVl3dUNOc0ZGT09aWnRLM1JmenZQZ1dXZWtxT0lZd2lHdmZKQ1pjMWI3OHV1?=
 =?utf-8?B?TmJFTVlTbXNwa0hEa2ErVy8xSkMzcXBUMElTOVFRYnVNdWJSemROMS9MODhs?=
 =?utf-8?Q?IMmcrdYq5JEW+Y+oa4N4Mw4QAznEzaOl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkpRalllc3A3OTkrQ0dXOEFOY0ZnWmlZTThKY1BjbUt5WG1CZzc1Nzh3VlFK?=
 =?utf-8?B?aCtsMkZtMmRrdFlJcFVDaVZHUlgzaTgrbUYya0JJM2NIQjJITVg0cG1Ha0No?=
 =?utf-8?B?WlZDb1cvZzJwdnkyR2tZeUo0UU9oSENlNUlUcWdkVTRDV3d0SENtMWx3N0Ru?=
 =?utf-8?B?L1BzRzIzZW1jN2VSY0V5QXFlNlRvYUx2TWtVZFI0TVhZbHZwRmNPVzNWMVYw?=
 =?utf-8?B?VzJuT3NOOGhjTFQxY3pMTjQ1aXpyTWZ2RmJUWnhtUGNNTkZIYW1HbVZHMGtV?=
 =?utf-8?B?K2RoQXJQVUkzaEVzdXRjOTlVeFFzSFFqdTJUbk9HRmcyMFpBVTg0K29sVklS?=
 =?utf-8?B?MEJVZ21XK0xMdXM0bEZlLzdlWkJ3L2tUcFhZaXBpd3UzcitvSWswWkwvR0hk?=
 =?utf-8?B?R1YyNjdUTTNqbnlQbk8vUDg1Tk9leVRZZWxZMmVlUDZaVkk2cW9WMGE2VkVp?=
 =?utf-8?B?Q05INmpEMFBxZ2h5cHJyUGp1ZnRmc1lYSkdCSTBxNGNhVWRIMFBBRTR1L1lv?=
 =?utf-8?B?ZVVkOEVaaXl0Z2t5c3dGbDVZZzZIOUI4bVVtYk9ybDhaUS9CTllSNmR0ZUxh?=
 =?utf-8?B?YW5uWjZPUnlleXRXYWdtcFlBR2VyR3BibmJaQ1VBY3Jyd1AvdlQ5eWM2c2ps?=
 =?utf-8?B?bXJvSFZid1IwQVlRdExSSjRWQytDdmF2eHNyY2RqblZjbmlXMEt2bldpdUlI?=
 =?utf-8?B?NUZ0RTU0L29jVTd4TGJhVXd4dDVPQ0ZoeG1BaS95NThUS1EzZWVjZzhaQzhX?=
 =?utf-8?B?VUVqWXEzY294SXpKTkwrSUY4bC84OVNGWkFLRTNLVzJMeUVXblpmaXBvNVpM?=
 =?utf-8?B?cXRKR2VpWHM3cHhzZzVOSzRQRERCRlBEb3p4Q0JiK1JxOERaeEZsNzVHV3JO?=
 =?utf-8?B?WnYzOG1CU2ZrRUhpR1Fsbi90cHdyVmNIc2Y0REJZV2Q3ZmhvYkh6Z2lpbkRp?=
 =?utf-8?B?S1o3cCtHYndLd1NFWG1TRExtSy92Mzg3TnplU1JlWXJmNkN2NFpOVkZ6L3pw?=
 =?utf-8?B?R3lxT3h1Nm8xMk40VmxxMjhNaVFiNWp3aURUNzhUWUtEeWFCL3c4MnR4dHFP?=
 =?utf-8?B?RURjeWdFNGVYbmRCeEJXamVJTjhCNnVPQ3g2ZDNMSXh1b2VyOVc5Si9GMTg2?=
 =?utf-8?B?czU5ZlVWOThRZnR3TUdSVFhpSGFWYzNyOWRwSS9NcllBVWswQTZFZHBpalVj?=
 =?utf-8?B?anRlMUVielBpd09JQ1pQbDlFNjZxZ1ZBd1VoNGZxOVNoNVR2Mk9qK0ptRTRK?=
 =?utf-8?B?TWJ3RDR0ZThSUVJrYlJueUlyNVM1OW9YUVZ2OWlLUUFIaTRuZmtwZDJDOXdE?=
 =?utf-8?B?QU9OYVBQdnlxR2MwVUVDU3VUN0pJakcwUTFoM1NLa0hVazBNNDJlaElrUVZs?=
 =?utf-8?B?eFUvUzNOYzBDOXp4RndPZWtTUW01MG9MQjNkaGpSTEU3R3dOYkNUODY4ckNj?=
 =?utf-8?B?NHlqaWF6ekRIc1pzUVB5aWM4TVRnQXltQWhNeld2UlBETDJQUTFuRTR2aUNS?=
 =?utf-8?B?eXNQdzRuVDhkM1kwTytKczNpRit3cTd6cXBVYktadWVSajRaQVJLMXpFdXp3?=
 =?utf-8?B?UDlBcFdOaWUzQTlMYUtBbWwwMlB1UGlhOUdKaklvRHR5OTdiZFpUaFBNTTlR?=
 =?utf-8?B?YXBoWUdSYk5EWUNramF1Q210dmJzeE1kT2V0THBFR1RjZ0ZweHJVUjB0aWc3?=
 =?utf-8?B?OHdzV0U5NGlrNW1hbHgvWEdJdlZHbnVvWmpEM2pRckNRWGNuMTVkS3g0SGhs?=
 =?utf-8?B?K2ZDbUVwUWxUaEZ1c0ZKTUFPMFJXVkhTWi8xWHpmYlUxRmRFS2hLWW9pSGtn?=
 =?utf-8?B?dmpxajgvM21pY29QcCtheFJRV1VNeEdWRjJ1czdxdHhFaDRwQ3RVc0UvNjBV?=
 =?utf-8?B?ejdZQkdldlI0RWdjWEFmWGlwb1doSThFYkdnRndOdXh0ZVYwMmtWbFJZSkV5?=
 =?utf-8?B?VGpkd1QzdUNYK1d3N0VsRkJwQTI2cDhEK3lidVpwK3hKSDBIcnplRUY0WUxM?=
 =?utf-8?B?RmVaWXhSbXpmWHJsMEtmMHFlOERpYjM3dm9xQ1J2VGx1VDhycUluZUxJYW9L?=
 =?utf-8?B?bUVrZHN3TUI2c1NLWlcvaUxQR0N6L09iZkVIUTg4QjlBbHdzbjF6YS9mS3d4?=
 =?utf-8?Q?9v1XP9Pmy9POITzjvYNI454bV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b395cd-b297-4c02-d62f-08de0b4aeaa3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 17:55:52.6918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhgAz1k4DAFxCY4Fx0oDlvvfDfEENVKIf4jmeB/CED3RCirX3B40tTbqGfo6LuZVgti+HcgAeIzotR/wk/09jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060



On 10/14/2025 6:48 AM, Peter Zijlstra wrote:
> On Mon, Oct 13, 2025 at 11:48:03AM -0400, Lyude Paul wrote:
> 
>>  #define __nmi_enter()						\
>>  	do {							\
>>  		lockdep_off();					\
>>  		arch_nmi_enter();				\
>> -		BUG_ON(in_nmi() == NMI_MASK);			\
>> -		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
>> +		BUG_ON(__this_cpu_read(nmi_nesting) == UINT_MAX);	\
>> +		__this_cpu_inc(nmi_nesting);			\
> 
> An NMI that nests from here..
> 
>> +		__preempt_count_add(HARDIRQ_OFFSET);		\
>> +		if (__this_cpu_read(nmi_nesting) == 1)		\
> 
> .. until here, will see nmi_nesting > 1 and not set NMI_OFFSET.

This is true, I can cure it by setting NMI_OFFSET unconditionally when
nmi_nesting >= 1. Then the outer most NMI will then reset it. I think that will
work. Do you see any other issue with doing so?

Thanks!

 - Joel





