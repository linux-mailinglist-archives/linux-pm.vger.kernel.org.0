Return-Path: <linux-pm+bounces-39313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD36CAD582
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 14:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6DFE301AD0C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 13:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13942EC563;
	Mon,  8 Dec 2025 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="r4er0nTZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021123.outbound.protection.outlook.com [52.101.100.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BE53101A9;
	Mon,  8 Dec 2025 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765202132; cv=fail; b=sUgtx2SZJVWexEtd8Eo5ra4LYEbUG1ZAtz5k3fIVu4b7m1fNG7C53gvW4wFi6vElWazIwkWkYljA/Nm0XoPvvmvIN56x9IkCxBtUI1vWR+eKq4EVolKrOKPPdWCuu0stLWOoc8Wq/YrdSjV0V7FIyDfrZCWR717TKpmg98ayYIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765202132; c=relaxed/simple;
	bh=KF+OilxcjXvBAvUkcilaGV9B7g+7UDxcvBhV4qDrq94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hMDYl/eK9IIzdineZeku5M7Rj/BLaIONHLX0GrYoUdZsoX/nCqsQgo9VVjsK3VJiER9TPPoFiS8PNGt2XZOfxQTI7/tSrqMOwa/Db9wVuMQMdvPTR1drZqbaKVqnuNcoCc88maEQ4a6VtnJEzk+WMpj95hjJwvJ8FUsoe1r9N/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=r4er0nTZ; arc=fail smtp.client-ip=52.101.100.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRyvqWxtFcLrIYalTxUcXZLTFwa60OBLe9yniXhQdvNFTcLtNEz7BzBCP1NsHXi1qE2LuhFyqgqL7h1rPfsGrJ4rnFD/fovTgAFgy2xVxNAIzUFBjN/WoZCrK/aDQqJ2AQ5uKSOlZUE7TqlfGzx4NcsVU8ubjbaiyXwaIOfb0ZbsCEI5hqQOrWG7KZr+t+Ohz5GvbEZ/oNfpIPGthR3EEMG3Owq48tuKpcIoU6jHMbgiERaK/rurYseyl/r/UH1HlMOqVdVBvns4LwFtDmR6P4aUuE71SIDVgADyaSByFj/xW4SW47DhIMe0eeVlhkXezcwDiUIOQJgC5n/SEgsAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbvXkuwm2zdAdzfaiypvf3tyUN4gje/TlBVoYSUxcT0=;
 b=XXPo26gOq6t1ajJairBdbFzK44ipqmTTBPr5tAHBfQJjwlms/l9NTglN1sDdEKcb0aaVFS2gbQ3Jmnbz5OD8mAwvvySt6ViMM2ppVixZsRRBuDcNYEGon2Nl5ZEGGW83s+iIuW9kLSyJVtkZBQ/N/JA7BmhJf32WBd83JmWIK3VyZEtox7x2s27tqHHviyI8dGNNkZLovNsfzJvt1hz6PKYQS/wVvzKfP905Gk3bu1LgKcmO70vhK9ZmsDrAGE2ip02pDdHOYoktdTn9YRoXMvYEzTbPv3seqPPWcveqNVacqJ7NufiBYj6p8ki6KDXMEXPEVJDCt5xTGfxlugQLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbvXkuwm2zdAdzfaiypvf3tyUN4gje/TlBVoYSUxcT0=;
 b=r4er0nTZ//SfSrAcS87HsVBaXJpUrhftv7B2sMhaavER2W95LM7n2bfx7XYztKbDkL47msRC86ERJ/wlcY/LEyvaEOnfFSfD3KJV+Zm1Z3c8kDeYV4CTeGppNqtKqfRGmfrKhbI8maAGGYud+FIAHNzTfYzuzHXhzOvCi1P+DZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB7050.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:321::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 13:55:23 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%6]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 13:55:23 +0000
Date: Mon, 8 Dec 2025 13:55:21 +0000
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
Subject: Re: [PATCH v3 3/7] rust: cpufreq: always inline functions using
 build_assert with arguments
