Return-Path: <linux-pm+bounces-21850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D754CA312EB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 18:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CB51886C62
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 17:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAB826215A;
	Tue, 11 Feb 2025 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBrQx2h3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC3262152;
	Tue, 11 Feb 2025 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294883; cv=none; b=TRKTZXuBtrJigYGsV3rNzrMykcDlapVJq4T/WS7MyCtBqMyTj5VnmHK0YEv5bryp/UKcWcu4heiIYCs0AUI34Zhb99TEy5SU0pr3am0WynF1dk2TbIjNHkisjVf3B3lo3GvEmaESK2C/EQSuy3QGrsG0zBjkEDJsPuGcsoZi0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294883; c=relaxed/simple;
	bh=NddH0pkxZWe9E2BuTZtR2bE6TlVPCcuHwM6y+KM9BA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nya2IDlaYa8QYM9oGl6PCu5nOcoMLH3C3v4x4jqhorSwVqSyYYb5RbQz44ELvW860LdLhdA9XXq2TL5Pu8Bkjen2WgdvCrRanzIQXAVI4mzNZ8IHMXOUEBHcXfpbNR+fI29TwGBQ3WDkkrAg+9GL6rDaTwb/pKH0SGHcPXArFuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBrQx2h3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1044EC4CEDD;
	Tue, 11 Feb 2025 17:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739294882;
	bh=NddH0pkxZWe9E2BuTZtR2bE6TlVPCcuHwM6y+KM9BA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBrQx2h3jicMJM1SPW6/fLau90JPmb1GNG1ajhMgiNldTP0+DP4vDxK9l/SvqE0+Q
	 8QO8ese1OhzYvU9Fj5IkmkzL8vy7Lo6ffmv5cfVIBfk8oG0C5ZjIY6L4nUeqAkP9DT
	 rUgMR9E8BR6B8E9cpv97P118YM9xzqEVj5iVZMXeZWW7J9AcFUbd1EpU/UvxOZR+z9
	 xvuob0gKx8VLDx0YbpkGNNoehd11HjHSceewp1VA1DTPoVJX5lsWYrRCDyEFvVlNh4
	 IWWKh7N0PrUzofo75YHCqwMweBJuV5LZ0ABsP2zkwdmi+QBJD7//iT2hsWm3IhXKMu
	 DRGIHWh8Cjt8Q==
Date: Tue, 11 Feb 2025 18:27:54 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
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
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 04/14] rust: Add cpumask helpers
Message-ID: <Z6uImtVQpVGrCGnj@pollux>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
 <Z6qTelPSqpFk439l@thinkpad>
 <20250211042908.nyftiw7gtxosfjwc@vireshk-i7>
 <Z6t51xodSV21ER4M@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6t51xodSV21ER4M@thinkpad>

Hi Yury,

On Tue, Feb 11, 2025 at 11:24:55AM -0500, Yury Norov wrote:
> + Jason, Christoph
> 
> On Tue, Feb 11, 2025 at 09:59:08AM +0530, Viresh Kumar wrote:
> > On 10-02-25, 19:02, Yury Norov wrote:
> > > On Thu, Feb 06, 2025 at 02:58:25PM +0530, Viresh Kumar wrote:
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index ee6709599df5..bfc1bf2ebd77 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -4021,6 +4021,7 @@ F:	lib/cpumask_kunit.c
> > > >  F:	lib/find_bit.c
> > > >  F:	lib/find_bit_benchmark.c
> > > >  F:	lib/test_bitmap.c
> > > > +F:	rust/helpers/cpumask.c
> > > 
> > > Sorry what? I never committed to maintain this thing, and will
> > > definitely not do it for free.
> > > 
> > > NAK.
> > 
> > Okay.
> 
> No, not Okay.
> 
> To begin with, this is the 8th version of the same patch, but you
> only now bothered to CC someone who is listed in MAINTAINERS. This is
> not how the community works.

I'm answering, since I was involved in the discussion you refer to below, but
please also let me add a few other thoughts from my side.

First of all, I think you are right here.

AFAICS, the cpumask abstraction was added to this series in v6, and you were
CC'd in v8, which is *not* OK.

I also agree that this definitely deserves it's own series for you to be
properly involved.

> > I will add a separate entry for Rust cpumask stuff.
> 
> That would make things even worse. Before you wanted me to maintain
> rust linkage. Now you want me to get approval from someone else who
> maintains rust linkage. In case I need to change something, I want to
> be able to just change.

I think the decision is up to you, whether

1) You want to maintain it on your own.
2) You want a co-maintainer / reviewer that takes care of the Rust parts.
3) You want nothing to do with it and have it maintained as a separate
   component.

In case you prefer option 3), please do *not* see it as "you need to get
approval from someone else for code changes in your subsystem", because no ones
wants to impose this on you.

Please see it as just another driver or another component that makes use of the
API you maintain.

If you are running into API changes that affect the Rust abstraction, that's
where you can refer to the maintainer of the Rust abstraction to help out. Just
like with every other driver or component that uses a core API, which isn't
trivial to adjust.

> 
> I went deeper into the subject, and found that rust team has similar
> problems with other maintainers:
> 
> https://lore.kernel.org/lkml/20250108122825.136021-3-abdiel.janulgue@gmail.com/

I don't think that this case is similar to the one you linked in. I think you
were indeed a bit bypassed here, plus you seem to have a real concern with
maintainership, which I think is fair to be addressed and resolved.

I hope my reply already helps with that.

- Danilo

