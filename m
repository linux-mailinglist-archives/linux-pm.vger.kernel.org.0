Return-Path: <linux-pm+bounces-27392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838E0ABCF07
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 08:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCE1167E86
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 06:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B4525C80A;
	Tue, 20 May 2025 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astier.eu header.i=@astier.eu header.b="UK1dKBGl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kXV3Z0ps"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B77825A334;
	Tue, 20 May 2025 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747721645; cv=none; b=CJitSo6o56Tf4nadOo1reCKiPxDvMVP0eK/wSH9Ih8KP++ifcKrIzM9wF1muVIotIX1U7PQGQbeTX2jPlHxWFFXobxlXqzl1j4tOUVimb7eMkUYEtwcmyt0XhyyyMRKwJ6yla6kldZgrE/OReCMOJgVqCcCxtHATMOLWKwc/tCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747721645; c=relaxed/simple;
	bh=sfOGzBxbmYxrpTmsmk9iA7kI+4GcUiAg7Ev+d64vRxA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UstwmppSmTF0q2myh9EN/kTRoSfGfXdEcYqN7OIaAg9m3VfCGSd9GXLP2swUPPa0Huc6V7LFvlzPbx1WEP80hbqLQxiCKJvK2C4a+Q7KIB4L6xjUZAnYCqWOM4BvceJO4itVWT2keQeXGQljkFZMlSFF+2pouW5Xqr2dW25ty3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astier.eu; spf=pass smtp.mailfrom=astier.eu; dkim=pass (2048-bit key) header.d=astier.eu header.i=@astier.eu header.b=UK1dKBGl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kXV3Z0ps; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astier.eu
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6119F2540156;
	Tue, 20 May 2025 02:14:00 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 20 May 2025 02:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=astier.eu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747721640;
	 x=1747808040; bh=ebCCwKl+ctIjs3xdVcCquO8ccEzo9gT00bMAJW9tR3k=; b=
	UK1dKBGlOE/nPbSFz2w4NVz0qzvvRxtPLIANPfir872v6f8QPbeybw8fzi0JeWj4
	vnalmJl4JpaBJSrU3Z2FkdoQyOephsDTEdjqhfkX8Vb8tMta+dcg7LhphfWbhf7a
	akyJcLx5Ehiq6iXJIEeOtQUnM1hm8V3GsHdS4mZKqJlFlKeYqhycgERZpMRCwwiy
	zI0iHMLipA4FCU5uJc7ER6HPVfylazaud6VKL7eLLsvS4szv4V9+/aRpb5XzJMky
	XAGTJjplkAKqCVkVpWheHRepDybx53LwpLxYKjuHlni+OAymlLhxZ63aeYf54OO+
	RtyyzPdKSTSO7ItH29fL9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747721640; x=
	1747808040; bh=ebCCwKl+ctIjs3xdVcCquO8ccEzo9gT00bMAJW9tR3k=; b=k
	XV3Z0ps9QdyShz3WgtdZTFTNx4ZS/RgqjBNiy8fn05lQc2cyOiqvTR7QxmGDCtaR
	e167ALUh3QZg2+lJUz1Tjykr9PcflQK0S/bz1gnQBWbfUfwLIzGYgoDQBdb++iL7
	LK1rIM/qpRVRO/kxvMTJkNdswhrWfIOO3NL9KlAklw9zinyzdvRjRBhmoBBN9fNK
	0ge2wA5diNZtojP2miy8fSnwY7SjHBjebJVzG83b0+zz1aXYVeB9/RNqvQuyftGI
	ei+Z4LUZAYNPNjd/s40uTGFzdQNPUXU3AHYWSeLA6pbejnK0XU5IIyoqTCPmXktR
	dNA1ffpfGnsdmLM99D0sw==
