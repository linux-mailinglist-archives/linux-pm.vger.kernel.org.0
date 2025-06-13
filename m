Return-Path: <linux-pm+bounces-28667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EC3AD8954
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 12:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF676168595
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB552C15A6;
	Fri, 13 Jun 2025 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSwq20OJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236FF1E0DE8;
	Fri, 13 Jun 2025 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809975; cv=none; b=F08a1sUof3QoWObKddXyCA+9XesIiGl+rhh0yRw/3E8kQzINypta7pGVuG4t+bHsqWhgGH0ppSdu7n+cJLQIOVjwYZM7jm7e6QY4/lOx5LiJhJYh02T4f8L5uzwrpP5YdGJK+3bk2wyJ0U1qtAdQ2S6xF+II02kwk+UX704INhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809975; c=relaxed/simple;
	bh=vG5VPJHwBrHvFMVg43CkcMXHNb8KegOopXpaTYM4A5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pm6LBQEmqN8H0pDKDq86jQCtyCnOqaPYAMULGw6cMY8nMqdIJ+kbU1kKgLRb6SI3nD7Md1B9vAOF3I5WFlnw94cZCfzqohnkM2vgmPjGrBynRppj2hJEmH/2FqP9OwxNNHQn62hyIXUeuyHJ45WrdYU+uvGmLiR5OU8cO6iQOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSwq20OJ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b26d7ddbfd7so2203909a12.0;
        Fri, 13 Jun 2025 03:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749809973; x=1750414773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1TZ09B9fF9qt3C3sRYNWKIJIgwZYwxaDL2K655BrwcY=;
        b=ZSwq20OJ0/aN9J7C24GzgH99HlHFXZFtoYLghootWwMBcLmsFaBpLPlq9u2BpfrnTF
         DN5mVigGZ0muNSgvyTbHIyVoBq6HYzoasOjD3SmVBrKnujuDLlW90HjkRaXNrFxWqxrs
         MIggTVq5qGonoxqsKCB3Cy3TiXMqjDYp/gmhVfGJJ8Ow0pxtAmJcSjPFIcaW4TsKPWTi
         rmFQPDOSKXvgGcDP+a/D5JZBRTM0lZ6IEnUeTDSx67LujIWghFdxRdXnvYuNauuky/zA
         AHQKGTyig2R8QVvrE+t+WX8YTd/ucAM1sY381/gJ4UASRCa2/F0pk/3xN1T6AJlqrQcC
         elTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809973; x=1750414773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TZ09B9fF9qt3C3sRYNWKIJIgwZYwxaDL2K655BrwcY=;
        b=m0EK5w3ikkPeB76TJWV9WajWUAnrGKzDwlX0PGvC97Inkj20ayQ9RAgHYMIkPUP02g
         s8sHqijkTVIWTUE/ru0g2At7ICDuJXzvSOv3OR/OlAAFr37F6PX5CKD5FYnZCtJpXRaA
         3ibj6SHRSLkXpIAwtreTeU+xtztJFedEEtS76fyVXeD7him5oBrba+HjMtQmTFucwovK
         z57l4wYSvsCXTFIxrIOPXljD3+z7tZAhTUWXZmaIUnstyweruXZ0uz10pUF5lRL85T1H
         bt7XZOFn8KeqtBAzXjXjDMY2dQk7oY0Rz4rb6FEptrF/soAQOgsmu8s9oYgHPKlOI0Sc
         3NUA==
X-Forwarded-Encrypted: i=1; AJvYcCVNWsSdCqAbAv4UvIWrhfBF3rRc+3sbpVGNE9ALoMZrjL06vPI7MoubiPneCycYvDsB+ZAUFx16x5O6eTsGBcQ=@vger.kernel.org, AJvYcCVwpoh/XQAFob8C7SKaEp25VUx+EiDSuTHcPzi6BFd0h9AZfjuZ04d09p46wIzrneAoEExP9QcbmgI=@vger.kernel.org, AJvYcCXxUGLB+PggVY7Ee0BY1nPUzSpU0KRRHv3YiYi/EOsvzB7bXhliN31W2LiW4YoxYf0WbMP+V/auPb+ciyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrDO1oe0GPfiAGbQmcXByU0lq5VEJEshHMV1RV3YvYIlrbFOo
	Fk8VdHBJPn2urmpnwDKcD+ioeq+gNzHg5auJ34aZ5IrVSCP3Cc7aYyURyAcrfrE9wMI=
X-Gm-Gg: ASbGncs+VtaZKMeKD3bzqS1vrJfP4r9zfYddcOq/G6zA0zfN+qpyRYDyWyY9mgaGmMt
	hfzH1PXI/SvqDyLZXLZKR1YgvIvCSmSGJ23HhZnS8haMDiX/ZYZoaRa4EpldrY9/b3Uo+Jv1Dwg
	vRd3zI7zR8e9YG+vulsNaYT8NCIPRsAnQCRrSALkRY6UPS+ElLo8aCJykopFif0pPvBekdYNwFn
	Ms/RDpi7tJHE6SQn92WA1Kmqy7L5CEQnTds7zil11TprCMGV9Js97taP2D3uBo4cEGK9z0das1z
	XlkpsCHdHMaChMOnH8/PkkFeIpy6l5MU8x3qaLCRvtCe5ScOm+J8xpO0MFzSnkUD
