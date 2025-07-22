Return-Path: <linux-pm+bounces-31302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E1FB0E549
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 23:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B233A65E4C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 21:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65C22868AC;
	Tue, 22 Jul 2025 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/djLveM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0D5285C9B;
	Tue, 22 Jul 2025 21:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753218883; cv=none; b=a6jbSUwcs5isN/H3Wch26lXf8sNoBOPQjedhEMYTo7LrQ2cRcLb2fwTgswUAAywwwwx7FGDHBpMDs6ugFXHrfgqcAxoe9FH4N7RhiEYr1TUB0q+hIFOp2dOqrW6tY+YqGYX/sM9zi7zAFMM4zqgi9OzqBbuu/PCEghymQ6VixB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753218883; c=relaxed/simple;
	bh=nvd0cKs0L4bBhK9fv2WrIRaWlznWb9vJRC/jjGCje44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C7wBAFWE5b5wZUOureZKFWHjdmsniIm/LJJvRlaOwTEdG4SkUT1UpYY6EQ1MhnBlKi51UEDn31Sa8aRSUD1XH32Wmt3LFpZxrBYx6l9IMZXxBc9neAkZtv1RWtmVVDfbjfYFkp5VvhAb6nHQgFWVzNWzYwdBhcTjS7zX2L712FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/djLveM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C344CC4CEF7;
	Tue, 22 Jul 2025 21:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753218882;
	bh=nvd0cKs0L4bBhK9fv2WrIRaWlznWb9vJRC/jjGCje44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J/djLveMzKGpaOiROpT7f+oXQeqHHfTRwQF9qgt7DGBS+vhd3BrvXj/DKIOgHX/E8
	 iff4l3d6lrTDdNEEXaaBlLCZsPb1sM9aBmNhZyT9QVrRCMxngW4UrpTcDFZIK7t6tn
	 gOoadHbxH76WeFPykyAqsWx9/V6D487+PcJnXc+KVRoAOrSaSGfacZ0K+7DRj6aEEu
	 G+janDMvQUiETqV/xPK5DPRRLWr/TCEXppXIFTCTzH9Y240lgvmsqCOTp9p/GfcIXG
	 sfKXdfaZdwtm/i166GKuqCUf06N1VDJqXzQaCuE4qmdG0rNEER0pmiA2k6f/Lw7NTX
	 ePinpkhYFggPg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 22 Jul 2025 23:14:25 +0200
Subject: [PATCH 1/2] rust: Add initial interconnect framework abstractions
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-topic-icc_rs-v1-1-9da731c14603@oss.qualcomm.com>
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
In-Reply-To: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753218871; l=9313;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=DRqe5blEFEynIDjmphk+tGhlzAyumkrYp2WYtr3A20w=;
 b=TLRADbxqm8FJxVBgL63e+b6ZJerogbQ0BKE4ZOdnHYeDBnB41oI3wWu22xXH7tmHzU5TxUvhG
 zYU4yHpLMHrAwisWCCYMhAOyN11DH50Z6NapLvf/29MCoOBkPn5BHYh
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Add abstractions for icc_path handling, laying the groundwork for more
work on the subsystem.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/icc.rs              | 225 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 4 files changed, 229 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffb35359f1e2d4c286c5afef691f10421a3542a6..fbdbaa3c401d3705974f43bbd47e5a83632d33ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12735,6 +12735,7 @@ F:	drivers/interconnect/
 F:	include/dt-bindings/interconnect/
 F:	include/linux/interconnect-provider.h
 F:	include/linux/interconnect.h
+F:	rust/kernel/icc.rs
 
 INTERRUPT COUNTER DRIVER
 M:	Oleksij Rempel <o.rempel@pengutronix.de>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 84d60635e8a9baef1f1a1b2752dc0fa044f8542f..becfce3fa4794a51d817927376f77df7b8b0434d 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -53,6 +53,8 @@
 #include <linux/file.h>
 #include <linux/firmware.h>
 #include <linux/fs.h>
