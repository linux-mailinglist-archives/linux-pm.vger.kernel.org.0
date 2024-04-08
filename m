Return-Path: <linux-pm+bounces-6042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE19C89B889
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 09:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D37F1F21DDC
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A362BB16;
	Mon,  8 Apr 2024 07:36:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88782B9D4;
	Mon,  8 Apr 2024 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561771; cv=none; b=fQegQGp1oiofGsTU3Q+qiKTR0aZqPbRzP7+cZOr8FXKGzD/9GECy9eG9gxnzer5RjcHg2gLYwqpwkEzy1VtxvMx+teVNplTcUKnma2ELOdQ9/hu7125EBcAX7Q5oFmquV1Y8/hY3JlVu2u90SXU0y/PbbvBGjKVoB/8OziXHSvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561771; c=relaxed/simple;
	bh=MYVEQ4Bnra1nXlCfh4cdc1ky1mz9ACZ0YBff5gnAeHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shaoHMKw0tZcZ+nixAlmTFr4HvVloLdJPzuTlBnIT8CY2XswDzNKgu8Y8qDjJf3AoE7d+44y9HKqe1AqBB3hdQCYmYkCx9/NSdVsXUuRhA1I0rNiKEiXyb3SANXIjU3l1BChdSKC4wqZzMK/8IcDUZu6v5pneBo1KvMIgkRbS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CAFC433C7;
	Mon,  8 Apr 2024 07:36:08 +0000 (UTC)
Message-ID: <0ee2d906-8ba3-4c3a-b731-4ed2f5d9fecc@xs4all.nl>
Date: Mon, 8 Apr 2024 09:36:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] media: platform: cros-ec: provide ID table for
 avoiding fallback match
Content-Language: en-US, nl
To: Tzung-Bi Shih <tzungbi@kernel.org>, bleung@chromium.org,
 groeck@chromium.org, linus.walleij@linaro.org, brgl@bgdev.pl,
 mchehab@kernel.org, sre@kernel.org
Cc: chrome-platform@lists.linux.dev, pmalani@chromium.org,
 linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, krzk@kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240401030052.2887845-1-tzungbi@kernel.org>
 <20240401030052.2887845-2-tzungbi@kernel.org>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240401030052.2887845-2-tzungbi@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/04/2024 05:00, Tzung-Bi Shih wrote:
> Instead of using fallback driver name match, provide ID table[1] for the
> primary match.
> 
> [1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c#L1353
> 
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Looks OK, I'll queue this patch up for v6.10.

Regards,

	Hans

> ---
> Changes from v1:
> - No code changes.
> - Add R-b tags.
> 
>  drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> index 48ed2993d2f0..8fbbb4091455 100644
> --- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> +++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/dmi.h>
>  #include <linux/pci.h>
> @@ -573,6 +574,12 @@ static void cros_ec_cec_remove(struct platform_device *pdev)
>  	}
>  }
>  
> +static const struct platform_device_id cros_ec_cec_id[] = {
> +	{ DRV_NAME, 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, cros_ec_cec_id);
> +
>  static struct platform_driver cros_ec_cec_driver = {
>  	.probe = cros_ec_cec_probe,
>  	.remove_new = cros_ec_cec_remove,
> @@ -580,6 +587,7 @@ static struct platform_driver cros_ec_cec_driver = {
>  		.name = DRV_NAME,
>  		.pm = &cros_ec_cec_pm_ops,
>  	},
> +	.id_table = cros_ec_cec_id,
>  };
>  
>  module_platform_driver(cros_ec_cec_driver);
> @@ -587,4 +595,3 @@ module_platform_driver(cros_ec_cec_driver);
>  MODULE_DESCRIPTION("CEC driver for ChromeOS ECs");
>  MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:" DRV_NAME);


