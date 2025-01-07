Return-Path: <linux-pm+bounces-20034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7D1A03E54
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40392188565A
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197671E47CE;
	Tue,  7 Jan 2025 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="F2O7ZRUM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IcwGUqPY"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405F1E261F;
	Tue,  7 Jan 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251102; cv=none; b=CZNrmMlVr2iXLN3XtOPJtj0NSN6slom0OO5AF4+GC6I8bYS15TMkAnUVwgmo9pwr/jNpM0v37upUkiLl/+zDWaoXQVtuDmC2kWbbSN9WHGgBWLM+1idOQHRa1dQgAxB9QLe0xfsmoOx0Qn7OSy9EcJvKVzqrX6hApcQsI/Jxg8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251102; c=relaxed/simple;
	bh=iYqu80ikEhLCKB96pnPl7fvq5E24WTbH3xA4kJnixP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf4q6aTrbvBTf7xMp1BWU1O5XXKxfv5Y2JQqySaAb3S3GiBcgRI+z3qV1A1jgmIty/DqrAw02BamYPL1TM7gbuvjV4A6v8x4NPOncVyhSTULSNLWw806I6c4nMjn9QmIRyUGhP0T/hjA5CGwHHdxqnY+8NMGRrWW6AccosrDaT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=F2O7ZRUM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IcwGUqPY; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id 31B6D2008A3;
	Tue,  7 Jan 2025 06:58:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 07 Jan 2025 06:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736251098; x=1736258298; bh=lDJAFFt1Qz
	3EJmSYslP+ZhO9ywJ7UWSnMvXPKRgD+PA=; b=F2O7ZRUMRQOAFjP0hlrTzm1422
	AktlHgglsjDMQ9+QSQj9mL/FcmXXl/Ss4+EPUtrs8H/+PfFEZdH10HoAeAN3ssJ3
	P2vo1BpTeVKXgIt0IRtbKYlxmmk2Lus9sm8iUh8ct8cGCm47dw2Bar3Lbwwdln1K
	tJvYQmxmTn22B4thKnVS3hlmVCliGcHlIHpUmYafUK9wZmJiJGYWdMVWAea/6+78
	g2keTZBhCA/q0+KaNLdkdPJa8zEKHQVXz8JtyOQfrqGJozSMwfuc9mqPSsFoku/T
	NBs12A1tkdfwXrlo9mC0k6cgoULROFOMCONE74hqvisy3yNQF+3S2aE0R10A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736251098; x=1736258298; bh=lDJAFFt1Qz3EJmSYslP+ZhO9ywJ7UWSnMvX
	PKRgD+PA=; b=IcwGUqPYgkk3+Y63hj2hDaFVDZrIgseu45BGWejq2mLZThF2qin
	vYvFt5FBWotUKLJE5Tj9LDpiZjewH2WNa/tIbyiYv2BTnBZpp5T0UmmDwWewRPep
	qntYOvpPoCSoY+1XZ0EiNxRp8QgbpDEGV9mGTfkiYXhuJfQpg+aT3U7m70QPcFKW
	0ksATduGFvYB0Q4XfWpbWF1cHq1id0HMiEHbCOEokK4CFIeIC6j6LWSRj+t9jMmO
	2uU4YMxthgZaMqQUj/dXb+k6hOTeSYXn1czb1hiYMxjaxTbY7o8yMqFBsIGfLPPL
	PFn6CKTupvULBh56W2j4+B6W8sMBPPjUHsA==
X-ME-Sender: <xms:2RZ9Z_JPOhUAGAaC43Mw7ghe-Okc8FVAXUJjXckyxhtjB9Wg7-_G2w>
    <xme:2RZ9ZzKStURcxGktIYuCyTJfg-P2014c-I4jdCGsG6fygMAOE4OKEqenSVq-ecPjY
    0b3aNV2PtanMw>
X-ME-Received: <xmr:2RZ9Z3uDIHwPkHwv0IKJ5H5N7hr2oS5HqlYGx9STQdygLUaotfUDtKi1kL4yib65rtfFFcBRquSkYL3mYuquMry3Vl7CdJKMPzm4tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgfeegucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:2RZ9Z4bpPzROnGSuQaCJjdm9oAfI3TRWE071aCB-5tJTdA9HcFPXAA>
    <xmx:2RZ9Z2aW0GIkb7lzq6ZvckCIl08hb12zj5us2rKtXUELAtOIDUJpZQ>
    <xmx:2RZ9Z8BJ3hQb2YODy_30KO4PjRDViInT9Da5C-yGPZe9jZQW36Xftw>
    <xmx:2RZ9Z0Z4hYjstbdGFffJCVjK_qxojwwELboHRb-1FoIPenWPCJQctQ>
    <xmx:2hZ9ZzjNjfrxur0bpEnQzyrBz062H3eJcTswL407RFRP3OWr14kdHbIe>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 06:58:17 -0500 (EST)
Date: Tue, 7 Jan 2025 12:58:14 +0100
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
Message-ID: <2025010759-errant-lather-a64a@gregkh>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <fa014791cad083ad77125cebad11a6d5ec9592df.1736248242.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa014791cad083ad77125cebad11a6d5ec9592df.1736248242.git.viresh.kumar@linaro.org>

On Tue, Jan 07, 2025 at 04:51:34PM +0530, Viresh Kumar wrote:
> The Rust implementation needs these APIs for its working. Expose them.

Why is the rust code unique here?  Why does C code not need these
exported?

And that first sentance isn't really good grammer :)

Also, you created a new function here and didn't document it anywhere,
nor do you mention it here in the changelog text, making this a
non-starter right off :(

thanks,

greg k-h

