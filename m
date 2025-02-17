Return-Path: <linux-pm+bounces-22192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D0BA37EE4
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 10:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953D07A35FC
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 09:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544642165E2;
	Mon, 17 Feb 2025 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Zv5AOoK4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F152163BA;
	Mon, 17 Feb 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739785540; cv=none; b=k9mTBmLMaCg6RBkdm9YSdtpMziTUzWwbrCu4nQICtRGk0uIyKPOgl7j9GOq7uPFlnkiReyj1GCAXd8K/1AlnTuvMoc9oy1XsCXrbVnILSWMIctT/fkR+R2vhPYzsUdhifMTlQYnCL2euT34PsKuoZ1iTXVd4iHYZubYkm7UUqK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739785540; c=relaxed/simple;
	bh=dfy2ywxbm9ZJJb1F36/6VsBddiXxecHJPPozdX/dwZI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mCy4eDYUiEPM4brm28MGVH7KJzpgZj5sf9pdZLqtbmEQuw1W/2J+89ekxCzXU46Y2TjN11S86p5RUYijGgXgnY6HNs95AiCvIj1UOwtphNSe1vHpab6GI21NAOYJW/Wy29kW+d+h7WRaWDLhCCt0YgDtEJjb9BZp3IrURroM+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Zv5AOoK4; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YxHnz0xy7z9sc4;
	Mon, 17 Feb 2025 10:45:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1739785527; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfy2ywxbm9ZJJb1F36/6VsBddiXxecHJPPozdX/dwZI=;
	b=Zv5AOoK4F+wgFhT65eRzIy1aLRnffHEfrQI0Njsj80Pp/TcjLFOUNPIXpF6ItFWQsF4FDz
	GiBnRU8B+nr3/xur/sFDrTZ420NHsCW0ypgi1VHrmrJhPbQoPceXV5/fP66sEisdepUw+E
	w+Za99O287mBh8nbNTrr6N3mJJkBV5aeBwPiCWbcHngkSvIzqUrbwwT4GEjR3aw560yo4D
	RdyiV8ZjjrMiLUMBtdBPdyZZCygZaX3xWlf4P1fk7q58sz17o5c8G3Jbp5kPeJhTZZmtR0
	PpnbG8skJxBRtPswxrz3lrcmqnazlqeiws37kHvqTHuRAbn3Xz2YBL8o8RVZqA==
Message-ID: <55a58a606cbd2afd86f83a89b9843e8c7d88c9f6.camel@mailbox.org>
Subject: Re: [PATCH V8 04/14] rust: Add cpumask helpers
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Jason Gunthorpe <jgg@nvidia.com>, Miguel Ojeda
	 <miguel.ojeda.sandonis@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Viresh Kumar
 <viresh.kumar@linaro.org>,  "Rafael J. Wysocki" <rafael@kernel.org>, Danilo
 Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>,  Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
 Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
 rust-for-linux@vger.kernel.org, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Erik Schilling
 <erik.schilling@linaro.org>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, Rob Herring
 <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org,  Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 17 Feb 2025 10:45:17 +0100
In-Reply-To: <20250214210637.GK3886819@nvidia.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: srr8d9hbx4hrod39prc91hgogotwtthr
X-MBO-RS-ID: c04db6c564b3c4e7acd

