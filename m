Return-Path: <linux-pm+bounces-26587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B80AA77EE
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 19:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288993A921D
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 17:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C4B1A5BBE;
	Fri,  2 May 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnmgpIGb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B4A28E7;
	Fri,  2 May 2025 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746205279; cv=none; b=ti24K4MQG2yRK3Us44Vb/gz8lYfcsN4xUnBaRf/mfL9PnjAJx7T0tKzm0rhksFH9rIwp6yfNtKJzFZCePVjkBg1W726R2hwx94NKGeR9KYjzhFN3j204arvmdL5bb90R3R73neKA88UcvbVjwBp99x/1WKN1uJCw3NObJuvTkQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746205279; c=relaxed/simple;
	bh=Dji5HAKJDOPgO8igsenuhqrXaSqHaOjkX8g2L9c+1XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNZzWkiikBGmyuyP2Bh/NIsRNlcYWFo5VHgj5KzteJB809Vd209batfOGUVpXtwKf9a8whDnnfuUJ3rx/AgDghVgMivaCmoaOv+Q69SZz3XJPDg6KsLd9GxiLvKI0W9gT1hucO4yX+z/azHhP8vyCyfFmYzsovlUjYM1Goa1F28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnmgpIGb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7398d65476eso1994130b3a.1;
        Fri, 02 May 2025 10:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746205275; x=1746810075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hxpLhyXoic8tBSmQR23kBXzVWBtBA4IoKozyeD3afus=;
        b=CnmgpIGb1FuP/xPraJ++ZZnFnyx02epRA/I6pQHgwEBCYyEKpnZ2wWEVWEZN8IXZR8
         gCjqW8USoZYFxcHesqCMlzkBS4dfca8OH2uScLDuIIAYxfQFki9cKfNEY3vVxrW7nPPl
         Icii/fUINdQGE9L7tHkU1HNpf3nIVoCxKVv8COncgh5ChqyaUGTEZv5l5LAOBx6xZAFp
         gM5hgKxXQ94Pxq3HVTVdWutyUZUz4HNOfVpWdCAT65e7pHjmXP1iLzOPXvDd80xxcy2R
         nFaLAvi1UyDupyIFbKh2ZeUn786+/HskjxEi2Q6f1lHQ/HvaPCTT7sqqdqp0i7XdTMHZ
         2kCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746205275; x=1746810075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxpLhyXoic8tBSmQR23kBXzVWBtBA4IoKozyeD3afus=;
        b=ptA/XTvHr+2BH9wt9KMjpjzkgHhQcPKp9glmIYrtbvMAvTF+5wMtNQRazOop7KDwWP
         8cxja1+uCCqO3sfPa0vP+z3YHzLJf/ttWP9oMYOGpaiGi/wiWHj9MzbcMvIvp5m1axH/
         CZUA4N2x3oTicOLd3GczjJhA+NVINZQHw/3xRgOKfNqNrbh1/khiuRmktWnS7KLhbiKY
         3D8ze1GfvSxDKOcbPwcIRF4/dzJYe54AVrZJbnAYsuxVOQSiRLxYms45/+CZ20X8q1NS
         zFIUS3NdMFM4A73LT4GCysNsmxNW9QH8XkHDuCr4YVQuir0sdFsZKYZgt8+ea+76P4c3
         GiYw==
X-Forwarded-Encrypted: i=1; AJvYcCUbbOM7y//FdCNS0bmdC9BK9gHz1SJ5khJNrYFUngylPDvbfbgfaZfPhZ72Ea9R9I7PECOfku6TBDg43E/ntl4=@vger.kernel.org, AJvYcCUfWBuZMK0DjJkLFOXbaU3zv/VgjpFZFbzu4/w4T+xsrALhQbtvfrpK7C6WoItDTrnuyZhwFAeCxK4=@vger.kernel.org, AJvYcCWIHLk9wEE4dZ4vVhDLxAGLIDJgJTGinLQdq5ySHQ5Q2M21L3LL0FtlMJbrFGbV4vSHki6prkXeKyY=@vger.kernel.org, AJvYcCWIIiAfho72SF0z1UY1hZDOVyWA2hO23GsD1iliG6QlcwfnTZ3Tg+M144w0zX7x9beBx8G8hYNrbC4Jon/M@vger.kernel.org
X-Gm-Message-State: AOJu0YymVKbOTARW0YUQPOIRJEQXGDEDcMxxraJ1pz/8bJZC3H1oJjFG
	mBOZtObBBPNl99fMxX1ctrAKh/904UpFlNQBr0MrfpxpHwOJB1I2
