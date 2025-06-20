Return-Path: <linux-pm+bounces-29149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D1BAE16C4
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 10:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CCA2177CFE
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560925B1EF;
	Fri, 20 Jun 2025 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKS3Vlj+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C166253934;
	Fri, 20 Jun 2025 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409712; cv=none; b=osrL2gKSH/KF/k/7kT+qJhxiR0DohGnqLv1QUllGoLht90RczCx2BuxQ9LvIQFqIOYCK5z/I/klcE+w8CNFR/CBFwJXHxc/V8nma7PXraCilCJDRkX7at50NJGqQY/M7SaQbLs3eLsl9WtuyvRtTUzi0a3yZZLSl56O9IlFB/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409712; c=relaxed/simple;
	bh=bVAYXmi1mGHMSd3f6pN5I21LAjlBO11vnhsVsIy5x8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jKlGETbFaSbaGBYT3mARvFS1vQjNmKSYk6V6poRI5LbGCZe8u1+HVhSOsk9Wec9XZGij69UVad8iU/dbs+UrvXJdeaq19duFP8ROqYG8LjVAr4Y6/1UZ2eHwvVn0Sa0Z5ncF1HIhULJ5AKNT1fhYjY1AME2bkqBQLmAfnn09UPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKS3Vlj+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748f54dfa5fso1081902b3a.2;
        Fri, 20 Jun 2025 01:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750409710; x=1751014510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iv3oZXqRsz+u6cGWSKhTrYlL4O94V/iX3UEF0MlMpEU=;
        b=HKS3Vlj+3YXvovL0JcgAxL2ZXT5qFo4hs47TZ6admL1meDS2iG7tSOIkN2MEfugs7U
         GnXw22c+8VLe3f+coSwRT0WkfF6TgXJvHEFzUU92rKWVpPWzqTFpq3hHn3b657+W8RXo
         ePlfWuZg8vTvtc71Idag9tlWxKom19X4Xxdr53NpyiHKBpyz0qJDZJNrjiJF4mw+cwk1
         xw32of1vT0OfWW0dQD2ot0dOLNhrLyT7VP1dZLN4VXfQidgHooGA9/B7Z06HQXY0EGpR
         YL7bO1Vzbctw2B4GZId4sFx3iPTL7zBToPyoD4Lx11GowZSrZyEcpVBrmzKQCexUdYhu
         IyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750409710; x=1751014510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iv3oZXqRsz+u6cGWSKhTrYlL4O94V/iX3UEF0MlMpEU=;
        b=WZOe+FV2D1ZQ8v0H/BWmOY1J8yZp6gpNRjfUbwW8Y2C+Z3bb21MDNR8V1Sjn5LoSuQ
         eDNHumKHEx8qXPAR1FcjX+2snQz5mnMbHGlKjdJa9JJzKQCgway8k+58uk7EMa+USJU4
         BveoSw1o9c8BJNp6X/VVetAYCzZ/p6oLfoMA6oqROZ9J4Xi9O+sZWfp4Sry/RxHdICAk
         nSrMapepxrF2yH6aFvHg9ftTS4GXXE0nDi7eCP8VqwKz080gQBN+X1XwUH9GrnZ3mWWP
         06IsW+rNDhd1xLelyHqRrUehNGbyFYMPZD+zP9LODZGRtCmtyoGsI0Y4mSBsGoEcTrfp
         dnTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVKK1dqybV7LFm95U8M4C1iuV4CIBz5rh65VhlJIsoBGE27ZQdbmjR5IB0HsmKIL2J0yi2p4uHEDKXya0=@vger.kernel.org, AJvYcCVUya2w0zgMIEeKZBMqjGUjKXqt2NJgWjh0Lc1IYT3df3bLNS5H4Y5N1SroTcUWV0sOk1dIYjwimfQ=@vger.kernel.org, AJvYcCWOCr292hxzUQjOqK3Vaa7bxont85+7FeZXMl7plNDfs1ulD7rxJPcep82k31IfM5E27tilScW9ui5yYBsa/dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS9zIWh3koZfDc2Cmy101qSenxkVHeRw+/h164rhAbBJ6JPFbi
	DggRkYfCB1Srndq5N9RlJQfHw0tySNJ6lrcqGnWBxoGW+vW3QSEKo3pU
