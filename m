Return-Path: <linux-pm+bounces-10694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDA092881F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 13:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC45286592
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D50F149E0B;
	Fri,  5 Jul 2024 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JG3YN9hW"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90D4149C52
	for <linux-pm@vger.kernel.org>; Fri,  5 Jul 2024 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179822; cv=none; b=kwMIoe/bulxWAbHA9DwkbLGv/noM5XmXNt4ar2NFJGfPgi5JXAzP+dQo/r80Mx1V5795/1FRa3+d9sb9Vp6CJWGiW2kTuQqAt2uLfwUVlDPSqdO0wUQn4yNObEqU6HiAmbu+av7lziPqqDA4Bd4lCCU+m3EO3nln/AmSlXmIaMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179822; c=relaxed/simple;
	bh=ALy2XMjaRq21wUDXMRtgZdlIJWtg6V1U2dZ3tiwDfhE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dVEWP1RYCZjNnCMfDMBckrSJl5pxB+KAWl5SFMU4Ts3Q6ZGe2rLgAcPzoYyMtx9HeSADCCcBBVcr28B0cbF78616gmrT/NYEGjmAZW+Lxf0KX3nExmPJQzYVO6D9U1odx45cvCai5D7/06IsAHN1fE3X7Q5Jx09TVyiW/vUyJAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JG3YN9hW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720179818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LM8oqhXjYeJdADlUxmauvnDgdtlNfhUy139keHdjAaM=;
	b=JG3YN9hWUYMoO7PNvTt8dcTFXq9c3cR3ZYhUt7xDiXC9KsihPog/GeYdgJ+3ymAe12HGE3
	Guep2/w3PTytAIt+UAAIF6DY153kE9cJIhPVTYa6UqpgC6NphibGBGuF3JjtnDu7YimdVO
	XMWBW0ug7Fjf0T/E+rf2LeWfW6ksKbo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-GVgHmgMNPwmhA9m2-aGsJA-1; Fri, 05 Jul 2024 07:43:37 -0400
X-MC-Unique: GVgHmgMNPwmhA9m2-aGsJA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4255e9f5897so11579685e9.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2024 04:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179815; x=1720784615;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LM8oqhXjYeJdADlUxmauvnDgdtlNfhUy139keHdjAaM=;
        b=uuiqxXdysQ/CDR2+NQusuX0lXgmpGbH61keUG9q0XbDwFiqo60Ueu3UI+FyiM8juGI
         tf39nRDw1rsrjZktsS5plQgzrUE4NdAnDvQyv0rJKIjCSIQBTOV9h6xml1UTG0dYZXDd
         U4g6Acjdij1EXWbFCXIt/IMvbI+oegmis5oga6RC09EL1BKHIGqYorxz5+n05VmJaMWv
         9d6LxQ1W2KVt7MJI+IhKxVxUcpbWbgzEDT7lVIeILk5SNP+aFQ73D/tnRNsnUPLKJ+md
         l5aYp6DzxiJczkJxdGuJz17aC7lGMLaWTNENYvKnLLu1h5TIX5jjf2gq4C//dfWDKEPG
         m5nA==
X-Gm-Message-State: AOJu0YzWWmhfrEwI2uaPHM4LD1dQPp7zpRZWucvlJykqV7VXdG+6yMdk
	3yEgPdwl5UTv+nha3PlaZUwPwcABROq8DEG6u8MgGyUijtPL15FGjJ/xqrWzT0u9+n6NZrWI0Ft
	vFe5RpRWS4SR7lmYhM5xnbffgElhmvXltHxz+AXbcBRVHf/Cf0fc6SBazPTkvlsmh
X-Received: by 2002:a05:600c:4da2:b0:425:7a6b:4e97 with SMTP id 5b1f17b1804b1-4264a3d77admr31802365e9.7.1720179815378;
        Fri, 05 Jul 2024 04:43:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKehtmjullDi9uAwYSRg74UxYSGZFTEHcu/fG9tLT7dv039fl2Js67daeRwkEXdaqF/sz5QA==
X-Received: by 2002:a05:600c:4da2:b0:425:7a6b:4e97 with SMTP id 5b1f17b1804b1-4264a3d77admr31802185e9.7.1720179814765;
        Fri, 05 Jul 2024 04:43:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679ac6d60dsm4168526f8f.39.2024.07.05.04.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 04:43:34 -0700 (PDT)
