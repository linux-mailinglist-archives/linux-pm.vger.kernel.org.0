Return-Path: <linux-pm+bounces-31086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C8BB0B021
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 15:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D4B1AA2AE9
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 13:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D4728751E;
	Sat, 19 Jul 2025 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg0Tr47K"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D210231824;
	Sat, 19 Jul 2025 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752929987; cv=none; b=IG7WzjOJKXLeWDUqH1Kqr+Oq8xdXgzosqVSOHpdrvdpl1BVtAaqicdtDMnAB9PCU2eiW6bo2xs6PHLzOezK2mFKm4iHtdmBmFlk6UmqiRt1xy42KrS6BQSlxCpiO1UCRQgW6tq6V/hU3MmxMH/ox+059/jmOUHqhKSowqNpx9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752929987; c=relaxed/simple;
	bh=Jc9LnpqRoxmgeWH+iMEHKogtW1KyENPU7ieXc3P23Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLNuwzAJCd7rHB4VrpaEONWtYTAx45xEdNs9lnZsaRyKk/jBNjNWSpZ6Ay8rqRjWI53gcj2J73LyK43f562+0VGSTDWyP9XOGtzky4meU7y+fe1dz+FxgtQlyzFUcD/tl6f3nROPJoy6hvxV9A1Blcdt/5cOe/TnzhiEnK6vgME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg0Tr47K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA0CC4CEE3;
	Sat, 19 Jul 2025 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752929986;
	bh=Jc9LnpqRoxmgeWH+iMEHKogtW1KyENPU7ieXc3P23Vo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gg0Tr47KgwUD6zd6eCkB12oPjZP7JAyA/YCnQWRSB3Pup6L+a4hyBtXxW6k/rodae
	 FXnDZejl08/gqQcwXhOg2xYXMpXaN85FXNFeInsFbKz7VQ88TUUZwfJvUZwkRuz9CD
	 V7Zv7F27l8RF1RRbLTNG3JiGuqFOjm5LKQ/gEtXcVTZ6tq2YCAT1R479CQp8hAChTT
	 D3yjNua5jR4ZFxUD9xDz208zX9oeoVmi9nEgADyKkrAHtI4S9KcTsNycfJN9xv/bXE
	 qybGuDllg+AiZ0OuNAmWQoRoHUk1I6p4YoNvS5ehBOQGQHhE5YLTqq/jnXg0dhKW3N
	 /pRhxG0FGKTmw==
Message-ID: <8f9fdb3e-9655-44ce-8a2f-c1628c88c929@kernel.org>
Date: Sat, 19 Jul 2025 14:59:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] gpio: Add new gpio-macsmc driver for Apple Macs
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Hector Martin <marcan@marcan.st>, Neal Gompa <neal@gompa.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-pm@vger.kernel.org, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Conor Dooley <conor+dt@kernel.org>,
 Janne Grunau <j@jannau.net>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
 <20250610-smc-6-15-v7-6-556cafd771d3@kernel.org>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250610-smc-6-15-v7-6-556cafd771d3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus, Bartosz,

top posting on purpose: are you fine if Lee takes this commit with the 
rest through his mfd tree?


Thanks,


Sven



On 10.06.25 17:29, Sven Peter wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> This driver implements the GPIO service on top of the SMC framework
> on Apple Mac machines. In particular, these are the GPIOs present in the
> PMU IC which are used to control power to certain on-board devices.
> 
> Although the underlying hardware supports various pin config settings
> (input/output, open drain, etc.), this driver does not implement that
> functionality and leaves it up to the firmware to configure things
> properly. We also don't yet support interrupts/events. This is
> sufficient for device power control, which is the only thing we need to
> support at this point. More features will be implemented when needed.
> 
> To our knowledge, only Apple Silicon Macs implement this SMC feature.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Sven Peter <sven@kernel.org>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>   MAINTAINERS                |   1 +
>   drivers/gpio/Kconfig       |  10 ++
>   drivers/gpio/Makefile      |   1 +
>   drivers/gpio/gpio-macsmc.c | 292 +++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 304 insertions(+)

[...]

