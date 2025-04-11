Return-Path: <linux-pm+bounces-25241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5A5A85B03
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 13:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5CA1BC3767
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 11:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619522BEC34;
	Fri, 11 Apr 2025 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EYCOf8aO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9632BEC22
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369201; cv=none; b=q1PjbaOI+CK40w4HA3/NFYnaNP0MgpJmvMVT9hR6nVtwy1La0yoxv/IrdHj2zi6j8s1PHwsPsN7DbsPUwEvt3sTnq/nxjyuw1dsAOgt4jM0sYLISsxnHfrF9qs9CXF5f7Vl/hz1sMbV0OUHZHp0MjzgY2Yt7HOJ7a22F/37QjFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369201; c=relaxed/simple;
	bh=YfkEvdysLwoMmcnG/s03bKY53YATs71FlnrnNvf18rM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QJG8mWAeAshc11qyecP36hhwFJpQ6dY8m3hVGW5hZrRy4ziZhDKBWKlZg5fF/wjePOZ1NlKs+ymP3FJmvPRJ/hFrkjIYEvlfOaz7LW3AAmFROlcMxs6HQMq7BiTUqTHsG0xG6PsosXg4miWlDxnp3SCeOQnOme1omhBYcldwSrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EYCOf8aO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-306b78ae2d1so1748244a91.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 03:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744369199; x=1744973999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5O39+KsHhbO3NhJV0D2xQKPBr7meyvBFEMUfJdpqZjU=;
        b=EYCOf8aODVPPX0FhyvlNF0SbvElYhQcTGPVQu+VmwhlXimf7KyaYCjHb+TQpZAqOKa
         7D93GW/X+8CmOxCLxqSI4dzA8bNjDdvRvaUgbfdFbw7HikZfGY0a6q0J1CFEi2GMUC12
         aBCKFldhqhgMuQptseEFCcCVAlB+zHY/u5G5lB2ey2b3BKfnFatsH5U7Wp4jyrAOPwsN
         sjoIUNwWyaMPssPXg50UZW3tTOv5+L34UWJWGF4EOaCHfBP8PMQbuCEwgnn7wRWoG2Hb
         wNV8IhDfi6UDXVDqUhCm00CkseGCwrmfao4DhWa3ZPyAkM7oF0C4YAt6Vo7cuvOg1T7z
         Tu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369199; x=1744973999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5O39+KsHhbO3NhJV0D2xQKPBr7meyvBFEMUfJdpqZjU=;
        b=MZtpBVDvteR+aSc/lt5eZRkwhY4Vr+AvGwCcc1TT9I7rpt87+zciFjkT5qAuibpFYq
         Awqy41rYOROb0wcZjTcPFaDnh7++6aXpiNbHMyarreNtpyF5mrxu2Dh9RPr8Ckh6y13R
         Lj555A6OaTEVyDoWZnGCOeH7SR3MfahVkYa7Ke4aDh/YHLgsVQ1QA/ySzuJMtTg09xop
         B2ZawGKXJ/YzbTsNTr9S5XvE8jLzWcRJu7PBal5ZGg77aewIvpq8ZiHQzFUuQJ5u/vLB
         flP2FsEgfWeiHqArw3schFETbcpn3UbHeH+lFGBD4+EYZOOMY4Zhcmj5Clsy505SqDf+
         cG+g==
X-Forwarded-Encrypted: i=1; AJvYcCU6Ep1/OE0zBGx7VwCdCct3i1OZlJeByuXW0dKV103pKfv7WcfKJR/fIF/+T2X6UZkM4FoAhzidaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqyu9O7V3SAFkkzBPoZ+IT+bHf2pB9/uHQv80iMhO9uBGIW08
	+iYt3bqmh/+il5RFqU9sA86idW8+au7kCJLSRoi1NptataneXvx9brg9hjTDJNU=