Message-ID: <1d0871c4-3613-492e-8f2f-3ea1b0377849@redhat.com>
Date: Fri, 5 Jul 2024 13:43:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V3 6/8] rust: Extend cpufreq bindings for driver
 registration
From: Danilo Krummrich <dakr@redhat.com>
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
 <fe1386ab-49c0-415d-8bbb-ff14b8197782@dakr.org>
Content-Language: en-US
Organization: RedHat
In-Reply-To: <fe1386ab-49c0-415d-8bbb-ff14b8197782@dakr.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/5/24 13:39, Danilo Krummrich wrote:
> On 7/3/24 09:14, Viresh Kumar wrote:
>> This extends the cpufreq bindings with bindings for registering a
>> driver.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>   rust/kernel/cpufreq.rs | 482 ++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 479 insertions(+), 3 deletions(-)
>>
>> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
>> index 6f9d34ebbcb0..66dad18f4ab6 100644
>> --- a/rust/kernel/cpufreq.rs
>> +++ b/rust/kernel/cpufreq.rs
>> @@ -9,14 +9,16 @@
>>   use crate::{
>>       bindings, clk, cpumask,
>>       device::Device,
>> -    error::{code::*, from_err_ptr, to_result, Result, VTABLE_DEFAULT_ERROR},
>> +    error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
>>       prelude::*,
>> -    types::{ARef, ForeignOwnable},
>> +    types::ForeignOwnable,
>>   };
>>   use core::{
>> +    cell::UnsafeCell,
>> +    marker::PhantomData,
>>       pin::Pin,
>> -    ptr::self,
>> +    ptr::{self, addr_of_mut},
>>   };
>>   use macros::vtable;
>> @@ -563,3 +565,477 @@ fn register_em(_policy: &mut Policy) {
>>           kernel::build_error(VTABLE_DEFAULT_ERROR)
>>       }
>>   }
>> +
>> +/// Registration of a cpufreq driver.
>> +pub struct Registration<T: Driver> {
>> +    registered: bool,
>> +    drv: UnsafeCell<bindings::cpufreq_driver>,
>> +    _p: PhantomData<T>,
>> +}
>> +
>> +// SAFETY: `Registration` doesn't offer any methods or access to fields when shared between threads
>> +// or CPUs, so it is safe to share it.
>> +unsafe impl<T: Driver> Sync for Registration<T> {}
>> +
>> +// SAFETY: Registration with and unregistration from the cpufreq subsystem can happen from any thread.
>> +// Additionally, `T::Data` (which is dropped during unregistration) is `Send`, so it is okay to move
>> +// `Registration` to different threads.
>> +#[allow(clippy::non_send_fields_in_send_ty)]
>> +unsafe impl<T: Driver> Send for Registration<T> {}
>> +
>> +impl<T: Driver> Registration<T> {
>> +    /// Creates new [`Registration`] but does not register it yet.
>> +    ///
>> +    /// It is allowed to move.
>> +    fn new() -> Result<Box<Self>> {
>> +        Ok(Box::new(
>> +            Self {
>> +                registered: false,
>> +                drv: UnsafeCell::new(bindings::cpufreq_driver::default()),
>> +                _p: PhantomData,
>> +            },
>> +            GFP_KERNEL,
>> +        )?)
>> +    }
>> +
>> +    /// Registers a cpufreq driver with the rest of the kernel.
>> +    pub fn register(
>> +        name: &'static CStr,
>> +        data: T::Data,
>> +        flags: u16,
>> +        boost: bool,
>> +    ) -> Result<Box<Self>> {
> 
> If you directly call `register` from `new` you can avoid having `Self::registered`.
> It's also a bit cleaner, once you got an instance of `Registration` it means something
> is registered, once it's dropped, it's unregistered.

Nevermind, I didn't notice `new` is private and you actually already do that. However,
this means you can drop `Self::registered`.

> 
>> +        let mut reg = Self::new()?;
>> +        let drv = reg.drv.get_mut();
>> +
>> +        // Account for the trailing null character.
>> +        let len = name.len() + 1;
>> +        if len > drv.name.len() {
>> +            return Err(EINVAL);
>> +        };
>> +
>> +        // SAFETY: `name` is a valid Cstr, and we are copying it to an array of equal or larger
>> +        // size.
>> +        let name = unsafe { &*(name.as_bytes_with_nul() as *const [u8] as *const [i8]) };
>> +        drv.name[..len].copy_from_slice(name);
>> +
>> +        drv.boost_enabled = boost;
>> +        drv.flags = flags;
>> +
>> +        // Allocate an array of 3 pointers to be passed to the C code.
>> +        let mut attr = Box::new([ptr::null_mut(); 3], GFP_KERNEL)?;
>> +        let mut next = 0;
>> +
>> +        // SAFETY: The C code returns a valid pointer here, which is again passed to the C code in
>> +        // an array.
>> +        attr[next] =
>> +            unsafe { addr_of_mut!(bindings::cpufreq_freq_attr_scaling_available_freqs) as *mut _ };
>> +        next += 1;
>> +
>> +        if boost {
>> +            // SAFETY: The C code returns a valid pointer here, which is again passed to the C code
>> +            // in an array.
>> +            attr[next] =
>> +                unsafe { addr_of_mut!(bindings::cpufreq_freq_attr_scaling_boost_freqs) as *mut _ };
>> +            next += 1;
>> +        }
>> +        attr[next] = ptr::null_mut();
>> +
>> +        // Pass the ownership of the memory block to the C code. This will be freed when
>> +        // the [`Registration`] object goes out of scope.
>> +        drv.attr = Box::leak(attr) as *mut _;
>> +
>> +        // Initialize mandatory callbacks.
>> +        drv.init = Some(Self::init_callback);
>> +        drv.verify = Some(Self::verify_callback);
>> +
>> +        // Initialize optional callbacks.
>> +        drv.setpolicy = if T::HAS_SETPOLICY {
>> +            Some(Self::setpolicy_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.target = if T::HAS_TARGET {
>> +            Some(Self::target_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.target_index = if T::HAS_TARGET_INDEX {
>> +            Some(Self::target_index_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.fast_switch = if T::HAS_FAST_SWITCH {
>> +            Some(Self::fast_switch_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.adjust_perf = if T::HAS_ADJUST_PERF {
>> +            Some(Self::adjust_perf_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.get_intermediate = if T::HAS_GET_INTERMEDIATE {
>> +            Some(Self::get_intermediate_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.target_intermediate = if T::HAS_TARGET_INTERMEDIATE {
>> +            Some(Self::target_intermediate_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.get = if T::HAS_GET {
>> +            Some(Self::get_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.update_limits = if T::HAS_UPDATE_LIMITS {
>> +            Some(Self::update_limits_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.bios_limit = if T::HAS_BIOS_LIMIT {
>> +            Some(Self::bios_limit_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.online = if T::HAS_ONLINE {
>> +            Some(Self::online_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.offline = if T::HAS_OFFLINE {
>> +            Some(Self::offline_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.exit = if T::HAS_EXIT {
>> +            Some(Self::exit_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.suspend = if T::HAS_SUSPEND {
>> +            Some(Self::suspend_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.resume = if T::HAS_RESUME {
>> +            Some(Self::resume_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.ready = if T::HAS_READY {
>> +            Some(Self::ready_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.set_boost = if T::HAS_SET_BOOST {
>> +            Some(Self::set_boost_callback)
>> +        } else {
>> +            None
>> +        };
>> +        drv.register_em = if T::HAS_REGISTER_EM {
>> +            Some(Self::register_em_callback)
>> +        } else {
>> +            None
>> +        };
>> +
>> +        // Set driver data before registering the driver, as the cpufreq core may call few
>> +        // callbacks before `cpufreq_register_driver()` returns.
>> +        reg.set_data(data)?;
>> +
>> +        // SAFETY: It is safe to register the driver with the cpufreq core in the C code.
>> +        to_result(unsafe { bindings::cpufreq_register_driver(reg.drv.get()) })?;
>> +        reg.registered = true;
>> +        Ok(reg)
>> +    }
>> +
>> +    /// Returns the previous set data for a cpufreq driver.
>> +    pub fn data<D: ForeignOwnable>() -> Option<<D>::Borrowed<'static>> {
>> +        // SAFETY: The driver data is earlier set by us from [`set_data()`].
>> +        let data = unsafe { bindings::cpufreq_get_driver_data() };
>> +        if data.is_null() {
>> +            None
>> +        } else {
>> +            // SAFETY: The driver data is earlier set by us from [`set_data()`].
>> +            Some(unsafe { D::borrow(data) })
>> +        }
>> +    }
>> +
>> +    // Sets the data for a cpufreq driver.
>> +    fn set_data(&mut self, data: T::Data) -> Result<()> {
>> +        let drv = self.drv.get_mut();
>> +
>> +        if drv.driver_data.is_null() {
>> +            // Pass the ownership of the data to the foreign interface.
>> +            drv.driver_data = <T::Data as ForeignOwnable>::into_foreign(data) as _;
>> +            Ok(())
>> +        } else {
>> +            Err(EBUSY)
>> +        }
>> +    }
>> +
>> +    // Clears and returns the data for a cpufreq driver.
>> +    fn clear_data(&mut self) -> Option<T::Data> {
>> +        let drv = self.drv.get_mut();
>> +
>> +        if drv.driver_data.is_null() {
>> +            None
>> +        } else {
>> +            // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
>> +            // relinquish it now.
>> +            let data = Some(unsafe { <T::Data as ForeignOwnable>::from_foreign(drv.driver_data) });
>> +            drv.driver_data = ptr::null_mut();
>> +            data
>> +        }
>> +    }
>> +}
>> +
>> +// cpufreq driver callbacks.
>> +impl<T: Driver> Registration<T> {
>> +    // Policy's init callback.
>> +    extern "C" fn init_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +            // `ptr`.
>> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
>> +
>> +            let data = T::init(&mut policy)?;
>> +            policy.set_data(data)?;
>> +            Ok(0)
>> +        })
>> +    }
>> +
>> +    // Policy's exit callback.
>> +    extern "C" fn exit_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +            // `ptr`.
>> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
>> +
>> +            let data = policy.clear_data();
>> +            T::exit(&mut policy, data).map(|_| 0)
>> +        })
>> +    }
>> +
>> +    // Policy's online callback.
>> +    extern "C" fn online_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +            // `ptr`.
>> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
>> +            T::online(&mut policy).map(|_| 0)
>> +        })
>> +    }
>> +
>> +    // Policy's offline callback.
>> +    extern "C" fn offline_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +            // `ptr`.
>> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
>> +            T::offline(&mut policy).map(|_| 0)
>> +        })
>> +    }
>> +
>> +    // Policy's suspend callback.
>> +    extern "C" fn suspend_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +            // `ptr`.
>> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
>> +            T::suspend(&mut policy).map(|_| 0)
>> +        })
>> +    }
>> +
>> +    // Policy's resume callback.
>> +    extern "C" fn resume_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +            // `ptr`.
>> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
>> +            T::resume(&mut policy).map(|_| 0)
>> +        })
>> +    }
>> +
>> +    // Policy's ready callback.
>> +    extern "C" fn ready_callback(ptr: *mut bindings::cpufreq_policy) {
>> +        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +        // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +        // `ptr`.
>> +        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
>> +        T::ready(&mut policy);
>> +    }
>> +
>> +    // Policy's verify callback.
>> +    extern "C" fn verify_callback(ptr: *mut bindings::cpufreq_policy_data) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +            // `ptr`.
>> +            let mut data = unsafe { PolicyData::from_raw_policy_data(ptr) };
>> +            T::verify(&mut data).map(|_| 0)
>> +        })
>> +    }
>> +
>> +    // Policy's setpolicy callback.
>> +    extern "C" fn setpolicy_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +            // `ptr`.
>> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
>> +            T::setpolicy(&mut policy).map(|_| 0)
>> +        })
>> +    }
>> +
>> +    // Policy's target callback.
>> +    extern "C" fn target_callback(
>> +        ptr: *mut bindings::cpufreq_policy,
>> +        target_freq: u32,
>> +        relation: u32,
>> +    ) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +            // `ptr`.
>> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
>> +            T::target(&mut policy, target_freq, Relation::new(relation)?).map(|_| 0)
>> +        })
>> +    }
>> +
>> +    // Policy's target_index callback.
>> +    extern "C" fn target_index_callback(
>> +        ptr: *mut bindings::cpufreq_policy,
>> +        index: u32,
>> +    ) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +            // `ptr`.
>> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
>> +            T::target_index(&mut policy, index).map(|_| 0)
>> +        })
>> +    }
>> +
>> +    // Policy's fast_switch callback.
>> +    extern "C" fn fast_switch_callback(
>> +        ptr: *mut bindings::cpufreq_policy,
>> +        target_freq: u32,
>> +    ) -> core::ffi::c_uint {
>> +        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +        // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +        // `ptr`.
>> +        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
>> +        T::fast_switch(&mut policy, target_freq)
>> +    }
>> +
>> +    // Policy's adjust_perf callback.
>> +    extern "C" fn adjust_perf_callback(cpu: u32, min_perf: u64, target_perf: u64, capacity: u64) {
>> +        if let Ok(mut policy) = Policy::from_cpu(cpu) {
>> +            T::adjust_perf(&mut policy, min_perf, target_perf, capacity);
>> +        }
>> +    }
>> +
>> +    // Policy's get_intermediate callback.
>> +    extern "C" fn get_intermediate_callback(
>> +        ptr: *mut bindings::cpufreq_policy,
>> +        index: u32,
>> +    ) -> core::ffi::c_uint {
>> +        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +        // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +        // `ptr`.
>> +        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
>> +        T::get_intermediate(&mut policy, index)
>> +    }
>> +
>> +    // Policy's target_intermediate callback.
>> +    extern "C" fn target_intermediate_callback(
>> +        ptr: *mut bindings::cpufreq_policy,
>> +        index: u32,
>> +    ) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +            // `ptr`.
>> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
>> +            T::target_intermediate(&mut policy, index).map(|_| 0)
>> +        })
>> +    }
>> +
>> +    // Policy's get callback.
>> +    extern "C" fn get_callback(cpu: u32) -> core::ffi::c_uint {
>> +        // SAFETY: Get the policy for a CPU.
>> +        Policy::from_cpu(cpu).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
>> +    }
>> +
>> +    // Policy's update_limit callback.
>> +    extern "C" fn update_limits_callback(cpu: u32) {
>> +        // SAFETY: Get the policy for a CPU.
>> +        if let Ok(mut policy) = Policy::from_cpu(cpu) {
>> +            T::update_limits(&mut policy);
>> +        }
>> +    }
>> +
>> +    // Policy's bios_limit callback.
>> +    extern "C" fn bios_limit_callback(cpu: i32, limit: *mut u32) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            let mut policy = Policy::from_cpu(cpu as u32)?;
>> +
>> +            // SAFETY: The pointer is guaranteed by the C code to be valid.
>> +            T::bios_limit(&mut policy, &mut (unsafe { *limit })).map(|_| 0)
>> +        })
>> +    }
>> +
>> +    // Policy's set_boost callback.
>> +    extern "C" fn set_boost_callback(
>> +        ptr: *mut bindings::cpufreq_policy,
>> +        state: i32,
>> +    ) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +            // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +            // `ptr`.
>> +            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
>> +            T::set_boost(&mut policy, state).map(|_| 0)
>> +        })
>> +    }
>> +
>> +    // Policy's register_em callback.
>> +    extern "C" fn register_em_callback(ptr: *mut bindings::cpufreq_policy) {
>> +        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
>> +        // duration of this call, so it is guaranteed to remain alive for the lifetime of
>> +        // `ptr`.
>> +        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
>> +        T::register_em(&mut policy);
>> +    }
>> +}
>> +
>> +impl<T: Driver> Drop for Registration<T> {
>> +    // Removes the registration from the kernel if it has completed successfully before.
>> +    fn drop(&mut self) {
>> +        pr_info!("Registration dropped\n");
>> +        let drv = self.drv.get_mut();
>> +
>> +        if self.registered {
>> +            // SAFETY: The driver was earlier registered from `register()`.
>> +            unsafe { bindings::cpufreq_unregister_driver(drv) };
>> +        }
>> +
>> +        // Free the previously leaked memory to the C code.
>> +        if !drv.attr.is_null() {
>> +            // SAFETY: The pointer was earlier initialized from the result of `Box::leak`.
>> +            unsafe { drop(Box::from_raw(drv.attr)) };
>> +        }
>> +
>> +        // Free data
>> +        drop(self.clear_data());
>> +    }
>> +}


