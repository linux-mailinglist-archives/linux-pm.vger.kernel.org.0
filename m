Return-Path: <linux-pm+bounces-26966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2DFAB1A63
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 18:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED4D3BD834
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 16:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE642367DD;
	Fri,  9 May 2025 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="yJbb5Pv2"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A72122CBEA;
	Fri,  9 May 2025 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807721; cv=none; b=gGNoSMJLHcOhn61ceBIRtYflDNZdcwv5w+6Y6w6fkpLN+wNoeIiJAspb4vKJIyPaN4E/at/S1totnedKJbr3vPgEWO1H6/v1+JqSsAUA0UmkeS5OLO0fm2+js7pTWV8L6H6r4edcZ7joxpjxafghlqSeDgFtymIVYwAdMBAAZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807721; c=relaxed/simple;
	bh=rEj6hWkcGPaha1zLvnzaxpRj8FK8vW30ghmy4w7SLfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k95EoIvvM6qRVwZkq21pqXANNkHWCIbuj2ZR0nJ35Tfeaq2F+RGgBiCjXHuQhfLCLeuF/HClkGHigN8kiRxINphX4zSWklFtdgrYG2BKj0d286B7K0qiDfuGuwxB4u40SET/PJT2yvZmT5Xx6xF9/owkfDHnYInjzPSSLbFWHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=yJbb5Pv2; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Fri, 9 May 2025 12:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1746807707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oCay4j7C41YPfPP4dRmjz27ecUbg9JIQQ0y/wWYi3Yk=;
	b=yJbb5Pv23OL+WAcAvl05L189sakxNU2wSigqZjyKPBKo6TN/zVF3XYwjSGhv/nOUsiEjL/
	Tp8tSHES30I1yjcQmteNELFrqGV/wMzPapMmE2mcb5VxV89kHpNkfAWq0W5a43dR7bQeR3
	tj08z9iGNCbD3M+FVqOr5t9j3yQAw8MY5HnYsz+l2fxXFwkjNx4XLdsQjaR13NvfRce8d1
	NmvMvyE+Cg/sJgIBOCWV6X1i6kZ5PwdUwMWq5Wr7lzoRGnFI38esKrtfgKKKRoJSgurIpD
	ac11fOF5/1DfHQHvguwizyJTVaY0X11phlrinCUlPVjjthsGKDpUWi0jK4cwVw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Sven Peter <sven@svenpeter.dev>
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 6/9] power: reset: macsmc-reboot: Add driver for
 rebooting via Apple SMC
Message-ID: <aB4rliBFrUWWuNQ2@blossom>
References: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
 <20250503-smc-6-15-v4-6-500b9b6546fc@svenpeter.dev>
 <aB39iJm9759RYAKW@blossom>
 <196f84ea-6567-4fe3-9bee-743bb289223e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <196f84ea-6567-4fe3-9bee-743bb289223e@app.fastmail.com>
X-Migadu-Flow: FLOW_OUT

> >
> >> +		mdelay(100);
> >> +		WARN_ON(1);
> >
> > ...What?
> 
> This is done in a few drivers in drivers/power/reboot. If we haven't
> rebooted after 100ms something's wrong with SMC. I'll add a comment.
> 
> drivers/power/reset/tps65086-restart.c:	WARN_ON(1);
> drivers/power/reset/atc260x-poweroff.c:	WARN_ONCE(1, "Unable to power off system\n");
> drivers/power/reset/mt6323-poweroff.c:	WARN_ONCE(1, "Unable to power off system\n");
> drivers/power/reset/gpio-restart.c:	WARN_ON(1);
> drivers/power/reset/regulator-poweroff.c:	WARN_ON(1);

Ohh, duh, ok. Cute.

Can we do the WARN_ONCE(1, "Unable ...") pattern? Then we don't need a
comment since the warn message makes it obvious.

