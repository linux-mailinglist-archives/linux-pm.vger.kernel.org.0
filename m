Return-Path: <linux-pm+bounces-27304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26830ABB5A8
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 09:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF8E3B8B94
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 07:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E9E2676F3;
	Mon, 19 May 2025 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSLARzX7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D12690C4
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638485; cv=none; b=nd2JS3/fPSjTY/6GtQTpecAJNr+qSeWN/8ieY/X4KTq0rWHe6qqf4JHxu/Rwap5eOyp3y+uXJ1WqOEw+H3MfHDiPypeI7aUgLJJW/YrnYjJ4VWqSGhmTYMKB+s/MpiHAI1ZpeZeWzm2jaoIfcoYWeejKrbhzknYyN1YvGm42vQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638485; c=relaxed/simple;
	bh=5L5Hmj+hoBZ1EgPgIOEh7N2LK8PQQuUGQGeNdU/vBY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rwB/J4ke+rrR7Cu5ISvSDiEMrsX3nTd8jr5b3h9BUDs/qQQexnhxRlS4H6YvIvv4dgGJs0G2mLQ9WuGUcG8e07eVEN3fphmX3CJB4SGvMhNICL+H/QBeW7nfFAoJLZzpmCzIPNnptxKEKeR6j/+z5OTkM1kEwIS6D1R38lFhM2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YSLARzX7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-232059c0b50so11735725ad.2
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 00:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747638482; x=1748243282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DO5+lgLPT8S/OeMtRlQPVr+3mHA37EzCb8FAlkZERxU=;
        b=YSLARzX7eH7ppZvU6+QUxmSHLz1SdFkd4y3j7eOE9gzHMCnonJ4OVkRoGY0dy/TzkD
         GFd7B0fwJH93rugUMJ7rRWxiz73Ccj/tpN7uENUIO0Nr6+HqpunLXk8MlI458qBB6AVZ
         l9/AUAyfY39CGi/zG8zB892v9uTZ/6BT9E2C+jgwHOGnRkntsoTcJlbG99Oqpwgk+pxq
         QDcS0c5WxoTxkmmBEM9N9DyVkYpgb769CDSUm9x1zRmQcwNLjCoNiSnWfFBX/glvbsgt
         SnBvZ54Xc4a7gOmw31+Zvl61WjNshgmLDqTpL5rC8figEJNYHNdWMarJRshCP9gZFPSZ
         SmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747638482; x=1748243282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DO5+lgLPT8S/OeMtRlQPVr+3mHA37EzCb8FAlkZERxU=;
        b=cVrltB2NpDTPf45YPFV5kONeB9Oh2/KwwgZBSFRHR29D0CHkin7FDHp511gdD4ros5
         dhJsWRjl6tjh5gRRNwazh8BrDfcDsOCTKv5LzUYb6Lddg0n1j2LRbUyyNx3HcXst3/aZ
         IfURhfwHo685TQWeNr7aKr9+TUMiyBxVei8bG/TTn6rxe5cVCgQ+bli76RvqODCxXh26
         9yKRZmLPd+187RwSJ6HgGvr9ix2LHmSGVF5woK7gvvoDhv+BatdkrbS+1o1WLRwDJ+zD
         FwROIS9Ay/ESmTmTZSB/+qvcbKmv+Gy5rlq26k4SJT57Jt1lOvKLoWhGWwMiNMTeT+JG
         +YxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGmsNu+YrGlfaZTnwlXl/SjVVrHv7uZ/KkXXITlCqeN4NFKghROD00TXrY/NVc/+mGIns/1Q7bEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwEjaFmdlPKpXg+hhHgi2OI6S72CEgEzsMUM27myqUT5m9cou1
	lmbpUHZJZP+C9qEUXTR8MJwo/STlf0vuSOnGbCtlVZz2uW1yZhuj70P1OJAxpnnAgTA=
X-Gm-Gg: ASbGncu8/uXpT92DCnTRlebEagVXi+WV54z9a/IYnb/2r0NqGkPuWVSf3dWRNc++aFN
	RltSBa/mTaywCogmJJwhoaDIAfLxV6rLA936RpMybrwMNooeSaS4a9wWpNYAI7nM1+BgUIJSPBE
	QHVZXlDUQ570e1AHwXLuLRb4ygcTe88UQDe4RlPZ/UK8bu/YZpT4CeuON7/hxdMrkUPUztRhkCb
	kIBq4vWBq44UkkpKbkDyqzJlRpTlmUXMGK++ISUzmufvYkFM/v0GFtEQn+0vcEWjysQ+9Pdsp2D
	y6ZEAZw7ZFicG4j/V3rVE0SyM9yvnHeQq9Q9GZTjYOTEjXS83jxs
