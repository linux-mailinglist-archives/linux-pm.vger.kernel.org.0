Return-Path: <linux-pm+bounces-21459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D74EA2A477
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 10:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC5F18816CD
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 09:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3922E418;
	Thu,  6 Feb 2025 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lm/Ns4dq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063A22E40A
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834163; cv=none; b=p0vDt6/jy8sfd8UZbITjBmQEjxNTn4HezH4o1bpIkAQKv4pTzwbPlHX98EOexDwe1rfUoeDPciQSlJw+8wMIgny5JwgyDpUtl8Zg7/zdQzYi6UvtFDPE6r/stDd8uU4/bjwkdgkB4Y7A4Ws3hYnVHS9ZUIl80hWNj52KK/1xHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834163; c=relaxed/simple;
	bh=bPUupsLrIu41ca6hGCG0wALTX0HU8RTO1Tyl+R7nuzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SIXy9rjuVi5ZmOpDPA6g1uuTKL4NBs2CBKff72nrTEkYx65f6tmamkDxORdBkS+R8rhY7R5Idp10S6btW9QgxJ3iVXIPq9NO3LPRlbklKNvZQO4FxZu3mIhjXPjoN2XIihs4Y18WN7i4N04zsEjKa6MEoLTGU5VSVu1aZEhmlLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lm/Ns4dq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166651f752so15132235ad.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2025 01:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738834161; x=1739438961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLPBv8n1rYnynPBOyeV9rCbHyxpotow0FwOsn2TAncA=;
        b=Lm/Ns4dqsdB0dwgmSg5i7fTwR1O77q6JMtlOemIy4E00l+8/rslXGF1rIEFbPKIFMD
         9CcKieC9aVMCc7EGh/u/JjAJjcZOoU65gadeWqDcsznN+MOjSg73doSVZsLmSsqYYfDz
         MokEPus3IJJVqWMvVoLi3UT0O8iTHstSmxy7srtg0S/nH1zgxk+ofb6/q/vejKhLz607
         51SvoZM6LN+EGAsnFUzz4eiSyLFzEXutABBMbBWiM+i0+eLRVXvdFtMozOmHauf8meeE
         ssWe45iTMaD79xLZgxFrBTBiSynxf2/+ukBWOCDlxL7dUoDW7sxYdwLYVelM1MY8HwFx
         Uj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834161; x=1739438961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLPBv8n1rYnynPBOyeV9rCbHyxpotow0FwOsn2TAncA=;
        b=G4UarX7aKta8UX3DFqaupfz1WsveJaIJp1m1+4EEnjVIXlOlAUbmfZGUo3gGOwJOms
         4LjwdMxmVK2bh5oBXUlChfbiiyMcFOSVTw/oCDxwFD8NMwsi5djWs7enGCLC5305WdOn
         W2sQegimbVTP48yeuR/1aUnc055TAXySdJg+Z9FyQ6MhXL0dOC3ERGrWndgNs1MO2QM3
         jkEyP+9mcuSYE4+EGFB+eNaHRPnrsjQXwnKM3m3QLIU/K+oK3yoasOTBd/MilhNAffGg
         Qk/xFmTZ42ITRkS8K6/csA7fket0rdktcZO6oJHO4t5Cy12+lbHYWoAiqO/cw+Bg+oxn
         Srog==
X-Forwarded-Encrypted: i=1; AJvYcCWOTQgpRjMidhQvPM+r2DyBe/VaiowVARaSJSKEJpwJf9GHrkOS1cDsjeSoFhJdi5J3F7hC2L27dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytZgVzzVN242qo5xtfQhM1SeIEVYzOTqjTr9xDojVG5VYADlKf
	91vPWKEcE8vpemsLVSagYBZRVan8AB1QHNmouZcXq8TXn1U+3DTxKOLtcKVqGH8=
