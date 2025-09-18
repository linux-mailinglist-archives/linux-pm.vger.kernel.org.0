Return-Path: <linux-pm+bounces-34968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5DCB85839
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478571C87EFD
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC48224AE8;
	Thu, 18 Sep 2025 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0Pvj4mc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880F260B8A
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208344; cv=none; b=Qt8+ujQQLzukph4Su7xz3GBPb5fe7myB99dcdZFMCqFBA2eaqlxdMmlE9wPGEZsQB2fMHgKS8UqzBHs3J6pcPOcS5S5uVHaNqcHDaANRB5HlrXz08Zf1E2BzWvXLfBr7dzYsVCBKVVIYW0MTUeydZvA4rCy0MsWRASmOhkdhhxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208344; c=relaxed/simple;
	bh=JKfm6NN2B2hHRdonJoxuB513WOjuDHT7I18uTla7p1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOEkfzT9iuE1u8hjm1F/lAR/VazgqswGUg2jM6bVtz77o6F7HBiDPGzjB7qex9qoY3mZf38iIMYTgjWK3NL8XYmbXo9ShaR316SlPkUQF37/CazYhFO/qrU21+ADK66wn3zQs2N7XlqcuPnSBPlIBvio/wWDFNZM8iBZroOPXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0Pvj4mc; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-724b9ba77d5so11558727b3.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758208340; x=1758813140; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzEB3oyqwg8o4qvK1OgqXlnhNgSoMuFMpP/k/75t3xc=;
        b=G0Pvj4mccHzwuYV+T73SVAtcgCz2GmGWizbF97pCuU6JO7qTtllZs5hFpr1+X1yTzH
         Yt6DXgCI0Z9dYdmyfFJwQcxOj9PotF1kn+mpe2jEoV6N8APfa8t1MXOuaIVl021FunhM
         711fdERrvAoBAeUEiHngD/DzM2cLihvIeqzBKYD4N4n/t+AUIQ2yvYBPh0B9+0Tw1dwM
         cWUTUZ0lsh7GLE9D1gC2MZxdxvGMObNv7aLfBQIf0R/5D+/1MYQ1BlQ7cEQBwyo+qVcI
         jThbei/hAPMFHmsUa5xVPdf6PTdtLMtiveq0k7RwX9gssqwi0cr9IBiRy0oYKsqdhmDW
         /UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208340; x=1758813140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzEB3oyqwg8o4qvK1OgqXlnhNgSoMuFMpP/k/75t3xc=;
        b=MPZGWj33JmO5OmFOBRhoUPoEZQPEndFmqKv2SpRvV44k0z9SnuUkHfy5lwGkRXexKa
         6z8PVCdDXvYrHA/XZBEs9m2ngvNw/qsnO09/z6CWhU7yGizyVW33CqDzVoWAPwlxzJNV
         WNbxVUW7FiQSARCHzivfo/bxSq5IqEl1a1/2TONaZP/yJiqaaPOVhzQaJjPj9YrDd5H7
         24DiH8k9nlh4jMevyFEJg2wnvE5K1fU/TsfywH2zU6o0FtWfjEwNaNS0K3RVN/Ps9o89
         LTI04Ite3L8PCUWQ01J6wYu2MwtKjofO7riOM3O2sDqGG50eG5rxJj3Hbg/EO8X/c0Ku
         moug==
X-Forwarded-Encrypted: i=1; AJvYcCXtTcFsFHgaSu2Gmq/mMVRsQq2Wdftvk+D/8/bVd7h69HsMKMviBNOom5iqasbugpoS4ize4TVocg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTMnURzZVXmVA8HI0AXW64+6ciEDZti33TQDwjvRdKlsc/eNrU
	S8mdiNwwAeAh8cz+QZVEq+iThJWMhpRm1y9Rxsm3otbUht3C6TtmFC5+3Bqxh0rWszv5Zw7vS/A
	dhapajA4KNYJ0afJ9/SE91gkYh2wq5ysRFWstViSjnA==
X-Gm-Gg: ASbGncvVoVo1ka7an6QpedotI0GBjU9FpsTVZNd+CAI/oLZqRTwL6zID5cEN69+8VFv
	M2D7AxL8cxEy8AGzP8A3vfipJo3d/5tukk/CiNfigRLtaSLkbWXXwCS+490vPojOMxfVBDXD4QA
	7vlZ9pZaGOkPNZDIbv22jdW8IX+BVbBN3QyLSh07qDeFXZgHe0j9Kj3JLfNVGeAyjk67ju+tPpo
	E3b1VeRv9c6oHrq0vaQ4ARJYB5y9U601Qok7A==
X-Google-Smtp-Source: AGHT+IFOOt5NOlhICVzaBKD3GERcW4IuNpGDCitHn0o/LFtu2/I5P/MFLfzOEfmO/oH8TvqHphqHmXeYL1qjVazMwlA=
X-Received: by 2002:a05:690e:4287:10b0:633:b6b5:ef2c with SMTP id
 956f58d0204a3-633b6b5f5bbmr4133202d50.27.1758208340325; Thu, 18 Sep 2025
 08:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com> <20250902-pm-v3-2-ffadbb454cdc@nxp.com>
In-Reply-To: <20250902-pm-v3-2-ffadbb454cdc@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 18 Sep 2025 17:11:44 +0200
X-Gm-Features: AS18NWAvbbmow72oBLB0fop6cXMFfTOtiltZJomLBqlvFFcV_ry6i4BBGlzd4Ow
Message-ID: <CAPDyKFqyLV7UF0E4WxYQrqv3HNuSZCet=F62Lvt7nBYJMOZQeg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] usb: chipidea: core: detach power domain for
 ci_hdrc platform device
To: Peng Fan <peng.fan@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Chen <peter.chen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, imx@lists.linux.dev, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 05:33, Peng Fan <peng.fan@nxp.com> wrote:
>
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
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Seems reasonable to me!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

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
>         if (ret)
>                 goto err;
>
> +       dev_pm_domain_detach(&pdev->dev, false);
> +
>         return pdev;
>
>  err:
>
> --
> 2.37.1
>

