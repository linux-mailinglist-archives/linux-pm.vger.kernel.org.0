Return-Path: <linux-pm+bounces-27161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F29AB7765
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 22:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393A6866795
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 20:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D77296707;
	Wed, 14 May 2025 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sd4Tg7iV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF3292901;
	Wed, 14 May 2025 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747256123; cv=none; b=PEmoNwe6B3u3Y4eBRUlzXxAj8CGu+c41AKU0Woyhr5ku4pvXIffUu7R8Fou5bXr/I68HURpmngiz9FiVH167tKzJsZSA89ARK7fkJblfeq3VP6Nyg8VBpl0wKdXQBBSkNKt8cR3atokCTOjGRabWsWlzRXlrkB0+pvDFHppLdWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747256123; c=relaxed/simple;
	bh=XI3xgfAZdwvDWzRCy7jilpDXrXPyCBgl3gT7OpRxpqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWgHIPAjqAdvT+r55krpmkHMo0EyAQuOuKua2rS4JKDDmJ1y/4D52YWyktK4uQ+ygryaYNFHRwLb7tQWnohN73VQF7fM+F/o/0zxt19QCm2DbwD3bbrk7hapn0wdKUQKxsOsUz/xXh6SuOXg4BF1ucMHXqodVEHJXnnoBQ2CiW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sd4Tg7iV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52475C4CEE3;
	Wed, 14 May 2025 20:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747256123;
	bh=XI3xgfAZdwvDWzRCy7jilpDXrXPyCBgl3gT7OpRxpqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sd4Tg7iVw9a3co6ia/HEJyfU4qAMGV5ADJVZuvdFjfpR8ubXd+5rQhM3p/FuieE27
	 SWP/qk39rgoRHVefCSLTj4mqFWpORhdqDx8REFM7pRU3sV6Cb5uRaxB21ideGeMkzB
	 CxKXF6sSGTbgU5Jc2gBpNXQN35ENq28Ojmt+4TeGHSW5ht/8mMawq629lOtSzRGoAW
	 296XCAd2dbMB59OLB2uJPyBECZUGnZ0LIRrtSWaosrzqpWoBLJc1zZK8aiNNF34vIu
	 aJiMiJ726GB5DJGH2AUIfQATNdkh2/gjDaP1ZmZtHg5sWderift4sCUQp23/OHLdVc
	 PNnsSPcx8orxg==
Date: Wed, 14 May 2025 15:55:21 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	asahi@lists.linux.dev, linux-pm@vger.kernel.org,
	Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <brgl@bgdev.pl>, devicetree@vger.kernel.org,
	Janne Grunau <j@jannau.net>, Lee Jones <lee@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Neal Gompa <neal@gompa.dev>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 01/10] dt-bindings: gpio: Add Apple Mac SMC GPIO block
Message-ID: <174725612106.3020225.7096153668435332244.robh@kernel.org>
References: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
 <20250511-smc-6-15-v5-1-f5980bdb18bd@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511-smc-6-15-v5-1-f5980bdb18bd@svenpeter.dev>


On Sun, 11 May 2025 08:18:36 +0000, Sven Peter wrote:
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> 
> Add the DT binding for the Apple Mac System Management Controller GPIOs.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../devicetree/bindings/gpio/apple,smc-gpio.yaml   | 37 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 38 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


