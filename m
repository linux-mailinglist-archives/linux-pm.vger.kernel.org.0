Return-Path: <linux-pm+bounces-14413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CD797BC64
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 14:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969521C21315
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 12:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD26189B83;
	Wed, 18 Sep 2024 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="6QoRj0X8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3952915B10C;
	Wed, 18 Sep 2024 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663414; cv=none; b=qED7jXXEylMIWkNdU/u9/1F2pzVPLqG6CefU24QMmJWecsTSNorTN99Nglc1lj6NDeEGykdBDy8imPzTunYDNwKP13pUOOI1URdb45YXTHe38/HNhWi1vK+IG7Ln07Motq2ajLnJvrAkQBL4RF7UF5gsc/Gl3pMRWdeyLh1gD/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663414; c=relaxed/simple;
	bh=a1kNO5OucUhoyax/JdvcsOyRuZI9nX9J5YIBVmy0l+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYVQURgFUz/mbIEMf79B4BVpGhCDdBEy2DrZZUhbGH67AJfTqMJOOMg/FBxmgi8jAW0oJPXzjfOfNFB5AamwVlT3p8vaewoM90dNoRngnRmMIKT2x5VpbY9mioCQp4/uoEND4ncAUjMa0JTVnRbdjC8MB4cZGnn5qY1BQPp9pdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=6QoRj0X8; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MjmO4lbzN3jRe2aqKAF2+FoHL9f/7t+lzoy6eLtQfAc=; b=6QoRj0X8tzGMFh1YZJhmJ62L03
	1IfI72dMRmM0y0Rtm7e2w6w1Wodn6+oqyU6nrCxUNsLaQDQP4/K/EF6D10PWemwt399Xpd7f9clWb
	iwHShiscCcYK3IwDopH/Ssg0OjlF1H/ntktLgbxF3mpabzw2TNsSf0XoS2f+I/tWj7j5APS/mkg+H
	2cH0nNWtAbGsURVER37lkU1dtiRygAuIKxMzrbdunXZd/jFWGpqUB8G9dQXAK/PasOBLZKbGrBlGD
	LdvHmbIKRWEtmNkej9LrWZFs9j9SGB4+bpVUYliFmj7HfAFJOrCcabfFmvBePYCGgh16PtH71PAN6
	eCe02ZRA==;
Date: Wed, 18 Sep 2024 14:43:25 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: tony@atomide.com, Sebastian Reichel <sre@kernel.org>,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Lee Jones
 <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] power: supply: initial support for TWL6030/32
Message-ID: <20240918144325.0ccca89c@akair>
In-Reply-To: <89a7e86b-8866-4148-9f9e-13ca84c1aede@kernel.org>
References: <20240918084132.928295-1-andreas@kemnade.info>
	<20240918084132.928295-4-andreas@kemnade.info>
	<89a7e86b-8866-4148-9f9e-13ca84c1aede@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Wed, 18 Sep 2024 12:43:01 +0200
schrieb Krzysztof Kozlowski <krzk@kernel.org>:

[...]
> Drop {}, see checkpatch.
> 
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "could not request irq %d\n",
> > +				     charger->irq_chg);
> > +	}
> > +

Apparently checkpatch only moans about {} around single *lines*
not single *statements*, even with --strict.

Coding-style says single statements,  so maybe checkpatch should be
fixed?

Same for other appearance of this pattern.

> > +	/* turing to charging to configure things */
> > +	twl6030_charger_write(CONTROLLER_CTRL1, 0);
> > +	twl6030_charger_interrupt(0, charger);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id twl_charger_of_match[]
> > __maybe_unused = {
> > +	{.compatible = "ti,twl6030-charger", },
> > +	{.compatible = "ti,twl6032-charger", },  
> 
> So they are compatible? Why two entries in such case?
> 
There is one device_is_compatible() in the file.

Regrads,
Andreas

