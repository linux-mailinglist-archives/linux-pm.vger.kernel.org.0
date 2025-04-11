Return-Path: <linux-pm+bounces-25276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1282EA86265
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15C14407E4
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13062211711;
	Fri, 11 Apr 2025 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJtlJKMT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2329220F063;
	Fri, 11 Apr 2025 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386852; cv=none; b=Mr9Hj6YpbYvEZ03tIyiLlJ3rq+tYUTFhT+zU/rZz5p/kBIPmy3ADXQmfwqZcrmo6DXkKc3yh+sIXlytmDkGXGJWcodaZOBnkL3cu47eip8fzySr2XKT3RPqrBr8mEGMJ26s4Y/Fw6VZNQanwOeX41hUQ2HYCQbad8LQl9ZLuLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386852; c=relaxed/simple;
	bh=vZWRAFC7VVmgtDQU05G9oaDc3mE9TN+0TOorRGW1Vec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STafSSN4pPhOxY9uIOi+vI6VLNggWVgnPWZvbaNlAflVKjhkUqYp6YPb6EKvbUtJWKomc+BIEsI3tOtRZHhN5LmDyNp6AX8ISFbdfjSbd4+y3ULCZCI3AfC+QWbvweMHnxHzRRtMl1e/Y5aGCvUF0eIQT8TIlehS9tMX+OGkul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJtlJKMT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2295d78b433so24337215ad.2;
        Fri, 11 Apr 2025 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744386849; x=1744991649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnKm+6tC2zelvOBneCrI98AlFvqJft8qt+3agL2U09E=;
        b=GJtlJKMTLRuiyuPynR8XU/RexfKKP59N8bco/f8lZlB+oCtS/Z/TAonlVGUYBTsHnY
         3wJ/EToIe24rnwqTR3l79ULEeTqDKwLIJCw8NSqGrwgaOgm6Rg3xv74F7hTffr6FSwzt
         SOAi9OxIHCar/b73V5gV64RpJ4Co5o493IYQiG4ubSDMWmb77LATCq9z+sEDZoam8nG5
         MJt427EicpVOTzELFeRAyWfuqE9pHLAducKncyGxZnfung4b0cpWEGnwuLxYWGTr+so4
         5bf6ElpiidmwJIuEjPUI5Wc9yRoB03gasssFn9GU1b03Azu4qQ1hSfTU4xIWwqeaSOmQ
         OUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744386849; x=1744991649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnKm+6tC2zelvOBneCrI98AlFvqJft8qt+3agL2U09E=;
        b=nEFMxFievWcBN71BzPnRY9Nfa6SpGem51pD0bWDdE93l6A/QNoV37Yw+p7TYmxqmuM
         08QcE9w31pbncOG5lHH/rCgMgWG9fEep/gIOitw9MVY/P8DeZvqFXUUOqt4NUtenFC/K
         /ZlU+THO7wA6o/ONCQDVQM1i3G7mmTohAR9GHDGia+zp9EiAlr0/nCuT6dKTzCrIEcWW
         W6cDfnrXJjclHtWslf8orQ7rHuwV7ic5A0J4iqEQskTzSN2VwGf1Vgj13QzxTsp3YAYp
         vn2ziaOI3tt6VApxoOkK3kDrnp2azwpjkP2kRyUt0+8JKYDvSQNQkD3knaVEn84/xnHS
         TK+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZg10BrjkxMJL3vJAZT+j2e20hM+ZEF9fa6NwwcYUQLtm4c++K5dvkvB7Wm6cCYbzBfSdQyl7OGTM=@vger.kernel.org, AJvYcCVwN2l4IDGCSsPdxXDHUutSJONgNvQDae9zkfIHR+uUVEvjhJmdMdsqY59KjWBD1awFlP4fblvxz/nAckPBzfw=@vger.kernel.org, AJvYcCWBadxSGqonbg6jBO7J+EiLapdd5yYHdK4KO1RdY/dXsiTBvVlrPFCm0STTqXL+kM7V6cMEvmagKKlBXK3l@vger.kernel.org, AJvYcCXTII4QM8NdRj/EhPHpdQgaktptOWdq9GEaYQlUl9q1q1HeQKuzo2ZDtGLQPeQW67FW2sKARVzPLnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmFFW1grghBgzvfHgDcO/4cr42nS5lJG5nM4fCxgj3zhAxJfkE
	nQKDxrmkpqhuPT/Z4nvjfbFKUQxPiFn2Sz/giJ25MaVsTMDYLkV1
X-Gm-Gg: ASbGncuML/eImnQGe/aH5GYP8mPEJGl/6f+U8us3oevI3dntey3XnWVUEQMVAIkgJjk
	CtPjQ48HkhRpCQgHCGgDQUYqjYyZhQeM/Y140WtuWSTVC39BDRRiBI3o/Wmkj5PUgZRwCGS9Bey
	UtNAlV71vRgAO/5mjbfKpz+zEed24ian70Xg5HwMrDgS6iGTuf1AAU+xfKi+PA83UT5CSZgE99t
	HhLXzH/cDu2KaqbBQL4C+gDQ5+KzCkzT6EPMITQ5PN1NqJJvrJGyL0iSN8moTU2CiD72GVwnwNU
	wBsE6txz34ER0xV5NMFrz3S3FibLW0ONcpQAxK3x
