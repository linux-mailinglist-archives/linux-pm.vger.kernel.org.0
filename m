Return-Path: <linux-pm+bounces-25362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61981A87C0D
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 11:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC1DE7A296B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAE825E477;
	Mon, 14 Apr 2025 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+CVztRr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DE61A83E8;
	Mon, 14 Apr 2025 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623588; cv=none; b=uiKpCvw896D6X8Et1GRB30LfxrssTjIzYVkdW3xT7yrKJLj0KO4bDL46LuKENBNk8roL9pGh+lF+tHHUTEaer4UzwVAeGAVz6a4j/ocYBOQ9KENhXirkN/hpaTdwe17hPLDYS4/LDKQV30qZz2LVoULajqEKkecA/g/5yDrObRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623588; c=relaxed/simple;
	bh=Q6Id2DVIQ7WpykunC2Xl8NGlRgFxTtQAEK5zrDFV/ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vzmz3QTtyGBB1pnefpPwHwiil765GRYQoaBWiHqVnKRxGQqyl1iwW0VRWg2GcXkcJfmRt0HV4AKMand+4Va7cQ1Dmjuv2KEIY6MXYXqX1hIcX2Gfy3L0/LMPxn0l/DXx3ZOVHcx1Bdto919RfKO7cdRVxQyC0BJZ81bXoQy1kdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+CVztRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8DAC4CEE2;
	Mon, 14 Apr 2025 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744623587;
	bh=Q6Id2DVIQ7WpykunC2Xl8NGlRgFxTtQAEK5zrDFV/ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+CVztRrQnagwjDinqiMcWRFOAHLL6VxKCU8uuwqNDAIIkZoyFiz74af9erCrBBvZ
	 lRNGVA//ZDhlzE4PkimCN9wrOJp/qsYxbfhdNjEljlcmc8t8BXLavpGQs4ZxKWUQTq
	 v/sGSW5e5eC568e6EWMtIcxdn5MDyOuGeZCHEt3H9nM8KgxCsTL7/2+carytFFA287
	 UKkVwegZyCoYDdioS0lB8NtS1E60hSScuDpMxF7ntdYe6QljY6ikF5kZHppQBD9Kkb
	 3DARM5Z+5gs7r9+FZynlgbwsAOOPzDNLVttK2P0dzCNh8WH/mZn66nEHzV2Wyn5lM0
	 kqu1Tg60Jcjdg==
Date: Mon, 14 Apr 2025 11:39:39 +0200
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
Message-ID: <Z_zX22N9cFmVpC_5@pollux>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
 <2f7a1331ad513b94fb47c05bf1d0f5c3fa803858.1744366572.git.viresh.kumar@linaro.org>
 <Z_kD5G3WhcYlgqmr@cassiopeiae>
 <20250414084706.rjsdaoxmug4p4e7l@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414084706.rjsdaoxmug4p4e7l@vireshk-i7>

On Mon, Apr 14, 2025 at 02:17:06PM +0530, Viresh Kumar wrote:
> On 11-04-25, 13:58, Danilo Krummrich wrote:
> > On Fri, Apr 11, 2025 at 04:25:14PM +0530, Viresh Kumar wrote:
> 
> > If no, it seems to me that you can even avoid allocating a struct cpufreq_driver
> > dynamically and make it const instead.
> 
> I am not sure if I understood your suggestion. The Registration::new()
> method still updates the instance of cpufreq_driver before passing it
> to the C cpufreq core.

See comment in the diff below.

> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 4194b9558413..9b275d4d3eb6 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -685,13 +685,14 @@ fn drop(&mut self) {
>  /// Reference: <https://docs.kernel.org/cpu-freq/cpu-drivers.html>
>  #[vtable]
>  pub trait Driver {
> -    /// Driver specific data.
> -    ///
> -    /// Corresponds to the data retrieved via the kernel's `cpufreq_get_driver_data` function.
> -    ///
> -    /// Require `Data` to implement `ForeignOwnable`. We guarantee to never move the underlying
> -    /// wrapped data structure.
> -    type Data: ForeignOwnable;
> +    /// Driver's name.
> +    const NAME: &'static CStr;
> +
> +    /// Driver's flags.
> +    const FLAGS: u16;
> +
> +    /// Boost support.
> +    const BOOST_ENABLED: bool;
>  
>      /// Policy specific data.
>      ///
> @@ -804,8 +805,8 @@ fn register_em(_policy: &mut Policy) {
>  ///
>  /// ```
>  /// use kernel::{
> -///     c_str,
>  ///     cpu, cpufreq,
> +///     c_str,
>  ///     device::Device,
>  ///     macros::vtable,
>  ///     sync::Arc,
> @@ -817,7 +818,10 @@ fn register_em(_policy: &mut Policy) {
>  ///
>  /// #[vtable]
>  /// impl cpufreq::Driver for FooDriver {
> -///     type Data = ();
> +///     const NAME: &'static CStr = c_str!("cpufreq-foo");
> +///     const FLAGS: u16 = cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV;
> +///     const BOOST_ENABLED: bool = true;
> +///
>  ///     type PData = Arc<FooDevice>;
>  ///
>  ///     fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {
> @@ -848,13 +852,7 @@ fn register_em(_policy: &mut Policy) {
>  /// }
>  ///
>  /// fn foo_probe(dev: &Device) {
> -///     cpufreq::Registration::<FooDriver>::new_foreign_owned(
> -///         dev,
> -///         c_str!("cpufreq-foo"),
> -///         (),
> -///         cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV,
> -///         true,
> -///     ).unwrap();
> +///     cpufreq::Registration::<FooDriver>::new_foreign_owned(dev).unwrap();
>  /// }
>  /// ```
>  pub struct Registration<T: Driver> {

You could define Registration<T: Driver> as

	pub struct Registration<T: Driver>(
	   NonNull<bindings::cpufreq_driver>,
	   PhantomData<T>
	);

and subsequently...

> @@ -868,13 +866,12 @@ unsafe impl<T: Driver> Sync for Registration<T> {}
>  
>  #[allow(clippy::non_send_fields_in_send_ty)]
>  // SAFETY: Registration with and unregistration from the cpufreq subsystem can happen from any
> -// thread.  Additionally, `T::Data` (which is dropped during unregistration) is `Send`, so it is
> -// okay to move `Registration` to different threads.
> +// thread.
>  unsafe impl<T: Driver> Send for Registration<T> {}
>  
>  impl<T: Driver> Registration<T> {

...add a new const of type bindings::cpufreq_driver, i.e.

	const VTABLE: bindings::cpufreq_driver = bindings::cpufreq_driver {
	   name: Self::copy_name(T::NAME),
	   boost_enabled: T::BOOST_ENABLED,
	   flags: T::FLAGS,
	   [...]
	}

	const fn copy_name(name: &'static CStr) -> [kernel::ffi::c_char; CPUFREQ_NAME_LEN] {
	   let src name.as_bytes_with_nul();
	   let mut dst = [0; CPUFREQ_NAME_LEN];
	   build_assert!(name.len() <= dst.len());

	   let mut i = 0;
	   while i < dst.len() {
	      dst[i] = src[i];
	      i += 1;
	   }

	   dst
	}

You should then be able to store a pointer of Self::VTABLE in your Registration
and and hence avoid dynamic allocation of struct cpufreq_driver.

>      /// Registers a CPU frequency driver with the cpufreq core.
> -    pub fn new(name: &'static CStr, data: T::Data, flags: u16, boost: bool) -> Result<Self> {
> +    pub fn new() -> Result<Self> {
>          // Required due to Rust 1.82's stricter handling of `unsafe` in mutable statics. The
>          // `unsafe` blocks aren't required anymore with later versions.
>          #![allow(unused_unsafe)]
> @@ -886,18 +883,18 @@ pub fn new(name: &'static CStr, data: T::Data, flags: u16, boost: bool) -> Resul
>          let drv_ref = drv.get_mut();
>  
>          // Account for the trailing null byte.
> -        let len = name.len() + 1;
> +        let len = T::NAME.len() + 1;
>          if len > drv_ref.name.len() {
>              return Err(EINVAL);
>          };
>  
> -        // SAFETY: `name` is a valid `CStr`, and we are copying it to an array of equal or larger
> -        // size.
> -        let name = unsafe { &*(name.as_bytes_with_nul() as *const [u8]) };
> +        // SAFETY: `T::NAME` is a valid `CStr`, and we are copying it to an array of equal or
> +        // larger size.
> +        let name = unsafe { &*(T::NAME.as_bytes_with_nul() as *const [u8]) };
>          drv_ref.name[..len].copy_from_slice(name);
>  
> -        drv_ref.boost_enabled = boost;
> -        drv_ref.flags = flags;
> +        drv_ref.boost_enabled = T::BOOST_ENABLED;
> +        drv_ref.flags = T::FLAGS;
>  
>          // Initialize mandatory callbacks.
>          drv_ref.init = Some(Self::init_callback);
> @@ -995,10 +992,6 @@ pub fn new(name: &'static CStr, data: T::Data, flags: u16, boost: bool) -> Resul
>              None
>          };
>  
> -        // Set driver data before registering the driver, as the cpufreq core calls few callbacks
> -        // before `cpufreq_register_driver` returns.
> -        Self::set_data(drv_ref, data)?;
> -
>          // SAFETY: It is safe to register the driver with the cpufreq core in the kernel C code.
>          to_result(unsafe { bindings::cpufreq_register_driver(drv_ref) })?;
>  
> @@ -1012,53 +1005,10 @@ pub fn new(name: &'static CStr, data: T::Data, flags: u16, boost: bool) -> Resul
>      ///
>      /// Instead the [`Registration`] is owned by [`Devres`] and will be revoked / dropped, once the
>      /// device is detached.
> -    pub fn new_foreign_owned(
> -        dev: &Device,
> -        name: &'static CStr,
> -        data: T::Data,
> -        flags: u16,
> -        boost: bool,
> -    ) -> Result<()> {
> -        Devres::new_foreign_owned(dev, Self::new(name, data, flags, boost)?, GFP_KERNEL)?;
> +    pub fn new_foreign_owned(dev: &Device) -> Result<()> {
> +        Devres::new_foreign_owned(dev, Self::new()?, GFP_KERNEL)?;
>          Ok(())
>      }
> -
> -    // Sets the `Data` for the CPU frequency driver.
> -    fn set_data(drv: &mut bindings::cpufreq_driver, data: T::Data) -> Result<()> {
> -        if drv.driver_data.is_null() {
> -            // Transfer the ownership of the data to the C code.
> -            drv.driver_data = <T::Data as ForeignOwnable>::into_foreign(data) as _;
> -            Ok(())
> -        } else {
> -            Err(EBUSY)
> -        }
> -    }
> -
> -    /// Returns borrowed `Data` previously set for the CPU frequency driver.
> -    pub fn data(&mut self) -> Option<<T::Data as ForeignOwnable>::Borrowed<'static>> {
> -        let drv = self.drv.get_mut();
> -
> -        if drv.driver_data.is_null() {
> -            None
> -        } else {
> -            // SAFETY: The data is earlier set by us from `set_data`.
> -            Some(unsafe { <T::Data as ForeignOwnable>::borrow(drv.driver_data) })
> -        }
> -    }
> -
> -    // Clears and returns the `Data` for the CPU frequency driver.
> -    fn clear_data(&mut self) -> Option<T::Data> {
> -        let drv = self.drv.get_mut();
> -
> -        if drv.driver_data.is_null() {
> -            None
> -        } else {
> -            // SAFETY: The data is earlier set by us from `set_data`.
> -            let data = Some(unsafe { <T::Data as ForeignOwnable>::from_foreign(drv.driver_data) });
> -            drv.driver_data = ptr::null_mut();
> -            data
> -        }
> -    }
>  }
>  
>  // CPU frequency driver callbacks.
> @@ -1313,8 +1263,5 @@ fn drop(&mut self) {
>  
>          // SAFETY: The driver was earlier registered from `new`.
>          unsafe { bindings::cpufreq_unregister_driver(drv) };
> -
> -        // Free data
> -        drop(self.clear_data());
>      }
>  }

