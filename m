Return-Path: <linux-pm+bounces-25521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AFFA8B0A5
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 08:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B358440EBC
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 06:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3B223C8CD;
	Wed, 16 Apr 2025 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pN4f8XE3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D079A22DFB6
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 06:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785646; cv=none; b=ST+YQpVj+kF6iiMW4oDSYEfJTM0UIrnBVoLp8NFIKtJpa/SEgsCyprsj7x/wntd0/Mfp+x2V2G9pgcpOFEAQzduMPJ2DGbm2mPbc7W+/qG9GGEbI1qH6/Bg1WStxTi6NCG7t3l5NWC3sJYE5tdefrjrZljp11gHtyDX0u5mhm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785646; c=relaxed/simple;
	bh=Sr9rAuYr8ID2mLrVyqriEpQmNGbv/dVay/wcUnsNZrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=quNNtCRMU+hC/uFZ83QL/Iua9v6hr9zBkZKrKhGQVWJHtsRikGPQzIKo7cax8blNQOXFukuDC4gkXOgxhR6TgZ+87OQjswpCwS4FfGzfmNaNBnIbOa0z/tslKHVofzgaILWAYE3ZZkfMGWnxZEwGFy7qvPdDWDQ1LBbamyEXuKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pN4f8XE3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2255003f4c6so66524485ad.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 23:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744785643; x=1745390443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nra1/y1QUgh6AgleDK5Vc1vrrwimHbIG9HYBJFdcQfg=;
        b=pN4f8XE3AAP2AUk+0k3P7ww21BxPUHaP1+uEk/UT6Frdm0CpdZ8IlR+x3DS+KkyehF
         zsrsAn2PWKid1gIavzA3kewAoybBxnUb9F5hVcgKY67O2Ne9N+rezZKedLn5pL5gbbrE
         Yp6J+0X/F53m+sJnOXNohCidhiclgwqoAGY9p+QYwIz4F8amoA33D48u745FZ5n4yoiY
         IX1GorBt7VWHTmzGi3iI/B9tOuxsukiZp5qKhvrmqQKacUCaXJwrvOAqJJ5J+IU36Acj
         HGRpg4dLJkezVRBSJ7HjSkt7/gPJO/Qm1X9uMmKSv5oOGF1wBf+z/cHs0XPBD6tuTn3u
         0x7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785643; x=1745390443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nra1/y1QUgh6AgleDK5Vc1vrrwimHbIG9HYBJFdcQfg=;
        b=TKom3bnMnWe3bCsg9G46sH8FIWeh8fbdbCgAOi4PidBNFOS2PKiQCVcKfvYNT29JZb
         4a35Izq+12/97sSSlav+buoUZ7dafhnrFRMsJp9Tx9S5AVtIe/F5trgb0+FmNCsff9ja
         xNRnZdalO0tgAVh+AYQN9RNQOJrPerA6bZoZnbzz/heLQAaEyTWawNRrvrrtQUhU49qR
         trxpdwkgHkMDfNkHDJEBZ5v26V2Ww3WkBIM248Tu781LdGXNaj1rVMZUcP5JoHNQ23Bj
         4MLEb1PY0ew5HuVDH167Cp7e8fQac8yPS80awPyimjDzCA2bRKQoILhyxs7WaH7hObQl
         8RjA==
X-Gm-Message-State: AOJu0Yy6bj/Rc+CCQA8z5zC/Q8TJmPFxGnd5w7KZQEXJwxbrgbxoBhpj
	sQTjwd7LilUO8BOv5nbIPZtuXrENUuyilktVP+fslhkP+H5eRRlOdc0wM97fP5U=
X-Gm-Gg: ASbGncumZRQoqLBbd996kAmdxl1QH1A82WrlfqkUO0VjChMdGqKz63IwfMKtWXfFpHO
	lCmb1xUk1OyWyBwh4CsmqYNAGa+THDbBqUVamOkkedr3EQ7qWcXkbcrKSPaHEXCdqphqSsbt8LT
	gt1oCuWgrZWO7DUGh1+GiZGv8KbTB2+wgjCxzN+n9C2OaxZ5tRkO3T77Aa3qsYzaEnl/q+gRoTc
	pEPgxwDK3vfRL1cnt8Jv2bAjNd3aFSXVTwQcSUJwmSeGywvzZM7j2b2dTmX4OvlvH1IhOzmqbOF
	F576PXxtWJz6aZp1hBPndDei+dgNtnRnizxq1oa4lQ==
