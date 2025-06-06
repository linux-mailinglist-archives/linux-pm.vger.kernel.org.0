Return-Path: <linux-pm+bounces-28200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB96AD0347
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 15:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62883AC667
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 13:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257F7288C1B;
	Fri,  6 Jun 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZHfQXDW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C0228466C;
	Fri,  6 Jun 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749216904; cv=none; b=hqnjCTkbDEgpv5tu3teM+hzpiEJUQV0VT6puNl1iAnvHdwzPsoBuR5dPeqF1tADuhbBz8pbVBQvn11fWVEzSI6B2FkcNALooB1hS4lFX5jbVkiHdI6+p9mHibC9mmlOI7fljgCjb/uM0AWYvIMitPlLd5bDw4WLw3VZNIAwwR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749216904; c=relaxed/simple;
	bh=/z4KNTY6K1QX9BqG+GXj3WT7AYkNxHHXlkhmMGQe8dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kosladHcgVsnmfxWI7kiskE6zf2MNKm7qA6Wn8dnB0epqaLc2IiJfVq23NOz8N5CD1Ogf8Gk8CAL36Z61ntLtVBZZ1Wyu7gyUilCKgMdDZGIodJuiCsehmpoFRAaKOp8mL3K/G7Rf2Q3fl/bI9SAMDdLkJuVtC4+xiK/eE4QAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZHfQXDW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7cee9f0af46so215050585a.3;
        Fri, 06 Jun 2025 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749216901; x=1749821701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=li311bFWIwjWn8TvNMnkERHq2b02zAYt2SjH2f5Hw9U=;
        b=PZHfQXDWA3IATUVeTXdxGiRJYm8FHkKP8vpmEfkDDql63vukvYyPMGdDIQLxd2h60S
         Ms6RY04z8yw1FpqQ7jrhCV3kO7G9NKlabxwXgc7yuEAyp2V8GUPRQ57uHSzeKddwpqPm
         EdezgBXvqJYyxZ481tbEVAnLiYDaGOkZnO7fv3HhvjMUoVuu7cBgfGct3jy4GfGcgQbR
         GMPIqyLhGnqCrLR5GguzX7x1hPX9DEhd3z8aLaku2lGp2dRhSCOpZEGbOZvUULN9k28+
         TxIUqgX1eYd0gmYcWzdFlxNbjuH1AP8mks5FUVpCzuwS/CHS90joXYfMsqUObnkX+KN0
         P9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749216901; x=1749821701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=li311bFWIwjWn8TvNMnkERHq2b02zAYt2SjH2f5Hw9U=;
        b=eYXf6fiX1CXdaYg+dAs03hTi7sMkorUj4oSDRMokTGTljeTgRkBbgOg8obbnKVOdkq
         +at/v8PnhgxouapTxeJ4h4/5hXbU5VoRo7sqcp5+TD9ZuqIbNmZFzB0g0I81gxrtj8Rp
         3HZHZLIbJ5ghdGXfPxxQucDPS7AedNISquDxJuxvndmhnAUNPn3Za9//v1HI0SQjjXKY
         5sYxSbwqJ3n/mKpRRBvGrMjMg+O0gAa3o1WtQMycxN4iQLU0vHlm1g6sWBsO7i6AEo62
         KHRQZmd6DFsbDV/jctN8G+LkXSTQuIo8nGdKthg+P/7wUrzUyB/Whh/TyPEJEBTin1Vv
         dd3w==
X-Forwarded-Encrypted: i=1; AJvYcCUYBeMY02Rij12hxEnEiG6I0RH9ncROLXeZ1+CPMZVGIg9jTrwmMufeDwdYMmCiR+UiYTIC5OVnx7g=@vger.kernel.org, AJvYcCWU9R/uM6diQCzZvYG696VFxLjqEIH2UXS9TlEHcUiidZNnmctqhbGDoqNbkT7EdFElmaZDUxTzjCyP3qc=@vger.kernel.org, AJvYcCX0bygzJ0v0SMIAZc0F2C3BkLJufELj5i28xAwXN8yR84y0XBn/BxtuyNObHx6HwXLfUqWguAXMxArVkXP4vvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGYhwnq3shAlx3j4LPnko4kZnlqHJMTCo/7pH1iTyxfQD8L6pm
	4+lV4WfG43JuZ10u13F/eUrRjUwuQH/ZRZ06pPYInV53qIrIrwouXePv
