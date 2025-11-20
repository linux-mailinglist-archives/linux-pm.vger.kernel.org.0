Return-Path: <linux-pm+bounces-38313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37988C755A3
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 17:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E2284F135B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 16:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BE53644A7;
	Thu, 20 Nov 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6sZSIw/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B334DB48;
	Thu, 20 Nov 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655082; cv=none; b=G69n3XuZnPnLCOJ3HGO2JVaCUvScpqfAEoUr+2a5WIzwMlDC7tNhqXTkscb1K/pRCZiMhfnggOTJtGUBQFYbDUt0mg9tKRcX1jOr7GE9vIzXVSNXC8pok6d9jsf1z9gJOCBjHBf/Rt/9LiN9HQwzGFxZz48woeya3GKF58XAn00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655082; c=relaxed/simple;
	bh=BbjFmvnZpIAYJemMHM1v/+EA292tt6R+P8dHMuj7Xbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDIUMhTfUbVvhr0XM1i/7RYf07JjFCUhsmnP1BYcX5uav6viwyi+Of0vhJva7IgBAATwQ5wEG+D7Q03ZyXy7DZRCfwxZ5VxflJS2H9Pb7ZmX7w/H3+xf0/RxeXNDFUoVXkGqB1KUsT+bvMPEnbe0XGjS3wPcfiCAmdI0iNBjZe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6sZSIw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7944BC16AAE;
	Thu, 20 Nov 2025 16:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763655081;
	bh=BbjFmvnZpIAYJemMHM1v/+EA292tt6R+P8dHMuj7Xbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6sZSIw/JPOJ5KPAnyvMTDJJwbyriGW5UTQEbsjE6QELz2EfAY2mJp36zyAAt0b+y
	 +vswlXRwsb0Sxxg8huowpVFhvSMiHekutXcQKmGpubePU5D60wuTCeWev9J/6Fu+op
	 cCSRGK1ecV/0eAkS9q+wD2uL2rM/iY1F7eOaa/u0kGHEoe9bkUCWrAbKWPBad3dSJT
	 N2euymlkYqScUvei7EX4PwXMWXXmS+KZjw9lh/5DnWGrDlxud6l/CIoB+5tVAJ2r48
	 Fnk6TPbYFHVm8R935wu3uLwRsCucySQuCtStJiF1UoblbTDE8eVGumiMuEoLObpe/g
	 VTBQZGKbhUaKw==
Date: Thu, 20 Nov 2025 10:11:19 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Pavel Machek <pavel@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-gpio@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-clk@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-rtc@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v5 04/16] dt-bindings: battery: Voltage drop properties
Message-ID: <176365507949.1467967.14779548559679744817.robh@kernel.org>
References: <cover.1763625920.git.mazziesaccount@gmail.com>
 <93768cba6688714756fca49cc57d46a111885863.1763625920.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93768cba6688714756fca49cc57d46a111885863.1763625920.git.mazziesaccount@gmail.com>


On Thu, 20 Nov 2025 10:20:24 +0200, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ROHM has developed a so called "zero-correction" -algorithm to improve
> the fuel-gauging accuracy close to the point where battery is depleted.
> This relies on battery specific "VDR" (voltage drop rate) tables, which
> are measured from the battery, and which describe the voltage drop rate.
> More thorough explanation about the "zero correction" and "VDR"
> parameters is here:
> https://lore.kernel.org/all/676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com/
> 
> Document the VDR zero-correction specific battery properties used by the
> BD71815, BD71828, BD72720 and some other ROHM chargers. (Note, charger
> drivers aren't upstream yet).
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> 
> Revision history:
>  v4 => v5:
>  - Move volt-drop parameters from rohm,vdr-battry,yaml to the
>    battery.yaml
>  - drop rohm, -prefix from volt-drop-* properties
>  - Drop the rohm,vdr-battry,yaml
>  - Add comment clarifying what the rohm,volt-drop-* properties are for
>    because this may no longer be obvious as they were moved to common
>    battery.yaml
>  - Drop Linus Walleij's rb-tag because the concept was changed
> 
>  v3 => v4:
>  - No changes
> 
>  v2 => v3:
>  - Constrain VDR threshold voltage to 48V
>  - Use standard '-bp' -suffix for the rohm,volt-drop-soc
> 
>  RFCv1 => v2:
>  - Add units to rohm,volt-drop-soc (tenths of %)
>  - Give real temperatures matching the VDR tables, instead of vague
>    'high', 'normal', 'low', 'very low'. (Add table of temperatures and
>    use number matching the right temperature index in the VDR table name).
>  - Fix typoed 'algorithm' in commit message.
> 
> The parameters are describing the battery voltage drop rates - so they
> are properties of the battery, not the charger. Thus they do not belong
> in the charger node.
> 
> The right place for them is the battery node, which is described by the
> generic "battery.yaml". There were some discussion whether these
> properties should be in their own file, or if they should be added to
> battery.yaml. Discussion can be found from:
> https://lore.kernel.org/all/52b99bf7-bfea-4cee-aa57-4c13e87eaa0d@gmail.com/
> This patch implements the volt-drop properties as generic (not vemdor
> specific) properties in the battery.yaml. It's worth noting that these
> properties are:
> 
>   - Meaningful only for those charger drivers which have the VDR
>     algorithm implemented. (And even though the algorithm is not charger
>     specific, AFAICS, it is currently only used by some ROHM PMIC
>     drivers).
>   - Technique of measuring the VDR tables for a battery is not widely
>     known. AFAICS, only folks at ROHM are measuring those for some
>     customer products. We do have those tables available for some of the
>     products, like Kobo e-readers though.
> ---
>  .../bindings/power/supply/battery.yaml        | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


