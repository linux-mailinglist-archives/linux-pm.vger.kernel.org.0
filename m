Return-Path: <linux-pm+bounces-20317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAB0A0B5A2
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 12:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D946A7A3949
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D692722A4CA;
	Mon, 13 Jan 2025 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvoURDSV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A5D238736
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767466; cv=none; b=bBf4G+0AG79eaqzStJf9Ba1GPugrddYyB4YhR1RO84CB8sZGam18q08udO7+N1k1Be++nHSz3Jc1rN3dyur/jjSZdJauNgXpX0WgBxNBCHfTBOxSiR/dabimSP36xGH3xtlkwhrF+4AahIgD3E8cs8MGxrQ5F+D+rqlPzCC6BPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767466; c=relaxed/simple;
	bh=fmsO+gUs+PaCOyzUqE6A+eHGWzdyvpsE6BHVemBn01I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hTLTpbDnrAg3O8d0OsWQb/w6HmDU5WrKBA+Auu3jDyI3ZTnxlYiZNo66z2qCPml3oZEbbiuL8isV8tT7/rjNOn/X8BUCkbmCSXCKI3/Der95lyCl1OC7D3kP0HjwNaWBKKrSbQZxTHuRWTPaIYJdgqHELyBeTJPoJkC0PqIZPok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zvoURDSV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21a7ed0155cso68974585ad.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 03:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736767464; x=1737372264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jqj01KGpNi0J5xBTE+Wd2fJArhO2X9pHhv/GKSBCr2Q=;
        b=zvoURDSVV23i7sIvzmen8y5RTKWoZ3cMG3gfLzzfid3LUgu+Wk5BLHjNA499RTKT47
         x4QzxIYyG8JpQAV98jwuYim9wsPzwMzWFdYfg/7MWhrGdtgX2TyTzsMKDhpVrK6CiNDO
         0yNeJgfHWWjH2tnzB6NCRfJSJn8vVoT/2UtkxYfxtowloFsFy1TQ4sJ/x56l55SCfGZr
         dxqLuCtCC9ooSeFcZPcOBY4bsAnlT1S7ex1GOhIUOdk84yDGUo0xK/cdAqbp/IKQmh4t
         O0zc79aDGyvqY1sjMgiIqz80ea0hYocfy7Mgr6MID+koBzVGzhQdt/A2c5GhP8ex9hq5
         gAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767464; x=1737372264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jqj01KGpNi0J5xBTE+Wd2fJArhO2X9pHhv/GKSBCr2Q=;
        b=bpbQOJ7eY1YqZC6xEANfqGmIaELOQVsLx6+r2wZAuvo3vCwrzXGiZ29M3UBjDIYIh9
         PmLrKXY5mDkQx2ZiuhOZxNUgxadcvMQOEB0bCxN77NgRVSatF5T4wiAMjq7le6FWcK4O
         icZYgYFpcBrpacX/8VNumFKEbQm+mr/WSuCXbkeCFB17F2/qPhizaGDTWqDw0d9UdZEq
         6lkiRuoKYIiRuomEZ+5kOtSgIpWn7u8+/s8JoUDcYPUHL9y/sWsYVjHV371Sa5YFbx2K
         gy6qHKh2uSkJYCRtw+yVU7zQV+fWDmN69B3/G4uLoEwI2CRRz1Ds8mzhaPYrYBkN+JKI
         ObIA==
X-Gm-Message-State: AOJu0YxpaR1QMBnHl59vAcvQ4OoU+ANj0kX0P+mQgerT3U+IpuShYvA/
	qtJDysNtDkwNW0TMuHbBh/7vvmsTjTD0tNC5dkUTZLW1Lk5I1rZ3az4Sf4giSPk=
