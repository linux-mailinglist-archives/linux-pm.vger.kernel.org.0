Return-Path: <linux-pm+bounces-28167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F478ACF82D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 21:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A0B3A99F7
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 19:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F54E22577E;
	Thu,  5 Jun 2025 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srvYOLHb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B3613D53B;
	Thu,  5 Jun 2025 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749152521; cv=none; b=tuihzd0GQBYdNxKxAlFRRCW4PYCpED6Q6fGx7FUZfsYBmY7a7bEoNyuMwxPQwZo2fm0lFOIS4AQNjj1ZmPAXhG4QFK5hKmwojLg7ZrtyKaoZeiUzv4Ug+wAlvyE7wywovWru7npn+wkwdiPBtXLVrd3RYcz95mARu0NG+9XOVfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749152521; c=relaxed/simple;
	bh=WNUFe0r++rYYxQncweuDCwXerrSXSE6XT3XraY36xMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kMpBBSRbZuabQ2FGRvtu8ne/BdLeUTRT9siE2f+6wMkcri0IWvrGX/nLpqT0EavHdlY5LGhHI0xHPGIT2gGNb6lRB8VvaziU4/kMZ50giJZAaYcR7l7vYNW6v6J28gU7aB8caOM2g+w1m++PFtWn4LRJ/klw8YwJmwe5THWP/CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srvYOLHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBE1C4CEE7;
	Thu,  5 Jun 2025 19:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749152520;
	bh=WNUFe0r++rYYxQncweuDCwXerrSXSE6XT3XraY36xMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=srvYOLHbCeMNbYO76cCjgQhuN/kYRrnYNbgN1Tb9HUijXKONnbs4C1+j6o3kslpTa
	 5HpEkVcRy8iGPCxSd+QvGOZXLUFMY9riiTH7UWkHVgNnhkjbyhR++PXNEGFMPKqhD8
	 U9MinUlthyP6n+NnxAnVKvdQ+KVQQjaSUYg++j3e5h0iqG7R+l++K9ZZdOjO5jxoMQ
	 vdaD4IGnBBtyePydMFrA+XdG6kej6925BxyQHedKIt8VEjskvqDes+EFBvEM83wzHs
	 Km1KWt3aKXJhpXO696dDL3//xkLx0ut1fZOA2uOuFfI0RSxYsJFHsw/L7PTapn57Jz
	 6+knLjd+CZljg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Viresh Kumar" <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,  "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>,  "Danilo Krummrich" <dakr@redhat.com>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Alice Ryhl"
 <aliceryhl@google.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Danilo Krummrich" <dakr@kernel.org>,  "Gary Guo"
 <gary@garyguo.net>,  "Michael Turquette" <mturquette@baylibre.com>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Nishanth Menon" <nm@ti.com>,  "Peter
 Zijlstra" <peterz@infradead.org>,  "Stephen Boyd" <sboyd@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Trevor Gross"
 <tmgross@umich.edu>,  "Viresh Kumar" <vireshk@kernel.org>,  "Yury Norov"
 <yury.norov@gmail.com>,  <linux-pm@vger.kernel.org>,  "Vincent Guittot"
 <vincent.guittot@linaro.org>,  <rust-for-linux@vger.kernel.org>,  "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?=
 <alex.bennee@linaro.org>,  "Joakim Bech" <joakim.bech@linaro.org>,  "Rob
 Herring" <robh@kernel.org>,  "Burak Emir" <bqe@google.com>,  "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>,  "Russell King"
 <linux@armlinux.org.uk>,  <linux-clk@vger.kernel.org>,  "Andrew Ballance"
 <andrewjballance@gmail.com>,  "Anisse Astier" <anisse@astier.eu>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V12 00/15] Rust abstractions for clk, cpumask, cpufreq, OPP
In-Reply-To: <cover.1747634382.git.viresh.kumar@linaro.org> (Viresh Kumar's
	message of "Mon, 19 May 2025 12:37:05 +0530")
References: <HVTDJypFNQFfSQJmmYDSPU4o-irFnjmDN22RW3S0z5Kwe_hVk9kquZWElv-C2k6d5kOIiewhj_Xo2kAoTHbHgg==@protonmail.internalid>
	<cover.1747634382.git.viresh.kumar@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 05 Jun 2025 21:41:47 +0200
Message-ID: <87qzzy3ric.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Viresh,

"Viresh Kumar" <viresh.kumar@linaro.org> writes:

> Hello,
>
> I have queued this up for v6.16-rc1, will merge it via the PM tree soon.
> Thanks.
>
> This series introduces initial Rust abstractions for a few subsystems: clk,
> cpumask, cpufreq and Operating Performance Points (OPP).
>
> The abstractions cover most of the interfaces exposed by cpufreq and OPP
> subsystems. It also includes minimal abstractions for the clk and cpumask
> frameworks, which are required by the cpufreq / OPP abstractions.
>
> Additionally, a sample `rcpufreq-dt` driver is included. This is a
> duplicate of the existing `cpufreq-dt` driver, which is a
> platform-agnostic, device-tree based cpufreq driver commonly used on ARM
> platforms.
>
> The implementation has been tested using QEMU, ensuring that frequency
> transitions, various configurations, and driver binding/unbinding work as
> expected. However, performance measurements have not been conducted yet.
>
> For those interested in testing these patches, they can be found at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git rust/cpufreq-dt
>
> Based on 6.15-rc1 + rust/devres dependencies + PM/cpufreq dependencies.

I was testing an unrelated patch and found this kunit failure in
mainline today:

[19:45:34] # rust_doctest_kernel_cpumask_rs_0.location: rust/kernel/cpumask.rs:180
[19:45:34] # rust_doctest_kernel_cpumask_rs_0: ASSERTION FAILED at rust/kernel/cpumask.rs:190

This is for arm64 defconfig. The test seems to passes on x86_64.


Best regards,
Andreas Hindborg