Message-ID: <20251208135521.5d1dd7f6.gary@garyguo.net>
In-Reply-To: <20251208-io-build-assert-v3-3-98aded02c1ea@nvidia.com>
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
	<20251208-io-build-assert-v3-3-98aded02c1ea@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0087.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB7050:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ec7956-04e1-4358-e932-08de36616edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?59aL88Yf61TULewML5WY9xr930kcnGsXR9LFuAFF3IxGkwsHgmUPmYbokipx?=
 =?us-ascii?Q?JUW7+0Im1ND7guxxwC0v9AXYWvusQZMu+hOVI8Ja5kqFBK1IiACu+Ji1Q0pg?=
 =?us-ascii?Q?vlKovCQxIVKSFXs5sPDqqiV4hAd/3GpqENIjSD+NGY9a4goPmyGFutIf9vSM?=
 =?us-ascii?Q?4lseSpcRGzBlpTmM5rUJ+JwPfnUp4JHEPcJNO3Niu0IkmYxZWe2bQJPnh4mV?=
 =?us-ascii?Q?lYmzLKv82aZJ0EjOr7vz2FdsNQElX0jTwhH/4bUAMGdB7JfQfem443TcQCTv?=
 =?us-ascii?Q?/jxGwE4Pu7H9Cx2vIiVpntNYydNrP8/hYLoePIxzDNub4+zWVsaoQPmuSiJJ?=
 =?us-ascii?Q?UD37axK9VookrSRernmkPmGATxy0ZWQsUyBKWiMv670TAs9C1ER8EWGm0NR7?=
 =?us-ascii?Q?I/Dj9bfE4g+NGBBg94PhxVV8l4cjGrkzpmZBy0ciduU3avNZ05QQDYR/Gp6k?=
 =?us-ascii?Q?5gpOd3zj2JhaLQ6P0oVCPrCqB9YwYpaYXZZxniVpKp2XADySR1i+yNO3m5sC?=
 =?us-ascii?Q?OHsY4XmPGjHoXQzBpyjSEuLkMaRAOo+Oeu2AY6dWZTeFZ24i1eNbRtxRgY3q?=
 =?us-ascii?Q?qttTtBVXxTAx+2oli9HAER1vV4J92FEizjWkKnVbmIZFjcmMETqXShh/pleu?=
 =?us-ascii?Q?Gq13bzhzZoi/H2oOZVr8coNF7VYRiIUmIOlOfpYh2NOSuLXJLJBcZohqkC1a?=
 =?us-ascii?Q?WfS6kFSc16PB/aZKf6NJb/zvAlPHxDzAkzN7pFXkizcIA2h1ljNjDhLLNe61?=
 =?us-ascii?Q?eLExMFfUYlkHIlL69C3KV7puK3Lp0QO42omMXGx9f2HqdMCuMJipaqsWV2Me?=
 =?us-ascii?Q?V+T2wzvmZQwb7wOuNXXbBZNhpSiFFOfmjeHj/DREabdTGj+JU48N8Hb7GFmy?=
 =?us-ascii?Q?jMyTHE+UFbJhU1xY9faqINegaTdY9wzWZs3EROvMGECPowdYk9+s1/cxpLE+?=
 =?us-ascii?Q?q17/xXcsMz1Rq0ceo2YLJbv4GdlnfL+eSqvwEEjZ5yAdwiNADIgDLX5kr++y?=
 =?us-ascii?Q?B1BeqdNBPgNBPupUAJtiu5CIb+WGZvbYFNFi5C09Oy1LU2rfwE7iYrBv9vdx?=
 =?us-ascii?Q?BjXKtFKHXqKMGInZ5MjpDIf1RzWGZENAjjfW8gAJv7Uft4JVWmuFDaDoTzhc?=
 =?us-ascii?Q?2OWvUgEcyp8PVHEd0gBJ1mUcJeRuQmOK/oqUezijJ7SJ4/wbQZkAYe/aVrSL?=
 =?us-ascii?Q?5PluVLdfhm27sHmw6eiWDbpDiwhctEu37FxjkWWRVgUbS2cvIaB2+8jzEJJW?=
 =?us-ascii?Q?J4cJMeWHlXQvr52TlwYIKY2xRk1pY74rhrwPIyeo+16NaIguSEZu05UsPFe5?=
 =?us-ascii?Q?/PmqwNUu/B9eSZ0PUU0bEl33IWlqylj8AjI1hyLj62ZQfnVDR34fZr0pdXe8?=
 =?us-ascii?Q?KjIUDXblVIBQUQtyi8nZa2SHoC9GEF4LhoUoJOf+NggQs9lmTgIE+22GZlMT?=
 =?us-ascii?Q?cGaotxzFyUjsk6MUgaNCzGNRoIHTIcC9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mf8D6CxXwQ4TG+JQlvhDPfwFQZOINRFzAknoozaiPr8EBESoTg3q3hC3+Rz7?=
 =?us-ascii?Q?eg13yS1/tDxlhGIU8tFyX45obX33rT4fSdvIVE8JhCatROlfrJXowc6FAcY8?=
 =?us-ascii?Q?G1ImjAbDA2+bToBrQaKsdE2v6xoGZqZhR6gJxFDkjPrXsZRwqXATSW8UVPuj?=
 =?us-ascii?Q?IrkJDIueZrV2GYISQCput7wsL7NjD51Xq3CAbJcifbON+hDHI7cYQ1U16OUf?=
 =?us-ascii?Q?FS0pj4sxJnaYkodX2CQcGxHOcIVbKQu9eeiwVWDoU0o+jWpxoGvltmnp9HQs?=
 =?us-ascii?Q?u2voa7Ytl9nSUL/+CKFTFKq297jxsNMpjE3+y7e9fg4KR+ae4O/l5tNV76N7?=
 =?us-ascii?Q?JT0DwbDGJo6pz8/7BJDuKuWGgplneW8WEZS1jj0QVvIHt8cahWornwM48WQ9?=
 =?us-ascii?Q?1+1xflYBLf5oY51kQpjyUqY6R7htlyUrJczNqCKHIYHnXwGzNa0d0AgbQf/b?=
 =?us-ascii?Q?HWQi6LBnbbaSgxPrb+Iy65V0+VBONK1vvVLCm0JJp2bV/gh+13/rmQ6yCYWP?=
 =?us-ascii?Q?ySEC3/rDObBPS1LWaHBwogCmP8RQ2MxGBoaYdSPMl1KhO2su/DJ80ZQQUFcW?=
 =?us-ascii?Q?Fx4o633JclCl/UrjKr8eZvXGISrt7HiGI1N7B663XFPEsYt3afOtN0uLIstw?=
 =?us-ascii?Q?4Qc6sLLJQdAszioEx+lLWU8TaCpRJbME9lKZcrKhsRFiNK4DeMx4NSV56eKS?=
 =?us-ascii?Q?inblpqPOEVmRq7+Z1MVbvMnUzAy4/P8Rb9GRIxMbLs85Qc/isk0l2oQQN/if?=
 =?us-ascii?Q?aXY1JVpdkIQJBkN5B28rPlh4IO9yeHPvfBLEcwjqphatvtwzmYJCxkL7AqfN?=
 =?us-ascii?Q?x4wBvkvfLxC0cUBepXl2bPcdEfN/9xat4fxr8tjsSFrwu/Z14/xYEJSkNyv7?=
 =?us-ascii?Q?wKr484LlHeU6ONvXbNooW65JfOx/74aYvFt19B/3OvrMxTwcg9LIJ/y9O+/f?=
 =?us-ascii?Q?+6XZV4WchLGfn2bR13aJ1JeqmQQY+N+reD7FDTRk8qkLA1QN4NzOEfx+JHgy?=
 =?us-ascii?Q?3G0hSoQkNF8QX+TksYlFwGJmunbYC6SP4nZcnl2RpEkvBtHVGBuKNnI2nvl8?=
 =?us-ascii?Q?+rRd5aby7YTvwMVQVNNZTLqHTd5uKiSiE7bC4WdXcQnvqKJaTBS52zt3dRib?=
 =?us-ascii?Q?Tggex6uTFhxyN7/bn8vYL5opi5QeEkYTvciRSsIrWl2nEJWF9rxvLjZVOtSD?=
 =?us-ascii?Q?kARUtzPV9QqWtGjsn4afv//6DMdkwHfo+rFMwXKFvRU61ceKIqXncFF9KsRr?=
 =?us-ascii?Q?c23h8TSyIphZQ/+w8rLEdBii44nVOamXhGpT8WM2wGaxk+TPag/WMAYCo/vS?=
 =?us-ascii?Q?HqGqJYnx0/onHsxeLbFIRdHbZYL+s/B8EWdiGckx9b91MkF4ZG+MjuC/ajyR?=
 =?us-ascii?Q?cHqPCAm55TSXNqSHzGyyht/wkYZqhHxR5pIlNCQJsPr5Pkes+xefWkOdC8Lm?=
 =?us-ascii?Q?KByoJ0p5bBickGypufG9X41xLhJZeJV5mZKuYUceTAZ+TvdLw9J1Zn31LT/r?=
 =?us-ascii?Q?wK/uNii9tz8WYlrnwJ0h+MyXkPMm2F0m807KLzOGS6amyt48FIs/lnt7inMQ?=
 =?us-ascii?Q?ANvOd9aYDYfA+NoMSUcT/msuzQiErRghPPoZgM6J?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ec7956-04e1-4358-e932-08de36616edc
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 13:55:23.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2No8hYxUME4sMpwZWcfBFoXRufwo5YdGU/QjKCcEX6px6ZxHQPUWbOsfdd/tPFOga+Xe3pOpRS4k2o9Uhz5MvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7050

