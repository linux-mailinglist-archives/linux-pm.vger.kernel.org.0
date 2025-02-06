Return-Path: <linux-pm+bounces-21464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE72A2A482
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 10:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99547188950D
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4A822FE0B;
	Thu,  6 Feb 2025 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j56OlRHB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B2922FDE5
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834183; cv=none; b=J53NqDeU8oYtiisdvuQulkEknoIg33e3Kyy8DZxxIGJKApPzVjbofLIusSrOG0R+0Iqh/UsCJ7N8M2zHI4UQrrDfV5akf6TR3RStTMFE7CKmKWsjdebLVQHZe+t0fhh9YRJ+jd1fwyxwLhGWIf84WqnEHxKspVH37Bw3JH/QRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834183; c=relaxed/simple;
	bh=l/VIi63UGc+3u6vflgZumPAhzfpIgDQMkROcsChH9BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YYhd4M7NDpAGh68KvJrhFWBqnNhj2WIp8ap5jQFDSrhphc5zVYr8ruiORJX5lQUJGV6NkFV9ggh23u+tGV+MDI4WXUl3ueejaBKXq9wU2TWVqHGJxK3iy+42y+BOhdqXSyiL1gaKE3yOPDWinLlhLJrYxMCVi/6l6za/XSMN3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j56OlRHB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso992057a91.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2025 01:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738834180; x=1739438980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6Z09wEUbdjhQQCnF4pncU5PBUEGY4K3sFzwx7fQzBM=;
        b=j56OlRHBbO31lKVuDT3GyLfYUebuhFd6+etnIW6OjTwS23d4ySTOUAVUulz6yrGY7A
         UYordM6URjWAGx1UmqVpmnY+JIA/jgzztt2xSoHC3D0BS60bh7h7dF27Ct5nkFcfh+SN
         YOhbRm8rFZsxsNS5MhaYOBm9bGLI0ZPuJU46PP9x38sdgFEsFZRV3xqCxAXLfvLfedvA
         3qVufLtWBs3kQnHWxkL3TwmyejvqokKqL/9MWTaOmtGehHoGhn0ZPZhBCuQfhaCDaXKg
         aV8DyObtAw9hpk3iwJ07p6K1nPDcRffa4e9ctaMJkSdlpYAQSmlz8ggjCn4rer01qtGf
         QpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834180; x=1739438980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6Z09wEUbdjhQQCnF4pncU5PBUEGY4K3sFzwx7fQzBM=;
        b=sz0w6e9KLifwDKZbQNzkw/5O1Gl2fKZp/Eypl3tPDSx6sK48B3X/+GuM75ZTBNqhRc
         GIUt0sJh0ua59ZkB5zQbZ8/gHmFdW87M7i7ptLY/6EFhotByaGGFA9LsLm5xIivQkJDt
         vvILMdGVB10SiRqDAR4ni6JPgfvzkurebBvc2Cht12pm0DgTZnw9F4AbUFjeJaLssR/t
         dw3CY9zbqN3Z74+wR8LHTNuUh//LhmFOMPZen8gpNdoivRvdpjYsNPB4N8Ps+u2yTn1q
         WHzd1WGAT2LD5tGC1wgg3NFg3z+6imvvbInF7SN9IHCterQD0XqBXseKiqQqnHPC5wAv
         2N/w==
X-Gm-Message-State: AOJu0YxhJYNWxtDKCKwsEYcRWu8OXmA7ckvCZhc/XY70zTaJCblqOowW
	rCrhI51fcx/b2YjKZ/kAQQVFbtf3EdKMlQkUqhNXkPmXAezEdvsCUfohqRxjtto=
X-Gm-Gg: ASbGncuwi0HgvUMFccFm3pCuzSN10+LZb/vXYaEzith4jwu3/o8e6ervykEeYzloWN2
	ZmNi5BS4ZHUrOXU1JuYnofOam4wdf5wLRglaoEx5Y9dbsyi3/Kq9yWsigYl3ejtz02+YfRcGtgr
	+4Z3nxLQg4KOdnz/3cDkWt9jIwtIHnq+PqpVHk6EjNjsSknFcVJJ7oKibtl+cSKSNdKyQgqMcao
	w6Y+0QnJYs2KyvJ7tHxgOW/4P0mSGJiN+p7aDOBlvS5W/QSoT+yeceDszhBAqdIp6gPRoGQsLf2
	WocNfXiZhsFSou0ofg==
