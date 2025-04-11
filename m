Return-Path: <linux-pm+bounces-25231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A66A85ADC
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 13:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AF6444B51
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 11:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CB229B211;
	Fri, 11 Apr 2025 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cRtW4H0t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D66238C2F
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369164; cv=none; b=JfQpWiflMiOzvBwkFKxsDo5mAeptmOSJYPkx974Zl+X+d3WLiDE/b7KAMThS/9mQ1tPIiMWRgSNJr/udU92M7OGnWzzHB9tO6aFhOR6D6H6rCzzQve96WbYQmjQwqMwAAXQGm6uspmZV1rcRqXD/4zsMkScj/yNX9ASSo+LZarU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369164; c=relaxed/simple;
	bh=mq6O5qS36H3RIwMRrR25gHoIsocZEAS0wWbW0Y6EpWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=izdn1WOcLhUEGEBc1aYc50fvPXe9EvPBXzc6MufUvwHsWntdVlRHD7/QOHPgcq1Or8kNUi32/ZDG9/U1PUG9bXvA24CBlXnejdWe0x306R3UKCBW8d4yYB54ZPR4pSkBx1F3Gt2SLldxR0zaVM76K6duH/Z1/UacH3CA2sKKsug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cRtW4H0t; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736b0c68092so1544517b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 03:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744369161; x=1744973961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P555m9dInNA1dM2vNde2UqRrjVYEkYAH0OSSlbPCy7M=;
        b=cRtW4H0to3zBYR+aWKHc6l5w/QIKkCQtHpQmev5b2vAiunr8oFoYbjICCUUY+FChiO
         yIGYAEeVby6st9eZomVJTGtgZiF6EmTKUrxToPbakZA9fi1vhaTF6mObNB9pa3mPzVIF
         n06c21t7jDubTYEWZNwaFfKHs5zjL6KWJhxp7akOGaQR8NIYebkCf3B1J6hNanqjq6Kf
         pvnSmEGKPxu3oI7sK9ojWtgV7p4KMGY+xRK7ldBpWdDlWhxZlkFRqoS2ZGbuWhPOrXkN
         blqhnRr7zHRUKWVdMKe87TzCrtSOEKu9vUeX83bKgqOLS9brMBm/ilyweibN6xX1D1vI
         gk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369161; x=1744973961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P555m9dInNA1dM2vNde2UqRrjVYEkYAH0OSSlbPCy7M=;
        b=vg+ivEbNjuV7aNZIeF5eOoSimbo11r/TgCsxl1dfKJy8B6SWCVJbbWAGa+IaslDDeU
         9gdtHxJpg3bnRWHTlP4/0qN7abDrdEyi8p+mdB2YQlt6q5/3NjuqLgX3bpJSzXmWQCjf
         +rOZmJ2k2si/eQiuS8pET6+tfySDoThjQyWZCD7yXdKGanTs8X50SxPiEefVX8eAWiMW
         NzSXOgS9Wr3l1J0mf7VLKFjasODxgqGvDNfl9MyKEceJW2cybVqvu3lbRk5/iGmlcvQH
         /lKsCoPbNZVdFH73tH47JsYhV8W1pRiYqglHEWJqooMbTb4qqDp8veGVBRI+lCZItgUU
         uXpg==
X-Forwarded-Encrypted: i=1; AJvYcCWXZ/LqWhjEPcLSLlkhLyQ1WqR3slPiHxxMGkhLkdcoA/U3sLHjBpHdNtQNOmUNZ9FrW54qRJwLnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZNctdsKnYpF3Rx3J8iKNicWFnfEPceTHxa4gejdIDKvEO5GCy
	T/E1XMKiOFRFJMzyNMVvTqqLOUSEfndU9swO3Dcyq7ULejADyJoo16EbqjXgUq4=
X-Gm-Gg: ASbGncuTiggpc61GjPnrPKWnvpGPWRP+HBTd1FI8yd2doRlKkl1rUw+ApjSuhpDdeNR
	o6adx0/2BS4Obhho/13pvsUS86NIkO5auDh4fC3VUOki8A7F6mIlokYoEKLWNvYb1V0sAvuu+rI
	1AMVf62rNz+aXnXxzSQekDqmUB9nb70hW81Oxfqodu5Zu+0eO+87u7ntzutR7Of+LakSoau91Kr
	sJbFjN8XD7ODaCt8HvjCxmiynzqr12yQhrdaX0dTBkGcIjltNUCFgGVX6maoQTCgzhJV1rwZb0r
	NRFzejdubgRrng3HPUf7HVm0LKsThesZVfoBsxRdHQ==
