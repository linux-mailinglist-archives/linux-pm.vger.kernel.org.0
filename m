Return-Path: <linux-pm+bounces-31564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A0CB154BE
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 23:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C951543B68
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 21:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7170D239E91;
	Tue, 29 Jul 2025 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bgHAhUcT"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E64D22539D;
	Tue, 29 Jul 2025 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753825124; cv=none; b=qYjUgzTzqfvnB/bIHVETYHFxObCJc7eNZA/iSt3FE5WKL801C63KtzMIeTM8Gey3b3CQRbZuDMtjHVl0OJrMCBsRkWYlQq39UY6TTu4rTpWVEhMfkhsiAsxgNSih+IydUZD3rgjXO9xit8RqvzMr7OffUr/bvpSsCxnYTKmbIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753825124; c=relaxed/simple;
	bh=hkgFerIj31qu/oTbEuKkpneIl53TRD91N1DIuth7LfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IQCMXjOT5PSEqYq8MOoan2GM4McLmLsZQIJBdsM9RzVfTLrc1wQHb6ir+ofTmT5F3HK0SCApr5tACr52oGFDau3wqQkeHvTCC2JpIS3b+hX2sfckJD7g+GlKKcmXOMIMmgBcTAar8xN79B4iltG9XvghyMoSWWM/MEDtei1rpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bgHAhUcT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753825119;
	bh=hkgFerIj31qu/oTbEuKkpneIl53TRD91N1DIuth7LfQ=;
	h=From:Date:Subject:To:Cc:From;
	b=bgHAhUcTAvTZWkevTN0KbvPNXTdDke32ZKNwOI9Vxi6zBxhYRCGY416BhH3JDRBlg
	 vFb0hxv3f/MXZszjRpHrOKi8p8jDJJJbUaYtObIhde4b75M2E8Dq/lLGj4Js2XYdS1
	 bwW0tHtgzvOxSPSCBKnUsiQfP+ZeujydeX4YYfXStUgzsX2RIl4dTMws0+y4guJ9Kj
	 g3+eBu8k/Ph+ecE9gvi24epqOmY8Q8paLpRdMyCWKCxNM6Rgvcl7ohoTwDeyFTe9jE
	 AQvavjiAU65RX9Z14Wv5NjMhgTgF/lbystF/5+7Jw6T98ZOU2ceQJx5NcDScKwkhuE
	 I3pO7JAn+U0dg==
Received: from [192.168.0.7] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0A85817E0F66;
	Tue, 29 Jul 2025 23:38:35 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 29 Jul 2025 18:38:19 -0300
Subject: [PATCH] rust: clk: use the type-state pattern
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
X-B4-Tracking: v=1; b=H4sIAEo/iWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyNL3eScbN2SyoJU3eKSxJJUXcM0SwuL1GRjCxPjRCWgpoKi1LTMCrC
 B0bG1tQDNIwwRYAAAAA==
X-Change-ID: 20250729-clk-type-state-1f988ec3843a
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, linux-clk@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

The current Clk abstraction can still be improved on the following issues:

a) It only keeps track of a count to clk_get(), which means that users have
to manually call disable() and unprepare(), or a variation of those, like
disable_unprepare().

b) It allows repeated calls to prepare() or enable(), but it keeps no track
of how often these were called, i.e., it's currently legal to write the
following:

clk.prepare();
clk.prepare();
clk.enable();
clk.enable();

And nothing gets undone on drop().

c) It adds a OptionalClk type that is probably not needed. There is no
"struct optional_clk" in C and we should probably not add one.

d) It does not let a user express the state of the clk through the
type system. For example, there is currently no way to encode that a Clk is
enabled via the type system alone.

In light of the Regulator abstraction that was recently merged, switch this
abstraction to use the type-state pattern instead. It solves both a) and b)
by establishing a number of states and the valid ways to transition between
them. It also automatically undoes any call to clk_get(), clk_prepare() and
clk_enable() as applicable on drop(), so users do not have to do anything
special before Clk goes out of scope.

It solves c) by removing the OptionalClk type, which is now simply encoded
as a Clk whose inner pointer is NULL.

