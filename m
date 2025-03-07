Return-Path: <linux-pm+bounces-23660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5477AA57626
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 00:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C045E189223C
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 23:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E139B20C024;
	Fri,  7 Mar 2025 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f9TNv5eE"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831F1925AC;
	Fri,  7 Mar 2025 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390481; cv=none; b=aEFq7G+uyO3q9ZAuWpkgDzNAF/AGvELiLo2IPG5CofTQhbVIrU0R1m6sLGcGQKOeYQUJksuNPhkuKvi/X1TJJdRDDPjDEAlS0Bxp9eWZOCqwxiC2U29O6DRJ0HD2nGrGABrYFOkVwtfpNFnhFP3t6gEE4JowuhpKrjMUBwqp7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390481; c=relaxed/simple;
	bh=kKh3XN4Srdg6CtNs5pzgXD8hxt/NvDuNA+VDK3Ebwe8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsPGM8VzM5PzhcpM9O8R+OnY7HX6rxpgieBYmVzIYCtubuzRsYzSCA4dAks9PxtDPxZVKAMgZtKrLUNWsaJe2rh+zbPCnxpop/Bg8wMPSBLAfZLszjWX5zanKPE6hDCuF6a/oZvc94n/Up06+CQ1SdbZAFoDyJeBemuqmIdyIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f9TNv5eE; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42F0F42FF4;
	Fri,  7 Mar 2025 23:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741390470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ydp6do/YmlCcdU444Z/VCOeLnRiEL8f6oOoQBqEHKHw=;
	b=f9TNv5eEBJQERSONNPIXE86lFBWD77yGJ0nfLkaPUyNuIH6zkHG/Xwkpa6VsAb4Q8S+WXq
	9t8VWk5F3hSznCwvIsppnG35PdvPLucURj1+RITr+Bi55fj0IqNMTk/p67sOrbKOwOVPmk
	yTdHYG7FXmt4EGD7CgJPRbD74ll4O8OLUieXDg9tvxCenxIIx1NYsT/O8l1qpNNNAD0viL
	ke1iM91BoEq61FbAJYzrC4sa1gHMDh7Y8USPTJEDEqAE0umO6zs6MI4GJpw0C+VHcX+b3h
	P51EWslCVh/NJMFZ6QDK9CvZS8jN1vdJFcsWHa6NdVw6LhaqiIUF5tjvHCVosg==
Date: Sat, 8 Mar 2025 00:34:25 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Liu Ying <victor.liu@nxp.com>,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] vsprintf: remove redundant and unused %pCn format
 specifier
Message-ID: <20250308003425.7b89bfb6@booty>
In-Reply-To: <Z8sqJhbqEBla_Ch7@smile.fi.intel.com>
References: <20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com>
	<20250307-vsprintf-pcn-v1-2-df0b2ccf610f@bootlin.com>
	<Z8sqJhbqEBla_Ch7@smile.fi.intel.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemrgegiedvmedusgguugemledutddumedvleegfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemrgegiedvmedusgguugemledutddumedvleegfhdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdeipdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlv
 giitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehflhhorhhirghnrdhfrghinhgvlhhlihessghrohgruggtohhmrdgtohhmpdhrtghpthhtoheprhhjuhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehssghrrghnuggvnhessghrohgruggtohhmrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Andy,

On Fri, 7 Mar 2025 19:17:26 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Mar 07, 2025 at 12:19:08PM +0100, Luca Ceresoli wrote:
> > %pC and %pCn print the same string, and commit 900cca294425 ("lib/vsprintf:
> > add %pC{,n,r} format specifiers for clocks") introducing them does not
> > clarify any intended difference. It can be assumed %pC is a default for
> > %pCn as some other specifiers do, but not all are consistent with this
> > policy. Moreover there is now no other suffix other than 'n', which makes a
> > default not really useful.
> > 
> > All users in the kernel were using %pC except for one which has been
> > converted. So now remove %pCn and all the unnecessary extra code and
> > documentation.  
> 
> You seem forgot to update translation(s) of the documentation.

I'm afraid I don't speak Chinese. :-)

For this specific change I think I could come up with an approximation
of it, but the both the docs and git log suggest this is not expected.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