X-Gm-Gg: ASbGncuggKhTFjbg6eLhvQHrYuFg7tdEHr3fIle4V8AW9ubAvsccDwizR28NazSu12F
	kJJLBSPzhTPUoy4/sAU4S+zzedIRvSUgPewRJCqyOVNWOd/1hXqFZiIr1gcsXZV5FifeFLjjuBM
	K2SbTjDe4O9/glZ1i2fG2HwM/Ao4bJE7SjEIe85EerYxbopUANDdLGbLcBsQhyKrr11OGsZyLqy
	tlQxbSfWYrzqx45PzUvYu5IuZ08/7alu8EVTjSBRKmahlvxgiLjlA9/oAt7AS4RDiU2BbFGfvWf
	5fB2VIJaCLRffDk6U+b0QLOGmxFvv3OV+f1CQYoAWA==
X-Google-Smtp-Source: AGHT+IFUZzi3or0+gmBFWhEoaT6J6YgEu6VDaT3zpSxk4MU/e2d8OAjpgFPpre9Wl18Dad1dznFhiQ==
X-Received: by 2002:a17:90b:5188:b0:301:98fc:9b51 with SMTP id 98e67ed59e1d1-3082365a310mr3170141a91.5.1744369198940;
        Fri, 11 Apr 2025 03:59:58 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df08f63bsm5260842a91.24.2025.04.11.03.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 03:59:58 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
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
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 16/17] rust: opp: Extend OPP abstractions with cpufreq support
Date: Fri, 11 Apr 2025 16:25:15 +0530
Message-Id: <e88fae38cb339ff88cb64fcd506ce767b458f310.1744366572.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1744366571.git.viresh.kumar@linaro.org>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the OPP abstractions to include support for interacting with the
cpufreq core, including the ability to retrieve frequency tables from
OPP table.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 7bf612fa0cc5..a46ac28d4464 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -20,6 +20,12 @@
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
@@ -497,6 +503,60 @@ extern "C" fn config_regulators(
     }
 }
 
+/// OPP frequency table.
+///
+/// A [`cpufreq::Table`] created from [`Table`].
+#[cfg(CONFIG_CPU_FREQ)]
+pub struct FreqTable {
+    dev: ARef<Device>,
+    ptr: *mut bindings::cpufreq_frequency_table,
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl FreqTable {
+    /// Creates a new instance of [`FreqTable`] from [`Table`].
+    fn new(table: &Table) -> Result<Self> {
+        let mut ptr: *mut bindings::cpufreq_frequency_table = ptr::null_mut();
+
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_init_cpufreq_table(table.dev.as_raw(), &mut ptr)
+        })?;
+
+        Ok(Self {
+            dev: table.dev.clone(),
+            ptr,
+        })
+    }
+
+    // Returns a reference to the underlying [`cpufreq::Table`].
+    #[inline]
+    fn table(&self) -> &cpufreq::Table {
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        unsafe { cpufreq::Table::from_raw(self.ptr) }
+    }
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl Deref for FreqTable {
+    type Target = cpufreq::Table;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        self.table()
+    }
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl Drop for FreqTable {
+    fn drop(&mut self) {
+        // SAFETY: The pointer was created via `dev_pm_opp_init_cpufreq_table`, and is only freed
+        // here.
+        unsafe { bindings::dev_pm_opp_free_cpufreq_table(self.dev.as_raw(), &mut self.as_raw()) };
+    }
+}
+
 /// A reference-counted OPP table.
 ///
 /// Rust abstraction for the C `struct opp_table`.
@@ -752,6 +812,13 @@ pub fn adjust_voltage(
         })
     }
 
+    /// Creates [`FreqTable`] from [`Table`].
+    #[cfg(CONFIG_CPU_FREQ)]
+    #[inline]
+    pub fn cpufreq_table(&mut self) -> Result<FreqTable> {
+        FreqTable::new(self)
+    }
+
     /// Configures device with [`OPP`] matching the frequency value.
     #[inline]
     pub fn set_rate(&self, freq: Hertz) -> Result<()> {
-- 
2.31.1.272.g89b43f80a514


