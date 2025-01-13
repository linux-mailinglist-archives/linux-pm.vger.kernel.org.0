Return-Path: <linux-pm+bounces-20318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26623A0B5A4
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 12:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B36018813AC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE1722A4EF;
	Mon, 13 Jan 2025 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2nawjd7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282222A4DC
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767469; cv=none; b=H7O6rF0GeqN2CO7fLrDioRxIHt9fZXnLrkFywczV5T+eSfEf6R9EvLpM2t+pnfCgqHnWK9kFCja23YNqlB8BrKcKiCd6GPn0a9brvzIL5AMJdzainZOJNaRKs6rcvVkfMJmvXpJxT46kHDvrnpjxDCjF9uE9kTfXlTrUdohrO9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767469; c=relaxed/simple;
	bh=gXRpq9a3zNo2mqoc+c+AY5iNG67itiGvRui0TBLI65I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R6nHI7T1lTksZNwmHVIaONJKt5oFiQ6kwpSHDOuzQwXDrzQNSo1WoAfO1FySWH0iS5DmCEfgsTdbZmhx0u/Zdu9bXfqmTPTyvUnx6lEf15dCIktJYJB5b2b1xj9M8JIHGq57dRW1wKp0P8up4xvxExgLwwPfMGOLYu0ycvI931U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j2nawjd7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166f1e589cso85551715ad.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 03:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736767467; x=1737372267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF4U0fmdhazacnu5TfK3YZgG7bQEU+5HFAz9S6EWr/w=;
        b=j2nawjd7iYwPuhavM6cRF68mMSrXua7hAHPhY0ZH0QluSLNftg9a6nWmVW4tnkmv+5
         1nty+xjQWa+6n37DCzdJ9xtRrwemFAcQJtC8J7li7SiiSDRQTRTX2ReOJTgsvHWKfCTy
         J2/H0l82kzdjG5ekZ79oKClMibvn2qbaVXB5lA3MVpAxe5C//CdPJJSfd+zJvrhSFMlj
         raCXTtcKOxFm47LBd0VY6pxXajeRPdDqHzaplPyMMFN0+7eBfS69jjwnhxGGIslEQtSB
         FPRIHz5fw9P4XmYj+23BEY3xou5IleKKk/tiNBmowwrBzPyanANKEbVP1II6Q3KfxRP5
         qg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767467; x=1737372267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yF4U0fmdhazacnu5TfK3YZgG7bQEU+5HFAz9S6EWr/w=;
        b=Sz67VcgCIfOptsN5/8ZItfZ4vtbhGt17LEsAugncmGKEUx4+tVb2FdYbqjO5B1TcCJ
         XGXEoaZuUkJ9JYOv1ctv7KLPAjbvBqV4aFfFJIZ7pgru/NiJp38116AyuCAP2qShSKOj
         eoGxlpn4mC5uPgWRt/sQR9a8hqurq/WIyiRJoqMteLMmKlKBCsZKqc2D4hGhxixcb9BU
         0ghBDT9vSrAiNEevZtfaMZH64MbheQ6CtjpW+F7IbrA3IrGicrIVyiiPVuimPEfEs7GD
         HNGnllOprg9RiJdtCN7xdKIkq+Jp21jWMQcwAK/4FYnSGy+dVl8DxTtg27nbfIO82V3s
         e5ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh0wolEQlsvTiGnzZeG4qFSBQ+6pSJhBTmKAlAbnltj7x6mPsPnKfh1UP8jHhBY7YaoRqOeInJwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd10iiJEdRdFKbvN3hzEITRof/tJL7PeCPyVC203XpvWY4AGgA
	oSuNp4o3f+1UM8OFvt2pYJKmJk3it2IranCRFv2V7E1EXyzyIsdbj/bmC9AfcoI=
X-Gm-Gg: ASbGncvbPti261LlpaOV4ha0Say2N4x1iE4gXHrSVLIGsXKyxNjDudOiO2iU8vcgHua
	lULUH/aRBLQMRA/lSXw5exBVXmzLiH6hAckUBpCvvUNyAJ/ItQjHFUwYk4LzoxWAzef/AOk9FCf
	G85snIaneaYivpFUG0Sp8wvxc3BvMaJXJAHTCsrTDABMOHsJlb9d1JtlYvpskmz0djyJMYX5297
	TE+mcZp1CNPIl1EXcBTa/50tcZsALWzaHRaR8g8qvMHmjqWl9tHKwI7ABw=
X-Google-Smtp-Source: AGHT+IEutGiSjaMCxKF1iSM7TvMVcvoFtHqUScWeDq6/12v9Cb/p3VlYB9GXoMrO10PoJYLEx+gU2A==
X-Received: by 2002:a17:903:41c3:b0:216:3732:ade3 with SMTP id d9443c01a7336-21a83fc3c07mr308109125ad.35.1736767467225;
        Mon, 13 Jan 2025 03:24:27 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f233851sm51636465ad.191.2025.01.13.03.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:24:26 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
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
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 14/16] rust: Extend OPP bindings with CPU frequency table
Date: Mon, 13 Jan 2025 16:53:09 +0530
Message-Id: <47cfb24fd3c7429dc68a023a6b504e37bb13c141.1736766672.git.viresh.kumar@linaro.org>
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

This commit adds bindings for CPUFreq core related API.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 22c4d543f456..147178410c60 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -16,6 +16,12 @@
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 
+#[cfg(CONFIG_CPU_FREQ)]
+use crate::cpufreq;
+
+#[cfg(CONFIG_CPU_FREQ)]
+use core::ops::Deref;
+
 use core::{marker::PhantomData, ptr};
 
 use macros::vtable;
@@ -337,6 +343,56 @@ extern "C" fn config_regulators(
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
@@ -541,6 +597,12 @@ pub fn adjust_voltage(
         })
     }
 
+    /// Create cpufreq table from OPP table.
+    #[cfg(CONFIG_CPU_FREQ)]
+    pub fn to_cpufreq_table(&mut self) -> Result<FreqTable> {
+        FreqTable::new(self)
+    }
+
     /// Sets a matching OPP based on frequency.
     pub fn set_rate(&self, freq: usize) -> Result<()> {
         // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
-- 
2.31.1.272.g89b43f80a514


