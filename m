Return-Path: <linux-pm+bounces-37498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AEFC397BF
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 09:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B9AD63502CA
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 08:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D392FFDE8;
	Thu,  6 Nov 2025 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaMpff5u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C42FFDCE;
	Thu,  6 Nov 2025 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762416049; cv=none; b=EgQOXpMuUvAUjEUEsaEtRq0sl/RLB/WzWBw1c+VoRpiKVH/MqxdiEaNUOh8AFOvOyyQFkpnY8U5m3QyuINPB97E/Qxw+ws8KcVMy9+Dei29dF1ix321MpksfJeOwdNfoeHylsiiieoyk7rgcUU+7tG3kC5oTZ6p949Or6j8Au68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762416049; c=relaxed/simple;
	bh=45on0mQEJNXhkLCVWCtk8c5NFmV1NROMIVn+DN3yc9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K188KMISaDW/Dfng4f5WOwm5eHwOhG4EXI54tnAxd1/J+I4ig9U2dmsR9HkQnZMStIUhRsmR3P1tnMcMrkQIiLRmsy75QB8MTP+Npp4ebS0nlu0MCuvnTtDsZmNl9rBE5lmpxd9Kg9LK+gO3jMBF85k3e/mVuO3XMoFNa4PflWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaMpff5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0062C16AAE;
	Thu,  6 Nov 2025 08:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762416048;
	bh=45on0mQEJNXhkLCVWCtk8c5NFmV1NROMIVn+DN3yc9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kaMpff5u+ZOX4yqZ7ZCmCQf0fgdVehDztu3JJEmtCK/Hp3IAgVy+2xpwxobUW48MX
	 lj1CNwO3w5y8uXdB3nNoKXYjByBBHbHHf6uTZ1ylwmAclhvy0eBQ2EfM1Tky/OdhJq
	 4iycXMhK/JZ5oAn8uvP7jUynCZjsnpIqVkNDrTRiuc8r8N9fEKg8m1VXoJr//K+5Z6
	 GMCpHxhrwdx7fvRIOVv0Y9sFcQ2n4GsUbCBW1eVvWFoufuharfV/eIrPEL/DYbJkRU
	 SpjL5e0+atV1eFRhudCKki9uSYOnO/kCNBEBoilQFpB2qKnKY8jGGfObVbOWdjVKeE
	 bykQC3xIZGxxw==
Date: Thu, 6 Nov 2025 09:00:46 +0100
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
Subject: Re: [PATCH v3 02/16] dt-bindings: battery: Clarify trickle-charge
Message-ID: <20251106-aloof-unyielding-turaco-c9a51a@kuoka>
References: <cover.1762327887.git.mazziesaccount@gmail.com>
 <742fcdcc8b6dcb5989418e8c1cf5a7d7ba5434a5.1762327887.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <742fcdcc8b6dcb5989418e8c1cf5a7d7ba5434a5.1762327887.git.mazziesaccount@gmail.com>

On Wed, Nov 05, 2025 at 09:36:16AM +0200, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The term 'trickle-charging' is used to describe a very slow charging
> phase, where electrons "trickle-in" the battery.
> 
> There are two different use-cases for this type of charging. At least
> some Li-Ion batteries can benefit from very slow, constant current,
> pre-pre phase 'trickle-charging', if a battery is very empty.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


