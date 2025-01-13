Return-Path: <linux-pm+bounces-20315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83535A0B59D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 12:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDDC1887421
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EC41CAA60;
	Mon, 13 Jan 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="po6Qqddr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB92343A5
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767459; cv=none; b=GB5gRWe7W0pFhipi/wcye+vm2Y03Ennu9r3CWU/oBy6Yy+wpoyQZnYPi5yYBKumhJihpJr9ZDW/FAF+dcsUTfCFXLGRQQ6GWlNzBcmGRiU2X4XHmsPVqQu66UuGNI5JLhoR4Uw3xZkMAbDO0yksTTIQPb7/BmAOdkQ76YwBc+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767459; c=relaxed/simple;
	bh=2JkhyINaywtfILSPDjQ4c4dGWRyIRBju4YSZ0W0gffU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bAff17MPyVJ0z8z1nL5hlYPc9/jrGFZ4A9rA5zKjPAFOLqzOiy+DfRMa/Btol95+Bt8MKyfGpaOfblhamDG/qEv9uwke2iyDGo/YKi5DXv9rT7BPV8xt5XeJmIoS000yQl6Q5+0hZuEVDoa58vWLn6sw9/Hjbb6RX0jk3Eb3nj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=po6Qqddr; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so5481413a91.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 03:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736767456; x=1737372256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwzrLAB8Dxug2z6b+uwUwN8Azj70Ar3EfIfvsIBOHtw=;
        b=po6Qqddr7BEQ67aYfi8OPjevKVpkOAO/k60U7UdGykICPo+8cyiJZo9tqyEoLKqtv1
         3wIHbdP6GLQRKr9FXaqsi6kHxWgZ97bH25/vAUGq8rg3hq/qqD1kx/3mqXPhIXoMgpLx
         ePcjBHU99kSBQxvfjW3uxb3C3eTMSzbH4d0MvOyuSa5xJDimGpCsjsCJf+/O/D00xp/n
         GmjGa0fpSCBXBdNJLkzd/G03hkOirGU7P5rOaUkbl4z4FFvaNv5i8VIn222uy0j/j2VQ
         uRcns0W86aVS03RLF44atOJ67v7y2QUMtHSMPFhgYlQm0nLyoKjEHSEBX5T8kZ1klF0h
         cGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767456; x=1737372256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwzrLAB8Dxug2z6b+uwUwN8Azj70Ar3EfIfvsIBOHtw=;
        b=Z73jbP23RYzNb+Lw0gRkSj/70SVpm4IrkMrtG1yC4zACw0P86qinu/DZjDRYQLnQa/
         u7aCxLly//2Wv+KClsgmJMpuWlPAEmS1h+XEVEZyxUOTm1GyyArpFe/St9Y1TZTRfcYF
         vmQAeI9lXPRV+uB1swgIPFwM05QR5RvxGTrAWthFcusRLKrfW+FUEONDBZaxPPw6jN4A
         GZnk2pMnTowUgMqfZU2FNVUMuwaYAv/8jDN5xFkQPdy+IoiU0GlrcsIN5N+fikqVt/bO
         uxbNHr9Qok3hB/LuGnUdgi8M/Ei12+7F0yCD9sk105wVNT1Q7JA0ie5KMvvfLNQU6R3D
         XWOw==
X-Gm-Message-State: AOJu0YwJfu8LtJTHJuaocDz1gkwbrrFsxeT6igxGR2VcyjDfub/ypiZ8
	Dahg6VTcpSjpY59oJnJ/j7UkAECdBhwJi2kslWmsgRuDE8Julcc95cXJsB0OpMU=
X-Gm-Gg: ASbGncuKIc67zgatILYlUs+msXY/bSZt8BJAhabek/ouukHVThi10RySyGeVcQpy/UU
	Fe502hiXdGh7FTW/S06Gwc92/WqWyQvEwaFkIBmGwcxri4Bxy81Hoqmwye/LKCZ+Ag6WTwWPVmx
	nR4ig10upA0c/Z8ySsBxgjXFW2f3lzEUUm7ec5C8Xc3OelacFlFPmmi/IboNSrEBlIelzuGywMS
	imD9alemQbdYS7e9V4xtns5saWBtlKEeJ2qcXMplGHtBn0CILaQY4yeBrE=
