Return-Path: <linux-pm+bounces-23628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84327A567D5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 13:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701F63B2390
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 12:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E4D2192F6;
	Fri,  7 Mar 2025 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bpvgkCh9"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671711E1E0E;
	Fri,  7 Mar 2025 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350613; cv=none; b=KJvFNMjQ5YLRfyG82CKX4th6rtFrJ1F6BjinJDQ8BqViIrXWkbEdq4uuIeugCf0JUQryDc8pXRVNjIgOgpoZgF6Sn4881J+3P+7540itmVdlAt4gOuLRJxxuvUbZbhwqcWBKOACjawD0v6GYtWzttVWrigRe+7xha19iGwHUCVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350613; c=relaxed/simple;
	bh=MSJOYmYhoP3KleVgDgo4/p/vvWrs63VDLh/BlnV+mWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUQyMDm3VTPX7BYKNfUyoo0PMPMdnMUjZHtjHuZEb5I71ruFPTPshXbmF4uUH7F8VFdSBbOBm24g8qrl50PO4qv6ljy3U0YPYA2mUE3zJBsyXpUW+NV/JndQ40KRmcRdg7kTXrXEnUydHQbammsajY7bt8pbNQJWO2Tr1WWrLiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bpvgkCh9; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D97B20457;
	Fri,  7 Mar 2025 12:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741350608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HKjBd8X3oIbWR4uTQ+kAMB9w4fC+DWN+UImtLmLxNxw=;
	b=bpvgkCh9S7IjUNZBTXr/d6Tv6HXPAadztsNAopW/nbql7xCncqI4cbpi4dNCocB+dggzyC
	DAvkPGIF6AoPUO+ZfQIK6bqKoxIzIsBPqi6lWNrpOskmYWMg2IWCLQl6Uqo9IBXDYAKAiW
	x4aFDoPxpIbsYdUM4LIYuwpEmladRcxbt8tJ1SwRw+y13LtNKwUzdfqDbVJ/E0LSp+Etri
	MushLLID2uehgB/MvNE4CLDHHLbKc12cVZLN+dTUoJ+ZnJaq3bGUsZLBz9tm+o5EQ0fa8x
	SNyB0/QIY0hYU9VJOsYYPCNmS3aj6HoRMxwNokCxETbAfT2tGWXyt+H+YIfrBA==
Date: Fri, 7 Mar 2025 13:30:03 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Liu Ying <victor.liu@nxp.com>,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] vsprintf: remove redundant %pCn format specifier
Message-ID: <20250307133003.09f1328f@booty>
In-Reply-To: <CAMuHMdUeThsk5tSaMnT-6BqO6XSMTTDo1Q9kRgJ_d5iC7MTdcw@mail.gmail.com>
References: <20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com>
	<CAMuHMdUeThsk5tSaMnT-6BqO6XSMTTDo1Q9kRgJ_d5iC7MTdcw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdeljeejuddvudetffdtudelfedugfduledtueffuedufefgudegkeegtdeihedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrn
 hhosehlihhnrghrohdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehflhhorhhirghnrdhfrghinhgvlhhlihessghrohgruggtohhmrdgtohhmpdhrtghpthhtoheprhhjuhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehssghrrghnuggvnhessghrohgruggtohhmrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

On Fri, 7 Mar 2025 13:13:19 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Luca,
> 
> On Fri, 7 Mar 2025 at 12:19, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> > There are two printk format specifiers for clocks: %pC and %pCn, and they
> > print exactly the same string. The reason for having two is not totally
> > clear (see discussion in patch 2), but there seem to be no advantage in
> > having two instead of one.
> >
> > Definitely having two without properly documenting they do the same creates
> > misunderstandings [0].
> >
> > Since %pCn is used in a single place, replace it with %pC and remove %pCn
> > to simplify such format specifiers implementation and avoid
> > misunderstandings.
> >
> > [0] https://lore.kernel.org/dri-devel/71c44221-b18b-4928-8faf-00893ec4a109@nxp.com/  
> 
> The link looks unrelated?

Wrong link, sorry. The correct one
is: https://lore.kernel.org/dri-devel/f8df2b5e-b005-4ada-8108-159b2b94a72e@nxp.com/

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

