Return-Path: <linux-pm+bounces-27313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1221EABB5BF
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 09:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B661A165659
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 07:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10B926B2DA;
	Mon, 19 May 2025 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+cGX1l+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32EF26B2C0
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638521; cv=none; b=BBTvrYLBrZioIuy8CwtDia3Qq8CcUHT8fes+vq46wVirzmI6Bnl+ssmnJiOZS4j2I+1imDxayXgptSNO2ICuxc1NXMCTfDR6qdPwiZAUHABVCunYTL79IgPrJTxNr/dHqGvgDlhhOg5qBHq/4Zm8cQE2onO1Mixg8R5BMzlXEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638521; c=relaxed/simple;
	bh=QB1NDnIN2+10EfH7zVK4+js+l6z1NvQ0KLDj/lkYjH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oXc0miy0HX/0tAXAweKU/BSjeRN1jGFb3uCRxPySQbqpsYaAFMPHOE4Q5NRAfQH+jGRhjAMuoDcJgzX6gca/twMiB1LWeryQYPWJh1X/c/egMu3/6bIyAAdZk7iGGDCvRF5xJhvs4arbVeVSt3Y7if5plOoM0GIVdSHyemIJQKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O+cGX1l+; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b0b2d1f2845so2785538a12.3
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 00:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747638519; x=1748243319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zV8iUMBX+j7TsKW8lH5BBlCVzlR9XbeiRbiHVvWBeLs=;
        b=O+cGX1l++cFgpf0MJm1qSDy7j8sY3gwFAhZiW6UaS2xgQSqUCvK6PNz+2/VXJCT0ch
         PzRG8QT+RhDAe1Ci4DPdXatS/MJ4v+/qqd+O/EfrFDdtsPsrwOljQwV+BSvK1BRzd7FT
         1oleRszUJDnkcHmZQOge1VvOLKkrM57M2Tbj/cJHQumD6rW6B8t3UKr4usLP3Z1oCVs/
         pdbp2OMQrW3hep+hrHwtp/BP3L9axskR1tUeCYcE43N0tVffVuK8keEt4mR8wD7mlepE
         mneUVrDBtRLUOPoi23YuJhlSuyozokCi4sOtLBXJb9pjPvIynnMX5Gff8PFl0tUgKTIu
         Cz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747638519; x=1748243319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zV8iUMBX+j7TsKW8lH5BBlCVzlR9XbeiRbiHVvWBeLs=;
        b=N2H6YqYAJ13kLOpXCrIHpRaKRqiI9ERfYaQMrHxgGOhNryBsXcTHPFMu2P845tJA4q
         bg/Qrkjuz7Bhi9lE9TQ/rOFklwLDnqyBhUVccGcXDvN/sm3oUDNYBOqOb4FR0PvfQ5Z8
         qr8zIEs0Y/HURIQFOZoVJdWawJUHqfMvpoucaWKZrCh/6x4BMZA47EMB1XmtSVtVJpZ4
         bkhkRDWxuhw6/zb/0v9quA5RGUqPpPBcWVvF+djbF1oK8uo7jjQDEQbaGFzsVFwsLgYu
         TRImM2q6tDmoJ31KCBHwds07jBOT65QNMjMg5rnYvUeeZdBL1URf1fYdzwb2pQa4ViKH
         l7bw==
X-Forwarded-Encrypted: i=1; AJvYcCVjQ3oBmVZzX0RuWGtc2wlFJbtBPg225vVrdnzVthLgXjNefcGkQa31YwEyBdDijAb7tgP54ZHAhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWqnPj92DvSlve6Dr/VeeIL5c6985JyurkvFKnhqoj9b1Ry0R+
	u1DPHrWsRV/DkMu/yDXQ6/EZ5cOEiv9OueJ5cRmRC7UxiET01iR70ApP8FVyV60TdrM=
