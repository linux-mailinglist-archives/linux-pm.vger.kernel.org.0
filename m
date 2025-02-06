Return-Path: <linux-pm+bounces-21470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221EFA2A80F
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 13:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A360E161AFE
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 12:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FBD22D4E5;
	Thu,  6 Feb 2025 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6MUSoaf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532622D4D9;
	Thu,  6 Feb 2025 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738843469; cv=none; b=pD32VHybTmaq9I6FvH32QYfu3S28sX0e4YWmsqYKGg7ZDHT4Z6ridyk/iuZP/VfWchPhwtfQgPL11C4qkxXG1hHo88x5zu1ljRZCcXDs0ZBHAZ8RGVyxG03RwmivW8RnR/7R8YsnoaGkGr5sLmvKArh66jGKLwR1neOwHZivbJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738843469; c=relaxed/simple;
	bh=ZxTURb/AQZuuzPwvKqOTAb8U5dIvEOQOdfrgmwiSS0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2aKZOMbF2L10ey1aqyY7OLwC0H7MDIKKH4IRKk6bqS0hTaTqol4W39RAJt8MRiooq9sLY3ApkfxxlByaOk2L+p6oBt1JZtnZymP5BxYDkYb934KekyoXnN8SnqnQrSkqP9ts4YNUlWbs8vOEGnCNSyN3UJ5QRcGUeX+BQ06xt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6MUSoaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082AAC4CEE2;
	Thu,  6 Feb 2025 12:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738843468;
	bh=ZxTURb/AQZuuzPwvKqOTAb8U5dIvEOQOdfrgmwiSS0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6MUSoafPWEyJZnuPO2y3gseqvXHxLdg2KAFM7n51H2qjatxLHnxnBeRG9RZjH5x3
	 tyo3O5432on3UIsCs+dS6QxbjQQrnMS8E43ea1LvjrTuwzP4Lwe/NyqPQ5zpepTQe+
	 PB89j+qNH6WmRhqypJLRuogfp6u+5+WeWSwMnft8Mj9JaVpIHSReOi9jKGSJhz2mlk
	 l5m0P3CATI9GQdveyrlYW+KINos95oJpuGHCDKVwvOMF4LZRWvasWsGPjyszRcxt2p
	 bYNB/pRe7NYzZfM0O7ET1NiTwKq/pmiuZ4lyVG6cXmUbQ4lcvW22GoTVleGqTt9qAT
	 iCHgTQ3jmm5cw==
Date: Thu, 6 Feb 2025 13:04:21 +0100
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 12/14] rust: Extend cpufreq bindings for driver
 registration
Message-ID: <Z6SlRZouQ-nPH2EP@pollux>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <5860ff88ff81d09838f7786507ec47a33cf16158.1738832119.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5860ff88ff81d09838f7786507ec47a33cf16158.1738832119.git.viresh.kumar@linaro.org>

