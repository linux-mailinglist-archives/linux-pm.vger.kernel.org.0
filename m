Return-Path: <linux-pm+bounces-25244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5E4A85C5E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 13:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3E716F848
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9F629AAEB;
	Fri, 11 Apr 2025 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvtzN8HW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDC8298CD9;
	Fri, 11 Apr 2025 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744372717; cv=none; b=SOvh7og7sve4+Iyoj0tJ6eqm3Fuob0Z8vBn9w7DodZ65W1o/9S4m83PgZY2eMHgBdQloTe3hAZSgtesl+BOAz9cbUIXkNHhuoctBC7tW+pgJuHqOWxnr7uoUsgi86NsUQMigNnsXGdpjzsq8eZipDXMIWW/FjOJq7pGctspMuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744372717; c=relaxed/simple;
	bh=ePFF4GGH8AopDjRasGCwQmpgIQb6LyuLsOSi1mcIjU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrvSrrgO/dysDoH20DhOFWz+csu6pynLt4WuTrDD1FQItTaQX4p9GF44MT3WB6VHTo91YzO3vf9RNHLL4G71+HQ8pzUXj0Sklahcg1VVPAcoqajC+exStwnTQqzmg6h9U2rkXaRy4XC/O0f8fyXNUh1G6U1kJP+iC9ON+pzAoDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvtzN8HW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB0CC4CEE2;
	Fri, 11 Apr 2025 11:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744372717;
	bh=ePFF4GGH8AopDjRasGCwQmpgIQb6LyuLsOSi1mcIjU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RvtzN8HWxAwCIvkN6HCqqxfGOxfSFf19EicjQaspg5ESxbw+SxHXeiickOJzw/hq0
	 biwAXLqZaBSVBBx26AiP6Zx1NOCsvklAw1wqJ8XWRejKgXm6wYSWNG8qAgEXdVxZGM
	 tAWH3847/h0PHRih1lnWpfxWO7gH+yM2+odo3+KUEQJaUNqeqNQnxlRX7Uy6WAB5UI
	 DkY4RrvPfP0JNUA5fTbh1qCGcxieOtjG8SX7xYp/xvNwqv5KX2xK9SrWmeURa37lb3
	 Uvy6K6jcFCsEYeLsEj6niJMNjyra0c1HBb3Qx6RPxn9b9f2OEuqevMkO4yCH1Uxt8H
	 0hBmsvi6B/t8g==
Date: Fri, 11 Apr 2025 13:58:28 +0200
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
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 15/17] rust: cpufreq: Extend abstractions for driver
 registration
Message-ID: <Z_kD5G3WhcYlgqmr@cassiopeiae>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
 <2f7a1331ad513b94fb47c05bf1d0f5c3fa803858.1744366572.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f7a1331ad513b94fb47c05bf1d0f5c3fa803858.1744366572.git.viresh.kumar@linaro.org>

On Fri, Apr 11, 2025 at 04:25:14PM +0530, Viresh Kumar wrote:
> +pub struct Registration<T: Driver> {
> +    drv: KBox<UnsafeCell<bindings::cpufreq_driver>>,
> +    _p: PhantomData<T>,
> +}
> +
> +// SAFETY: `Registration` doesn't offer any methods or access to fields when shared between threads
> +// or CPUs, so it is safe to share it.
> +unsafe impl<T: Driver> Sync for Registration<T> {}
> +
> +#[allow(clippy::non_send_fields_in_send_ty)]
> +// SAFETY: Registration with and unregistration from the cpufreq subsystem can happen from any
> +// thread.  Additionally, `T::Data` (which is dropped during unregistration) is `Send`, so it is
> +// okay to move `Registration` to different threads.
> +unsafe impl<T: Driver> Send for Registration<T> {}
> +
> +impl<T: Driver> Registration<T> {
> +    /// Registers a CPU frequency driver with the cpufreq core.
> +    pub fn new(name: &'static CStr, data: T::Data, flags: u16, boost: bool) -> Result<Self> {

Do you really need the private data? It seems to be used by only very few
drivers in C either.

If yes, I think you have to split this up into a CpufreqDriver structure and a
separate Registration. Otherwise you won't ever get access to the private data
again, after Registration::new_foreign_owned().

Note that we typically want Registration::new_foreign_owned(), because it
implies the guaranteed "fence" for where we can safely consider a device to be
bound. If we'd give out a Registration instance instead, the driver can
arbitrarily extend its lifetime across the remove() boundary.

If no, it seems to me that you can even avoid allocating a struct cpufreq_driver
dynamically and make it const instead. The fields name, boost_enabled and flags
could be required consts in your cpufreq::Driver trait.