X-Gm-Gg: ASbGncu/xU0209AmElyIZ/ZD7s7CtZ7Ifa9sKb710RL8yAUNEDY4rrsQBjpuZqKhB5p
	pjJ6I5JcAi4bV0dBdQ3HbqapwmgziNhtTGFwGur/T3iEDp1vQD9SuyS265m/aK/3uOA7eLeIXG7
	gMVop4N6So63FTaMxmAUmnh1j/j55m6eR3Q+BJEuHFNGk8sRr93bOjfoUiPGQYHhLEo8gbOGKib
	OCx0RgoEt+hyn6uuhlAxlLbkMoaSeND81NY6RxhwgLP06S1/IlKS8Ef+1DT+a3KwJP22Eo9mZrI
	Qxfx+ox9tfLb8511dlHgtGkTdiOblwLl7e7LJWRd2qav2b/ik6lu95A4qvWFOpM=
X-Google-Smtp-Source: AGHT+IHEjkPhd0v9dHUnrSumRKqtP+XO8qTwXgH5hnKDzbAp7zerm30lnT7DxIhX8VkHWyBQkdAPVw==
X-Received: by 2002:a17:903:18d:b0:224:c47:cbd with SMTP id d9443c01a7336-231d3257fc6mr161226955ad.0.1747638518855;
        Mon, 19 May 2025 00:08:38 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eba368sm53296525ad.200.2025.05.19.00.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:08:38 -0700 (PDT)
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
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V12 14/15] rust: opp: Extend OPP abstractions with cpufreq support
Date: Mon, 19 May 2025 12:37:19 +0530
Message-Id: <f4a35fcc3c4f6b737bbd359854ea12f5a53bcb37.1747634382.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1747634382.git.viresh.kumar@linaro.org>
References: <cover.1747634382.git.viresh.kumar@linaro.org>
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
 rust/kernel/opp.rs | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 7be6fd33d93f..1e5fd9887b3a 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -19,6 +19,69 @@
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 
+#[cfg(CONFIG_CPU_FREQ)]
+/// Frequency table implementation.
+mod freq {
+    use super::*;
+    use crate::cpufreq;
+    use core::ops::Deref;
+
+    /// OPP frequency table.
+    ///
+    /// A [`cpufreq::Table`] created from [`Table`].
+    pub struct FreqTable {
+        dev: ARef<Device>,
+        ptr: *mut bindings::cpufreq_frequency_table,
+    }
+
+    impl FreqTable {
+        /// Creates a new instance of [`FreqTable`] from [`Table`].
+        pub(crate) fn new(table: &Table) -> Result<Self> {
+            let mut ptr: *mut bindings::cpufreq_frequency_table = ptr::null_mut();
+
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements.
+            to_result(unsafe {
+                bindings::dev_pm_opp_init_cpufreq_table(table.dev.as_raw(), &mut ptr)
+            })?;
+
+            Ok(Self {
+                dev: table.dev.clone(),
+                ptr,
+            })
+        }
+
+        /// Returns a reference to the underlying [`cpufreq::Table`].
+        #[inline]
+        fn table(&self) -> &cpufreq::Table {
+            // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+            unsafe { cpufreq::Table::from_raw(self.ptr) }
+        }
+    }
+
+    impl Deref for FreqTable {
+        type Target = cpufreq::Table;
+
+        #[inline]
+        fn deref(&self) -> &Self::Target {
+            self.table()
+        }
+    }
+
+    impl Drop for FreqTable {
+        fn drop(&mut self) {
+            // SAFETY: The pointer was created via `dev_pm_opp_init_cpufreq_table`, and is only
+            // freed here.
+            unsafe {
+                bindings::dev_pm_opp_free_cpufreq_table(self.dev.as_raw(), &mut self.as_raw())
+            };
+        }
+    }
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+pub use freq::FreqTable;
+
 use core::{marker::PhantomData, ptr};
 
 use macros::vtable;
@@ -753,6 +816,13 @@ pub fn adjust_voltage(
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


