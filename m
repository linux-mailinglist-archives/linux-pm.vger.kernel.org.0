Return-Path: <linux-pm+bounces-25368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB67A87FB6
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 13:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD147AB306
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 11:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3783928EA4C;
	Mon, 14 Apr 2025 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1XEoHfd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0614219A298;
	Mon, 14 Apr 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631506; cv=none; b=Plv2nBVSt5tM+1hz8B6h6bniy7dPWqw+Jj93Oj9XElrrj88QPuw6eb01BfU3eEkSzn4XCp2eps2jaztCYQ+FsbRxUJ9sgf/yZF3N83anrZaQsnHjpDI/Hd94jM/20WW6qRXYxjj//6MdlsPey7swrSN6Jh2bzrVussWyYj4zUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631506; c=relaxed/simple;
	bh=zWanHeZugv5QCRW6MySKJGGKfwzVyNChhq5Nufbx1kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pML6gkQNnlUd6OOIZNHyys4iwI1haj3UQd1YI5SciqSJM/L2XFz+IpKrY/iGk25posjWNT2AOGZWBsxrFay/MnfuCN10yHhXHJKK9ou3J2EXHJTo/5dVb1bMi3cI6U57bGZh6NlGw9rBH5r2jVoEi50jO+CJ/+XGslk5bphIstc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1XEoHfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A98C4CEE2;
	Mon, 14 Apr 2025 11:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744631504;
	bh=zWanHeZugv5QCRW6MySKJGGKfwzVyNChhq5Nufbx1kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1XEoHfdnE895itpgW0LmhAH0DmPrD+6zad8v5ShEZAvjGVQGv3Xt95v6VqIeqcgr
	 EIs1OA+rJiTs92pxo4/RjIr9ptkXIyQa0OZH7Adjr95fr8cNSAY6Vcf405/4aeHcrt
	 etj/UR2rAH5PQbqfPvAHRug9Z9Qzgv7hKzQdKhWdluiC7QhxQNV6PtWNpuOGBAnwWc
	 zJ0PU9EooFyJims8SRkwE7It5lTs8txCPEqz8+0p3vaPHp08zaNDmck5TsrPUOrYTj
	 3DAyNMRxjRXVAJJInw8STsdBYsq6SzRYntpZiuUZp/yPNcNsy8CXjImKeabTtxFbmg
	 /rBi4/v7v89zw==
Date: Mon, 14 Apr 2025 13:51:36 +0200
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
Message-ID: <Z_z2yPyf3o2Rq4iA@cassiopeiae>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
 <2f7a1331ad513b94fb47c05bf1d0f5c3fa803858.1744366572.git.viresh.kumar@linaro.org>
 <Z_kD5G3WhcYlgqmr@cassiopeiae>
 <20250414084706.rjsdaoxmug4p4e7l@vireshk-i7>
 <Z_zX22N9cFmVpC_5@pollux>
 <20250414105212.glxkrto4ybvxgx3y@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414105212.glxkrto4ybvxgx3y@vireshk-i7>

On Mon, Apr 14, 2025 at 04:22:12PM +0530, Viresh Kumar wrote:
> On 14-04-25, 11:39, Danilo Krummrich wrote:
> > 	const VTABLE: bindings::cpufreq_driver = bindings::cpufreq_driver {
> > 	   name: Self::copy_name(T::NAME),
> > 	   boost_enabled: T::BOOST_ENABLED,
> > 	   flags: T::FLAGS,
> > 	   [...]
> > 	}
> 
> Ahh, thanks for this.

The diff below looks good!

One nit below.

> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 9b275d4d3eb6..a6e660d46304 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -9,28 +9,32 @@
>  //! Reference: <https://docs.kernel.org/admin-guide/pm/cpufreq.html>
>  
>  use crate::{
> +    alloc::AllocError,
>      bindings,
>      clk::{Clk, Hertz},
>      cpumask,
>      device::Device,
>      devres::Devres,
>      error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
> -    ffi::c_ulong,
> +    ffi::{c_char, c_ulong},
>      prelude::*,
>      types::ForeignOwnable,
>      types::Opaque,
>  };
>  
>  use core::{
> -    cell::UnsafeCell,
>      marker::PhantomData,
> +    mem::MaybeUninit,
>      ops::{Deref, DerefMut},
>      pin::Pin,
> -    ptr,
> +    ptr::{self, NonNull},
>  };
>  
>  use macros::vtable;
>  
> +// Maximum length of CPU frequency driver's name.
> +const CPUFREQ_NAME_LEN: usize = bindings::CPUFREQ_NAME_LEN as usize;
> +
>  /// Default transition latency value in nanoseconds.
>  pub const ETERNAL_LATENCY_NS: u32 = bindings::CPUFREQ_ETERNAL as u32;
>  
> @@ -855,10 +859,8 @@ fn register_em(_policy: &mut Policy) {
>  ///     cpufreq::Registration::<FooDriver>::new_foreign_owned(dev).unwrap();
>  /// }
>  /// ```
> -pub struct Registration<T: Driver> {
> -    drv: KBox<UnsafeCell<bindings::cpufreq_driver>>,
> -    _p: PhantomData<T>,
> -}
> +#[repr(transparent)]
> +pub struct Registration<T: Driver>(NonNull<bindings::cpufreq_driver>, PhantomData<T>);
>  
>  // SAFETY: `Registration` doesn't offer any methods or access to fields when shared between threads
>  // or CPUs, so it is safe to share it.
> @@ -870,135 +872,136 @@ unsafe impl<T: Driver> Sync for Registration<T> {}
>  unsafe impl<T: Driver> Send for Registration<T> {}
>  
>  impl<T: Driver> Registration<T> {
> -    /// Registers a CPU frequency driver with the cpufreq core.
> -    pub fn new() -> Result<Self> {
> -        // Required due to Rust 1.82's stricter handling of `unsafe` in mutable statics. The
> -        // `unsafe` blocks aren't required anymore with later versions.
> -        #![allow(unused_unsafe)]
> -
> -        let mut drv = KBox::new(
> -            UnsafeCell::new(bindings::cpufreq_driver::default()),
> -            GFP_KERNEL,
> -        )?;
> -        let drv_ref = drv.get_mut();
> -
> -        // Account for the trailing null byte.
> -        let len = T::NAME.len() + 1;
> -        if len > drv_ref.name.len() {
> -            return Err(EINVAL);
> -        };
> -
> -        // SAFETY: `T::NAME` is a valid `CStr`, and we are copying it to an array of equal or
> -        // larger size.
> -        let name = unsafe { &*(T::NAME.as_bytes_with_nul() as *const [u8]) };
> -        drv_ref.name[..len].copy_from_slice(name);
> -
> -        drv_ref.boost_enabled = T::BOOST_ENABLED;
> -        drv_ref.flags = T::FLAGS;
> +    const VTABLE: bindings::cpufreq_driver = bindings::cpufreq_driver {
> +        name: Self::copy_name(T::NAME),
> +        boost_enabled: T::BOOST_ENABLED,
> +        flags: T::FLAGS,
>  
>          // Initialize mandatory callbacks.
> -        drv_ref.init = Some(Self::init_callback);
> -        drv_ref.verify = Some(Self::verify_callback);
> +        init: Some(Self::init_callback),
> +        verify: Some(Self::verify_callback),
>  
>          // Initialize optional callbacks based on the traits of `T`.
> -        drv_ref.setpolicy = if T::HAS_SETPOLICY {
> +        setpolicy: if T::HAS_SETPOLICY {
>              Some(Self::setpolicy_callback)
>          } else {
>              None
> -        };
> -        drv_ref.target = if T::HAS_TARGET {
> +        },
> +        target: if T::HAS_TARGET {
>              Some(Self::target_callback)
>          } else {
>              None
> -        };
> -        drv_ref.target_index = if T::HAS_TARGET_INDEX {
> +        },
> +        target_index: if T::HAS_TARGET_INDEX {
>              Some(Self::target_index_callback)
>          } else {
>              None
> -        };
> -        drv_ref.fast_switch = if T::HAS_FAST_SWITCH {
> +        },
> +        fast_switch: if T::HAS_FAST_SWITCH {
>              Some(Self::fast_switch_callback)
>          } else {
>              None
> -        };
> -        drv_ref.adjust_perf = if T::HAS_ADJUST_PERF {
> +        },
> +        adjust_perf: if T::HAS_ADJUST_PERF {
>              Some(Self::adjust_perf_callback)
>          } else {
>              None
> -        };
> -        drv_ref.get_intermediate = if T::HAS_GET_INTERMEDIATE {
> +        },
> +        get_intermediate: if T::HAS_GET_INTERMEDIATE {
>              Some(Self::get_intermediate_callback)
>          } else {
>              None
> -        };
> -        drv_ref.target_intermediate = if T::HAS_TARGET_INTERMEDIATE {
> +        },
> +        target_intermediate: if T::HAS_TARGET_INTERMEDIATE {
>              Some(Self::target_intermediate_callback)
>          } else {
>              None
> -        };
> -        drv_ref.get = if T::HAS_GET {
> +        },
> +        get: if T::HAS_GET {
>              Some(Self::get_callback)
>          } else {
>              None
> -        };
> -        drv_ref.update_limits = if T::HAS_UPDATE_LIMITS {
> +        },
> +        update_limits: if T::HAS_UPDATE_LIMITS {
>              Some(Self::update_limits_callback)
>          } else {
>              None
> -        };
> -        drv_ref.bios_limit = if T::HAS_BIOS_LIMIT {
> +        },
> +        bios_limit: if T::HAS_BIOS_LIMIT {
>              Some(Self::bios_limit_callback)
>          } else {
>              None
> -        };
> -        drv_ref.online = if T::HAS_ONLINE {
> +        },
> +        online: if T::HAS_ONLINE {
>              Some(Self::online_callback)
>          } else {
>              None
> -        };
> -        drv_ref.offline = if T::HAS_OFFLINE {
> +        },
> +        offline: if T::HAS_OFFLINE {
>              Some(Self::offline_callback)
>          } else {
>              None
> -        };
> -        drv_ref.exit = if T::HAS_EXIT {
> +        },
> +        exit: if T::HAS_EXIT {
>              Some(Self::exit_callback)
>          } else {
>              None
> -        };
> -        drv_ref.suspend = if T::HAS_SUSPEND {
> +        },
> +        suspend: if T::HAS_SUSPEND {
>              Some(Self::suspend_callback)
>          } else {
>              None
> -        };
> -        drv_ref.resume = if T::HAS_RESUME {
> +        },
> +        resume: if T::HAS_RESUME {
>              Some(Self::resume_callback)
>          } else {
>              None
> -        };
> -        drv_ref.ready = if T::HAS_READY {
> +        },
> +        ready: if T::HAS_READY {
>              Some(Self::ready_callback)
>          } else {
>              None
> -        };
> -        drv_ref.set_boost = if T::HAS_SET_BOOST {
> +        },
> +        set_boost: if T::HAS_SET_BOOST {
>              Some(Self::set_boost_callback)
>          } else {
>              None
> -        };
> -        drv_ref.register_em = if T::HAS_REGISTER_EM {
> +        },
> +        register_em: if T::HAS_REGISTER_EM {
>              Some(Self::register_em_callback)
>          } else {
>              None
> -        };
> +        },
> +        // SAFETY: All zeros is a valid value for `bindings::cpufreq_driver`.
> +        ..unsafe { MaybeUninit::zeroed().assume_init() }
> +    };
> +
> +    const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
> +        let src = name.as_bytes_with_nul();
> +        let mut dst = [0; CPUFREQ_NAME_LEN];
> +
> +        build_assert!(src.len() <= CPUFREQ_NAME_LEN);
> +
> +        let mut i = 0;
> +        while i < src.len() {
> +            dst[i] = src[i];
> +            i += 1;
> +        }
> +
> +        dst
> +    }
> +
> +    /// Registers a CPU frequency driver with the cpufreq core.
> +    pub fn new() -> Result<Self> {
> +        let drv = &Self::VTABLE as *const _ as *mut _;

Hm, I didn't think of that, maybe it's better to store a *const directly instead
of a NonNull, given that VTABLE can't be altered.

Tamir is trying to clean up 'as' casts in [1]. So, I'd write this as

	let drv: *const bindings::cpufreq_driver = &Self::VTABLE;

[1] https://lore.kernel.org/rust-for-linux/20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com/

>  
>          // SAFETY: It is safe to register the driver with the cpufreq core in the kernel C code.
> -        to_result(unsafe { bindings::cpufreq_register_driver(drv_ref) })?;
> +        to_result(unsafe { bindings::cpufreq_register_driver(drv) })?;
>  
> -        Ok(Self {
> -            drv,
> -            _p: PhantomData,
> -        })
> +        Ok(Self(
> +            NonNull::new(drv.cast()).ok_or(AllocError)?,
> +            PhantomData,
> +        ))
>      }
>  
>      /// Same as [`Registration::new`], but does not return a [`Registration`] instance.
> @@ -1259,9 +1262,7 @@ extern "C" fn register_em_callback(ptr: *mut bindings::cpufreq_policy) {
>  impl<T: Driver> Drop for Registration<T> {
>      // Removes the `Registration` from the kernel, if it has initialized successfully earlier.
>      fn drop(&mut self) {
> -        let drv = self.drv.get_mut();
> -
>          // SAFETY: The driver was earlier registered from `new`.
> -        unsafe { bindings::cpufreq_unregister_driver(drv) };
> +        unsafe { bindings::cpufreq_unregister_driver(self.0.as_ptr()) };
>      }
>  }

