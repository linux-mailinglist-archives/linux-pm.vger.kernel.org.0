Return-Path: <linux-pm+bounces-27309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA01ABB5C9
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 09:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35C0E7AC86F
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 07:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DFE26A1B4;
	Mon, 19 May 2025 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9YCbw7Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1B7266B59
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638506; cv=none; b=A0Os4kUZSh2bMEmsNyX343v2nSyJjbs6QL+kouEZHD7w+LrQT7YEvHirz+wK9RNnNKts3UhLTCMBBBdPbSy2wk92J111aHcyWxgY3fDx5q93I9kbonLjb0WRwSvni4kLKIyh8ypv54etGqAtOz8+a7gUOLwo/J4oVhSjUsBc0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638506; c=relaxed/simple;
	bh=GQZ/C13qepiseJqyRqcGLUXRE9t1VF7vW3VUh3qqVoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJBcmJiRjgXR8Vj2jeJ5LKAmTJxDyTVvkAzYKDB6m3cqBHhBt4NHXOPavJ27u0rr+BCiPnM2Zrqty6cU7ZdYPF6yuPvKvWSH1LeBoCTgq7OkwtAV/NLy8ilYb2HCNUFV0VCXwC9pmhGa35tPyXHEJ8TPSnNjmNleHtFQ7bOg63A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D9YCbw7Z; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c7a52e97so676290b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 00:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747638503; x=1748243303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81nTFGvkA/IBrcIFlaJ92uVSha8rn1gDNqnm+5GgOQw=;
        b=D9YCbw7ZApPOTbxWi04xxtq55Q2gvReahm1BH5ikGbzOGhSkb8OPkurYUsYSmNxtyj
         saYfrEiXGzJGZgrrxARe7A0W2Q78sAj3Zqss3U9mqxMroIt9M0V3Yd4qiNDno1wf3FJO
         Ylp853auef4/9/ZdtikCqfSsvlXVSucc558p2MFtcDQOHG/0ReYyWpZoqqZLtSqTeNbt
         Y5sVbdA48cjUNrXYOI8on5dNl/CC23f8WfezUYfiN94ryJUixMUtS80d75oGTtJwuULk
         PtomNgdDr+YBHhHBOccYVxzd/xb0/DsvLw94jam6lBJIkEh013xRAr51hzItkNA5yYm4
         P7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747638503; x=1748243303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81nTFGvkA/IBrcIFlaJ92uVSha8rn1gDNqnm+5GgOQw=;
        b=ImmuRCL/q1Zrk2C6v02DDyrluf5IC4VbRT1qVuMLWg/x7OtJ2qU+rath63TEI+d9mn
         1M0xVu34gcvwHINE8QrsRp3AaCWdTTJbNrAHN3ZT9h3dT1H+HwcNDgNsGDi+Rym8QvnM
         TXx/lr+rEoGkGqSz/Rn71Ii+fl7+3bCwbsLrO6jACgqh2nQFtzCo5q4+UJqy3WYTOThZ
         xesJAl3WbTD8nMiYXgDqLglYG36HGUmngsWDawKPU+ULhZioHTRGWQCqqaGyOPivcr51
         CtICYfzemxroLE7Rg7xmBaft2SiybNeT9IT8IKj3IqoYPW8SUoi+OW1eMMxyAFAd0LC7
         Z9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCX99fEG36cXedqmKrkkLsbXyTSX5587+LQn2mGzZkGwJgPp9lLcysIFs+c+hNz+97Muo4Lg6DDBbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzChhp9tDd3tSHQGgfB2dhKIxjGnH2Jq0cgPIllRhfIm6UyD772
	e46Ic/oy87jj0oZO3AZsaYhbp0O3uftfIvyEaldEErF0vBfRdQsrZLVIR+iEnlI79p8=
X-Gm-Gg: ASbGncvuk4mUXCh9V6Ej95msJKFOMuQt0nMboJ026GeNOJhnR87dsILklGPXZehjxLy
	VPInCSwJCPO/HgF71sNMXQ/g2n7lyXN4qE7CkPkWu9S8Q4/yPHExD2jvElx/Bd/1GQyLN5nebIq
	VS5/jdLoULNkpY+MDSPEBfjH90+9Q9ReXtspGbBVnMNwBmXqHu9UTTgXEr6p1RbuWxrSJVGuU56
	IoguGHzaFDUw4Mnfk8LbKjDT8T4iwsEZR78R3NY0hGXB1cmkycxlVZooywVeYMyO5uoPcnW+CXf
	bUcUjGNb0TDCI7vMacgeDaY1xA3UtgUzkpeyDEtgbAHOWouqa/1y
X-Google-Smtp-Source: AGHT+IHCRYPAYiAYx5Tx1UMCGZquBQ1QMiYKJ2/LxxD9n3pNoawWDcoNg8DtRj0MGmDb4xlY0ykjbA==
X-Received: by 2002:a05:6a20:6a28:b0:201:4061:bd94 with SMTP id adf61e73a8af0-2170ccaf4e4mr15295210637.19.1747638502864;
        Mon, 19 May 2025 00:08:22 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e981desm53007485ad.124.2025.05.19.00.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:08:22 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
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
	Andrew Ballance <andrewjballance@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V12 10/15] rust: opp: Add abstractions for the configuration options