+#include <linux/interconnect-provider.h>
+#include <linux/interconnect.h>
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
diff --git a/rust/kernel/icc.rs b/rust/kernel/icc.rs
new file mode 100644
index 0000000000000000000000000000000000000000..3674632866954613749e78bc24b8db6f1f3c0369
--- /dev/null
+++ b/rust/kernel/icc.rs
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+
+//! Interconnect abstractions
+//!
+//! (based on clk.rs)
+//!
+//! C headers:
+//! [`include/linux/interconnect.h`](srctree/include/linux/interconnect.h)
+//! [`include/linux/interconnect-provider.h`](srctree/include/linux/interconnect-provider.h)
+//!
+//! Reference: <https://docs.kernel.org/driver-api/interconnect.html>
+
+/// The interconnect framework bandidth unit.
+///
+/// Represents a bus bandwidth request in kBps, wrapping a [`u32`] value.
+#[derive(Copy, Clone, PartialEq, Eq, Debug)]
+pub struct IccBwUnit(pub u32);
+
+impl IccBwUnit {
+    /// Create a new instance from bytes (B)
+    pub const fn from_bytes_per_sec(bps: u32) -> Self {
+        Self(bps / 1000)
+    }
+
+    /// Create a new instance from kilobytes (kB) per second
+    pub const fn from_kilobytes_per_sec(kbps: u32) -> Self {
+        Self(kbps)
+    }
+
+    /// Create a new instance from megabytes (MB) per second
+    pub const fn from_megabytes_per_sec(mbps: u32) -> Self {
+        Self(mbps * 1000)
+    }
+
+    /// Create a new instance from gigabytes (GB) per second
+    pub const fn from_gigabytes_per_sec(gbps: u32) -> Self {
+        Self(gbps * 1000 * 1000)
+    }
+
+    /// Create a new instance from bits (b) per second
+    pub const fn from_bits_per_sec(_bps: u32) -> Self {
+        Self(1)
+    }
+
+    /// Create a new instance from kilobits (kb) per second
+    pub const fn from_kilobits_per_sec(kbps: u32) -> Self {
+        Self(kbps.div_ceil(8))
+    }
+
+    /// Create a new instance from megabits (Mb) per second
+    pub const fn from_megabits_per_sec(mbps: u32) -> Self {
+        Self(mbps * 1000 / 8)
+    }
+
+    /// Create a new instance from gigabits (Gb) per second
+    pub const fn from_gigabits_per_sec(mbps: u32) -> Self {
+        Self(mbps * 1000 * 1000 / 8)
+    }
+
+    /// Get the bandwidth in bytes (B) per second
+    pub const fn as_bytes_per_sec(self) -> u32 {
+        self.0 * 1000
+    }
+
+    /// Get the bandwidth in kilobytes (kB) per second
+    pub const fn as_kilobytes_per_sec(self) -> u32 {
+        self.0
+    }
+
+    /// Get the bandwidth in megabytes (MB) per second
+    pub const fn as_megabytes_per_sec(self) -> u32 {
+        self.0 / 1000
+    }
+
+    /// Get the bandwidth in gigabytes (GB) per second
+    pub const fn as_gigabytes_per_sec(self) -> u32 {
+        self.0 / 1000 / 1000
+    }
+
+    /// Get the bandwidth in bits (b) per second
+    pub const fn as_bits_per_sec(self) -> u32 {
+        self.0 * 8 / 1000
+    }
+
+    /// Get the bandwidth in kilobits (kb) per second
+    pub const fn as_kilobits_per_sec(self) -> u32 {
+        self.0 * 8
+    }
+
+    /// Get the bandwidth in megabits (Mb) per second
+    pub const fn as_megabits_per_sec(self) -> u32 {
+        self.0 * 8 * 1000
+    }
+
+    /// Get the bandwidth in gigabits (Gb) per second
+    pub const fn as_gigabits_per_sec(self) -> u32 {
+        self.0 * 8 * 1000 * 1000
+    }
+}
+
+impl From<IccBwUnit> for u32 {
+    fn from(bw: IccBwUnit) -> Self {
+        bw.0
+    }
+}
+
+#[cfg(CONFIG_INTERCONNECT)]
+mod icc_path {
+    use super::IccBwUnit;
+    use crate::{
+        device::Device,
+        error::{Result, from_err_ptr, to_result},
+        prelude::*,
+    };
+
+    use core::ptr;
+
+    /// A reference-counted interconnect path.
+    ///
+    /// Rust abstraction for the C [`struct icc_path`]
+    ///
+    /// # Invariants
+    ///
+    /// An [`IccPath`] instance holds either a pointer to a valid [`struct icc_path`] created by
+    /// the C portion of the kernel, or a NULL pointer.
+    ///
+    /// Instances of this type are reference-counted. Calling [`IccPath::of_get`] ensures that the
+    /// allocation remains valid for the lifetime of the [`IccPath`].
+    ///
+    /// # Examples
+    ///
+    /// The following example demonstrates hwo to obtain and configure an interconnect path for
+    /// a device.
+    ///
+    /// ```
+    /// use kernel::icc_path::{IccPath, IccBwUnit};
+    /// use kernel::device::Device;
+    /// use kernel::error::Result;
+    ///
+    /// fn poke_at_bus(dev: &Device) -> Result {
+    ///     let bus_path = IccPath::of_get(dev, Some(c_str!("bus")))?;
+    ///
+    ///     bus_path.set_bw(
+    ///         IccBwUnit::from_megabits_per_sec(400),
+    ///         IccBwUnit::from_megabits_per_sec(800)
+    ///     )?;
+    ///
+    ///     // bus_path goes out of scope and self-disables if there are no other users
+    ///
+    ///     Ok(())
+    /// }
+    /// ```
+    #[repr(transparent)]
+    pub struct IccPath(*mut bindings::icc_path);
+
+    impl IccPath {
+        /// Get [`IccPath`] corresponding to a [`Device`]
+        ///
+        /// Equivalent to the kernel's of_icc_get() API.
+        pub fn of_get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+            let id = name.map_or(ptr::null(), |n| n.as_ptr());
+
+            // SAFETY: It's always safe to call [`of_icc_get`]
+            //
+            // INVARIANT: The reference count is decremented when [`IccPath`] goes out of scope
+            Ok(Self(from_err_ptr(unsafe {
+                bindings::of_icc_get(dev.as_raw(), id)
+            })?))
+        }
+
+        /// Obtain the raw [`struct icc_path`] pointer.
+        #[inline]
+        pub fn as_raw(&self) -> *mut bindings::icc_path {
+            self.0
+        }
+
+        /// Enable the path.
+        ///
+        /// Equivalent to the kernel's icc_enable() API.
+        #[inline]
+        pub fn enable(&self) -> Result {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for `icc_enable`].
+            to_result(unsafe { bindings::icc_enable(self.as_raw()) })
+        }
+
+        /// Disable the path.
+        ///
+        /// Equivalent to the kernel's icc_disable() API.
+        #[inline]
+        pub fn disable(&self) -> Result {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for `icc_disable`].
+            to_result(unsafe { bindings::icc_disable(self.as_raw()) })
+        }
+
+        /// Set the bandwidth on a path
+        ///
+        /// Equivalent to the kernel's icc_set_bw() API.
+        #[inline]
+        pub fn set_bw(&self, avg_bw: IccBwUnit, peak_bw: IccBwUnit) -> Result {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`icc_set_bw`].
+            to_result(unsafe {
+                bindings::icc_set_bw(
+                    self.as_raw(),
+                    avg_bw.as_kilobytes_per_sec(),
+                    peak_bw.as_kilobytes_per_sec(),
+                )
+            })
+        }
+    }
+
+    impl Drop for IccPath {
+        fn drop(&mut self) {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`icc_put`].
+            unsafe { bindings::icc_put(self.as_raw()) }
+        }
+    }
+}
+
+// SAFETY: An `IccPath` is always reference-counted and can be released from any thread.
+unsafe impl Send for IccPath {}
+
+#[cfg(CONFIG_INTERCONNECT)]
+pub use icc_path::*;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 87bcaa1c6b8a6291e71905e8dde60d945b654b98..60f6ac6e79cce57a8538ea0ad48f34f51af91731 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -89,6 +89,7 @@
 pub mod fmt;
 pub mod fs;
 pub mod init;
+pub mod icc;
 pub mod io;
 pub mod ioctl;
 pub mod jump_label;

-- 
2.50.1


