Return-Path: <linux-pm+bounces-28687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFABAD91A0
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB1E189ED85
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A711FBE9B;
	Fri, 13 Jun 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej+/YyKq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E91F428C;
	Fri, 13 Jun 2025 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829209; cv=none; b=ElbjU20o5x65BC/6ddH2HWhp+LB4m6cC1uLzDr+EJ9dFO7c+32UYo+Nv1tKZbQ7ScJwYDmkRpY+cAy4zU1P8/B1KuTnpTI50cGofpADBqtHD37IZq0KtKCMKtfKVJ55YSljn+k1jQD7oA7/za3kH4FP9pIt3ue3kD2h957pdrJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829209; c=relaxed/simple;
	bh=9te5CCjrFZaz1KxLyCGrVsVQcnrq78gDZkkGplYpKjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7NTCaXTrJsGzNhG4num94b30q3Kdqak6Fu7snbjiM/F+UrhzL05ME4FFJfipUfuncsDUaQ1rDDQtbkfGu96oMDARFK00GHik8pB7GSTH1DgiXkcyxfO8G4S0GTs++tXgVgt6h9wjfZm+wauTcg58CCoK3RPub59okGU1+VmufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej+/YyKq; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6facba680a1so26819076d6.3;
        Fri, 13 Jun 2025 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749829206; x=1750434006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KupK1c4Lm0SPYLLhp4v1EdiFsUsIffsLQqXMeFIS6mU=;
        b=ej+/YyKqi+N06KWVfcAUTWqzlSruRRMzM5KkFuIBhd6lmIeSFmft7JzL59MH6C7+Ub
         EdcMkxxxFqSG4gtm03tDQ1J807kb3bT06NgW92IR/A5kcT67XIQqPXXxlLjB0AVoxlyy
         n/CP1ye5q3g/OyJxPMNlhl5GCfgBpiXevVsaKzEUBqFaxXyKQkJ1tZj4dpdv5Ux6ml1Z
         3G+Vdhetp9zKgIziOzz4k2hLAE9ku83btlJ93NfA/Ts+zWVqbo3ecXF2cnbDN3D7WjM3
         iebuPIP7XNErS2mpueZVPGI59JYZ7siIUB6fUetXcE2s7tnPmvf52PEm2EBi1tAXGvj4
         erEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749829206; x=1750434006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KupK1c4Lm0SPYLLhp4v1EdiFsUsIffsLQqXMeFIS6mU=;
        b=S9E77IMxcw5sSqxIMp6qHJZN6JsdKFxYKgtCwtlFudd1Y0BE/7Rw3trFfCx1YCPwzD
         qLCgEair9NoN2wKoJSqddEL2uk/pepjv5zmjA/NsgRqeLwkJZr2NxMxn07GfN1hwJc2h
         mP/f+k1vo9OwCaNrGndqbfU500zWNavrj/un4Uc+bzrKfV+hAXdyRpmtBQZVntE7+w01
         6aHqOZW/Ea+4H7ENF/JB1XqqPswYACnldA+5o5P6sQutElZPEFdfFNALAv1Gp6r5ZV3O
         kFmpjSBNIvPXyRHJYmPEM3rAW3JSepfmMND6lEVLzV/Qqz936aw+XwsswC4d3AVWVwNO
         a+pQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6oPPdfqI+sU1vQe3zXgWtF2f/yEZweNvIFOVqQGxbc9cL9nbw9HOlxEQlYh0n38Q8JPCrdbI75fOfaDk=@vger.kernel.org, AJvYcCXAFfgD9PQoO3EI32wL+t0fNCHb6Q8BwyjMJdwtV3/Vbw9oZVM2Oj3ECx3iqKGxVvFL+/hx28RGCmk=@vger.kernel.org, AJvYcCXvo1zojDu5Olzfs3DfO8Rt/WmobeGnUjFq/INENl28nCHBaauC2voMsrS0FPAoG10Tmcb+GsQO/E/A+G88I4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyzVPl+wJNVC3ScntKvGuhGcakFxkRyzUt29KXSQGznWMv1te3
	GJvbnXsYoxEg3RAYrzm1tzkYf1GRPtWmfBUx6HoW+pmWAS/ftHsWYmTk
