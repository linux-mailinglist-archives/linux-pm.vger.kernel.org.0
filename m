Return-Path: <linux-pm+bounces-39489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF775CBBD63
	for <lists+linux-pm@lfdr.de>; Sun, 14 Dec 2025 17:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14AF23007270
	for <lists+linux-pm@lfdr.de>; Sun, 14 Dec 2025 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017D721D3F3;
	Sun, 14 Dec 2025 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zbiXxnFb"
X-Original-To: linux-pm@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB3C17A31C;
	Sun, 14 Dec 2025 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765729293; cv=none; b=IGXvHmwKwt3pJSFNVb1oFuKFU2R0RKDC0hf1Q8q2VK9S6LeGb/h2jwxSoUoGlEzuHzJ5oDpba72Qiiuh+l+lquzSayQ9IaWQNpO1qACuzh5tOOubQDBPjE6gJLXu17lEwafjH9UJyxkwciMLBwfNSrdA/siYdX8XM3/J76REALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765729293; c=relaxed/simple;
	bh=oKeYvhSD8UppLEXpZFvXnphWhmTlKQA0MVeyGw/vbR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEfHfNWo7kFcdLuNS7w23bsM7IrcLfxnkFPlt7COVKjFwBQvDeFKu7VT2FAE4yZPiLs10Fct4Q6U1V0Ho0BH9MQ9Jkrt1Z5s9MX27rrBI7/VarSKIymVUBMWGYN+LrHSjixNl3bz4BBz1MlLf2n5BRC9nyPtuW7PuXcsjeiY+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zbiXxnFb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b5iDoQ4t1oS+0WiPDGUQIZJ9YDhuCciE8h6VNTnQ24o=; b=zbiXxnFbXyEyGr+nuZZt0UsdVS
	v/HnFI3uPqoB7YxmIk4Sl9Pd9SrTsR8shN+tVarnoFBYZBlzmNM/X5e15bxt530plddKsCWlM/E0s
	TQnfHY4MmSwD6uXLl8FW70GeE8Y6rnFNS2Xh8t+L41GqFFbGACPDKkkcsXaAQ6g/56mY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vUoqa-00GveI-DG; Sun, 14 Dec 2025 17:21:24 +0100
Date: Sun, 14 Dec 2025 17:21:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Changwoo Min <changwoo@igalia.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
	sched-ext@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Concerns with em.yaml YNL spec
Message-ID: <bb7871f1-3ea7-4bf7-baa9-a306a2371e4b@lunn.ch>
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
 <081e0ba7-055c-4243-8b39-e2c0cb9a8c5a@lunn.ch>
 <4bb1ea43-ef52-47ae-8009-6a2944dbf92b@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bb1ea43-ef52-47ae-8009-6a2944dbf92b@igalia.com>

> > We also need to watch out for other meaning of these letters. In the
> > context of networking and Power over Ethernet, PD means Powered
> > Device. We generally don't need to enumerate the PD, we are more
> > interested in the Power Sourcing Equipment, PSE.
> > 
> > And a dumb question. What is an energy model? A PSE needs some level
> > of energy model, it needs to know how much energy each PD can consume
> > in order that it is not oversubscribed.Is the energy model generic
> > enough that it could be used for this? Or should this energy model get
> > a prefix to limit its scope to a performance domain? The suggested
> > name of this file would then become something like
> > performance-domain-energy-model.yml?
> > 
> 
> Lukasz might be the right person for this question. In my view, the
> energy model essentially provides the performance-versus-power-
> consumption curve for each performance domain.

The problem here is, you are too narrowly focused. My introduction
said:

> > In the context of networking and Power over Ethernet, PD means
> > Powered Device.

You have not given any context. Reading the rest of your email, it
sounds like you are talking about the energy model/performance domain
for a collection of CPU cores?

Now think about Linux as a whole, not the little corner you are
interested in. Are there energy models anywhere else in Linux? What
about the GPU cores? What about Linux regulators controlling power to
peripherals? I pointed out the use case of Power over Ethernet needing
an energy model.

> Conceptually, the energy model covers the system-wide information; a
> performance domain is information about one domain (e.g., big/medium/
> little CPU blocks), so it is under the energy model; a performance state
> is one dot in the performance-versus-power-consumption curve of a
> performance domain.
> 
> Since the energy model covers the system-wide information, energy-
> model.yaml (as Donald suggested) sounds better to me.

By system-wide, do you mean the whole of Linux? I could use it for
GPUs, regulators, PoE? Is it sufficiently generic? I somehow doubt it
is. So i think you need some sort of prefix to indicate the domain it
is applicable to. We can then add GPU energy models, PoE energy
models, etc by the side without getting into naming issues.

Naming is important, and causes a lot of pain when you get it
wrong. Linux has PHYs and generic PHYs. The PHY subsystem has been
around a long time, and generic PHY is much newer. And sometimes a PHY
has a generic PHY associated to it, so it can get really confusing
unless you are very precises with wording.

We need to be careful with any generic term, such as energy model.

	Andrew

