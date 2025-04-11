Return-Path: <linux-pm+bounces-25236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9358A85AF0
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 13:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A20919E0DDD
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101F829DB6A;
	Fri, 11 Apr 2025 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDah7i/d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB34C29CB53
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369183; cv=none; b=ESyOmAcOh+kXxEybsh4NrPQP0+IbHm0w9PNVS1KxyjjQvMxUh/7u20L7+xrCdO2RyFVeAV9nK5iN4ZgE2M5zH+B/N9FOBiaYa2KWHO22XOQq6VGfuw/0HVjqTUKCk7x8SLqyatJ2tYps2sCqmqy8bckhnayAPYQms7frAm/XJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369183; c=relaxed/simple;
	bh=v6QFll9/klY1IijI3W5e++N6keitgxvRHdj/+o5bFOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b8wxCGdhB9aahVOj33TMFctEfNki80zH817h4Bu5CoTESmMc0kKRZI3TbgLNKJkF4ni79VBOGNeGFuiLj6U9IuLHYX3OOeq1fiuOh9cB55YhsySEmawqabvy5EvYrhSYd1H5kHtBsGUGTIpKUVMtEkANJ/yt5YnjT32wWZDWH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NDah7i/d; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22622ddcc35so23510885ad.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 03:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744369180; x=1744973980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhbWqejZNQm6P0aBusiZGVh4RlUEh1rM32mYI+OrPGo=;
        b=NDah7i/d2lGlF1JaXRAqmB9m5w6lvNHGuuvxPeVJhgNVesxNZFeMpcJTcsAwulWnFr
         rTwFMhX2PLoMwToP2el9yIctbjdQesp+x4qys/G+G2ZhAUyTaUqE3DEwobSY+vmFzT1j
         4JiLojF+48XOmHGB2/M5JclEOUDY6rZoKxauHunEN0R+tQDx4USkI9k+ldtayZtV6joB
         WS2EGtdjDWo51sV4VJH9N2wHzWNz+ZQcJ+E6MXjmLyLRUToHNU7TTw9cVctKukymaIcQ
         APvSoGMhjfwhncsElUkF+nauRpFKxc1zw6IuWNmw30A6oh/f4blEx2OyabYN21D5yXcf
         dWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369180; x=1744973980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhbWqejZNQm6P0aBusiZGVh4RlUEh1rM32mYI+OrPGo=;
        b=bO3wC6yl1Kx5AzbjyMJ/z20u+UKqaVfZ8l9I+BhN3UB687iAmskAZWIcSBl5MOHQ1G
         DPYyl31HYhyMqljjplmz2wNRhvqotu0ZHufU3tI8MCA/C52WCMm+qo0Vvcs+OVAYMa/S
         o2cYfiMg0nfh5O9BwuonWPG6XJPFgw6hdeQm8D6893Is5IBVYr+PI4hkreVWYrRpzNsI
         h5e5ZH3S1kCAXoFgRfQCQyIXIGtQjqen+MlsogrVeG0zfyMN2OG03fuxOb7IiKziN6t4
         8tygdQiv+ERaLYjtx5HIEAuXS9zmTuLAzBbtbVDl4jEV79GI3FOs3cC4WAE/WzkZOYCj
         juMw==
X-Forwarded-Encrypted: i=1; AJvYcCV1hvcNm01LB6JnGAeyoMkPHOdr+mfJt+LxQ0SNY3i7SpQiBbvSZ9T3NEbOxc7o01k8/oKRT9s1hw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52TIXbSGIpY4xKE5JwBecP6LEVter9eoVe/ah3BB0EHhjwbuj
	HU/KLEyhdG7XqNknpbw3jWVP3JtSB52DVfnnPwkVSM0f8xprZ3ObgEYBGTJanhA=
X-Gm-Gg: ASbGncsNVs07xKV+EVMo7gOSo7KbJYfthfh4V5C4ZpCforHcFEE084bHG5bzEFTy8zs
	mqnl3kZ01tY+7yAg/NIn6Ts121sCMCLFHORACGTOeXA1iw4KYVTZR8JCJQzizDo+NUN0sbi1+qy
	yZIJ1IrKLlbldezDrDRp8zM48mJhn2G5Qtr9b9NaSx0i8HyTmhgpeGse413nLBUFV9YBxjvkoVq
	KjfKEyJ25JnNGAsnwH7H3nhJrPdJ7BS+0GEN/PG3qvPoeb1c2o7pcB/F2s+AC6dBEcmUMXxEhaJ
	KXtAwz/LLKmJiKsFM9jMRwgWlmusYHpK5tD9ZouRtw==