X-Google-Smtp-Source: AGHT+IGSrjWAXG/i1/fxPFQSZ8SgGH6S3WwvH2xeaVLAPlcZxWEtSTFord1i+91CODMVAveRLw497A==
X-Received: by 2002:a17:90b:5208:b0:2ef:33a4:ae6e with SMTP id 98e67ed59e1d1-2f548eba9c4mr35243647a91.12.1736767456231;
        Mon, 13 Jan 2025 03:24:16 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f53e1d3bd0sm7704068a91.0.2025.01.13.03.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:24:15 -0800 (PST)
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
	Trevor Gross <tmgross@umich.edu>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH V7 11/16] rust: Add initial bindings for cpufreq framework
Date: Mon, 13 Jan 2025 16:53:06 +0530
Message-Id: <535b9af357a3e6735bd5543d4cb56e632ba80697.1736766672.git.viresh.kumar@linaro.org>
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

This commit adds initial Rust bindings for the cpufreq core. This adds
basic bindings for cpufreq flags, relations and cpufreq table.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/cpufreq.c          |  10 ++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/cpufreq.rs          | 231 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 6 files changed, 246 insertions(+)
 create mode 100644 rust/helpers/cpufreq.c
 create mode 100644 rust/kernel/cpufreq.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f9ebca78732..fb92356efbba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6017,6 +6017,7 @@ F:	drivers/cpufreq/
 F:	include/linux/cpufreq.h
 F:	include/linux/sched/cpufreq.h
 F:	kernel/sched/cpufreq*.c
+F:	rust/kernel/cpufreq.rs
 F:	tools/testing/selftests/cpufreq/
 
 CPU HOTPLUG
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 7f851d5907af..68bf1bc5bae8 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -12,6 +12,7 @@
 #include <linux/blkdev.h>
 #include <linux/clk.h>
 #include <linux/cpu.h>
+#include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/cred.h>
 #include <linux/errname.h>
