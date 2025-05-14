Return-Path: <linux-pm+bounces-27162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC90AB776A
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 22:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E961BA58B1
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 20:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C66F29670A;
	Wed, 14 May 2025 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKjA/3US"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0674AE55B;
	Wed, 14 May 2025 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747256182; cv=none; b=lI+LP7OxvXbB43uQRERH+009bpk9KQR4x1hH5AUu6PrEkVncRVrtCT+yFHDPpbrACFD/ZBVSCLF/Y5kro/qyh/yyZry3nXz8M6bdV5ZZiuojleTqfAeWvsq5F7pqrIvuiRdCd3IKeW/7rkj1S33FXMkcGwabxxcammXDy9Hu9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747256182; c=relaxed/simple;
	bh=LzcztWerU4pmt8hh0TJh4jLsvk6/oUYWuswSfEQJhA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAgjP9MKjYjEZcSxokYeUhEMwcilyzDnTRnB8JN1bHn1R355xk1mrVsVmgZXOArXqrc5owDAfUaJeojzXJSfdQGSIoB+O8604tPtZsbgoqyOFrFrvQpyxGTIQvvlusEg7a8I9Z5mKQb33kqI94LDKrhDr7zfiz784kl264wk/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKjA/3US; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A225C4CEE3;
	Wed, 14 May 2025 20:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747256179;
	bh=LzcztWerU4pmt8hh0TJh4jLsvk6/oUYWuswSfEQJhA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKjA/3US6VvMiYWEFfxUTPcVRsgkq/fkEDd1FECDu3ML/8zXXjCtRGVqsgM8wCUH5
	 +ly2bPAmH0DwK6dNZL892QlHnLHhFjDitrtw52TwhPFYhT+LUEv5yuC7EW/yskCSy2
	 eNJNgCzxtKIuXEoYdQyC00fVdaiCxVlLuYEM1mvp5kXyJEcPNzlZJs92pnXqpwijHT
	 MqAKCgjWf+09vWbdG9ViS23iPDY5zWJnOCJwri1XSKRIhmd23wvZWVmMQ/vyJPgI9L
	 Sz6X2Oiqd7Iy9MO31pjPyE+UlaqzGmrWv5IASpHjm7eqrfGR6ceJ9sxNHOUTvroicT
	 TSbs3g75uA6lg==
Date: Wed, 14 May 2025 15:56:17 -0500
From: Rob Herring <robh@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 02/10] dt-bindings: power: reboot: Add Apple Mac SMC
 Reboot Controller
Message-ID: <20250514205617.GA3020430-robh@kernel.org>
References: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
 <20250511-smc-6-15-v5-2-f5980bdb18bd@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511-smc-6-15-v5-2-f5980bdb18bd@svenpeter.dev>

On Sun, May 11, 2025 at 08:18:37AM +0000, Sven Peter wrote:
> On Apple Silicon machines a clean shutdown or reboot requires
> talking to SMC and writing to NVMEM cells. Add a binding for
> this MFD sub-device.
> 
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../bindings/power/reset/apple,smc-reboot.yaml     | 52 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml b/Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..e55e524914c2f57f7acf239fdefcbdc7a993b69f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/apple,smc-reboot.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SMC Reboot Controller
> +
> +description: |

Don't need '|' here.

> +  The Apple System Management Controller (SMC) provides reboot functionality
> +  on Apple Silicon SoCs. It uses NVMEM cells to store and track various
> +  system state information related to boot, shutdown, and panic events.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