Date: Mon, 19 May 2025 12:37:15 +0530
Message-Id: <a04acf7046e90395e18e384fcd99570ff25bfbd3.1747634382.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1747634382.git.viresh.kumar@linaro.org>
References: <cover.1747634382.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Rust abstractions for the OPP core configuration options,
enabling safe access to various configurable aspects of the OPP
framework.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 295 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 293 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 18f55c00a4d6..7be6fd33d93f 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -12,12 +12,29 @@
     clk::Hertz,
     cpumask::{Cpumask, CpumaskVar},
     device::Device,
-    error::{code::*, from_err_ptr, to_result, Error, Result},
+    error::{code::*, from_err_ptr, from_result, to_result, Error, Result, VTABLE_DEFAULT_ERROR},
     ffi::c_ulong,
+    prelude::*,
+    str::CString,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 
-use core::ptr;
+use core::{marker::PhantomData, ptr};
+
+use macros::vtable;
+
+/// Creates a null-terminated slice of pointers to [`Cstring`]s.
+fn to_c_str_array(names: &[CString]) -> Result<KVec<*const u8>> {
+    // Allocated a null-terminated vector of pointers.
+    let mut list = KVec::with_capacity(names.len() + 1, GFP_KERNEL)?;
+
+    for name in names.iter() {
+        list.push(name.as_ptr() as _, GFP_KERNEL)?;
+    }
+
+    list.push(ptr::null(), GFP_KERNEL)?;
+    Ok(list)
+}
 
 /// The voltage unit.
 ///
@@ -205,6 +222,280 @@ pub enum SearchType {
     Ceil,
 }
 
