Return-Path: <linux-pm+bounces-20086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51326A05ACB
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 12:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F69A7A3B95
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 11:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93A51FDE08;
	Wed,  8 Jan 2025 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="KI2aVTuw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xpm5xDDw"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30CF1FCF62;
	Wed,  8 Jan 2025 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337221; cv=none; b=t1shWcRzLQfkoa8rLpBrPjE3I+nbaBZSxU0YwOjbGzAVd5MA2u3u/Oi9kDw4RX2rjVZj7qsaLTBvy5lMq1n1tnO4qKOh18do4Eo4xCc0++aqEawT6MTdayvUd8Mbirgv093Cx2CSB5jJxiGAZ2DZq/IApZbZsaFvCziOCne8KoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337221; c=relaxed/simple;
	bh=x00YMsxhjzJGlP9Sq4r8hP0TerHaPpRXSdNMhuXXc8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hilo/Akf29vbvRqx0/p0LQRADtlN3p0syKWf4kl7CzGCBsLOpoJ3YWJTcJY2oB64DVUKoOWBMRXt8d1H3NWx0bacyH1kenITLkEF+zU3X2EX5vKfTcRKAvPIUWypS4nU9XD16ehprbIwNZiY95a08hrBs56QMn4Y1QnmqHbqLls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=KI2aVTuw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xpm5xDDw; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id A3353200FDD;
	Wed,  8 Jan 2025 06:53:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 08 Jan 2025 06:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736337218; x=1736344418; bh=btUwRHuX5g
	BsWJIQdk3kdeg3r4y3ZqBBNLuLHNcycxE=; b=KI2aVTuwWZNuVLooRSyIfoWGJ/
	rA/g2dgsUbVQBcEUHHmLdQ9FvfckVQsYAaznAARdwsqXNz9g68lmHLkFUXznWuy7
	DzHSGxlLzatZO72zLZVSWCbbAUsbFvG176LvjNccfv1t0LCOyydhY1toyaFle6nD
	rGZ3w9Ri17ExRLEAb9iOJw9RoMcZgiviSR9//Khj+0NjLIiWBp7LG0fEOs+4DpqN
	rr0A3665/R0Ujv9bd27tOYyXn36T+LE0GbiVLAu25mFbgwx+ejc7qS2ZRS4erC4o
	NFW+Y60qOiqR+aSPCr3PPiem9U7O8143rCTbU/s2lrcyoM7uBFpcUymlrOFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736337218; x=1736344418; bh=btUwRHuX5gBsWJIQdk3kdeg3r4y3ZqBBNLu
	LHNcycxE=; b=Xpm5xDDw7t/ZkbaFr5Ju90h+q1pWUXJSlRS2dNC6yYs1ugfX0wX
	ZM0qbR8cVtHeXbuNzt2F3Dx7XUFQtYGjGVlud056t9vMIeWcyy6wgqTbwQv8EBrA
	C3rpzFNeRW46j9Wdz0Tf4JrH7+pyG3+0zQazMVD0oopY9jFqPr3ewJJCzsBhxDP2
	+SyOOmEqmq0rkBeu4E+LzmoaPXI2R8wxEfKG2VX7cwmIiMhKqWOGf2C2KMtCqrMH
	kIuv8P3QbMrhBrMjUHO1O1VoIp3jCvniivZdWfbyWPYIUw3dWdBzfkTwjmna+CYw
	2La+EeGI7A0mWkGr6YKzjtsbc+5DlzKwWvQ==
X-ME-Sender: <xms:Qmd-Z6O8McItGLEhEIHpEy6sQHq7WvupuvmsGOBoMjAG5YFJFubBQQ>
    <xme:Qmd-Z4_f4ebqSfWcvhZup3bDZTlM5lRhySBjH2tsCwTqzqKkDMZGhvd6oMvIGKIy_
    FWDR7kMky2CMg>
X-ME-Received: <xmr:Qmd-ZxQCO05PKbzROFOXLzKsIenTb-_4k7gnI-Xh7Io9IyggvVKYOwSVDOfo7P3CxsByhly_M8EuA9LsX2KlIhXPEooH7n8OzJxCQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefh
    gfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeehtddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdroh
    hrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhmrghilhdrtghomhdprhgtph
    htthhopegurghkrhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvhhirhgvshhhkhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhmsehtihdrtghomhdprhgtphhtthhope
    hssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Qmd-Z6tGUdqS1rzS-kJWCEGP3iyy47ghPI7sVR4NOn5cjtTzhsUM1w>
    <xmx:Qmd-Zyd9AKadU4Bx9MecknKqAZZJn3gGJIO5WRY9xiciyvXVxwVhuw>
    <xmx:Qmd-Z-3vgNEmJ9ccSeq1L5_IUXBaRm1KIIgGR4IkAhzdpUJdUec30Q>
    <xmx:Qmd-Z2-njjL9U9ktxDoIfnoCHKMP4gU4MyOXsGy_tuVAjNCAgPoZmQ>
    <xmx:Qmd-Z_XkyAsF06Clr7ZDEJKhU494NaD6URSWp6x0aSgWqn9LqNcQa_bS>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 06:53:37 -0500 (EST)
Date: Wed, 8 Jan 2025 12:53:35 +0100
From: Greg KH <greg@kroah.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 01/15] PM / OPP: Expose refcounting helpers for the
 Rust implementation
Message-ID: <2025010821-yam-distaste-130f@gregkh>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <fa014791cad083ad77125cebad11a6d5ec9592df.1736248242.git.viresh.kumar@linaro.org>
 <2025010759-errant-lather-a64a@gregkh>
 <20250108091124.3cqgjk4k45uuvppk@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108091124.3cqgjk4k45uuvppk@vireshk-i7>

On Wed, Jan 08, 2025 at 02:41:24PM +0530, Viresh Kumar wrote:
> On 07-01-25, 12:58, Greg KH wrote:
> > On Tue, Jan 07, 2025 at 04:51:34PM +0530, Viresh Kumar wrote:
> > > The Rust implementation needs these APIs for its working. Expose them.
> > 
> > Why is the rust code unique here?  Why does C code not need these
> > exported?
> > 
> > And that first sentance isn't really good grammer :)
> > 
> > Also, you created a new function here and didn't document it anywhere,
> > nor do you mention it here in the changelog text, making this a
> > non-starter right off :(
> 
> How about this ?
> 
>     PM / OPP: Add reference counting helpers for Rust implementation
> 
>     To ensure that resources such as OPP tables or OPP nodes are not freed
>     while in use by the Rust implementation, it is necessary to increment
>     their reference count from Rust code.
> 
>     This commit introduces a new helper function,
>     `dev_pm_opp_get_opp_table_ref()`, to increment the reference count of an
>     OPP table and declares the existing helper `dev_pm_opp_get()` in
>     `pm_opp.h`.

That works, if you drop the `` stuff, not needed :)

thanks,

greg k-h