X-Google-Smtp-Source: AGHT+IGvzDmiMJGRpepS/9/HxxBD6K4uQOyrmZ5Z/P0VpVjMavBRgfYTNtKdzE8d9q/kFMstDAByZQ==
X-Received: by 2002:a17:90b:3b41:b0:2f7:4c7a:b5f with SMTP id 98e67ed59e1d1-2f9ff786427mr4766379a91.2.1738834179821;
        Thu, 06 Feb 2025 01:29:39 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09b3f803sm872055a91.32.2025.02.06.01.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:29:39 -0800 (PST)
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
	Trevor Gross <tmgross@umich.edu>
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
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 12/14] rust: Extend cpufreq bindings for driver registration
Date: Thu,  6 Feb 2025 14:58:33 +0530
Message-Id: <5860ff88ff81d09838f7786507ec47a33cf16158.1738832119.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1738832118.git.viresh.kumar@linaro.org>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
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
 rust/kernel/cpufreq.rs | 475 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 473 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 63ea816017c0..f92259d339d3 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -9,14 +9,17 @@
 use crate::{
     bindings, clk, cpumask,
     device::Device,
-    error::{code::*, from_err_ptr, to_result, Result, VTABLE_DEFAULT_ERROR},
+    devres::Devres,
+    error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
     prelude::*,
     types::ForeignOwnable,
 };
 
 use core::{
+    cell::UnsafeCell,
+    marker::PhantomData,
     pin::Pin,
-    ptr::self,
+    ptr::{self, addr_of_mut},
 };
 
 use macros::vtable;
