Return-Path: <linux-pm+bounces-10695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E158B928826
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 13:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E4128622F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EBF14831F;
	Fri,  5 Jul 2024 11:46:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from hs01.dakr.org (hs01.dk-develop.de [173.249.23.66])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7965514658A;
	Fri,  5 Jul 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.23.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179991; cv=none; b=miEZZWmORGEQGY3khauzZizLQgfVgOpPSjPry6sM8QijiweuE4gr0LR6SpFo+qquV0b3uRpIziEkIJhZrVGkpshQ8n+eHaf+QZG6myDmU1FlykqYKBUE6ZEfLTCK/K/0+dn0ZK0F3Ti0df5v2ejAlk5uZRmkupnpylQwJ31r7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179991; c=relaxed/simple;
	bh=3R2MhzqWrS62U5h1nkLOH2P75ff+pAEl6NSxiIB2K4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AV+IEaTZQ/8hPR9v0gTRxQLZrE8Fbp8fy3dtnCwqaC3WDiKucuMlCFAm+BAOKgLjxSqQhIh21mayx2opGB45dSs42priIdkB72hm8k4VCjEX/DCfYXJciFPan1YoaXYbKPMIxHT0Q3mkf1rnIJ1CV05HFI7AL4w1fbD/v7lqeKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org; spf=pass smtp.mailfrom=dakr.org; arc=none smtp.client-ip=173.249.23.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dakr.org
Message-ID: <fe1386ab-49c0-415d-8bbb-ff14b8197782@dakr.org>
Date: Fri, 5 Jul 2024 13:39:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH V3 6/8] rust: Extend cpufreq bindings for driver
 registration
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
 rust-for-linux@vger.kernel.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org
References: <cover.1719990273.git.viresh.kumar@linaro.org>
 <0f8618610dde586284d8c9971b8bdf215eef0456.1719990273.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: Danilo Krummrich <me@dakr.org>