+/// OPP configuration callbacks.
+///
+/// Implement this trait to customize OPP clock and regulator setup for your device.
+#[vtable]
+pub trait ConfigOps {
+    /// This is typically used to scale clocks when transitioning between OPPs.
+    #[inline]
+    fn config_clks(_dev: &Device, _table: &Table, _opp: &OPP, _scaling_down: bool) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// This provides access to the old and new OPPs, allowing for safe regulator adjustments.
+    #[inline]
+    fn config_regulators(
+        _dev: &Device,
+        _opp_old: &OPP,
+        _opp_new: &OPP,
+        _data: *mut *mut bindings::regulator,
+        _count: u32,
+    ) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// OPP configuration token.
+///
+/// Returned by the OPP core when configuration is applied to a [`Device`]. The associated
+/// configuration is automatically cleared when the token is dropped.
+pub struct ConfigToken(i32);
+
+impl Drop for ConfigToken {
+    fn drop(&mut self) {
+        // SAFETY: This is the same token value returned by the C code via `dev_pm_opp_set_config`.
+        unsafe { bindings::dev_pm_opp_clear_config(self.0) };
+    }
+}
+
+/// OPP configurations.
+///
+/// Rust abstraction for the C `struct dev_pm_opp_config`.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to set OPP property-name configuration for a [`Device`].
+///
+/// ```
+/// use kernel::device::Device;
+/// use kernel::error::Result;
+/// use kernel::opp::{Config, ConfigOps, ConfigToken};
+/// use kernel::str::CString;
+/// use kernel::types::ARef;
+/// use kernel::macros::vtable;
+///
+/// #[derive(Default)]
+/// struct Driver;
+///
+/// #[vtable]
+/// impl ConfigOps for Driver {}
+///
+/// fn configure(dev: &ARef<Device>) -> Result<ConfigToken> {
+///     let name = CString::try_from_fmt(fmt!("{}", "slow"))?;
+///
+///     // The OPP configuration is cleared once the [`ConfigToken`] goes out of scope.
+///     Config::<Driver>::new()
+///         .set_prop_name(name)?
+///         .set(dev)
+/// }
+/// ```
+#[derive(Default)]
+pub struct Config<T: ConfigOps>
+where
+    T: Default,
+{
+    clk_names: Option<KVec<CString>>,
+    prop_name: Option<CString>,
+    regulator_names: Option<KVec<CString>>,
+    supported_hw: Option<KVec<u32>>,
+
+    // Tuple containing (required device, index)
+    required_dev: Option<(ARef<Device>, u32)>,
+    _data: PhantomData<T>,
+}
+
+impl<T: ConfigOps + Default> Config<T> {
+    /// Creates a new instance of [`Config`].
+    #[inline]
+    pub fn new() -> Self {
+        Self::default()
+    }
+
+    /// Initializes clock names.
+    pub fn set_clk_names(mut self, names: KVec<CString>) -> Result<Self> {
+        if self.clk_names.is_some() {
+            return Err(EBUSY);
+        }
+
+        if names.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.clk_names = Some(names);
+        Ok(self)
+    }
+
+    /// Initializes property name.
+    pub fn set_prop_name(mut self, name: CString) -> Result<Self> {
+        if self.prop_name.is_some() {
+            return Err(EBUSY);
+        }
+
+        self.prop_name = Some(name);
+        Ok(self)
+    }
+
+    /// Initializes regulator names.
+    pub fn set_regulator_names(mut self, names: KVec<CString>) -> Result<Self> {
+        if self.regulator_names.is_some() {
+            return Err(EBUSY);
+        }
+
+        if names.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.regulator_names = Some(names);
+
+        Ok(self)
+    }
+
+    /// Initializes required devices.
+    pub fn set_required_dev(mut self, dev: ARef<Device>, index: u32) -> Result<Self> {
+        if self.required_dev.is_some() {
+            return Err(EBUSY);
+        }
+
+        self.required_dev = Some((dev, index));
+        Ok(self)
+    }
+
+    /// Initializes supported hardware.
+    pub fn set_supported_hw(mut self, hw: KVec<u32>) -> Result<Self> {
+        if self.supported_hw.is_some() {
+            return Err(EBUSY);
+        }
+
+        if hw.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.supported_hw = Some(hw);
+        Ok(self)
+    }
+
+    /// Sets the configuration with the OPP core.
+    ///
+    /// The returned [`ConfigToken`] will remove the configuration when dropped.
+    pub fn set(self, dev: &Device) -> Result<ConfigToken> {
+        let (_clk_list, clk_names) = match &self.clk_names {
+            Some(x) => {
+                let list = to_c_str_array(x)?;
+                let ptr = list.as_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null()),
+        };
+
+        let (_regulator_list, regulator_names) = match &self.regulator_names {
+            Some(x) => {
+                let list = to_c_str_array(x)?;
+                let ptr = list.as_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null()),
+        };
+
+        let prop_name = self
+            .prop_name
+            .as_ref()
+            .map_or(ptr::null(), |p| p.as_char_ptr());
+
+        let (supported_hw, supported_hw_count) = self
+            .supported_hw
+            .as_ref()
+            .map_or((ptr::null(), 0), |hw| (hw.as_ptr(), hw.len() as u32));
+
+        let (required_dev, required_dev_index) = self
+            .required_dev
+            .as_ref()
+            .map_or((ptr::null_mut(), 0), |(dev, idx)| (dev.as_raw(), *idx));
+
+        let mut config = bindings::dev_pm_opp_config {
+            clk_names,
+            config_clks: if T::HAS_CONFIG_CLKS {
+                Some(Self::config_clks)
+            } else {
+                None
+            },
+            prop_name,
+            regulator_names,
+            config_regulators: if T::HAS_CONFIG_REGULATORS {
+                Some(Self::config_regulators)
+            } else {
+                None
+            },
+            supported_hw,
+            supported_hw_count,
+
+            required_dev,
+            required_dev_index,
+        };
+
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements. The OPP core guarantees not to access fields of [`Config`] after this call
+        // and so we don't need to save a copy of them for future use.
+        let ret = unsafe { bindings::dev_pm_opp_set_config(dev.as_raw(), &mut config) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ConfigToken(ret))
+        }
+    }
+
+    /// Config's clk callback.
+    ///
+    /// SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn config_clks(
+        dev: *mut bindings::device,
+        opp_table: *mut bindings::opp_table,
+        opp: *mut bindings::dev_pm_opp,
+        _data: *mut kernel::ffi::c_void,
+        scaling_down: bool,
+    ) -> kernel::ffi::c_int {
+        from_result(|| {
+            // SAFETY: 'dev' is guaranteed by the C code to be valid.
+            let dev = unsafe { Device::get_device(dev) };
+            T::config_clks(
+                &dev,
+                // SAFETY: 'opp_table' is guaranteed by the C code to be valid.
+                &unsafe { Table::from_raw_table(opp_table, &dev) },
+                // SAFETY: 'opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_raw_opp(opp)? },
+                scaling_down,
+            )
+            .map(|()| 0)
+        })
+    }
+
+    /// Config's regulator callback.
+    ///
+    /// SAFETY: Called from C. Inputs must be valid pointers.
+    extern "C" fn config_regulators(
+        dev: *mut bindings::device,
+        old_opp: *mut bindings::dev_pm_opp,
+        new_opp: *mut bindings::dev_pm_opp,
+        regulators: *mut *mut bindings::regulator,
+        count: kernel::ffi::c_uint,
+    ) -> kernel::ffi::c_int {
+        from_result(|| {
+            // SAFETY: 'dev' is guaranteed by the C code to be valid.
+            let dev = unsafe { Device::get_device(dev) };
+            T::config_regulators(
+                &dev,
+                // SAFETY: 'old_opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_raw_opp(old_opp)? },
+                // SAFETY: 'new_opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_raw_opp(new_opp)? },
+                regulators,
+                count,
+            )
+            .map(|()| 0)
+        })
+    }
+}
+
 /// A reference-counted OPP table.
 ///
 /// Rust abstraction for the C `struct opp_table`.
-- 
2.31.1.272.g89b43f80a514


