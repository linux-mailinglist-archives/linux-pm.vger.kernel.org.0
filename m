Return-Path: <linux-pm+bounces-28177-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DF6ACFC00
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 06:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91CF3AECB4
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 04:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352D61A0BD6;
	Fri,  6 Jun 2025 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE6DMEI2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537407FD;
	Fri,  6 Jun 2025 04:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749184674; cv=none; b=l0P7SS7aQrhLXmCqPJqLGBufYF2yR1dWD9TgGTZ/CYHOl79++fupCS0GgJ1MxjguCqqmA3ZYxay+b2svcmnjLyFlQLI4JBAfOmOYYs7ctFWHDptKkFBY96hqvK0IUyoj2j6jeVA4OtXWCHf2z9wO7XDrK7cOFkSr+ofpcbObPAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749184674; c=relaxed/simple;
	bh=ooa8GUCrOJx9dyOpO2RqFlntCiLyJrV5MKBPBO4VX1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjHViCFpV+jnE+C0vLD9kzj3XI19qod67zRyB9klroq4dSYmN4KS5XlPWHCEhBCMBUkK5pogIAy933vWgQcsHQyqZ6AuH5cZQYKms3g63ektSSwlCEBssArc4jdheZNtHPoNldtQQ4I26YiMyuvk+nKimeCmopW86qQJCH9RmQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE6DMEI2; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a5903bceffso19810401cf.3;
        Thu, 05 Jun 2025 21:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749184671; x=1749789471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkteYriPiUEQMk2PJvli3NF55JAHjvDo7DBgrBsNFMo=;
        b=nE6DMEI2Kfp2t3C8mCQhC5lAeBGde4uCUOMBysCYgsStyfKrxJLe5fbo3eYHecayda
         Y+/No4+FE8ht1menbyP+TKu5lZe64wY5CajDDYjQnXxlYbJltNYiba0H2L5wdFdLqJiO
         7zZtuEt8KhZsqykGyG9DjIr1lRt8P8fOeaFUs0A2hXYIr6K80f+FuybcHjTtvr36qHVV
         PTA4hmyEvxLRJcPjpaYtpZFL1jCOYvnUfjqGXn5avyPIs+AJfX4wdKeytZbLbiJ5yZdj
         b8INsnP52a3PT4cNvweJi9uDVuFYE0eHDZB5SNtVgVio/KrhdnOZz+CJSxJlFKkdkM+I
         JsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749184671; x=1749789471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkteYriPiUEQMk2PJvli3NF55JAHjvDo7DBgrBsNFMo=;
        b=HZmTsBZsjjO0EApDmNl4RaZqRcg5GX+BwWKGywFQ6ffTQUUGyOll4dDSkIbS4WIoYQ
         xkum1jwyvf/IZnpqejPWG8fCbaAwMuzqzWQFjadr/ArSaza3P4qWneIlBeywmc2CfaQD
         2LC/x0FtYDQGLi6sne/xaRla8voldgU6A0YYuUF0071og15ie8qTOW4wJyQf60m30CYb
         IY4df8hVe0OZFrrauf6gd1RLQR4nVUJwrXzr9KM3wEgSqvcE/sisBnRKIC4h/GIgvpqA
         HO6A3yzWVjGstzV8cFhyMfoOzAP/1pfucKevk6Qf1SwWDXwIEg7dVq87tGAQYqAeoqx5
         NVug==
X-Forwarded-Encrypted: i=1; AJvYcCVQsNhtPWzEwcZiZ8N44G0yO4zCBDAigRSttTxbwjoX4PRkFLwAlkETvo1tB0tW3W1/mbOSNeBSCjfRpCsFBIk=@vger.kernel.org, AJvYcCW5HWgRNv/2SdxkWYq/fhlOWIJEgUrUbqkJ5BDhh2DUH0XYV6+zjHQUCLuRdaasUydYXaV8/jCaf1c=@vger.kernel.org, AJvYcCWd0KcC4NPHgc81128aLHYWLvM5rYgAGFuIpg9L1AyRpMDxO9bnVprG33AC9aS3IgvmfpIdrLlVXyJP6EA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0tX7NI3GYp6XteAWhgMNa4FbR45qYxPxCa65YFAsNDFeYO0ou
	i3NrUT+s2/yAeXulGgdL6J/NzS3d2b4cDmghMsT2zWYKO/c8L6sTYLRA