X-Google-Smtp-Source: AGHT+IFgPfqa9usodkgQ11OYlZElwVHS+rhpBGMheAxnhQPM0Vl8edO//jgp2CADvF98b7uy7ZmSyg==
X-Received: by 2002:a17:903:46c7:b0:225:adf8:8634 with SMTP id d9443c01a7336-22bea505634mr48590175ad.51.1744386849120;
        Fri, 11 Apr 2025 08:54:09 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b6430asm50889945ad.17.2025.04.11.08.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 08:54:08 -0700 (PDT)
Date: Fri, 11 Apr 2025 11:54:06 -0400
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
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 03/17] rust: cpumask: Add initial abstractions
Message-ID: <Z_k7HtIZaSWeJvM4@yury>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
 <9a004e3dff5321dae3b96df2817799daa699ce01.1744366571.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a004e3dff5321dae3b96df2817799daa699ce01.1744366571.git.viresh.kumar@linaro.org>

On Fri, Apr 11, 2025 at 04:25:02PM +0530, Viresh Kumar wrote:
> Add initial Rust abstractions for struct cpumask, covering a subset of
> its APIs. Additional APIs can be added as needed.
> 
> These abstractions will be used in upcoming Rust support for cpufreq and
> OPP frameworks.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  rust/kernel/cpumask.rs | 328 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |   1 +
>  2 files changed, 329 insertions(+)
>  create mode 100644 rust/kernel/cpumask.rs
> 
> diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
> new file mode 100644
> index 000000000000..a9d22c1d7a5a
> --- /dev/null
> +++ b/rust/kernel/cpumask.rs
> @@ -0,0 +1,328 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! CPU Mask abstractions.
> +//!
> +//! C header: [`include/linux/cpumask.h`](srctree/include/linux/cpumask.h)
> +
> +use crate::{
> +    alloc::{AllocError, Flags},
> +    bindings,
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
> +/// The callers must ensure that the `struct cpumask` is valid for access and remains valid for the

This line is too long to me.

> +/// lifetime of the returned reference.
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
> +///     let mask = unsafe { Cpumask::from_raw_mut(ptr) };
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
> +    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpumask) -> &'a mut Self {
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
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::cpumask) -> &'a Self {
> +        // SAFETY: Guaranteed by the safety requirements of the function.
> +        //
> +        // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the
> +        // lifetime of the returned reference.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Obtain the raw `struct cpumask` pointer.
> +    pub fn as_raw(&self) -> *mut bindings::cpumask {
> +        self as *const _ as _
> +    }
> +
> +    /// Set `cpu` in the cpumask.
> +    ///
> +    /// Equivalent to the kernel's `__cpumask_set_cpu` API.
> +    #[inline]
> +    pub fn set(&mut self, cpu: u32) {
> +        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `__cpumask_set_cpu`.
> +        unsafe { bindings::__cpumask_set_cpu(cpu, self.as_raw()) };
> +    }
> +
> +    /// Clear `cpu` in the cpumask.
> +    ///
> +    /// Equivalent to the kernel's `__cpumask_clear_cpu` API.

Similarly to bitmaps, can you explain here that this is a non-atomic
operation?

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
> +/// let mut mask = CpumaskVar::new(GFP_KERNEL).unwrap();
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
> +    /// Creates an initialized instance of the [`CpumaskVar`].
> +    pub fn new(_flags: Flags) -> Result<Self, AllocError> {
> +        Ok(Self {
> +            #[cfg(CONFIG_CPUMASK_OFFSTACK)]
> +            ptr: {
> +                let mut ptr: *mut bindings::cpumask = ptr::null_mut();
> +
> +                // SAFETY: Depending on the value of `_flags`, this call may sleep. Other than
> +                // that, it is always safe to call this method.
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
> +    /// Creates an uninitialized instance of the [`CpumaskVar`].

I would do this another way: introduce new() that calls
alloc_cpumask_var(), and new_zero() binded to zalloc() version. Your
statement here is simply wrong because I can pass GFP_ZERO and 'hack'
all your architecture.

> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that the returned [`CpumaskVar`] is properly initialized before
> +    /// getting used.
> +    unsafe fn new_uninit(_flags: Flags) -> Result<Self, AllocError> {
> +        Ok(Self {
> +            #[cfg(CONFIG_CPUMASK_OFFSTACK)]
> +            ptr: {
> +                let mut ptr: *mut bindings::cpumask = ptr::null_mut();
> +
> +                // SAFETY: Depending on the value of `_flags`, this call may sleep. Other than
> +                // that, it is always safe to call this method.

I'm not sure I understand this sentence. What's wrong with safety when
the alloc() function sleeps? Even if something is wrong. If you really
want to protect your users, you'd introduce new_sync() version that
returns error if user provides sleeping flags.

To that extend, once you write so many flavors of constructors, I bet
your users will be happy if you hide the 'flags' entirely:
        new_gfp(flags);
        new();
        new_zero(); // or znew()?
        new_sync();
        
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
> +    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpumask_var_t) -> &'a mut Self {

The 'from' (wrt cpumasks) has a special meaning: search for a cpu
starting from a given one. This 'from_raw' may confuse readers. Have
you any other name for it in mind?

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
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::cpumask_var_t) -> &'a Self {
> +        // SAFETY: Guaranteed by the safety requirements of the function.
> +        //
> +        // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the
> +        // lifetime of the returned reference.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Clones cpumask.
> +    pub fn try_clone(cpumask: &Cpumask) -> Result<Self> {

Just clone(), I think.

> +        // SAFETY: The returned cpumask_box is initialized right after this call.
> +        let mut cpumask_box = unsafe { Self::new_uninit(GFP_KERNEL) }?;
> +
> +        cpumask.copy(&mut cpumask_box);
> +        Ok(cpumask_box)
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