X-Google-Smtp-Source: AGHT+IEkfFwyCe94bOjmjULnv83o+CRuQZhsOYhW5Y6RrKug8u/hshMXoaRE5SJ6RSPLF5S0Ew/TfQ==
X-Received: by 2002:a05:6a00:4644:b0:736:9e40:13b1 with SMTP id d2e1a72fcca58-73bd12b1315mr3071528b3a.23.1744369161489;
        Fri, 11 Apr 2025 03:59:21 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198c0bsm1180060b3a.23.2025.04.11.03.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 03:59:20 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
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
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 06/17] rust: clk: Add initial abstractions
Date: Fri, 11 Apr 2025 16:25:05 +0530
Message-Id: <15f1d8ddae565f6060f4fc2d9ee82bc179c81287.1744366571.git.viresh.kumar@linaro.org>
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

Add initial abstractions for the clk APIs. These provide the minimal
functionality needed for common use cases, making them straightforward
to introduce in the first iteration.

These will be used by Rust based cpufreq / OPP layers to begin with.

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS        |   1 +
 rust/kernel/clk.rs | 319 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |   2 +
 3 files changed, 322 insertions(+)
 create mode 100644 rust/kernel/clk.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 608689342aaf..12cde55579a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5884,6 +5884,7 @@ F:	include/linux/clk-pr*
 F:	include/linux/clk/
 F:	include/linux/of_clk.h
 F:	rust/helpers/clk.c
+F:	rust/kernel/clk.rs
 X:	drivers/clk/clkdev.c
 
 COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3)
diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
new file mode 100644
index 000000000000..477daa408587
--- /dev/null
+++ b/rust/kernel/clk.rs
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Clock abstractions.
+//!
+//! C header: [`include/linux/clk.h`](srctree/include/linux/clk.h)
+//!
+//! Reference: <https://docs.kernel.org/driver-api/clk.html>
+
+use crate::{
+    bindings,
+    device::Device,
+    error::{from_err_ptr, to_result, Result},
+    ffi::c_ulong,
+    prelude::*,
+};
+
+use core::{ops::Deref, ptr};
+
+/// The frequency unit.
+///
+/// Represents a frequency in hertz, wrapping a [`c_ulong`] value.
+///
+/// ## Examples
+///
+/// ```
+/// use kernel::clk::Hertz;
+///
+/// let hz = 1_000_000_000;
+/// let rate = Hertz(hz);
+///
+/// assert_eq!(rate.as_hz(), hz);
+/// assert_eq!(rate, Hertz(hz));
+/// assert_eq!(rate, Hertz::from_khz(hz / 1_000));
+/// assert_eq!(rate, Hertz::from_mhz(hz / 1_000_000));
+/// assert_eq!(rate, Hertz::from_ghz(hz / 1_000_000_000));
+/// ```
+#[derive(Copy, Clone, PartialEq, Eq, Debug)]
+pub struct Hertz(pub c_ulong);
+
+impl Hertz {
+    /// Create a new instance from kilohertz (kHz)
+    pub fn from_khz(khz: c_ulong) -> Self {
+        Self(khz * 1_000)
+    }
+
+    /// Create a new instance from megahertz (MHz)
+    pub fn from_mhz(mhz: c_ulong) -> Self {
+        Self(mhz * 1_000_000)
+    }
+
+    /// Create a new instance from gigahertz (GHz)
+    pub fn from_ghz(ghz: c_ulong) -> Self {
+        Self(ghz * 1_000_000_000)
+    }
+
+    /// Get the frequency in hertz
+    pub fn as_hz(&self) -> c_ulong {
+        self.0
+    }
+
+    /// Get the frequency in kilohertz
+    pub fn as_khz(&self) -> c_ulong {
+        self.0 / 1_000
+    }
+
+    /// Get the frequency in megahertz
+    pub fn as_mhz(&self) -> c_ulong {
+        self.0 / 1_000_000
+    }
+
+    /// Get the frequency in gigahertz
+    pub fn as_ghz(&self) -> c_ulong {
+        self.0 / 1_000_000_000
+    }
+}
+
+impl From<Hertz> for c_ulong {
+    fn from(freq: Hertz) -> Self {
+        freq.0
+    }
+}
+
+/// A reference-counted clock.
+///
+/// Rust abstraction for the C [`struct clk`].
+///
+/// # Invariants
+///
+/// A [`Clk`] instance holds either a pointer to a valid [`struct clk`] created by the C portion of
+/// the kernel or a NULL pointer.
+///
+/// Instances of this type are reference-counted. Calling [`Clk::get`] ensures that the allocation
+/// remains valid for the lifetime of the [`Clk`].
+///
+/// ## Examples
+///
+/// The following example demonstrates how to obtain and configure a clock for a device.
+///
+/// ```
+/// use kernel::c_str;
+/// use kernel::clk::{Clk, Hertz};
+/// use kernel::device::Device;
+/// use kernel::error::Result;
+///
+/// fn configure_clk(dev: &Device) -> Result {
+///     let clk = Clk::get(dev, Some(c_str!("apb_clk")))?;
+///
+///     clk.prepare_enable()?;
+///
+///     let expected_rate = Hertz::from_ghz(1);
+///
+///     if clk.rate() != expected_rate {
+///         clk.set_rate(expected_rate)?;
+///     }
+///
+///     clk.disable_unprepare();
+///     Ok(())
+/// }
+/// ```
+///
+/// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
+#[repr(transparent)]
+pub struct Clk(*mut bindings::clk);
+
+impl Clk {
+    /// Gets [`Clk`] corresponding to a [`Device`] and a connection id.
+    ///
+    /// Equivalent to the kernel's [`clk_get`] API.
+    ///
+    /// [`clk_get`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get
+    pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+        let con_id = if let Some(name) = name {
+            name.as_ptr() as *const _
+        } else {
+            ptr::null()
+        };
+
+        // SAFETY: It is safe to call [`clk_get`] for a valid device pointer.
+        //
+        // INVARIANT: The reference-count is decremented when [`Clk`] goes out of scope.
+        Ok(Self(from_err_ptr(unsafe {
+            bindings::clk_get(dev.as_raw(), con_id)
+        })?))
+    }
+
+    /// Obtain the raw [`struct clk`] pointer.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::clk {
+        self.0
+    }
+
+    /// Enable the clock.
+    ///
+    /// Equivalent to the kernel's [`clk_enable`] API.
+    ///
+    /// [`clk_enable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_enable
+    #[inline]
+    pub fn enable(&self) -> Result {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_enable`].
+        to_result(unsafe { bindings::clk_enable(self.as_raw()) })
+    }
+
+    /// Disable the clock.
+    ///
+    /// Equivalent to the kernel's [`clk_disable`] API.
+    ///
+    /// [`clk_disable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_disable
+    #[inline]
+    pub fn disable(&self) {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_disable`].
+        unsafe { bindings::clk_disable(self.as_raw()) };
+    }
+
+    /// Prepare the clock.
+    ///
+    /// Equivalent to the kernel's [`clk_prepare`] API.
+    ///
+    /// [`clk_prepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_prepare
+    #[inline]
+    pub fn prepare(&self) -> Result {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_prepare`].
+        to_result(unsafe { bindings::clk_prepare(self.as_raw()) })
+    }
+
+    /// Unprepare the clock.
+    ///
+    /// Equivalent to the kernel's [`clk_unprepare`] API.
+    ///
+    /// [`clk_unprepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_unprepare
+    #[inline]
+    pub fn unprepare(&self) {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_unprepare`].
+        unsafe { bindings::clk_unprepare(self.as_raw()) };
+    }
+
+    /// Prepare and enable the clock.
+    ///
+    /// Equivalent to calling [`Clk::prepare`] followed by [`Clk::enable`].
+    #[inline]
+    pub fn prepare_enable(&self) -> Result {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+        // [`clk_prepare_enable`].
+        to_result(unsafe { bindings::clk_prepare_enable(self.as_raw()) })
+    }
+
+    /// Disable and unprepare the clock.
+    ///
+    /// Equivalent to calling [`Clk::disable`] followed by [`Clk::unprepare`].
+    #[inline]
+    pub fn disable_unprepare(&self) {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+        // [`clk_disable_unprepare`].
+        unsafe { bindings::clk_disable_unprepare(self.as_raw()) };
+    }
+
+    /// Get clock's rate.
+    ///
+    /// Equivalent to the kernel's [`clk_get_rate`] API.
+    ///
+    /// [`clk_get_rate`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_rate
+    #[inline]
+    pub fn rate(&self) -> Hertz {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_get_rate`].
+        Hertz(unsafe { bindings::clk_get_rate(self.as_raw()) })
+    }
+
+    /// Set clock's rate.
+    ///
+    /// Equivalent to the kernel's [`clk_set_rate`] API.
+    ///
+    /// [`clk_set_rate`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_set_rate
+    #[inline]
+    pub fn set_rate(&self, rate: Hertz) -> Result {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_set_rate`].
+        to_result(unsafe { bindings::clk_set_rate(self.as_raw(), rate.as_hz()) })
+    }
+}
+
+impl Drop for Clk {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_put`].
+        unsafe { bindings::clk_put(self.as_raw()) };
+    }
+}
+
+/// A reference-counted optional clock.
+///
+/// A lightweight wrapper around an optional [`Clk`]. An [`OptionalClk`] represents a [`Clk`] that
+/// a driver can function without but may improve performance or enable additional features when
+/// available.
+///
+/// # Invariants
+///
+/// An [`OptionalClk`] instance encapsulates a [`Clk`] with either a valid [`struct clk`] or `NULL`
+/// pointer.
+///
+/// Instances of this type are reference-counted. Calling [`OptionalClk::get`] ensures that the
+/// allocation remains valid for the lifetime of the [`OptionalClk`].
+///
+/// ## Examples
+///
+/// The following example demonstrates how to obtain and configure an optional clock for a device.
+/// The code functions correctly whether or not the clock is available.
+///
+/// ```
+/// use kernel::c_str;
+/// use kernel::clk::{OptionalClk, Hertz};
+/// use kernel::device::Device;
+/// use kernel::error::Result;
+///
+/// fn configure_clk(dev: &Device) -> Result {
+///     let clk = OptionalClk::get(dev, Some(c_str!("apb_clk")))?;
+///
+///     clk.prepare_enable()?;
+///
+///     let expected_rate = Hertz::from_ghz(1);
+///
+///     if clk.rate() != expected_rate {
+///         clk.set_rate(expected_rate)?;
+///     }
+///
+///     clk.disable_unprepare();
+///     Ok(())
+/// }
+/// ```
+///
+/// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
+pub struct OptionalClk(Clk);
+
+impl OptionalClk {
+    /// Gets [`OptionalClk`] corresponding to a [`Device`] and a connection id.
+    ///
+    /// Equivalent to the kernel's [`clk_get_optional`] API.
+    ///
+    /// [`clk_get_optional`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_optional
+    pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+        let con_id = if let Some(name) = name {
+            name.as_ptr() as *const _
+        } else {
+            ptr::null()
+        };
+
+        // SAFETY: It is safe to call [`clk_get_optional`] for a valid device pointer.
+        //
+        // INVARIANT: The reference-count is decremented when [`OptionalClk`] goes out of scope.
+        Ok(Self(Clk(from_err_ptr(unsafe {
+            bindings::clk_get_optional(dev.as_raw(), con_id)
+        })?)))
+    }
+}
+
+// Make [`OptionalClk`] behave like [`Clk`].
+impl Deref for OptionalClk {
+    type Target = Clk;
+
+    fn deref(&self) -> &Clk {
+        &self.0
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 75f78f6bfaa6..f4dcfefe94be 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -42,6 +42,8 @@
 pub mod block;
 #[doc(hidden)]
 pub mod build_assert;
+#[cfg(CONFIG_COMMON_CLK)]
+pub mod clk;
 pub mod cpumask;
 pub mod cred;
 pub mod device;
-- 
2.31.1.272.g89b43f80a514


