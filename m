Return-Path: <linux-pm+bounces-28205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FE1AD08B4
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 21:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563F23B370E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 19:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061DE1F3B9E;
	Fri,  6 Jun 2025 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGQGSI4e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D71E501C;
	Fri,  6 Jun 2025 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749238449; cv=none; b=oOSWdNLbd9ETmpW1DBbdP2EHD6Gl3T5eZ+dSlhiniqCaGHmL7gwiQTgl4C5RCbJoM+GG0UnP6BoO2RAmEC0XPWN4btEuwZ2iu523+rxzoaWvyBFHH+gaA9cMacjEpjF7bVAppAcrr4AX6dq9i1VLHW2ehniH1/ACny5Lp9pgpQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749238449; c=relaxed/simple;
	bh=H3LG70DDFkrvPWOnWEJJh55HhE/5hyND70bmc+t70E0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=AdpZqvC+3HI6NoIcsxVt3Rs8NK2S9LU1CBRWD8ywocnI0S8W8wHXIaGLIyh2LYo+ukBenGuqk+pqfbU0tt7TR4cwGYWMWH6Nn3iqG4bdxK0miG7HmV/mVs/IwnW6sfpqp4EgDixUmyQI3611WCDdPO5920VUT8z6KVWzq5+i4qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGQGSI4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D4EC4CEEB;
	Fri,  6 Jun 2025 19:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749238449;
	bh=H3LG70DDFkrvPWOnWEJJh55HhE/5hyND70bmc+t70E0=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=HGQGSI4edQTuDIM8ShM02brnAcb4Zhl+/8yPBdkt5dNWpORwpxKMbpYd4FzA3MsIQ
	 XWa+rZJem7lHlTNNvQ0zi8hU89b4xz4P+/9gMNJG/ZZ5Wfx8R/TnA2NGssGy9kxPVZ
	 R1OaF3lfpzxTC6BBRL78W188XvdDndClcaB3HyoEm+RDaDvowc/Dl4d0RAKfgIMOGG
	 mBjXSMxPygHFjT8jNrtS5BNtNQA0AvI3nhE0BmZ1RRa11ghoPCu+22/ENB7b/4n/+g
	 Q40ms7sHhyeIqI3AwFPQLua2kTxvM/Gepykk38FUzv5tNRxy02+9yI6ZnAQxiKm3jh
	 kXdAwknIhhdpg==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Jun 2025 21:34:04 +0200
Message-Id: <DAFP9ZRENV0S.ON0XKIXIAEKY@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: "Viresh Kumar" <viresh.kumar@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Vincent Guittot"
 <vincent.guittot@linaro.org>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: cpumask: Validate CPU number in set() and clear()
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <8b5fc7889a7aacbd9f1f7412c99f02c736bde190.1749183428.git.viresh.kumar@linaro.org> <aEJwm16HSwCyt7aB@Mac.home> <DAFAR5SUQSU9.OSLB2UAXE9DY@kernel.org> <aELugDefiviXZjx6@Mac.home>
In-Reply-To: <aELugDefiviXZjx6@Mac.home>

