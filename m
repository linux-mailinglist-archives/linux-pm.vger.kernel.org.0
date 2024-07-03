Return-Path: <linux-pm+bounces-10492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAD39254B0
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE6A1C252A4
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 07:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D6E13CFB7;
	Wed,  3 Jul 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4ZU1lDX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5362213D538
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991870; cv=none; b=eEdWejKHQAj7Uhz5E5XnhvXX4ipfb0LwxN2g6qUUtpXILFGtKZZ+9+Uf5v0AzML6hAuc0pHWyJhXdJeop7Wo5eiVT8DJygtO0057Tkbm+LtlTtKbIyp1cNcJ9bYEM8a0DmsstbLLZYXWkULoa1ZJChh5IAqeuQz0XorpF/YEmxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991870; c=relaxed/simple;
	bh=ONhmdqsWZDFLFh6FZ0fs7s5ZNKCwSTqTca5vpftOr4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kTZY8BpuknhW+ixW52xc9UiyfKhoh9o2IB4EHQsTz40ZneMdnztzMQc8cNUpaYUW6ntA4FQC88MHilu40HHSwiH/diBpI12xnx946yYqDtIYJdiP+KYJUAcxndpvD6+11j/4M9ZZR8p1EHFr0994f6ydBGlUDHhSpcElnmno5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W4ZU1lDX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c927152b4bso3645300a91.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719991869; x=1720596669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGmDSlgxeRxM9Y7lSVn8pZpU6fzV4VP8wkEHpyGM1hk=;
        b=W4ZU1lDXSzZmSt5bWEcJBTm9pjPTJmcoberXVHYQWus63osTQh+1ACwR+iKRJm4wR9
         vRz+Mns34CkXtbrGc7hOZLOOP1MlmNpmtrvOO4fI7i1sdryoP+gyOiqOx4ZokAZ1MYet
         PDMUF6vynMBrdUfmLwXDrhDxOQb9E5YikYuxUTwkBKl+rxbpyg+cf8X39opxzUbWUfQ7
         6D8iiQVfIXhHrBeLYKk3OZ5t6fyxLao9IHYyIkBc+VsIwCSnnubJ5nhcN7KzqXz4hrQl
         yxKzFOMXECxQSF3dYPgP+yNUeBGByKsNI8Oa7p+XLq9zTjxU+PhVow2/D1eREkyKfQL5
         CqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719991869; x=1720596669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGmDSlgxeRxM9Y7lSVn8pZpU6fzV4VP8wkEHpyGM1hk=;
        b=TnwiYR4ZgdOjJftg27DwIe4Ui2HO3R6dy4HihPau0HOsfWr2VFiczlcyVv5ZuNrDT/
         YI9e3x78N6Px9B1trQZcN3RmmiDFQxTP7tIz78fefCYXLXI7EhxrUlLKVZ9NcSlllN52
         Lq6v5DYc5iqkFFwfYWoCkXqY39JNh4XOnJE4iO9ZfkEHnsbhddcCJX5BQdOVyWJlN2Qh
         6RTz3uSwDY7GegpppK4++FL4SxivupVJOdsSwacRhwRARITQ8y+/Q1sbalIFDvjld+yL
         +jjK3uuWMu4mZVGYk65gzfNh6CCp4GyQvf5J2SCessROjZ7rpuALr4RvXT+6FND/+U8T
         gk4A==
X-Forwarded-Encrypted: i=1; AJvYcCUgTRbyHOS+wz/3V6p44bSxW8HpuBzdUslADxF8Ws29Z/EnFi1/B1dr/86B7a8L08uiYABrRS7EXDOwF+8+ZF3ww07ddJcD8Rs=
X-Gm-Message-State: AOJu0YxKZSgBsQ6ESdWshPriLPkabGSajX9q9y9m0jFaxqtNFdPG7pJw
	vGc66ay9gPX7qgmmF5qHgeyIAuHNUG8gr0V0humHSNw2jDMPKYLm8Xp0RB9DEu4=
X-Google-Smtp-Source: AGHT+IENXtyKbNnA1xRpxIfAeNA//qOjOvY7fcGsntZd4ck71ZV+1hEVvl03kBc6zmacmCk2AFG8yw==
X-Received: by 2002:a17:90b:a48:b0:2c8:bf72:5389 with SMTP id 98e67ed59e1d1-2c93d6f1508mr9665435a91.9.1719991868718;
        Wed, 03 Jul 2024 00:31:08 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3e7d7bsm10045396a91.47.2024.07.03.00.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 00:31:08 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
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
Subject: [RFC PATCH V3 7/8] rust: Extend OPP bindings with CPU frequency table
Date: Wed,  3 Jul 2024 12:44:32 +0530
Message-Id: <e7f85eb87c45633d7b5da3aa340dc44d37fb8ee2.1719990273.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1719990273.git.viresh.kumar@linaro.org>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds bindings for CPUFreq core related API.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 61 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 92c4ac6cb89c..bc16b8c407fb 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -16,7 +16,10 @@
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 
-use core::{ffi::c_char, marker::PhantomData, ptr};
+#[cfg(CONFIG_CPU_FREQ)]
+use crate::cpufreq;
+
+use core::{ffi::c_char, marker::PhantomData, ops::Deref, ptr};
 
 use macros::vtable;
 
@@ -376,6 +379,56 @@ extern "C" fn config_regulators(
     }
 }
 
+/// CPU Frequency table created from OPP entries.
+#[cfg(CONFIG_CPU_FREQ)]
+pub struct FreqTable {
+    dev: ARef<Device>,
+    table: cpufreq::Table,
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl FreqTable {
+    /// Creates new instance of [`FreqTable`] from raw pointer.
+    fn new(table: &Table) -> Result<Self> {
+        let mut ptr: *mut bindings::cpufreq_frequency_table = ptr::null_mut();
+
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_init_cpufreq_table(table.dev.as_raw(), &mut ptr)
+        })?;
+        Ok(Self {
+            dev: table.dev.clone(),
+            // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+            table: unsafe { cpufreq::Table::from_raw(ptr) },
+        })
+    }
+
+    /// Returns reference to the underlying [`cpufreq::Table`].
+    pub fn table(&self) -> &cpufreq::Table {
+        &self.table
+    }
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl Deref for FreqTable {
+    type Target = cpufreq::Table;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        &self.table
+    }
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl Drop for FreqTable {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // relinquish it now.
+        unsafe { bindings::dev_pm_opp_free_cpufreq_table(self.dev.as_raw(), &mut self.as_raw()) };
+    }
+}
+
 /// Operating performance point (OPP) table.
 ///
 /// # Invariants
@@ -580,6 +633,12 @@ pub fn adjust_voltage(
         })
     }
 
+    /// Create cpufreq table from OPP table.
+    #[cfg(CONFIG_CPU_FREQ)]
+    pub fn to_cpufreq_table(&mut self) -> Result<FreqTable> {
+        FreqTable::new(self)
+    }
+
     /// Sets a matching OPP based on frequency.
     pub fn set_rate(&self, freq: u64) -> Result<()> {
         // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
-- 
2.31.1.272.g89b43f80a514


