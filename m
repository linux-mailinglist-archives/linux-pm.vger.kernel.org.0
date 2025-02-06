Return-Path: <linux-pm+bounces-21455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21A5A2A471
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 10:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA541889736
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 09:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3312B22619F;
	Thu,  6 Feb 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJwe2eN9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A29226167
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834147; cv=none; b=QzFCtjk4nGTQOPUT1jqF4UVAXYz6EbprxtH4ic93mvrvSRuf4gyYwp+Q1bvjXvdhuGBkeyejX7fFoHzA36ay8AGVJ4FTJvKoF7FtWyCYKAgPsqvGaqj5cK4m7YHOoADoiqLuPAp8mxtjoh+byx5HV1Xotlmu7bSpQi2GZe+74+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834147; c=relaxed/simple;
	bh=hNxUaqce8sjnkwzAQlWMlhW9DvX+XlFNHHx9DRtSdzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTb2IlJ/xD9Ud4ZrVShanZsF5BzCJ5ymT4aaLQpvZ/ieMW+AmJ1HTs+LbNhzqkwbzKBmRUU4T6EcS5GtAPU3/C6vrc4RGUTyWMSO1vIOAdp6DDaKXR5BsjkP4ipi8JSrrA1rH13olRqiqNtyQddLeToEvLB/KjAAi2rbzzBMD8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GJwe2eN9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f40deb941so2739625ad.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2025 01:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738834145; x=1739438945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G2VXwMXVVwTjOULFIF4Y5hQffUd1BBYLZ5S5agX+0E=;
        b=GJwe2eN9R6OS5SV+yyTFO9EaC9rcaVkKbk1AbGKR/GRW0MAQtw/AP5VuDnq7I16ceR
         Gg2u92epq0vMtGdRboNkMm1AXjOKDdVqDloKntpGvuRWcPY+U7iK+/pjwxA2kkRz0r/O
         2tv39HFfoHKReiXN9HkQDCiL/pOFvl/aDR1cM/t+MFUZwRJ2BiiMxDMboDzaF+77mpU4
         IpY/yOdUD3lv4IRB7lEmagk+LAQ/ntV0Myk0j8bCBXKkuSROMa1Iwc4mLupSViXvG8Qp
         3gzTGMAp07WeYyhYh1hZbSgYYQvd3lIIKWPNw/S57tx0ruOy0NnVAsf8Lc2hBgNuXcVp
         bN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834145; x=1739438945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G2VXwMXVVwTjOULFIF4Y5hQffUd1BBYLZ5S5agX+0E=;
        b=Lnrwf5SIOWGRqS9ztZpIp0pM5UgL/LT8fwVkH6iXNUulAraA8oTJaODFudvBD8EXmY
         pQMeiuZSsAOHZpCD2aizD3E3HwcxmAf20UZ+2ek5YHeV9da6HtphGhkkbJfF9GPwDN2+
         7J2SobCZytc+wFeq4XIyC3OqlgJiaH2k7nkOddHmk/vdIE4OW/8aYKsDgXmrJjwcFall
         OgJ36BZZfohDkxFynyLKe6Rn0h7dnrNSYCCIZICIDDQp4xzGSS2D3DaQEQE5VRdLu54f
         92E8mqomp1OLoSVIHrAy3IxllCV1BWoX1KS8YJZS+VzObeHLS3P92I/TmOQXX6tg2fdp
         SrQA==
X-Forwarded-Encrypted: i=1; AJvYcCVoz2OE2mw04G4I5xNDxVj6zPliBCSngTHqS4H2fWgvexa4/5rO9F/KYnnx0vfXMsVEeiZpKET4EA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2adQVmhr3lESbYf8wFYVLUc1HL7j2o9p3KO5Qv9RQcE03Knat
	b64Oqs7L5tJt9SKcGGiK2o0eNwzrosTrtoIDwSMG2oNbf+HxtpQUDstsHN0WXMs=
X-Gm-Gg: ASbGncston+Ky5qzrKmRE3PUF6dAgFs6LrRoIKtlagdTUsxWASKbQmX8Il2I8ty18ne
	Au7whtSZ7H3XgKg3amtCBMUzkg1pbV8eNX05/7oY2knsGl22KFecKNuR5W94OQyhxN4A2tZ80g1
	srvHmEfQ12PBSuP2jzTGtWf5C16zJWZz3DjD+9AJoKzWRQY9KLMbNJl73Hy50dizMMFWoPlZ7ZR
	tk2VdQfYUEwMEeLtwfDF3wpfsn81blI8tuv0U8I82b3yZ7Njf05WYhRCSV4lHBWbfm+WZusVo3f
	EXcSvQTKy+ytJ1pbWQ==
X-Google-Smtp-Source: AGHT+IERZaH/yV6NhctlMcXLudgaGLxhDTf+gOxPascB2hUakJ8YcCEV+KZm6lvDnBVxg1aOgdZhiA==
X-Received: by 2002:a17:903:8c4:b0:215:a3fd:61f5 with SMTP id d9443c01a7336-21f17dde0c8mr99801325ad.5.1738834144997;
        Thu, 06 Feb 2025 01:29:04 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683ddc0sm8071205ad.123.2025.02.06.01.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:29:04 -0800 (PST)
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
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
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
Subject: [PATCH V8 03/14] rust: cpu: Add from_cpu()
Date: Thu,  6 Feb 2025 14:58:24 +0530
Message-Id: <35ef3767cb9e65cb4c95df7ed50c6f3f6190066e.1738832118.git.viresh.kumar@linaro.org>
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

This implements cpu::from_cpu(), which returns a reference to
Device for a CPU. The C struct is created at initialization time for
CPUs and is never freed and so ARef isn't returned from this function.

The new helper will be used by Rust based cpufreq drivers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                     |  1 +
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/cpu.rs              | 31 +++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 4 files changed, 34 insertions(+)
 create mode 100644 rust/kernel/cpu.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..ee6709599df5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6034,6 +6034,7 @@ F:	include/linux/cpuhotplug.h
 F:	include/linux/smpboot.h
 F:	kernel/cpu.c
 F:	kernel/smpboot.*
+F:	rust/kernel/cpu.rs
 
 CPU IDLE TIME MANAGEMENT FRAMEWORK
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 55354e4dec14..fda1e0d8f376 100644
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
index 000000000000..3054165d3818
--- /dev/null
+++ b/rust/kernel/cpu.rs
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic CPU definitions.
+//!
+//! C header: [`include/linux/cpu.h`](srctree/include/linux/cpu.h)
+
+use crate::{bindings, device::Device, error::Result, prelude::ENODEV};
+
+/// Creates a new instance of CPU's device.
+///
+/// # Safety
+///
+/// Reference counting is not implemented for the CPU device in the C code. When a CPU is
+/// hot-unplugged, the corresponding CPU device is unregistered, but its associated memory
+/// is not freed.
+///
+/// Callers must ensure that the CPU device is not used after it has been unregistered.
+/// This can be achieved, for example, by registering a CPU hotplug notifier and removing
+/// any references to the CPU device within the notifier's callback.
+pub unsafe fn from_cpu(cpu: u32) -> Result<&'static Device> {
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
index 496ed32b0911..415c500212dd 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -40,6 +40,7 @@
 pub mod block;
 #[doc(hidden)]
 pub mod build_assert;
+pub mod cpu;
 pub mod cred;
 pub mod device;
 pub mod device_id;
-- 
2.31.1.272.g89b43f80a514


