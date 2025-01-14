Return-Path: <linux-pm+bounces-20433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FF8A1105D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 19:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927903A4D5B
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 18:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC211F9F60;
	Tue, 14 Jan 2025 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="isr5W1mD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C271D54E2;
	Tue, 14 Jan 2025 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736880150; cv=none; b=HfVsqePs7NBRIiAc8nWsdoLFe9mD5Pkzdx7AkouUC+MitCHt7Yqdl0fHKAtCY5//AdLDazADFb1ozvLM3uq2yrZhfGfCSifHHHPSRN3b0xTh0x67uwcEAw7QAIy4F7WTeX1E3W5hx0ERrH2lEIYON/CVadj74AbgQkBY++OKuwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736880150; c=relaxed/simple;
	bh=EUT3oOlrQr51CgzU+r6kxyaTVH0cN94CbyiPJtLj1cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCj44VE9synC1UhxCtY+yBhTfvtV9EZ9BSBEUR4U6GDUVoQwin2LeFZN2rJKVv8jiRgmCixwjUf/Of5SfcDGFZNXuOUoDy4XvWoX/H2z/PyhMH8TLK94X+abxV7jDGXW41AJhFYyEo2ViVMYE4D+MPsJ3vHP6uoqR0e8TjUfykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=isr5W1mD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF76C4CEDD;
	Tue, 14 Jan 2025 18:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736880149;
	bh=EUT3oOlrQr51CgzU+r6kxyaTVH0cN94CbyiPJtLj1cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isr5W1mDrYhqCWbhmE0lhHqO5rK+6qjnoCJ6f8PeP36VaCUP15re/kCKf+dIYnDfb
	 jcaq1zjmTHp1BejseknylV31NAjuHZoBVuO1Km1BwvWVQpYrWE01dZSgNGBLw2P702
	 7+KUbuKrg+m/lP8LwTswtp1/sJXSTIon5mTecxvM=
Date: Tue, 14 Jan 2025 19:42:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 04/16] rust: device: Add property_present()
Message-ID: <2025011432-racism-savings-715b@gregkh>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
 <f43fe3f7b3151a89c261ad728b0f3bb2fc24caef.1736766672.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f43fe3f7b3151a89c261ad728b0f3bb2fc24caef.1736766672.git.viresh.kumar@linaro.org>

On Mon, Jan 13, 2025 at 04:52:59PM +0530, Viresh Kumar wrote:
> This implements Device::property_present(), which calls C APIs
> device_property_present() helper.
> 
> The new helper will be used by Rust based cpufreq drivers.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  rust/bindings/bindings_helper.h | 1 +
>  rust/kernel/device.rs           | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index d63e7f6d10ea..fda1e0d8f376 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -27,6 +27,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/platform_device.h>
>  #include <linux/poll.h>
> +#include <linux/property.h>
>  #include <linux/refcount.h>
>  #include <linux/sched.h>
>  #include <linux/security.h>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index d5e6a19ff6b7..e8c4cda5aacc 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -6,6 +6,7 @@
>  
>  use crate::{
>      bindings,
> +    str::CString,
>      types::{ARef, Opaque},
>  };
>  use core::{fmt, ptr};
> @@ -180,6 +181,12 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
>              )
>          };
>      }
> +
> +    /// Checks if property is present or not.
> +    pub fn property_present(&self, name: &CString) -> bool {
> +        // SAFETY: By the invariant of `CString`, `name` is null-terminated.
> +        unsafe { bindings::device_property_present(self.as_raw().cast_const(), name.as_ptr() as *const _) }
> +    }
>  }

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

