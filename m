Return-Path: <linux-pm+bounces-20014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EF0A03D83
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4EB1188085B
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1391F03DB;
	Tue,  7 Jan 2025 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="imchDMCv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5E1EE7A9
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248960; cv=none; b=TF6gnfc/q7xe1X0S6k7fCbjeuqwzc8qK3fuImunqb7drZii28RnqQCMgu0lvnuFoXi3644jcJWlcEoiymtxOZcnANEcdBF21AXbvpW2m6rn2EwBxTgwS/ASDhXKNEwVbsH+1Me/5tOSBoObqOVfRGZJfzdr6Vo34R/n4gAnhWyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248960; c=relaxed/simple;
	bh=RUDp97kyBFIGovesEh3TcgaS1b+pQ5Z9mu6pR3fl99c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3DC+g7hXVAB1A0nzEyWOE2qvFhtVq4XRu/4W5JiSG9rWbFnfPJ5oh2YmmBtq4hvDN/pAnbvmrVPgxx+coR99csqWNFU4OX7C6lTmiXAIwpRnlr1Kh4CUCQcPeEaAIoy9IRPOgbHPu+si8mY+K1X7IGzk2afaEbZG1Nl6vs/X+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=imchDMCv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21636268e43so44913175ad.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 03:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736248954; x=1736853754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIFfeNRkv4GqkQKjKCC5750j/cwmEcYtSCPj/U32YOk=;
        b=imchDMCv+w8TAy3vjWcgE9XvNP9VbK8C5t91iyiYGIWc7dUw8n+muy9FUpLSjMgiyS
         dqMAES6O01D1NW3ZyuHQ7oEtSR0m3IQK4tnj3xwtNY5xxGi4IrSvNKWHXIU1Pj/mYq8X
         Ds2ijfGOZJoj7pebP7QHme8zgHiDd3JFkNjvaWTH9tuPOJjilBoGLSbvEjlojMvF+9h0
         acVKFCtTLZS1/hzL4XqoyAL1lOrgKxloyTUR5FZpZlh7ybC+cAWXFWj8l4IxkuSzsmBQ
         2YEG0aETCAuapRL874yA6DWw/vWRRRaWnbrp5+VNjByW7YOuFeH4uPlUhTlkW2Ey/aXf
         YZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736248954; x=1736853754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIFfeNRkv4GqkQKjKCC5750j/cwmEcYtSCPj/U32YOk=;
        b=sSdIHYVu4e2Bc3xLRzSZmC4EEoJgm9SPm/4xsTfUn62A8cM4CLuPNrlaUjFztnuRCs
         UWeW6Jw6nmQOcMvI1CAZA6Nc4HEZLyCni6dp090iIDcuXgzo0erXJHvjDFoKfekpVc1O
         7G4z8bG1A+b1STrqfSKzqN3nM4KSCLfVxpx6toaoB7PPgHQYj2UAJghyq/CGC8b2lYAw
         ZGAoyCcJBApuCfLIUnnDk/ppUU3Qrm2J1tOPznbZ9fsW0nuf1SOrBaOaWAIdRX+WFpds
         BerIU6p7Gu5btTeFOgRobHpz2Uxmz2eTAEyd6Mq4yAuYj+4CHhAyhnxUklYNqd1moG2a
         HflA==
X-Forwarded-Encrypted: i=1; AJvYcCWP2U283qa8Hk2+CObaNBIGro7xQtMhybPfQpVwEsLiOAHO86I78jTYN0vsILPRQflEKMTT8hmduw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxum22qCMMVKGOkUrtXR0SlNukoYBEBIUZKQPItFqwNM2nmnjk
	atHZa7LcmrVGBCSg73NcmrzPgd1j3RMm4N/c7LYB6Axvw0jJdrIdomaJpWwErl4=
X-Gm-Gg: ASbGncvpdJdkVLiWxqTRJRs2giDFUQUKC5vq1XGmAfabF17hTrzWX2CgcqU8xzxslXL
	slxVyKq24FuoWKzRXCh6A5KISH7CJQLlPQVI3TRRGBBkz+y08CDgHHLgiEJz9eethXjmF8uEHu8
	iJ/swL4PHULK6ubsV7tubJYe6dLSclOS0Df0dp/UiyDICaVIXoXux5dqt2vr+8eU6SattUjnVSO
	8H7W8llge/SF6q90XKQWTsSrT6MW/Qv16V7u16zONG9uNLYJlo/hZbmGIg=
X-Google-Smtp-Source: AGHT+IH55KYIRXD8acYIT0LgyRMSyhiGlWt1eCwqBg0y7DWXZgLM7IgALGmFYuJ2JwgQHsa3MAQBEQ==
X-Received: by 2002:a17:903:186:b0:215:4450:54fb with SMTP id d9443c01a7336-219e6f28c0emr683222305ad.55.1736248954557;
        Tue, 07 Jan 2025 03:22:34 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc972734sm308868435ad.88.2025.01.07.03.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:22:34 -0800 (PST)
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
Subject: [PATCH V6 07/15] rust: Add initial bindings for OPP framework
Date: Tue,  7 Jan 2025 16:51:40 +0530
Message-Id: <3ca45b4b783d1195305a16f7db4d26b26ff3a192.1736248242.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1736248242.git.viresh.kumar@linaro.org>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds initial Rust bindings for the Operating performance
points (OPP) core. This adds bindings for `struct dev_pm_opp` and
`struct dev_pm_opp_data` to begin with.

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
index 15c8df5b3590..bfcdbe4aa119 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17579,6 +17579,7 @@ F:	Documentation/devicetree/bindings/opp/
 F:	Documentation/power/opp.rst
 F:	drivers/opp/
 F:	include/linux/pm_opp.h
+F:	rust/kernel/opp.rs
 
 OPL4 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 7a95d999ead8..5f900532e5ec 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -32,6 +32,7 @@
 #include <linux/phy.h>
 #include <linux/pid_namespace.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/poll.h>
 #include <linux/property.h>
 #include <linux/refcount.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 70694becc9ff..16e534024323 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -61,6 +61,8 @@
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod of;
+#[cfg(CONFIG_PM_OPP)]
+pub mod opp;
 pub mod page;
 pub mod pid_namespace;
 pub mod platform;
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


