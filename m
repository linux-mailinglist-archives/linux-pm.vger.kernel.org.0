Return-Path: <linux-pm+bounces-20032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AA8A03E47
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A5B18853F8
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CE51E3DCC;
	Tue,  7 Jan 2025 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q9QUq7jV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36881E0DE5;
	Tue,  7 Jan 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250972; cv=none; b=Tjre3jkbqso7q8y5hGcrha1tgWtFbTE0jwHsLP6la2aHOzq1H2uFYLDQ/A/q/xfkob09YHjfPYmS+badyp48+XwN7lchQ6SsQuIif8rP5QucBTjcRVs7TZYqgVPmBhRES4vmFnfp+5u7dv8ukbOmXYV+DU76oysdaiaI+5u2XcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250972; c=relaxed/simple;
	bh=DOg7Lgjd6W+yuS+5gzaGeLM+9My0Y/z5Kl2TJmQQoI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk5MBDpVKDoYTVTbLggBYb/KGm1hqbVapQ7ZvGKrexGd2PMBWvWfPC3kD9pBPMnCFKf1k8znNVMvHl0PCRedg2Yb+AtY4/AeTHpQpNlxYtq7cYEHfQsWlfTDzWcZznMLqrSR2a5de7+PkzF5CCzM6mSrHQ6MdHEN3XYDdARS9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q9QUq7jV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACADC4CED6;
	Tue,  7 Jan 2025 11:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736250971;
	bh=DOg7Lgjd6W+yuS+5gzaGeLM+9My0Y/z5Kl2TJmQQoI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q9QUq7jV91liX4pX4PnVS8iz2B95/DcKW+ViNLR7HgCCtU7lWrKu748k0/vdmKESy
	 QtiKC79pm/YcaLuyxvJc0RH243meLAQwVjD9cnkbLFySXgDHToAzbbXzey9ifVwcnp
	 7e86AHhaxOgmRPQwFArpn7EoycN9Oya9+LcV9p1k=
Date: Tue, 7 Jan 2025 12:56:08 +0100
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
Message-ID: <2025010734-march-cultivate-bd96@gregkh>
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

That says what, but not why.

Also those are two totally different things, I'm going to argue with you
about one of them...

> +    /// Creates a new ref-counted instance of device of a CPU.
> +    pub fn from_cpu(cpu: u32) -> Result<ARef<Self>> {

Why is this a reference counted device, yet the C structure is NOT
properly reference counted at all?  Are you _sure_ this is going to work
properly?

And really, we should fix up the C side to properly reference count all
of this.  Just read the comment in cpu_device_release() for a hint at
what needs to be done here.

> +        // SAFETY: It is safe to call `get_cpu_device()` for any CPU number.

For any number at all, no need to say "CPU" here, right?

> +        let ptr = unsafe { bindings::get_cpu_device(cpu) };
> +        if ptr.is_null() {
> +            return Err(ENODEV);
> +        }
> +
> +        // SAFETY: By the safety requirements, ptr is valid.
> +        Ok(unsafe { Device::get_device(ptr) })

So why is this device reference counted?  I get it that it should be,
but how does that play with the "real" device here?

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
> +        unsafe { bindings::device_property_present(self.as_raw(), name.as_ptr() as *const _) }

is "self.as_raw()" a constant pointer too?

thanks,

greg k-h

