Return-Path: <linux-pm+bounces-25548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1ECA8B8E2
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 14:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C29127A989E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 12:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEF82472B3;
	Wed, 16 Apr 2025 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axsYmxZ0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E7723F41D;
	Wed, 16 Apr 2025 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806331; cv=none; b=T1NjmguaYa6q15qwIbfw82H3ZuyJzBeeLP0Ui0yXimUlGqUgqLUc7EmD7yIkdTd/Aa1+oAyrPWoJE6IhoS8IjJgnV0jHDASmDX6G0eI2Zf4udfA/yP+Koo/gOaPc7zcH0unvHzSA8I+0zox8hDo/QN1sjj19OO3ezESSUGAvMns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806331; c=relaxed/simple;
	bh=BV2HPhADEG6mWWoQMZcnYHZ6jfye0CvT+9anrJmNaR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkyfdZ21m/hNcWL98FNfPSGe2+EMWHZx44SKKgDvOSmyGC4gZLa9y/pGsxoO0iA1Tmql4YW6R6p4cBAVaEDpk3cLa3D+TEZbsP03LnHzpucXqldKpDAg6ZBwtYMGys+r53Hqjf18hXry+vnO3X9MEuq5HcUCvvI5qHx7S1kXkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axsYmxZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A636C4CEE2;
	Wed, 16 Apr 2025 12:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744806330;
	bh=BV2HPhADEG6mWWoQMZcnYHZ6jfye0CvT+9anrJmNaR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axsYmxZ0s3rcoNJuk1dKe/7DUYWTK6wl0r4NiJhjwnV43VkKMkYQ/0jr1dTxFNPyv
	 Hnqo4X1xhpvEOzx31dLj4cVDlIxR+vuI4/SCgV849cuwCaGbeOHEiPLipeB6gV5hnL
	 fLEYgdnDg1bGj6hLfGxchmCTtOZN3k9dOXVXeG0znWQtX8EWvW8SpvabAGr1ivgRCs
	 cMV2vKDG7KrB/1tmHmgDy3XHxegv3uKOtryNZNGk/IJST0srzyA8yyQnXXH5/YXtzf
	 IB2w1OfdPTIilc5Bm/EV44tt6Pxn+tWP3vhZf8AFImr56KqOKgxRPcZZqRTi+yGy7s
	 T8QDRgSsLww6A==
Date: Wed, 16 Apr 2025 14:25:22 +0200
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
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 11/15] rust: cpufreq: Add initial abstractions for
 cpufreq framework
Message-ID: <Z_-hskVtNFPxUmlC@pollux>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
 <ac6854885277b23f100c6033fab51a080cdb70eb.1744783509.git.viresh.kumar@linaro.org>
 <Z_904KuBhKbO738_@pollux>
 <20250416093720.5nigxsirbvyiumcv@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416093720.5nigxsirbvyiumcv@vireshk-i7>

On Wed, Apr 16, 2025 at 03:07:20PM +0530, Viresh Kumar wrote:
> On 16-04-25, 11:14, Danilo Krummrich wrote:
> > On Wed, Apr 16, 2025 at 12:09:28PM +0530, Viresh Kumar wrote:
> 
> > > +    pub unsafe fn data(&self, index: usize) -> u32 {
> > > +        // SAFETY: By the type invariant, the pointer stored in `self` is valid and `index` is
> > > +        // guaranteed to be valid by the safety requirements of the function.
> > > +        unsafe { (*self.as_raw().add(index)).driver_data }
> > > +    }
> > 
> > Those three functions above look like they're supposed to be used directly by
> > drivers, but are unsafe. :(
> > 
> > It looks like the reason for them being unsafe is that with only the pointer to
> > the struct cpufreq_frequency_table array we don't know the length of the array.
> 
> Yes.
> 
> > However, a Table instance seems to come from TableBox, which *does* know the
> > length of the KVec<bindings::cpufreq_frequency_table>. Why can't we just preserve the
> > length and provide a safe API?
> 
> The Table is also created from a raw pointer, when it is received from
> the C callbacks. Also the Table can be created from the OPP table,
> where again we receive a raw pointer from the C code.
> 
> I tried to do this differently earlier and finalized on current
> version after some discussions on the list:
> 
> https://lore.kernel.org/all/2025011327-cubbyhole-idealness-d4cc@gregkh/

I skimmed over your explanation from the link and got stuck at:

> - The cpufreq core then calls cpufreq driver's callbacks and passes an
>   index to the freq-table, which the drivers don't need to verify
>   against table length, since the index came from the core itself.

This sounds like you could just abstract the index passed through the callback
in some trusted type (e.g. cpufreq::TableIndex) and let the cpufreq::Table
methods take this trusted index type, rather than a raw usize, which would also
make the methods safe.

- Danilo

