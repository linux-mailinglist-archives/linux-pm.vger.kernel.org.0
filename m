Return-Path: <linux-pm+bounces-39311-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 067B1CAD549
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 14:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE624301AB23
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 13:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612BD23EAAE;
	Mon,  8 Dec 2025 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ZN52kC3a"
X-Original-To: linux-pm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022075.outbound.protection.outlook.com [52.101.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9A72623;
	Mon,  8 Dec 2025 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765201782; cv=fail; b=MJsRr9SNF7RJsdIZk855dD7ngUZVq60QJs3dfLsgA4XgL9IkcYTKuwpLtT24zDNrHPmZCYHQin26ZuTsXEBReAdLlne6H54wK+A50S27ncFxIqTKl+kXTPfn0TyrsC9EZOHDF6qhSPdID3dv/ZoZVCD7XsZAc5Jo1cx0Ir1HXSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765201782; c=relaxed/simple;
	bh=+ChtnHYhXYmQB9Ju1VhVp30Sn0BUl6WxavEiugo9H0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ScFl9rZINnHgTdQRmpU8K+vKEAfVTNaqsj6L9V+egQilYQGd+knGIp1DsaSLaxsnNs5xcT2WCjs+3+6kiE1WlkXtKf50QqKRTBgP0IGAtSEs15SWyWYJZsx5hJ+Gd5+ohoYXviWImtcflmbqEe3wP9XtJDJa2bkHIqAmyrp72JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ZN52kC3a; arc=fail smtp.client-ip=52.101.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xxncm8BYAopKMNAkCZFY8R8rz5nKUPR4AamMEFyWmgdPouKKPJ6jFWZmXiJgfTRjEOaS37GMDv7hVbY/zAu17sTDcWwR2e7CKYRDkGfs2WEshDyeuvwEtFZ3rs1H8BnZRlxKApIs+idZTMns63XTxLYxQE7lN3aten7nPAXU/c4mt46Mp3Hkxw0eNAL70E0FLRRGI4h0aSlsDWnwS3rDhZBodtnEznTe1V4lASPgtD5M7QKwQ1Gfz5Pkgq+LhKKBHhj5y3JzqhMYWoCZ9o+sp0pO23VUAIDANYsVIssy1A9jomuDdpe8Tj/AOfAdshUl33f+WsiasVi5rnmuTusV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKwz8FOUzDI5BdFxJBDXzI4Noa1klj/zs27vC4Yz8l8=;
 b=dX7KsGwueAVd3eqosqUN1LwZ+XmhTAK25ajPpuMj7y7ZoesPC3FJxrxmxQQXuX75j/9lqZqJIu6VGmnqQpVhyvDmdcB2Fowct01CTMw1aGZrH3osO5AgWZIMFojwYAa14iRu3BZxDrheKXbNuNlneiCZJzp3Sk2MmpiDUd86F5M4t/1hRW2YVS7vp2xEgDdBRZ0PnwW1/SkAMmFPQbPNxSxsvnLWbn+9fushCKwUBNcrIGuCMbCloy73mB0YL7eK3COJf34z1xC8tDJ9MhYrYYzeOGrbwKIhESic27tKI3GCG5kp969Lu2kkeP2q81+piEKVqr9xWcJqGtIxHh/muw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKwz8FOUzDI5BdFxJBDXzI4Noa1klj/zs27vC4Yz8l8=;
 b=ZN52kC3aqbK1IA67np0SO78txYuWjZwbOMey/9lExwsQdSr1Nrkp7XlE++2df+2rnq93dzi28f8M41K7uj1NE44avUoZ/n4zdWFei2kuD5d6UleGrN6WEiHGpx/cKmmmsQvINdYxBfGnIhDHUQYj+Rmx6jx1tZJcaPcdX+mvcPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5989.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:28c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 13:49:35 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%6]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 13:49:35 +0000
Date: Mon, 8 Dec 2025 13:49:33 +0000
From: Gary Guo <gary@garyguo.net>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mark
 Rutland <mark.rutland@arm.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] rust: build_assert: document and fix use with
 function arguments