X-Google-Smtp-Source: AGHT+IGNPuH6cJTfNjOfoEbs5WUXszgit60bS/Bc3QN65T7yHRlnKlORXUIy3dKlujs451m55yaYUg==
X-Received: by 2002:a17:903:1450:b0:223:6180:1bea with SMTP id d9443c01a7336-22bea4ef0b3mr34466755ad.37.1744369180051;
        Fri, 11 Apr 2025 03:59:40 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8bcd7sm46107215ad.88.2025.04.11.03.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 03:59:39 -0700 (PDT)
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
Subject: [PATCH V9 11/17] rust: opp: Add abstractions for the OPP table
Date: Fri, 11 Apr 2025 16:25:10 +0530
Message-Id: <1961fd9a4ef44dbda18a63eb832dc3a3176c2314.1744366571.git.viresh.kumar@linaro.org>
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

Introduce Rust abstractions for `struct opp_table`, enabling access to
OPP tables from Rust.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 495 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 494 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index e4780b41664f..e074009e4b7a 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -11,8 +11,9 @@
 use crate::{
     bindings,
     clk::Hertz,
+    cpumask::{Cpumask, CpumaskVar},
     device::Device,
-    error::{code::*, to_result, Result},
+    error::{code::*, from_err_ptr, to_result, Error, Result},
     ffi::c_ulong,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
@@ -172,6 +173,477 @@ fn freq(&self) -> Hertz {
     }
 }
 
