Return-Path: <linux-pm+bounces-27022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3CAAB29BC
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 18:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9983A3FB9
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EE225D1F6;
	Sun, 11 May 2025 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="wgL3cOyp"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591921F92E
	for <linux-pm@vger.kernel.org>; Sun, 11 May 2025 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982282; cv=none; b=TN2WgR56zz3LXSqM3ACd0Slb7iYioqlCvbGZoTDdU/VS93/wUNrBM0flpdtJwHCETsXU6julQMk21qCF3qULcBuUqQkmgs4/Hv3VicQJ2HcTeMC5WxSKB12NplGjz56J7WxwU/JDkxDwYzGB3S5ahlx4lsXyLeZDAsX29RMJBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982282; c=relaxed/simple;
	bh=hp0V2rHp0AnNag69pcoABnJEQYAZl8UmFSF2rOTR0Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4f5mrG2TLmz6dHNfc+v4TkbffK84pTUeX2uQsZNeglXQizB4mhuHk09tth3gUj3/SYhD4qeDjm5gC1DfUcGKmtlGGpwigmRKXnIiDlGWSO3zKOQBkwFU2ZXIzrkPc2l45ZI7PngYq8utroWHlfEkrUB3z/0hcjgG8TvT1U69J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=wgL3cOyp; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Sun, 11 May 2025 12:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1746982277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SeoAHDIH23gFXGyKcKHI7nDG1fKj5EZdsLV0fsLEv9Y=;
	b=wgL3cOypWMiXkr9it1pxC/4m9VSuGKQURmq2hX4dI9imvGcAa+rZft30xDqz7Uvuctg6aw
	iSXHNE1QQcYQ7qQ0jJ05KEvtUsQcqtUGne6LjZFNr1BpbuGZ/4/3he38YxPL3u6eAQTXU7
	7SWBd4GpKwuayuXzWonj6gESUbJ6+Dno/VHdlSIGnrmbtzqUa21VYWohtCYgNWMgLIDqH1
	nC1CtYQ2QGWPh+BkYFhGwYr0NZrH/RxikGTCnefEoNwrUPEFzCigkafaBQuTMfpe/WrtIH
	P4QzBQ2UagN1QTDpbrQcoyQuZ7IxtE4LMsWkcuPwzi6vr5CFC+cUX/F24YUSXQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 05/10] mfd: Add Apple Silicon System Management
 Controller
Message-ID: <aCDVgI4_LtE6OfO-@blossom>
References: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
 <20250511-smc-6-15-v5-5-f5980bdb18bd@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511-smc-6-15-v5-5-f5980bdb18bd@svenpeter.dev>
X-Migadu-Flow: FLOW_OUT

> +struct apple_smc_key_info {
> +	u8 size;
> +	u32 type_code;
> +	u8 flags;
> +};

This still has the padding problem from v4. With that fixed,

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

