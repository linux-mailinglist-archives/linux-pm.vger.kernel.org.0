Return-Path: <linux-pm+bounces-20033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB18FA03E4E
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5BB1633A6
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35D31E261F;
	Tue,  7 Jan 2025 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6x41r4r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E531AAA32;
	Tue,  7 Jan 2025 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251018; cv=none; b=ngvhHhzNCR1cXC4p3LkkM+Ob5njZRH7KYlicLzkcbOd/FcxaM7jDXKxhUhQs05MQvo+ZXnfWQjucCS769Ler7zBPA9mstQquncZgR/fJJCa8AO/TTjy0U/JG87zeEYA6n2Ylo6Z5LRdwq8drnAkci8/y/JYEnz92MAhQkyWRYPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251018; c=relaxed/simple;
	bh=KA6SIoek7qOv823cMYxiZG7dT9wjD+2G04YKK3iWug0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/g96TsEs0ZU2G8+at/tE/Xj8pTcJ9fRBScL8B+ayYkPNfAghKzLlP7sD6T0nyRLZUCDrMPLGXM4FDD05nGd6IhM7kcMlDvIAk4esKtyM/72H1k9KxomBDlSdM/uSJR1zSooCcl6lqWGjc6eJfXGc9PKhdYHHiFXNFvVOlEy5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6x41r4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400BAC4CED6;
	Tue,  7 Jan 2025 11:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736251018;
	bh=KA6SIoek7qOv823cMYxiZG7dT9wjD+2G04YKK3iWug0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6x41r4rg+myEW12Mjlr9dv7osrfvGOWLL3XZ4CFQHACQJMTECEN595M4UcvoHIAs
	 +YRVgiUxLDKNBK6xv6Mo/nIHFBpLZkfn7/tNlVftDr3gMrQmjAsymZBi8NpYfLtavz
	 ArG1b1xUzjVhkB0z5sxVbYS5QzY6VgUqHOanxnURa/xx9Tz6UB5+WNbZ0KiHlFq92k
	 IpCB5j3dor0OND0aQ6KUZkZBjp+q/6NHbzhGZJF7VxPZS+6k2rAc6ElsCjtdB4LtpX
	 q56dbDFaV4DWI90nPYBOcyuTXaOkvDnttQQLySDBJwy4eaL4sqgTF2G4XmSoIOQqnA
	 QXkszZ5mk5XlQ==
Date: Tue, 7 Jan 2025 12:56:50 +0100
From: Danilo Krummrich <dakr@kernel.org>
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 04/15] rust: device: Add few helpers
Message-ID: <Z30WgqKCLJbnr0S4@pollux>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <429b7539f787ad360cd28fd1db6dc3d6c1fe289d.1736248242.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429b7539f787ad360cd28fd1db6dc3d6c1fe289d.1736248242.git.viresh.kumar@linaro.org>

On Tue, Jan 07, 2025 at 04:51:37PM +0530, Viresh Kumar wrote:
> Add from_cpu() and property_present() helpers to the device bindings.

I think you should split this into two separate patches.

> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/device.rs           | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 43f5c381aab0..70e4b7b0f638 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -31,6 +31,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/platform_device.h>
>  #include <linux/poll.h>
> +#include <linux/property.h>
>  #include <linux/refcount.h>
>  #include <linux/sched.h>
>  #include <linux/security.h>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index d5e6a19ff6b7..5bfbc4bdfadc 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -6,6 +6,9 @@
>  
>  use crate::{
>      bindings,
> +    error::Result,
> +    prelude::ENODEV,
> +    str::CString,
>      types::{ARef, Opaque},
>  };
>  use core::{fmt, ptr};
> @@ -59,6 +62,18 @@ pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
>          unsafe { Self::as_ref(ptr) }.into()
>      }
>  
> +    /// Creates a new ref-counted instance of device of a CPU.
> +    pub fn from_cpu(cpu: u32) -> Result<ARef<Self>> {
> +        // SAFETY: It is safe to call `get_cpu_device()` for any CPU number.
> +        let ptr = unsafe { bindings::get_cpu_device(cpu) };
> +        if ptr.is_null() {
> +            return Err(ENODEV);
> +        }
> +
> +        // SAFETY: By the safety requirements, ptr is valid.

There are no safety requirements for from_cpu().

Instead, you should say that the pointer returned by get_cpu_device(), if not
NULL, is a valid pointer to a struct device with a non-zero reference count.

> +        Ok(unsafe { Device::get_device(ptr) })
> +    }
> +
>      /// Obtain the raw `struct device *`.
>      pub(crate) fn as_raw(&self) -> *mut bindings::device {
>          self.0.get()
> @@ -180,6 +195,12 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
>              )
>          };
>      }
> +
> +    /// Checks if property is present or not.
> +    pub fn property_present(&self, name: &CString) -> bool {
> +        // SAFETY: `name` is null-terminated. `self.as_raw` is valid because `self` is valid.

Maybe "by the invariant of `CString` `name` is null-terminated."?

> +        unsafe { bindings::device_property_present(self.as_raw(), name.as_ptr() as *const _) }
> +    }
>  }
>  
>  // SAFETY: Instances of `Device` are always reference-counted.
> -- 
> 2.31.1.272.g89b43f80a514
> 

