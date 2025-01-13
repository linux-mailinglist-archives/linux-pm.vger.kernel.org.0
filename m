Return-Path: <linux-pm+bounces-20310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4D7A0B569
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 12:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C02407A4250
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7241B23DEA6;
	Mon, 13 Jan 2025 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QeGxawUt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4C23DEA4
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767437; cv=none; b=g9420Yf7aPk6ooT5DlwNQr24KdSQMxtNTb+vsMOeAvlTP0+gX2IZBJx2IBioE/v505407Id6WXYqqE1B5ihBtPp+zWnDBecpn+Kupf1mT12c0LR5YBALU7lWzs3BB80pGFaCkvFqYMcPYEuBBqI2FJgPnj+c0qXw5JycXqLjiXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767437; c=relaxed/simple;
	bh=fhjAe+tZdJoItHGU3pbD+/oYCE2BaIDZH25E8DWX9nw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f0wUVWbHU/6Icnx6LUQ4XOmheO26lwnJqyBTsm72jPFK5EniYidquT06PJgVKDguregL07dIEMhhkZ4nxcBdP6YmehMCYj76mycuXVvN+FQk0ScTs3MJkIC0iXKIVX9KE1HB9HXK2bGs7p5Tq8ADODnaKrcJy3HZoI/yPwYFaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QeGxawUt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216401de828so66447585ad.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 03:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736767435; x=1737372235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czbTFxrFTC6BGzHp/oKzcB8oNYeLUKg2TzQ6UGtz5yk=;
        b=QeGxawUtpUaYPyl8MXwU04iGVaWdgKk9OXtLGWlKFqfNxFgWYcdPpzXrAc4+RrTwzA
         vY2DoMxneziblh8fGvMg7+rTjXOSI+tcw+iOWE+rKzJkYSJ1Nbv63F909FCLN7h8VNJE
         IU3nm3Vct7dsE9QqL5ub5CTYRhJU1usDc8G2S19a9kslaSwJ/j8H63vW69yAbzHUI9Uq
         uBcZqIvFoeCthzObNhs/sCFoTy/fFppGiW8S9hKNne/Qry91FxVorXxBuI9DfwIEmnD2
         vTTtyW1+zGeU2uQixeHWQmPLdn5Dqx2m5E/A8/8GkeSNOHQ7gFpj0e71g7jZqrlc5js1
         5OHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767435; x=1737372235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czbTFxrFTC6BGzHp/oKzcB8oNYeLUKg2TzQ6UGtz5yk=;
        b=eHSF5Y98v2vUoQ5AbL0Ksm00ie325dcDElnxf7OCHA7e2QNJBMC4pAeAKDkqYj0386
         QePvtccyzXHOO7OCYJCuV+t70d5aGkQ7Ai/8t1oUByeRBlvuMkrgkwTfwWrDxN/9sDk/
         inWbEKuWkzT/SE9+R4B6v2ov7mFWT3T5cd7jk86O1vyNEUDPPhwuyafYybSirbxs+MMt
         AfSxP886Qm9EmsxMu4eQ5qiuUcAJmF5xlifFKFRqpxUoqMHZZRqlj85upn3d3yfYBcIP
         oA7vbCgsvCk4oUk2AJIJwxeUJalKql3qkUCUcXctxRjB7yQBrvawdMEp335Ebx7vCwGP
         jWiw==
X-Forwarded-Encrypted: i=1; AJvYcCWgZnmyo7shpGnqX86sw7iphZPRxohCLOEHJipXz5SFggzwXLG+PAQ1lQJzZCiU6FPhfZV9NlEkFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjCOZmMC19npmxJBERSzmGgQcqdIwBQlsA1k4vJNOYgugKsNN9
	frBUna4XBnTaGQkkZ5R8Fe4wQ/afiZ65WZVsR6D1K98RHems0yDMDxyJQIzWPfk=
X-Gm-Gg: ASbGncs180vW5Es8GxZjur9GqVYRh1osAUg4G2qpDZyXnu1aiKx6JzzYlQm6bsmCyzm
	vlyzsuiHiKE/XloLHcNcz4xcSj7BjesuQNd2MBLnhYv4bI58M0jbkhFvi0i8W7Eu8NRLcKGrSl/
	wgQDScpJHHB8b4j1Ls7c5h/XUyaHEsQc608o2vrscuhug3sc/g42zBs4FORZxwCle8+MFsaqtSx
	6/f9Fog+tF5qG/HwloK0ZJWfOfWVEapCSJbim/AOGPVln8M2fPcSH5Cc2Y=