Message-ID: <20251208134933.24372874.gary@garyguo.net>
In-Reply-To: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0503.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 355851fb-546b-44ed-a1dd-08de36609fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LJKHQVchRhLjIytNT0YJDvCTzuiHpLU2rIHiopxHwEUQ/Ful8CxCsxhuGZ44?=
 =?us-ascii?Q?3eaBAT7GuMrVBMbGyenBoJA6I/N+SUp1G4Q8coWJp2qSmAgx46QHcUNGr4qL?=
 =?us-ascii?Q?pLLT3Q8YkHbjYAnKoX4juxvLtPQ9RTAJrT7vheIwrAh/CQIU9rYiXg09K0Jc?=
 =?us-ascii?Q?/3KYEuO6eaXKyhVAgrqi1XksQfWJ9HvSlF6T9JhHIvc9dAGNaMw05L4W64T6?=
 =?us-ascii?Q?8QV4AHYrP7CmsOxl0Ti3dO2Kp+tmssZeoUOvSUOPTGJoN8Drgp/unCzSRWuW?=
 =?us-ascii?Q?bIhL2Prytma6lBCaBydDfoLrVMrN8Tm3YYnU6Rr55d19ce5B8PHggLt5rRl2?=
 =?us-ascii?Q?Q3RU5Kk5M8/7wgBY0BtxAbqTP9PhVYhkF7DK/ayWkKEGjBAOTlHCjswkgnAz?=
 =?us-ascii?Q?neAbCQ2ayg51y9qpuMAYch9qj0KKkQD2JOwVv/Zn5NAfnSlLe/KPSkodPXoz?=
 =?us-ascii?Q?DG+N3ro9eL+OejhBmu1o+sWC5/tBVD4vBffvhxoxKyBorXRcgVFjj0/AVRzH?=
 =?us-ascii?Q?2aWDiF+z5JSyay9ll+MpqeQCRIiRviI479fp/SZxkS4a7r84T7tgkzzXpUCn?=
 =?us-ascii?Q?0nlV67ImtS5Lk4EcTLwKEreFWJKtveMmJRI+PO4HIgYQN2IP6thddPtSKk3c?=
 =?us-ascii?Q?wfn2OGyjQBjLSozlxN2r+IgrFm0m5VTdnTRBJVyaYiZKRWnE5mC5c/6T3HJD?=
 =?us-ascii?Q?uuVOLzmveddWngRgYsYnU+hvb4wvXd/uIePhqfHv3659KlWRnYwM63GErZdZ?=
 =?us-ascii?Q?4tXL+Stj/hEby710EVwXxPcD2hdK2EcOgw/Ew/hAATFmD86vNDhD3DTlDxGh?=
 =?us-ascii?Q?RQSPjjIWNNpML8mGQ4vW2eEVJmOLqfWXFOoa3/csp0rsh9LNZR505hZ6/VR6?=
 =?us-ascii?Q?mrDdGN0lEAgOZg7r/nBlzY7SWvCRh9HAmJ3mhHEeAu9lGR7gyZwC6K/w7Jnh?=
 =?us-ascii?Q?ZDLGBnONhu+3DB7T/TT/f0eZ5CJ1JuFMTaALt63rge+f/qEi6E75CGw9iswJ?=
 =?us-ascii?Q?7JI9haaiop9/5MufTP8vPv7r2yZCpu9YyKpT3o5hkG4TCHROVDur3rZL9pR1?=
 =?us-ascii?Q?oQr1Tnx2qN+lzsgb2KotHPOg0P9MGqYI8BhvpxbwRTVnDe0Am8KSgxs0acHg?=
 =?us-ascii?Q?+bpzEGLFLLJ1X/yeQLlcAHdFpPR1zmyPJ4i0iyTcZ10VBrrwm1N00RNqNUqi?=
 =?us-ascii?Q?EkIBoODi0D/O/aIlpx7eA2VM6MhRB8BT8XqZNZvzyTY70IO4g9s7IFjSL2AR?=
 =?us-ascii?Q?xJ+bBGUyuKkywN4ReZJ0npa3ZkacMg3lThj8hEB0Kci8zD++M5B/g/IhJmWU?=
 =?us-ascii?Q?+MRsOLqcI+rJOk4DONk4m8ww/K3z1ai8nf5s3SpEuMKp1vWXN9Rkplvyu5Yz?=
 =?us-ascii?Q?mbH2tmtvnfMXazS6nWrIhNef9aTflmUhkNKoNkp1Mocq0AJoML6iAyespmQh?=
 =?us-ascii?Q?8W7Sa2lEBIR/5dn/F/88+cXFbmr2+Wdp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VZQSyljaEQbPOMdykgOjlUMnbC3SkaP24/RiDtERVt4fQyu5qgz+zPrHl7P0?=
 =?us-ascii?Q?RAnuC1rJTt3lSbgDJvejvDJZmfMkACBiA3NaZU5BY5MRpqOoM2bSViZmryJR?=
 =?us-ascii?Q?mjNSru7eOrK7lhjbpvjR/lIp1XgercnqJ4QNH3RHlMJ8wX33NwchwrDC2ME/?=
 =?us-ascii?Q?hNBnJ3OprWUJD4rhHbAhLh5GQbVSqtD3lVxcf7uQBka9e6ti7Iu+QHZTTMeZ?=
 =?us-ascii?Q?qflf9DNe9TUAQH01jUqkq5ma2tmn03bkPUZ6uU9qNtl6yywxtTcJM6sd4eov?=
 =?us-ascii?Q?7w6k5Mlh8+SBzEMpX00rBYR2XcvuSYvxmUEkJIubH7NZFB7s3TPkLza/POl7?=
 =?us-ascii?Q?2s/j4ep6Nsbm/kFgsws8GITrdSXmqsJFPm8EXlvYoFr8/uAI/xzz78UkpC3Q?=
 =?us-ascii?Q?ae0KnyZ9SCcUkXjXkQlVsp00mMW0xZ81dxJCVp24NEeopR4nqCCb1WRqmi7s?=
 =?us-ascii?Q?Ir3Nfcm9TlaKPgLhn0rf/y+k9z9Aj1IBjIjh/kaQRoMKyFMB08fq3CAPgfbB?=
 =?us-ascii?Q?FWQDJl3n0KBw2ufkTt3xB1Sj4N5jPfvMOL9qwEOmzQyinAyk52uuThgP3/vi?=
 =?us-ascii?Q?yPz+51tlfSdMoUBHMW333STR/JwpN1c5amKponx/4zqQer3/BTwjVX7dMJBH?=
 =?us-ascii?Q?y7PL/6Wj8xvGRUYJGx105Xc0Cu7z9XO8+i1ShX0zDAHEUoyT8QmIT1gyMNHO?=
 =?us-ascii?Q?aDk8kS9DoFbxruoKbmkXEq9BXhedSTyG2fVUGftrYyo9rAFxf6QUKOJrYTHe?=
 =?us-ascii?Q?6ugJZcVdcg8r65MoC/KuTztFVw6QcASpAeZYc66ymkOpnhDoIKfgtUEaKMQ8?=
 =?us-ascii?Q?milz/Iv9uWPo7p3leOQa9J0R41xMN34Nx3ssiDY4YkpFXtxaMVlptkcJCtND?=
 =?us-ascii?Q?3WfE3KrozfxscIVNVPlTu999G5/1bECBiKIxAMYT6UITugMnytN8Nt8rQyaU?=
 =?us-ascii?Q?eNd1FZEtWjICUhjtmc0VNeT7MPmf/ctwcdZQE26nH8XbgEtIYZxviWFfclpX?=
 =?us-ascii?Q?NsmMR47JzVsn7yw1ZyaLNZfm9IBkpgukYehXrWtBRKWZolD3ll1bE1P3ycsE?=
 =?us-ascii?Q?vaLjqr5Zl2XlZx9gsnLs3BDNpnuFiva8D2y2fJ6gyC9C0DcnmGq+enr0Tf9S?=
 =?us-ascii?Q?JqajuN/s10wdwAmb8SftuSkBSz3nmRjpgR4HZldbenTW+vHAG+9RhVH08QDX?=
 =?us-ascii?Q?wCkpK3K0m7aqmt0b5/7L2O6rXFvWH39AdGxNo3q2vpZJdg3/40y5C9ogu7T+?=
 =?us-ascii?Q?3Lecf4/gc0T8SAdiFL9amUrhK6p6BWvTDL0q+NN2/lHm1CShQGOi8JZ31jwS?=
 =?us-ascii?Q?/MLlMtruErOmb24UroEL34OZDHD3Q+0LJynti0+8rZmgUPNDH9vFCqGvXhDO?=
 =?us-ascii?Q?1UBg3pTQth2bD9TCBCx2OileuFYzSxT/8TfXgZekfpE2dDzsWgkz5s/irD4L?=
 =?us-ascii?Q?zL1orfmLTsQLJgPoleQ7HnNouoGEXUcPaZzofAI4pdc90iiedmlYWEnlH2p2?=
 =?us-ascii?Q?rwCt4+HL4tK+uj0sMSU8eWQM61t6EQTYX4ThMoT6iaU+6JAJZPHfcrSsnVtI?=
 =?us-ascii?Q?kElk7cZxdbXO4eO2+PqXW4l5Tl1Sc8UAIIm6TrYZ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 355851fb-546b-44ed-a1dd-08de36609fab
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 13:49:35.7885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfqDTyqTn3Umijw58xyBj3VDHdoO1N4BhdIWcJHmRNWNAB+vCEwJ8VxNnYgLOByy4KB9rM4YhYy3aQ4hQEQ6Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5989