X-Gm-Gg: ASbGnctvmeUsfZTOGcmcGSWHvPjpHEhBsSZzCoZo61dtNElm8XhjoACWBVQ+Mq1xob1
	5FrA3u5keglb5nkE2an/EyblRaIHFRdIIF1eMPHmWaAVP7bHsM8byaRtrNhNwVMqsK4ZVaPMrm2
	SRY5ccGh1SDPKGnM6UHGYgSjU1hE6hruB5buqxFEuRdPNWpqAytB/gT1cGKoYHLzQ5IrRQu2MCC
	MPmG49NjcjefiY2qjU3Jqd4SwlNPsgxTqZsMVjijgWDTf94F7u9AJn0xyJriRcLk+2Yx8/go/FR
	5R0Qg2rcZtMZhLbyl9+MDsJ8jb8nMevxW7Ac1iAWQBh1uoIKrPYW1l/72xu+AMIdOqJlrS9kXY0
	Uj7n71H55jmRnX+47w9IEN4y45LCsjh1yTrdoFo5dRQ==
X-Google-Smtp-Source: AGHT+IFY2+q/lUJAOCrxM2SmV33llI67uyb8wDjBujMIP4xppmeXWzRNEO7tA51VgA6njyFvsdVvZg==
X-Received: by 2002:a05:622a:2287:b0:4a4:4da5:8b55 with SMTP id d75a77b69052e-4a5b9d39e8cmr39828631cf.28.1749184670927;
        Thu, 05 Jun 2025 21:37:50 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a611150830sm7192311cf.10.2025.06.05.21.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 21:37:50 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id D5C711200043;
	Fri,  6 Jun 2025 00:37:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 06 Jun 2025 00:37:49 -0400
X-ME-Sender: <xms:nXBCaARGqRTaW9aRl-8OIGEYBnxwpSN6TCmrvcjPf3Zn5XDobvZTSw>
    <xme:nXBCaNyDoCxcHWrpURtuXjKSZ6rh4ADXLvlTZhl8c6UhjEUYcx1srFLtgdcCP7TAo
    yvPJeKuH35I-HrYUw>
X-ME-Received: <xmr:nXBCaN0kAIXOxrP3NKtrE9OEInPXWujrNWHkC94wLi1_xTEusDjW51_G1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtuden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeiffejheejledukeefieekgfetveejiedtveek
    gffhteekvdeijeefgedtffevgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehrrghf
    rggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihurhihrdhnohhrohhvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrg
    hrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhho
    thhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nXBCaECszaj6AWhUm-DpDYTroJO4DtviIZZN17zSYmm4J2b1YZbbAQ>
    <xmx:nXBCaJibly_LEZRs51Bz-r5azCuXvUzoyJ9skQFID8WQtn9cWFYBEw>
    <xmx:nXBCaApsXjr34ukFfCAasE8aOBr6R5B5CuK6akOzcKvPNmOQHlk0Rw>
    <xmx:nXBCaMiNGmezyO6VI4WzeKl5-4PhYyKbm661fxHvEdJpDGTnYMqNXw>
    <xmx:nXBCaATbwO5-MsvXBGPnxecO_3ogOig0Pr_dRyje4DJfVr7IvuaJKTow>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 00:37:49 -0400 (EDT)
Date: Thu, 5 Jun 2025 21:37:47 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: cpumask: Validate CPU number in set() and clear()
Message-ID: <aEJwm16HSwCyt7aB@Mac.home>
References: <8b5fc7889a7aacbd9f1f7412c99f02c736bde190.1749183428.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8b5fc7889a7aacbd9f1f7412c99f02c736bde190.1749183428.git.viresh.kumar@linaro.org>

