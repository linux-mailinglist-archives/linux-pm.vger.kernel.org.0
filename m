Return-Path: <linux-pm+bounces-21845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C0EA31131
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 17:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4DAB7A11D6
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7C9253F01;
	Tue, 11 Feb 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQcQPNoj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F72505C8;
	Tue, 11 Feb 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291099; cv=none; b=ptHvQqQg39aFEQ1e7ixqF3JD5kYA7Hwhbo6mOo8VJsVb1jb+LiP+s2jReJrNT5BywzRCP+7WNt9YV0hI6w5i9cXNaj0eHmXnY6kscsx99X5QiCLCQJ2m+nIIKMuYyjDsUwfnvHwq5r0U4KDGFIXQymXrQ/c5Wn7AKQjvm51di9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291099; c=relaxed/simple;
	bh=fgt56ktJmlvYAbXm5sV+4Qtv71HymWGmUAaPDCI3QlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMyCTyPEdnmZoCFI5E2uSsIvdFkpKldQupu/R5dL+NqnPyD6lsscrnR8l29iDqELsPjiPzzemCo5NZVoXXRtnNs/u4gO3tOHnIw6TdqtjsMQFaqPiQFHa5RIaq6QhwjZnyjBu8nGfGibANLUP83ergkswwTymk79Yt51D18nbdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQcQPNoj; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f754678c29so51452977b3.0;
        Tue, 11 Feb 2025 08:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739291097; x=1739895897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4v8f6HeSnLZ4UkzrHQLgY8GnoqjOuKRQP5rAHwP5pW0=;
        b=DQcQPNoj3Hby2/sH+6m8jiSoONmc4bsFhWRpF+9TAHWi4OSvjD9+PRlz7nDFQ3HpUa
         IgoWjdCO3c3DCkiN8sIcEDULBJ57pSxTfwAE8gZwAdHu0n+hghnKx/nuFCt3/WhgEDLE
         rqP34jh6TbNxteROaW4v9XenaulLXyz4o5jIEDLvWSuCeSHkJaaizqJE0uKCwnd9+o1H
         f9tQnkrthlVdxWIVxmZHCUa/kLRC4V0+yeEn2u7vJJPFVNC22/8incE/qX1QBYmOWnp9
         PTBGrAaAMbShDiK0FaqwQC19tnDvVLtg3Z4c5R5dCYj41BJIc1C07J3cWgKq5WYld1Cq
         ByaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739291097; x=1739895897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4v8f6HeSnLZ4UkzrHQLgY8GnoqjOuKRQP5rAHwP5pW0=;
        b=vF3wp4TcFOpmrvVQdy7EUQViGQRMlVvuGLUHkVqCoYKxtirZ6cKkfDnbLKpoEE85/q
         n14EuD403g4cCCSNTy2gWlATRKe92a+mAETcnC8+lgGt8j147h8avLKNhucvwfNOtEjb
         zoNK7MrgcmG6i/NGPeBX6BY7VyibreZMHRl9jg0dVq56UfzJ6KT1mUFgZYKShDZL9ZbT
         +7DQVP9tTzMtaGxnFPQhssGq4/RVaYjPt6Ha7EnIaW3WsdYiT4mQMvyixUy4Ffxn4g5M
         8evZiltSwCxuou4tUJS9n9heonN+P4SLXs0oKNgHRVGgt6bxFVtrtSbt6tcwhypNv/tS
         I2wA==
X-Forwarded-Encrypted: i=1; AJvYcCU40ISGWO/RiYNLKOIMFGZQgiMw187yqQvWemE+GIfiwftU1t2LqOHlcDG5yf5LORvylkY9aWjF/BU=@vger.kernel.org, AJvYcCVnxmWXGZOq9XJUUrBNjNisUkStscD74tvFmNOwQqz0qeZTKQi0Gt60osUVtX27Coh6mKepk2CFlHY+SYY=@vger.kernel.org, AJvYcCVwuDp+3aCeNsgA/7wkCFNxBeKRtgBZiVbfc6zObD9dlkYkhtByZEkZ5LQmO3l8K1RUIlBLoBjcJGUqIi0N42k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsMp72RHlKKSZIVKMWvttwywxj7qa0Yt/QHxj/w1nHQx/UzKsF
	x+lHdawsfPQSlHbGNk4fQe4+CHwk4VV2LF33NtU7Ea8XU+MHl80BqHRcR/Pi
X-Gm-Gg: ASbGncsIf94+kBkjbPsXi8tyyGd6bJGzpn1iRDir2gk0RknwmZ3rOUCXkASprlAiWw9
	o5FLE3XCJ/DeNFFbgtzeH9BHDfsPwLksFsALx4PQaFnyc6tCD9MG++l9lJf5Ir3pQo4WVTSiJgS
	vtA0pk4jVOVueNnpFvCVmYYPlH+IKGyKUstaqrZoRddAdKNiYIVig+50cEhkhfTMIaItH/f/vYQ
	W5PTbd0nXxPZYe1rdzCDNVt67lAU4DiiNv9YvA3Kb+gYA4ifikafpwZ7TllPf58792FNKTVepCE
	Ph/oqGfZ8vXnXVQpFFRVn+TTOmlqTO6uy9/4icH4yqMgQhu/d7A=
