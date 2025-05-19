Return-Path: <linux-pm+bounces-27340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F82ABBBF0
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 13:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F68F3B1712
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 11:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE842741A1;
	Mon, 19 May 2025 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuhIXdxa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C3726D4EF;
	Mon, 19 May 2025 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747652819; cv=none; b=tEJypwOHpRrD6kVABl4+Fe5kaOrIjjrqPWaB5Hlwio8FG9adbyQPF81ywxoDxlTlLXydlS8IvyO88nSdoKrwsjYu0PWTYQwTeWRpPTzfk4RAAHACNNi2t0ZelpmRPRRxiNQ5SjeAFhjT6BrABaK98gAWx4rQdFEGY35coSptuO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747652819; c=relaxed/simple;
	bh=QW6b2iPr1kIC6mJxbCjvYl2N57UynhfAeMer3vkWIAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgRNJWfb0drH13D/nTrENiBoNTh7bOtG5lKm99GXTsuJGPBBzLPyqdO3xkL9KchQ98OX282LBJELr3JsEqUF4u39yKXGZZjMNctVOdmundcKevqGUw8ukRxwlTIU/p9vEKh5AhunckYuHJSQz/Irq/TiK26ew2YRezqLPNPNn/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuhIXdxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A038C4CEEB;
	Mon, 19 May 2025 11:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747652818;
	bh=QW6b2iPr1kIC6mJxbCjvYl2N57UynhfAeMer3vkWIAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BuhIXdxakTY1pYyP0h9EYlDjkftNK2yF2RT5R1m5fJFV/cyYtxCauwCEJ1wgdWEmB
	 L+doYZLJnMrYA4uNiPnzlim3/rRaLR+3BpBYYGhx5vf2vywCuqBQsp4Jzha6VtOog4
	 dzCUNXuCoTU3jjTpx2898tHtA+g+IjH5carTbwqcDiGnpuxgdKPpUeVbdv7VKNn5Y6
	 zRhRj5PtPtbT+aBCeSGbsEHyuVBmKLbbMk83Wz3himg43IKctQNZbm86vygEvwLNtn
	 ACpudJeRajJ2TMzOnpihwAnCF8yUdm4j5eHVvlEExnz/WB3CA8e+PpYvmBzWF7/BOe
	 m+FAPlrbuL7Ig==
Date: Mon, 19 May 2025 13:06:50 +0200
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
	Andrew Ballance <andrewjballance@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V12 13/15] rust: cpufreq: Extend abstractions for driver
 registration
Message-ID: <aCsQylyW7R5rC15m@pollux>
References: <cover.1747634382.git.viresh.kumar@linaro.org>
 <68906d67109c3b323b54469fb1ee44e10c1c5b1e.1747634382.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68906d67109c3b323b54469fb1ee44e10c1c5b1e.1747634382.git.viresh.kumar@linaro.org>

On Mon, May 19, 2025 at 12:37:18PM +0530, Viresh Kumar wrote:
> +/// CPU frequency driver Registration.
> +///
> +/// ## Examples
> +///
> +/// The following example demonstrates how to register a cpufreq driver.
> +///
> +/// ```
> +/// use kernel::{
> +///     cpu, cpufreq,
> +///     c_str,
> +///     device::{Bound, Device},
> +///     macros::vtable,
> +///     sync::Arc,
> +/// };
> +/// struct FooDevice;
> +///
> +/// #[derive(Default)]
> +/// struct FooDriver;
> +///
> +/// #[vtable]
> +/// impl cpufreq::Driver for FooDriver {
> +///     const NAME: &'static CStr = c_str!("cpufreq-foo");
> +///     const FLAGS: u16 = cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV;
> +///     const BOOST_ENABLED: bool = true;
> +///
> +///     type PData = Arc<FooDevice>;
> +///
> +///     fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {
> +///         // Initialize here
> +///         Ok(Arc::new(FooDevice, GFP_KERNEL)?)
> +///     }
> +///
> +///     fn exit(_policy: &mut cpufreq::Policy, _data: Option<Self::PData>) -> Result<()> {

This can just be `Result`, here and below.

> +///         Ok(())
> +///     }
> +///
> +///     fn suspend(policy: &mut cpufreq::Policy) -> Result<()> {
> +///         policy.generic_suspend()
> +///     }
> +///
> +///     fn verify(data: &mut cpufreq::PolicyData) -> Result<()> {
> +///         data.generic_verify()
> +///     }
> +///
> +///     fn target_index(policy: &mut cpufreq::Policy, index: cpufreq::TableIndex) -> Result<()> {
> +///         // Update CPU frequency
> +///         Ok(())
> +///     }
> +///
> +///     fn get(policy: &mut cpufreq::Policy) -> Result<u32> {
> +///         policy.generic_get()
> +///     }
> +/// }
> +///
> +/// fn foo_probe(dev: &Device<Bound>) {

You could use a real probe function, e.g. from platform:

	# struct Driver;
	
	impl platform::Driver for SampleDriver {
	   # type IdInfo = ();
	   # const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
	
	   fn probe(
	      pdev: &platform::Device<Core>,
	      info: Option<&Self::IdInfo>,
	   ) -> Result<Pin<KBox<Self>>> {
	      ...
	   }
	}

> +///     cpufreq::Registration::<FooDriver>::new_foreign_owned(dev).unwrap();

I prefer if we do not use unwrap() in doctests, since they also serve as example
and people might think that calling unwrap() is valid thing to do.

Sorry, I didn't catch the above in my previous review -- fine for me if you do
those improvements in a subsequent patch.

