Return-Path: <linux-pm+bounces-37008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DBDC185F9
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 07:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFD164E4357
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 06:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFB12FB990;
	Wed, 29 Oct 2025 06:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVp8mbJ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA25229B2E;
	Wed, 29 Oct 2025 06:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761717785; cv=none; b=lWPj2iT2xVG9hfwKznvWqMMFbcZyl+QjwPLOO0KgjmHqbvnqruf4Db5A5BL62XqRqyCES8Y54KjztaVdwIykx0YbT8wzp0gaA4KFKxWwGHGfYJdNael8gNh6Q+KBC8NqOXGd8qrMgCzOqPHd9xgQRqo22B5VcdWBgqSJMooidJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761717785; c=relaxed/simple;
	bh=YrHXSkSziP250cVRScq0phJVMi2r3oBtH0D/zUlpBuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tppksPYV6dUIjrIaWEOvHd8JKSz4XaBqTeEN0/IV6VNXiDqBaa7mQ0ZJ5tuFY/k+JdF16Is7K5NFjlUomN6Fgmy57NKt5+IPfBjCDEJjGZd9U/HrmqScbIpDn+fNV+SOtRumQlAy0BtoSF/VJKRwzOvVyQjjlOVzBxjF0HmXQjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVp8mbJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04849C4CEF7;
	Wed, 29 Oct 2025 06:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761717785;
	bh=YrHXSkSziP250cVRScq0phJVMi2r3oBtH0D/zUlpBuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVp8mbJ+f1AtJM7ysqo48j/jMtEJGVLZ3OCElTVXnsOlhlWDFU29YM4/4SZjtN5r4
	 T/Hj4DbRRVO71H4yIaZpgpNwoWEfN/MQ2lU2qflBqvePiFKnJruIcyqv73CxnglftJ
	 y04Zkqi5qCXuxVoC6r4qDnl30bAij2NoXzmrgfkP+Xk9g4+m5hVebK540ljoAsf1GH
	 bowdD/Ip6rq9Cbz6GcdbyRowL4Da3GTvNByAeyjaZfQl1ukT2IUofkigJCCfqlsx5J
	 MRzttXvdsA5qjqrwiS6ECbL3RXL7RIAajDLtq3/jWOPUnjyoKmyqVZuBZuLhyJTk15
	 Wa/8WDnbnb+gQ==
Date: Wed, 29 Oct 2025 07:03:02 +0100
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
Subject: Re: [PATCH v2 02/15] dt-bindings: Add trickle-charge upper limit
Message-ID: <20251029-adamant-mamba-of-patience-cddb65@kuoka>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <b13b733e7e0fba05652f49f727412fed9e0ceb02.1761564043.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b13b733e7e0fba05652f49f727412fed9e0ceb02.1761564043.git.mazziesaccount@gmail.com>

On Mon, Oct 27, 2025 at 01:45:05PM +0200, Matti Vaittinen wrote:
> Some of the chargers for lithium-ion batteries use a trickle-charging as
> a first charging phase for very empty batteries, to "wake-up" the battery.

In the few cases I was dealing with charging circuits, trickle charging
was used in context of top-off charging, so when battery is 100%. It's
also documented at Wiki like that:
https://en.wikipedia.org/wiki/Trickle_charging

> Trickle-charging is a low current, constant current phase. After the
> voltage of the very empty battery has reached an upper limit for
> trickle charging, the pre-charge phase is started with a higher current.
> 
> Allow defining the upper limit for trickle charging voltage, after which
> the charging should be changed to the pre-charging.

pre-charging is the trickle charging, no? Or you want to say that
trickle-charging is pre-pre-charging? But then what is pre-charging in
this binding?

> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> ---
> Revision history:
>  RFCv1 =>:
>  - No changes
> ---
>  Documentation/devicetree/bindings/power/supply/battery.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
> index 491488e7b970..66bed24b3dee 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
> @@ -66,6 +66,9 @@ properties:
>    trickle-charge-current-microamp:
>      description: current for trickle-charge phase
>  
> +  tricklecharge-upper-limit-microvolt:

Please keep existing format, look three lines above. trickle-charge-....

But I believe this is wrong. Trickle charging does not switch to
anything more, there is no fast charging after trickle. You have some
sort of pre-pre-charging, which is just pre-charging.

Best regards,
Krzysztof


