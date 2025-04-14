Return-Path: <linux-pm+bounces-25367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295EEA87F05
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 13:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0833B791F
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1EB28C5D0;
	Mon, 14 Apr 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLSMqNTm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5027E1A7
	for <linux-pm@vger.kernel.org>; Mon, 14 Apr 2025 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630189; cv=none; b=WwBpl2EIlvdorM0PkrZx0RigFlLYhupNs3ymC4PH3GMIBe70o4FNttmHNZ9Sdk+B+sPzFzxjnMDNioc5PBEQd21RHCDlFpSNmQw5Vh5MpST+1ug//PCNaTdIS04AtPYTX6mxjnIIs8lW4jam3DolTazUU82QTeOiYQ3DZpbLWEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630189; c=relaxed/simple;
	bh=OId65vYG4iChVP7s+ep0NmfGVOgkQkETuAsaQF/JGAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uR9pvxBL98BnddoYDt4G+hFO5tienB5FbfttYO1+Rd17/o1vhn+Kni8i8EEsL7Edm1UB0dU39BqL+G4C3/PwZs3OEC/tndfi4/zt65zrZiMiSAt9fGKdDznnql8jiRy5OfU35F5O7ZVMUISV42QEbz2uptfB9bct8U8hRae3CSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aLSMqNTm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2240b4de12bso55965865ad.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Apr 2025 04:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744630187; x=1745234987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6+sNIyO8JzbVU9H6WY1PZualMiTtrIWYxB95T2aKKg=;
        b=aLSMqNTmz41GrHp26HLeqezmtfrsjDxmMQIcAABezKLFe96hlbVkNUl92pj1yPyYWe
         wxfKyNvI1P/ID5roBtHIHz9J7NuZZIQe9tI/7eT+D1is04Qu32vMhJrrKKbonBSQ9/hR
         AbC2YEdSj6zu+u6QPwmoAMKQbtOzGzOyFlCJydosAOvG46/1nIn4usbvNopkI0c4dExI
         GdL2uO1SRXCXsNxsvhwqBckjxjrdiM8zNaGxpCylg1h7DnzOWRPcs2cLikwHKb07mVf5
         9HGyw6SB9nusv23J1JDE2ZqbSANGOCnTLGiLwQuGLIBT5UcICZ74BrnjPLf1uybLVUKT
         sE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744630187; x=1745234987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6+sNIyO8JzbVU9H6WY1PZualMiTtrIWYxB95T2aKKg=;
        b=j0l9djgrJzVwNwzwC83YMaIiHLEqVWhuY9Ct2cwO7kyZj6zhSjsYctO6etRr655Rkv
         aaOAWL5jUN7e583HibmilEDNe0SBpuaTInyeqi6NjnGQxcxtrMGKQRO2/sCjMQR76qG6
         sYgbhnGYUSQlZOp0xC3AOmczwFCZdGU2x4e7VeXNVSTV64tl8dhgZ7UFsZBGdbKd5RaM
         wJQVlQ0TWFceC5/hLHFdx1SlkxmfFh33+u3Vrd54FmAFF87k8vjwxyPZjVQRjOe+Oei2
         /WLCFMeFOJtdKaWGe162O0qqsmz7TkOqHYEqXGeBJqMMJjSXCj1rSrk2Kw9L/10tdvqS
         lDIA==
X-Forwarded-Encrypted: i=1; AJvYcCXgBANG4dNo1kFH1zMkv8/k/oTBUEQfT2P+v55Uqq8jrVXpYz8aPxMWKyezTPHKXndQESBs9SdFtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJGwPY5lADMS8zgnXRAKW5c1tJFZxpZy23mC8j1uTFG0XudjG
	toVjbu5IY1sKZkGb/TpmhGRC+Jq9LFxXtHAiSejJqBlKYgz5bGN4TxZ4fXlZPUo=
X-Gm-Gg: ASbGncvNzOXd/OdTolnX9phwPLhyVuiX1+776J7/qKitZNtk7QecYw3pf93nfGroxXc
	dVAULpc+UUYRzxGhcTLKsEBzyL5zICe/PoLcExKqWLtOJTuWcCqU4FML8kBbx5SwWcvwC68jxb3
	Ect0pmPQGTlARSXWAovvcOMkZ2h6whpCx8x9Virz64YZo8D+gm78U5DJvXgV8sqV4HyHLtlNDqu
	Gz8phxe9gqIrCznwlMFNU453VHh5eThM7bkaIZUqeexTgw0fyfsLIDqT+uQBQcDLt6G390zAZBL
	Ukx0ssR8gUe1o/VgmjDPOM470wn6IvesCg9Y0oldvQ==
X-Google-Smtp-Source: AGHT+IE2yePppLq/70OKRdNpVINOxCz29KaYhLiwBomV/BOoxtq3utngiXMthhUwoFkXpZSNMWS9Gg==
X-Received: by 2002:a17:903:1d1:b0:21f:f3d:d533 with SMTP id d9443c01a7336-22bea4a17fdmr134579745ad.2.1744630186633;
        Mon, 14 Apr 2025 04:29:46 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b628desm96556265ad.20.2025.04.14.04.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 04:29:46 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:59:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yury Norov <yury.norov@gmail.com>, Danilo Krummrich <dakr@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 03/17] rust: cpumask: Add initial abstractions
Message-ID: <20250414112943.r2h3a54r2jm4iana@vireshk-i7>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
 <9a004e3dff5321dae3b96df2817799daa699ce01.1744366571.git.viresh.kumar@linaro.org>
 <Z_k7HtIZaSWeJvM4@yury>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_k7HtIZaSWeJvM4@yury>

