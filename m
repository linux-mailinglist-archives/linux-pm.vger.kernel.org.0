Return-Path: <linux-pm+bounces-25529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95D8A8B467
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 10:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D743189D1D6
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 08:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB890230BD2;
	Wed, 16 Apr 2025 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnvxGz5G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8880B8494;
	Wed, 16 Apr 2025 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744793573; cv=none; b=EQjfCi1Vrm+qPZ/mjivGzjHlFIV+veGuOt8U3ZlDkfUscaUQH69mssv3UoAc/rIm2/0MIwYoj3pyOUh284ROZE33r9uQhgaWcloBG6t1weueZE8n601YQdc525/i4qxZBjMTlNPrrGJNVMhNa0fSTydOK2zGFwdGaC8JKJuvdEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744793573; c=relaxed/simple;
	bh=RnJXf3yeEkNSvfYLGOSZQdoqPefOM/O6vhN6IFZZRog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBK92+WCmXfOiHMnhjE/iSSDfjRER/U4vVKa0+wte81cpESNL1gu3VRwfZN5QrLFNg74b0k/Fl4x5/P+ktpE8qqsF6OaSePRsOHTuPRWU0ilMgHa6EC8VqmhuMpscdfb1XSzvJFKJ+/YZsVLOOf4A5VSFovkIOqKlWraK7A5Adc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnvxGz5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A8BC4CEE2;
	Wed, 16 Apr 2025 08:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744793572;
	bh=RnJXf3yeEkNSvfYLGOSZQdoqPefOM/O6vhN6IFZZRog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnvxGz5Gw8Y3CSzJUsLhvzcZ2WzweniBFVo+koHRBmAtFnEhHiQBl+0VeCR48NX6v
	 4CMyzVEuT8ylK/x1RcCcGGZLCtWEY1Gr5ZgsDqj70JOKVTx1xF4lL01jWmheNPXNfu
	 zQo86iBJJeYH66lT24xKz55/B/RjxkjFs1PqmQqJqJRbai3i0L8U6VUt7sI/9q+DnC
	 2yUsDskIQCzAa7/FvzA3P/jnTxzDIF/r4aQOB/g3QJgq5AvokDvdidyDenzOYZK7Bs
	 uKDitG5L2XtHW/7DtmxnsTFFUwxpYvBmfPv4YDjM0lKHJu+xk8BiWIN3OSS3QKzEaL
	 c5K5edVPxU9Mg==
Date: Wed, 16 Apr 2025 10:52:43 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 14/15] rust: opp: Extend OPP abstractions with
 cpufreq support
Message-ID: <Z_9v24SghlIhT62r@pollux>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
 <a940d1b1a02d99fdc80ba8d0526c35a776854cb3.1744783509.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a940d1b1a02d99fdc80ba8d0526c35a776854cb3.1744783509.git.viresh.kumar@linaro.org>

On Wed, Apr 16, 2025 at 12:09:31PM +0530, Viresh Kumar wrote:
> Extend the OPP abstractions to include support for interacting with the
> cpufreq core, including the ability to retrieve frequency tables from
> OPP table.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  rust/kernel/opp.rs | 67 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index 44e11808793a..734be8b6d0ef 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -19,6 +19,12 @@
>      types::{ARef, AlwaysRefCounted, Opaque},
>  };
>  
> +#[cfg(CONFIG_CPU_FREQ)]

This config is needed quite often, it probably makes sense to move this code in
its own Rust module, i.e.:

	#[cfg(CONFIG_CPU_FREQ)]
	pub mod freq;

