Return-Path: <linux-pm+bounces-20307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B27CA0B563
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 12:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00A13A8CE0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FD32397AF;
	Mon, 13 Jan 2025 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mNDWtdYm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF161239799
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767426; cv=none; b=b4LIbjgWhdvo/8hBEepGORuEgX6sqlB8Rx53g7Hio+SLk3tA/1/R4zbuvCjTsq1Wu3Mhg/7FohaDAGM0y6wNwBA1D7EtK5TpwBYU12ebfClZnJOol8DnhJT2+7UVkLv8kpR35uZdmmsTKA1TF0LEcRMp+24O2/gG1dyFJQ85BZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767426; c=relaxed/simple;
	bh=Log7cXXjzMiJkcv5gL5n5WiPvymmPQBug9ZqKR86Yek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MExGiOOHEkZq8qKd+2onu5fdgAoQrl6N9l3DgBkow919EsKChuwQyOC5vyAXu8dO+CvJRFMwkwkIn3CC+CsnUSZFkoKvFM4mX++vx5oZ6PyLtBW8X/A4qkW5uNIbnNWlywVEQxYUEUKpjZs0KHQTYNTblpeUNJvGfnKmWk0PmX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mNDWtdYm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2162c0f6a39so90526515ad.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 03:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736767424; x=1737372224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdn4m6dKlofswR8ctFShfrfS5TKeZlPBTra3kXQON/0=;
        b=mNDWtdYmQwesy81qm8USSreo7D38hLW3H26UTPJDW0KT9V4Xc2yow55rOKD8HrGwKK
         EA89HIE4gczQjdiWGS5a9AsRpkfk6j0xbI+aYf6jqAsuLfNEcazhlfzwSdE06+WJ96jh
         UOJdd7UGyVAKCY8h/cHkx6nyFlQOmDH8zV0nCkoL3eMUNVbCWGrO5IOKLEjtMKh2Hqge
         1EbsTpNptfIbgBBoWfBocZ78KE/fNrq1JuygiMlnDwefnvKOv8k0/iPgsNQB9Y9TGum8
         mIzHEIpT4Dt1F/PCVFV9nQfeMusgo3KKdQR9AU/kLpQkL4oS0WkRL7dkq+EfaXYNKCBV
         faBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767424; x=1737372224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdn4m6dKlofswR8ctFShfrfS5TKeZlPBTra3kXQON/0=;
        b=gbUPNvWm3FMeKIkFlGS2HYE5opLVVWuz/VoxTMLBMNpJOX/GE9Dbeyr29UWQYWLN5i
         /ZtsJDdmxICy5t+r99gR6lMbe0JhTg9wu73vdK/PUVkECR8q5zMFA5D3wd5CBeE0kpn0
         TRres9r1geFCGE85uAYoGyQSKKVBO2oXJC5qrtzPXAcxUelsJa3yHZZge8OgApEWTEvE
         XgFdBmQawhY6JcnmPULZNkR3Uj1RIIZMkXCVdyqbzYHmeAIEyYGcFcrbYxEC/JShgrvN
         PYIffSmAbRry85kpD+fOTVMoTZ742IDKF5zNuokjxBml8zgv46IhDI843x1VE8oS4XFZ
         N1FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAhuGneNV5Wyu6XngKvNTKZqST+ZG7lV+boUz25to2J1n+zdGQihdVBbn6fd6oODWBAQCnLzNk1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkbIVqHjMj7oc8JtR3xu6leil0ZPufxlTVGmFUITOyOyUAGoYi
	3Ln361n7gtOgitLDkUUyxandf87Bc7f7tdTTo6z8/qI2HiIQDsCknEgRa5G965s=
X-Gm-Gg: ASbGnctyMt0yN8rAt9Z+P6RkLWL1v0TKRRseocHOoxHRDX45Xgm0IVhhkEIKH+wj/k6
	KYA6t5ZL6LN821eTKOKUok0P8Du8gNfX8Nfb5wH7js+sRvF1MXk/c8RmMIe4SaxNeOl33ejBkx0
	jaa4z/9TJ29q9N1mlKHy8InKigxWbF1idl2zJ6cepkix371D/fiuEg/Ss7RjPuOV7NsQ/9XLF4X
	+GhHTtpKGP5zbPSp05wHSHIG0U+Zs5X71D3XGh8bCqrx7I+504uyDcKw+w=
X-Google-Smtp-Source: AGHT+IF0Y5yG1c5M9n48ix5v1C+TyVEgXKMj6yF6bVdvpXIdxxQSPZGVPl+AyedZLky2FVhj80qa6A==
X-Received: by 2002:a05:6a00:3bc9:b0:727:39a4:30cc with SMTP id d2e1a72fcca58-72d30301d86mr19474714b3a.1.1736767424079;
        Mon, 13 Jan 2025 03:23:44 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067e591sm5677575b3a.126.2025.01.13.03.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:23:43 -0800 (PST)
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
	Trevor Gross <tmgross@umich.edu>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH V7 03/16] rust: cpu: Add from_cpu()
Date: Mon, 13 Jan 2025 16:52:58 +0530
Message-Id: <854f7b8c9cbcc7f38fe5ed548290f41224478b40.1736766672.git.viresh.kumar@linaro.org>
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

This implements cpu::from_cpu(), which returns a reference to
Device for a CPU. The C struct is created at initialization time for
CPUs and is never freed and so ARef isn't returned from this function.

The new helper will be used by Rust based cpufreq drivers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/cpu.rs              | 26 ++++++++++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 3 files changed, 28 insertions(+)
 create mode 100644 rust/kernel/cpu.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e9fdceb568b8..d63e7f6d10ea 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
+#include <linux/cpu.h>
 #include <linux/cred.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
new file mode 100644
index 000000000000..422e874627d2
--- /dev/null
+++ b/rust/kernel/cpu.rs
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic CPU definitions.
+//!
+//! C header: [`include/linux/cpu.h`](srctree/include/linux/cpu.h)
+
+use crate::{
+    bindings,
+    device::Device,
+    error::Result,
+    prelude::ENODEV,
+};
+
+/// Creates a new instance of CPU's device.
+pub fn from_cpu(cpu: u32) -> Result<&'static Device> {
+    // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
+    // a `struct device` and is never freed by the C code.
+    let ptr = unsafe { bindings::get_cpu_device(cpu) };
+    if ptr.is_null() {
+        return Err(ENODEV);
+    }
+
+    // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
+    // a `struct device` and is never freed by the C code.
+    Ok(unsafe { Device::as_ref(ptr) })
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 2d5c3d7d2e21..e9106b29c359 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -39,6 +39,7 @@
 pub mod block;
 #[doc(hidden)]
 pub mod build_assert;
+pub mod cpu;
 pub mod cred;
 pub mod device;
 pub mod device_id;
-- 
2.31.1.272.g89b43f80a514


