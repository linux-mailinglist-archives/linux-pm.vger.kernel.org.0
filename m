Return-Path: <linux-pm+bounces-8757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5598FFF01
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD4B289679
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 09:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D29A15E5CB;
	Fri,  7 Jun 2024 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gi3OhzxO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D3C15E5C0
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751582; cv=none; b=Z4Ndw78uP1tOc7dtvSisueqDzPA85deuSTe+fUhiwVbyOOwdUvMxCMcFdFUUeqzdyVljssvPbYMo11mK1eRDbZSZ1cVobBALz2au1UNWMOFStFmNmcvEG3q15J25YL/ItDu13ktbNfvrbrHnsyRAQzveieMRhfG54X7TP4LovMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751582; c=relaxed/simple;
	bh=W2KMeDxS/6WMTlM2Lf4D/UsbGwQ/V2yDMEQ0Z88lCb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4NsqH9Prq6j2tTc6XqqJP7R18L0L6vN9Vxr886BqnhlJoFgT7hg90VecyWGbsPAIXoeqGEDgu26Ia4Z+Ac3cDPDyaRmqeEkQqIyF5g2NHqp6rZHMzkVpaaumUNKBLSMnaWoEXWx5McmmYzPWdxSl5YYiz0yJrtHdKDviclm3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gi3OhzxO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6ab88dfaeso16773225ad.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717751580; x=1718356380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Tu8R/Slxi6hlXPEgui5zs0wCaeCyPbdxpusH+/PwXI=;
        b=Gi3OhzxOfNsSmNOu72xiCjYFFagClz3FVvj+sNFDbZ1PgwonuKkEhVH4g6Y2iL/ch0
         ecA9EiHtqbPdzbAHWUL7cvH7mK1K0PeK79ShLobRvkWohWprWJj4zjgXfN41t9jJ6yUM
         mSm/kqkzFPSt/yEdwnRrMliMY7kUJ5TZG9thhXdc6GPA/6aKbT7vQay+hiIzqHmTcSC7
         Owb10UElv1bmnfIAPoTrfmvoIiFeFHgRAgoekeHm4TT/TluwbCztNgfjYNvN6QZjM4dp
         1oM6GV73Yi+BYJ82xnoSOCbbnluViSkgiKXmiYGOrsMZse5x2KnVTFmlPi6OSjeXUPHD
         zjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751580; x=1718356380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Tu8R/Slxi6hlXPEgui5zs0wCaeCyPbdxpusH+/PwXI=;
        b=HPKcYyLGtsrj4QE+5Xk9mqcHQei9tRqCqCRUjQ0JJaFqbIq188N8vo5h/00dth/SIF
         GP/+wFeIWia8opw5OhY7L6ZkXxDTp/ASkjQVS/6fdCRYR2DnhSfHFe07f4oCY7sBVJ6Z
         DdqeeHBVdt87aSTXm+A+6tJ/bm7KnG1Utqz8qNQtTr/uXHT4xhzXuagCwA42dJyEQ5iY
         fkSRRZIJ2TIu9+VxIlZucgoWb+3YLAAWjnBXPf7+8a/0siQeSLoikxZ+/XnlkQjWeI1e
         iutu6rM0UB+lGsSzM9AqVV9lonHR8Ex7tS/suc4xEbopyUAxGEoZYnBUu3TR5VyRxUMB
         /JRw==
X-Forwarded-Encrypted: i=1; AJvYcCX7rPp6suUUNpm1QhaJKXyn0fGuKFZNS0yvVz9HrLm2W0na9DfI3qUqzx37rEx9g7Zceu7G9zKcdTs8Plx2hxqjHm31ek5OInk=
X-Gm-Message-State: AOJu0Yzd447pyOr1ZZ7ZDn/oLJJgk9dqNBGGLBRRXfdSSj4zWpxTLXKo
	ictH+4+Mh9L8MGa0sIi/tSRT5llh9eplJ/2mhFruDXYQv4y4i/huibYh1GJ8AOc=
X-Google-Smtp-Source: AGHT+IEFCeDDBxW2kS7vIkDgT3DwtVxB5zwC8xpWpKFjFRtfPknZNd6Uts92pNL6c/BZcWFUSdI6Dg==
X-Received: by 2002:a17:902:db05:b0:1f6:6ae5:1410 with SMTP id d9443c01a7336-1f6d03c8d5emr20219555ad.64.1717751579255;
        Fri, 07 Jun 2024 02:12:59 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd761660sm29380525ad.53.2024.06.07.02.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:12:58 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH V2 6/8] rust: Extend cpufreq bindings for driver registration