X-Gm-Gg: ASbGncskhiS2SWpY7WFDzAKbIy3o4lkwrIn4Q8FkSg51CShKbsZco0NNQImHj0o9k7+
	ASJHOFUQ5osy2f2rNd3Upw4IE1AYUVrTwGKUlmMnJjxiIncVbj4vB8bHQYWVlMTWpZW3S+Prqmf
	8QyrT9aeVoey2XO9XsNgEBVDbgxVgx+H7UmjN1QAfYH6PfMyLi/9KHQLF/CQH/zqml+CZdq78yQ
	bvmQUdLqS9uapdifONrB+uUIx42NDpQ/JYuXjGU4in/+hU0C8DCRRmkLXFTljNxSwkxHRXxkTA2
	Jxvlq38u1HR5WqsIogsVQAsjPC70JKo3C44XbgY9
X-Google-Smtp-Source: AGHT+IEk+Igw2ARcl3IWx7Uho2ts3OWV/7n1SwhEedFDfvcr2pygX3sPRH2rJ2jk2mGqo1kMFryoYQ==
X-Received: by 2002:a05:6a00:1902:b0:736:aea8:c9b7 with SMTP id d2e1a72fcca58-74049171694mr12358198b3a.2.1746205274909;
        Fri, 02 May 2025 10:01:14 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590a6005sm1881337b3a.174.2025.05.02.10.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 10:01:14 -0700 (PDT)
Date: Fri, 2 May 2025 13:01:12 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V11 02/15] rust: cpumask: Add initial abstractions
Message-ID: <aBT6WK9vcX1oZGmT@yury>
References: <cover.1745218975.git.viresh.kumar@linaro.org>
 <4a8f23fd447897cb76ccc46d03cc30a2086a0e90.1745218975.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a8f23fd447897cb76ccc46d03cc30a2086a0e90.1745218975.git.viresh.kumar@linaro.org>

On Mon, Apr 21, 2025 at 12:52:09PM +0530, Viresh Kumar wrote:
> Add initial Rust abstractions for struct cpumask, covering a subset of
> its APIs. Additional APIs can be added as needed.
> 
> These abstractions will be used in upcoming Rust support for cpufreq and
> OPP frameworks.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