diff --git a/rust/helpers/cpufreq.c b/rust/helpers/cpufreq.c
new file mode 100644
index 000000000000..7c1343c4d65e
--- /dev/null
+++ b/rust/helpers/cpufreq.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/cpufreq.h>
+
+#ifdef CONFIG_CPU_FREQ
+void rust_helper_cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
+{
+	cpufreq_register_em_with_opp(policy);
+}
+#endif
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index de2341cfd917..32d0462219e5 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -11,6 +11,7 @@
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
+#include "cpufreq.c"
 #include "cpumask.c"
 #include "cred.c"
 #include "device.c"
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
new file mode 100644
index 000000000000..3dfdf5ccb9b8
--- /dev/null
+++ b/rust/kernel/cpufreq.rs
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! CPU frequency scaling.
+//!
+//! This module provides bindings for interacting with the cpufreq subsystem.
+//!
+//! C header: [`include/linux/cpufreq.h`](srctree/include/linux/cpufreq.h)
+
+use crate::{
+    bindings,
+    error::{code::*, to_result, Result},
+    prelude::*,
+};
+
+use core::{
+    pin::Pin,
+};
+
+/// Default transition latency value.
+pub const ETERNAL_LATENCY: u32 = bindings::CPUFREQ_ETERNAL as u32;
+
+/// Container for cpufreq driver flags.
+pub mod flags {
+    use crate::bindings;
+
+    /// Set by drivers that need to update internal upper and lower boundaries along with the
+    /// target frequency and so the core and governors should also invoke the driver if the target
+    /// frequency does not change, but the policy min or max may have changed.
+    pub const NEED_UPDATE_LIMITS: u16 = bindings::CPUFREQ_NEED_UPDATE_LIMITS as _;
+
+    /// Set by drivers for platforms where loops_per_jiffy or other kernel "constants" aren't
+    /// affected by frequency transitions.
+    pub const CONST_LOOPS: u16 = bindings::CPUFREQ_CONST_LOOPS as _;
+
+    /// Set by drivers that want the core to automatically register the cpufreq driver as a thermal
+    /// cooling device.
+    pub const IS_COOLING_DEV: u16 = bindings::CPUFREQ_IS_COOLING_DEV as _;
+
+    /// Set by drivers for platforms that have multiple clock-domains, i.e. supporting multiple
+    /// policies. With this sysfs directories of governor would be created in cpu/cpuN/cpufreq/
+    /// directory and so they can use the same governor with different tunables for different
+    /// clusters.
+    pub const HAVE_GOVERNOR_PER_POLICY: u16 = bindings::CPUFREQ_HAVE_GOVERNOR_PER_POLICY as _;
+
+    /// Set by drivers which do POSTCHANGE notifications from outside of their ->target() routine.
+    pub const ASYNC_NOTIFICATION: u16 = bindings::CPUFREQ_ASYNC_NOTIFICATION as _;
+
+    /// Set by drivers that want cpufreq core to check if CPU is running at a frequency present in
+    /// freq-table exposed by the driver. For these drivers if CPU is found running at an out of
+    /// table freq, the cpufreq core will try to change the frequency to a value from the table.
+    /// And if that fails, it will stop further boot process by issuing a BUG_ON().
+    pub const NEED_INITIAL_FREQ_CHECK: u16 = bindings::CPUFREQ_NEED_INITIAL_FREQ_CHECK as _;
+
+    /// Set by drivers to disallow use of governors with "dynamic_switching" flag set.
+    pub const NO_AUTO_DYNAMIC_SWITCHING: u16 = bindings::CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING as _;
+}
+
+/// CPU frequency selection relations. Each value contains a `bool` argument which corresponds to
+/// the Relation being efficient.
+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
+pub enum Relation {
+    /// Select the lowest frequency at or above target.
+    Low(bool),
+    /// Select the highest frequency below or at target.
+    High(bool),
+    /// Select the closest frequency to the target.
+    Close(bool),
+}
+
+impl Relation {
+    // Converts from a value compatible with the C code.
+    fn new(val: u32) -> Result<Self> {
+        let efficient = val & bindings::CPUFREQ_RELATION_E != 0;
+
+        Ok(match val & !bindings::CPUFREQ_RELATION_E {
+            bindings::CPUFREQ_RELATION_L => Self::Low(efficient),
+            bindings::CPUFREQ_RELATION_H => Self::High(efficient),
+            bindings::CPUFREQ_RELATION_C => Self::Close(efficient),
+            _ => return Err(EINVAL),
+        })
+    }
+
+    /// Converts to a value compatible with the C code.
+    pub fn val(&self) -> u32 {
+        let (mut val, e) = match self {
+            Self::Low(e) => (bindings::CPUFREQ_RELATION_L, e),
+            Self::High(e) => (bindings::CPUFREQ_RELATION_H, e),
+            Self::Close(e) => (bindings::CPUFREQ_RELATION_C, e),
+        };
+
+        if *e {
+            val |= bindings::CPUFREQ_RELATION_E;
+        }
+
+        val
+    }
+}
+
+/// Equivalent to `struct cpufreq_policy_data` in the C code.
+#[repr(transparent)]
+pub struct PolicyData(*mut bindings::cpufreq_policy_data);
+
+impl PolicyData {
+    /// Creates new instance of [`PolicyData`].
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid and non-null.
+    pub unsafe fn from_raw_policy_data(ptr: *mut bindings::cpufreq_policy_data) -> Self {
+        Self(ptr)
+    }
+
+    /// Returns the raw pointer to the C structure.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::cpufreq_policy_data {
+        self.0
+    }
+
+    /// Provides a wrapper to the generic verify routine.
+    pub fn generic_verify(&self) -> Result<()> {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it now.
+        to_result(unsafe { bindings::cpufreq_generic_frequency_table_verify(self.as_raw()) })
+    }
+}
+
+/// Builder for the `struct cpufreq_frequency_table` in the C code.
+#[repr(transparent)]
+#[derive(Default)]
+pub struct TableBuilder {
+    entries: KVec<bindings::cpufreq_frequency_table>,
+}
+
+impl TableBuilder {
+    /// Creates new instance of [`TableBuilder`].
+    pub fn new() -> Self {
+        Self {
+            entries: KVec::new(),
+        }
+    }
+
+    /// Adds a new entry to the table.
+    pub fn add(&mut self, frequency: u32, flags: u32, driver_data: u32) -> Result<()> {
+        // Adds new entry to the end of the vector.
+        Ok(self.entries.push(
+            bindings::cpufreq_frequency_table {
+                flags,
+                driver_data,
+                frequency,
+            },
+            GFP_KERNEL,
+        )?)
+    }
+
+    /// Creates [`Table`] from [`TableBuilder`].
+    pub fn into_table(mut self) -> Result<Table> {
+        // Add last entry to the table.
+        self.add(bindings::CPUFREQ_TABLE_END as u32, 0, 0)?;
+        Table::from_builder(self.entries)
+    }
+}
+
+/// A simple implementation of the cpufreq table, equivalent to the `struct
+/// cpufreq_frequency_table` in the C code.
+pub struct Table {
+    #[allow(dead_code)]
+    // Dynamically created table.
+    entries: Option<Pin<KVec<bindings::cpufreq_frequency_table>>>,
+
+    // Pointer to the statically or dynamically created table.
+    ptr: *mut bindings::cpufreq_frequency_table,
+}
+
+impl Table {
+    /// Creates new instance of [`Table`] from [`TableBuilder`].
+    fn from_builder(entries: KVec<bindings::cpufreq_frequency_table>) -> Result<Self> {
+        if entries.is_empty() {
+            return Err(EINVAL);
+        }
+
+        // Pin the entries to memory, since we are passing its pointer to the C code.
+        let mut entries = Pin::new(entries);
+
+        // The pointer is valid until the table gets dropped.
+        let ptr = entries.as_mut_ptr();
+
+        Ok(Self {
+            entries: Some(entries),
+            ptr,
+        })
+    }
+
+    /// Creates new instance of [`Table`] from raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid and non-null for the lifetime of the [`Table`].
+    pub unsafe fn from_raw(ptr: *mut bindings::cpufreq_frequency_table) -> Self {
+        Self {
+            entries: None,
+            ptr,
+        }
+    }
+
+    /// Returns raw pointer to the `struct cpufreq_frequency_table` compatible with the C code.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::cpufreq_frequency_table {
+        self.ptr
+    }
+
+    /// Returns `frequency` at index in the [`Table`].
+    pub fn freq(&self, index: usize) -> Result<u32> {
+        // SAFETY: The pointer is guaranteed to be valid for the lifetime of `self` and `index` is
+        // guaranteed to be within limits of the frequency table by the C API.
+        Ok(unsafe { (*self.ptr.add(index)).frequency })
+    }
+
+    /// Returns `flags` at index in the [`Table`].
+    pub fn flags(&self, index: usize) -> Result<u32> {
+        // SAFETY: The pointer is guaranteed to be valid for the lifetime of `self` and `index` is
+        // guaranteed to be within limits of the frequency table by the C API.
+        Ok(unsafe { (*self.ptr.add(index)).flags })
+    }
+
+    /// Returns `data` at index in the [`Table`].
+    pub fn data(&self, index: usize) -> Result<u32> {
+        // SAFETY: The pointer is guaranteed to be valid for the lifetime of `self` and `index` is
+        // guaranteed to be within limits of the frequency table by the C API.
+        Ok(unsafe { (*self.ptr.add(index)).driver_data })
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index d1c0f136952e..2dd134a46285 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -41,6 +41,8 @@
 pub mod build_assert;
 pub mod clk;
 pub mod cpu;
+#[cfg(CONFIG_CPU_FREQ)]
+pub mod cpufreq;
 pub mod cpumask;
 pub mod cred;
 pub mod device;
-- 
2.31.1.272.g89b43f80a514


