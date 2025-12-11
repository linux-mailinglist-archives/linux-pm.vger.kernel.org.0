Return-Path: <linux-pm+bounces-39446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD1FCB6CA3
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 18:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF6803019B8A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 17:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1543313265;
	Thu, 11 Dec 2025 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bsWeeSFS"
X-Original-To: linux-pm@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A9266B6B;
	Thu, 11 Dec 2025 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765475242; cv=none; b=lqsfZp5vFu3kaypre1vQnZ3vd6HETw+K4wDQNm7mx1fiEn9ZmZ14iu97OpwIPOgztWOJ/vhtk6QnmA1Ic3koUfFm3tJkXsFY+WcuJGJaKd+NLfHSaery9Xzg/H9yx3zTEUFPpmslhuzICDwVCx1RS6TVUK/Qre7L6yDgP5saRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765475242; c=relaxed/simple;
	bh=6flwxWfNNvYMrc/WLrBKbuzI9j7O6XiXgrcAl/2S80Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olValu9WFfAX//AyqUxjD0TbkigevrQ7hXk9t2N+Tf0stkwxONLEJ7CrzVOSkonX/3Y26p/0iKZBJgzQLD8vqA8owfV1WJWSSfitA/llYxiiao317nPkcO7o1jYIWRmxj65omGbHw2Ddy36XTo4p0hXWvDVqNRNrMMNJ4uv/Zv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bsWeeSFS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XUkjzl23OkQ3deMTipBJkV5D9W9M+dPdbSMNcpDkOMo=; b=bsWeeSFSVS4kI3qfn9XJviBh1k
	ZYamqnYuJOFeuNnAcvhe3WmwEUMh0JgFjScb1ez1bX819jprM+UkbvxNMYdRS9LpveXnymSgKDoJa
	6FvGrPURcBlCXi5SrPn7OFmdlfN7drUH2R+cl+HbdcYu0vD+T7KGYPQMg1rkoUEgKnzk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vTkl2-00GfYR-Ls; Thu, 11 Dec 2025 18:47:16 +0100
Date: Thu, 11 Dec 2025 18:47:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Changwoo Min <changwoo@igalia.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Concerns with em.yaml YNL spec
Message-ID: <8a0dbc9d-0ed4-4a4c-8b5d-5779d07761a2@lunn.ch>
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
 <fc7dede0-30a4-4b37-9d4c-af9e67e762c7@lunn.ch>
 <CAD4GDZxYVwzxHBRnpG1RnkaD3wPW+-GUozhBg7hzO-_3X_PPpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD4GDZxYVwzxHBRnpG1RnkaD3wPW+-GUozhBg7hzO-_3X_PPpA@mail.gmail.com>

> It is covered by the Documentation/netlink/ entry:
> 
> ./scripts/get_maintainer.pl Documentation/netlink/specs/em.yaml
> Lukasz Luba <lukasz.luba@arm.com> (maintainer:ENERGY MODEL)
> "Rafael J. Wysocki" <rafael@kernel.org> (maintainer:ENERGY MODEL)
> Donald Hunter <donald.hunter@gmail.com> (maintainer:YAML NETLINK (YNL))
> Jakub Kicinski <kuba@kernel.org> (maintainer:YAML NETLINK (YNL))

Yep. So it should of gone flying passed on the netdev list.

But it did not:

https://lore.kernel.org/all/20251014001055.772422-4-changwoo@igalia.com/

Very little of what get_maintainers suggest should be in Cc: is
actually in Cc: :-(

	Andrew

