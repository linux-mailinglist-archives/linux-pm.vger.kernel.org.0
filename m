Return-Path: <linux-pm+bounces-22861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2EAA4339F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 04:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFF0172B6D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 03:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597A18FDC6;
	Tue, 25 Feb 2025 03:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lVnvIeUG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F392A1D8;
	Tue, 25 Feb 2025 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740454441; cv=none; b=H3A87uAda3jgPjkBn4zJV3MTA5tMJH3OTLpsu6mwWitWh+gJh/f8MCh0Xtdr1QCXb3QYhsby5QlR+aLlIJnP0v0EAqKLAWFR3AT2hKb7IO/3zoR4DWXifd1ITxzu0i+W+AHa6F8UlgNUbCAmGyY4vAy1jX+6uOHex3hQtm8O/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740454441; c=relaxed/simple;
	bh=y3mGs7t8+XJevVGwbZ9T7FmAJL8mZauQ4VHUHxSwQHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz7OSA+QuljVS9a5siQQZT/vEp1ngriNVNY2moKk54Pf4Q35JMZiUte0oQ9WubHm2vdZ5Lb3zIO0cqxpcGFjW8iqo5wrwig94KAnoa9Ca0dapMAnNCP2HzUBuP/DIBySEu7Gmy9oalhiZbZPEGWcz+iULvrgiFEnWRpc8zf+wYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lVnvIeUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C1AC4CEE2;
	Tue, 25 Feb 2025 03:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740454440;
	bh=y3mGs7t8+XJevVGwbZ9T7FmAJL8mZauQ4VHUHxSwQHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVnvIeUGlnR0l7YZJER4iGQ9MWbTjhIUhOjPmUpINQt1S4ny3x693z1aPJ6dD93WS
	 51ndlCJfyT4Vj6LIU43ztRrqekg8qxlG+CYoh1zjefQ42oDSrD6crY7Cf9qAKQS4k+
	 X1eetoJyCvc+rjPCHlmZ5uNgcCqcdkTY8P7Ffs+U=
Date: Tue, 25 Feb 2025 04:32:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Samuel Holland <samuel@sholland.org>,
	David Lechner <david@lechnology.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/7] usb: common: usb-conn-gpio: switch psy_cfg from
 of_node to fwnode
Message-ID: <2025022542-recital-ebony-d9b5@gregkh>
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-3-d5e4369936bb@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-3-d5e4369936bb@collabora.com>

On Tue, Feb 25, 2025 at 12:21:36AM +0100, Sebastian Reichel wrote:
> In order to remove .of_node from the power_supply_config struct,
> use .fwnode instead.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/usb/common/usb-conn-gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
> index aa710b50791b0282be0a6a26cffdd981b794acaa..1e36be2a28fd5ca5e1495b7923e4d3e25d7cedef 100644
> --- a/drivers/usb/common/usb-conn-gpio.c
> +++ b/drivers/usb/common/usb-conn-gpio.c
> @@ -158,7 +158,7 @@ static int usb_conn_psy_register(struct usb_conn_info *info)
>  	struct device *dev = info->dev;
>  	struct power_supply_desc *desc = &info->desc;
>  	struct power_supply_config cfg = {
> -		.of_node = dev->of_node,
> +		.fwnode = dev_fwnode(dev),
>  	};
>  
>  	desc->name = "usb-charger";
> 
> -- 
> 2.47.2

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

