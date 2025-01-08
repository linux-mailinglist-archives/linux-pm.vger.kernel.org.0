Return-Path: <linux-pm+bounces-20085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC5DA05A88
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 12:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF31E3A60D0
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 11:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81B11FA260;
	Wed,  8 Jan 2025 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="05E1o/VS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832381FA166;
	Wed,  8 Jan 2025 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337177; cv=none; b=qz3biCatcGK8Ph+pplVAHcTbxwECX8lpG2qW/N9sCzN2TOvPhduH9dUQ9Nxt32ZPxy2uNGEE499igl520vogsryFJTY8NjOlABchKDcNQH57xar3zEVR/P64AuW8k3Np6QEKdGjtnKGgoY0VZcsXD3IhVu58cTGusMjd0u7NtpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337177; c=relaxed/simple;
	bh=9UKPhWEzeyCWhLzHfHT0SB22oAW7mgjYIo40Ea3iKCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YveyrpFHkfA6uFSRtXgm0PSbuPl4Q7Ixmpj0eiXqFGzbLBEPgagEIgfArQmIxaYFYjc2/i03AmoMzazOqP55ZV4VHkEoQn62+YqUJacRgr+4L7lUnebwE75y3cGA7D9NoAL937MauLwowj97VWawwpU8KebHyS8lK0FeEYZObsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=05E1o/VS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DFAC4CEDD;
	Wed,  8 Jan 2025 11:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736337177;
	bh=9UKPhWEzeyCWhLzHfHT0SB22oAW7mgjYIo40Ea3iKCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=05E1o/VSSv6DkwXB12wnQermP3YB1dsne5/w73/KgixoiqJdrtvzxV7m79vnZ9iGi
	 y1nBUUBAt216EbpjfOl0v+RYOS6neDKY1c77w9vKL+ZGetI36S1z2PckdZ2iQIzqJd
	 bnfdPlQAQ+E1c7HEy7Fda7Xq+l5M+T7x673Juztw=
Date: Wed, 8 Jan 2025 12:52:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 04/15] rust: device: Add few helpers
Message-ID: <2025010835-uncover-pamphlet-de5b@gregkh>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <429b7539f787ad360cd28fd1db6dc3d6c1fe289d.1736248242.git.viresh.kumar@linaro.org>
 <2025010734-march-cultivate-bd96@gregkh>
 <20250108110242.dwhdlwnyjloz6dwb@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108110242.dwhdlwnyjloz6dwb@vireshk-i7>

On Wed, Jan 08, 2025 at 04:32:42PM +0530, Viresh Kumar wrote:
> On 07-01-25, 12:56, Greg Kroah-Hartman wrote:
> > On Tue, Jan 07, 2025 at 04:51:37PM +0530, Viresh Kumar wrote:
> > > +    /// Creates a new ref-counted instance of device of a CPU.
> > > +    pub fn from_cpu(cpu: u32) -> Result<ARef<Self>> {
> > 
> > Why is this a reference counted device, yet the C structure is NOT
> > properly reference counted at all?
> 
> Ahh, I completely missed that it is not reference counted at all.
> 
> > Are you _sure_ this is going to work properly?
> > 
> > And really, we should fix up the C side to properly reference count all
> > of this.  Just read the comment in cpu_device_release() for a hint at
> > what needs to be done here.
> > 
> > > +        // SAFETY: It is safe to call `get_cpu_device()` for any CPU number.
> > 
> > For any number at all, no need to say "CPU" here, right?
> > 
> > > +        let ptr = unsafe { bindings::get_cpu_device(cpu) };
> > > +        if ptr.is_null() {
> > > +            return Err(ENODEV);
> > > +        }
> > > +
> > > +        // SAFETY: By the safety requirements, ptr is valid.
> > > +        Ok(unsafe { Device::get_device(ptr) })
> > 
> > So why is this device reference counted?  I get it that it should be,
> > but how does that play with the "real" device here?
> 
> How about this:
> 
> Subject: [PATCH] rust: device: Add from_cpu()
> 
> This implements Device::from_cpu(), which returns a reference to
> `Device` for a CPU. The C struct is created at initialization time for
> CPUs and is never freed and so `ARef` isn't returned from this function.

How about fixing the reference count of the cpu device?  :)

But seriously, this is NOT a generic 'struct device' thing, it is a 'cpu
device' thing.  So putting this function in device.rs is probably not
the proper place for it at all, sorry.  Why not put it in the cpu.rs
file instead?

> The new helper will be used by Rust based cpufreq drivers.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  rust/kernel/device.rs | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 66ba0782551a..007f9ffab08b 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -6,6 +6,8 @@
>  
>  use crate::{
>      bindings,
> +    error::Result,
> +    prelude::ENODEV,
>      str::CString,
>      types::{ARef, Opaque},
>  };
> @@ -60,6 +62,20 @@ pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
>          unsafe { Self::as_ref(ptr) }.into()
>      }
>  
> +    /// Creates a new instance of CPU's device.
> +    pub fn from_cpu(cpu: u32) -> Result<&'static Self> {
> +        // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
> +        // a `struct device` and is never freed by the C code.
> +        let ptr = unsafe { bindings::get_cpu_device(cpu) };
> +        if ptr.is_null() {
> +            return Err(ENODEV);
> +        }
> +
> +        // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
> +        // a `struct device` and is never freed by the C code.
> +        Ok(unsafe { Self::as_ref(ptr) })
> +    }
> +
>      /// Obtain the raw `struct device *`.
>      pub(crate) fn as_raw(&self) -> *mut bindings::device {
>          self.0.get()
> 
> -------------------------8<-------------------------
> 
> > > +    /// Checks if property is present or not.
> > > +    pub fn property_present(&self, name: &CString) -> bool {
> > > +        // SAFETY: `name` is null-terminated. `self.as_raw` is valid because `self` is valid.
> > > +        unsafe { bindings::device_property_present(self.as_raw(), name.as_ptr() as *const _) }
> > 
> > is "self.as_raw()" a constant pointer too?
> 
> Subject: [PATCH] rust: device: Add property_present()
> 
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
> index d5e6a19ff6b7..66ba0782551a 100644
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
> +        unsafe { bindings::device_property_present(self.as_raw() as *const _, name.as_ptr() as *const _) }

I hate to ask, but how was this compiling if the const wasn't there
before?  There's no type-checking happening here?  If not, how are we
ever going to notice when function parameters change?  If there is type
checking, how did this ever build without the const?

confused,

greg k-h

