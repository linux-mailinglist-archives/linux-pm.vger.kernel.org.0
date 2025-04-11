Return-Path: <linux-pm+bounces-25240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6452AA85AF9
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 13:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8892244533C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA382BE7D2;
	Fri, 11 Apr 2025 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RKiz/d2g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411F2989A6
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369198; cv=none; b=bMAv+R19jgrFfzMskCDnzU2aY68H2547a3qifqnP8lTueVK/osybQijqSj+wSRtouRmIE1dU7lSqhuuc2PO00eQzD1n3CSbcYRKG101NAmfri7odRRbxjL7lHGFXPD5GCW4mBRIf0YzTdggTlAhadeIjKEjaK4XSgmxfsNm2AE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369198; c=relaxed/simple;
	bh=x9ocZuCMF6s1tLJISfuyOmdKP9oOJA6RAJRtbMhG13w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hG7fIY/bhvu/M1ElqaQjGp0a9v+rWlI3WveB/vN+w/nMSOwgssl0mkZdrjx82/Zgvhj9u3S5ik8OjObd51jL4Xu4btPlZ8t4cj3k4ANqiavHFhwJbfEq+LN+dW4e7MUmFJRh6JSuF/hLWaS/5MJiUbfLgGZNxxHFWbw4/YVY8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RKiz/d2g; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736b34a71a1so2163279b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 03:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744369196; x=1744973996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8icndP/zvg1XI2+CBWAxu2KWgnBqQFP1Hmt5Q3cH4NQ=;
        b=RKiz/d2gCQT0s82PQvVOOUSxPOzKBP6CRu/jQZSmQQmNklutc5MDp20PHBp70FCrb4
         p2vWAI0gAsjUwpOkro1tOFL/FfnFGjrCKSwTbjfaGP21NW86R3f5MSOUpUYINqfFttrs
         pRQfuXN0SD0uiGawJivS0RohKy1JnadUJ3MLixwm/HDICVQ3fZrjBsyGII11sO/QnWI/
         uaI9urpUOjeuhjVJyKXczRvZoZiEqj/qf8eo1xbBUk31cKFiWrzUbdyjBeSwRYpijoKe
         fx4K/MV56YbWAK5AALzfc+DTcRD0P+kO7yw/lv/OrzQp1RtSQrzebuu0RD9vguGs5Ars
         tqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369196; x=1744973996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8icndP/zvg1XI2+CBWAxu2KWgnBqQFP1Hmt5Q3cH4NQ=;
        b=Oz9AiORPBlBuh011XN9AWR+02miEUcDl1I2+ADsobT1TmWn5XN+miv6YuwTsPBgwNc
         5PRkh88H1zEnbcd9cC4yzijI8R1f/1/gunJKg28Fsa0hztAOh/WQmnL8I1Lbn0aAgUTV
         lFUxi9Ninyec3aKOT7xa7AnnBzynyFU43nWtfy4GLXoQ5+7SNAfxDwUhf+U5ZEHHfbQ4
         FLlYOi2LLY1gSdLdzPqr5KFJUknT0JeEqr78TH2jraMx0XK2mmriTDL9o9daB7MmvInB
         tnvT6nvS8BrBtwV8i/n+z7S7dc5TqnX0Y+54CFxBtFV4DrEtGtUKeUKUeXAV5oQYi6Rf
         c40w==
X-Gm-Message-State: AOJu0YyrRQWcqZ82YgmxyTaQDUvweDiummOwyGO7nVcw0yyCBM9tMekm
	ybSQBImRsOjaQvDCAsM1eeal3sbQLwbdcbjGzRDYXFc2hvw6KvPru+sDz3eMBmg=
X-Gm-Gg: ASbGncvp+YACD+licP4K+BDilwqs1xORYkTwk9qzp5AmEsbCCT60u1//50hOEQrhgKm
	fVth+xl4Jp/7RzXMR3vXqVKm3NrGZBPn3f/ul2Ar3g7yFyiDkOPv2vowgDBA2Exlmrhu5ZsF5za
	94liTSsFEB92PB/zXqEY/njw0IDmcG4vEmagBCO433mxMzdO6V6g8n5z9VS5lc2+KKOHkgZdQMD
	zB/j7oLJqa5fY4l2rRPJY7BriDTtvJRAiAm3ePxWA9v+8nzOwNg9Fn+VLPmcV7Kv02GBYAUS+XV
	slPHk2yEFLcSd49YPaE83/nWG6l3abDFL8tyJzbcLg==
