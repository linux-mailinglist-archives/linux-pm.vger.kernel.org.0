Return-Path: <linux-pm+bounces-25515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2B9A8B093
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 08:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC3718936FA
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 06:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243A222CBF4;
	Wed, 16 Apr 2025 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xidwe0V7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430F1230BD9
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785621; cv=none; b=V6WWD6oBPMzLsj04x5EuO3lydmjFnvRSfLkBAEw+WUgSozHWnFKI35zBpg8oEIVDCXis0aWMAOVD6NB9+EJIFjx3DhlcwokY+8TuxloUq1/ioWn1xGVN849mGYRxZTK51dgp3htQQTYZTJ++qvjHhia3vuAWc3w+ejaBAT4Nuak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785621; c=relaxed/simple;
	bh=FXN7MqRrTtWb3HqWkB4bVWXQmRagu7xa10NZ2Fw72s8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQn5RGbZP+o9m+gVQBU24wJt/f4O6/AtLDyDPtQBxb5hYZq631CeajXRVdtWQUBtFwpkpyAX8ki59g2aGKSXy0kKX4SmsKPl7LF2mxDPNvOTHUiZGU+i8P8B9rT7stK4hcX8uCKfiNZtYYmhDGnsnxsLTAXf+3mXSV0RLncxm8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xidwe0V7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736b0c68092so5487913b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744785618; x=1745390418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I9rp3cxJf7RfTSYMTTz5L7zI5/p8FTKb0IR9cJ6SsU=;
        b=Xidwe0V7wfxWDgHsAStGUguKV3Skl485YhNSuWeLrDUvT2Mbu7kFP7XXwkWmc+Zk2I
         ekQNNSfdFw63oaDlO4RKTkEpIXB9ahHvFulnWhSYE+IioINb/X834cLcQfuPeXGUyV5J
         jBwHurnbItPYW9B42bsbmiZoE4BpvpvYtK0vzCVLJTnizVBuMleOXUwkh77Tn0pslFg7
         N03mjesuZLvqTUNqH5LOCf3Euywf3HQ6ifpmHjCQVjO9PTyQTmKmve4J05XCd/XE6lWy
         MI9IZ/qzK/wBW1GZDjiO2kerJF5cUc61EDne5KqhncI7Sa0yysHE+Tghy3DER15q1HlX
         ZCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785618; x=1745390418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8I9rp3cxJf7RfTSYMTTz5L7zI5/p8FTKb0IR9cJ6SsU=;
        b=w48CuCkPtEOsvZzHoD1ir+WYSMqhs0KSnYKH79MRsMiOoTJsx3l2PUUXP4FiFMFOTb
         7t7PZwfaKzPq5txcSznZvX6aQxucoXauQsbLMFTOJ5FglxqgZOGMkW4dg/sEpfoh81p4
         bIOfTh+BEXFqA6Rgm6CaTo6KLvJZerjKOadl2tAF+qO6c+ooUDcjJi1UAFLHeWFXeEut
         5wmv3lSObDC/hjRw/RSDUIAg8dDyViUAu2eQPzAVaSiIHUDDsbevpesfsKrawxh/UKQs
         j80/L7dBifd1AXBodQmDkO2Qxdynr6CFJTcSkIx3sW8xjJM57DtqysHOdkJFmP7p98m/
         pgGA==
X-Forwarded-Encrypted: i=1; AJvYcCXHM+MzNmixcwfQ19hUNBOYhVERKFu+J6rUkIagUjVcDEaoqrZOyZULyhddYYmccpakYCpuSa9jog==@vger.kernel.org
X-Gm-Message-State: AOJu0YxePJsPEBJMeBgbq6QyssBcvN5TJXbp/PH8Tg0gfJr/MVvddh2v
	eImfDrblta5qLVE4GVJ5XxPnMUbCEvAh0NIqwrK4dVJhe1zGLyMNIINe6Sbh094=
X-Gm-Gg: ASbGncvS+gWEuMJlQAt87HqlUOdLaEbT5kBwyzPxKmoJpqtlNbFw166D2OhshGPARqK
	6h4s6ikMSk5dz+VNEoHON7R1I+/EP2m/Ci4vDMrAPi3TA51syK19bgHq+YSIAXT24sAxu0IjKQU
	K37NaDVkitdVmdFlqBV3o6a6cL0SwrYtaQ8DTzw/O0zqRy4hER5PSyOrkI3tr4sMtWrGeYPBDL7
	iMZlDU29xWoa/ZZ3TirVgsyNrVZMu7WM92X6SDEkDjCLNhNfy1C7QZgrKkl7RmyHn2P0sFp0NQL
	CymY1MJrkABd+SsFC2BNyOyR1qobIA2AXH6+nxyA3A==
X-Google-Smtp-Source: AGHT+IF0ex/iD+sUrbitNrvOanXTZ6pYvDsy9aAY8JPu8xZYMYJcxxzu0L7Lfm7GAzJbTIuYn066Rw==
X-Received: by 2002:a05:6a20:e68f:b0:1ee:c8e7:203c with SMTP id adf61e73a8af0-203b3eea03dmr933373637.24.1744785618538;
        Tue, 15 Apr 2025 23:40:18 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b2221bb77sm582080a12.71.2025.04.15.23.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:40:18 -0700 (PDT)
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
	Danilo Krummrich <dakr@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 07/15] rust: cpu: Add from_cpu()
Date: Wed, 16 Apr 2025 12:09:24 +0530
Message-Id: <cf7c84e4fcd5ef0430d11e02cd727120ba94a248.1744783509.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1744783509.git.viresh.kumar@linaro.org>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
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
 rust/kernel/cpu.rs              | 30 ++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 4 files changed, 33 insertions(+)
 create mode 100644 rust/kernel/cpu.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 12cde55579a0..475abf72869c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6155,6 +6155,7 @@ F:	include/linux/cpuhotplug.h
 F:	include/linux/smpboot.h
 F:	kernel/cpu.c
 F:	kernel/smpboot.*
+F:	rust/kernel/cpu.rs
 
 CPU IDLE TIME MANAGEMENT FRAMEWORK
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index f53d6e1a21f2..ac92c67d2c38 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
 #include <linux/clk.h>
+#include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/cred.h>
 #include <linux/device/faux.h>
diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
new file mode 100644
index 000000000000..10c5c3b25873
--- /dev/null
+++ b/rust/kernel/cpu.rs
@@ -0,0 +1,30 @@
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
+    // SAFETY: It is safe to call `get_cpu_device()` for any CPU.
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
index f4dcfefe94be..db372f806875 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -44,6 +44,7 @@
 pub mod build_assert;
 #[cfg(CONFIG_COMMON_CLK)]
 pub mod clk;
+pub mod cpu;
 pub mod cpumask;
 pub mod cred;
 pub mod device;
-- 
2.31.1.272.g89b43f80a514


