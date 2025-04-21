Return-Path: <linux-pm+bounces-25783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3247DA94CFF
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 09:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BC616A70C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D888925A630;
	Mon, 21 Apr 2025 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqya0186"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FDA25A34E
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220204; cv=none; b=Nju9ILBFBQDXThptr/bDvdlqNwU8UIct3eey309l+dRPPZHhowhTikLLc4rx4Y7wQcnHMbF0tJNrwyw83ZabJo5G2UBEjZHryO+gCGEBYS1ThLEtcfhjsIselFZsmooOTSnZUpTWxPW+5rRHA9zL4Rqdei0vETnQCUgJgRv36lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220204; c=relaxed/simple;
	bh=XX3U6Tw7oOsV2P/lZuKJuHf6QBrB6qmqZ43oqb9nxh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qIHxkhtXGKuBJxQ+RG2n9c7dq6ZEd3/9Zcmmw9GENzRwHi+6GMlaUV12aUXRmisW1/k6RVdj15G/owbiCNno8j1eo/vm9SQx+6/NoBfjRKfWZkFKMF3JVzzA7BzKgV54B6THS2wLSg5f2o35bZdJ3PfqhPyXQkhNT81WdXVVaVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nqya0186; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso4209482a12.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 00:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745220202; x=1745825002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUcfURvD53WGE5bWpmH47J8MJLL7ClfsqTtjc7lNE8o=;
        b=nqya0186JqjskxIsDfC3ZnvvAlaU62g4q31MnEqE1L96tYTNiFy4HDdeRAiXMzLWBd
         +NjRErkznawJa6uOUV/VvWpnVrsJeKIHsiKIob5ZBexwPlHnJ+l4mjbF6wFrGagMtJZM
         wC35oKuWEHoAjQdRdc1aowtcmAIiGKhlr2zLc+STNxhCTjQZLOLbRxxyqw7G+ni+1ttM
         0z/yS2ht2NeHJemYjX3Gfels4l5K9Fn0A4oqzVEZUZ744fzOCEmCaWFOVJBMwWQJ7/b1
         XAGRavxOdEJnS0cBLAQ9OJX6c3B7/6VBiJiCnuxA62vFRs+C4rmnD6K02Gf0TGdLtqAn
         YC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745220202; x=1745825002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUcfURvD53WGE5bWpmH47J8MJLL7ClfsqTtjc7lNE8o=;
        b=FiEeOpDng+KNPJ77L1u3UOJe3twqgG3yoUAsTLxC8KpQTygByi0ENdhQeDS2Z3BT7z
         F3aAKxmybiF8Wb58z4upTHGusr9NBbBeqSdX8U7RjfS/9ahgYBK0e43mvFxi856vAJrh
         UCDhjmNYzWAi4r5y5vYuCbaflxcmKO8JHFrkjl4HV3DbzqK1ZNryf4u5uGPv5Bi7NyRr
         WAvsU5viQFwKGc2Fo/R9gQldoYG57DwgMyZkdMncbdYFsqpwRKxahK9J6011drQFnNnW
         V62ei1appp2mfIjU4ny1fqfxenssR4ZOcJiD9eFRVEO7KlUWH2/9cYKnQ2Zh50L4Vcqm
         UOnA==
X-Forwarded-Encrypted: i=1; AJvYcCWfB5BlGdNFYESpTl4jl50+vp41bDRg//hlNKqUcgBUQrkYlO75iVbFU/OGoQ6HlIplcdrklMSPwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJNipwuCUBfWtClsYqsM4cPA71A6c5QoBdcLtXGhwIXR5c6CFj
	Qc11WRwMYgCQIOML14UR89qy66zrOlXSZoAIzt+yDzirTobwuH1Fwop3NMg5bck=
X-Gm-Gg: ASbGncvZGPmbTfD/zh7wPMLdwogvu8HWF/yogNypB/2zmRSZcJyRcRBda5yLXGAed90
	vAz/m5Dyc2t9X6QJxs4MJbS1KWmvg3aAFJyxUWP3MeKYkzL3B++pvFtC6/Oj+nGJY1GZrAvAbtu
	Kl2QkT1E231VIF//kas+r+6VvZ9RzHv7GrpNtWTdPJQcFOUkfCtfxq92QDDoCza+wzp2Hroji2G
	KpttZLX8rgki57AvVqIxUpVEU0+hyL+M9EheRHHKEW2eDMomX92XEzQhLEaJ5XLD6O+95OUSowf
	jx/w+JESwxtV6CQLYJzAFbP82k2NYwyXXMeIH2KLCg==
X-Google-Smtp-Source: AGHT+IGxPhzDWRwZnKMMdpMmqReoI1r2YjBUlr0I5yZMN4NwiAXmwekxI1KwiPI6yxVBzAfNSrnxIA==
X-Received: by 2002:a17:902:db0f:b0:215:7421:262 with SMTP id d9443c01a7336-22c5357f020mr172416085ad.12.1745220202204;
        Mon, 21 Apr 2025 00:23:22 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf5382sm59318555ad.81.2025.04.21.00.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 00:23:21 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 10/15] rust: opp: Add abstractions for the configuration options
Date: Mon, 21 Apr 2025 12:52:17 +0530
Message-Id: <5394d62f356422c95866af129402878db453f25a.1745218976.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745218975.git.viresh.kumar@linaro.org>
References: <cover.1745218975.git.viresh.kumar@linaro.org>
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
index 062c2a04c52f..8b61ea8748a3 100644
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


