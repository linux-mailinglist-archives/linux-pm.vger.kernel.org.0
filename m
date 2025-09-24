Return-Path: <linux-pm+bounces-35262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08C8B97E9A
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 02:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0E8323E4B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 00:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AD519ABC6;
	Wed, 24 Sep 2025 00:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnbO/Ue6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E06192D8A;
	Wed, 24 Sep 2025 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674144; cv=none; b=FgJNJXsSPYN8EBOo8gjdvhyosd9MGYzOT3lfS1HS5KfQPugdL30RUuSpUeqB7pYfbQThPdKjfeNh68eBwBieGy4Tmpkkv5fPRWgihURqXUHp4hQw1cTHUz+TlBa/LDKckPJ08pEXxPHUO77exC+SRSo+L9JCOXm+aIYKLGheYow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674144; c=relaxed/simple;
	bh=DRhxi2T0h0T058uT0q5WDIBIuhGBboq7dtvoADz/Vcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYUlfRe0/N1CXoke1vE+kKixO6G1MwmiBQ+JVTjl/gd+ZHJQek7py+MpMFJVkZ5eYAEj2vcU4js1lOEqPvtirynhQd7okG9dJkgjZvxPZ30xc2RHhYNkjfBY4Tlp+NL8vOsS8Bba5CBsPDgtKGw6nBEJ3UBLe3L3M1SQjNH9iqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnbO/Ue6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DBBC4CEF5;
	Wed, 24 Sep 2025 00:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758674143;
	bh=DRhxi2T0h0T058uT0q5WDIBIuhGBboq7dtvoADz/Vcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rnbO/Ue6pEe98CQSQtGfI/WCHp27rIl9ETccr9wK+XKbPEhAVgOEGrmuG5DdpnxYB
	 6V2epqcVFYfp6oNtXqyPk2zHR++EaJK21xyt50aEfVAg8Bh8K/nbuTVeEpEqIWtwAb
	 KXVY1tj1exQGp2xVpevO/ziNcdTCFWrLiAfB3uAvrREIb6SYKMzJPotf3swUuapCSY
	 BFY17Z56mWjoU7tKyyVmISX+fR8PZbEAJBxY7jKlLW+JXQoNIddc05W0Zd2dHI1Zpb
	 14Qh/897rQXmwBSe20Lwo84HWIC38peCrSERGRqLRl0H+Ckpo/UGlBhPaU2tdiYWcz
	 G65sFg9c4Rrfw==
Date: Wed, 24 Sep 2025 08:35:37 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH v4 3/5] usb: chipidea: core: detach power domain for
 ci_hdrc platform device
Message-ID: <aNM82SUSoQN6cKkD@nchen-desktop>
References: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
 <20250922-pm-v4-v4-3-ef48428e8fe0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922-pm-v4-v4-3-ef48428e8fe0@nxp.com>

On 25-09-22 10:21:08, Peng Fan wrote:
> From: Xu Yang <xu.yang_2@nxp.com>
> 
> When add a platform device by calling ci_hdrc_add_device(), this device
> will reuse OF node of its parent device. If power-domains property is
> provided in the OF node, both two platform devices will be attached to
> the same power domain. This should be unnecessary and may bring other
> inconsistent behavior. For example, to support wakeup capability, these
> two platform device need different power domain state. The parent device
> need NOT power domain on for out-band interrupt, but the ci_hdrc device
> need power domain on for in-band interrupt. The i.MX95 Soc support
> out-band wakeup interrupt, the user need to enable wakeup for the parent
> device, but if the user also enable wakeup for ci_hdrc device, the power
> domain will keep at on state finally. To exclude such inconsistent
> behavior and simplify the power management, detach power domain for ci_hdrc
> platform device.
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter

> ---
>  drivers/usb/chipidea/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 694b4a8e4e1d8583dcbf4a42f8c2dfd785d5745c..70597f40b9997a9766934c67bbbed38e96c210f8 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -27,6 +27,7 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
> @@ -915,6 +916,8 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
>  	if (ret)
>  		goto err;
>  
> +	dev_pm_domain_detach(&pdev->dev, false);
> +
>  	return pdev;
>  
>  err:
> 
> -- 
> 2.37.1
> 

-- 

Best regards,
Peter

