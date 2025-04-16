Return-Path: <linux-pm+bounces-25531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A21BAA8B4EA
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 11:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCBD3BD5E7
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E692343AE;
	Wed, 16 Apr 2025 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBhlIeXD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB021A83E5;
	Wed, 16 Apr 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794858; cv=none; b=B3xtKXtczU9D2sdbHIUCq3lUR+RvNzMu715KKX3OBzrL62MKUYGRYn528xiPA2fGqHkDZz/edM6tEjft+QYd49Fhtd3VTM56jl9BPe9VMqo3MPZILugKnZVlEIybyuu22b8B5rQRE422avM9lTGxw00OdP/DmM/biePwg/7Fp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794858; c=relaxed/simple;
	bh=bw96YQlw/gduJCoxlmIz0If/N62U5EoAPohOf1NsNN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oizrBQB1XtEmHYcU8BrtYrUFkRF5VDA8jTDoLroDdX3bfc36yfcZiLMX2uJ2+kbwDKKQq3YP9l0ZzMx1QqW6IPGuQMd1SUAJMeTFxDX8/0udzusvXyWIsTq23JnwRdK85zj5my6wORunyTfuYsa4Gmiw9rlrkpHENXk0M5zkpDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBhlIeXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14441C4CEE2;
	Wed, 16 Apr 2025 09:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744794856;
	bh=bw96YQlw/gduJCoxlmIz0If/N62U5EoAPohOf1NsNN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBhlIeXDWBasquzywMYkhZ9ypU9eKj3PP0y2i/6aFyYQ5YsxpoopNg2FYBHdu5o2Q
	 hCcIN8PoQYaGdhgCUFuuVt9d7tGCSPZxQ9rmcpSYmeHEs3dziw9gxSLK2MCnytn0Qc
	 OyD1piHHvSOfJvAnHjaczsqNv222uGWtV9HWUuZOU8dTjp4CA8BX7sEJb0mwAw2QLn
	 CsDHNEAmRD9VojwI1X1B6e5oSVbiGhnCixQuHKmjvnsZ3BOJiKPjP9rQRCAOEGaAPN
	 /U8aUR+WMcmEC0DV696IlNF8cg1AKwLMjYWGGxvdQXD86ORx/8WMkmeZRbWX30HVhc
	 EFyWfEXg4IXKg==
Date: Wed, 16 Apr 2025 11:14:08 +0200
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
Subject: Re: [PATCH V10 11/15] rust: cpufreq: Add initial abstractions for
 cpufreq framework
Message-ID: <Z_904KuBhKbO738_@pollux>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
 <ac6854885277b23f100c6033fab51a080cdb70eb.1744783509.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac6854885277b23f100c6033fab51a080cdb70eb.1744783509.git.viresh.kumar@linaro.org>

On Wed, Apr 16, 2025 at 12:09:28PM +0530, Viresh Kumar wrote:
> +/// CPU frequency table.
> +///
> +/// Rust abstraction for the C `struct cpufreq_frequency_table`.
> +///
> +/// # Invariants
> +///
> +/// A [`Table`] instance always corresponds to a valid C `struct cpufreq_frequency_table`.
> +///
> +/// The callers must ensure that the `struct cpufreq_frequency_table` is valid for access and
> +/// remains valid for the lifetime of the returned reference.
> +///
> +/// ## Examples
> +///
> +/// The following example demonstrates how to read a frequency value from [`Table`].
> +///
> +/// ```
> +/// use kernel::cpufreq::Policy;
> +///
> +/// fn show_freq(policy: &Policy) {
> +///     let table = policy.freq_table().unwrap();
> +///
> +///     // SAFETY: The index values passed are correct.
> +///     unsafe {
> +///         pr_info!("The frequency at index 0 is: {:?}\n", table.freq(0).unwrap());
> +///         pr_info!("The flags at index 0 is: {}\n", table.flags(0));
> +///         pr_info!("The data at index 0 is: {}\n", table.data(0));
> +///     }
> +/// }
> +/// ```
> +#[allow(dead_code)]

Why is this needed?

> +#[repr(transparent)]
> +pub struct Table(Opaque<bindings::cpufreq_frequency_table>);
> +
> +impl Table {
> +    /// Creates a reference to an existing C `struct cpufreq_frequency_table` pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid for reading and remains valid for the lifetime
> +    /// of the returned reference.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::cpufreq_frequency_table) -> &'a Self {
> +        // SAFETY: Guaranteed by the safety requirements of the function.
> +        //
> +        // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the
> +        // lifetime of the returned reference.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Returns the raw mutable pointer to the C `struct cpufreq_frequency_table`.
> +    #[inline]
> +    pub fn as_raw(&self) -> *mut bindings::cpufreq_frequency_table {
> +        let this: *const Self = self;
> +        this.cast_mut().cast()
> +    }
> +
> +    /// Returns frequency at `index` in the [`Table`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `index` corresponds to a valid table entry.
> +    #[inline]
> +    pub unsafe fn freq(&self, index: usize) -> Result<Hertz> {
> +        // SAFETY: By the type invariant, the pointer stored in `self` is valid and `index` is
> +        // guaranteed to be valid by the safety requirements of the function.
> +        Ok(Hertz::from_khz(unsafe {
> +            (*self.as_raw().add(index)).frequency.try_into()?
> +        }))
> +    }
> +
> +    /// Returns flags at `index` in the [`Table`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `index` corresponds to a valid table entry.
> +    #[inline]
> +    pub unsafe fn flags(&self, index: usize) -> u32 {
> +        // SAFETY: By the type invariant, the pointer stored in `self` is valid and `index` is
> +        // guaranteed to be valid by the safety requirements of the function.
> +        unsafe { (*self.as_raw().add(index)).flags }
> +    }
> +
> +    /// Returns data at `index` in the [`Table`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `index` corresponds to a valid table entry.
> +    #[inline]
> +    pub unsafe fn data(&self, index: usize) -> u32 {
> +        // SAFETY: By the type invariant, the pointer stored in `self` is valid and `index` is
> +        // guaranteed to be valid by the safety requirements of the function.
> +        unsafe { (*self.as_raw().add(index)).driver_data }
> +    }

Those three functions above look like they're supposed to be used directly by
drivers, but are unsafe. :(

It looks like the reason for them being unsafe is that with only the pointer to
the struct cpufreq_frequency_table array we don't know the length of the array.

However, a Table instance seems to come from TableBox, which *does* know the
length of the KVec<bindings::cpufreq_frequency_table>. Why can't we just preserve the
length and provide a safe API?

> +}
> +
> +/// CPU frequency table owned and pinned in memory, created from a [`TableBuilder`].
> +pub struct TableBox {
> +    #[allow(dead_code)]

Why?