On Fri, Jun 06, 2025 at 09:47:28AM +0530, Viresh Kumar wrote:
> The C `cpumask_{set|clear}_cpu()` APIs emit a warning when given an
> invalid CPU number - but only if `CONFIG_DEBUG_PER_CPU_MAPS=y` is set.
> 
> Meanwhile, `cpumask_weight()` only considers CPUs up to `nr_cpu_ids`,
> which can cause inconsistencies: a CPU number greater than `nr_cpu_ids`
> may be set in the mask, yet the weight calculation won't reflect it.
> 
> This leads to doctest failures when `nr_cpu_ids < 4`, as the test tries
> to set CPUs 2 and 3:
> 
>   rust_doctest_kernel_cpumask_rs_0.location: rust/kernel/cpumask.rs:180
>   rust_doctest_kernel_cpumask_rs_0: ASSERTION FAILED at rust/kernel/cpumask.rs:190
> 
> Fix this by validating the CPU number in the Rust `set()` and `clear()`
> methods to prevent out-of-bounds modifications.
> 

Thanks for the quick fix!

While this can fix the current problem, but it's not a good solution for
the long run. Because outside a test, we should never use an arbitrary
i32 as a cpu number (we usually get it from smp_processor_id(), or
something else). So the `< nr_cpu_ids` testing is not necessary in
normal use cases.

We should instead provide a wrapper for cpu id:

    /// # Invariants
    ///
    /// The number is always in [0..nr_cpu_ids) range.
    pub struct CpuId(i32);

and

    impl CpuId {
        /// # Safety
	/// Callers must ensure `i` is a valid cpu id (i.e. 0 <= i <
	/// nr_cpu_ids).
        pub unsafe fn from_i32_unchecked(i: i32) -> Self {
	    // INVARIANT: The function safety guarantees `i` is a valid
	    // cpu id.
	    CpuId(id);
	}

	pub fn from_i32(i: i32) -> Option<Self> {
	    if i < 0 || i >= nr_cpu_ids {
	        None
	    } else {
	        // SAFETY: `i` has just been checked as a valid cpu id.
	        Some(unsafe { Self::from_i32_unchecked(i) })
	    }
	}

	pub fn current() -> Self {
	    // SAFETY: smp_processor_id() always return valid cpu id.
	    unsafe { Self::from_i32_unchecked(smp_processor_id()) }
	}
    }

All `Cpumask` functions then take `CpuId` instead of `i32` as the
parameter. Needless to say if we were to have a cpumask_next() wrapper,
the return value will be `CpuId` (or `Option<CpuId>`), i.e. if a bit was
set in a cpumask, then it must represent a correct cpu id.

Make sense?

