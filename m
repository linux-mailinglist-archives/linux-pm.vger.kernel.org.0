Return-Path: <linux-pm+bounces-25530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C278A8B4B0
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 11:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53D7189FDA8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 09:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A1123535C;
	Wed, 16 Apr 2025 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0IC2f4t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313FE233716;
	Wed, 16 Apr 2025 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794297; cv=none; b=uaxGC15FoPLmWkKh6/FZsQeuJWNcma+uPN3LbkU4Fbxb76YT1dIrvmEYCNlGk+J61x1hPXT1ew3wITtYRSGCvGBW+TFR3YmX5TRhahmF8KdKxe5ZmsulE7CbsQ7QFw5pBtZ22pOTjxKsARuUmgkOO/EC/zycLalCehQ1tdYLOVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794297; c=relaxed/simple;
	bh=A6WZgNiIb4syhwkDfNA9r5Yvwb5kihYCAGvRmu8Yqb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Heu6o5BlI3xsqyUrlMY5RRHnmlHqYJAw2YbNhePE7G+brsJdVLHGrjS0ZONF9R7ug7q3kwVX2VOMeBicrI11vi/XnLSL2VTT+j50FEL4XzfUZPN4IlOHMH1T+/HClyv3Skrw8K6tSd+wrD8XVpIhTrYz18eXd8y6dwTJi579oXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0IC2f4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26B4C4CEE2;
	Wed, 16 Apr 2025 09:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744794296;
	bh=A6WZgNiIb4syhwkDfNA9r5Yvwb5kihYCAGvRmu8Yqb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0IC2f4tQsNz/MeXnNyyuBK9Kgucvlr9GWSVK8wnmRtdXWCKRWXRXcayeSjHhhIb0
	 vchPb0hjZgQFvGyzJv4GqtkKZ8YwfSGLs8F4nUvd/2FQfwCRwjQyxUWmif4pE8Seke
	 Lc1uJOnKUK8GIi90IaFcMR7GkWds2O+HWTKKFvMjF+xS21NPCD/+TxzMHsJIaotZbd
	 nI+YS6Hpaq5vZHXVHIGWhBxp1/cU19KdFkN7epFWsPcSxXaxPNbj6LH7hbhVlUFtdC
	 YgGp4BG6m3Gzk6bUf8/JPEG/ewMslZRujuthfBNO1HABy9DWf8as4SV/YnPZXRk4nU
	 8DFPqShRn0mFA==
Date: Wed, 16 Apr 2025 11:04:48 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 13/15] rust: cpufreq: Extend abstractions for driver
 registration
Message-ID: <Z_9ysHFmvZvaoe8H@pollux>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
 <8d04ef19d7a16610dbf0dfb5c9a611c6e1e3e318.1744783509.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d04ef19d7a16610dbf0dfb5c9a611c6e1e3e318.1744783509.git.viresh.kumar@linaro.org>

On Wed, Apr 16, 2025 at 12:09:30PM +0530, Viresh Kumar wrote:
> +    /// Registers a CPU frequency driver with the cpufreq core.
> +    pub fn new() -> Result<Self> {
> +        let drv: *const bindings::cpufreq_driver = &Self::VTABLE;
> +        let drv = drv.cast_mut();
> +
> +        // SAFETY: It is safe to register the driver with the cpufreq core in the kernel C code.
> +        to_result(unsafe { bindings::cpufreq_register_driver(drv) })?;

You need to justify why drv is a valid pointer to be passed to
cpufreq_register_driver(), i.e. something like

	// SAFETY:
	// - `drv` comes from Self::VTABLE and hence is a valid pointer to a `struct cpufreq_driver`,
	// - `cpufreq_register_driver()` never attempts to modify the data `drv` points to

> +
> +        Ok(Self(
> +            NonNull::new(drv.cast()).ok_or(AllocError)?,

We know `drv` can't be NULL, hence it's better to use NonNull::new_unchecked().

> +            PhantomData,
> +        ))
> +    }
> +
> +    /// Same as [`Registration::new`], but does not return a [`Registration`] instance.
> +    ///
> +    /// Instead the [`Registration`] is owned by [`Devres`] and will be revoked / dropped, once the
> +    /// device is detached.
> +    pub fn new_foreign_owned(dev: &Device) -> Result<()> {
> +        Devres::new_foreign_owned(dev, Self::new()?, GFP_KERNEL)?;

If you remove the question mark operator and the semicolon, you can remove the
below.

> +        Ok(())
> +    }
> +}

<snip>

> +impl<T: Driver> Drop for Registration<T> {
> +    // Removes the `Registration` from the kernel, if it has initialized successfully earlier.
> +    fn drop(&mut self) {
> +        // SAFETY: The driver was earlier registered from `new`.

Should be similar to the safety comment in Self::new().

> +        unsafe { bindings::cpufreq_unregister_driver(self.0.as_ptr()) };
> +    }
> +}

With those fixed,

	Reviewed-by: Danilo Krummrich <dakr@kernel.org>