On 11-04-25, 11:54, Yury Norov wrote:
> On Fri, Apr 11, 2025 at 04:25:02PM +0530, Viresh Kumar wrote:
> > +    unsafe fn new_uninit(_flags: Flags) -> Result<Self, AllocError> {
> > +        Ok(Self {
> > +            #[cfg(CONFIG_CPUMASK_OFFSTACK)]
> > +            ptr: {
> > +                let mut ptr: *mut bindings::cpumask = ptr::null_mut();
> > +
> > +                // SAFETY: Depending on the value of `_flags`, this call may sleep. Other than
> > +                // that, it is always safe to call this method.
> 
> I'm not sure I understand this sentence. What's wrong with safety when
> the alloc() function sleeps? Even if something is wrong. If you really
> want to protect your users, you'd introduce new_sync() version that
> returns error if user provides sleeping flags.

I borrowed this SAFETY comment from similar allocation done in
page.rs, I think we can skip it though. Here is the delta so far:

@@ -27,8 +27,8 @@
 ///
 /// A [`Cpumask`] instance always corresponds to a valid C `struct cpumask`.
 ///
-/// The callers must ensure that the `struct cpumask` is valid for access and remains valid for the
-/// lifetime of the returned reference.
+/// The callers must ensure that the `struct cpumask` is valid for access and
+/// remains valid for the lifetime of the returned reference.
 ///
 /// ## Examples
 ///
@@ -86,7 +86,9 @@ pub fn as_raw(&self) -> *mut bindings::cpumask {
 
     /// Set `cpu` in the cpumask.
     ///
-    /// Equivalent to the kernel's `__cpumask_set_cpu` API.
+    /// ATTENTION: Contrary to C, this Rust `set()` method is non-atomic.
+    /// This mismatches kernel naming convention and corresponds to the C
+    /// function `__cpumask_set_cpu()`.
     #[inline]
     pub fn set(&mut self, cpu: u32) {
         // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `__cpumask_set_cpu`.
@@ -95,7 +97,9 @@ pub fn set(&mut self, cpu: u32) {
 
     /// Clear `cpu` in the cpumask.
     ///
-    /// Equivalent to the kernel's `__cpumask_clear_cpu` API.
+    /// ATTENTION: Contrary to C, this Rust `clear()` method is non-atomic.
+    /// This mismatches kernel naming convention and corresponds to the C
+    /// function `__cpumask_clear_cpu()`.
     #[inline]
     pub fn clear(&mut self, cpu: i32) {
         // SAFETY: By the type invariant, `self.as_raw` is a valid argument to
@@ -198,15 +202,14 @@ pub struct CpumaskVar {
 }
 
 impl CpumaskVar {
-    /// Creates an initialized instance of the [`CpumaskVar`].
-    pub fn new(_flags: Flags) -> Result<Self, AllocError> {
+    /// Creates a zero-initialized instance of the [`CpumaskVar`].
+    pub fn new_zero(_flags: Flags) -> Result<Self, AllocError> {
         Ok(Self {
             #[cfg(CONFIG_CPUMASK_OFFSTACK)]
             ptr: {
                 let mut ptr: *mut bindings::cpumask = ptr::null_mut();
 
-                // SAFETY: Depending on the value of `_flags`, this call may sleep. Other than
-                // that, it is always safe to call this method.
+                // SAFETY: It is safe to call this method as the reference to `ptr` is valid.
                 //
                 // INVARIANT: The associated memory is freed when the `CpumaskVar` goes out of
                 // scope.
@@ -222,20 +225,19 @@ pub fn new(_flags: Flags) -> Result<Self, AllocError> {
         })
     }
 
-    /// Creates an uninitialized instance of the [`CpumaskVar`].
+    /// Creates an instance of the [`CpumaskVar`].
     ///
     /// # Safety
     ///
     /// The caller must ensure that the returned [`CpumaskVar`] is properly initialized before
     /// getting used.
-    unsafe fn new_uninit(_flags: Flags) -> Result<Self, AllocError> {
+    unsafe fn new(_flags: Flags) -> Result<Self, AllocError> {
         Ok(Self {
             #[cfg(CONFIG_CPUMASK_OFFSTACK)]
             ptr: {
                 let mut ptr: *mut bindings::cpumask = ptr::null_mut();
 
-                // SAFETY: Depending on the value of `_flags`, this call may sleep. Other than
-                // that, it is always safe to call this method.
+                // SAFETY: It is safe to call this method as the reference to `ptr` is valid.
                 //
                 // INVARIANT: The associated memory is freed when the `CpumaskVar` goes out of
                 // scope.

> > +    /// Creates a mutable reference to an existing `struct cpumask_var_t` pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The caller must ensure that `ptr` is valid for writing and remains valid for the lifetime
> > +    /// of the returned reference.
> > +    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpumask_var_t) -> &'a mut Self {
> 
> The 'from' (wrt cpumasks) has a special meaning: search for a cpu
> starting from a given one. This 'from_raw' may confuse readers. Have
> you any other name for it in mind?

'from_raw' is widely used in Rust for similar methods, though I do
understand your concerns.

Danilo / Miguel, what do you suggest I rename these to ?

> > +        // SAFETY: Guaranteed by the safety requirements of the function.
> > +        //
> > +        // INVARIANT: The caller ensures that `ptr` is valid for writing and remains valid for the
> > +        // lifetime of the returned reference.
> > +        unsafe { &mut *ptr.cast() }
> > +    }
> > +    /// Clones cpumask.
> > +    pub fn try_clone(cpumask: &Cpumask) -> Result<Self> {
> 
> Just clone(), I think.

The method 'clone()' is already used by the 'Clone' trait [1], and
that's what I wanted to use initially. But 'clone' doesn't return a
'Result'.

-- 
viresh

[1] https://doc.rust-lang.org/std/clone/trait.Clone.html