X-Google-Smtp-Source: AGHT+IHnrhBynvQl4izswdqX0FGr2tTEWxmV7V8m/R0CNjLpc+6kxSaRl0OBDyyoeTl8M6wMWU7Cfw==
X-Received: by 2002:a05:6a21:3982:b0:215:e60b:3bd3 with SMTP id adf61e73a8af0-21facf11c33mr4300123637.29.1749809973179;
        Fri, 13 Jun 2025 03:19:33 -0700 (PDT)
Received: from pop-os.. ([2401:4900:1c96:fdb4:b26c:8198:a171:6fa6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d24bbsm1214044b3a.169.2025.06.13.03.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:19:32 -0700 (PDT)
From: Abhinav Ananthu <abhinav.ogl@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhinav Ananthu <abhinav.ogl@gmail.com>
Subject: [PATCH v3] rust: cpufreq: Ensure C ABI compatibility in all unsafe
Date: Fri, 13 Jun 2025 15:48:16 +0530
Message-Id: <20250613101815.18092-1-abhinav.ogl@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update all `unsafe extern "C"` callback functions in the cpufreq module to
use `kernel::ffi` types (`c_int`, `c_uint`, etc.) instead of Rust-native
types like `i32`, `u32`, or `usize`.

This change ensures that all Rust callbacks have signatures that are
ABI-compatible with their corresponding C counterparts, which is critical
for FFI correctness and safety.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1170
Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
---
 rust/kernel/cpufreq.rs | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 11b03e9d7e89..481a6d2dc362 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1207,8 +1207,8 @@ impl<T: Driver> Registration<T> {
     /// - The pointer arguments must be valid pointers.
     unsafe extern "C" fn target_callback(
         ptr: *mut bindings::cpufreq_policy,
-        target_freq: u32,
-        relation: u32,
+        target_freq: c_uint,
+        relation: c_uint,
     ) -> kernel::ffi::c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
@@ -1226,7 +1226,7 @@ impl<T: Driver> Registration<T> {
     /// - The pointer arguments must be valid pointers.
     unsafe extern "C" fn target_index_callback(
         ptr: *mut bindings::cpufreq_policy,
-        index: u32,
+        index: c_uint,
     ) -> kernel::ffi::c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
@@ -1249,7 +1249,7 @@ impl<T: Driver> Registration<T> {
     /// - The pointer arguments must be valid pointers.
     unsafe extern "C" fn fast_switch_callback(
         ptr: *mut bindings::cpufreq_policy,
-        target_freq: u32,
+        target_freq: c_uint,
     ) -> kernel::ffi::c_uint {
         // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
         // lifetime of `policy`.
@@ -1263,10 +1263,10 @@ impl<T: Driver> Registration<T> {
     ///
     /// - This function may only be called from the cpufreq C infrastructure.
     unsafe extern "C" fn adjust_perf_callback(
-        cpu: u32,
-        min_perf: usize,
-        target_perf: usize,
-        capacity: usize,
+        cpu: c_uint,
+        min_perf: c_ulong,
+        target_perf: c_ulong,
+        capacity: c_ulong,
     ) {
         // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
         let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
@@ -1284,7 +1284,7 @@ impl<T: Driver> Registration<T> {
     /// - The pointer arguments must be valid pointers.
     unsafe extern "C" fn get_intermediate_callback(
         ptr: *mut bindings::cpufreq_policy,
-        index: u32,
+        index: c_uint,
     ) -> kernel::ffi::c_uint {
         // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
         // lifetime of `policy`.
@@ -1305,7 +1305,7 @@ impl<T: Driver> Registration<T> {
     /// - The pointer arguments must be valid pointers.
     unsafe extern "C" fn target_intermediate_callback(
         ptr: *mut bindings::cpufreq_policy,
-        index: u32,
+        index: c_uint,
     ) -> kernel::ffi::c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
@@ -1325,7 +1325,7 @@ impl<T: Driver> Registration<T> {
     /// # Safety
     ///
     /// - This function may only be called from the cpufreq C infrastructure.
-    unsafe extern "C" fn get_callback(cpu: u32) -> kernel::ffi::c_uint {
+    unsafe extern "C" fn get_callback(cpu: c_uint) -> kernel::ffi::c_uint {
         // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
         let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
 
@@ -1351,7 +1351,7 @@ impl<T: Driver> Registration<T> {
     ///
     /// - This function may only be called from the cpufreq C infrastructure.
     /// - The pointer arguments must be valid pointers.
-    unsafe extern "C" fn bios_limit_callback(cpu: i32, limit: *mut u32) -> kernel::ffi::c_int {
+    unsafe extern "C" fn bios_limit_callback(cpu: c_int, limit: *mut c_uint) -> kernel::ffi::c_int {
         // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
         let cpu_id = unsafe { CpuId::from_i32_unchecked(cpu) };
 
@@ -1371,7 +1371,7 @@ impl<T: Driver> Registration<T> {
     /// - The pointer arguments must be valid pointers.
     unsafe extern "C" fn set_boost_callback(
         ptr: *mut bindings::cpufreq_policy,
-        state: i32,
+        state: c_int,
     ) -> kernel::ffi::c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
-- 
2.34.1


