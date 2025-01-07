Return-Path: <linux-pm+bounces-20017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9ABA03D8B
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365521881155
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FE61F12F9;
	Tue,  7 Jan 2025 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uiwvc3Y2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B41F0E57
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248971; cv=none; b=XK7c2KIjU9B2T4LMyILbwsIxRk2dt/POgxjr44TpiaatjiyUlI3qVK0gApZydPpWeZAcqVaUf8vcnzFtpiHptRtsvp6Ni2WPD3usmPawefAyHBkeqkn9lvymM25HTsYxXW31T2PUxSCuSIstfxx+X4XNs6p3qJzB+rhx+F9ScA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248971; c=relaxed/simple;
	bh=rTvkUg8TSAwbpVq8htbrxHio/yXXpqaXKu8xmyXvlsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hxCxjHK+P3PUX+/j1BSGb4JX3sLWlLsK2x9qWVCo70Xm3pr0TiPhCFxWYex2w9qUDOX8BNaVl9xFKmh/fjS/SqGf9SRungeIqpyZAf4+gDGVYs2YfPEHc+oTSKG0G5Z7/1pxfpmMhMb/ZZTvdcuRdvqp/mJaAjkRvxhP3wr7b3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uiwvc3Y2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2165cb60719so228251085ad.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 03:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736248966; x=1736853766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GirQKr1CrJ4lbsHTZW131CE79vWTAUxlJNTFw3lOtI=;
        b=uiwvc3Y27McNjDqmInDPdmkOv3r1AX6n1L9QcZugXLIfOjOCxen4rHFtizhXJw/qcz
         Ijl7TyLMYsKjNuDGnl8TQiqwa6eLu7AgxTrR06YZ1GzaS1ySTeINGKfGy7mvCMiviuBO
         9dm2TazGNmMIDC5/f1rm2I6R2NnMqJiaEbQ7aTCGuC04BY6jGYdUk3SRYy7jfdXJ/OBY
         jJpF/FPaiU+YsAjV01toqPJ085i42vmvrmNyeK5GUhhORyf2TXukm4SwWJfw9z2ZEi7Z
         X5x45bMX8zNBRVgtR9D1kF1kybwGQWOh9FixTZo92O6HDVzDmdZUCqtLjMlHLbydDJKG
         VI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736248966; x=1736853766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GirQKr1CrJ4lbsHTZW131CE79vWTAUxlJNTFw3lOtI=;
        b=d9FkiPjKmL0UAushbA5NM2VaqHll2O8zJaSyh1Uk8KILwjwrJkfy1fFm8FYmtTt3BE
         xI1orTbRxlJ4HeqzfoXVmRju/edroNosa7LwKDpZsDi/fQ60kRoNsefzsrZ8T5eLh7f6
         lFOLy3FxtMuuH+geoYm7obE+iTBlT5PqUuZrfIiXDjDVx7wg/MLyQHp3wP7RfI8NuM6H
         gnMVkPzIXdoSzhuww137Zq/l5ezn7IdFoLLZGG4mnwF/rg+9ZJAj3tS7jbmJfQ9RH1pt
         zdZHqgfp7jpndgQwffQBLuN/1ZIoPZiE5D3uU5Su7Y94Y+y7pxXONh7aTEYtTzmogWMA
         5z0A==
X-Gm-Message-State: AOJu0Yy2MHic4OPHaqaXIYc4FJJUBxAu3oo4RSbiukJVONrbtKXcoXKl
	OcPvZN0CmiVF8KtR6n1ZPVP0rnnU6WK1GpHF4RjaUcevnamK/lSpAVOI/KwGHPk=
X-Gm-Gg: ASbGnct4iQk4Ttr8Xut3ahjZFsnqeRSwdua65cfHmAgH74t9XrrGxXF7g8DudNTVnXF
	tdS/dVA0jjsJfhlWZNdwPF+LasBKUGAWG49lyJ5hfdTZAeNkVYHhLsRpUgoZiCXM5kQI3tTUCM9
	oStgKOK++pm3inFxFBSx+tEYxWSGfXVUH1l1AgVgi/xggZQJMD6MqS2cYEzz/EyYcMEhfZSRrY0
	5dBGGWARmSCSxBBaWedj8nhyo72eXFi2/P/dmBubi8uk8CvtrTRGPFfEUA=