X-Google-Smtp-Source: AGHT+IGiqX6OW2GEGKLh5MRa1NI+yVJdcevPfSSgbI6OLmV4SJcZxFsPyJ9dAzL7IwYspmBAWCx1cw==
X-Received: by 2002:a05:690c:63c6:b0:6f9:a3c6:b2e4 with SMTP id 00721157ae682-6fb1f2b7197mr1588187b3.37.1739291096554;
        Tue, 11 Feb 2025 08:24:56 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fa130ba279sm10767827b3.106.2025.02.11.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:24:56 -0800 (PST)
Date: Tue, 11 Feb 2025 11:24:55 -0500
From: Yury Norov <yury.norov@gmail.com>
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
Message-ID: <Z6t51xodSV21ER4M@thinkpad>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
 <Z6qTelPSqpFk439l@thinkpad>
 <20250211042908.nyftiw7gtxosfjwc@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211042908.nyftiw7gtxosfjwc@vireshk-i7>

+ Jason, Christoph

On Tue, Feb 11, 2025 at 09:59:08AM +0530, Viresh Kumar wrote:
> On 10-02-25, 19:02, Yury Norov wrote:
> > On Thu, Feb 06, 2025 at 02:58:25PM +0530, Viresh Kumar wrote:
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index ee6709599df5..bfc1bf2ebd77 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4021,6 +4021,7 @@ F:	lib/cpumask_kunit.c
> > >  F:	lib/find_bit.c
> > >  F:	lib/find_bit_benchmark.c
> > >  F:	lib/test_bitmap.c
> > > +F:	rust/helpers/cpumask.c
> > 
> > Sorry what? I never committed to maintain this thing, and will
> > definitely not do it for free.
> > 
> > NAK.
> 
> Okay.

No, not Okay.

To begin with, this is the 8th version of the same patch, but you
only now bothered to CC someone who is listed in MAINTAINERS. This is
not how the community works.

You also made it a patch bomb that touches multiple critical and very
sensitive subsystems. You link them to an experimental and unstable
project, and do it in a way that makes it really easy to slip through
maintainers' attention.

Not speaking for others, but please for cpumasks create a separate
series and start thorough discussion.

> I will add a separate entry for Rust cpumask stuff.

That would make things even worse. Before you wanted me to maintain
rust linkage. Now you want me to get approval from someone else who
maintains rust linkage. In case I need to change something, I want to
be able to just change.

I went deeper into the subject, and found that rust team has similar
problems with other maintainers:

https://lore.kernel.org/lkml/20250108122825.136021-3-abdiel.janulgue@gmail.com/

I'm particularly concerned with the following comment from Jason
Gunthorpe:

  All PRs to Linus must not break the rust build and the responsibilty
  for that falls to all the maintainers. If the Rust team is not quick
  enough to resolve any issues during the development window then
  patches must be dropped before sending PRs, or Linus will refuse the
  PR.

https://lore.kernel.org/lkml/20250130154646.GA2298732@nvidia.com/

And that happened at least once, right?

I don't expect that the functions you export now will get changed
anytime soon but it happens from time to time. cpumask_next_wrap()
is one recent example.

https://lore.kernel.org/netdev/20250128164646.4009-7-yury.norov@gmail.com/T/

The more drivers you write, the more functionality you will inevitably
pull. And the risk that something will get broken one day will grow
exponentially. So before we move forward, please explain in very details
how would you act in a scenario described by Jason?

Do you proactively run builds against development branches? If so,
please add my bitmap-for-next.

https://github.com/norov/linux/tree/bitmap-for-next

Have you considered creating a conftest, so that if rust fails to build
against the current kernel, it will get disabled until you fix the
issue?

Maybe you will just teach your language to understand inlines, and
that's it? Does it understand macros?

Thanks,
Yury

> > > +#ifndef CONFIG_CPUMASK_OFFSTACK
> > > +void rust_helper_free_cpumask_var(cpumask_var_t mask)
> > > +{
> > > +	free_cpumask_var(mask);
> > > +}
> > > +#endif
> > 
> > This is most likely wrong because free_cpumask_var() is declared
> > unconditionally, and I suspect the rust helper should be as well.
> 
> Non-trivial C macros and inlined C functions cannot be used directly
> in the Rust code and are used via functions ("helpers") that wrap
> those so that they can be called from Rust.
> 
> The free_cpumask_var() function is defined as inline only for the
> CONFIG_CPUMASK_OFFSTACK=n case and that's where we need this wrapper.
> For the other case (CONFIG_CPUMASK_OFFSTACK=y), Rust code can directly
> call free_cpumask_var() from the C code and we don't need this helper.
> 
> > Please for the next iteration keep me CCed for the whole series. I
> > want to make sure you'll not make me a rust maintainer accidentally.
> 
> Sure.
> 
> -- 
> viresh

