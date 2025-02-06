Return-Path: <linux-pm+bounces-21519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E2DA2B66A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 00:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9846E3A4E44
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 23:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1219A22FF37;
	Thu,  6 Feb 2025 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLWwQsGr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67932417DB;
	Thu,  6 Feb 2025 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883500; cv=none; b=EDm28jItlnk2McBEdndj9YaYQ35aqPjo2oz+xd2QlVNcFXoTXmD6T2k1Jk9+XVzqq1zV6hVLjJwJQLKg2WGhxDjLorxFwtdYDgI46ZnL8UCluGBbG4o5pJ/NahKzl6Qf62Txo0PkaqIQkHMIHKtOT+n7Rz8sVwajHMqdYAbOWVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883500; c=relaxed/simple;
	bh=jDuPmiaq9ueizgTW8FkupCOJkVQUdjLVaZ6njpeHcVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRoQvOL8as2rccaOlEKAPp1UqZ7xd/fXnkByMRwBYalBgnf16wBfkXfLJtDYPFguxzFMu3LDqfydjcemIyzcec9rDcPBniKEgM7xX7Vteow28h7C8Jw6AQzhqfiV+grb0lNb89Y5q0SZpj5A/+ednqcBgdYj8cOT38wIwU3l2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLWwQsGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C81C4CEE0;
	Thu,  6 Feb 2025 23:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738883499;
	bh=jDuPmiaq9ueizgTW8FkupCOJkVQUdjLVaZ6njpeHcVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLWwQsGrqCWiTz7ciZe4TH4q5zurpTo/1k/REn+QY+m/lsMxACI9XrXHYVq7TI/4r
	 lmTZHCJqQ8QDobZSitExjwGTZDEwnQuAyfBFeK4n99h0ZJFMp1l1VqRc+ZDLKEoBHE
	 vlLnYizUdODzUifm5I4MxmEF+AAhsvL0QqVxMQElohT8cuwk4Z5Bz5cIYudv63Z3gU
	 /flYP8ChC1hQRZhau+nyetKGMuGPSxeDdeea+RFSCcRIEcTyWDHyveYN2TQlB9zo2W
	 RAW8MlfC0ac8q7Txom/mUMuQ7NVj6ZA1k6zCLkGQW8WzXO0O2Tk9wBmAP6x2D5HP9H
	 P0GgNC01AaIXA==
Date: Fri, 7 Feb 2025 00:11:31 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH V8 06/14] rust: Add bare minimal bindings for clk
 framework
Message-ID: <Z6VBo51g54xAmelQ@cassiopeiae>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <c68081e18d939aefc7f6dac798df6b72e81bba4b.1738832118.git.viresh.kumar@linaro.org>
 <Z6ShsuLykigNscz8@pollux>
 <Z6SiiRubSXGInbgj@pollux>
 <0cd42d2d683ea057e6034978b02c7f84.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cd42d2d683ea057e6034978b02c7f84.sboyd@kernel.org>

On Thu, Feb 06, 2025 at 12:05:59PM -0800, Stephen Boyd wrote:
> Quoting Danilo Krummrich (2025-02-06 03:52:41)
> > On Thu, Feb 06, 2025 at 12:49:14PM +0100, Danilo Krummrich wrote:
> > > On Thu, Feb 06, 2025 at 02:58:27PM +0530, Viresh Kumar wrote:
> > > > diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> > > > new file mode 100644
> > > > index 000000000000..123cdb43b115
> > > > --- /dev/null
> > > > +++ b/rust/kernel/clk.rs
> > > > @@ -0,0 +1,48 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +//! Clock abstractions.
> > > > +//!
> > > > +//! C header: [`include/linux/clk.h`](srctree/include/linux/clk.h)
> > > > +
> > > > +use crate::{
> > > > +    bindings,
> > > > +    device::Device,
> > > > +    error::{from_err_ptr, Result},
> > > > +    prelude::*,
> > > > +};
> > > > +
> > > > +use core::ptr;
> > > > +
> > > > +/// A simple implementation of `struct clk` from the C code.
> > > > +#[repr(transparent)]
> > > > +pub struct Clk(*mut bindings::clk);
> > > 
> > > Guess this should be Opaque<bindings::clk>.
> > 
> > Sorry, I meant NonNull<bindings::clk>.
> 
> NULL is a valid clk. It's like "don't care" in the common clk framework

Thanks for clarifying!

> as most clk consumer operations bail out early in that case.

Most? Does that mean NULL isn't *always* valid?

