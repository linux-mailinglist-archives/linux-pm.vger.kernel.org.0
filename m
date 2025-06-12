Return-Path: <linux-pm+bounces-28523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EBFAD6706
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 07:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E97C189D6FB
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 05:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8451AAA1F;
	Thu, 12 Jun 2025 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="viLNnXJn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883473C1F
	for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749704483; cv=none; b=pTtKZ720CuENzDEVIj4fphTNdqhlwTrOr/EJ3rpZXEEJFWgVRMbBgP0Eec9u06fjvkYOAROfEzLDSY99J7YxyAQsTxzUhjIJKuApON0fCxkwxgLI7FU5KOTahjMzKXNNVVTnT3eYQnSe5Ls9PVryURnxGbTZw4//XY8G66kWfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749704483; c=relaxed/simple;
	bh=9pHjVMGg2ruxdwaHtiPTktq8Zbd4RUe/LdD/4hfxsW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkiQTMk6KnTwbcWPq1qWRckOt0rydQZoxKVPqjC1+hlRqwBR7BtnLxoieDb4mEr9gbYryqC+JrpShD0g2OJorF7mD+9qiyhGwlisRnQ5PjBeR8u1eyIgYmgL5/FYVedpg/mzah9WJp27AwEG2+qqKxiMI477k19XiqLODMIsfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=viLNnXJn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234d3261631so4070435ad.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 22:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749704481; x=1750309281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ta897ANnsOKw/3ZrDJN+Z/Yd5TG55/Y0TTXdSO5Wgwo=;
        b=viLNnXJngWrQpc05n6uWOIH+yg1CAoaDc7rhmN8TZqE/BcUNz5fRkH4TA/7J10XIU4
         bLlDIsTEezVSVLmDgi//cx0s+pPkgNEhlQzceBU4QKLmDFk3SMpc260bVNjkSta4LU9j
         oW3Tl/sK/FxI+fYwQfhQwXXLWXOKxkRPAh+fIKInhaOW580yODdPTF1+yxwLZUfNpv9W
         y/CW6bdwqbeEbs5+k9h74F4eqlEMl9aGleAYQltTPbJy0mZhaCObpnWxEr9t+ASzXm4e
         L1LZKeFoccFh76AoUCGp2BjsfKQRG+au3B7knpxKzDlf8EU9ytWTgNLDPzZ6PFhrBrn9
         2aLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749704481; x=1750309281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ta897ANnsOKw/3ZrDJN+Z/Yd5TG55/Y0TTXdSO5Wgwo=;
        b=NnUd+b/Qn8eLaQVo8+zFrGQSFWHoLKbw0h1undNdA/NO7qfOGog7KL88TxVn/lt9yx
         tO9N6FvljWr/l5dwuOZonDWw9WeLWJ7KA19uj+8Xsr9/izDBWoiucExUwBPSupjJ3n5E
         eM0ea9nAesrq+2NXMLFj6QKM71bnU52H+c3jfEP4OXKG/Pn1w7ACztS8DuJxoukmpsMQ
         7bahe7bmTlBu0fD4TgRIhIC/XHgjof4SM4qY/dxZw0OiWLm+eevVbbFSSbwzyCGzHPGa
         fjiH4jkUnCVzzwIYwVxuarcBhVSmezg5br87WG04ReXhertOtMZzo/SMAmm8FH7EPK+y
         MC+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHNh69QTm/oWyMIHJ+Vs+F3TlIElT1EXgomANzq5LocaqvxHLWn0L3/KSi8sdpWsB2KAfj2lbIQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKBMSbwfTyUj2wM4PA0UwPJ2UnbUoXOW460OVN8eguXqtesaJ5
	R8XJgaA0zkJibACLEJKa9xq3Ary8Q2Y3HjoKVHAMxdpYr20kB8vMxQC5/u1btHHOhA0=
X-Gm-Gg: ASbGncs1gOETVJrXrVe0Ll8oIKX7Bnj+U+7Tu0DcxbG5LTq59tOzCXRt/RLHvvU57Kx
	2HZ4m2aqXKqtE0D9YuCLO39SX7AbWnY7Aeyfy4dEdDdMImcinRLxBAdTcs3HhLODkHSRjKXT8aJ
	z0F1msQjDBmbsRHnsrjsA7ZVLwG5fKSlxKT23W+9lIWMTZehA9guSp6BB0Hu/nijvL1BukjtLiA
	zM8gU1jKfGrdYQIRFIMPgVaOm/Mxzr0wi16qkCK3A5xGO6/gDoULa4ob8oCF3vqZsGaMIpmZz5v
	LKhZYMarHUZ8N1K0MymlHl68NOVgCrjRIlW8iHK1fYI9l5+J0uf4gFyJKOPW7i5cUjum1spvMQ=
	=