X-Google-Smtp-Source: AGHT+IHOlqPXQbP/NH5YoopqX8rs99m8OO1ecidoEx4lWwHl9VBhh51/az5okTqwk9eilX+LPwMurg==
X-Received: by 2002:a05:6a00:1147:b0:736:a638:7f9e with SMTP id d2e1a72fcca58-73bd11dc3bamr4082106b3a.8.1744369195524;
        Fri, 11 Apr 2025 03:59:55 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c62f7sm1226889b3a.65.2025.04.11.03.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 03:59:54 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 15/17] rust: cpufreq: Extend abstractions for driver registration
Date: Fri, 11 Apr 2025 16:25:14 +0530
Message-Id: <2f7a1331ad513b94fb47c05bf1d0f5c3fa803858.1744366572.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1744366571.git.viresh.kumar@linaro.org>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the cpufreq abstractions to support driver registration from
Rust.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/cpufreq.rs | 530 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 528 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 3e9ded655d46..4194b9558413 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -13,7 +13,8 @@
     clk::{Clk, Hertz},
     cpumask,
     device::Device,
-    error::{code::*, from_err_ptr, to_result, Result, VTABLE_DEFAULT_ERROR},
+    devres::Devres,
+    error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
     ffi::c_ulong,
     prelude::*,
     types::ForeignOwnable,
@@ -21,9 +22,11 @@
 };
 
 use core::{
+    cell::UnsafeCell,
+    marker::PhantomData,
     ops::{Deref, DerefMut},
     pin::Pin,
-    ptr::self,
+    ptr,
 };
 
 use macros::vtable;
