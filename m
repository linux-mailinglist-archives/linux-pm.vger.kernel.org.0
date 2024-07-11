Return-Path: <linux-pm+bounces-10998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347C892EAE8
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 16:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D9D282943
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 14:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EB61662FE;
	Thu, 11 Jul 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="DLbZ8yXa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sJBa4ZQ0"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0AC5477A;
	Thu, 11 Jul 2024 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708679; cv=none; b=iZOgy5A+YZIODoRqaa0L/U1AFeSyr5lvkbX8Y++J4usDs7EPyrXELKyMmqc76obH42FWD9Ya9YGP8BfpiZ+uHQO7fpZbxVE7p57YuMIEvxyYPZ09dd1CIYfN/QEjXc/k8YrEwTzfzuP+uMvdQuDeziEPphBgJGznmq1r4w/XOPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708679; c=relaxed/simple;
	bh=iNVbhMguS2HYaKK3MnkVYZ1VXSkQ0ZvHqjgflY/bde0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIsWlrRXNqdJdeJuofjZG1DCFJTy3x0rJ1Yu/Bb0gRTvnfA4811s9brOj5nTQcil08NooBG7jt30MMWrWz4HIn3+06L+t/Ay80a07GyIE4HE14mknQHDAqgd3cQ7z3eQkk3mCWUGUXeY6gG4JX0z0Q4EkV+qC7DhIAd40pvY6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=DLbZ8yXa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sJBa4ZQ0; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.nyi.internal (Postfix) with ESMTP id 6924B200586;
	Thu, 11 Jul 2024 10:37:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 11 Jul 2024 10:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720708676; x=1720715876; bh=MHNUEi//5T
	c8gQAhWcjzeuCFJZyiEQUy0WrAOU3472A=; b=DLbZ8yXaw/nlzgYebuB1dUd2xb
	5O9ikBiDp9soXNYmF155/ZIg2+71dOLmXuTNCCf/F+eNoz6rwNhxscXAZj0aTKUc
	13B43g4HOYlW6WpASMpL/gk5okUt+7LEyWbhK6av/cdIrAkMoAsWZHsNhhw+ZePb
	4Q/TtOj3wr2HUg90trivjIYDuZ4cXL+gXFM/7QG6rMwfF+bzEuYvU5ZMXAp1eZPq
	uC9V5JtwqtNfRe+uYwcnqN9kxSP9cIyYowGdADbCeDyOxjbmksOvnANq/OBZvjYr
	mjDuPRXT1VHpLGr1BO89dwXfhry0+oqNgUeJrj4h2khqGGTA1xPi9f0PFW7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720708676; x=1720715876; bh=MHNUEi//5Tc8gQAhWcjzeuCFJZyi
	EQUy0WrAOU3472A=; b=sJBa4ZQ0juIuK4XS0hhMb0rCrtrnGO+gwTvHjL63NNbH
	Zr2pIVKDA2nQcw2JJX6GJW1lNJmWRf+ygoEar1aXibAN0Mpo5b2uzceUudeqeKwj
	Grv/2ozcq4Cg1ToG0hWN2GDYOTegRj9tSX0Iav96NuKoZx3v5zbpN5PbBxR4S3hh
	HW/Mmxw5xqkUwzNZd8RrNb1F8jCxMeUIEm5f8oiqo1DPxkHj9fV4f8XivF/MCADC
	7lg9CHmj7NMbgl/3TLOHejD2YEI8bTV4QPaZjsVPCGxma9zMtHojX0mMcq6bJc4c
	C1EU0TMck878PkSBCT8Qvg68YNlyPX+GVSCtUJRgtQ==
X-ME-Sender: <xms:Q-6PZm2yt0kPy9qqFOagAYKbnUZR8yYMJeSwNGTgHGUa0-0iH5SXyQ>
    <xme:Q-6PZpEC97fYGgDX9jf8aC1WQmZ5N2cJ_4hz7YioIkM_Q_6OR1xyazP-uDyWoBZbr
    r0ZjPRnDmhOpQ>
X-ME-Received: <xmr:Q-6PZu61hlOsZfMPS_WT5B8TLKIZNAGQR7fBx5Z23g6dXTUImVurN8FzgDaZLmgkCyWkqfdFbPxO4qrapBLllJ9g6MlTL7aM-FlX-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:Q-6PZn22GvhbBwdt_5fr9mE4XLT4BONT3pev5To9aeCEG27jVmi0Mg>
    <xmx:Q-6PZpHF04BKyJTl4Sm6TbvFP4nmhIU40iXBFsf8saEcYKuvTPktpA>
    <xmx:Q-6PZg8BPn7mFNgeQ8M_5qbw0LM2E-_Udjlx-gMSWNmGezzucHuE-w>
    <xmx:Q-6PZul-y-O9GPL03_6wybzpVfKO5dn9KyWquyrRVNNnxzwBsUvRhw>
    <xmx:RO6PZqSDKmxeqX5ugiQalak2jXlKw5eBWFirl9_69IAn1JCze6LER7_i>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 10:37:54 -0400 (EDT)
Date: Thu, 11 Jul 2024 16:37:50 +0200
From: Greg KH <greg@kroah.com>
To: Danilo Krummrich <dakr@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 8/8] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <2024071122-escargot-treadmill-6e9a@gregkh>
References: <cover.1720680252.git.viresh.kumar@linaro.org>
 <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>
 <Zo-3QIPbhBsv8EjB@pollux>
 <20240711130802.vk7af6zd4um3b2cm@vireshk-i7>
 <Zo_cW57i_GMlmYV-@pollux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo_cW57i_GMlmYV-@pollux>

On Thu, Jul 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> (2) You require drivers to always implement a "dummy" struct platform_device,
> there is platform_device_register_simple() for that purpose.

No, NEVER do that.  platform devices are only for real platform devices,
do not abuse that interface any more than it already is.

> I think (2) is the preferred option.

No, not at all, sorry.

Use a real device, you have one somewhere that relates to this hardware,
otherwise you aren't controlling anything and then you can use a virtual
device.

Again, do NOT abuse the platform subsystem.  It's one reason I am loath
to even want to allow rust bindings to it.

greg k-h

