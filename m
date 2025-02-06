Return-Path: <linux-pm+bounces-21458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B55A2A473
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 10:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FE5168615
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 09:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BF522E3E7;
	Thu,  6 Feb 2025 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldcr8WEo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA322DFB6
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834159; cv=none; b=Bs/MzYx7QuyX23+XSHv3wZ+FXLxx2ecGWtG/mmxprVe7dPlYUj3x5pACp2R5uNT8TjInb4WNQKwJNKjGvJdH1vde1XBuWbec7+G9XJNo3dhwzmcfbzJKkLEC+JmRMwODXaLMIMKX1AyRXgmHerNKtvh91zhWpwAkMWj85U6lVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834159; c=relaxed/simple;
	bh=3cYUP4ZgznWOZmDbqnOVZhRLIIwxzB7xzdnixIMBEUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XX2pTf+Of58NEP5e7IdsH9v6paXzBv5y0LhL2B/UYIQfb4sGxeEugHsGX8YBGYukhTSaxjNOf9nnghceMKkeJzuEoEme+e1gHzxGzdF8kgFDE5rNpwtdmQx7lWVWWyhLCW6mpjumoTUDh8BlTR+iyDu13cdk7f/6bAMxEEaOiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ldcr8WEo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21670dce0a7so16617765ad.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2025 01:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738834157; x=1739438957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0B68fWX1cr1APKh0mAnlDXaXZbPEk2ia+lGAswFIw0=;
        b=ldcr8WEos3NDA7dj1Oeid0prRSIBJF9qx3xZabZ46t62pnQzRJrlneNzKQ1S3x4Kej
         GD29HX29Pp5ZeoeAHJgZuIx3HtwH9ejufb3UDfzcn9+vRV99zRYqNAxuafPbzNbkBZTE
         lr3CmhMWRNp64M9xuTN5sAAURXygFppkwFjSGUDC++BXUZUc34UaRhPDfS4/2VRfrJs/
         0hZMdmgYZ3WS+YEwzS+E09ua6+w9wkzWjvHIb0SCfye221+5N2pUOWkLWG6dJIM0fZuz
         fkD4DhvL5veiE7m9dbFmzubHpRSQV4uFa4vAECPsw1Y1CQ+pd6XpGzvrWgTN5hKhNO7X
         QQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834157; x=1739438957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0B68fWX1cr1APKh0mAnlDXaXZbPEk2ia+lGAswFIw0=;
        b=i863SUBobEx+8er5lwZXbFk73gn6w0dUyYLXl+Knn+VEdS7BETjdhMv9jbsAQ66EGf
         tmK1RV6RfS6YxhoajLaJNkTNa6Azzh5DT2/9HC6aI/EGXvTIXrvTDms03+eA+wjm2KJy
         86B19qMAWqjxiXFgWRVeKvzAwaMvqVCrS/s+SspqXJKm4ouFZLOu5ue2Ka/1jb5HIpnS
         yobrOgRpyJIblYJkSPG2I8ek/Y3VTmzQel52Pc9FmbJoBom98ismWpkTPa702P+Bj2ur
         TkJFvt2LTiHr2T2ERhBbe4IE1W+mnIMovzz35LX2drrg8iXr3PNQlC/TeZjO8+AkTMoj
         bVDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl6YXsJ6IcVKuC89y4X0yoz1ho4i7e3kuhkO64eHUmW998GHbBbHaLA7obFzSW7hX+dWOmtaJ1og==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGJnwhWet/ey7h+QRE9rqX1b3alhWMwkN6q+Glhd81LKxZ4pH
	MrHwAFl+YQuAGsT3Ny6K60a8OwwSJ2mSPrg+p29rUojfEu1W1ua0yuCcs+GJX3U=
X-Gm-Gg: ASbGncstq/x00sLzAHMfQNKiHebWZ+BZmYWYEs3eB38kG2iYu4fXI5ry7YOXdoLNPBP
	T08ex/9DzLVtcqroJcju/+ufTHzAlgGRHLEky8wNJj9jQoB4CrqMIf0TtM1ZUdhjcp37cRoGjEG
	cpgS/y7eJsNTmCnRK2x2OwbtCrgl0llNzWgfBc123g506UhIWytw1AguYMSY86/zPKUY5DA8RAJ
	VAyCwFtFLrhJYkkjEYCtSewYVZYaOvaWgym2X2+VqoQbhSqkN6+qT8hYFFg3J0R1RHPeUPVmIsn
	iMk6kq/5R5L9UakM4w==
X-Google-Smtp-Source: AGHT+IElDAOxzrGahKe43tZNe0gD8sTNEOXo/yB4R0zYTSZc3KLuS4C5s8EHFmMR+PrUabkKHjkhcg==
X-Received: by 2002:a17:902:ec87:b0:216:5e6e:68cb with SMTP id d9443c01a7336-21f17df5c3amr101820155ad.16.1738834157071;
        Thu, 06 Feb 2025 01:29:17 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653baa8sm8255655ad.73.2025.02.06.01.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:29:16 -0800 (PST)
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
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH V8 06/14] rust: Add bare minimal bindings for clk framework
Date: Thu,  6 Feb 2025 14:58:27 +0530
Message-Id: <c68081e18d939aefc7f6dac798df6b72e81bba4b.1738832118.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1738832118.git.viresh.kumar@linaro.org>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
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

These will be used by Rust based cpufreq / OPP core to begin with.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                     |  1 +
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/clk.rs              | 48 +++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |  2 ++
 4 files changed, 52 insertions(+)
 create mode 100644 rust/kernel/clk.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index ff4511914e0a..604717065476 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5780,6 +5780,7 @@ F:	include/dt-bindings/clock/
 F:	include/linux/clk-pr*
 F:	include/linux/clk/
 F:	include/linux/of_clk.h
+F:	rust/kernel/clk.rs
 X:	drivers/clk/clkdev.c
 
 COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3)
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 59b4bc49d039..4eadcf645df0 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
+#include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/cred.h>
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
index ccbf7fa087a0..77d3b1f82154 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -40,6 +40,8 @@
 pub mod block;
 #[doc(hidden)]
 pub mod build_assert;
+#[cfg(CONFIG_COMMON_CLK)]
+pub mod clk;
 pub mod cpu;
 pub mod cpumask;
 pub mod cred;
-- 
2.31.1.272.g89b43f80a514