X-Gm-Gg: ASbGncu8PmOmC1V33W3p85O9AIxvf9vLffNPrwpZqjnfbTy1l7kYBvgsDDHb/uIvgr4
	CDTCCqSMjc+7qzeal5bYGVm1c7DrMjmxLHCIAP/xbOqkA3duT/Q/1mKAUMNaWi8TDtrkGhv3nMg
	nRDg2ulDojPPLzoZtJdweqGZdhQT7C92Pn1SvEFdQ0EygnCMoon6aNgpO/ddwuAxo+PlwmAeYnc
	1OwzwInVSP10S1rqJphAaIaXccDDdj//X4pJe/9zuY3mp9q4Y6cUSdjyR6xHJ27RZHrV7SrYkG3
	pbNVLKvPVVcvNsBEzExSPEjCzeqmFcR8fIgSlo1JtBjL1NOeMm56msv6NJbf
X-Google-Smtp-Source: AGHT+IF67WJrN3hf2vcD3jXzZM/KBmIBc10Qpir3d5KV+HevWSCQcanboakFIo/NmXsywHkFLR7yIg==
X-Received: by 2002:a05:6a00:a1f:b0:748:2e1a:84e3 with SMTP id d2e1a72fcca58-7490d9aae0emr3470234b3a.8.1750409710050;
        Fri, 20 Jun 2025 01:55:10 -0700 (PDT)