On Fri, 2025-02-14 at 17:06 -0400, Jason Gunthorpe wrote:
> On Fri, Feb 14, 2025 at 09:24:31PM +0100, Miguel Ojeda wrote:
> > On Fri, Feb 14, 2025 at 8:11=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com=
>
> > wrote:
> > >=20
> > > Sure, but it was said, by many people, many times, that "Rust is
> > > allowed to break".
> >=20
> > A lot of people have said many things (especially in online fora),
> > and
> > many of those things are contradictory, but that does not really
> > mean
> > anything.
>=20
> We don't have a community where there is a clear authority
> structure. If lots of people are repeating a thing, that thing
> usually
> becomes the consensus and common viewpoint regardless of who
> originated it. The repetition reflects community agreement and buy in
> of the idea.
>=20
> At the end of the day, only the policy adopted by the people merging
> patches really matters.
>=20
> The assumption being if respected people speak with authority on a
> policy they have also got buy in from the people responsible to
> execute it.
>=20
> I also think you should merge your policy document to the tree, not
> keep it on a web page. That seems to be a big part of getting
> community agreed policy adopted.
>=20
> > Finally, ambiguous terms are used in many cases to refer to
> > different
> > parties: "Rust community", "Rust people", "Rust team", "Rust
> > maintainers"... I have started to ask people to avoid doing that
> > (at
> > least in the LKML), please, and be concrete if possible.
>=20
> Okay, that makes lots of seense. Please don't use "we" as well.. I
> have no idea who is included in your "we", or what to even call it.
>=20
> > > And Greg's version:
> > >=20
> > > https://lore.kernel.org/all/2025013030-gummy-cosmic-7927@gregkh/
> >=20
> > I cannot speak for Greg, sorry.
>=20
> Yet he does seems to be speaking with authority on this topic. His
> message was quoted on LWN and likely was read by a large number of
> maintainers.
>=20
> Is he not part of your "we"?
>=20
> > I can read his message in the following ways:
>=20
> I think it was very clear, sorry, I don't read it your many ways at
> all.
>=20
> > =C2=A0 - I can read it as a general ability of subsystems to potentiall=
y
> > agree to treat Rust code as something like staging, like block's
> > plan.
>=20
> As a side note, I don't see how anyone can enact this plan without
> the
> support of Linus to do CONFIG_RUST=3Dn builds and put out a non-working
> rc1. IMHO it is yet unclear if this is real thing or an unproven idea
> block has that will run into problems.
>=20
> > It is very hard to keep hundreds of maintainers on the same page.
>=20
> It is, but also I think you need to take this challenge to succeed.
> =C2=A0
> > > I do not agree with "Didn't you promise Rust wouldn't be extra
> > > work
> > > for maintainers?" in your document. Clearly there is a widespread
> > > belief this kind of promise was made, even if it was never made
> > > by
> > > you. "Rust is allowed to break" is understood to be the same as
> > > saying
> > > it won't cause extra work.
> >=20
> > Sorry, but I have to strongly push back against this paragraph.
> >=20
> > Are you really saying that, because people out there may think
> > something, we cannot claim anymore that we did not promise
> > something?
>=20
> Again "we" ?
>=20
> I'm not concerned about "people out there". Greg said it. Others who
> I
> would think are part of your "we" have posted it on LKML.
>=20
> It is not clear at all. If you said Miguel never claimed it, then I
> would not complain. You said it correctly above, be concrete. Ideally
> acknowledge there were different policy ideas in wide circulation,
> but
> they did not get adopted.
>=20
> > Furthermore, I don't agree with your assessment in your last
> > sentence
> > at all. Even if it was decided to allow Rust to break globally and
> > at
> > all times, it does not mean Rust is not extra work.=20
>=20
> I appreciate this point is realistically true, but look at how
> Philipp
> presented this 'no break' concept to Christoph as a no-work option
> for
> him.

Hello,

so to clarify that: I'm (currently) not writing or maintaining any Rust
abstractions. So I'm not representing official projects, so take the
statement for what it's worth. I mainly wanted to probe how an
agreement with Christoph could have been worked out.

My main point still holds up, though:
The rules should be written down. In tree, in linux/

As you, Jason, also state, this would enforce a discussion leading to
more clarity.


>=20
> My main point here is that I'm glad things are getting straightened
> out, some of the conflicting policy ideas shot down, and the demands
> on maintainers are being articulated more clearly.
>=20
> > That is good, but to be clear, from my point of view, the approach
> > mentioned in the document I wrote is what we have always said.
>=20
> There is another we :)

The current, apparent, distinction between Rust and non-Rust kernel
engineers might indeed be a symbol for an underlying big question. 10
years down the road, will there still be "Rust people" who take care
of=E2=80=A6 the compiler? The abstractions and bindings? Are there "Clang
people and GCC people" currently, too?

That question goes deeper than one might think, because it's ultimately
about who maintains what and, as we already discussed, who can break
what. If, in the mid-future, subsystem maintainers uninvolved with Rust
couldn't merge changes that break Rust anymore, that *might* de facto
indeed lead to them having to learn that language. Or everyone would
need a Rust-proficient co-maintainer who can deal with those breakages;
or similar solutions.

So that's why I think clarifying it rather sooner than later is
necessary.


P.


>=20
> Jason
>=20