@@ -579,3 +582,471 @@ fn register_em(_policy: &mut Policy) {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 }
+
+/// Registration of a cpufreq driver.
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
+    /// Registers a cpufreq driver with the rest of the kernel.
+    pub fn new(name: &'static CStr, data: T::Data, flags: u16, boost: bool) -> Result<Self> {
+        let mut drv = KBox::new(
+            UnsafeCell::new(bindings::cpufreq_driver::default()),
+            GFP_KERNEL,
+        )?;
+        let drv_ref = drv.get_mut();
+
+        // Account for the trailing null character.
+        let len = name.len() + 1;
+        if len > drv_ref.name.len() {
+            return Err(EINVAL);
+        };
+
+        // SAFETY: `name` is a valid Cstr, and we are copying it to an array of equal or larger
+        // size.
+        let name = unsafe { &*(name.as_bytes_with_nul() as *const [u8]) };
+        drv_ref.name[..len].copy_from_slice(name);
+
+        drv_ref.boost_enabled = boost;
+        drv_ref.flags = flags;
+
+        // Allocate an array of 3 pointers to be passed to the C code.
+        let mut attr = KBox::new([ptr::null_mut(); 3], GFP_KERNEL)?;
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
+        drv_ref.attr = KBox::leak(attr) as *mut _;
+
+        // Initialize mandatory callbacks.
+        drv_ref.init = Some(Self::init_callback);
+        drv_ref.verify = Some(Self::verify_callback);
+
+        // Initialize optional callbacks.
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
+        // Set driver data before registering the driver, as the cpufreq core may call few
+        // callbacks before `cpufreq_register_driver()` returns.
+        Self::set_data(drv_ref, data)?;
+
+        // SAFETY: It is safe to register the driver with the cpufreq core in the C code.
+        to_result(unsafe { bindings::cpufreq_register_driver(drv_ref) })?;
+
+        Ok(Self {
+            drv,
+            _p: PhantomData,
+        })
+    }
+
+    /// Same as [Registration::new`], but does not return a `Registration` instance.
+    /// Instead the `Registration` is owned by devres and will be revoked / dropped, once the
+    /// device is detached.
+    pub fn new_foreign_owned(
+        dev: &Device,
+        name: &'static CStr,
+        data: T::Data,
+        flags: u16,
+        boost: bool,
+    ) -> Result<()> {
+        let reg = Self::new(name, data, flags, boost)?;
+        Devres::new_foreign_owned(dev, reg, GFP_KERNEL)?;
+        Ok(())
+    }
+
+    // Sets the data for a cpufreq driver.
+    fn set_data(drv: &mut bindings::cpufreq_driver, data: T::Data) -> Result<()> {
+        if drv.driver_data.is_null() {
+            // Pass the ownership of the data to the foreign interface.
+            drv.driver_data = <T::Data as ForeignOwnable>::into_foreign(data) as _;
+            Ok(())
+        } else {
+            Err(EBUSY)
+        }
+    }
+
+    /// Returns the previous set data for a cpufreq driver.
+    pub fn data(&mut self) -> Option<<T::Data as ForeignOwnable>::Borrowed<'static>> {
+        let drv = self.drv.get_mut();
+
+        if drv.driver_data.is_null() {
+            None
+        } else {
+            // SAFETY: The data is earlier set by us from [`set_data()`].
+            Some(unsafe { <T::Data as ForeignOwnable>::borrow(drv.driver_data) })
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
+            // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe
+            // to relinquish it now.
+            let data = Some(unsafe { <T::Data as ForeignOwnable>::from_foreign(drv.driver_data) });
+            drv.driver_data = ptr::null_mut();
+            data
+        }
+    }
+}
+
+// cpufreq driver callbacks.
+impl<T: Driver> Registration<T> {
+    // Policy's init callback.
+    extern "C" fn init_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for
+            // the duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+
+            let data = T::init(&mut policy)?;
+            policy.set_data(data)?;
+            Ok(0)
+        })
+    }
+
+    // Policy's exit callback.
+    extern "C" fn exit_callback(ptr: *mut bindings::cpufreq_policy) {
+        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of
+        // `ptr`.
+        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+
+        let data = policy.clear_data();
+        let _ = T::exit(&mut policy, data);
+    }
+
+    // Policy's online callback.
+    extern "C" fn online_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for
+            // the duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+            T::online(&mut policy).map(|()| 0)
+        })
+    }
+
+    // Policy's offline callback.
+    extern "C" fn offline_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for
+            // the duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+            T::offline(&mut policy).map(|()| 0)
+        })
+    }
+
+    // Policy's suspend callback.
+    extern "C" fn suspend_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for
+            // the duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+            T::suspend(&mut policy).map(|()| 0)
+        })
+    }
+
+    // Policy's resume callback.
+    extern "C" fn resume_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for
+            // the duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+            T::resume(&mut policy).map(|()| 0)
+        })
+    }
+
+    // Policy's ready callback.
+    extern "C" fn ready_callback(ptr: *mut bindings::cpufreq_policy) {
+        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of `ptr`.
+        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+        T::ready(&mut policy);
+    }
+
+    // Policy's verify callback.
+    extern "C" fn verify_callback(ptr: *mut bindings::cpufreq_policy_data) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for
+            // the duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut data = unsafe { PolicyData::from_raw_policy_data(ptr) };
+            T::verify(&mut data).map(|()| 0)
+        })
+    }
+
+    // Policy's setpolicy callback.
+    extern "C" fn setpolicy_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for
+            // the duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+            T::setpolicy(&mut policy).map(|()| 0)
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
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for
+            // the duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+            T::target(&mut policy, target_freq, Relation::new(relation)?).map(|()| 0)
+        })
+    }
+
+    // Policy's target_index callback.
+    extern "C" fn target_index_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        index: u32,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for
+            // the duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+            T::target_index(&mut policy, index).map(|()| 0)
+        })
+    }
+
+    // Policy's fast_switch callback.
+    extern "C" fn fast_switch_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        target_freq: u32,
+    ) -> core::ffi::c_uint {
+        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of `ptr`.
+        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+        T::fast_switch(&mut policy, target_freq)
+    }
+
+    // Policy's adjust_perf callback.
+    extern "C" fn adjust_perf_callback(
+        cpu: u32,
+        min_perf: usize,
+        target_perf: usize,
+        capacity: usize,
+    ) {
+        if let Ok(mut policy) = Policy::from_cpu(cpu) {
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
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of `ptr`.
+        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+        T::get_intermediate(&mut policy, index)
+    }
+
+    // Policy's target_intermediate callback.
+    extern "C" fn target_intermediate_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        index: u32,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for
+            // the duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+            T::target_intermediate(&mut policy, index).map(|()| 0)
+        })
+    }
+
+    // Policy's get callback.
+    extern "C" fn get_callback(cpu: u32) -> core::ffi::c_uint {
+        Policy::from_cpu(cpu).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
+    }
+
+    // Policy's update_limit callback.
+    extern "C" fn update_limits_callback(cpu: u32) {
+        if let Ok(mut policy) = Policy::from_cpu(cpu) {
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
+            T::bios_limit(&mut policy, &mut (unsafe { *limit })).map(|()| 0)
+        })
+    }
+
+    // Policy's set_boost callback.
+    extern "C" fn set_boost_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        state: i32,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for
+            // the duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+            T::set_boost(&mut policy, state).map(|()| 0)
+        })
+    }
+
+    // Policy's register_em callback.
+    extern "C" fn register_em_callback(ptr: *mut bindings::cpufreq_policy) {
+        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of `ptr`.
+        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+        T::register_em(&mut policy);
+    }
+}
+
+impl<T: Driver> Drop for Registration<T> {
+    // Removes the registration from the kernel if it has completed successfully before.
+    fn drop(&mut self) {
+        pr_info!("Registration dropped\n");
+        let drv = self.drv.get_mut();
+
+        // SAFETY: The driver was earlier registered from `new()`.
+        unsafe { bindings::cpufreq_unregister_driver(drv) };
+
+        // Free the previously leaked memory to the C code.
+        if !drv.attr.is_null() {
+            // SAFETY: The pointer was earlier initialized from the result of `KBox::leak`.
+            unsafe { drop(KBox::from_raw(drv.attr)) };
+        }
+
+        // Free data
+        drop(self.clear_data());
+    }
+}
-- 
2.31.1.272.g89b43f80a514