It solves d) by directly encoding the state of the Clk into the type, e.g.:
Clk<Enabled> is now known to be a Clk that is enabled.

The INVARIANTS section for Clk is expanded to highlight the relationship
between the states and the respective reference counts that are owned by
each of them.

The examples are expanded to highlight how a user can transition between
states, as well as highlight some of the shortcuts built into the API.

The current implementation is also more flexible, in the sense that it
allows for more states to be added in the future. This lets us implement
different strategies for handling clocks, including one that mimics the
current API, allowing for multiple calls to prepare() and enable().

The users (cpufreq.rs/ rcpufreq_dt.rs) were updated by this patch (and not
a separate one) to reflect the new changes. This is needed, because
otherwise this patch would break the build.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
Hi Michael, Stephen, Viresh and others. I believe that we should get this
change in before more drivers start depending on clocks. It uses the same
rationale as Regulator<T>, and that was the result of some extensive
discussion, so I really believe that it is a good fit for clocks as well,
in the sense that it correctly tracks all refcounts, decrement them on drop
as needed and also provides a guarantee on the underlying state of the
clock via the type system. For instance, it is now possible to express via
the type system that a Clk is enabled, i.e.: Clk<Enabled>.

On top of that, it can constrain operations to a given state. For instance,
the current patch only offers get_rate() and set_rate() for the
Clk<Enabled> state. We can also offer it to all states, or a subset of
states as appropriate.
---
 drivers/cpufreq/rcpufreq_dt.rs |   2 +-
 rust/kernel/clk.rs             | 358 ++++++++++++++++++++++++++---------------
 rust/kernel/cpufreq.rs         |   8 +-
 3 files changed, 232 insertions(+), 136 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 94ed81644fe1c3f8a0240dede2299102a2118e73..f5dee7aba95c5c150fe75d6e2ffc2adf61c41c60 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -45,7 +45,7 @@ struct CPUFreqDTDevice {
     freq_table: opp::FreqTable,
     _mask: CpumaskVar,
     _token: Option<opp::ConfigToken>,
-    _clk: Clk,
+    _clk: Clk<kernel::clk::Unprepared>,
 }
 
 #[derive(Default)]
diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index fbcea31dbccadc29ae1db12cd77beda67a5665ee..6c8edb665c608386a36f28a2c9ec39604b5bc20d 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -85,12 +85,73 @@ mod common_clk {
         prelude::*,
     };
 
-    use core::{ops::Deref, ptr};
+    use core::{marker::PhantomData, mem::ManuallyDrop, ptr};
+
+    mod private {
+        pub trait Sealed {}
+
+        impl Sealed for super::Unprepared {}
+        impl Sealed for super::Prepared {}
+        impl Sealed for super::Enabled {}
+    }
+
+    /// A trait representing the different states that a [`Clk`] can be in.
+    pub trait ClkState: private::Sealed {
+        /// Whether the clock should be disabled when dropped.
+        const DISABLE_ON_DROP: bool;
+
+        /// Whether the clock should be unprepared when dropped.
+        const UNPREPARE_ON_DROP: bool;
+    }
+
+    /// A state where the [`Clk`] is not prepared and not enabled.
+    pub struct Unprepared;
+
+    /// A state where the [`Clk`] is prepared but not enabled.
+    pub struct Prepared;
+
+    /// A state where the [`Clk`] is both prepared and enabled.
+    pub struct Enabled;
+
+    impl ClkState for Unprepared {
+        const DISABLE_ON_DROP: bool = false;
+        const UNPREPARE_ON_DROP: bool = false;
+    }
+
+    impl ClkState for Prepared {
+        const DISABLE_ON_DROP: bool = false;
+        const UNPREPARE_ON_DROP: bool = true;
+    }
+
+    impl ClkState for Enabled {
+        const DISABLE_ON_DROP: bool = true;
+        const UNPREPARE_ON_DROP: bool = true;
+    }
+
+    /// An error that can occur when trying to convert a [`Clk`] between states.
+    pub struct Error<State: ClkState> {
+        /// The error that occurred.
+        pub error: kernel::error::Error,
+
+        /// The [`Clk`] that caused the error, so that the operation may be
+        /// retried.
+        pub clk: Clk<State>,
+    }
 
     /// A reference-counted clock.
     ///
     /// Rust abstraction for the C [`struct clk`].
     ///
