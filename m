Return-Path: <linux-pm+bounces-25553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC93A8B98C
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 14:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7129D7A8750
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 12:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23562EAE4;
	Wed, 16 Apr 2025 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufMbBZza"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02A11CA0;
	Wed, 16 Apr 2025 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807622; cv=none; b=iNJv4X0lFKAiQ+Mxmk23cKpfmfmPuZipnBEnVrkmwveUUjE7pyvE4B4rCvLE0mw9FjLSze17fVuCvaZ+PYUJCSWjZul39m5EUbn6ZXE9J0zL2fOel8B7kTFSz3+vQEvnE4ZHiwYQZ2DH4WZqtSlyv7/o6aHK29JHkNsfhHCrGQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807622; c=relaxed/simple;
	bh=LvJ12tKplLNrFrTCz4Wzqin22ujyIlOPSdlj12fSrN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6c79JPwKqtOXmXDgcvRVoLY1XWr//82EF+0FRHX9E3pzXx0p6WkkqrSKfNQ1O0HpZPoWyENHVgaMFXykUfup+XXs6nZIFdMJ8DrmKxkKpERFWykekfTxKodQlYSyxKXRv2je2bW2vWcYcqmEQUp1SEqRurm/qDSnmSITzBNuvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufMbBZza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705C6C4CEE2;
	Wed, 16 Apr 2025 12:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744807620;
	bh=LvJ12tKplLNrFrTCz4Wzqin22ujyIlOPSdlj12fSrN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ufMbBZzaEUx30bSlUVP3sqOw//LJN3SAfJPd8tH3iTGtQ3tjSddJ5/M0RLqX4FSjT
	 DhP7cnt0EWXxkA/8Xe3QuweEZl2iPLQwz6oQOWsWT0E+8G6+WOT5BUJP2zbTTKM91B
	 xRY7Iu1ZfJ9LUnAMbZSLMQ51o3pObzL+uA/dz6TMyI1gIOh9d4PlQQ8s/CQFeGvX0t
	 2Hf6RY7hq4jpgCpTCXEOjdIZk1FW+lQ/uS3Q36RpTrWzyM0EqTyZbanAomZaa+0LGs
	 /m8dehnanFXVpzxyiJEZ6W89mnjJoTSwHGbF8OlQR0qI96XD99ls5QaMKTYVX6Fsqf
	 sZOUnS9t3bOaA==
Date: Wed, 16 Apr 2025 14:46:52 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 14/15] rust: opp: Extend OPP abstractions with
 cpufreq support
Message-ID: <Z_-mvB7hibFD4Q34@pollux>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
 <a940d1b1a02d99fdc80ba8d0526c35a776854cb3.1744783509.git.viresh.kumar@linaro.org>
 <Z_9v24SghlIhT62r@pollux>
 <20250416095943.f3jxy55bamekscst@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416095943.f3jxy55bamekscst@vireshk-i7>

On Wed, Apr 16, 2025 at 03:29:43PM +0530, Viresh Kumar wrote:
> On 16-04-25, 10:52, Danilo Krummrich wrote:
> > This config is needed quite often, it probably makes sense to move this code in
> > its own Rust module, i.e.:
> > 
> > 	#[cfg(CONFIG_CPU_FREQ)]
> > 	pub mod freq;
> 
> Like this ?

Yes, I thought of a separate file, but I that should work as well.

