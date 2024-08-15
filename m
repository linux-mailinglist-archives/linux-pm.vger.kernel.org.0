Return-Path: <linux-pm+bounces-12260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF36952B0A
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 11:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE2AEB2051A
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 09:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF8A1BD4F7;
	Thu, 15 Aug 2024 08:30:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AEC177980;
	Thu, 15 Aug 2024 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710618; cv=none; b=UZkZ/gRAgg4MjnORFdDpjQ0mjNXpPesO3+09I9shWVHzIBR6hNAiDL471FJkQyFVQfMhTPKedUrX65VVXPiWuQNbbLvhcIX7B+JAqSYO7gO6tyJZiG0PG6lGb68gnp5rzNBPGp7hNCIYdWeGoIe4fxeEMsplHPxDE3g2xXKS5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710618; c=relaxed/simple;
	bh=eGKMZIAHZn0qGfSlPf2pl0TT/SzeZGIQ4kHgw2k7x68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chhHWpGVi5qrAeimplQEG7ZiEd2JDrWYQM56kEqpi3b6bdiR0wgB7gGya7u3tA2xTsdEyUDMBuwH9yNpO/bGvlrPmi4a46owZXcxP6oIrMDuId3NuI6ozJvzj9LgFMzJhXi1GCwBNHr+RBAY4gVpKxnGTWbT9uRqrm6W8h1EV4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 649E516F3;
	Thu, 15 Aug 2024 01:30:42 -0700 (PDT)
Received: from [192.168.1.13] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E04A63F6A8;
	Thu, 15 Aug 2024 01:30:11 -0700 (PDT)
Message-ID: <2a510219-4681-4915-9c27-c7ecdc6df133@arm.com>
Date: Thu, 15 Aug 2024 10:30:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 6/8] rust: Extend cpufreq bindings for driver
 registration
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
 rust-for-linux@vger.kernel.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org
References: <cover.1722334569.git.viresh.kumar@linaro.org>
 <9eb75ce148b8fead5b66c1927cff2355325ae621.1722334569.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <9eb75ce148b8fead5b66c1927cff2355325ae621.1722334569.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Viresh,

On 7/30/24 12:27, Viresh Kumar wrote:
> This extends the cpufreq bindings with bindings for registering a
> driver.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   rust/kernel/cpufreq.rs | 478 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 476 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index d58bb0bbaad4..2631dbb4865f 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -9,14 +9,17 @@
>   use crate::{
>       bindings, clk, cpumask,
>       device::Device,
> -    error::{code::*, from_err_ptr, to_result, Result, VTABLE_DEFAULT_ERROR},
> +    devres::Devres,
> +    error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
>       prelude::*,
>       types::ForeignOwnable,
>   };
>   
>   use core::{
> +    cell::UnsafeCell,
> +    marker::PhantomData,
>       pin::Pin,
> -    ptr::self,
> +    ptr::{self, addr_of_mut},
>   };
>   
>   use macros::vtable;
> @@ -563,3 +566,474 @@ fn register_em(_policy: &mut Policy) {
>           kernel::build_error(VTABLE_DEFAULT_ERROR)
>       }
>   }
> +
> +/// Registration of a cpufreq driver.
> +pub struct Registration<T: Driver> {
> +    drv: Box<UnsafeCell<bindings::cpufreq_driver>>,
> +    _p: PhantomData<T>,
> +}
> +
> +// SAFETY: `Registration` doesn't offer any methods or access to fields when shared between threads
> +// or CPUs, so it is safe to share it.
> +unsafe impl<T: Driver> Sync for Registration<T> {}
> +
> +// SAFETY: Registration with and unregistration from the cpufreq subsystem can happen from any thread.
> +// Additionally, `T::Data` (which is dropped during unregistration) is `Send`, so it is okay to move
> +// `Registration` to different threads.
> +#[allow(clippy::non_send_fields_in_send_ty)]
> +unsafe impl<T: Driver> Send for Registration<T> {}
> +
> +impl<T: Driver> Registration<T> {
> +    /// Registers a cpufreq driver with the rest of the kernel.
> +    pub fn new(name: &'static CStr, data: T::Data, flags: u16, boost: bool) -> Result<Self> {
> +        let mut drv = Box::new(
> +            UnsafeCell::new(bindings::cpufreq_driver::default()),
> +            GFP_KERNEL,
> +        )?;
> +        let drv_ref = drv.get_mut();
> +
> +        // Account for the trailing null character.
> +        let len = name.len() + 1;
> +        if len > drv_ref.name.len() {
> +            return Err(EINVAL);
> +        };
> +
> +        // SAFETY: `name` is a valid Cstr, and we are copying it to an array of equal or larger
> +        // size.
> +        let name = unsafe { &*(name.as_bytes_with_nul() as *const [u8] as *const [i8]) };
> +        drv_ref.name[..len].copy_from_slice(name);
> +
> +        drv_ref.boost_enabled = boost;
> +        drv_ref.flags = flags;
> +
> +        // Allocate an array of 3 pointers to be passed to the C code.
> +        let mut attr = Box::new([ptr::null_mut(); 3], GFP_KERNEL)?;
> +        let mut next = 0;
> +
> +        // SAFETY: The C code returns a valid pointer here, which is again passed to the C code in
> +        // an array.
> +        attr[next] =
> +            unsafe { addr_of_mut!(bindings::cpufreq_freq_attr_scaling_available_freqs) as *mut _ };
> +        next += 1;
> +
> +        if boost {
> +            // SAFETY: The C code returns a valid pointer here, which is again passed to the C code
> +            // in an array.
> +            attr[next] =
> +                unsafe { addr_of_mut!(bindings::cpufreq_freq_attr_scaling_boost_freqs) as *mut _ };
> +            next += 1;
> +        }
> +        attr[next] = ptr::null_mut();
> +
> +        // Pass the ownership of the memory block to the C code. This will be freed when
> +        // the [`Registration`] object goes out of scope.
> +        drv_ref.attr = Box::leak(attr) as *mut _;

I think it would be better to give the possibility to the cpufreq driver to pass the
attr array, as not all drivers might want these attributes,

Regards,
Pierre

