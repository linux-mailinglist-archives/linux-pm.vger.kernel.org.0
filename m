Return-Path: <linux-pm+bounces-28184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EABBACFDFC
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 10:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5D41893805
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 08:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEDE28468B;
	Fri,  6 Jun 2025 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cj4pu86+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE3A24EF6B;
	Fri,  6 Jun 2025 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749197480; cv=none; b=N9DDOqmrsJ+cxYjgjZSI5TgVTfMKheS85B3jyFh/bxPcHvreorOlaJOQsvio3Uai6JacR/IJNLEPmPWBmRd0RzS4C6rxZThDsC68cDxZyOwPdZRI9wHYNGtXfY2k2+tsgBuAH3xPg0XkN4l+PRurI4XYuFMIfQi3hYpT6OiXQT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749197480; c=relaxed/simple;
	bh=ND77xMVcFqeXe20NboWW0w2himlLjNgVxCRvLH5ylDA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HuqwO5hlTipuLpH0C9c4Bty26xBcpW40i8wIyNmvvV4LPAGYhUdPf/qZBc5MuZDLYk8MKJTN4g4MPWD9ZKMr8tTYJDwHlttW3wAyvGj1wxD/NHMiCWBG7VX2K7sjlXygLHLAkTws2hbJ80XktdGkZViJAu/oBoEcl5P1CHGG9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cj4pu86+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854E5C4CEEB;
	Fri,  6 Jun 2025 08:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749197480;
	bh=ND77xMVcFqeXe20NboWW0w2himlLjNgVxCRvLH5ylDA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=cj4pu86+AMWCo54oNH4Pvp+0tWHoIclkHKDmjxZirsjSHKcfhsNxMbU80aU/1wo8t
	 53NjEOedMoJS7nhcrS0yT4SPtmGD57MILhpCIzRqNv0gxW5XZFcJHPtKjh55e2Qioy
	 7oG3IZB5PLYrKWCTuxz/CxkyqwspR11EmFNSDzm3DHDr+rQ0NAPCJTklDhWpU1WdZ4
	 PK2oTdjgJk2OAlz/twb1gPG5z4W6x7jWpdN4DgY3Y3WMnOhlNLsampM4q5PgfpFMax
	 CJcaItV7pzGFeh1dGXToOOCUVqv/cghi7W+v4s0Gy1q4T3WT68Vx2tiuHfuuoUI8d9
	 aBjnADTPSgOTA==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Jun 2025 10:11:13 +0200
Message-Id: <DAFAR5SUQSU9.OSLB2UAXE9DY@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Vincent Guittot" <vincent.guittot@linaro.org>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: cpumask: Validate CPU number in set() and clear()
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Viresh Kumar"
 <viresh.kumar@linaro.org>
X-Mailer: aerc 0.20.1
References: <8b5fc7889a7aacbd9f1f7412c99f02c736bde190.1749183428.git.viresh.kumar@linaro.org> <aEJwm16HSwCyt7aB@Mac.home>
In-Reply-To: <aEJwm16HSwCyt7aB@Mac.home>

On Fri Jun 6, 2025 at 6:37 AM CEST, Boqun Feng wrote:
> On Fri, Jun 06, 2025 at 09:47:28AM +0530, Viresh Kumar wrote:
>> The C `cpumask_{set|clear}_cpu()` APIs emit a warning when given an
>> invalid CPU number - but only if `CONFIG_DEBUG_PER_CPU_MAPS=3Dy` is set.
>>=20
>> Meanwhile, `cpumask_weight()` only considers CPUs up to `nr_cpu_ids`,
>> which can cause inconsistencies: a CPU number greater than `nr_cpu_ids`
>> may be set in the mask, yet the weight calculation won't reflect it.
>>=20
>> This leads to doctest failures when `nr_cpu_ids < 4`, as the test tries
>> to set CPUs 2 and 3:
>>=20
>>   rust_doctest_kernel_cpumask_rs_0.location: rust/kernel/cpumask.rs:180
>>   rust_doctest_kernel_cpumask_rs_0: ASSERTION FAILED at rust/kernel/cpum=
ask.rs:190
>>=20
>> Fix this by validating the CPU number in the Rust `set()` and `clear()`
>> methods to prevent out-of-bounds modifications.
>>=20
>
> Thanks for the quick fix!
>
> While this can fix the current problem, but it's not a good solution for
> the long run. Because outside a test, we should never use an arbitrary
> i32 as a cpu number (we usually get it from smp_processor_id(), or
> something else). So the `< nr_cpu_ids` testing is not necessary in
> normal use cases.
>
> We should instead provide a wrapper for cpu id:
>
>     /// # Invariants
>     ///
>     /// The number is always in [0..nr_cpu_ids) range.
>     pub struct CpuId(i32);
>
> and
>
>     impl CpuId {
>         /// # Safety
> 	/// Callers must ensure `i` is a valid cpu id (i.e. 0 <=3D i <
> 	/// nr_cpu_ids).
>         pub unsafe fn from_i32_unchecked(i: i32) -> Self {
> 	    // INVARIANT: The function safety guarantees `i` is a valid
> 	    // cpu id.
> 	    CpuId(id);
> 	}
>
> 	pub fn from_i32(i: i32) -> Option<Self> {
> 	    if i < 0 || i >=3D nr_cpu_ids {
> 	        None
> 	    } else {
> 	        // SAFETY: `i` has just been checked as a valid cpu id.
> 	        Some(unsafe { Self::from_i32_unchecked(i) })
> 	    }
> 	}
>
> 	pub fn current() -> Self {
> 	    // SAFETY: smp_processor_id() always return valid cpu id.
> 	    unsafe { Self::from_i32_unchecked(smp_processor_id()) }
> 	}
>     }
>
> All `Cpumask` functions then take `CpuId` instead of `i32` as the
> parameter. Needless to say if we were to have a cpumask_next() wrapper,
> the return value will be `CpuId` (or `Option<CpuId>`), i.e. if a bit was
> set in a cpumask, then it must represent a correct cpu id.
>
> Make sense?

Just to make sure, the `nr_cpu_ids` stays constant, right?

>> @@ -101,10 +108,16 @@ pub fn set(&mut self, cpu: u32) {
>>      /// This mismatches kernel naming convention and corresponds to the=
 C
>>      /// function `__cpumask_clear_cpu()`.
>>      #[inline]
>> -    pub fn clear(&mut self, cpu: i32) {
>> +    pub fn clear(&mut self, cpu: i32) -> Result {
>> +        // SAFETY: It is safe to read `nr_cpu_ids`.
>> +        if unsafe { cpu as u32 >=3D bindings::nr_cpu_ids } {
>
> You probably want to check whether `bindings::nr_cpu_ids` can be
> accessible if NR_CPUS =3D=3D 1 or CONFIG_FORCE_NR_CPUS=3Dy, because then
> nr_cpu_ids is a macro definition.

Just define a helper function?

---
Cheers,
Benno