> ---
>  rust/kernel/cpumask.rs | 330 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |   1 +
>  2 files changed, 331 insertions(+)
>  create mode 100644 rust/kernel/cpumask.rs
> 
> diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
> new file mode 100644
> index 000000000000..c90bfac9346a
> --- /dev/null
> +++ b/rust/kernel/cpumask.rs
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! CPU Mask abstractions.
> +//!
> +//! C header: [`include/linux/cpumask.h`](srctree/include/linux/cpumask.h)
> +
> +use crate::{
> +    alloc::{AllocError, Flags},
> +    prelude::*,
> +    types::Opaque,
> +};
> +
> +#[cfg(CONFIG_CPUMASK_OFFSTACK)]
> +use core::ptr::{self, NonNull};
> +
> +#[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
> +use core::mem::MaybeUninit;
> +
> +use core::ops::{Deref, DerefMut};
> +
> +/// A CPU Mask.
> +///
> +/// Rust abstraction for the C `struct cpumask`.
> +///
> +/// # Invariants
> +///
> +/// A [`Cpumask`] instance always corresponds to a valid C `struct cpumask`.
> +///
> +/// The callers must ensure that the `struct cpumask` is valid for access and
> +/// remains valid for the lifetime of the returned reference.
> +///
> +/// ## Examples
> +///
> +/// The following example demonstrates how to update a [`Cpumask`].
> +///
> +/// ```
> +/// use kernel::bindings;
> +/// use kernel::cpumask::Cpumask;
> +///
> +/// fn set_clear_cpu(ptr: *mut bindings::cpumask, set_cpu: u32, clear_cpu: i32) {
> +///     // SAFETY: The `ptr` is valid for writing and remains valid for the lifetime of the
> +///     // returned reference.
> +///     let mask = unsafe { Cpumask::as_mut_ref(ptr) };
> +///
> +///     mask.set(set_cpu);
> +///     mask.clear(clear_cpu);
> +/// }
> +/// ```
> +#[repr(transparent)]
> +pub struct Cpumask(Opaque<bindings::cpumask>);
> +
> +impl Cpumask {
> +    /// Creates a mutable reference to an existing `struct cpumask` pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid for writing and remains valid for the lifetime
> +    /// of the returned reference.
> +    pub unsafe fn as_mut_ref<'a>(ptr: *mut bindings::cpumask) -> &'a mut Self {
> +        // SAFETY: Guaranteed by the safety requirements of the function.
> +        //
> +        // INVARIANT: The caller ensures that `ptr` is valid for writing and remains valid for the
> +        // lifetime of the returned reference.
> +        unsafe { &mut *ptr.cast() }
> +    }
> +
> +    /// Creates a reference to an existing `struct cpumask` pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid for reading and remains valid for the lifetime
> +    /// of the returned reference.
> +    pub unsafe fn as_ref<'a>(ptr: *const bindings::cpumask) -> &'a Self {
> +        // SAFETY: Guaranteed by the safety requirements of the function.
> +        //
> +        // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the
> +        // lifetime of the returned reference.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Obtain the raw `struct cpumask` pointer.
> +    pub fn as_raw(&self) -> *mut bindings::cpumask {
> +        let this: *const Self = self;
> +        this.cast_mut().cast()
> +    }
> +
> +    /// Set `cpu` in the cpumask.
> +    ///
> +    /// ATTENTION: Contrary to C, this Rust `set()` method is non-atomic.
> +    /// This mismatches kernel naming convention and corresponds to the C
> +    /// function `__cpumask_set_cpu()`.
> +    #[inline]
> +    pub fn set(&mut self, cpu: u32) {
> +        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `__cpumask_set_cpu`.
> +        unsafe { bindings::__cpumask_set_cpu(cpu, self.as_raw()) };
> +    }
> +
> +    /// Clear `cpu` in the cpumask.
> +    ///
> +    /// ATTENTION: Contrary to C, this Rust `clear()` method is non-atomic.
> +    /// This mismatches kernel naming convention and corresponds to the C
> +    /// function `__cpumask_clear_cpu()`.
> +    #[inline]
> +    pub fn clear(&mut self, cpu: i32) {
> +        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to
> +        // `__cpumask_clear_cpu`.
> +        unsafe { bindings::__cpumask_clear_cpu(cpu, self.as_raw()) };
> +    }
> +
> +    /// Test `cpu` in the cpumask.
> +    ///
> +    /// Equivalent to the kernel's `cpumask_test_cpu` API.
> +    #[inline]
> +    pub fn test(&self, cpu: i32) -> bool {
> +        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_test_cpu`.
> +        unsafe { bindings::cpumask_test_cpu(cpu, self.as_raw()) }
> +    }
> +
> +    /// Set all CPUs in the cpumask.
> +    ///
> +    /// Equivalent to the kernel's `cpumask_setall` API.
> +    #[inline]
> +    pub fn setall(&mut self) {
> +        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_setall`.
> +        unsafe { bindings::cpumask_setall(self.as_raw()) };
> +    }
> +
> +    /// Checks if cpumask is empty.
> +    ///
> +    /// Equivalent to the kernel's `cpumask_empty` API.
> +    #[inline]
> +    pub fn empty(&self) -> bool {
> +        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_empty`.
> +        unsafe { bindings::cpumask_empty(self.as_raw()) }
> +    }
> +
> +    /// Checks if cpumask is full.
> +    ///
> +    /// Equivalent to the kernel's `cpumask_full` API.
> +    #[inline]
> +    pub fn full(&self) -> bool {
> +        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_full`.
> +        unsafe { bindings::cpumask_full(self.as_raw()) }
> +    }
> +
> +    /// Get weight of the cpumask.
> +    ///
> +    /// Equivalent to the kernel's `cpumask_weight` API.
> +    #[inline]
> +    pub fn weight(&self) -> u32 {
> +        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_weight`.
> +        unsafe { bindings::cpumask_weight(self.as_raw()) }
> +    }
> +
> +    /// Copy cpumask.
> +    ///
> +    /// Equivalent to the kernel's `cpumask_copy` API.
> +    #[inline]
> +    pub fn copy(&self, dstp: &mut Self) {
> +        // SAFETY: By the type invariant, `Self::as_raw` is a valid argument to `cpumask_copy`.
> +        unsafe { bindings::cpumask_copy(dstp.as_raw(), self.as_raw()) };
> +    }
> +}
> +
> +/// A CPU Mask pointer.
> +///
> +/// Rust abstraction for the C `struct cpumask_var_t`.
> +///
> +/// # Invariants
> +///
> +/// A [`CpumaskVar`] instance always corresponds to a valid C `struct cpumask_var_t`.
> +///
> +/// The callers must ensure that the `struct cpumask_var_t` is valid for access and remains valid
> +/// for the lifetime of [`CpumaskVar`].
> +///
> +/// ## Examples
> +///
> +/// The following example demonstrates how to create and update a [`CpumaskVar`].
> +///
> +/// ```
> +/// use kernel::cpumask::CpumaskVar;
> +///
> +/// let mut mask = CpumaskVar::new_zero(GFP_KERNEL).unwrap();
> +///
> +/// assert!(mask.empty());
> +/// mask.set(2);
> +/// assert!(mask.test(2));
> +/// mask.set(3);
> +/// assert!(mask.test(3));
> +/// assert_eq!(mask.weight(), 2);
> +///
> +/// let mask2 = CpumaskVar::try_clone(&mask).unwrap();
> +/// assert!(mask2.test(2));
> +/// assert!(mask2.test(3));
> +/// assert_eq!(mask2.weight(), 2);
> +/// ```
> +pub struct CpumaskVar {
> +    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
> +    ptr: NonNull<Cpumask>,
> +    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
> +    mask: Cpumask,
> +}
> +
> +impl CpumaskVar {
> +    /// Creates a zero-initialized instance of the [`CpumaskVar`].
> +    pub fn new_zero(_flags: Flags) -> Result<Self, AllocError> {
> +        Ok(Self {
> +            #[cfg(CONFIG_CPUMASK_OFFSTACK)]
> +            ptr: {
> +                let mut ptr: *mut bindings::cpumask = ptr::null_mut();
> +
> +                // SAFETY: It is safe to call this method as the reference to `ptr` is valid.
> +                //
> +                // INVARIANT: The associated memory is freed when the `CpumaskVar` goes out of
> +                // scope.
> +                unsafe { bindings::zalloc_cpumask_var(&mut ptr, _flags.as_raw()) };
> +                NonNull::new(ptr.cast()).ok_or(AllocError)?
> +            },
> +
> +            #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
> +            // SAFETY: FFI type is valid to be zero-initialized.
> +            //
> +            // INVARIANT: The associated memory is freed when the `CpumaskVar` goes out of scope.
> +            mask: unsafe { core::mem::zeroed() },
> +        })
> +    }
> +
> +    /// Creates an instance of the [`CpumaskVar`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that the returned [`CpumaskVar`] is properly initialized before
> +    /// getting used.
> +    pub unsafe fn new(_flags: Flags) -> Result<Self, AllocError> {
> +        Ok(Self {
> +            #[cfg(CONFIG_CPUMASK_OFFSTACK)]
> +            ptr: {
> +                let mut ptr: *mut bindings::cpumask = ptr::null_mut();
> +
> +                // SAFETY: It is safe to call this method as the reference to `ptr` is valid.
> +                //
> +                // INVARIANT: The associated memory is freed when the `CpumaskVar` goes out of
> +                // scope.
> +                unsafe { bindings::alloc_cpumask_var(&mut ptr, _flags.as_raw()) };
> +                NonNull::new(ptr.cast()).ok_or(AllocError)?
> +            },
> +            #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
> +            // SAFETY: Guaranteed by the safety requirements of the function.
> +            //
> +            // INVARIANT: The associated memory is freed when the `CpumaskVar` goes out of scope.
> +            mask: unsafe { MaybeUninit::uninit().assume_init() },
> +        })
> +    }
> +
> +    /// Creates a mutable reference to an existing `struct cpumask_var_t` pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid for writing and remains valid for the lifetime
> +    /// of the returned reference.
> +    pub unsafe fn as_mut_ref<'a>(ptr: *mut bindings::cpumask_var_t) -> &'a mut Self {
> +        // SAFETY: Guaranteed by the safety requirements of the function.
> +        //
> +        // INVARIANT: The caller ensures that `ptr` is valid for writing and remains valid for the
> +        // lifetime of the returned reference.
> +        unsafe { &mut *ptr.cast() }
> +    }
> +
> +    /// Creates a reference to an existing `struct cpumask_var_t` pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid for reading and remains valid for the lifetime
> +    /// of the returned reference.
> +    pub unsafe fn as_ref<'a>(ptr: *const bindings::cpumask_var_t) -> &'a Self {
> +        // SAFETY: Guaranteed by the safety requirements of the function.
> +        //
> +        // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the
> +        // lifetime of the returned reference.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Clones cpumask.
> +    pub fn try_clone(cpumask: &Cpumask) -> Result<Self> {
> +        // SAFETY: The returned cpumask_var is initialized right after this call.
> +        let mut cpumask_var = unsafe { Self::new(GFP_KERNEL) }?;
> +
> +        cpumask.copy(&mut cpumask_var);
> +        Ok(cpumask_var)
> +    }
> +}
> +
> +// Make [`CpumaskVar`] behave like a pointer to [`Cpumask`].
> +impl Deref for CpumaskVar {
> +    type Target = Cpumask;
> +
> +    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: The caller owns CpumaskVar, so it is safe to deref the cpumask.
> +        unsafe { &*self.ptr.as_ptr() }
> +    }
> +
> +    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
> +    fn deref(&self) -> &Self::Target {
> +        &self.mask
> +    }
> +}
> +
> +impl DerefMut for CpumaskVar {
> +    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
> +    fn deref_mut(&mut self) -> &mut Cpumask {
> +        // SAFETY: The caller owns CpumaskVar, so it is safe to deref the cpumask.
> +        unsafe { self.ptr.as_mut() }
> +    }
> +
> +    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
> +    fn deref_mut(&mut self) -> &mut Cpumask {
> +        &mut self.mask
> +    }
> +}
> +
> +impl Drop for CpumaskVar {
> +    fn drop(&mut self) {
> +        #[cfg(CONFIG_CPUMASK_OFFSTACK)]
> +        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `free_cpumask_var`.
> +        unsafe {
> +            bindings::free_cpumask_var(self.as_raw())
> +        };
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index de07aadd1ff5..75f78f6bfaa6 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -42,6 +42,7 @@
>  pub mod block;
>  #[doc(hidden)]
>  pub mod build_assert;
> +pub mod cpumask;
>  pub mod cred;
>  pub mod device;
>  pub mod device_id;
> -- 
> 2.31.1.272.g89b43f80a514

