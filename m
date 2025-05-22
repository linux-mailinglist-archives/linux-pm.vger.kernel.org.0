Return-Path: <linux-pm+bounces-27498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B12DAC080C
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 10:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518294A055E
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 08:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F834286413;
	Thu, 22 May 2025 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7/ESCQo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584A2281531;
	Thu, 22 May 2025 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904353; cv=none; b=eE1JDRLzi7cZYjJj8sbOXxOwBnjU1gGiL4fu/nEPF7O+UQA5kB6TyWIgWk5KGav99sKc4Jo4VMM+VBhU2VSgYUNHQlxr7BM7gzWKNNyhRCMTF4Ae6lemEqtWW8ve5dJmUqWiEdTXIcgYI1YwfcJ0/o4Eq990IsrYo8n0CLWaVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904353; c=relaxed/simple;
	bh=F+UaMKsaTaM23XM2k8ATYaf6ORfK+hGHKXw+SidOvP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaxJaPo0MSjVIdZluGzEs4uV4Unw7iBgGngsb9rfCdL00MVx3sF7uDRowbAoK33vgs7pu8yArElpaHKj6ZG09e2KyhqE2vNydgYGmLF/n0FAM4qOJbeLz5fSD14vt5aTdpIYfLE3iwmRelEsA1RVNRU9/VkV7qGRnBpVp9gyyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7/ESCQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43286C4CEE4;
	Thu, 22 May 2025 08:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747904352;
	bh=F+UaMKsaTaM23XM2k8ATYaf6ORfK+hGHKXw+SidOvP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7/ESCQoDO8xpAYpb+TppNiGZuXD5kGBMkqEXzyjHKG58NZQ51X20EicgGsjmDVWf
	 k4w9RLdbhirJCnP+M0h925cuPMimyMsxAWwOoiOJgNoctuAh0Dhxbt9qERxyNJionC
	 PRiYKhMolbpRhCrnlNpWWy8fRRc8nRJT5ABEjOmKP+buMPt4qLkzijSFAiBXOCqiDP
	 E9QzVu+v82JG7fylZCh6T5qq6Rqf8BPjIBhXB+2qGmJHyUiE6QHSjQDMkCAyyivlbq
	 c9PraU0EWUzPy9MM4Dsr1b4BaQVdzc+qv8QHGxeFFfHW+pXEzxI803IAPDeGvO4LhV
	 wFgOe8d2pMqGg==
Date: Thu, 22 May 2025 09:59:06 +0100
From: Lee Jones <lee@kernel.org>
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Marc Zyngier <maz@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 05/10] mfd: Add Apple Silicon System Management
 Controller
Message-ID: <20250522085906.GA1199143@google.com>
References: <20250515-smc-6-15-v6-0-c47b1ef4b0ae@svenpeter.dev>
 <20250515-smc-6-15-v6-5-c47b1ef4b0ae@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515-smc-6-15-v6-5-c47b1ef4b0ae@svenpeter.dev>

On Thu, 15 May 2025, Sven Peter via B4 Relay wrote:

> From: Sven Peter <sven@svenpeter.dev>
> 
> The System Management Controller (SMC) on Apple Silicon machines is a
> piece of hardware that exposes various functionalities such as
> temperature sensors, voltage/power meters, shutdown/reboot handling,
> GPIOs and more.
> 
> Communication happens via a shared mailbox using the RTKit protocol
> which is also used for other co-processors. The SMC protocol then allows
> reading and writing many different keys which implement the various
> features. The MFD core device handles this protocol and exposes it
> to the sub-devices.
> 
> Some of the sub-devices are potentially also useful on pre-M1 Apple
> machines and support for SMCs on these machines can be added at a later
> time.
> 
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  MAINTAINERS                |   2 +
>  drivers/mfd/Kconfig        |  18 ++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/macsmc.c       | 498 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/macsmc.h | 279 +++++++++++++++++++++++++
>  5 files changed, 798 insertions(+)

Arghhh, so close!

[...]

> +static struct platform_driver apple_smc_driver = {
> +	.driver = {
> +		.name = "mfd-macsmc",

Drop the 'mfd-' part please.

> +		.of_match_table = apple_smc_of_match,
> +	},
> +	.probe = apple_smc_probe,
> +};
> +module_platform_driver(apple_smc_driver);
> +
> +MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
> +MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
> +MODULE_LICENSE("Dual MIT/GPL");
> +MODULE_DESCRIPTION("Apple SMC driver");

I plan to apply this set after the merge-window.

What else are you waiting on?

-- 
Lee Jones [李琼斯]

