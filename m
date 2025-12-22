Return-Path: <linux-pm+bounces-39775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4475CD5FB0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 13:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C80B3005EB8
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 12:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0EE23A9BD;
	Mon, 22 Dec 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQgCSt2n"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E946BFCE;
	Mon, 22 Dec 2025 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766406579; cv=none; b=A6KNOYZ++efDqwMbblfkeNuXwLPtviXCUjxHtI4Wj8CjgaUpnjHfiiCwPGIF+4lT3CiDkqGj3H5jAqBe3roi3r1KAKM49EA30rsWqmZwlPwqSGItI3uwZdXvzTzshM2/eBfxpMZ8hJ0795ghkVMLQcmOG29l1D3vY0Ge4lkPKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766406579; c=relaxed/simple;
	bh=2G0/TbpRpEY08Dw+lJgLBhbGwn9HvxIvXWSw1WPXQow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tflV2gINQJSuxd1uiaKPOBJ1kQO5m5dmYVrWAtYnfasCeY/tQ5NVAIgjnJKVPhZ1nCICJ3+GJlauX2bl/jo05sxPB0jcZlUGkv1RPSMtMFqt2LGn5DzUn83ZAc6ktc6CEceb7P2IU8MF1FzIcHsmTX5TuHNgESwpyT1MhEABVQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQgCSt2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FEEC4CEF1;
	Mon, 22 Dec 2025 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766406578;
	bh=2G0/TbpRpEY08Dw+lJgLBhbGwn9HvxIvXWSw1WPXQow=;
	h=From:Date:Subject:To:Cc:From;
	b=iQgCSt2nDpREmaxV5n847O4OFRkZ2VIljxcOMpy2J19Fyyuc6lFbJ1MaZXi7gpevy
	 QdZ+KY3Zyq8J14f7Sr9j+MnwKNHZ0t3Mmi9BrVqcIg9wJw93fMjCihRWMQ/u9wCxWW
	 ZLDpLe1/WjtvyKpp9Umo3BNIdtSxl27eeWCZ9feRxPnvotAgJlk194/W682tUcKPAV
	 bzeWPfiZw7+hEuwcX4hok865IZyxt2laiYPzCKDuGUXGKPZNLDxvRucx4jkw2wN5on
	 h1EK670TjFAnsYqplDZsYlOWde5otlcvyagd0fukXXUOfO4V9+KTARPCHCvUeSkf1z
	 FeI1W3CExmc1g==
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 22 Dec 2025 13:29:32 +0100
Subject: [PATCH] rust: cpufreq: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-cstr-cpufreq-v1-1-2d99dfc88cbb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ5EQAyA4VeRnncSU0HiVTZ7oDrUwdIiEvHuB
 sfv8P8HGKuwQZUcoLyJyX+M8J8EqK/Hjp200YAp5h4RHdmijqY1KM+uxJzarKA6DR5iMikH2Z/
 d9/fa1mZgWu4HnOcF8ZpLNXAAAAA=
X-Change-ID: 20251222-cstr-cpufreq-725cd36ca0f1
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1766406574; l=2533;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=URejYURVdgM8xsn8wNpsqiJMx/VUH8dxw+RDn7bQgdw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEyO4qNIUfiiQW9I5t4F7WkcUXH4wt9Bo9uqWZs3y+Dq3yJSj18scNHUGrfLjsEdKwgn1PYlxDR
 irs+xzDBMtQE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

From: Tamir Duberstein <tamird@gmail.com>

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/cpufreq/rcpufreq_dt.rs | 5 ++---
 rust/kernel/cpufreq.rs         | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 31e07f0279db..f17bf64c22e2 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -3,7 +3,6 @@
 //! Rust based implementation of the cpufreq-dt driver.
 
 use kernel::{
-    c_str,
     clk::Clk,
     cpu, cpufreq,
     cpumask::CpumaskVar,
@@ -52,7 +51,7 @@ impl opp::ConfigOps for CPUFreqDTDriver {}
 
 #[vtable]
 impl cpufreq::Driver for CPUFreqDTDriver {
-    const NAME: &'static CStr = c_str!("cpufreq-dt");
+    const NAME: &'static CStr = c"cpufreq-dt";
     const FLAGS: u16 = cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV;
     const BOOST_ENABLED: bool = true;
 
@@ -197,7 +196,7 @@ fn register_em(policy: &mut cpufreq::Policy) {
     OF_TABLE,
     MODULE_OF_TABLE,
     <CPUFreqDTDriver as platform::Driver>::IdInfo,
-    [(of::DeviceId::new(c_str!("operating-points-v2")), ())]
+    [(of::DeviceId::new(c"operating-points-v2"), ())]
 );
 
 impl platform::Driver for CPUFreqDTDriver {
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index f968fbd22890..8be634eaabe9 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -840,7 +840,6 @@ fn register_em(_policy: &mut Policy) {
 /// ```
 /// use kernel::{
 ///     cpufreq,
-///     c_str,
 ///     device::{Core, Device},
 ///     macros::vtable,
 ///     of, platform,
@@ -853,7 +852,7 @@ fn register_em(_policy: &mut Policy) {
 ///
 /// #[vtable]
 /// impl cpufreq::Driver for SampleDriver {
-///     const NAME: &'static CStr = c_str!("cpufreq-sample");
+///     const NAME: &'static CStr = c"cpufreq-sample";
 ///     const FLAGS: u16 = cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV;
 ///     const BOOST_ENABLED: bool = true;
 ///

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251222-cstr-cpufreq-725cd36ca0f1

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


