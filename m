Return-Path: <linux-pm+bounces-20013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E71A03D80
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E9F3A4BE3
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67421E9B27;
	Tue,  7 Jan 2025 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="woKW3rU8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BC1EE7DC
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248956; cv=none; b=We8M1EhckOFLqPugITRkyS7PUeEvyG9X90FJ7Fkc4umuvJFpBKR6L5ir8d5N/2e2i8Fy5YGaIsjqL1w97/KEIoQ2e3dgurVzRZkMSMFm/9o4n/l4IirL7y3XajFffcDIdF2r73p63lAJARrxZVwlrz6KIJHP+uGlg7vgWLsdlpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248956; c=relaxed/simple;
	bh=Fx9XB5ts9sXUh9O3/l7pGwJGGgpdlk1bk0cEGYOweMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlXKFJUPuZG13I28lgazgbMM5v00o+inelEPin3+vplXQAod3ciwsUfWLydRC1nit8Z0OBZvcd+Ec9GGojslLkezQDgAqi1UaR0oW7Zh5cdQXT+4lqMPSsi+wXvCt/bhdgl80NTzncVzQlQX2/JKfYJEaT3n3azfDOHXBw0jW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=woKW3rU8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216281bc30fso4733785ad.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 03:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736248950; x=1736853750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK9fggKbnQIV5hRTBl9969qRmfCDXZjN5H+SCocLudA=;
        b=woKW3rU8YbZ5atMKY6K4VJZqd6hKuqCVyZm4TOmkD5rPd7CuwKTsuEfct98/SqwCqT
         jbGZzjLUWdLm6knoU5ZOUKLYpd+LiEP7OJUY/H0tdN1TT4/7ayyDlHEyuWFAAB58HlNs
         8FY7Mrh0/B9o5GC1Wsnsl+rdghWJDivOnGKF8haK9atbMygeTNHvUgP05IfrAHb7y0Dh
         XCNXHJJ/+DlcSREBoIv78EBQAfVAzfI1OkY/e3pEye4uQmijN79xb52IpQn0YqeG7w6y
         s3CG6zHaLoRhHdeEUdAICp6lJZXUhwzosnIkZz2ENh3rq4r/WmOdaV1EfK2xdP21hpko
         EJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736248950; x=1736853750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jK9fggKbnQIV5hRTBl9969qRmfCDXZjN5H+SCocLudA=;
        b=apDq9E0hyROwmGXc/RnkMhxh28O2wBzN6xGWlE3syIC2wHb7voePZHU013wKw9TYWz
         rlrG1/vXIV4zb2rOyhpoSPXSm1H8hVZQrRPFHzsaFi4rAuvHY8OoTL+oGKi5cmFptAh+
         fNVgUws057yTRnRq/RunWUryB0pXgJaVyuLVoUCYbOfUSjhCi2mEkSvn+PVhr1TgoCui
         7C1s5M7cEM9Kx+1uhdUthrbHIeu00HQFXxnvMKWzJKuA2AbEJqHWhMj1/qL7haedOgJB
         wDbeCH0PdAPfNb8HMbovPxgZhyXIaWb/bEISe2LFwrCZw38DA4M8qbm9n+pZ6+GN/G2O
         Sbuw==
X-Forwarded-Encrypted: i=1; AJvYcCWIx/IEAPnvlqkaX6UcHrfGzjrnA0CYoEwrnJEYLqikRkZK8/4Et1LRtN7NkMRxye0+VOn7bqQuOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YweJ08jPDSB5Zz3L4XOruuR2tamaUFrSMB2WIKr41qlEZP3KoSv
	tjApaSvQ9AecA3Chd5HayBZxMnJgURvrt1iUssZEDmEvFWPkLqdDiEVpQMTdOpE=
X-Gm-Gg: ASbGnctdXPJh74iuwMVc5hB7v9H5B/47az5IMvCBxrVPqbu7kWXpZNofaxInPsOAWMZ
	Pk/KHyf0TCSUj7df0Bwp1agrdzJ1jIRhscffCXSw1V+HPWfsKqc/dRG72LzCmbSVINtCQOgL/je
	fqzo4Tben9l6QXFzvTwzsgVLyACAwgjJmXeAsigt8+D4G9+o/IL6EtjpWap3SzUPAJ6Jb34dXbt
	lC0EVLQy1PQRoDhA1z1poaasMUUYDumMB+JmK9w8PRULySjMLh36DDHgTI=
X-Google-Smtp-Source: AGHT+IF9FSxiUi6E3vyUCMwDEsv53WHI4nW1IVtUaahS5ofFQcTzHYCfQCLCjg0emu7ogoZdphf3/A==
X-Received: by 2002:a17:902:da8e:b0:215:b058:28a5 with SMTP id d9443c01a7336-219e6ea2855mr823470415ad.18.1736248950516;
        Tue, 07 Jan 2025 03:22:30 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962940sm307240865ad.34.2025.01.07.03.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:22:30 -0800 (PST)
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
Subject: [PATCH V6 06/15] rust: Add bare minimal bindings for clk framework
Date: Tue,  7 Jan 2025 16:51:39 +0530
Message-Id: <d5c8f6f8d16ce9d95ea1715641597f78e7c0e845.1736248242.git.viresh.kumar@linaro.org>
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

This adds very basic bindings for the clk framework, implements only
clk_get() and clk_put(). These are the bare minimum bindings required
for many users and are simple enough to add in the first attempt.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/clk.rs              | 48 +++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 3 files changed, 50 insertions(+)
 create mode 100644 rust/kernel/clk.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3225379abd2b..7a95d999ead8 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
+#include <linux/clk.h>
 #include <linux/cpumask.h>
 #include <linux/cred.h>
 #include <linux/errname.h>
diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
new file mode 100644
index 000000000000..123cdb43b115
--- /dev/null
+++ b/rust/kernel/clk.rs
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Clock abstractions.
+//!
+//! C header: [`include/linux/clk.h`](srctree/include/linux/clk.h)
+
+use crate::{
+    bindings,
+    device::Device,
+    error::{from_err_ptr, Result},
+    prelude::*,
+};
+
+use core::ptr;
+
+/// A simple implementation of `struct clk` from the C code.
+#[repr(transparent)]
+pub struct Clk(*mut bindings::clk);
+
+impl Clk {
+    /// Creates `Clk` instance for a device and a connection id.
+    pub fn new(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+        let con_id = if let Some(name) = name {
+            name.as_ptr() as *const _
+        } else {
+            ptr::null()
+        };
+
+        // SAFETY: It is safe to call `clk_get()`, on a device pointer earlier received from the C
+        // code.
+        Ok(Self(from_err_ptr(unsafe {
+            bindings::clk_get(dev.as_raw(), con_id)
+        })?))
+    }
+
+    /// Obtain the raw `struct clk *`.
+    pub fn as_raw(&self) -> *mut bindings::clk {
+        self.0
+    }
+}
+
+impl Drop for Clk {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // relinquish it now.
+        unsafe { bindings::clk_put(self.0) };
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 8a0cd60eb6cc..70694becc9ff 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -38,6 +38,7 @@
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 mod build_assert;
+pub mod clk;
 pub mod cpumask;
 pub mod cred;
 pub mod device;
-- 
2.31.1.272.g89b43f80a514