X-Gm-Gg: ASbGncsoqAjrQX+lh9qz379OpxZlwZe2AdAX/lnxL1fdCQRhlJz15wx5xRYoE32atD3
	jc8f8KNlFSFt+9IxSKoe9zRQVNztreW1HGGCjA5uUYg19pNM59EPEIWZrnboLPSCq5tKhOYWv6F
	h+4dYjFZ4yfCsMADcOIhbcBJgasjfD8FbHBLcB/CudcLsg/n5F/nGCGgZ64sqyWEUuqaIifbQZg
	XwIouzXpgdl7VQJDrcgnqkr7ZbV3Tkf/eK5g2HeOcWLcSAU3q0EU+N8Er8Z3H58m8OMS8quT5pF
	/4c7p3d8XxGr0Rj/wRkkQt5KDBJPIU1lurSMVtiqP04ZyPOuHLOIiFLjRGiSLl2ST36rMVnjixI
	LuBIHqT12Q8jzrOghltf3M/yr6zEw5DFrAbG/QGTruRi2/TSCOc+b
X-Google-Smtp-Source: AGHT+IGdv0PS1gCrF8HQzy1OVLhLukJz18uMLvvURPoeqzXqH+XjqhJus4TcmLLdKA2xzN/X0VJTRA==
X-Received: by 2002:a05:620a:2910:b0:7c5:60c7:339 with SMTP id af79cd13be357-7d229896807mr549791285a.9.1749216901107;
        Fri, 06 Jun 2025 06:35:01 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d2513357basm131888285a.4.2025.06.06.06.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 06:35:00 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id CF8D81200043;
	Fri,  6 Jun 2025 09:34:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 06 Jun 2025 09:34:59 -0400
X-ME-Sender: <xms:g-5CaNRpeF7_7vsGG9v5ez9zypqGV4oaphkT89ARD1sU3yQ3dyY-rA>
    <xme:g-5CaGyjvxdiFuo_L9i03pJPxRSI6FDLsNwWw22oSFcU48rDLFv9H6wBDPDA2-gyn
    D-Vf4bxMaJ-iQaf9A>
X-ME-Received: <xmr:g-5CaC31W5AqpHQdU7zDlZ2SUuW7OvW4k2mYMC_CcMXwkQFm7_1wba-eYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeejuefh
    hffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhu
    mhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopeihuhhrhidrnhhorhhovhesghhmrghilhdrtghomhdprhgt
    phhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrgh
    grhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhho
    rdhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:g-5CaFA-zWWrv8JLb3Wnksy-nxHZWpITNKKXVPnjDyFJG27FOuW6eA>
    <xmx:g-5CaGgsY8xTMgxvIj-dagcYAAUAo-KGwQOsICDASq8jd_Bj1F8lRw>
    <xmx:g-5CaJr05cAIrBlfLm-gzzhBJSYarjBFEEYsBswpRojhZqamNwzDpA>
    <xmx:g-5CaBgTQTj2RvSqaBsJTY-3n7ssks1XCJTtRrJPybS0GqjXbt-KbQ>
    <xmx:g-5CaBR-rd1jMbvxffL4vy9pD7P1uujEqMepQUhJRW0fYO1IjQPm0Dv7>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 09:34:58 -0400 (EDT)
Date: Fri, 6 Jun 2025 06:34:56 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: cpumask: Validate CPU number in set() and clear()
Message-ID: <aELugDefiviXZjx6@Mac.home>
References: <8b5fc7889a7aacbd9f1f7412c99f02c736bde190.1749183428.git.viresh.kumar@linaro.org>
 <aEJwm16HSwCyt7aB@Mac.home>
 <DAFAR5SUQSU9.OSLB2UAXE9DY@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAFAR5SUQSU9.OSLB2UAXE9DY@kernel.org>

