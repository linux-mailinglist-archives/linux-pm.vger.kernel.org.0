Return-Path: <linux-pm+bounces-24224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C43A6610B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 22:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B4B17A53F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 21:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA5B20469B;
	Mon, 17 Mar 2025 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LlHMBRN4"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FEF1FDE2E;
	Mon, 17 Mar 2025 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742248579; cv=none; b=rr2SqkIKuoJrxAsKYaJ5ywOdPMu7uZOxPaFG9QOoPDD1IQ7N2KTE+Sl4725FS9BAChMXUumhUEwYeP2cyNNL2F/aEHksuhTKXG9cMIq9Uj7Xp7AjGYu0MiOOJu2A4WJuYC8XBgLmv1aPzyhOdyrrAkpM4QMGEdMt4r9RB4HKfSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742248579; c=relaxed/simple;
	bh=inAtUwWXZw6O+qaTrGoLKXAeQwhcqR+I5Hy9wJp/Kto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4ZNDGGRu0FZ+XYp3LWRT29proHaolmhUoOewzEQ3p3e5w+5YEvZ70nlaxQFt7s8EQRN/UTOe9GUQjkZO+JhkF/IDLkn7PfrMQKRHLRf2/5xusmKvGsnOZAzzdBEehpPq3WYuJiUSru90X4XvokO33X/1Fasy9cqJ7iF5Fmng0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LlHMBRN4; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8FEF32057C;
	Mon, 17 Mar 2025 21:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742248573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+2T3UFKZNQqzYcppRSeRT40EIToHYWw5aJ/ZTMJlsg=;
	b=LlHMBRN4dd1wr3rT/5fl9FvLjlU9W0MrimdfbNvbBLmagR523h+WFWVHELxVrwnr0AfKe8
	ukIUFAYhDvBj14lILUTc8VuKNOeQFbdP6N31lMeCB4rgKBTFhfnLu0UNK4UEiV9x4b2J8z
	FODZFbe0VD3kW/Fe0/x/2OSWKJSok7HbxuwLO8aX/OGP+sQ/57sLDj0U2NSAMytvG4ozlw
	MMAkehhE4kvQHPoYD4sXllnsp7IqWM5rJSm1tESA9G0kq76sLK5m0A7HTknvrio+tWCebf
	VYStkCnS/CxnZo0zorWUmQgBwRrEVqrP+mCb+1lDaJ9mNFAIaeVZHXYdaDnfdQ==
Date: Mon, 17 Mar 2025 22:56:12 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: arnd@arndb.de, lee@kernel.org, dmitry.torokhov@gmail.com,
	sre@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
	danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	linus.walleij@linaro.org, brgl@bgdev.pl, tsbogend@alpha.franken.de,
	linux@treblig.org
Cc: linux-mips@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 2/9] rtc: pcf50633: Remove
Message-ID: <174224855863.1587763.1321316355670597238.b4-ty@bootlin.com>
References: <20250311014959.743322-1-linux@treblig.org>
 <20250311014959.743322-3-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311014959.743322-3-linux@treblig.org>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeefhfffkeejueehveeuveejvdelveejteduffehuedtffdufeejudffuedvtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemvgdtrgemvdgumeeifeejtdemjeekvgdtmegttdgvkeemvdektdeimeekrggtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdgumeeifeejtdemjeekvgdtmegttdgvkeemvdektdeimeekrggtiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegumhhithhrhidrthhorhhokhhhohhvsehgmhgrihhlrdgtohhmpdhrtghpt
 hhtohepshhrvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhnghhoohhhrghnudesghhmrghilhdrtghomh
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 11 Mar 2025 01:49:52 +0000, linux@treblig.org wrote:
> The pcf50633 was used as part of the OpenMoko devices but
> the support for its main chip was recently removed in:
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
> 
> See https://lore.kernel.org/all/Z8z236h4B5A6Ki3D@gallifrey/
> 
> Remove it.
> 
> [...]

Applied, thanks!

[2/9] rtc: pcf50633: Remove
      https://git.kernel.org/abelloni/c/0a243de9d009

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

