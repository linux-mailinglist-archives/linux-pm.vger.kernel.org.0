Return-Path: <linux-pm+bounces-20012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A056A03D7E
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA621884FF6
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FE21EF097;
	Tue,  7 Jan 2025 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vtua+Dzx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A511EE7A7
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248951; cv=none; b=t66dQQzGr2cCGXq782ZdK1FR9drzbStGegGXsy/tt5cRIHYmQ4qX+ZJDqs53CGcEkv1UpkchqMdCYs5IxeM0zcE8HRV/VwuuRwikeQXn9nPkpw/Grr6+lOSDFQBgy5IixjwTeGsyQVazhYHKLcb50TSpit3JQtug6edpTngRwlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248951; c=relaxed/simple;
	bh=sKmeI11G2DxJ27Bh9xeLDcM6wV23AEntdb5SxcwiL/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qbbB8BwGaN7PDe53CNMzuxs9kgGV7ksiTJSAVGUy9JMohm1j+/aYeNlTH0k+vuRXYsbj9MVevx4EXJJEmL3FIjimsW8SaJESeLdGIFr3LzzWsTdDL7PdPjokq5r3WHVMgBGBFlsR4QYWop21vWumw9qKbbGzuUYAmXtecRYMDvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vtua+Dzx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21654fdd5daso208576185ad.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 03:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736248947; x=1736853747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht0fHOcCf93NDtalSLiwsaXduseZ2XVH+o3kGv/x6Zk=;
        b=Vtua+Dzx6A4Q0OqDRnJTktl+1Arkqh36ueTTl3dZhWoO7Vs6amoZZTkvD7IG2xZNlW
         sWDg+b/CiEADPiA08Wwt9uTaIyYMgx+XIwL1ilVdY2+cTJQw7NvwBKhcCgLrcAOILS+Q
         UY2kysqY8/Vb98H6a6ttAZeATlSO75icT470RwMQBVkpZvz4jLsE+zVFfDe7MRzRaXVA
         aV349EjSnJOpnyCg52mn7DjMaSLm4oqkU9USNN48rVxgfglpPi7MCbqGsveFTX5G0G9b
         yjvxeNH9P7CE8eNzFZE254pMG/7CXEq0qz7pG0RtH63v95wVicyZWiiIzOS6kg8KO3LK
         y7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736248947; x=1736853747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ht0fHOcCf93NDtalSLiwsaXduseZ2XVH+o3kGv/x6Zk=;
        b=blw21FgfScZ/cFgwvHpHM3hhNtoqRoxJFA413yKkn3oIV9OFIwc5THNKygo4q5/h/F
         39ot5IqO5GA3me6tZ6JoOMgn+hsAugBtDRlqvcEiBfMColmOEjWWsWYzcRlw1/gPgLAK
         5us4aqW5d9AyS96BgQ+3Wonwa3DISgoA6gyQiwYLB1k8ka2F7tSgvu69GVhUQia/ZSg3
         nEKC9yvqyq3HD3g4DplF0k4LDr8lQDtqTMI2lwsVOcv20OuI/LIOQvawaBAjYJzp3KwI
         bT04u+4GuReXzqGRrhWqHKjpwhytK7s6Y/kqZgqj3EXVDFB74SnPJDrXxUxkvgBuv6jy
         /Mig==
X-Forwarded-Encrypted: i=1; AJvYcCV8/YfgR726jjyj/NbEVi52itYyJNmoeSspcY6iuka88ra+MlmzIGIJgipyeJUMRiUqkmi6hiQBpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzW2piOhC83RsOi5DbOHiFuB0QxmS4UIvo4p6BmJ7XJWAZjpeI
	L+c1E0LFeXx/5K1owqLF/DTzngPq5ZW1YKwu9UFG8Cre3QTj3KLNV0Yv/wZcZfo=
X-Gm-Gg: ASbGncs5eTu5ac+u9FHmR1dt+FicPVUyQOvkeXamXqpBbutxrvV1UuMsysBvG1O78Xk
	TRDGM5W/KCRWyyST3UUZrpVDXBZCdSQZrBreJw4oAPVpM/xRYWr37R9OKv2ecg/sxGsTxYvVOCc
	UBD9jGKgZUn86aSnn3EFFwYK1TVqW1qMclhVcYayW5JWffzwXV6Rx+e2vRP9WQGnQVxE2DxQNiV
	hIYOYY/GYTeL6eKoQfoj49kW5eQnwgiVXYxEYGpjDaRCZunr9TH/rAQbNc=
X-Google-Smtp-Source: AGHT+IFF+Fx6oir496vMPHHsLeodo6tk/63tF7zPPNV7pdO5c8Q2JMrTBOmjWNxbwJAzbaE9Hc7sEw==
X-Received: by 2002:a17:902:c409:b0:216:6fb5:fd83 with SMTP id d9443c01a7336-219e6ebdd95mr891466135ad.29.1736248946751;
        Tue, 07 Jan 2025 03:22:26 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f5087sm302943345ad.202.2025.01.07.03.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:22:26 -0800 (PST)
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
	Trevor Gross <tmgross@umich.edu>
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
Subject: [PATCH V6 05/15] rust: Add bindings for cpumask
Date: Tue,  7 Jan 2025 16:51:38 +0530
Message-Id: <77c33c80f878010b8cf3f8c931c3b6e46397dc34.1736248242.git.viresh.kumar@linaro.org>
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

Add basic Rust bindings for `struct cpumask`. Also add few Rust helpers
for the same.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/cpumask.c          | 35 ++++++++++++++
 rust/helpers/helpers.c          |  1 +
 rust/kernel/cpumask.rs          | 85 +++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 5 files changed, 123 insertions(+)
 create mode 100644 rust/helpers/cpumask.c
 create mode 100644 rust/kernel/cpumask.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 70e4b7b0f638..3225379abd2b 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
+#include <linux/cpumask.h>
 #include <linux/cred.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
diff --git a/rust/helpers/cpumask.c b/rust/helpers/cpumask.c
new file mode 100644
index 000000000000..0b371826a13c
--- /dev/null
+++ b/rust/helpers/cpumask.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/cpumask.h>
+
+void rust_helper_cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
+{
+	cpumask_set_cpu(cpu, dstp);
+}
+
+void rust_helper_cpumask_clear_cpu(int cpu, struct cpumask *dstp)
+{
+	cpumask_clear_cpu(cpu, dstp);
+}
+
+void rust_helper_cpumask_setall(struct cpumask *dstp)
+{
+	cpumask_setall(dstp);
+}
+
+void rust_helper_cpumask_copy(struct cpumask *dstp, const struct cpumask *srcp)
+{
+	cpumask_copy(dstp, srcp);
+}
+
+bool rust_helper_zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
+{
+	return zalloc_cpumask_var(mask, flags);
+}
+
+#ifndef CONFIG_CPUMASK_OFFSTACK
+void rust_helper_free_cpumask_var(cpumask_var_t mask)
+{
+	free_cpumask_var(mask);
+}
+#endif
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 2f2070c15f09..1943b98aec2b 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -11,6 +11,7 @@
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
+#include "cpumask.c"
 #include "cred.c"
 #include "device.c"
 #include "drm.c"
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
index 584d95c1eb5d..8a0cd60eb6cc 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -38,6 +38,7 @@
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 mod build_assert;
+pub mod cpumask;
 pub mod cred;
 pub mod device;
 pub mod device_id;
-- 
2.31.1.272.g89b43f80a514