Received: from pop-os.. ([103.21.124.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a66a819sm1549985b3a.139.2025.06.20.01.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 01:55:09 -0700 (PDT)
From: Abhinav Ananthu <abhinav.ogl@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhinav Ananthu <abhinav.ogl@gmail.com>
Subject: [PATCH] rust: cpufreq: use c_ types from kernel prelude
Date: Fri, 20 Jun 2025 14:22:30 +0530
Message-Id: <20250620085229.18250-1-abhinav.ogl@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update cpufreq FFI callback signatures to use `c_int` from the `kernel::prelude`,
rather than accessing it explicitly through `kernel::ffi::c_int`.

Although these types are defined in the `ffi` crate, they are re-exported
via `kernel::prelude`. This aligns with the Rust-for-Linux coding
guidelines and ensures proper C ABI compatibility across platforms.

Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/cpufreq.rs | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 481a6d2dc362..fda7301c404e 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1061,7 +1061,7 @@ impl<T: Driver> Registration<T> {
     ///
     /// - This function may only be called from the cpufreq C infrastructure.
     /// - The pointer arguments must be valid pointers.
-    unsafe extern "C" fn init_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
+    unsafe extern "C" fn init_callback(ptr: *mut bindings::cpufreq_policy) -> c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1094,7 +1094,7 @@ impl<T: Driver> Registration<T> {
     ///
     /// - This function may only be called from the cpufreq C infrastructure.
     /// - The pointer arguments must be valid pointers.
-    unsafe extern "C" fn online_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
+    unsafe extern "C" fn online_callback(ptr: *mut bindings::cpufreq_policy) -> c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1111,7 +1111,7 @@ impl<T: Driver> Registration<T> {
     /// - The pointer arguments must be valid pointers.
     unsafe extern "C" fn offline_callback(
         ptr: *mut bindings::cpufreq_policy,
-    ) -> kernel::ffi::c_int {
+    ) -> c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1128,7 +1128,7 @@ impl<T: Driver> Registration<T> {
     /// - The pointer arguments must be valid pointers.
     unsafe extern "C" fn suspend_callback(
         ptr: *mut bindings::cpufreq_policy,
-    ) -> kernel::ffi::c_int {
+    ) -> c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1143,7 +1143,7 @@ impl<T: Driver> Registration<T> {
     ///
     /// - This function may only be called from the cpufreq C infrastructure.
     /// - The pointer arguments must be valid pointers.
-    unsafe extern "C" fn resume_callback(ptr: *mut bindings::cpufreq_policy) -> kernel::ffi::c_int {
+    unsafe extern "C" fn resume_callback(ptr: *mut bindings::cpufreq_policy) -> c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1173,7 +1173,7 @@ impl<T: Driver> Registration<T> {
     /// - The pointer arguments must be valid pointers.
     unsafe extern "C" fn verify_callback(
         ptr: *mut bindings::cpufreq_policy_data,
-    ) -> kernel::ffi::c_int {
+    ) -> c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1190,7 +1190,7 @@ impl<T: Driver> Registration<T> {
     /// - The pointer arguments must be valid pointers.
     unsafe extern "C" fn setpolicy_callback(
         ptr: *mut bindings::cpufreq_policy,
-    ) -> kernel::ffi::c_int {
+    ) -> c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1209,7 +1209,7 @@ impl<T: Driver> Registration<T> {
         ptr: *mut bindings::cpufreq_policy,
         target_freq: c_uint,
         relation: c_uint,
-    ) -> kernel::ffi::c_int {
+    ) -> c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1227,7 +1227,7 @@ impl<T: Driver> Registration<T> {
     unsafe extern "C" fn target_index_callback(
         ptr: *mut bindings::cpufreq_policy,
         index: c_uint,
-    ) -> kernel::ffi::c_int {
+    ) -> c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1250,7 +1250,7 @@ impl<T: Driver> Registration<T> {
     unsafe extern "C" fn fast_switch_callback(
         ptr: *mut bindings::cpufreq_policy,
         target_freq: c_uint,
-    ) -> kernel::ffi::c_uint {
+    ) -> c_uint {
         // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
         // lifetime of `policy`.
         let policy = unsafe { Policy::from_raw_mut(ptr) };
@@ -1285,7 +1285,7 @@ impl<T: Driver> Registration<T> {
     unsafe extern "C" fn get_intermediate_callback(
         ptr: *mut bindings::cpufreq_policy,
         index: c_uint,
-    ) -> kernel::ffi::c_uint {
+    ) -> c_uint {
         // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
         // lifetime of `policy`.
         let policy = unsafe { Policy::from_raw_mut(ptr) };
@@ -1306,7 +1306,7 @@ impl<T: Driver> Registration<T> {
     unsafe extern "C" fn target_intermediate_callback(
         ptr: *mut bindings::cpufreq_policy,
         index: c_uint,
-    ) -> kernel::ffi::c_int {
+    ) -> c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
@@ -1325,7 +1325,7 @@ impl<T: Driver> Registration<T> {
     /// # Safety
     ///
     /// - This function may only be called from the cpufreq C infrastructure.
-    unsafe extern "C" fn get_callback(cpu: c_uint) -> kernel::ffi::c_uint {
+    unsafe extern "C" fn get_callback(cpu: c_uint) -> c_uint {
         // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
         let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
 
@@ -1351,7 +1351,7 @@ impl<T: Driver> Registration<T> {
     ///
     /// - This function may only be called from the cpufreq C infrastructure.
     /// - The pointer arguments must be valid pointers.
-    unsafe extern "C" fn bios_limit_callback(cpu: c_int, limit: *mut c_uint) -> kernel::ffi::c_int {
+    unsafe extern "C" fn bios_limit_callback(cpu: c_int, limit: *mut c_uint) -> c_int {
         // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
         let cpu_id = unsafe { CpuId::from_i32_unchecked(cpu) };
 
@@ -1372,7 +1372,7 @@ impl<T: Driver> Registration<T> {
     unsafe extern "C" fn set_boost_callback(
         ptr: *mut bindings::cpufreq_policy,
         state: c_int,
-    ) -> kernel::ffi::c_int {
+    ) -> c_int {
         from_result(|| {
             // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
             // lifetime of `policy`.
-- 
2.34.1