X-Google-Smtp-Source: AGHT+IFFxonaPDUSw5GDuK6y9YEM45DNTx4nOsm8oXu1zAiQSki75MjEYrGMGno+TTY/2jdIWdALLg==
X-Received: by 2002:a17:903:32c5:b0:215:e98c:c5bb with SMTP id d9443c01a7336-219e6eb43d6mr902213635ad.28.1736248966309;
        Tue, 07 Jan 2025 03:22:46 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96eae7sm308153165ad.85.2025.01.07.03.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:22:45 -0800 (PST)
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
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 10/15] rust: Add initial bindings for cpufreq framework
Date: Tue,  7 Jan 2025 16:51:43 +0530
Message-Id: <f648705caee99c2e624746a93f2c882a36464826.1736248242.git.viresh.kumar@linaro.org>
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

This commit adds initial Rust bindings for the cpufreq core. This adds
basic bindings for cpufreq flags, relations and cpufreq table.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/cpufreq.c          |  16 ++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/cpufreq.rs          | 254 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 6 files changed, 275 insertions(+)
 create mode 100644 rust/helpers/cpufreq.c
 create mode 100644 rust/kernel/cpufreq.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index bfcdbe4aa119..35ab20b99f90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5957,6 +5957,7 @@ F:	drivers/cpufreq/
 F:	include/linux/cpufreq.h
 F:	include/linux/sched/cpufreq.h
 F:	kernel/sched/cpufreq*.c
+F:	rust/kernel/cpufreq.rs
 F:	tools/testing/selftests/cpufreq/
 
 CPU HOTPLUG
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 5f900532e5ec..bd706ad1e58a 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -16,6 +16,7 @@
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
 #include <linux/clk.h>
+#include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/cred.h>
 #include <linux/errname.h>
diff --git a/rust/helpers/cpufreq.c b/rust/helpers/cpufreq.c
new file mode 100644
index 000000000000..28f8ebf96032
--- /dev/null
+++ b/rust/helpers/cpufreq.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/cpufreq.h>
+
+#ifdef CONFIG_CPU_FREQ
+unsigned int
+rust_helper_cpufreq_table_len(struct cpufreq_frequency_table *freq_table)
+{
+	return cpufreq_table_len(freq_table);
+}
+
+void rust_helper_cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
+{
+	cpufreq_register_em_with_opp(policy);
+}
+#endif
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 1943b98aec2b..f258e3b1a0bb 100644
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
index 000000000000..07ff03cb2991
--- /dev/null
+++ b/rust/kernel/cpufreq.rs
@@ -0,0 +1,254 @@
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
+
+    // Number of entries in the table.
+    len: usize,
+}
+
+impl Table {
+    /// Creates new instance of [`Table`] from [`TableBuilder`].
+    fn from_builder(entries: KVec<bindings::cpufreq_frequency_table>) -> Result<Self> {
+        let len = entries.len();
+        if len == 0 {
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
+            // The last entry in table is reserved for `CPUFREQ_TABLE_END`.
+            len: len - 1,
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
+            // SAFETY: The pointer is guaranteed to be valid for the lifetime of `Self`.
+            len: unsafe { bindings::cpufreq_table_len(ptr) } as usize,
+        }
+    }
+
+    // Validate the index.
+    fn validate(&self, index: usize) -> Result<()> {
+        if index >= self.len {
+            Err(EINVAL)
+        } else {
+            Ok(())
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
+        self.validate(index)?;
+
+        // SAFETY: The pointer is guaranteed to be valid for the lifetime of `self` and `index` is
+        // also validated before this and is guaranteed to be within limits of the frequency table.
+        Ok(unsafe { (*self.ptr.add(index)).frequency })
+    }
+
+    /// Returns `flags` at index in the [`Table`].
+    pub fn flags(&self, index: usize) -> Result<u32> {
+        self.validate(index)?;
+
+        // SAFETY: The pointer is guaranteed to be valid for the lifetime of `self` and `index` is
+        // also validated before this and is guaranteed to be within limits of the frequency table.
+        Ok(unsafe { (*self.ptr.add(index)).flags })
+    }
+
+    /// Returns `data` at index in the [`Table`].
+    pub fn data(&self, index: usize) -> Result<u32> {
+        self.validate(index)?;
+
+        // SAFETY: The pointer is guaranteed to be valid for the lifetime of `self` and `index` is
+        // also validated before this and is guaranteed to be within limits of the frequency table.
+        Ok(unsafe { (*self.ptr.add(index)).driver_data })
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 16e534024323..1c5a20679c7e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -39,6 +39,8 @@
 pub mod block;
 mod build_assert;
 pub mod clk;
+#[cfg(CONFIG_CPU_FREQ)]
+pub mod cpufreq;
 pub mod cpumask;
 pub mod cred;
 pub mod device;
-- 
2.31.1.272.g89b43f80a514