On Thu, Feb 06, 2025 at 02:58:33PM +0530, Viresh Kumar wrote:
> This extends the cpufreq bindings with bindings for registering a
> driver.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  rust/kernel/cpufreq.rs | 475 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 473 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 63ea816017c0..f92259d339d3 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -9,14 +9,17 @@
>  use crate::{
>      bindings, clk, cpumask,
>      device::Device,
> -    error::{code::*, from_err_ptr, to_result, Result, VTABLE_DEFAULT_ERROR},
> +    devres::Devres,
> +    error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
>      prelude::*,
>      types::ForeignOwnable,
>  };
>  
>  use core::{
> +    cell::UnsafeCell,
> +    marker::PhantomData,
>      pin::Pin,
> -    ptr::self,
> +    ptr::{self, addr_of_mut},
>  };
>  
>  use macros::vtable;
> @@ -579,3 +582,471 @@ fn register_em(_policy: &mut Policy) {
>          build_error!(VTABLE_DEFAULT_ERROR)
>      }
>  }
> +
> +/// Registration of a cpufreq driver.
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
> +    /// Registers a cpufreq driver with the rest of the kernel.
> +    pub fn new(name: &'static CStr, data: T::Data, flags: u16, boost: bool) -> Result<Self> {
> +        let mut drv = KBox::new(
> +            UnsafeCell::new(bindings::cpufreq_driver::default()),
> +            GFP_KERNEL,
> +        )?;
> +        let drv_ref = drv.get_mut();
> +
> +        // Account for the trailing null character.
> +        let len = name.len() + 1;
> +        if len > drv_ref.name.len() {
> +            return Err(EINVAL);
> +        };
> +
> +        // SAFETY: `name` is a valid Cstr, and we are copying it to an array of equal or larger
> +        // size.
> +        let name = unsafe { &*(name.as_bytes_with_nul() as *const [u8]) };
> +        drv_ref.name[..len].copy_from_slice(name);
> +
> +        drv_ref.boost_enabled = boost;
> +        drv_ref.flags = flags;
> +
> +        // Allocate an array of 3 pointers to be passed to the C code.
> +        let mut attr = KBox::new([ptr::null_mut(); 3], GFP_KERNEL)?;
> +        let mut next = 0;
> +
> +        // SAFETY: The C code returns a valid pointer here, which is again passed to the C code in
> +        // an array.
> +        attr[next] =
> +            unsafe { addr_of_mut!(bindings::cpufreq_freq_attr_scaling_available_freqs) as *mut _ };
> +        next += 1;
> +
> +        if boost {
> +            // SAFETY: The C code returns a valid pointer here, which is again passed to the C code
> +            // in an array.
> +            attr[next] =
> +                unsafe { addr_of_mut!(bindings::cpufreq_freq_attr_scaling_boost_freqs) as *mut _ };
> +            next += 1;
> +        }
> +        attr[next] = ptr::null_mut();
> +
> +        // Pass the ownership of the memory block to the C code. This will be freed when
> +        // the [`Registration`] object goes out of scope.
> +        drv_ref.attr = KBox::leak(attr) as *mut _;

I think this should be KBox::into_raw() instead.

> +
> +        // Initialize mandatory callbacks.
> +        drv_ref.init = Some(Self::init_callback);
> +        drv_ref.verify = Some(Self::verify_callback);
> +
> +        // Initialize optional callbacks.
> +        drv_ref.setpolicy = if T::HAS_SETPOLICY {
> +            Some(Self::setpolicy_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.target = if T::HAS_TARGET {
> +            Some(Self::target_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.target_index = if T::HAS_TARGET_INDEX {
> +            Some(Self::target_index_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.fast_switch = if T::HAS_FAST_SWITCH {
> +            Some(Self::fast_switch_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.adjust_perf = if T::HAS_ADJUST_PERF {
> +            Some(Self::adjust_perf_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.get_intermediate = if T::HAS_GET_INTERMEDIATE {
> +            Some(Self::get_intermediate_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.target_intermediate = if T::HAS_TARGET_INTERMEDIATE {
> +            Some(Self::target_intermediate_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.get = if T::HAS_GET {
> +            Some(Self::get_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.update_limits = if T::HAS_UPDATE_LIMITS {
> +            Some(Self::update_limits_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.bios_limit = if T::HAS_BIOS_LIMIT {
> +            Some(Self::bios_limit_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.online = if T::HAS_ONLINE {
> +            Some(Self::online_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.offline = if T::HAS_OFFLINE {
> +            Some(Self::offline_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.exit = if T::HAS_EXIT {
> +            Some(Self::exit_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.suspend = if T::HAS_SUSPEND {
> +            Some(Self::suspend_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.resume = if T::HAS_RESUME {
> +            Some(Self::resume_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.ready = if T::HAS_READY {
> +            Some(Self::ready_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.set_boost = if T::HAS_SET_BOOST {
> +            Some(Self::set_boost_callback)
> +        } else {
> +            None
> +        };
> +        drv_ref.register_em = if T::HAS_REGISTER_EM {
> +            Some(Self::register_em_callback)
> +        } else {
> +            None
> +        };
> +
> +        // Set driver data before registering the driver, as the cpufreq core may call few
> +        // callbacks before `cpufreq_register_driver()` returns.
> +        Self::set_data(drv_ref, data)?;
> +
> +        // SAFETY: It is safe to register the driver with the cpufreq core in the C code.
> +        to_result(unsafe { bindings::cpufreq_register_driver(drv_ref) })?;
> +
> +        Ok(Self {
> +            drv,
> +            _p: PhantomData,
> +        })
> +    }

...

> +// cpufreq driver callbacks.
> +impl<T: Driver> Registration<T> {
> +    // Policy's init callback.
> +    extern "C" fn init_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {

I suggest to convert all the ffi types to kernel::ffi::*.

> +        from_result(|| {
> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for
> +            // the duration of this call, so it is guaranteed to remain alive for the lifetime of
> +            // `ptr`.
> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +
> +            let data = T::init(&mut policy)?;
> +            policy.set_data(data)?;
> +            Ok(0)
> +        })
> +    }

...

> +impl<T: Driver> Drop for Registration<T> {
> +    // Removes the registration from the kernel if it has completed successfully before.
> +    fn drop(&mut self) {
> +        pr_info!("Registration dropped\n");

This should be dropped.

> +        let drv = self.drv.get_mut();
> +
> +        // SAFETY: The driver was earlier registered from `new()`.
> +        unsafe { bindings::cpufreq_unregister_driver(drv) };
> +
> +        // Free the previously leaked memory to the C code.
> +        if !drv.attr.is_null() {
> +            // SAFETY: The pointer was earlier initialized from the result of `KBox::leak`.

Box::leak() returns a mutable reference, whereas Box::into_raw() returns a raw
pointer for exactly this purpose.

Now that I think of it, maybe Box::leak() should even be removed, since it
almost never makes any sense in the kernel.

> +            unsafe { drop(KBox::from_raw(drv.attr)) };

This could just be

let _ = unsafe { KBox::from_raw(drv.attr) };

At least drop() should not be within the unsafe block.

> +        }
> +
> +        // Free data
> +        drop(self.clear_data());

No need for drop(), but I also don't mind to be explicit.

> +    }
> +}
> -- 
> 2.31.1.272.g89b43f80a514
> 
> 