X-Google-Smtp-Source: AGHT+IHfv4TXGee8ischTd2l0mhcpY+jrfYOqJPhK7dDPNeUP1SWyHXE6UuQWPB+/HGeogEvX68lJA==
X-Received: by 2002:a17:903:1247:b0:220:ca39:d453 with SMTP id d9443c01a7336-22c358d878cmr9655275ad.17.1744785642912;
        Tue, 15 Apr 2025 23:40:42 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fa5febsm6384525ad.117.2025.04.15.23.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:40:42 -0700 (PDT)
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
Subject: [PATCH V10 13/15] rust: cpufreq: Extend abstractions for driver registration
Date: Wed, 16 Apr 2025 12:09:30 +0530
Message-Id: <8d04ef19d7a16610dbf0dfb5c9a611c6e1e3e318.1744783509.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1744783509.git.viresh.kumar@linaro.org>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
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
 rust/kernel/cpufreq.rs | 480 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 477 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index fd605921add4..87a54a8af198 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -9,24 +9,31 @@
 //! Reference: <https://docs.kernel.org/admin-guide/pm/cpufreq.html>
 
 use crate::{
+    alloc::AllocError,
     clk::{Clk, Hertz},
     cpumask,
     device::Device,
-    error::{code::*, from_err_ptr, to_result, Result, VTABLE_DEFAULT_ERROR},
-    ffi::c_ulong,
+    devres::Devres,
+    error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
+    ffi::{c_char, c_ulong},
     prelude::*,
     types::ForeignOwnable,
     types::Opaque,
 };
 
 use core::{
+    marker::PhantomData,
+    mem::MaybeUninit,
     ops::{Deref, DerefMut},
     pin::Pin,
-    ptr,
+    ptr::{self, NonNull},
 };
 
 use macros::vtable;
 
+// Maximum length of CPU frequency driver's name.
+const CPUFREQ_NAME_LEN: usize = bindings::CPUFREQ_NAME_LEN as usize;
+
 /// Default transition latency value in nanoseconds.
 pub const ETERNAL_LATENCY_NS: u32 = bindings::CPUFREQ_ETERNAL as u32;
 
