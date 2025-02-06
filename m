Return-Path: <linux-pm+bounces-21503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC53A2B2E0
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 21:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FE9168F7E
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 20:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5002D1C701A;
	Thu,  6 Feb 2025 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0drsea/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD7C1B4231;
	Thu,  6 Feb 2025 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738872362; cv=none; b=GOHXLIWdz63knXSIBBSRu5KnwHCKWu31CJCwY2HQtR2VBTyHevWJvTpYN+zmWpSkeRdyMp7hq8hbNuetnfl0qX72r0U+5UhNL0NPTckbv2lTPc4IC9jZ4Xzqy4XbFZbpoZTQtINDfG4KnqcrV0OXEKu3Z2mxvfh+EkQPtXHL+Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738872362; c=relaxed/simple;
	bh=zIOxhng+9030YiafVBMIF0uinyUABG6TP/2uiKz/A/8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=rfbM+JeeZzim8/bCyDbyX7GeLJlxSI6pP+9fFUVqgaQFNm7BVD3hwkzy3gOeayhfqu1u1UdPpWtbZUQiqtI5KUO3mNuSsYPS+npeB+iWl94nx2uxUPRpHkcrAYp2vLqlS9DVCyJbJCol14CJDb9pTkN5aXKGzv2iZcujsJczDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0drsea/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A7DC4CEDD;
	Thu,  6 Feb 2025 20:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738872361;
	bh=zIOxhng+9030YiafVBMIF0uinyUABG6TP/2uiKz/A/8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=M0drsea/HyZE1xa7yUTso301Gdw3Gk+GPpxzYfnvohY+PoRnWlB5J9WBiT41q2SgR
	 h8IS/sh70fuYAn2ETIUWhAYXuF1NDdIS4Yj5ix1awHKCI/K/HGp1Ti069WVDAhexf9
	 sj4TuI85jWaFJd/QCLGwHfXeARrhK8D0oWZ/cAfpdOcNmSfSQ9B4pPnUvlceYlu33t
	 NqgOTeK8Dsz/gEO1EfRw109jEmLURrwxQYT6hHpmKpgyhC3Hm5ilE6RiOY/SzS3RfJ
	 QaRKagxmPZ6uLy6Dx5kJA2ypD75NoGKuVV43RIYXJztroJ5BebGCykwY9iPhWIKIGt
	 PyRB7x1n5UNzw==
Message-ID: <0cd42d2d683ea057e6034978b02c7f84.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z6SiiRubSXGInbgj@pollux>
References: <cover.1738832118.git.viresh.kumar@linaro.org> <c68081e18d939aefc7f6dac798df6b72e81bba4b.1738832118.git.viresh.kumar@linaro.org> <Z6ShsuLykigNscz8@pollux> <Z6SiiRubSXGInbgj@pollux>
Subject: Re: [PATCH V8 06/14] rust: Add bare minimal bindings for clk framework
From: Stephen Boyd <sboyd@kernel.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Michael Turquette <mturquette@baylibre.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, Alex =?utf-8?q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To: Danilo Krummrich <dakr@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 06 Feb 2025 12:05:59 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Danilo Krummrich (2025-02-06 03:52:41)
> On Thu, Feb 06, 2025 at 12:49:14PM +0100, Danilo Krummrich wrote:
> > On Thu, Feb 06, 2025 at 02:58:27PM +0530, Viresh Kumar wrote:
> > > diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> > > new file mode 100644
> > > index 000000000000..123cdb43b115
> > > --- /dev/null
> > > +++ b/rust/kernel/clk.rs
> > > @@ -0,0 +1,48 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Clock abstractions.
> > > +//!
> > > +//! C header: [`include/linux/clk.h`](srctree/include/linux/clk.h)
> > > +
> > > +use crate::{
> > > +    bindings,
> > > +    device::Device,
> > > +    error::{from_err_ptr, Result},
> > > +    prelude::*,
> > > +};
> > > +
> > > +use core::ptr;
> > > +
> > > +/// A simple implementation of `struct clk` from the C code.
> > > +#[repr(transparent)]
> > > +pub struct Clk(*mut bindings::clk);
> >=20
> > Guess this should be Opaque<bindings::clk>.
>=20
> Sorry, I meant NonNull<bindings::clk>.

NULL is a valid clk. It's like "don't care" in the common clk framework
as most clk consumer operations bail out early in that case.