@@ -792,3 +795,526 @@ fn register_em(_policy: &mut Policy) {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 }
+
+/// CPU frequency driver Registration.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to register a cpufreq driver.
+///
+/// ```
+/// use kernel::{
+///     c_str,
+///     cpu, cpufreq,
+///     device::Device,
+///     macros::vtable,
+///     sync::Arc,
+/// };
+/// struct FooDevice;
+///
+/// #[derive(Default)]
+/// struct FooDriver;
+///
+/// #[vtable]
+/// impl cpufreq::Driver for FooDriver {
+///     type Data = ();
+///     type PData = Arc<FooDevice>;
+///
+///     fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {
+///         // Initialize here
+///         Ok(Arc::new(FooDevice, GFP_KERNEL)?)
+///     }
+///
+///     fn exit(_policy: &mut cpufreq::Policy, _data: Option<Self::PData>) -> Result<()> {
+///         Ok(())
+///     }
+///
+///     fn suspend(policy: &mut cpufreq::Policy) -> Result<()> {
+///         policy.generic_suspend()
+///     }
+///
+///     fn verify(data: &mut cpufreq::PolicyData) -> Result<()> {
+///         data.generic_verify()
+///     }
+///
+///     fn target_index(policy: &mut cpufreq::Policy, index: u32) -> Result<()> {
+///         // Update CPU frequency
+///         Ok(())
+///     }
+///
+///     fn get(policy: &mut cpufreq::Policy) -> Result<u32> {
+///         policy.generic_get()
+///     }
+/// }
+///
+/// fn foo_probe(dev: &Device) {
+///     cpufreq::Registration::<FooDriver>::new_foreign_owned(
+///         dev,
+///         c_str!("cpufreq-foo"),
+///         (),
+///         cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV,
+///         true,
+///     ).unwrap();
+/// }
+/// ```
+pub struct Registration<T: Driver> {
+    drv: KBox<UnsafeCell<bindings::cpufreq_driver>>,
+    _p: PhantomData<T>,
+}
+
+// SAFETY: `Registration` doesn't offer any methods or access to fields when shared between threads
+// or CPUs, so it is safe to share it.
+unsafe impl<T: Driver> Sync for Registration<T> {}
+
+#[allow(clippy::non_send_fields_in_send_ty)]
+// SAFETY: Registration with and unregistration from the cpufreq subsystem can happen from any
+// thread.  Additionally, `T::Data` (which is dropped during unregistration) is `Send`, so it is
+// okay to move `Registration` to different threads.
+unsafe impl<T: Driver> Send for Registration<T> {}
+
+impl<T: Driver> Registration<T> {
+    /// Registers a CPU frequency driver with the cpufreq core.
+    pub fn new(name: &'static CStr, data: T::Data, flags: u16, boost: bool) -> Result<Self> {
+        // Required due to Rust 1.82's stricter handling of `unsafe` in mutable statics. The
+        // `unsafe` blocks aren't required anymore with later versions.
+        #![allow(unused_unsafe)]
+
+        let mut drv = KBox::new(
+            UnsafeCell::new(bindings::cpufreq_driver::default()),
+            GFP_KERNEL,
+        )?;
+        let drv_ref = drv.get_mut();
+
+        // Account for the trailing null byte.
+        let len = name.len() + 1;
+        if len > drv_ref.name.len() {
+            return Err(EINVAL);
+        };
+
+        // SAFETY: `name` is a valid `CStr`, and we are copying it to an array of equal or larger
+        // size.
+        let name = unsafe { &*(name.as_bytes_with_nul() as *const [u8]) };
+        drv_ref.name[..len].copy_from_slice(name);
+
+        drv_ref.boost_enabled = boost;
+        drv_ref.flags = flags;
+
+        // Initialize mandatory callbacks.
+        drv_ref.init = Some(Self::init_callback);
+        drv_ref.verify = Some(Self::verify_callback);
+
+        // Initialize optional callbacks based on the traits of `T`.
+        drv_ref.setpolicy = if T::HAS_SETPOLICY {
+            Some(Self::setpolicy_callback)
+        } else {
+            None
+        };
+        drv_ref.target = if T::HAS_TARGET {
+            Some(Self::target_callback)
+        } else {
+            None
+        };
+        drv_ref.target_index = if T::HAS_TARGET_INDEX {
+            Some(Self::target_index_callback)
+        } else {
+            None
+        };
+        drv_ref.fast_switch = if T::HAS_FAST_SWITCH {
+            Some(Self::fast_switch_callback)
+        } else {
+            None
+        };
+        drv_ref.adjust_perf = if T::HAS_ADJUST_PERF {
+            Some(Self::adjust_perf_callback)
+        } else {
+            None
+        };
+        drv_ref.get_intermediate = if T::HAS_GET_INTERMEDIATE {
+            Some(Self::get_intermediate_callback)
+        } else {
+            None
+        };
+        drv_ref.target_intermediate = if T::HAS_TARGET_INTERMEDIATE {
+            Some(Self::target_intermediate_callback)
+        } else {
+            None
+        };
+        drv_ref.get = if T::HAS_GET {
+            Some(Self::get_callback)
+        } else {
+            None
+        };
+        drv_ref.update_limits = if T::HAS_UPDATE_LIMITS {
+            Some(Self::update_limits_callback)
+        } else {
+            None
+        };
+        drv_ref.bios_limit = if T::HAS_BIOS_LIMIT {
+            Some(Self::bios_limit_callback)
+        } else {
+            None
+        };
+        drv_ref.online = if T::HAS_ONLINE {
+            Some(Self::online_callback)
+        } else {
+            None
+        };
+        drv_ref.offline = if T::HAS_OFFLINE {
+            Some(Self::offline_callback)
+        } else {
+            None
+        };
+        drv_ref.exit = if T::HAS_EXIT {
+            Some(Self::exit_callback)
+        } else {
+            None
+        };
+        drv_ref.suspend = if T::HAS_SUSPEND {
+            Some(Self::suspend_callback)
+        } else {
+            None
+        };
+        drv_ref.resume = if T::HAS_RESUME {
+            Some(Self::resume_callback)
+        } else {
+            None
+        };
+        drv_ref.ready = if T::HAS_READY {
+            Some(Self::ready_callback)
+        } else {
+            None
+        };
+        drv_ref.set_boost = if T::HAS_SET_BOOST {
+            Some(Self::set_boost_callback)
+        } else {
+            None
+        };
+        drv_ref.register_em = if T::HAS_REGISTER_EM {
+            Some(Self::register_em_callback)
+        } else {
+            None
+        };
+
+        // Set driver data before registering the driver, as the cpufreq core calls few callbacks
+        // before `cpufreq_register_driver` returns.
+        Self::set_data(drv_ref, data)?;
+
+        // SAFETY: It is safe to register the driver with the cpufreq core in the kernel C code.
+        to_result(unsafe { bindings::cpufreq_register_driver(drv_ref) })?;
+
+        Ok(Self {
+            drv,
+            _p: PhantomData,
+        })
+    }
+
+    /// Same as [`Registration::new`], but does not return a [`Registration`] instance.
+    ///
+    /// Instead the [`Registration`] is owned by [`Devres`] and will be revoked / dropped, once the
+    /// device is detached.
+    pub fn new_foreign_owned(
+        dev: &Device,
+        name: &'static CStr,
+        data: T::Data,
+        flags: u16,
+        boost: bool,
+    ) -> Result<()> {
+        Devres::new_foreign_owned(dev, Self::new(name, data, flags, boost)?, GFP_KERNEL)?;
+        Ok(())
+    }
+
+    // Sets the `Data` for the CPU frequency driver.
+    fn set_data(drv: &mut bindings::cpufreq_driver, data: T::Data) -> Result<()> {
+        if drv.driver_data.is_null() {
+            // Transfer the ownership of the data to the C code.
+            drv.driver_data = <T::Data as ForeignOwnable>::into_foreign(data) as _;
+            Ok(())
+        } else {
+            Err(EBUSY)
+        }
+    }
+
+    /// Returns borrowed `Data` previously set for the CPU frequency driver.
+    pub fn data(&mut self) -> Option<<T::Data as ForeignOwnable>::Borrowed<'static>> {
+        let drv = self.drv.get_mut();
+
+        if drv.driver_data.is_null() {
+            None
+        } else {
+            // SAFETY: The data is earlier set by us from `set_data`.
+            Some(unsafe { <T::Data as ForeignOwnable>::borrow(drv.driver_data) })
+        }
+    }
+
+    // Clears and returns the `Data` for the CPU frequency driver.
+    fn clear_data(&mut self) -> Option<T::Data> {
+        let drv = self.drv.get_mut();
+
+        if drv.driver_data.is_null() {
+            None
+        } else {
+            // SAFETY: The data is earlier set by us from `set_data`.
+            let data = Some(unsafe { <T::Data as ForeignOwnable>::from_foreign(drv.driver_data) });
+            drv.driver_data = ptr::null_mut();
+            data
+        }
+    }
+}
+
+// CPU frequency driver callbacks.
+impl<T: Driver> Registration<T> {
+    // Driver's `init` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn init_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+            // lifetime of `policy`.
+            let policy = unsafe { Policy::from_raw_mut(ptr) };
+
+            let data = T::init(policy)?;
+            policy.set_data(data)?;
+            Ok(0)
+        })
+    }
+
+    // Driver's `exit` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn exit_callback(ptr: *mut bindings::cpufreq_policy) {
+        // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+        // lifetime of `policy`.
+        let policy = unsafe { Policy::from_raw_mut(ptr) };
+
+        let data = policy.clear_data();
+        let _ = T::exit(policy, data);
+    }
+
+    // Driver's `online` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn online_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+            // lifetime of `policy`.
+            let policy = unsafe { Policy::from_raw_mut(ptr) };
+            T::online(policy).map(|()| 0)
+        })
+    }
+
+    // Driver's `offline` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn offline_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+            // lifetime of `policy`.
+            let policy = unsafe { Policy::from_raw_mut(ptr) };
+            T::offline(policy).map(|()| 0)
+        })
+    }
+
+    // Driver's `suspend` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn suspend_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+            // lifetime of `policy`.
+            let policy = unsafe { Policy::from_raw_mut(ptr) };
+            T::suspend(policy).map(|()| 0)
+        })
+    }
+
+    // Driver's `resume` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn resume_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+            // lifetime of `policy`.
+            let policy = unsafe { Policy::from_raw_mut(ptr) };
+            T::resume(policy).map(|()| 0)
+        })
+    }
+
+    // Driver's `ready` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn ready_callback(ptr: *mut bindings::cpufreq_policy) {
+        // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+        // lifetime of `policy`.
+        let policy = unsafe { Policy::from_raw_mut(ptr) };
+        T::ready(policy);
+    }
+
+    // Driver's `verify` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn verify_callback(ptr: *mut bindings::cpufreq_policy_data) -> kernel::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+            // lifetime of `policy`.
+            let data = unsafe { PolicyData::from_raw_mut(ptr) };
+            T::verify(data).map(|()| 0)
+        })
+    }
+
+    // Driver's `setpolicy` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn setpolicy_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+            // lifetime of `policy`.
+            let policy = unsafe { Policy::from_raw_mut(ptr) };
+            T::setpolicy(policy).map(|()| 0)
+        })
+    }
+
+    // Driver's `target` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn target_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        target_freq: u32,
+        relation: u32,
+    ) -> kernel::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+            // lifetime of `policy`.
+            let policy = unsafe { Policy::from_raw_mut(ptr) };
+            T::target(policy, target_freq, Relation::new(relation)?).map(|()| 0)
+        })
+    }
+
+    // Driver's `target_index` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn target_index_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        index: u32,
+    ) -> kernel::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+            // lifetime of `policy`.
+            let policy = unsafe { Policy::from_raw_mut(ptr) };
+            T::target_index(policy, index).map(|()| 0)
+        })
+    }
+
+    // Driver's `fast_switch` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn fast_switch_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        target_freq: u32,
+    ) -> kernel::ffi::c_uint {
+        // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+        // lifetime of `policy`.
+        let policy = unsafe { Policy::from_raw_mut(ptr) };
+        T::fast_switch(policy, target_freq)
+    }
+
+    // Driver's `adjust_perf` callback.
+    extern "C" fn adjust_perf_callback(
+        cpu: u32,
+        min_perf: usize,
+        target_perf: usize,
+        capacity: usize,
+    ) {
+        if let Ok(mut policy) = PolicyCpu::from_cpu(cpu) {
+            T::adjust_perf(&mut policy, min_perf, target_perf, capacity);
+        }
+    }
+
+    // Driver's `get_intermediate` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn get_intermediate_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        index: u32,
+    ) -> kernel::ffi::c_uint {
+        // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+        // lifetime of `policy`.
+        let policy = unsafe { Policy::from_raw_mut(ptr) };
+        T::get_intermediate(policy, index)
+    }
+
+    // Driver's `target_intermediate` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn target_intermediate_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        index: u32,
+    ) -> kernel::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+            // lifetime of `policy`.
+            let policy = unsafe { Policy::from_raw_mut(ptr) };
+            T::target_intermediate(policy, index).map(|()| 0)
+        })
+    }
+
+    // Driver's `get` callback.
+    extern "C" fn get_callback(cpu: u32) -> kernel::ffi::c_uint {
+        PolicyCpu::from_cpu(cpu).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
+    }
+
+    // Driver's `update_limit` callback.
+    extern "C" fn update_limits_callback(cpu: u32) {
+        if let Ok(mut policy) = PolicyCpu::from_cpu(cpu) {
+            T::update_limits(&mut policy);
+        }
+    }
+
+    // Driver's `bios_limit` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn bios_limit_callback(cpu: i32, limit: *mut u32) -> kernel::ffi::c_int {
+        from_result(|| {
+            let mut policy = PolicyCpu::from_cpu(cpu as u32)?;
+
+            // SAFETY: `limit` is guaranteed by the C code to be valid.
+            T::bios_limit(&mut policy, &mut (unsafe { *limit })).map(|()| 0)
+        })
+    }
+
+    // Driver's `set_boost` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn set_boost_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        state: i32,
+    ) -> kernel::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+            // lifetime of `policy`.
+            let policy = unsafe { Policy::from_raw_mut(ptr) };
+            T::set_boost(policy, state).map(|()| 0)
+        })
+    }
+
+    // Driver's `register_em` callback.
+    //
+    // SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn register_em_callback(ptr: *mut bindings::cpufreq_policy) {
+        // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+        // lifetime of `policy`.
+        let policy = unsafe { Policy::from_raw_mut(ptr) };
+        T::register_em(policy);
+    }
+}
+
+impl<T: Driver> Drop for Registration<T> {
+    // Removes the `Registration` from the kernel, if it has initialized successfully earlier.
+    fn drop(&mut self) {
+        let drv = self.drv.get_mut();
+
+        // SAFETY: The driver was earlier registered from `new`.
+        unsafe { bindings::cpufreq_unregister_driver(drv) };
+
+        // Free data
+        drop(self.clear_data());
+    }
+}
-- 
2.31.1.272.g89b43f80a514