@@ -801,3 +808,470 @@ fn register_em(_policy: &mut Policy) {
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
+///     cpu, cpufreq,
+///     c_str,
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
+///     const NAME: &'static CStr = c_str!("cpufreq-foo");
+///     const FLAGS: u16 = cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV;
+///     const BOOST_ENABLED: bool = true;
+///
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
+///     cpufreq::Registration::<FooDriver>::new_foreign_owned(dev).unwrap();
+/// }
+/// ```
+#[repr(transparent)]
+pub struct Registration<T: Driver>(NonNull<bindings::cpufreq_driver>, PhantomData<T>);
+
+// SAFETY: `Registration` doesn't offer any methods or access to fields when shared between threads
+// or CPUs, so it is safe to share it.
+unsafe impl<T: Driver> Sync for Registration<T> {}
+
+#[allow(clippy::non_send_fields_in_send_ty)]
+// SAFETY: Registration with and unregistration from the cpufreq subsystem can happen from any
+// thread.
+unsafe impl<T: Driver> Send for Registration<T> {}
+
+impl<T: Driver> Registration<T> {
+    const VTABLE: bindings::cpufreq_driver = bindings::cpufreq_driver {
+        name: Self::copy_name(T::NAME),
+        boost_enabled: T::BOOST_ENABLED,
+        flags: T::FLAGS,
+
+        // Initialize mandatory callbacks.
+        init: Some(Self::init_callback),
+        verify: Some(Self::verify_callback),
+
+        // Initialize optional callbacks based on the traits of `T`.
+        setpolicy: if T::HAS_SETPOLICY {
+            Some(Self::setpolicy_callback)
+        } else {
+            None
+        },
+        target: if T::HAS_TARGET {
+            Some(Self::target_callback)
+        } else {
+            None
+        },
+        target_index: if T::HAS_TARGET_INDEX {
+            Some(Self::target_index_callback)
+        } else {
+            None
+        },
+        fast_switch: if T::HAS_FAST_SWITCH {
+            Some(Self::fast_switch_callback)
+        } else {
+            None
+        },
+        adjust_perf: if T::HAS_ADJUST_PERF {
+            Some(Self::adjust_perf_callback)
+        } else {
+            None
+        },
+        get_intermediate: if T::HAS_GET_INTERMEDIATE {
+            Some(Self::get_intermediate_callback)
+        } else {
+            None
+        },
+        target_intermediate: if T::HAS_TARGET_INTERMEDIATE {
+            Some(Self::target_intermediate_callback)
+        } else {
+            None
+        },
+        get: if T::HAS_GET {
+            Some(Self::get_callback)
+        } else {
+            None
+        },
+        update_limits: if T::HAS_UPDATE_LIMITS {
+            Some(Self::update_limits_callback)
+        } else {
+            None
+        },
+        bios_limit: if T::HAS_BIOS_LIMIT {
+            Some(Self::bios_limit_callback)
+        } else {
+            None
+        },
+        online: if T::HAS_ONLINE {
+            Some(Self::online_callback)
+        } else {
+            None
+        },
+        offline: if T::HAS_OFFLINE {
+            Some(Self::offline_callback)
+        } else {
+            None
+        },
+        exit: if T::HAS_EXIT {
+            Some(Self::exit_callback)
+        } else {
+            None
+        },
+        suspend: if T::HAS_SUSPEND {
+            Some(Self::suspend_callback)
+        } else {
+            None
+        },
+        resume: if T::HAS_RESUME {
+            Some(Self::resume_callback)
+        } else {
+            None
+        },
+        ready: if T::HAS_READY {
+            Some(Self::ready_callback)
+        } else {
+            None
+        },
+        set_boost: if T::HAS_SET_BOOST {
+            Some(Self::set_boost_callback)
+        } else {
+            None
+        },
+        register_em: if T::HAS_REGISTER_EM {
+            Some(Self::register_em_callback)
+        } else {
+            None
+        },
+        // SAFETY: All zeros is a valid value for `bindings::cpufreq_driver`.
+        ..unsafe { MaybeUninit::zeroed().assume_init() }
+    };
+
+    const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
+        let src = name.as_bytes_with_nul();
+        let mut dst = [0; CPUFREQ_NAME_LEN];
+
+        build_assert!(src.len() <= CPUFREQ_NAME_LEN);
+
+        let mut i = 0;
+        while i < src.len() {
+            dst[i] = src[i];
+            i += 1;
+        }
+
+        dst
+    }
+
+    /// Registers a CPU frequency driver with the cpufreq core.
+    pub fn new() -> Result<Self> {
+        let drv: *const bindings::cpufreq_driver = &Self::VTABLE;
+        let drv = drv.cast_mut();
+
+        // SAFETY: It is safe to register the driver with the cpufreq core in the kernel C code.
+        to_result(unsafe { bindings::cpufreq_register_driver(drv) })?;
+
+        Ok(Self(
+            NonNull::new(drv.cast()).ok_or(AllocError)?,
+            PhantomData,
+        ))
+    }
+
+    /// Same as [`Registration::new`], but does not return a [`Registration`] instance.
+    ///
+    /// Instead the [`Registration`] is owned by [`Devres`] and will be revoked / dropped, once the
+    /// device is detached.
+    pub fn new_foreign_owned(dev: &Device) -> Result<()> {
+        Devres::new_foreign_owned(dev, Self::new()?, GFP_KERNEL)?;
+        Ok(())
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
+        // SAFETY: The driver was earlier registered from `new`.
+        unsafe { bindings::cpufreq_unregister_driver(self.0.as_ptr()) };
+    }
+}
-- 
2.31.1.272.g89b43f80a514