Date: Fri,  7 Jun 2024 14:42:21 +0530
Message-Id: <ec8ea3f68df07330203b58920f07fb166aecf232.1717750631.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1717750631.git.viresh.kumar@linaro.org>
References: <cover.1717750631.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This extends the cpufreq bindings with bindings for registering a
driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/cpufreq.rs | 492 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 490 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index d5679272e40b..76eba63b6716 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -9,14 +9,16 @@
 use crate::{
     bindings, clk, cpumask,
     device::Device,
-    error::{code::*, from_err_ptr, to_result, Result, VTABLE_DEFAULT_ERROR},
+    error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
     prelude::*,
     types::{ARef, ForeignOwnable},
 };
 
 use core::{
+    cell::UnsafeCell,
+    marker::{PhantomData, PhantomPinned},
     pin::Pin,
-    ptr::self,
+    ptr::{self, addr_of_mut},
 };
 
 use macros::vtable;
@@ -580,3 +582,489 @@ fn register_em(_policy: &mut Policy) {
         kernel::build_error(VTABLE_DEFAULT_ERROR)
     }
 }
+
+/// Registration of a cpufreq driver.
+pub struct Registration<T: DriverOps> {
+    registered: bool,
+    drv: UnsafeCell<bindings::cpufreq_driver>,
+    _p: PhantomData<T>,
+    _pin: PhantomPinned,
+}
+
+// SAFETY: `Registration` doesn't offer any methods or access to fields when shared between threads
+// or CPUs, so it is safe to share it.
+unsafe impl<T: DriverOps> Sync for Registration<T> {}
+
+// SAFETY: Registration with and unregistration from the cpufreq subsystem can happen from any thread.
+// Additionally, `T::Data` (which is dropped during unregistration) is `Send`, so it is okay to move
+// `Registration` to different threads.
+#[allow(clippy::non_send_fields_in_send_ty)]
+unsafe impl<T: DriverOps> Send for Registration<T> {}
+
+impl<T: DriverOps> Default for Registration<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T: DriverOps> Registration<T> {
+    /// Creates new [`Registration`] but does not register it yet.
+    ///
+    /// It is allowed to move.
+    pub fn new() -> Self {
+        Self {
+            registered: false,
+            drv: UnsafeCell::new(bindings::cpufreq_driver::default()),
+            _pin: PhantomPinned,
+            _p: PhantomData,
+        }
+    }
+
+    /// Registers a cpufreq driver with the rest of the kernel.
+    pub fn register(
+        self: Pin<&mut Self>,
+        name: &'static CStr,
+        data: T::Data,
+        flags: u16,
+        boost: bool,
+    ) -> Result {
+        // SAFETY: We never move out of `this`.
+        let this = unsafe { self.get_unchecked_mut() };
+
+        if this.registered {
+            return Err(EINVAL);
+        }
+
+        let drv = this.drv.get_mut();
+
+        // Account for the trailing null character.
+        let len = name.len() + 1;
+        if len > drv.name.len() {
+            return Err(EINVAL);
+        };
+
+        // SAFETY: `name` is a valid Cstr, and we are copying it to an array of equal or larger
+        // size.
+        let name = unsafe { &*(name.as_bytes_with_nul() as *const [u8] as *const [i8]) };
+        drv.name[..len].copy_from_slice(name);
+
+        drv.boost_enabled = boost;
+        drv.flags = flags;
+
+        // Allocate an array of 3 pointers to be passed to the C code.
+        let mut attr = Box::new([ptr::null_mut(); 3], GFP_KERNEL)?;
+        let mut next = 0;
+
+        // SAFETY: The C code returns a valid pointer here, which is again passed to the C code in
+        // an array.
+        attr[next] =
+            unsafe { addr_of_mut!(bindings::cpufreq_freq_attr_scaling_available_freqs) as *mut _ };
+        next += 1;
+
+        if boost {
+            // SAFETY: The C code returns a valid pointer here, which is again passed to the C code
+            // in an array.
+            attr[next] =
+                unsafe { addr_of_mut!(bindings::cpufreq_freq_attr_scaling_boost_freqs) as *mut _ };
+            next += 1;
+        }
+        attr[next] = ptr::null_mut();
+
+        // Pass the ownership of the memory block to the C code. This will be freed when
+        // the [`Registration`] object goes out of scope.
+        drv.attr = Box::leak(attr) as *mut _;
+
+        // Initialize mandatory callbacks.
+        drv.init = Some(Self::init_callback);
+        drv.verify = Some(Self::verify_callback);
+
+        // Initialize optional callbacks.
+        drv.setpolicy = if T::HAS_SETPOLICY {
+            Some(Self::setpolicy_callback)
+        } else {
+            None
+        };
+        drv.target = if T::HAS_TARGET {
+            Some(Self::target_callback)
+        } else {
+            None
+        };
+        drv.target_index = if T::HAS_TARGET_INDEX {
+            Some(Self::target_index_callback)
+        } else {
+            None
+        };
+        drv.fast_switch = if T::HAS_FAST_SWITCH {
+            Some(Self::fast_switch_callback)
+        } else {
+            None
+        };
+        drv.adjust_perf = if T::HAS_ADJUST_PERF {
+            Some(Self::adjust_perf_callback)
+        } else {
+            None
+        };
+        drv.get_intermediate = if T::HAS_GET_INTERMEDIATE {
+            Some(Self::get_intermediate_callback)
+        } else {
+            None
+        };
+        drv.target_intermediate = if T::HAS_TARGET_INTERMEDIATE {
+            Some(Self::target_intermediate_callback)
+        } else {
+            None
+        };
+        drv.get = if T::HAS_GET {
+            Some(Self::get_callback)
+        } else {
+            None
+        };
+        drv.update_limits = if T::HAS_UPDATE_LIMITS {
+            Some(Self::update_limits_callback)
+        } else {
+            None
+        };
+        drv.bios_limit = if T::HAS_BIOS_LIMIT {
+            Some(Self::bios_limit_callback)
+        } else {
+            None
+        };
+        drv.online = if T::HAS_ONLINE {
+            Some(Self::online_callback)
+        } else {
+            None
+        };
+        drv.offline = if T::HAS_OFFLINE {
+            Some(Self::offline_callback)
+        } else {
+            None
+        };
+        drv.exit = if T::HAS_EXIT {
+            Some(Self::exit_callback)
+        } else {
+            None
+        };
+        drv.suspend = if T::HAS_SUSPEND {
+            Some(Self::suspend_callback)
+        } else {
+            None
+        };
+        drv.resume = if T::HAS_RESUME {
+            Some(Self::resume_callback)
+        } else {
+            None
+        };
+        drv.ready = if T::HAS_READY {
+            Some(Self::ready_callback)
+        } else {
+            None
+        };
+        drv.set_boost = if T::HAS_SET_BOOST {
+            Some(Self::set_boost_callback)
+        } else {
+            None
+        };
+        drv.register_em = if T::HAS_REGISTER_EM {
+            Some(Self::register_em_callback)
+        } else {
+            None
+        };
+
+        // Set driver data before registering the driver, as the cpufreq core may call few
+        // callbacks before `cpufreq_register_driver()` returns.
+        this.set_data(data)?;
+
+        // SAFETY: It is safe to register the driver with the cpufreq core in the C code.
+        to_result(unsafe { bindings::cpufreq_register_driver(this.drv.get_mut()) })?;
+
+        this.registered = true;
+        Ok(())
+    }
+
+    /// Returns the previous set data for a cpufreq driver.
+    pub fn data<D: ForeignOwnable>() -> Option<<D>::Borrowed<'static>> {
+        // SAFETY: The driver data is earlier set by us from [`set_data()`].
+        let data = unsafe { bindings::cpufreq_get_driver_data() };
+        if data.is_null() {
+            None
+        } else {
+            // SAFETY: The driver data is earlier set by us from [`set_data()`].
+            Some(unsafe { D::borrow(data) })
+        }
+    }
+
+    // Sets the data for a cpufreq driver.
+    fn set_data(&mut self, data: T::Data) -> Result<()> {
+        let drv = self.drv.get_mut();
+
+        if drv.driver_data.is_null() {
+            // Pass the ownership of the data to the foreign interface.
+            drv.driver_data = <T::Data as ForeignOwnable>::into_foreign(data) as _;
+            Ok(())
+        } else {
+            Err(EBUSY)
+        }
+    }
+
+    // Clears and returns the data for a cpufreq driver.
+    fn clear_data(&mut self) -> Option<T::Data> {
+        let drv = self.drv.get_mut();
+
+        if drv.driver_data.is_null() {
+            None
+        } else {
+            // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+            // relinquish it now.
+            let data = Some(unsafe { <T::Data as ForeignOwnable>::from_foreign(drv.driver_data) });
+            drv.driver_data = ptr::null_mut();
+            data
+        }
+    }
+}
+
+// cpufreq driver callbacks.
+impl<T: DriverOps> Registration<T> {
+    // Policy's init callback.
+    extern "C" fn init_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+
+            let data = T::init(&mut policy)?;
+            policy.set_data(data)?;
+            Ok(0)
+        })
+    }
+
+    // Policy's exit callback.
+    extern "C" fn exit_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+
+            let data = policy.clear_data();
+            T::exit(&mut policy, data).map(|_| 0)
+        })
+    }
+
+    // Policy's online callback.
+    extern "C" fn online_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::online(&mut policy).map(|_| 0)
+        })
+    }
+
+    // Policy's offline callback.
+    extern "C" fn offline_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::offline(&mut policy).map(|_| 0)
+        })
+    }
+
+    // Policy's suspend callback.
+    extern "C" fn suspend_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::suspend(&mut policy).map(|_| 0)
+        })
+    }
+
+    // Policy's resume callback.
+    extern "C" fn resume_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::resume(&mut policy).map(|_| 0)
+        })
+    }
+
+    // Policy's ready callback.
+    extern "C" fn ready_callback(ptr: *mut bindings::cpufreq_policy) {
+        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of
+        // `ptr`.
+        let mut policy = unsafe { Policy::from_ptr(ptr) };
+        T::ready(&mut policy);
+    }
+
+    // Policy's verify callback.
+    extern "C" fn verify_callback(ptr: *mut bindings::cpufreq_policy_data) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut data = unsafe { PolicyData::from_ptr(ptr) };
+            T::verify(&mut data).map(|_| 0)
+        })
+    }
+
+    // Policy's setpolicy callback.
+    extern "C" fn setpolicy_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::setpolicy(&mut policy).map(|_| 0)
+        })
+    }
+
+    // Policy's target callback.
+    extern "C" fn target_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        target_freq: u32,
+        relation: u32,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::target(&mut policy, target_freq, Relation::new(relation)?).map(|_| 0)
+        })
+    }
+
+    // Policy's target_index callback.
+    extern "C" fn target_index_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        index: u32,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::target_index(&mut policy, index).map(|_| 0)
+        })
+    }
+
+    // Policy's fast_switch callback.
+    extern "C" fn fast_switch_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        target_freq: u32,
+    ) -> core::ffi::c_uint {
+        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of
+        // `ptr`.
+        let mut policy = unsafe { Policy::from_ptr(ptr) };
+        T::fast_switch(&mut policy, target_freq)
+    }
+
+    // Policy's adjust_perf callback.
+    extern "C" fn adjust_perf_callback(cpu: u32, min_perf: u64, target_perf: u64, capacity: u64) {
+        if let Some(mut policy) = Policy::from_cpu(cpu).ok() {
+            T::adjust_perf(&mut policy, min_perf, target_perf, capacity);
+        }
+    }
+
+    // Policy's get_intermediate callback.
+    extern "C" fn get_intermediate_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        index: u32,
+    ) -> core::ffi::c_uint {
+        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of
+        // `ptr`.
+        let mut policy = unsafe { Policy::from_ptr(ptr) };
+        T::get_intermediate(&mut policy, index)
+    }
+
+    // Policy's target_intermediate callback.
+    extern "C" fn target_intermediate_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        index: u32,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::target_intermediate(&mut policy, index).map(|_| 0)
+        })
+    }
+
+    // Policy's get callback.
+    extern "C" fn get_callback(cpu: u32) -> core::ffi::c_uint {
+        // SAFETY: Get the policy for a CPU.
+        Policy::from_cpu(cpu).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
+    }
+
+    // Policy's update_limit callback.
+    extern "C" fn update_limits_callback(cpu: u32) {
+        // SAFETY: Get the policy for a CPU.
+        if let Some(mut policy) = Policy::from_cpu(cpu).ok() {
+            T::update_limits(&mut policy);
+        }
+    }
+
+    // Policy's bios_limit callback.
+    extern "C" fn bios_limit_callback(cpu: i32, limit: *mut u32) -> core::ffi::c_int {
+        from_result(|| {
+            let mut policy = Policy::from_cpu(cpu as u32)?;
+
+            // SAFETY: The pointer is guaranteed by the C code to be valid.
+            T::bios_limit(&mut policy, &mut (unsafe { *limit })).map(|_| 0)
+        })
+    }
+
+    // Policy's set_boost callback.
+    extern "C" fn set_boost_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        state: i32,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::set_boost(&mut policy, state).map(|_| 0)
+        })
+    }
+
+    // Policy's register_em callback.
+    extern "C" fn register_em_callback(ptr: *mut bindings::cpufreq_policy) {
+        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of
+        // `ptr`.
+        let mut policy = unsafe { Policy::from_ptr(ptr) };
+        T::register_em(&mut policy);
+    }
+}
+
+impl<T: DriverOps> Drop for Registration<T> {
+    // Removes the registration from the kernel if it has completed successfully before.
+    fn drop(&mut self) {
+        let drv = self.drv.get_mut();
+
+        if self.registered {
+            // SAFETY: The driver was earlier registered from `register()`.
+            unsafe { bindings::cpufreq_unregister_driver(drv) };
+        }
+
+        // Free the previously leaked memory to the C code.
+        if !drv.attr.is_null() {
+            // SAFETY: The pointer was earlier initialized from the result of `Box::leak`.
+            unsafe { drop(Box::from_raw(drv.attr)) };
+        }
+
+        // Free data
+        drop(self.clear_data());
+    }
+}
-- 
2.31.1.272.g89b43f80a514