> Fixes: 8961b8cb3099 ("rust: cpumask: Add initial abstractions")
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://lore.kernel.org/all/87qzzy3ric.fsf@kernel.org/
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Closes: https://lore.kernel.org/all/87qzzy3ric.fsf@kernel.org/
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/rcpufreq_dt.rs |  2 +-
>  rust/kernel/cpumask.rs         | 49 +++++++++++++++++++++++-----------
>  2 files changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
> index 94ed81644fe1..f396c8f35069 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -70,7 +70,7 @@ fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {
>          let dev = unsafe { cpu::from_cpu(cpu)? };
>          let mut mask = CpumaskVar::new_zero(GFP_KERNEL)?;
>  
> -        mask.set(cpu);
> +        mask.set(cpu)?;
>  
>          let token = find_supply_names(dev, cpu)
>              .map(|names| {
> diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
> index c90bfac9346a..75d4ce916b4f 100644
> --- a/rust/kernel/cpumask.rs
> +++ b/rust/kernel/cpumask.rs
> @@ -37,13 +37,14 @@
>  /// use kernel::bindings;
>  /// use kernel::cpumask::Cpumask;
>  ///
> -/// fn set_clear_cpu(ptr: *mut bindings::cpumask, set_cpu: u32, clear_cpu: i32) {
> +/// fn set_clear_cpu(ptr: *mut bindings::cpumask, set_cpu: u32, clear_cpu: i32) -> Result {
>  ///     // SAFETY: The `ptr` is valid for writing and remains valid for the lifetime of the
>  ///     // returned reference.
>  ///     let mask = unsafe { Cpumask::as_mut_ref(ptr) };
>  ///
> -///     mask.set(set_cpu);
> -///     mask.clear(clear_cpu);
> +///     mask.set(set_cpu)?;
> +///     mask.clear(clear_cpu)?;
> +///     Ok(())
>  /// }
>  /// ```
>  #[repr(transparent)]
> @@ -90,9 +91,15 @@ pub fn as_raw(&self) -> *mut bindings::cpumask {
>      /// This mismatches kernel naming convention and corresponds to the C
>      /// function `__cpumask_set_cpu()`.
>      #[inline]
> -    pub fn set(&mut self, cpu: u32) {
> +    pub fn set(&mut self, cpu: u32) -> Result {
> +        // SAFETY: It is safe to read `nr_cpu_ids`.
> +        if unsafe { cpu >= bindings::nr_cpu_ids } {
> +            return Err(EINVAL);
> +        }
> +
>          // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `__cpumask_set_cpu`.
>          unsafe { bindings::__cpumask_set_cpu(cpu, self.as_raw()) };
> +        Ok(())
>      }
>  
>      /// Clear `cpu` in the cpumask.
> @@ -101,10 +108,16 @@ pub fn set(&mut self, cpu: u32) {
>      /// This mismatches kernel naming convention and corresponds to the C
>      /// function `__cpumask_clear_cpu()`.
>      #[inline]
> -    pub fn clear(&mut self, cpu: i32) {
> +    pub fn clear(&mut self, cpu: i32) -> Result {
> +        // SAFETY: It is safe to read `nr_cpu_ids`.
> +        if unsafe { cpu as u32 >= bindings::nr_cpu_ids } {

You probably want to check whether `bindings::nr_cpu_ids` can be
accessible if NR_CPUS == 1 or CONFIG_FORCE_NR_CPUS=y, because then
nr_cpu_ids is a macro definition.

Regards,
Boqun

> +            return Err(EINVAL);
> +        }
> +
>          // SAFETY: By the type invariant, `self.as_raw` is a valid argument to
>          // `__cpumask_clear_cpu`.
>          unsafe { bindings::__cpumask_clear_cpu(cpu, self.as_raw()) };
> +        Ok(())
>      }
>  
>      /// Test `cpu` in the cpumask.
> @@ -180,19 +193,23 @@ pub fn copy(&self, dstp: &mut Self) {
>  /// ```
>  /// use kernel::cpumask::CpumaskVar;
>  ///
> -/// let mut mask = CpumaskVar::new_zero(GFP_KERNEL).unwrap();
> +/// fn cpumask_test() -> Result {
> +///     let mut mask = CpumaskVar::new_zero(GFP_KERNEL).unwrap();
>  ///
> -/// assert!(mask.empty());
> -/// mask.set(2);
> -/// assert!(mask.test(2));
> -/// mask.set(3);
> -/// assert!(mask.test(3));
> -/// assert_eq!(mask.weight(), 2);
> +///     assert!(mask.empty());
> +///     mask.set(2)?;
> +///     assert!(mask.test(2));
> +///     mask.set(3)?;
> +///     assert!(mask.test(3));
> +///     assert_eq!(mask.weight(), 2);
>  ///
> -/// let mask2 = CpumaskVar::try_clone(&mask).unwrap();
> -/// assert!(mask2.test(2));
> -/// assert!(mask2.test(3));
> -/// assert_eq!(mask2.weight(), 2);
> +///     let mask2 = CpumaskVar::try_clone(&mask).unwrap();
> +///     assert!(mask2.test(2));
> +///     assert!(mask2.test(3));
> +///     assert_eq!(mask2.weight(), 2);
> +///
> +///     Ok(())
> +/// }
>  /// ```
>  pub struct CpumaskVar {
>      #[cfg(CONFIG_CPUMASK_OFFSTACK)]
> -- 
> 2.31.1.272.g89b43f80a514
> 