On Mon, 08 Dec 2025 11:46:58 +0900
Alexandre Courbot <acourbot@nvidia.com> wrote:

> `build_assert` relies on the compiler to optimize out its error path,
> lest build fails with the dreaded error:
> 
>     ERROR: modpost: "rust_build_error" [path/to/module.ko] undefined!
> 
> It has been observed that very trivial code performing I/O accesses
> (sometimes even using an immediate value) would seemingly randomly fail
> with this error whenever `CLIPPY=1` was set. The same behavior was also
> observed until different, very similar conditions [1][2].
> 
> The cause, as pointed out by Gary Guo [3], appears to be that the
> failing function is eventually using `build_assert` with its argument,
> but is only annotated with `#[inline]`. This gives the compiler freedom
> to not inline the function, which it notably did when Clippy was active,
> triggering the error.

That's an interesting observation, so `#[inline]` is fine without
clippy but `#[inline(always)]` is needed when Clippy is used?

I know Clippy would affect codegen but this might be a first concrete
example that it actually creates (non-perf) issues that I've countered
in practice.

> 
> The fix is to annotate functions passing their argument to
> `build_assert` with `#[inline(always)]`, telling the compiler to be as
> aggressive as possible with their inlining. This is also the correct
> behavior as inlining is mandatory for correct behavior in these cases.