X-Gm-Gg: ASbGncvR1AdE9NtBQRkoQc09QceG6gOwY2a70nybHWXmyhL3ODVHOLvQYLl77R5XPV7
	AV+eEpYfkpvpXcgM7TcmrzVWdStEqVcNmzA2slEPXl0jxkKBnwkirAQW+oxC7fJcpqE2vMRqiNk
	BEYMTinVc9QK34fFoPzKHVA5dGCtRWQ2rMLvaEtiw7YcSyICcJ6gqeG/4ODw9nIZVZAIC12xgHv
	cHQHtU/+12u/81airPGFT8SBZx0bNOj7VcciLwaITBZwmj7R+Bu0FT6xUiXG09WsuTkkh0IMQJW
	vtoNPfHSEOtsRl4hYrfk0wYqnJho3bo8PYw/enfYSNynbIvRewR7jyQv+2HO94+S+MKaAwMDKpX
	3bNsBQJmEoP8Y1JLaiwEZaRFHj1wio12xPb2yGoaTdUkE4jZG5kTdblmiZ4WUBQA=
X-Google-Smtp-Source: AGHT+IEGvmkwA50NnwVfQznUXoblPUYa5GZU9ch0GNYZqlaVTm4hegFizJgmCPABwVktv6fBOQhPjA==
X-Received: by 2002:a05:6214:246d:b0:6fb:f00:48ad with SMTP id 6a1803df08f44-6fb3e5991ffmr58510936d6.18.1749829204275;
        Fri, 13 Jun 2025 08:40:04 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35b3d630sm22866776d6.47.2025.06.13.08.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:40:03 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4B1561200068;
	Fri, 13 Jun 2025 11:40:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 13 Jun 2025 11:40:03 -0400
X-ME-Sender: <xms:U0ZMaKs_5dZs40BSZb_Z1s8gyLBJhak4--d0hze3BYG9wdLpdVCVgQ>
    <xme:U0ZMaPfZabpg4ugqUUxi1QIgOLwTXJnxCLuofuUy2DHTyoWNetsq7A7zfR_2O-mRE
    UIa1zapvlVl4sm3iQ>
X-ME-Received: <xmr:U0ZMaFwQ-pFiCnyweAmQdddM-JR7Whzn6GtCpoqdcVQCKCi7x1RsMa8lfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduledpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrg
    hrohdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgvthgvrh
    iisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhn
    fegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinheskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:U0ZMaFML3_OTqlJKddHlbA6eEJU_jaPCcqj0six9T-3COTkbz-9Upw>
    <xmx:U0ZMaK8o7OAgW0WPc2gcVxOMXDOnmDG0sEs6gJEccG9djZWlUKjBxA>
    <xmx:U0ZMaNUoVbWMnmCbkWFyBkHBd9yXMszODL6JBpn2k0mcDi1-TAADpA>
    <xmx:U0ZMaDdS64Q2qe5bC0vc-a3JSKlICjj2gkv9E7ml8yu812QEvhgTzA>
    <xmx:U0ZMaEc4dImh-wme0UA2EMudbODoZRol7Qn7u6_GxKWw00VKKWlN6us_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 11:40:01 -0400 (EDT)
Date: Fri, 13 Jun 2025 08:40:01 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/3] rust: Use CpuId in place of raw CPU numbers
Message-ID: <aExGUZ3H5mZ7Drqd@Mac.home>
References: <cover.1749554685.git.viresh.kumar@linaro.org>
 <e790f17123beb45c6a811135ec3df8f0bd761c0e.1749554685.git.viresh.kumar@linaro.org>
 <aEmq8fs1fHSB3z4i@tardis.local>
 <20250612050117.3oi6belkf5lrreoh@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612050117.3oi6belkf5lrreoh@vireshk-i7>