X-Google-Smtp-Source: AGHT+IHjKKphjMeTJbrWdHGlFJHlNdpGPNMrULzrgSDDhULG3ADFXBlhrBdHy3LnjqfpGfHSVht4nA==
X-Received: by 2002:a17:903:41c7:b0:224:1221:1ab4 with SMTP id d9443c01a7336-231de317b43mr173678205ad.22.1747638482451;
        Mon, 19 May 2025 00:08:02 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac9fc8sm53183405ad.27.2025.05.19.00.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:08:01 -0700 (PDT)
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
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Andrew Ballance <andrewjballance@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V12 05/15] rust: clk: Add initial abstractions
Date: Mon, 19 May 2025 12:37:10 +0530
Message-Id: <a223f92ce22a2d1e04437559e5e8b79d392bb32a.1747634382.git.viresh.kumar@linaro.org>
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

Add initial abstractions for the clk APIs. These provide the minimal
functionality needed for common use cases, making them straightforward
to introduce in the first iteration.

These will be used by Rust based cpufreq / OPP layers to begin with.

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS        |   1 +
 rust/kernel/clk.rs | 334 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |   1 +
 3 files changed, 336 insertions(+)
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
index 000000000000..6041c6d07527
--- /dev/null
+++ b/rust/kernel/clk.rs
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Clock abstractions.
+//!
+//! C header: [`include/linux/clk.h`](srctree/include/linux/clk.h)
+//!
+//! Reference: <https://docs.kernel.org/driver-api/clk.html>
+
+use crate::ffi::c_ulong;
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
+#[cfg(CONFIG_COMMON_CLK)]
+mod common_clk {
+    use super::Hertz;
+    use crate::{
+        device::Device,
+        error::{from_err_ptr, to_result, Result},
+        prelude::*,
+    };
+
+    use core::{ops::Deref, ptr};
+
+    /// A reference-counted clock.
+    ///
+    /// Rust abstraction for the C [`struct clk`].
+    ///
+    /// # Invariants
+    ///
+    /// A [`Clk`] instance holds either a pointer to a valid [`struct clk`] created by the C
+    /// portion of the kernel or a NULL pointer.
+    ///
+    /// Instances of this type are reference-counted. Calling [`Clk::get`] ensures that the
+    /// allocation remains valid for the lifetime of the [`Clk`].
+    ///
+    /// ## Examples
+    ///
+    /// The following example demonstrates how to obtain and configure a clock for a device.
+    ///
+    /// ```
+    /// use kernel::c_str;
+    /// use kernel::clk::{Clk, Hertz};
+    /// use kernel::device::Device;
+    /// use kernel::error::Result;
+    ///
+    /// fn configure_clk(dev: &Device) -> Result {
+    ///     let clk = Clk::get(dev, Some(c_str!("apb_clk")))?;
+    ///
+    ///     clk.prepare_enable()?;
+    ///
+    ///     let expected_rate = Hertz::from_ghz(1);
+    ///
+    ///     if clk.rate() != expected_rate {
+    ///         clk.set_rate(expected_rate)?;
+    ///     }
+    ///
+    ///     clk.disable_unprepare();
+    ///     Ok(())
+    /// }
+    /// ```
+    ///
+    /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
+    #[repr(transparent)]
+    pub struct Clk(*mut bindings::clk);
+
+    impl Clk {
+        /// Gets [`Clk`] corresponding to a [`Device`] and a connection id.
+        ///
+        /// Equivalent to the kernel's [`clk_get`] API.
+        ///
+        /// [`clk_get`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get
+        pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+            let con_id = if let Some(name) = name {
+                name.as_ptr()
+            } else {
+                ptr::null()
+            };
+
+            // SAFETY: It is safe to call [`clk_get`] for a valid device pointer.
+            //
+            // INVARIANT: The reference-count is decremented when [`Clk`] goes out of scope.
+            Ok(Self(from_err_ptr(unsafe {
+                bindings::clk_get(dev.as_raw(), con_id)
+            })?))
+        }
+
+        /// Obtain the raw [`struct clk`] pointer.
+        #[inline]
+        pub fn as_raw(&self) -> *mut bindings::clk {
+            self.0
+        }
+
+        /// Enable the clock.
+        ///
+        /// Equivalent to the kernel's [`clk_enable`] API.
+        ///
+        /// [`clk_enable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_enable
+        #[inline]
+        pub fn enable(&self) -> Result {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // [`clk_enable`].
+            to_result(unsafe { bindings::clk_enable(self.as_raw()) })
+        }
+
+        /// Disable the clock.
+        ///
+        /// Equivalent to the kernel's [`clk_disable`] API.
+        ///
+        /// [`clk_disable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_disable
+        #[inline]
+        pub fn disable(&self) {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // [`clk_disable`].
+            unsafe { bindings::clk_disable(self.as_raw()) };
+        }
+
+        /// Prepare the clock.
+        ///
+        /// Equivalent to the kernel's [`clk_prepare`] API.
+        ///
+        /// [`clk_prepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_prepare
+        #[inline]
+        pub fn prepare(&self) -> Result {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // [`clk_prepare`].
+            to_result(unsafe { bindings::clk_prepare(self.as_raw()) })
+        }
+
+        /// Unprepare the clock.
+        ///
+        /// Equivalent to the kernel's [`clk_unprepare`] API.
+        ///
+        /// [`clk_unprepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_unprepare
+        #[inline]
+        pub fn unprepare(&self) {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // [`clk_unprepare`].
+            unsafe { bindings::clk_unprepare(self.as_raw()) };
+        }
+
+        /// Prepare and enable the clock.
+        ///
+        /// Equivalent to calling [`Clk::prepare`] followed by [`Clk::enable`].
+        #[inline]
+        pub fn prepare_enable(&self) -> Result {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // [`clk_prepare_enable`].
+            to_result(unsafe { bindings::clk_prepare_enable(self.as_raw()) })
+        }
+
+        /// Disable and unprepare the clock.
+        ///
+        /// Equivalent to calling [`Clk::disable`] followed by [`Clk::unprepare`].
+        #[inline]
+        pub fn disable_unprepare(&self) {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // [`clk_disable_unprepare`].
+            unsafe { bindings::clk_disable_unprepare(self.as_raw()) };
+        }
+
+        /// Get clock's rate.
+        ///
+        /// Equivalent to the kernel's [`clk_get_rate`] API.
+        ///
+        /// [`clk_get_rate`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_rate
+        #[inline]
+        pub fn rate(&self) -> Hertz {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // [`clk_get_rate`].
+            Hertz(unsafe { bindings::clk_get_rate(self.as_raw()) })
+        }
+
+        /// Set clock's rate.
+        ///
+        /// Equivalent to the kernel's [`clk_set_rate`] API.
+        ///
+        /// [`clk_set_rate`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_set_rate
+        #[inline]
+        pub fn set_rate(&self, rate: Hertz) -> Result {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // [`clk_set_rate`].
+            to_result(unsafe { bindings::clk_set_rate(self.as_raw(), rate.as_hz()) })
+        }
+    }
+
+    impl Drop for Clk {
+        fn drop(&mut self) {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_put`].
+            unsafe { bindings::clk_put(self.as_raw()) };
+        }
+    }
+
+    /// A reference-counted optional clock.
+    ///
+    /// A lightweight wrapper around an optional [`Clk`]. An [`OptionalClk`] represents a [`Clk`]
+    /// that a driver can function without but may improve performance or enable additional
+    /// features when available.
+    ///
+    /// # Invariants
+    ///
+    /// An [`OptionalClk`] instance encapsulates a [`Clk`] with either a valid [`struct clk`] or
+    /// `NULL` pointer.
+    ///
+    /// Instances of this type are reference-counted. Calling [`OptionalClk::get`] ensures that the
+    /// allocation remains valid for the lifetime of the [`OptionalClk`].
+    ///
+    /// ## Examples
+    ///
+    /// The following example demonstrates how to obtain and configure an optional clock for a
+    /// device. The code functions correctly whether or not the clock is available.
+    ///
+    /// ```
+    /// use kernel::c_str;
+    /// use kernel::clk::{OptionalClk, Hertz};
+    /// use kernel::device::Device;
+    /// use kernel::error::Result;
+    ///
+    /// fn configure_clk(dev: &Device) -> Result {
+    ///     let clk = OptionalClk::get(dev, Some(c_str!("apb_clk")))?;
+    ///
+    ///     clk.prepare_enable()?;
+    ///
+    ///     let expected_rate = Hertz::from_ghz(1);
+    ///
+    ///     if clk.rate() != expected_rate {
+    ///         clk.set_rate(expected_rate)?;
+    ///     }
+    ///
+    ///     clk.disable_unprepare();
+    ///     Ok(())
+    /// }
+    /// ```
+    ///
+    /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
+    pub struct OptionalClk(Clk);
+
+    impl OptionalClk {
+        /// Gets [`OptionalClk`] corresponding to a [`Device`] and a connection id.
+        ///
+        /// Equivalent to the kernel's [`clk_get_optional`] API.
+        ///
+        /// [`clk_get_optional`]:
+        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_optional
+        pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+            let con_id = if let Some(name) = name {
+                name.as_ptr()
+            } else {
+                ptr::null()
+            };
+
+            // SAFETY: It is safe to call [`clk_get_optional`] for a valid device pointer.
+            //
+            // INVARIANT: The reference-count is decremented when [`OptionalClk`] goes out of
+            // scope.
+            Ok(Self(Clk(from_err_ptr(unsafe {
+                bindings::clk_get_optional(dev.as_raw(), con_id)
+            })?)))
+        }
+    }
+
+    // Make [`OptionalClk`] behave like [`Clk`].
+    impl Deref for OptionalClk {
+        type Target = Clk;
+
+        fn deref(&self) -> &Clk {
+            &self.0
+        }
+    }
+}
+
+#[cfg(CONFIG_COMMON_CLK)]
+pub use common_clk::*;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 75f78f6bfaa6..3fd7c17cbc06 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -42,6 +42,7 @@
 pub mod block;
 #[doc(hidden)]
 pub mod build_assert;
+pub mod clk;
 pub mod cpumask;
 pub mod cred;
 pub mod device;
-- 
2.31.1.272.g89b43f80a514