Yeah, I suppose when you draw parallelism with C `BUILD_BUG` macro,
there are a few users of that in other macros, which are kinda
force-inlined.

> 
> This series fixes all possible points of failure in the kernel crate,
> and adds documentation to `build_assert` explaining how to properly
> inline functions for which this behavior may arise.
> 
> [1] https://lore.kernel.org/all/DEEUYUOAEZU3.1J1HM2YQ10EX1@nvidia.com/
> [2] https://lore.kernel.org/all/A1A280D4-836E-4D75-863E-30B1C276C80C@collabora.com/
> [3] https://lore.kernel.org/all/20251121143008.2f5acc33.gary@garyguo.net/
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> Changes in v3:
> - Add "Fixes:" tags.
> - CC stable on fixup patches.
> - Link to v2: https://patch.msgid.link/20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com
> 
> Changes in v2:
> - Turn into a series and address other similar cases in the kernel crate.
> - Link to v1: https://patch.msgid.link/20251127-io-build-assert-v1-1-04237f2e5850@nvidia.com
> 
> ---
> Alexandre Courbot (7):
>       rust: build_assert: add instructions for use with function arguments
>       rust: io: always inline functions using build_assert with arguments
>       rust: cpufreq: always inline functions using build_assert with arguments
>       rust: bits: always inline functions using build_assert with arguments
>       rust: sync: refcount: always inline functions using build_assert with arguments
>       rust: irq: always inline functions using build_assert with arguments
>       rust: num: bounded: add missing comment for always inlined function
> 
>  rust/kernel/bits.rs          | 6 ++++--
>  rust/kernel/build_assert.rs  | 7 ++++++-
>  rust/kernel/cpufreq.rs       | 2 ++
>  rust/kernel/io.rs            | 9 ++++++---
>  rust/kernel/io/resource.rs   | 2 ++
>  rust/kernel/irq/flags.rs     | 2 ++
>  rust/kernel/num/bounded.rs   | 1 +
>  rust/kernel/sync/refcount.rs | 3 ++-
>  8 files changed, 25 insertions(+), 7 deletions(-)
> ---
> base-commit: ba65a4e7120a616d9c592750d9147f6dcafedffa
> change-id: 20251127-io-build-assert-3579a5bfb81c
> 
> Best regards,