On Fri Jun 6, 2025 at 3:34 PM CEST, Boqun Feng wrote:
> On Fri, Jun 06, 2025 at 10:11:13AM +0200, Benno Lossin wrote:
>> On Fri Jun 6, 2025 at 6:37 AM CEST, Boqun Feng wrote:
>> > On Fri, Jun 06, 2025 at 09:47:28AM +0530, Viresh Kumar wrote:
>> >> The C `cpumask_{set|clear}_cpu()` APIs emit a warning when given an
>> >> invalid CPU number - but only if `CONFIG_DEBUG_PER_CPU_MAPS=3Dy` is s=
et.
>> >>=20
>> >> Meanwhile, `cpumask_weight()` only considers CPUs up to `nr_cpu_ids`,
>> >> which can cause inconsistencies: a CPU number greater than `nr_cpu_id=
s`
>> >> may be set in the mask, yet the weight calculation won't reflect it.
>> >>=20
>> >> This leads to doctest failures when `nr_cpu_ids < 4`, as the test tri=
es
>> >> to set CPUs 2 and 3:
>> >>=20
>> >>   rust_doctest_kernel_cpumask_rs_0.location: rust/kernel/cpumask.rs:1=
80
>> >>   rust_doctest_kernel_cpumask_rs_0: ASSERTION FAILED at rust/kernel/c=
pumask.rs:190
>> >>=20
>> >> Fix this by validating the CPU number in the Rust `set()` and `clear(=
)`
>> >> methods to prevent out-of-bounds modifications.
>> >>=20
>> >
>> > Thanks for the quick fix!
>> >
>> > While this can fix the current problem, but it's not a good solution f=
or
>> > the long run. Because outside a test, we should never use an arbitrary
>> > i32 as a cpu number (we usually get it from smp_processor_id(), or
>> > something else). So the `< nr_cpu_ids` testing is not necessary in
>> > normal use cases.
>> >
>> > We should instead provide a wrapper for cpu id:
>> >
>> >     /// # Invariants
>> >     ///
>> >     /// The number is always in [0..nr_cpu_ids) range.
>> >     pub struct CpuId(i32);
>> >
>> > and
>> >
>> >     impl CpuId {
>> >         /// # Safety
>> > 	/// Callers must ensure `i` is a valid cpu id (i.e. 0 <=3D i <
>> > 	/// nr_cpu_ids).
>> >         pub unsafe fn from_i32_unchecked(i: i32) -> Self {
>> > 	    // INVARIANT: The function safety guarantees `i` is a valid
>> > 	    // cpu id.
>> > 	    CpuId(id);
>> > 	}
>> >
>> > 	pub fn from_i32(i: i32) -> Option<Self> {
>> > 	    if i < 0 || i >=3D nr_cpu_ids {
>> > 	        None
>> > 	    } else {
>> > 	        // SAFETY: `i` has just been checked as a valid cpu id.
>> > 	        Some(unsafe { Self::from_i32_unchecked(i) })
>> > 	    }
>> > 	}
>> >
>> > 	pub fn current() -> Self {
>> > 	    // SAFETY: smp_processor_id() always return valid cpu id.
>> > 	    unsafe { Self::from_i32_unchecked(smp_processor_id()) }
>> > 	}
>> >     }
>> >
>> > All `Cpumask` functions then take `CpuId` instead of `i32` as the
>> > parameter. Needless to say if we were to have a cpumask_next() wrapper=
,
>> > the return value will be `CpuId` (or `Option<CpuId>`), i.e. if a bit w=
as
>> > set in a cpumask, then it must represent a correct cpu id.
>> >
>> > Make sense?
>>=20
>> Just to make sure, the `nr_cpu_ids` stays constant, right?
>>=20
>
> Sort of. I believe the value won't be changed once the kernel boots, in
> most cases (modulo NR_CPUS=3D1 or CONFIG_FORCE_NR_CPUS=3Dy), it's a
> read-mostly variable not a constant, and the value gets set by either a
> kernel command line or how many CPUs the kernel actually detect at boot
> time. See:
>
> https://github.com/Rust-for-Linux/linux/blob/rust-next/kernel/smp.c#L995:=
w

It's allowed to increase, but if it ever decreases, the invariant of
`CpuId` will be wrong (ie it's not *invariant* :).

>> >> @@ -101,10 +108,16 @@ pub fn set(&mut self, cpu: u32) {
>> >>      /// This mismatches kernel naming convention and corresponds to =
the C
>> >>      /// function `__cpumask_clear_cpu()`.
>> >>      #[inline]
>> >> -    pub fn clear(&mut self, cpu: i32) {
>> >> +    pub fn clear(&mut self, cpu: i32) -> Result {
>> >> +        // SAFETY: It is safe to read `nr_cpu_ids`.
>> >> +        if unsafe { cpu as u32 >=3D bindings::nr_cpu_ids } {
>> >
>> > You probably want to check whether `bindings::nr_cpu_ids` can be
>> > accessible if NR_CPUS =3D=3D 1 or CONFIG_FORCE_NR_CPUS=3Dy, because th=
en
>> > nr_cpu_ids is a macro definition.
>>=20
>> Just define a helper function?
>>=20
>
> Maybe, but it is then "a variable read" vs "a FFI function call" if we
> want to check every time in clear()/set(), of course if we only check it
> in CpuId::from_i32() mentioned above, the performance impact shouldn't
> be observable, because we won't call that method often.

Sure, you could also have a rust function that is inlined that does the
two different checks depending on the config.

> Either, I was just pointing out the current fix may cause build errors.

Yeah that should be fixed.

---
Cheers,
Benno