On Fri, Jun 06, 2025 at 10:11:13AM +0200, Benno Lossin wrote:
> On Fri Jun 6, 2025 at 6:37 AM CEST, Boqun Feng wrote:
> > On Fri, Jun 06, 2025 at 09:47:28AM +0530, Viresh Kumar wrote:
> >> The C `cpumask_{set|clear}_cpu()` APIs emit a warning when given an
> >> invalid CPU number - but only if `CONFIG_DEBUG_PER_CPU_MAPS=y` is set.
> >> 
> >> Meanwhile, `cpumask_weight()` only considers CPUs up to `nr_cpu_ids`,
> >> which can cause inconsistencies: a CPU number greater than `nr_cpu_ids`
> >> may be set in the mask, yet the weight calculation won't reflect it.
> >> 
> >> This leads to doctest failures when `nr_cpu_ids < 4`, as the test tries
> >> to set CPUs 2 and 3:
> >> 
> >>   rust_doctest_kernel_cpumask_rs_0.location: rust/kernel/cpumask.rs:180
> >>   rust_doctest_kernel_cpumask_rs_0: ASSERTION FAILED at rust/kernel/cpumask.rs:190
> >> 
> >> Fix this by validating the CPU number in the Rust `set()` and `clear()`
> >> methods to prevent out-of-bounds modifications.
> >> 
> >
> > Thanks for the quick fix!
> >
> > While this can fix the current problem, but it's not a good solution for
> > the long run. Because outside a test, we should never use an arbitrary
> > i32 as a cpu number (we usually get it from smp_processor_id(), or
> > something else). So the `< nr_cpu_ids` testing is not necessary in
> > normal use cases.
> >
> > We should instead provide a wrapper for cpu id:
> >
> >     /// # Invariants
> >     ///
> >     /// The number is always in [0..nr_cpu_ids) range.
> >     pub struct CpuId(i32);
> >
> > and
> >
> >     impl CpuId {
> >         /// # Safety
> > 	/// Callers must ensure `i` is a valid cpu id (i.e. 0 <= i <
> > 	/// nr_cpu_ids).
> >         pub unsafe fn from_i32_unchecked(i: i32) -> Self {
> > 	    // INVARIANT: The function safety guarantees `i` is a valid
> > 	    // cpu id.
> > 	    CpuId(id);
> > 	}
> >
> > 	pub fn from_i32(i: i32) -> Option<Self> {
> > 	    if i < 0 || i >= nr_cpu_ids {
> > 	        None
> > 	    } else {
> > 	        // SAFETY: `i` has just been checked as a valid cpu id.
> > 	        Some(unsafe { Self::from_i32_unchecked(i) })
> > 	    }
> > 	}
> >
> > 	pub fn current() -> Self {
> > 	    // SAFETY: smp_processor_id() always return valid cpu id.
> > 	    unsafe { Self::from_i32_unchecked(smp_processor_id()) }
> > 	}
> >     }
> >
> > All `Cpumask` functions then take `CpuId` instead of `i32` as the
> > parameter. Needless to say if we were to have a cpumask_next() wrapper,
> > the return value will be `CpuId` (or `Option<CpuId>`), i.e. if a bit was
> > set in a cpumask, then it must represent a correct cpu id.
> >
> > Make sense?
> 
> Just to make sure, the `nr_cpu_ids` stays constant, right?
> 

Sort of. I believe the value won't be changed once the kernel boots, in
most cases (modulo NR_CPUS=1 or CONFIG_FORCE_NR_CPUS=y), it's a
read-mostly variable not a constant, and the value gets set by either a
kernel command line or how many CPUs the kernel actually detect at boot
time. See:

https://github.com/Rust-for-Linux/linux/blob/rust-next/kernel/smp.c#L995:w

> >> @@ -101,10 +108,16 @@ pub fn set(&mut self, cpu: u32) {
> >>      /// This mismatches kernel naming convention and corresponds to the C
> >>      /// function `__cpumask_clear_cpu()`.
> >>      #[inline]
> >> -    pub fn clear(&mut self, cpu: i32) {
> >> +    pub fn clear(&mut self, cpu: i32) -> Result {
> >> +        // SAFETY: It is safe to read `nr_cpu_ids`.
> >> +        if unsafe { cpu as u32 >= bindings::nr_cpu_ids } {
> >
> > You probably want to check whether `bindings::nr_cpu_ids` can be
> > accessible if NR_CPUS == 1 or CONFIG_FORCE_NR_CPUS=y, because then
> > nr_cpu_ids is a macro definition.
> 
> Just define a helper function?
> 

Maybe, but it is then "a variable read" vs "a FFI function call" if we
want to check every time in clear()/set(), of course if we only check it
in CpuId::from_i32() mentioned above, the performance impact shouldn't
be observable, because we won't call that method often.

Either, I was just pointing out the current fix may cause build errors.

Regards,
Boqun

> ---
> Cheers,
> Benno