+/// [`OPP`] search options.
+///
+/// ## Examples
+///
+/// Defines how to search for an [`OPP`] in a [`Table`] relative to a frequency.
+///
+/// ```
+/// use kernel::clk::Hertz;
+/// use kernel::error::Result;
+/// use kernel::opp::{OPP, SearchType, Table};
+/// use kernel::types::ARef;
+///
+/// fn find_opp(table: &Table, freq: Hertz) -> Result<ARef<OPP>> {
+///     let opp = table.opp_from_freq(freq, Some(true), None, SearchType::Exact)?;
+///
+///     pr_info!("OPP frequency is: {:?}\n", opp.freq(None));
+///     pr_info!("OPP voltage is: {:?}\n", opp.voltage());
+///     pr_info!("OPP level is: {}\n", opp.level());
+///     pr_info!("OPP power is: {:?}\n", opp.power());
+///
+///     Ok(opp)
+/// }
+/// ```
+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
+pub enum SearchType {
+    /// Match the exact frequency.
+    Exact,
+    /// Find the highest frequency less than or equal to the given value.
+    Floor,
+    /// Find the lowest frequency greater than or equal to the given value.
+    Ceil,
+}
+
+/// A reference-counted OPP table.
+///
+/// Rust abstraction for the C `struct opp_table`.
+///
+/// # Invariants
+///
+/// The pointer stored in `Self` is non-null and valid for the lifetime of the [`Table`].
+///
+/// Instances of this type are reference-counted.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to get OPP [`Table`] for a [`Cpumask`] and set its
+/// frequency.
+///
+/// ```
+/// use kernel::clk::Hertz;
+/// use kernel::cpumask::Cpumask;
+/// use kernel::device::Device;
+/// use kernel::error::Result;
+/// use kernel::opp::Table;
+/// use kernel::types::ARef;
+///
+/// fn get_table(dev: &ARef<Device>, mask: &mut Cpumask, freq: Hertz) -> Result<Table> {
+///     let mut opp_table = Table::from_of_cpumask(dev, mask)?;
+///
+///     if opp_table.opp_count()? == 0 {
+///         return Err(EINVAL);
+///     }
+///
+///     pr_info!("Max transition latency is: {} ns\n", opp_table.max_transition_latency_ns());
+///     pr_info!("Suspend frequency is: {:?}\n", opp_table.suspend_freq());
+///
+///     opp_table.set_rate(freq)?;
+///     Ok(opp_table)
+/// }
+/// ```
+pub struct Table {
+    ptr: *mut bindings::opp_table,
+    dev: ARef<Device>,
+    em: bool,
+    of: bool,
+    cpumask_box: Option<CpumaskVar>,
+}
+
+// SAFETY: It is okay to send ownership of [`Table`] across thread boundaries.
+unsafe impl Send for Table {}
+
+// SAFETY: It is okay to access [`Table`] through shared references from other threads because
+// we're either accessing properties that don't change or that are properly synchronised by C code.
+unsafe impl Sync for Table {}
+
+impl Table {
+    /// Creates a new reference-counted [`Table`] from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid and non-null.
+    unsafe fn from_raw_table(ptr: *mut bindings::opp_table, dev: &ARef<Device>) -> Self {
+        // SAFETY: By the safety requirements, ptr is valid and its refcount will be incremented.
+        //
+        // INVARIANT: The reference-count is decremented when [`Table`] goes out of scope.
+        unsafe { bindings::dev_pm_opp_get_opp_table_ref(ptr) };
+
+        Self {
+            ptr,
+            dev: dev.clone(),
+            em: false,
+            of: false,
+            cpumask_box: None,
+        }
+    }
+
+    /// Creates a new reference-counted [`Table`] instance for a [`Device`].
+    pub fn from_dev(dev: &Device) -> Result<Self> {
+        // SAFETY: The requirements are satisfied by the existence of the [`Device`] and its safety
+        // requirements.
+        //
+        // INVARIANT: The reference-count is incremented by the C code and is decremented when
+        // [`Table`] goes out of scope.
+        let ptr = from_err_ptr(unsafe { bindings::dev_pm_opp_get_opp_table(dev.as_raw()) })?;
+
+        Ok(Self {
+            ptr,
+            dev: dev.into(),
+            em: false,
+            of: false,
+            cpumask_box: None,
+        })
+    }
+
+    /// Creates a new reference-counted [`Table`] instance for a [`Device`] based on device tree
+    /// entries.
+    #[cfg(CONFIG_OF)]
+    pub fn from_of(dev: &ARef<Device>, index: i32) -> Result<Self> {
+        // SAFETY: The requirements are satisfied by the existence of the [`Device`] and its safety
+        // requirements.
+        //
+        // INVARIANT: The reference-count is incremented by the C code and is decremented when
+        // [`Table`] goes out of scope.
+        to_result(unsafe { bindings::dev_pm_opp_of_add_table_indexed(dev.as_raw(), index) })?;
+
+        // Get the newly created [`Table`].
+        let mut table = Self::from_dev(dev)?;
+        table.of = true;
+
+        Ok(table)
+    }
+
+    // Remove device tree based [`Table`].
+    #[cfg(CONFIG_OF)]
+    #[inline]
+    fn remove_of(&self) {
+        // SAFETY: The requirements are satisfied by the existence of the [`Device`] and its safety
+        // requirements. We took the reference from [`from_of`] earlier, it is safe to drop the
+        // same now.
+        unsafe { bindings::dev_pm_opp_of_remove_table(self.dev.as_raw()) };
+    }
+
+    /// Creates a new reference-counted [`Table`] instance for a [`Cpumask`] based on device tree
+    /// entries.
+    #[cfg(CONFIG_OF)]
+    pub fn from_of_cpumask(dev: &Device, cpumask: &mut Cpumask) -> Result<Self> {
+        // SAFETY: The cpumask is valid and the returned pointer will be owned by the [`Table`]
+        // instance.
+        //
+        // INVARIANT: The reference-count is incremented by the C code and is decremented when
+        // [`Table`] goes out of scope.
+        to_result(unsafe { bindings::dev_pm_opp_of_cpumask_add_table(cpumask.as_raw()) })?;
+
+        // Fetch the newly created table.
+        let mut table = Self::from_dev(dev)?;
+        table.cpumask_box = Some(CpumaskVar::try_clone(cpumask)?);
+
+        Ok(table)
+    }
+
+    // Remove device tree based [`Table`] for a [`Cpumask`].
+    #[cfg(CONFIG_OF)]
+    #[inline]
+    fn remove_of_cpumask(&self, cpumask: &Cpumask) {
+        // SAFETY: The cpumask is valid and we took the reference from [`from_of_cpumask`] earlier,
+        // it is safe to drop the same now.
+        unsafe { bindings::dev_pm_opp_of_cpumask_remove_table(cpumask.as_raw()) };
+    }
+
+    /// Returns the number of [`OPP`]s in the [`Table`].
+    pub fn opp_count(&self) -> Result<u32> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        let ret = unsafe { bindings::dev_pm_opp_get_opp_count(self.dev.as_raw()) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u32)
+        }
+    }
+
+    /// Returns max clock latency (in nanoseconds) of the [`OPP`]s in the [`Table`].
+    #[inline]
+    pub fn max_clock_latency_ns(&self) -> usize {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_clock_latency(self.dev.as_raw()) }
+    }
+
+    /// Returns max volt latency (in nanoseconds) of the [`OPP`]s in the [`Table`].
+    #[inline]
+    pub fn max_volt_latency_ns(&self) -> usize {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_volt_latency(self.dev.as_raw()) }
+    }
+
+    /// Returns max transition latency (in nanoseconds) of the [`OPP`]s in the [`Table`].
+    #[inline]
+    pub fn max_transition_latency_ns(&self) -> usize {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_transition_latency(self.dev.as_raw()) }
+    }
+
+    /// Returns the suspend [`OPP`]'s frequency.
+    #[inline]
+    pub fn suspend_freq(&self) -> Hertz {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        Hertz(unsafe { bindings::dev_pm_opp_get_suspend_opp_freq(self.dev.as_raw()) })
+    }
+
+    /// Synchronizes regulators used by the [`Table`].
+    #[inline]
+    pub fn sync_regulators(&self) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_sync_regulators(self.dev.as_raw()) })
+    }
+
+    /// Gets sharing CPUs.
+    #[inline]
+    pub fn sharing_cpus(dev: &Device, cpumask: &mut Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_get_sharing_cpus(dev.as_raw(), cpumask.as_raw()) })
+    }
+
+    /// Sets sharing CPUs.
+    pub fn set_sharing_cpus(&mut self, cpumask: &mut Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_set_sharing_cpus(self.dev.as_raw(), cpumask.as_raw())
+        })?;
+
+        if let Some(mask) = self.cpumask_box.as_mut() {
+            // Update the cpumask as this will be used while removing the table.
+            cpumask.copy(mask);
+        }
+
+        Ok(())
+    }
+
+    /// Gets sharing CPUs from device tree.
+    #[cfg(CONFIG_OF)]
+    #[inline]
+    pub fn of_sharing_cpus(dev: &Device, cpumask: &mut Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_of_get_sharing_cpus(dev.as_raw(), cpumask.as_raw())
+        })
+    }
+
+    /// Updates the voltage value for an [`OPP`].
+    #[inline]
+    pub fn adjust_voltage(
+        &self,
+        freq: Hertz,
+        volt: MicroVolt,
+        volt_min: MicroVolt,
+        volt_max: MicroVolt,
+    ) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_adjust_voltage(
+                self.dev.as_raw(),
+                freq.into(),
+                volt.into(),
+                volt_min.into(),
+                volt_max.into(),
+            )
+        })
+    }
+
+    /// Configures device with [`OPP`] matching the frequency value.
+    #[inline]
+    pub fn set_rate(&self, freq: Hertz) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_set_rate(self.dev.as_raw(), freq.into()) })
+    }
+
+    /// Configures device with [`OPP`].
+    #[inline]
+    pub fn set_opp(&self, opp: &OPP) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_set_opp(self.dev.as_raw(), opp.as_raw()) })
+    }
+
+    /// Finds [`OPP`] based on frequency.
+    pub fn opp_from_freq(
+        &self,
+        freq: Hertz,
+        available: Option<bool>,
+        index: Option<u32>,
+        stype: SearchType,
+    ) -> Result<ARef<OPP>> {
+        let raw_dev = self.dev.as_raw();
+        let index = index.unwrap_or(0);
+
+        let ptr = from_err_ptr(match stype {
+            SearchType::Exact => {
+                if let Some(available) = available {
+                    // SAFETY: The requirements are satisfied by the existence of [`Device`] and
+                    // its safety requirements. The returned pointer will be owned by the new
+                    // [`OPP`] instance.
+                    unsafe {
+                        bindings::dev_pm_opp_find_freq_exact_indexed(
+                            raw_dev,
+                            freq.into(),
+                            index,
+                            available,
+                        )
+                    }
+                } else {
+                    return Err(EINVAL);
+                }
+            }
+
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements. The returned pointer will be owned by the new [`OPP`] instance.
+            SearchType::Ceil => unsafe {
+                bindings::dev_pm_opp_find_freq_ceil_indexed(
+                    raw_dev,
+                    &mut freq.into() as *mut usize,
+                    index,
+                )
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements. The returned pointer will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_freq_floor_indexed(
+                    raw_dev,
+                    &mut freq.into() as *mut usize,
+                    index,
+                )
+            },
+        })?;
+
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        unsafe { OPP::from_raw_opp_owned(ptr) }
+    }
+
+    /// Finds [`OPP`] based on level.
+    pub fn opp_from_level(&self, mut level: u32, stype: SearchType) -> Result<ARef<OPP>> {
+        let raw_dev = self.dev.as_raw();
+
+        let ptr = from_err_ptr(match stype {
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements. The returned pointer will be owned by the new [`OPP`] instance.
+            SearchType::Exact => unsafe { bindings::dev_pm_opp_find_level_exact(raw_dev, level) },
+
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements. The returned pointer will be owned by the new [`OPP`] instance.
+            SearchType::Ceil => unsafe {
+                bindings::dev_pm_opp_find_level_ceil(raw_dev, &mut level as *mut u32)
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements. The returned pointer will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_level_floor(raw_dev, &mut level as *mut u32)
+            },
+        })?;
+
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        unsafe { OPP::from_raw_opp_owned(ptr) }
+    }
+
+    /// Finds [`OPP`] based on bandwidth.
+    pub fn opp_from_bw(&self, mut bw: u32, index: i32, stype: SearchType) -> Result<ARef<OPP>> {
+        let raw_dev = self.dev.as_raw();
+
+        let ptr = from_err_ptr(match stype {
+            // The OPP core doesn't support this yet.
+            SearchType::Exact => return Err(EINVAL),
+
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements. The returned pointer will be owned by the new [`OPP`] instance.
+            SearchType::Ceil => unsafe {
+                bindings::dev_pm_opp_find_bw_ceil(raw_dev, &mut bw as *mut u32, index)
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements. The returned pointer will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_bw_floor(raw_dev, &mut bw as *mut u32, index)
+            },
+        })?;
+
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        unsafe { OPP::from_raw_opp_owned(ptr) }
+    }
+
+    /// Enables the [`OPP`].
+    #[inline]
+    pub fn enable_opp(&self, freq: Hertz) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_enable(self.dev.as_raw(), freq.into()) })
+    }
+
+    /// Disables the [`OPP`].
+    #[inline]
+    pub fn disable_opp(&self, freq: Hertz) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_disable(self.dev.as_raw(), freq.into()) })
+    }
+
+    /// Registers with Energy model.
+    #[cfg(CONFIG_OF)]
+    pub fn of_register_em(&mut self, cpumask: &mut Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_of_register_em(self.dev.as_raw(), cpumask.as_raw())
+        })?;
+
+        self.em = true;
+        Ok(())
+    }
+
+    // Unregisters with Energy model.
+    #[cfg(all(CONFIG_OF, CONFIG_ENERGY_MODEL))]
+    #[inline]
+    fn of_unregister_em(&self) {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements. We registered with the EM framework earlier, it is safe to unregister now.
+        unsafe { bindings::em_dev_unregister_perf_domain(self.dev.as_raw()) };
+    }
+}
+
+impl Drop for Table {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe
+        // to relinquish it now.
+        unsafe { bindings::dev_pm_opp_put_opp_table(self.ptr) };
+
+        #[cfg(CONFIG_OF)]
+        {
+            #[cfg(CONFIG_ENERGY_MODEL)]
+            if self.em {
+                self.of_unregister_em();
+            }
+
+            if self.of {
+                self.remove_of();
+            } else if let Some(cpumask) = self.cpumask_box.take() {
+                self.remove_of_cpumask(&cpumask);
+            }
+        }
+    }
+}
+
 /// A reference-counted Operating performance point (OPP).
 ///
 /// Rust abstraction for the C `struct dev_pm_opp`.
@@ -185,6 +657,27 @@ fn freq(&self) -> Hertz {
 /// represents a pointer that owns a reference count on the [`OPP`].
 ///
 /// A reference to the [`OPP`], &[`OPP`], isn't refcounted by the Rust code.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to get [`OPP`] corresponding to a frequency value and
+/// configure the device with it.
+///
+/// ```
+/// use kernel::clk::Hertz;
+/// use kernel::error::Result;
+/// use kernel::opp::{SearchType, Table};
+///
+/// fn configure_opp(table: &Table, freq: Hertz) -> Result {
+///     let opp = table.opp_from_freq(freq, Some(true), None, SearchType::Exact)?;
+///
+///     if opp.freq(None) != freq {
+///         return Err(EINVAL);
+///     }
+///
+///     table.set_opp(&opp)
+/// }
+/// ```
 #[repr(transparent)]
 pub struct OPP(Opaque<bindings::dev_pm_opp>);
 
-- 
2.31.1.272.g89b43f80a514