X-Gm-Gg: ASbGncvvH2LZQYCL2poJ+khbsy6L3yjsemAcnk5cTMn5JvejdaPip5Q6MgWpzFCkst1
	iBQ99MRFPKzVy3+Wg+ROXx4gIBLVkbClMgMn/zL71Jst0rPQ1KAvqPOIRQ7lnjn73KiXJKRvZqQ
	I2w+2mkYdvao+Z6Y5OKK4f8z45saCP6VZlSpLy0x6Yino+Ely3NyMTCUgEALIQnY0PB6O4bdsvw
	2kCazgIdNQ9LTSqdXV/b/wTGCXlSCf6EochdNGaO8mkGYZizPxoUg16978=
X-Google-Smtp-Source: AGHT+IF3VnF2HOh2G1jERTpOh24EBzVNaNpYbXGC2liPXlYsq5SBTdEYYq0R/pVu5nzMpPDVkfebpQ==
X-Received: by 2002:a05:6a00:32cb:b0:725:df1a:288 with SMTP id d2e1a72fcca58-72d2201c96dmr33506209b3a.24.1736767463835;
        Mon, 13 Jan 2025 03:24:23 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4065a544sm5939301b3a.96.2025.01.13.03.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:24:23 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
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
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 13/16] rust: Extend cpufreq bindings for driver registration
Date: Mon, 13 Jan 2025 16:53:08 +0530
Message-Id: <c082019a92ab0554db1a1777b318cdb698f8d7f8.1736766672.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1736766672.git.viresh.kumar@linaro.org>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
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
 rust/kernel/cpufreq.rs | 476 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 474 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 8468e12ef1f5..899f5b50eb7c 100644
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
@@ -582,3 +585,472 @@ fn register_em(_policy: &mut Policy) {
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
+// SAFETY: Registration with and unregistration from the cpufreq subsystem can happen from any thread.
+// Additionally, `T::Data` (which is dropped during unregistration) is `Send`, so it is okay to move
+// `Registration` to different threads.
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
+        attr[next] = unsafe {
+            addr_of_mut!(bindings::cpufreq_freq_attr_scaling_available_freqs) as *mut _
+        };
+        next += 1;
+
+        if boost {
+            // SAFETY: The C code returns a valid pointer here, which is again passed to the C code
+            // in an array.
+            attr[next] = unsafe {
+                addr_of_mut!(bindings::cpufreq_freq_attr_scaling_boost_freqs) as *mut _
+            };
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
+impl<T: Driver> Registration<T> {
+    // Policy's init callback.
+    extern "C" fn init_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
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
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+            T::online(&mut policy).map(|()| 0)
+        })
+    }
+
+    // Policy's offline callback.
+    extern "C" fn offline_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+            T::offline(&mut policy).map(|()| 0)
+        })
+    }
+
+    // Policy's suspend callback.
+    extern "C" fn suspend_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+            T::suspend(&mut policy).map(|()| 0)
+        })
+    }
+
+    // Policy's resume callback.
+    extern "C" fn resume_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+            T::resume(&mut policy).map(|()| 0)
+        })
+    }
+
+    // Policy's ready callback.
+    extern "C" fn ready_callback(ptr: *mut bindings::cpufreq_policy) {
+        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of
+        // `ptr`.
+        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+        T::ready(&mut policy);
+    }
+
+    // Policy's verify callback.
+    extern "C" fn verify_callback(ptr: *mut bindings::cpufreq_policy_data) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut data = unsafe { PolicyData::from_raw_policy_data(ptr) };
+            T::verify(&mut data).map(|()| 0)
+        })
+    }
+
+    // Policy's setpolicy callback.
+    extern "C" fn setpolicy_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
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
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
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
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
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
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of
+        // `ptr`.
+        let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+        T::fast_switch(&mut policy, target_freq)
+    }
+
+    // Policy's adjust_perf callback.
+    extern "C" fn adjust_perf_callback(cpu: u32, min_perf: usize, target_perf: usize, capacity: usize) {
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
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of
+        // `ptr`.
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
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
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
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_raw_policy(ptr) };
+            T::set_boost(&mut policy, state).map(|()| 0)
+        })
+    }
+
+    // Policy's register_em callback.
+    extern "C" fn register_em_callback(ptr: *mut bindings::cpufreq_policy) {
+        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of
+        // `ptr`.
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


