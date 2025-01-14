Return-Path: <linux-pm+bounces-20435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E32A1106A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 19:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3655F3A4E92
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857B91FA15B;
	Tue, 14 Jan 2025 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dQXUYes/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0C81C5D41;
	Tue, 14 Jan 2025 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736880298; cv=none; b=dKuZZJXsjlePlpjleYI1JYMCRxTev17mMRFfYXL6tPKpt+K+lQ6GtMZQCBkesENkJAZQGZELmHrO7zUFVqnE8hliq0sT0ejCuHPlcv+X+IS1QzirawPivT1cg5uOi2/z5e+NGlqwHvj4wH/cgqqLGvLWwgp7fVdFa/OnRZhPJcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736880298; c=relaxed/simple;
	bh=9/kfYBcXAbFDT+sCbvVPYXGFVuVnq7Go6JSdoCOJvdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK5KpVVJjbd+bStA3UN8r+6OXAlJbn8Yt+LjHOSngIUKsRonHydCg3CB4PQLapQuzwfBMVu2rWFpULcnotAfZRNJx00KDD0VE3Xp7aF8jWBTUdU88Qc5iFEGRe3nXyUMo3eceg0v1/AY4a7UJxBKUkSJcXKldNbdoY9Yly7MInY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dQXUYes/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AD3C4CEDD;
	Tue, 14 Jan 2025 18:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736880297;
	bh=9/kfYBcXAbFDT+sCbvVPYXGFVuVnq7Go6JSdoCOJvdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dQXUYes/HQAgUr3Jb76V49qYuRidwS9xkxLfy5LQfTIepAo3Q+iKxwg62Pjel8Arg
	 z/LKaIk0+iZrWqM+VUkgzYOLvquH6ckK0iE4u0RJEUTb7bl8PldXLUK8raqNGuMAXY
	 d3t0JlRkLbE2d1DckSMG0qfO/9khTrY/1iv5DnUQ=
Date: Tue, 14 Jan 2025 19:44:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V7 03/16] rust: cpu: Add from_cpu()
Message-ID: <2025011430-humiliate-expansive-2ea4@gregkh>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
 <854f7b8c9cbcc7f38fe5ed548290f41224478b40.1736766672.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <854f7b8c9cbcc7f38fe5ed548290f41224478b40.1736766672.git.viresh.kumar@linaro.org>

On Mon, Jan 13, 2025 at 04:52:58PM +0530, Viresh Kumar wrote:
> This implements cpu::from_cpu(), which returns a reference to
> Device for a CPU. The C struct is created at initialization time for
> CPUs and is never freed and so ARef isn't returned from this function.
> 
> The new helper will be used by Rust based cpufreq drivers.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/cpu.rs              | 26 ++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |  1 +
>  3 files changed, 28 insertions(+)
>  create mode 100644 rust/kernel/cpu.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index e9fdceb568b8..d63e7f6d10ea 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -10,6 +10,7 @@
>  #include <linux/blk-mq.h>
>  #include <linux/blk_types.h>
>  #include <linux/blkdev.h>
> +#include <linux/cpu.h>
>  #include <linux/cred.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
> diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
> new file mode 100644
> index 000000000000..422e874627d2
> --- /dev/null
> +++ b/rust/kernel/cpu.rs
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic CPU definitions.
> +//!
> +//! C header: [`include/linux/cpu.h`](srctree/include/linux/cpu.h)
> +
> +use crate::{
> +    bindings,
> +    device::Device,
> +    error::Result,
> +    prelude::ENODEV,
> +};
> +
> +/// Creates a new instance of CPU's device.
> +pub fn from_cpu(cpu: u32) -> Result<&'static Device> {
> +    // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
> +    // a `struct device` and is never freed by the C code.

I thought it was pointed out that it could be freed when a cpu was
hot-unplugged?  Or is that a different device in the cpu code?  We seem
to have 2 of them and it's not obvious which is which :(

thanks,

greg k-h

