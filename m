Return-Path: <linux-pm+bounces-28359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7954AD34DC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 13:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563557A35DD
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 11:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF317228CBC;
	Tue, 10 Jun 2025 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tV29Jtwd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD018024
	for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554625; cv=none; b=MGz6yvKkKuh86l6KPvcPytkq/gxPVydlPdbgqW9VOLy7CABIP5A+qYYb/taoYwGK2Xf8RG28mAO/7/YmYDyAavLdX6JsiYR7asdUGW2gjpxZqmv+zWMWW3yyH1tNqZqbq9JBOFej5kJZxJV3+9BiFpkzcmU1ByikHNFfqo/cEQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554625; c=relaxed/simple;
	bh=vCjb0uxbfPFk0UYdvMbqoDPkEkRiXB/JN/UWoh+Hxsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ssUFTvsdXB3jM389Djuz7/oLOVLOoG/QjUeg+H2gz0lVExixLrTiBQOZ0kgwVR0zKbr5b6kYzgT88TVrB7NPLlTu/mXbCPcBAn3VUTQB/S8wqklJeWYeHOeEUY/FG/ucZi7YaiYLs2xD0lZ/HtoDJRbHdU9MIwNntxfMrT85ZuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tV29Jtwd; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2c3c689d20so3334671a12.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 04:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749554623; x=1750159423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QAOxshUoslySRqoBSqJuXZMRLjIvGL3UlikR3NO42PI=;
        b=tV29JtwdoG3nSfw8/RxiMhIAjuYPuTrDKkEGi76UA3Otv1vnrIzDOaBOKpLtevRcqp
         t5k/MOG91Lnvt/hH0f/9evv6U1WhElcU0xFqQ/YcfPdpdf0CWxLxE6gHooWDklXIlIol
         kyaHkkhFkAOjV7a7RT+C8+J14E6gL+g7MbS924hiYrRPvwbPgQR7PtUPwU+YhsUr893h
         DyNPXvS81K73cap0IyBEu6dUmbAHujGthrVXLrWNCGtMQhP2wtjmMsUZkeZizH7S51Jo
         HTrEle8MPwPkgivZY3OTFF3qB6cGQgGlJSPNE6vbtFS3voi7PrGPBmNPU2a4pHcGBDrn
         kw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749554623; x=1750159423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAOxshUoslySRqoBSqJuXZMRLjIvGL3UlikR3NO42PI=;
        b=pBrehouZYarprMou49+wHXWOOV5nOd0EiOiyeEYuo2rdsOQCXv5txBo9UkzFpGg+JQ
         Gb/OxRhGTyTx7TY9pdZpf53sHfzd3G1IAtmO0h5LNdKh6LnD86Yp4gcJqblE66Oe5Zx1
         WeeTnpEZpg8kpliQ0MFy+ThSEjqlKP+6aIe0ZGOabc2XpxUx+t5fQpSqcBJGXAN/8VTC
         adRU7xz/Y3Q27eb0rvaaMXKNAD0i/QtQ5U47AEdNXVzWaRptsT6PCQXytQAmsa7V09eG
         Q3ciPwQAbHaqPTc3AbABeUyX6XhvJC5yxhdsCmExKj29zP5FZijXYCL92+RLSYxjAM/0
         +xTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQSuyFwyJrRY5PjD2li+UoNxuAWA7XmiPLPAOn5D32p+VNtpVmSATGIO3y3M3QVtSly2cl4iQvzw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3bXXU87pcBYMw7s5nXySZUilVXbBUbU2cch+AHSFlsLDNplYY
	Z8I/iujWoVFpDngzJxizPtDUw4KVU/qduO4+QuOAJiecg3sXrhbgD7LA3BdJmbK+HTUTiECTQdD
	zhUtb