+    /// A [`Clk`] instance represents a clock that can be in one of several
+    /// states: [`Unprepared`], [`Prepared`], or [`Enabled`].
+    ///
+    /// No action needs to be taken when a [`Clk`] is dropped. The calls to
+    /// `clk_unprepare()` and `clk_disable()` will be placed as applicable.
+    ///
+    /// An optional [`Clk`] is treated just like a regular [`Clk`], but its
+    /// inner `struct clk` pointer is `NULL`. This interfaces correctly with the
+    /// C API and also exposes all the methods of a regular [`Clk`] to users.
+    ///
     /// # Invariants
     ///
     /// A [`Clk`] instance holds either a pointer to a valid [`struct clk`] created by the C
@@ -99,20 +160,39 @@ mod common_clk {
     /// Instances of this type are reference-counted. Calling [`Clk::get`] ensures that the
     /// allocation remains valid for the lifetime of the [`Clk`].
     ///
-    /// ## Examples
+    /// The [`Prepared`] state is associated with a single count of
+    /// `clk_prepare()`, and the [`Enabled`] state is associated with a single
+    /// count of `clk_enable()`, and the [`Enabled`] state is associated with a
+    /// single count of `clk_prepare` and `clk_enable()`.
+    ///
+    /// All states are associated with a single count of `clk_get()`.
+    ///
+    /// # Examples
     ///
     /// The following example demonstrates how to obtain and configure a clock for a device.
     ///
     /// ```
     /// use kernel::c_str;
-    /// use kernel::clk::{Clk, Hertz};
+    /// use kernel::clk::{Clk, Enabled, Hertz, Unprepared, Prepared};
     /// use kernel::device::Device;
     /// use kernel::error::Result;
     ///
     /// fn configure_clk(dev: &Device) -> Result {
-    ///     let clk = Clk::get(dev, Some(c_str!("apb_clk")))?;
+    ///     // The fastest way is to use a version of `Clk::get` for the desired
+    ///     // state, i.e.:
+    ///     let clk: Clk<Enabled> = Clk::<Enabled>::get(dev, Some(c_str!("apb_clk")))?;
     ///
-    ///     clk.prepare_enable()?;
+    ///     // Any other state is also possible, e.g.:
+    ///     let clk: Clk<Prepared> = Clk::<Prepared>::get(dev, Some(c_str!("apb_clk")))?;
+    ///
+    ///     // Later:
+    ///     let clk: Clk<Enabled> = clk.enable().map_err(|error| {
+    ///         error.error
+    ///     })?;
+    ///
+    ///     // Note that error.clk is the original `clk` if the operation
+    ///     // failed. It is provided as a convenience so that the operation may be
+    ///     // retried in case of errors.
     ///
     ///     let expected_rate = Hertz::from_ghz(1);
     ///
@@ -120,104 +200,172 @@ mod common_clk {
     ///         clk.set_rate(expected_rate)?;
     ///     }
     ///
-    ///     clk.disable_unprepare();
+    ///     // Nothing is needed here. The drop implementation will undo any
+    ///     // operations as appropriate.
+    ///     Ok(())
+    /// }
+    ///
+    /// fn shutdown(dev: &Device, clk: Clk<Enabled>) -> Result {
+    ///     // The states can be traversed "in the reverse order" as well:
+    ///     let clk: Clk<Prepared> = clk.disable().map_err(|error| {
+    ///         error.error
+    ///     })?;
+    ///
+    ///     let clk: Clk<Unprepared> = clk.unprepare();
+    ///
     ///     Ok(())
     /// }
     /// ```
     ///
     /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
     #[repr(transparent)]
-    pub struct Clk(*mut bindings::clk);
+    pub struct Clk<T: ClkState> {
+        inner: *mut bindings::clk,
+        _phantom: core::marker::PhantomData<T>,
+    }
 
-    impl Clk {
+    impl Clk<Unprepared> {
         /// Gets [`Clk`] corresponding to a [`Device`] and a connection id.
         ///
         /// Equivalent to the kernel's [`clk_get`] API.
         ///
         /// [`clk_get`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get
-        pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+        #[inline]
+        pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Clk<Unprepared>> {
             let con_id = name.map_or(ptr::null(), |n| n.as_ptr());
 
             // SAFETY: It is safe to call [`clk_get`] for a valid device pointer.
-            //
+            let inner = from_err_ptr(unsafe { bindings::clk_get(dev.as_raw(), con_id) })?;
+
             // INVARIANT: The reference-count is decremented when [`Clk`] goes out of scope.
-            Ok(Self(from_err_ptr(unsafe {
-                bindings::clk_get(dev.as_raw(), con_id)
-            })?))
+            Ok(Self {
+                inner,
+                _phantom: PhantomData,
+            })
         }
 
-        /// Obtain the raw [`struct clk`] pointer.
+        /// Behaves the same as [`Self::get`], except when there is no clock
+        /// producer. In this case, instead of returning [`ENOENT`], it returns
+        /// a dummy [`Clk`].
         #[inline]
-        pub fn as_raw(&self) -> *mut bindings::clk {
-            self.0
+        pub fn get_optional(dev: &Device, name: Option<&CStr>) -> Result<Clk<Unprepared>> {
+            let con_id = name.map_or(ptr::null(), |n| n.as_ptr());
+
+            // SAFETY: It is safe to call [`clk_get`] for a valid device pointer.
+            let inner = from_err_ptr(unsafe { bindings::clk_get_optional(dev.as_raw(), con_id) })?;
+
+            // INVARIANT: The reference-count is decremented when [`Clk`] goes out of scope.
+            Ok(Self {
+                inner,
+                _phantom: PhantomData,
+            })
         }
 
-        /// Enable the clock.
+        /// Attempts to convert the [`Clk`] to a [`Prepared`] state.
         ///
-        /// Equivalent to the kernel's [`clk_enable`] API.
+        /// Equivalent to the kernel's [`clk_prepare`] API.
         ///
-        /// [`clk_enable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_enable
+        /// [`clk_prepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_prepare
         #[inline]
-        pub fn enable(&self) -> Result {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_enable`].
-            to_result(unsafe { bindings::clk_enable(self.as_raw()) })
+        pub fn prepare(self) -> Result<Clk<Prepared>, Error<Unprepared>> {
+            // We will be transferring the ownership of our `clk_get()` count to
+            // `Clk<Prepared>`.
+            let clk = ManuallyDrop::new(self);
+
+            // SAFETY: By the type invariants, self.0 is a valid argument for [`clk_prepare`].
+            to_result(unsafe { bindings::clk_prepare(clk.as_raw()) })
+                .map(|()| Clk {
+                    inner: clk.inner,
+                    _phantom: PhantomData,
+                })
+                .map_err(|error| Error {
+                    error,
+                    clk: ManuallyDrop::into_inner(clk),
+                })
         }
+    }
 
-        /// Disable the clock.
-        ///
-        /// Equivalent to the kernel's [`clk_disable`] API.
+    impl Clk<Prepared> {
+        /// Obtains a [`Clk`] from a [`Device`] and a connection id and prepares it.
         ///
-        /// [`clk_disable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_disable
+        /// Equivalent to calling [`Clk::get`], followed by [`Clk::prepare`],
         #[inline]
-        pub fn disable(&self) {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_disable`].
-            unsafe { bindings::clk_disable(self.as_raw()) };
+        pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Clk<Prepared>> {
+            Clk::<Unprepared>::get(dev, name)?
+                .prepare()
+                .map_err(|error| error.error)
         }
 
-        /// Prepare the clock.
+        /// Attempts to convert the [`Clk`] to an [`Unprepared`] state.
         ///
-        /// Equivalent to the kernel's [`clk_prepare`] API.
-        ///
-        /// [`clk_prepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_prepare
+        /// Equivalent to the kernel's [`clk_unprepare`] API.
         #[inline]
-        pub fn prepare(&self) -> Result {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_prepare`].
-            to_result(unsafe { bindings::clk_prepare(self.as_raw()) })
+        pub fn unprepare(self) -> Clk<Unprepared> {
+            // We will be transferring the ownership of our `clk_get()` count to
+            // `Clk<Unprepared>`.
+            let clk = ManuallyDrop::new(self);
+
+            // SAFETY: By the type invariants, self.0 is a valid argument for [`clk_unprepare`].
+            unsafe { bindings::clk_unprepare(clk.as_raw()) }
+
+            Clk {
+                inner: clk.inner,
+                _phantom: PhantomData,
+            }
         }
 
-        /// Unprepare the clock.
+        /// Attempts to convert the [`Clk`] to an [`Enabled`] state.
         ///
-        /// Equivalent to the kernel's [`clk_unprepare`] API.
+        /// Equivalent to the kernel's [`clk_enable`] API.
         ///
-        /// [`clk_unprepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_unprepare
+        /// [`clk_enable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_enable
         #[inline]
-        pub fn unprepare(&self) {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_unprepare`].
-            unsafe { bindings::clk_unprepare(self.as_raw()) };
+        pub fn enable(self) -> Result<Clk<Enabled>, Error<Prepared>> {
+            // We will be transferring the ownership of our `clk_get()` and
+            // `clk_prepare()` counts to `Clk<Enabled>`.
+            let clk = ManuallyDrop::new(self);
+
+            // SAFETY: By the type invariants, self.0 is a valid argument for [`clk_enable`].
+            to_result(unsafe { bindings::clk_enable(clk.as_raw()) })
+                .map(|()| Clk {
+                    inner: clk.inner,
+                    _phantom: PhantomData,
+                })
+                .map_err(|error| Error {
+                    error,
+                    clk: ManuallyDrop::into_inner(clk),
+                })
         }
+    }
 
-        /// Prepare and enable the clock.
+    impl Clk<Enabled> {
+        /// Gets [`Clk`] corresponding to a [`Device`] and a connection id and
+        /// then prepares and enables it.
         ///
-        /// Equivalent to calling [`Clk::prepare`] followed by [`Clk::enable`].
+        /// Equivalent to calling [`Clk::get`], followed by [`Clk::prepare`],
+        /// followed by [`Clk::enable`].
         #[inline]
-        pub fn prepare_enable(&self) -> Result {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_prepare_enable`].
-            to_result(unsafe { bindings::clk_prepare_enable(self.as_raw()) })
+        pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Clk<Enabled>> {
+            Clk::<Prepared>::get(dev, name)?
+                .enable()
+                .map_err(|error| error.error)
         }
 
-        /// Disable and unprepare the clock.
-        ///
-        /// Equivalent to calling [`Clk::disable`] followed by [`Clk::unprepare`].
         #[inline]
-        pub fn disable_unprepare(&self) {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_disable_unprepare`].
-            unsafe { bindings::clk_disable_unprepare(self.as_raw()) };
+        /// Attempts to disable the [`Clk`] and convert it to the [`Prepared`]
+        /// state.
+        pub fn disable(self) -> Result<Clk<Prepared>, Error<Enabled>> {
+            // We will be transferring the ownership of our `clk_get()` and
+            // `clk_enable()` counts to `Clk<Prepared>`.
+            let clk = ManuallyDrop::new(self);
+
+            // SAFETY: By the type invariants, self.0 is a valid argument for [`clk_disable`].
+            unsafe { bindings::clk_disable(clk.as_raw()) };
+
+            Ok(Clk {
+                inner: clk.inner,
+                _phantom: PhantomData,
+            })
         }
 
         /// Get clock's rate.
@@ -245,83 +393,27 @@ pub fn set_rate(&self, rate: Hertz) -> Result {
         }
     }
 
-    impl Drop for Clk {
-        fn drop(&mut self) {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_put`].
-            unsafe { bindings::clk_put(self.as_raw()) };
-        }
-    }
-
-    /// A reference-counted optional clock.
-    ///
-    /// A lightweight wrapper around an optional [`Clk`]. An [`OptionalClk`] represents a [`Clk`]
-    /// that a driver can function without but may improve performance or enable additional
-    /// features when available.
-    ///
-    /// # Invariants
-    ///
-    /// An [`OptionalClk`] instance encapsulates a [`Clk`] with either a valid [`struct clk`] or
-    /// `NULL` pointer.
-    ///
-    /// Instances of this type are reference-counted. Calling [`OptionalClk::get`] ensures that the
-    /// allocation remains valid for the lifetime of the [`OptionalClk`].
-    ///
-    /// ## Examples
-    ///
-    /// The following example demonstrates how to obtain and configure an optional clock for a
-    /// device. The code functions correctly whether or not the clock is available.
-    ///
-    /// ```
-    /// use kernel::c_str;
-    /// use kernel::clk::{OptionalClk, Hertz};
-    /// use kernel::device::Device;
-    /// use kernel::error::Result;
-    ///
-    /// fn configure_clk(dev: &Device) -> Result {
-    ///     let clk = OptionalClk::get(dev, Some(c_str!("apb_clk")))?;
-    ///
-    ///     clk.prepare_enable()?;
-    ///
-    ///     let expected_rate = Hertz::from_ghz(1);
-    ///
-    ///     if clk.rate() != expected_rate {
-    ///         clk.set_rate(expected_rate)?;
-    ///     }
-    ///
-    ///     clk.disable_unprepare();
-    ///     Ok(())
-    /// }
-    /// ```
-    ///
-    /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
-    pub struct OptionalClk(Clk);
-
-    impl OptionalClk {
-        /// Gets [`OptionalClk`] corresponding to a [`Device`] and a connection id.
-        ///
-        /// Equivalent to the kernel's [`clk_get_optional`] API.
-        ///
-        /// [`clk_get_optional`]:
-        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_optional
-        pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
-            let con_id = name.map_or(ptr::null(), |n| n.as_ptr());
-
-            // SAFETY: It is safe to call [`clk_get_optional`] for a valid device pointer.
-            //
-            // INVARIANT: The reference-count is decremented when [`OptionalClk`] goes out of
-            // scope.
-            Ok(Self(Clk(from_err_ptr(unsafe {
-                bindings::clk_get_optional(dev.as_raw(), con_id)
-            })?)))
+    impl<T: ClkState> Clk<T> {
+        /// Obtain the raw [`struct clk`] pointer.
+        #[inline]
+        pub fn as_raw(&self) -> *mut bindings::clk {
+            self.inner
         }
     }
 
-    // Make [`OptionalClk`] behave like [`Clk`].
-    impl Deref for OptionalClk {
-        type Target = Clk;
-
-        fn deref(&self) -> &Clk {
-            &self.0
+    impl<T: ClkState> Drop for Clk<T> {
+        fn drop(&mut self) {
+            if T::DISABLE_ON_DROP {
+                // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+                // [`clk_disable`].
+                unsafe { bindings::clk_disable(self.as_raw()) };
+            }
+
+            if T::UNPREPARE_ON_DROP {
+                // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+                // [`clk_unprepare`].
+                unsafe { bindings::clk_unprepare(self.as_raw()) };
+            }
         }
     }
 }
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index b0a9c6182aec6027f85d65a492595e8f815ae6b9..8eef0ffeb60276951737726af3c43c04d7f8dff3 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -551,8 +551,12 @@ pub fn cpus(&mut self) -> &mut cpumask::Cpumask {
     /// The caller must guarantee that the returned [`Clk`] is not dropped while it is getting used
     /// by the C code.
     #[cfg(CONFIG_COMMON_CLK)]
-    pub unsafe fn set_clk(&mut self, dev: &Device, name: Option<&CStr>) -> Result<Clk> {
-        let clk = Clk::get(dev, name)?;
+    pub unsafe fn set_clk(
+        &mut self,
+        dev: &Device,
+        name: Option<&CStr>,
+    ) -> Result<Clk<crate::clk::Unprepared>> {
+        let clk = Clk::<crate::clk::Unprepared>::get(dev, name)?;
         self.as_mut_ref().clk = clk.as_raw();
         Ok(clk)
     }

---
base-commit: bc27a30feb4932493af841a14fe80d752e049f95
change-id: 20250729-clk-type-state-1f988ec3843a

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