On Mon, 08 Dec 2025 11:47:01 +0900
Alexandre Courbot <acourbot@nvidia.com> wrote:

> `build_assert` relies on the compiler to optimize out its error path.
> Functions using it with its arguments must thus always be inlined,
> otherwise the error path of `build_assert` might not be optimized out,
> triggering a build error.
> 
> Cc: stable@vger.kernel.org
> Fixes: c6af9a1191d0 ("rust: cpufreq: Extend abstractions for driver registration")
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  rust/kernel/cpufreq.rs | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index f968fbd22890..0879a79485f8 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1015,6 +1015,8 @@ impl<T: Driver> Registration<T> {
>          ..pin_init::zeroed()
>      };
>  
> +    // Always inline to optimize out error path of `build_assert`.
> +    #[inline(always)]
>      const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
>          let src = name.to_bytes_with_nul();
>          let mut dst = [0; CPUFREQ_NAME_LEN];
> 

This change is not needed as this is a private function only used in
const-eval only.

I wonder if I should add another macro to assert that the function is
only used in const eval instead? Do you think it might be useful to have
something like:

	#[const_only]
	const fn foo() {}

or

	const fn foo() {
	    const_only!();
	}

? If so, I can send a patch that adds this feature. 

Implementation-wise, this will behave similar to build_error, where a
function is going to be added that is never-linked but has a body for
const eval.

Best,
Gary

