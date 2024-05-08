Return-Path: <linux-pm+bounces-7646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3335F8BFD19
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 14:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24F21F2358E
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A08F84D0A;
	Wed,  8 May 2024 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="b5nukZWF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zkd2fxXU"
X-Original-To: linux-pm@vger.kernel.org
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A8A81ABF;
	Wed,  8 May 2024 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171181; cv=none; b=QfHqgI0TylcMhzZkrUCDnizGQUavsdqhDnbb7EBXjnqV5HifqRxAW7rYLaZAzolbebZE1pL2T6qaSpcip9GUEM+4WNscvF7xpHwtTOICULRB1Q+xo7nkj38m/9OwZ/uNEWbXlLuAf1heH33wKVZW161yziTokF8dp4RLb9aFD1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171181; c=relaxed/simple;
	bh=zYqOsCSZRrhqRaruDwBPaWi51sm7YDKWs5yK4CoiTVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/MZ9no7W7VDr7vJrd50vcqTdGrhZztqm5czGeWzQXL9A7x5I1kzdoHQHXC991gPVMTr5eXznmlxgjFCLhGQdPCbFbT1Zh1sj4NGMk/lcHWyrVxBQyJzMUydDQa+wvCkcefLIOCIOFwQBamwWsSnfdRvK5VsrKPnduH5Bo/8NiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=b5nukZWF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zkd2fxXU; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 91F3718000DD;
	Wed,  8 May 2024 08:26:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 08 May 2024 08:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1715171178;
	 x=1715257578; bh=GDLhwnnjzpETjuUGPQWNEGiiCDcav5MyxElYleqd5fM=; b=
	b5nukZWFPlD7Wk/XKSYgFzozZG4P6u3fjcz6+84sc8abINHylJexwA9x5A+ASPw+
	qQUy1UNGY7U9k+6504CBoUPItGTmL/Kyb+V41IKh0/LwrBSQD4ig0uVIkmZ2M+ro
	xbyCCN3oxmrvLYALQUi03duObnx/sULs0UMFlWvBB18BDG+2pNEb/3KfWEmwQBz9
	enXLl0Y4JhHDOxoAebs+sHyAg3SjaspHo+KJcaQUT507f6qa4nWVyGph4xaavfpp
	wZmsuFl8ps2vdOrhzxFa5eVpHaXF5XEIf27+XNbXo0T4TYDhnVLDJ1YcrZprsEUm
	9WZmQpXDO34fFIH5lm8MhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715171178; x=
	1715257578; bh=GDLhwnnjzpETjuUGPQWNEGiiCDcav5MyxElYleqd5fM=; b=Z
	kd2fxXURymZglzFFPgQwQNZsQtys2b7zlzoeuGxIJgUr3ctxXDhy7OizhE06Wyrd
	1by7MFsd6HIiHVzgHsgaJHQH6sG9i9vwjqxJUml0o1arIxDRdYIkcq1EZvwC4ENe
	66h6wVRuUpj+SpIiP4hUv7/B4PR0of7NxC/rN9RVe/eWWwgyTMu2Yu5nTVs2Znc9
	GAaJUmkwZWQOXvt65Oy5wmm2s1OlumTU2pfVTgEsZ7lsk3R4Pfq5vIhMmeu7cSIX
	GtHplsX1EtDviFn0KL6oNSyQjCSuceOd25jXOTAogbXi/FzFCr8bjOoxBg5dGEns
	7YM4XsjLHJiG5dQSIU0ZA==
X-ME-Sender: <xms:aW87ZtBN6zvGPsWSpuq_-LK3NkR2I25dDH0ltO4QSpOuSHjp0Pnaww>
    <xme:aW87Zrgdz06KH6P-swRvctSmesOXTJfhz3G3zQXQdNj0_FF0w4x415JIEI_WmftoX
    0HoNFjy-k44C4SaJYA>
X-ME-Received: <xmr:aW87ZolP448ezwqctQ0Uk6Xnk9RTjNZvjABtIQyNPU9GYsOgNdHXELCr7bFXSjIyl_hQHO4zZIus0W-WjZtIDzedOK_guMY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeefhfellefh
    ffejgfefudfggeejlefhveehieekhfeulefgtdefueehffdtvdelieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:aW87ZnxfbeLPop401oIKIOJOw8aLCwSUSKIpF6Aju9UtjQLs8-_x_w>
    <xmx:aW87ZiTU7naLVgOHkpBZh-knUJfr8jdqUZu2z5Hfn743slffS5QyNA>
    <xmx:aW87ZqZHX4DSWEyy9RzkEzGi5J69y2_hEGA87mHz5uqHKhAhRLwkLw>
    <xmx:aW87ZjQ3lrZ26LXdhKD01Y7qcGgtybV5BrNYPRswCTJVcqBDVIrrow>
    <xmx:am87ZvSFmwrcCvF4Amu_KsJhMSjDzR_izhqgxA316OJXFskdLWX0KU5S>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 08:26:16 -0400 (EDT)
Date: Wed, 8 May 2024 14:26:15 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 0/2] thermal: renesas: Group drivers and update
 dependencies
Message-ID: <20240508122615.GF1385281@ragnatech.se>
References: <20240506154011.344324-1-niklas.soderlund+renesas@ragnatech.se>
 <TY3PR01MB113465D9CD7906936C5AC6DD686E42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY3PR01MB113465D9CD7906936C5AC6DD686E42@TY3PR01MB11346.jpnprd01.prod.outlook.com>

Hello Biju,

On 2024-05-07 06:58:59 +0000, Biju Das wrote:
> Hi Niklas,
> 
> > -----Original Message-----
> > From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > Subject: [PATCH 0/2] thermal: renesas: Group drivers and update dependencies
> > 
> > Hello,
> > 
> > This small series moves and groups all renesas thermal drivers in a vendor directory as done by
> > some other vendors. The idea is to make it easier to spot issues they are worked on by the same set
> > of people.
> > 
> > Patch 2/2 fix such an issue where one dependency was missed for one the drivers.
> > 
> > @Biju: There is no entry for rzg2l_thermal in MAINTAINERS. Should we update that with an entry for
> > you?
> 
> Yes Please.

Sounds good, once this series is merged could you send a patch adding 
yourself?

> 
> Thanks,
> Biju
> 
> > 
> > Niklas Söderlund (2):
> >   thermal: renesas: Group all renesas thermal drivers together
> >   thermal: renesas: rcar: Add dependency on OF
> > 
> >  MAINTAINERS                                   |  4 +--
> >  drivers/thermal/Kconfig                       | 28 ++-----------------
> >  drivers/thermal/Makefile                      |  4 +--
> >  drivers/thermal/renesas/Kconfig               | 28 +++++++++++++++++++
> >  drivers/thermal/renesas/Makefile              |  5 ++++
> >  .../thermal/{ => renesas}/rcar_gen3_thermal.c |  2 +-  drivers/thermal/{ =>
> > renesas}/rcar_thermal.c  |  2 +-  drivers/thermal/{ => renesas}/rzg2l_thermal.c |  2 +-
> >  8 files changed, 41 insertions(+), 34 deletions(-)  create mode 100644
> > drivers/thermal/renesas/Kconfig  create mode 100644 drivers/thermal/renesas/Makefile  rename
> > drivers/thermal/{ => renesas}/rcar_gen3_thermal.c (99%)  rename drivers/thermal/{ =>
> > renesas}/rcar_thermal.c (99%)  rename drivers/thermal/{ => renesas}/rzg2l_thermal.c (99%)
> > 
> > --
> > 2.45.0
> 

-- 
Kind Regards,
Niklas Söderlund

