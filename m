Return-Path: <linux-pm+bounces-10964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A002B92E079
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 09:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC271F2283F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 07:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966514F9E4;
	Thu, 11 Jul 2024 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBuR8xO0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA314EC73
	for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720681117; cv=none; b=PgKbckEqLO0r3CrA9L3s0sf332JJrdL7Mzm13FEGo+NSBmYAERMUAAxmQU21bik7IL+BDOrsEbRodMofZQf4JbWzjwHBa+eHPI04tEU9SSwNGuAyvywGd9pKXen7hhEzAUrEdiZ4FVCzUAjorkphHear4hYMxKOwn35ZPItWyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720681117; c=relaxed/simple;
	bh=dO0CWc/xKDTHkuWPDNFu1TEYJonQR+X8T3Udl4DMBu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U8Hf10Y1iyLr84taOsAK5ZdIXuDVmvTqDK6xWZwrZybJ7VCLbFOwSimwL4r/Mqr3aI+n6q+xb0GE2aykcNk+LvD8XZYpCx48oaw1xAZiyUrUyJIZg0gzuAhO18HKvwHzAZ97C9PWjgRa5JYyZAMkFKDH71zvxe008Csgc1XBfkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZBuR8xO0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fbda48631cso6357075ad.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2024 23:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720681116; x=1721285916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGcVVh6shkk/cP1y6RKWzcHFgRZvU/7gGba22DNsHXQ=;
        b=ZBuR8xO0kKEasHfScUj71x1BedhSpHYdCSlX+2lMFVrXyPeUVKdDdKbTheFeC7R+Hf
         GDR70Ij2bPpsy8ChmRJVb1SGCxvDSlixjE6dpE3c79lmchfP43ZK0LFEonIEnwJyqUNk
         xYrivKPhS990Q1J4JYA+Hcno29sskie2M03WirQFD7st7VDmjnbfjGBhkIiksOSt2vRk
         kC2901z2nEB+xtFEMMhUQn9aZd6kkovDSzZRbd2lfBVlghjmEYyDw9kzcytOKKpjWOmV
         UaiCkAt4FaFHqKtNrbXvLuIJpS3BmdE7fAnrJOV8dBWkc6oR57u4ocTFHzSbDiw0dy+C
         DlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720681116; x=1721285916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGcVVh6shkk/cP1y6RKWzcHFgRZvU/7gGba22DNsHXQ=;
        b=UWOMrJvOJ0e+mDilpJEFm5xHTsV+pyYjMTSfNIGIsOmPoUF8AYdkLHEtoyp2I/hfh4
         DhQv1iPuL56XmuXL+y8ctWmRYUDymqWSXkNQcYP7vymZHgZkfmVfqT2KfzoZdfX6SZOe
         SnACAHkkgbvE0GvWykF8YOw7zl1IWY+exVgmoVL6Oou39LawEMabIR9nU/syr9F6L8XV
         KQaxmW0bmKMPTQdlEofycDAnumWiGMLWfMl5c6y7LFqHPW8EVgI2XotLKHBaCRY5S333
         gbv5uLcRnhrBFuKxxnd672N4ZoM2WUlXo0a0iml3hRbrUVGDoflWv9S1hg6ziWDPpn9m
         HG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdXw06ulGU/5E+0dkUx3Tz1JIOkQpjvNIedJSKqFMBbzUng+r2H/t6I0rx9jllY0l6sYkBH2xf0Bws9OfPBi7afRvB609vQZs=
X-Gm-Message-State: AOJu0YzsLD9Dd452vJPlpTLZanbKj9HYmUqI2yhBWdbhvo3KsgTKMu6p
	kRXlKcZnn0A5sUqvTDj4vGogJcRC36AdjX/slO4wcgXZjWhpRC1JW4CbV1jqNBI=
X-Google-Smtp-Source: AGHT+IHttmQ+CJmAEGiN+ZpLgx1FkTxuA+txB4y8lJKqk+ahCAt7PiixgF+qi4Udu0Q7oaRRF/rSwA==
X-Received: by 2002:a17:902:f78e:b0:1fb:8e29:621f with SMTP id d9443c01a7336-1fbdba13720mr24954095ad.16.1720681115548;
        Wed, 10 Jul 2024 23:58:35 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad0103sm43520175ad.279.2024.07.10.23.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 23:58:35 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
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
Subject: [PATCH V4 7/8] rust: Extend OPP bindings with CPU frequency table
Date: Thu, 11 Jul 2024 12:27:49 +0530
Message-Id: <bf90317b65a5f05c614e80739c03011c7b26538a.1720680252.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1720680252.git.viresh.kumar@linaro.org>
References: <cover.1720680252.git.viresh.kumar@linaro.org>
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
index 113652448056..7317a5e922cc 100644
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
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_free_cpufreq_table(self.dev.as_raw(), &mut self.as_raw()) };
+    }
+}
+
 /// Operating performance point (OPP) table.
 ///
 /// Wraps the kernel's `struct opp_table`.
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