X-Google-Smtp-Source: AGHT+IGieekbwx3qrgjAyDs5pUfdvjfV28c0KO0g2MvkIOQBBkbaEI8L2WbSDSmjUT3+UgBrDwIJ1Q==
X-Received: by 2002:a05:6a21:32a0:b0:1e1:abd6:ca66 with SMTP id adf61e73a8af0-1e88cfdc6f0mr35358105637.24.1736767434793;
        Mon, 13 Jan 2025 03:23:54 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4065a544sm5938475b3a.96.2025.01.13.03.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:23:54 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH V7 06/16] rust: Add bindings for cpumask
Date: Mon, 13 Jan 2025 16:53:01 +0530
Message-Id: <4f233d3f6d593ba2e1cdde68af44200cae74f6f2.1736766672.git.viresh.kumar@linaro.org>
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

This patch adds basic Rust bindings for struct cpumask.

These will be used by Rust based cpufreq / OPP core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/cpumask.rs | 85 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |  1 +
 2 files changed, 86 insertions(+)
 create mode 100644 rust/kernel/cpumask.rs

diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
new file mode 100644
index 000000000000..e3b15bc12798
--- /dev/null
+++ b/rust/kernel/cpumask.rs
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! CPU mask abstractions.
+//!
+//! C header: [`include/linux/cpumask.h`](srctree/include/linux/cpumask.h)
+
+use crate::{bindings, error::Result, prelude::ENOMEM};
+use core::ptr;
+
+/// A simple implementation of `struct cpumask` from the C code.
+pub struct Cpumask {
+    ptr: *mut bindings::cpumask,
+    owned: bool,
+}
+
+impl Cpumask {
+    /// Creates empty cpumask.
+    pub fn new() -> Result<Self> {
+        let mut ptr: *mut bindings::cpumask = ptr::null_mut();
+
+        // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
+        // is always safe to call this method.
+        if !unsafe { bindings::zalloc_cpumask_var(&mut ptr, bindings::GFP_KERNEL) } {
+            return Err(ENOMEM);
+        }
+
+        Ok(Self { ptr, owned: true })
+    }
+
+    /// Creates a new abstraction instance of an existing `struct cpumask` pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid, and non-null.
+    pub unsafe fn get_cpumask(ptr: *mut bindings::cpumask) -> Self {
+        Self { ptr, owned: false }
+    }
+
+    /// Obtain the raw `struct cpumask *`.
+    pub fn as_raw(&mut self) -> *mut bindings::cpumask {
+        self.ptr
+    }
+
+    /// Sets CPU in the cpumask.
+    ///
+    /// Update the cpumask with a single CPU.
+    pub fn set(&mut self, cpu: u32) {
+        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_set_cpus()` for any CPU.
+        unsafe { bindings::cpumask_set_cpu(cpu, self.ptr) };
+    }
+
+    /// Clears CPU in the cpumask.
+    ///
+    /// Update the cpumask with a single CPU.
+    pub fn clear(&mut self, cpu: i32) {
+        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_clear_cpu()` for any CPU.
+        unsafe { bindings::cpumask_clear_cpu(cpu, self.ptr) };
+    }
+
+    /// Sets all CPUs in the cpumask.
+    pub fn set_all(&mut self) {
+        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_setall()`.
+        unsafe { bindings::cpumask_setall(self.ptr) };
+    }
+
+    /// Copies cpumask.
+    pub fn copy(&self, dstp: &mut Self) {
+        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_copy()`.
+        unsafe { bindings::cpumask_copy(dstp.as_raw(), self.ptr) };
+    }
+}
+
+impl Drop for Cpumask {
+    fn drop(&mut self) {
+        if self.owned {
+            // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe
+            // to call `free_cpumask_var()`.
+            unsafe { bindings::free_cpumask_var(self.ptr) }
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e9106b29c359..2f72e1d8a6b7 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -40,6 +40,7 @@
 #[doc(hidden)]
 pub mod build_assert;
 pub mod cpu;
+pub mod cpumask;
 pub mod cred;
 pub mod device;
 pub mod device_id;
-- 
2.31.1.272.g89b43f80a514