In-Reply-To: <0f8618610dde586284d8c9971b8bdf215eef0456.1719990273.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/24 09:14, Viresh Kumar wrote:
> This extends the cpufreq bindings with bindings for registering a
> driver.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   rust/kernel/cpufreq.rs | 482 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 479 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 6f9d34ebbcb0..66dad18f4ab6 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -9,14 +9,16 @@
>   use crate::{
>       bindings, clk, cpumask,
>       device::Device,
> -    error::{code::*, from_err_ptr, to_result, Result, VTABLE_DEFAULT_ERROR},
> +    error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
>       prelude::*,
> -    types::{ARef, ForeignOwnable},
> +    types::ForeignOwnable,
>   };
>   
>   use core::{
> +    cell::UnsafeCell,
> +    marker::PhantomData,
>       pin::Pin,
> -    ptr::self,
> +    ptr::{self, addr_of_mut},
>   };
>   
>   use macros::vtable;
> @@ -563,3 +565,477 @@ fn register_em(_policy: &mut Policy) {
>           kernel::build_error(VTABLE_DEFAULT_ERROR)
>       }
>   }
> +
> +/// Registration of a cpufreq driver.
> +pub struct Registration<T: Driver> {
> +    registered: bool,
> +    drv: UnsafeCell<bindings::cpufreq_driver>,
> +    _p: PhantomData<T>,
> +}
> +
> +// SAFETY: `Registration` doesn't offer any methods or access to fields when shared between threads
> +// or CPUs, so it is safe to share it.
> +unsafe impl<T: Driver> Sync for Registration<T> {}
> +
> +// SAFETY: Registration with and unregistration from the cpufreq subsystem can happen from any thread.
> +// Additionally, `T::Data` (which is dropped during unregistration) is `Send`, so it is okay to move
> +// `Registration` to different threads.
> +#[allow(clippy::non_send_fields_in_send_ty)]
> +unsafe impl<T: Driver> Send for Registration<T> {}
> +
> +impl<T: Driver> Registration<T> {
> +    /// Creates new [`Registration`] but does not register it yet.
> +    ///
> +    /// It is allowed to move.
> +    fn new() -> Result<Box<Self>> {
> +        Ok(Box::new(
> +            Self {
> +                registered: false,
> +                drv: UnsafeCell::new(bindings::cpufreq_driver::default()),
> +                _p: PhantomData,
> +            },
> +            GFP_KERNEL,
> +        )?)
> +    }
> +
> +    /// Registers a cpufreq driver with the rest of the kernel.
> +    pub fn register(
> +        name: &'static CStr,
> +        data: T::Data,
> +        flags: u16,
> +        boost: bool,
> +    ) -> Result<Box<Self>> {

If you directly call `register` from `new` you can avoid having `Self::registered`.
It's also a bit cleaner, once you got an instance of `Registration` it means something
is registered, once it's dropped, it's unregistered.

> +        let mut reg = Self::new()?;
> +        let drv = reg.drv.get_mut();
> +
> +        // Account for the trailing null character.
> +        let len = name.len() + 1;
> +        if len > drv.name.len() {
> +            return Err(EINVAL);
> +        };
> +
> +        // SAFETY: `name` is a valid Cstr, and we are copying it to an array of equal or larger
> +        // size.
> +        let name = unsafe { &*(name.as_bytes_with_nul() as *const [u8] as *const [i8]) };
> +        drv.name[..len].copy_from_slice(name);
> +
> +        drv.boost_enabled = boost;
> +        drv.flags = flags;
> +
> +        // Allocate an array of 3 pointers to be passed to the C code.
> +        let mut attr = Box::new([ptr::null_mut(); 3], GFP_KERNEL)?;
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
> +        drv.attr = Box::leak(attr) as *mut _;
> +
> +        // Initialize mandatory callbacks.
> +        drv.init = Some(Self::init_callback);
> +        drv.verify = Some(Self::verify_callback);
> +
> +        // Initialize optional callbacks.
> +        drv.setpolicy = if T::HAS_SETPOLICY {
> +            Some(Self::setpolicy_callback)
> +        } else {
> +            None
> +        };
> +        drv.target = if T::HAS_TARGET {
> +            Some(Self::target_callback)
> +        } else {
> +            None
> +        };
> +        drv.target_index = if T::HAS_TARGET_INDEX {
> +            Some(Self::target_index_callback)
> +        } else {
> +            None
> +        };
> +        drv.fast_switch = if T::HAS_FAST_SWITCH {
> +            Some(Self::fast_switch_callback)
> +        } else {
> +            None
> +        };
> +        drv.adjust_perf = if T::HAS_ADJUST_PERF {
> +            Some(Self::adjust_perf_callback)
> +        } else {
> +            None
> +        };
> +        drv.get_intermediate = if T::HAS_GET_INTERMEDIATE {
> +            Some(Self::get_intermediate_callback)
> +        } else {
> +            None
> +        };
> +        drv.target_intermediate = if T::HAS_TARGET_INTERMEDIATE {
> +            Some(Self::target_intermediate_callback)
> +        } else {
> +            None
> +        };
> +        drv.get = if T::HAS_GET {
> +            Some(Self::get_callback)
> +        } else {
> +            None
> +        };
> +        drv.update_limits = if T::HAS_UPDATE_LIMITS {
> +            Some(Self::update_limits_callback)
> +        } else {
> +            None
> +        };
> +        drv.bios_limit = if T::HAS_BIOS_LIMIT {
> +            Some(Self::bios_limit_callback)
> +        } else {
> +            None
> +        };
> +        drv.online = if T::HAS_ONLINE {
> +            Some(Self::online_callback)
> +        } else {
> +            None
> +        };
> +        drv.offline = if T::HAS_OFFLINE {
> +            Some(Self::offline_callback)
> +        } else {
> +            None
> +        };
> +        drv.exit = if T::HAS_EXIT {
> +            Some(Self::exit_callback)
> +        } else {
> +            None
> +        };
> +        drv.suspend = if T::HAS_SUSPEND {
> +            Some(Self::suspend_callback)
> +        } else {
> +            None
> +        };
> +        drv.resume = if T::HAS_RESUME {
> +            Some(Self::resume_callback)
> +        } else {
> +            None
> +        };
> +        drv.ready = if T::HAS_READY {
> +            Some(Self::ready_callback)
> +        } else {
> +            None
> +        };
> +        drv.set_boost = if T::HAS_SET_BOOST {
> +            Some(Self::set_boost_callback)
> +        } else {
> +            None
> +        };
> +        drv.register_em = if T::HAS_REGISTER_EM {
> +            Some(Self::register_em_callback)
> +        } else {
> +            None
> +        };
> +
> +        // Set driver data before registering the driver, as the cpufreq core may call few
> +        // callbacks before `cpufreq_register_driver()` returns.
> +        reg.set_data(data)?;
> +
> +        // SAFETY: It is safe to register the driver with the cpufreq core in the C code.
> +        to_result(unsafe { bindings::cpufreq_register_driver(reg.drv.get()) })?;
> +        reg.registered = true;
> +        Ok(reg)
> +    }
> +
> +    /// Returns the previous set data for a cpufreq driver.
> +    pub fn data<D: ForeignOwnable>() -> Option<<D>::Borrowed<'static>> {
> +        // SAFETY: The driver data is earlier set by us from [`set_data()`].
> +        let data = unsafe { bindings::cpufreq_get_driver_data() };
> +        if data.is_null() {
> +            None
> +        } else {
> +            // SAFETY: The driver data is earlier set by us from [`set_data()`].
> +            Some(unsafe { D::borrow(data) })
> +        }
> +    }
> +
> +    // Sets the data for a cpufreq driver.
> +    fn set_data(&mut self, data: T::Data) -> Result<()> {
> +        let drv = self.drv.get_mut();
> +
> +        if drv.driver_data.is_null() {
> +            // Pass the ownership of the data to the foreign interface.
> +            drv.driver_data = <T::Data as ForeignOwnable>::into_foreign(data) as _;
> +            Ok(())
> +        } else {
> +            Err(EBUSY)
> +        }
> +    }
> +
> +    // Clears and returns the data for a cpufreq driver.
> +    fn clear_data(&mut self) -> Option<T::Data> {
> +        let drv = self.drv.get_mut();
> +
> +        if drv.driver_data.is_null() {
> +            None
> +        } else {
> +            // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
> +            // relinquish it now.
> +            let data = Some(unsafe { <T::Data as ForeignOwnable>::from_foreign(drv.driver_data) });
> +            drv.driver_data = ptr::null_mut();
> +            data
> +        }
> +    }
> +}
> +
> +// cpufreq driver callbacks.
> +impl<T: Driver> Registration<T> {
> +    // Policy's init callback.
> +    extern "C" fn init_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +            // `ptr`.
> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +
> +            let data = T::init(&mut policy)?;
> +            policy.set_data(data)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    // Policy's exit callback.
> +    extern "C" fn exit_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +            // `ptr`.
> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +
> +            let data = policy.clear_data();
> +            T::exit(&mut policy, data).map(|_| 0)
> +        })
> +    }
> +
> +    // Policy's online callback.
> +    extern "C" fn online_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +            // `ptr`.
> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +            T::online(&mut policy).map(|_| 0)
> +        })
> +    }
> +
> +    // Policy's offline callback.
> +    extern "C" fn offline_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +            // `ptr`.
> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +            T::offline(&mut policy).map(|_| 0)
> +        })
> +    }
> +
> +    // Policy's suspend callback.
> +    extern "C" fn suspend_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +            // `ptr`.
> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +            T::suspend(&mut policy).map(|_| 0)
> +        })
> +    }
> +
> +    // Policy's resume callback.
> +    extern "C" fn resume_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +            // `ptr`.
> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +            T::resume(&mut policy).map(|_| 0)
> +        })
> +    }
> +
> +    // Policy's ready callback.
> +    extern "C" fn ready_callback(ptr: *mut bindings::cpufreq_policy) {
> +        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +        // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +        // `ptr`.
> +        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +        T::ready(&mut policy);
> +    }
> +
> +    // Policy's verify callback.
> +    extern "C" fn verify_callback(ptr: *mut bindings::cpufreq_policy_data) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +            // `ptr`.
> +            let mut data = unsafe { PolicyData::from_raw_policy_data(ptr) };
> +            T::verify(&mut data).map(|_| 0)
> +        })
> +    }
> +
> +    // Policy's setpolicy callback.
> +    extern "C" fn setpolicy_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +            // `ptr`.
> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +            T::setpolicy(&mut policy).map(|_| 0)
> +        })
> +    }
> +
> +    // Policy's target callback.
> +    extern "C" fn target_callback(
> +        ptr: *mut bindings::cpufreq_policy,
> +        target_freq: u32,
> +        relation: u32,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +            // `ptr`.
> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +            T::target(&mut policy, target_freq, Relation::new(relation)?).map(|_| 0)
> +        })
> +    }
> +
> +    // Policy's target_index callback.
> +    extern "C" fn target_index_callback(
> +        ptr: *mut bindings::cpufreq_policy,
> +        index: u32,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +            // `ptr`.
> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +            T::target_index(&mut policy, index).map(|_| 0)
> +        })
> +    }
> +
> +    // Policy's fast_switch callback.
> +    extern "C" fn fast_switch_callback(
> +        ptr: *mut bindings::cpufreq_policy,
> +        target_freq: u32,
> +    ) -> core::ffi::c_uint {
> +        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +        // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +        // `ptr`.
> +        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +        T::fast_switch(&mut policy, target_freq)
> +    }
> +
> +    // Policy's adjust_perf callback.
> +    extern "C" fn adjust_perf_callback(cpu: u32, min_perf: u64, target_perf: u64, capacity: u64) {
> +        if let Ok(mut policy) = Policy::from_cpu(cpu) {
> +            T::adjust_perf(&mut policy, min_perf, target_perf, capacity);
> +        }
> +    }
> +
> +    // Policy's get_intermediate callback.
> +    extern "C" fn get_intermediate_callback(
> +        ptr: *mut bindings::cpufreq_policy,
> +        index: u32,
> +    ) -> core::ffi::c_uint {
> +        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +        // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +        // `ptr`.
> +        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +        T::get_intermediate(&mut policy, index)
> +    }
> +
> +    // Policy's target_intermediate callback.
> +    extern "C" fn target_intermediate_callback(
> +        ptr: *mut bindings::cpufreq_policy,
> +        index: u32,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +            // `ptr`.
> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +            T::target_intermediate(&mut policy, index).map(|_| 0)
> +        })
> +    }
> +
> +    // Policy's get callback.
> +    extern "C" fn get_callback(cpu: u32) -> core::ffi::c_uint {
> +        // SAFETY: Get the policy for a CPU.
> +        Policy::from_cpu(cpu).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
> +    }
> +
> +    // Policy's update_limit callback.
> +    extern "C" fn update_limits_callback(cpu: u32) {
> +        // SAFETY: Get the policy for a CPU.
> +        if let Ok(mut policy) = Policy::from_cpu(cpu) {
> +            T::update_limits(&mut policy);
> +        }
> +    }
> +
> +    // Policy's bios_limit callback.
> +    extern "C" fn bios_limit_callback(cpu: i32, limit: *mut u32) -> core::ffi::c_int {
> +        from_result(|| {
> +            let mut policy = Policy::from_cpu(cpu as u32)?;
> +
> +            // SAFETY: The pointer is guaranteed by the C code to be valid.
> +            T::bios_limit(&mut policy, &mut (unsafe { *limit })).map(|_| 0)
> +        })
> +    }
> +
> +    // Policy's set_boost callback.
> +    extern "C" fn set_boost_callback(
> +        ptr: *mut bindings::cpufreq_policy,
> +        state: i32,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +            // `ptr`.
> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +            T::set_boost(&mut policy, state).map(|_| 0)
> +        })
> +    }
> +
> +    // Policy's register_em callback.
> +    extern "C" fn register_em_callback(ptr: *mut bindings::cpufreq_policy) {
> +        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
> +        // duration of this call, so it is guaranteed to remain alive for the lifetime of
> +        // `ptr`.
> +        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
> +        T::register_em(&mut policy);
> +    }
> +}
> +
> +impl<T: Driver> Drop for Registration<T> {
> +    // Removes the registration from the kernel if it has completed successfully before.
> +    fn drop(&mut self) {
> +        pr_info!("Registration dropped\n");
> +        let drv = self.drv.get_mut();
> +
> +        if self.registered {
> +            // SAFETY: The driver was earlier registered from `register()`.
> +            unsafe { bindings::cpufreq_unregister_driver(drv) };
> +        }
> +
> +        // Free the previously leaked memory to the C code.
> +        if !drv.attr.is_null() {
> +            // SAFETY: The pointer was earlier initialized from the result of `Box::leak`.
> +            unsafe { drop(Box::from_raw(drv.attr)) };
> +        }
> +
> +        // Free data
> +        drop(self.clear_data());
> +    }
> +}