X-Gm-Gg: ASbGncsP16RJd3dCLaMvP3IqkSXPZaQsRwlF7jsqEvAXGHdgkrbT0JYGwwmocJ4yxvo
	yubdXdSr8LvAdJmUtN9jHN/hBiV2p4rKP04lMRDh6noV6/rfPJfbhNa3nkLVHsaTAveE/2/OeVz
	dfPZeHvozWJuTx5BvhT/hQdPL5bUQiSVMIDiBRzZd7LLJxVD4jyv6pFcP6nExvAvE88gWpocY0Y
	uwVn/6IdatoXlNgV3l2Gw6SPv2ltwm+VaXeRpb15/wlodv1PpXwrdWqeQbOBqkypmfgdOc41dHS
	0o7jv4MbKf3FtjaA8w==
X-Google-Smtp-Source: AGHT+IE/W0NhCGRwbtqLAwKKUgdYRFcvvn5hRH/Tb4ko9jZOCyaNyJuBFvVBTRIS/Hx2rkjxNWoO9g==
X-Received: by 2002:a17:902:fc86:b0:215:5625:885b with SMTP id d9443c01a7336-21f17edb780mr104861365ad.52.1738834161000;
        Thu, 06 Feb 2025 01:29:21 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368aac7fsm8129745ad.221.2025.02.06.01.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:29:20 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 07/14] rust: Add initial bindings for OPP framework
Date: Thu,  6 Feb 2025 14:58:28 +0530
Message-Id: <62c57b517a3503dee94f83f3fc284d69fb65ca1a.1738832119.git.viresh.kumar@linaro.org>
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

This commit adds initial Rust bindings for the Operating performance
points (OPP) core. This adds bindings for struct dev_pm_opp and
struct dev_pm_opp_data to begin with.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/opp.rs              | 189 ++++++++++++++++++++++++++++++++
 4 files changed, 193 insertions(+)
 create mode 100644 rust/kernel/opp.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 604717065476..cda0d2b74e29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17732,6 +17732,7 @@ F:	Documentation/devicetree/bindings/opp/
 F:	Documentation/power/opp.rst
 F:	drivers/opp/
 F:	include/linux/pm_opp.h
+F:	rust/kernel/opp.rs
 
 OPL4 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 4eadcf645df0..7f851d5907af 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -28,6 +28,7 @@
 #include <linux/phy.h>
 #include <linux/pid_namespace.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/poll.h>
 #include <linux/property.h>
 #include <linux/refcount.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 77d3b1f82154..8956f78a2805 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -64,6 +64,8 @@
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod of;
+#[cfg(CONFIG_PM_OPP)]
+pub mod opp;
 pub mod page;
 #[cfg(CONFIG_PCI)]
 pub mod pci;
diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
new file mode 100644
index 000000000000..becb33880c92
--- /dev/null
+++ b/rust/kernel/opp.rs
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Operating performance points.
+//!
+//! This module provides bindings for interacting with the OPP subsystem.
+//!
+//! C header: [`include/linux/pm_opp.h`](srctree/include/linux/pm_opp.h)
+
+use crate::{
+    bindings,
+    device::Device,
+    error::{code::*, to_result, Result},
+    types::{ARef, AlwaysRefCounted, Opaque},
+};
+
+use core::ptr;
+
+/// Dynamically created Operating performance point (OPP).
+pub struct Token {
+    dev: ARef<Device>,
+    freq: usize,
+}
+
+impl Token {
+    /// Adds an OPP dynamically.
+    pub fn new(dev: &ARef<Device>, mut data: Data) -> Result<Self> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_add_dynamic(dev.as_raw(), &mut data.0) })?;
+        Ok(Self {
+            dev: dev.clone(),
+            freq: data.freq(),
+        })
+    }
+}
+
+impl Drop for Token {
+    fn drop(&mut self) {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_remove(self.dev.as_raw(), self.freq) };
+    }
+}
+
+/// Equivalent to `struct dev_pm_opp_data` in the C Code.
+#[repr(transparent)]
+pub struct Data(bindings::dev_pm_opp_data);
+
+impl Data {
+    /// Creates new instance of [`Data`].
+    pub fn new(freq: usize, u_volt: usize, level: u32, turbo: bool) -> Self {
+        Self(bindings::dev_pm_opp_data {
+            turbo,
+            freq,
+            u_volt,
+            level,
+        })
+    }
+
+    /// Adds an OPP dynamically. The OPP is freed once the [`Token`] gets freed.
+    pub fn add_opp(self, dev: &ARef<Device>) -> Result<Token> {
+        Token::new(dev, self)
+    }
+
+    fn freq(&self) -> usize {
+        self.0.freq
+    }
+}
+
+/// Operating performance point (OPP).
+///
+/// Wraps the kernel's `struct dev_pm_opp`.
+///
+/// The pointer to `struct dev_pm_opp` is non-null and valid for the lifetime of the `OPP`
+/// instance.
+///
+/// # Invariants
+///
+/// Instances of this type are reference-counted. The reference count is incremented by the
+/// `dev_pm_opp_get()` function and decremented by `dev_pm_opp_put`. The Rust type `ARef<OPP>`
+/// represents a pointer that owns a reference count on the OPP.
+///
+/// A reference to the `OPP`, `&OPP` isn't refcounted by the Rust code.
+
+#[repr(transparent)]
+pub struct OPP(Opaque<bindings::dev_pm_opp>);
+
+// SAFETY: It's OK to send the ownership of `OPP` across thread boundaries.
+unsafe impl Send for OPP {}
+
+// SAFETY: It's OK to access `OPP` through shared references from other threads because we're
+// either accessing properties that don't change or that are properly synchronised by C code.
+unsafe impl Sync for OPP {}
+
+// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
+unsafe impl AlwaysRefCounted for OPP {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::dev_pm_opp_get(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::dev_pm_opp_put(obj.cast().as_ptr()) }
+    }
+}
+
+impl OPP {
+    /// Creates an owned reference to a [`OPP`] from a valid pointer.
+    ///
+    /// The refcount is incremented by the C code and will be decremented by `dec_ref()` when the
+    /// ARef object is dropped.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and the OPP's refcount is incremented. The
+    /// caller must also ensure that it doesn't explicitly drop the refcount of the OPP, as the
+    /// returned ARef object takes over the refcount increment on the underlying object and the
+    /// same will be dropped along with it.
+    pub unsafe fn from_raw_opp_owned(ptr: *mut bindings::dev_pm_opp) -> Result<ARef<Self>> {
+        let ptr = ptr::NonNull::new(ptr).ok_or(ENODEV)?;
+
+        // SAFETY: The safety requirements guarantee the validity of the pointer.
+        Ok(unsafe { ARef::from_raw(ptr.cast()) })
+    }
+
+    /// Creates a reference to a [`OPP`] from a valid pointer.
+    ///
+    /// The refcount is not updated by the Rust API unless the returned reference is converted to
+    /// an ARef object.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the duration of 'a.
+    pub unsafe fn from_raw_opp<'a>(ptr: *mut bindings::dev_pm_opp) -> Result<&'a Self> {
+        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
+        // duration of 'a. The cast is okay because `OPP` is `repr(transparent)`.
+        Ok(unsafe { &*ptr.cast() })
+    }
+
+    #[inline]
+    fn as_raw(&self) -> *mut bindings::dev_pm_opp {
+        self.0.get()
+    }
+
+    /// Returns the frequency of an OPP.
+    pub fn freq(&self, index: Option<u32>) -> usize {
+        let index = index.unwrap_or(0);
+
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_freq_indexed(self.as_raw(), index) }
+    }
+
+    /// Returns the voltage of an OPP.
+    pub fn voltage(&self) -> usize {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_voltage(self.as_raw()) }
+    }
+
+    /// Returns the level of an OPP.
+    pub fn level(&self) -> u32 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_level(self.as_raw()) }
+    }
+
+    /// Returns the power of an OPP.
+    pub fn power(&self) -> usize {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_power(self.as_raw()) }
+    }
+
+    /// Returns the required pstate of an OPP.
+    pub fn required_pstate(&self, index: u32) -> u32 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_required_pstate(self.as_raw(), index) }
+    }
+
+    /// Returns true if the OPP is turbo.
+    pub fn is_turbo(&self) -> bool {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_is_turbo(self.as_raw()) }
+    }
+}
-- 
2.31.1.272.g89b43f80a514