On Thu, Jun 12, 2025 at 10:31:17AM +0530, Viresh Kumar wrote:
> On 11-06-25, 09:12, Boqun Feng wrote:
> > I generally found that `u32::from(cpu)` is more clear than `cpu.into()`,
> > but it's up to you. Same for the rest of `cpu.into()` cases.
> 
> Updated as:
> 
> diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
> index 7549594fad7f..abc780d7a8ec 100644
> --- a/rust/kernel/cpu.rs
> +++ b/rust/kernel/cpu.rs
> @@ -129,7 +129,7 @@ fn from(id: CpuId) -> Self {
>  /// any references to the CPU device within the notifier's callback.
>  pub unsafe fn from_cpu(cpu: CpuId) -> Result<&'static Device> {
>      // SAFETY: It is safe to call `get_cpu_device()` for any CPU.
> -    let ptr = unsafe { bindings::get_cpu_device(cpu.into()) };
> +    let ptr = unsafe { bindings::get_cpu_device(u32::from(cpu)) };
>      if ptr.is_null() {
>          return Err(ENODEV);
>      }
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index ea6106db5c29..11b03e9d7e89 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -527,7 +527,7 @@ pub fn generic_suspend(&mut self) -> Result {
>      #[inline]
>      pub fn generic_get(&self) -> Result<u32> {
>          // SAFETY: By the type invariant, the pointer stored in `self` is valid.
> -        Ok(unsafe { bindings::cpufreq_generic_get(self.cpu().into()) })
> +        Ok(unsafe { bindings::cpufreq_generic_get(u32::from(self.cpu())) })
>      }
>  
>      /// Provides a wrapper to the register with energy model using the OPP core.
> @@ -682,7 +682,7 @@ fn clear_data<T: ForeignOwnable>(&mut self) -> Option<T> {
>  impl<'a> PolicyCpu<'a> {
>      fn from_cpu(cpu: CpuId) -> Result<Self> {
>          // SAFETY: It is safe to call `cpufreq_cpu_get` for any valid CPU.
> -        let ptr = from_err_ptr(unsafe { bindings::cpufreq_cpu_get(cpu.into()) })?;
> +        let ptr = from_err_ptr(unsafe { bindings::cpufreq_cpu_get(u32::from(cpu)) })?;
>  
>          Ok(Self(
>              // SAFETY: The `ptr` is guaranteed to be valid and remains valid for the lifetime of
> diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
> index 11ddd43edcb5..19c607709b5f 100644
> --- a/rust/kernel/cpumask.rs
> +++ b/rust/kernel/cpumask.rs
> @@ -94,7 +94,7 @@ pub fn as_raw(&self) -> *mut bindings::cpumask {
>      #[inline]
>      pub fn set(&mut self, cpu: CpuId) {
>          // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `__cpumask_set_cpu`.
> -        unsafe { bindings::__cpumask_set_cpu(cpu.into(), self.as_raw()) };
> +        unsafe { bindings::__cpumask_set_cpu(u32::from(cpu), self.as_raw()) };
>      }
>  
>      /// Clear `cpu` in the cpumask.
> @@ -106,7 +106,7 @@ pub fn set(&mut self, cpu: CpuId) {
>      pub fn clear(&mut self, cpu: CpuId) {
>          // SAFETY: By the type invariant, `self.as_raw` is a valid argument to
>          // `__cpumask_clear_cpu`.
> -        unsafe { bindings::__cpumask_clear_cpu(cpu.into(), self.as_raw()) };
> +        unsafe { bindings::__cpumask_clear_cpu(i32::from(cpu), self.as_raw()) };
>      }
>  
>      /// Test `cpu` in the cpumask.
> @@ -115,7 +115,7 @@ pub fn clear(&mut self, cpu: CpuId) {
>      #[inline]
>      pub fn test(&self, cpu: CpuId) -> bool {
>          // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_test_cpu`.
> -        unsafe { bindings::cpumask_test_cpu(cpu.into(), self.as_raw()) }
> +        unsafe { bindings::cpumask_test_cpu(i32::from(cpu), self.as_raw()) }
>      }
>  

LGTM,thanks!

Regards,
Boqun

>      /// Set all CPUs in the cpumask.
> 
> -- 
> viresh

