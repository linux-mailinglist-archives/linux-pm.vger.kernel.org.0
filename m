Return-Path: <linux-pm+bounces-31644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ED2B16952
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 01:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8B45A77E5
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 23:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC12238C3F;
	Wed, 30 Jul 2025 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FiPDKj8p"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF4E2367A3;
	Wed, 30 Jul 2025 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753918841; cv=none; b=ZnuZLkvmJnbJinoCYp/hhlkT7azCULMRdAWQ8R7u41ZXKV1cRFNcuWG6VgKpMZofUhWcAyV58VFAyGt2oWNUsZPO+5HbJqA34O/3yBRAbmBtRq52zfujghv82xhpfi0Q3hB7NjO2ZpDrcWsIuUVgiskGHuWNIOPPuCxw7CDh57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753918841; c=relaxed/simple;
	bh=MfvAOrEMREnBy2TDLYttGKn6mlg56GMwqovDTbFfeN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT+YPSJDYpoDhh7Xl4bcJHO/4SlO9BCokWn0T6HIpvTDOFO8rp/WMEBtpXhlV4Hik8yj0U+u27lyjFP5T+ASNnQMAEP1LUq6ged+SuJPf14tIJfj5sWcO5qQn3kgW4nsydmH5gXVQouQ/VYKbTQDhp2Y+dIAcA4nGAY7HJ0Pido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FiPDKj8p; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E9A24328A;
	Wed, 30 Jul 2025 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753918836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2gSvoo+xeA/2kQRaK3UuSoEFac1ckG9fNOJ2Jo8dGuM=;
	b=FiPDKj8p4lRJhZwJJCKYppDVNG8Z+82N2nzDROP2QzuBdIkR75kdz3S65VZzIZJKjrFOMS
	+LezKvtLaf8p8UKT4xFnWhopcOvv631Ly4u4t3vnUU5FND6nVhop+wDftU44rLy3D0kpfe
	gwnya0O7OM/H53cF6INxIrfM+nVXgBM7BQL+pUvsp7wNFijCUrpd3QKyVaiYn8Nqp+aFIG
	AOpq8GSypyi27YXgIx1INIMeBvqEL1iJSkD7AtGPRg5ofHftzoH7NZGq+4SjRTYMFVagmP
	+v9NmRtXk387jR5/uDe00do1fRqjyENNyYhEAeruJmnvHJh6/R/pa7UsaXaqKA==
Date: Thu, 31 Jul 2025 01:40:36 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-pm@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: (subset) [PATCH 00/80] treewide: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <175391871302.1768453.3711812427284825013.b4-ty@bootlin.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelledvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeefhfffkeejueehveeuveejvdelveejteduffehuedtffdufeejudffuedvtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemvgdtrgemvdgumeeifeejtdemudgvfeefmehfledvleemhegvsgekmeduudegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdgumeeifeejtdemudgvfeefmehfledvleemhegvsgekmeduudegfedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghkrghrihdrrghilhhusheslhhinhhugidrihhnthgvl
 hdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexandre.belloni@bootlin.com

On Fri, 04 Jul 2025 10:52:25 +0300, Sakari Ailus wrote:
> Late last year I posted a set to switch to __pm_runtime_mark_last_busy()
> and gradually get rid of explicit pm_runtime_mark_last_busy() calls in
> drivers, embedding them in the appropriate pm_runtime_*autosuspend*()
> calls. The overall feedback I got at the time was that this is an
> unnecessary intermediate step, and removing the
> pm_runtime_mark_last_busy() calls can be done after adding them to the
> relevant Runtime PM autosuspend related functions. The latter part has
> been done and is present in Rafael's tree at the moment, also see
> <URL:https://lore.kernel.org/linux-pm/CAJZ5v0g7-8UWp6ATOy+=oGdxDaCnfKHBG_+kbiTr+VeuXZsUFQ@mail.gmail.com/>:
> 
> [...]

Applied, thanks!

[24/80] i3c: master: svc: Remove redundant pm_runtime_mark_last_busy() calls
        https://git.kernel.org/abelloni/c/0c2ce4fba48c
[25/80] i3c: dw: Remove redundant pm_runtime_mark_last_busy() calls
        https://git.kernel.org/abelloni/c/5fa62d4ec49a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

