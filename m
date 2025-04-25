Return-Path: <linux-pm+bounces-26218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F2DA9C8EE
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 14:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55C81BC0083
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ECF248879;
	Fri, 25 Apr 2025 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="dQLZS1vH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n9Yspg5x"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C728B248176;
	Fri, 25 Apr 2025 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745584138; cv=none; b=IQirjfiLjW5l8l1z+G/pJRsDJjDOvOMt0NWzjga1USjOHBdCLQ3H0c+Z/9e+gWDx/h+CHu/qs8KjUPnVvP4MxDhQtxVlPgjOMR7fE7mUgHidWgp8F+W13M9srFcgaK12VQtIb0DjdoRCLH09uQwO4FvW1W4vdIM4SeR4PIbX1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745584138; c=relaxed/simple;
	bh=5t7yNPr1CWOau0RMYcrRFsXe9MPaeyzZjGY5BgZV1o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l75oOdqMA721OVWix1TkWWHc47L2zNT4uPyR/HV4P1KaMVd3IY+6ZAT48kUbyTZLRanpV/w+sSERzbi4dMClq3ZLd8GLE3sQAuF5uSIMF+9Mm9y4XUhVgfycJrSNIscdMUOhHWRFksnOsexiPykNT+SP7nZJVflCGd2oFNb/vQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=dQLZS1vH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n9Yspg5x; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 76B3D114021B;
	Fri, 25 Apr 2025 08:28:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 25 Apr 2025 08:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1745584133; x=
	1745670533; bh=oDNpPryBrsrLI6MNT652iy7u9ZryJF8wQVHOnmOUp+k=; b=d
	QLZS1vHt7XLg7laxQNs3/RSjp2nYQx2mnXx61t4OGwllZ2Yk1qGJb2IrDw1LlhIN
	nwzrGSD2LxB+pDkOxUKrppjFqtHvYzMWPN0VXHScOfh7L5VXWUAGa9nlNDoKm9uK
	/xPjCvnNu9zwVwu268/FYsOdS/h1J/QOo7Gjw/JNAPmTX453++t21Hn+94mXZuNI
	1fPywjoctp8apcCcNQ8pTAWepIrpit/LFpG9kR49XRdbSQpVgLa1ZngkxRYI07J3
	Mmfqvowwz8LxXp2J06/Uoh9Drclbsn749kjx9OZgGnlgN0Ico0Wrl/j/tS2HJcyo
	l6AJHuPvDnNihSt+U9vEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745584133; x=1745670533; bh=oDNpPryBrsrLI6MNT652iy7u9ZryJF8wQVH
	OnmOUp+k=; b=n9Yspg5xZCHkbVLlFEM7+UfoJiUJLX6/+6E3pB6Xyfcxef89b4b
	/19hzcDppt3Oh0582KczHBgO5sb8G+e4DP83k7KshsNZ51K9Tvg5O+gw8dRhvfrv
	MCUOGeXa67ZlAp2oIuFXoQTsKdfAE6N/sYeVY6sruLfubmlWvEcGA0D4aLbIXTiN
	Kzt72b8nrE9mwqemVsLD8ZZBQn8JeGjO+eYo0Et/Bo3ANzYgCqsXj+i7gpdUrv37
	saRJ9fkIBSJ5lUdIi9Nm+Mxi5R2aBq1oupUQHrbNeau2HgEQgrGApGnciD/ZAyni
	qkJ8IgcnxsEgV5vWvWaZQjAXYllHvH3JItA==
X-ME-Sender: <xms:BIALaBwbI7RNIZkzSUkRqcF85j_JdkpB3AoGf95xIZEBHEukpWIPcg>
    <xme:BIALaBTPE8uTm3KMrreJFpdrRGn1jwWnOftSVWsQBYSF52rrVmu0S5Sh255EoLm9_
    QYYm-oFz4svhZpFaXU>
X-ME-Received: <xmr:BIALaLV7S3lw3nKMDYt44ugtBzMjG8qkD8u6OfJNd7RGnR4icilx01iecleA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeekleevleekfefgueehveejueek
    vdehvdeugedvkeelgefhleegieevffdtuedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvrh
    gsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopehlihhn
    uhigqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrih
    gthhgrrhgusehnohgurdgrthdprhgtphhtthhopegthhgvnhhgiihhihhhrghoudeshhhu
    rgifvghirdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfh
    hrrgguvggrugdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgrvhgvlhesuhgtfidrtgiipdhrtghpthhtoheplhhinhhugidqph
    hmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghffhgvnhdrkhhl
    rghsshgvrhhtsehsvggtuhhnvghtrdgtohhm
X-ME-Proxy: <xmx:BIALaDi2B7zCD1xIfS789Vp3Zl0ypkFSvqJIl-8By3nbbu5P5m-frg>
    <xmx:BIALaDCq4sTkjFppwq-q_GGh3p_n4BYrxCYASJhM18McRJx-5UgMIA>
    <xmx:BIALaMIykH5GVHTlYxktpiQyupiQobkz4UHdkomjPKwmTqsMpX1low>
    <xmx:BIALaCB6deqlUAKFo3DHVX-0ixnnUqO6_mMpdkeaqJ8-2_pct678fw>
    <xmx:BYALaJIvyXovcrkjbdwJKw4DsG-aXUoG53dlaE-zhb-I9gLORb42TQHu>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 08:28:51 -0400 (EDT)
Date: Fri, 25 Apr 2025 14:28:49 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [v5 PATCH 11/14] xfrm: ipcomp: Use crypto_acomp interface
Message-ID: <aAuAAVOvfcTeZJbY@krikkit>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
 <d7bccafdf38259c2b820be79763f66bfaad1497e.1742034499.git.herbert@gondor.apana.org.au>
 <aAt8AIiFWZZwgCyj@krikkit>
 <aAt-GiUloeLEfu7O@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAt-GiUloeLEfu7O@gondor.apana.org.au>

2025-04-25, 20:20:42 +0800, Herbert Xu wrote:
> On Fri, Apr 25, 2025 at 02:11:44PM +0200, Sabrina Dubroca wrote:
> >
> > The splat goes away with
> > 
> >  	/* Only update truesize on input. */
> >  	if (!hlen)
> > -		skb->truesize += dlen - plen;
> > +		skb->truesize += dlen;
> >  	skb->data_len = dlen;
> >  	skb->len += dlen;
> > 
> > pskb_trim_unique ends up calling skb_condense, which seems to adjust
> > the truesize to account for all frags being dropped.
> > 
> > Does that look like the right fix to you?
> 
> You're right.  I must've missed the truesize update in skb_condense
> when writing this.

Ok, I'll submit the patch in a bit. Thanks.

-- 
Sabrina

