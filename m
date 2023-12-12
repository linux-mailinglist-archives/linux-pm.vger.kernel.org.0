Return-Path: <linux-pm+bounces-1024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE29880F9C0
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 22:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B5428211B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 21:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA19A64CC1;
	Tue, 12 Dec 2023 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzsvwnlo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A892A65A98;
	Tue, 12 Dec 2023 21:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FF1C433C7;
	Tue, 12 Dec 2023 21:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702417805;
	bh=6ogrBXo4J5g4zBXsQOlW0y4FIDZEwSmJ8vaSdXm00eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rzsvwnlo32fqTtf3/7LvOn0kX55GFA+RKbr8qR84zmtyBxBr8Z27rXb4U/6Pub9MR
	 SZPALCeQvn2083UU6DzF9G7YUneqS+diLCLU8LotEsI+v9qPOxZhj11odGxvk5n6Iu
	 yYJwm5kUuY6Vy6D9LYgAhKLUqWGU9OnXxgbB18lXh+hcvu9SPljiZMuBhOwujYPV8b
	 x5LlP7Gs6hZTDH8OmivofNGvAtf7K8ZIEwfbXCbp83wdffTbNJmxqjofNZEOFXBNyK
	 0sZ4swf7yt8LFaX5CAqYXb07ZoIeMFPXObopMU3OU3jhLSRBwnsDhIjjrrajdlI1xP
	 MnbKaOMp5BiWw==
Date: Tue, 12 Dec 2023 14:50:02 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] power: reset: at91: mark at91_wakeup_status non-__init
Message-ID: <20231212215002.GA3300655@dev-arch.thelio-3990X>
References: <20231212214658.213510-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212214658.213510-1-arnd@kernel.org>

On Tue, Dec 12, 2023 at 10:46:49PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Two copies of the at91_wakeup_status() function are called by the
> respective probe() callbacks and are marked __init, but the probe
> functions are no longer annotated that way. This works with gcc because
> the functions always get inlined, but clang keeps them separate, which
> can lead to executing freed memory:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: at91_poweroff_probe+0x80 (section: .text) -> at91_wakeup_status (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: at91_shdwc_probe+0xcc (section: .text) -> at91_wakeup_status (section: .init.text)
> 
> Drop the incorrect annotation on these.
> 
> Fixes: 099806de68b7 ("power: reset: at91-poweroff: Stop using module_platform_driver_probe()")
> Fixes: dde74a5de817 ("power: reset: at91-sama5d2_shdwc: Stop using module_platform_driver_probe()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, I sent the same change three weeks ago at this point:

https://lore.kernel.org/20231120-fix-at91-modpost-warnings-v1-1-813671933863@kernel.org/

Your commit message is a little better than mine and I don't really care
which one goes in but it would be good if this could get cleared up
soon...

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/power/reset/at91-poweroff.c      | 2 +-
>  drivers/power/reset/at91-sama5d2_shdwc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
> index 126e774e210c..93eece027865 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -57,7 +57,7 @@ static struct shdwc {
>  	void __iomem *mpddrc_base;
>  } at91_shdwc;
>  
> -static void __init at91_wakeup_status(struct platform_device *pdev)
> +static void at91_wakeup_status(struct platform_device *pdev)
>  {
>  	const char *reason;
>  	u32 reg = readl(at91_shdwc.shdwc_base + AT91_SHDW_SR);
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index af95c7b39cb3..959ce0dbe91d 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -107,7 +107,7 @@ static const unsigned long long sdwc_dbc_period[] = {
>  	0, 3, 32, 512, 4096, 32768,
>  };
>  
> -static void __init at91_wakeup_status(struct platform_device *pdev)
> +static void at91_wakeup_status(struct platform_device *pdev)
>  {
>  	struct shdwc *shdw = platform_get_drvdata(pdev);
>  	const struct reg_config *rcfg = shdw->rcfg;
> -- 
> 2.39.2
> 
> 