X-Google-Smtp-Source: AGHT+IHFd17mtrnTaIfhEeysW8IO5ia6VXlIvrfEaCUzdPUvSOMJM3AaKiJKr973WWitYYB9zcOAZA==
X-Received: by 2002:a17:902:ef0c:b0:234:986c:66f9 with SMTP id d9443c01a7336-2364ca0c6e4mr33957475ad.22.1749704480788;
        Wed, 11 Jun 2025 22:01:20 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c45sm4698395ad.140.2025.06.11.22.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 22:01:20 -0700 (PDT)
Date: Thu, 12 Jun 2025 10:31:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/3] rust: Use CpuId in place of raw CPU numbers
Message-ID: <20250612050117.3oi6belkf5lrreoh@vireshk-i7>
References: <cover.1749554685.git.viresh.kumar@linaro.org>
 <e790f17123beb45c6a811135ec3df8f0bd761c0e.1749554685.git.viresh.kumar@linaro.org>
 <aEmq8fs1fHSB3z4i@tardis.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEmq8fs1fHSB3z4i@tardis.local>

On 11-06-25, 09:12, Boqun Feng wrote:
> I generally found that `u32::from(cpu)` is more clear than `cpu.into()`,
> but it's up to you. Same for the rest of `cpu.into()` cases.

Updated as:

diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
index 7549594fad7f..abc780d7a8ec 100644
--- a/rust/kernel/cpu.rs
+++ b/rust/kernel/cpu.rs
@@ -129,7 +129,7 @@ fn from(id: CpuId) -> Self {
 /// any references to the CPU device within the notifier's callback.
 pub unsafe fn from_cpu(cpu: CpuId) -> Result<&'static Device> {
     // SAFETY: It is safe to call `get_cpu_device()` for any CPU.
-    let ptr = unsafe { bindings::get_cpu_device(cpu.into()) };
+    let ptr = unsafe { bindings::get_cpu_device(u32::from(cpu)) };
     if ptr.is_null() {
         return Err(ENODEV);
     }
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index ea6106db5c29..11b03e9d7e89 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -527,7 +527,7 @@ pub fn generic_suspend(&mut self) -> Result {
     #[inline]
     pub fn generic_get(&self) -> Result<u32> {
         // SAFETY: By the type invariant, the pointer stored in `self` is valid.
-        Ok(unsafe { bindings::cpufreq_generic_get(self.cpu().into()) })
+        Ok(unsafe { bindings::cpufreq_generic_get(u32::from(self.cpu())) })
     }
 
     /// Provides a wrapper to the register with energy model using the OPP core.
@@ -682,7 +682,7 @@ fn clear_data<T: ForeignOwnable>(&mut self) -> Option<T> {
 impl<'a> PolicyCpu<'a> {
     fn from_cpu(cpu: CpuId) -> Result<Self> {
         // SAFETY: It is safe to call `cpufreq_cpu_get` for any valid CPU.
-        let ptr = from_err_ptr(unsafe { bindings::cpufreq_cpu_get(cpu.into()) })?;
+        let ptr = from_err_ptr(unsafe { bindings::cpufreq_cpu_get(u32::from(cpu)) })?;
 
         Ok(Self(
             // SAFETY: The `ptr` is guaranteed to be valid and remains valid for the lifetime of
diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
index 11ddd43edcb5..19c607709b5f 100644
--- a/rust/kernel/cpumask.rs
+++ b/rust/kernel/cpumask.rs
@@ -94,7 +94,7 @@ pub fn as_raw(&self) -> *mut bindings::cpumask {
     #[inline]
     pub fn set(&mut self, cpu: CpuId) {
         // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `__cpumask_set_cpu`.
-        unsafe { bindings::__cpumask_set_cpu(cpu.into(), self.as_raw()) };
+        unsafe { bindings::__cpumask_set_cpu(u32::from(cpu), self.as_raw()) };
     }
 
     /// Clear `cpu` in the cpumask.
@@ -106,7 +106,7 @@ pub fn set(&mut self, cpu: CpuId) {
     pub fn clear(&mut self, cpu: CpuId) {
         // SAFETY: By the type invariant, `self.as_raw` is a valid argument to
         // `__cpumask_clear_cpu`.
-        unsafe { bindings::__cpumask_clear_cpu(cpu.into(), self.as_raw()) };
+        unsafe { bindings::__cpumask_clear_cpu(i32::from(cpu), self.as_raw()) };
     }
 
     /// Test `cpu` in the cpumask.
@@ -115,7 +115,7 @@ pub fn clear(&mut self, cpu: CpuId) {
     #[inline]
     pub fn test(&self, cpu: CpuId) -> bool {
         // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_test_cpu`.
-        unsafe { bindings::cpumask_test_cpu(cpu.into(), self.as_raw()) }
+        unsafe { bindings::cpumask_test_cpu(i32::from(cpu), self.as_raw()) }
     }
 
     /// Set all CPUs in the cpumask.

-- 
viresh