X-ME-Sender: <xms:px0saFY933IyeKEWYu3XuDcC-SGiR6bNl4iLz_M7NuHdPfvXkjllOQ>
    <xme:px0saMZ9ZuGp5gd440aUHBHelMRvH5_nWuDdlHln6mDWgYxZ0oLQlKhRejnK0tbX2
    z0FaoDXmVVF2IoGz38>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdefheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedftehnihhsshgvucetshhtihgvrhdfuceorghnihhsshgvsegrsh
    htihgvrhdrvghuqeenucggtffrrghtthgvrhhnpeekvedutdeghfevfeevjefhvdfhtdeh
    teetfedvgfdvffefveeufeduueethfegfeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrnhhishhsvgesrghsthhivghrrdgvuhdpnhgspghr
    tghpthhtohepfedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigse
    grrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepmhhtuhhrqhhuvghtthgvsegs
    rgihlhhisghrvgdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
    dprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheprghnughrvgifjhgsrghllhgrnhgtvgesghhmrghilhdrtghomhdprhgtphhtthhope
    gsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehmihhguhgvlhdr
    ohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhmpdhrtghpthhtohephihurh
    ihrdhnohhrohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlihgtvghrhihhlhes
    ghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:px0saH_Ji6vuSbgAkP2LDvb94v-U3vk5LgRfgazc5HYIcqfC-vpOMA>
    <xmx:px0saDpRhMm_Nx09JgSroPL-Ur1A8wMHKD2-6mLWZMjOv-38Pdxqpw>
    <xmx:px0saAp2DBjw2SBZMd8AmMDJB34Elb9ERuvq7RqLGbtGWH-yQMuOQQ>
    <xmx:px0saJTaeW3h9Vhf5t5KvcchACqLnVj3EhG2N4j48qFuWAFl1aTvJg>
    <xmx:qB0saEPbiwR3t4qKp0RzcC6tYAfavsmtt2bjyqVbRFtLP3L5rEOWCj73>
Feedback-ID: iccec46d4:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4EE4B700060; Tue, 20 May 2025 02:13:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tc582061166103edd
Date: Tue, 20 May 2025 08:13:09 +0200
From: "Anisse Astier" <anisse@astier.eu>
To: "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@redhat.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, linux-pm@vger.kernel.org,
 "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Stephen Boyd" <sboyd@kernel.org>, "Nishanth Menon" <nm@ti.com>,
 rust-for-linux@vger.kernel.org,
 "Manos Pitsidianakis" <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Joakim Bech" <joakim.bech@linaro.org>, "Rob Herring" <robh@kernel.org>,
 "Yury Norov" <yury.norov@gmail.com>, "Burak Emir" <bqe@google.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Russell King" <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Andrew Ballance" <andrewjballance@gmail.com>,
 linux-kernel@vger.kernel.org
Message-Id: <e8a404b2-4ec6-4e1d-a973-15684676e870@app.fastmail.com>
In-Reply-To: <20250520043355.wjkrslnripaqj6mm@vireshk-i7>
References: <cover.1747634382.git.viresh.kumar@linaro.org>
 <21b4c30db60f22d56cc6386a18564705ad3a6f4a.1747634382.git.viresh.kumar@linaro.org>
 <CANiq72mNHYKXcDm6DiB=69W0w8pZ1KhqeARqqKBK_s01PPRsmQ@mail.gmail.com>
 <20250520043355.wjkrslnripaqj6mm@vireshk-i7>
Subject: Re: [PATCH V12 06/15] rust: macros: enable use of hyphens in module names
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



Mar 20 mai 2025, =C3=A0 06:33, Viresh Kumar a =C3=A9crit=E2=80=AF:
> On 19-05-25, 16:15, Miguel Ojeda wrote:
>> On Mon, May 19, 2025 at 9:08=E2=80=AFAM Viresh Kumar <viresh.kumar@li=
naro.org> wrote:
>> >
>> > +    /* Rust does not allow hyphens in identifiers, use underscore =
instead */
>>=20
>> (In case you see this before you apply)
>>=20
>> Nit: `//` for comments, also please end with a period.
>
> Done.

Thank you Viresh for iterating on this and picking up review comments. D=
o not hesitate to add your Co-developed-by.

Kind regards,

Anisse