> 
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index 734be8b6d0ef..f4cabe859c43 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -20,10 +20,67 @@
>  };
> 
>  #[cfg(CONFIG_CPU_FREQ)]
> -use crate::cpufreq;
> +// Frequency table implementation.
> +mod freq {
> +    use crate::cpufreq;
> +    use core::ops::Deref;
> +    use super::*;
> +
> +    /// OPP frequency table.
> +    ///
> +    /// A [`cpufreq::Table`] created from [`Table`].
> +    pub struct FreqTable {
> +        dev: ARef<Device>,
> +        ptr: *mut bindings::cpufreq_frequency_table,
> +    }
> +
> +    impl FreqTable {
> +        /// Creates a new instance of [`FreqTable`] from [`Table`].
> +        pub(crate) fn new(table: &Table) -> Result<Self> {
> +            let mut ptr: *mut bindings::cpufreq_frequency_table = ptr::null_mut();
> +
> +            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
> +            // requirements.
> +            to_result(unsafe {
> +                bindings::dev_pm_opp_init_cpufreq_table(table.dev.as_raw(), &mut ptr)
> +            })?;
> +
> +            Ok(Self {
> +                dev: table.dev.clone(),
> +                ptr,
> +            })
> +        }
> +
> +        // Returns a reference to the underlying [`cpufreq::Table`].
> +        #[inline]
> +        fn table(&self) -> &cpufreq::Table {
> +            // SAFETY: The `ptr` is guaranteed by the C code to be valid.
> +            unsafe { cpufreq::Table::from_raw(self.ptr) }
> +        }
> +    }
> +
> +    impl Deref for FreqTable {
> +        type Target = cpufreq::Table;
> +
> +        #[inline]
> +        fn deref(&self) -> &Self::Target {
> +            self.table()
> +        }
> +    }
> +
> +    impl Drop for FreqTable {
> +        fn drop(&mut self) {
> +            // SAFETY: The pointer was created via `dev_pm_opp_init_cpufreq_table`, and is only
> +            // freed here.
> +            unsafe {
> +                bindings::dev_pm_opp_free_cpufreq_table(self.dev.as_raw(), &mut self.as_raw())
> +            };
> +        }
> +    }
> +}
> 
>  #[cfg(CONFIG_CPU_FREQ)]
> -use core::ops::Deref;
> +pub use freq::FreqTable;
> 
>  use core::{marker::PhantomData, ptr};
> 
> @@ -502,60 +559,6 @@ extern "C" fn config_regulators(
>      }
>  }
> 
> -/// OPP frequency table.
> -///
> -/// A [`cpufreq::Table`] created from [`Table`].
> -#[cfg(CONFIG_CPU_FREQ)]
> -pub struct FreqTable {
> -    dev: ARef<Device>,
> -    ptr: *mut bindings::cpufreq_frequency_table,
> -}
> -
> -#[cfg(CONFIG_CPU_FREQ)]
> -impl FreqTable {
> -    /// Creates a new instance of [`FreqTable`] from [`Table`].
> -    fn new(table: &Table) -> Result<Self> {
> -        let mut ptr: *mut bindings::cpufreq_frequency_table = ptr::null_mut();
> -
> -        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
> -        // requirements.
> -        to_result(unsafe {
> -            bindings::dev_pm_opp_init_cpufreq_table(table.dev.as_raw(), &mut ptr)
> -        })?;
> -
> -        Ok(Self {
> -            dev: table.dev.clone(),
> -            ptr,
> -        })
> -    }
> -
> -    // Returns a reference to the underlying [`cpufreq::Table`].
> -    #[inline]
> -    fn table(&self) -> &cpufreq::Table {
> -        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
> -        unsafe { cpufreq::Table::from_raw(self.ptr) }
> -    }
> -}
> -
> -#[cfg(CONFIG_CPU_FREQ)]
> -impl Deref for FreqTable {
> -    type Target = cpufreq::Table;
> -
> -    #[inline]
> -    fn deref(&self) -> &Self::Target {
> -        self.table()
> -    }
> -}
> -
> -#[cfg(CONFIG_CPU_FREQ)]
> -impl Drop for FreqTable {
> -    fn drop(&mut self) {
> -        // SAFETY: The pointer was created via `dev_pm_opp_init_cpufreq_table`, and is only freed
> -        // here.
> -        unsafe { bindings::dev_pm_opp_free_cpufreq_table(self.dev.as_raw(), &mut self.as_raw()) };
> -    }
> -}
> -
>  /// A reference-counted OPP table.
>  ///
>  /// Rust abstraction for the C `struct opp_table`.
> 
> -- 
> viresh