X-Gm-Gg: ASbGncuDiDJD08whKLhqH6Nj1YA1CWRI7Sc/B+yJetSDsWdDHzqvoNSWlagCd4BJGOZ
	KPhS8HF5bW17ZP/mOQd5/aUUlpZuPj+aopq9SDSSkdKNflg0HyuDP7TPzS3uF5jDCKcslYsU1eP
	oyvjP9jZa1902NtSASA2HfIh961hwe5WJ/10BAuf2iS1JedawppAD/TLyjtGK0AeY4P4GXrqDY8
	Tj1gkNso33sOdi5hpmWLJRWvHnQ5h/xyhyPbRRujdaXLbRsQMoxjfMp4oOO4KEhIqIb5IhX01Lz
	LPMoD/uIgdnvUoQ4LwmD8u5f67bhmh40TG7ThbxTR0FG+HzlAOCfvpqmtbS8kFk=
X-Google-Smtp-Source: AGHT+IECQ3d1p5YhRXaqwtWVtF4QNxUMVW4lM2m6vVyst0oTYorm1TkVH4ar0oNCMOIXUUZpiF/4cg==
X-Received: by 2002:a17:90b:3b42:b0:312:959:dc42 with SMTP id 98e67ed59e1d1-31347302b63mr24129745a91.11.1749554622954;
        Tue, 10 Jun 2025 04:23:42 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349f32df7sm7090063a91.15.2025.06.10.04.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 04:23:42 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Convert `/// SAFETY` lines to `# Safety` sections
Date: Tue, 10 Jun 2025 16:53:34 +0530
Message-Id: <4823a58093c6dfa20df62b5c18da613621b9716e.1749554599.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `/// SAFETY` comments in doc comments with proper `# Safety`
sections, as per rustdoc conventions.

