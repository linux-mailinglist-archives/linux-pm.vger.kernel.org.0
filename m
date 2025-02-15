Return-Path: <linux-pm+bounces-22148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4FFA36D24
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 10:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667F83B1410
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091B11A08B8;
	Sat, 15 Feb 2025 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8MY28WN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D55194A75;
	Sat, 15 Feb 2025 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739613372; cv=none; b=uxzrt+1d71oXdTKd3esnAya5SvSF/JWpgUAmBIcvH93Dvaz1W0s7HW8hQ2kYq6fVm8JFdUzxjrDiPKp6Hm4+j1VQNoPuFjBCvceVhZXEAuRUR64+letAzKxdO/1u/DHv6ADAzW8MktNEM1ipTO1yKKQwWARDBvTPlyuKlx4tf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739613372; c=relaxed/simple;
	bh=PDXxTjSHcNovs90NenL3yq3grvygHWpMIcQJRui2vF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GnU3aOzZhR0sxE5Qw6EcPxyBlK5gxeAUVN+CXPKN6zmIBy1NvmH1k20dwbIIbRJEvAVqYHZ8sxA7qg0IhhzojOWYNSBQPHQsHGHpJeRyUAHaUYYLgazA5blJxb5RyUdGyEuIniA/sTfZd8xHcft8RgkHomdiNyS6WDt3B2+kcQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8MY28WN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55100C4CEE7;
	Sat, 15 Feb 2025 09:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739613372;
	bh=PDXxTjSHcNovs90NenL3yq3grvygHWpMIcQJRui2vF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B8MY28WNxij960KIhHpXPZBcui8oLrabQ393VYeI0DubgXVbtiOWftxNgkVfGTrvF
	 RhYgpfJtBmmFllLeo+IisN4oP4KO/ZToWuqYr2KFvvVaUHvcNzxqSRn2bz00kYrWx3
	 hB5Ns15O+YSquJ4Nu1ntTIE0F/eqtcUdwxdigBC9/noGtXgvDDCjKCm26kj+BfY2vm
	 53s07ghKuFO4oAe/ELWhQ2ivvIIKii4XjHHcvCU03G8pEhqC9DfpOWnUyoTgjqF5jQ
	 5itZKCMh+qQFt1pvCZ6pdoPC9tGNuPDB1n0Zp2eX/2tBBRKOgddn/UFVA48irGk5V9
	 BDPZb8oZX+UZA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>,  "Yury Norov"
 <yury.norov@gmail.com>,  "Viresh Kumar" <viresh.kumar@linaro.org>,
  "Rafael J. Wysocki" <rafael@kernel.org>,  "Danilo Krummrich"
 <dakr@redhat.com>,  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Rasmus Villemoes"
 <linux@rasmusvillemoes.dk>,  <linux-pm@vger.kernel.org>,  "Vincent
 Guittot" <vincent.guittot@linaro.org>,  "Stephen Boyd" <sboyd@kernel.org>,
  "Nishanth Menon" <nm@ti.com>,  <rust-for-linux@vger.kernel.org>,  "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>,  "Erik Schilling"
 <erik.schilling@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
  "Joakim Bech" <joakim.bech@linaro.org>,  "Rob Herring" <robh@kernel.org>,
  "Christoph Hellwig" <hch@lst.de>,  <linux-kernel@vger.kernel.org>,  "Uros
 Bizjak" <ubizjak@gmail.com>,  "Greg KH" <gregkh@linuxfoundation.org>,
  "Philipp Stanner" <phasta@mailbox.org>,  "Jens Axboe" <axboe@kernel.dk>
Subject: Re: [PATCH V8 04/14] rust: Add cpumask helpers
In-Reply-To: <CANiq72mFKNWfGmc5J_9apQaJMgRm6M7tvVFG8xK+ZjJY+6d6Vg@mail.gmail.com>
 (Miguel
	Ojeda's message of "Fri, 14 Feb 2025 23:36:57 +0100")
References: <cover.1738832118.git.viresh.kumar@linaro.org>
	<db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
	<Z6qTelPSqpFk439l@thinkpad> <20250211042908.nyftiw7gtxosfjwc@vireshk-i7>
	<Z6t51xodSV21ER4M@thinkpad>
	<CANiq72=3MR9F9ur-aQYP4P81RBreAr=UiGg5iaSuFjjd5Q4Y7Q@mail.gmail.com>
	<Z66oWuLwY4X9Ou9D@thinkpad>
	<CANiq72=Yy8e=pGA+bUHPZhn+D66TmU3kLSjAXCSQzgseSYnDxQ@mail.gmail.com>
	<20250214191103.GH3886819@nvidia.com>
	<CANiq72=tDhUEjdBmVTPv4cFeD8iiKwJAQD3Cb1=Y4KnE-vh2OQ@mail.gmail.com>
	<20250214210637.GK3886819@nvidia.com>
	<8p3qXjy6QKTkpYaevmoORFfiyI62sFFSA6aKjoTlE2aGlLMCyLQXwpnag5qhXBFSa5PojMZrN-mLYKu29TyYIQ==@protonmail.internalid>
	<CANiq72mFKNWfGmc5J_9apQaJMgRm6M7tvVFG8xK+ZjJY+6d6Vg@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 15 Feb 2025 10:55:53 +0100
Message-ID: <87frkfv8eu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Fri, Feb 14, 2025 at 10:06=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com>=
 wrote:

[...]

>> As a side note, I don't see how anyone can enact this plan without the
>> support of Linus to do CONFIG_RUST=3Dn builds and put out a non-working
>> rc1. IMHO it is yet unclear if this is real thing or an unproven idea
>> block has that will run into problems.
>
> Please ask Jens and the block layer -- Cc'ing Jens (Andreas and Boqun
> are already Cc'd):
>
>     https://lore.kernel.org/all/593a98c9-baaa-496b-a9a7-c886463722e1@kern=
el.dk/
>
> Having said that, I am not sure what you mean by -rc1. It is in the
> context of a friendly collaboration -- I assume the intention is that
> Andreas et al. are given enough lead time on new features to fix them
> before the merge window. For fixes, it may be harder, of course. Other
> ideas: they may be able to config out certain parts too; or in the
> worst case, in an emergency, Linus may decide to break Rust. They may
> be able to tell you the details of their plan.

Maybe I can help move the discussion forward by describing how we do
things in block.

In block we (the block subsystem community) currently have the rule that
rust code should not delay shipping a PR. I am not sure how Jens will
enforce this, but I could imagine that if builds start failing by the
time a PR has to be submitted, Jens would just yank rust block code. And
so no fallout of this would reach Linus.

Of course, there may be situations where problems do not surface until
Linux is merging things, but for this to happen without these issues
first appearing in linux-next would be extremely unlikely.

Maybe having a config option to disable rust block might be a good idea,
to prevent the yanking if it ever comes to that.

In practice, we never had any issues. Things have broken a handful of
times, but I usually see it within 24 ours and then I am able to send a
fix.

I can't imagine that Jens has been forced to spend a lot of cycles on
this, outside of applying a few fixes now and again. It would be
interesting to know how much the workload has actually been for him.

Anyways, it is my hope that within a few years, rust will become a fully
qualified citizen in block, and the special rule can be dropped. This of
course requires Jens becoming able and willing to handle rust related
issues himself, or him becoming confident that the current arrangement
will suffice for solving any rust related issues.


Best regards,
Andreas Hindborg



