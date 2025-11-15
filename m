Return-Path: <linux-pm+bounces-38084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A649DC603FA
	for <lists+linux-pm@lfdr.de>; Sat, 15 Nov 2025 12:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 18F78241E7
	for <lists+linux-pm@lfdr.de>; Sat, 15 Nov 2025 11:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D19299948;
	Sat, 15 Nov 2025 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uge+fHj4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69ED1E9B22;
	Sat, 15 Nov 2025 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763206312; cv=none; b=EP+MGAta9uu0v08l4s8iPK4ruE00NW32IwU8FQgiRhlJqkM/7VHMeof0ovLJ+AmSiLZlcGkDUuXhRptck2MyYD7auK2EdkGAlNILjvKruQHn+fMBwo434UTjtBq2shN/G6IpUZ+9+hA+/H/pl+GfhwK7XovdKrYMphQ46V8ppws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763206312; c=relaxed/simple;
	bh=FPZ0kQZIwnebdbDeToX/YK8Bd3hA21dxcccPr3O5ccY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFrXbFUKO7NfDGFxnZC2YFrpuQCQ7RTh9FG8Kl8EGW6bpwSPe4uJrhge0G7cR2YN0FIZ4h+yNUWAhJavuc13lFnn9ansQavZYwld5VHrZ7mHLi3wX0R/twVCAq0BvwnvJN+RRmNiTWOZ6iERBi0ED1d5N2VlO1UevdBYox5KSQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uge+fHj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9200DC116B1;
	Sat, 15 Nov 2025 11:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763206312;
	bh=FPZ0kQZIwnebdbDeToX/YK8Bd3hA21dxcccPr3O5ccY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uge+fHj4kRQhX5pc86U5iaOgiFqgdDil5CdrG2swUUk+N3TjlB62JemPjth32HKot
	 l4WuxNKEZUq2a653BbiSjQ8UkzHm0pGUKXkKL5h8S8gyCwCdpGa+jZqUixOjYUZAcr
	 YfnLBTOfBHgL7Lcl/B5L7qlvxYPwVoz4n5kEhNhXEi5xTpIFmAcKc341m2o91z9JqR
	 pVj2PUJHMr8+SjXqBIHUHS2mnD+3M7fdYgJj3/kw/jLSCJcD5jNTeBb24ifdmFADB3
	 hwB9tozgjFyOKqZ5x1eBXFBqRWVRv+rDiSn82Ep5Z8EA7Ns6+WUMF4OWIj8EHWn6L0
	 NbFLU8nvdoNGQ==
Date: Sat, 15 Nov 2025 12:31:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v4 05/16] dt-bindings: mfd: ROHM BD72720
Message-ID: <20251115-wolverine-of-interesting-authority-faecde@kuoka>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
 <ec2cb44d9d00f5edaed2fbe17fd9ddbed914ff37.1763022807.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec2cb44d9d00f5edaed2fbe17fd9ddbed914ff37.1763022807.git.mazziesaccount@gmail.com>

On Thu, Nov 13, 2025 at 10:52:35AM +0200, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The ROHM BD72720 is a power management IC integrating regulators, GPIOs,
> charger, LEDs, RTC and a clock gate.
> 
> Add dt-binding doc for ROHM BD72720.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


