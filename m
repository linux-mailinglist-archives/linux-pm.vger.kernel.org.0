Return-Path: <linux-pm+bounces-36958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AACEC138A6
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 09:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 252CC4FA006
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 08:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716772D876F;
	Tue, 28 Oct 2025 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bErXYxOq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C724C068;
	Tue, 28 Oct 2025 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639943; cv=none; b=hOP4joPez2/020lje2I1+pv6K2N5rSsMNmBK0n1j3B1lYamw0OvVp6e9+FKGD+bSyLZpWQkFNtE4te+voehswezbAu0Mh3c3O32NRCdshb2ogP5e8Lm93rOr1GmaD6/778QsqdJW56oWF7VqDVn0FbcIgywQhSDaGFFoLpGqhvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639943; c=relaxed/simple;
	bh=BGLHI15OIhr0mx0wtAC1PBfsCC3+JWLqQ+LEeMy407M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0CNrNhxb+w6P5Qoe6FCUM0V+b52JDGpDiWzzRlCx4CE1ahT0GHfkTHlMgtgNrZpdQ/6kRqVwG2Yly/wucbuSBqyAUBaQWf8OIR1Ata7LycBKfgNJvw6+RwJ4TPn3kG4UZlxbNcjXBnvjt0qg6/Uwe+KGaX2inuF9TcSR2SPzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bErXYxOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674FCC4CEE7;
	Tue, 28 Oct 2025 08:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761639942;
	bh=BGLHI15OIhr0mx0wtAC1PBfsCC3+JWLqQ+LEeMy407M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bErXYxOqO9j4761ugrqbIqEfKLRzl229Sce6osceYbs2ZVoNaiX+EndqE7zv6xkwl
	 +C7EdozcnXILbJNBSeCr2yx0PlfksKFhd3RU9WU1/Irtpu7wP5ku7fbp10jHsqL21f
	 iSKh7om+vJNcc+uk8r6BL3rXrv8IJxoUa3rzEvXjPmOGBelnVw/+NNCofKVsQppzI3
	 H8fNAJ5azfpGktLvMO51b14NP43VtdXZ5nRXk3cV55MC2QQQRWfcWOugNqmQiz3uGf
	 OyFQDqWNzBaDIeOOolTVurFoF0mQ214tnY4eNVquKBnHRZxoB38FAHzPU6Q+fIL3pG
	 RN38roBS+tehg==
Date: Tue, 28 Oct 2025 09:25:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 05/15] dt-bindings: leds: bd72720: Add BD72720
Message-ID: <20251028-discerning-opal-mushroom-df7859@kuoka>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <fae1285b43acdd19cebfcfbcf4530bf90064f601.1761564043.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fae1285b43acdd19cebfcfbcf4530bf90064f601.1761564043.git.mazziesaccount@gmail.com>

On Mon, Oct 27, 2025 at 01:46:04PM +0200, Matti Vaittinen wrote:
> Add the ROHM BD72720 documentation to the binding documents.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