Also mark the C FFI callbacks as `unsafe` to correctly reflect their
safety requirements.

Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://github.com/Rust-for-Linux/linux/issues/1169
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/cpufreq.rs | 146 ++++++++++++++++++++++++++++++-----------
 1 file changed, 109 insertions(+), 37 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index b0a9c6182aec..9b995f18aac6 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1055,8 +1055,11 @@ pub fn new_foreign_owned(dev: &Device<Bound>) -> Result {
 impl<T: Driver> Registration<T> {
     /// Driver's `init` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn init_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn init_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1070,8 +1073,11 @@ extern "C" fn init_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::
 
     /// Driver's `exit` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn exit_callback(ptr: *mut bindings::cpufreq_policy) {
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn exit_callback(ptr: *mut bindings::cpufreq_policy) {
         // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
         // lifetime of `policy`.
         let policy = unsafe { Policy::from_raw_mut(ptr) };
@@ -1082,8 +1088,11 @@ extern "C" fn exit_callback(ptr: *mut bindings::cpufreq_policy) {
 
     /// Driver's `online` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn online_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn online_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1094,8 +1103,13 @@ extern "C" fn online_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi
 
     /// Driver's `offline` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn offline_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn offline_callback(
+        ptr: *mut bindings::cpufreq_policy,
+    ) -> kernel::ffi::c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1106,8 +1120,13 @@ extern "C" fn offline_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ff
 
     /// Driver's `suspend` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn suspend_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn suspend_callback(
+        ptr: *mut bindings::cpufreq_policy,
+    ) -> kernel::ffi::c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1118,8 +1137,11 @@ extern "C" fn suspend_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ff
 
     /// Driver's `resume` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn resume_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn resume_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1130,8 +1152,11 @@ extern "C" fn resume_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi
 
     /// Driver's `ready` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn ready_callback(ptr: *mut bindings::cpufreq_policy) {
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn ready_callback(ptr: *mut bindings::cpufreq_policy) {
         // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
         // lifetime of `policy`.
         let policy = unsafe { Policy::from_raw_mut(ptr) };
@@ -1140,8 +1165,13 @@ extern "C" fn ready_callback(ptr: *mut bindings::cpufreq_policy) {
 
     /// Driver's `verify` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn verify_callback(ptr: *mut bindings::cpufreq_policy_data) -> kernel::ffi::c_int {
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn verify_callback(
+        ptr: *mut bindings::cpufreq_policy_data,
+    ) -> kernel::ffi::c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1152,8 +1182,13 @@ extern "C" fn verify_callback(ptr: *mut bindings::cpufreq_policy_data) -> kernel
 
     /// Driver's `setpolicy` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn setpolicy_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn setpolicy_callback(
+        ptr: *mut bindings::cpufreq_policy,
+    ) -> kernel::ffi::c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1164,8 +1199,11 @@ extern "C" fn setpolicy_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::
 
     /// Driver's `target` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn target_callback(
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn target_callback(
         ptr: *mut bindings::cpufreq_policy,
         target_freq: u32,
         relation: u32,
@@ -1180,8 +1218,11 @@ extern "C" fn target_callback(
 
     /// Driver's `target_index` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn target_index_callback(
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn target_index_callback(
         ptr: *mut bindings::cpufreq_policy,
         index: u32,
     ) -> kernel::ffi::c_int {
@@ -1200,8 +1241,11 @@ extern "C" fn target_index_callback(
 
     /// Driver's `fast_switch` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn fast_switch_callback(
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn fast_switch_callback(
         ptr: *mut bindings::cpufreq_policy,
         target_freq: u32,
     ) -> kernel::ffi::c_uint {
@@ -1212,7 +1256,11 @@ extern "C" fn fast_switch_callback(
     }
 
     /// Driver's `adjust_perf` callback.
-    extern "C" fn adjust_perf_callback(
+    ///
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    unsafe extern "C" fn adjust_perf_callback(
         cpu: u32,
         min_perf: usize,
         target_perf: usize,
@@ -1225,8 +1273,11 @@ extern "C" fn adjust_perf_callback(
 
     /// Driver's `get_intermediate` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn get_intermediate_callback(
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn get_intermediate_callback(
         ptr: *mut bindings::cpufreq_policy,
         index: u32,
     ) -> kernel::ffi::c_uint {
@@ -1243,8 +1294,11 @@ extern "C" fn get_intermediate_callback(
 
     /// Driver's `target_intermediate` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn target_intermediate_callback(
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn target_intermediate_callback(
         ptr: *mut bindings::cpufreq_policy,
         index: u32,
     ) -> kernel::ffi::c_int {
@@ -1262,12 +1316,21 @@ extern "C" fn target_intermediate_callback(
     }
 
     /// Driver's `get` callback.
-    extern "C" fn get_callback(cpu: u32) -> kernel::ffi::c_uint {
+    ///
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    unsafe extern "C" fn get_callback(cpu: u32) -> kernel::ffi::c_uint {
         PolicyCpu::from_cpu(cpu).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
     }
 
     /// Driver's `update_limit` callback.
-    extern "C" fn update_limits_callback(ptr: *mut bindings::cpufreq_policy) {
+    ///
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn update_limits_callback(ptr: *mut bindings::cpufreq_policy) {
         // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
         // lifetime of `policy`.
         let policy = unsafe { Policy::from_raw_mut(ptr) };
@@ -1276,8 +1339,11 @@ extern "C" fn update_limits_callback(ptr: *mut bindings::cpufreq_policy) {
 
     /// Driver's `bios_limit` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn bios_limit_callback(cpu: i32, limit: *mut u32) -> kernel::ffi::c_int {
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn bios_limit_callback(cpu: i32, limit: *mut u32) -> kernel::ffi::c_int {
         from_result(|| {
             let mut policy = PolicyCpu::from_cpu(cpu as u32)?;
 
@@ -1288,8 +1354,11 @@ extern "C" fn bios_limit_callback(cpu: i32, limit: *mut u32) -> kernel::ffi::c_i
 
     /// Driver's `set_boost` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn set_boost_callback(
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn set_boost_callback(
         ptr: *mut bindings::cpufreq_policy,
         state: i32,
     ) -> kernel::ffi::c_int {
@@ -1303,8 +1372,11 @@ extern "C" fn set_boost_callback(
 
     /// Driver's `register_em` callback.
     ///
-    /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn register_em_callback(ptr: *mut bindings::cpufreq_policy) {
+    /// # Safety
+    ///
+    /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
+    unsafe extern "C" fn register_em_callback(ptr: *mut bindings::cpufreq_policy) {
         // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
         // lifetime of `policy`.
         let policy = unsafe { Policy::from_raw_mut(ptr) };
-- 
2.31.1.272.g89b43f80a514


